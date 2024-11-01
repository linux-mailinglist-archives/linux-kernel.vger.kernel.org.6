Return-Path: <linux-kernel+bounces-392231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 808499B9148
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05BDD1F222CF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04646158DD0;
	Fri,  1 Nov 2024 12:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OZCd8+8r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1D8433B3
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 12:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730465253; cv=none; b=UaJG7pqC8Jw9wO7Y1GygnyQDRVHkvKE3+0GU/DJ8F4sz7gvmKJuzpKaHk8H0jcJwC6pV11OEzDVxRe1FWNDzVeeJ/26AnKqELlzlKdgdDOyMCZeAcP1dpnQ5KJiak8xFMIozlhABClnJim5Exq7t+YqZo1QrVyFrMg+gMTUAhpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730465253; c=relaxed/simple;
	bh=P9Oh7kwpuJB0beKvhfKyelwHxMCRekfFKeoFYqBx8gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M35CsJ1MnWqYHb9L4vTHcu8GLMF+DGrvGJXRgRK5sQJHcvAmq2IxKMalBmDA2D6mrfgrDRxF+ipdnJEyqsrMdbCZ1cA05761QwtKxKKVAM/Jmox7PwStm1AJNjAI56BU/ob32E9IybLqZLRv9Skxm9oBsYfvi6b/Raj0+XeZzBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OZCd8+8r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730465249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LX0q/MEpetcUnOFBtGDXF2PPIdbiRSdt8gd7JoLBPAA=;
	b=OZCd8+8r+EJASScbpQP8MkVYEYKAzIpRKm1lrnPnUEskQeCfuDVKoFpJ/E1W3cbdj0b3L7
	w/HX42NhW3Ma8HB8se+VFxGHhEg3xCECGQe6lE/OXOnw4194GIaBn/5jLaTLbhUospStb+
	jhYeGo2i9dmUM9I++r5JBQXuRBDau6k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-2-EDo1E9msMpubF-WwlwYWdA-1; Fri,
 01 Nov 2024 08:47:25 -0400
X-MC-Unique: EDo1E9msMpubF-WwlwYWdA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D2C841954B21;
	Fri,  1 Nov 2024 12:47:22 +0000 (UTC)
Received: from pauld.westford.csb (unknown [10.22.88.10])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9954D19560A2;
	Fri,  1 Nov 2024 12:47:18 +0000 (UTC)
Date: Fri, 1 Nov 2024 08:47:15 -0400
From: Phil Auld <pauld@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	kprateek.nayak@amd.com, wuyun.abel@bytedance.com,
	youssefesmat@chromium.org, tglx@linutronix.de, efault@gmx.de
Subject: Re: [PATCH 17/24] sched/fair: Implement delayed dequeue
Message-ID: <20241101124715.GA689589@pauld.westford.csb>
References: <20240727102732.960974693@infradead.org>
 <20240727105030.226163742@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240727105030.226163742@infradead.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


Hi Peterm

On Sat, Jul 27, 2024 at 12:27:49PM +0200 Peter Zijlstra wrote:
> Extend / fix 86bfbb7ce4f6 ("sched/fair: Add lag based placement") by
> noting that lag is fundamentally a temporal measure. It should not be
> carried around indefinitely.
> 
> OTOH it should also not be instantly discarded, doing so will allow a
> task to game the system by purposefully (micro) sleeping at the end of
> its time quantum.
> 
> Since lag is intimately tied to the virtual time base, a wall-time
> based decay is also insufficient, notably competition is required for
> any of this to make sense.
> 
> Instead, delay the dequeue and keep the 'tasks' on the runqueue,
> competing until they are eligible.
> 
> Strictly speaking, we only care about keeping them until the 0-lag
> point, but that is a difficult proposition, instead carry them around
> until they get picked again, and dequeue them at that point.

This one is causing a 10-20% performance hit on our filesystem tests.

On 6.12-rc5 (so with the latest follow ons) we get:

