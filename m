Return-Path: <linux-kernel+bounces-317227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C20096DB27
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 16:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6844AB20E01
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 14:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AF519DF8B;
	Thu,  5 Sep 2024 14:07:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D7119AA46
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545229; cv=none; b=GJAp1X/BCIpwN6s5gZQ4FvJcYsXWUAD52nyoYr0brsXNpBJI96q6r7hIqmDfT0TQBXz9l8SY92y+4TgeDMqN9c2dZOQOC0qu16F+1NC2OUk87N7JYQLz6aCfteybxSSkBrqC5T6brj2On2fo9AmrVeuIFmOSqnYFX7xztODC9oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545229; c=relaxed/simple;
	bh=WUOAIwsLDvuKR+QduXY+WsLRqaDECp66nQyxrknNY84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kgnZREI8lfuBETVsPZBQkaTfTw+yE4B5IWJxAKIuNhJWFnsrYkFcI7OyF9v/7AI0oXhcMSDms+qm9Y9G124SjOiiUdhy6lphkZkSxeT0LAjA9ixTdBbWLQwhcZknV0D5Nkqk3ZCLoQ4bCj/7JDmxnUjBipUWWOLgOTzRsMVwgJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 26DB1FEC;
	Thu,  5 Sep 2024 07:07:34 -0700 (PDT)
Received: from [192.168.178.115] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DC6D3F73F;
	Thu,  5 Sep 2024 07:07:04 -0700 (PDT)
Message-ID: <a9a45193-d0c6-4ba2-a822-464ad30b550e@arm.com>
Date: Thu, 5 Sep 2024 16:07:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Hongyan Xia <hongyan.xia2@arm.com>, Luis Machado <luis.machado@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
 juri.lelli@redhat.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
 kprateek.nayak@amd.com, wuyun.abel@bytedance.com, youssefesmat@chromium.org,
 tglx@linutronix.de, efault@gmx.de
References: <20240727102732.960974693@infradead.org>
 <20240727105029.315205425@infradead.org>
 <6f39e567-fd9a-4157-949d-7a9ccd9c3592@arm.com>
 <CAKfTPtAS0eSqf5Qoq_rpQC7DbyyGX=GACsB7OPdhi8=HEciPUQ@mail.gmail.com>
 <1debbea4-a0cf-4de9-9033-4f6135a156ed@arm.com>
 <CAKfTPtCEUZxV9zMpguf7RKs6njLsJJUmz8WadyS4ryr+Fqca1Q@mail.gmail.com>
 <83a20d85-de7a-4fe6-8cd8-5a96d822eb6b@arm.com>
 <629937b1-6f97-41d1-aa4f-7349c2ffa29d@arm.com>
 <CAKfTPtBPK8ovttHDQjfuwve63PK_pNH4WMznEHWoXQ=2vGhKQQ@mail.gmail.com>
 <CAKfTPtDO3n-4mcr2Sk-uu0ZS5xQnagdicQmaBh-CyrndPLM8eQ@mail.gmail.com>
 <aa81d37e-ad9c-42c6-a104-fe8496c5d907@arm.com>
 <c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm.com>
 <CAKfTPtCNUvWE_GX5LyvTF-WdxUT=ZgvZZv-4t=eWntg5uOFqiQ@mail.gmail.com>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <CAKfTPtCNUvWE_GX5LyvTF-WdxUT=ZgvZZv-4t=eWntg5uOFqiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/09/2024 15:33, Vincent Guittot wrote:
> On Thu, 5 Sept 2024 at 15:02, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 29/08/2024 17:42, Hongyan Xia wrote:
>>> On 22/08/2024 15:58, Vincent Guittot wrote:
>>>> On Thu, 22 Aug 2024 at 14:10, Vincent Guittot
>>>> <vincent.guittot@linaro.org> wrote:
>>>>>
>>>>> On Thu, 22 Aug 2024 at 14:08, Luis Machado <luis.machado@arm.com> wrote:
>>>>>>
>>>>>> Vincent,
>>>>>>
>>>>>> On 8/22/24 11:28, Luis Machado wrote:
>>>>>>> On 8/22/24 10:53, Vincent Guittot wrote:
>>>>>>>> On Thu, 22 Aug 2024 at 11:22, Luis Machado <luis.machado@arm.com>
>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>> On 8/22/24 09:19, Vincent Guittot wrote:
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> On Wed, 21 Aug 2024 at 15:34, Hongyan Xia <hongyan.xia2@arm.com>

