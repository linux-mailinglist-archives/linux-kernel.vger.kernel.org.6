Return-Path: <linux-kernel+bounces-406529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EDD9C6079
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 19:33:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FF231F218BB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 18:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD979217452;
	Tue, 12 Nov 2024 18:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="sfv+N2Lc"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5DC2076A9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 18:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731436414; cv=none; b=i3DqT2O79we4c9QPDkFpvu88jo8i06RAGc7eKNHArEr1Wq+fGGpUg4e3IxpY6CAnIGFzQxQ8unbp7GKkilAjTccuXvv6oCTkb15obJZE+svhotkTOw+tcDObQRnXMLj6q2Wo9ASlY4hHMVU7hGrMe+2OWdZpJz+P//uRfguMShA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731436414; c=relaxed/simple;
	bh=L4EB3bK9nF1eUw9gq5osQzL/652ZBBgHHJ66oumcjGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDEmREG7KnWU9bIKon1pA4LhObSpSgLzOsAT1MBXJ7lq37hvd90+owpWos8K+h10rCVR3qAzDhCs4OpEjnlhM9YsjuLJb/q0fG2erW10yxo253ENFyHgF21HOMtalNB61hm2AGypn74flnsvmFukuMAI6GgIrzzRsfUUcAPdpYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=sfv+N2Lc; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a4e5a7b026so21498045ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 10:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1731436411; x=1732041211; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p465dKIJ4IYYDjMn3gNfZlw1GvGQG1PiuuM4JHiNnig=;
        b=sfv+N2LckY8DvnJ/yM7fTpDXUGtANMjkP5MlVo1ovwRLLBLzrSpt86Iid0u8flBqUt
         8zWhpSygQ54Cz4939YPbk5p6OhoXU2Aswp/zU1w9FwTQu3nzE+ghAgefF1182TkLuqRm
         +BHPbdnPUDhlJqv4idFFsSTZS+t8EOxgHHFmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731436411; x=1732041211;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p465dKIJ4IYYDjMn3gNfZlw1GvGQG1PiuuM4JHiNnig=;
        b=shQhOtWk4vj/6wpHfxE5I4QrIUp2QLmNVn3oG31a4fLPzdg6X9FNjX/c0KdaO+/5ZM
         L7Ki+h/az6/AJzPD/gtiKUkPr83OYOe3iRFXDqA3qVniLBiJ1jQruLiZCoBOteUf5Z69
         toiBjyGtBSWEBBkXBbk9Xn8/nHsLp8Bd98ccIhoxCYp1I46mnL3HdguLwu/kQEsdOiDQ
         dkdwAUoZcivEWxeFdZbP44ak3lF4sqoU9arVyqXfrtCsNtlqRtXAKsChSv6ZKq5yIKUg
         qH53H4LsjeCCjpft7Bn/5cTy+mZoxTT53+AdfkTd2qX2cExcCzvvzQp6JBmmUfZTUJa7
         1sRw==
X-Gm-Message-State: AOJu0YyfLbDpUodhrSvZ17rySOcwH4hLghrUzVeR0TqjZRJOuOr/cdpu
	m2gkJ4/N1TQqO7/TmFxWNSQQ08lsaNEweNHRTgZzXaKwFOfRoBB/QcIhmO0io/k=
X-Google-Smtp-Source: AGHT+IFohZ+rcHRINBALHVrUbT+FrIFEIH8SSF1HmPhttDNm2ZpTiMe7OaLYyKBnsmW1fiivpULbcg==
X-Received: by 2002:a05:6e02:2148:b0:3a3:b3f4:af42 with SMTP id e9e14a558f8ab-3a7156f751amr955065ab.7.1731436411491;
        Tue, 12 Nov 2024 10:33:31 -0800 (PST)
Received: from localhost (222.121.121.34.bc.googleusercontent.com. [34.121.121.222])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a6f987e056sm22827805ab.64.2024.11.12.10.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 10:33:30 -0800 (PST)
Date: Tue, 12 Nov 2024 18:33:30 +0000
From: Joel Fernandes <joel@joelfernandes.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC 1/3] tick-sched: Remove last_tick and calculate next tick
 from now
