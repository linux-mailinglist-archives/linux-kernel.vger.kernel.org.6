Return-Path: <linux-kernel+bounces-233099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC3491B23A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 00:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4241F281852
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 22:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DCF1A255D;
	Thu, 27 Jun 2024 22:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="SGFtPI0B"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479734DA08
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 22:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719527503; cv=none; b=dVrDjCt82CeQTdtfS60bE1cpUDeBBI0uToecSu/n/lgGhjTgItoguVI3krGCYuE0QZ7sz1E+aaY3ImJq0URmg9Pb+kUtJmlaGSHN5QY7PrGP0AU4N0QZ7mRs8mLkLF5fwh42lb7GiiJ2mmATdCK9hzWedBH5p31RnRakiqD5WGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719527503; c=relaxed/simple;
	bh=iVG5TjqcSUtvA2HeNDBUPbgL4UV3NsxVdFVF5r19mhs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QxpjkwM23gt5fwLeJRJzyKMepJSrdK3wNe2LdN1DvbDl5Gur+zW7nJAcl6DpfGei5RTAmXsfW66Sv6eoqc2epFwKTbAgktBMsBKKutkCQBRKc3FD3I2Fd/aLZidKRqRECmx+/RmFMZSEB0R6rAMl6i2Rv79VmBsoZtJeUdSfvKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=SGFtPI0B; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=FXWPZ6R1yFRB4G/Kxw7AwXMeXqy2+eEZUndy1EvM8Os=;
  b=SGFtPI0BYywR4GuEB8nM7w4SXMyaQ+0NlKkAHQ/97+jGeJPnu4BfcHAr
   3jp1l3dMs/aWNGYzvrSJhVM+LTuhjpc1nZ2gU95maZCDHiB/YrY2Vf15A
   JcXh14PfOSxwwTw21BVjcCeXxVGXrjoDWKmlAGf++e5LOrisKjVj/lQcR
   g=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.09,167,1716242400"; 
   d="scan'208";a="172898240"
