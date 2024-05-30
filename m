Return-Path: <linux-kernel+bounces-195677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9E58D502B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 18:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0FC1F22937
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:53:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3239383A5;
	Thu, 30 May 2024 16:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBeCFjZA"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFF52E859
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717087995; cv=none; b=p7LmlicVR+Eb/V0gF0PdKk7BeSo4oeQoPyTFwKb/JANLJZFyIxFU7sGGjjoauURMGdFVc7NnCra3DQqkvQXEYrU6TOOTcvAOwsdfhY87WFl+VBiLpi5XXkF5BCJE77OdXIGep0/9fVI0P5fgLIU3jP0ohrLu71uIJ6EQc8GSHts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717087995; c=relaxed/simple;
	bh=eS4QSfXNcIjbZGqC+93+6RUlp/THEJ6yY+bMr61+D+U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFc5AViiA83+MKQ2n/AkUntGgu0AKodePm97V1MulMyufEWP+Xkp2rsWTMp1Hv8r3CGZ9+eRQc6Wj+cBmk+IT4fmZu8tOBoJPhme+H+dBLDRGm2P+A0GAF/t6sfuzs6ZQZA85ye9dx5peqmW2PlthLr9HYiYjVRqvfcyUT1w33s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZBeCFjZA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717087992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FWRZoiUvFuxX1OnzeVNicOYUmBU2rijcyvy6xzKbRWc=;
	b=ZBeCFjZAc+46K6mElNKcSBmuP53F2OCen0rTCfWyb/Tp5EnRJir6mc2KY8mAcv6bmqSh9k
	pnvLRmXfpqdBwZjo//Vr/4MqxUy9lBwxE5uV4T/JCPwurfIE8mh8fu4Jp5gFjDf8Fn4jsO
	TAuf5OlkKSfdI4ZSLprkpb2m4ALOn9c=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-Rkn4M4e8OVGAdW7xsilJEw-1; Thu, 30 May 2024 12:53:11 -0400
X-MC-Unique: Rkn4M4e8OVGAdW7xsilJEw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-35dc0949675so840739f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717087990; x=1717692790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FWRZoiUvFuxX1OnzeVNicOYUmBU2rijcyvy6xzKbRWc=;
        b=LM9TCizoBRYZV5TiGKN3jyXduSkyGSURuduw5nzP6iNGN7lRUnvVRWKkO5+BN4JlSz
         z8B2TUktWRjXWd1nvAtfuMfukNYMwOhwIwjLXgfh7sLumoa6n7d2YlbZspTVq+MO7ybj
         IYuQtCFCQ57bea0U2aDDq0gQGh6LCS9zS4KW6FAvDUrrEZNiBnkLSlhnEQ9pOTs3bqlm
         V3nWp8jYeSIZBe0uF/cHraay8c5UaE+vPrxInzlEhc5E7wgMkHFAhURCvdhsi9/RjC91
         YiBiDFIEQ0DxD/vE/YHO6hjQefRI2niSsa48P+hFLKu+AjN3TAL5keaTLRlRUKRI92U0
         hCuw==
X-Forwarded-Encrypted: i=1; AJvYcCWboLXejH5GZia5U0XZBdpPI9qWnaaEiMpROqr2ZTDcgU/dHvqwZMYkfJOiCKnnpyhMGT/v+ABaK4hGkIcYaGfnaUJKRaBXqfDyoQik
X-Gm-Message-State: AOJu0YwSckISMXXeWQHsI5e7HtDqlFg9MABxVsjiF482nGsAsLjKoMyv
	Y4neVdURzKgprtnUfdwdrQlIItJjqAWdaH1rETWL3nUe8jObrZntWqbw1SqIWzN3sr4s+xVfOPu
	0uXto8tRhmfgXdPg0NQdN8FOmJjevezLQ8nQ98PZfV2ig+DVXjRwsnoJpWZ/ihA==
X-Received: by 2002:a05:6000:928:b0:34a:35c7:22a3 with SMTP id ffacd0b85a97d-35dc008ddf8mr2545310f8f.20.1717087989883;
        Thu, 30 May 2024 09:53:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTBqsPusLnEDK/xy012HXBOJUvyUShnfqv5puMOaj9W8uNpidMef17LWF0sLBQG6LCmTiC/Q==
X-Received: by 2002:a05:6000:928:b0:34a:35c7:22a3 with SMTP id ffacd0b85a97d-35dc008ddf8mr2545284f8f.20.1717087989425;
        Thu, 30 May 2024 09:53:09 -0700 (PDT)
