Return-Path: <linux-kernel+bounces-278209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3809694AD80
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 18:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C03A31F23250
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 16:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599D0131E4B;
	Wed,  7 Aug 2024 16:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="GVnYCrvn"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E71084DE4
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 16:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723046513; cv=none; b=taZsNICxXsDPBMhCr39Iu45p+6EYiWKp/KA3SnlsmrwPv3SsPlto7v+oRXe/fLtjDtE0PnE2UYX9VDVtsacoCjIvCvVo62M66k6SKpbspzR5xpOiFjHhWBWJUMmGNr8rsshhVYKVunfM6xz1+i0ugfNUimrv2jOJb6oxyTiw4A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723046513; c=relaxed/simple;
	bh=wysYm/qNgdUnSgwXEaScb6MDEVFUEQXszalkaSmx6xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c/MpW43CIDvsK/9tI+LnMx4SKX6NW8mzFoRjql8el6S+vMSl0dD0wrTR1N1wYNbnb69GpYfjurmi0PvCB/5xutDZXvoQJIG+k21CRaZBLh7dIvWlMSgTCkeVQx9v2Y7XlFM66nJhYpgH7N5aWuoXXZ8TAGIccJiY5Vr7dqBLKBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=GVnYCrvn; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a10835487fso3056095a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 09:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1723046508; x=1723651308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wfWrl8VZD19FKxaJR7VaPIQTf2XncwvdYl+52yGeefs=;
        b=GVnYCrvnRoVXziX0LBYeILmdi7S7nlrPgAZJoPWGFf4NX1IS9skjAQvoS9UCfaYfz0
         C5YhxgbXM/5pCnWTspPdd+kb/PcSJnuRjfknUd2i1HSxWfWHCXqbNR1L5i6P+kGIJwxo
         1F882S19KVnVSB1x/bPqMascQThG9+HOYFzf4HIPMEXfx0FXe4b95KEzqmHP4A0U95NZ
         NBLXcbu3nj0IyjqA0IPMS/YsKzhZgrZZfFTlvdLGCr7miAIq+Az6OnO1ylP7jSxnGVcb
         pSqMqHrY0RCKq7PG7Pe29mIuWfUNus0EztfMZjEZTjswZ0BKihKunT0cjlS+Z8SlMYe7
         xGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723046508; x=1723651308;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wfWrl8VZD19FKxaJR7VaPIQTf2XncwvdYl+52yGeefs=;
        b=QLt55sb98H7sCP25phPHhcm3oFyaagIMVr9gxxTaNzTyeF549mYg1uyXhCnQsC/Pai
         33xg2eegd0y4o4Vcg1sQbML8Qf1xEDdjCAbnfG4bMe/U4d+caGXaZKulM0r5BtMDStQV
         xBkirBzVkIXx2s12l5zQVcOUALKoMO/dQy1QITK9i0e7YkrOire+FhxeuNmm61z+IA6a
         bfQMOuU6l+J91iudX5svTfh/HLwCvdr31oxwSnPxeIZtHj1Qwru3GQT1kXvLTIpsF0Nj
         n39NyFJpEPEiLynU4Wd6U+omNktQ61p00XElpucOy4lnwzKm8L51P9mLJsA4DDJ8nKal
         QM/w==
X-Forwarded-Encrypted: i=1; AJvYcCWccfCOwBbhgwwDCdqVa2VrXt2aOSYsaxDRShW9if6lI37mi/qemkFvA61cB8Mc+d+9N5EnJLDcO9lfcnQs6WOIs8xv0EkayrM6F0H1
X-Gm-Message-State: AOJu0Yx5c44JMLhqLma9UViQIil3a7y2yE9RyAk06By1YKceL9SDcp6g
	wB5HfxczgUyRrVM7q2Y8EOf3hJrA2nPAx5/4WG4Lh6sZNGKc/mXZbQp1eyJ8lBY=
X-Google-Smtp-Source: AGHT+IHWrqwniJn2eVz5Em10yrKJfh8xr+5TVRXfs5U2EgWU1CtTRoAJrPQuOP6c/LaL/2ZVfbQ52Q==
X-Received: by 2002:aa7:c518:0:b0:5af:7b5a:8185 with SMTP id 4fb4d7f45d1cf-5b7f56fe0f6mr13501535a12.27.1723046508124;
        Wed, 07 Aug 2024 09:01:48 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5b839c25558sm7180604a12.32.2024.08.07.09.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 09:01:47 -0700 (PDT)
Message-ID: <89f51615-0dee-4ab0-ab72-e3c057fee1e7@tuxon.dev>
Date: Wed, 7 Aug 2024 19:01:46 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: microchip: Rename node, sub-node, and clean up
 spacing
Content-Language: en-US
To: Andrei Simion <andrei.simion@microchip.com>, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, nicolas.ferre@microchip.com,
 alexandre.belloni@bootlin.com
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240723131228.189308-1-andrei.simion@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240723131228.189308-1-andrei.simion@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Andrei,

