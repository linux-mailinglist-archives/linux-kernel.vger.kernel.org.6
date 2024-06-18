Return-Path: <linux-kernel+bounces-219988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD5B90DB30
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA717284FF6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 17:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2146214D6FC;
	Tue, 18 Jun 2024 17:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="X0BxpNSD"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA09313EFEE
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 17:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718733590; cv=none; b=fr5vfAWwqeGFGZzUcPISIGGKhYKh3aWTvW7jMptFQ6ZU6BgNQJQDGoEqQQwJ57G8M5QKUZFoKxgvg8jVkm9O9gpla+hQ14Cmrxadxk6ma+mMf3kMCfW295jPPQfhD58d/xRt8ogsDO6fr9FlU6gx9qe00TyqtaX1LDuG6DKYBM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718733590; c=relaxed/simple;
	bh=vSGQw9eeOHuUDdymNtiqFBuHc7SL9kuNUa19zol5WiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRte7hajZqP8ITUyAUecBQocRoM0mmhrgHecmfPPVBXaQHxVZDAuYO9eYsB+ua2n+SqieELzroXMrrpQctsXrQPU5/75U07dNmvkIm+ZXV4V7bMMk9KmlsHzJ2QnNCMSJ/QztPrB9ae4Eg+86Xsy8VtqR0Uo9KNMmmqXjxLBkmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=X0BxpNSD; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7955dc86cacso324414885a.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 10:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1718733586; x=1719338386; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hUZtHcNHFglGhTdqwaIfo34qKkwlxqj5XCR+XxcJQ3c=;
        b=X0BxpNSD+upV6NLTPxj/lBySc7lAyX9Kf40m16dbhkWsGN8eEVdeKWtOlwXUwWjV6Y
         bfeDgyG+zD3lIkIACLfdsv3SYRsi7rFjv0tFYkY4FK+oR+9bUW0zdAYKLd7xytc+M81H
         ZSIVVxuTc+XhNQJSfbXrQPKdexTQMTNKm7JYR/OdMixbuPiKIDhPhu6mWaOhhWAophlZ
         ng2j0hwYxVlroS4XodiK6r9jDfd7O1DPvlabZTqA6YCFgqe1MaaoumYChAArJL1JTQCC
         TPe0n2kpUQlohbOHLPulWUa8Tws7A45vukUZ1LiirrXfHpZD6y3P+U8Lw0uZ//Uk2GTL
         7K9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718733586; x=1719338386;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hUZtHcNHFglGhTdqwaIfo34qKkwlxqj5XCR+XxcJQ3c=;
        b=FebWpPrgNoOVZPvQXij+yGgzJZkthm2EgfCaUQ72+uSz57xkutqppIrMReDTDJyIKd
         0AqZIliPnAz+Ld2Sx12gznFI0L/+Q9K+MzDCEYqJb7UAsFAmbsZvQQz4XqkHNtY5eO9d
         OvZFm4JEwOuLIlEAxt0G6VBFkKlQ1DfGoWiBVhjW+jHRtjKeokCAzWiWTPQxOVQezrrj
         bm18Nf3Q00xco13qiQoEDTjB8Eu8wxK3u9FPk2Lo1zxJebsbCAHXTTFTYMTRK+NWzxmF
         zWHFVGjmxRbkNUXeNqwK8SocK35W7IRceV+73AZ6QIEn67p5BW88n1+IwsEExFh01Hq1
         3Q5g==
X-Forwarded-Encrypted: i=1; AJvYcCVJJxYcyID5lUWwDf3RF6rAxwRwS9bR9vAM1g69512lH5Hws7evPKEeI4SB770FxHhhbb2cQBi0EXg2Cm3RnE4epj+sI64tVMn3nv9x
X-Gm-Message-State: AOJu0Yx5E9TG2jdagHIF9gxNCCXsRHf1UWQEVeU09B3GuPmVSKuvNFG9
	e0GlE6uWOY81+AdDKn6RdkJIJR4AdQt3I929gTygmaHZ6dzy0liWXV8KEBXsFX0=
X-Google-Smtp-Source: AGHT+IFL+h272ABjHi436edexHUCc7aiMtJ41T3xKJjXLzvx+tq/VN+gYGjkwhOzrLLmjxB+5VAvEg==
X-Received: by 2002:a05:620a:2a07:b0:795:48dd:f1a with SMTP id af79cd13be357-79bb3e1ba29mr44481185a.15.1718733585124;
        Tue, 18 Jun 2024 10:59:45 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abe2773dsm542487385a.99.2024.06.18.10.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 10:59:44 -0700 (PDT)
Date: Tue, 18 Jun 2024 13:59:39 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: John Stultz <jstultz@google.com>, Qais Yousef <qyousef@layalina.io>,
	LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joel@joelfernandes.org>, kernel-team@android.com
Subject: Re: [PATCH] RFC: sched: Rework task_sched_runtime to avoid calling
 update_rq_clock