Received: from redhat.com ([212.20.115.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579d7dba2sm17723525f8f.17.2024.05.30.09.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 09:53:09 -0700 (PDT)
From: Oleg Nesterov <onestero@redhat.com>
X-Google-Original-From: Oleg Nesterov <oleg@redhat.com>
Date: Thu, 30 May 2024 12:52:38 -0400
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Chris von Recklinghausen <crecklin@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tick/nohz_full: don't abuse smp_call_function_single()
 in tick_setup_device()
Message-ID: <Zliu1qVoUB3Y1rTE@redhat.com>
References: <20240522151742.GA10400@redhat.com>
 <20240528122019.GA28794@redhat.com>
 <ZliSt-RDyxf1bZ_t@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZliSt-RDyxf1bZ_t@localhost.localdomain>

Frederic,

Thanks for review.

On 05/30, Frederic Weisbecker wrote:
>
> Looks good, but can we have a WARN_ONCE(tick_do_timer_cpu != tick_do_timer_boot_cpu)
> right before that, just to make sure our assumptions above are right forever and
> the boot CPU hasn't stopped the tick up to that point?

Sure, I thought about the additional sanity checks too. Although I had something
different in mind.

Frederic, et al, I am on private trip again without my working laptop, can't read
the code. I'll reply on Saturday, OK?

Oleg.

> 
> And after all, pushing a bit further your subsequent patch, can we get rid of
> tick_do_timer_boot_cpu and ifdefery altogether? Such as:
> 
> diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
> index fb0fdec8719a..63a7bd405de7 100644
> --- a/kernel/time/tick-common.c
> +++ b/kernel/time/tick-common.c
> @@ -48,14 +48,6 @@ ktime_t tick_next_period;
>   *    procedure also covers cpu hotplug.
>   */
>  int tick_do_timer_cpu __read_mostly = TICK_DO_TIMER_BOOT;
> -#ifdef CONFIG_NO_HZ_FULL
> -/*
> - * tick_do_timer_boot_cpu indicates the boot CPU temporarily owns
> - * tick_do_timer_cpu and it should be taken over by an eligible secondary
> - * when one comes online.
> - */
> -static int tick_do_timer_boot_cpu __read_mostly = -1;
> -#endif
>  
>  /*
>   * Debugging: see timer_list.c
> @@ -177,26 +169,6 @@ void tick_setup_periodic(struct clock_event_device *dev, int broadcast)
>  	}
>  }
>  
> -#ifdef CONFIG_NO_HZ_FULL
> -static void giveup_do_timer(void *info)
> -{
> -	int cpu = *(unsigned int *)info;
> -
> -	WARN_ON(tick_do_timer_cpu != smp_processor_id());
> -
> -	tick_do_timer_cpu = cpu;
> -}
> -
> -static void tick_take_do_timer_from_boot(void)
> -{
> -	int cpu = smp_processor_id();
> -	int from = tick_do_timer_boot_cpu;
> -
> -	if (from >= 0 && from != cpu)
> -		smp_call_function_single(from, giveup_do_timer, &cpu, 1);
> -}
> -#endif
> -
>  /*
>   * Setup the tick device
>   */
> @@ -211,29 +183,28 @@ static void tick_setup_device(struct tick_device *td,
>  	 * First device setup ?
>  	 */
>  	if (!td->evtdev) {
> +		int timekeeper = READ_ONCE(tick_do_timer_cpu);
>  		/*
>  		 * If no cpu took the do_timer update, assign it to
>  		 * this cpu:
>  		 */
> -		if (tick_do_timer_cpu == TICK_DO_TIMER_BOOT) {
> +		if (timekeeper == TICK_DO_TIMER_BOOT) {
>  			tick_do_timer_cpu = cpu;
>  			tick_next_period = ktime_get();
> -#ifdef CONFIG_NO_HZ_FULL
> +		} else if (timekeeper == TICK_DO_TIMER_NONE) {
> +			if (WARN_ON_ONCE(tick_nohz_full_enabled()))
> +				WRITE_ONCE(tick_do_timer_cpu, cpu);
> +		} else if (tick_nohz_full_cpu(timekeeper) && !tick_nohz_full_cpu(cpu)) {
>  			/*
> -			 * The boot CPU may be nohz_full, in which case set
> -			 * tick_do_timer_boot_cpu so the first housekeeping
> -			 * secondary that comes up will take do_timer from
> -			 * us.
> +			 * The boot CPU will stay in periodic (NOHZ disabled)
> +			 * mode until clocksource_done_booting() called after
> +			 * smp_init() selects a high resolution clocksource and
> +			 * timekeeping_notify() kicks the NOHZ stuff alive.
> +			 *
> +			 * So this WRITE_ONCE can only race with the READ_ONCE
> +			 * check in tick_periodic() but this race is harmless.
>  			 */
> -			if (tick_nohz_full_cpu(cpu))
> -				tick_do_timer_boot_cpu = cpu;
> -
> -		} else if (tick_do_timer_boot_cpu != -1 &&
> -						!tick_nohz_full_cpu(cpu)) {
> -			tick_take_do_timer_from_boot();
> -			tick_do_timer_boot_cpu = -1;
> -			WARN_ON(tick_do_timer_cpu != cpu);
> -#endif
> +			WRITE_ONCE(tick_do_timer_cpu, cpu);
>  		}
>  
>  		/*
> 