On 23.07.2024 16:12, Andrei Simion wrote:
> Cosmetic work:

Can you please format it as follows:

> Rename the eeprom node according to device tree specification.

One patch for this.

> Rename the usb node according to device tree specification.

One patch for this.

> Rename the led sub nodes according to device tree specification.

One patch for this.

> Rename the pmic node according to the device tree specification.

One patch for this.

> Clean up spacing and indentation.

One patch for this.


> 
> Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
> ---
> Modifications Based On:
> https://lore.kernel.org/linux-arm-kernel/c4b23da5-10fc-476e-8acc-8ba0815f5def@kernel.org/

You had here 6 patches all addressing "Align the eeprom nodename".

Few comments bellow.

Thank you,
Claudiu Beznea

> ---
>  arch/arm/boot/dts/microchip/aks-cdu.dts       | 12 +++++-----
>  arch/arm/boot/dts/microchip/animeo_ip.dts     | 10 ++++----
>  .../dts/microchip/at91-cosino_mega2560.dts    |  2 +-
>  arch/arm/boot/dts/microchip/at91-foxg20.dts   |  4 ++--
>  .../arm/boot/dts/microchip/at91-qil_a9260.dts |  4 ++--
>  .../boot/dts/microchip/at91-sam9_l9260.dts    |  2 +-
>  .../arm/boot/dts/microchip/at91-sam9x60ek.dts |  6 ++---
>  .../dts/microchip/at91-sama5d27_som1.dtsi     |  2 +-
>  .../dts/microchip/at91-sama5d27_som1_ek.dts   | 14 +++++------
>  .../dts/microchip/at91-sama5d27_wlsom1.dtsi   |  2 +-
>  .../dts/microchip/at91-sama5d29_curiosity.dts |  2 +-
>  .../boot/dts/microchip/at91-sama5d2_icp.dts   | 10 ++++----
>  .../dts/microchip/at91-sama5d2_ptc_ek.dts     |  8 +++----
>  .../dts/microchip/at91-sama5d2_xplained.dts   |  8 +++----
>  .../dts/microchip/at91-sama5d3_xplained.dts   |  6 ++---
>  .../dts/microchip/at91-sama5d4_ma5d4evk.dts   |  6 ++---
>  .../dts/microchip/at91-sama5d4_xplained.dts   |  6 ++---
>  .../arm/boot/dts/microchip/at91-sama5d4ek.dts |  6 ++---
>  .../arm/boot/dts/microchip/at91-sama7g5ek.dts |  2 +-
>  arch/arm/boot/dts/microchip/at91-vinco.dts    |  6 ++---
>  arch/arm/boot/dts/microchip/at91rm9200.dtsi   |  4 ++--
>  arch/arm/boot/dts/microchip/at91rm9200ek.dts  | 10 ++++----
>  arch/arm/boot/dts/microchip/at91sam9260.dtsi  |  4 ++--
>  arch/arm/boot/dts/microchip/at91sam9260ek.dts | 10 ++++----
>  arch/arm/boot/dts/microchip/at91sam9261.dtsi  |  4 ++--
>  arch/arm/boot/dts/microchip/at91sam9261ek.dts | 10 ++++----
>  arch/arm/boot/dts/microchip/at91sam9263.dtsi  |  4 ++--
>  arch/arm/boot/dts/microchip/at91sam9263ek.dts | 12 +++++-----
>  arch/arm/boot/dts/microchip/at91sam9g20ek.dts |  4 ++--
>  .../boot/dts/microchip/at91sam9g20ek_2mmc.dts |  4 ++--
>  .../dts/microchip/at91sam9g20ek_common.dtsi   |  6 ++---
>  .../at91sam9g25-gardena-smart-gateway.dts     | 24 +++++++++----------
>  arch/arm/boot/dts/microchip/at91sam9g45.dtsi  |  6 ++---
>  .../boot/dts/microchip/at91sam9m10g45ek.dts   |  6 ++---
>  arch/arm/boot/dts/microchip/at91sam9n12.dtsi  |  4 ++--
>  arch/arm/boot/dts/microchip/at91sam9n12ek.dts | 10 ++++----
>  arch/arm/boot/dts/microchip/at91sam9rl.dtsi   |  2 +-
>  arch/arm/boot/dts/microchip/at91sam9rlek.dts  |  2 +-
>  arch/arm/boot/dts/microchip/at91sam9x5.dtsi   |  6 ++---
>  arch/arm/boot/dts/microchip/at91sam9x5cm.dtsi |  4 ++--
>  arch/arm/boot/dts/microchip/ethernut5.dts     |  4 ++--
>  arch/arm/boot/dts/microchip/evk-pro3.dts      |  4 ++--
>  arch/arm/boot/dts/microchip/mpa1600.dts       |  2 +-
>  arch/arm/boot/dts/microchip/pm9g45.dts        |  4 ++--
>  arch/arm/boot/dts/microchip/sam9x60.dtsi      |  6 ++---
>  arch/arm/boot/dts/microchip/sama5d2.dtsi      |  6 ++---
>  arch/arm/boot/dts/microchip/sama5d3.dtsi      |  6 ++---
>  arch/arm/boot/dts/microchip/sama5d34ek.dts    |  2 +-
>  arch/arm/boot/dts/microchip/sama5d3xmb.dtsi   |  6 ++---
>  .../boot/dts/microchip/sama5d3xmb_cmp.dtsi    |  2 +-
>  arch/arm/boot/dts/microchip/sama5d4.dtsi      |  6 ++---
>  arch/arm/boot/dts/microchip/tny_a9263.dts     |  2 +-
>  .../boot/dts/microchip/usb_a9260_common.dtsi  |  4 ++--
>  arch/arm/boot/dts/microchip/usb_a9263.dts     |  4 ++--
>  54 files changed, 156 insertions(+), 156 deletions(-)
> 

