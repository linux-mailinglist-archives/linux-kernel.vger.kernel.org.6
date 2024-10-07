Return-Path: <linux-kernel+bounces-352862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 831F4992553
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:03:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70A51C221A8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B096115D5CF;
	Mon,  7 Oct 2024 07:03:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560BD6FC5
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 07:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728284622; cv=none; b=SNKO0KTrSbO+TRfpmCZpaNou4K59H13HjsQkzJHq1IhRMCCsOUCOZN2ZwbTj6V1yEtkaVkjStSQP2OMEo8OYRB5hM3fZ+C2iZ/Ze118ysokvVtj4MKFagB9P0rFFnwpzbpt+BB0JBbTPNtdUJfMCWXdMgK08eul8QSePzSOW6zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728284622; c=relaxed/simple;
	bh=615T1jRni2Wx7mMGj7eE7SfbON+2agn8YClOdwHnYVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hGgAqrcRXBXLvYfHiCqGREjEUwZ6ZzWUaJdbNhdFxtc7wf1vZCZLZKadeKX+JrJRfrq/G0HFNupcT224yiHMHJSLA2kOXSTRLVFyl816JEl/3ipsogGKiuX19IqkFV18/OwqMd6u0SCAFO7GYvpPayxa9lrRNNhTXucfh4acxsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C620AFEC;
	Mon,  7 Oct 2024 00:04:07 -0700 (PDT)
Received: from [192.168.1.12] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13E713F640;
	Mon,  7 Oct 2024 00:03:34 -0700 (PDT)
Message-ID: <ae1d8de4-dbd2-44fd-b4a4-ce1c63286c1d@arm.com>
Date: Mon, 7 Oct 2024 09:03:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] sched/fair: Use EAS also when overutilized
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Christian Loehle <christian.loehle@arm.com>, qyousef@layalina.io,
 hongyan.xia2@arm.com, mingo@redhat.com, peterz@infradead.org,
 linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
 lukasz.luba@arm.com, vschneid@redhat.com, mgorman@suse.de,
 bsegall@google.com, rostedt@goodmis.org, dietmar.eggemann@arm.com,
 juri.lelli@redhat.com
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-5-vincent.guittot@linaro.org>
 <64ed0fb8-12ea-4452-9ec2-7ad127b65529@arm.com>
 <66583e86-e2a7-4e4f-bd45-40ea2d4a21df@arm.com>
 <CAKfTPtAooR2Qqko6Cfe=hQiTqJEzHX0j5uydza-SxdGDTsoGYA@mail.gmail.com>
Content-Language: en-US
From: Pierre Gondois <pierre.gondois@arm.com>
In-Reply-To: <CAKfTPtAooR2Qqko6Cfe=hQiTqJEzHX0j5uydza-SxdGDTsoGYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Vincent,

Sorry for the delay:

On 9/25/24 15:28, Vincent Guittot wrote:
> On Thu, 19 Sept 2024 at 10:26, Pierre Gondois <pierre.gondois@arm.com> wrote:
>>
>> Hello Vincent,
>> I tried this patch on a Pixel 6 (8 CPUs, 4 little, 2 mid, 2 big)
>> with patches 1-4/5 using these workloads:
>> ---
>> A.
>> a. 8 tasks at 2%/5%/10% during 1s
>> b. 1 task:
>>      - sleeping during 0.3s
>>      - at 100% during 0.3s
>>      - sleeping during 0.3s
>>
>> b. is used to reach the overutilized state during a limited amount of time.
>> EAS is then operating, then the load balancer does the task placement, then EAS
>> is operating again.
>>
>> B.
>> a. 8 tasks at 2%/5%/10% during 1s
>> b. 1 task:
>>      - at 100% during 1s
>>
>> ---
>> I'm seeing the energy consumption increase in some cases. This seems to be
>> due to feec() migrating tasks more often than what the load balancer does
>> for this workload. This leads to utilization 'spikes' and then frequency
>> 'spikes', increasing the overall energy consumption.
>> This is not entirely related to this patch though,, as the task placement seems
>> correct. I.e. feec() effectively does an optimal placement given the EM and
>> task utilization. The task placement is just a bit less stable than with
>> the load balancer.
> 
> Would patch 5 help to keep things better placed ? in particular if
> task b is misplaced at some point because of load balance ?

I assume so, it would require more testing on my side

> 
> I agree that load balance might still contribute to migrate task in a
> not energy efficient way
> 
>>
>> ---
>> Regarding hackbench, I've reproduced the test you've run on the same Pixel6.
>> I have CONFIG_SCHED_CLUSTER enabled, which allows having a sched domain for
>> each little/mid/big CPUs (without the config, these group would no exist).
> 
> Why did you do this ? All cpus are expected to be in same sched domain
> as they share their LLC

