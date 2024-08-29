Return-Path: <linux-kernel+bounces-307225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47984964A58
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 17:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2D61F24149
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 15:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF421B3B06;
	Thu, 29 Aug 2024 15:42:28 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479521B3742
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 15:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946148; cv=none; b=TtHk5ZjFim638ElKX0m5iL4tYA3QA28Y7wsxZqV4wN9F1KY7rT3UtvpH9S+k/bMGr2d2ifj5WPuB8cketgi830hVPFA8hXJvLTm9Sl6ObPhBX//ARDnG26iX58DXGHJaudMOE4CleBz+bo0aFIyW5ysr5K2J71iuoHwrAM8En/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946148; c=relaxed/simple;
	bh=OTftFpLM0w4T+yKRAgb6kkR5aVQhhfhKpAGpnkyfpIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hdB4TWlAfHm1IAIoTbytGILWj3XXd+txvkgQy3D8oOd3J0Ly7C2pvyVJfo9w6fx8Ht4Mu8yIiFeKRgBVeRDHfPhEaftkoswP9BTvceizbVla81OIs0v5FK44aHcfmDFKP/zdEoo3L2yTOFdBx1rhX+Gl9G+I6lMri5i+GgB8TkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A849CDA7;
	Thu, 29 Aug 2024 08:42:51 -0700 (PDT)
Received: from [10.57.49.123] (unknown [10.57.49.123])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AF4D3F66E;
	Thu, 29 Aug 2024 08:42:23 -0700 (PDT)
Message-ID: <aa81d37e-ad9c-42c6-a104-fe8496c5d907@arm.com>
Date: Thu, 29 Aug 2024 16:42:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/24] sched/uclamg: Handle delayed dequeue
To: Vincent Guittot <vincent.guittot@linaro.org>,
 Luis Machado <luis.machado@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
 juri.lelli@redhat.com, dietmar.eggemann@arm.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
 linux-kernel@vger.kernel.org, kprateek.nayak@amd.com,
 wuyun.abel@bytedance.com, youssefesmat@chromium.org, tglx@linutronix.de,
 efault@gmx.de
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
Content-Language: en-US
From: Hongyan Xia <hongyan.xia2@arm.com>
In-Reply-To: <CAKfTPtDO3n-4mcr2Sk-uu0ZS5xQnagdicQmaBh-CyrndPLM8eQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/08/2024 15:58, Vincent Guittot wrote:
> On Thu, 22 Aug 2024 at 14:10, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
>>
>> On Thu, 22 Aug 2024 at 14:08, Luis Machado <luis.machado@arm.com> wrote:
>>>
>>> Vincent,
>>>
>>> On 8/22/24 11:28, Luis Machado wrote:
>>>> On 8/22/24 10:53, Vincent Guittot wrote:
>>>>> On Thu, 22 Aug 2024 at 11:22, Luis Machado <luis.machado@arm.com> wrote:
>>>>>>
>>>>>> On 8/22/24 09:19, Vincent Guittot wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On Wed, 21 Aug 2024 at 15:34, Hongyan Xia <hongyan.xia2@arm.com> wrote:
>>>>>>>>
>>>>>>>> Hi Peter,
>>>>>>>>
>>>>>>>> Sorry for bombarding this thread in the last couple of days. I'm seeing
>>>>>>>> several issues in the latest tip/sched/core after these patches landed.
>>>>>>>>
>>>>>>>> What I'm now seeing seems to be an unbalanced call of util_est. First, I applied
>>>>>>>
>>>>>>> I also see a remaining util_est for idle rq because of an unbalance
>>>>>>> call of util_est_enqueue|dequeue
>>>>>>>
>>>>>>
>>>>>> I can confirm issues with the utilization values and frequencies being driven
>>>>>> seemingly incorrectly, in particular for little cores.
>>>>>>
>>>>>> What I'm seeing with the stock series is high utilization values for some tasks
>>>>>> and little cores having their frequencies maxed out for extended periods of
>>>>>> time. Sometimes for 5+ or 10+ seconds, which is excessive as the cores are mostly
>>>>>> idle. But whenever certain tasks get scheduled there, they have a very high util
>>>>>> level and so the frequency is kept at max.
>>>>>>
>>>>>> As a consequence this drives up power usage.
>>>>>>
>>>>>> I gave Hongyan's draft fix a try and observed a much more reasonable behavior for
>>>>>> the util numbers and frequencies being used for the little cores. With his fix,
>>>>>> I can also see lower energy use for my specific benchmark.
>>>>>
>>>>> The main problem is that the util_est of a delayed dequeued task
>>>>> remains on the rq and keeps the rq utilization high and as a result
>>>>> the frequency higher than needed.
>>>>>
>>>>> The below seems to works for me and keep sync the enqueue/dequeue of
>>>>> uti_test with the enqueue/dequeue of the task as if de dequeue was not
>>>>> delayed
>>>>>
>>>>> Another interest is that we will not try to migrate a delayed dequeue
>>>>> sleeping task that doesn't actually impact the current load of the cpu
>>>>> and as a result will not help in the load balance. I haven't yet fully
>>>>> checked what would happen with hotplug
>>>>
>>>> Thanks. Those are good points. Let me go and try your patch.
>>>
>>> I gave your fix a try, but it seems to make things worse. It is comparable
>>> to the behavior we had before Peter added the uclamp imbalance fix, so I
>>> believe there is something incorrect there.
>>
>> we need to filter case where task are enqueued/dequeued several
>> consecutive times. That's what I'm look now
> 
> I just realize before that It's not only util_est but the h_nr_running
> that keeps delayed tasks as well so all stats of the rq are biased:
> h_nr_running, util_est, runnable avg and load_avg.

After staring at the code even more, I think the situation is worse.

First thing is that uclamp might also want to be part of these stats 
(h_nr_running, util_est, runnable_avg, load_avg) that do not follow 
delayed dequeue which needs to be specially handled in the same way. The 
current way of handling uclamp in core.c misses the frequency update, 
like I commented before.

Second, there is also an out-of-sync issue in update_load_avg(). We only 
update the task-level se in delayed dequeue and requeue, but we return 
early and the upper levels are completely skipped, as if the delayed 
task is still on rq. This de-sync is wrong.

