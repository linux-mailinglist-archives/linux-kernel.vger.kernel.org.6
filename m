Return-Path: <linux-kernel+bounces-306396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A215963E62
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 10:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC9B1C2218F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 08:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0134218C343;
	Thu, 29 Aug 2024 08:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HLY00qBJ"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D1518C327
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 08:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724920043; cv=none; b=mUIrqEh8w2fSDj9blVZdXTmP/kP7t+C4xw+20ei8zRYXMXV083ebn0VleCG++KvqOiYpixGGqVnL7NA8hmLTxeggPmEWxpGNwx/TP/lVl20Ii1UXYRoE4VRcZHtwEENbILNvTbhF4Pz1/SeyzoGmB0mHqI+tY1N1rMUyVxvBm7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724920043; c=relaxed/simple;
	bh=q8RkWOZsduoG5UpfLU23VXt2DfOskuBrY0U7O8AaMVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=apicFnVH9RZejl0+qhHD0Z3Axf5PpulmM3zuuEKahd7ekNcDX8QisdNX7BNAGuPaEEjP8EpFSnOGDpIxuBD1D1XyIx0b5P0cpadGbqNl/MZ75wuGaWXFyfV5CSs8mogqjEqUlGdT8D+XIf8V/udFJZ0/yOlQEHeLStgOHkhHfrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HLY00qBJ; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b6bf22e9-0d01-4e6b-bd06-4eaef73e76ce@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724920033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z4IX81RoSKRpORtKKtqo9Xgk/NT1kzOnZwSCBhIj1Ng=;
	b=HLY00qBJ6iPhp2xVu0Y9eupsVbgG6O7AjHJ495bKmIS7vShSXXSwXIJDq2laxzFRx/LVhQ
	toplZU6gnnHWzNKQh45m4ClYJDYNVcYSVv1w3/1eAX+k8eJ01p++HAJx0qEiawKIq8b2jC
	lbMALXq5vLx/30c10htibuyIPgzhD9Y=
Date: Thu, 29 Aug 2024 16:27:06 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] sched: psi: fix bogus pressure spikes from aggregation
 race
To: Johannes Weiner <hannes@cmpxchg.org>, bugzilla-daemon@kernel.org
Cc: Suren Baghdasaryan <surenb@google.com>,
 Peter Zijlstra <peterz@infradead.org>, Shakeel Butt <shakeelb@google.com>,
 linux-kernel@vger.kernel.org
References: <bug-219194-14699@https.bugzilla.kernel.org/>
 <20240826181900.GA3214@cmpxchg.org> <20240827121851.GB438928@cmpxchg.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20240827121851.GB438928@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/8/27 20:18, Johannes Weiner wrote:
> Sending a proper patch. Peter, can you please take this?
> 
> ---
> 
> Brandon reports sporadic, non-sensical spikes in cumulative pressure
> time (total=) when reading cpu.pressure at a high rate. This is due to
> a race condition between reader aggregation and tasks changing states.
> 
> While it affects all states and all resources captured by PSI, in
> practice it most likely triggers with CPU pressure, since scheduling
> events are so frequent compared to other resource events.
> 
> The race context is the live snooping of ongoing stalls during a
> pressure read. The read aggregates per-cpu records for stalls that
> have concluded, but will also incorporate ad-hoc the duration of any
> active state that hasn't been recorded yet. This is important to get
> timely measurements of ongoing stalls. Those ad-hoc samples are
> calculated on-the-fly up to the current time on that CPU; since the
> stall hasn't concluded, it's expected that this is the minimum amount
> of stall time that will enter the per-cpu records once it does.
> 
> The problem is that the path that concludes the state uses a CPU clock
> read that is not synchronized against aggregators; the clock is read
> outside of the seqlock protection. This allows aggregators to race and
> snoop a stall with a longer duration than will actually be recorded.
> 
> With the recorded stall time being less than the last snapshot
> remembered by the aggregator, a subsequent sample will underflow and
> observe a bogus delta value, resulting in an erratic jump in pressure.
> 
> Fix this by moving the clock read of the state change into the seqlock
> protection. This ensures no aggregation can snoop live stalls past the
> time that's recorded when the state concludes.
> 
> Reported-by: Brandon Duffany <brandon@buildbuddy.io>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=219194
> Fixes: df77430639c9 ("psi: Reduce calls to sched_clock() in psi")
> Cc: stable@vger.kernel.org
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Good catch!

Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>

Maybe another solution is to check the race happened on the read side,
then return delta as 0, right?

Thanks.

