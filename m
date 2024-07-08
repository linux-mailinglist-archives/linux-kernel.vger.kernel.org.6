Return-Path: <linux-kernel+bounces-244286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F01D92A236
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637D71C212D4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248C912CDB5;
	Mon,  8 Jul 2024 12:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hHcvL34I"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCA514F12C
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440187; cv=none; b=G3xnfO9oXiH8uSDCDZ0vdtgJyDfL+jre0B/bz6bYnB/CDCPMrL5a00enCdqzhY3Y1Rk1pIJ2Gz3lcqJHyOp7SzpfuYXn3FmSCCzFyoaaYSlvQ+uizUlK2aPETKC6619u8M0hOmwEWmDyFbBSUQwRwSeINvft6SJ+LuXZsAf/cVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440187; c=relaxed/simple;
	bh=PIaL/yqX99/BaglaH4odjyhKYxhBv42DHDN+EBZYDm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CeZgkJhJz181FTuCbV/D68K4TBGJpXPzlXYMY2SRBbnC3ppFdoLHMLq85kPwQAtseBX8TVPHa8ujvUsCiQXWH7PGMhBtGsycG9crs1zifpCxK6+dgqI2rYvBD7r6F8EHHCpsf3jRTzhe+YdxOUCa7m1Isbl+WXuBo9wPEuhOB7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hHcvL34I; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mz4HcF1cWkqY6j9aPHDhrm/cJCubNYXQhHFHVaVLed4=; b=hHcvL34I5tfBx1hROrG1RnVODG
	JRD1u3UytwKDxscg+TJ6dt82ZtHsy6nGHzHEzKiZkHMZWNd/r4KFr91bYmXqSLfi3TOMV/fhv1vNX
	UyedLIazJImeL/1qLMyZzY7lO9VuT3aYSs/vHp9IKhRCwzdbXqKzkRphGm64t9xJyTIUVTynKSV11
	EUR2BwatcDmkLVJ59gpORfkqofh4cWaxVwMOLHrLniq5/jmaT2YvtGN92+Lj4a88vXVkv9xCFnKvv
	wf4XUWTlZB93mhRD8TZnOD/njIkaVnWVmqb23es5Rww5X7whYLr5K712hIRCoMYI3CibOZiQvzrMO
	Ea3TQK9g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQn54-00000000azs-2VU5;
	Mon, 08 Jul 2024 12:02:54 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3B765300694; Mon,  8 Jul 2024 14:02:54 +0200 (CEST)
Date: Mon, 8 Jul 2024 14:02:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tianchen Ding <dtcccc@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Josh Don <joshdon@google.com>
Subject: Re: [PATCH v2] sched/fair: Make SCHED_IDLE entity be preempted in
 strict hierarchy
Message-ID: <20240708120254.GA27299@noisy.programming.kicks-ass.net>
References: <20240626023505.1332596-1-dtcccc@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626023505.1332596-1-dtcccc@linux.alibaba.com>

On Wed, Jun 26, 2024 at 10:35:05AM +0800, Tianchen Ding wrote:
> Consider the following cgroup:
> 
>                        root
>                         |
>              ------------------------
>              |                      |
>        normal_cgroup            idle_cgroup
>              |                      |
>    SCHED_IDLE task_A           SCHED_NORMAL task_B
> 
> According to the cgroup hierarchy, A should preempt B. But current
> check_preempt_wakeup_fair() treats cgroup se and task separately, so B
> will preempt A unexpectedly.
> Unify the wakeup logic by {c,p}se_is_idle only. This makes SCHED_IDLE of
> a task a relative policy that is effective only within its own cgroup,
> similar to the behavior of NICE.
> 
> Also fix se_is_idle() definition when !CONFIG_FAIR_GROUP_SCHED.
> 
> Fixes: 304000390f88 ("sched: Cgroup SCHED_IDLE support")
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> Reviewed-by: Josh Don <joshdon@google.com>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> v2:
> Use entity_is_task() to check whether pse is a task.
> Improve comments and commit log.
> 
> v1: https://lore.kernel.org/all/20240624073900.10343-1-dtcccc@linux.alibaba.com/
> ---
>  kernel/sched/fair.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 41b58387023d..f0b038de99ce 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -511,7 +511,7 @@ static int cfs_rq_is_idle(struct cfs_rq *cfs_rq)
>  
>  static int se_is_idle(struct sched_entity *se)
>  {
> -	return 0;
> +	return task_has_idle_policy(task_of(se));
>  }
>  
>  #endif	/* CONFIG_FAIR_GROUP_SCHED */
> @@ -8382,16 +8382,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  	if (test_tsk_need_resched(curr))
>  		return;
>  
> -	/* Idle tasks are by definition preempted by non-idle tasks. */
> -	if (unlikely(task_has_idle_policy(curr)) &&
> -	    likely(!task_has_idle_policy(p)))
> -		goto preempt;
> -
> -	/*
> -	 * Batch and idle tasks do not preempt non-idle tasks (their preemption
> -	 * is driven by the tick):
> -	 */
> -	if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
> +	if (!sched_feat(WAKEUP_PREEMPTION))
>  		return;
>  
>  	find_matching_se(&se, &pse);
> @@ -8401,7 +8392,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  	pse_is_idle = se_is_idle(pse);
>  
>  	/*
> -	 * Preempt an idle group in favor of a non-idle group (and don't preempt
> +	 * Preempt an idle entity in favor of a non-idle entity (and don't preempt
>  	 * in the inverse case).
>  	 */
>  	if (cse_is_idle && !pse_is_idle)
> @@ -8409,6 +8400,15 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>  	if (cse_is_idle != pse_is_idle)
>  		return;
>  
> +	/*
> +	 * Batch tasks do not preempt non-idle tasks (their preemption
> +	 * is driven by the tick).
> +	 * We've done the check about "only one of the entities is idle",
> +	 * so cse must be non-idle if p is a batch task.
> +	 */
> +	if (unlikely(entity_is_task(pse) && p->policy == SCHED_BATCH))
> +		return;

I'm not convinced this condition is right. The current behaviour of
SCHED_BATCH doesn't care about pse, only p.

That is, if p is SCHED_BATCH it will not preempt -- except an
SCHED_IDLE.

So I'm tempted to delete this first part of your condition and have it
be:

	if (p->policy == SCHED_BATCH)
		return;

That is, suppose you have:

                        root
                         |
              ------------------------
              |                      |
        normal_cgroup          normal_cgroup
              |                      |
        SCHED_BATCH task_A     SCHED_BATCH task_B

Then the preemption crud will end up comparing the groups to one another
and still allow A to preempt B -- except we explicitly do not want this.

The 'problem' is that the whole BATCH thing isn't cgroup aware ofcourse,
but I'm not sure we want to go fix that -- esp. not in this patch.

Hmm?

