#GCC-194 - ARQUITETURA DE COMPUTADORES - 2019/01
#CALCULADORA PÓSFIXA USANDO NOTACAO POLONESA INVERSA OU RPN (Reverse Polish Notation)

#EXEMPLO DE NOTACAO: 10 10 + 2 * 4 /
#	     10 10 + = 20
#	     2 * = 20*2 = 40
#	     4 / = 40/4 = 10
#RESULTANDO EM 10

 
#COPYRIGHT BY WESLEY DE JESUS SANTOS

#OBS: PARA IMPRIMIR OS RESULTADOS ETAPA POR ETAPA, RETIRE TODAS OS "#" NO INICIO DOS COMANDOS

#TABELA ASCII
#Número 43 equivale ao +
#Número 45 equivale ao -
#Número 42 equivale ao *
#Número 47 equivale ao /
#Número 36 equivale ao $
#Número 38 equivale ao &
							
	.data

#$soma: .asciiz  "soma: \n" #declara variavel soma como 'soma: \n'
#$subtracao: .asciiz "\nsubtracao: \n" #declara variavel subtracao como 'subtracao: \n'
#$multiplicacao: .asciiz "\nmultiplicacao: \n" #declara variavel multiplicacao como 'multiplicacao: \n'
#$divisao: .asciiz "\ndivisao: \n" #declara variavel divisao como 'divisao: \n'

$message1: .asciiz "\nInsira o primeiro valor:\n"
$message2: .asciiz "\nInsira o segundo valor:\n"
$message3: .asciiz "\nEscolha a operação:\n+ para somar \n- para subtrair\n* para multiplicar\n/ para dividir\n"
$message4: .asciiz "\nInsira o proximo valor:\n"
#message5: .asciiz "\nO valor atual é:\n"
$message6: .asciiz "\nPara continuar a operacao digite $ \nPara encerrar a operacao digite & \n"
$final: .asciiz "\nO resultado final é igual a: "
	
	.text
main:

	#li $t0,43 #leva o simbolo de adicao para t0
	#li $t1,45 #leva o simbolo de subtracao para t1
	#li $t2,42 #leva o simbolo de multiplicacao para t2
	#li $t3,47 #leva o simbolo de divisao para t3
	
	
	li $v0,4 #comando de impressão de string na tela
	la $a0, $message1 #coloca o texto soma para ser impresso
	syscall # efetua a chamada ao sistema
	
	li $v0,5 #le entrada do usuário para o primeiro numero
	syscall #faz chamada ao sistema
	
	move $s0, $v0 # move conteúdo de $v0 para $s0 (primeiro numero para $s0)
	
	li $v0,4 #comando de impressão de string na tela
	la $a0, $message2 #coloca o texto soma para ser impresso
	syscall # efetua a chamada ao sistema
	
	li $v0,5 #le entrada do usuário para o segundo numero
	syscall # efetua a chamada ao sistema
	
	move $s1, $v0 # move conteúdo de $v0 para $s1 (segundo numero para $s1)
	
#Comeca a selecionar a operacao

	li $v0,4 #comando de impressão de string na tela
	la $a0, $message3 #coloca o texto de operacao para ser impresso
	syscall # efetua a chamada ao sistema
	
	li $v0,12 #le entrada do usuário para o simbolo desejado
	syscall # efetua a chamada ao sistema
	
	move $s2, $v0 # move conteúdo de $v1 para $s2 (simbolo para $s2)	
	
	beq $s2,43,somaOp #verifica se $s2 é igual a 1 se for desvia para somaOP
	beq $s2,45,subtracaoOp #verifica se $s2 é igual a 2 se for desvia para subtracaoOP
	beq $s2,42,multiplicacaoOp #verifica se $s2 é igual a 3 se for desvia para multiplicacaoOP
	beq $s2,47,divisaoOp #verifica se $s2 é igual a 4 se for desvia para divisaoOP
	j termina #desvia para termina
	
somaOp:
	#li $v0,4 #comando de impressão de string na tela
	#la $a0, $message5 #coloca o texto de operacao para ser impresso
	#syscall # efetua a chamada ao sistema
	
	add $s2, $s0, $s1 #soma os valores dos registradores $s0 e $s1 e insere o resultado no registrador $s2
	#j imprimirTotal #desvia para nova operacao
	j continuar #desvia para opcao de continuar
	
subtracaoOp:
	#li $v0,4 #comando de impressão de string na tela
	#la $a0, $message5 #coloca o texto de operacao para ser impresso
	#syscall # efetua a chamada ao sistema

	sub $s2, $s0, $s1 #subtrai os valores dos registradores $s0 e $s1 e insere o resultado no registrador $s2
	#j imprimirTotal #desvia para termina
	j continuar #desvia para opcao de continuar
	
