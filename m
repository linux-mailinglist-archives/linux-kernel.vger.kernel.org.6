Return-Path: <linux-kernel+bounces-216673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6F690A2D5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 05:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 933D72818CF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 03:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ABD17C7B3;
	Mon, 17 Jun 2024 03:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XUGJ8WVk"
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C5E12AD39
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 03:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718594469; cv=none; b=Y9LJtl9e+/z3svMlA8iRT1a3ZUatuIy3ueJxb2CaSEHmA30h7rkYqwimJM+rKiNKEtF7ALjWC7C+uSRlc2LU99SpD9pzNfa8BhQP0gDSYvIRWFgNKwY4o3BAYE1uziyOVRQs1r18x7CILlVF1Pi0gtnLjWJw2kLUQWLb940prJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718594469; c=relaxed/simple;
	bh=JLa//cSqvXOSR4IobIh4xH5O6x96y971b2BG9ccy3As=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rg5fsWISEUkPTTlRnpNyvd2++D894rfOJ5XMyDmIkJktYD9a5bJuwchAJyOXso8RL10tSmfjbirBSPLR3oWbSPp5UIKowhBC4DWqeNLLgdvXow2YIh9rbarPFaAN+KF8tUDFfuDb0gYaFx/2ur0cjmHPF3yk94aNEY8ZohpXO2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XUGJ8WVk; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718594458; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=pNRrXF7erodQEn2f5zAoQzhXrdHTfB7UhgabJTcNXN0=;
	b=XUGJ8WVkPSrszYx5XmMTAd4HT4XvbsW9B9qiNfeiQ/N+lLmAhMXOz8FfyOAAdPwjygGyoG5S8FRWWcHpahQ5CziYEIk/TudDQzgtOJIElAlT7jnxJc1xN+t2RlgFS6tsP14Yd9UrJfJOta7/zIsO4RohubSvuVcMnD6xVvDSJsg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R431e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0W8XFG82_1718594455;
Received: from 30.97.48.188(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0W8XFG82_1718594455)
          by smtp.aliyun-inc.com;
          Mon, 17 Jun 2024 11:20:57 +0800
Message-ID: <8e6f02a0-2bd0-4e75-9055-2cb7c508ce4e@linux.alibaba.com>
Date: Mon, 17 Jun 2024 11:20:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 29/35] sched: handle preempt=voluntary under
 PREEMPT_AUTO
Content-Language: en-US
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: tglx@linutronix.de, peterz@infradead.org, torvalds@linux-foundation.org,
 paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
 juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
 sshegde@linux.ibm.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
 Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <20240528003521.979836-30-ankur.a.arora@oracle.com>
From: Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <20240528003521.979836-30-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/5/28 08:35, Ankur Arora wrote:
> The default preemption policy for voluntary preemption under
> PREEMPT_AUTO is to schedule eagerly for tasks of higher scheduling
> class, and lazily for well-behaved, non-idle tasks.
> 
> This is the same policy as preempt=none, with an eager handling of
> higher priority scheduling classes.
> 
> Comparing a cyclictest workload with a background kernel load of
> 'stress-ng --mmap', shows that both the average and the maximum
> latencies improve:
> 
>   # stress-ng --mmap 0 &
>   # cyclictest --mlockall --smp --priority=80 --interval=200 --distance=0 -q -D 300
> 
>                                       Min     (  %stdev )    Act     (  %stdev )   Avg     (  %stdev )   Max      (  %stdev )
> 
>    PREEMPT_AUTO, preempt=voluntary    1.73  ( +-  25.43% )   62.16 ( +- 303.39% )  14.92 ( +-  17.96% )  2778.22 ( +-  15.04% )
>    PREEMPT_DYNAMIC, preempt=voluntary 1.83  ( +-  20.76% )  253.45 ( +- 233.21% )  18.70 ( +-  15.88% )  2992.45 ( +-  15.95% )
> 
> The table above shows the aggregated latencies across all CPUs.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Ziljstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>   kernel/sched/core.c  | 12 ++++++++----
>   kernel/sched/sched.h |  6 ++++++
>   2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index c25cccc09b65..2bc3ae21a9d0 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1052,6 +1052,9 @@ static resched_t resched_opt_translate(struct task_struct *curr,
>   	if (preempt_model_preemptible())
>   		return RESCHED_NOW;
>   
> +	if (preempt_model_voluntary() && opt == RESCHED_PRIORITY)
> +		return RESCHED_NOW;
> +
>   	if (is_idle_task(curr))
>   		return RESCHED_NOW;
>   
> @@ -2289,7 +2292,7 @@ void wakeup_preempt(struct rq *rq, struct task_struct *p, int flags)
>   	if (p->sched_class == rq->curr->sched_class)
>   		rq->curr->sched_class->wakeup_preempt(rq, p, flags);
>   	else if (sched_class_above(p->sched_class, rq->curr->sched_class))
> -		resched_curr(rq);
> +		resched_curr_priority(rq);
>   
Besides the conditions about higher class, can we do resched_curr_priority() in the same class?
For example, in fair class, we can do it when SCHED_NORMAL vs SCHED_IDLE.

Maybe sth like

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 41b58387023d..eedb70234bdd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8352,6 +8352,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
  	struct sched_entity *se = &curr->se, *pse = &p->se;
  	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
  	int cse_is_idle, pse_is_idle;
+	enum resched_opt opt = RESCHED_PRIORITY;
  
  	if (unlikely(se == pse))
  		return;
@@ -8385,7 +8386,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
  	/* Idle tasks are by definition preempted by non-idle tasks. */
  	if (unlikely(task_has_idle_policy(curr)) &&
  	    likely(!task_has_idle_policy(p)))
-		goto preempt;
+		goto preempt; /* RESCHED_PRIORITY */
  
  	/*
  	 * Batch and idle tasks do not preempt non-idle tasks (their preemption
@@ -8405,7 +8406,7 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
  	 * in the inverse case).
  	 */
  	if (cse_is_idle && !pse_is_idle)
-		goto preempt;
+		goto preempt; /* RESCHED_PRIORITY */
  	if (cse_is_idle != pse_is_idle)
  		return;
  
@@ -8415,13 +8416,15 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
  	/*
  	 * XXX pick_eevdf(cfs_rq) != se ?
  	 */
-	if (pick_eevdf(cfs_rq) == pse)
+	if (pick_eevdf(cfs_rq) == pse) {
+		opt = RESCHED_DEFAULT;
  		goto preempt;
+	}
  
  	return;
  
  preempt:
-	resched_curr(rq);
+	__resched_curr(rq, opt);
  }
  
  #ifdef CONFIG_SMP


