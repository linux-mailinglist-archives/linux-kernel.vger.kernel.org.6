Return-Path: <linux-kernel+bounces-354377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1C6993CD7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 04:30:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EB211C22BC4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 02:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D466D224F0;
	Tue,  8 Oct 2024 02:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxlAfhmL"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE25E13AC1;
	Tue,  8 Oct 2024 02:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728354613; cv=none; b=OMazWu1Q8G1+qawWNGgsqcoBvGNHIIkDNvepr3J62VhazrbSbcUzNgOqFJ/W4sW1MB3IVYxFE416WyEMMQTWTQpNPkNLEPjuC/QuMJnyOZgUK5EqXiBuaRHlrqoDMRHpjcTw6m13q78DPjiJ69nyLMi0xsnXQURQdCcuw2KsW+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728354613; c=relaxed/simple;
	bh=zwL9TcioXpUGhWLd1sDdthGSco4S5bRFfmVlR7J4P28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jp5ZYD1EGl0kgTUrfK2+1uO9J1HzprYmwGPe3oiRfTC8hnv1g7IvCINbHFY6oe0OU3oAGsQvxFgwEY9Gzi3q79URv1PKW7eXENxD3nSg9384w41z7sWrVYin2dQA95yCyxW7dG1+cqhGRMNe1m+vMMnBHyh9W0E7t0jFZyOHOsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxlAfhmL; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20b49ee353cso47901305ad.2;
        Mon, 07 Oct 2024 19:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728354611; x=1728959411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JLu2GkrJyIH/iXx8pdbjQNyQU8u3ariQBugLwkrciVs=;
        b=DxlAfhmLeHHUj1rN5e7JuAFnsf3uYPSsWheKVK4B3U6QhkUy81cCTc2h+H+KPli0S1
         /WcoGSlGUX0rJrRKWv53bT77qn4sTIuajDyTf7VwPYWbhDn+LS8flrjr5bUpNm53MfpD
         O0bQD832MlPhO9T4bmMC92O7zGtIAePrcoPuksF0yqSBRz7f7HOcYEHS3MjsBJweAz4g
         TRMIVshxB0pCLhGIIAvyBEAsswKzr0A6MybFLh5zU1yj23bRI1PwTKNJ7wO0B/yJkb5w
         ufXAuCY6AZ2gE5VPYI1tEPXqc5w6EHLoq+rHAC20Ubzkcx8DRAqoDEC8xA0dqM9RK6tF
         I/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728354611; x=1728959411;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JLu2GkrJyIH/iXx8pdbjQNyQU8u3ariQBugLwkrciVs=;
        b=Ka2kmJ8/3qXuKOBL272XcuV2kdGKnzgAIoAjTlcFqOw/bcR6wQ4Bnys2uhRAuZtIVl
         A31LQEyA1JKDnTZhEbFT0yJPBX7aw3/BHptPntRuPndSVohs37nS+crD4FhIDhfclqgP
         0HXZmTnS0un2ClXQ+wCowuwp/PTAOWX2E7VG5FtbH/LrOrKoWkpVwewOf+60Lc5fz42T
         R9cokt6UCnm0opZ1vu04qppRujjMaAImf2tOqlyJddLwJVchvOXKzFCytuNYXIaWxo95
         t2u7dy9FFtlcekzGQHYCUmL+XHsFawoIqeODJH2kAesH0MnMzBJALQ7B3TUpJV5ro9fh
         P+EA==
X-Forwarded-Encrypted: i=1; AJvYcCU/0CLV2XyGC8HLedAfeDkyF6lrn4XcDq+mhpqqhVL4y7R7D4fDs+R4fXBlnmUxNBiWElIVSrnfCGtiGLSQ@vger.kernel.org, AJvYcCUS8FpErTcNZSaKiv0OytaFj2zEZcKtyLjq8vBA2Qo9iYS/O+L8dWfyrHgrFB7loXl/+qDDWD5+lpzL@vger.kernel.org
X-Gm-Message-State: AOJu0YylGF/QBNsL3rmD3c3z42XvooNUc8Y3MqCrYSdHQ0PfTD9xsASZ
	kVzinCp01Kjnw8Mgk1IN1t1rJtgD7kt/4rhkbuhsi05xc4KWNiAQqiL5JQ==
