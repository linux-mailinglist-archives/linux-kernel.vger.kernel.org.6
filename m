Return-Path: <linux-kernel+bounces-548818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7C7A549A6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 12:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC2E3AEE52
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E798C20C46A;
	Thu,  6 Mar 2025 11:32:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885F120AF78
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 11:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260761; cv=none; b=h/Zc7PDggLC/tw5KUOECRT5pAytEw2jR3vvfuiqDMqA6AEp38l5lfKE3SGo7YORvVmyN4XE/yWpz36vrvz8tnYqcZQGFFmhzZYWfSvrPwaWpAJfm64PfZuq1qj5P9AnsFfsa7A7YvR4vSPLeCpgCxasOTE9HTyYMdrckNnqwdGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260761; c=relaxed/simple;
	bh=fGxSMZNIXHn7sNKVZBLMpXB80R8qnu2vP3THUDn00vM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nOhIs6jdPZI6WducWamzZNNEd0guYUG+kvyYw2ygbxysXdEcl7X8U3sfxUTN9//Bv1HEOEAV4Jvv0Efhh7We3xh4pjXnVi5hB//JQh+ZnR1gKaOyDcwiDaA3e48f8LT4GjwEVXfLva+QCqER5TOfxRoFZLG6nktTeXqD5jx0l2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E4E31007;
	Thu,  6 Mar 2025 03:32:50 -0800 (PST)
Received: from [10.57.40.132] (unknown [10.57.40.132])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE5243F66E;
	Thu,  6 Mar 2025 03:32:35 -0800 (PST)
Message-ID: <6eb93af8-e239-44d7-a132-2932f260e792@arm.com>
Date: Thu, 6 Mar 2025 11:32:33 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] uclamp sum aggregation
To: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Morten Rasmussen <morten.rasmussen@arm.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 Christian Loehle <christian.loehle@arm.com>,
 Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org,
 Xuewen Yan <xuewen.yan@unisoc.com>
References: <cover.1741091349.git.hongyan.xia2@arm.com>
 <CAB8ipk_AvaOWp9QhmnFDdbFSWcKLhCH151=no6kRO2z+pSJfyQ@mail.gmail.com>
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <CAB8ipk_AvaOWp9QhmnFDdbFSWcKLhCH151=no6kRO2z+pSJfyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Xuewen,