with DELAY_DEQUEUE the bandwidth is 510 MB/s
with NO_DELAY_DEQUEUE the bandwidth is 590 MB/s

The test is fio, something like this:

taskset -c 1,2,3,4,5,6,7,8 fio --rw randwrite --bs 4k --runtime 1m --fsync 0 --iodepth 32 --direct 1 --ioengine libaio --numjobs 8 --size 30g --nrfiles 1 --loops 1 --name default --randrepeat 1 --time_based --group_reporting --directory /testfs

In this case it's ext4, but I'm not sure it will be FS specific.

I should have the machine and setup next week to poke further but I wanted
to mention it now just in case any one has an "aha" moment.

It seems to only effect these FS loads. Other perf tests are not showing any
issues that I am aware of.



Thanks,
Phil



> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/deadline.c |    1 
>  kernel/sched/fair.c     |   82 ++++++++++++++++++++++++++++++++++++++++++------
>  kernel/sched/features.h |    9 +++++
>  3 files changed, 81 insertions(+), 11 deletions(-)
> 
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2428,7 +2428,6 @@ static struct task_struct *__pick_next_t
>  		else
>  			p = dl_se->server_pick_next(dl_se);
>  		if (!p) {
> -			WARN_ON_ONCE(1);
>  			dl_se->dl_yielded = 1;
>  			update_curr_dl_se(rq, dl_se, 0);
>  			goto again;
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5379,20 +5379,44 @@ static void clear_buddies(struct cfs_rq
>  
>  static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
>  
> -static void
> +static bool
>  dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  {
> -	int action = UPDATE_TG;
> +	if (flags & DEQUEUE_DELAYED) {
> +		/*
> +		 * DEQUEUE_DELAYED is typically called from pick_next_entity()
> +		 * at which point we've already done update_curr() and do not
> +		 * want to do so again.
> +		 */
> +		SCHED_WARN_ON(!se->sched_delayed);
> +		se->sched_delayed = 0;
> +	} else {
> +		bool sleep = flags & DEQUEUE_SLEEP;
> +
> +		/*
> +		 * DELAY_DEQUEUE relies on spurious wakeups, special task
> +		 * states must not suffer spurious wakeups, excempt them.
> +		 */
> +		if (flags & DEQUEUE_SPECIAL)
> +			sleep = false;
> +
> +		SCHED_WARN_ON(sleep && se->sched_delayed);
> +		update_curr(cfs_rq);
>  
> +		if (sched_feat(DELAY_DEQUEUE) && sleep &&
> +		    !entity_eligible(cfs_rq, se)) {
> +			if (cfs_rq->next == se)
> +				cfs_rq->next = NULL;
> +			se->sched_delayed = 1;
> +			return false;
> +		}
> +	}
> +
> +	int action = UPDATE_TG;
>  	if (entity_is_task(se) && task_on_rq_migrating(task_of(se)))
>  		action |= DO_DETACH;
>  
>  	/*
> -	 * Update run-time statistics of the 'current'.
> -	 */
> -	update_curr(cfs_rq);
> -
> -	/*
>  	 * When dequeuing a sched_entity, we must:
>  	 *   - Update loads to have both entity and cfs_rq synced with now.
>  	 *   - For group_entity, update its runnable_weight to reflect the new
> @@ -5430,6 +5454,8 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
>  
>  	if (cfs_rq->nr_running == 0)
>  		update_idle_cfs_rq_clock_pelt(cfs_rq);
> +
> +	return true;
>  }
>  
>  static void
> @@ -5828,11 +5854,21 @@ static bool throttle_cfs_rq(struct cfs_r
>  	idle_task_delta = cfs_rq->idle_h_nr_running;
>  	for_each_sched_entity(se) {
>  		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
> +		int flags;
> +
>  		/* throttled entity or throttle-on-deactivate */
>  		if (!se->on_rq)
>  			goto done;
>  
> -		dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
> +		/*
> +		 * Abuse SPECIAL to avoid delayed dequeue in this instance.
> +		 * This avoids teaching dequeue_entities() about throttled
> +		 * entities and keeps things relatively simple.
> +		 */
> +		flags = DEQUEUE_SLEEP | DEQUEUE_SPECIAL;
> +		if (se->sched_delayed)
> +			flags |= DEQUEUE_DELAYED;
> +		dequeue_entity(qcfs_rq, se, flags);
>  
>  		if (cfs_rq_is_idle(group_cfs_rq(se)))
>  			idle_task_delta = cfs_rq->h_nr_running;
> @@ -6918,6 +6954,7 @@ static int dequeue_entities(struct rq *r
>  	bool was_sched_idle = sched_idle_rq(rq);
>  	int rq_h_nr_running = rq->cfs.h_nr_running;
>  	bool task_sleep = flags & DEQUEUE_SLEEP;
> +	bool task_delayed = flags & DEQUEUE_DELAYED;
>  	struct task_struct *p = NULL;
>  	int idle_h_nr_running = 0;
>  	int h_nr_running = 0;
> @@ -6931,7 +6968,13 @@ static int dequeue_entities(struct rq *r
>  
>  	for_each_sched_entity(se) {
>  		cfs_rq = cfs_rq_of(se);
> -		dequeue_entity(cfs_rq, se, flags);
> +
> +		if (!dequeue_entity(cfs_rq, se, flags)) {
> +			if (p && &p->se == se)
> +				return -1;
> +
> +			break;
> +		}
>  
>  		cfs_rq->h_nr_running -= h_nr_running;
>  		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
> @@ -6956,6 +6999,7 @@ static int dequeue_entities(struct rq *r
>  			break;
>  		}
>  		flags |= DEQUEUE_SLEEP;
> +		flags &= ~(DEQUEUE_DELAYED | DEQUEUE_SPECIAL);
>  	}
>  
>  	for_each_sched_entity(se) {
> @@ -6985,6 +7029,17 @@ static int dequeue_entities(struct rq *r
>  	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
>  		rq->next_balance = jiffies;
>  
> +	if (p && task_delayed) {
> +		SCHED_WARN_ON(!task_sleep);
> +		SCHED_WARN_ON(p->on_rq != 1);
> +
> +		/* Fix-up what dequeue_task_fair() skipped */
> +		hrtick_update(rq);
> +
> +		/* Fix-up what block_task() skipped. */
> +		__block_task(rq, p);
> +	}
> +
>  	return 1;
>  }
>  /*
> @@ -6996,8 +7051,10 @@ static bool dequeue_task_fair(struct rq
>  {
>  	util_est_dequeue(&rq->cfs, p);
>  
> -	if (dequeue_entities(rq, &p->se, flags) < 0)
> +	if (dequeue_entities(rq, &p->se, flags) < 0) {
> +		util_est_update(&rq->cfs, p, DEQUEUE_SLEEP);
>  		return false;
> +	}
>  
>  	util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
>  	hrtick_update(rq);
> @@ -12973,6 +13030,11 @@ static void set_next_task_fair(struct rq
>  		/* ensure bandwidth has been allocated on our new cfs_rq */
>  		account_cfs_rq_runtime(cfs_rq, 0);
>  	}
> +
> +	if (!first)
> +		return;
> +
> +	SCHED_WARN_ON(se->sched_delayed);
>  }
>  
>  void init_cfs_rq(struct cfs_rq *cfs_rq)
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -29,6 +29,15 @@ SCHED_FEAT(NEXT_BUDDY, false)
>  SCHED_FEAT(CACHE_HOT_BUDDY, true)
>  
>  /*
> + * Delay dequeueing tasks until they get selected or woken.
> + *
> + * By delaying the dequeue for non-eligible tasks, they remain in the
> + * competition and can burn off their negative lag. When they get selected
> + * they'll have positive lag by definition.
> + */
> +SCHED_FEAT(DELAY_DEQUEUE, true)
> +
> +/*
>   * Allow wakeup-time preemption of the current task:
>   */
>  SCHED_FEAT(WAKEUP_PREEMPTION, true)
> 
> 

-- 


