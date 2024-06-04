Return-Path: <linux-kernel+bounces-200753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A5C8FB481
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:53:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E70831C20B18
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446D029CF0;
	Tue,  4 Jun 2024 13:53:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD29517C72
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509196; cv=none; b=gnb2j/QLGY15XQ5A7dJ8FUMh+URl/oekM9L0GcE44cOk+H0uLPlIv/AXx3HbJCG9RE1p+BUYc3Nzb4sNM/ZRopvzN//Jl9MhsTmB0KYkgniXqeCZiKi+w1zrGVzVJTOn9SrDdOB4yYsTBEcej1M+0WiT99JqVlPNuRKmWtLsskY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509196; c=relaxed/simple;
	bh=q14KACDj4LhO/vXw/vAlOE6JduSzMo3pO2gBwd9Kqt8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dl/qshv38VzGKsQgqN+qLbhqVFVtPiaNXJwHch5v3punlK8xf5WfcU5r29nsh2g8mCH7qDL13fTRmZL8Ge0unYYcGTa0eiEyqtTFfGLJ5P8nN9FE9PFXJB5KtiSw+eOHgNad5QWaJp3JFANJw7w+6GfD0BzObKnmKV9hmklLTUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 727EE1042;
	Tue,  4 Jun 2024 06:53:37 -0700 (PDT)
Received: from [10.1.37.61] (e132833.arm.com [10.1.37.61])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 379803F64C;
	Tue,  4 Jun 2024 06:53:10 -0700 (PDT)
Message-ID: <2a1cca9a-f82e-44bd-9c37-37a962934a13@arm.com>
Date: Tue, 4 Jun 2024 14:53:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 5/7] sched: Consolidate pick_*_task to
 task_is_pushable helper
To: Qais Yousef <qyousef@layalina.io>, John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Connor O'Brien <connoro@google.com>,
 Joel Fernandes <joelaf@google.com>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Zimuzo Ezeozue <zezeozue@google.com>, Youssef Esmat
 <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak
 <kprateek.nayak@amd.com>, Thomas Gleixner <tglx@linutronix.de>,
 kernel-team@android.com
References: <20240507045450.895430-1-jstultz@google.com>
 <20240507045450.895430-6-jstultz@google.com>
 <20240604131856.xo6jxe2geetq6jlg@airbuntu>
Content-Language: en-US
From: Metin Kaya <metin.kaya@arm.com>
In-Reply-To: <20240604131856.xo6jxe2geetq6jlg@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/06/2024 2:18 pm, Qais Yousef wrote:
> On 05/06/24 21:54, John Stultz wrote:
>> From: Connor O'Brien <connoro@google.com>
>>
>> This patch consolidates rt and deadline pick_*_task functions to
>> a task_is_pushable() helper
>>
>> This patch was broken out from a larger chain migration
>> patch originally by Connor O'Brien.
>>
>> Cc: Joel Fernandes <joelaf@google.com>
>> Cc: Qais Yousef <qyousef@layalina.io>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: Juri Lelli <juri.lelli@redhat.com>
>> Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> Cc: Valentin Schneider <vschneid@redhat.com>
>> Cc: Steven Rostedt <rostedt@goodmis.org>
>> Cc: Ben Segall <bsegall@google.com>
>> Cc: Zimuzo Ezeozue <zezeozue@google.com>
>> Cc: Youssef Esmat <youssefesmat@google.com>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Waiman Long <longman@redhat.com>
>> Cc: Boqun Feng <boqun.feng@gmail.com>
>> Cc: "Paul E. McKenney" <paulmck@kernel.org>
>> Cc: Metin Kaya <Metin.Kaya@arm.com>
>> Cc: Xuewen Yan <xuewen.yan94@gmail.com>
>> Cc: K Prateek Nayak <kprateek.nayak@amd.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: kernel-team@android.com
>> Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
>> Tested-by: Metin Kaya <metin.kaya@arm.com>
>> Reviewed-by: Metin Kaya <metin.kaya@arm.com>
>> Reviewed-by: Valentin Schneider <vschneid@redhat.com>
>> Signed-off-by: Connor O'Brien <connoro@google.com>
>> [jstultz: split out from larger chain migration patch,
>>   renamed helper function]
>> Signed-off-by: John Stultz <jstultz@google.com>
>> ---
>> v7:
>> * Split from chain migration patch
>> * Renamed function
>> ---
>>   kernel/sched/deadline.c | 10 +---------
>>   kernel/sched/rt.c       | 11 +----------
>>   kernel/sched/sched.h    | 10 ++++++++++
>>   3 files changed, 12 insertions(+), 19 deletions(-)
>>
>> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
>> index eaedc69c5e30..ae583a427539 100644
>> --- a/kernel/sched/deadline.c
>> +++ b/kernel/sched/deadline.c
>> @@ -2179,14 +2179,6 @@ static void task_fork_dl(struct task_struct *p)
>>   /* Only try algorithms three times */
>>   #define DL_MAX_TRIES 3
>>   
>> -static int pick_dl_task(struct rq *rq, struct task_struct *p, int cpu)
>> -{
>> -	if (!task_on_cpu(rq, p) &&
>> -	    cpumask_test_cpu(cpu, &p->cpus_mask))
>> -		return 1;
>> -	return 0;
>> -}
>> -
>>   /*
>>    * Return the earliest pushable rq's task, which is suitable to be executed
>>    * on the CPU, NULL otherwise:
>> @@ -2205,7 +2197,7 @@ static struct task_struct *pick_earliest_pushable_dl_task(struct rq *rq, int cpu
>>   	if (next_node) {
>>   		p = __node_2_pdl(next_node);
>>   
>> -		if (pick_dl_task(rq, p, cpu))
>> +		if (task_is_pushable(rq, p, cpu) == 1)
> 
> Any reason we're checking specifically for == 1? Could the function later
> return something other than 0 or 1?

I hear you, but just letting you know that `task_is_pushable()` will 
return different non-zero results per upcoming patches in the queue. The 
commit "sched: Fix rt/dl load balancing via chain level balance" will 
make the function look like below (excerpt from `kernel/sched/core.c`):

/*
  * Returns:
  * 1 if chain is pushable and affinity does not prevent pushing to cpu
  * 0 if chain is unpushable
  * -1 if chain is pushable but affinity blocks running on cpu.
  */