On 06/03/2025 11:12, Xuewen Yan wrote:
> Hi Hongyan,
> 
> On Tue, Mar 4, 2025 at 10:26 PM Hongyan Xia <hongyan.xia2@arm.com> wrote:
>>
>> This series gives an alternative implementation that addresses some of
>> the problems in uclamp max aggregation. Sum aggregation mostly gives:
>>
>> 1. Simplicity. Sum aggregation implements uclamp with less than half of
>>     code than max aggregation.
>> 2. Effectiveness. Sum aggregation shows better uclamp effectiveness,
>>     either in benchmark scores or sometimes in energy efficiency.
>>
>> The key idea of sum aggregation is fairly simple. Each task has a
>> util_avg_bias, which is obtained by:
>>
>>      util_avg_bias = clamp(util_avg, uclamp_min, uclamp_max) - util_avg;
>>
>> If a CPU has N tasks, p1, p2, p3... pN, then we sum the biases up and
>> obtain a rq total bias:
>>
>>      rq_bias = util_avg_bias1 + util_avg_bias2... + util_avg_biasN;
>>
>> Then we use the biased rq utilization rq_util + rq_bias to select OPP
>> and to schedule tasks.
>>
>> PATCH BREAKDOWN:
>>
>> Patch 1/6 reverts a patch that accommodate uclamp_max tasks under max
>> aggregation. This patch is not needed and creates other problems for sum
>> aggregation. It is discussed elsewhere that this patch will be improved
>> and there may not be the need to revert it in the future.
>>
>> Patch 2, 3 and 4 implement sum aggregation.
>>
>> Patch 5 and 6 remove max aggregation.
>>
>> Patch 7 applies PELT decay on negative util_avg_bias. This improves
>> energy efficiency and task placement, but is not strictly necessary.
>>
>> Patch 8 addresses sum aggregation under-utilization problem.
>>
>> TESTING:
>>
>> Two notebooks are shared at
>>
>> https://nbviewer.org/github/honxia02/notebooks/blob/aac12d9becae2b2fe4690cbb672439fd884ede30/whitebox/max.ipynb
>> https://nbviewer.org/github/honxia02/notebooks/blob/aac12d9becae2b2fe4690cbb672439fd884ede30/whitebox/sum-offset.ipynb
>>
>> The experiments done in notebooks are on Arm Juno r2 board. CPU0-3 are
>> little cores with capacity of 383. CPU4-5 are big cores. The rt-app
>> profiles used for these experiments are included in the notebooks.
>>
>> Scenario 1: Scheduling 4 tasks with UCLAMP_MAX at 110.
>>
>> The scheduling decisions are plotted in Out[11]. Both max and sum
>> aggregation understand the UCLAMP_MAX hint and schedule all 4 tasks on
>> the little cluster. Max aggregation sometimes schedule 2 tasks on 1 CPU,
>> and this is the reason why sum aggregation reverts the 1st commit.
>>
>> Scenario 2: Scheduling 4 tasks with UCLAMP_MIN and UCLAMP_MAX at a value
>> slightly above the capacity of the little CPU.
>>
>> Results are in Out[17]. The purpose is to use UCLAMP_MIN to place tasks
>> on the big core. Both max and sum aggregation handle this correctly.
>>
>> Scenario 3: Task A is a task with a small utilization pinned to CPU4.
>> Task B is an always-running task pinned to CPU5, but UCLAMP_MAX capped
>> at 300. After a while, task A is then pinned to CPU5, joining B.
>>
>> Results are in Out[23]. Max aggregation sees a frequency spike at
>> 873.64s. When zoomed in, one can see square-wave-like utilization values
>> because of A periodically going to sleep. When A wakes up, its default
>> UCLAMP_MAX of 1024 will uncap B and reach the highest CPU frequency.
>> When A sleeps, B's UCLAMP_MAX will be in effect and will reduce rq
>> utilization. This happens repeatedly, hence the square wave. In
>> contrast, sum aggregation sees a normal increase in utilization when A
>> joins B, without any square-wave behavior.
>>
>> Scenario 4: 4 always-running tasks with UCLAMP_MAX of 110 pinned to the
>> little PD (CPU0-3). 4 same tasks pinned to the big PD (CPU4-5).
>> After a while, remove the CPU pinning of the 4 tasks on the big PD.
>>
>> Results are in Out[29]. After unpinning, max aggregation moves all 8
>> tasks to the little cluster, but schedules 5 tasks on CPU0 and 1 each on
>> CPU1-3. In contrast, sum aggregation schedules 2 on each little CPU
>> after unpinning, which is the desired balanced task placement.
>>
>> EVALUATION:
>>
>> We backport patches to GKI kernel v6.1 on Pixel 9 and run Android
>> benchmarks.
>>
>> Speedometer:
>>
>> We run Speedometer 2.1 on Chrome v131 to test ADPF/uclamp effectiveness.
>> Because sum aggregation does not circumvent the 25% OPP margin, we
>> reduce uclamp values to 80% to be fair.
>>
>> |   score   | score |   %    | CPU power % |
>> |    max    | 192.4 |        |             |
>> |  sum_0.8  | 230.8 | +19.96 |   +31.54    |
>> | sum_tuned | 201.8 |  +4.89 |    -0.41    |
>>
>> We see a consistant higher score and higher average power consumption.
>> Note that a higher score also means a reduction in run-time, total
>> energy increase for sum_0.8 is only 9.65%.
>>
>> We then reduce uclamp values so that power consumption is roughly
>> the same. If we do so, then sum aggregation achieves slightly better
>> scores, shown in the sum_tuned row.
>>
>> UIBench:
>>
>> |   score   | jank percentage |   %    | CPU power (mW) |   %   |
>> |    max    |     0.115%      |        |     158.1      |       |
>> |  sum_0.8  |     0.129%      | +11.96 |     154.9      | -4.19 |
>>
>> UIBench on Pixel 9 by default already has a low enough jank percentage.
>> Moving to sum aggregation gives slightly higher jank percentage and
>> lower power consumption.
>>
>> ---
>> Changed in v2:
>> - Completely separate uclamp component from PELT and util_est.
>> - Separate util_est_uclamp into an individual patch.
>> - Address the under-utilization problem.
>> - Update Python notebooks to reflect the latest sched/tip.
>>
>> Hongyan Xia (8):
>>    Revert "sched/uclamp: Set max_spare_cap_cpu even if max_spare_cap is
>>      0"
>>    sched/uclamp: Track a new util_avg_bias signal
>>    sched/uclamp: Add util_est_uclamp
>>    sched/fair: Use util biases for utilization and frequency
>>    sched/uclamp: Remove all uclamp bucket logic
> 
> I’ve recently been looking into the issue with uclamp and
> delayed-dequeue, and I found that uclamp_rq_inc should be placed
> before enqueue_task, which led to a patch.
> Before sending the patch, I came across your series of patches. I
> haven’t fully understood your patch yet, but it seems like
> uclamp_rq_inc is no longer needed.
> Do you think the patch below is still necessary?
> 