Message-ID: <20240618175939.GA439156@cmpxchg.org>
References: <20240613015837.4132703-1-jstultz@google.com>
 <20240613100441.GC17707@noisy.programming.kicks-ass.net>
 <20240613115142.kxrmlf3btmwjcprg@airbuntu>
 <20240614094833.GM8774@noisy.programming.kicks-ass.net>
 <CANDhNCqcbCJNSyrKG5b7vyjmuHUm0kAJmDecqHF-QRZ_EHq=Zw@mail.gmail.com>
 <20240618081236.GB31592@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240618081236.GB31592@noisy.programming.kicks-ass.net>

On Tue, Jun 18, 2024 at 10:12:36AM +0200, Peter Zijlstra wrote:
> On Mon, Jun 17, 2024 at 05:42:25PM -0700, John Stultz wrote:
> > On Fri, Jun 14, 2024 at 2:48 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > > Which then gets me something like the (completely untested) below..
> > >
> > > Hmm?
> > >
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 0935f9d4bb7b..36aed99d6a6c 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -724,7 +724,6 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
> > >
> > >         rq->prev_irq_time += irq_delta;
> > >         delta -= irq_delta;
> > > -       psi_account_irqtime(rq->curr, irq_delta);
> > >         delayacct_irq(rq->curr, irq_delta);
> > >  #endif
> > >  #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
> > > @@ -5459,6 +5458,8 @@ void sched_tick(void)
> > >
> > >         sched_clock_tick();
> > >
> > > +       psi_account_irqtime(curr, NULL, &rq->psi_irq_time);
> > > +
> > >         rq_lock(rq, &rf);
> > >
> > >         update_rq_clock(rq);
> > > @@ -6521,6 +6524,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
> > >                 ++*switch_count;
> > >
> > >                 migrate_disable_switch(rq, prev);
> > > +               psi_account_irqtime(prev, next, &rq->psi_irq_time);
> > 
> > FYI: These references to psi_irq_time hit build issues if
> > CONFIG_IRQ_TIME_ACCOUNTING is disabled.
> 
> Ah, well, I did say it was untested...
> 
> > Also, separately, while I didn't see this earlier testing on physical
> > devices, when running virtualized, I can pretty easily trip over the
> > following:
> > 
> > [   65.207340] watchdog: BUG: soft lockup - CPU#0 stuck for 26s!
> > [kworker/0:3:374]
> > [   65.211107] irq event stamp: 118664
> > [   65.212786] hardirqs last  enabled at (118663):
> > [<ffffffff97a00e46>] asm_sysvec_apic_timer_interrupt+0x16/0x20
> > [   65.218440] hardirqs last disabled at (118664):
> > [<ffffffff977fdeca>] sysvec_apic_timer_interrupt+0xa/0xc0
> > [   65.223074] softirqs last  enabled at (118546):
> > [<ffffffff9676db78>] __irq_exit_rcu+0x88/0xe0
> > [   65.227118] softirqs last disabled at (118541):
> > [<ffffffff9676db78>] __irq_exit_rcu+0x88/0xe0
> > [   65.231137] CPU: 0 PID: 374 Comm: kworker/0:3 Not tainted
> > 6.10.0-rc4-dirty #4393
> > [   65.234625] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > [   65.239089] Workqueue: events psi_avgs_work
> > [   65.241122] RIP: 0010:collect_percpu_times+0xff/0x310
> > [   65.243525] Code: b9 02 00 00 00 48 89 df e8 8e a4 01 00 48 8b b4
> > 24 d0 00 00 00 48 89 df e8 5e 9e 01 00 58 45 8b 34 24 41 f6 c6 01 74
> > 0c f3 0
> > [   65.252926] RSP: 0018:ffff958501263d50 EFLAGS: 00000202
> > [   65.255433] RAX: 0000000000017b61 RBX: ffff9585b901d848 RCX: 0000000000000006
> > [   65.258755] RDX: ffffffff967eb6ac RSI: ffffffff9819e305 RDI: ffffffff98177748
> > [   65.262113] RBP: ffff958501263db0 R08: 0000000000000001 R09: 0000000000000000
> > [   65.265475] R10: 0000000000000001 R11: 0000000000000001 R12: ffff9585b901d840
> > [   65.268785] R13: ffff9585b901d884 R14: 0000000000033d8b R15: 0000000000000000
> > [   65.272146] FS:  0000000000000000(0000) GS:ffff9585b9000000(0000)
> > knlGS:0000000000000000
> > [   65.275908] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   65.278629] CR2: 00005631aee8b000 CR3: 0000000116c0e001 CR4: 0000000000370ef0
> > [   65.282002] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [   65.285386] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [   65.288730] Call Trace:
> > [   65.289958]  <IRQ>
> > [   65.290965]  ? watchdog_timer_fn+0x275/0x310
> > [   65.293185]  ? __pfx_watchdog_timer_fn+0x10/0x10
> > [   65.295379]  ? __hrtimer_run_queues+0x190/0x3b0
> > [   65.297795]  ? hrtimer_interrupt+0xf9/0x230
> > [   65.299782]  ? __sysvec_apic_timer_interrupt+0x82/0x210
> > [   65.302243]  ? sysvec_apic_timer_interrupt+0x98/0xc0
> > [   65.304590]  </IRQ>
> > [   65.305658]  <TASK>
> > [   65.306708]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> > [   65.309206]  ? psi_avgs_work+0x3c/0xb0
> > [   65.311001]  ? collect_percpu_times+0xff/0x310
> > [   65.313153]  psi_avgs_work+0x3c/0xb0
> > [   65.314864]  process_one_work+0x1fe/0x700
> > [   65.316782]  ? lock_is_held_type+0xcd/0x120
> > [   65.318782]  worker_thread+0x1c7/0x3b0
> > [   65.320571]  ? __pfx_worker_thread+0x10/0x10
> > [   65.322626]  kthread+0xe0/0x110
> > [   65.324103]  ? __pfx_kthread+0x10/0x10
> > [   65.325853]  ret_from_fork+0x28/0x40
> > [   65.327512]  ? __pfx_kthread+0x10/0x10
> > [   65.329255]  ret_from_fork_asm+0x1a/0x30
> > [   65.331073]  </TASK>
> > [   65.332119] Kernel panic - not syncing: softlockup: hung tasks
> > 
> > Where collect_percpu_times+0xff/0x310:
> > __seqprop_sequence at include/linux/seqlock.h:211 (discriminator 2)
> > (inlined by) get_recent_times at kernel/sched/psi.c:261 (discriminator 2)
> > (inlined by) collect_percpu_times at kernel/sched/psi.c:359 (discriminator 2)
> > 
> > Which looks like its getting stuck in the seqlock loop, and the only
> > way I can see that catching right off, is if we're in some sort of
> > livelock where the calls to psi_account_irqtime(curr, NULL,
> > &rq->psi_irq_time) is coming in frequently enough to change the seqno
> > each iteration through the reader.  But from my initial trace_printk
> > debugging, it seems like from a kworker we enter the loop in
> > get_recent_times(), hit an irq and somehow never really come back out
> > of irq context. Though we continue to get ticks on the task and
> > continue to call psi_account_irqtime().  I was worried we were somehow
> > getting stuck in the 'while ((group = group->parent));' loop in
> > psi_account_irqtime(), but that doesn't seem to be the case.
> > 
> > [  238.297094] kworker/-798       0..... 200647713us :
> > collect_percpu_times: JDB: get_recent_times at top of loop 0!
> > [  238.301705] kworker/-798       0..... 200647767us :
> > collect_percpu_times: JDB: get_recent_times done with read (looped:
> > 1)!
> > [  238.306689] kworker/-798       0..... 200647768us :
> > collect_percpu_times: JDB: get_recent_times at top of loop 0!
> > [  238.311313] kworker/-798       0..... 200647769us :
> > collect_percpu_times: JDB: get_recent_times done with read (looped:
> > 1)!
> > [  238.316318] kworker/-798       0d..2. 200647786us :
> > psi_group_change: JDB: psi_group_change seqwrite
> > <normal behavior above>
> > [  238.320460] kworker/-10        0..... 200647790us :
> > collect_percpu_times: JDB: get_recent_times at top of loop 0!
> > [  238.325131] kworker/-10        0d.h.. 200648408us :
> > psi_account_irqtime: JDB: psi_account_irqtime seqwrite (loop count: 0)
> > [  238.330149] kworker/-10        0d.h.. 200649406us :
> > psi_account_irqtime: JDB: psi_account_irqtime seqwrite (loop count: 0)
> > [  238.335140] kworker/-10        0d.h.. 200650405us :
> > psi_account_irqtime: JDB: psi_account_irqtime seqwrite (loop count: 0)
> > ...
> > With the psi_account_irqtime just repeating there each ms/tick.
> > 
> > I'm still digging a bit here to understand what's going on. But I
> > wanted to share.
> 
> Urgh, that's not making any sense to me either. Johannes, considering:
> 
>  https://lkml.kernel.org/20240614094833.GM8774@noisy.programming.kicks-ass.net

This might be the culprit:

@@ -5459,6 +5458,8 @@ void sched_tick(void)
 
 	sched_clock_tick();
 
+	psi_account_irqtime(curr, NULL, &rq->psi_irq_time);
+
 	rq_lock(rq, &rf);
 
 	update_rq_clock(rq);

rq->lock is required for these state updates because it also
serializes against tasks moving between cgroups. If another CPU
changes the task->cgroup association during the update, AFAICS it
could call write_seqcount_begin() one group 1 and _end() on group 2,
leaving both groups' seqcounters odd.

Can you try moving the accounting call below rq_lock()?

