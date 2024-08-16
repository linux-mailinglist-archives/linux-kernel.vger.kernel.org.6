Return-Path: <linux-kernel+bounces-289609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5ABF954827
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C59F284AC8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B101A01BF;
	Fri, 16 Aug 2024 11:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t3b428J7"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E257254BD4
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723808418; cv=none; b=FFQ8Tsn+Z4aJ+LOqp7Est8XRUa/cgagrboKJs43N3/Ujv0i7O442S8x4Lm8FDdhAKeMM22J1c0Q/n6/tMtQeg/oeTDo/PJyKvk3mz5O73Gpu4TJOuqxUstCe3UI6sXq4R3rf5QpV1/9JQ5KmI2l5bYYO9KNxM5EEbCrWeACYbhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723808418; c=relaxed/simple;
	bh=gWSWXupF8qbhNBhPCMEWh0SCBnROGwWuZr6WAsFBu1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KjXKXKfTgDSFxYbpsuTVmY1x3g4cJqG3BLDdTlfhc6ETq0nYawuInURBWRLtZOV0GTmdFFq9ko00qY7vMU+FYeOH2MFbzcqu+l0YMxJu02RerituN++rgQXweskO8ywziM7gkPDM7b/ieh2TPK6u/EBGXvIipDyukf2m2JKVGas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t3b428J7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso18871275e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 04:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723808415; x=1724413215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q79J3wtYEmpzRYRYYxMWeIZD6zPAB3a4xO+VLbVzfCY=;
        b=t3b428J7DJevzCUCMLthnHEyaTa5S0/T0aGNmiia1ayGOY6vx8uL3u1zWjCwcNC4Iq
         Cw2miCMtHn+HGxMcyzhdOXU1qJtuee53oPxM02ucI4Sj+r755+LlyCczuoQ6b/WN5oJz
         IZqTt7DMuc/PM3Gw9n/wpiRBwSRuiT8e25GtqvVqCMcQKuXAbxMxO0xm17dy8eaDSnxB
         NoUx/J7h16DR+d/mcxSjyz1Wa8WO3fkdpfvK/InTNqaotXvmq4xIgB0NjE3cJjp84gAE
         JZTBGw/8qeOL8Rtv+IsGWekr1pZROPS/jcrCHpXYcyTZ5fUDJ2U36rTDyH31Nv64PDs0
         IQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723808415; x=1724413215;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q79J3wtYEmpzRYRYYxMWeIZD6zPAB3a4xO+VLbVzfCY=;
        b=jshOmXffzQfweBw2IvsGFXtwHotWS+dmp3fvyq3VpMmXeHIp5q1jV71RUTjZa+f5+0
         rOtmI+kceeylZ2gtplNjpTmQrNXRzsLpzHcySKulAEQ/LNPXMB8gCGdagV2YS9Mk3+gI
         1bJLcEadUX5N6tZBvM5KSUdiLttYzB8gEkYhs+d8r4Y99A9fXlIqBw7FdHteQRo3RuHd
         X/MZHt9OQS9ANTiREYk1PwAAmRV/iDLatQYoI64QdontAaIyR4ZqPrD/rVcI8LUwadZs
         txzkohcP24qbmsduQWtpVIjaLBIwfEO16COS3ROii3YnnFj+Dk8jsInvf0Yj2Zyr8h5A
         +i0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZBWBXU7tLuxlCeUimAiCBpMK697AnVm0xYhQJgvAdU47w/ho8PNqfb91sBjzTZX4IsTQKbnm8HasWTtWVTHckNW8ABgd3hZjQQw/l
X-Gm-Message-State: AOJu0YyYyZPD+HyoePLDqo+GX9/KvvEipuDkPcK24GGkqc1zm7MaAIuB
	8smcZUeK02AN9hjqO81ip6cA2keGZOfUPShQP52leWXpum8BMzU0seoYMrNIeUg=
X-Google-Smtp-Source: AGHT+IGYxbX58YT33BLeLe7F4PoGo9PsEnINz7wZt46kqnS8JZ/+w5JuqR7qPtfenZGo7q3WWFUHkg==
X-Received: by 2002:a05:600c:1d94:b0:428:15b0:c8dd with SMTP id 5b1f17b1804b1-429ed7b78cemr26073325e9.20.1723808414930;
        Fri, 16 Aug 2024 04:40:14 -0700 (PDT)
