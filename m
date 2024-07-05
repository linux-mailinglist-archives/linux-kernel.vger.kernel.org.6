Return-Path: <linux-kernel+bounces-241965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CE89281FC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 08:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F102F1F247F0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jul 2024 06:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEAA13C8FB;
	Fri,  5 Jul 2024 06:26:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BB91369AE
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jul 2024 06:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720160766; cv=none; b=PQ+lcuncLcvtvqKUJcBL06qQDECOST2iG+i6bpeemUXArpZ33Ci+/GHfvFxHaeRba88fDsvg2ypjT+iUROZ4vohYKETdyH59nf7W7widBUxVK82eUUMsKrxPhSE/L8hUSB/WibMuLQMqsIqPpbtcKBwoIUO0+wySQmP6TrJI5rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720160766; c=relaxed/simple;
	bh=rwTpQEZIDPDIz2vaYtx5AxMI0dNatWjs5WMqm8E08jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JjjhulUP8q9kSw5Pv2slLsNuKJ8YqNDSsTB1CTTwJd9D+YFOHhdAvaqb+qNtd3sXZVGOi1q2AlotovWZhW1RexTYvUfQ3CvDM+jpMRbI8pqjkuhreUdSiBq8ss05+9c7x+fFS2kgsOn9n5OfS/z9mG7UDFbpnPNDeuYB2XrIZoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 74D28367;
	Thu,  4 Jul 2024 23:26:28 -0700 (PDT)
Received: from [192.168.178.110] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 126263F766;
	Thu,  4 Jul 2024 23:26:00 -0700 (PDT)
Message-ID: <66f2ef35-cbc0-4205-96f1-c857efb6f9cd@arm.com>
Date: Fri, 5 Jul 2024 08:25:59 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] sched/fair: Use actual_cpu_capacity everywhere in
 util_fits_cpu()
To: Qais Yousef <qyousef@layalina.io>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, mingo@redhat.com,
 peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
 bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
 vschneid@redhat.com, christian.loehle@arm.com, vincent.donnefort@arm.com,
 ke.wang@unisoc.com, di.shen@unisoc.com, xuewen.yan94@gmail.com,
 linux-kernel@vger.kernel.org
References: <20240624082011.4990-1-xuewen.yan@unisoc.com>
 <20240624082011.4990-3-xuewen.yan@unisoc.com>
 <20240628012832.37swdtxr4ds2kkp7@airbuntu>
 <CAKfTPtALDtnbPmq4401oLKzcEDurLKuCyqyNKOb1oYLAVJ2P4A@mail.gmail.com>
 <20240703115407.y6tjelkpq5njkzjy@airbuntu>
 <CAKfTPtCNEa+pAbo1br_1SDSn8=x67YMCi_jytpjUMHv7a9xMKA@mail.gmail.com>
 <20240704235652.n2wtpwck43umh4dq@airbuntu>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <20240704235652.n2wtpwck43umh4dq@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/07/2024 01:56, Qais Yousef wrote:
> On 07/03/24 16:54, Vincent Guittot wrote:
>> On Wed, 3 Jul 2024 at 13:54, Qais Yousef <qyousef@layalina.io> wrote:
>>>
>>> On 07/02/24 15:25, Vincent Guittot wrote:
>>>
>>>>>>        *
>>>>>>        * Only exception is for HW or cpufreq pressure since it has a direct impact
>>>>>>        * on available OPP of the system.
>>>>>> @@ -5011,7 +5011,7 @@ static inline int util_fits_cpu(unsigned long util,
>>>>>>        * For uclamp_max, we can tolerate a drop in performance level as the
>>>>>>        * goal is to cap the task. So it's okay if it's getting less.
>>>>>>        */
>>>>>> -     capacity_orig = arch_scale_cpu_capacity(cpu);
>>>>>> +     capacity_actual = get_actual_cpu_capacity(cpu);
>>>>>>
>>>>>>       /*
>>>>>>        * We want to force a task to fit a cpu as implied by uclamp_max.
>>>>>> @@ -5039,7 +5039,7 @@ static inline int util_fits_cpu(unsigned long util,
>>>>>>        *     uclamp_max request.
>>>>>>        *
>>>>>>        *   which is what we're enforcing here. A task always fits if
>>>>>> -      *   uclamp_max <= capacity_orig. But when uclamp_max > capacity_orig,
>>>>>> +      *   uclamp_max <= capacity_actual. But when uclamp_max > capacity_actual,
>>>>>>        *   the normal upmigration rules should withhold still.
>>>>>>        *
>>>>>>        *   Only exception is when we are on max capacity, then we need to be
>>>>>> @@ -5050,8 +5050,8 @@ static inline int util_fits_cpu(unsigned long util,
>>>>>>        *     2. The system is being saturated when we're operating near
>>>>>>        *        max capacity, it doesn't make sense to block overutilized.
>>>>>>        */
>>>>>> -     uclamp_max_fits = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
>>>>>> -     uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_orig);
>>>>>> +     uclamp_max_fits = (capacity_actual == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
>>>>>
>>>>> We should use capacity_orig here. We are checking if the CPU is the max
>>>>> capacity CPU.
>>>>
>>>> I was also wondering what would be the best choice there. If we
>>>> consider that we have only one performance domain with all max
>>>> capacity cpus then I agree that we should keep capacity_orig as we
>>>> can't find a better cpu that would fit. But is it always true that all
>>>> max cpu are tied to the same perf domain ?

This should be the case. Perf domains follow Frequency Domains (FD). So
even if we have the most powerful CPUs in 2 different FDs, only the CPUs
in the FD with the higher max OPP get SCHED_CAPACITY_SCALE assigned,
i.e. only they become big CPUs.

>>> Hmm I could be not thinking straight today. But the purpose of this check is to
>>> ensure overutilized can trigger for the common case where a task will always
>>> fit the max capacity cpu (whether it's on a single pd or multiple ones). For
>>> that corner case fits_capacity() should be the only fitness check otherwise
>>> overutilized will never trigger by default.
>>
>> Ok, so I messed up several use cases but in fact both are similar ...
>>
>> if capacity_actual != SCHED_CAPACITY_SCALE and uclamp_max ==
>> SCHED_CAPACITY_SCALE
>> then uclamp_max_fits = (capacity_actual == SCHED_CAPACITY_SCALE) &&
>> (uclamp_max == SCHED_CAPACITY_SCALE) is false
>> and uclamp_max_fits = !uclamp_max_fits && (uclamp_max <=
>> capacity_actual); is also false because (uclamp_max <=
>> capacity_actual) is always false
>>
>> if capacity_actual == SCHED_CAPACITY_SCALE and uclamp_max ==
>> SCHED_CAPACITY_SCALE
>> then we are the same as with capacity_orig
> 
> Right. The condition is becoming less readable, but you're right it doesn't
> change functionality.

+1. 'capacity_actual < SCHED_CAPACITY_SCALE' on big CPUs just make them
non-big CPUs.

> Xuewen, could you put something in the commit message please to remind us in
> the future that we thought about this and it is fine?
> 
> Thanks!
> 
> --
> Qais Yousef


