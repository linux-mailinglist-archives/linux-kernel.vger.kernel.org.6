Return-Path: <linux-kernel+bounces-207274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB2B9014E3
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 10:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 132A4281C18
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jun 2024 08:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972351C68F;
	Sun,  9 Jun 2024 08:09:03 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AAED26A
	for <linux-kernel@vger.kernel.org>; Sun,  9 Jun 2024 08:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717920543; cv=none; b=bzpW6CKCIpb8apU2V7fLc2Ny/gpObakH2uDgtQeC+tB+xlSVJ/ABZuabZO5tPG9QJNO7UmG9AOOtKUgnn4r/0HMMasssmc3L4WNMgdJsaRSkZjdb6Us8kthw56+a8GKUtLhpFY0B18AcoyfiXG+pppEizhDvSoscW2EuQU3BXzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717920543; c=relaxed/simple;
	bh=G3I4tbx0AiuW6I9IAVsKC+RvknC2RDYBwErr5ofCUUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kh7m4cU/mnOP74t64xZ2r+MVmcDkZfaXcNJVRDmNha9ff7ST5LI+ACEOdoW0YlyJvirB7ZwIYq2HhDemi/y/JpjOeh2lMx4rGmN3RUkOhXFYi6Kw59F70YQV2uF9zlRXNdtbt6FBAm09LCk1zBhkrCvztzh2/70YserErhMVZ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Vxnbd2DxhzdZwN;
	Sun,  9 Jun 2024 16:07:25 +0800 (CST)
Received: from canpemm500001.china.huawei.com (unknown [7.192.104.163])
	by mail.maildlp.com (Postfix) with ESMTPS id 3D63B18007C;
	Sun,  9 Jun 2024 16:08:51 +0800 (CST)
Received: from [10.67.111.186] (10.67.111.186) by
 canpemm500001.china.huawei.com (7.192.104.163) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 9 Jun 2024 16:08:50 +0800
Message-ID: <f23a2d63-7493-75c8-030c-e569ed73b9d2@huawei.com>
Date: Sun, 9 Jun 2024 16:08:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] sched: Initialize the vruntime of a new task when it is
 first enqueued
To: Peter Zijlstra <peterz@infradead.org>
CC: <mingo@redhat.com>, <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
	<linux-kernel@vger.kernel.org>
References: <20240606121133.2218723-1-zhangqiao22@huawei.com>
 <20240607103043.GO8774@noisy.programming.kicks-ass.net>
From: Zhang Qiao <zhangqiao22@huawei.com>
In-Reply-To: <20240607103043.GO8774@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500001.china.huawei.com (7.192.104.163)



在 2024/6/7 18:30, Peter Zijlstra 写道:
> On Thu, Jun 06, 2024 at 08:11:33PM +0800, Zhang Qiao wrote:
>> When create a new task, we initialize vruntime of the new task
>> at sched_cgroup_fork(). However, the timing of executing this
>> action is too early and may not be accurate.
>>
>> Because it use current cpu to init the vruntime, but the new
>> task actually runs on the cpu which be assigned at wake_up_new_task().
>>
>> To optimize this case, we pass ENQUEUE_INITIAL flag to
>> activate_task() in wake_up_new_task(), in this way,
>> when place_entity is called in enqueue_entity(), the
>> vruntime of the new task will be initialized. At the same
>> time, place_entity in task_fork_fair() is useless, remove it.
> 
> The better argument would've looked at history to see why the code was
> the way it is and then verify those reasons are no longer valid.
> 
> Specifically, I think these are remains of child_runs_first, and that is
> now gone.> > Can you verify and update accordingly?

Initially, __enqueue_entity() was in task_new_fair(), in order to schedule
according to se->vruntime, only a"se->vruntime = cfs_rq->min_vruntime" was
added here. This modification  was introduced by commit e9acbff648 ("sched: introduce se->vruntime").

Then,the commit 4d78e7b656aa("sched: new task placement for vruntime") added proper
new task placement for the vruntime based math, this also requires the new task's vruntime value.

The commit aeb73b040399("sched: clean up new task placement") clean up code and extract
a place_entity() helper function.

To summarize, the place_entity() in task_fork_fair() was for the child_runs_first and enqueue_entity,
After remove the child_runs_first and enqueue_entity from task_fork_fair(), we can remove this place_entity().


> 
>> Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
>> ---
>>  kernel/sched/core.c |  2 +-
>>  kernel/sched/fair.c | 16 ----------------
>>  2 files changed, 1 insertion(+), 17 deletions(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index bcf2c4cc0522..b4ff595a2dc8 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -4897,7 +4897,7 @@ void wake_up_new_task(struct task_struct *p)
>>  	update_rq_clock(rq);
>>  	post_init_entity_util_avg(p);
>>  
>> -	activate_task(rq, p, ENQUEUE_NOCLOCK);
>> +	activate_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_INITIAL);
>>  	trace_sched_wakeup_new(p);
>>  	wakeup_preempt(rq, p, WF_FORK);
>>  #ifdef CONFIG_SMP
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index efce2d36a783..bb5f376fd51e 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -12702,23 +12702,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>>   */
>>  static void task_fork_fair(struct task_struct *p)
>>  {
>> -	struct sched_entity *se = &p->se, *curr;
>> -	struct cfs_rq *cfs_rq;
>> -	struct rq *rq = this_rq();
>> -	struct rq_flags rf;
>> -
>> -	rq_lock(rq, &rf);
>> -
>>  	set_task_max_allowed_capacity(p);
>> -
>> -	cfs_rq = task_cfs_rq(current);
>> -	curr = cfs_rq->curr;
>> -	if (curr) {
>> -		update_rq_clock(rq);
>> -		update_curr(cfs_rq);
>> -	}
>> -	place_entity(cfs_rq, se, ENQUEUE_INITIAL);
>> -	rq_unlock(rq, &rf);
>>  }
>>  
>>  /*
>> -- 
>> 2.18.0.huawei.25
>>
> .
> 

