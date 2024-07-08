Return-Path: <linux-kernel+bounces-244633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A52CE92A72A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 235B11F21F5C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 16:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179BC145A0E;
	Mon,  8 Jul 2024 16:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="eG/Wd4vC"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79CC1E532
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 16:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720455631; cv=none; b=iVuNJq4oV0lwPdnrrZQw6jPcQ5QgJbjkw/xhy94R16MmP2/GYVKYQjX1A3NsDxOnx9GvWSC294GPUT+90jUx7N487lyJNqBVam/2Yb3eVv/ja69qAa+IwBPZ8r71mwg/RSyHbJabG3SSHyMYovDReCuhmJiEYzNtFCbLOPzl3Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720455631; c=relaxed/simple;
	bh=aJdk/XRdWyIblLK3ozQTkwTptbk1YQXFtKbNtXz0vM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jZDlcXBKPmMQI/5cSj3KOBJ2PBZJLM6EcO2DdTgNrvefiicLvossp8EozuqXiT6fV3iypPHNVfCXgIpnyDzrscHPjMfpsnJY6Hsp3LAzwiU4XmmgCldjy6igf14YwE5EkwhMYkJIkKd/ry2YISLOm9ohovcQXnqqtcQUUkz1ALI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=eG/Wd4vC; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4266ea6a488so4201155e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 09:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1720455627; x=1721060427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=efjdffzA6be808BSQrBm7ElmnNfN/TFUiTpZ5HUXzX0=;
        b=eG/Wd4vC0Kvv0MnxdExXiOJNFKpcyzKGOfjntR4xyl0I/N8pL0rsXRcfLvN37XexTf
         r6RDbIgkac55IDHhSBvBxBS3rpJsRFW5SZ64zT+NL/7mFH/fqWBBvwyUR8KdUL94sdl8
         aKhBICQIDkXynuBgaITx3dz43ffFjm5Ez4MRbyZLNgJjCzxvs0DZNqGWdIJgCro2BChx
         ZDoqKfJ/arpaU5P/kzfzNZuSUaYJO+EwYfWvFiEL91kXFVpvSFLZ9K3WVKQ+DlbKCpEJ
         mRDR171I3aCA9Oj8vRK8hd0mjp8ohfHQHUiOSyrbIERXXvfKaAViTNoEBEmpa5IzlC4R
         rbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720455627; x=1721060427;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=efjdffzA6be808BSQrBm7ElmnNfN/TFUiTpZ5HUXzX0=;
        b=tFB0fSXKk+2KugMLtuwd6sUK0edSCE/JR+jTq7XaYhmsqqwuuTdCtWtXJB4GFcninb
         ffKhmhf7v64gABjeo13LvYjCnBSe4G56nvBxX/EMCCIucgLy/JdLEV8Uay96IVstKimv
         ja2NL+PNb/TR75cd/m/esh2nEM7WhVi9oxumnQ/Yv0F9GpvjSSk1c7bG8gwJHsbvlTj/
         maJGtZpCYCeBybVyR1s/uGcX9NypAWhKEayOSD7rMbdMn0ZyQnC3pwHm+sfdx+3PNZyK
         Xp1sGWu7nXssoNLvpP6nl+OA0Sg9tlW1I0GMsj6VVdB/nc69+5od+fNimlDDx2qTkZMH
         c+ug==
X-Forwarded-Encrypted: i=1; AJvYcCXtKJBy6LeN9Phnf6M3HYfUfUw/vp2n8gBsBHFv7GrrfYiqug6+3sgaJs4rJ1Y1ACDRzDYoJgSPsnXqwOZSVnKHPw0ITE4+JH0tnh/Y
X-Gm-Message-State: AOJu0Yw5e2mn+bZ3nGpOb6stwycKGYYX4d/lVjKQEOmZY2pUAPfv2SAl
	1hNLK8/q2Ywb5g9moxHAUep9OlXbJu+ESFPSidUIUFnd+abVLGpnYO8ThSAPC4c=
X-Google-Smtp-Source: AGHT+IEG2NVvE7PrRKg7rvuM/rTMMME7BNjBvE+R82kpH5ObylZi/9GqsJx73f7ua5ZrBr8wVzZGCw==
X-Received: by 2002:a05:600c:1c99:b0:426:6714:5415 with SMTP id 5b1f17b1804b1-426707f8573mr672685e9.30.1720455626895;
        Mon, 08 Jul 2024 09:20:26 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266dcf49besm23283295e9.41.2024.07.08.09.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 09:20:26 -0700 (PDT)
