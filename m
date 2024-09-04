Return-Path: <linux-kernel+bounces-314403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF4696B2C1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 09:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FBDB1C22F16
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 07:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F93146585;
	Wed,  4 Sep 2024 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rI+35Ko/"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3301130ADA
	for <linux-kernel@vger.kernel.org>; Wed,  4 Sep 2024 07:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725434703; cv=none; b=BW4AxI9Mk68LWz02Yzrau7pwii5BLoVIhJMULYJAbYN/C16duaJwqlzzDjwfd6v9szeoeKgaRoiXojBOBjA4zSsliHq0znEf9VfSX3yTDyg7zbrmceBumhVqZ6uH+kd0pNAyxHyKVP2BS2tqfAFh/zOEls/f86eovEBzcx0uxCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725434703; c=relaxed/simple;
	bh=IrjIY3S2ahrVPPZenTztMLPh79Rw2d/fQmKzpwoYbd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oa74Cctbhjnak2Tkrn1DwfOy/pcuAUUElAicoVjT1OJSj72p4mWe94dYI6/hXYMCzXEH5sdKgMDVSOTqI7orj7wioiOclXEpPYPP3Dz6FQNwb7ky25tR6sY01vesbrLb6+NhcWgLXveKeCF3by75Lmkr/hd0M4WJx6RbEitfQFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rI+35Ko/; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d8b96c18f0so2396027a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2024 00:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725434701; x=1726039501; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zia/otr4C3byx5FvIk2GO5tKAfk2CXNg7oLBhBOypXs=;
        b=rI+35Ko/AfTIML2YGPq310IDOSo8MtnCWzPcK+hmHUfbFG46W7svpMBKLL1i3nhz2P
         xjS5l+2jRZDaD51TyK8shbBvHmAxIJLNN/sSc05x6XItwGn/u6ud7T0GhDfYk1iWCWDn
         ZGdqd+jeBx0Fa1VmjnH4SHOltw7jA6cusBcNZ31GTjJJL4+F+z2FKt4KwTaeyKc68Qte
         JPWP064uTDww2lHCVm09FNVejJsW67LA+riJBxEVdhzaaiI/sj+rrJFEhvcmPGgMckX0
         lGW2VCwi4TGB/2FL3mpsLymeJKNgqXntVWJwK8lIe2zFqh2+FESXNnRRYXbW1eGr16Bc
         Z17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725434701; x=1726039501;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zia/otr4C3byx5FvIk2GO5tKAfk2CXNg7oLBhBOypXs=;
        b=ksbIXkWbIN9WuuJzuNrjNWJiJgo377NC6Q2Di8Qvq+6Gr5M9U3Ywb2bcm2OvHNHTLj
         VrPnH2D0Mqoms09tUL8KWFHQp9LM0Tpmrpdjonl7y6o3opTynhbnozOBs1AYSrkMlQwX
         BiLogc3vZkXofdn5hTdEdXRb9nm6rigPssmkkD3KZm2Ldesxd7vuM9Nh/IQ6IpJKIrZx
         UVaztLyza4EmuERnruhbb3pyuqr54EswnvYMqET2Xwj9zzJD8ciD/wYdZOFxue21PDLg
         KF/vOM/4YF6TW1TQdIc8elb/tGbDlREE5kG088do65IcavoeFJ7cq9cknZf4vzqcGdZN
         z0Jw==
X-Forwarded-Encrypted: i=1; AJvYcCWRoXUSq64MDR4S845rPdcnU+Uz9PqrDOyccVE1fywyG7KNJtaaJ7NPlcAH9lKy8wR3mI06S5Hp852FYwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF8CRZYw+6r/QVY18WginfrsXTHUkiEeqolvVt6yuMZUpE+Uwj
	EqwjnIUd55FmSdWvE8QyqlnI1ZO8kAuEqaj+8mw40vZ3ASXwU/hrp5BT41GHdjtOx4ysE4uwy39
	J/LS2Iicr3pLE1SflaCp/yySg6sjbt/wewgUz5w==
X-Google-Smtp-Source: AGHT+IENhs5foSHIjRQgXT5j42nNT5ThtEWO7ERqdcjOcSJRglzYrJzz/9HVMlss2MVteej8OVtPvFhD4ttxELLVP3M=
X-Received: by 2002:a17:90b:1651:b0:2d8:b91d:d284 with SMTP id
 98e67ed59e1d1-2da7485191bmr3875779a91.16.1725434700740; Wed, 04 Sep 2024
 00:25:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809092240.6921-1-kprateek.nayak@amd.com>
