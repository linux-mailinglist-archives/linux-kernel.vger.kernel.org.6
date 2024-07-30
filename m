Return-Path: <linux-kernel+bounces-266980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7C7940AAD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 10:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D93F1C22D6A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 08:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE4B187856;
	Tue, 30 Jul 2024 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MO2jGGnK"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6A8D2E5;
	Tue, 30 Jul 2024 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722326621; cv=none; b=rMaywGLQEvx5O9OTWXpAR7tUhDRiAE+oL5zx3g+FMpkOh89um/ZoUNSe86zf74i8ooTmINS1rPoVr5EAjci8vPNrx9ZKUEmMYEJw6ucIN6FTkJYpwM89un45naZ5kamdHGdRRtioreePtsuePp2yHacyfKn8cHfNcw78Yz5d1OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722326621; c=relaxed/simple;
	bh=zrOPpP7n6wpVbT0LbTrIPNP60QQatw1aJrnNVWHz73c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jGmzhA7u7ppidHlnRnjnP+iklS5vBO53XzuNgCLjb9VQGjVyJjco9btgVvD8MeMqJci8nEzhXdjKFxLq/usO1r4U1Ps13ev1SNle/PadP4KVL58r6LgMiFlA9Bpdoh6q3Fb25En2NZyeAUTDFi3eRyLGE3rxHJtdoI41C4aUH7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MO2jGGnK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1fed72d23a7so27850735ad.1;
        Tue, 30 Jul 2024 01:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722326619; x=1722931419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9OVNGQMe/C64240V64c1zunaFPC+HkZVviRBxRM9hd0=;
        b=MO2jGGnK4YXSNabs1kpyAhN2qg0nrcdUO2mTb5JaRLwvKUyCYUWZYIZxyeArwonika
         ePsjzPfAPcBDGE4ie1CF58hGtSQnLq9L/d/9jNEa65Nn2ssdjEfqxSUS1o1XXOAIzZDh
         lxSKZnFfJOHIGpMCooWZKPXhQu3aNjZY+GmpjtB3ZhjZrinQ6jonlJ8NHrpzlEATabPC
         0dptM0c09S1iAy54UdjCZgNZXZR/PLuWQtook0py8dBfdFCNQWbSiexeT+U+ls6PPK1O
         SX+Al9FX0WykaTx/ocVU4XGApMSET8tw3JAR5/TxI4Xo8QJ0NMYFw47YUTvwWyQP++J1
         itEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722326619; x=1722931419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9OVNGQMe/C64240V64c1zunaFPC+HkZVviRBxRM9hd0=;
        b=LEke934TUimMYYC7LawyFjUrOcF1YINhYb7/ww1DSOb02w1lPbGvc30+XC/3egrDol
         ZL36BgMVH5Ll4uowKZEF0PdDxJ3NWxAzWTDfLa6vZxT69x679sfgkdEJUBikWLPNZleB
         HaFZuomLwFysVqWklaSg/QVg1XgZvA8w6Du0v2jGVVCjPulcjrtXzC6gvXAaJTwq0O2O
         eEL1rDKUcbicVmk/rOjtT3AGnUN6TJgcuXQtIoMxDXf6FM5V2QPzi2WZQ8O2UF7KYz/A
         UaILOOli+b630w1l32i0EoWvSoNZw5HCQajcpGQGk3/8lJXNrzV/Qk64rlxwtxj9ic59
         CCEg==
X-Forwarded-Encrypted: i=1; AJvYcCVNE1CXd5hoA4+dUaRpvvvaQgSVON5aNzY+CNe1fEuTA2P9we8ArRIo9Z16bia1bIn/RhHvNEb6mwte6rUbZaJqbnwU2jki3lRUKJfxZSPNmNf77Y0O/jl8UvY1k6BZCqOBUtnOVH7sOw==
X-Gm-Message-State: AOJu0YxUSqkRUTZMCFg+0FjAb6IRG0vklV/JNZ/VFrKv5b1IwGuvBhCc
	uLhrCuidA8gc/cTES0x/cyoDLdk8KwUAzvy/Hv/ZVHpCmOnOqRE3