[...]

>>> After staring at the code even more, I think the situation is worse.
>>>
>>> First thing is that uclamp might also want to be part of these stats
>>> (h_nr_running, util_est, runnable_avg, load_avg) that do not follow
>>> delayed dequeue which needs to be specially handled in the same way. The
>>> current way of handling uclamp in core.c misses the frequency update,
>>> like I commented before.
>>>
>>> Second, there is also an out-of-sync issue in update_load_avg(). We only
>>> update the task-level se in delayed dequeue and requeue, but we return
>>> early and the upper levels are completely skipped, as if the delayed
>>> task is still on rq. This de-sync is wrong.
>>
>> I had a look at the util_est issue.
>>
>> This keeps rq->cfs.avg.util_avg sane for me with
>> SCHED_FEAT(DELAY_DEQUEUE, true):
>>
>> -->8--
>>
>> From 0d7e8d057f49a47e0f3f484ac7d41e047dccec38 Mon Sep 17 00:00:00 2001
>> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> Date: Thu, 5 Sep 2024 00:05:23 +0200
>> Subject: [PATCH] kernel/sched: Fix util_est accounting for DELAY_DEQUEUE
>>
>> Remove delayed tasks from util_est even they are runnable.
> 
> Unfortunately, this is not only about util_est
> 
> cfs_rq's runnable_avg is also wrong  because we normally have :
> cfs_rq's runnable_avg == /Sum se's runnable_avg
> but cfs_rq's runnable_avg uses cfs_rq's h_nr_running but delayed
> entities are still accounted in h_nr_running

Yes, I agree.

se's runnable_avg should be fine already since:

se_runnable()

  if (se->sched_delayed)
    return false

But then, like you said, __update_load_avg_cfs_rq() needs correct
cfs_rq->h_nr_running.

And I guess we need something like:

se_on_rq()

  if (se->sched_delayed)
    return false

for

__update_load_avg_se()

- if (___update_load_sum(now, &se->avg, !!se->on_rq, se_runnable(se),
+ if (___update_load_sum(now, &se->avg, se_on_rq(se), se_runnable(se),


My hope was we can fix util_est independently since it drives CPU
frequency. Whereas PELT load_avg and runnable_avg are "only" used for
load balancing. But I agree, it has to be fixed as well.

> That also means that cfs_rq's h_nr_running is not accurate anymore
> because it includes delayed dequeue

+1

> and cfs_rq load_avg is kept artificially high which biases
> load_balance and cgroup's shares

+1

>> Exclude delayed task which are (a) migrating between rq's or (b) in a
>> SAVE/RESTORE dequeue/enqueue.

I just realized that this fixes the uneven util_est_dequeue/enqueue
calls so we don't see the underflow depicted by Hongyan and no massive
rq->cfs util_est due to missing ue_dequeues.
But delayed tasks are part of rq->cfs util_est, not excluded. Let me fix
that.

>> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> ---
>>  kernel/sched/fair.c | 16 +++++++++-------
>>  1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 1e693ca8ebd6..5c32cc26d6c2 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6948,18 +6948,19 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>         int rq_h_nr_running = rq->cfs.h_nr_running;
>>         u64 slice = 0;
>>
>> -       if (flags & ENQUEUE_DELAYED) {
>> -               requeue_delayed_entity(se);
>> -               return;
>> -       }
>> -
>>         /*
>>          * The code below (indirectly) updates schedutil which looks at
>>          * the cfs_rq utilization to select a frequency.
>>          * Let's add the task's estimated utilization to the cfs_rq's
>>          * estimated utilization, before we update schedutil.
>>          */
>> -       util_est_enqueue(&rq->cfs, p);
>> +       if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & ENQUEUE_RESTORE))))
>> +               util_est_enqueue(&rq->cfs, p);
>> +
>> +       if (flags & ENQUEUE_DELAYED) {
>> +               requeue_delayed_entity(se);
>> +               return;
>> +       }
>>
>>         /*
>>          * If in_iowait is set, the code below may not trigger any cpufreq
>> @@ -7177,7 +7178,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
>>   */
>>  static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>>  {
>> -       util_est_dequeue(&rq->cfs, p);
>> +       if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & DEQUEUE_SAVE))))
>> +               util_est_dequeue(&rq->cfs, p);
>>
>>         if (dequeue_entities(rq, &p->se, flags) < 0) {
>>                 if (!rq->cfs.h_nr_running)
>> --
>> 2.34.1