Received: from [192.168.220.175] (143.red-88-28-5.dynamicip.rima-tde.net. [88.28.5.143])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429eeadfafbsm16189825e9.47.2024.08.16.04.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Aug 2024 04:40:14 -0700 (PDT)
Message-ID: <a9ccd0cd-82ee-4e31-9815-f8f3871b30c8@linaro.org>
Date: Fri, 16 Aug 2024 13:40:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MIPS: cevt-r4k: Don't call get_c0_compare_int if timer
 irq is installed
To: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 Serge Semin <fancer.lancer@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
References: <20240813-get_c0_compare_int-v1-1-a0a1b007d736@flygoat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240813-get_c0_compare_int-v1-1-a0a1b007d736@flygoat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jiaxun,

+Daniel/Thomas for CLOCKEVENTS

On 13/8/24 11:59, Jiaxun Yang wrote:
> This avoids warning:
> 
> [    0.118053] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:283
> 
> Caused by get_c0_compare_int on secondary CPU.
> 
> We also skipped saving IRQ number to struct clock_event_device *cd as
> it's never used by clockevent core, as per comments it's only meant
> for "non CPU local devices".
> 
> Reported-by: Serge Semin <fancer.lancer@gmail.com>
> Closes: https://lore.kernel.org/linux-mips/6szkkqxpsw26zajwysdrwplpjvhl5abpnmxgu2xuj3dkzjnvsf@4daqrz4mf44k/
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>   arch/mips/kernel/cevt-r4k.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
> index 368e8475870f..5f6e9e2ebbdb 100644
> --- a/arch/mips/kernel/cevt-r4k.c
> +++ b/arch/mips/kernel/cevt-r4k.c
> @@ -303,13 +303,6 @@ int r4k_clockevent_init(void)
>   	if (!c0_compare_int_usable())
>   		return -ENXIO;
>   
> -	/*
> -	 * With vectored interrupts things are getting platform specific.
> -	 * get_c0_compare_int is a hook to allow a platform to return the
> -	 * interrupt number of its liking.
> -	 */
> -	irq = get_c0_compare_int();
> -
>   	cd = &per_cpu(mips_clockevent_device, cpu);
>   
>   	cd->name		= "MIPS";
> @@ -320,7 +313,6 @@ int r4k_clockevent_init(void)
>   	min_delta		= calculate_min_delta();
>   
>   	cd->rating		= 300;
> -	cd->irq			= irq;

What should be the unset value is not clear, clock_event_device::irq
is an int, described in <linux/clockchips.h> as:

   @irq:          IRQ number (only for non CPU local devices)

Most arch clocks set irq > 0 or don't set it.

Core code / drivers check for irq != -1, irq != 0 or irq >= 0:

kernel/time/tick-common.c-295-  if (newdev->irq >= 0 && 
!irq_can_set_affinity(newdev->irq))
kernel/time/tick-common.c-296-          return false;
drivers/clocksource/exynos_mct.c-479-           if (evt->irq == -1)
drivers/clocksource/exynos_mct.c-480-                   return -EIO;
drivers/clocksource/timer-ti-dm-systimer.c-562- if (!dev->irq)
drivers/clocksource/timer-ti-dm-systimer.c-563-         return -ENXIO;

Using -1 for unset value seems reasonable, but since most don't set
this default value, I guess that's OK to do the same.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   	cd->cpumask		= cpumask_of(cpu);
>   	cd->set_next_event	= mips_next_event;
>   	cd->event_handler	= mips_event_handler;
> @@ -332,6 +324,13 @@ int r4k_clockevent_init(void)
>   
>   	cp0_timer_irq_installed = 1;
>   
> +	/*
> +	 * With vectored interrupts things are getting platform specific.
> +	 * get_c0_compare_int is a hook to allow a platform to return the
> +	 * interrupt number of its liking.
> +	 */
> +	irq = get_c0_compare_int();
> +
>   	if (request_irq(irq, c0_compare_interrupt, flags, "timer",
>   			c0_compare_interrupt))
>   		pr_err("Failed to request irq %d (timer)\n", irq);
> 
> ---
> base-commit: 9e6869691724b12e1f43655eeedc35fade38120c
> change-id: 20240812-get_c0_compare_int-66935853a308
> 
> Best regards,


