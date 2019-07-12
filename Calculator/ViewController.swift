//
//  ViewController.swift
//  Calculator
//
//  Created by Wafiq Syed on 2019-07-11.
//  Copyright © 2019 Wafiq Syed. All rights reserved.
/*
 ~ App Plan ~
 -------------
 
 - Tap numbers, and see them at the top.
 - Tap an operation
 - Tap buttons for more numbers
 - Tap = for result
 - Tap C to Clear
 
 ~ Key Instance Variables (Properties)
 currentNumber: int (used to hold the numeric values entered)
 operation: Modes - Enum (holds the operation)
 lastButtonIsOp: Boolean (true if operation button was last was pressed)
 result: String
 resultLabel: UILabl
 
 ~ Key Methods (Functions)
 clearTapped - resets calculator
 numberTapped - user taps number button (0-9) and number
 is put into label
 plusTapped - plus button calls changeOp
 minusTapped - minus button calls changeOp
 multiplyTapped - multiply button calls changeOp
 equalsTapped - displays result in label
 changeOp - changes operation
 updateLabel - updates resultLabel
 
*/

import UIKit

// Let's declare an enumerated type here for our math operations

enum operation {
    case add
    case subtract
    case multiply
    case noOperation
}

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    // Connect the user interface variables here
    
    var lastNumber: Int = 0
    var operation: operation = .noOperation
    var lastButtonIsOp: Bool = false
    var labelString: String = "0"
    
    
    func updateLabel() {
        guard let resultInt: Int = Int(labelString) else{
            resultLabel.text = "ERROR"
            return
        }
        
        if operation == .noOperation {
            lastNumber = resultInt
        }
        
        resultLabel.text = "\(resultInt)"
    }
    
    func changeOp(newOp: operation){
        if lastNumber == 0{
            return
        }
        
        operation = newOp
        lastButtonIsOp = true
    }
    
    @IBAction func plusTapped(_ sender: Any){
        changeOp(newOp: .add)
    }
    
    @IBAction func minusTapped(_ sender: Any){
        changeOp(newOp: .subtract)
    }
    
    @IBAction func multiplyTapped(_ sender: Any){
        changeOp(newOp: .multiply)
    }
    
    @IBAction func equalsTapped(_ sender: Any){
        guard let resultInt: Int = Int(labelString) else{
            resultLabel.text = "ERROR"
            return
        }
        
        if operation == .noOperation || lastButtonIsOp {
            return
        }else if operation == .add{
            lastNumber += resultInt
        }else if operation == .subtract{
            lastNumber -= resultInt
        }else{
            lastNumber *= resultInt
        }
        
        operation = .noOperation
        labelString = "\(lastNumber)"
        updateLabel()
        lastButtonIsOp = true
        
    }
    
    @IBAction func clearTapped(_ sender: Any){
        operation = .noOperation
        lastButtonIsOp = false
        labelString = "0"
        lastNumber = 0
        resultLabel.text = "0"
    }
    
    @IBAction func numberTapped(_ sender: UIButton){
        // We need to accept the number tapped
        // Have to guard it in case the button doesn't have anything
        
        guard let stringValue: String = sender.titleLabel?.text else{
            resultLabel.text = "ERROR"
            return
        }
        
        if lastButtonIsOp {
            labelString = "0"
            lastButtonIsOp = false
        }
        labelString = labelString.appending(stringValue)
        updateLabel()
    }
    
    
}

