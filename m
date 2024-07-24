Return-Path: <linux-kernel+bounces-260563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E3393AAEF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 04:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C71C5283BA6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jul 2024 02:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1EB5168DA;
	Wed, 24 Jul 2024 02:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JPVoR37Q"
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0885079F0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jul 2024 02:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721787147; cv=none; b=aGI4cbSpZy3dlrGrCfbXE0Y7+uTtW+ere9yk+uWcfQl3G3S+Y6cqWblX6wH6p20mvncUcV/qiUi6X1w+DlszqsO9EUNtT7N1+tsEcBIl0idUt6yIAHFGF44nbcjotf9HEawRAEP2ujLLQF3DKRl1MOAmozt2rKCGGI0qEAvzMk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721787147; c=relaxed/simple;
	bh=jF7D4PluNHqGc9bf8TvKwLZKi/g+CHtJF6A441Mu2i8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KY9nOyjoRro/eb1J87Eu6nmfso0+0WdQbSw3iYqwJrpyWimd3PFoNSfiP5n5sAIItHnkOVkwmi1lCUW2EJ7bD9Dm+UIVAxBRZXHrrMPtklzGWyzntPRpLJjN/wEGeJsk4nsr/oDNP/RrKUtH35X3bZJVOu/GttAGasRTI6m9Ycs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JPVoR37Q; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bc8e5905-7729-4263-84e2-ca86a710eccd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721787143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+vRPKr2NussoOTDsnv1rEmg+AtFEVRhZiH7byVE1HhM=;
	b=JPVoR37QKUVdzh9lnZqYOj1VRKiEMKui13g965GPUqngTwlB7DHrUMpAjTiDI/3ITYpBoV
	AlZnj9mETYyAJ2eGq3oQbjjgfWoEx/WaqWLQoY2F/RJf5RjXlfaKvyNyT259r+YO7RKzin
	ydvSK6Q9/7ElW5x+povXuyhIBdHjIaE=
Date: Wed, 24 Jul 2024 10:12:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3] sched/fair: Sync se's load_avg with cfs_rq in
 reweight_task
To: Vishal Chourasia <vishalc@linux.ibm.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org
References: <20240723114247.104848-1-zhouchuyi@bytedance.com>
 <Zp_QzS-DUiE934X2@linux.ibm.com>
 <da5b5683-ed22-4e65-9e89-e22ff7f6cf2b@arm.com>
 <d758614b-73e8-42a3-92d1-5d2424ee4e89@linux.ibm.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <d758614b-73e8-42a3-92d1-5d2424ee4e89@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2024/7/24 07:00, Vishal Chourasia wrote:
> On 24/07/24 2:40 am, Dietmar Eggemann wrote:
>> On 23/07/2024 17:48, Vishal Chourasia wrote:
>>> On Tue, Jul 23, 2024 at 07:42:47PM +0800, Chuyi Zhou wrote:
>>>> In reweight_task(), there are two situations:
>>>>
>>>> 1. The task was on_rq, then the task's load_avg is accurate because we
>>>> synchronized it with cfs_rq through update_load_avg() in dequeue_task().
>>>>
>>>> 2. The task is sleeping, its load_avg might not have been updated for some
>>>> time, which can result in inaccurate dequeue_load_avg() in
>>>> reweight_entity().
>>>>
>>>> This patch solves this by using sync_entity_load_avg() to synchronize the
>>>> load_avg of se with cfs_rq before dequeue_load_avg() in reweight_entity().
>>>> For tasks were on_rq, since we already update load_avg to accurate values
>>>> in dequeue_task(), this change will not have other effects due to the short
>>>> time interval between the two updates.
>>>>
>>>> Suggested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>>>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>>>> ---
>>>> Changes in v3:
>>>> - use sync_entity_load_avg() rather than update_load_avg() to sync the
>>>> sleeping task with its cfs_rq suggested by Dietmar.
>>>> - Link t0 v2: https://lore.kernel.org/lkml/20240720051248.59608-1-zhouchuyi@bytedance.com/
>>>> Changes in v2:
>>>> - change the description in commit log.
>>>> - use update_load_avg() in reweight_task() rather than in reweight_entity
>>>> suggested by chengming.
>>>> - Link to v1: https://lore.kernel.org/lkml/20240716150840.23061-1-zhouchuyi@bytedance.com/
>>>> ---
>>>>   kernel/sched/fair.c | 43 ++++++++++++++++++++++++-------------------
>>>>   1 file changed, 24 insertions(+), 19 deletions(-)
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index 9057584ec06d..da3cdd86ab2e 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -3669,11 +3669,32 @@ dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
>>>>   	cfs_rq->avg.load_sum = max_t(u32, cfs_rq->avg.load_sum,
>>>>   					  cfs_rq->avg.load_avg * PELT_MIN_DIVIDER);
>>>>   }
>>>> +
>>>> +static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
>>>> +{
>>>> +	return u64_u32_load_copy(cfs_rq->avg.last_update_time,
>>>> +				 cfs_rq->last_update_time_copy);
>>>> +}
>>>> +
>>>> +/*
>>>> + * Synchronize entity load avg of dequeued entity without locking
>>>> + * the previous rq.
>>>> + */
>>>> +static void sync_entity_load_avg(struct sched_entity *se)
>>>> +{
>>>> +	struct cfs_rq *cfs_rq = cfs_rq_of(se);
>>>> +	u64 last_update_time;
>>>> +
>>>> +	last_update_time = cfs_rq_last_update_time(cfs_rq);
>>>> +	__update_load_avg_blocked_se(last_update_time, se);
>>>> +}
>>>> +
>>> The difference between using update_load_avg() and
>>> sync_entity_load_avg() is:
>>> 1. update_load_avg() uses the updated PELT clock value from the rq
>>>     structure.
>>> 2. sync_entity_load_avg() uses the last updated time of
>>>     the cfs_rq where the scheduling entity (se) is attached.
>>>
>>> Won't this affect the entity load sync?
>>
>> Not sure what you mean exactly by entity load sync here.
> load avg sync for the wakee
>>
>> The task has been sleeping for a long time, i.e. its PELT values haven't
>> been updated or a long time (its last_update_time (lut) value is pretty
>> old).
>>
>> In this meantime the task's cfs_rq has potentially seen other PELT
>> updates due to PELT updates of other non-sleeping tasks related to this
>> cfs_rq. I.e. the cfs_rq lut is much more recent.
>>
>> What we want to do here is to sync the sleeping task with its cfs_rq. If
>> the task was sleeping for more than 1us (1024ns) and we cross a 1ms PELT
>> period (1024us) when we use cfs_rq's lut as the 'now' value for
>> __update_load_avg_blocked_se() then we will see the task PELT values decay.
>>
>> We rely on sync_entity_load_avg() for instance in EAS wakeup where the
>> task's util_avg influences on which CPU type the task will run next. So
>> we sync the wakee with its cfs_rq to be able to work with a current task
>> util_avg.
> I was talking about the case where all the tasks on a cfs_rq are sleeping.
> In this case, lut of the cfs_rq will be same as, at the time of last dequeue.

In this case, cfs_rq is not on_rq, its load_sum/avg will be updated when
enqueue next time. (Or periodically updated from load balance)

> 
> And, wakee is been woken up (suppose) after 1us window
> 
> 
> I guess, in this case pelt metric would not have changed for the cfs_rq

IMHO, so long as task_se load is synced with cfs_rq there should be ok.

Thanks.

> 
> Thanks
> -- vishal.c
> 