X-Google-Smtp-Source: AGHT+IHzrH25cPutln0r6hKGEy+zOvRDkcSSoWRSjTAN0Fvh/KG4hSP/q7SqXRvaVQfALvD8yJBdcQ==
X-Received: by 2002:a17:902:d4cd:b0:1fb:68a2:a948 with SMTP id d9443c01a7336-1ff04809ab3mr67129815ad.15.1722326618767;
        Tue, 30 Jul 2024 01:03:38 -0700 (PDT)
Received: from [172.19.1.53] (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7ff067esm95122855ad.295.2024.07.30.01.03.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 01:03:38 -0700 (PDT)
Message-ID: <85a4b5c2-89f1-40d1-baec-b17479f5cae2@gmail.com>
Date: Tue, 30 Jul 2024 16:03:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: phy: nuvoton,ma35-usb2-phy: add new
 bindings
To: Krzysztof Kozlowski <krzk@kernel.org>, vkoul@kernel.org,
 kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240729061509.83828-1-hpchen0nvt@gmail.com>
 <20240729061509.83828-2-hpchen0nvt@gmail.com>
 <c4c2b30a-8ff9-4fc4-a1ed-adcd366d15a7@kernel.org>
Content-Language: en-US
From: Hui-Ping Chen <hpchen0nvt@gmail.com>
In-Reply-To: <c4c2b30a-8ff9-4fc4-a1ed-adcd366d15a7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Krzysztof,

Thank you for your reply.



On 2024/7/29 下午 03:29, Krzysztof Kozlowski wrote:
> On 29/07/2024 08:15, hpchen0 wrote:
>> Add dt-bindings for USB2 PHY found on the Nuvoton MA35 SoC.
>>
>> Signed-off-by: hpchen0 <hpchen0nvt@gmail.com>
> Please use proper name.

Okay, I will make the correction and use the correct name.



>> ---
>>   .../bindings/phy/nuvoton,ma35-usb2-phy.yaml   | 51 +++++++++++++++++++
>>   1 file changed, 51 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/phy/nuvoton,ma35-usb2-phy.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/phy/nuvoton,ma35-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/nuvoton,ma35-usb2-phy.yaml
>> new file mode 100644
>> index 000000000000..415ea2c45975
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/phy/nuvoton,ma35-usb2-phy.yaml
>> @@ -0,0 +1,51 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/phy/nuvoton,ma35-usb2-phy.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Nuvoton MA35 USB2 phy
>> +
>> +maintainers:
>> +  - hpchen0 <hpchen0nvt@gmail.com>
> Same here

Okay, I will make the correction and use the correct name.



>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - nuvoton,ma35-usb2-phy
> All other devices have name ma35d1. Is this a different SoC?

The SoC is the same as ma35d1. I will modify ma35 to ma35d1.

Originally, I intended to create a series of shared drivers.



>> +
>> +  "#phy-cells":
>> +    const: 0
>> +
>> +  clocks:
>> +    maxItems: 1
>> +    description: USB PHY clock
> Drop description, it's obvious.

Okay, I will remove the description.



>> +
>> +  clock-names:
>> +    const: usbd_gate
> Drop clock-names, you do not bring any new information.

Okay, I will remove the clock-names.



>> +
>> +  nuvoton,sys:
>> +    $ref: /schemas/types.yaml#/definitions/phandle
>> +    description:
>> +      phandle of the system-management node.
> Describe what is it for.

Because this driver has some status bits located in the sys, it is 
necessary to reference the sys link.



>> +
>> +required:
>> +  - compatible
>> +  - clocks
>> +  - nuvoton,sys
>> +  - "#phy-cells"
> Keep the same order as in properties.

Okay, I will correct this issue.



>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> Where do you use it?

This is not used and will be removed. Thanks for the reminder.



>> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>> +
>> +    usb_phy: usb-phy {
>> +        compatible = "nuvoton,ma35-usb2-phy";
>> +        clocks = <&clk USBD_GATE>;
>> +        clock-names = "usbd_gate";
>> +        nuvoton,sys = <&sys>;
>> +        #phy-cells = <0>;
>> +    };
> Best regards,
> Krzysztof


Best regards,

Hui-Ping Chen




