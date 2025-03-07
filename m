Return-Path: <linux-kernel+bounces-550631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33477A5623A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 09:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2473E3B4E6E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 08:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319EF1A83F5;
	Fri,  7 Mar 2025 08:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZwocC4Tu"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605E428E8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 08:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741335019; cv=none; b=dy+kjHYkSs84ziP8cFEg8aZCSYDyam/Z+9kIEAm1Fgv/C2DVnH3A1KQU9Rq6HmKye7P33U1HOg2gu377l/O7mvs7j3suVQoB+7D3bGu/Him0G1NPy5Nae+YZO/3fpdjzlWNHvbLu6yx0D7mirNzkYyDrEawnNP/T1dtJlli6ooA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741335019; c=relaxed/simple;
	bh=ZJ5bYaA/NoBi8D2i8Cmzl1QUiyLAuiC8Rc8/AQdXd24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D6pAbgZkpPnHm9rR4pj4zX8rZOeJeD4Tu58tq/xdAiauHGroLq+s93ZmuJUtDCTIsIVeCb5ru0MB5ACzv69Xg4TWWSnQeeubzOcukN02G72OxNZAa9QSnr02iZTMGCYbEyl0cnObUWHEV0W/EzhcP9XTrgRuD3UfHMwPUAOB18k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZwocC4Tu; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4393dc02b78so9311995e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 00:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741335015; x=1741939815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cDvCkrrez/D/1PjCxRLX9NGT1wuUhu19Wz2Qsyw7FtE=;
        b=ZwocC4TuoUFOx0wulym1Bqpai6zHBkRqNs9q7wq9Wiuj9TdmWZmK+/eviBHRb49lbY
         i3K+hxr/3AedArHgx5+GoB7WjMzxNnKypvNzVG3uFWn+N+LF8JpGSAWsfsn61dHjUewc
         /HZzl1U/PsLvD5RgvmKNoC3wkBNIJqKTHSic1qMl8mSuYfut6o5RFwxcZzoAd1YeDnv8
         eFd8Ma3jv75MFKrOldPuGVQxXfF7iZf7ry9SQ9ZqZkRzUEiKETWAhlHpesIZ76iR+Z+1
         zcE094O/AWF32LUZnVoNCsCTMoyjGuya9VHceqpzETTxw0omAcQU9mOSTeK2yN/PgwnM
         9Sdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741335015; x=1741939815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cDvCkrrez/D/1PjCxRLX9NGT1wuUhu19Wz2Qsyw7FtE=;
        b=jFRc34zL6Rglcd+FLWdnQUE9fxAQYPI+l+WE27K9D2RB2h14++JkAQIu2Gs95tSntD
         gBMaQ9uVOuIksXl8qhqWN3q14MH/gmfP0nxSWVWwrlGhubEyNPwMct2JCr8ydWWxxKiO
         bKJHBWy7Kd1AHwHVsOhTukh7ylzRPZLx0fRyurX0QYURvkaHdPR1UO66J90B2eH1xY+N
         ZY8ziPqwsBZKFMt0hE8nTCN0Uus7IzO1N10Dufs1LDcxrCdSUi7EWqcgmIXfm8Y/H7Zw
         8GxPwkclQ0rrB5Dzg6hN3f3BZ/M45kxwtHLGtvAqobW5BcYUq7LaHkkLKD6Wr2xkWvlI
         hh6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXnlJQ6Kf4kanCdsmIQC+rXRWyPm9SlmtFwEevxWgdn5JJGhDzKWyXwkUqN5SCxPSObpYftBk/ajmRa/mM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6W+J9bXaCRp0++wtYrTI2f3/0mjYHkv4iKpb8TlYM07lqQHF4
	l/96gxUHZp/YFZKLe+N4erC+wsnFPDwOtD/N5n2CF+oRGWpQAz+dW4aJcIxb+KY=
X-Gm-Gg: ASbGnctu3yh0fpXef4Vt/A6mwknWNLt3xveqW6O2W1NO+E8wLAXynZojcoN61VqJmZT
	AQDx1m5x+H8J/o3k7GMxUBv1yRnMZYgfBH9kN+NqNEmXZTpW5gZIn7TNofEt30nk5rapbBz2yvP
	LAh+7eIOdfsWSAlNmKX6gMRTRUdrsNg4I1aAljfzHdRoXQ7goXCMGoW69yKX2zoy4xPdZMxibpS
	kUZqj8qlNiIOR7r2CaEpPSH76w41jovxk4oy2P3n3NGTQLDEv5hGNPzHHTzOHMB1ILtxV4Sq85J
	GgF5Ab2Ry/k+jWdArP8R8N7PzcXxacloZ8rxhxCMRTgxCB/SYm2b4SLpE1e81zWsIA7j2iPytP7
	0EKYKDoqs
