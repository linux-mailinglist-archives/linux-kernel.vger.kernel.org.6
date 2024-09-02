Return-Path: <linux-kernel+bounces-311502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6BF9689EB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 16:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DA381F24981
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32197210190;
	Mon,  2 Sep 2024 14:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YLFIruWP"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B630319C55D
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 14:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725287294; cv=none; b=gRL4zZFNJ/OTcJahobEwtYhybPSNAHujPZmi2swZ/qpYme7tdSXr/j1rRv9GvNagVFjsKElHP1WXjwujlM1uPFQHYIsq/YaQxwTio6v4aV2IbgDmTIbYXpXMuB6tjcbRH6udsBh0sFXFw8wVobJv5TOvONb4441PpwAro3CdeHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725287294; c=relaxed/simple;
	bh=v9jLjjvwoKPM7C9aTg0cuvm7/8/aoh5fXGwVeHKRXMY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hxM6YkVzkj52XD7KSm/1l80o6YNsEFXKEX7OfdASM/alKG/f/+WjolITjIs+5vuCpw7NiV2NZAGjpQ1A8LAcxB6D27GfTH04PjyKU61AI8eEiczCzU5jvyPa3xL2XNBka171D94Ilq4/TPptCSbFkJ1cTx/rGSwpO0pUlvRYUYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YLFIruWP; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2948360003;
	Mon,  2 Sep 2024 14:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725287290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WPsXU8s4xSlfCi2ei8mMQVrT3eZ7dvgcLn4ER60DDQk=;
	b=YLFIruWPdvEyIIaxTPWbqmBqIi+ZsD11uCkcQLfBui6zK8jeFyxE0XKtBsZvbBZKJyAQGo
	GE5QqyECOCOkzGpk5fkooLny1ftx/vrNna/6PvkBuxO2D7gByknZ9eLxrMwUCuRVHZ3m1P
	se5KgLavzvupZPWlDgkmi+JNZ4j7TFyJO9vgNGuHEyyA7rRH867bXxAhFZqS6PSLg5Vzjz
	75VBITWhqWe5MBLRkivTyDUE9eA11No4ZoseM53qpLmgjAwDM4B7GxuryHs2inz5VwR8qk
	qPC02BWVidXTl8/PXVNq7sy/ZPbmHhz42pPkMo7ynD4a3Xu8tid8HvjvUpzmog==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Andrew Davis <afd@ti.com>, Andre Przywara <andre.przywara@arm.com>,
 Russell King <linux@armlinux.org.uk>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Andrew Lunn
 <andrew@lunn.ch>, Sebastian
 Hesselbarth <sebastian.hesselbarth@gmail.com>, Daniel Mack
 <daniel@zonque.org>, Haojian
 Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, Andrew Davis <afd@ti.com>
Subject: Re: [PATCH v2 3/7] ARM: orion5x: Switch to new sys-off handler API
In-Reply-To: <20240729123538.175704-4-afd@ti.com>
References: <20240729123538.175704-1-afd@ti.com>
 <20240729123538.175704-4-afd@ti.com>
Date: Mon, 02 Sep 2024 16:28:08 +0200
Message-ID: <87mskqf7uv.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com

Hi Andrew,

> Kernel now supports chained power-off handlers. Use
> register_platform_power_off() that registers a platform level power-off
> handler. Legacy pm_power_off() will be removed once all drivers and archs
> are converted to the new sys-off API.
>
> Signed-off-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Applied on mvebu/arm

Thanks,

Gregory

