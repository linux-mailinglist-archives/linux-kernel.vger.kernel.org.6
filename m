Return-Path: <linux-kernel+bounces-326991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4738E976F8D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 19:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4060B240FB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 17:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D42C1BF7FD;
	Thu, 12 Sep 2024 17:29:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5D21BE86D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726162199; cv=none; b=MSL6ZExZQ9QO9lzP7Wxpa0HnHxyC3g/i4b9/pzIrFoFu6NewoENdunyiIEmj/1i93PRghY06HSLHxiWbHOiACQocTsI3uRMNrCzWlAUCEdljidJ73wHHL5y+H3umgL1NHoVTBt4vwoiRCCrlzqryspOIFw8imM9t+fAb6fbK+0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726162199; c=relaxed/simple;
	bh=r1UmhIQahkS50MEBKiPzTQW2X+QodUEbhFcc+9cRhVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=htgieqrxslQtxshemXrRXMKB1zl6rhHqysd1O6O70yWI0OUO43Ozl5bwzlSf9JMeCu0CcmOhIgN88Bc6MbCN7W0/itHAjnCcquBnhy1ONPgIYAS+LJld8zOzYY6UVWv03bhQiTJhsRWy3ATvgWvHsvOSnlB/tRM0JP6qeeZch2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 449D3DA7;
	Thu, 12 Sep 2024 10:30:23 -0700 (PDT)
Received: from [10.1.32.61] (e127648.arm.com [10.1.32.61])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 84A543F64C;
	Thu, 12 Sep 2024 10:29:49 -0700 (PDT)
Message-ID: <a608c2df-ce2b-45d8-94f5-16c830104d46@arm.com>
Date: Thu, 12 Sep 2024 18:29:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND x2][PATCH v12 5/7] sched: Consolidate pick_*_task to
 task_is_pushable helper
To: John Stultz <jstultz@google.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Connor O'Brien <connoro@google.com>, Joel Fernandes <joelaf@google.com>,
 Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Metin Kaya <Metin.Kaya@arm.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com
References: <20240910221235.2132138-1-jstultz@google.com>
 <20240910221235.2132138-6-jstultz@google.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240910221235.2132138-6-jstultz@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/10/24 23:12, John Stultz wrote:
> From: Connor O'Brien <connoro@google.com>
> 
> This patch consolidates rt and deadline pick_*_task functions to
> a task_is_pushable() helper
> 
> This patch was broken out from a larger chain migration
> patch originally by Connor O'Brien.
> 
> Cc: Joel Fernandes <joelaf@google.com>
> Cc: Qais Yousef <qyousef@layalina.io>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Zimuzo Ezeozue <zezeozue@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Metin Kaya <Metin.Kaya@arm.com>
> Cc: Xuewen Yan <xuewen.yan94@gmail.com>
> Cc: K Prateek Nayak <kprateek.nayak@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: kernel-team@android.com
> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Tested-by: Metin Kaya <metin.kaya@arm.com>
> Reviewed-by: Metin Kaya <metin.kaya@arm.com>
> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: Connor O'Brien <connoro@google.com>
> [jstultz: split out from larger chain migration patch,
>  renamed helper function]
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
> v7:
> * Split from chain migration patch
> * Renamed function
> v11:
> * Switched to bool (though later in the series it goes
>   to a tri-state return) for now to simplify review.
>   Will add tri-state handling later in the series when
>   its needed. Suggested by Metin and others.
> ---
>  kernel/sched/deadline.c | 10 +---------
>  kernel/sched/rt.c       | 11 +----------
>  kernel/sched/sched.h    | 10 ++++++++++
>  3 files changed, 12 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index ac60d2819bd1d..d3050f6c2958d 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2183,14 +2183,6 @@ static void task_fork_dl(struct task_struct *p)
>  /* Only try algorithms three times */
>  #define DL_MAX_TRIES 3
>  
> -static int pick_dl_task(struct rq *rq, struct task_struct *p, int cpu)
> -{
> -	if (!task_on_cpu(rq, p) &&
> -	    cpumask_test_cpu(cpu, &p->cpus_mask))
> -		return 1;
> -	return 0;
> -}
> -
>  /*
>   * Return the earliest pushable rq's task, which is suitable to be executed
>   * on the CPU, NULL otherwise:
> @@ -2209,7 +2201,7 @@ static struct task_struct *pick_earliest_pushable_dl_task(struct rq *rq, int cpu
>  	if (next_node) {
>  		p = __node_2_pdl(next_node);
>  
> -		if (pick_dl_task(rq, p, cpu))
> +		if (task_is_pushable(rq, p, cpu))
>  			return p;
>  
>  		next_node = rb_next(next_node);
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 496d3e6ab57d2..9f07f09641f7a 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -1790,15 +1790,6 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
>  /* Only try algorithms three times */
>  #define RT_MAX_TRIES 3
>  
> -static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
> -{
> -	if (!task_on_cpu(rq, p) &&
> -	    cpumask_test_cpu(cpu, &p->cpus_mask))
> -		return 1;
> -
> -	return 0;
> -}
> -
>  /*
>   * Return the highest pushable rq's task, which is suitable to be executed
>   * on the CPU, NULL otherwise
> @@ -1812,7 +1803,7 @@ static struct task_struct *pick_highest_pushable_task(struct rq *rq, int cpu)
>  		return NULL;
>  
>  	plist_for_each_entry(p, head, pushable_tasks) {
> -		if (pick_rt_task(rq, p, cpu))
> +		if (task_is_pushable(rq, p, cpu))
>  			return p;
>  	}
>  
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index d2cc31c2457e5..10ef612c078f9 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -3586,6 +3586,16 @@ void move_queued_task_locked(struct rq *src_rq, struct rq *dst_rq, struct task_s
>  	set_task_cpu(task, dst_rq->cpu);
>  	activate_task(dst_rq, task, 0);
>  }
> +
> +static inline
> +bool task_is_pushable(struct rq *rq, struct task_struct *p, int cpu)
> +{
> +	if (!task_on_cpu(rq, p) &&
> +	    cpumask_test_cpu(cpu, &p->cpus_mask))
> +		return true;
> +
> +	return false;
> +}

The slightly awkward
if (condition)
	return true;
return false;

is more convenient for you for the tri-state later, I assume.
Fine by me FWIW.
Reviewed-by: Christian Loehle <christian.loehle@arm.com>


