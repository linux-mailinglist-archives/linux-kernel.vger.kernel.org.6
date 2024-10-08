Return-Path: <linux-kernel+bounces-354423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F24EB993D4E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 05:05:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 563FDB231B7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 03:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF806433DF;
	Tue,  8 Oct 2024 03:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FECokY3g"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0D543172;
	Tue,  8 Oct 2024 03:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728356697; cv=none; b=U1Uxmk6Tdabfx7gkG0rce80gK7SEoCSbiIaZntbhmgA+qJ8XBf/v/mBUeQoZaxY/ODSbXfAWxwcN1m8oobMpdxtmNKtp325KunDDZN4UP5b3ESNLDz43sxml5FA0dU2Lt+wymBB+yGQibnVMn25zVkEv5walGBS9X5cMlHUqyPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728356697; c=relaxed/simple;
	bh=ji/WffbkV/I3k5OZJmCuBs+IP6/EXSUYAEFLCHoDmaA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iPNzVeyT0YaEQfBVGMGtEsxLvDxsm3j6NF6ac9FsXLX5lO69NKOTUKEHi91/icQch85ZtYUfD3S+h6DiQmQg6FINqNHT+p7OMPkgY+oK5MNfYwOI3+SZwAuS5axfdg/soR3LIDaUwiOpS3PjA0nnjhqkzK5RjTqyzk7OKzl2Y/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FECokY3g; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7ea0bc03a90so312265a12.2;
        Mon, 07 Oct 2024 20:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728356695; x=1728961495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0fEU5+LIRwpPcVtB5GFRw9EBx5GwZfZdi0DP3rpreiA=;
        b=FECokY3gmsLZ4b6LG7v5gIUeTz8QqH9nFqxOrvTHgT8FE9iLYKnwHMbAGuhOcccn9w
         xE8RVKr4SbiblkoRDJ1jhomS9YexiLLRqkyBtYGyZRxldv70yg+Q5Xuc4wkd2m8J9TzU
         1Njv/MmeMWenmP3Equ6Mt1jBM9RBnaDEAGQm2aUPUKIHp6vmyGItwoX+oWdbX66YUEjK
         gtWqOBhUrAJJ9KgPqFzElfkG8fdy9G/oGUWliC40cKIpJGD3YcsoLPeFiwfVYZwraBEN
         jG2iVlreo1i4p6dV5RIxopCwxTwPsy98RPmtP1cmeOSY72g0vM7exwQWObC8F08/hdRK
         cyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728356695; x=1728961495;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0fEU5+LIRwpPcVtB5GFRw9EBx5GwZfZdi0DP3rpreiA=;
        b=vT1Lax/BHzuatgVL82FAHhnNUGWEAIHP3RZsf/3BYNNjszgo/FgZvXKeKRyDONUsMK
         Daus8p/0I5hriRl+Dv+ps6SSRZTODMJVC2+FzhhIEHQUGgL7qTBBaFr6NosJfhyDEz3l
         S4U9Q2IdCnxV1iGJZCRUe021zBKeS+kblOSceqNoNxwK7PEaOYpmflgwfJeKYfDuGNWu
         WrQhnjkJodvFZa82PvmzDWZ8d41cL+rquxLknLch3d/m5NQiqngFBmGiDJ5vpAy/Juyd
         OoCy2gz3oz6HUjuVAjxnVK10ZICcPUOpMx+yaRzWLmh8QKauYixWMs5W2xgRvM8MVu+j
         d2dA==
X-Forwarded-Encrypted: i=1; AJvYcCUaGMarqN9twVibpZ9s0BlyJpqt+Uzaq7k1ozU8SLCeGjq65ASjWWNjLNChHTHk5UAvItB/pNC4Etbv@vger.kernel.org, AJvYcCV9/RP9ckCCOC+0+tzgAUXujj67fKDfslGM40nmfMV2AS34f1ivgerSiDCluZKwj0IaFvcPOC+zcsFlR0t9@vger.kernel.org
X-Gm-Message-State: AOJu0YzvJI9VMVsB6dHwuH2h+sllCxFeG+uXojYg4IFNg1RO88IcJu/c
	Ab+NAdZh0osIuTmSRbNtFUTdn3K89zTqjDg2H/dvEQEo7maCqVdOo7V2Las0
X-Google-Smtp-Source: AGHT+IF/mYdHKvquiAn/wFf8QmUeywFZG+J2GcInNX9jsPC4w+KCpYqQSUbZsOsVRTg8hvdAg5XvQg==
X-Received: by 2002:a17:902:eccf:b0:207:428d:ecc0 with SMTP id d9443c01a7336-20bfee35e78mr86055315ad.8.1728356694751;
        Mon, 07 Oct 2024 20:04:54 -0700 (PDT)
