Return-Path: <linux-kernel+bounces-241445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1314F927B83
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C5801C20ADF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 17:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D960A1B1201;
	Thu,  4 Jul 2024 17:01:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74BF18AED
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 17:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720112500; cv=none; b=Q/qEtDFYRktha6jY2J0Ei4VbvEfkEvj7QyMd5QPZntFfoPhvBO6P2a/VTyhjfTMRd+xEVsx0d+OtAk3ixQCb2qyzgNgLyjDA84zltMMBmGnKNcZL1s+nh6VizL0S8QXgrBx9tQiumAM7ztW0n0e0nfpED527J/2UOZ4LyVey6Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720112500; c=relaxed/simple;
	bh=q1v/3HwifHVlanOAwb5VRa6ZwetJnfkDjt/xMF1cJNo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=uCqfXqNPMWc2VEC/ZdqaXiBPQRi5nVLOmFKklsgNwsUMC/BI9ggkJNRr+bkkmyr5fjLsLj6HiE2CcpL7xJ1ZvjegOmtD/BgQ9mCk60yg8tOVvKziNj4mYvsiXC2mCcQrBYA6/Gug6AXRlpVWnJq55N2nL0OsvMi+4kmWpaPqL0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DA433367;
	Thu,  4 Jul 2024 10:02:01 -0700 (PDT)
Received: from [192.168.1.13] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 218F83F73B;
	Thu,  4 Jul 2024 10:01:32 -0700 (PDT)
Message-ID: <c4eaadcd-e563-41cf-b174-cd0fb4453c6f@arm.com>
Date: Thu, 4 Jul 2024 19:01:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH V2 1/2] sched/fair: Prevent cpu_busy_time from exceeding
 actual_cpu_capacity
To: Vincent Guittot <vincent.guittot@linaro.org>,
 Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, dietmar.eggemann@arm.com,
 mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 qyousef@layalina.io, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 christian.loehle@arm.com, vincent.donnefort@arm.com, ke.wang@unisoc.com,
 di.shen@unisoc.com, linux-kernel@vger.kernel.org
References: <20240624082011.4990-1-xuewen.yan@unisoc.com>
 <20240624082011.4990-2-xuewen.yan@unisoc.com>
 <CAKfTPtB=Yk8Bp4sSanr4fCdyWA9PVROM+uiWsQSh+QjFpKb+Aw@mail.gmail.com>
 <CAB8ipk-yAoX5EJ975ZVKfgZP7rP-vzuc3bLVr6yiLtMv26Lxjw@mail.gmail.com>
 <CAKfTPtDuuF8XX3gbsjF_Vgys2UtbzwtaX9QFgA-3kZ7+eqk02w@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAKfTPtDuuF8XX3gbsjF_Vgys2UtbzwtaX9QFgA-3kZ7+eqk02w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

On 6/27/24 18:15, Vincent Guittot wrote:
> On Thu, 27 Jun 2024 at 04:02, Xuewen Yan <xuewen.yan94@gmail.com> wrote:
>>
>> On Tue, Jun 25, 2024 at 9:05 PM Vincent Guittot
>> <vincent.guittot@linaro.org> wrote:
>>>
>>> On Mon, 24 Jun 2024 at 10:22, Xuewen Yan <xuewen.yan@unisoc.com> wrote:
>>>>
>>>> Commit 3e8c6c9aac42 ("sched/fair: Remove task_util from effective utilization in feec()")
>>>> changed the PD's util from per-CPU to per-PD capping. But because
>>>> the effective_cpu_util() would return a util which maybe bigger
>>>> than the actual_cpu_capacity, this could cause the pd_busy_time
>>>> calculation errors.
>>>
>>> I'm still not convinced that this is an error. Your example used for v1 is :
>>>
>>> The pd cpus are 4-7, and the arch_scale_capacity is 1024, and because
>>> of cpufreq-limit, the cpu_actual_cap = 512.
>>>
>>> Then the eenv->cpu_cap = 512, the eenv->pd_cap = 2048;
>>> effective_cpu_util(4) = 1024;
>>> effective_cpu_util(5) = 1024;
>>> effective_cpu_util(6) = 256;
>>> effective_cpu_util(7) = 0;
>>>
>>> so env->pd_busy_time = 2304

