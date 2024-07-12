Return-Path: <linux-kernel+bounces-250810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2915992FD1A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 17:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6AAA28272D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 15:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7DE171E74;
	Fri, 12 Jul 2024 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cgcbCq/f"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7258821
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720796535; cv=none; b=Ff+lzRifoKE0HNn9i7iZt2aL3tLZYsAnabVzddiBuMnhGBOBwcPVzp50x3gvgAFh2NVPjoncTmBaNrTu6wPx4rYi478WAxs6+dsp7vuZXwxCP3vfsCjC3pGwtHb7jntoxXZNmEolEOOZimx7MFnic69+oHkQN6qhyq5TouCaGX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720796535; c=relaxed/simple;
	bh=8E9j3ZAKWdl+n60rLkky2PxV9OV2pVNk7/Cp7ddbJKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JzJZlfKc4mK18MjdTty/jzIEUvwzPw7JFn3wfX9HbsLd7VK9BJhZbc3yQJ0rT8b4KWQA2zsAmn6akn3zcAux/ea2kM5eLfcNyiKgxcjneZb/YxxQEqP4xQXPnCbHC5dZ4ArvFoUP5G75ZD88OxlUyTS7S+ej6v0tbV9Ftn9Emn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cgcbCq/f; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Bx6/Jc8wr5QcWBMYhgxcnmehYZKsuTxKPdrZgXfalRA=; b=cgcbCq/fUfmKi3awvdVo2FF7wF
	383NzLjLSOgDY0lgXSc93Tc549PqkC2KGivxL3OpkJuWWmKQ2CGAA+1kd6TaPXxZUV9ET3UAYjSFB
	ZaPdisWYePwAPhupo1HLoG4SFVMnH5C416kIdli3pajCpOmoBBgP7cmuUxsdzr1anTB3SitfCqaHg
	yHAAWZ16OSRcY35eIIfL8wH51SrJW0X4O7HVzbrr+JAxpauZfqgu4ov/U4wJzH5hphrILROcqNOBF
	qH288DS+kkVlpwsIOMn5DpRrRy7FTeH0ASJTygknLBWPAHrCG6TK5NIu0sHkBLtIj53ZzFWm4G/45
	xzEyngDA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSHmY-00000001Jps-30mI;
	Fri, 12 Jul 2024 15:01:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 38CD330050D; Fri, 12 Jul 2024 17:01:58 +0200 (CEST)
Date: Fri, 12 Jul 2024 17:01:58 +0200
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
	Zimuzo Ezeozue <zezeozue@google.com>,
	Youssef Esmat <youssefesmat@google.com>,
	Mel Gorman <mgorman@suse.de>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Xuewen Yan <xuewen.yan94@gmail.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Metin Kaya <Metin.Kaya@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com,
	Connor O'Brien <connoro@google.com>
Subject: Re: [PATCH v11 7/7] sched: Split scheduler and execution contexts
Message-ID: <20240712150158.GM27299@noisy.programming.kicks-ass.net>
References: <20240709203213.799070-1-jstultz@google.com>
 <20240709203213.799070-8-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709203213.799070-8-jstultz@google.com>

On Tue, Jul 09, 2024 at 01:31:50PM -0700, John Stultz wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> Let's define the scheduling context as all the scheduler state
> in task_struct for the task selected to run, and the execution
> context as all state required to actually run the task.
> 
> Currently both are intertwined in task_struct. We want to
> logically split these such that we can use the scheduling
> context of the task selected to be scheduled, but use the
> execution context of a different task to actually be run.
> 
> To this purpose, introduce rq_selected() macro to point to the
> task_struct selected from the runqueue by the scheduler, and
> will be used for scheduler state, and preserve rq->curr to
> indicate the execution context of the task that will actually be
> run.

> * Swapped proxy for selected for clarity

I'm not loving this naming...  what does selected even mean? What was
wrong with proxy? -- (did we have this conversation before?)

> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 493de4cc320a..7ee8c7fa0ae8 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1051,7 +1051,7 @@ struct rq {
>  	 */
>  	unsigned int		nr_uninterruptible;
>  
> -	struct task_struct __rcu	*curr;
> +	struct task_struct __rcu	*curr;       /* Execution context */
>  	struct task_struct	*idle;
>  	struct task_struct	*stop;
>  	unsigned long		next_balance;
> @@ -1246,6 +1246,13 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
>  #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
>  #define raw_rq()		raw_cpu_ptr(&runqueues)
>  
> +/* For now, rq_selected == rq->curr */
> +#define rq_selected(rq)		((rq)->curr)
> +static inline void rq_set_selected(struct rq *rq, struct task_struct *t)
> +{
> +	/* Do nothing */
> +}
> +
>  struct sched_group;
>  #ifdef CONFIG_SCHED_CORE
>  static inline struct cpumask *sched_group_span(struct sched_group *sg);
> @@ -2151,11 +2158,25 @@ static inline u64 global_rt_runtime(void)
>  	return (u64)sysctl_sched_rt_runtime * NSEC_PER_USEC;
>  }
>  
> +/*
> + * Is p the current execution context?
> + */
>  static inline int task_current(struct rq *rq, struct task_struct *p)
>  {
>  	return rq->curr == p;
>  }
>  
> +/*
> + * Is p the current scheduling context?
> + *
> + * Note that it might be the current execution context at the same time if
> + * rq->curr == rq_selected() == p.
> + */
> +static inline int task_current_selected(struct rq *rq, struct task_struct *p)
> +{
> +	return rq_selected(rq) == p;
> +}


And I think I hated on the macros before, and you said you needed them
to to allow !PROXY builds.

But what about something like:

#ifdef CONFIG_PROXY_EXEC
	struct task_struct __rcu *proxy;
	struct task_struct __rcu *curr;
#else
	union {
		struct task_struct __rcu *proxy;
		struct task_struct __rcu *curr;
	};
#endif


And then we can use rq->proxy and rq->curr like the good old days?


I realize this is going to be a lot of typing to fix up, and perhaps
there's a reason to not do this. But...

