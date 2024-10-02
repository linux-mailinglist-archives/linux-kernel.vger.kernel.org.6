Return-Path: <linux-kernel+bounces-347086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C10F98CD9E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 09:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE3FE1F244AF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 07:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CFF1885AD;
	Wed,  2 Oct 2024 07:10:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D195D2030A
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 07:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727853015; cv=none; b=XGb7LCWh2WGyTMc5r5lJb3PYEipbtuF9Lg095wRVlkQbJzJzszoGjYbjQuy8rJV3cra7pFsTs79sDLAS4SaYgsGyRlcVGc/DoQ8rGnLzP1usX08w735PX+2TghfxEs1fVva8ucPlPM+fCXYMqhtp+hlydsR4lABePADSUTKOS14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727853015; c=relaxed/simple;
	bh=j5hfOjYANjbm9ReBY2owT5ZFMuGWfit7z4lgeJ7ggjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YpAoc/ejgXISnv0Zjlford6X4R0d/Y3O0fPjvfG7zA6mLZSxIaFCSSL4EbwHafzsowAcLsucKe+vytFjnwkYWDv6AhsfAJlNO/aerbIRMX51R2IcOSUPhAVkgix6cDwnCgUln2P2E5oluX/I01SqyEFKN/RG+1//7/VGHmHE1KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4507D339;
	Wed,  2 Oct 2024 00:10:39 -0700 (PDT)
Received: from [10.57.77.16] (unknown [10.57.77.16])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39C4C3F64C;
	Wed,  2 Oct 2024 00:10:07 -0700 (PDT)
Message-ID: <bb89dbad-f6e8-471e-a165-750cce2b1593@arm.com>
Date: Wed, 2 Oct 2024 08:11:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/5] sched/fair: Use EAS also when overutilized
To: Quentin Perret <qperret@google.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
 mgorman@suse.de, vschneid@redhat.com, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org, qyousef@layalina.io, hongyan.xia2@arm.com
References: <20240830130309.2141697-1-vincent.guittot@linaro.org>
 <20240830130309.2141697-5-vincent.guittot@linaro.org>
 <Zu2gHOv7mqArWXLZ@google.com>
 <CAKfTPtCvwPq+8pQcTZePiee9EXxKAQS=J57X2OavWFrQwkDt5A@mail.gmail.com>
 <ZvUlB8s-zIkDQji7@google.com>
 <CAKfTPtAzG7u0+e=8skMhnCETVxbDTOxT-zLaoqUXB-Zz5=4t+A@mail.gmail.com>
 <Zvw2O4JGBpMXwOZA@google.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <Zvw2O4JGBpMXwOZA@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Quentin and Vincent,

On 10/1/24 18:50, Quentin Perret wrote:
> On Tuesday 01 Oct 2024 at 18:20:03 (+0200), Vincent Guittot wrote:
>> With commit 50181c0cff31 ("sched/pelt: Avoid underestimation of task
>> utilization"), the util_est remains set the value before having to
>> share the cpu with other tasks which means that the util_est remains
>> correct even if its util_avg decrease because of sharing the cpu with
>> other task. This has been done to cover the cases that you mention
>> above whereboth util_avg and util_est where decreasing when tasks
>> starts to  share  the CPU bandwidth with others
> 
> I don't think I agree about the correctness of that util_est value at
> all. The above patch only makes it arbitrarily out of date in the truly
> overcommitted case. All the util-based heuristic we have in the
> scheduler are based around the assumption that the close future will
> look like the recent past, so using an arbitrarily old util-est is still
> incorrect. I can understand how this may work OK in RT-app or other
> use-cases with perfectly periodic tasks for their entire lifetime and
> such, but this doesn't work at all in the general case.

I remember that commit Vincent mentioned above. That was from a web
browser test 'Speedometer', not rt-app. The browser has to run the
same 'computation problem' but with quite a lot of JavaScript
frameworks. Those frameworks mainly run in the browser main thread,
with some helper threads in background.

So it was not purely RT-app or other perfectly periodic task.
Although, IIRC Vincent was able to build a model based on rt-app
to tackle that issue.

That patch helped to better reflect the situation in the OS.

For this particular _subject_ I don't think it's relevant, though.
It was actually helping to show that the situation is worse, so
closer to OU because the task was bigger (and we avoid EAS).

> 
>> And feec() will return -1 for that case because util_est remains high
> 
> And again, checking that a task fits is broken to start with if we don't
> know how big the task is. When we have reasons to believe that the util
> values are no longer correct (and the absence of idle time is a very
> good reason for that) we just need to give up on them. The fact that we
> have to resort to using out-of-date data to sort of make that work is
> just another proof that this is not a good idea in the general case.
> 
>> the commit that I mentioned above covers those cases and the task will
>> not incorrectly fit to another smaller CPU because its util_est is
>> preserved during the overutilized phase
> 
> There are other reasons why a task may look like it fits, e.g. two tasks
> coscheduled on a big CPU get 50% util each, then we migrate one away, the
> CPU looks half empty. Is it half empty? We've got no way to tell until
> we see idle time. The current util_avg and old util_est value are just
> not helpful, they're both bad signals and we should just discard them.

So would you then reset them to 0? Or leave them as they are?
What about the other signals (cpu runqueue) which are derived from them?
That sounds like really heavy change or inconsistency in many places.

> 
> So again I do feel like the best way forward would be to change the
> nature of the OU threshold to actually ask cpuidle 'when was the last
> time there was idle time?' (or possibly cache that in the idle task
> directly). And then based on that we can decide whether we want to enter
> feec() and do util-based decision, or to kick the push-pull mechanism in
> your other patches, things like that. That would solve/avoid the problem
> I mentioned in the previous paragraph and make the OU detection more
> robust. We could also consider using different thresholds in different
> places to re-enable load-balancing earlier, and give up on feec() a bit
> later to avoid messing the entire task placement when we're only
> transiently OU because of misfit. But eventually, we really need to just
> give up on util values altogether when we're really overcommitted, it's
> really an invariant we need to keep.

IMHO the problem here with OU was amplified recently due to the
Uclamp_max setting + 'Max aggregation policy' + aggressive frequency
capping + fast freq switching.

Now we are in the situation where we complain about util metrics...

I've been warning Qais and Vincent that this usage of Uclamp_max
in such environment is dangerous and might explode.

If one background task is capped hard in CPU freq, but does computation
'all the time' making that CPU to have no idle time - then IMO
this is not a good scheduling. This is a receipt for starvation.
You probably won't find any better metric.

I would suggest to stop making the OU situation worse and more
frequent with this 'artificial starvation with uclamp_max'.

I understand we want to safe energy, but uclamp_max in current shape
has too many side effects IMO.

Why we haven't invested in the 'Bandwidth controller', e.g. to make
it big.Little aware (if that could be a problem)(they were there for
many years)?

Regards,
Lukasz

