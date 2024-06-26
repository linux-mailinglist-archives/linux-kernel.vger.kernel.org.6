Return-Path: <linux-kernel+bounces-231535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 434E09199A2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 23:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3414B21399
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 21:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DF419307D;
	Wed, 26 Jun 2024 21:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="kPv+M52r"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EA714D6EB
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 21:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719436091; cv=none; b=Gw6h0ob7Ew4GvZfqPdKJeSBc+PHrgFDi5mG5QHAhq0ju4gEBfoXw/vIfrDgxnoa0lCyws9zHaaOGS8C8gAYlsDe8u6NuFxXgOsn+LYJzqKhua89pbDjyMMAYZJa8Ci/Vv/fhTvOVUq3ERibfdHHi8Nrr09uSVeuL3gOCTO5DJqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719436091; c=relaxed/simple;
	bh=rNKW3G/e9dcLSoRWW0be0AJ4O/KiLaCqBlOhi7O1fLc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=V6EkhxtC0DEVCazyrImLhdQHzMPQNAPJGXVJLiimXvcGEOJPU22QyoK5D+iS3hRJ9QBaSwSbdD30nFxUauTpCyjVRt/fc0LzeyWN4o34hcno/8+Mvou8kb0wdMH2LUUzbrY0xC8OPJg7hiHYa67gYYO3XlKZLdwcJvOuIegAtwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=kPv+M52r; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=u0EnO2kFypxPYvQhcawZyOjrrJ/C2hgnr1CRgWjrNmM=;
  b=kPv+M52rpqomyg5KI3DrcHqRZe4XpjVKWrw/zZffBGDPzuNTH+oWIn8y
   WB417eR2wfu4xrg5FVYJ01Bb3ikaC1gJINODZHtYA4rVQRo17Mq47U7T4
   OJ9wr2PjbZG29fCZaKd/ViI/3guCnOLvHIRC4YDeyLTOeLdahOJKtixyr
   s=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.08,268,1712613600"; 
   d="scan'208";a="90721396"
