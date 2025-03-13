Return-Path: <linux-kernel+bounces-559198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D45BA5F0D2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 679AD170E08
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 10:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54AE26619A;
	Thu, 13 Mar 2025 10:26:16 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87963264FBD
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 10:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861576; cv=none; b=LR/NiRHe81YcN89FVOQvUsQO2eyyvJNyfR1REcsCGtrt0yXIu+wDcaarPAUCbRgnB69B0j7z+E5Lodsq9HjuPYVOCPagNvrghiriuwmQPCK23O1ITIPPGEJUfbPRs3LzyfIYQled7DUxB3OEp6uP4sftLUNOqEoWpVdVAHbq9Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861576; c=relaxed/simple;
	bh=9/K/zL/rOPaaNXXCuel0ivaUnO8Ow1gfx6PgaGvzElE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P5N5cGK5MWHdVgJ4yc+C83OWA6XNRhT3RoBCE0OkteuwWB8FTvqmqJmlooSv4Ip1KhP2T/bNcCtNGyOFaIDC0dYe3We0GLLCwai2QYcDjZTQwgOwRvMWIF6rgg5R2yHYf2cXOFy7yAx7RJdtNjPMdvjIFrLANEqXm2ryo/OON6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62804C4CEEE;
	Thu, 13 Mar 2025 10:26:10 +0000 (UTC)
Date: Thu, 13 Mar 2025 06:26:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes
 <joelagnelf@nvidia.com>, Qais Yousef <qyousef@layalina.io>, Ingo Molnar
 <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
 <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Valentin Schneider
 <vschneid@redhat.com>, Ben Segall <bsegall@google.com>, Zimuzo Ezeozue
 <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, Will Deacon
 <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng
 <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya
 <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>, Daniel
 Lezcano <daniel.lezcano@linaro.org>, Suleiman Souhlal
 <suleiman@google.com>, kernel-team@android.com
Subject: Re: [RFC PATCH v15 4/7] sched: Fix runtime accounting w/ split exec
 & sched contexts
Message-ID: <20250313062607.5fd9052e@batman.local.home>
In-Reply-To: <20250312221147.1865364-5-jstultz@google.com>
References: <20250312221147.1865364-1-jstultz@google.com>
	<20250312221147.1865364-5-jstultz@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Mar 2025 15:11:34 -0700
John Stultz <jstultz@google.com> wrote:

> The idea here is we want to charge the scheduler-context task's
> vruntime but charge the execution-context task's sum_exec_runtime.

The "but" is confusing me. Do you mean, "and also"? The sentence
doesn't make sense with "but" unless it was:

  "The idea here is we DON'T want to charge the scheduler-context
  task's vruntime but charge the execution-context task's
  sum_exec_runtime INSTEAD."

> 
> This way cputime accounting goes against the task actually running
> but vruntime accounting goes against the rq->donor task so we get
> proper fairness.

But this shows that you want to do both, although, I would remove the
"but" here too. Replace it with "while".

Or maybe I'm just confused.


> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index c798d27952431..f8ad3a44b3771 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1129,22 +1129,33 @@ static void update_tg_load_avg(struct cfs_rq *cfs_rq)
>  }
>  #endif /* CONFIG_SMP */
>  
> -static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
> +static s64 update_curr_se(struct rq *rq, struct sched_entity *se)

Should this be renamed to "update_se()" as it no longer appears to be
updating "curr_se".

>  {
>  	u64 now = rq_clock_task(rq);
>  	s64 delta_exec;
>  
> -	delta_exec = now - curr->exec_start;
> +	delta_exec = now - se->exec_start;
>  	if (unlikely(delta_exec <= 0))
>  		return delta_exec;
>  
> -	curr->exec_start = now;
> -	curr->sum_exec_runtime += delta_exec;
> +	se->exec_start = now;
> +	if (entity_is_task(se)) {
> +		struct task_struct *running = rq->curr;
> +		/*
> +		 * If se is a task, we account the time against the running
> +		 * task, as w/ proxy-exec they may not be the same.
> +		 */
> +		running->se.exec_start = now;
> +		running->se.sum_exec_runtime += delta_exec;
> +	} else {
> +		/* If not task, account the time against se */
> +		se->sum_exec_runtime += delta_exec;
> +	}

Or maybe: update_proxy_se() ?

-- Steve

>  
>  	if (schedstat_enabled()) {
>  		struct sched_statistics *stats;
>  
> -		stats = __schedstats_from_se(curr);
> +		stats = __schedstats_from_se(se);
>  		__schedstat_set(stats->exec_max,
>  				max(delta_exec, stats->exec_max));
>  	}


