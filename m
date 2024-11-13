Return-Path: <linux-kernel+bounces-407580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E1E9C6F32
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 13:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1D4286442
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 12:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EFDF1DF97E;
	Wed, 13 Nov 2024 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxNLDUrC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D830D1632EE
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 12:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731501620; cv=none; b=jEYgbUZlQBehW9xpfAJfUmSYcaZiFHecTJ7HNrjqeGnPtRVc4y09JJ/GmE41AyLEA+7qbtEQs5Q6ft40KDpE9Tb7QiMaZ94O7w2fmSmsAae7hcTYYe/Fsced9jUV5639PxUtKcYNUhwxHTEzUwVSFJX0ox5K3wvMDX2DYgTkt+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731501620; c=relaxed/simple;
	bh=DzuD4cTZwQjgZsA8Yh6d9Nr445fXtS2n0LDmbeqjVRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SpzCTfP7O5E23sOcpTk/oLMEDD16bj/Yw99oIFaYFO2dxm4u2hRCoav1UFsHLaRPuBwNhiIhH5hCfIXzO2jNbaLOHS1YZ3ekGbVllNhijufjm1I/zYQ3DtLk/2Hl/8IKDPHILMQ7zlzibq7P2iLbfKZyj0gZF21kSw5cSwlOXiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxNLDUrC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF260C4CECD;
	Wed, 13 Nov 2024 12:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731501620;
	bh=DzuD4cTZwQjgZsA8Yh6d9Nr445fXtS2n0LDmbeqjVRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lxNLDUrClm7LbmV04eKZsiC8zpfX/4SgEBHMk9XUs7E8OtZbjf3yA4svicHLPEunh
	 NdTzcsA46NeUVWXp6t9Am6VkNLnIeyKFFm4kCzTs/zgts9VOUncRbjYiZg7XoSZREg
	 HMw/4bRq3VZxnMJsLAq9yekRAAvjevVXifSDuF1j3lqdzXNZMl7/sTZmc0iANgy5Ve
	 csN0Ro86Ti3ZvyxgpXb7efLDpua8DebuxsdjbUaDpEFAMGUjcE5M5xp2DyfWTUrYnI
	 GH/Tsj/9uvocpcjhxOtGzfx+nwsEm8+ZxvFU0Wq1ZOqpgx2QpaMTNhb5VeTtK920kU
	 eGIpVkwfRKIVA==
Date: Wed, 13 Nov 2024 13:40:17 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC 1/3] tick-sched: Remove last_tick and calculate next tick
 from now
Message-ID: <ZzSeMaV9676NiN1_@localhost.localdomain>
References: <20241108174839.1016424-1-joel@joelfernandes.org>
 <20241108174839.1016424-2-joel@joelfernandes.org>
 <ZzKWvislBnjV9kpf@pavilion.home>
 <20241112183330.GA2061573@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241112183330.GA2061573@google.com>

Le Tue, Nov 12, 2024 at 06:33:30PM +0000, Joel Fernandes a écrit :
> On Tue, Nov 12, 2024 at 12:43:58AM +0100, Frederic Weisbecker wrote:
> > > @@ -837,11 +837,9 @@ EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
> > >  
> > >  static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
> > >  {
> > > +	/* Set the time to expire on the next tick and not some far away future. */
> > >  	hrtimer_cancel(&ts->sched_timer);
> > > -	hrtimer_set_expires(&ts->sched_timer, ts->last_tick);
> > > -
> > > -	/* Forward the time to expire in the future */
> > > -	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
> > > +	hrtimer_set_expires(&ts->sched_timer, DIV_ROUND_UP_ULL(now, TICK_NSEC) * TICK_NSEC);
> > 
> > We don't want to rewrite hrtimer_forward() but, after all, the current expiry is
> > enough a relevant information.
> 
> Thanks, do you envision any way we can get past the sched_skew_tick issue
> Thomas mentioned, if we still want to do something like this patch?

First, do we still want to do something like this patch? :-)

> 
> > How about just this? It's worth it as it now forwards after the real last programmed
> > tick, which should be close enough from @now with a delta below TICK_NSEC, or even
> > better @now is below the expiry. Therefore it should resume as just a no-op
> > or at worst an addition within hrtimer_forward():
> > 
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index 753a184c7090..ffd0c026a248 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -838,7 +838,6 @@ EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
> >  static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
> >  {
> >  	hrtimer_cancel(&ts->sched_timer);
> > -	hrtimer_set_expires(&ts->sched_timer, ts->last_tick);
> >  
> >  	/* Forward the time to expire in the future */
> >  	hrtimer_forward(&ts->sched_timer, now, TICK_NSEC);
> 
> For completeness, as we discussed on other thread and Thomas mentioned, we
> break code if doing this.

Right!

> 
> > As for removing last_tick, I think it's a precious debugging information. But
> > it's lagging behind the record of the first time only the tick got stopped within
> > the last trip to idle. So it could become this instead:
> > 
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index 753a184c7090..af013f7733b2 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -1042,12 +1041,11 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
> >  	if (!tick_sched_flag_test(ts, TS_FLAG_STOPPED)) {
> >  		calc_load_nohz_start();
> >  		quiet_vmstat();
> > -
> > -		ts->last_tick = hrtimer_get_expires(&ts->sched_timer);
> >  		tick_sched_flag_set(ts, TS_FLAG_STOPPED);
> >  		trace_tick_stop(1, TICK_DEP_MASK_NONE);
> >  	}
> >  
> > +	ts->last_tick = hrtimer_get_expires(&ts->sched_timer);
> >  	ts->next_tick = expires;
> 
> Are you suggesting we roll this part of your diff into a new patch (to
> improve debug)? I could do that with attribution to you. But I guess I don't
> understand this particular part of your diff.

No there is no point in doing this after all. I was trying to find a point for
this ->last_tick existence but there was one I overlooked like Thomas explained.

> If the tick was already stopped, how does
> hrtimer_get_expires(&ts->sched_timer) change since the last time the tick was
> stopped? ->last_tick should be set only when the tick was last running and a
> stop was attempted? Otherwise your diff might set ->last_tick well into the
> future after the tick was already stopped, AFAICS.

Right.

Thanks.

> 
> thanks,
> 
>  - Joel
> 

