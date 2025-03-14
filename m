Return-Path: <linux-kernel+bounces-561740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5E2A6158B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 16:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5644189ECFE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 15:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8D820299E;
	Fri, 14 Mar 2025 15:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="c1fhjJ0O"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E871F4716
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 15:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741967959; cv=none; b=saq9JvVA7ngzavakPVdfXqwTFpMr8Y3PI+v2UMhUgKCp6DT1MmVGsnLacoInj5MHcJEDpmMou1fdjpn3fQnO9CPiZIyeOiuYmBXhEnXnRlMH6dFAX+w19PbsYSVoMLPES6xIQC55XXSxmWIHoD6ZQ2QdrSUA9sF2XnEiwUiwHxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741967959; c=relaxed/simple;
	bh=ll8a/hg9UdreoNRTfjWLCxMvZd5ZfiYM4psECWw1BuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AyY8FL06WjxtHYYTDepeXyiW/bU5gwWHRiu+GFs9YF1xxJY7vWhHRt5pJraAQEyiH6MJUSgpoXol0/TcPSIV6v8l1Iip6jIbDfo762cqOCSwO4azzTQErajhwe+6GEeWpSdrZDMX3GFqKB/PxBqhcoLNsheIqINBWVj77SHKP/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=c1fhjJ0O; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a86eb8c7-c692-463a-acda-7624e4686163@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741967954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SB9kg4bIO35id5dGgluGovaGuiMNXsQvJzZnNuk55iY=;
	b=c1fhjJ0ONQpfYVcZbxxldJRhUjWH5r31mHWoR7XoNGS11Fw3V6WyufBSytKz5jZRMsHGM2
	7impd3UCyQrHbsbrFddD8HD6Lv5F2gNeiWJWRGFqJwl1tcNxRCdVgLlu08pvNI3vdJgac+
	oLgEqH9X6NPVi+WIN1xu2QmvL8bdB1k=
Date: Fri, 14 Mar 2025 23:58:55 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC PATCH 2/7] sched/fair: Handle throttle path for task based
 throttle
To: Aaron Lu <ziqianlu@bytedance.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Valentin Schneider <vschneid@redhat.com>, Ben Segall
 <bsegall@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org,
 Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
 Chuyi Zhou <zhouchuyi@bytedance.com>
References: <20250313072030.1032893-1-ziqianlu@bytedance.com>
 <CANCG0GcFF7cnR4rCbU5MmY1Gq3M+r4gPXv39QPXXC=Cdr6sRww@mail.gmail.com>
 <58e0515a-ed67-4d1a-825f-bfc2b31d1d18@linux.dev>
 <20250314094249.GC1633113@bytedance>
 <6688eade-8eec-4d76-87f2-637425b1c2d2@amd.com>
 <20250314114738.GI1633113@bytedance>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20250314114738.GI1633113@bytedance>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2025/3/14 19:47, Aaron Lu wrote:
> Hi Prateek,
> 
> On Fri, Mar 14, 2025 at 03:56:26PM +0530, K Prateek Nayak wrote:
>> Hello Aaron,
>>
>> On 3/14/2025 3:12 PM, Aaron Lu wrote:
>>>> Then then if we pick a task from a throttled cfs_rq subtree, we can setup task work
>>>> for it, so we don't botter with the delayed_dequeue task case that Prateek mentioned.
>>> If we add a check point in pick time, maybe we can also avoid the check
>>> in enqueue time. One thing I'm thinking is, for a task, it may be picked
>>> multiple times with only a single enqueue so if we do the check in pick,
>>> the overhead can be larger?
>>
>> I think it can be minimized to a good extent. Something like:
> 
> I see, thanks for the illustration.
> 
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index d646451d617c..ba6571368840 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -5942,6 +5942,9 @@ static inline bool task_has_throttle_work(struct task_struct *p)
>>   static inline void task_throttle_setup_work(struct task_struct *p)
>>   {
>> +	if (task_has_throttle_work(p))
>> +		return;
>> +
>>   	/*
>>   	 * Kthreads and exiting tasks don't return to userspace, so adding the
>>   	 * work is pointless
>> @@ -5949,9 +5952,6 @@ static inline void task_throttle_setup_work(struct task_struct *p)
>>   	if ((p->flags & (PF_EXITING | PF_KTHREAD)))
>>   		return;
>> -	if (task_has_throttle_work(p))
>> -		return;
>> -
>>   	task_work_add(p, &p->sched_throttle_work, TWA_RESUME);
>>   }
>> @@ -6000,12 +6000,6 @@ static int tg_throttle_down(struct task_group *tg, void *data)
>>   		node = rb_next(node);
>>   	}
>> -	/* curr is not in the timeline tree */
>> -	if (cfs_rq->curr && entity_is_task(cfs_rq->curr)) {
>> -		p = task_of(cfs_rq->curr);
>> -		task_throttle_setup_work(p);
>> -	}
>> -
> 
> Should we also remove adding throttle work for those tasks in
> cfs_rq->tasks_timeline?
> 
>>   	return 0;
>>   }
>> @@ -6049,6 +6043,18 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
>>   	SCHED_WARN_ON(cfs_rq->throttled_clock);
>>   	if (cfs_rq->nr_queued)
>>   		cfs_rq->throttled_clock = rq_clock(rq);
>> +
>> +	/*
>> +	 * If cfs_rq->curr is set, check if current task is queued
>> +	 * and set up the throttle work proactively.
>> +	 */
>> +	if (cfs_rq->curr) {
>> +		struct task_struct *p = rq->donor; /* scheduling context with proxy */
> 
> I'll have to check what rq->donor means.
> I think the point is to proactively add throttle work for rq->curr if
> rq->curr is in this throttled hierarchy? Because the only check point to
> add throttle work will be at pick time and curr will probably not be
> picked anytime soon.

The cfs_rq based throttle use update_curr() -> put_prev_task(), so it just
resched_curr() in update_curr().

With per-task throttle, we don't need to call resched_curr(), we should
setup throttle work for this curr, which will dequeue & resched when ret2user.

Thanks.

> 
> Thanks,
> Aaron
> 
>> +
>> +		if (task_on_rq_queued(p))
>> +			task_throttle_setup_work(p);
>> +	}
>> +
>>   	return;
>>   }
>> @@ -8938,6 +8944,13 @@ pick_next_task_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf
>>   		struct sched_entity *pse = &prev->se;
>>   		struct cfs_rq *cfs_rq;
>> +		/*
>> +		 * Check if throttle work needs to be setup when
>> +		 * switching to a different task.
>> +		 */
>> +		if (throttled_hierarchy(cfs_rq_of(se)))
>> +			task_throttle_setup_work(p);
>> +
>>   		while (!(cfs_rq = is_same_group(se, pse))) {
>>   			int se_depth = se->depth;
>>   			int pse_depth = pse->depth;
>> @@ -13340,6 +13353,9 @@ static void set_next_task_fair(struct rq *rq, struct task_struct *p, bool first)
>>   		account_cfs_rq_runtime(cfs_rq, 0);
>>   	}
>> +	if (throttled_hierarchy(cfs_rq_of(se)))
>> +		task_throttle_setup_work(p);
>> +
>>   	__set_next_task_fair(rq, p, first);
>>   }
>> --
>>
>> .. with the additional plumbing in place of course.
>>
>> -- 
>> Thanks and Regards,
>> Prateek
>>