Message-ID: <ced35e84-0dde-4c44-8b57-849036705de8@tuxon.dev>
Date: Mon, 8 Jul 2024 19:20:24 +0300
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
To: Alexander Dahl <ada@thorsis.com>, devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org
References: <20240528153109.439407-1-ada@thorsis.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240528153109.439407-1-ada@thorsis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 28.05.2024 18:31, Alexander Dahl wrote:
> These properties are common for all i2c subnodes, and marked as
> 'required' in atmel/microchip i2c bindings. 

Not required anymore:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=cf7feb642dc0e36bbbda9ec9fecc6601f439b8dd

> Allows to add i2c device
> nodes (like an rtc for example) in other .dts files including
> sam9x60.dtsi without requiring to repeat these properties for each i2c
> device again and again.
> 
> Found on a custom board after adding this in .dts:
> 
>     &flx5 {
>             atmel,flexcom-mode = <ATMEL_FLEXCOM_MODE_TWI>;
>             status = "okay";
> 
>             i2c5: i2c@600 {
>                     pinctrl-0 = <&pinctrl_flx5_default>;
>                     status = "okay";
> 
>                     pcf8523: rtc@68 {
>                             compatible = "nxp,pcf8523";
>                             reg = <0x68>;
>                     };
>             };
>     };
> 
> … which created a warning like this:
> 
>     […]:236.4-17: Warning (reg_format): /ahb/apb/flexcom@f0004000/i2c@600/rtc@68:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
>     […]: Warning (pci_device_reg): Failed prerequisite 'reg_format'
>     […]: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
>     […]: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
>     […]/linux-6.6.25/arch/arm/boot/dts/microchip/sam9x60.dtsi:283.19-299.7: Warning (i2c_bus_bridge): /ahb/apb/flexcom@f0004000/i2c@600: incorrect #address-cells for I2C bus also defined at […]:228.16-238.4
>     […]/linux-6.6.25/arch/arm/boot/dts/microchip/sam9x60.dtsi:283.19-299.7: Warning (i2c_bus_bridge): /ahb/apb/flexcom@f0004000/i2c@600: incorrect #size-cells for I2C bus also defined at […]:228.16-238.4
>     […]: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
>     […]: Warning (i2c_bus_reg): Failed prerequisite 'i2c_bus_bridge'
>     […]: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
>     […]:234.19-237.5: Warning (avoid_default_addr_size): /ahb/apb/flexcom@f0004000/i2c@600/rtc@68: Relying on default #address-cells value
>     […]:234.19-237.5: Warning (avoid_default_addr_size): /ahb/apb/flexcom@f0004000/i2c@600/rtc@68: Relying on default #size-cells value
>     […]: Warning (avoid_unnecessary_addr_size): Failed prerequisite 'avoid_default_addr_size'
>     […]: Warning (unique_unit_address): Failed prerequisite 'avoid_default_addr_size'
> 
> This probably should have been done with commit 84f23f3284d5 ("ARM: dts:
> at91: sam9x60: move flexcom definitions") already, where those
> address-cells and size-cells properties were left in the board .dts
> files instead of moving them to the dtsi.
> 
> Signed-off-by: Alexander Dahl <ada@thorsis.com>

Will apply it for the next PR.

> ---
>  .../dts/microchip/at91-sam9x60_curiosity.dts  |  2 --
>  .../arm/boot/dts/microchip/at91-sam9x60ek.dts |  4 ---
>  arch/arm/boot/dts/microchip/sam9x60.dtsi      | 26 +++++++++++++++++++
>  3 files changed, 26 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts b/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
> index c6fbdd29019f..b9ffd9e5faac 100644
> --- a/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
> +++ b/arch/arm/boot/dts/microchip/at91-sam9x60_curiosity.dts
> @@ -198,8 +198,6 @@ i2c0: i2c@600 {
>  		dmas = <0>, <0>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_flx0_default>;
> -		#address-cells = <1>;
> -		#size-cells = <0>;
>  		i2c-analog-filter;
>  		i2c-digital-filter;
>  		i2c-digital-filter-width-ns = <35>;
> diff --git a/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts b/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
> index f3cbb675cea4..3b38707d736e 100644
> --- a/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
> +++ b/arch/arm/boot/dts/microchip/at91-sam9x60ek.dts
> @@ -207,8 +207,6 @@ &flx0 {
>  	status = "okay";
>  
>  	i2c0: i2c@600 {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
>  		dmas = <0>, <0>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_flx0_default>;
> @@ -254,8 +252,6 @@ &flx6 {
>  	status = "okay";
>  
>  	i2c6: i2c@600 {
> -		#address-cells = <1>;
> -		#size-cells = <0>;
>  		dmas = <0>, <0>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&pinctrl_flx6_default>;
> diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> index 291540e5d81e..551b46894f47 100644
> --- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
> +++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> @@ -215,6 +215,8 @@ i2c4: i2c@600 {
>  					compatible = "microchip,sam9x60-i2c";
>  					reg = <0x600 0x200>;
>  					interrupts = <13 IRQ_TYPE_LEVEL_HIGH 7>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 13>;
>  					dmas = <&dma0
>  						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -284,6 +286,8 @@ i2c5: i2c@600 {
>  					compatible = "microchip,sam9x60-i2c";
>  					reg = <0x600 0x200>;
>  					interrupts = <14 IRQ_TYPE_LEVEL_HIGH 7>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 14>;
>  					dmas = <&dma0
>  						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -394,6 +398,8 @@ i2c11: i2c@600 {
>  					compatible = "microchip,sam9x60-i2c";
>  					reg = <0x600 0x200>;
>  					interrupts = <32 IRQ_TYPE_LEVEL_HIGH 7>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 32>;
>  					dmas = <&dma0
>  						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -443,6 +449,8 @@ i2c12: i2c@600 {
>  					compatible = "microchip,sam9x60-i2c";
>  					reg = <0x600 0x200>;
>  					interrupts = <33 IRQ_TYPE_LEVEL_HIGH 7>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 33>;
>  					dmas = <&dma0
>  						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -600,6 +608,8 @@ i2c6: i2c@600 {
>  					compatible = "microchip,sam9x60-i2c";
>  					reg = <0x600 0x200>;
>  					interrupts = <9 IRQ_TYPE_LEVEL_HIGH 7>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 9>;
>  					dmas = <&dma0
>  						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -649,6 +659,8 @@ i2c7: i2c@600 {
>  					compatible = "microchip,sam9x60-i2c";
>  					reg = <0x600 0x200>;
>  					interrupts = <10 IRQ_TYPE_LEVEL_HIGH 7>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 10>;
>  					dmas = <&dma0
>  						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -698,6 +710,8 @@ i2c8: i2c@600 {
>  					compatible = "microchip,sam9x60-i2c";
>  					reg = <0x600 0x200>;
>  					interrupts = <11 IRQ_TYPE_LEVEL_HIGH 7>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 11>;
>  					dmas = <&dma0
>  						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -766,6 +780,8 @@ i2c0: i2c@600 {
>  					compatible = "microchip,sam9x60-i2c";
>  					reg = <0x600 0x200>;
>  					interrupts = <5 IRQ_TYPE_LEVEL_HIGH 7>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 5>;
>  					dmas = <&dma0
>  						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -834,6 +850,8 @@ i2c1: i2c@600 {
>  					compatible = "microchip,sam9x60-i2c";
>  					reg = <0x600 0x200>;
>  					interrupts = <6 IRQ_TYPE_LEVEL_HIGH 7>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 6>;
>  					dmas = <&dma0
>  						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -902,6 +920,8 @@ i2c2: i2c@600 {
>  					compatible = "microchip,sam9x60-i2c";
>  					reg = <0x600 0x200>;
>  					interrupts = <7 IRQ_TYPE_LEVEL_HIGH 7>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 7>;
>  					dmas = <&dma0
>  						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -970,6 +990,8 @@ i2c3: i2c@600 {
>  					compatible = "microchip,sam9x60-i2c";
>  					reg = <0x600 0x200>;
>  					interrupts = <8 IRQ_TYPE_LEVEL_HIGH 7>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 8>;
>  					dmas = <&dma0
>  						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -1074,6 +1096,8 @@ i2c9: i2c@600 {
>  					compatible = "microchip,sam9x60-i2c";
>  					reg = <0x600 0x200>;
>  					interrupts = <15 IRQ_TYPE_LEVEL_HIGH 7>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 15>;
>  					dmas = <&dma0
>  						(AT91_XDMAC_DT_MEM_IF(0) |
> @@ -1123,6 +1147,8 @@ i2c10: i2c@600 {
>  					compatible = "microchip,sam9x60-i2c";
>  					reg = <0x600 0x200>;
>  					interrupts = <16 IRQ_TYPE_LEVEL_HIGH 7>;
> +					#address-cells = <1>;
> +					#size-cells = <0>;
>  					clocks = <&pmc PMC_TYPE_PERIPHERAL 16>;
>  					dmas = <&dma0
>  						(AT91_XDMAC_DT_MEM_IF(0) |
> 
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0

