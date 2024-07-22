Return-Path: <linux-kernel+bounces-258507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E01CE9388FE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 08:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AB90B20D08
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 06:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7FCE18052;
	Mon, 22 Jul 2024 06:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="I1Q9FDgU"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C0717BAB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 06:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721630465; cv=none; b=PvBGsGlYL6WIGpnxoDgycxi1OyLRmAn0IziUuMWIg9ibWkoIt7ss/mwKG8onFJDVHM6yP2Knrz8hCapFnLFQNNRrm/ylJZxznatLSDro8SLU0NUihysxrJ5J0ZEFtgTLEgkLQ8atwoGw7+grSxd1iRGsIUqKIZoRt2Ph2w7X9QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721630465; c=relaxed/simple;
	bh=8uqEGZghhT/l+hmZrn/6IpB3DheHvqzKDYim9bl5TFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p7QLCIrn/0bit41cwB++IN4sHmBMbIzgWckH9OLV5qPVI295YpXJGA97hGMh1+Dhl3yAKXyHGQZfHTBO1FNdWiw/g+x7TMQa4BGHCZBhZVRe1szAQ+VAZYzEP74N1v15udc/7YAyGb5321j/mH9OjsOQvMtWYSw7ujczATJZ4WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=I1Q9FDgU; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: kprateek.nayak@amd.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1721630460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Txv8/Afh7Nk5fCH70JQiEsbc51DiAwkAWG4ZC4Zqok=;
	b=I1Q9FDgUomWwzdvLjTbXVRuWBTGLyri4u07ltPLGFethM7akm93hF02FCoXF+BHUy/vfle
	mGhufBECMraWOC4/jT4v+ABA53Xz+0sR+SSLkOsLlXZWo3rfxD6YjzN9hAd6TFRBi49yk1
	944JwGOTAT401K43is5yc6yWXq3sHhg=
X-Envelope-To: zhouchuyi@bytedance.com
X-Envelope-To: mingo@redhat.com
X-Envelope-To: peterz@infradead.org
X-Envelope-To: juri.lelli@redhat.com
X-Envelope-To: vincent.guittot@linaro.org
X-Envelope-To: dietmar.eggemann@arm.com
X-Envelope-To: rostedt@goodmis.org
X-Envelope-To: bsegall@google.com
X-Envelope-To: mgorman@suse.de
X-Envelope-To: vschneid@redhat.com
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: qyousef@layalina.io
Message-ID: <20bd07c6-2d39-44a0-951b-83aa57a84432@linux.dev>
Date: Mon, 22 Jul 2024 14:40:48 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] sched/fair: Sync se's load_avg with cfs_rq in
 reweight_task
To: K Prateek Nayak <kprateek.nayak@amd.com>,
 Chuyi Zhou <zhouchuyi@bytedance.com>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 vincent.guittot@linaro.org, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 linux-kernel@vger.kernel.org, Qais Yousef <qyousef@layalina.io>
References: <20240720051248.59608-1-zhouchuyi@bytedance.com>
 <3e88f113-e7b9-9b26-a4c1-52cf92b820c5@amd.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <3e88f113-e7b9-9b26-a4c1-52cf92b820c5@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2024/7/22 13:17, K Prateek Nayak wrote:
> (+ Qais)
> 
> Hello Chuyi,
> 
> On 7/20/2024 10:42 AM, Chuyi Zhou wrote:
>> In reweight_task(), there are two situations:
>>
>> 1. The task was on_rq, then the task's load_avg is accurate because we
>> synchronized it with cfs_rq through update_load_avg() in dequeue_task().
>>
>> 2. The task is sleeping, its load_avg might not have been updated for 
>> some
>> time, which can result in inaccurate dequeue_load_avg() in
>> reweight_entity().
>>
>> This patch solves this by using update_load_avg() to synchronize the
>> load_avg of se with cfs_rq. For tasks were on_rq, since we already update
>> load_avg to accurate values in dequeue_task(), this change will not have
>> other effects due to the short time interval between the two updates.
>>
>> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
>> ---
>> Changes in v2:
>> - change the description in commit log.
>> - use update_load_avg() in reweight_task() rather than in reweight_entity
>> suggested by chengming.
>> - Link to v1: 
>> https://lore.kernel.org/lkml/20240716150840.23061-1-zhouchuyi@bytedance.com/
>> ---
>>   kernel/sched/fair.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 9057584ec06d..b1e07ce90284 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -3835,12 +3835,15 @@ static void reweight_entity(struct cfs_rq 
>> *cfs_rq, struct sched_entity *se,
>>       }
>>   }
>> +static inline void update_load_avg(struct cfs_rq *cfs_rq, struct 
>> sched_entity *se, int flags);
>> +
>>   void reweight_task(struct task_struct *p, const struct load_weight *lw)
>>   {
>>       struct sched_entity *se = &p->se;
>>       struct cfs_rq *cfs_rq = cfs_rq_of(se);
>>       struct load_weight *load = &se->load;
>> +    update_load_avg(cfs_rq, se, 0);
> 
> Seems to be necessary when we reach here from __setscheduler_params() or
> set_user_nice() for a sleeping task. Please feel free to add:
> 
> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
> 
> But since we are on the subject of accurate PELT accounting, one question
> I have here is whether a reweight_task() for a sleeping task race with
> its wakeup? Something like the following scenario:

These two paths are impossible to race, since we have the task->pi_lock.

Thanks.

> 
> CPU0                                        CPU1
> ====                                        ====
> /* No rq locks held until ttwu_queue() */
> try_to_wake_up(p) {
>      ...
>      /* Migrating task */
>      set_task_cpu(p, cpu) {
>          /* p->sched_class->migrate_task_rq(p, new_cpu); */        /* 
> Called with task_cpu(p)'s rq lock held */
>          migrate_task_rq_fair() {                    reweight_task(p) {
>              /* p is still sleeping */                    ...
>              if (!task_on_rq_migrating(p)) {                    
> dequeue_load_avg(cfs_rq, se);
>                          remove_entity_load_avg(se);                
> update_load_set(&se->load, weight);
>                  ...                            enqueue_load_avg(cfs_rq, 
> se);
>              }                                ...
>          }                                }
>          /* task_cpu() is updated here */
>          __set_task_cpu(p, new_cpu);
>      }
>      ttwu_queue();
> }
> 
> In theory, the remove_entity_load_avg() could record stale value of
> "load_avg" that gets removed at the next dequeue if I'm not mistaken?
> But I believe these small inaccuracies are tolerable since they'll decay
> in a while anyways?
> 
>>       reweight_entity(cfs_rq, se, lw->weight);
>>       load->inv_weight = lw->inv_weight;
>>   }
> 