int task_is_pushable(struct rq *rq, struct task_struct *p, int cpu)

> 
> It's explaining if 1 could end up meaning something else in the commit message
> and in function docs. Otherwise let's make it a bool and not do explicit check
> for return value.
> 
> With this
> 
> Reviewed-by: Qais Yousef <qyousef@layalina.io>
> 
>>   			return p;
>>   
>>   		next_node = rb_next(next_node);
>> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>> index 975cb49a64dc..8b6fb77e095b 100644
>> --- a/kernel/sched/rt.c
>> +++ b/kernel/sched/rt.c
>> @@ -1791,15 +1791,6 @@ static void put_prev_task_rt(struct rq *rq, struct task_struct *p)
>>   /* Only try algorithms three times */
>>   #define RT_MAX_TRIES 3
>>   
>> -static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
>> -{
>> -	if (!task_on_cpu(rq, p) &&
>> -	    cpumask_test_cpu(cpu, &p->cpus_mask))
>> -		return 1;
>> -
>> -	return 0;
>> -}
>> -
>>   /*
>>    * Return the highest pushable rq's task, which is suitable to be executed
>>    * on the CPU, NULL otherwise
>> @@ -1813,7 +1804,7 @@ static struct task_struct *pick_highest_pushable_task(struct rq *rq, int cpu)
>>   		return NULL;
>>   
>>   	plist_for_each_entry(p, head, pushable_tasks) {
>> -		if (pick_rt_task(rq, p, cpu))
>> +		if (task_is_pushable(rq, p, cpu) == 1)
>>   			return p;
>>   	}
>>   
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 2d41ebe200c7..e46f69ba9ba2 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -3490,6 +3490,16 @@ void move_queued_task_locked(struct rq *rq, struct rq *dst_rq, struct task_struc
>>   	set_task_cpu(task, dst_rq->cpu);
>>   	activate_task(dst_rq, task, 0);
>>   }
>> +
>> +static inline
>> +int task_is_pushable(struct rq *rq, struct task_struct *p, int cpu)
>> +{
>> +	if (!task_on_cpu(rq, p) &&
>> +	    cpumask_test_cpu(cpu, &p->cpus_mask))
>> +		return 1;
>> +
>> +	return 0;
>> +}
>>   #endif
>>   
>>   #endif /* _KERNEL_SCHED_SCHED_H */
>> -- 
>> 2.45.0.rc1.225.g2a3ae87e7f-goog
>>


