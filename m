Return-Path: <linux-kernel+bounces-218851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A72590C704
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F43E1C20FF2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4DD1A4F2C;
	Tue, 18 Jun 2024 08:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pYceKVkf"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFEB13A272
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718698734; cv=none; b=cmfvT1T2pleBN+SjLOhJ3HI6wR+hRPaFtA424pCuKl1dOfj+lFFW/pTS3OvmxnnbRpxWhLkkKcW/p8I9jRSyFoIqhD9hsmI7Ot4XDNvtmgISm2Fg2jE+CjVpFzcqHWPxqD76tLWDtcZIFzN4voxnItPSCdQc4cNkZy73BdPz5+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718698734; c=relaxed/simple;
	bh=ByoBCIudJMsREOr1c9B7KQwC7LRFq8ExoFOaEZ/f92c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWIKjGMgR6RtKH3nxEJMZHMLFkt7oOi7Dd3HCjwPNuiY+RGwJtqfNc55fhds11ZNAfglUTLrnIGx8i6ZJtl9qtVHjZk8tyrB1VbXWynjTUXTWA2M0elZgaSRVCo5SSIBc7G0W4HmqSuMQ+XHdOzASHFzyvaZwKRFqB9NBw7pLw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pYceKVkf; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=tj+kMbodb7VA0W8GPKqWyv+bL11Wb/OhQa0goBSMmVY=; b=pYceKVkffCCl3QQcBnxREYvmd0
	ekK5ib19JfsIMQb3UPsIFtuuc5p+w8EZfZ+B+5DGMuXL4Zkxb3NJ5vdPKQTozgF6dg+bCcX2EP+T9
	KEFoBIYjrOokMiUepYuhgA4iqeIvgK9cE3tAaE+dbmhk4ew6s15CdiM0Nv1vNrt00aa8j+NdJ5hZ7
	u6HC7a9W3etJ3SejqapWSIRYZbiNux5+nSkuCu8CsA8dZRVnccOZt746T5u2gnq4y/4Do00GausiG
	Ds4lHPHg61rmAO4QzrJyl4j8i2arbY3mjDzo2akr+7fw7Rc5MnUlvp5J5rdDPhZRDLuSQpVkE5C5y
	xnzy97ig==;
