Return-Path: <linux-kernel+bounces-532231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80341A44A63
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 19:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8E351776CB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A34119FA93;
	Tue, 25 Feb 2025 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acBmjohJ"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B239518C035;
	Tue, 25 Feb 2025 18:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740508263; cv=none; b=m1wD40l+8cqaaJ1WSxRaPd91fLVJIRFLzaa9x/NaZehtu99szIDaJWn0WqX3gnG2UYuI4G7TsKLaONTMWDpDjoeJkRObUw6hmB0mi2udVrA3oNntaMSI+WxYIIiNdNcFtuPCMIZcdvh5AVMTpEXQcVMl0oU2jb8FEMqaQr5223I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740508263; c=relaxed/simple;
	bh=nmjNE2/5IDHBVbgl4kdcWs687grdd6MfsW3lMGDz4lU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nrDbYH2xCTIuGfjMHJNrKmsno1LvZM6HOaTg6B5jhXQ5JNzI+YHNWHU32xPGhgcNA6db8l8zmZ9JcYIQJCMyFX6em7tJ4B+Z4QIOAL0EeZrVXE4B8VM+fXIgdUOV5JDb+ZKekXnajv8ysvqtyrHRopUKM82ez9rRbA+ypGU9PSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acBmjohJ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fc6272259cso9660928a91.0;
        Tue, 25 Feb 2025 10:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740508261; x=1741113061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=clbxucH2qa/HYexBlCEIH5MMYzU5Q2jGNyXDV7K5VTM=;
        b=acBmjohJf8VsvngejxoLazEayJoK9UpleysTZ1/qTWpQvDz5DHE0ZYdChAJp6W6YjT
         ymOm4wcWa4yzT1HL62TVvRw3R980Q5y/3rYdY+d4aRHsnQgPUhTZQtGvqa3GKsBLIOca
         V/1dAD9Ucz3GWLNOjomSEGSNa8gfcL3AIUgQ+6MFPnpydFM+6pBLfDwjQ8qRztSqpil3
         iZyHaAFuj/X8onExGUhCXAuxViaY0Q9nfUAlZzX64bn432dKk8Q/bU4u0ilVX504auHc
         iPHhpj7ibkPHTv93ece/4YSONWj9hCKhoJ+G/ON9+yyeFQouyDb3Lhtzs2khhO3R4i8+
         2cmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740508261; x=1741113061;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=clbxucH2qa/HYexBlCEIH5MMYzU5Q2jGNyXDV7K5VTM=;
        b=CjA45YavYJxxdK6GNxPKIW78WOpvrSKt3mH7pC4jrM+TzxZN9B1ILafZlJNl9tbtTi
         Yv8QkW90LSPgVbHQMHLYMiTJSws9s6BIzjbt6GX1VzQ6tyuGNOrwlJsCBi8wl/sX71nb
         gDlt8I/hXpY4nF1BmrUOvCXKs2u8UVoTOWuscgCFW0mBAQrLKstJExVibJHeA2FiIqJD
         KwLT4F4/obopDGK6+iYyUF/bOcPV2SRwZp78VSvBXv14+MsiUic8j+nmFn/odBOFrAqa
         aVEJjXwfXl3EtpW/EA2EcF1ZDZ86c2zINAWBeShvkrsnvFEAOczznrYST2r4R6qHZdZ0
         L72g==
X-Forwarded-Encrypted: i=1; AJvYcCVBM+FT7iSUZcawqUrKIjncOzAdSsXT/8nXCknO9arHXhkgUfMdX7oIH0MkxID+CBklLbEfBC8kIApl@vger.kernel.org, AJvYcCVTJRxxQpYHiHtfHDPg95acgRep9KFQSxOUBZdCz7tbklQuYRqfCO0hOJPOmHvESY1tTaxWztHX5rzDfVdH@vger.kernel.org
X-Gm-Message-State: AOJu0YzjBJbM+FCs/28HkfE55pAW9YPCc27gLgDdq0WRluvpCs7gK/8Y
	ATXlSsNt1NqGh3L/sbQhM3jOgNjs+gR6TK3afmGaTJdrSUoF1IMY
X-Gm-Gg: ASbGncvJ5jWlmiEC6+uNbqZc21qff0oYZgjFnIDELZ2eu1QrmVEsxKUXCQpkW7zJlPl
	HYOhYvRj3yKAaMOxzyAWOPuAhkx7VbFBnSwpB0bB8Zx7FX876g7p71uyVrUkBWrVCNEF8vfdbTY
	pIAqbNUDinsiiw2XMPGorM2kp8RY+uouV5YXhmFRee/hgn8x73r6CrLYgFkiVEJRaz3juLlyHgN
	Opes8LUSjUvGH2XcakK3guGyYdJvwqQM1DZ6U+Ue4xznU83fX5za9OgDBkdsVP1xC6Y3KBnzGFL
	iuXz4vNcv7r+/qIJ8rZA9gBIAxkf+ELvBxmGeI3djEKE3P6F6V/1OUaPfB/qGR25V+00YVKito0
	=
