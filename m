Return-Path: <linux-kernel+bounces-218497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 943E890C09F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F82C1F217B8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 00:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D2C5672;
	Tue, 18 Jun 2024 00:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IyMDiPV2"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B414C8F
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 00:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718671362; cv=none; b=Du+aTYUxe0xF6C5Ki0BqpQZUUxEZ/z1ByZMyD1QYxwLX2mjYO1+1iL5zMl8sSghuLj1VA8LasDIKUspVj5wigz5r+J6sk+iV8PQGsvcyn2xUn23VhQgmgszR0JBT+CrbTCayzQQn2DjkoCEmQk1gI4C+n0UOUdgCQFNzKRTZzZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718671362; c=relaxed/simple;
	bh=BYotfX760PqY2mcNOWxiaLsEIif4d7BNTEGHmIPKRls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SXyBL7JvfR0wrzF2gXGqZ/KD+6k9r3DEGRPrH35smHWqjoLJeseSiTMPUc9DJQQJWqls3gEa47gInCH5EfEVINRj8LLI/+gqCX/x2DTVbJShT9GeKbx+g9QeeJbWvboXz2fyctK+8xyV4BXQp4NvTDB2f8Pux9SOdjrhvxdH9ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IyMDiPV2; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-422f7c7af49so31315e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 17:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718671358; x=1719276158; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=soNwY1feUT1m5F+Cl3agS6X9xd9R8atpsTjXhDrPfUA=;
        b=IyMDiPV24PAXq4rnXjtaGZlAos9TVyYfdXNSEW+HHObkRsA1m2oNkWb+ksxSoVXD12
         DlzUE2nxWQWQ8EWUIxTDuATmWenMDL8PDgpKlAlvqXKlJYZLqU2EPyBPo9uBVBS+0He1
         YIz9/22fPMPpdg3Lehc85uSnT+xrRNww1GtF7lwJkoq943ptXpZR2l0j692hJy0Gz2d1
         RpXOmcJfU0HcwxS1YksFd3Rcp52vM4gJiBEfK8l6DWXHo3jVAoRXMlnjc8x2fV3Rv2AG
         bX9k9I04sfsxn8fgn4mKvklx9sx1mbe3/+r6wTflbDSnuvb1v2Umeot64XhX1s88jofW
         ef9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718671358; x=1719276158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=soNwY1feUT1m5F+Cl3agS6X9xd9R8atpsTjXhDrPfUA=;
        b=F771lj8tQBXuV+ahQEg0wDOAf/L9y+0r0i2Y/O6SL0J7hXKtXhoPpy8p/Mf7/6V1BA
         lnD6ShiUzshbng8xxKDvpGaTTTRMf9RBxQPZ2Sn76085iDMc1f6ehwGsTzdj28LxwccQ
         hDA42MZhJpk0ycv9khqXYqevWEk01EgGGlXqMSQCkNIb1/5U4oj7jAvc+4vqH7o/viEx
         ad6T2iDjb40ZjV8VH1RDX141l/VoOyPJZA9jZSrGFbxNlG8u9+uiTsxqiY1JxDiE3C/o
         WjH7pbU09u+/BcLcm+nJLFz2t+U6I3gJ7D6Wx8XA/4TJdMmx7Zw+yryp4fE1kgPnH7y7
         V/jw==
X-Forwarded-Encrypted: i=1; AJvYcCXj51LEF7Ei3nw82QVFLfgjepCm749AHV+IyzYJLEPpAyXwmkFZ3uN5tuW/tflSfkerxP0qyUGkMQeq7Zl+Bd6CgzjySqvUx4tWx+bP
X-Gm-Message-State: AOJu0Yw9w4HXcwIGfLqe93DfqyAEVs+oUKwA6wTQ/POljHfv2PDh2KbI
	e4hBURhKoln8fzGDv0+EwoUkFnEHRtWTQLI56OzN8p6IwrHeX4xhtlKsgN5htazBfT7MdjB9U91
	+atp+qa0BNDHHONtSn9bDqUx+LFqJdpRRdAI=
