Return-Path: <linux-kernel+bounces-291674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC108956565
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 10:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3389BB21A25
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 08:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7473E15AADA;
	Mon, 19 Aug 2024 08:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o0aUTpV0"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10EC154C0C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724055524; cv=none; b=mQoGOWg2UMSxU22IRaMYwx5EQmAf6Gpr4KaAK9T53miGHizhYPuxdwD3pwCSc6oQ52tVSPPDAYfPvK1w5XitnS93VOucIxY+/RclMdPxw9c8plBW2RUwN0vKeOb+1xmVqkMoPgy1hUUgFMhluCs1JjZ6KJytlfS7sit+L/zjkdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724055524; c=relaxed/simple;
	bh=6KThASgOPSP5/5shA5NtMrTyfMzOw5FtxoFrLmznwMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QeEgP8cH301TiHQ2IH+rsj5lQZUKf5xXxLk8unmmNSn/8mbSVwNfeVwEuNzrbEwYE9QN9FYQbQl4CvU6dKlLPdrGLmsS7njkPQ031skMI9fF0A4/v0G3cbBvJ8qUMah30a7ROhLg2v502jKDUvArLimBbks/1HNkCOEKWGpyH30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o0aUTpV0; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-428085a3ad1so35311305e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 01:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724055521; x=1724660321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5vefPSrP1zHUD7xG6qFqJR+hO86OiYjqBlL9pRZIjik=;
        b=o0aUTpV0zzUuRaleCnzmKzygo1npEcilHNguzIyPh/1zlRd8j4N2OGwvw6VsOjPzmW
         z8ChNdv9CdlpIaTVVXyCh/X+zkFrRYVaXgk+5zkYkyotWTnToksQcdnWjoiykddP7iqO
         z1YngLF2xEWEz+2UnX55hBUjKxbNkIxG88EuHl/TPgs7/4opGbukpIpGpIuM+rl9FAwx
         ljiwEEisDlEMuZttq7pJEsQgXvZxAD+C9CwmQyEglcQaQd1QZTYudNsUmrt3OlEghinB
         734qTFWiMJIdQjZwairpWlF97qPKyUY3g9yKA/y3t3ygB+pxn1tqwSqJNUN3a7VriYKN
         EA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724055521; x=1724660321;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5vefPSrP1zHUD7xG6qFqJR+hO86OiYjqBlL9pRZIjik=;
        b=mxUnqRaiIQX48Vh2737ou58etWihsKn8ZUQAeGAGQpjTlmySciRBIQxOwLMLkkiGC+
         OITsIjGehqmDUYGQWgJUX5kCYZnAKFk+hp/zmOkXoBEF18AdNycTQwdBASmj6xKxe2BO
         jV87ERRIDq5qlmIuAn0L2jdd2BcX4B1W12UYXrbqr7x+0hPUq3te2nJvsA10AYBTwQfu
         x4UVUTWKS0x4Rtcs2HUH859FEc7rkliQSbwkcm1YLq88YOw5ZioBUB8ojZ5FQA9SOzQE
         rdoLIt7QJGprA89XkRdkS42zrgr2vXx5Tb6AyvmV60hFcLPAsnCUfI73Rbx8PqaItX/o
         zMAw==
X-Forwarded-Encrypted: i=1; AJvYcCV96Mv47Sy1qylOKglN4FuhbMPHwE1E0qX5VpOSDG9pxMeF7Xmc/yEap61x1FizeYLZTJS11cqNZVwJH3t9tlfWq67q3d5daxYlDVxf
X-Gm-Message-State: AOJu0YzgRfWKiybA1Ygj3zg/xTfxL/YlryQW29FUlWJd/0fDmo174U5T
	8IeINIK4I0i4aI5FRzTqNHB5B7ehpPxp5N90A5YC2r3Gg8pFsT0vhYcmNg4UsHJ7VB99vk8MSZs
	f
X-Google-Smtp-Source: AGHT+IFEji2/+WW2anEgUuhK6Qr8mREdKovvPpo1aJZD2a3UhGCVqnhB5E0FpTt50eT46g5kGnggtQ==
X-Received: by 2002:a05:6000:1b01:b0:371:8f19:bff0 with SMTP id ffacd0b85a97d-3719445235amr5260377f8f.20.1724055520608;
        Mon, 19 Aug 2024 01:18:40 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3718983a311sm9838156f8f.23.2024.08.19.01.18.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 01:18:40 -0700 (PDT)
Message-ID: <51e3c38c-42a3-49b6-ab19-50f4f37336aa@linaro.org>
Date: Mon, 19 Aug 2024 10:18:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clocksource/timer-of: Add missing casts to percpu address
 space
To: Uros Bizjak <ubizjak@gmail.com>, linux-kernel@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>
References: <20240819061351.14782-1-ubizjak@gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240819061351.14782-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/08/2024 08:13, Uros Bizjak wrote:
> Add missing casts to percpu address space to fix
> 
> timer-of.c:29:46: warning: incorrect type in argument 2 (different address spaces)
> timer-of.c:29:46:    expected void [noderef] __percpu *
> timer-of.c:29:46:    got struct clock_event_device *clkevt
> timer-of.c:74:51: warning: incorrect type in argument 4 (different address spaces)
> timer-of.c:74:51:    expected void [noderef] __percpu *percpu_dev_id
> timer-of.c:74:51:    got struct clock_event_device *clkevt
> 
> sparse warnings.
> 
> Found by GCC's named address space checks.
> 
> There were no changes in the resulting object file.

The warning may go away but the problem sparse is spotting is still there.

IMO sparse is totally right and the code related to the percpu is 
broken. It seems the .percpu flag is never used in the drivers and we 
should be able to just remove the percpu related code in timer-of.c

> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>   drivers/clocksource/timer-of.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
> index c3f54d9912be..7e0375a804ff 100644
> --- a/drivers/clocksource/timer-of.c
> +++ b/drivers/clocksource/timer-of.c
> @@ -26,7 +26,8 @@ static __init void timer_of_irq_exit(struct of_timer_irq *of_irq)
>   	struct clock_event_device *clkevt = &to->clkevt;
>   
>   	if (of_irq->percpu)
> -		free_percpu_irq(of_irq->irq, clkevt);
> +		free_percpu_irq(of_irq->irq,
> +				(void __percpu *)(unsigned long)clkevt);
>   	else
>   		free_irq(of_irq->irq, clkevt);
>   }
> @@ -70,8 +71,8 @@ static __init int timer_of_irq_init(struct device_node *np,
>   	}
>   
>   	ret = of_irq->percpu ?
> -		request_percpu_irq(of_irq->irq, of_irq->handler,
> -				   np->full_name, clkevt) :
> +		request_percpu_irq(of_irq->irq, of_irq->handler, np->full_name,
> +				   (void __percpu *)(unsigned long)clkevt) :
>   		request_irq(of_irq->irq, of_irq->handler,
>   			    of_irq->flags ? of_irq->flags : IRQF_TIMER,
>   			    np->full_name, clkevt);


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

