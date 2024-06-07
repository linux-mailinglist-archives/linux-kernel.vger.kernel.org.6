Return-Path: <linux-kernel+bounces-205846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3260690012B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B602F1C21652
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4579C186295;
	Fri,  7 Jun 2024 10:49:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B515178C96
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 10:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717757369; cv=none; b=D0bvjW+o6GlCjLfvraiursIWA6ANIXJJ8jtGVhmaF4coxCU5904IQ8Y7BPgXzJCgLbigJVYVPU9SCpHy384YJqmnWZJG/MlSkidWAh4DLoyGZsY/gAZVwn9X/oawHdQu9/HI0TmPuD+cLTNHB66eLmPxwCl1U1l0LrBa3tV20F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717757369; c=relaxed/simple;
	bh=F5xksq+7xc24osVGuNQX063f8gRZvqxnh4DLRgjVzZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ada1IZZ/2pO3O2AVS9oVEsMHSZmZGRjCIlQwSch+qidiFfUeGavgi5g46mrZZNs24xclELqyfMXERKyYLLrUGPwT0jPo/a3vuD8y4g7mlrD+u1kExZJMiwt5GSX1aJGwl7k7bgBs2NMNdbIKd9sRsLv4zLnzMcem5EB/TKhb/Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CCDBD2F4;
	Fri,  7 Jun 2024 03:49:51 -0700 (PDT)
Received: from [10.57.70.246] (unknown [10.57.70.246])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5AAC33F762;
	Fri,  7 Jun 2024 03:49:26 -0700 (PDT)
Message-ID: <ffafe1b9-352c-4115-9e2d-c91ba93c9cb8@arm.com>
Date: Fri, 7 Jun 2024 11:49:24 +0100
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
To: Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Kairui Song <kasong@tencent.com>, "Huang, Ying" <ying.huang@intel.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
 <CANeU7QkmQ+bJoFnr-ca-xp_dP1XgEKNSwb489MYVqynP_Q8Ddw@mail.gmail.com>
 <CAGsJ_4y1L5uA6twjjJSs3bYhFc-Urr1oUWb0Q8f3cczgbqyBMA@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4y1L5uA6twjjJSs3bYhFc-Urr1oUWb0Q8f3cczgbqyBMA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/05/2024 08:49, Barry Song wrote:
> On Wed, May 29, 2024 at 9:04 AM Chris Li <chrisl@kernel.org> wrote:
>>
>> I am spinning a new version for this series to address two issues
>> found in this series:
>>
>> 1) Oppo discovered a bug in the following line:
>> +               ci = si->cluster_info + tmp;
>> Should be "tmp / SWAPFILE_CLUSTER" instead of "tmp".
>> That is a serious bug but trivial to fix.
>>
>> 2) order 0 allocation currently blindly scans swap_map disregarding
>> the cluster->order. Given enough order 0 swap allocations(close to the
>> swap file size) the order 0 allocation head will eventually sweep
>> across the whole swapfile and destroy other cluster order allocations.
>>
>> The short term fix is just skipping clusters that are already assigned
>> to higher orders.
>>
>> In the long term, I want to unify the non-SSD to use clusters for
>> locking and allocations as well, just try to follow the last
>> allocation (less seeking) as much as possible.
> 
> Hi Chris,
> 
> I am sharing some new test results with you. This time, we used two
> zRAM devices by modifying get_swap_pages().
> 
> zram0 -> dedicated for order-0 swpout
> zram1 -> dedicated for order-4 swpout
> 
> We allocate a generous amount of space for zRAM1 to ensure it never gets full
> and always has ample free space. However, we found that Ryan's approach
> does not perform well even in this straightforward scenario. Despite zRAM1
> having 80% of its space remaining, we still experience issues obtaining
> contiguous swap slots and encounter a high swpout_fallback ratio.
> 
> Sorry for the report, Ryan :-)

No problem; clearly it needs to be fixed, and I'll help where I can. I'm pretty
sure that this is due to fragmentation preventing clusters from being freed back
to the free list.

> 
> In contrast, with your patch, we consistently see the thp_swpout_fallback ratio
> at 0%, indicating a significant improvement in the situation.

Unless I've misunderstood something critical, Chris's change is just allowing a
cpu to steal a block from another cpu's current cluster for that order. So it
just takes longer (approx by a factor of the number of cpus in the system) to
get to the state where fragmentation is causing fallbacks? As I said in the
other thread, I think the more robust solution is to implement scanning for high
order blocks.

