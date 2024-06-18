Return-Path: <linux-kernel+bounces-220057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C58C90DC22
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 21:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6C211F23934
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 19:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA7815ECEF;
	Tue, 18 Jun 2024 19:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FT4+enOO"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECA71BF50
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718737348; cv=none; b=LTfQ+4cRiPCfcFxErlHefRfp2XQYijOqDjuUsqjsTaQQpMh5rFl1MRlQFOy2okDDAEydQOZpWeMSapYlxg2aj4Vo9d3iznSZHmZhpoPaVHz1ifFZHZELyk2JFR+36g7cFJPQ5Cn254Zrvjg5cSOindWz9f+gijXFbX41ITW1LIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718737348; c=relaxed/simple;
	bh=nYLha8GoaJPDwoJqKl6MxbvnkYxW0rC2ygtht8ouAdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMF/xvh087fjf67nUiIYeSvnqVVO4N+1yY3CjyMoXo7/txoX+A8sC1OCa+VTZJqD+oRIQF8eLJBlZ0qwJYRDCh3XfNyh/jM/tyFTgd7eEDNJiG+6/rYlCdwCCwtslwZcXnKSzUV9c0pHuILJBvOtL9/AgOe9uux/XfY3nIXTGbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FT4+enOO; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-423b89f9042so15245e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 12:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718737344; x=1719342144; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGIhDvq8kB7AmaPBxDv6tkZzPu/qHBt/iZT9hxhjvmY=;
        b=FT4+enOOlLVZVTOdNLUY4p92eu62lMG00Fb68I6D72+XX4vXozhRY+PBUfq5p7kbkK
         59p3S2MHpkYLJWULEHdCKOL5zf/1//Wgr/36J92GH0fW8MsKgXg7/5BLWq1UOdeaRQ7Q
         tSaNO7EVfYOCpqlrTNsXRqlo2Sjm+fSvXWqpbMFcqSWvuBigd8PBANKUvtORJT7O2GZR
         kEnbL5tX4oKYg+uve+Vm6hptzGYyGEI/+3ArwzN7NaEfVK1d0Vi2pz085aspLwTkAxUA
         oLosuqQ3RDiHdVXjt17xnBHH+x0ZTxCCXNfWn6l3sGE2ln173AMz8RFVYpy5YtKUBjSb
         VWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718737344; x=1719342144;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGIhDvq8kB7AmaPBxDv6tkZzPu/qHBt/iZT9hxhjvmY=;
        b=cbNaWBtl4JdNn1NKDDdV12lGeybOZbl5tX5/UtvXAGywSCHGEpQiAQlI6Nr0LWRAfG
         62J9gDFNTpY21X53D6MB56lV6Pfdnd/7SHmojQm4x/eeXWyb9/Tzvx8gutqfXmLXJd5S
         Gvau/Ll/QLmTdbw7C4S8e0G4QD+uOJ7+pJVGAt2bFo4Z0S/HlgV1LUjZ8oeqonHPUCJk
         WWqdtrP9svNLHByP9Q5cwvdz9rcWnhxTueKJlbepEUA8qGGR4EBTe14dgJuZvbhQLnJs
         sfZ5PySOzji0nnXaOe6OsPnmmpn1A7keVZtyjFkqya/LXK8amQG1h/f4Ns4/OlJwPYh2
         v20g==
X-Forwarded-Encrypted: i=1; AJvYcCUIfH7J5+FRanWesbUtdh4Fg20ZB0WVJ+AAKyRZqRzX421J4fZ920HGvjkUI08vGWAwq/QiAWb4ynxPWQqoz3mJxSP25qsKKHAhRkCt
X-Gm-Message-State: AOJu0YxNVXDnJ8Nbwo09WxVvDahrsOvlri/KhSg2R5sueErByTu0GgXm
	klBLLtyBu4CYQIVlsY3LpImK5xAf5mMgz2HyR1wMuefoD1xVqWnFVWcsfig2meuHjfa/DDWkHAQ
	eCjMBIHiU4T/zRaa5jnTsuPrtVb7p5iHu2z4=
