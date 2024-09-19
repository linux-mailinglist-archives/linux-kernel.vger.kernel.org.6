Return-Path: <linux-kernel+bounces-333239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D264197C5C8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 10:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 929C72846DB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7961E198A33;
	Thu, 19 Sep 2024 08:26:05 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3780198A2C
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 08:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726734365; cv=none; b=RyVYSnJdEOUp9GFpR1y80EIhc9IyxqFGXa7NZOcKdBcEtuAyHdIFo2jW9s3UhAijCg4OxCsuvCjue8d5SlgtXWw1urTCWUaE0qw7g1b3Gg25usYA6JYfqr5K4KBjsntl9KUPnsnfRobz+IYubaiTZD9c7s6mZHRrKPIeWkc1Mcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726734365; c=relaxed/simple;
	bh=/Igfij5U+sdAQOoUq67Bq2zykenTnXfjXmI6SmKjA2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZZOBIGR9Zhf/9jLU77L4I/l751HZH5wqjiPs8f3S9LlD9yf/aKQFzQUXmt507kcb9qLELzGJ1kR2cSxWO+mmxXrOACInDNukitXcjZZHF7Rl+Zj9VqBL5ZixMYzpHTJYgw11Y6cLXcxUEIxCcB0meIpyDh5STYUdbp54xcxORyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 388BD1007;
	Thu, 19 Sep 2024 01:26:30 -0700 (PDT)
Received: from [10.34.111.172] (e126645.nice.Arm.com [10.34.111.172])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE8973F71A;
	Thu, 19 Sep 2024 01:25:57 -0700 (PDT)
Message-ID: <66583e86-e2a7-4e4f-bd45-40ea2d4a21df@arm.com>
Date: Thu, 19 Sep 2024 10:25:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] sched/fair: Use EAS also when overutilized
To: Christian Loehle <christian.loehle@arm.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: qyousef@layalina.io, hongyan.xia2@arm.com, mingo@redhat.com,
 peterz@infradead.org, linux-kernel@vger.kernel.org,
 rafael.j.wysocki@intel.com, lukasz.luba@arm.com, vschneid@redhat.com,
 mgorman@suse.de, bsegall@google.com, rostedt@goodmis.org,
 dietmar.eggemann@arm.com, juri.lelli@redhat.com
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-5-vincent.guittot@linaro.org>
 <64ed0fb8-12ea-4452-9ec2-7ad127b65529@arm.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <64ed0fb8-12ea-4452-9ec2-7ad127b65529@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Vincent,
I tried this patch on a Pixel 6 (8 CPUs, 4 little, 2 mid, 2 big)
with patches 1-4/5 using these workloads:
---
A.
a. 8 tasks at 2%/5%/10% during 1s
b. 1 task:
    - sleeping during 0.3s
    - at 100% during 0.3s
    - sleeping during 0.3s

b. is used to reach the overutilized state during a limited amount of time.
EAS is then operating, then the load balancer does the task placement, then EAS
is operating again.

B.
a. 8 tasks at 2%/5%/10% during 1s
b. 1 task:
    - at 100% during 1s

---
I'm seeing the energy consumption increase in some cases. This seems to be
due to feec() migrating tasks more often than what the load balancer does
for this workload. This leads to utilization 'spikes' and then frequency
'spikes', increasing the overall energy consumption.
This is not entirely related to this patch though,, as the task placement seems
correct. I.e. feec() effectively does an optimal placement given the EM and
task utilization. The task placement is just a bit less stable than with
the load balancer.

---
Regarding hackbench, I've reproduced the test you've run on the same Pixel6.
I have CONFIG_SCHED_CLUSTER enabled, which allows having a sched domain for
each little/mid/big CPUs (without the config, these group would no exist).

I see an important regression in the result.
I replaced the condition to run feec() through select_task_rq_fair() by:
   if (get_rd_overloaded(cpu_rq(cpu)->rd) == 0)) {
     new_cpu = find_energy_efficient_cpu(p, prev_cpu);
     ...
   }
and obtained better results.

Indeed, for such intensive workload:
- EAS would not have any energy benefit, so better prioritize performance
   (as Christian mentioned)
- EAS would not be able to find a fitting CPU, so running feec() should be
   avoided
- as you mention in the commit message, shuffling tasks when one CPU becomes
   momentarily overutilized is inefficient energy-wise (even though I don't have
   the numbers, it should make sense).
So detecting when the system is overloaded should be a better compromise I
assume. The condition in sched_balance_find_src_group() to let the load balancer
operate might also need to be updated.