Received: from 203-174-183-243.bri.static-ipl.aapt.com.au (HELO hadrien) ([203.174.183.243])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2024 23:07:58 +0200
Date: Thu, 27 Jun 2024 07:07:52 +1000 (AEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Vincent Guittot <vincent.guittot@linaro.org>
cc: Julia Lawall <julia.lawall@inria.fr>, 
    Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Dietmar Eggemann <dietmar.eggemann@arm.com>, Mel Gorman <mgorman@suse.de>, 
    K Prateek Nayak <kprateek.nayak@amd.com>, 
    linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: softirq
In-Reply-To: <CAKfTPtBTc3Z_oK_Gg=79g4eUfA1iUat7gsZ2wqKkj=QXULYzng@mail.gmail.com>
Message-ID: <cf7716fd-a148-aae2-45d-94862549e20@inria.fr>
References: <ef964f57-7c9d-aa77-c958-793c899dc4d9@inria.fr> <CAKfTPtBTc3Z_oK_Gg=79g4eUfA1iUat7gsZ2wqKkj=QXULYzng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 26 Jun 2024, Vincent Guittot wrote:

> On Wed, 26 Jun 2024 at 07:37, Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> > Hello,
> >
> > I'm not sure to understand how soft irqs work.  I see the code:
> >
> > open_softirq(SCHED_SOFTIRQ, sched_balance_softirq);
> >
> > Intuitively, I would expect that sched_balance_softirq would be run by
> > ksoftirqd.  That is, I would expect ksoftirqd to be scheduled
>
> By default, sched_softirq and others run in interrupt context.
> ksoftirqd is woken up only in some cases like when we spent too much
> time processing softirq in interrupt context or the softirq is raised
> outside interrupt context

nohz_csd_func calls raise_softirq_irqoff, which does:

inline void raise_softirq_irqoff(unsigned int nr)
{
        __raise_softirq_irqoff(nr);

        /*
         * If we're in an interrupt or softirq, we're done
         * (this also catches softirq-disabled code). We will
         * actually run the softirq once we return from
         * the irq or softirq.
         *
         * Otherwise we wake up ksoftirqd to make sure we
         * schedule the softirq soon.
         */
        if (!in_interrupt() && should_wake_ksoftirqd())
		wakeup_softirqd();
}

My impression was that wakeup_softirqd was getting called.

But it is true that if the code is being executed by idle, then
in_interrupt() should be true.  So perhaps it is someone else who is
waking up ksoftirqd.  When I switched to __raise_softirq_irqoff, the
behavior seemed to change, but I may not have fully understood why that
happened.

>
> > (sched_switch event), then the various actions of sched_balance_softirq to
> > be executed, and the ksoftirqd to be unscheduled (another ksoftirqd)
> > event.
> >
> > But in practice, I see the code of sched_balance_softirq being executed
> > by the idle task, before the ksoftirqd is scheduled (see core 40):
>
> What wakes up ksoftirqd ? and which softirq finally runs in ksoftirqd ?
>
> >
> >           <idle>-0     [040]  3611.432554: softirq_entry:        vec=7 [action=SCHED]
> >           <idle>-0     [040]  3611.432554: bputs:                sched_balance_softirq: starting nohz
> >           <idle>-0     [040]  3611.432554: bputs:                sched_balance_softirq: starting _nohz_idle_balance
> >           bt.B.x-12022 [047]  3611.432554: softirq_entry:        vec=1 [action=TIMER]
> >           <idle>-0     [040]  3611.432554: bputs:                _nohz_idle_balance.isra.0: searching for a cpu
> >           bt.B.x-12033 [003]  3611.432554: softirq_entry:        vec=7 [action=SCHED]
> >           <idle>-0     [040]  3611.432554: bputs:                sched_balance_softirq: ending _nohz_idle_balance
> >           bt.B.x-12052 [011]  3611.432554: softirq_entry:        vec=7 [action=SCHED]
> >           <idle>-0     [040]  3611.432554: bputs:                sched_balance_softirq: nohz returns true ending soft irq
> >           <idle>-0     [040]  3611.432554: softirq_exit:         vec=7 [action=SCHED]
> >
> > For example, idle seems to be running the code in _nohz_idle_balance.
> >
> > I updated the code of _nohz_idle_balance as follows:
> >
> > trace_printk("searching for a cpu\n");
> >         for_each_cpu_wrap(balance_cpu,  nohz.idle_cpus_mask, this_cpu+1) {
> >                 if (!idle_cpu(balance_cpu))
> >                         continue;
> > trace_printk("found an idle cpu\n");
> >
> > It prints searching for a cpu, but not found an idle cpu, because the
> > ksoftirqd on the core's runqueue makes the core not idle.  This makes the
> > whole softirq seem fairly useless when the only idle core is the one
> > raising the soft irq.
>
> The typical behavior is:
>
> CPUA                                   CPUB
>                                        do_idle
>                                          while (!need_resched()) {
>                                          ...
>
> kick_ilb
>   smp_call_function_single_async(CPUB)
>     send_call_function_single_ipi
>       raise_ipi  --------------------->    cpuidle exit event
>                                            irq_handler_entry
>                                              ipi_handler
>                                                raise sched_softirq
>                                            irq_handler_exit
>                                            sorftirq_entry
>                                              sched_balance_softirq
>                                                __nohe_idle_balance
>                                            softirq_exit
>                                            cpuidle_enter event
>
> softirq is done in the interrupt context after the irq handler and
> CPUB never leaves the while (!need_resched())  loop
>
> In your case, I suspect that you have a racing with the polling mode
> and the fact that you leave the while (!need_resched()) loop and call
> flush_smp_call_function_queue()
>
> We don't use polling on arm64 so I can't even try to reproduce your case

This is with Prateek's patch.  So need_resched is not true any more.

thanks,
julia

> >
> > This is all for the same scenario that I have discussed previously, where
> > there are two sockets and an overload of on thread on one and an underload
> > of on thread on the other, and all the thread have been marked by numa
> > balancing as preferring to be where they are.  Now I am trying Prateek's
> > patch series.
> >
> > thanks,
> > julia
>