multiplicacaoOp:
	#li $v0,4 #comando de impressão de inteiro na tela
	#la $a0, $message5 #coloca o texto de operacao para ser impresso
	#syscall # efetua a chamada ao sistema

	mul $s2, $s0, $s1 #multiplica os valores dos registradores $s0 e $s1 e insere o resultado no registrador $s2
	#j imprimirTotal #desvia para termina
	j continuar #desvia para opcao de continuar
	
divisaoOp:
	#li $v0,4 #comando de impressão de string na tela
	#la $a0, $message5 #coloca o texto de operacao para ser impresso
	#syscall # efetua a chamada ao sistema

	div $s2, $s0, $s1 #divide os valores dos registradores $s0 e $s1 e insere o resultado no registrador $s2
	#j imprimirTotal #desvia para termina
	j continuar #desvia para opcao de continuar
	
	
#imprimirTotal:
	#li $v0,1 #comando de impressão de inteiro na tela
	#la $a0, ($s2) #coloca o registrador $s2 para ser impresso
	#syscall # efetua a chamada ao sistema
	
	#j continuar #desvia para continuar
	
continuar:
	li $v0, 4 #comando para impressão de string na tela
	la $a0, $message6 #coloca o texto de continue para ser impresso
	syscall
	
	li $v0, 12 #comando para ler caracter
	syscall
	
	beq $v0,36,selecionaNum
	beq $v0,38,imprimirFinal
	
selecionaNum:			
	li $v0,4 #comando de impressão de string na tela
	la $a0, $message4 #coloca o texto de proxima operacao para ser impresso
	syscall # efetua a chamada ao sistema
	
	li $v0,5 #le o proximo numero
	syscall
	
	move $s5, $v0
	
selecionaOp:
	li $v0,4 #comando de impressão de string na tela
	la $a0, $message3 #coloca o texto de operacao para ser impresso
	syscall # efetua a chamada ao sistema
	
	li $v0,12 #le entrada do usuário para o simbolo desejado
	syscall # efetua a chamada ao sistema
	
	move $s4, $v0 # move conteúdo de $v0 para $s4 (simbolo para $s4)
		
	beq $s4,43,soma_Op
	beq $s4,45,subtracao_Op
	beq $s4,42,multiplicacao_Op
	beq $s4,47,divisao_Op
	j termina
	
soma_Op:
	#li $v0,4 #comando de impressão de string na tela
	#la $a0, $message5 #coloca o texto de operacao para ser impresso
	#syscall # efetua a chamada ao sistema
	
	add $s2, $s2, $s5 #soma os valores dos registradores $s0 e $s1 e insere o resultado no registrador $s2
	#j imprimirTotal
	j continuar #desvia para opcao de continuar

subtracao_Op:
	#li $v0,4 #comando de impressão de string na tela
	#la $a0, $message5 #coloca o texto de operacao para ser impresso
	#syscall # efetua a chamada ao sistema
	
	sub $s2, $s2, $s5 #soma os valores dos registradores $s0 e $s1 e insere o resultado no registrador $s2
	#j imprimirTotal
	j continuar #desvia para opcao de continuar
	
multiplicacao_Op:
	#li $v0,4 #comando de impressão de string na tela
	#la $a0, $message5 #coloca o texto de operacao para ser impresso
	#syscall # efetua a chamada ao sistema
	
	mul $s2, $s2, $s5 #soma os valores dos registradores $s0 e $s1 e insere o resultado no registrador $s2
	#j imprimirTotal
	j continuar #desvia para opcao de continuar
	
divisao_Op:	
	#li $v0,4 #comando de impressão de string na tela
	#la $a0, $message5 #coloca o texto de operacao para ser impresso
	#syscall # efetua a chamada ao sistema
	
	div $s2, $s2, $s5 #soma os valores dos registradores $s0 e $s1 e insere o resultado no registrador $s2
	#j imprimirTotal
	j continuar #desvia para opcao de continuar
	
imprimirFinal:
	li $v0,4 #comando de impressão de string na tela
	la $a0,$final
	syscall
	
	li $v0,1 #comando de impressão de inteiro na tela
	la $a0, ($s2) #coloca o registrador $s2 para ser impresso
	syscall # efetua a chamada ao sistema
	
	j termina #desvia para selecao do proximo numero
		
termina:
	li $v0, 10 # comando de exit
	syscall # efetua a chamada ao sistema
