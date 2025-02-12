Return-Path: <linux-kernel+bounces-510742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3138FA3215D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7CFF3A2CE1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 08:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5766205AA3;
	Wed, 12 Feb 2025 08:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KBWlrinD"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364B5204C00
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 08:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739349669; cv=none; b=FgQXO8Cpt1BHBM7LXsZe0W04Kt3diiIutYT/j/TgpCHwQyKwzq4jOnKxmL/6l5BZQwnek4qNaLv2XdUbsUwZimoRfIdCmLguUT+e6OIg1Iu55zAa8D9vqwBhWx7M/9sAf2XqIadVkZ54fGS0fWoHAdzT9yPauwAwkc5YNl4AknY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739349669; c=relaxed/simple;
	bh=f9ZCAVmq2gg3N2HN7ui17vIaD9Wt7j6KDCePUL9di18=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VMGrdYdsze/6t9e5u3U4jSZ0Vbt4CqNsPRIl7cAMhhHgFMZ0cde8AFHnNWuzL3vAQ5uBbO8p4HOKXUli1tVq0gSKpi1dV+JLJbfCwVZA7sCwM0CKqrQyp/BpUYtV4RMBZ7WxIX2WaIZkBykaFqf5byrsEw3CXbM6+FYWcCbNfnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KBWlrinD; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739349656; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=G2dzHAeJclCBBtVnMp2ixJo/1kvecabyqzECUSBfwNg=;
	b=KBWlrinDY78UgNTay/Mgi4okpwsW/k32s8qj4aVjR2ES0HzYvqvI66JnkuEpFAFZYtc8ayigu+jpoedcs3JFFPDlYOm3go6vYv2n5dRHG+4G3AxJHUnMG7gdsZm5j2aHkpu9JEXdfTnGgM3D4lRiUXyqk6KxCXkNq1Q85NZ0+8U=
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0WPJWt4O_1739349655 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 12 Feb 2025 16:40:56 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Nikhil Dhama <nikhil.dhama@amd.com>
Cc: <akpm@linux-foundation.org>,  <bharata@amd.com>,
  <huang.ying.caritas@gmail.com>,  <linux-kernel@vger.kernel.org>,
  <linux-mm@kvack.org>,  <mgorman@techsingularity.net>,
  <raghavendra.kodsarathimmappa@amd.com>
Subject: Re: [FIX PATCH] mm: pcp: fix pcp->free_count reduction on page
 allocation
In-Reply-To: <20250212050403.17504-1-nikhil.dhama@amd.com> (Nikhil Dhama's
	message of "Wed, 12 Feb 2025 10:34:03 +0530")
References: <20250128203118.578a46182beea6a82dcd0b1d@linux-foundation.org>
	<20250212050403.17504-1-nikhil.dhama@amd.com>
Date: Wed, 12 Feb 2025 16:40:54 +0800
Message-ID: <871pw33695.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Nikhil Dhama <nikhil.dhama@amd.com> writes:

> On 1/29/2025 10:01 AM, Andrew Morton wrote:
>>
>> On Wed, 15 Jan 2025 19:19:02 +0800 "Huang, Ying" <ying.huang@linux.alibaba.com> wrote:
>>
>>> Andrew Morton <akpm@linux-foundation.org> writes:
>>>
>>>> On Tue, 7 Jan 2025 14:47:24 +0530 Nikhil Dhama <nikhil.dhama@amd.com> wrote:
>>>>
>>>>> In current PCP auto-tuning desgin, free_count was introduced to track
>>>>> the consecutive page freeing with a counter, This counter is incremented
>>>>> by the exact amount of pages that are freed, but reduced by half on
>>>>> allocation. This is causing a 2-node iperf3 client to server's network
>>>>> bandwidth to drop by 30% if we scale number of client-server pairs from 32
>>>>> (where we achieved peak network bandwidth) to 64.
>>>>>
>>>>> To fix this issue, on allocation, reduce free_count by the exact number
>>>>> of pages that are allocated instead of halving it.
>>>> The present division by two appears to be somewhat randomly chosen.
>>>> And as far as I can tell, this patch proposes replacing that with
>>>> another somewhat random adjustment.
>>>>
>>>> What's the actual design here?  What are we attempting to do and why,
>>>> and why is the proposed design superior to the present one?
>>> Cc Mel for the original design.
>>>
>>> IIUC, pcp->free_count is used to identify the consecutive, pure, large
>>> number of page freeing pattern.  For that pattern, larger batch will be
>>> used to free pages from PCP to buddy to improve the performance.  Mixed
>>> free/allocation pattern should not make pcp->free_count large, even if
>>> the number of the pages freed is much larger than that of the pages
>>> allocated in the long run.  So, pcp->free_count decreases rapidly for
>>> the page allocation.
>>>
>>> Hi, Mel, please correct me if my understanding isn't correct.
>>>
>> hm, no Mel.
>>
>> Nikhil, please do continue to work on this - it seems that there will
>> be a significant benefit to retuning this.
>
>
> Hi Andrew,
>
> I have analyzed the performance of different memory-sensitive workloads for these
> two different ways to decrement pcp->free_count. I compared the score amongst
> v6.6 mainline, v6.7 mainline and v6.7 with our patch.
>
> For all the benchmarks, I used a 2-socket AMD server with 382 logical CPUs.
>
> Results I got are as follows:
> All scores are normalized with respect to v6.6 (base).
>
>
> For all the benchmarks below (iperf3, lmbench3 unix, netperf, redis, gups, xsbench),
> a higher score is better.
>
>                     iperf3    lmbench3 Unix       1-node netperf       2-node netperf
>                                   (AF_UNIX)   (SCTP_STREAM_MANY)   (SCTP_STREAM_MANY)
>                    -------   --------------   ------------------   ------------------
> v6.6 (base)            100              100                  100                  100
> v6.7                    69            113.2                   99                98.59
> v6.7 with my patch     100            112.1                100.3               101.16
>
>
>                   redis standard    redis core    redis L3 Heavy    Gups    xsbench
>                   --------------    ----------    --------------    ----    -------
> v6.6 (base)                  100           100              100      100        100
> v6.7                       99.45        101.66            99.47      100      98.14
> v6.7 with my patch         99.76        101.12            99.75      100      99.56
>
>
> and for graph500, hashjoin, pagerank and Kbuild, a lower score is better.
>
>                      graph500     hashjoin      hashjoin    pagerank     Kbuild
>                                (THP always)   (THP never)
>                     ---------  ------------   -----------   --------     ------
> v6.6 (base)              100           100           100         100        100
> v6.7                  101.08         101.3         101.9         100       98.8
> v6.7 with my patch     99.73           100        101.66         100       99.6
>
> from these result I can conclude that this patch is performing better
> or as good as base v6.7 on almost all of these workloads.

Sorry, this change doesn't make sense to me.

For example, if a large size process exits on a CPU, pcp->free_count
will increase on this CPU.  This is good, because the process can free
pages quicker during exiting with the larger batching.  However, after
that, pcp->free_count may be kept large for a long duration unless a
large number of page allocation (without large number of page freeing)
are done on the CPU.  So, the page freeing parameter may be influenced
by some unrelated workload for long time.  That doesn't sound good.

In effect, the larger pcp->free_count will increase page freeing batch
size.  That will improve the page freeing throughput but hurt page
freeing latency.  Please check the page freeing latency too.  If larger
batch number helps performance without regressions, just increase batch
number directly instead of playing with pcp->free_count.

And, do you run network related workloads on one machine?  If so, please
try to run them on two machines instead, with clients and servers run on
different machines.  At least, please use different sockets for clients
and servers.  Because larger pcp->free_count will make it easier to
trigger free_high heuristics.  If that is the case, please try to
optimize free_high heuristics directly too.

---
Best Regards,
Huang, Ying