I did this to observe the loa balancer a bit more carefully while reviewing
the first patch:
   sched/fair: Filter false overloaded_group case for EAS
I've let this configuration, but effectively this should not bring anything more.


> 
>>
>> I see an important regression in the result.
>> I replaced the condition to run feec() through select_task_rq_fair() by:
>>     if (get_rd_overloaded(cpu_rq(cpu)->rd) == 0)) {
> 
> overloaded is enable when more than 1 task runs on a cpu whatever the
> utilization

Yes right, this idea has little sense.

> 
>>       new_cpu = find_energy_efficient_cpu(p, prev_cpu);
>>       ...
>>     }
>> and obtained better results.
>>
>> Indeed, for such intensive workload:
>> - EAS would not have any energy benefit, so better prioritize performance
>>     (as Christian mentioned)
>> - EAS would not be able to find a fitting CPU, so running feec() should be
>>     avoided
>> - as you mention in the commit message, shuffling tasks when one CPU becomes
>>     momentarily overutilized is inefficient energy-wise (even though I don't have
>>     the numbers, it should make sense).
>> So detecting when the system is overloaded should be a better compromise I
>> assume. The condition in sched_balance_find_src_group() to let the load balancer
>> operate might also need to be updated.
>>
>> Note:
>> - base: with patches 1-4/5
>> - _ou: run feec() when not overutilized
>> - _ol: run feec() when not overloaded
>> - mean: hackbench execution time in s.
>> - delta: negative is better. Value is in percentage.
> 
> Could you share your command line ? As explained in the cover letter I
> have seen some perf regressions but not in the range that you have
> below
> 
> What is your base ? tip/sched/core ?

I am working on a Pixel6, with a branch based on v6.8 with some scheduler patches
to be able to apply your patches cleanly.

The mapping id -> command line is as:
(1) hackbench -l 5120 -g 1
(2) hackbench -l 1280 -g 4
(3) hackbench -l 640  -g 8
(4) hackbench -l 320  -g 16

(5) hackbench -p -l 5120 -g 1
(6) hackbench -p -l 1280 -g 4
(7) hackbench -p -l 640  -g 8
(8) hackbench -p -l 320  -g 16

(9) hackbench -T -l 5120 -g 1
(10) hackbench -T -l 1280 -g 4
(11) hackbench -T -l 640  -g 8
(12) hackbench -T -l 320  -g 16

(13) hackbench -T -p -l 5120 -g 1
(14) hackbench -T -p -l 1280 -g 4
(15) hackbench -T -p -l 640  -g 8
(16) hackbench -T -p -l 320  -g 16


