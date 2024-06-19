Return-Path: <linux-kernel+bounces-220914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA21990E919
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F32285AB6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA66F1369AA;
	Wed, 19 Jun 2024 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="I+xTZT2I"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B152747A40
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718795709; cv=none; b=eDOfhOKs/NAT8DGlmXXg0cLmNmn6mIlboz7sLjcYR3L1QC4fajDubqKpvORR9X5m7W+8h1uL8Ijp9IXp0Z9y0FSwF5H8goIPmcLEfE3nrsH2cHOnP6Ed+GVfbguxzrce9SGfGXN62CmkB4eD4YAvHQiqRQ+jaTz9k/c60HTSf5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718795709; c=relaxed/simple;
	bh=Vkgw8R8WIVUG17FwnI57U+cOToXWQOVzmSkJKZXyz3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AW1xV/olyt1Z6dcOirluSWCSbPl35m0BAdxzOnrgto0e3QbjOQEOWfTH6pZUW59aCD78uHhz3A4+JfMqEmymr09Iw5IHOiqtvPHA/qzCvpivjoJDxAM5FpcDGoBGM6/B5uPk2GqWnYrIzNoNutKtDYzCFnwy44Mx86cvxyU8Jdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=I+xTZT2I; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57d07464aa9so1015949a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1718795706; x=1719400506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aAO1X14gFtxi6b56QpuTsJvHFxiWMgSFziaIPiyAnUg=;
        b=I+xTZT2IL6Ek9vchpL+uiAxQhaDugGWLetrnlka+bUqXDbbYNja/chs7NUQeNrNcgy
         0WVRWXhLDRH92admIiMId1+dYUiIzPKOaQz5KDRslZ9EhzBH989Wf2babpgOCmpDEf6Q
         p+Oz6aHA0e8DPxNZA/nAOcW6Ykj8AQaR8V/EDu8jZzcvpPubJJHLdCll4P8H4L5O2+mt
         c1adQPsGsxhVcxPash6BslUSmDnQw6Iw5qRWyjNqQktj5531UDQHRc5uZIPUtVqt3eks
         bDM1Yf+P6T3yskHmMkbQAw6Eqgo9l+u5mk883w9Z5Z6WaxpA3RCLxnruvRZP+XftnSmZ
         sEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718795706; x=1719400506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aAO1X14gFtxi6b56QpuTsJvHFxiWMgSFziaIPiyAnUg=;
        b=X9KydTnkPnHmR0yJJDFAShCYS4IDTqnfjAk4iNpn6lrpY8DkwIPy6Eo1XFL3uenw7c
         UYV3DER9G8w9gbgPJzpAape4gZlWKkMK/8OhLhviHZOgOY9cxoZYouBaFcpyM28t+n7d
         TWnbLG89xVk7k4B9os/NYouMCoqnM5aTUM5jCjFP6sDf9HSpMlSyK7fDkKyLm6eTbYEr
         e4IVcQguPamY76+W6/0bVOywt5FzG36OAsaQjw2fBVLpXG2fsqWnMoyHZEVHyV5GlCGt
         feVNHRbxs56xp9rZzeEtA/Fpm0gLCsilMTbIBEe/6kGHyMRXkJFALnZNzbV2A30NgvyE
         Ef7A==
X-Gm-Message-State: AOJu0Yz5RKDeRcAXX2IUwJ9eqiTP/6M82j15zRzfNzDsdjG6gt15WHe5
	6FPUmZZxgj6oMQeIpUwnCJAgwFTAYVe3EWy4JWkMY7Muxim8YewKZJCkFy0GrnY=
X-Google-Smtp-Source: AGHT+IEPBkaVfWo66X2fbcjfRgEQFYmx5FyvPl/WuYrwQw3pKxj7uox76EGMRat1MZmog/cjEgLwEg==
X-Received: by 2002:a17:906:1b0d:b0:a6f:3155:bb89 with SMTP id a640c23a62f3a-a6fab7d6aeamr110995766b.70.1718795705730;
        Wed, 19 Jun 2024 04:15:05 -0700 (PDT)