X-Google-Smtp-Source: AGHT+IHs98MecKlAIN7pAThXOrkUh7E3AIRt/vYcixB4+zqZvpAdTtK8So0vPkRa7+Wpv2+CNmw02w==
X-Received: by 2002:a17:90b:538f:b0:2f6:d266:f467 with SMTP id 98e67ed59e1d1-2fe68d061d4mr5465187a91.34.1740508260846;
        Tue, 25 Feb 2025 10:31:00 -0800 (PST)
Received: from ?IPV6:2804:14d:887:95a9:e1a5:e9d5:ba9a:df82? ([2804:14d:887:95a9:e1a5:e9d5:ba9a:df82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe6cf86486sm1952600a91.0.2025.02.25.10.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 10:31:00 -0800 (PST)
Message-ID: <c3407b84-7698-4102-b600-c1a6701fe67f@gmail.com>
Date: Tue, 25 Feb 2025 15:30:55 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: interrupt-controller: Convert
 nxp,lpc3220-mic.txt to yaml format
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: tglx@linutronix.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, vz@mleia.com,
 Leonardo Felipe Takao Hirata <leofthirata@gmail.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org
References: <20250224210432.94851-1-leofthirata@gmail.com>
 <20250225-lean-bronze-millipede-03edd9@krzk-bin>
Content-Language: en-US
From: Leonardo Felipe Takao Hirata <leo.fthirata@gmail.com>
In-Reply-To: <20250225-lean-bronze-millipede-03edd9@krzk-bin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Krzysztof,

On 25/02/2025 9:06 AM, Krzysztof Kozlowski wrote:
> On Mon, Feb 24, 2025 at 06:04:30PM -0300, Leonardo Felipe Takao Hirata wrote:
>> Convert NXP LPC3220-MIC to DT schema.
>>
>> Signed-off-by: Leonardo Felipe Takao Hirata <leofthirata@gmail.com>
> SoB mismatch.
>
> Run checkpatch.
>
>> ---
>>   .../interrupt-controller/nxp,lpc3220-mic.txt  | 58 -------------
>>   .../interrupt-controller/nxp,lpc3220-mic.yaml | 86 +++++++++++++++++++
>>   2 files changed, 86 insertions(+), 58 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.txt
>>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/nxp,lpc3220-mic.yaml
> ...
>
>> +title: NXP LPC32xx MIC, SIC1 and SIC2 Interrupt Controllers
>> +
>> +maintainers:
>> +  - Vladimir Zapolskiy <vz@mleia.com>
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - nxp,lpc3220-mic
>> +      - nxp,lpc3220-sic
>> +
>> +  reg:
>> +    description:
>> +      Should contain IC registers location and length.
> Drop description
>
>> +    maxItems: 1
>> +
>> +  interrupt-controller: true
>> +
>> +  '#interrupt-cells':
>> +    const: 2
>> +    description:
>> +      The number of cells to define an interrupt, should be 2.
> Don't repeat constraints in free form text. Drop.
>
>> +      The first cell is the IRQ number, the second cell is used to specify
>> +      one of the supported IRQ types.
>> +          IRQ_TYPE_EDGE_RISING = low-to-high edge triggered,
>> +          IRQ_TYPE_EDGE_FALLING = high-to-low edge triggered,
>> +          IRQ_TYPE_LEVEL_HIGH = active high level-sensitive,
>> +          IRQ_TYPE_LEVEL_LOW = active low level-sensitive.
>> +      Reset value is IRQ_TYPE_LEVEL_LOW.
>> +
>> +  interrupts:
> Need to list and describe the items.
>
>> +    description:
>> +      Empty for MIC interrupt controller, cascaded MIC hardware interrupts for
>> +      SIC1 and SIC2
> And then allOf:if:then restricting it per variant (interrupts: false).
>
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupt-controller
>> +  - '#interrupt-cells'
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +    mic: interrupt-controller@40008000 {
>> +      compatible = "nxp,lpc3220-mic";
>> +      reg = <0x40008000 0x4000>;
>> +      interrupt-controller;
>> +      #interrupt-cells = <2>;
>> +    };
>> +
>> +    sic1: interrupt-controller@4000c000 {
>> +      compatible = "nxp,lpc3220-sic";
>> +      reg = <0x4000c000 0x4000>;
>> +      interrupt-controller;
>> +      #interrupt-cells = <2>;
>> +      interrupt-parent = <&mic>;
>> +      interrupts = <0 IRQ_TYPE_LEVEL_LOW>,
>> +                  <30 IRQ_TYPE_LEVEL_LOW>;
>> +    };
>> +
>> +    sic2: interrupt-controller@40010000 {
> Drop, two examples are enough.
>
>> +      compatible = "nxp,lpc3220-sic";
>> +      reg = <0x40010000 0x4000>;
>> +      interrupt-controller;
>> +      #interrupt-cells = <2>;
>> +      interrupt-parent = <&mic>;
>> +      interrupts = <1 IRQ_TYPE_LEVEL_LOW>,
>> +                  <31 IRQ_TYPE_LEVEL_LOW>;
>> +    };
>> +
>> +    adc@40048000 {
>> +      compatible = "nxp,lpc3220-adc";
> Drop, not relevant.
>
> Best regards,
> Krzysztof
>
Thanks for the feedback. The fixes will be in v2.

Best regards,
Leonardo Hirata