X-Google-Smtp-Source: AGHT+IHNmVOlymw36d8FbPeId/74lLBYVRkwza5mRQzCBLmEPmsh1tC8YXjJ7uxg3DFE227VBJeIvqy6bdsrQDBvAuc=
X-Received: by 2002:a05:600c:1d99:b0:422:ff8d:5d25 with SMTP id
 5b1f17b1804b1-42470e9825emr477335e9.5.1718671357826; Mon, 17 Jun 2024
 17:42:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613015837.4132703-1-jstultz@google.com> <20240613100441.GC17707@noisy.programming.kicks-ass.net>
 <20240613115142.kxrmlf3btmwjcprg@airbuntu> <20240614094833.GM8774@noisy.programming.kicks-ass.net>
In-Reply-To: <20240614094833.GM8774@noisy.programming.kicks-ass.net>
From: John Stultz <jstultz@google.com>
Date: Mon, 17 Jun 2024 17:42:25 -0700
Message-ID: <CANDhNCqcbCJNSyrKG5b7vyjmuHUm0kAJmDecqHF-QRZ_EHq=Zw@mail.gmail.com>
Subject: Re: [PATCH] RFC: sched: Rework task_sched_runtime to avoid calling update_rq_clock
To: Peter Zijlstra <peterz@infradead.org>
Cc: Qais Yousef <qyousef@layalina.io>, LKML <linux-kernel@vger.kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	Joel Fernandes <joel@joelfernandes.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 2:48=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
> Which then gets me something like the (completely untested) below..
>
> Hmm?
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 0935f9d4bb7b..36aed99d6a6c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -724,7 +724,6 @@ static void update_rq_clock_task(struct rq *rq, s64 d=
elta)
>
>         rq->prev_irq_time +=3D irq_delta;
>         delta -=3D irq_delta;
> -       psi_account_irqtime(rq->curr, irq_delta);
>         delayacct_irq(rq->curr, irq_delta);
>  #endif
>  #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
> @@ -5459,6 +5458,8 @@ void sched_tick(void)
>
>         sched_clock_tick();
>
> +       psi_account_irqtime(curr, NULL, &rq->psi_irq_time);
> +
>         rq_lock(rq, &rf);
>
>         update_rq_clock(rq);
> @@ -6521,6 +6524,7 @@ static void __sched notrace __schedule(unsigned int=
 sched_mode)
>                 ++*switch_count;
>
>                 migrate_disable_switch(rq, prev);
> +               psi_account_irqtime(prev, next, &rq->psi_irq_time);

FYI: These references to psi_irq_time hit build issues if
CONFIG_IRQ_TIME_ACCOUNTING is disabled.

Also, separately, while I didn't see this earlier testing on physical
devices, when running virtualized, I can pretty easily trip over the
following:

