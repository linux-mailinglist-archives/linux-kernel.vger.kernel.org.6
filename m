Return-Path: <linux-kernel+bounces-188850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A668CE7C8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F9CF282F15
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CC312E1C5;
	Fri, 24 May 2024 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ElhUYfZu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1590112DDB3
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 15:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716564140; cv=none; b=J0BDvBliNuc7uVZp+Czd7PDr2OA7w27Z5o5/Xy2bcLQf1RpsO/NsG+McnE2W97TE/RR04TlL6WPD4S/qxS/GJWJx3nXgdQ3AxPrD31QJqvRn8pAIO+eWMH9ngZsisKEhbRGxtXcP5DRstYbPwDOF9ln7ZDTmNRq3ifs0CB3I3bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716564140; c=relaxed/simple;
	bh=rERK38A3YDvE0CAtapMe8mxNsMbKVDTYsfNJyVUOTa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klFPraF4oCOfLfYQ2kNd5ilqqZxCEbg1O4SxxExaVp/+pp6KxyMe/8rkOVYO4m+8nEtYSNL6HLbex+PnHVVA+MK7i+IT3zyPbu2xOeKXK5ab94j9StFOcYHpQi4+MqBO3MAu+rlHtoDFrHiSIJEv48+ITZF4b0/QTNda0yu4jXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ElhUYfZu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD2CC2BBFC;
	Fri, 24 May 2024 15:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716564139;
	bh=rERK38A3YDvE0CAtapMe8mxNsMbKVDTYsfNJyVUOTa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ElhUYfZuIxVWE1d2d0zdwnEg7VPJNUsIIgjeECn2Fw/Hvej4YemstEuJNSoS/Kkxo
	 7l93U+MDDNuD8o/Rhpt2yTkhjaxJZqt/Y8XQZT3jqcJduPneQT8KohIiWg/FZcCF1e
	 ZVDj7DSKX3YI/dwbzpO+naqp99zbM+zywVaXb2y94KrvXZ09bEMVEhiLkSSM44wkyy
	 A3KgKSHwmot2fTmevA9UzzM8L8SS3Pr7oz0n5zryc7F0ntQAu+XQhRd2sLea9puqLl
	 2wX8orrpDm9jZkjbgxVae8jBoWmogBw0kEv0XOvVpQ4JMBxIm9l8qZInw7AAi86AC0
	 HL4TbNnOkVc6g==
Date: Fri, 24 May 2024 17:22:16 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	Chris von Recklinghausen <crecklin@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: sched/isolation: tick_take_do_timer_from_boot() calls
 smp_call_function_single() with irqs disabled
Message-ID: <ZlCwqEUPq5VFAqrS@pavilion.home>
References: <20240522151742.GA10400@redhat.com>
 <20240523132358.GA1965@redhat.com>
 <87h6eneeu7.ffs@tglx>
 <20240524141018.GA14261@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240524141018.GA14261@redhat.com>

Le Fri, May 24, 2024 at 04:10:52PM +0200, Oleg Nesterov a écrit :
> Hi Thomas,
> 
> On 05/24, Thomas Gleixner wrote:
> >
> > >> But I don't even understand why exactly we need smp_call_function()...
> >
> > It's not required at all.
> >
> > >> Race with tick_nohz_stop_tick() on boot CPU which can set
> > >> tick_do_timer_cpu = TICK_DO_TIMER_NONE? Is it really bad?
> >
> > This can't happen.
> >
> > > And is it supposed to happen if tick_nohz_full_running ?
> > >
> > > tick_sched_do_timer() and can_stop_idle_tick() claim that
> > > TICK_DO_TIMER_NONE is not possible in this case...
> >
> > What happens during boot is:
> >
> >   1) The boot CPU takes the do_timer duty when it installs its
> >      clockevent device
> >
> >   2) The boot CPU does not give up the duty because of this
> >      condition in can_stop_idle_tick():
> >
> >      if (tick_nohz_full_enabled()) {
> >      	if (tick_cpu == cpu)
> >            return false;
> 
> Yes, I have looked at this code too. But I failed to understand its
> callers, even tick_nohz_idle_stop_tick() which doesn't even call this
> function when ts->timer_expires != 0.
> 
> This code is too tricky for me, I still don't follow the logic.
> Damn, I can't even remember the names of all these functions ;)
> 
> > > So, once again, could you explain why the patch below is wrong?
> >
> > > -			tick_take_do_timer_from_boot();
> > >  			tick_do_timer_boot_cpu = -1;
> > > -			WARN_ON(READ_ONCE(tick_do_timer_cpu) != cpu);
> > > +			WRITE_ONCE(tick_do_timer_cpu, cpu);
> >
> > This part is perfectly fine.
> 
> Great, thanks! I'll write the changelog and send the patch tomorrow.
> 
> > > --- a/kernel/time/tick-sched.c
> > > +++ b/kernel/time/tick-sched.c
> > > @@ -1014,6 +1014,9 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
> > >  	 */
> > >  	tick_cpu = READ_ONCE(tick_do_timer_cpu);
> > >  	if (tick_cpu == cpu) {
> > > +#ifdef CONFIG_NO_HZ_FULL
> > > +		WARN_ON_ONCE(tick_nohz_full_running);
> > > +#endif
> >
> >                 WARN_ON_ONCE(tick_nohz_full_enabled());
> >
> > which spares the ugly #ifdef?
> 
> Yes but tick_nohz_full_enabled() depends on context_tracking_key, and
> context_tracking_enabled() is false without CONFIG_CONTEXT_TRACKING_USER.
> I didn't even try to check if it is selected by NO_HZ_FULL and how do
> they play together.

Yes it is! You can rely on it.

Thanks.

