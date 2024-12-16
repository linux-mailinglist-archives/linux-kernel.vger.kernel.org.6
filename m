Return-Path: <linux-kernel+bounces-447791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F709F3705
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 18:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1FD91893096
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEAF204566;
	Mon, 16 Dec 2024 17:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pSqpYe6h"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884B11C54A6
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734368864; cv=none; b=a47FWyJwQ3idjmnp0nH1G/3st5Qb14LF1W/KsXOPLoMPvZLp10gB6j4ndpEpCW/GGz6hLNUpISkcdVlBmAUWUWX2cjWiWbW1Ly2uVx622WiMYjhGa8JuMV5c/AbvOR434NzwDAXk3YIlfOVngELOltrg55OuSTyhk2ipsUK/Q20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734368864; c=relaxed/simple;
	bh=E5/d+dReIUhXuHg1v7oS8ktr7gb/WIyds77UdfRtRzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJ0n49FO13jJ0rHYrCBv+/O7fnO+J1c7GzPEXmvEOppVAiuOJ7DkA92xJOqSDNxOa0hsgT+x8k1fmBet9YCgtpVTJxuHlZoJN8E21RIDX/WtVRYameSzeYkf2f8VUvvEfXhkCBEIhlaYwBvQ1tDkpvn9AiZK38+JpVeMtiCGJXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pSqpYe6h; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Iaz1+7lGVC6B2me2Y4rdlfpafrRn2ZXS3uJsTcllWUc=; b=pSqpYe6h9U7cQYccX/5H2Wa5iw
	O8xSW3tR0XEml5PHVhlGxEtjv+Mdn8P2J+kbpPc7n75r/qlIHCcr+fRriiXlbxJuMwzJ1kv8DPpFO
	UyWqeJWJXd96I0mIQ6BCzX4q+FfRYMufNXvvbTdyN2DOj40NHFZo65L0C8/k7LurZDAaevb29LwQb
	oPW8AJ0DlwwqWEe5GjpDxtDpaLpzo9azINnmxsk3wtThV6WGL0j3n1/zaw/WctQYvYa0pboZZuOEK
	ePogUSS2QA+Hx2FRGZZ95DFNSIxjPzFvRgI/ApYuy5RCbVaNOEqVp9mDgj4ExFZxoNqGcxjz4c9Dk
	0F2kiVoQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tNEZD-00000004uZn-0hyj;
	Mon, 16 Dec 2024 17:07:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B1A9D3003FF; Mon, 16 Dec 2024 18:07:34 +0100 (CET)
Date: Mon, 16 Dec 2024 18:07:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>,
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com,
	Connor O'Brien <connoro@google.com>
Subject: Re: [RFC][PATCH v14 2/7] locking/mutex: Rework
 task_struct::blocked_on
Message-ID: <20241216170734.GG12500@noisy.programming.kicks-ass.net>
References: <20241125195204.2374458-1-jstultz@google.com>
 <20241125195204.2374458-3-jstultz@google.com>
 <20241213232214.GA17501@noisy.programming.kicks-ass.net>
 <CANDhNCraMepXyQPs1q-aNa+Gh745WpaFPkngA9Eohi9vXRpe+w@mail.gmail.com>
 <20241216165419.GE35539@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216165419.GE35539@noisy.programming.kicks-ass.net>

On Mon, Dec 16, 2024 at 05:54:19PM +0100, Peter Zijlstra wrote:

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 6eaffa913495..30d7371bb5c4 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4035,6 +4035,53 @@ static inline void activate_blocked_entities(struct rq *target_rq,
>  }
>  #endif /* CONFIG_SCHED_PROXY_EXEC */
>  
> +struct task_struct *proxy_handoff(struct mutex *lock);
> +{
> +	struct task_struct *next;
> +
> +	if (!sched_proxy_exec())
> +		return NULL;
> +
> +	/*
> +	 * current->blocked_donor can't change if we can't schedule
> +	 * caller needs to do this, since its needs stabiliy of return value
> +	 */
> +	lockdep_assert_preemption_disabled();
> +	next = current->blocked_donor;
> +	if (!next)
> +		return NULL;
> +
> +	scoped_guard (task_rq_lock, next) {
> +		/*
> +		 * current->blocked_donor had better be on the same CPU as current
> +		 */
> +		WARN_ON_ONCE(scope.rq != this_rq());
> +
> +		scoped_guard (raw_spin_lock, next->blocked_lock) {
> +			/*
> +			 * WARN_ON on this? How can this happen
> +			 */
> +			if (next->blocked_on != lock)
> +				return NULL;
> +		}
> +
> +		/*
> +		 * blocked_on relation is stable, since we hold both
> +		 * next->pi_lock and it's rq->lock
> +		 *
> +		 * OK -- we have a donor, it is blocked on the lock we're about
> +		 * to release and it cannot run on this CPU -- fixies are
> +		 * required.
> +		 *
> +		 * Dequeue the task, such that ttwu() can fix up the placement thing.
> +		 */
> +		if (!is_cpu_allowed(next, cpu_of(scope.rq)))
> +			deactivate_task(scope.rq, next, DEQUEUE_SLEEP);
> +	}

It is probably better to do:

	scoped_guard (raw_spin_lock_irq, next->pi_lock) {

		int cpu = smp_processor_id();
		WARN_ON_ONCE(task_cpu(next) != cpu);

		...

		if (!is_cpu_allowed(next, cpu)) {
			struct rq_flags rf;
			struct rq *rq;
			rq = __task_rq_lock(next, &rf);
			deactivate_task(rq, next, DEQUEUE_SLEEP);
			__task_rq_unlock(rq, &rf);
		}
	}	

In order to minize the amount or rq->lock'ing.

> +
> +	return next;
> +}
> +
>  #ifdef CONFIG_SMP
>  static inline bool proxy_needs_return(struct rq *rq, struct task_struct *p)
>  {

