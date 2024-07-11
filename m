Return-Path: <linux-kernel+bounces-248746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B4E92E16D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 10:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ADE0282DC1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 08:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8016F14B978;
	Thu, 11 Jul 2024 08:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zaX0cv4U"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6943D0D0
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 08:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720684830; cv=none; b=AkrBFfI5HBJZnoiDDY+g0jOnqWAyBXERfW6XQ9ZU0RLF9gmFCgf3CRdTSiwm7JgJR5ZZq+tnhBEtFUfmhq4bR+tznhEbog8edeRnJsvH1Tqg7hu921xyjIdS9zsvmZwjFKFt9+djbuPgcWfcpC1S+KXKCuCucCaUR4y9PMy1JY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720684830; c=relaxed/simple;
	bh=StERRhxfed9oXpWj6KwTEYPY/WFQ87CBanMoWJMaZ5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vd4rbAY2c3kzl+3OOBcdLPcqSUl0GB9X+4bVdbh4FKL//9KMOWhLuxt4mufMC4Ab88/kmkLJLLvY7BBPkK5N9aignG94ldboTkpE+z496cx7O7Hf8BShINNIoMu+eBiAntm6MbXw7TRlq/xJE1q2pJ8Zdoic6zGudx61DjTORLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zaX0cv4U; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fbe6f83957so234325ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 01:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1720684828; x=1721289628; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pIkeP93WkzYbza9jdVyJyr2UB0/JFViqS0uge4UddcQ=;
        b=zaX0cv4U+y9tVCDV4RcRm1VB71/05+PTZFVT8Y9qM7a6ufjhh/+gjsCwpdkHq0a2KS
         J1XXLIVJ6VTIyAUhsuLISGVh0E2Kk4qA/SNXEZ4YnbX5GfSKcrykIbx5ETxJuXKbMGb+
         1zUAZjCiynuG6M3zBHYFCKtbPEmL+zqQhwFLv3yjunkm19l5DJY/qm+szGKek6QfpiQR
         RAXx8kACJOx8lPRWu/eFZXVepZEXTBOa+fBO7fcs4N1Yan3SsDrGTZ7athg5w7dYy3JL
         n9QddTz7OGDFpdiaucdLbPZTxT3SeIt8p87B5nC+V59TvhLISEOVo+DubuYFymEtqDDh
         67VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720684828; x=1721289628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pIkeP93WkzYbza9jdVyJyr2UB0/JFViqS0uge4UddcQ=;
        b=p07WLZVb1OcYX37W2DIV7xMQfVAIj5u5GqblMgGrVPMhS/XYA6IEElHSQBIS6gh6pL
         HHb+WkbDSA0neIIKzCNECMeRNcoiPpFofLYt7kvFPksSodjWP73edX9yc8s/SIa5sXkq
         CQi36WrVKQQ3qlRwWpSrkk8USqwaZbR+OpZsh1YgBpHdUTjNkqwWRhejwRIbiiHGbsW1
         gddvEoQWkwrGHowSGNfps1EKzvQQwS7/EM/8M/Io0nDxzcElNDBbz6NgxOnRkjxmrWK6
         fkYiJFjttRmodE3gXyMvxRaGhD/JjBtczfduxFDWdHQ28daFjCdY+ktXjFYXGGjv51Pa
         yV0A==
X-Forwarded-Encrypted: i=1; AJvYcCVwGkUYdcd/SrikFw8VqhNBqxIQENnA6SsUHkFVXAFna5bJazDzYggOfTHV2tomsrM3dTvfhaCkOcRsvYoBJXLhOzRdBKWRUNjhv6ye
X-Gm-Message-State: AOJu0YyjiaNK8Q2bb1zsRtwia8Tq2fXUx+t1G/+0gxmj0EuF98dd+fDz
	GDb5b8av1WkhLDuSpyQ7VGJlo0qqQmd2/Q4gYD72397EUADvMdZ/ONC0sYZekikCz4ciKy/kB3c
	TNZZ7QIJa4kkmJy2+bfqnbMFlPKD1+ews+edDFV6AN1hQOtWSnJ4=
X-Google-Smtp-Source: AGHT+IGsK3yu8EB7hCFy7J2LMnkGFcTEypOET9A72YEnoQtyJZJyfwnN8UeMGVz4tia2MQgfgqD7e2bXBClxFmllzqs=
X-Received: by 2002:a17:902:e5d2:b0:1f9:fb48:7cf9 with SMTP id
 d9443c01a7336-1fbb6efaad1mr69917125ad.63.1720684828137; Thu, 11 Jul 2024
 01:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710090210.41856-1-kprateek.nayak@amd.com> <20240710090210.41856-3-kprateek.nayak@amd.com>
In-Reply-To: <20240710090210.41856-3-kprateek.nayak@amd.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Thu, 11 Jul 2024 10:00:15 +0200
Message-ID: <CAKfTPtCNJUC-gNNPkEBRT5a2UVcPUHLdzUJ+-egZGQ5ihnU0Kw@mail.gmail.com>
Subject: Re: [PATCH 2/3] sched/core: Introduce SM_IDLE and an idle re-entry
 fast-path in __schedule()
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Imran Khan <imran.f.khan@oracle.com>, 
	Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>, Rik van Riel <riel@surriel.com>, 
	Tejun Heo <tj@kernel.org>, Cruz Zhao <CruzZhao@linux.alibaba.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Joel Fernandes <joel@joelfernandes.org>, 
	Zqiang <qiang.zhang1211@gmail.com>, Julia Lawall <julia.lawall@inria.fr>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jul 2024 at 11:03, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> From: Peter Zijlstra <peterz@infradead.org>
