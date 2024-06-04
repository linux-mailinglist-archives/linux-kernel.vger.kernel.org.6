Return-Path: <linux-kernel+bounces-200757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C068F8FB48D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73DA4282C48
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF060DF5C;
	Tue,  4 Jun 2024 13:55:43 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0AF8F66
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509343; cv=none; b=EoUH9adxL9iH2webA7FwwAOQPC5pPyR4krnwSBqZSaplOcT9sMY0snXGbCioKovMrbzXDNAhK8OMyFihwf8/ETGxkZrD0bW3VlVYwXheZekA2jk+Ju9tX0WSzdyiWpfT1/xvwBqYp9mvan/UFYoODKJ5G6x8V1C3wY2Ms58dlCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509343; c=relaxed/simple;
	bh=r5L3F8kwnvQ2iwV2TVqzxi4hAMdmCJ13gigy6SiOtzs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t+J2QaqFvkeqWd++rS54utCqv6QO4IR5zS1b+0HuGP2ahufXQ7N7Ch7G0jsKplsm6iDHWlo7CJaX9JUNdqbKRoyRGo8lDdqb75LufBeIo/vBD51oHoHmdnf8t2fDrV3kMgbS1lJMld2eyHAOdyq373l1FkfjFjnW5ZeeGUyjsXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B96921474;
	Tue,  4 Jun 2024 06:56:04 -0700 (PDT)
Received: from [10.1.37.61] (e132833.arm.com [10.1.37.61])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AB7F3F64C;
	Tue,  4 Jun 2024 06:55:37 -0700 (PDT)
Message-ID: <10962efe-ce2a-4954-beea-6de90f1df8b4@arm.com>
Date: Tue, 4 Jun 2024 14:55:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 6/7] sched: Split out __schedule() deactivate task
 logic into a helper
To: Qais Yousef <qyousef@layalina.io>, John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Joel Fernandes <joelaf@google.com>,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
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
 <20240507045450.895430-7-jstultz@google.com>
 <20240604132910.25pgz3mjrnnwitve@airbuntu>
Content-Language: en-US
From: Metin Kaya <metin.kaya@arm.com>
In-Reply-To: <20240604132910.25pgz3mjrnnwitve@airbuntu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/06/2024 2:29 pm, Qais Yousef wrote:
> On 05/06/24 21:54, John Stultz wrote:
>> As we're going to re-use the deactivation logic,
>> split it into a helper.
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
>> Signed-off-by: John Stultz <jstultz@google.com>
>> ---
>> v6:
>> * Define function as static to avoid "no previous prototype"
>>    warnings as Reported-by: kernel test robot <lkp@intel.com>
>> v7:
>> * Rename state task_state to be more clear, as suggested by
>>    Metin Kaya
>> ---
>>   kernel/sched/core.c | 72 +++++++++++++++++++++++++++------------------
>>   1 file changed, 43 insertions(+), 29 deletions(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 48f0d4b381d5..8bc5844ebab9 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -6572,6 +6572,48 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>>   # define SM_MASK_PREEMPT	SM_PREEMPT
>>   #endif
>>   
>> +/*
>> + * Helper function for __schedule()
>> + *
>> + * If a task does not have signals pending, deactivate it and return true
>> + * Otherwise marks the task's __state as RUNNING and returns false
>> + */
>> +static bool try_to_deactivate_task(struct rq *rq, struct task_struct *p,
>> +				   unsigned long task_state)
>> +{
>> +	if (signal_pending_state(task_state, p)) {
>> +		WRITE_ONCE(p->__state, TASK_RUNNING);
> 
> We can avoid extra indention for the other (lengthy) leg if we return here?
> 
> The return value is ignored for now, I don't mind keeping it but better call it

I see the return value is unused even after the complete patch set. So, 
agreed with your proposal.

> out in the commit message or when you add the new user later you can update the
> signature more easily.
> 
> Generally I think patches 4, 5 and 6 could be sent as their own series with
> minor commit messages tweaks to make them more independent and I hope Ingo and
> Peter are okay to pick them up as they look a nice clean up in general.
> 
> Anyway:
> 
> Reviewed-by: Qais Yousef <qyousef@layalina.io>
> 
>> +	} else {
>> +		p->sched_contributes_to_load =
>> +			(task_state & TASK_UNINTERRUPTIBLE) &&
>> +			!(task_state & TASK_NOLOAD) &&
>> +			!(task_state & TASK_FROZEN);
>> +
>> +		if (p->sched_contributes_to_load)
>> +			rq->nr_uninterruptible++;
>> +
>> +		/*
>> +		 * __schedule()			ttwu()
>> +		 *   prev_state = prev->state;    if (p->on_rq && ...)
>> +		 *   if (prev_state)		    goto out;
>> +		 *     p->on_rq = 0;		  smp_acquire__after_ctrl_dep();
>> +		 *				  p->state = TASK_WAKING
>> +		 *
>> +		 * Where __schedule() and ttwu() have matching control dependencies.
>> +		 *
>> +		 * After this, schedule() must not care about p->state any more.
>> +		 */
>> +		deactivate_task(rq, p, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
>> +
>> +		if (p->in_iowait) {
>> +			atomic_inc(&rq->nr_iowait);
>> +			delayacct_blkio_start();
>> +		}
>> +		return true;
>> +	}
>> +	return false;
>> +}
>> +
>>   /*
>>    * __schedule() is the main scheduler function.
>>    *
>> @@ -6665,35 +6707,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>>   	 */
>>   	prev_state = READ_ONCE(prev->__state);
>>   	if (!(sched_mode & SM_MASK_PREEMPT) && prev_state) {
>> -		if (signal_pending_state(prev_state, prev)) {
>> -			WRITE_ONCE(prev->__state, TASK_RUNNING);
>> -		} else {
>> -			prev->sched_contributes_to_load =
>> -				(prev_state & TASK_UNINTERRUPTIBLE) &&
>> -				!(prev_state & TASK_NOLOAD) &&
>> -				!(prev_state & TASK_FROZEN);
>> -
>> -			if (prev->sched_contributes_to_load)
>> -				rq->nr_uninterruptible++;
>> -
>> -			/*
>> -			 * __schedule()			ttwu()
>> -			 *   prev_state = prev->state;    if (p->on_rq && ...)
>> -			 *   if (prev_state)		    goto out;
>> -			 *     p->on_rq = 0;		  smp_acquire__after_ctrl_dep();
>> -			 *				  p->state = TASK_WAKING
>> -			 *
>> -			 * Where __schedule() and ttwu() have matching control dependencies.
>> -			 *
>> -			 * After this, schedule() must not care about p->state any more.
>> -			 */
>> -			deactivate_task(rq, prev, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
>> -
>> -			if (prev->in_iowait) {
>> -				atomic_inc(&rq->nr_iowait);
>> -				delayacct_blkio_start();
>> -			}
>> -		}
>> +		try_to_deactivate_task(rq, prev, prev_state);
>>   		switch_count = &prev->nvcsw;
>>   	}
>>   
>> -- 
>> 2.45.0.rc1.225.g2a3ae87e7f-goog
>>


