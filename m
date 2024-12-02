Return-Path: <linux-kernel+bounces-427049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C739DFB9A
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAF3FB225DB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 08:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988451F9A91;
	Mon,  2 Dec 2024 08:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="i/N1I/nT"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EF6F9E6
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 08:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733126720; cv=none; b=EhMDRZHZJPyskSf8Hrpa8tXkXy+2P0OTdBLe/rfqvo1VB7QyM8Nf+9S7v01UuYpGlL6WPc2rwFBeNW8ubQM9RMwGozF5atZvthRZSVp+chYGoqO8WKAffD1TtF6KuNR22k4tgZTjq10ceaNfPkt4JVCcLX8wIVytNUhaSR5KjXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733126720; c=relaxed/simple;
	bh=HKnyssjRU3BrgFikDQPjora2tKd4rTt41GufQ8z8wyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mkUEyP/D7XvPD+tUOAtiSGKXPzwkM6fRqCCJ7NY4NYEegHxb+a+9e2QeaDWzxVwF0GfMWk4X+N6UMTD7dvZcS5WWlrf5Igypq5yyTOrH5Jq9sJlUTcAPh5fSU6YxjGwAvg/cRZ8LtRjj9756xV6nmafi2TwsIf13s0MztSJlwiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=i/N1I/nT; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ffc1009a06so54770751fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 00:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1733126716; x=1733731516; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nt9G7KmSxpaO4MDaESLiYEAxzFatOQtvUL6niYdnua4=;
        b=i/N1I/nT4U7EImYRw6fzT7jKfS5sfgfbnyHIjEix59rAs6HdNaVwyABrMxvjM8S7bc
         wT22RptllCJVy+d/6FJL9NvwRpo5Q9g/Qco5jjATz31PXz3yKSlDO68YBtzId8zvgtY8
         XrNJVOr2ovUY1xVCiLwLXeH1LQflLJzYuVItxXoY1j2vcPE0Eci4QHBZc283vShKHQ5Y
         0I0eJ4F0OS1BoR7NnyX6xO3ZBAxFJOkxWGwwWAST5C7o95xRiizLSKvjy3fnIFKFFRtK
         SiIsZDirf7AJrBVrHK1yVWHkJaXcCL3FFVckYnE3Y63VF8pklp/Gt2UfX5kwyfHvpY6k
         /Asg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733126716; x=1733731516;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nt9G7KmSxpaO4MDaESLiYEAxzFatOQtvUL6niYdnua4=;
        b=ePWBOCuH5C0EmshUGDIQs0h89wCXTlZ0Krqa8wYY7XLU0oWp1cQVztPOJ787Tuu3mA
         Nbfst/HKv4My6G4Nxf5uBZsOvEDx28OeHrVQYGCiC2kGmX/GWB3dApGPuNcQtZcUrGSX
         Rkk0Yx+sRHXlqu1FG9BiJvPtPsMqUATspm+l9Sj566lLSFtSyeuONjOLmHKgO/B4DuRE
         5CQFW487UWQAE03nEVO9KB50L13RoUrCO0IEJVSOq7j3k9VhFUeCVTMXMK4LQTQcvfEg
         mmCQStDnsFUTjpEORJQOUonX3/AitrMfmnVeS+QLnQcPJVQsxXd+gVk+Cvlo0FcV4Xwg
         UroA==
X-Forwarded-Encrypted: i=1; AJvYcCUjr0zbTR7q3G2WhzjGSrvTOs/LWm2LZyA2N0u8aT1iG7Nd3Iqony1NPvA4+Sli2DpHhsUHn84DmiweYzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXnhYmaBRVqK/grDkryTh33lIAwEs3vVt/dztSLR5f+ThEzkL3
	d5j2hSskvFadQTC8VtpUcNBn7BzXqGlOrNlF6l4//dJOJJts44kCfOe54BfFu/E=
X-Gm-Gg: ASbGnct/gxZfo/0fyyV5k6Bidax1ObLd73EjkUZ7cLednT3H4qibtuMcLuC9NfzVnwt
	SwG/nafQ/Pgx4/NY+U65V6AxUHf+/5ajj+pxYzrec/RrR7DkpSCePbw9EYHU3VZmNN3jmKXNLsO
	F1zKOfJw00Efp/xVgML13/H91gzmxoKpe4KJzVOkX92pQHIMFI+f2rtKrVI19Sw6keVefOMNxGz
	XePT3+74TC6kzHsPfrbqOBZ5+wN1l2ib4Fpne3Gp0M+re9NnsN73Tsytg==