Received: from unknown (HELO hadrien) ([159.196.38.209])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 00:30:24 +0200
Date: Fri, 28 Jun 2024 08:30:20 +1000 (AEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Vincent Guittot <vincent.guittot@linaro.org>
cc: K Prateek Nayak <kprateek.nayak@amd.com>, 
    Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
    Dietmar Eggemann <dietmar.eggemann@arm.com>, Mel Gorman <mgorman@suse.de>, 
    linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: softirq
In-Reply-To: <CAKfTPtBtAuBCXH+EcgZhjxqemYf_ye7JhZq-wadRqSvpwfqabA@mail.gmail.com>
Message-ID: <fcf823f-195e-6c9a-eac3-25f870cb35ac@inria.fr>
References: <ef964f57-7c9d-aa77-c958-793c899dc4d9@inria.fr> <CAKfTPtBTc3Z_oK_Gg=79g4eUfA1iUat7gsZ2wqKkj=QXULYzng@mail.gmail.com> <cf7716fd-a148-aae2-45d-94862549e20@inria.fr> <bb174ad3-e5f6-8643-21f4-40604323c00b@amd.com>
 <CAKfTPtBtAuBCXH+EcgZhjxqemYf_ye7JhZq-wadRqSvpwfqabA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Thu, 27 Jun 2024, Vincent Guittot wrote:

> On Thu, 27 Jun 2024 at 16:13, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> >
> > Hello Julia,
> >
> > Some data from my 3rd Generation EPYC machine.
> >
> > On 6/27/2024 2:37 AM, Julia Lawall wrote:
> > >
> > >
> > > On Wed, 26 Jun 2024, Vincent Guittot wrote:
> > >
> > >> On Wed, 26 Jun 2024 at 07:37, Julia Lawall <julia.lawall@inria.fr> wrote:
> > >>>
> > >>> Hello,
> > >>>
> > >>> I'm not sure to understand how soft irqs work.  I see the code:
> > >>>
> > >>> open_softirq(SCHED_SOFTIRQ, sched_balance_softirq);
> > >>>
> > >>> Intuitively, I would expect that sched_balance_softirq would be run by
> > >>> ksoftirqd.  That is, I would expect ksoftirqd to be scheduled
> > >>
> > >> By default, sched_softirq and others run in interrupt context.
> > >> ksoftirqd is woken up only in some cases like when we spent too much
> > >> time processing softirq in interrupt context or the softirq is raised
> > >> outside interrupt context
> > >
> > > nohz_csd_func calls raise_softirq_irqoff, which does:
> > >
> > > inline void raise_softirq_irqoff(unsigned int nr)
> > > {
> > >          __raise_softirq_irqoff(nr);
> > >
> > >          /*
> > >           * If we're in an interrupt or softirq, we're done
> > >           * (this also catches softirq-disabled code). We will
> > >           * actually run the softirq once we return from
> > >           * the irq or softirq.
> > >           *
> > >           * Otherwise we wake up ksoftirqd to make sure we
> > >           * schedule the softirq soon.
> > >           */
> > >          if (!in_interrupt() && should_wake_ksoftirqd())
> >
> > I think it is the !in_interrupt() check that fails. When I disable C2
> > (which is I/O Port based C-state on AMD) and only leave C0 (Poll loop)
> > and C1 (MWAIT based C-state), both of which set TIF_POLLING_NRFLAG while
> > idling, and I add the following log line:
> >
> >         trace_printk("raise_softirq_irqoff %d %lu %lu\n",
> >                      preempt_count(),
> >                      in_interrupt());
> >
> > just above the "if" condition on previous line, I see:
> >
> > #                                _-----=> irqs-off/BH-disabled
> > #                               / _----=> need-resched
> > #                              | / _---=> hardirq/softirq
> > #                              || / _--=> preempt-depth
> > #                              ||| / _-=> migrate-disable
> > #                              |||| /     delay
> > #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> > #              | |         |   |||||     |         |
> >            <idle>-0       [000] d..1.   364.875516: raise_softirq_irqoff_nohz: raise_softirq_irqoff 1 0
> >            <idle>-0       [000] d..1.   364.879504: raise_softirq_irqoff_nohz: raise_softirq_irqoff 1 0
> >            <idle>-0       [000] d..1.   365.299507: raise_softirq_irqoff_nohz: raise_softirq_irqoff 1 0
> >            <idle>-0       [000] d..1.   365.963524: raise_softirq_irqoff_nohz: raise_softirq_irqoff 1 0
> >            <idle>-0       [000] d..1.   367.291500: raise_softirq_irqoff_nohz: raise_softirq_irqoff 1 0
> >            <idle>-0       [000] d..1.   370.339504: raise_softirq_irqoff_nohz: raise_softirq_irqoff 1 0
> >            <idle>-0       [000] d..1.   371.875481: raise_softirq_irqoff_nohz: raise_softirq_irqoff 1 0
> >            <idle>-0       [000] d..1.   374.875462: raise_softirq_irqoff_nohz: raise_softirq_irqoff 1 0
> >           ...
> >
> > (Note, this is only for SCHED_SOFTIRQ being raised from nohz_csd_func())
> >
> > Since for !CONFIG_PREEMPT_RT "should_wake_ksoftirqd()" always returns
> > true, we end up waking softirqd for idle load balancing. Note that
> > "hardirq/softirq" column is always a "." since nohz_csd_func() is
> > executed from "flush_smp_call_function_queue()" on the way out of
> > do_idle().
> >
> > With C2 enabled, which is an I/O Port based C-state on AMD and does
> > not set TIF_POLLING_NRFLAG, I see:
> >
> > #                                _-----=> irqs-off/BH-disabled
> > #                               / _----=> need-resched
> > #                              | / _---=> hardirq/softirq
> > #                              || / _--=> preempt-depth
> > #                              ||| / _-=> migrate-disable
> > #                              |||| /     delay
> > #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> > #              | |         |   |||||     |         |
> >            <idle>-0       [000] d.h1.  2880.497140: raise_softirq_irqoff_nohz: raise_softirq_irqoff 65537 65536
> >            <idle>-0       [000] d.H2.  2882.193270: raise_softirq_irqoff_nohz: raise_softirq_irqoff 65794 65792
> >            <idle>-0       [000] d.h1.  2884.857103: raise_softirq_irqoff_nohz: raise_softirq_irqoff 65537 65536
> >            <idle>-0       [000] d.h1.  2886.769577: raise_softirq_irqoff_nohz: raise_softirq_irqoff 65537 65536
> >            <idle>-0       [000] d.h1.  2886.989832: raise_softirq_irqoff_nohz: raise_softirq_irqoff 65537 65536
> >            <idle>-0       [000] d.h1.  2887.281561: raise_softirq_irqoff_nohz: raise_softirq_irqoff 65537 65536
> >            <idle>-0       [000] d.h1.  2887.825556: raise_softirq_irqoff_nohz: raise_softirq_irqoff 65537 65536
> >            <idle>-0       [000] d.h1.  2888.817564: raise_softirq_irqoff_nohz: raise_softirq_irqoff 65537 65536
> >
> > Raising of softirq here happens in "hardirq" context which, I believe,
> > will lead to SCHED_SOFTIRQ being serviced on the way out. When enabling
> > soft_irq_enter and soft_irq_exit tracepoints, I see:
> >
> >            <idle>-0       [000] d.h1.  3309.994942: raise_softirq_irqoff_nohz: raise_softirq_irqoff 65537 65536 65536
> >            <idle>-0       [000] ..s1.  3309.994943: softirq_entry: vec=7 [action=SCHED]
> >            <idle>-0       [000] ..s1.  3309.995026: softirq_exit: vec=7 [action=SCHED]
> >
> > With the former, I do see nr_running > 1 whenever "ksoftirqd" is running
> > "sched_balance_domains":
> >
> >       ksoftirqd/0-16      [000] ..s.. 10153.805434: sched_balance_domains: nr_running: 1
> >     ksoftirqd/168-1038    [168] ..s.. 10163.765221: sched_balance_domains: nr_running: 1
> >       ksoftirqd/0-16      [000] ..s.. 10166.761349: sched_balance_domains: nr_running: 1
> >     ksoftirqd/120-747     [120] ..s.. 10166.809204: sched_balance_domains: nr_running: 2
> >     ksoftirqd/132-820     [132] ..s.. 10166.813203: sched_balance_domains: nr_running: 1
> >     ksoftirqd/246-1511    [246] ..s.. 10166.845532: sched_balance_domains: nr_running: 1
> >     ksoftirqd/107-668     [107] ..s.. 10166.853201: sched_balance_domains: nr_running: 2
> >     ksoftirqd/120-747     [120] ..s.. 10166.865359: sched_balance_domains: nr_running: 1
> >       ksoftirqd/0-16      [000] ..s.. 10191.273328: sched_balance_domains: nr_running: 1
> >       ksoftirqd/0-16      [000] ..s.. 10193.137307: sched_balance_domains: nr_running: 1
> >       ksoftirqd/0-16      [000] ..s.. 10235.057105: sched_balance_domains: nr_running: 1
> >       ksoftirqd/0-16      [000] ..s.. 10320.172832: sched_balance_domains: nr_running: 1
> >       ksoftirqd/0-16      [000] ..s.. 10323.708863: sched_balance_domains: nr_running: 1
> >       ksoftirqd/0-16      [000] ..s.. 10338.912787: sched_balance_domains: nr_running: 1
> >
>
> This is probably linked to flush_smp_call_function_queue()
>
> flush_smp_call_function_queue();
>   local_irq_save(flags);
>   __flush_smp_call_function_queue(true);
>     nohz_csd_func
>       wakeup ksoftirqd because not in interrupt context
>   if (local_softirq_pending())
>     do_softirq_post_smp_call_flush(was_pending);
>       do_softirq()
>         sched_balance_softirq
>   local_irq_restore(flags);

Thanks for the experiment Prateek.

I agree that the issue is that when polling, we are not in interrupt
context, and thus there is a wakeup ksoftirqd.  The problem is that when
there is only one idle core, waking up the ksoftirqd is counterproductive,
because it prevents load balancing, because that core is then seen as not
being idle.

julia

>
>
>
> > --
> > Thanks and Regards,
> > Prateek
> >
> > >               wakeup_softirqd();
> > > }
> > >
> > > My impression was that wakeup_softirqd was getting called.
> > >
> > > But it is true that if the code is being executed by idle, then
> > > in_interrupt() should be true.  So perhaps it is someone else who is
> > > waking up ksoftirqd.  When I switched to __raise_softirq_irqoff, the
> > > behavior seemed to change, but I may not have fully understood why that
> > > happened.
> > >
> > >>
> > >>> (sched_switch event), then the various actions of sched_balance_softirq to
> > >>> be executed, and the ksoftirqd to be unscheduled (another ksoftirqd)
> > >>> event.
> > >>>
> > >>> But in practice, I see the code of sched_balance_softirq being executed
> > >>> by the idle task, before the ksoftirqd is scheduled (see core 40):
> > >>
> > >> What wakes up ksoftirqd ? and which softirq finally runs in ksoftirqd ?
> > >>
> > >>>
> > >>>            <idle>-0     [040]  3611.432554: softirq_entry:        vec=7 [action=SCHED]
> > >>>            <idle>-0     [040]  3611.432554: bputs:                sched_balance_softirq: starting nohz
> > >>>            <idle>-0     [040]  3611.432554: bputs:                sched_balance_softirq: starting _nohz_idle_balance
> > >>>            bt.B.x-12022 [047]  3611.432554: softirq_entry:        vec=1 [action=TIMER]
> > >>>            <idle>-0     [040]  3611.432554: bputs:                _nohz_idle_balance.isra.0: searching for a cpu
> > >>>            bt.B.x-12033 [003]  3611.432554: softirq_entry:        vec=7 [action=SCHED]
> > >>>            <idle>-0     [040]  3611.432554: bputs:                sched_balance_softirq: ending _nohz_idle_balance
> > >>>            bt.B.x-12052 [011]  3611.432554: softirq_entry:        vec=7 [action=SCHED]
> > >>>            <idle>-0     [040]  3611.432554: bputs:                sched_balance_softirq: nohz returns true ending soft irq
> > >>>            <idle>-0     [040]  3611.432554: softirq_exit:         vec=7 [action=SCHED]
> > >>>
> > >>> For example, idle seems to be running the code in _nohz_idle_balance.
> > >>>
> > >>> I updated the code of _nohz_idle_balance as follows:
> > >>>
> > >>> trace_printk("searching for a cpu\n");
> > >>>          for_each_cpu_wrap(balance_cpu,  nohz.idle_cpus_mask, this_cpu+1) {
> > >>>                  if (!idle_cpu(balance_cpu))
> > >>>                          continue;
> > >>> trace_printk("found an idle cpu\n");
> > >>>
> > >>> It prints searching for a cpu, but not found an idle cpu, because the
> > >>> ksoftirqd on the core's runqueue makes the core not idle.  This makes the
> > >>> whole softirq seem fairly useless when the only idle core is the one
> > >>> raising the soft irq.
> > >>
> > >> The typical behavior is:
> > >>
> > >> CPUA                                   CPUB
> > >>                                         do_idle
> > >>                                           while (!need_resched()) {
> > >>                                           ...
> > >>
> > >> kick_ilb
> > >>    smp_call_function_single_async(CPUB)
> > >>      send_call_function_single_ipi
> > >>        raise_ipi  --------------------->    cpuidle exit event
> > >>                                             irq_handler_entry
> > >>                                               ipi_handler
> > >>                                                 raise sched_softirq
> > >>                                             irq_handler_exit
> > >>                                             sorftirq_entry
> > >>                                               sched_balance_softirq
> > >>                                                 __nohe_idle_balance
> > >>                                             softirq_exit
> > >>                                             cpuidle_enter event
> > >>
> > >> softirq is done in the interrupt context after the irq handler and
> > >> CPUB never leaves the while (!need_resched())  loop
> > >>
> > >> In your case, I suspect that you have a racing with the polling mode
> > >> and the fact that you leave the while (!need_resched()) loop and call
> > >> flush_smp_call_function_queue()
> > >>
> > >> We don't use polling on arm64 so I can't even try to reproduce your case
> > >
> > > This is with Prateek's patch.  So need_resched is not true any more.
> > >
> > > thanks,
> > > julia
> > >
> > >>>
> > >>> This is all for the same scenario that I have discussed previously, where
> > >>> there are two sockets and an overload of on thread on one and an underload
> > >>> of on thread on the other, and all the thread have been marked by numa
> > >>> balancing as preferring to be where they are.  Now I am trying Prateek's
> > >>> patch series.
> > >>>
> > >>> thanks,
> > >>> julia
> > >>
> >
>

