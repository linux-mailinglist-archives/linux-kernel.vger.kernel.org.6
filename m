Return-Path: <linux-kernel+bounces-296277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC31F95A885
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 01:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE374B21D41
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 23:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0C717DFE9;
	Wed, 21 Aug 2024 23:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VbtvZFJi"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581B616F0DE;
	Wed, 21 Aug 2024 23:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724284331; cv=none; b=aSpbNINeDysLQ2fZlPZtxgWey6ndsR1VCVZD18mfUQXBxLoI7Lovzrnu4JJHua1i/r2+bFStgI+EXVyhat4ev5swObHlHzk4drAOEq6tGD1YxF5BdV+o50wutN6BuxaldvwcdttCcPYvH8djURkzyQ2l/sCJVkKCr8LH4mVDQn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724284331; c=relaxed/simple;
	bh=/Z/HwBcsCtywniW/ZzCfaEcLcBT+4xgCHYU82J8sQv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQOD+8bbX7VA3Zw7d4aJr/z2K2NRLTS26USXMvfAL/VM1zub/2absl40yciVkv+9Ls8ra1OSPfCJ03ARp1Euy4faz4XslfN4RhBy6EqcqPeTm9qze6SPzTBybhRv6j0HKhryiwXlgTiVWqigpDLL4ErT6v3k2PNB62oQR9gHK4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VbtvZFJi; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0E59640002;
	Wed, 21 Aug 2024 23:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724284326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0HU6Ta0HRhn2z2jojEOSX+U5lajLvD863lfH93hnjsU=;
	b=VbtvZFJi3StZk7TiRQXTxa1wm4MmfPKHL0/WmMfUgnd49Fp7FopIMAlK2UXxlv/eUEAZx6
	G6gk53COFJWmQNJRJAHgZ61Fus17tem6M23NMRwLJQt8i+ALVUNqgBlU6F7EYaYZMsHP8E
	zjdJTCvcqovkCYhr9Q3LDATQrlOIPETV9/3txL9CQ5+Ugg5Anus1/MAOx/yFieYDBvYGea
	SH9tSE0HZ7ZpETMcv/q0yOoBqxmveYFxZRKKGOdFjDNOY35AD9MtfW6nNvgrdj3OrglYQU
	32cvapPFuyT+WMBAv/cEm8FAe23ezIoWg9g0SiViWtszE01NzAjvrQE63GfeHw==
Date: Thu, 22 Aug 2024 01:52:05 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Alexander Dahl <ada@thorsis.com>
Cc: linux-clk@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
	Sandeep Sheriker Mallikarjun <sandeepsheriker.mallikarjun@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ARM: dts: microchip: sam9x60: Fix rtc/rtt clocks
Message-ID: <20240821235205b302068b@mail.local>
References: <20240820132730.357347-1-ada@thorsis.com>
 <20240821055136.6858-1-ada@thorsis.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240821055136.6858-1-ada@thorsis.com>
X-GND-Sasl: alexandre.belloni@bootlin.com

On 21/08/2024 07:51:36+0200, Alexander Dahl wrote:
> The RTC and RTT peripherals use the "timing domain slow clock (TD_SLCK),
> sourced from the 32.768 kHz crystal oscillator.
> 
> (The previously used Monitoring domain slow clock (MD_SLCK) is sourced
> from an internal RC oscillator which is most probably not precise enough
> for real time clock purposes.)
> 
> Fixes: 1e5f532c2737 ("ARM: dts: at91: sam9x60: add device tree for soc and board")
> Fixes: 5f6b33f46346 ("ARM: dts: sam9x60: add rtt")
> Signed-off-by: Alexander Dahl <ada@thorsis.com>
> ---
> 
> Notes:
>     Picked the wrong patch in the first try.  This v2 one has a slightly
>     adapted commit message and more context below.
>     
>     This obviously requires a 32.768 kHz crystal oscillator to be present,
>     but the sam9x60.dtsi does contain that, and the clock-controllers
>     reference that, so I assume it's always present.

The crystal is optional so this is going to break the boards that don't
have one. I don't really mind but this should probably be part of the
commit message.

This makes me realise that we always assumed the RC oscillator was
running at 32768 while the sam9x60 datasheet refers to it has a 32kHz
oscillator. However the RTC only has a 32768 divider...

>     
>     /sys/kernel/debug/clk/clk_summary content excerpt before:
>     
>          slow_rc_osc                         1       1        0        32768       93750000   0     50000      Y   deviceless                      no_connection_id
>             md_slck                          4       4        0        32768       0          0     50000      Y      fffffea8.rtc                    no_connection_id
>                                                                                                                       fffffe20.rtc                    no_connection_id
>                                                                                                                       fffffe10.poweroff               no_connection_id
>                                                                                                                       fffffe00.reset-controller       no_connection_id
>                                                                                                                       timer@f8008000                  slow_clk
>                                                                                                                       deviceless                      no_connection_id
>     …
>          slow_xtal                           0       0        0        32768       0          0     50000      Y   deviceless                      no_connection_id
>             slow_osc                         0       0        0        32768       0          0     50000      Y      deviceless                      no_connection_id
>                td_slck                       0       0        0        32768       0          0     50000      Y         deviceless                      no_connection_id
>     
>     And after:
>     
>          slow_rc_osc                         1       1        0        32768       93750000   0     50000      Y   deviceless                      no_connection_id
>             md_slck                          2       2        0        32768       0          0     50000      Y      fffffe10.poweroff               no_connection_id
>                                                                                                                       fffffe00.reset-controller       no_connection_id
>                                                                                                                       timer@f8008000                  slow_clk
>                                                                                                                       deviceless                      no_connection_id
>     …
>          slow_xtal                           1       1        0        32768       0          0     50000      Y   deviceless                      no_connection_id
>             slow_osc                         1       1        0        32768       0          0     50000      Y      deviceless                      no_connection_id
>                td_slck                       2       2        0        32768       0          0     50000      Y         fffffea8.rtc                    no_connection_id
>                                                                                                                          fffffe20.rtc                    no_connection_id
>                                                                                                                          deviceless                      no_connection_id
> 
>  arch/arm/boot/dts/microchip/sam9x60.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/microchip/sam9x60.dtsi b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> index 291540e5d81e..d077afd5024d 100644
> --- a/arch/arm/boot/dts/microchip/sam9x60.dtsi
> +++ b/arch/arm/boot/dts/microchip/sam9x60.dtsi
> @@ -1312,7 +1312,7 @@ rtt: rtc@fffffe20 {
>  				compatible = "microchip,sam9x60-rtt", "atmel,at91sam9260-rtt";
>  				reg = <0xfffffe20 0x20>;
>  				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
> -				clocks = <&clk32k 0>;
> +				clocks = <&clk32k 1>;
>  			};
>  
>  			pit: timer@fffffe40 {
> @@ -1338,7 +1338,7 @@ rtc: rtc@fffffea8 {
>  				compatible = "microchip,sam9x60-rtc", "atmel,at91sam9x5-rtc";
>  				reg = <0xfffffea8 0x100>;
>  				interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
> -				clocks = <&clk32k 0>;
> +				clocks = <&clk32k 1>;
>  			};
>  
>  			watchdog: watchdog@ffffff80 {
> 
> base-commit: 47ac09b91befbb6a235ab620c32af719f8208399
> -- 
> 2.39.2
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