X-Google-Smtp-Source: AGHT+IFUfZ5e2F1fAB4ao3/fokEu8MgM9xJJBXI2ftiU7+MWrxZpJdyaH0ok5YzBfo7DCvJTbQZ7iA==
X-Received: by 2002:a2e:be25:0:b0:2ff:96dc:af29 with SMTP id 38308e7fff4ca-2ffd5ffe050mr116068701fa.10.1733126715444;
        Mon, 02 Dec 2024 00:05:15 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f327casm144987935e9.27.2024.12.02.00.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Dec 2024 00:05:14 -0800 (PST)
Message-ID: <34a5b77b-e732-4393-a469-d9c719afa879@tuxon.dev>
Date: Mon, 2 Dec 2024 10:05:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: at91: pm: change BU Power Switch to automatic mode
Content-Language: en-US
To: nicolas.ferre@microchip.com,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Cristian Birsan <cristian.birsan@microchip.com>
References: <20241125165648.509162-1-nicolas.ferre@microchip.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20241125165648.509162-1-nicolas.ferre@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Nicolas,

On 25.11.2024 18:56, nicolas.ferre@microchip.com wrote:
> From: Nicolas Ferre <nicolas.ferre@microchip.com>
> 
> Change how the Backup Unit Power is configured and force the
> automatic/hardware mode.
> This change eliminates the need for software management of the power
> switch, ensuring it transitions to the backup power source before
> entering low power modes.
> 
> This is done in the only locaton where this swich was configured. It's

s/locaton/location

> usually done in the bootloader.
> 
> Previously, the loss of the VDDANA (or VDDIN33) power source was not
> automatically compensated by an alternative power source. This resulted
> in the loss of Backup Unit content, including Backup Self-refresh low
> power mode information, OTP emulation configuration, and boot
> configuration, for instance.

Should we add a fixes for this?

> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> ---
>  arch/arm/mach-at91/pm.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index b9b995f8a36e..05a1547642b6 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -598,7 +598,21 @@ static int at91_suspend_finish(unsigned long val)
>  	return 0;
>  }
>  
> -static void at91_pm_switch_ba_to_vbat(void)
> +/**
> + * at91_pm_switch_ba_to_auto() - Configure Backup Unit Power Switch
> + * to automatic/hardware mode.
> + *
> + * The Backup Unit Power Switch can be managed either by software or hardware.
> + * Enabling hardware mode allows the automatic transition of power between
> + * VDDANA (or VDDIN33) and VDDBU (or VBAT, respectively), based on the
> + * availability of these power sources.
> + *
> + * If the Backup Unit Power Switch is already in automatic mode, no action is
> + * required. If it is in software-controlled mode, it is switched to automatic
> + * mode to enhance safety and eliminate the need for toggling between power
> + * sources.
> + */
> +static void at91_pm_switch_ba_to_auto(void)
>  {
>  	unsigned int offset = offsetof(struct at91_pm_sfrbu_regs, pswbu);
>  	unsigned int val;
> @@ -609,24 +623,19 @@ static void at91_pm_switch_ba_to_vbat(void)
>  
>  	val = readl(soc_pm.data.sfrbu + offset);
>  
> -	/* Already on VBAT. */
> -	if (!(val & soc_pm.sfrbu_regs.pswbu.state))
> +	/* Already on auto/hardware. */
> +	if (!(val & soc_pm.sfrbu_regs.pswbu.ctrl))
>  		return;
>  
> -	val &= ~soc_pm.sfrbu_regs.pswbu.softsw;

It seems that softsw and state members of at91_pm_sfrbu_regs.pswbu along
with their initialization could be dropped. What do you think?

I can do it while applying, if any.

Thank you,
Claudiu


> -	val |= soc_pm.sfrbu_regs.pswbu.key | soc_pm.sfrbu_regs.pswbu.ctrl;
> +	val &= ~soc_pm.sfrbu_regs.pswbu.ctrl;
> +	val |= soc_pm.sfrbu_regs.pswbu.key;
>  	writel(val, soc_pm.data.sfrbu + offset);
> -
> -	/* Wait for update. */
> -	val = readl(soc_pm.data.sfrbu + offset);
> -	while (val & soc_pm.sfrbu_regs.pswbu.state)
> -		val = readl(soc_pm.data.sfrbu + offset);
>  }
>  
>  static void at91_pm_suspend(suspend_state_t state)
>  {
>  	if (soc_pm.data.mode == AT91_PM_BACKUP) {
> -		at91_pm_switch_ba_to_vbat();
> +		at91_pm_switch_ba_to_auto();
>  
>  		cpu_suspend(0, at91_suspend_finish);
>  