> 
>> ┌─────┬───────────┬──────────┬─────────┬──────────┬─────────┬──────────┬──────────┬──────────┐
>> │ id  ┆ mean_base ┆ std_base ┆ mean_ou ┆ std_ou   ┆ mean_ol ┆ std_ol   ┆ delta_ou ┆ delta_ol │
>> ╞═════╪═══════════╪══════════╪═════════╪══════════╪═════════╪══════════╪══════════╪══════════╡
>> │ 1   ┆ 1.9786    ┆ 0.04719  ┆ 3.0856  ┆ 0.122209 ┆ 2.1734  ┆ 0.045203 ┆ 55.95    ┆ 9.85     │
>> │ 2   ┆ 1.8991    ┆ 0.019768 ┆ 2.6672  ┆ 0.135266 ┆ 1.98875 ┆ 0.055132 ┆ 40.45    ┆ 4.72     │
>> │ 3   ┆ 1.9053    ┆ 0.014795 ┆ 2.5761  ┆ 0.141693 ┆ 2.06425 ┆ 0.045901 ┆ 35.21    ┆ 8.34     │
>> │ 4   ┆ 1.9586    ┆ 0.023439 ┆ 2.5823  ┆ 0.110399 ┆ 2.0955  ┆ 0.053818 ┆ 31.84    ┆ 6.99     │
>> │ 5   ┆ 1.746     ┆ 0.055676 ┆ 3.3437  ┆ 0.279107 ┆ 1.88    ┆ 0.038184 ┆ 91.51    ┆ 7.67     │
>> │ 6   ┆ 1.5476    ┆ 0.050131 ┆ 2.6835  ┆ 0.140497 ┆ 1.5645  ┆ 0.081644 ┆ 73.4     ┆ 1.09     │
>> │ 7   ┆ 1.4562    ┆ 0.062457 ┆ 2.3568  ┆ 0.119213 ┆ 1.48425 ┆ 0.06212  ┆ 61.85    ┆ 1.93     │
>> │ 8   ┆ 1.3554    ┆ 0.031757 ┆ 2.0609  ┆ 0.112869 ┆ 1.4085  ┆ 0.036601 ┆ 52.05    ┆ 3.92     │
>> │ 9   ┆ 2.0391    ┆ 0.035732 ┆ 3.4045  ┆ 0.277307 ┆ 2.2155  ┆ 0.019053 ┆ 66.96    ┆ 8.65     │
>> │ 10  ┆ 1.9247    ┆ 0.056472 ┆ 2.6605  ┆ 0.119417 ┆ 2.02775 ┆ 0.05795  ┆ 38.23    ┆ 5.35     │
>> │ 11  ┆ 1.8923    ┆ 0.038222 ┆ 2.8113  ┆ 0.120623 ┆ 2.089   ┆ 0.025259 ┆ 48.57    ┆ 10.39    │
>> │ 12  ┆ 1.9444    ┆ 0.034856 ┆ 2.6675  ┆ 0.219585 ┆ 2.1035  ┆ 0.076514 ┆ 37.19    ┆ 8.18     │
>> │ 13  ┆ 1.7107    ┆ 0.04874  ┆ 3.4443  ┆ 0.154481 ┆ 1.8275  ┆ 0.036665 ┆ 101.34   ┆ 6.83     │
>> │ 14  ┆ 1.5565    ┆ 0.056595 ┆ 2.8241  ┆ 0.158643 ┆ 1.5515  ┆ 0.040813 ┆ 81.44    ┆ -0.32    │
>> │ 15  ┆ 1.4932    ┆ 0.085256 ┆ 2.6841  ┆ 0.135623 ┆ 1.50475 ┆ 0.028336 ┆ 79.75    ┆ 0.77     │
>> │ 16  ┆ 1.4263    ┆ 0.067666 ┆ 2.3971  ┆ 0.145928 ┆ 1.414   ┆ 0.061422 ┆ 68.06    ┆ -0.86    │
>> └─────┴───────────┴──────────┴─────────┴──────────┴─────────┴──────────┴──────────┴──────────┘
>>
>> On 9/17/24 22:24, Christian Loehle wrote:
>>> On 8/30/24 14:03, Vincent Guittot wrote:
>>>> Keep looking for an energy efficient CPU even when the system is
>>>> overutilized and use the CPU returned by feec() if it has been able to find
>>>> one. Otherwise fallback to the default performance and spread mode of the
>>>> scheduler.
>>>> A system can become overutilized for a short time when workers of a
>>>> workqueue wake up for a short background work like vmstat update.
>>>> Continuing to look for a energy efficient CPU will prevent to break the
>>>> power packing of tasks.
>>>>
>>>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>>>> ---
>>>>    kernel/sched/fair.c | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>>> index 2273eecf6086..e46af2416159 100644
>>>> --- a/kernel/sched/fair.c
>>>> +++ b/kernel/sched/fair.c
>>>> @@ -8505,7 +8505,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>>>>                   cpumask_test_cpu(cpu, p->cpus_ptr))
>>>>                       return cpu;
>>>>
>>>> -            if (!is_rd_overutilized(this_rq()->rd)) {
>>>> +            if (sched_energy_enabled()) {
>>>>                       new_cpu = find_energy_efficient_cpu(p, prev_cpu);
>>>>                       if (new_cpu >= 0)
>>>>                               return new_cpu;
>>>
>>> Super quick testing on pixel6:
>>> for i in $(seq 0 6); do /data/local/tmp/hackbench -l 500 -g 100 | grep Time; sleep 60; done
>>> with patch 5/5 only:
>>> Time: 19.433
>>> Time: 19.657
>>> Time: 19.851
>>> Time: 19.789
>>> Time: 19.857
>>> Time: 20.092
>>> Time: 19.973
>>>
>>> mainline:
>>> Time: 18.836
>>> Time: 18.718
>>> Time: 18.781
>>> Time: 19.015
>>> Time: 19.061
>>> Time: 18.950
>>> Time: 19.166
>>>
>>>
>>> The reason we didn't always have this enabled is the belief that
>>> this costs us too much performance in scenarios we most need it
>>> while at best making subpar EAS decisions anyway (in an
>>> overutilized state).
>>> I'd be open for questioning that, but why the change of mind?
>>> And why is this necessary in your series if the EAS selection
>>> isn't 'final' (until the next sleep) anymore (Patch 5/5)?
>>>