I posted a fix of the issue you mentioned days ago here

https://lore.kernel.org/lkml/84441660bef0a5e67fd09dc3787178d0276dad31.1740664400.git.hongyan.xia2@arm.com/

I think we found the same issue, but our approaches are different. I 
fear that as more complexity goes into each sched_class like delayed 
dequeue, it's better to just let the sched_class handle how uclamp is 
enqueued and dequeued within itself rather than leaking into core.c. 
Would be nice if you could take a look at my fix.

Your patch is definitely necessary. The thing with this uclamp sum 
aggregation series is that there are still debates around it and it 
might take a while before everything is settled. So, at the moment we 
should view this series and the uclamp enqueue fix as separate things.

> --->
> 
> Subject: [PATCH] sched/uclamp: Update the rq's uclamp before enqueue task
> 
> When task's uclamp is set, we hope that the CPU frequency
> can increase as quickly as possible when the task is enqueued.
> Because the cpu frequency updating happens during the enqueue_task(),
> so the rq's uclamp needs to be updated before the task is enqueued.
> For sched-delayed tasks, the rq uclamp should only be updated
> when they are enqueued upon being awakened.
> 
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>   kernel/sched/core.c | 14 ++++++--------
>   1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 67189907214d..b07e78910221 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1747,7 +1747,7 @@ static inline void uclamp_rq_dec_id(struct rq
> *rq, struct task_struct *p,
>          }
>   }
> 
> -static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
> +static inline void uclamp_rq_inc(struct rq *rq, struct task_struct
> *p, int flags)
>   {
>          enum uclamp_id clamp_id;
> 
> @@ -1763,7 +1763,8 @@ static inline void uclamp_rq_inc(struct rq *rq,
> struct task_struct *p)
>          if (unlikely(!p->sched_class->uclamp_enabled))
>                  return;
> 
> -       if (p->se.sched_delayed)
> +       /* Only inc the delayed task which is being woken up. */
> +       if (p->se.sched_delayed && !(flags & ENQUEUE_DELAYED))
>                  return;
> 
>          for_each_clamp_id(clamp_id)
> @@ -2031,7 +2032,7 @@ static void __init init_uclamp(void)
>   }
> 
>   #else /* !CONFIG_UCLAMP_TASK */
> -static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p) { }
> +static inline void uclamp_rq_inc(struct rq *rq, struct task_struct
> *p, int flags) { }
>   static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p) { }
>   static inline void uclamp_fork(struct task_struct *p) { }
>   static inline void uclamp_post_fork(struct task_struct *p) { }
> @@ -2067,12 +2068,9 @@ void enqueue_task(struct rq *rq, struct
> task_struct *p, int flags)
>          if (!(flags & ENQUEUE_NOCLOCK))
>                  update_rq_clock(rq);
> 
> +       uclamp_rq_inc(rq, p, flags);
> +
>          p->sched_class->enqueue_task(rq, p, flags);
> -       /*
> -        * Must be after ->enqueue_task() because ENQUEUE_DELAYED can clear
> -        * ->sched_delayed.
> -        */
> -       uclamp_rq_inc(rq, p);
> 
>          psi_enqueue(p, flags);
> 
> --
> 
> Thanks!
> 
> BR
> ---
> 
>>    sched/uclamp: Simplify uclamp_eff_value()
>>    sched/uclamp: Propagate negative bias
>>    sched/uclamp: Solve under-utilization problem
>>
>>   include/linux/sched.h            |   8 +-
>>   init/Kconfig                     |  32 ---
>>   kernel/sched/core.c              | 308 ++--------------------
>>   kernel/sched/cpufreq_schedutil.c |   6 +-
>>   kernel/sched/debug.c             |   2 +-
>>   kernel/sched/fair.c              | 430 ++++++++++++++++---------------
>>   kernel/sched/pelt.c              |  62 +++++
>>   kernel/sched/rt.c                |   4 -
>>   kernel/sched/sched.h             | 132 +++-------
>>   kernel/sched/syscalls.c          |   2 +
>>   10 files changed, 341 insertions(+), 645 deletions(-)
>>
>> --
>> 2.34.1
>>
>>