X-Google-Smtp-Source: AGHT+IG0XlQwigLCdKAbnnojc3uYhNT6rEnNcv+YyyHL1+QHoXphkGVEnZp8Wmv4Z5sctICHhbU9NnFCLeJGlF9jkr0=
X-Received: by 2002:a05:600c:1e18:b0:423:646:4f85 with SMTP id
 5b1f17b1804b1-42475d2b133mr192305e9.3.1718737344243; Tue, 18 Jun 2024
 12:02:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613015837.4132703-1-jstultz@google.com> <20240613100441.GC17707@noisy.programming.kicks-ass.net>
 <20240613115142.kxrmlf3btmwjcprg@airbuntu> <20240614094833.GM8774@noisy.programming.kicks-ass.net>
 <CANDhNCqcbCJNSyrKG5b7vyjmuHUm0kAJmDecqHF-QRZ_EHq=Zw@mail.gmail.com>
 <20240618081236.GB31592@noisy.programming.kicks-ass.net> <20240618175939.GA439156@cmpxchg.org>
In-Reply-To: <20240618175939.GA439156@cmpxchg.org>
From: John Stultz <jstultz@google.com>
Date: Tue, 18 Jun 2024 12:02:11 -0700
Message-ID: <CANDhNCpaawHsY6oQd24ok86Cbno9RyBSmJhin50rV8nhGkhpxg@mail.gmail.com>
Subject: Re: [PATCH] RFC: sched: Rework task_sched_runtime to avoid calling update_rq_clock
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Qais Yousef <qyousef@layalina.io>, 
	LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Joel Fernandes <joel@joelfernandes.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 10:59=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
>
> On Tue, Jun 18, 2024 at 10:12:36AM +0200, Peter Zijlstra wrote:
> > On Mon, Jun 17, 2024 at 05:42:25PM -0700, John Stultz wrote:
> > > On Fri, Jun 14, 2024 at 2:48=E2=80=AFAM Peter Zijlstra <peterz@infrad=
ead.org> wrote:
> > > > Which then gets me something like the (completely untested) below..
> > > >
> > > > Hmm?
> > > >
> > > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > > index 0935f9d4bb7b..36aed99d6a6c 100644
> > > > --- a/kernel/sched/core.c
> > > > +++ b/kernel/sched/core.c
> > > > @@ -724,7 +724,6 @@ static void update_rq_clock_task(struct rq *rq,=
 s64 delta)
