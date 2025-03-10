Return-Path: <linux-kernel+bounces-554115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8053EA5932B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 12:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01189188F633
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 11:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6FA22371A;
	Mon, 10 Mar 2025 11:56:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8CF2223323
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 11:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741607784; cv=none; b=dByvTgqmt9ltNa/rkuUb7PIRa0Olj6QsI8ejiigSszjgSc2KZJrKiPAtOzAU2JzeKnETJZ8mDQmYUPMS7LG/qih0nBdFoNTJER39PbyDGabyNIBVjjaa++7Xtl6adG5eA1cmG5+koJzx4LPvw9tFPm4UigSi0gcaUV55sCfypC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741607784; c=relaxed/simple;
	bh=8tm/q9tne120Hl3XPPkcCixaygOeifODvFSvcXUTqok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=paIFfu1Kdjw+zT5DRN6uYT64QvI+hzCmjn1R5MXlcY3eY7hJ2mDWL0zk0Lv41JxYkFFAZvMKLwgUdSvH+QxnuvaS6vmVjMEqcoMcBDwbeqZAFdOcEB2qVuNWKy4fa080K+upawBQW/OHz9SMmtCvxEkMcgAGSkminKim7MOOdt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9530A153B;
	Mon, 10 Mar 2025 04:56:32 -0700 (PDT)
