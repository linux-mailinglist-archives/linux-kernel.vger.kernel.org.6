Return-Path: <linux-kernel+bounces-244639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C4092A739
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03661F21601
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD601145B3B;
	Mon,  8 Jul 2024 16:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="ckXZVWfb"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC911419B5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 16:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720455833; cv=none; b=JukcuMk+eSIi912DySe1sw0zc5Glr1adVYe7XDGFQnbotBIqRHY5NmoMo1CexhpoqN+XxbcMTTSCcH7O9+jISRBRgMyjnxK3bFXt5IVO89TEUlS8XSEUqMEQ5LSenAa8TYMJViVqFEiIu4c4c6rYbZf1nNfgkjvHuNl/eSFD5SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720455833; c=relaxed/simple;
	bh=jSn78okXtRS0dnv+PeonQjGYOxB3OOwhhyM3PscgFWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=hbxHxCnRr4MoD6TtelO6U10GOyyAyrOF7vEIJdNkVaHzhVLlQqes+3QhYcGiSJIG8PUpdg+BNBy2kCjS8D5J0bBi28NKoPcBjUg1JmGjrsSksKQrEV0xtLY+6jk57g+kdG+QnyEl4a9erO3lG8HOJLfY6NvzwR3uO5HyqltixaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=ckXZVWfb; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eabd22d3f4so42925441fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 09:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1720455830; x=1721060630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HoLRPpuQmo9FjJRLgcNB4t0ZfZDeWh8+0GFq1KxijDo=;
        b=ckXZVWfb8N58353GHqAsfQlBagJ+doEF5R7DQDf92I+qAzUKdssxoJN5FLXGovTv/W
         h0Lso0BoIeA1Z9Nt0yjH1jhs3nxDmJvOlSVbZE2CeeIiocjZBNb4gRRZAbA0XaFwAYkv
         C8pZvknFQM7GJjWEwNwp7WQBivU47a2Fy9pq3T9S3NABE+lluB9+zfrpm/lLGsPYAYxc
         7wHSarO3gbYOIhWB+N68DtzGKsc1af652sVOKVu0Q2OJiII/vWC83Slm1TFAFIrj2noK
         +ewAhxAjQcGBYNm9hxnj9cofUAdbHNrUlfX5VF32+M1rta+LTXzj7OSv6v7hvlz5NGX6
         BZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720455830; x=1721060630;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HoLRPpuQmo9FjJRLgcNB4t0ZfZDeWh8+0GFq1KxijDo=;
        b=TXdpVUlfS7zDzZcgLQs1vK1osjg8N4yjF5FqOhvaIrvPfxAAlQk46ny+eyl3hiykPS
         59zGm6wc4mxGIDQeCuUuxkPmmpJW6r7RdaiVT5TADwIr3emCWcsR9egzJ7TaFntqxVre
         Jbw6RYDVvLtU9W5agtrauc67cBZHZOZN7B9T2fe+KgYECMcEdlOSmwg4ZXL8l0WUYRGG
         2e8zlOWye8guLQgi8qt+HjmlqLSSPyCWxncXmDhUdQqEl14VSxTCvbPAaB/pMcfhVIMd
         02HmuSUhJAXR4NBKKpCOctcbvMaEg4ql+TV76N6JsD3QNjG2kL6XZuXpGtpdztOSnTvM
         YxZw==
X-Forwarded-Encrypted: i=1; AJvYcCWJDxiNjRZWQcpZY8P+2UfCNbDyNlsDc9HJYaMVP31MTlF3/wnZNznKVk1gy40OdnObjr1IeZ3z7fy5jc9YXC50/mMVLNqhoQdYFejI
X-Gm-Message-State: AOJu0YzaZ31xWXOREuwfNhU+15CrA9qVm63g5AyVjO7s4HHjjpAujsbR
	ni3R6RBBww35OcZpVckG635cYA6nRsX7MLQWAGF4wiofChjzWTykk+9sJR/s4Tk=
X-Google-Smtp-Source: AGHT+IGxsHExHJR7X7r40hND2PJrszccNLJS04p/sluUMjMNNpVGXPTD8PTGT/+3qIb2tmK/jqegMA==
X-Received: by 2002:a2e:9495:0:b0:2ec:558f:a3a with SMTP id 38308e7fff4ca-2eeb30b9fd7mr1471511fa.4.1720455829885;
        Mon, 08 Jul 2024 09:23:49 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42667720667sm59826685e9.33.2024.07.08.09.23.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 09:23:48 -0700 (PDT)
Message-ID: <30fc0b41-49b9-41b8-82ef-c27d202492e6@tuxon.dev>
Date: Mon, 8 Jul 2024 19:23:47 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: microchip: sam9x60: Move i2c address/size to
 dtsi
Content-Language: en-US
To: devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Mihai Sain <mihai.sain@microchip.com>
References: <20240528153109.439407-1-ada@thorsis.com>
 <20240705-defection-septum-dd9202836b23@thorsis.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240705-defection-septum-dd9202836b23@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 05.07.2024 09:19, Alexander Dahl wrote:
> Hei hei,
> 
> Am Tue, May 28, 2024 at 05:31:09PM +0200 schrieb Alexander Dahl:
>> These properties are common for all i2c subnodes, and marked as
>> 'required' in atmel/microchip i2c bindings.  Allows to add i2c device
>> nodes (like an rtc for example) in other .dts files including
>> sam9x60.dtsi without requiring to repeat these properties for each i2c
>> device again and again.
>>
>> Found on a custom board after adding this in .dts:
>>
>>     &flx5 {
>>             atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
>>             status = "okay";
>>
>>             i2c5: i2c@600 {
>>                     pinctrl-0 = <&pinctrl_flx5_default>;
>>                     status = "okay";
>>
>>                     pcf8523: rtc@68 {
>>                             compatible = "nxp,pcf8523";
>>                             reg = <0x68>;
>>                     };
>>             };
>>     };
>>
>> … which created a warning like this:
>>
>>     […]:236.4-17: Warning (reg_format): /ahb/apb/flexcom@f0004000/i2c@600/rtc@68:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
>>     […]: Warning (pci_device_reg): Failed prerequisite 'reg_format'
>>     […]: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
>>     […]: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
>>     […]/linux-6.6.25/arch/arm/boot/dts/microchip/sam9x60.dtsi:283.19-299.7: Warning (i2c_bus_bridge): /ahb/apb/flexcom@f0004000/i2c@600: incorrect #address-cells for I2C bus also defined at […]:228.16-238.4
>>     […]/linux-6.6.25/arch/arm/boot/dts/microchip/sam9x60.dtsi:283.19-299.7: Warning (i2c_bus_bridge): /ahb/apb/flexcom@f0004000/i2c@600: incorrect #size-cells for I2C bus also defined at […]:228.16-238.4
>>     […]: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
>>     […]: Warning (i2c_bus_reg): Failed prerequisite 'i2c_bus_bridge'
>>     […]: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
>>     […]:234.19-237.5: Warning (avoid_default_addr_size): /ahb/apb/flexcom@f0004000/i2c@600/rtc@68: Relying on default #address-cells value
>>     […]:234.19-237.5: Warning (avoid_default_addr_size): /ahb/apb/flexcom@f0004000/i2c@600/rtc@68: Relying on default #size-cells value
>>     […]: Warning (avoid_unnecessary_addr_size): Failed prerequisite 'avoid_default_addr_size'
>>     […]: Warning (unique_unit_address): Failed prerequisite 'avoid_default_addr_size'
>>
>> This probably should have been done with commit 84f23f3284d5 ("ARM: dts:
>> at91: sam9x60: move flexcom definitions") already, where those
>> address-cells and size-cells properties were left in the board .dts
>> files instead of moving them to the dtsi.
> 
> It's been a while.  Is something wrong with the patch?  Or with the
> commit message?

Please CC your patches to proper people (e.g., use
./script/get_maintainer.pl). I see no Microchip AT91 maintainers in the
initial to/cc list of your patch.

Thank you,
Claudiu Beznea

> 
> at91 support seems to have slowed down somehow lately? :-/
> 
> Greets
> Alex
> 
>>
>> Signed-off-by: Alexander Dahl <ada@thorsis.com>
>> ---
>>  .../dts/microchip/at91-sam9x60_curiosity.dts  |  2 --
>>  .../arm/boot/dts/microchip/at91-sam9x60ek.dts |  4 ---
>>  arch/arm/boot/dts/microchip/sam9x60.dtsi      | 26 +++++++++++++++++++
>>  3 files changed, 26 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
>> index c6fbdd29019f..b9ffd9e5faac 100644
>> --- a/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
>> +++ b/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
>> @@ -198,8 +198,6 @@ i2c0: i2c@600 {
>>  		dmas = <0>, <0>;
>>  		pinctrl-names = "default";
>>  		pinctrl-0 = <&pinctrl_flx0_default>;
>> -		#address-cells = <1>;
>> -		#size-cells = <0>;
>>  		i2c-analog-filter;
>>  		i2c-digital-filter;
>>  		i2c-digital-filter-width-ns = <35>;
>> diff --git a/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts b/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
>> index f3cbb675cea4..3b38707d736e 100644
>> --- a/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
>> +++ b/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
>> @@ -207,8 +207,6 @@ &flx0 {
>>  	status = "okay";
>>  
>>  	i2c0: i2c@600 {
>> -		#address-cells = <1>;
>> -		#size-cells = <0>;
>>  		dmas = <0>, <0>;
>>  		pinctrl-names = "default";
>>  		pinctrl-0 = <&pinctrl_flx0_default>;
>> @@ -254,8 +252,6 @@ &flx6 {
>>  	status = "okay";
>>  
>>  	i2c6: i2c@600 {
>> -		#address-cells = <1>;
>> -		#size-cells = <0>;
>>  		dmas = <0>, <0>;
>>  		pinctrl-names = "default";
>>  		pinctrl-0 = <&pinctrl_flx6_default>;
>> diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
>> index 291540e5d81e..551b46894f47 100644
>> --- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
>> +++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
>> @@ -215,6 +215,8 @@ i2c4: i2c@600 {
>>  					compatible = "microchip,sam9x60-i2c";
>>  					reg = <0x600 0x200>;
>>  					interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
>>  					dmas = <&dma0
>>  						(AT91_XDMAC_DT_MEM_IF(0) |
>> @@ -284,6 +286,8 @@ i2c5: i2c@600 {
>>  					compatible = "microchip,sam9x60-i2c";
>>  					reg = <0x600 0x200>;
>>  					interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
>>  					dmas = <&dma0
>>  						(AT91_XDMAC_DT_MEM_IF(0) |
>> @@ -394,6 +398,8 @@ i2c11: i2c@600 {
>>  					compatible = "microchip,sam9x60-i2c";
>>  					reg = <0x600 0x200>;
>>  					interrupts = <32 IRQ_TYPE_LEVEL_HIGH 7>;
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 32>;
>>  					dmas = <&dma0
>>  						(AT91_XDMAC_DT_MEM_IF(0) |
>> @@ -443,6 +449,8 @@ i2c12: i2c@600 {
>>  					compatible = "microchip,sam9x60-i2c";
>>  					reg = <0x600 0x200>;
>>  					interrupts = <33 IRQ_TYPE_LEVEL_HIGH 7>;
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 33>;
>>  					dmas = <&dma0
>>  						(AT91_XDMAC_DT_MEM_IF(0) |
>> @@ -600,6 +608,8 @@ i2c6: i2c@600 {
>>  					compatible = "microchip,sam9x60-i2c";
>>  					reg = <0x600 0x200>;
>>  					interrupts = <9 IRQ_TYPE_LEVEL_HIGH 7>;
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
>>  					dmas = <&dma0
>>  						(AT91_XDMAC_DT_MEM_IF(0) |
>> @@ -649,6 +659,8 @@ i2c7: i2c@600 {
>>  					compatible = "microchip,sam9x60-i2c";
>>  					reg = <0x600 0x200>;
>>  					interrupts = <10 IRQ_TYPE_LEVEL_HIGH 7>;
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 10>;
>>  					dmas = <&dma0
>>  						(AT91_XDMAC_DT_MEM_IF(0) |
>> @@ -698,6 +710,8 @@ i2c8: i2c@600 {
>>  					compatible = "microchip,sam9x60-i2c";
>>  					reg = <0x600 0x200>;
>>  					interrupts = <11 IRQ_TYPE_LEVEL_HIGH 7>;
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 11>;
>>  					dmas = <&dma0
>>  						(AT91_XDMAC_DT_MEM_IF(0) |
>> @@ -766,6 +780,8 @@ i2c0: i2c@600 {
>>  					compatible = "microchip,sam9x60-i2c";
>>  					reg = <0x600 0x200>;
>>  					interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
>>  					dmas = <&dma0
>>  						(AT91_XDMAC_DT_MEM_IF(0) |
>> @@ -834,6 +850,8 @@ i2c1: i2c@600 {
>>  					compatible = "microchip,sam9x60-i2c";
>>  					reg = <0x600 0x200>;
>>  					interrupts = <6 IRQ_TYPE_LEVEL_HIGH 7>;
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
>>  					dmas = <&dma0
>>  						(AT91_XDMAC_DT_MEM_IF(0) |
>> @@ -902,6 +920,8 @@ i2c2: i2c@600 {
>>  					compatible = "microchip,sam9x60-i2c";
>>  					reg = <0x600 0x200>;
>>  					interrupts = <7 IRQ_TYPE_LEVEL_HIGH 7>;
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
>>  					dmas = <&dma0
>>  						(AT91_XDMAC_DT_MEM_IF(0) |
>> @@ -970,6 +990,8 @@ i2c3: i2c@600 {
>>  					compatible = "microchip,sam9x60-i2c";
>>  					reg = <0x600 0x200>;
>>  					interrupts = <8 IRQ_TYPE_LEVEL_HIGH 7>;
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
>>  					dmas = <&dma0
>>  						(AT91_XDMAC_DT_MEM_IF(0) |
>> @@ -1074,6 +1096,8 @@ i2c9: i2c@600 {
>>  					compatible = "microchip,sam9x60-i2c";
>>  					reg = <0x600 0x200>;
>>  					interrupts = <15 IRQ_TYPE_LEVEL_HIGH 7>;
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 15>;
>>  					dmas = <&dma0
>>  						(AT91_XDMAC_DT_MEM_IF(0) |
>> @@ -1123,6 +1147,8 @@ i2c10: i2c@600 {
>>  					compatible = "microchip,sam9x60-i2c";
>>  					reg = <0x600 0x200>;
>>  					interrupts = <16 IRQ_TYPE_LEVEL_HIGH 7>;
>> +					#address-cells = <1>;
>> +					#size-cells = <0>;
>>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 16>;
>>  					dmas = <&dma0
>>  						(AT91_XDMAC_DT_MEM_IF(0) |
>>
>> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
>> -- 
>> 2.39.2
>>
>>
> 