Received: from [192.168.60.56] ([103.29.142.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c138af9f7sm46708955ad.13.2024.10.07.20.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 20:04:54 -0700 (PDT)
Message-ID: <b3046637-7a35-49ef-a2b4-2f44355980a7@gmail.com>
Date: Tue, 8 Oct 2024 11:04:49 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] dt-bindings: phy: rockchip,inno-usb2phy: add
 rk3576
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, heiko@sntech.de, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 william.wu@rock-chips.com, tim.chen@rock-chips.com, frank.wang@rock-chips.com
References: <20240929061025.3704-1-frawang.cn@gmail.com>
 <20240929061025.3704-2-frawang.cn@gmail.com>
 <4czjtesext2ulsmcym2cpjavni7zuve2sdgyiqxkjkaxrl2gpf@7nqylzgd5f55>
Content-Language: en-US
From: Frank Wang <frawang.cn@gmail.com>
In-Reply-To: <4czjtesext2ulsmcym2cpjavni7zuve2sdgyiqxkjkaxrl2gpf@7nqylzgd5f55>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 2024/9/30 3:36, Krzysztof Kozlowski wrote:
> On Sun, Sep 29, 2024 at 02:10:24PM +0800, Frank Wang wrote:
>> From: Frank Wang <frank.wang@rock-chips.com>
>>
>> Add compatible for the USB2 phy in the Rockchip RK3576 SoC.
>>
>> This change also refactor the clocks list as there are new clocks
>> adding used for the USB MMU in RK3576 SoC.
>>
>> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
>> ---
>> Changelog:
>> v4:
>>   - refactor the clocks list used if:then:
>>
>> v3:
>>   - narrowed rk3576 clocks by compatible property.
>>
>> v2:
>>   - Categorize clock names by oneOf keyword.
>>
>> v1:
>>   - https://patchwork.kernel.org/project/linux-phy/patch/20240923025326.10467-1-frank.wang@rock-chips.com/
>>
>>   .../bindings/phy/rockchip,inno-usb2phy.yaml   | 46 ++++++++++++++++++-
>>   1 file changed, 44 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
>> index 5254413137c6..fc2c03d01a20 100644
>> --- a/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
>> +++ b/Documentation/devicetree/bindings/phy/rockchip,inno-usb2phy.yaml
>> @@ -20,6 +20,7 @@ properties:
>>         - rockchip,rk3366-usb2phy
>>         - rockchip,rk3399-usb2phy
>>         - rockchip,rk3568-usb2phy
>> +      - rockchip,rk3576-usb2phy
>>         - rockchip,rk3588-usb2phy
>>         - rockchip,rv1108-usb2phy
>>   
>> @@ -34,10 +35,12 @@ properties:
>>       const: 0
>>   
>>     clocks:
>> -    maxItems: 1
>> +    minItems: 1
>> +    maxItems: 3
>>   
>>     clock-names:
>> -    const: phyclk
>> +    minItems: 1
>> +    maxItems: 3
>>   
>>     assigned-clocks:
>>       description:
>> @@ -172,6 +175,45 @@ allOf:
>>               - interrupts
>>               - interrupt-names
>>   
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - rockchip,px30-usb2phy
>> +              - rockchip,rk3128-usb2phy
>> +              - rockchip,rk3228-usb2phy
>> +              - rockchip,rk3308-usb2phy
>> +              - rockchip,rk3328-usb2phy
>> +              - rockchip,rk3366-usb2phy
>> +              - rockchip,rk3399-usb2phy
>> +              - rockchip,rk3568-usb2phy
>> +              - rockchip,rk3588-usb2phy
>> +              - rockchip,rv1108-usb2phy
>> +    then:
>> +      properties:
>> +        clocks:
>> +          maxItems: 1
>> +        clock-names:
>> +          const: phyclk
> maxItems: 1 instead

Sorry for late reply.

Do you mean use "maxItems: 1" instead of "const: phyclk" ?


>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          contains:
>> +            enum:
>> +              - rockchip,rk3576-usb2phy
>> +    then:
>> +      properties:
>> +        clocks:
>> +          minItems: 3
>> +          maxItems: 3
>> +        clock-names:
>> +          items:
>> +            - const: phyclk
>> +            - const: aclk
>> +            - const: aclk_slv
> This list goes to the top property with minItems: 1. Here you have only
> minItems: 3.
>
> This way you have only one definition of entire list with same order of
> items between variants.

For rockchip,rk3576-usb2phy, three clocks are all required, and the 
driver does not care about the order of the clocks.

So is the above definition correct?


Best regards,
Frank

> Best regards,
> Krzysztof
>


