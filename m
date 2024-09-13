Return-Path: <linux-kernel+bounces-327854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521A0977BF0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 11:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4D011C24595
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 09:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02881D6DC6;
	Fri, 13 Sep 2024 09:10:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB491D6DC8
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726218603; cv=none; b=uahevd5OFsa/2kUIWYMq5cUZBVQm8YjVJNv2cUXzgGGwVWaKMo/TycEJNCHxxoqBaWiJNOrYggbOJ+F47o5edKuCK43HGmWADji20KVO5boOyS+wPpDhgaLSdZMrA762WWjgsURLE1fQNaaytkATrFvcWllng7EGVpDyGgxw/pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726218603; c=relaxed/simple;
	bh=0mWGs2FHEmfQVikZtZU1lBffsWT85KwcNlRyYbJJ1zc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4IHjZnBeZB+EGgYVwS2gCbECnuuswDYLu7Jp6z017Pyi+4gAPW3k8ozoE6ofT5DducNOm0BpEFscRTPVK6mdck3awpxS3EI+gbhfmvzp4uvKHh9GUitQXgBjsAZmExih2srE+Z0egKH6YXSdxsEtDNjxLAi/1RJJCqPv6qpECE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 644E713D5;
	Fri, 13 Sep 2024 02:10:30 -0700 (PDT)
Received: from [10.57.75.215] (unknown [10.57.75.215])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E65BE3F73B;
	Fri, 13 Sep 2024 02:09:57 -0700 (PDT)
Message-ID: <5ccc3a77-64de-48fd-b118-f08aef9e1d2c@arm.com>
Date: Fri, 13 Sep 2024 11:09:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 5/5] sched/fair: Add push task callback for EAS
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, lukasz.luba@arm.com,
 rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org,
 qyousef@layalina.io, hongyan.xia2@arm.com
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-6-vincent.guittot@linaro.org>
 <ccf4095f-5fca-42f4-b9fe-aa93e703016e@arm.com>
 <CAKfTPtDm_e2feardrXN0M3679F67+gys=U7ZHQoyLL_LjzD04w@mail.gmail.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <CAKfTPtDm_e2feardrXN0M3679F67+gys=U7ZHQoyLL_LjzD04w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Vincent,