[ ... ]

>  
> @@ -258,10 +258,10 @@ pinctrl_i2c1_default: i2c1_default {
>  				};
>  
>  				pinctrl_i2c1_gpio: i2c1_gpio {
> -                                        pinmux = <PIN_PD4__GPIO>,
> -                                                 <PIN_PD5__GPIO>;
> -                                        bias-disable;
> -                                };
> +					pinmux = <PIN_PD4__GPIO>,
> +						 <PIN_PD5__GPIO>;
> +					bias-disable;
> +				};
>  

Please remove this extra line here, too.

[ ... ]

> -			usb1: gadget@fff78000 {
> +			usb1: usb@fff78000 {
>  				atmel,vbus-gpio = <&pioA 25 GPIO_ACTIVE_HIGH>;
>  				status = "okay";
>  			};
> @@ -86,7 +86,7 @@ pinctrl@fffff200 {
>  				mmc0 {
>  					pinctrl_board_mmc0: mmc0-board {
>  						atmel,pins =
> -							<AT91_PIOE 18 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH 	/* PE18 gpio CD pin pull up and deglitch */
> +							<AT91_PIOE 18 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP_DEGLITCH	/* PE18 gpio CD pin pull up and deglitch */

What was wrong here?

>  							 AT91_PIOE 19 AT91_PERIPH_GPIO AT91_PINCTRL_PULL_UP>;	/* PE19 gpio WP pin pull up */
>  					};
>  				};
> @@ -207,7 +207,7 @@ data@7ca0000 {
>  			};
>  		};

[ ...]

> diff --git a/arch/arm/boot/dts/microchip/at91sam9g25-gardena-smart-gateway.dts b/arch/arm/boot/dts/microchip/at91sam9g25-gardena-smart-gateway.dts
> index af70eb8a3a02..60560e4c1696 100644
> --- a/arch/arm/boot/dts/microchip/at91sam9g25-gardena-smart-gateway.dts
> +++ b/arch/arm/boot/dts/microchip/at91sam9g25-gardena-smart-gateway.dts
> @@ -37,71 +37,71 @@ button {
>  	leds {
>  		compatible = "gpio-leds";
>  
> -		power_blue {
> +		led-0 {
>  			label = "smartgw:power:blue";
>  			gpios = <&pioC 21 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
>  		};
>  
> -		power_green {
> +		led-1 {
>  			label = "smartgw:power:green";
>  			gpios = <&pioC 20 GPIO_ACTIVE_HIGH>;
>  			default-state = "on";
>  		};
>  
> -		power_red {
> +		led-2 {
>  			label = "smartgw:power:red";
>  			gpios = <&pioC 19 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
>  		};
>  
> -		radio_blue {
> +		led-3 {
>  			label = "smartgw:radio:blue";
>  			gpios = <&pioC 18 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
>  		};
>  
> -		radio_green {
> +		led-4 {
>  			label = "smartgw:radio:green";
>  			gpios = <&pioC 17 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
>  		};
>  
> -		radio_red {
> +		led-5 {
>  			label = "smartgw:radio:red";
>  			gpios = <&pioC 16 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
>  		};
>  
> -		internet_blue {
> +		led-6 {
>  			label = "smartgw:internet:blue";
>  			gpios = <&pioC 15 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
>  		};
>  
> -		internet_green {
> +		led-7 {
>  			label = "smartgw:internet:green";
>  			gpios = <&pioC 14 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
>  		};
>  
> -		internet_red {
> +		led-8 {
>  			label = "smartgw:internet:red";
>  			gpios = <&pioC 13 GPIO_ACTIVE_HIGH>;
>  			default-state = "off";
>  		};
>  
> -		heartbeat {
> +		led-9 {
>  			label = "smartgw:heartbeat";
>  			gpios = <&pioB 8 GPIO_ACTIVE_HIGH>;
>  			linux,default-trigger = "heartbeat";
>  		};
>  
> -		pb18 {
> +		led-pb18 {
>  			status = "disabled";
>  		};
>  
> -		pd21 {
> +		led-pd21 {

Why used led-<old-label> for some leds and led-<integer> for other? Valid
for other files.


