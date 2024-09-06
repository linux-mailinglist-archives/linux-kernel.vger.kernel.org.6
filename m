Return-Path: <linux-kernel+bounces-319136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8E996F830
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73DCDB21400
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 232461D174A;
	Fri,  6 Sep 2024 15:32:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825D0381C2
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725636748; cv=none; b=bECid7wbxJ1eKRaId1WFO721KiyOwvuO4id2uq3y6qnXuO+qhYNsAir06tmRFRX6lkBwc+v3Rb8f5Ux9nbFDYnEi5Ops2qXZu5Bwv7BZvYfc91nt7hZ8Y0WT03n+KvG0sTDtPZfZJol0Mju3Z2t4vBNJg4LA5MeCS5gtPVzGivE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725636748; c=relaxed/simple;
	bh=ByDNBBGJ9/lJbk/2+FgIhf3ysUlKodT9CKFvUu9V1Bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TjILlikOUpQonDBBdjm6eOz6QZDJek4G7aXa8Bcvs1bShzHs+QeVQn+FGAA5utSZwVwSP1H41SePmoB1tG+mvbOCA1B+mW1lqwghpe5Jf6kIT60SbiW1gTBRhSIODOcmeTS8EbFQNDiMccO4uM9ngOYflzpufj5C/KPeQlSL4C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFCF9FEC;
	Fri,  6 Sep 2024 08:32:50 -0700 (PDT)
Received: from [10.57.50.61] (unknown [10.57.50.61])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 252D23F73F;
	Fri,  6 Sep 2024 08:32:22 -0700 (PDT)
Message-ID: <27e1b3c6-7e5b-4e52-9ba4-4e08fe7a11fc@arm.com>
Date: Fri, 6 Sep 2024 16:32:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] sched/fair: Rework feec() to use cost instead of
 spare capacity
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: linux-kernel@vger.kernel.org, qyousef@layalina.io, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
 rostedt@goodmis.org, bsegall@google.com, vschneid@redhat.com,
 lukasz.luba@arm.com, mgorman@suse.de, rafael.j.wysocki@intel.com
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-4-vincent.guittot@linaro.org>
 <066b7de8-0854-424b-8888-b18fc61ec21c@arm.com>
 <CAKfTPtAX22QPPfA1smH9eOWpqBzXZ=enUOAE8zscEFY9wBbkZQ@mail.gmail.com>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <CAKfTPtAX22QPPfA1smH9eOWpqBzXZ=enUOAE8zscEFY9wBbkZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/09/2024 08:08, Vincent Guittot wrote:
> On Mon, 2 Sept 2024 at 13:03, Hongyan Xia <hongyan.xia2@arm.com> wrote:
>>
>> On 30/08/2024 14:03, Vincent Guittot wrote:
>>> feec() looks for the CPU with highest spare capacity in a PD assuming that
>>> it will be the best CPU from a energy efficiency PoV because it will
>>> require the smallest increase of OPP. Although this is true generally
>>> speaking, this policy also filters some others CPUs which will be as
>>> efficients because of using the same OPP.
>>> In fact, we really care about the cost of the new OPP that will be
>>> selected to handle the waking task. In many cases, several CPUs will end
>>> up selecting the same OPP and as a result using the same energy cost. In
>>> these cases, we can use other metrics to select the best CPU for the same
>>> energy cost.
>>>
>>> Rework feec() to look 1st for the lowest cost in a PD and then the most
>>> performant CPU between CPUs.
>>>
>>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>>> ---
>>>    kernel/sched/fair.c | 466 +++++++++++++++++++++++---------------------
>>>    1 file changed, 244 insertions(+), 222 deletions(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index e67d6029b269..2273eecf6086 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> [...]
>>>
>>> -     energy = em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
>>> +/* For a same cost, select the CPU that will povide best performance for the task */
>>> +static bool select_best_cpu(struct energy_cpu_stat *target,
>>> +                         struct energy_cpu_stat *min,
>>> +                         int prev, struct sched_domain *sd)
>>> +{
>>> +     /*  Select the one with the least number of running tasks */
>>> +     if (target->nr_running < min->nr_running)
>>> +             return true;
>>> +     if (target->nr_running > min->nr_running)
>>> +             return false;
>>>
>> This makes me a bit worried about systems with coarse-grained OPPs. All
>> my dev boards and one of my old phones have <= 3 OPPs. On my Juno board,
>> the lowest OPP on the big core spans across 512 utilization, half of the
>> full capacity. Assuming a scenario where there are 4 tasks, each with
>> 300, 100, 100, 100 utilization, the placement should be 300 on one core
>> and 3 tasks with 100 on another, but the nr_running check here would
>> give 2 tasks (300 + 100) on one CPU and 2 tasks (100 + 100) on another
>> because they are still under the lowest OPP on Juno. The second CPU will
>> also finish faster and idle more than the first one.
> 
> By balancing the number of tasks on each cpu, I try to minimize the
> scheduling latency. In your case above, tasks will wait for no more
> than a slice before running whereas it might have to wait up to 2
> slices if I put all the (100 utilization) tasks on the same CPU.

If viewed in another angle, we are now asking the 300 task (which 
potentially has a heavier workload to finish) to compete with a 100 
task, and now one core finishes faster and the other takes longer time, 
making the overall execution time longer.

>>
>> To give an extreme example, assuming the system has only one OPP (such a
>> system is dumb to begin with, but just to make a point), before this
>> patch EAS would still work okay in task placement, but after this patch,
> 
> Not sure what you mean by would still work okay. Do you have an
> example in mind that would not work correctly ?

With only one OPP, this patch will balance task placement purely on the 
number of tasks without considering utilization, and I don't think 
that's entirely acceptable (I actually need to deal with such a device 
with only one OPP in real life, although that's the fault of that 
device). Before, we are still balancing on total utilization, which 
results in the lowest execution time.

> 
>> EAS would just balance on the number of tasks, regardless of utilization
>> of tasks on wake-up.
> 
> You have to keep in mind that utilization is already taken into
> account to check if the task fits the CPU and by selecting the OPP
> (which is a nope in case of one OPP). So we know that there is enough
> capacity for the waking task

Still, taking my Juno board as an example where the 1st OPP is at 
utilization 512. Assuming no 25% margin, four tasks with utilization 
200, 200, 50, 50 and two CPUs, I would strongly favor 200 + 50 on one 
CPU and same on the other, than 200 + 200 on one, 50 + 50 on the other. 
However, with this patch, these two scheduling decisions are the same, 
as long as both are under the 512 OPP.

Of course, this becomes less of a problem with fine-grained OPPs. On my 
Pixel 6 with 18 OPPs on one CPU, I don't have such concerns.

>>
>> I wonder if there is a way to still take total utilization as a factor.
> 
> utilization is still used to check that the task utilization fits with
> current cpu utilization and then to select the OPP. At this step we
> know that there is enough capacity for everybody
> 
>> It used to be 100% of the decision making, but maybe now it is only 60%,
>> and the other 40% are things like number of tasks and contention.
>>
>>> -     trace_sched_compute_energy_tp(p, dst_cpu, energy, max_util, busy_time);
>>> +     /* Favor previous CPU otherwise */
>>> +     if (target->cpu == prev)
>>> +             return true;
>>> +     if (min->cpu == prev)
>>> +             return false;
>>>
>>> -     return energy;
>>> +     /*
>>> +      * Choose CPU with lowest contention. One might want to consider load instead of
>>> +      * runnable but we are supposed to not be overutilized so there is enough compute
>>> +      * capacity for everybody.
>>> +      */
>>> +     if ((target->runnable * min->capa * sd->imbalance_pct) >=
>>> +                     (min->runnable * target->capa * 100))
>>> +             return false;
>>> +
>>> +     return true;
>>>    }
>>> [...]
>>