In-Reply-To: <20240809092240.6921-1-kprateek.nayak@amd.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Wed, 4 Sep 2024 09:24:49 +0200
Message-ID: <CAKfTPtAnX3a+XfeCbFzNGJKiUyA2VGYowsiofetHra=ODOsYJQ@mail.gmail.com>
Subject: Re: [PATCH v2] sched/core: Introduce SM_IDLE and an idle re-entry
 fast-path in __schedule()
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, linux-kernel@vger.kernel.org, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 9 Aug 2024 at 11:22, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
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
> IPIs using ipistorm improves noticeably. Following are the numbers
> from a dual socket Intel Ice Lake Xeon server (2 x 32C/64T) and
> 3rd Generation AMD EPYC system (2 x 64C/128T) (boost on, C2 disabled)
> running ipistorm between CPU8 and CPU16:
>
> cmdline: insmod ipistorm.ko numipi=100000 single=1 offset=8 cpulist=8 wait=1
>
>    ==================================================================
>    Test          : ipistorm (modified)
>    Units         : Normalized runtime
>    Interpretation: Lower is better
>    Statistic     : AMean
>    ======================= Intel Ice Lake Xeon ======================
>    kernel:                              time [pct imp]
>    tip:sched/core                       1.00 [baseline]
>    tip:sched/core + SM_IDLE             0.80 [20.51%]
>    ==================== 3rd Generation AMD EPYC =====================
>    kernel:                              time [pct imp]
>    tip:sched/core                       1.00 [baseline]
>    tip:sched/core + SM_IDLE             0.90 [10.17%]
>    ==================================================================
>
>
> [ kprateek: Commit message, SM_RTLOCK_WAIT fix ]
>
> Link: https://lore.kernel.org/lkml/20240615012814.GP8774@noisy.programming.kicks-ass.net/
> Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>

Acked-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
> v1..v2:
>
> - Fixed SM_RTLOCK_WAIT being considered as preemption for task state
>   change on PREEMPT_RT kernels. Since (sched_mode & SM_MASK_PREEMPT) was
>   used in a couple of places, I decided to reuse the preempt variable.
>   (Vincent, Peter)
>
> - Seperated this patch from the newidle_balance() fixes series since
>   there are PREEMPT_RT bits that requires deeper review whereas this is
>   an independent enhancement on its own.

What is the status of the other part of v1 patchset to run idle load
balance instead of newly idle load balance ?

>
> - Updated the numbers based on latest tip:sched/core. In my testing the
>   v6.11-rc1 based tip gives better IPI throughput out of the box which
>   is why the improvements are respectable and not as massive as what was
>   reported on v6.10 based tip in v1.
>
> This series is based on tip:sched/core at commit cea5a3472ac4
> ("sched/fair: Cleanup fair_server")
>
> v1: https://lore.kernel.org/all/20240710090210.41856-1-kprateek.nayak@amd.com/
> ---
>  kernel/sched/core.c | 45 ++++++++++++++++++++++++++-------------------
>  1 file changed, 26 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 29fde993d3f8..6d55a30bb017 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6380,19 +6380,12 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
> @@ -6433,9 +6426,14 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>   *
>   * WARNING: must be called with preemption disabled!
>   */
> -static void __sched notrace __schedule(unsigned int sched_mode)
> +static void __sched notrace __schedule(int sched_mode)
>  {
>         struct task_struct *prev, *next;
> +       /*
> +        * On PREEMPT_RT kernel, SM_RTLOCK_WAIT is noted
> +        * as a preemption by schedule_debug() and RCU.
> +        */
> +       bool preempt = sched_mode > SM_NONE;
>         unsigned long *switch_count;
>         unsigned long prev_state;
>         struct rq_flags rf;
> @@ -6446,13 +6444,13 @@ static void __sched notrace __schedule(unsigned int sched_mode)
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
> @@ -6481,12 +6479,20 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>
>         switch_count = &prev->nivcsw;
>
> +       /* Task state changes only considers SM_PREEMPT as preemption */
> +       preempt = sched_mode == SM_PREEMPT;
> +
>         /*
>          * We must load prev->state once (task_struct::state is volatile), such
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
>                 if (signal_pending_state(prev_state, prev)) {
>                         WRITE_ONCE(prev->__state, TASK_RUNNING);
>                 } else {
> @@ -6520,6 +6526,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>         }
>
>         next = pick_next_task(rq, prev, &rf);
> +picked:
>         clear_tsk_need_resched(prev);
>         clear_preempt_need_resched();
>  #ifdef CONFIG_SCHED_DEBUG
> @@ -6561,7 +6568,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>                 psi_account_irqtime(rq, prev, next);
>                 psi_sched_switch(prev, next, !task_on_rq_queued(prev));
>
> -               trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next, prev_state);
> +               trace_sched_switch(preempt, prev, next, prev_state);
>
>                 /* Also unlocks the rq: */
>                 rq = context_switch(rq, prev, next, &rf);
> @@ -6637,7 +6644,7 @@ static void sched_update_worker(struct task_struct *tsk)
>         }
>  }
>
> -static __always_inline void __schedule_loop(unsigned int sched_mode)
> +static __always_inline void __schedule_loop(int sched_mode)
>  {
>         do {
>                 preempt_disable();
> @@ -6682,7 +6689,7 @@ void __sched schedule_idle(void)
>          */
>         WARN_ON_ONCE(current->__state);
>         do {
> -               __schedule(SM_NONE);
> +               __schedule(SM_IDLE);
>         } while (need_resched());
>  }
>
>
> base-commit: cea5a3472ac43f18590e1bd6b842f808347a810c
> --
> 2.34.1
>

