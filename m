Return-Path: <linux-kernel+bounces-295591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93070959EBD
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 15:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE0EAB241DA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 13:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264A519ABD7;
	Wed, 21 Aug 2024 13:34:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C721C19ABCC
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 13:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247248; cv=none; b=IPrXSDQkXVRR9wK94UD+7MQfBYy90JPWUj/ZNfRdmKHUv6EGOEla1kDgpjcgUqiUN+hKF/wwJlc5Kw4LtkIgoW6eEHCtB7b5qL678cYyqohIc1BJuMrnMQ8aWHu89qKWRq2jKh7MNhp9P4FOPvfNjMUSWxG19+sq0EMaqB5/AhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247248; c=relaxed/simple;
	bh=VYKQTFXQtybzA75ObVzaW7gnvupsfeFRG+ODm12b8U8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vC57UdOBbSPPWFgUvfR69D5hCYSfxxZsSMVwUiIn1YRUGT5SKseD13sig2HFDP8ksGviRKRmLlh4jCEG6WjrXX+vBtzClxjGJSJz3LtUAyeTVXiWAKF+Ox77/j9LA7W4cYneHOLDY5aYNJUsQpAgBDuLQRy5psi9CZbOclaVreM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 108E5DA7;
	Wed, 21 Aug 2024 06:34:31 -0700 (PDT)
Received: from [10.57.48.161] (unknown [10.57.48.161])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0502B3F66E;
	Wed, 21 Aug 2024 06:34:02 -0700 (PDT)
Message-ID: <6f39e567-fd9a-4157-949d-7a9ccd9c3592@arm.com>
Date: Wed, 21 Aug 2024 14:34:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
To: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
 juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
 vschneid@redhat.com, linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
 youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de,
 Luis Machado <luis.machado@arm.com>
References: <20240727102732.960974693@infradead.org>
 <20240727105029.315205425@infradead.org>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <20240727105029.315205425@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Peter,

Sorry for bombarding this thread in the last couple of days. I'm seeing 
several issues in the latest tip/sched/core after these patches landed.

What I'm now seeing seems to be an unbalanced util_est. First, I applied 
the following diff to warn against util_est != 0 when no tasks are on 
the queue:

https://lore.kernel.org/all/752ae417c02b9277ca3ec18893747c54dd5f277f.1724245193.git.hongyan.xia2@arm.com/

Then, I'm reliably seeing warnings on my Juno board during boot in 
latest tip/sched/core.

If I do the same thing to util_est just like what you did in this uclamp 
patch, like this:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 574ef19df64b..58aac42c99e5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6946,7 +6946,7 @@ enqueue_task_fair(struct rq *rq, struct 
task_struct *p, int flags)

  	if (flags & ENQUEUE_DELAYED) {
  		requeue_delayed_entity(se);
-		return;
+		goto util_est;
  	}

  	/*
@@ -6955,7 +6955,6 @@ enqueue_task_fair(struct rq *rq, struct 
task_struct *p, int flags)
  	 * Let's add the task's estimated utilization to the cfs_rq's
  	 * estimated utilization, before we update schedutil.
  	 */
-	util_est_enqueue(&rq->cfs, p);

  	/*
  	 * If in_iowait is set, the code below may not trigger any cpufreq
@@ -7050,6 +7049,9 @@ enqueue_task_fair(struct rq *rq, struct 
task_struct *p, int flags)
  	assert_list_leaf_cfs_rq(rq);

  	hrtick_update(rq);
+util_est:
+	if (!p->se.sched_delayed)
+		util_est_enqueue(&rq->cfs, p);
  }

  static void set_next_buddy(struct sched_entity *se);
@@ -7173,7 +7175,8 @@ static int dequeue_entities(struct rq *rq, struct 
sched_entity *se, int flags)
   */
  static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, 
int flags)
  {
-	util_est_dequeue(&rq->cfs, p);
+	if (!p->se.sched_delayed)
+		util_est_dequeue(&rq->cfs, p);

  	if (dequeue_entities(rq, &p->se, flags) < 0) {
  		if (!rq->cfs.h_nr_running)

which is basically enqueuing util_est after enqueue_task_fair(), 
dequeuing util_est before dequeue_task_fair() and double check 
p->se.delayed_dequeue, then the unbalanced issue seems to go away.

Hopefully this helps you in finding where the problem could be.

Hongyan

On 27/07/2024 11:27, Peter Zijlstra wrote:
> Delayed dequeue has tasks sit around on the runqueue that are not
> actually runnable -- specifically, they will be dequeued the moment
> they get picked.
> 
> One side-effect is that such a task can get migrated, which leads to a
> 'nested' dequeue_task() scenario that messes up uclamp if we don't
> take care.
> 
> Notably, dequeue_task(DEQUEUE_SLEEP) can 'fail' and keep the task on
> the runqueue. This however will have removed the task from uclamp --
> per uclamp_rq_dec() in dequeue_task(). So far so good.
> 
> However, if at that point the task gets migrated -- or nice adjusted
> or any of a myriad of operations that does a dequeue-enqueue cycle --
> we'll pass through dequeue_task()/enqueue_task() again. Without
> modification this will lead to a double decrement for uclamp, which is
> wrong.
> 
> Reported-by: Luis Machado <luis.machado@arm.com>
> Reported-by: Hongyan Xia <hongyan.xia2@arm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>   kernel/sched/core.c |   16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1676,6 +1676,9 @@ static inline void uclamp_rq_inc(struct
>   	if (unlikely(!p->sched_class->uclamp_enabled))
>   		return;
>   
> +	if (p->se.sched_delayed)
> +		return;
> +
>   	for_each_clamp_id(clamp_id)
>   		uclamp_rq_inc_id(rq, p, clamp_id);
>   
> @@ -1700,6 +1703,9 @@ static inline void uclamp_rq_dec(struct
>   	if (unlikely(!p->sched_class->uclamp_enabled))
>   		return;
>   
> +	if (p->se.sched_delayed)
> +		return;
> +
>   	for_each_clamp_id(clamp_id)
>   		uclamp_rq_dec_id(rq, p, clamp_id);
>   }
> @@ -1979,8 +1985,12 @@ void enqueue_task(struct rq *rq, struct
>   		psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
>   	}
>   
> -	uclamp_rq_inc(rq, p);
>   	p->sched_class->enqueue_task(rq, p, flags);
> +	/*
> +	 * Must be after ->enqueue_task() because ENQUEUE_DELAYED can clear
> +	 * ->sched_delayed.
> +	 */
> +	uclamp_rq_inc(rq, p);
>   
>   	if (sched_core_enabled(rq))
>   		sched_core_enqueue(rq, p);
> @@ -2002,6 +2012,10 @@ inline bool dequeue_task(struct rq *rq,
>   		psi_dequeue(p, flags & DEQUEUE_SLEEP);
>   	}
>   
> +	/*
> +	 * Must be before ->dequeue_task() because ->dequeue_task() can 'fail'
> +	 * and mark the task ->sched_delayed.
> +	 */
>   	uclamp_rq_dec(rq, p);
>   	return p->sched_class->dequeue_task(rq, p, flags);
>   }
> 
> 

