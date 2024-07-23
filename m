Return-Path: <linux-kernel+bounces-260413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B1F93A892
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 23:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 859991F233C4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 21:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB59414431F;
	Tue, 23 Jul 2024 21:11:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 979C5143C5D
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 21:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721769069; cv=none; b=MdStBpu46g/duy58Xhv5DVpNGcTSK5qwTrzIgss7+YUb0nwZzSSVh9oj6RXQN0T0t8N6lVhUy/dIurQ0Ev/PQMRXN4LJLATsCYh4/oMJaSkzHYOC1xERM4eU/s0bZ3xkoRfUShSc1M/VeDG/Fq0k3rQnQz1D81Cp42DXekzTL3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721769069; c=relaxed/simple;
	bh=FMR9HIivO53rsSaayduz2mm0h4wi3sl0W0lWaHTXFc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PcDrO/j0x/KKcogRE3g2EhOnJJnDHCE96BXnYpIAkmRN7V31OTByb2tda8yntGNLtGK00saAmtmN/1wunrFPcfIVeVgiIKGwHO/p0X/Wk+cTfo6L2MM/6hpGDYLz8Zhu5XB8H7E1NdvE+7V6karIXdO5zErponfEls+3GjUujRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC96C139F;
	Tue, 23 Jul 2024 14:11:25 -0700 (PDT)
Received: from [192.168.178.110] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 986A83F73F;
	Tue, 23 Jul 2024 14:10:58 -0700 (PDT)
Message-ID: <da5b5683-ed22-4e65-9e89-e22ff7f6cf2b@arm.com>
Date: Tue, 23 Jul 2024 23:10:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sched/fair: Sync se's load_avg with cfs_rq in
 reweight_task
To: Vishal Chourasia <vishalc@linux.ibm.com>,
 Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, chengming.zhou@linux.dev,
 linux-kernel@vger.kernel.org
References: <20240723114247.104848-1-zhouchuyi@bytedance.com>
 <Zp_QzS-DUiE934X2@linux.ibm.com>
Content-Language: en-US
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <Zp_QzS-DUiE934X2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/07/2024 17:48, Vishal Chourasia wrote:
> On Tue, Jul 23, 2024 at 07:42:47PM +0800, Chuyi Zhou wrote:
>> In reweight_task(), there are two situations:
>>
>> 1. The task was on_rq, then the task's load_avg is accurate because we
>> synchronized it with cfs_rq through update_load_avg() in dequeue_task().
>>
>> 2. The task is sleeping, its load_avg might not have been updated for some
>> time, which can result in inaccurate dequeue_load_avg() in
>> reweight_entity().
>>
>> This patch solves this by using sync_entity_load_avg() to synchronize the
>> load_avg of se with cfs_rq before dequeue_load_avg() in reweight_entity().
>> For tasks were on_rq, since we already update load_avg to accurate values
>> in dequeue_task(), this change will not have other effects due to the short
>> time interval between the two updates.
>>
>> Suggested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> ---
>> Changes in v3:
>> - use sync_entity_load_avg() rather than update_load_avg() to sync the
>> sleeping task with its cfs_rq suggested by Dietmar.
>> - Link t0 v2: https://lore.kernel.org/lkml/20240720051248.59608-1-zhouchuyi@bytedance.com/
>> Changes in v2:
>> - change the description in commit log.
>> - use update_load_avg() in reweight_task() rather than in reweight_entity
>> suggested by chengming.
>> - Link to v1: https://lore.kernel.org/lkml/20240716150840.23061-1-zhouchuyi@bytedance.com/
>> ---
>>  kernel/sched/fair.c | 43 ++++++++++++++++++++++++-------------------
>>  1 file changed, 24 insertions(+), 19 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 9057584ec06d..da3cdd86ab2e 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -3669,11 +3669,32 @@ dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
>>  	cfs_rq->avg.load_sum = max_t(u32, cfs_rq->avg.load_sum,
>>  					  cfs_rq->avg.load_avg * PELT_MIN_DIVIDER);
>>  }
>> +
>> +static inline u64 cfs_rq_last_update_time(struct cfs_rq *cfs_rq)
>> +{
>> +	return u64_u32_load_copy(cfs_rq->avg.last_update_time,
>> +				 cfs_rq->last_update_time_copy);
>> +}
>> +
>> +/*
>> + * Synchronize entity load avg of dequeued entity without locking
>> + * the previous rq.
>> + */
>> +static void sync_entity_load_avg(struct sched_entity *se)
>> +{
>> +	struct cfs_rq *cfs_rq = cfs_rq_of(se);
>> +	u64 last_update_time;
>> +
>> +	last_update_time = cfs_rq_last_update_time(cfs_rq);
>> +	__update_load_avg_blocked_se(last_update_time, se);
>> +}
>> +
> The difference between using update_load_avg() and
> sync_entity_load_avg() is:
> 1. update_load_avg() uses the updated PELT clock value from the rq
>    structure.  
> 2. sync_entity_load_avg() uses the last updated time of
>    the cfs_rq where the scheduling entity (se) is attached.
> 
> Won't this affect the entity load sync?

Not sure what you mean exactly by entity load sync here.

The task has been sleeping for a long time, i.e. its PELT values haven't
been updated or a long time (its last_update_time (lut) value is pretty
old).

In this meantime the task's cfs_rq has potentially seen other PELT
updates due to PELT updates of other non-sleeping tasks related to this
cfs_rq. I.e. the cfs_rq lut is much more recent.

What we want to do here is to sync the sleeping task with its cfs_rq. If
the task was sleeping for more than 1us (1024ns) and we cross a 1ms PELT
period (1024us) when we use cfs_rq's lut as the 'now' value for
__update_load_avg_blocked_se() then we will see the task PELT values decay.

We rely on sync_entity_load_avg() for instance in EAS wakeup where the
task's util_avg influences on which CPU type the task will run next. So
we sync the wakee with its cfs_rq to be able to work with a current task
util_avg.