On 9/12/24 14:30, Vincent Guittot wrote:
> Hello Pierre,
> 
> On Wed, 11 Sept 2024 at 16:03, Pierre Gondois <pierre.gondois@arm.com> wrote:
>>
>> Hello Vincent,
>>
>> On 8/30/24 15:03, Vincent Guittot wrote:
>>> EAS is based on wakeup events to efficiently place tasks on the system, but
>>> there are cases where a task will not have wakeup events anymore or at a
>>> far too low pace. For such situation, we can take advantage of the task
>>> being put back in the enqueued list to check if it should be migrated on
>>> another CPU. When the task is the only one running on the CPU, the tick
>>> will check it the task is stuck on this CPU and should migrate on another
>>> one.
>>>
>>> Wake up events remain the main way to migrate tasks but we now detect
>>> situation where a task is stuck on a CPU by checking that its utilization
>>> is larger than the max available compute capacity (max cpu capacity or
>>> uclamp max setting)
>>>
>>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>>> ---
>>>    kernel/sched/fair.c  | 211 +++++++++++++++++++++++++++++++++++++++++++
>>>    kernel/sched/sched.h |   2 +
>>>    2 files changed, 213 insertions(+)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.cHel
>>> index e46af2416159..41fb18ac118b 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>
>> [snip]
>>
>>> +
>>> +static inline void check_misfit_cpu(struct task_struct *p, struct rq *rq)
>>> +{
>>> +     int new_cpu, cpu = cpu_of(rq);
>>> +
>>> +     if (!sched_energy_enabled())
>>> +             return;
>>> +
>>> +     if (WARN_ON(!p))
>>> +             return;
>>> +
>>> +     if (WARN_ON(p != rq->curr))
>>> +             return;
>>> +
>>> +     if (is_migration_disabled(p))
>>> +             return;
>>> +
>>> +     if ((rq->nr_running > 1) || (p->nr_cpus_allowed == 1))
>>> +             return;
>>
>> I tried the code on a Pixel6 with the following setup:
>> - without the above (rq->nr_running > 1) condition
>> - without the push task mechanism
>> i.e. tasks without regular wakeups only have the opportunity to
>> run feec() via the sched_tick. It seemed sufficient to avoid
>> the problematic you mentioned:
>> - having unbalanced UCLAMP_MAX tasks in a pd, e.g. 1 UCLAMP_MAX task
>>     per little CPU, except one little CPU with N UCLAMP_MAX tasks
>> - downgrading UCLAMP_MAX tasks that could run on smaller CPUs
>>     but have no wakeups and thus don't run feec()
> 
> The main problem with your test is that you always call feec() for the
> running task so you always have to wake up the migration thread to
> migrate the current running thread which is quite inefficient. The
> push mechanism only takes a task which is not the current running one
> and we don't need to wake up migration thread which is simpler and
> more efficient. We check only one task at a time and will not loop on
> an unbounded number of tasks after a task switch or a tick
> 
>>
>> Thus I was wondering it it would not be better to integrate the
>> EAS to the load balancer instead (not my idea, but don't remember
>> who suggested that).
> 
> My 1st thought was also to use load balance to pull tasks which were
> stuck on the wrong CPU (as mentioned in [1]) but this solution is not
> scalable as we don't want to test all runnable task on a cpu and it's
> not really easy to know which cpu and which tasks should be checked
> 
> [1] https://youtu.be/PHEBAyxeM_M?si=ZApIOw3BS4SOLPwp
> 
>> Or otherwise if just running feec() through the sched_tick path
>> would not be sufficient (i.e. this patch minus the push mechanism).
> 
> As mentioned above, the push mechanism is more efficient than active migration.
> 
> 
>>
>>> +
>>> +     if (!task_misfit_cpu(p, cpu))
>>> +             return;
>>> +
>>> +     new_cpu = find_energy_efficient_cpu(p, cpu);
>>> +
>>> +     if (new_cpu == cpu)
>>> +             return;
>>> +
>>> +     /*
>>> +      * ->active_balance synchronizes accesses to
>>> +      * ->active_balance_work.  Once set, it's cleared
>>> +      * only after active load balance is finished.
>>> +      */
>>> +     if (!rq->active_balance) {
>>> +             rq->active_balance = 1;
>>> +             rq->push_cpu = new_cpu;
>>> +     } else
>>> +             return;
>>> +
>>> +     raw_spin_rq_unlock(rq);
>>> +     stop_one_cpu_nowait(cpu,
>>> +             active_load_balance_cpu_stop, rq,
>>> +             &rq->active_balance_work);
>>> +     raw_spin_rq_lock(rq);
>>
>> I didn't hit any error, but isn't it eligible to the following ?
>>     commit f0498d2a54e7 ("sched: Fix stop_one_cpu_nowait() vs hotplug")
>>
> 
> I will recheck but being called from the tick, for the local cpu and
> with a running thread no being cpu_stopper_thread, should protect us
> from the case describe in this commit
> 
>>
>>> +}
>>> +
>>> +static inline int has_pushable_tasks(struct rq *rq)
>>> +{
>>> +     return !plist_head_empty(&rq->cfs.pushable_tasks);
>>> +}
>>> +
>>> +static struct task_struct *pick_next_pushable_fair_task(struct rq *rq)
>>> +{
>>> +     struct task_struct *p;
>>> +
>>> +     if (!has_pushable_tasks(rq))
>>> +             return NULL;
>>> +
>>> +     p = plist_first_entry(&rq->cfs.pushable_tasks,
>>> +                           struct task_struct, pushable_tasks);
>>> +
>>> +     WARN_ON_ONCE(rq->cpu != task_cpu(p));
>>> +     WARN_ON_ONCE(task_current(rq, p));
>>> +     WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
>>> +
>>> +     WARN_ON_ONCE(!task_on_rq_queued(p));
>>> +
>>> +     /*
>>> +      * Remove task from the pushable list as we try only once after
>>> +      * task has been put back in enqueued list.
>>> +      */
>>> +     plist_del(&p->pushable_tasks, &rq->cfs.pushable_tasks);
>>> +
>>> +     return p;
>>> +}
>>> +
>>> +/*
>>> + * See if the non running fair tasks on this rq
>>> + * can be sent to some other CPU that fits better with
>>> + * their profile.
>>> + */
>>> +static int push_fair_task(struct rq *rq)
>>> +{
>>> +     struct task_struct *next_task;
>>> +     struct rq *new_rq;
>>> +     int prev_cpu, new_cpu;
>>> +     int ret = 0;
>>> +
>>> +     next_task = pick_next_pushable_fair_task(rq);
>>> +     if (!next_task)
>>> +             return 0;
>>> +
>>> +     if (is_migration_disabled(next_task))
>>> +             return 0;
>>> +
>>> +     if (WARN_ON(next_task == rq->curr))
>>> +             return 0;
>>> +
>>> +     /* We might release rq lock */
>>> +     get_task_struct(next_task);
>>> +
>>> +     prev_cpu = rq->cpu;
>>> +
>>> +     new_cpu = find_energy_efficient_cpu(next_task, prev_cpu);
>>> +
>>> +     if (new_cpu == prev_cpu)
>>> +             goto out;
>>> +
>>> +     new_rq = cpu_rq(new_cpu);
>>> +
>>> +     if (double_lock_balance(rq, new_rq)) {
>>
>>
>> I think it might be necessary to check the following:
>>     if (task_cpu(next_task) != rq->cpu) {
>>       double_unlock_balance(rq, new_rq);
> 
> Yes good point
> 
>>       goto out;
>>     }
>>
>> Indeed I've been hitting the following warnings:
>> - uclamp_rq_dec_id():SCHED_WARN_ON(!bucket->tasks)
>> - set_task_cpu()::WARN_ON_ONCE(state == TASK_RUNNING &&
>>                       p->sched_class == &fair_sched_class &&
>>                       (p->on_rq && !task_on_rq_migrating(p)))
>> - update_entity_lag()::SCHED_WARN_ON(!se->on_rq)
>>
>> and it seemed to be caused by the task not being on the initial rq anymore.
> 
> Do you have a particular use case to trigger this ? I haven't faced
> this in the various stress tests that  I did

It was triggered by this workload, but it was on a Pixel6 device,
so there might be more background activity:
- 8 tasks with: [UCLAMP_MIN:0, UCLAMP_MAX:1, duty_cycle:100%, period:16ms]
- 4 tasks each bound to a little CPU with: [UCLAMP_MIN:0, UCLAMP_MAX:1024, duty_cycle:4%, period:4ms]

Regards,
Pierre