Note:
- base: with patches 1-4/5
- _ou: run feec() when not overutilized
- _ol: run feec() when not overloaded
- mean: hackbench execution time in s.
- delta: negative is better. Value is in percentage.
┌─────┬───────────┬──────────┬─────────┬──────────┬─────────┬──────────┬──────────┬──────────┐
│ id  ┆ mean_base ┆ std_base ┆ mean_ou ┆ std_ou   ┆ mean_ol ┆ std_ol   ┆ delta_ou ┆ delta_ol │
╞═════╪═══════════╪══════════╪═════════╪══════════╪═════════╪══════════╪══════════╪══════════╡
│ 1   ┆ 1.9786    ┆ 0.04719  ┆ 3.0856  ┆ 0.122209 ┆ 2.1734  ┆ 0.045203 ┆ 55.95    ┆ 9.85     │
│ 2   ┆ 1.8991    ┆ 0.019768 ┆ 2.6672  ┆ 0.135266 ┆ 1.98875 ┆ 0.055132 ┆ 40.45    ┆ 4.72     │
│ 3   ┆ 1.9053    ┆ 0.014795 ┆ 2.5761  ┆ 0.141693 ┆ 2.06425 ┆ 0.045901 ┆ 35.21    ┆ 8.34     │
│ 4   ┆ 1.9586    ┆ 0.023439 ┆ 2.5823  ┆ 0.110399 ┆ 2.0955  ┆ 0.053818 ┆ 31.84    ┆ 6.99     │
│ 5   ┆ 1.746     ┆ 0.055676 ┆ 3.3437  ┆ 0.279107 ┆ 1.88    ┆ 0.038184 ┆ 91.51    ┆ 7.67     │
│ 6   ┆ 1.5476    ┆ 0.050131 ┆ 2.6835  ┆ 0.140497 ┆ 1.5645  ┆ 0.081644 ┆ 73.4     ┆ 1.09     │
│ 7   ┆ 1.4562    ┆ 0.062457 ┆ 2.3568  ┆ 0.119213 ┆ 1.48425 ┆ 0.06212  ┆ 61.85    ┆ 1.93     │
│ 8   ┆ 1.3554    ┆ 0.031757 ┆ 2.0609  ┆ 0.112869 ┆ 1.4085  ┆ 0.036601 ┆ 52.05    ┆ 3.92     │
│ 9   ┆ 2.0391    ┆ 0.035732 ┆ 3.4045  ┆ 0.277307 ┆ 2.2155  ┆ 0.019053 ┆ 66.96    ┆ 8.65     │
│ 10  ┆ 1.9247    ┆ 0.056472 ┆ 2.6605  ┆ 0.119417 ┆ 2.02775 ┆ 0.05795  ┆ 38.23    ┆ 5.35     │
│ 11  ┆ 1.8923    ┆ 0.038222 ┆ 2.8113  ┆ 0.120623 ┆ 2.089   ┆ 0.025259 ┆ 48.57    ┆ 10.39    │
│ 12  ┆ 1.9444    ┆ 0.034856 ┆ 2.6675  ┆ 0.219585 ┆ 2.1035  ┆ 0.076514 ┆ 37.19    ┆ 8.18     │
│ 13  ┆ 1.7107    ┆ 0.04874  ┆ 3.4443  ┆ 0.154481 ┆ 1.8275  ┆ 0.036665 ┆ 101.34   ┆ 6.83     │
│ 14  ┆ 1.5565    ┆ 0.056595 ┆ 2.8241  ┆ 0.158643 ┆ 1.5515  ┆ 0.040813 ┆ 81.44    ┆ -0.32    │
│ 15  ┆ 1.4932    ┆ 0.085256 ┆ 2.6841  ┆ 0.135623 ┆ 1.50475 ┆ 0.028336 ┆ 79.75    ┆ 0.77     │
│ 16  ┆ 1.4263    ┆ 0.067666 ┆ 2.3971  ┆ 0.145928 ┆ 1.414   ┆ 0.061422 ┆ 68.06    ┆ -0.86    │
└─────┴───────────┴──────────┴─────────┴──────────┴─────────┴──────────┴──────────┴──────────┘

On 9/17/24 22:24, Christian Loehle wrote:
> On 8/30/24 14:03, Vincent Guittot wrote:
>> Keep looking for an energy efficient CPU even when the system is
>> overutilized and use the CPU returned by feec() if it has been able to find
>> one. Otherwise fallback to the default performance and spread mode of the
>> scheduler.
>> A system can become overutilized for a short time when workers of a
>> workqueue wake up for a short background work like vmstat update.
>> Continuing to look for a energy efficient CPU will prevent to break the
>> power packing of tasks.
>>
>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>> ---
>>   kernel/sched/fair.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 2273eecf6086..e46af2416159 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -8505,7 +8505,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>>   		    cpumask_test_cpu(cpu, p->cpus_ptr))
>>   			return cpu;
>>   
>> -		if (!is_rd_overutilized(this_rq()->rd)) {
>> +		if (sched_energy_enabled()) {
>>   			new_cpu = find_energy_efficient_cpu(p, prev_cpu);
>>   			if (new_cpu >= 0)
>>   				return new_cpu;
> 
> Super quick testing on pixel6:
> for i in $(seq 0 6); do /data/local/tmp/hackbench -l 500 -g 100 | grep Time; sleep 60; done
> with patch 5/5 only:
> Time: 19.433
> Time: 19.657
> Time: 19.851
> Time: 19.789
> Time: 19.857
> Time: 20.092
> Time: 19.973
> 
> mainline:
> Time: 18.836
> Time: 18.718
> Time: 18.781
> Time: 19.015
> Time: 19.061
> Time: 18.950
> Time: 19.166
> 
> 
> The reason we didn't always have this enabled is the belief that
> this costs us too much performance in scenarios we most need it
> while at best making subpar EAS decisions anyway (in an
> overutilized state).
> I'd be open for questioning that, but why the change of mind?
> And why is this necessary in your series if the EAS selection
> isn't 'final' (until the next sleep) anymore (Patch 5/5)?
> 