IIUC, with this configuration:
Before patch:
- env->pd_busy_time = 2304
After patch:
- env->pd_busy_time = 512 + 512 + 256 + 0 = 1280

But when computing the energy for the task to place:
compute_energy()
{
   if (dst_cpu >= 0)
     busy_time = min(eenv->pd_cap, busy_time + eenv->task_busy_time);
}

the contribution of the task might be truncated.
E.g.:
Trying to place a task on CPU7 with task_busy_time=300.
Then in compute_energy():

Before patch:
busy_time = min(2048, 2304 + 300)
busy_time = 2048
-> busy_time delta = 2048 - 2304 = 256

After patch:
busy_time = min(2048, 1280 + 300)
busy_time = 1580
-> busy_time delta = 1580 - 1280 = 300

>>>
>>> Even if effective_cpu_util(4) = 1024; is above the current max compute
>>> capacity of 512, this also means that activity of cpu4 will run twice
>>> longer . If you cap effective_cpu_util(4) to 512 you miss the
>>> information that it will run twice longer at the selected OPP. The
>>> extreme case being:
>>> effective_cpu_util(4) = 1024;
>>> effective_cpu_util(5) = 1024;
>>> effective_cpu_util(6) = 1024;
>>> effective_cpu_util(7) = 1024;
>>>
>>> in this case env->pd_busy_time = 4096
>>>
>>> If we cap, we can't make any difference between the 2 cases
>>>
>>> Do you have more details about the problem you are facing ?
>>
>> Because of the cpufreq-limit, the opp was also limited, and when compute_energy:
>>
>> energy =  ps->cost * sum_util =  ps->cost * eenv->pd_busy_time;
>>
>> Because of the cpufreq-limit, the ps->cost is the limited-freq's opp's
>> cost instead of the max freq's cost.
>> So the energy is determined by pd_busy_time.
>>
>> Still the example above:
>>
>> The pd cpus are 4-7, and the arch_scale_capacity is 1024, and because
>> of cpufreq-limit, the cpu_actual_cap = 512.
>>
>> Then the eenv->cpu_cap = 512, the eenv->pd_cap = 2048;
>> effective_cpu_util(4) = 1024;
>> effective_cpu_util(5) = 1024;
>> effective_cpu_util(6) = 256;
>> effective_cpu_util(7) = 0;
>>
>> Before the patch:
>> env->pd_busy_time = min(1024+1024+256, eenv->pd_cap) = 2048.
>> However, because the effective_cpu_util(7) = 0, indeed, the 2048 is bigger than
>> the actual_cpu_cap.
>>
>> After the patch:
>> cpu_util(4) = min(1024, eenv->cpu_cap) = 512;
>> cpu_util(5) = min(1024, eenv->cpu_cap) = 512;
>> cpu_util(6) = min(256, eenv->cpu_cap) = 256;
>> cpu_util(7) = 0;
>> env->pd_busy_time = min(512+512+256, eenv->pd_cap) = 1280.

If we take a similar example, on a pd with 2 CPUs and:
- effective_cpu_util(0) = 1024
- effective_cpu_util(1) = 0
and:
- eenv->cpu_cap = 100
- eenv->pd_cap = 100 + 100 = 200

Before the patch:
- env->pd_busy_time = min(1024 + 0, eenv->pd_cap) = 200

After the patch:
- cpu_util(0) = min(1024, eenv->cpu_cap) = 100
- cpu_util(1) = min(0, eenv->cpu_cap) = 0
and:
- env->pd_busy_time = min(100 + 0, eenv->pd_cap) = 100

-------------

Same example while adding additional empty CPUs:
- effective_cpu_util(0) = 1024
- effective_cpu_util(1) = 0
- effective_cpu_util(2) = 0
- effective_cpu_util(3) = 0
and:
- eenv->cpu_cap = 100
- eenv->pd_cap = 100 * 4 = 400

Before the patch:
- env->pd_busy_time = min(1024 + 0 + 0 + 0, eenv->pd_cap) = 400

