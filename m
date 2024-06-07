Return-Path: <linux-kernel+bounces-205750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E93358FFFC9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 742B5281B28
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4445215B969;
	Fri,  7 Jun 2024 09:43:21 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3C013790B
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717753400; cv=none; b=Uj7NV4DPlNgwSHOFNochnhP4VxPWYcLbA++mb4HjT4fj0amrB+A4EibdkFCCALqjzkqIhdSAgGadunacVCM9JIZHRPSxAu6pm8cWUtsNJuKIbnQ8h7uStWbYiZAKOQCusWWOP7c2rrF3+Hp/dvPbtiEO1pG6G4rFPRXq6H/Tetc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717753400; c=relaxed/simple;
	bh=aYxAMbiC9GFuHLeU5OXRDfs9gVY0Lm4yjtRm2oC83Qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wa55gcHvDJbfNg6ZzvjZg9I9Uv3ihcXxAQOuiN88MkBcvq7gCKziSC7okfigyu6J0iECzUgaFFk9rFzZht6Lsb8oWwHEPWWpi+frtiZwiZyKmhftNBCk60AeIrMT06UZIHRgFpunNd8pYMuUUH1HxSvhdGDgf+RVgBoUi6Xt4o8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96B9F2F4;
	Fri,  7 Jun 2024 02:43:42 -0700 (PDT)
