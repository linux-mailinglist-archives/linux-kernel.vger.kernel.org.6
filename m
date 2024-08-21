Return-Path: <linux-kernel+bounces-295862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF8695A231
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 18:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E2A289C61
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B601B3B26;
	Wed, 21 Aug 2024 15:57:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E2D71B2ED1
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 15:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724255835; cv=none; b=mn3D4AJrOdnJgbdvcKSXFmw4pgEiczzl1jA8HWIGsuoH9R2pslgHcG7hSM9p3NRsvgddzTXpttCspeMbW2CaE0CJkJiE1PnK9v0qfPRtYMvLX7qCbNjlqSz2/04asjrc312t6vIVDdhkUqSTtHt2anzox1aeqij5trLmJZ9KZ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724255835; c=relaxed/simple;
	bh=Zhh59TAwP5gItjgZHZgEjWOE9suwfYFb5kHxCglJ6bY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XrxMM7ewxNEKP1ffDG0cbdthWh80JpACgBanwsLsw6qZTKMPSdMjt1lNDn3UwezcSI1I5vGRo8hqMnGjmfGXxvoQbrAzljU4SXFRMxFHFGOAe7ICPpNwkQMnPsXKhk87bj1AhhLJs19gokTZaOhhGkBHyxESHLsfTqHdFfgbQnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6486DA7;
	Wed, 21 Aug 2024 08:57:38 -0700 (PDT)
Received: from [10.1.37.52] (e127648.arm.com [10.1.37.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C9DA3F66E;
	Wed, 21 Aug 2024 08:57:11 -0700 (PDT)
Message-ID: <5dd66e38-2b00-4b89-8b8c-cc25ad39dcb8@arm.com>
Date: Wed, 21 Aug 2024 16:57:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET v6 0/4] Split iowait into two states
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, tglx@linutronix.de,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Qais Yousef <qyousef@layalina.io>, "Rafael J. Wysocki" <rafael@kernel.org>
References: <20240819154259.215504-1-axboe@kernel.dk>
 <c8cd6339-c168-4409-8cc4-e85e7ad92914@arm.com>
 <9a0f2192-b897-4952-b4ea-7fe229f33001@kernel.dk>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <9a0f2192-b897-4952-b4ea-7fe229f33001@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/21/24 16:04, Jens Axboe wrote:
> On 8/21/24 8:54 AM, Christian Loehle wrote:
>> On 8/19/24 16:39, Jens Axboe wrote:
>>> Hi,
>>>
>>> This is v6 of the patchset where the current in_iowait state is split
>>> into two parts:
>>>
>>> 1) The "task is sleeping waiting on IO", and would like cpufreq goodness
>>>    in terms of sleep and wakeup latencies.
>>> 2) The above, and also accounted as such in the iowait stats.
>>>
>>> The current ->in_iowait covers both, this series splits it into two types
>>> of state so that each can be controlled seperately.
>>
>> Hi Jens,
>> I wanted to give a brief update on where I think we're at in terms
>> of iowait behavior regarding cpuidle and cpufreq.
>> I'm still working on getting both removed, given the discussions had
>> on the list [0] and at OSPM [1] this seems realistic and the best way
>> forward IMO.
>> That would then naturally make this series and the iowait workaround in
>> io_uring/io_uring.c unnecessary.
>>
>> 1. For cpuidle:
>> Main issue with relying on nr_iowaiters is that there is no guarantee
>> whatsoever that these tasks will wakeup where they went to sleep so if
>> we can achieve the same throughput without nr_iowaiters it shouldn't
>> be relevant.
>> I spent quite some time in fixing teo [2], because untangling nr_iowaiters
>> from menu seems hard, essentially nobody has worked on menu seriously for
>> a while now. Thus the plan here is to replace menu by teo eventually.
>> For your io_uring workloads I see throughput on par for teo (doesn't rely
>> on iowait) and menu.
>>
>> # echo teo > /sys/devices/system/cpu/cpuidle/current_governor
>> #  ./io_uring -r 5 -X0 -d 1 -s 1 -c 1 -p 0 -S 1 -R 0 /dev/nvme0n1 
>> submitter=0, tid=206, file=/dev/nvme0n1, node=-1
>> polled=0, fixedbufs=1/0, register_files=1, buffered=0, QD=1
>> Engine=preadv2
>> IOPS=22500, BW=87MiB/s, IOS/call=0/0
>> IOPS=21916, BW=85MiB/s, IOS/call=1/0
>> IOPS=21774, BW=85MiB/s, IOS/call=1/0
>> IOPS=22467, BW=87MiB/s, IOS/call=1/0
>> Exiting on timeout
>> Maximum IOPS=22500
>> # echo menu > /sys/devices/system/cpu/cpuidle/current_governor
>> [  178.754571] cpuidle: using governor menu
>> #  ./io_uring -r 5 -X0 -d 1 -s 1 -c 1 -p 0 -S 1 -R 0 /dev/nvme0n1 
>> submitter=0, tid=209, file=/dev/nvme0n1, node=-1
>> polled=0, fixedbufs=1/0, register_files=1, buffered=0, QD=1
>> Engine=preadv2
>> IOPS=21452, BW=83MiB/s, IOS/call=0/0
>> IOPS=21778, BW=85MiB/s, IOS/call=1/0
>> IOPS=21120, BW=82MiB/s, IOS/call=1/0
>> IOPS=20903, BW=81MiB/s, IOS/call=1/0
>> Exiting on timeout
>> Maximum IOPS=21778
>>
>> Please do give it a try for yourself as well!
>>
>> 2. For cpufreq:
>> Main issue for IO-bound workloads with iowait boosting is we're punishing
>> the 'good' workloads (that don't have iowait sleeps in their throughput-critical
>> part, which is already bad because of the scheduling overhead induced) by
>> making them energy-inefficient to make synthetic benchmarks happy.
>> A study of more realistic workloads show that they don't suffer from a problem
>> of building up utilization, not util_est anyway, so they don't actually benefit
>> from a cpufreq boost.
>> This leads me to the conclusion that cpufreq iowait boosting can be scrapped
>> altogether if we accept some degradation of benchmarks like
>> ./io_uring -r 5 -X0 -d 1 -s 1 -c 1 -p 0 -S 1 -R 0 /dev/nvme0n1
>> or
>> fio --name=fio --rw=randread --bs=4k --runtime=5 --time_based --filename=/dev/nvme0n1 --iodepth=1 --numjobs=1
>> (non-io_uring) for that matter.
> 
> The original iowait addition came because a big regression was seen
> compared to not setting iowait, it was around 20% iirc. That's big, and
> not in the realm of "some degradation" that will be acceptable. And that
> will largely depend on the system being used. On some systems, it'll be
> less, and on some it'll be more.