> ---
>   kernel/sched/psi.c | 26 ++++++++++++--------------
>   1 file changed, 12 insertions(+), 14 deletions(-)
> 
> diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
> index 020d58967d4e..84dad1511d1e 100644
> --- a/kernel/sched/psi.c
> +++ b/kernel/sched/psi.c
> @@ -769,12 +769,13 @@ static void record_times(struct psi_group_cpu *groupc, u64 now)
>   }
>   
>   static void psi_group_change(struct psi_group *group, int cpu,
> -			     unsigned int clear, unsigned int set, u64 now,
> +			     unsigned int clear, unsigned int set,
>   			     bool wake_clock)
>   {
>   	struct psi_group_cpu *groupc;
>   	unsigned int t, m;
>   	u32 state_mask;
> +	u64 now;
>   
>   	lockdep_assert_rq_held(cpu_rq(cpu));
>   	groupc = per_cpu_ptr(group->pcpu, cpu);
> @@ -789,6 +790,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
>   	 * SOME and FULL time these may have resulted in.
>   	 */
>   	write_seqcount_begin(&groupc->seq);
> +	now = cpu_clock(cpu);
>   
>   	/*
>   	 * Start with TSK_ONCPU, which doesn't have a corresponding
> @@ -899,18 +901,15 @@ void psi_task_change(struct task_struct *task, int clear, int set)
>   {
>   	int cpu = task_cpu(task);
>   	struct psi_group *group;
> -	u64 now;
>   
>   	if (!task->pid)
>   		return;
>   
>   	psi_flags_change(task, clear, set);
>   
> -	now = cpu_clock(cpu);
> -
>   	group = task_psi_group(task);
>   	do {
> -		psi_group_change(group, cpu, clear, set, now, true);
> +		psi_group_change(group, cpu, clear, set, true);
>   	} while ((group = group->parent));
>   }
>   
> @@ -919,7 +918,6 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>   {
>   	struct psi_group *group, *common = NULL;
>   	int cpu = task_cpu(prev);
> -	u64 now = cpu_clock(cpu);
>   
>   	if (next->pid) {
>   		psi_flags_change(next, 0, TSK_ONCPU);
> @@ -936,7 +934,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>   				break;
>   			}
>   
> -			psi_group_change(group, cpu, 0, TSK_ONCPU, now, true);
> +			psi_group_change(group, cpu, 0, TSK_ONCPU, true);
>   		} while ((group = group->parent));
>   	}
>   
> @@ -974,7 +972,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>   		do {
>   			if (group == common)
>   				break;
> -			psi_group_change(group, cpu, clear, set, now, wake_clock);
> +			psi_group_change(group, cpu, clear, set, wake_clock);
>   		} while ((group = group->parent));
>   
>   		/*
> @@ -986,7 +984,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
>   		if ((prev->psi_flags ^ next->psi_flags) & ~TSK_ONCPU) {
>   			clear &= ~TSK_ONCPU;
>   			for (; group; group = group->parent)
> -				psi_group_change(group, cpu, clear, set, now, wake_clock);
> +				psi_group_change(group, cpu, clear, set, wake_clock);
>   		}
>   	}
>   }
> @@ -997,8 +995,8 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
>   	int cpu = task_cpu(curr);
>   	struct psi_group *group;
>   	struct psi_group_cpu *groupc;
> -	u64 now, irq;
>   	s64 delta;
> +	u64 irq;
>   
>   	if (static_branch_likely(&psi_disabled))
>   		return;
> @@ -1011,7 +1009,6 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
>   	if (prev && task_psi_group(prev) == group)
>   		return;
>   
> -	now = cpu_clock(cpu);
>   	irq = irq_time_read(cpu);
>   	delta = (s64)(irq - rq->psi_irq_time);
>   	if (delta < 0)
> @@ -1019,12 +1016,15 @@ void psi_account_irqtime(struct rq *rq, struct task_struct *curr, struct task_st
>   	rq->psi_irq_time = irq;
>   
>   	do {
> +		u64 now;
> +
>   		if (!group->enabled)
>   			continue;
>   
>   		groupc = per_cpu_ptr(group->pcpu, cpu);
>   
>   		write_seqcount_begin(&groupc->seq);
> +		now = cpu_clock(cpu);
>   
>   		record_times(groupc, now);
>   		groupc->times[PSI_IRQ_FULL] += delta;
> @@ -1223,11 +1223,9 @@ void psi_cgroup_restart(struct psi_group *group)
>   	for_each_possible_cpu(cpu) {
>   		struct rq *rq = cpu_rq(cpu);
>   		struct rq_flags rf;
> -		u64 now;
>   
>   		rq_lock_irq(rq, &rf);
> -		now = cpu_clock(cpu);
> -		psi_group_change(group, cpu, 0, 0, now, true);
> +		psi_group_change(group, cpu, 0, 0, true);
>   		rq_unlock_irq(rq, &rf);
>   	}
>   }