Received: from [10.57.70.246] (unknown [10.57.70.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30C913F762;
	Fri,  7 Jun 2024 02:43:17 -0700 (PDT)
Message-ID: <968fec1a-9a54-4b2d-a54c-653d84393c82@arm.com>
Date: Fri, 7 Jun 2024 10:43:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mm: swap: mTHP swap allocator base on swap cluster
 order
Content-Language: en-GB
To: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <kasong@tencent.com>, "Huang, Ying" <ying.huang@intel.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Barry Song <baohua@kernel.org>
References: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Sorry I'm late to the discussion - I've been out for the last 3.5 weeks and just
getting through my mail now...


On 24/05/2024 18:17, Chris Li wrote:
> This is the short term solutiolns "swap cluster order" listed
> in my "Swap Abstraction" discussion slice 8 in the recent
> LSF/MM conference.

I've read the article on lwn and look forward to watching the video once
available. The longer term plans look interesting.

> 
> When commit 845982eb264bc "mm: swap: allow storage of all mTHP
> orders" is introduced, it only allocates the mTHP swap entries
> from new empty cluster list. That works well for PMD size THP,
> but it has a serius fragmentation issue reported by Barry.

Yes, that was a deliberate initial approach to be conservative, just like the
original PMD-size THP support. I'm glad to see work to improve the situation!

> 
> https://lore.kernel.org/all/CAGsJ_4zAcJkuW016Cfi6wicRr8N9X+GJJhgMQdSMp+Ah+NSgNQ@mail.gmail.com/
> 
> The mTHP allocation failure rate raises to almost 100% after a few
> hours in Barry's test run.
> 
> The reason is that all the empty cluster has been exhausted while
> there are planty of free swap entries to in the cluster that is
> not 100% free.
> 
> Address this by remember the swap allocation order in the cluster.
> Keep track of the per order non full cluster list for later allocation.

I don't immediately see how this helps because memory is swapped back in
per-page (currently), so just because a given cluster was initially filled with
entries of a given order, doesn't mean that those entries are freed in atomic
units; only specific pages could have been swapped back in, meaning the holes
are not of the required order. Additionally, scanning could lead to order-0
pages being populated in random places.

My naive assumption was that the obvious way to solve this problem in the short
term would be to extend the scanning logic to be able to scan for an arbitrary
order. That way you could find an allocation of the required order in any of the
clusters, even a cluster that was not originally allocated for the required order.

I guess I should read your patches to understand exactly what you are doing
rather than making assumptions...

Thanks,
Ryan

> 
> This greatly improve the sucess rate of the mTHP swap allocation.
> While I am still waiting for Barry's test result. I paste Kairui's test
> result here:
> 
> I'm able to reproduce such an issue with a simple script (enabling all order of mthp):
> 
> modprobe brd rd_nr=1 rd_size=$(( 10 * 1024 * 1024))
> swapoff -a
> mkswap /dev/ram0
> swapon /dev/ram0
> 
> rmdir /sys/fs/cgroup/benchmark
> mkdir -p /sys/fs/cgroup/benchmark
> cd /sys/fs/cgroup/benchmark
> echo 8G > memory.max
> echo $$ > cgroup.procs
> 
> memcached -u nobody -m 16384 -s /tmp/memcached.socket -a 0766 -t 32 -B binary &
> 
> /usr/local/bin/memtier_benchmark -S /tmp/memcached.socket \
>         -P memcache_binary -n allkeys --key-minimum=1 \
>         --key-maximum=18000000 --key-pattern=P:P -c 1 -t 32 \
>         --ratio 1:0 --pipeline 8 -d 1024
> 
> Before:
> Totals      48805.63         0.00         0.00         5.26045         1.19100        38.91100        59.64700     51063.98
> After:
> Totals      71098.84         0.00         0.00         3.60585         0.71100        26.36700        39.16700     74388.74
> 
> And the fallback ratio dropped by a lot:
> Before:
> hugepages-32kB/stats/anon_swpout_fallback:15997
> hugepages-32kB/stats/anon_swpout:18712
> hugepages-512kB/stats/anon_swpout_fallback:192
> hugepages-512kB/stats/anon_swpout:0
> hugepages-2048kB/stats/anon_swpout_fallback:2
> hugepages-2048kB/stats/anon_swpout:0
> hugepages-1024kB/stats/anon_swpout_fallback:0
> hugepages-1024kB/stats/anon_swpout:0
> hugepages-64kB/stats/anon_swpout_fallback:18246
> hugepages-64kB/stats/anon_swpout:17644
> hugepages-16kB/stats/anon_swpout_fallback:13701
> hugepages-16kB/stats/anon_swpout:18234
> hugepages-256kB/stats/anon_swpout_fallback:8642
> hugepages-256kB/stats/anon_swpout:93
> hugepages-128kB/stats/anon_swpout_fallback:21497
> hugepages-128kB/stats/anon_swpout:7596
> 
> (Still collecting more data, the success swpout was mostly done early, then the fallback began to increase, nearly 100% failure rate)
> 
> After:
> hugepages-32kB/stats/swpout:34445
> hugepages-32kB/stats/swpout_fallback:0
> hugepages-512kB/stats/swpout:1
> hugepages-512kB/stats/swpout_fallback:134
> hugepages-2048kB/stats/swpout:1
> hugepages-2048kB/stats/swpout_fallback:1
> hugepages-1024kB/stats/swpout:6
> hugepages-1024kB/stats/swpout_fallback:0
> hugepages-64kB/stats/swpout:35495
> hugepages-64kB/stats/swpout_fallback:0
> hugepages-16kB/stats/swpout:32441
> hugepages-16kB/stats/swpout_fallback:0
> hugepages-256kB/stats/swpout:2223
> hugepages-256kB/stats/swpout_fallback:6278
> hugepages-128kB/stats/swpout:29136
> hugepages-128kB/stats/swpout_fallback:52
> 
> Reported-by: Barry Song <21cnbao@gmail.com>
> Tested-by: Kairui Song <kasong@tencent.com>
> Signed-off-by: Chris Li <chrisl@kernel.org>
> ---
> Chris Li (2):
>       mm: swap: swap cluster switch to double link list
>       mm: swap: mTHP allocate swap entries from nonfull list
> 
>  include/linux/swap.h |  18 ++--
>  mm/swapfile.c        | 252 +++++++++++++++++----------------------------------
>  2 files changed, 93 insertions(+), 177 deletions(-)
> ---
> base-commit: c65920c76a977c2b73c3a8b03b4c0c00cc1285ed
> change-id: 20240523-swap-allocator-1534c480ece4
> 
> Best regards,


