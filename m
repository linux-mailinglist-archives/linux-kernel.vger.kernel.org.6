Return-Path: <linux-kernel+bounces-295716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CD195A077
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 16:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4153F285634
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3655E1B1D61;
	Wed, 21 Aug 2024 14:54:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3491D12EB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252078; cv=none; b=ccSS8U9lCjojymkaPcpvWCInShKawIox+q7Nbv675nKjT2yQ0nJOX1A2M/U9Qya7u3tpFiUwmeKeqEsE7KoIQ9TJlkiAt+k/uhQwP7ruEOZ+tyYDelqnR1z8+PLo7QqA72pQiiVGgX4WsdrRKWafgbmO256/QqcXzWKJBb/jblg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252078; c=relaxed/simple;
	bh=c8J/6WNgDj+DVg03AwehxyUZ9V23NenT/F3d+dd3/Dk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P9RDNMfIhwl/+eW3FP0IvcELWUETgvsPqeNtkeo72wXl8xv/NSZNRTKg+MkK1Zl1384O4olwLjdAFkeQus9CbjZfRISDB0nTHXu5BIfQlQ8m/qXncEeAaY9DySXcy+XWOWUqPJ98wpiK2CWdvfvolCyfTGjlw0nLlcxlYagiwcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB59BDA7;
	Wed, 21 Aug 2024 07:55:00 -0700 (PDT)
Received: from [10.1.37.52] (e127648.arm.com [10.1.37.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 938103F73B;
	Wed, 21 Aug 2024 07:54:33 -0700 (PDT)
Message-ID: <c8cd6339-c168-4409-8cc4-e85e7ad92914@arm.com>
Date: Wed, 21 Aug 2024 15:54:31 +0100
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
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20240819154259.215504-1-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/24 16:39, Jens Axboe wrote:
> Hi,
> 
> This is v6 of the patchset where the current in_iowait state is split
> into two parts:
> 
> 1) The "task is sleeping waiting on IO", and would like cpufreq goodness
>    in terms of sleep and wakeup latencies.
> 2) The above, and also accounted as such in the iowait stats.
> 
> The current ->in_iowait covers both, this series splits it into two types
> of state so that each can be controlled seperately.

Hi Jens,
I wanted to give a brief update on where I think we're at in terms
of iowait behavior regarding cpuidle and cpufreq.
I'm still working on getting both removed, given the discussions had
on the list [0] and at OSPM [1] this seems realistic and the best way
forward IMO.
That would then naturally make this series and the iowait workaround in
io_uring/io_uring.c unnecessary.

1. For cpuidle:
Main issue with relying on nr_iowaiters is that there is no guarantee
whatsoever that these tasks will wakeup where they went to sleep so if
we can achieve the same throughput without nr_iowaiters it shouldn't
be relevant.
I spent quite some time in fixing teo [2], because untangling nr_iowaiters
from menu seems hard, essentially nobody has worked on menu seriously for
a while now. Thus the plan here is to replace menu by teo eventually.
For your io_uring workloads I see throughput on par for teo (doesn't rely
on iowait) and menu.

# echo teo > /sys/devices/system/cpu/cpuidle/current_governor
#  ./io_uring -r 5 -X0 -d 1 -s 1 -c 1 -p 0 -S 1 -R 0 /dev/nvme0n1 
submitter=0, tid=206, file=/dev/nvme0n1, node=-1
polled=0, fixedbufs=1/0, register_files=1, buffered=0, QD=1
Engine=preadv2
IOPS=22500, BW=87MiB/s, IOS/call=0/0
IOPS=21916, BW=85MiB/s, IOS/call=1/0
IOPS=21774, BW=85MiB/s, IOS/call=1/0
IOPS=22467, BW=87MiB/s, IOS/call=1/0
Exiting on timeout
Maximum IOPS=22500
# echo menu > /sys/devices/system/cpu/cpuidle/current_governor
[  178.754571] cpuidle: using governor menu
#  ./io_uring -r 5 -X0 -d 1 -s 1 -c 1 -p 0 -S 1 -R 0 /dev/nvme0n1 
submitter=0, tid=209, file=/dev/nvme0n1, node=-1
polled=0, fixedbufs=1/0, register_files=1, buffered=0, QD=1
Engine=preadv2
IOPS=21452, BW=83MiB/s, IOS/call=0/0
IOPS=21778, BW=85MiB/s, IOS/call=1/0
IOPS=21120, BW=82MiB/s, IOS/call=1/0
IOPS=20903, BW=81MiB/s, IOS/call=1/0
Exiting on timeout
Maximum IOPS=21778

Please do give it a try for yourself as well!

2. For cpufreq:
Main issue for IO-bound workloads with iowait boosting is we're punishing
the 'good' workloads (that don't have iowait sleeps in their throughput-critical
part, which is already bad because of the scheduling overhead induced) by
making them energy-inefficient to make synthetic benchmarks happy.
A study of more realistic workloads show that they don't suffer from a problem
of building up utilization, not util_est anyway, so they don't actually benefit
from a cpufreq boost.
This leads me to the conclusion that cpufreq iowait boosting can be scrapped
altogether if we accept some degradation of benchmarks like
./io_uring -r 5 -X0 -d 1 -s 1 -c 1 -p 0 -S 1 -R 0 /dev/nvme0n1
or
fio --name=fio --rw=randread --bs=4k --runtime=5 --time_based --filename=/dev/nvme0n1 --iodepth=1 --numjobs=1
(non-io_uring) for that matter.

For io_uring where the expected case is probably not single-threaded sync IO
(or iodepth=1) the cpufreq iowait boost is just hurting use-cases by pushing
it to less efficient frequencies that might not be needed.


I know you want your problem (io_uring showing up as 100% busy even though it's
just sleeping) to be solved like yesterday and my opinion on a future timeline
might not be enough to convince you of much. I wanted to share it anyway.
I don't see an issue with the actual code you're proposing, but it does feel
like a step in the wrong direction to me.

[0] https://lore.kernel.org/lkml/20240304201625.100619-1-christian.loehle@arm.com/
v2: https://lore.kernel.org/lkml/20240518113947.2127802-1-christian.loehle@arm.com/
[1] https://www.youtube.com/watch?v=MSQGEsSziZ4
[2] https://lore.kernel.org/lkml/20240628095955.34096-1-christian.loehle@arm.com/

Regards,
Christian

> [snip]

