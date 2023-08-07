import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  //variables
  double firstNum = 0.0;
  double secondNum = 0.0;
  var input = '';
  var output = '';
  var operation = '';
  bool hideInput = false; 
  var outputSize = 34.0;

  //functionality of buttons
  onButtonClick(value){
    //if value is AC 

    if(value=='AC'){
      input = '';
      output = '';
    }
    else if (value=='←'){
      if(input.isNotEmpty){
        input = input.substring(0,input.length-1);
      }
    }
    else if (value=='='){
      if(input.isNotEmpty){
        var userInput = input;
        userInput = input.replaceAll('×', '*');
        userInput = input.replaceAll('÷', '/');
        Parser p = Parser();
        Expression e = p.parse(userInput);
        ContextModel cm = ContextModel();

        var finalValue = e.evaluate(EvaluationType.REAL, cm);

        output = finalValue.toString();
        
        if(output.endsWith('.0')){
          output = output.substring(0,output.length-2);
        }

        input = output;
        hideInput = true;
        outputSize = 52;
      }
    } 
    else{
      input = input + value; 
      hideInput = false;
      outputSize = 34;
    }

    setState(() {});

    
  }

  //creating buttons
  Widget button({
    text, tColor = Colors.white, bColor = const Color(0xff191919)
  }){
    return Expanded(
                child: Container(
                  margin: const EdgeInsets.all(8),
                  child: ElevatedButton(
                    onPressed: () => onButtonClick(text), 
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.all(22),
                      backgroundColor: bColor,
                    ),
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 18,
                        color: tColor,
                        fontWeight: FontWeight.bold,
                      ),
                      )
                  )
                ),
              );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.black,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 35, 35, 35),
        title: const Text(
          'Calculator',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
          ),
        ),
      ),
      body: Column(
        children: [
          //display area
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hideInput?'':input,
                    style: const TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Text(
                    output,
                    style: TextStyle(
                      fontSize: outputSize,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 30,),

                ],
              ),
            )
          ),
          //buttons area 
          Row(
            children: [
              button(text: 'AC',tColor: const Color(0xffD9802E), bColor: const Color(0xff272727)),
              button(text: '←',tColor: const Color(0xffD9802E), bColor: const Color(0xff272727)),
              button(text: '', bColor: Colors.transparent),
              button(text: '÷',bColor: const Color(0xff272727)),
            ],
          ),
          Row(
            children: [
              button(text: '7'),
              button(text: '8'),
              button(text: '9'),
              button(text: '×',bColor: const Color(0xff272727)),
            ],
          ),
          Row(
            children: [
              button(text: '4'),
              button(text: '5'),
              button(text: '6'),
              button(text: '-',bColor: const Color(0xff272727)),
            ],
          ),
          Row(
            children: [
              button(text: '1'),
              button(text: '2'),
              button(text: '3'),
              button(text: '+',bColor: const Color(0xff272727)),
            ],
          ),
          Row(
            children: [
              button(text: '%',bColor: const Color(0xff272727)),
              button(text: '0'),
              button(text: '.',bColor: const Color(0xff272727)),
              button(text: '=',bColor: const Color(0xffD9802E)),
            ],
          ),
        ],
      ),
      
    );
  }

  
}