Message-ID: <20241112183330.GA2061573@google.com>
References: <20241108174839.1016424-1-joel@joelfernandes.org>
 <20241108174839.1016424-2-joel@joelfernandes.org>
 <ZzKWvislBnjV9kpf@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZzKWvislBnjV9kpf@pavilion.home>

On Tue, Nov 12, 2024 at 12:43:58AM +0100, Frederic Weisbecker wrote:
> Le Fri, Nov 08, 2024 at 05:48:34PM +0000, Joel Fernandes (Google) a écrit :
> > During tick restart, we use last_tick and forward it past now.
> > 
> > Since we are forwarding past now, we can simply use now as a reference
> > instead of last_tick. This patch removes last_tick and does so.
> > 
> > This patch potentially does more mul/imul than the existing code,
> > as sometimes forwarding past now need not be done if last_tick > now.
> 
> Which is not uncommon if idle exited because of a non-timer interrupt
> (remote wake up IPI or hardware interrupt).
> 
> It's also cheaper with hrtimer_forward() if now - last_tick < TICK_NSEC
> which is not uncommon either if idle exited because of a wake-up from the tick
> (schedule_timeout for example).
> 
> > However, the patch is a cleanup which reduces LOC and reduces the size
> > of struct tick_sched.
> 
> Reducing the overhead of idle exit and consolidating its code within existing
> forward API is more important than a per-cpu field.
> 
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> >  kernel/time/tick-sched.c | 7 ++-----
> >  kernel/time/tick-sched.h | 1 -
> >  kernel/time/timer_list.c | 1 -
> >  3 files changed, 2 insertions(+), 7 deletions(-)
> > 
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index 71a792cd8936..52a4eda664cf 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -837,11 +837,9 @@ EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
> >  
> >  static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
> >  {
> > +	/* Set the time to expire on the next tick and not some far away future. */
> >  	hrtimer_cancel(&ts->sched_timer);
> > -	hrtimer_set_expires(&ts->sched_timer, ts->last_tick);
> > -
> > -	/* Forward the time to expire in the future */
> > -	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
> > +	hrtimer_set_expires(&ts->sched_timer, DIV_ROUND_UP_ULL(now, TICK_NSEC) * TICK_NSEC);
> 
> We don't want to rewrite hrtimer_forward() but, after all, the current expiry is
> enough a relevant information.

Thanks, do you envision any way we can get past the sched_skew_tick issue
Thomas mentioned, if we still want to do something like this patch?

> How about just this? It's worth it as it now forwards after the real last programmed
> tick, which should be close enough from @now with a delta below TICK_NSEC, or even
> better @now is below the expiry. Therefore it should resume as just a no-op
> or at worst an addition within hrtimer_forward():
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 753a184c7090..ffd0c026a248 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -838,7 +838,6 @@ EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
>  static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
>  {
>  	hrtimer_cancel(&ts->sched_timer);
> -	hrtimer_set_expires(&ts->sched_timer, ts->last_tick);
>  
>  	/* Forward the time to expire in the future */
>  	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);

For completeness, as we discussed on other thread and Thomas mentioned, we
break code if doing this.

> As for removing last_tick, I think it's a precious debugging information. But
> it's lagging behind the record of the first time only the tick got stopped within
> the last trip to idle. So it could become this instead:
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 753a184c7090..af013f7733b2 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -1042,12 +1041,11 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
>  	if (!tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
>  		calc_load_nohz_start();
>  		quiet_vmstat();
> -
> -		ts->last_tick = hrtimer_get_expires(&ts->sched_timer);
>  		tick_sched_flag_set(ts, TS_FLAG_STOPPED);
>  		trace_tick_stop(1, TICK_DEP_MASK_NONE);
>  	}
>  
> +	ts->last_tick = hrtimer_get_expires(&ts->sched_timer);
>  	ts->next_tick = expires;

Are you suggesting we roll this part of your diff into a new patch (to
improve debug)? I could do that with attribution to you. But I guess I don't
understand this particular part of your diff.

If the tick was already stopped, how does
hrtimer_get_expires(&ts->sched_timer) change since the last time the tick was
stopped? ->last_tick should be set only when the tick was last running and a
stop was attempted? Otherwise your diff might set ->last_tick well into the
future after the tick was already stopped, AFAICS.

thanks,

 - Joel