Received: from airbuntu (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56db6182sm657482866b.51.2024.06.19.04.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 04:15:05 -0700 (PDT)
Date: Wed, 19 Jun 2024 12:15:04 +0100
From: Qais Yousef <qyousef@layalina.io>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Joel Fernandes <joel@joelfernandes.org>, kernel-team@android.com,
	Jimmy Shiu <jimmyshiu@google.com>
Subject: Re: [PATCH] sched: Move psi_account_irqtime() out of
 update_rq_clock_task() hotpath
Message-ID: <20240619111504.wnqhjpw6bj4uet2o@airbuntu>
References: <20240618215909.4099720-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240618215909.4099720-1-jstultz@google.com>

On 06/18/24 14:58, John Stultz wrote:
> It was reported that in moving to 6.1, a larger then 10%
> regression was seen in the performance of
> clock_gettime(CLOCK_THREAD_CPUTIME_ID,...).
> 
> Using a simple reproducer, I found:
> 5.10:
> 100000000 calls in 24345994193 ns => 243.460 ns per call
> 100000000 calls in 24288172050 ns => 242.882 ns per call
> 100000000 calls in 24289135225 ns => 242.891 ns per call
> 
> 6.1:
> 100000000 calls in 28248646742 ns => 282.486 ns per call
> 100000000 calls in 28227055067 ns => 282.271 ns per call
> 100000000 calls in 28177471287 ns => 281.775 ns per call
> 
> The cause of this was finally narrowed down to the addition of
> psi_account_irqtime() in update_rq_clock_task(), in commit
> 52b1364ba0b1 ("sched/psi: Add PSI_IRQ to track IRQ/SOFTIRQ
> pressure").
> 
> In my initial attempt to resolve this, I leaned towards moving
> all accounting work out of the clock_gettime() call path, but it
> wasn't very pretty, so it will have to wait for a later deeper
> rework. Instead, Peter shared this approach:
> 
> Rework psi_account_irqtime() to use its own psi_irq_time base
> for accounting, and move it out of the hotpath, calling it
> instead from sched_tick() and __schedule().

I think we can be more accurate towards group change if we check in
sched_move_task() if task is running. But as-is doesn't change current behavior
AFAICT.

Reviewed-by: Qais Yousef <qyousef@layalina.io>

> 
> In testing this, we found the importance of ensuring
> psi_account_irqtime() is run under the rq_lock, which Johannes
> Weiner helpfully explained, so also add some lockdep annotations
> to make that requirement clear.
> 
> With this change the performance is back in-line with 5.10:
> 6.1+fix:
> 100000000 calls in 24297324597 ns => 242.973 ns per call
> 100000000 calls in 24318869234 ns => 243.189 ns per call
> 100000000 calls in 24291564588 ns => 242.916 ns per call
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Chengming Zhou <zhouchengming@bytedance.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> Cc: Qais Yousef <qyousef@layalina.io>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: kernel-team@android.com
> Originally-by: Peter Zijlstra <peterz@infradead.org>
> Reported-by: Jimmy Shiu <jimmyshiu@google.com>
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
>  kernel/sched/core.c  |  7 +++++--
>  kernel/sched/psi.c   | 21 ++++++++++++++++-----
>  kernel/sched/sched.h |  1 +
>  kernel/sched/stats.h | 11 ++++++++---
>  4 files changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index bcf2c4cc0522..59ce0841eb1f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -723,7 +723,6 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
>  
>  	rq->prev_irq_time += irq_delta;
>  	delta -= irq_delta;
> -	psi_account_irqtime(rq->curr, irq_delta);
>  	delayacct_irq(rq->curr, irq_delta);
>  #endif
>  #ifdef CONFIG_PARAVIRT_TIME_ACCOUNTING
> @@ -5665,7 +5664,7 @@ void sched_tick(void)
>  {
>  	int cpu = smp_processor_id();
>  	struct rq *rq = cpu_rq(cpu);
> -	struct task_struct *curr = rq->curr;
> +	struct task_struct *curr;
>  	struct rq_flags rf;
>  	unsigned long hw_pressure;
>  	u64 resched_latency;
> @@ -5677,6 +5676,9 @@ void sched_tick(void)
>  
>  	rq_lock(rq, &rf);
>  
> +	curr = rq->curr;
> +	psi_account_irqtime(rq, curr, NULL);
> +
>  	update_rq_clock(rq);
>  	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
>  	update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
> @@ -6737,6 +6739,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>  		++*switch_count;
>  
>  		migrate_disable_switch(rq, prev);
> +		psi_account_irqtime(rq, prev, next);
>  		psi_sched_switch(prev, next, !task_on_rq_queued(prev));
>  
>  		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next, prev_state);
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 7b4aa5809c0f..507d7b8d79af 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -773,6 +773,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
>  	enum psi_states s;
>  	u32 state_mask;
>  
> +	lockdep_assert_rq_held(cpu_rq(cpu));
>  	groupc = per_cpu_ptr(group->pcpu, cpu);
>  
>  	/*
> @@ -991,22 +992,32 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>  }
>  
>  #ifdef CONFIG_IRQ_TIME_ACCOUNTING
> -void psi_account_irqtime(struct task_struct *task, u32 delta)
> +void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_struct *prev)
>  {
> -	int cpu = task_cpu(task);
> +	int cpu = task_cpu(curr);
>  	struct psi_group *group;
>  	struct psi_group_cpu *groupc;
> -	u64 now;
> +	u64 now, irq;
> +	s64 delta;
>  
>  	if (static_branch_likely(&psi_disabled))
>  		return;
>  
> -	if (!task->pid)
> +	if (!curr->pid)
> +		return;
> +
> +	lockdep_assert_rq_held(rq);
> +	group = task_psi_group(curr);
> +	if (prev && task_psi_group(prev) == group)
>  		return;
>  
>  	now = cpu_clock(cpu);
> +	irq = irq_time_read(cpu);
> +	delta = (s64)(irq - rq->psi_irq_time);
> +	if (delta < 0)
> +		return;
> +	rq->psi_irq_time = irq;
>  
> -	group = task_psi_group(task);
>  	do {
>  		if (!group->enabled)
>  			continue;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index a831af102070..ef20c61004eb 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1126,6 +1126,7 @@ struct rq {
>  
>  #ifdef CONFIG_IRQ_TIME_ACCOUNTING
>  	u64			prev_irq_time;
> +	u64			psi_irq_time;
>  #endif
>  #ifdef CONFIG_PARAVIRT
>  	u64			prev_steal_time;
> diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
> index 38f3698f5e5b..b02dfc322951 100644
> --- a/kernel/sched/stats.h
> +++ b/kernel/sched/stats.h
> @@ -110,8 +110,12 @@ __schedstats_from_se(struct sched_entity *se)
>  void psi_task_change(struct task_struct *task, int clear, int set);
>  void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>  		     bool sleep);
> -void psi_account_irqtime(struct task_struct *task, u32 delta);
> -
> +#ifdef CONFIG_IRQ_TIME_ACCOUNTING
> +void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_struct *prev);
> +#else
> +static inline void psi_account_irqtime(struct rq *rq, struct task_struct *curr,
> +				       struct task_struct *prev) {}
> +#endif /*CONFIG_IRQ_TIME_ACCOUNTING */
>  /*
>   * PSI tracks state that persists across sleeps, such as iowaits and
>   * memory stalls. As a result, it has to distinguish between sleeps,
> @@ -192,7 +196,8 @@ static inline void psi_ttwu_dequeue(struct task_struct *p) {}
>  static inline void psi_sched_switch(struct task_struct *prev,
>  				    struct task_struct *next,
>  				    bool sleep) {}
> -static inline void psi_account_irqtime(struct task_struct *task, u32 delta) {}
> +static inline void psi_account_irqtime(struct rq *rq, struct task_struct *curr,
> +				       struct task_struct *prev) {}
>  #endif /* CONFIG_PSI */
>  
>  #ifdef CONFIG_SCHED_INFO
> -- 
> 2.45.2.627.g7a2c4fd464-goog
> 

