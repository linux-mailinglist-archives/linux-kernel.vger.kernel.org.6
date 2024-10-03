Return-Path: <linux-kernel+bounces-348737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE1198EB3C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92EF1C228E0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E607413D509;
	Thu,  3 Oct 2024 08:14:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7601413C661
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 08:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727943277; cv=none; b=XzjhczB889tSernj8Au+QyA3c47Ue0tUapjoaxWghcHQV+4BGyIni2UNzJQQXO9Qv3cCrI0Rha3SACNo/KypWV6ZRe3VzcCczkq2sBSZYhYU10Yf13/cFFxi9hDG21XDpBPB2E3BGsaOB38kUIJPIwH80BIqqA3ZnWDJkbs0Pjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727943277; c=relaxed/simple;
	bh=2EzXql8RzdzXAzloLVN4vnlBWRwG7cQuQLI0ITYJxoU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZuORY7BRgShkARE6bweDgilpxIDJieUkysZ0dvsgUbrZ3b4cvD4x/vUs92AuL3BaFZ/B71WkIX7ps+I4EvPjeBm0BOhxeufeWuSpAYRGxJgEAlBAuzqxqINhLkJn0dl9E+Im955DqAay6MmLICQBIpdIGPdV93HCcVrCO4QKZp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5BE3339;
	Thu,  3 Oct 2024 01:15:02 -0700 (PDT)
Received: from [10.57.76.118] (unknown [10.57.76.118])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 273763F64C;
	Thu,  3 Oct 2024 01:14:31 -0700 (PDT)
Message-ID: <71e7e154-584a-4856-b906-ba92c636b17f@arm.com>
Date: Thu, 3 Oct 2024 09:15:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] sched/fair: Use EAS also when overutilized
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org, qyousef@layalina.io, hongyan.xia2@arm.com,
 Quentin Perret <qperret@google.com>
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-5-vincent.guittot@linaro.org>
 <Zu2gHOv7mqArWXLZ@google.com>
 <CAKfTPtCvwPq+8pQcTZePiee9EXxKAQS=J57X2OavWFrQwkDt5A@mail.gmail.com>
 <ZvUlB8s-zIkDQji7@google.com>
 <CAKfTPtAzG7u0+e=8skMhnCETVxbDTOxT-zLaoqUXB-Zz5=4t+A@mail.gmail.com>
 <Zvw2O4JGBpMXwOZA@google.com>
 <CAKfTPtDOhNmL0Nn3g-agnL5HH5nhwXb3-sfzydEe4nvRKAq3HQ@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAKfTPtDOhNmL0Nn3g-agnL5HH5nhwXb3-sfzydEe4nvRKAq3HQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent,

On 10/3/24 07:27, Vincent Guittot wrote:
> On Tue, 1 Oct 2024 at 19:51, Quentin Perret <qperret@google.com> wrote:
>>
>> On Tuesday 01 Oct 2024 at 18:20:03 (+0200), Vincent Guittot wrote:
>>> With commit 50181c0cff31 ("sched/pelt: Avoid underestimation of task
>>> utilization"), the util_est remains set the value before having to
>>> share the cpu with other tasks which means that the util_est remains
>>> correct even if its util_avg decrease because of sharing the cpu with
>>> other task. This has been done to cover the cases that you mention
>>> above whereboth util_avg and util_est where decreasing when tasks
>>> starts to  share  the CPU bandwidth with others
>>
>> I don't think I agree about the correctness of that util_est value at
>> all. The above patch only makes it arbitrarily out of date in the truly
>> overcommitted case. All the util-based heuristic we have in the
>> scheduler are based around the assumption that the close future will
>> look like the recent past, so using an arbitrarily old util-est is still
>> incorrect. I can understand how this may work OK in RT-app or other
> 
> This fixes a real use case on android device
> 
>> use-cases with perfectly periodic tasks for their entire lifetime and
>> such, but this doesn't work at all in the general case.
>>
>>> And feec() will return -1 for that case because util_est remains high
>>
>> And again, checking that a task fits is broken to start with if we don't
>> know how big the task is. When we have reasons to believe that the util
>> values are no longer correct (and the absence of idle time is a very
>> good reason for that) we just need to give up on them. The fact that we
>> have to resort to using out-of-date data to sort of make that work is
>> just another proof that this is not a good idea in the general case.
> 
> That's where I disagree, this is not an out-of-date value, this is the
> last correct one before sharing the cpu
> 
>>
>>> the commit that I mentioned above covers those cases and the task will
>>> not incorrectly fit to another smaller CPU because its util_est is
>>> preserved during the overutilized phase
>>
>> There are other reasons why a task may look like it fits, e.g. two tasks
>> coscheduled on a big CPU get 50% util each, then we migrate one away, the
> 
> 50% of what ? not the cpu capacity. I think you miss one piece of the
> recent pelt behavior here. I fullygree that when the system os
> overcommitted the util base task placement is not correct but I also
> think that feec() can't find a cpu in such case
> 
>> CPU looks half empty. Is it half empty? We've got no way to tell until
> 
> The same here, it's not thanks to util_est
> 
>> we see idle time. The current util_avg and old util_est value are just
>> not helpful, they're both bad signals and we should just discard them.
>>
>> So again I do feel like the best way forward would be to change the
>> nature of the OU threshold to actually ask cpuidle 'when was the last
>> time there was idle time?' (or possibly cache that in the idle task
>> directly). And then based on that we can decide whether we want to enter
>> feec() and do util-based decision, or to kick the push-pull mechanism in
>> your other patches, things like that. That would solve/avoid the problem
>> I mentioned in the previous paragraph and make the OU detection more
>> robust. We could also consider using different thresholds in different
>> places to re-enable load-balancing earlier, and give up on feec() a bit
>> later to avoid messing the entire task placement when we're only
>> transiently OU because of misfit. But eventually, we really need to just
>> give up on util values altogether when we're really overcommitted, it's
>> really an invariant we need to keep.
> 
> For now, I will increase the OU threshold to cpu capacity to reduce
> the false overutilized state because of misfit tasks which is what I
> really care about. The redesign of OU will come in a different series
> as this implies more rework. IIUC your point, we are more interested
> by the prev cpu than the current one
> 

What do you mean by that?
Is it due to OU in e.g. Little cluster?
Is it amplified by the uclamp_max usage?

You're re-writing heavily the EAS+EM and I would like to understand
your motivation.

BTW, do you know that if you or anyone wants to improve the EAS/EM
should be able to provide the power numbers?

W/o the power numbers the discussion is moot. Many times SW engineers
have wrong assumptions about HW, therefore we have to test and
measure. There are confidential power saving techniques in HW
that can be missed and some ugly workaround created in SW for issues
which don't exist.

That's why we have to discuss the power numbers.

This _subject_ is not different. If EAS is going to help
even in OU state - we need the numbers.

Regards,
Lukasz