We are also talking about power regressions of 1000% easily FWIW for e.g.
fio --name=fio --rw=randread --bs=4k --runtime=10 --time_based --filename=/dev/nvme0n1 --iodepth=32 --numjobs=nr_cpus --ioengine=io_uring
(without any throughput gain).

> 
>> For io_uring where the expected case is probably not single-threaded
>> sync IO (or iodepth=1) the cpufreq iowait boost is just hurting
>> use-cases by pushing it to less efficient frequencies that might not
>> be needed.
> 
> People do all sorts of things, and sync (or low queue depth) IO is
> certainly one of the use cases. In fact that's where the above report
> came from, on the postgres aio side.

I have looked at that and (on the platforms I've tested) that was indeed
from cpuidle FWIW. Moving away from menu did remedy this with the
mainlined teo fixes.

>> I know you want your problem (io_uring showing up as 100% busy even
>> though it's just sleeping) to be solved like yesterday and my opinion
>> on a future timeline might not be enough to convince you of much. I
>> wanted to share it anyway. I don't see an issue with the actual code
>> you're proposing, but it does feel like a step in the wrong direction
>> to me.
> 
> As mentioned in my original reply, I view this as entirely orthogonal,
> and while I appreciate your efforts in this area, I'm a little tired of
> this being brought up as a gatekeeping metric when it's not there.

I can understand you being tired of me bringing this up, but I'm not
gatekeeping this series, not intentionally anyway.
Just trying to give some perspective on the entire iowait behavior
future.

> 
> If we can eliminate iowait for boosting down the line, then I'm all for
> it. But this has now been pending for > 6 months and I don't think it's
> far to keep stringing this along on a future promise. This isn't a lot
> of code and it solves the issue for now, if the code will get removed
> down the line as not needed, then that's certainly fine. For now, we
> need it.

I'm fine with carrying a revert of the series along my patchset.

Regards,
Christian

