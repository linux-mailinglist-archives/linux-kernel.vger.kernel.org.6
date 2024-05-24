Return-Path: <linux-kernel+bounces-188842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8B98CE7B4
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAC651F220E2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC6F12EBED;
	Fri, 24 May 2024 15:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0rckNix"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3C612EBE3
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 15:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716564014; cv=none; b=fjkFccILw7ZjjDmb4wAjMAAT/OkQCfaHX7pJ4nDBOgJNnlucg3aSYq+JMck5ejPSpny4PYUD4165aOpCu3y21Tkoyml/EImpqsOF1fWp4s6ej4yB98nj38vZuglLY7fTcakRR4xcnV8TDyhB3huvtO0a/egrl4yhYbvi/KPOeis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716564014; c=relaxed/simple;
	bh=1hbYp9ygdO4ykYO6SM86qUSkk5yHljmEwCEUtr9n/Ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiWO5QTe/XcJWruudsIjKbuc2ZJOnxkwPctk7zDolK9a/FyczibgkfojZER4KbuBwCIqiTkgv3RS1iJ3UaHCHAlyJwKWRCGaaSkJzqP3iOWHmIjvAr/cJRCPp5cD/VF3Dy5evve7OVx1WykHbXNgg1+loLIeXPpeDOOSacjAtFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0rckNix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D062C4AF09;
	Fri, 24 May 2024 15:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716564013;
	bh=1hbYp9ygdO4ykYO6SM86qUSkk5yHljmEwCEUtr9n/Ng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I0rckNixd3zCr8QKwKyKfUaEmXjHqJ9XwzwikWk6s6I7VeVLqT8zUhFgwkoE8I3Wj
	 dARyIwMVWFeu9GlgRCXBUuw6W22cImBD8yIdun0MyOWxg38YmBBWs1IQETyRBGZDXd
	 SNecQR1WcmwrBS8uTfcj4QYY95nzL4v9mvrSMFxhzwInwnzyt7tVTYog6zqu5xuCN7
	 1I8ftKTFCoHVd9ORQT+fYaGb51dXGxksp7uiCk384PjFOVOMaqgmhBACayIB2H1LBj
	 YQkUt1EXu0skHmbuMSlzFw/Gum419gOSYXydloH8R6sVRRlIW5rmhJTygdrWVsU52p
	 jKgkF7yAJ0wmw==
Date: Fri, 24 May 2024 17:20:10 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>, Phil Auld <pauld@redhat.com>,
	Chris von Recklinghausen <crecklin@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: sched/isolation: tick_take_do_timer_from_boot() calls
 smp_call_function_single() with irqs disabled
Message-ID: <ZlCwKk65-eL0FrKX@pavilion.home>
References: <20240522151742.GA10400@redhat.com>
 <20240523132358.GA1965@redhat.com>
 <87h6eneeu7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h6eneeu7.ffs@tglx>

Le Fri, May 24, 2024 at 11:31:12AM +0200, Thomas Gleixner a écrit :
> Oleg!
> 
> On Thu, May 23 2024 at 15:23, Oleg Nesterov wrote:
> > On 05/22, Oleg Nesterov wrote:
> >>
> >> After the recent comment 5097cbcb38e6 ("sched/isolation: Prevent boot crash
> >> when the boot CPU is nohz_full") the kernel no longer crashes, but there is
> >> another problem.
> >>
> >> In this case tick_setup_device() does tick_take_do_timer_from_boot() to
> >> update tick_do_timer_cpu and this triggers WARN_ON_ONCE(irqs_disabled())
> >> in smp_call_function_single().
> >>
> >> I don't understand this code even remotely, I failed to find the fix.
> >>
> >> Perhaps we can use smp_call_function_single_async() as a workaround ?
> >>
> >> But I don't even understand why exactly we need smp_call_function()...
> 
> It's not required at all.
> 
> >> Race with tick_nohz_stop_tick() on boot CPU which can set
> >> tick_do_timer_cpu = TICK_DO_TIMER_NONE? Is it really bad?
> 
> This can't happen.

Actually... The boot CPU is nohz_full and nothing prevents it
from stopping its tick once IRQs are enabled and before calling
tick_nohz_idle_enter(). When that happens, tick_nohz_full_update_tick()
doesn't go through can_stop_idle_tick() and therefore doesn't check if it
is the timekeeper. And then it goes through tick_nohz_stop_tick() which
can set tick_do_timer_cpu = TICK_DO_TIMER_NONE.

> 
> > And is it supposed to happen if tick_nohz_full_running ?
> >
> > tick_sched_do_timer() and can_stop_idle_tick() claim that
> > TICK_DO_TIMER_NONE is not possible in this case...
> 
> What happens during boot is:
> 
>   1) The boot CPU takes the do_timer duty when it installs its
>      clockevent device
> 
>   2) The boot CPU does not give up the duty because of this
>      condition in can_stop_idle_tick():
> 
>      if (tick_nohz_full_enabled()) {
>      	if (tick_cpu == cpu)
>            return false;
>         ...
> 
> So there is no race because the boot CPU _cannot_ reach
> tick_nohz_stop_tick() as long as no secondary has taken over.
> 
> It's far from obvious. What a horrible maze..

I know, I wish I had the time to Nack that nohz_full boot CPU
patch back then. But now we have to maintain it, even though it's
broken and uglifies the situation.

Anyway, we probably need to prevent from stopping the tick
as long as a CPU is the timekeeper and some CPU (could be the same)
is nohz_full somewhere.

That needs to be a seperate change (I'll try to fix that after
the week-end with a new brain) and then Oleg's patch can go on
top of it.

Thanks.

> 
> > So, once again, could you explain why the patch below is wrong?
> 
> > -			tick_take_do_timer_from_boot();
> >  			tick_do_timer_boot_cpu = -1;
> > -			WARN_ON(READ_ONCE(tick_do_timer_cpu) != cpu);
> > +			WRITE_ONCE(tick_do_timer_cpu, cpu);
> 
> This part is perfectly fine.
> 
> > diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> > index 71a792cd8936..3b1d011d45e1 100644
> > --- a/kernel/time/tick-sched.c
> > +++ b/kernel/time/tick-sched.c
> > @@ -1014,6 +1014,9 @@ static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
> >  	 */
> >  	tick_cpu = READ_ONCE(tick_do_timer_cpu);
> >  	if (tick_cpu == cpu) {
> > +#ifdef CONFIG_NO_HZ_FULL
> > +		WARN_ON_ONCE(tick_nohz_full_running);
> > +#endif
> 
>                 WARN_ON_ONCE(tick_nohz_full_enabled());
> 
> which spares the ugly #ifdef?
> 
> >  		WRITE_ONCE(tick_do_timer_cpu, TICK_DO_TIMER_NONE);
> >  		tick_sched_flag_set(ts, TS_FLAG_DO_TIMER_LAST);
> >  	} else if (tick_cpu != TICK_DO_TIMER_NONE) {
> 
> Thanks,
> 
>         tglx