Received: from [24.132.130.84] (helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJTxk-00000006zrr-0p17;
	Tue, 18 Jun 2024 08:16:08 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1925D300886; Tue, 18 Jun 2024 10:12:36 +0200 (CEST)
Date: Tue, 18 Jun 2024 10:12:36 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: Qais Yousef <qyousef@layalina.io>, LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>, kernel-team@android.com,
	hannes@cmpxchg.org
Subject: Re: [PATCH] RFC: sched: Rework task_sched_runtime to avoid calling
 update_rq_clock
Message-ID: <20240618081236.GB31592@noisy.programming.kicks-ass.net>
References: <20240613015837.4132703-1-jstultz@google.com>
 <20240613100441.GC17707@noisy.programming.kicks-ass.net>
 <20240613115142.kxrmlf3btmwjcprg@airbuntu>
 <20240614094833.GM8774@noisy.programming.kicks-ass.net>
 <CANDhNCqcbCJNSyrKG5b7vyjmuHUm0kAJmDecqHF-QRZ_EHq=Zw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANDhNCqcbCJNSyrKG5b7vyjmuHUm0kAJmDecqHF-QRZ_EHq=Zw@mail.gmail.com>

On Mon, Jun 17, 2024 at 05:42:25PM -0700, John Stultz wrote:
> On Fri, Jun 14, 2024 at 2:48 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > Which then gets me something like the (completely untested) below..
> >
> > Hmm?
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 0935f9d4bb7b..36aed99d6a6c 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -724,7 +724,6 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
> >
> >         rq->prev_irq_time += irq_delta;
> >         delta -= irq_delta;
> > -       psi_account_irqtime(rq->curr, irq_delta);
> >         delayacct_irq(rq->curr, irq_delta);
> >  #endif
> >  #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
> > @@ -5459,6 +5458,8 @@ void sched_tick(void)
> >
> >         sched_clock_tick();
> >
> > +       psi_account_irqtime(curr, NULL, &rq->psi_irq_time);
> > +
> >         rq_lock(rq, &rf);
> >
> >         update_rq_clock(rq);
> > @@ -6521,6 +6524,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
> >                 ++*switch_count;
> >
> >                 migrate_disable_switch(rq, prev);
> > +               psi_account_irqtime(prev, next, &rq->psi_irq_time);
> 
> FYI: These references to psi_irq_time hit build issues if
> CONFIG_IRQ_TIME_ACCOUNTING is disabled.

Ah, well, I did say it was untested...

> Also, separately, while I didn't see this earlier testing on physical
> devices, when running virtualized, I can pretty easily trip over the
> following:
> 
> [   65.207340] watchdog: BUG: soft lockup - CPU#0 stuck for 26s!
> [kworker/0:3:374]
> [   65.211107] irq event stamp: 118664
> [   65.212786] hardirqs last  enabled at (118663):
> [<ffffffff97a00e46>] asm_sysvec_apic_timer_interrupt+0x16/0x20
> [   65.218440] hardirqs last disabled at (118664):
> [<ffffffff977fdeca>] sysvec_apic_timer_interrupt+0xa/0xc0
> [   65.223074] softirqs last  enabled at (118546):
> [<ffffffff9676db78>] __irq_exit_rcu+0x88/0xe0
> [   65.227118] softirqs last disabled at (118541):
> [<ffffffff9676db78>] __irq_exit_rcu+0x88/0xe0
> [   65.231137] CPU: 0 PID: 374 Comm: kworker/0:3 Not tainted
> 6.10.0-rc4-dirty #4393
> [   65.234625] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   65.239089] Workqueue: events psi_avgs_work
> [   65.241122] RIP: 0010:collect_percpu_times+0xff/0x310
> [   65.243525] Code: b9 02 00 00 00 48 89 df e8 8e a4 01 00 48 8b b4
> 24 d0 00 00 00 48 89 df e8 5e 9e 01 00 58 45 8b 34 24 41 f6 c6 01 74
> 0c f3 0
> [   65.252926] RSP: 0018:ffff958501263d50 EFLAGS: 00000202
> [   65.255433] RAX: 0000000000017b61 RBX: ffff9585b901d848 RCX: 0000000000000006
> [   65.258755] RDX: ffffffff967eb6ac RSI: ffffffff9819e305 RDI: ffffffff98177748
> [   65.262113] RBP: ffff958501263db0 R08: 0000000000000001 R09: 0000000000000000
> [   65.265475] R10: 0000000000000001 R11: 0000000000000001 R12: ffff9585b901d840
> [   65.268785] R13: ffff9585b901d884 R14: 0000000000033d8b R15: 0000000000000000
> [   65.272146] FS:  0000000000000000(0000) GS:ffff9585b9000000(0000)
> knlGS:0000000000000000
> [   65.275908] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   65.278629] CR2: 00005631aee8b000 CR3: 0000000116c0e001 CR4: 0000000000370ef0
> [   65.282002] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> [   65.285386] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> [   65.288730] Call Trace:
> [   65.289958]  <IRQ>
> [   65.290965]  ? watchdog_timer_fn+0x275/0x310
> [   65.293185]  ? __pfx_watchdog_timer_fn+0x10/0x10
> [   65.295379]  ? __hrtimer_run_queues+0x190/0x3b0
> [   65.297795]  ? hrtimer_interrupt+0xf9/0x230
> [   65.299782]  ? __sysvec_apic_timer_interrupt+0x82/0x210
> [   65.302243]  ? sysvec_apic_timer_interrupt+0x98/0xc0
> [   65.304590]  </IRQ>
> [   65.305658]  <TASK>
> [   65.306708]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> [   65.309206]  ? psi_avgs_work+0x3c/0xb0
> [   65.311001]  ? collect_percpu_times+0xff/0x310
> [   65.313153]  psi_avgs_work+0x3c/0xb0
> [   65.314864]  process_one_work+0x1fe/0x700
> [   65.316782]  ? lock_is_held_type+0xcd/0x120
> [   65.318782]  worker_thread+0x1c7/0x3b0
> [   65.320571]  ? __pfx_worker_thread+0x10/0x10
> [   65.322626]  kthread+0xe0/0x110
> [   65.324103]  ? __pfx_kthread+0x10/0x10
> [   65.325853]  ret_from_fork+0x28/0x40
> [   65.327512]  ? __pfx_kthread+0x10/0x10
> [   65.329255]  ret_from_fork_asm+0x1a/0x30
> [   65.331073]  </TASK>
> [   65.332119] Kernel panic - not syncing: softlockup: hung tasks
> 
> Where collect_percpu_times+0xff/0x310:
> __seqprop_sequence at include/linux/seqlock.h:211 (discriminator 2)
> (inlined by) get_recent_times at kernel/sched/psi.c:261 (discriminator 2)
> (inlined by) collect_percpu_times at kernel/sched/psi.c:359 (discriminator 2)
> 
> Which looks like its getting stuck in the seqlock loop, and the only
> way I can see that catching right off, is if we're in some sort of
> livelock where the calls to psi_account_irqtime(curr, NULL,
> &rq->psi_irq_time) is coming in frequently enough to change the seqno
> each iteration through the reader.  But from my initial trace_printk
> debugging, it seems like from a kworker we enter the loop in
> get_recent_times(), hit an irq and somehow never really come back out
> of irq context. Though we continue to get ticks on the task and
> continue to call psi_account_irqtime().  I was worried we were somehow
> getting stuck in the 'while ((group = group->parent));' loop in
> psi_account_irqtime(), but that doesn't seem to be the case.
> 
> [  238.297094] kworker/-798       0..... 200647713us :
> collect_percpu_times: JDB: get_recent_times at top of loop 0!
> [  238.301705] kworker/-798       0..... 200647767us :
> collect_percpu_times: JDB: get_recent_times done with read (looped:
> 1)!
> [  238.306689] kworker/-798       0..... 200647768us :
> collect_percpu_times: JDB: get_recent_times at top of loop 0!
> [  238.311313] kworker/-798       0..... 200647769us :
> collect_percpu_times: JDB: get_recent_times done with read (looped:
> 1)!
> [  238.316318] kworker/-798       0d..2. 200647786us :
> psi_group_change: JDB: psi_group_change seqwrite
> <normal behavior above>
> [  238.320460] kworker/-10        0..... 200647790us :
> collect_percpu_times: JDB: get_recent_times at top of loop 0!
> [  238.325131] kworker/-10        0d.h.. 200648408us :
> psi_account_irqtime: JDB: psi_account_irqtime seqwrite (loop count: 0)
> [  238.330149] kworker/-10        0d.h.. 200649406us :
> psi_account_irqtime: JDB: psi_account_irqtime seqwrite (loop count: 0)
> [  238.335140] kworker/-10        0d.h.. 200650405us :
> psi_account_irqtime: JDB: psi_account_irqtime seqwrite (loop count: 0)
> ...
> With the psi_account_irqtime just repeating there each ms/tick.
> 
> I'm still digging a bit here to understand what's going on. But I
> wanted to share.

Urgh, that's not making any sense to me either. Johannes, considering:

 https://lkml.kernel.org/20240614094833.GM8774@noisy.programming.kicks-ass.net

Do you have any idea what's going on here?