X-Google-Smtp-Source: AGHT+IGeQEqLzuvHuWusEN4nVLoxNffXjEIhVExhavgblUpbYb87p1OahnMRUqzEYA2b6qstnKCPfA==
X-Received: by 2002:a05:6a21:1788:b0:1ce:d08c:2c10 with SMTP id adf61e73a8af0-1d6dfa55709mr20715014637.28.1728354610971;
        Mon, 07 Oct 2024 19:30:10 -0700 (PDT)
Received: from [172.19.1.53] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e28213ce28sm386873a91.40.2024.10.07.19.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 19:30:10 -0700 (PDT)
Message-ID: <eec602ce-e74a-4b37-880d-32b49a55adf8@gmail.com>
Date: Tue, 8 Oct 2024 10:30:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dt-bindings: mtd: nuvoton,ma35d1-nand: add new
 bindings
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: richard@nod.at, vigneshr@ti.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, nikita.shubin@maquefel.me, arnd@arndb.de,
 vkoul@kernel.org, esben@geanix.com, linux-arm-kernel@lists.infradead.org,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240927020749.46791-1-hpchen0nvt@gmail.com>
 <20240927020749.46791-2-hpchen0nvt@gmail.com>
 <20241001121902.658d3977@xps-13>
Content-Language: en-US
From: Hui-Ping Chen <hpchen0nvt@gmail.com>
In-Reply-To: <20241001121902.658d3977@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Miquel,

Thank you for your reply.



On 2024/10/1 下午 06:19, Miquel Raynal wrote:
> Hi Hui-Ping,
>
> hpchen0nvt@gmail.com wrote on Fri, 27 Sep 2024 02:07:48 +0000:
>
>> Add dt-bindings for the Nuvoton MA35 SoC NAND Controller.
>>
>> Signed-off-by: Hui-Ping Chen <hpchen0nvt@gmail.com>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>   .../bindings/mtd/nuvoton,ma35d1-nand.yaml     | 93 +++++++++++++++++++
>>   1 file changed, 93 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mtd/nuvoton,ma35d1-nand.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/nuvoton,ma35d1-nand.yaml b/Documentation/devicetree/bindings/mtd/nuvoton,ma35d1-nand.yaml
>> new file mode 100644
>> index 000000000000..a8a549644c98
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mtd/nuvoton,ma35d1-nand.yaml
>> @@ -0,0 +1,93 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/mtd/nuvoton,ma35d1-nand.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Nuvoton MA35D1 NAND Flash Interface (NFI) Controller
>> +
>> +maintainers:
>> +  - Hui-Ping Chen <hpchen0nvt@gmail.com>
>> +
>> +allOf:
>> +  - $ref: nand-controller.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - nuvoton,ma35d1-nand-controller
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +patternProperties:
>> +  "^nand@[a-f0-9]$":
>> +    type: object
>> +    $ref: raw-nand-chip.yaml
>> +    properties:
>> +      nand-ecc-step-size:
>> +        enum: [512, 1024]
>> +
>> +      nand-ecc-strength:
>> +        enum: [8, 12, 24]
>> +
>> +    required:
>> +      - nand-ecc-step-size
>> +      - nand-ecc-strength
> No, they should not be required, unless there is a good reason to do
> so. Optimal strength is discoverable, stop forcing it by default.


I will remove this required.


>> +
>> +    unevaluatedProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +
>> +unevaluatedProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/clock/nuvoton,ma35d1-clk.h>
>> +
>> +    soc {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        nand-controller@401A0000 {
>> +            compatible = "nuvoton,ma35d1-nand-controller";
>> +            reg = <0x0 0x401A0000 0x0 0x1000>;
>> +            interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
>> +            clocks = <&clk NAND_GATE>;
>> +            #address-cells = <1>;
>> +            #size-cells = <0>;
>> +
>> +            nand@0 {
>> +                reg = <0>;
>> +
>> +                nand-on-flash-bbt;
>> +                nand-ecc-step-size = <512>;
>> +                nand-ecc-strength = <8>;
>> +
>> +                partitions {
>> +                    compatible = "fixed-partitions";
>> +                    #address-cells = <1>;
>> +                    #size-cells = <1>;
>> +
>> +                    uboot@0 {
>> +                        label = "nand-uboot";
>> +                        read-only;
>> +                        reg = <0x0 0x300000>;
>> +                    };
>> +                };
>> +            };
>> +        };
>> +    };
>> +
>> +...
>
> Thanks,
> Miquèl


Best regards,

Hui-Ping Chen