>
> Since commit b2a02fc43a1f ("smp: Optimize
> send_call_function_single_ipi()") an idle CPU in TIF_POLLING_NRFLAG mode
> can be pulled out of idle by setting TIF_NEED_RESCHED flag to service an
> IPI without actually sending an interrupt. Even in cases where the IPI
> handler does not queue a task on the idle CPU, do_idle() will call
> __schedule() since need_resched() returns true in these cases.
>
> Introduce and use SM_IDLE to identify call to __schedule() from
> schedule_idle() and shorten the idle re-entry time by skipping
> pick_next_task() when nr_running is 0 and the previous task is the idle
> task.
>
> With the SM_IDLE fast-path, the time taken to complete a fixed set of
> IPIs using ipistorm improves significantly. Following are the numbers
> from a dual socket 3rd Generation EPYC system (2 x 64C/128T) (boost on,
> C2 disabled) running ipistorm between CPU8 and CPU16:
>
> cmdline: insmod ipistorm.ko numipi=100000 single=1 offset=8 cpulist=8 wait=1
>
>    ==================================================================
>    Test          : ipistorm (modified)
>    Units         : Normalized runtime
>    Interpretation: Lower is better
>    Statistic     : AMean
>    ==================================================================
>    kernel:                              time [pct imp]
>    tip:sched/core                       1.00 [baseline]
>    tip:sched/core + SM_IDLE             0.25 [75.11%]
>
> [ kprateek: Commit log and testing ]
>
> Link: https://lore.kernel.org/lkml/20240615012814.GP8774@noisy.programming.kicks-ass.net/
> Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> ---
>  kernel/sched/core.c | 38 +++++++++++++++++++-------------------
>  1 file changed, 19 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 1e0c77eac65a..417d3ebbdf60 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6343,19 +6343,12 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>   * Constants for the sched_mode argument of __schedule().
>   *
>   * The mode argument allows RT enabled kernels to differentiate a
> - * preemption from blocking on an 'sleeping' spin/rwlock. Note that
> - * SM_MASK_PREEMPT for !RT has all bits set, which allows the compiler to
> - * optimize the AND operation out and just check for zero.
> + * preemption from blocking on an 'sleeping' spin/rwlock.
>   */
> -#define SM_NONE                        0x0
> -#define SM_PREEMPT             0x1
> -#define SM_RTLOCK_WAIT         0x2
> -
> -#ifndef CONFIG_PREEMPT_RT
> -# define SM_MASK_PREEMPT       (~0U)
> -#else
> -# define SM_MASK_PREEMPT       SM_PREEMPT
> -#endif
> +#define SM_IDLE                        (-1)
> +#define SM_NONE                        0
> +#define SM_PREEMPT             1
> +#define SM_RTLOCK_WAIT         2
>
>  /*
>   * __schedule() is the main scheduler function.
> @@ -6396,11 +6389,12 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>   *
>   * WARNING: must be called with preemption disabled!
>   */
> -static void __sched notrace __schedule(unsigned int sched_mode)
> +static void __sched notrace __schedule(int sched_mode)
>  {
>         struct task_struct *prev, *next;
>         unsigned long *switch_count;
>         unsigned long prev_state;
> +       bool preempt = sched_mode > 0;
>         struct rq_flags rf;
>         struct rq *rq;
>         int cpu;
> @@ -6409,13 +6403,13 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>         rq = cpu_rq(cpu);
>         prev = rq->curr;
>
> -       schedule_debug(prev, !!sched_mode);
> +       schedule_debug(prev, preempt);
>
>         if (sched_feat(HRTICK) || sched_feat(HRTICK_DL))
>                 hrtick_clear(rq);
>
>         local_irq_disable();
> -       rcu_note_context_switch(!!sched_mode);
> +       rcu_note_context_switch(preempt);
>
>         /*
>          * Make sure that signal_pending_state()->signal_pending() below
> @@ -6449,7 +6443,12 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>          * that we form a control dependency vs deactivate_task() below.
>          */
>         prev_state = READ_ONCE(prev->__state);
> -       if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
> +       if (sched_mode == SM_IDLE) {
> +               if (!rq->nr_running) {
> +                       next = prev;
> +                       goto picked;
> +               }
> +       } else if (!preempt && prev_state) {

With CONFIG_PREEMPT_RT, it was only for SM_PREEMPT but not for SM_RTLOCK_WAIT

>                 if (signal_pending_state(prev_state, prev)) {
>                         WRITE_ONCE(prev->__state, TASK_RUNNING);
>                 } else {
> @@ -6483,6 +6482,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>         }
>
>         next = pick_next_task(rq, prev, &rf);
> +picked:
>         clear_tsk_need_resched(prev);
>         clear_preempt_need_resched();
>  #ifdef CONFIG_SCHED_DEBUG
> @@ -6523,7 +6523,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>                 migrate_disable_switch(rq, prev);
>                 psi_sched_switch(prev, next, !task_on_rq_queued(prev));
>
> -               trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next, prev_state);
> +               trace_sched_switch(preempt, prev, next, prev_state);
>
>                 /* Also unlocks the rq: */
>                 rq = context_switch(rq, prev, next, &rf);
> @@ -6599,7 +6599,7 @@ static void sched_update_worker(struct task_struct *tsk)
>         }
>  }
>
> -static __always_inline void __schedule_loop(unsigned int sched_mode)
> +static __always_inline void __schedule_loop(int sched_mode)
>  {
>         do {
>                 preempt_disable();
> @@ -6644,7 +6644,7 @@ void __sched schedule_idle(void)
>          */
>         WARN_ON_ONCE(current->__state);
>         do {
> -               __schedule(SM_NONE);
> +               __schedule(SM_IDLE);
>         } while (need_resched());
>  }
>
> --
> 2.34.1
>