> 
> Although your patch still has issues supporting the mixing of order-0 and
> order-4 pages in a swap device, it represents a significant improvement.
> 
> I would be delighted to witness your approach advancing with Ying
> Huang’s assistance. However, due to my current commitments, I
> regret that I am unable to allocate time for debugging.
> 
>>
>> Chris
>>
>>
>>
>> On Fri, May 24, 2024 at 10:17 AM Chris Li <chrisl@kernel.org> wrote:
>>>
>>> This is the short term solutiolns "swap cluster order" listed
>>> in my "Swap Abstraction" discussion slice 8 in the recent
>>> LSF/MM conference.
>>>
>>> When commit 845982eb264bc "mm: swap: allow storage of all mTHP
>>> orders" is introduced, it only allocates the mTHP swap entries
>>> from new empty cluster list. That works well for PMD size THP,
>>> but it has a serius fragmentation issue reported by Barry.
>>>
>>> https://lore.kernel.org/all/CAGsJ_4zAcJkuW016Cfi6wicRr8N9X+GJJhgMQdSMp+Ah+NSgNQ@mail.gmail.com/
>>>
>>> The mTHP allocation failure rate raises to almost 100% after a few
>>> hours in Barry's test run.
>>>
>>> The reason is that all the empty cluster has been exhausted while
>>> there are planty of free swap entries to in the cluster that is
>>> not 100% free.
>>>
>>> Address this by remember the swap allocation order in the cluster.
>>> Keep track of the per order non full cluster list for later allocation.
>>>
>>> This greatly improve the sucess rate of the mTHP swap allocation.
>>> While I am still waiting for Barry's test result. I paste Kairui's test
>>> result here:
>>>
>>> I'm able to reproduce such an issue with a simple script (enabling all order of mthp):
>>>
>>> modprobe brd rd_nr=1 rd_size=$(( 10 * 1024 * 1024))
>>> swapoff -a
>>> mkswap /dev/ram0
>>> swapon /dev/ram0
>>>
>>> rmdir /sys/fs/cgroup/benchmark
>>> mkdir -p /sys/fs/cgroup/benchmark
>>> cd /sys/fs/cgroup/benchmark
>>> echo 8G > memory.max
>>> echo $$ > cgroup.procs
>>>
>>> memcached -u nobody -m 16384 -s /tmp/memcached.socket -a 0766 -t 32 -B binary &
>>>
>>> /usr/local/bin/memtier_benchmark -S /tmp/memcached.socket \
>>>         -P memcache_binary -n allkeys --key-minimum=1 \
>>>         --key-maximum=18000000 --key-pattern=P:P -c 1 -t 32 \
>>>         --ratio 1:0 --pipeline 8 -d 1024
>>>
>>> Before:
>>> Totals      48805.63         0.00         0.00         5.26045         1.19100        38.91100        59.64700     51063.98
>>> After:
>>> Totals      71098.84         0.00         0.00         3.60585         0.71100        26.36700        39.16700     74388.74
>>>
>>> And the fallback ratio dropped by a lot:
>>> Before:
>>> hugepages-32kB/stats/anon_swpout_fallback:15997
>>> hugepages-32kB/stats/anon_swpout:18712
>>> hugepages-512kB/stats/anon_swpout_fallback:192
>>> hugepages-512kB/stats/anon_swpout:0
>>> hugepages-2048kB/stats/anon_swpout_fallback:2
>>> hugepages-2048kB/stats/anon_swpout:0
>>> hugepages-1024kB/stats/anon_swpout_fallback:0
>>> hugepages-1024kB/stats/anon_swpout:0
>>> hugepages-64kB/stats/anon_swpout_fallback:18246
>>> hugepages-64kB/stats/anon_swpout:17644
>>> hugepages-16kB/stats/anon_swpout_fallback:13701
>>> hugepages-16kB/stats/anon_swpout:18234
>>> hugepages-256kB/stats/anon_swpout_fallback:8642
>>> hugepages-256kB/stats/anon_swpout:93
>>> hugepages-128kB/stats/anon_swpout_fallback:21497
>>> hugepages-128kB/stats/anon_swpout:7596
>>>
>>> (Still collecting more data, the success swpout was mostly done early, then the fallback began to increase, nearly 100% failure rate)
>>>
>>> After:
>>> hugepages-32kB/stats/swpout:34445
>>> hugepages-32kB/stats/swpout_fallback:0
>>> hugepages-512kB/stats/swpout:1
>>> hugepages-512kB/stats/swpout_fallback:134
>>> hugepages-2048kB/stats/swpout:1
>>> hugepages-2048kB/stats/swpout_fallback:1
>>> hugepages-1024kB/stats/swpout:6
>>> hugepages-1024kB/stats/swpout_fallback:0
>>> hugepages-64kB/stats/swpout:35495
>>> hugepages-64kB/stats/swpout_fallback:0
>>> hugepages-16kB/stats/swpout:32441
>>> hugepages-16kB/stats/swpout_fallback:0
>>> hugepages-256kB/stats/swpout:2223
>>> hugepages-256kB/stats/swpout_fallback:6278
>>> hugepages-128kB/stats/swpout:29136
>>> hugepages-128kB/stats/swpout_fallback:52
>>>
>>> Reported-by: Barry Song <21cnbao@gmail.com>
>>> Tested-by: Kairui Song <kasong@tencent.com>
>>> Signed-off-by: Chris Li <chrisl@kernel.org>
>>> ---
>>> Chris Li (2):
>>>       mm: swap: swap cluster switch to double link list
>>>       mm: swap: mTHP allocate swap entries from nonfull list
>>>
>>>  include/linux/swap.h |  18 ++--
>>>  mm/swapfile.c        | 252 +++++++++++++++++----------------------------------
>>>  2 files changed, 93 insertions(+), 177 deletions(-)
>>> ---
>>> base-commit: c65920c76a977c2b73c3a8b03b4c0c00cc1285ed
>>> change-id: 20240523-swap-allocator-1534c480ece4
>>>
>>> Best regards,
>>> --
>>> Chris Li <chrisl@kernel.org>
>>>
> 
> Thanks
> Barry