> > > >
> > > >         rq->prev_irq_time +=3D irq_delta;
> > > >         delta -=3D irq_delta;
> > > > -       psi_account_irqtime(rq->curr, irq_delta);
> > > >         delayacct_irq(rq->curr, irq_delta);
> > > >  #endif
> > > >  #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
> > > > @@ -5459,6 +5458,8 @@ void sched_tick(void)
> > > >
> > > >         sched_clock_tick();
> > > >
> > > > +       psi_account_irqtime(curr, NULL, &rq->psi_irq_time);
> > > > +
> > > >         rq_lock(rq, &rf);
> > > >
> > > >         update_rq_clock(rq);
> > > > @@ -6521,6 +6524,7 @@ static void __sched notrace __schedule(unsign=
ed int sched_mode)
> > > >                 ++*switch_count;
> > > >
> > > >                 migrate_disable_switch(rq, prev);
> > > > +               psi_account_irqtime(prev, next, &rq->psi_irq_time);
> > >
> > > FYI: These references to psi_irq_time hit build issues if
> > > CONFIG_IRQ_TIME_ACCOUNTING is disabled.
> >
> > Ah, well, I did say it was untested...
> >
> > > Also, separately, while I didn't see this earlier testing on physical
> > > devices, when running virtualized, I can pretty easily trip over the
> > > following:
> > >
> > > [   65.207340] watchdog: BUG: soft lockup - CPU#0 stuck for 26s!
> > > [kworker/0:3:374]
> > > [   65.211107] irq event stamp: 118664
> > > [   65.212786] hardirqs last  enabled at (118663):
> > > [<ffffffff97a00e46>] asm_sysvec_apic_timer_interrupt+0x16/0x20
> > > [   65.218440] hardirqs last disabled at (118664):
> > > [<ffffffff977fdeca>] sysvec_apic_timer_interrupt+0xa/0xc0
> > > [   65.223074] softirqs last  enabled at (118546):
> > > [<ffffffff9676db78>] __irq_exit_rcu+0x88/0xe0
> > > [   65.227118] softirqs last disabled at (118541):
> > > [<ffffffff9676db78>] __irq_exit_rcu+0x88/0xe0
> > > [   65.231137] CPU: 0 PID: 374 Comm: kworker/0:3 Not tainted
> > > 6.10.0-rc4-dirty #4393
> > > [   65.234625] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> > > BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > > [   65.239089] Workqueue: events psi_avgs_work
> > > [   65.241122] RIP: 0010:collect_percpu_times+0xff/0x310
> > > [   65.243525] Code: b9 02 00 00 00 48 89 df e8 8e a4 01 00 48 8b b4
> > > 24 d0 00 00 00 48 89 df e8 5e 9e 01 00 58 45 8b 34 24 41 f6 c6 01 74
> > > 0c f3 0
> > > [   65.252926] RSP: 0018:ffff958501263d50 EFLAGS: 00000202
> > > [   65.255433] RAX: 0000000000017b61 RBX: ffff9585b901d848 RCX: 00000=
00000000006
> > > [   65.258755] RDX: ffffffff967eb6ac RSI: ffffffff9819e305 RDI: fffff=
fff98177748
> > > [   65.262113] RBP: ffff958501263db0 R08: 0000000000000001 R09: 00000=
00000000000
> > > [   65.265475] R10: 0000000000000001 R11: 0000000000000001 R12: ffff9=
585b901d840
> > > [   65.268785] R13: ffff9585b901d884 R14: 0000000000033d8b R15: 00000=
00000000000
> > > [   65.272146] FS:  0000000000000000(0000) GS:ffff9585b9000000(0000)
> > > knlGS:0000000000000000
> > > [   65.275908] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [   65.278629] CR2: 00005631aee8b000 CR3: 0000000116c0e001 CR4: 00000=
00000370ef0
> > > [   65.282002] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
> > > [   65.285386] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000=
00000000400
> > > [   65.288730] Call Trace:
> > > [   65.289958]  <IRQ>
> > > [   65.290965]  ? watchdog_timer_fn+0x275/0x310
> > > [   65.293185]  ? __pfx_watchdog_timer_fn+0x10/0x10
> > > [   65.295379]  ? __hrtimer_run_queues+0x190/0x3b0
> > > [   65.297795]  ? hrtimer_interrupt+0xf9/0x230
> > > [   65.299782]  ? __sysvec_apic_timer_interrupt+0x82/0x210
> > > [   65.302243]  ? sysvec_apic_timer_interrupt+0x98/0xc0
> > > [   65.304590]  </IRQ>
> > > [   65.305658]  <TASK>
> > > [   65.306708]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
> > > [   65.309206]  ? psi_avgs_work+0x3c/0xb0
> > > [   65.311001]  ? collect_percpu_times+0xff/0x310
> > > [   65.313153]  psi_avgs_work+0x3c/0xb0
> > > [   65.314864]  process_one_work+0x1fe/0x700
> > > [   65.316782]  ? lock_is_held_type+0xcd/0x120
> > > [   65.318782]  worker_thread+0x1c7/0x3b0
> > > [   65.320571]  ? __pfx_worker_thread+0x10/0x10
> > > [   65.322626]  kthread+0xe0/0x110
> > > [   65.324103]  ? __pfx_kthread+0x10/0x10
> > > [   65.325853]  ret_from_fork+0x28/0x40
> > > [   65.327512]  ? __pfx_kthread+0x10/0x10
> > > [   65.329255]  ret_from_fork_asm+0x1a/0x30
> > > [   65.331073]  </TASK>
> > > [   65.332119] Kernel panic - not syncing: softlockup: hung tasks
> > >
> > > Where collect_percpu_times+0xff/0x310:
> > > __seqprop_sequence at include/linux/seqlock.h:211 (discriminator 2)
> > > (inlined by) get_recent_times at kernel/sched/psi.c:261 (discriminato=
r 2)
> > > (inlined by) collect_percpu_times at kernel/sched/psi.c:359 (discrimi=
nator 2)
> > >
> > > Which looks like its getting stuck in the seqlock loop, and the only
> > > way I can see that catching right off, is if we're in some sort of
> > > livelock where the calls to psi_account_irqtime(curr, NULL,
> > > &rq->psi_irq_time) is coming in frequently enough to change the seqno
> > > each iteration through the reader.  But from my initial trace_printk
> > > debugging, it seems like from a kworker we enter the loop in
> > > get_recent_times(), hit an irq and somehow never really come back out
> > > of irq context. Though we continue to get ticks on the task and
> > > continue to call psi_account_irqtime().  I was worried we were someho=
w
> > > getting stuck in the 'while ((group =3D group->parent));' loop in
> > > psi_account_irqtime(), but that doesn't seem to be the case.
> > >
> > > [  238.297094] kworker/-798       0..... 200647713us :
> > > collect_percpu_times: JDB: get_recent_times at top of loop 0!
> > > [  238.301705] kworker/-798       0..... 200647767us :
> > > collect_percpu_times: JDB: get_recent_times done with read (looped:
> > > 1)!
> > > [  238.306689] kworker/-798       0..... 200647768us :
> > > collect_percpu_times: JDB: get_recent_times at top of loop 0!
> > > [  238.311313] kworker/-798       0..... 200647769us :
> > > collect_percpu_times: JDB: get_recent_times done with read (looped:
> > > 1)!
> > > [  238.316318] kworker/-798       0d..2. 200647786us :
> > > psi_group_change: JDB: psi_group_change seqwrite
> > > <normal behavior above>
> > > [  238.320460] kworker/-10        0..... 200647790us :
> > > collect_percpu_times: JDB: get_recent_times at top of loop 0!
> > > [  238.325131] kworker/-10        0d.h.. 200648408us :
> > > psi_account_irqtime: JDB: psi_account_irqtime seqwrite (loop count: 0=
)
> > > [  238.330149] kworker/-10        0d.h.. 200649406us :
> > > psi_account_irqtime: JDB: psi_account_irqtime seqwrite (loop count: 0=
)
> > > [  238.335140] kworker/-10        0d.h.. 200650405us :
> > > psi_account_irqtime: JDB: psi_account_irqtime seqwrite (loop count: 0=
)
> > > ...
> > > With the psi_account_irqtime just repeating there each ms/tick.
> > >
> > > I'm still digging a bit here to understand what's going on. But I
> > > wanted to share.
> >
> > Urgh, that's not making any sense to me either. Johannes, considering:
> >
> >  https://lkml.kernel.org/20240614094833.GM8774@noisy.programming.kicks-=
ass.net
>
> This might be the culprit:
>
> @@ -5459,6 +5458,8 @@ void sched_tick(void)
>
>         sched_clock_tick();
>
> +       psi_account_irqtime(curr, NULL, &rq->psi_irq_time);
> +
>         rq_lock(rq, &rf);
>
>         update_rq_clock(rq);
>
> rq->lock is required for these state updates because it also
> serializes against tasks moving between cgroups. If another CPU
> changes the task->cgroup association during the update, AFAICS it
> could call write_seqcount_begin() one group 1 and _end() on group 2,
> leaving both groups' seqcounters odd.
>
> Can you try moving the accounting call below rq_lock()?

Ah, Yeah! This very much aligns with my testing.
Putting it under the rq_lock avoids the issue, so thank you for the
explanation of why!

The other part that was confounding to me as I was debugging this was
what seemed like we were never returning out of irq context, but in
fact that wasn't the case. I realize now the read_seqcount_begin()
will internally spin if the seqno is odd, and my expectation was
*very* dated that we always entered the loop and repeated while it was
odd, so my debug trace message in the loop wouldn't be expected to
print.

So that nicely resolves it.

Peter: I'll add the fix and write up the change log and send it along.

thanks
-john

