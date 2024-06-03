Return-Path: <linux-kernel+bounces-198556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501298D7A37
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 04:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4AE1C20C1D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 02:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E38B663;
	Mon,  3 Jun 2024 02:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="GBpa7xoo"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77248D29B
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 02:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717383499; cv=none; b=VMrdihno2OnIk2fyGkqxmNAe1YxdlU7tglopi+8EUwS9JS37q8PdRk0GrO/3D/NSCZNUxng6Tywds6dGJalT1CGImFslcIqvjgu+fOsV3ATUjJPI8wF2Hsv5O2fljlTgJYi/+0wsW5ESrEQFbUkolG08O1TI2omiZ6rxCzwWO7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717383499; c=relaxed/simple;
	bh=TDMzxrWehCpcrouEiQlU14TqotNUMejWIh7fhfoLRAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CeQ1IlInWEIC+WLI9qJELsSoTH/PpEbz0wq2+81T3RFAN6TJeAP7Yr2zdQ1LZWvzHwE3MPPCthzpXRQjj8GlOHFzbzcGyp7MaDqdyujj1IaHToiHWe2UCrkfD7wwNpQYvSjyQEiHTgh2QEXqVSWyBZqn2RpSn3BRH16L+AahoPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=GBpa7xoo; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=wMpQlTsu2ZFAUv16znDumhREYmtHYvEuZSemXgjeZdI=;
	b=GBpa7xooWCGlDga9bf8cUDJ8sBI04RVvcxjgLc/UiNhPIxSSmrjut4RWW70Bpm
	ZVNx6gy0ueZriADEKz0dVmg2shBeVzNT92wJuUw+iFLW4NII3EOoYd+fUYTfQofS
	Rc2UVT2MUA9rW3RV2hHwRyK147Ud5xfwAjUImabt3BV90=
Received: from [172.24.140.185] (unknown [111.204.182.99])
	by gzga-smtp-mta-g0-0 (Coremail) with SMTP id _____wD3H_urMF1mdhOPAw--.9565S2;
	Mon, 03 Jun 2024 10:55:42 +0800 (CST)
Message-ID: <bb43844e-0ef2-44d6-9d98-496865d942b9@126.com>
Date: Mon, 3 Jun 2024 10:55:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched/fair: Reschedule the cfs_rq when current is
 ineligible
To: Chunxin Zang <spring.cxz@gmail.com>
Cc: dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
 linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
 yangchen11@lixiang.com, Jerry Zhou <zhouchunhua@lixiang.com>,
 Chunxin Zang <zangchunxin@lixiang.com>, mingo@redhat.com,
 Peter Zijlstra <peterz@infradead.org>, juri.lelli@redhat.com,
 vincent.guittot@linaro.org
References: <20240524134011.270861-1-spring.cxz@gmail.com>
 <572bef0a-727c-4922-93e9-ad29c385120e@126.com>
 <6AF97701-B8F4-46C6-851E-A8BACE97E8C0@gmail.com>
Content-Language: en-US
From: Honglei Wang <jameshongleiwang@126.com>
In-Reply-To: <6AF97701-B8F4-46C6-851E-A8BACE97E8C0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3H_urMF1mdhOPAw--.9565S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Gr1rurykJw4kZFy7Kw4Uurg_yoW7WrWfpF
	ZIqa42vF4kJw1UJ3yIyw4I9FyrGFWfAFy8XFn5tFyFqFnxK3Wftr13KrWjkrW09r4F9r1a
	vr4qq3y3u34qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UC_M-UUUUU=
X-CM-SenderInfo: 5mdpv2pkrqwzphlzt0bj6rjloofrz/1tbiYAXyrWV21EhACgAEs7