[   65.207340] watchdog: BUG: soft lockup - CPU#0 stuck for 26s!
[kworker/0:3:374]
[   65.211107] irq event stamp: 118664
[   65.212786] hardirqs last  enabled at (118663):
[<ffffffff97a00e46>] asm_sysvec_apic_timer_interrupt+0x16/0x20
[   65.218440] hardirqs last disabled at (118664):
[<ffffffff977fdeca>] sysvec_apic_timer_interrupt+0xa/0xc0
[   65.223074] softirqs last  enabled at (118546):
[<ffffffff9676db78>] __irq_exit_rcu+0x88/0xe0
[   65.227118] softirqs last disabled at (118541):
[<ffffffff9676db78>] __irq_exit_rcu+0x88/0xe0
[   65.231137] CPU: 0 PID: 374 Comm: kworker/0:3 Not tainted
6.10.0-rc4-dirty #4393
[   65.234625] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   65.239089] Workqueue: events psi_avgs_work
[   65.241122] RIP: 0010:collect_percpu_times+0xff/0x310
[   65.243525] Code: b9 02 00 00 00 48 89 df e8 8e a4 01 00 48 8b b4
24 d0 00 00 00 48 89 df e8 5e 9e 01 00 58 45 8b 34 24 41 f6 c6 01 74
0c f3 0
[   65.252926] RSP: 0018:ffff958501263d50 EFLAGS: 00000202
[   65.255433] RAX: 0000000000017b61 RBX: ffff9585b901d848 RCX: 00000000000=
00006
[   65.258755] RDX: ffffffff967eb6ac RSI: ffffffff9819e305 RDI: ffffffff981=
77748
[   65.262113] RBP: ffff958501263db0 R08: 0000000000000001 R09: 00000000000=
00000
[   65.265475] R10: 0000000000000001 R11: 0000000000000001 R12: ffff9585b90=
1d840
[   65.268785] R13: ffff9585b901d884 R14: 0000000000033d8b R15: 00000000000=
00000
[   65.272146] FS:  0000000000000000(0000) GS:ffff9585b9000000(0000)
knlGS:0000000000000000
[   65.275908] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   65.278629] CR2: 00005631aee8b000 CR3: 0000000116c0e001 CR4: 00000000003=
70ef0
[   65.282002] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   65.285386] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[   65.288730] Call Trace:
[   65.289958]  <IRQ>
[   65.290965]  ? watchdog_timer_fn+0x275/0x310
[   65.293185]  ? __pfx_watchdog_timer_fn+0x10/0x10
[   65.295379]  ? __hrtimer_run_queues+0x190/0x3b0
[   65.297795]  ? hrtimer_interrupt+0xf9/0x230
[   65.299782]  ? __sysvec_apic_timer_interrupt+0x82/0x210
[   65.302243]  ? sysvec_apic_timer_interrupt+0x98/0xc0
[   65.304590]  </IRQ>
[   65.305658]  <TASK>
[   65.306708]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20
[   65.309206]  ? psi_avgs_work+0x3c/0xb0
[   65.311001]  ? collect_percpu_times+0xff/0x310
[   65.313153]  psi_avgs_work+0x3c/0xb0
[   65.314864]  process_one_work+0x1fe/0x700
[   65.316782]  ? lock_is_held_type+0xcd/0x120
[   65.318782]  worker_thread+0x1c7/0x3b0
[   65.320571]  ? __pfx_worker_thread+0x10/0x10
[   65.322626]  kthread+0xe0/0x110
[   65.324103]  ? __pfx_kthread+0x10/0x10
[   65.325853]  ret_from_fork+0x28/0x40
[   65.327512]  ? __pfx_kthread+0x10/0x10
[   65.329255]  ret_from_fork_asm+0x1a/0x30
[   65.331073]  </TASK>
[   65.332119] Kernel panic - not syncing: softlockup: hung tasks

Where collect_percpu_times+0xff/0x310:
__seqprop_sequence at include/linux/seqlock.h:211 (discriminator 2)
(inlined by) get_recent_times at kernel/sched/psi.c:261 (discriminator 2)
(inlined by) collect_percpu_times at kernel/sched/psi.c:359 (discriminator =
2)

Which looks like its getting stuck in the seqlock loop, and the only
way I can see that catching right off, is if we're in some sort of
livelock where the calls to psi_account_irqtime(curr, NULL,
&rq->psi_irq_time) is coming in frequently enough to change the seqno
each iteration through the reader.  But from my initial trace_printk
debugging, it seems like from a kworker we enter the loop in
get_recent_times(), hit an irq and somehow never really come back out
of irq context. Though we continue to get ticks on the task and
continue to call psi_account_irqtime().  I was worried we were somehow
getting stuck in the 'while ((group =3D group->parent));' loop in
psi_account_irqtime(), but that doesn't seem to be the case.

[  238.297094] kworker/-798       0..... 200647713us :
collect_percpu_times: JDB: get_recent_times at top of loop 0!
[  238.301705] kworker/-798       0..... 200647767us :
collect_percpu_times: JDB: get_recent_times done with read (looped:
1)!
[  238.306689] kworker/-798       0..... 200647768us :
collect_percpu_times: JDB: get_recent_times at top of loop 0!
[  238.311313] kworker/-798       0..... 200647769us :
collect_percpu_times: JDB: get_recent_times done with read (looped:
1)!
[  238.316318] kworker/-798       0d..2. 200647786us :
psi_group_change: JDB: psi_group_change seqwrite
<normal behavior above>
[  238.320460] kworker/-10        0..... 200647790us :
collect_percpu_times: JDB: get_recent_times at top of loop 0!
[  238.325131] kworker/-10        0d.h.. 200648408us :
psi_account_irqtime: JDB: psi_account_irqtime seqwrite (loop count: 0)
[  238.330149] kworker/-10        0d.h.. 200649406us :
psi_account_irqtime: JDB: psi_account_irqtime seqwrite (loop count: 0)
[  238.335140] kworker/-10        0d.h.. 200650405us :
psi_account_irqtime: JDB: psi_account_irqtime seqwrite (loop count: 0)
...
With the psi_account_irqtime just repeating there each ms/tick.

I'm still digging a bit here to understand what's going on. But I
wanted to share.

thanks
-john