> ---
>  arch/arm/mach-orion5x/board-mss2.c             | 2 +-
>  arch/arm/mach-orion5x/dns323-setup.c           | 6 +++---
>  arch/arm/mach-orion5x/kurobox_pro-setup.c      | 2 +-
>  arch/arm/mach-orion5x/mv2120-setup.c           | 2 +-
>  arch/arm/mach-orion5x/net2big-setup.c          | 2 +-
>  arch/arm/mach-orion5x/terastation_pro2-setup.c | 2 +-
>  arch/arm/mach-orion5x/ts209-setup.c            | 2 +-
>  arch/arm/mach-orion5x/ts409-setup.c            | 2 +-
>  8 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/mach-orion5x/board-mss2.c b/arch/arm/mach-orion5x/board-mss2.c
> index b0f16d223adf5..9e3d69891d2f6 100644
> --- a/arch/arm/mach-orion5x/board-mss2.c
> +++ b/arch/arm/mach-orion5x/board-mss2.c
> @@ -82,5 +82,5 @@ static void mss2_power_off(void)
>  void __init mss2_init(void)
>  {
>  	/* register mss2 specific power-off method */
> -	pm_power_off = mss2_power_off;
> +	register_platform_power_off(mss2_power_off);
>  }
> diff --git a/arch/arm/mach-orion5x/dns323-setup.c b/arch/arm/mach-orion5x/dns323-setup.c
> index 062109efa0ecc..fcd38ff7ca459 100644
> --- a/arch/arm/mach-orion5x/dns323-setup.c
> +++ b/arch/arm/mach-orion5x/dns323-setup.c
> @@ -700,7 +700,7 @@ static void __init dns323_init(void)
>  		if (gpio_request(DNS323_GPIO_POWER_OFF, "POWEROFF") != 0 ||
>  		    gpio_direction_output(DNS323_GPIO_POWER_OFF, 0) != 0)
>  			pr_err("DNS-323: failed to setup power-off GPIO\n");
> -		pm_power_off = dns323a_power_off;
> +		register_platform_power_off(dns323a_power_off);
>  		break;
>  	case DNS323_REV_B1:
>  		/* 5182 built-in SATA init */
> @@ -717,7 +717,7 @@ static void __init dns323_init(void)
>  		if (gpio_request(DNS323_GPIO_POWER_OFF, "POWEROFF") != 0 ||
>  		    gpio_direction_output(DNS323_GPIO_POWER_OFF, 0) != 0)
>  			pr_err("DNS-323: failed to setup power-off GPIO\n");
> -		pm_power_off = dns323b_power_off;
> +		register_platform_power_off(dns323b_power_off);
>  		break;
>  	case DNS323_REV_C1:
>  		/* 5182 built-in SATA init */
> @@ -727,7 +727,7 @@ static void __init dns323_init(void)
>  		if (gpio_request(DNS323C_GPIO_POWER_OFF, "POWEROFF") != 0 ||
>  		    gpio_direction_output(DNS323C_GPIO_POWER_OFF, 0) != 0)
>  			pr_err("DNS-323: failed to setup power-off GPIO\n");
> -		pm_power_off = dns323c_power_off;
> +		register_platform_power_off(dns323c_power_off);
>  
>  		/* Now, -this- should theoretically be done by the sata_mv driver
>  		 * once I figure out what's going on there. Maybe the behaviour
> diff --git a/arch/arm/mach-orion5x/kurobox_pro-setup.c b/arch/arm/mach-orion5x/kurobox_pro-setup.c
> index acba066180801..339b10891808f 100644
> --- a/arch/arm/mach-orion5x/kurobox_pro-setup.c
> +++ b/arch/arm/mach-orion5x/kurobox_pro-setup.c
> @@ -373,7 +373,7 @@ static void __init kurobox_pro_init(void)
>  	i2c_register_board_info(0, &kurobox_pro_i2c_rtc, 1);
>  
>  	/* register Kurobox Pro specific power-off method */
> -	pm_power_off = kurobox_pro_power_off;
> +	register_platform_power_off(kurobox_pro_power_off);
>  }
>  
>  #ifdef CONFIG_MACH_KUROBOX_PRO
> diff --git a/arch/arm/mach-orion5x/mv2120-setup.c b/arch/arm/mach-orion5x/mv2120-setup.c
> index b7327a6128353..5b0249f109cde 100644
> --- a/arch/arm/mach-orion5x/mv2120-setup.c
> +++ b/arch/arm/mach-orion5x/mv2120-setup.c
> @@ -238,7 +238,7 @@ static void __init mv2120_init(void)
>  	if (gpio_request(MV2120_GPIO_POWER_OFF, "POWEROFF") != 0 ||
>  	    gpio_direction_output(MV2120_GPIO_POWER_OFF, 1) != 0)
>  		pr_err("mv2120: failed to setup power-off GPIO\n");
> -	pm_power_off = mv2120_power_off;
> +	register_platform_power_off(mv2120_power_off);
>  }
>  
>  /* Warning: HP uses a wrong mach-type (=526) in their bootloader */
> diff --git a/arch/arm/mach-orion5x/net2big-setup.c b/arch/arm/mach-orion5x/net2big-setup.c
> index 6ad9740b426b6..4afd9b4c71a94 100644
> --- a/arch/arm/mach-orion5x/net2big-setup.c
> +++ b/arch/arm/mach-orion5x/net2big-setup.c
> @@ -423,7 +423,7 @@ static void __init net2big_init(void)
>  
>  	if (gpio_request(NET2BIG_GPIO_POWER_OFF, "power-off") == 0 &&
>  	    gpio_direction_output(NET2BIG_GPIO_POWER_OFF, 0) == 0)
> -		pm_power_off = net2big_power_off;
> +		register_platform_power_off(net2big_power_off);
>  	else
>  		pr_err("net2big: failed to configure power-off GPIO\n");
>  
> diff --git a/arch/arm/mach-orion5x/terastation_pro2-setup.c b/arch/arm/mach-orion5x/terastation_pro2-setup.c
> index 23a5521c68336..a9f01859d1012 100644
> --- a/arch/arm/mach-orion5x/terastation_pro2-setup.c
> +++ b/arch/arm/mach-orion5x/terastation_pro2-setup.c
> @@ -349,7 +349,7 @@ static void __init tsp2_init(void)
>  	i2c_register_board_info(0, &tsp2_i2c_rtc, 1);
>  
>  	/* register Terastation Pro II specific power-off method */
> -	pm_power_off = tsp2_power_off;
> +	register_platform_power_off(tsp2_power_off);
>  }
>  
>  MACHINE_START(TERASTATION_PRO2, "Buffalo Terastation Pro II/Live")
> diff --git a/arch/arm/mach-orion5x/ts209-setup.c b/arch/arm/mach-orion5x/ts209-setup.c
> index bab8ba0e01ab9..de9092e992c56 100644
> --- a/arch/arm/mach-orion5x/ts209-setup.c
> +++ b/arch/arm/mach-orion5x/ts209-setup.c
> @@ -314,7 +314,7 @@ static void __init qnap_ts209_init(void)
>  	i2c_register_board_info(0, &qnap_ts209_i2c_rtc, 1);
>  
>  	/* register tsx09 specific power-off method */
> -	pm_power_off = qnap_tsx09_power_off;
> +	register_platform_power_off(qnap_tsx09_power_off);
>  }
>  
>  MACHINE_START(TS209, "QNAP TS-109/TS-209")
> diff --git a/arch/arm/mach-orion5x/ts409-setup.c b/arch/arm/mach-orion5x/ts409-setup.c
> index 8131982c10d97..725688aa5cba7 100644
> --- a/arch/arm/mach-orion5x/ts409-setup.c
> +++ b/arch/arm/mach-orion5x/ts409-setup.c
> @@ -312,7 +312,7 @@ static void __init qnap_ts409_init(void)
>  	platform_device_register(&ts409_leds);
>  
>  	/* register tsx09 specific power-off method */
> -	pm_power_off = qnap_tsx09_power_off;
> +	register_platform_power_off(qnap_tsx09_power_off);
>  }
>  
>  MACHINE_START(TS409, "QNAP TS-409")
> -- 
> 2.39.2