On 2024/5/29 22:31, Chunxin Zang wrote:
> 
> 
>> On May 25, 2024, at 19:48, Honglei Wang <jameshongleiwang@126.com> wrote:
>>
>>
>>
>> On 2024/5/24 21:40, Chunxin Zang wrote:
>>> I found that some tasks have been running for a long enough time and
>>> have become illegal, but they are still not releasing the CPU. This
>>> will increase the scheduling delay of other processes. Therefore, I
>>> tried checking the current process in wakeup_preempt and entity_tick,
>>> and if it is illegal, reschedule that cfs queue.
>>> The modification can reduce the scheduling delay by about 30% when
>>> RUN_TO_PARITY is enabled.
>>> So far, it has been running well in my test environment, and I have
>>> pasted some test results below.
>>> I isolated four cores for testing. I ran Hackbench in the background
>>> and observed the test results of cyclictest.
>>> hackbench -g 4 -l 100000000 &
>>> cyclictest --mlockall -D 5m -q
>>>                                   EEVDF      PATCH  EEVDF-NO_PARITY  PATCH-NO_PARITY
>>>                  # Min Latencies: 00006      00006      00006      00006
>>>    LNICE(-19)    # Avg Latencies: 00191      00122      00089      00066
>>>                  # Max Latencies: 15442      07648      14133      07713
>>>                  # Min Latencies: 00006      00010      00006      00006
>>>    LNICE(0)      # Avg Latencies: 00466      00277      00289      00257
>>>                  # Max Latencies: 38917      32391      32665      17710
>>>                  # Min Latencies: 00019      00053      00010      00013
>>>    LNICE(19)     # Avg Latencies: 37151      31045      18293      23035
>>>                  # Max Latencies: 2688299    7031295    426196     425708
>>> I'm actually a bit hesitant about placing this modification under the
>>> NO_PARITY feature. This is because the modification conflicts with the
>>> semantics of RUN_TO_PARITY. So, I captured and compared the number of
>>> resched occurrences in wakeup_preempt to see if it introduced any
>>> additional overhead.
>>> Similarly, hackbench is used to stress the utilization of four cores to
>>> 100%, and the method for capturing the number of PREEMPT occurrences is
>>> referenced from [1].
>>> schedstats                          EEVDF       PATCH   EEVDF-NO_PARITY  PATCH-NO_PARITY  CFS(6.5)
>>> stats.check_preempt_count          5053054     5057286    5003806    5018589    5031908
>>> stats.patch_cause_preempt_count    -------     858044     -------    765726     -------
>>> stats.need_preempt_count           570520      858684     3380513    3426977    1140821
>>>  From the above test results, there is a slight increase in the number of
>>> resched occurrences in wakeup_preempt. However, the results vary with each
>>> test, and sometimes the difference is not that significant. But overall,
>>> the count of reschedules remains lower than that of CFS and is much less
>>> than that of NO_PARITY.
>>> [1]: https://lore.kernel.org/all/20230816134059.GC982867@hirez.programming.kicks-ass.net/T/#m52057282ceb6203318be1ce9f835363de3bef5cb
>>> Signed-off-by: Chunxin Zang <zangchunxin@lixiang.com>
>>> Reviewed-by: Chen Yang <yangchen11@lixiang.com>
>>> ---
>>>   kernel/sched/fair.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 03be0d1330a6..a0005d240db5 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -5523,6 +5523,9 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr, int queued)
>>>   			hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
>>>   		return;
>>>   #endif
>>> +
>>> +	if (!entity_eligible(cfs_rq, curr))
>>> +		resched_curr(rq_of(cfs_rq));
>>>   }
>>>     @@ -8325,6 +8328,9 @@ static void check_preempt_wakeup_fair(struct rq *rq, struct task_struct *p, int
>>>   	if (unlikely(p->policy != SCHED_NORMAL) || !sched_feat(WAKEUP_PREEMPTION))
>>>   		return;
>>>   +	if (!entity_eligible(cfs_rq, se))
>>> +		goto preempt;
>>> +
>>>   	find_matching_se(&se, &pse);
>>>   	WARN_ON_ONCE(!pse);
>>>   
>> Hi Chunxin,
>>
>> Did you run a comparative test to see which modification is more helpful on improve the latency? Modification at tick point makes more sense to me. But, seems just resched arbitrarily in wakeup might introduce too much preemption (and maybe more context switch?) in complex environment such as cgroup hierarchy.
>>
>> Thanks,
>> Honglei
> 
> Hi Honglei
> 
> I attempted to build a slightly more complex scenario. It consists of 4 isolated cores,
> 4 groups of hackbench (160 processes in total) to stress the CPU, and 1 cyclictest
> process to test scheduling latency. Using cgroup v2, to created 64 cgroup leaf nodes
> in a binary tree structure (with a depth of 7). I then evenly distributed the aforementioned
> 161 processes across the 64 cgroups respectively, and observed the scheduling delay
> performance of cyclictest.
> 
> Unfortunately, the test results were very fluctuating, and the two sets of data were very
> close to each other. I suspect that it might be due to too few processes being distributed
> in each cgroup, which led to the logic for determining ineligible always succeeding and
> following the original logic. Later, I will attempt more tests to verify the impact of these
> modifications in scenarios involving multiple cgroups.
> 

Sorry to lately replay, I was a bit busy last week. How's the test going 
on? What about run some workload processes who spend more time in 
kernel? Maybe it's worth do give a try, but it depends on your test plan.

Thanks,
Honglei

> thanks
> Chunxin
> 
> 