Received: from [10.1.27.50] (e133649.arm.com [10.1.27.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 44B7C3F673;
	Mon, 10 Mar 2025 04:56:18 -0700 (PDT)
Message-ID: <84a8f306-e2f6-4c9e-a150-72ee3c187b64@arm.com>
Date: Mon, 10 Mar 2025 11:56:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/uclamp: Let each sched_class handle uclamp
To: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan@unisoc.com>
References: <84441660bef0a5e67fd09dc3787178d0276dad31.1740664400.git.hongyan.xia2@arm.com>
 <4394f2a7-b4e8-419a-a299-f1afa560c944@arm.com>
 <CAB8ipk_627GF+TV5u=6DK_3aRUHW8qGYwmN+KXMq_Cg-+Say1Q@mail.gmail.com>
 <bf5a70bf-3d13-4b3b-a3ef-804998b21fe9@arm.com>
 <CAB8ipk-SUFDATb=euJQFebxQ513SRwTEpSbBSD6K=batQKELHg@mail.gmail.com>
 <80c2c9f4-eb84-4a43-9c48-8f776615b45a@arm.com>
 <CAB8ipk8pEvOtCm-d0o1rsekwxPWUHk9iBGtt9TLTWW-iWTQKiA@mail.gmail.com>
 <65365ec7-6a16-4e66-8005-e78788cbedfa@arm.com>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <65365ec7-6a16-4e66-8005-e78788cbedfa@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/03/2025 11:22, Dietmar Eggemann wrote:
> On 10/03/2025 12:03, Xuewen Yan wrote:
>> Hi Dietmar,
>>
>> On Mon, Mar 10, 2025 at 6:53 PM Dietmar Eggemann
>> <dietmar.eggemann@arm.com> wrote:
>>>
>>> On 10/03/2025 03:41, Xuewen Yan wrote:
>>>> On Sat, Mar 8, 2025 at 2:32 AM Dietmar Eggemann
>>>> <dietmar.eggemann@arm.com> wrote:
>>>>>
>>>>> On 06/03/2025 13:01, Xuewen Yan wrote:
>>>>>> On Thu, Mar 6, 2025 at 2:24 AM Dietmar Eggemann
>>>>>> <dietmar.eggemann@arm.com> wrote:
>>>>>>>
>>>>>>> On 27/02/2025 14:54, Hongyan Xia wrote:
>>>>>>>
>>>>>>> [...]
>>>>>>>
>>>>>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>>>>>> index 857808da23d8..7e5a653811ad 100644
>>>>>>>> --- a/kernel/sched/fair.c
>>>>>>>> +++ b/kernel/sched/fair.c
>>>>>>>> @@ -6941,8 +6941,10 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>>>>>>>         * Let's add the task's estimated utilization to the cfs_rq's
>>>>>>>>         * estimated utilization, before we update schedutil.
>>>>>>>>         */
>>>>>>>> -     if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & ENQUEUE_RESTORE))))
>>>>>>>> +     if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & ENQUEUE_RESTORE)))) {
>>>>>>>> +             uclamp_rq_inc(rq, p);
>>>>>>>>                util_est_enqueue(&rq->cfs, p);
>>>>>>>> +     }
>>>>>>>
>>>>>>> So you want to have p uclamp-enqueued so that its uclamp_min value
>>>>>>> counts for the cpufreq_update_util()/cfs_rq_util_change() calls later in
>>>>>>> enqueue_task_fair?
>>>>>>>
>>>>>>>    if (p->in_iowait)
>>>>>>>      cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
>>>>>>>
>>>>>>>    enqueue_entity() -> update_load_avg() -> cfs_rq_util_change() ->
>>>>>>>    cpufreq_update_util()
>>>>>>>
>>>>>>> But if you do this before requeue_delayed_entity() (1) you will not
>>>>>>> uclamp-enqueue p which got his ->sched_delayed just cleared in (1)?
>>>>>>>
>>>>>>
>>>>>> Could we change to the following:
>>>>>>
>>>>>> when enqueue:
>>>>>>
>>>>>> -     if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags
>>>>>> & ENQUEUE_RESTORE))))
>>>>>> +     if (!(p->se.sched_delayed && !(flags & ENQUEUE_DELAYED)))
>>>>>
>>>>> Why you want to check ENQUEUE_DELAYED as well here? Isn't
>>>>> !p->se.sched_delayed implying !ENQUEUE_DELAYED).
>>>>
>>>> Indeed, the (!(p->se.sched_delayed && !(flags & ENQUEUE_DELAYED))) is equal to
>>>> the  (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags &
>>>> ENQUEUE_RESTORE)))).
>>>> I just think it might be easier to read using the ENQUEUE_DELAYED flag.
>>>> Because we only allow enq the uclamp and util_est when wake up the delayed-task.
>>>
>>> OK, I see.
>>>
>>> So that means we would not have to move the uclamp handling into the sched
>>> classes necessarily, we could use flags in enqueue_task() as well:
>>>
>>> -->8--
>>>
>>> Subject: [PATCH] Align uclamp and util_est and call before freq update
>>>
>>> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>>> ---
>>>   kernel/sched/core.c | 14 ++++++++------
>>>   kernel/sched/fair.c |  4 ++--
>>>   2 files changed, 10 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index b60916d77482..f833108a3b2d 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -1747,7 +1747,8 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
>>>          }
>>>   }
>>>
>>> -static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
>>> +static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p,
>>> +                                int flags)
>>>   {
>>>          enum uclamp_id clamp_id;
>>>
>>> @@ -1763,7 +1764,7 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
>>>          if (unlikely(!p->sched_class->uclamp_enabled))
>>>                  return;
>>>
>>> -       if (p->se.sched_delayed)
>>> +       if (p->se.sched_delayed && !(flags & ENQUEUE_DELAYED))
>>>                  return;
>>>
>>>          for_each_clamp_id(clamp_id)
>>> @@ -2067,12 +2068,13 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
>>>          if (!(flags & ENQUEUE_NOCLOCK))
>>>                  update_rq_clock(rq);
>>>
>>> -       p->sched_class->enqueue_task(rq, p, flags);
>>>          /*
>>> -        * Must be after ->enqueue_task() because ENQUEUE_DELAYED can clear
>>> -        * ->sched_delayed.
>>> +        * Can be before ->enqueue_task() because uclamp considers the
>>> +        * ENQUEUE_DELAYED task before its ->sched_delayed gets cleared
>>> +        * in ->enqueue_task().
>>>           */
>>> -       uclamp_rq_inc(rq, p);
>>> +       uclamp_rq_inc(rq, p, flags);
>>> +       p->sched_class->enqueue_task(rq, p, flags);
>>>
>>>          psi_enqueue(p, flags);
>>>
>>
>> I submitted a patch similar to yours before:
>>
>> https://lore.kernel.org/all/CAB8ipk_AvaOWp9QhmnFDdbFSWcKLhCH151=no6kRO2z+pSJfyQ@mail.gmail.com/
>>
>> And Hongyan fears that as more complexity goes into each sched_class
>> like delayed dequeue,
>> so it's better to just let the sched_class handle how uclamp is
>> enqueued and dequeued within itself rather than leaking into core.c.
> 
> Ah, OK. Your patch didn't have 'sched' in the subject so I didn't see it
> immediately.
> 
> I would prefer that uclamp stays in core.c. ENQUEUE_DELAYED among all
> the other flags is already used there (ttwu_runnable()).
> 
> task_struct contains  sched_{,rt_,dl_}entity}. We just have to be
> careful when switching policies.

I lean towards letting each class handle uclamp. We've seen the trouble 
with delayed dequeue. Just like the if condition we have for util_est, 
if uclamp is in each class then we can re-use the condition easily, 
otherwise we need to carefully synchronize the enqueue/dequeue between 
core.c and the sub class.

Also I think so far we are assuming delayed dequeue is the only trouble 
maker. If RT and sched_ext have their own corner cases (I think maybe 
sched_ext is likely because it may eventually want the ext scheduler to 
be able to decide on uclamp itself) then the uclamp inc/dec in core.c 
need to cater for that as well. Once a task is in a class, the variables 
in another class may be in an undefined state, so checking corner cases 
for all the sub-classes in a centralized place like core.c may not even 
be easy to get right.