X-Google-Smtp-Source: AGHT+IF2hZ7bMOZmdu0gEqijL7mMc3TLVZjUbjbd+oz8H6jeHEJgcVhpCkiZKPH/iwSdxyxIt73Mnw==
X-Received: by 2002:a05:600c:4f46:b0:439:9192:f088 with SMTP id 5b1f17b1804b1-43c5a6008admr15079245e9.8.1741335015444;
        Fri, 07 Mar 2025 00:10:15 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3912c0e2b6asm4641644f8f.66.2025.03.07.00.10.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Mar 2025 00:10:15 -0800 (PST)
Message-ID: <198fe423-e797-4a82-a509-ee06ca05466e@linaro.org>
Date: Fri, 7 Mar 2025 09:10:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource: timer-sp804: Fix read_current_timer() issue
 when clock source is not registered
To: stephen eta zhou <stephen.eta.zhou@outlook.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <BYAPR12MB3205C9C87EB560CA0CC4984BD5FB2@BYAPR12MB3205.namprd12.prod.outlook.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <BYAPR12MB3205C9C87EB560CA0CC4984BD5FB2@BYAPR12MB3205.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Hi Stephen,

thanks for the proposed fix

On 21/02/2025 04:46, stephen eta zhou wrote:
> Hi daniel
> 
> While debugging on the vexpress-v2p-ca9 platform, I discovered that the read_current_timer API wasn't functioning correctly. The issue was that the SP804 driver lacked ARM32 support and did not register read_current_timer. To add ARM32 compatibility, I’ve submitted this patch. Without it, using SP804 as the timer on ARM32 causes issues with boot_init_stack_canary when inserting the canary value into the interrupt stack, and also affects entropy generation and collection, resulting in incorrect rdseed values.

It is better to put that information in the changelog and provide a 
fixed format of the patch description.

>  From 9dd9b5bd7ab1638990176f7171417c83ddb7a221 Mon Sep 17 00:00:00 2001
> From: Stephen Eta Zhou <stephen.eta.zhou@outlook.com>
> Date: Fri, 21 Feb 2025 11:15:40 +0800
> Subject: [PATCH] clocksource: timer-sp804: Fix read_current_timer() issue when
>   clock source is not registered
> 
> Fix read_current_timer() on ARM32 by adding support in the SP804 driver.
> 
> Signed-off-by: Stephen Eta Zhou <stephen.eta.zhou@outlook.com>
> ---
>   drivers/clocksource/timer-sp804.c | 36 +++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
> index cd1916c05325..b98a14d24874 100644
> --- a/drivers/clocksource/timer-sp804.c
> +++ b/drivers/clocksource/timer-sp804.c
> @@ -21,6 +21,11 @@
>   #include <linux/of_irq.h>
>   #include <linux/sched_clock.h>
>   
> +#ifdef CONFIG_ARM
> +#include <linux/delay.h>
> +#include "timer-of.h"
> +#endif
> +
>   #include "timer-sp.h"
>   
>   /* Hisilicon 64-bit timer(a variant of ARM SP804) */
> @@ -59,6 +64,10 @@ static struct sp804_timer hisi_sp804_timer __initdata = {
>   
>   static struct sp804_clkevt sp804_clkevt[NR_TIMERS];
>   
> +#ifdef CONFIG_ARM
> +	struct delay_timer delay;

static ...

> +#endif
> +
 >
>   static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
>   {
>   	int err;
> @@ -102,6 +111,13 @@ static u64 notrace sp804_read(void)
>   	return ~readl_relaxed(sched_clkevt->value);
>   }
>   
> +#ifdef CONFIG_ARM
> +static unsigned long sp804_read_delay_timer_read(void)
> +{
> +	return sp804_read();
> +}
> +#endif

Group this function with the global delay variable above.

>   static int __init sp804_clocksource_and_sched_clock_init(void __iomem *base,
>   							 const char *name,
>   							 struct clk *clk,
> @@ -259,6 +275,10 @@ static int __init sp804_of_init(struct device_node *np, struct sp804_timer *time
>   	struct clk *clk1, *clk2;
>   	const char *name = of_get_property(np, "compatible", NULL);
>   
> +#ifdef CONFIG_ARM
> +	struct timer_of to = { .flags = TIMER_OF_CLOCK };
> +#endif
> +
>   	if (initialized) {
>   		pr_debug("%pOF: skipping further SP804 timer device\n", np);
>   		return 0;
> @@ -318,6 +338,22 @@ static int __init sp804_of_init(struct device_node *np, struct sp804_timer *time
>   		if (ret)
>   			goto err;
>   	}
> +
> +#ifdef CONFIG_ARM
> +	ret = timer_of_init(np, &to);

The clock is already retrieved from the initialization code before

> +	if (ret) {
> +		pr_err("Failed to initialize the Timer device tree: %d\n", ret);
> +		return ret;
> +	}
> +
> +	delay.read_current_timer = sp804_read_delay_timer_read;
> +	delay.freq = timer_of_rate(&to);
> +	if (delay.freq <= 0)
> +		pr_warn("Failed to obtain the freq of the clock source: %d\n", ret);
> +
> +	register_current_timer_delay(&delay);
> +#endif>   	initialized = true;
>   
>   	return 0;


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