After the patch:
- cpu_util(0) = min(1024, eenv->cpu_cap) = 100
- cpu_util(1) = min(0, eenv->cpu_cap) = 0
- ...
and:
- env->pd_busy_time = min(100 + 0 + 0 + 0, eenv->pd_cap) = 100

-------------

What seems strange is that the more we add empty CPUs in a pd,
the more energy is spent in the first computation, which seems
indeed incorrect (unless I missed something).

>>
>> As a result, without this patch, the energy is bigger than actual_energy.
>>
>> And even if cpu4 would run twice longer, the energy may not be equal.
>> Because:
>>   *             ps->power * cpu_max_freq
>> *   cpu_nrg = ------------------------ * cpu_util           (3)
>> *               ps->freq * scale_cpu
>>
>> the ps->power = cfv2, and then:
>>
>> *                  cv2 * cpu_max_freq
>> *   cpu_nrg = ------------------------ * cpu_util           (3)
>> *                    scale_cpu
>>
>> because the limited-freq's voltage is not equal to the max-freq's voltage.
> 
> I'm still struggling to understand why it's wrong. If the frequency is
> capped, we will never go above this limited frequency and its
> associated voltage so there is no reason to consider max-freq's
> voltage. If there is more things to do than the actual capacity can do
> per unit of time then we will run more than 1 unit of time.
> 
> nrg of PD = /Sum(cpu) ps->power * cpu-running-time
> 
> ps->power is fixed because of the limited frequency constraint
> 
> we estimate cpu-running-time = utilization / ps->performance
> with
> - utilization = util_avg
> - performance = ps->freq / cpu_max_freq * arch_scale_cpu_capacity() =
> ps->performance
> 
> Up to now we were assuming that utilization was always lower than
> performance otherwise the system was overutilized andwe fallback in
> performance mode. But when the frequency of a cpu is limited by
> userspace or thermal mitigation, the utilization can become higher
> than the limited capacity which can be translated by cpu will run
> longer.

I thought the EAS was comparing instantaneous power and not energy,
i.e. how the energy computation is done:

   *             ps->power * cpu_max_freq
   *   cpu_nrg = ------------------------ * cpu_util           (3)
   *               ps->freq * scale_cpu

cpu_nrg should have the same dimension as ps->power (i.e. energy/s).
  From this PoV, the energy computation should not take into account how
much time a task is expected to run. But it might be a side discussion,

Regards,
Pierre


> 
>>
>>>
>>>
>>>
>>>> So clamp the cpu_busy_time with the eenv->cpu_cap, which is
>>>> the actual_cpu_capacity.
>>>>
>>>> Fixes: 3e8c6c9aac42 ("sched/fair: Remove task_util from effective utilization in feec()")
>>>> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
>>>> Tested-by: Christian Loehle <christian.loehle@arm.com>
>>>> ---
>>>> V2:
>>>> - change commit message.
>>>> - remove the eenv->pd_cap capping in eenv_pd_busy_time(). (Dietmar)
>>>> - add Tested-by.
>>>> ---
>>>>   kernel/sched/fair.c | 9 +++++----
>>>>   1 file changed, 5 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index 8a5b1ae0aa55..5ca6396ef0b7 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -7864,16 +7864,17 @@ static inline void eenv_pd_busy_time(struct energy_env *eenv,
>>>>                                       struct cpumask *pd_cpus,
>>>>                                       struct task_struct *p)
>>>>   {
>>>> -       unsigned long busy_time = 0;
>>>>          int cpu;
>>>>
>>>> +       eenv->pd_busy_time = 0;
>>>> +
>>>>          for_each_cpu(cpu, pd_cpus) {
>>>>                  unsigned long util = cpu_util(cpu, p, -1, 0);
>>>>
>>>> -               busy_time += effective_cpu_util(cpu, util, NULL, NULL);
>>>> +               util = effective_cpu_util(cpu, util, NULL, NULL);
>>>> +               util = min(eenv->cpu_cap, util);
>>>> +               eenv->pd_busy_time += util;
>>>>          }
>>>> -
>>>> -       eenv->pd_busy_time = min(eenv->pd_cap, busy_time);
>>>>   }
>>>>
>>>>   /*
>>>> --
>>>> 2.25.1
>>>>
>>>>
> 

