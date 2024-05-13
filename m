Return-Path: <linux-kernel+bounces-177360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFAB8C3D78
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 10:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08380B20AD0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 08:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D564C1482E4;
	Mon, 13 May 2024 08:43:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D011474B1
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715589836; cv=none; b=LpRKAYBlXNXGtk4zd9pvRdj3SNI8rwiT3SEaP+Kj5vzdlnDq/6UwX9vKy9ML8EBbfyTFueseSrW8Zbf4jEBsPbrpX3vemmA0b6udQOgMLUZkHhcukwr68LCg9QD/5WKrmpyDaoCP5ugcxZsItcaZkqBLotGkUoOQAsX1jhzdl/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715589836; c=relaxed/simple;
	bh=oPs0LIVO0daVAFThgjJxWqxTMHcpGjCf9NysjZWeEKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ERpweqjOFHBiQYu4bCgAIZVPHMQRfMrIoHcDdwT9TEd0PN3ulJnzgoe1Xjcq1FU/t57s1KALuxaCWF3EpKyGhcULzX8hJMu/Z9DcOAgJXHbaHJJk2uveOZs0wiIbXGVj7/CED3ku5xEusFp57pWCIk/IRl8xuoixSw66uCcsi7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0BA31007;
	Mon, 13 May 2024 01:44:18 -0700 (PDT)
Received: from [10.57.68.95] (unknown [10.57.68.95])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60ECD3F7A6;
	Mon, 13 May 2024 01:43:51 -0700 (PDT)
Message-ID: <17b4f026-d734-4610-8517-d83081f75ed4@arm.com>
Date: Mon, 13 May 2024 09:43:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/7] mm: swap: Allow storage of all mTHP orders
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>,
 Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
 Michal Hocko <mhocko@suse.com>, Kefeng Wang <wangkefeng.wang@huawei.com>,
 Chris Li <chrisl@kernel.org>, Lance Yang <ioworker0@gmail.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240408183946.2991168-1-ryan.roberts@arm.com>
 <20240408183946.2991168-6-ryan.roberts@arm.com>
 <CAGsJ_4zAcJkuW016Cfi6wicRr8N9X+GJJhgMQdSMp+Ah+NSgNQ@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4zAcJkuW016Cfi6wicRr8N9X+GJJhgMQdSMp+Ah+NSgNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/05/2024 08:30, Barry Song wrote:
> On Tue, Apr 9, 2024 at 6:40 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> Multi-size THP enables performance improvements by allocating large,
>> pte-mapped folios for anonymous memory. However I've observed that on an
>> arm64 system running a parallel workload (e.g. kernel compilation)
>> across many cores, under high memory pressure, the speed regresses. This
>> is due to bottlenecking on the increased number of TLBIs added due to
>> all the extra folio splitting when the large folios are swapped out.
>>
>> Therefore, solve this regression by adding support for swapping out mTHP
>> without needing to split the folio, just like is already done for
>> PMD-sized THP. This change only applies when CONFIG_THP_SWAP is enabled,
>> and when the swap backing store is a non-rotating block device. These
>> are the same constraints as for the existing PMD-sized THP swap-out
>> support.
>>
>> Note that no attempt is made to swap-in (m)THP here - this is still done
>> page-by-page, like for PMD-sized THP. But swapping-out mTHP is a
>> prerequisite for swapping-in mTHP.
>>
>> The main change here is to improve the swap entry allocator so that it
>> can allocate any power-of-2 number of contiguous entries between [1, (1
>> << PMD_ORDER)]. This is done by allocating a cluster for each distinct
>> order and allocating sequentially from it until the cluster is full.
>> This ensures that we don't need to search the map and we get no
>> fragmentation due to alignment padding for different orders in the
>> cluster. If there is no current cluster for a given order, we attempt to
>> allocate a free cluster from the list. If there are no free clusters, we
>> fail the allocation and the caller can fall back to splitting the folio
>> and allocates individual entries (as per existing PMD-sized THP
>> fallback).
>>
>> The per-order current clusters are maintained per-cpu using the existing
>> infrastructure. This is done to avoid interleving pages from different
>> tasks, which would prevent IO being batched. This is already done for
>> the order-0 allocations so we follow the same pattern.
>>
>> As is done for order-0 per-cpu clusters, the scanner now can steal
>> order-0 entries from any per-cpu-per-order reserved cluster. This
>> ensures that when the swap file is getting full, space doesn't get tied
>> up in the per-cpu reserves.
>>
>> This change only modifies swap to be able to accept any order mTHP. It
>> doesn't change the callers to elide doing the actual split. That will be
>> done in separate changes.

[...]

> 
> Hi Ryan,
> 
> Sorry for bringing up an old thread.

No problem - thanks for the report!

> 
> During the initial hour of utilizing an Android phone with 64KiB mTHP,
> we noticed that the
> anon_swpout_fallback rate was less than 10%. However, after several
> hours of phone
> usage, we observed a significant increase in the anon_swpout_fallback
> rate, reaching
> 100%.

I suspect this is due to fragmentation of the clusters; If there is just one
page left in a cluster then the cluster can't be freed and once the cluster free
list is empty a new cluster allcoation will fail and this will cause fallback to
order-0.

> 
> As I checked the code of scan_swap_map_try_ssd_cluster(),
> 
> static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>         unsigned long *offset, unsigned long *scan_base, int order)
> {
>         unsigned int nr_pages = 1 << order;
>         struct percpu_cluster *cluster;
>         struct swap_cluster_info *ci;
>         unsigned int tmp, max;
> 
> new_cluster:
>         cluster = this_cpu_ptr(si->percpu_cluster);
>         tmp = cluster->next[order];
>         if (tmp == SWAP_NEXT_INVALID) {
>                 if (!cluster_list_empty(&si->free_clusters)) {
>                         tmp = cluster_next(&si->free_clusters.head) *
>                                         SWAPFILE_CLUSTER;
>                 } else if (!cluster_list_empty(&si->discard_clusters)) {
>                         /*
>                          * we don't have free cluster but have some clusters in
>                          * discarding, do discard now and reclaim them, then
>                          * reread cluster_next_cpu since we dropped si->lock
>                          */
>                         swap_do_scheduled_discard(si);
>                         *scan_base = this_cpu_read(*si->cluster_next_cpu);
>                         *offset = *scan_base;
>                         goto new_cluster;
>                 } else
>                         return false;
>         }
> ...
> 
> }
> 
> Considering the cluster_list_empty() checks, is it necessary to have
> free_cluster to
> ensure a continuous allocation of swap slots for large folio swap out?

Yes, currently that is done by design; if we can't allocate a free cluster then
we only scan for free space in an already allocated cluster for order-0
allocations. I did this for a couple of reasons;

1: Simplicity.

2: Keep behavior the same as PMD-order allocations, which are never scanned
(although the cluster is the same size as the PMD so scanning would be pointless
there - so perhaps this is not a good argument for not scanning smaller high
orders).

3: If scanning for a high order fails then we would fall back to order-0 and
scan again, so I was trying to avoid the potential for 2 scans (although once
you split the page, you'll end up scanning per-page, so perhaps its not a real
argument either).

> For instance,
> if numerous clusters still possess ample free swap slots, could we
> potentially miss
> out on them due to a lack of execution of a slow scan?

I think it would definitely be possible to add support for scanning high orders
and from memory, I don't think it would be too difficult. Based on your
experience, it sounds like this would be valuable.

I'm going to be out on Paternity leave for 3 weeks from end of today, so I won't
personally be able to do this until I get back. I might find some time to review
if you were to post something though :)

> 
> I'm not saying your patchset has problems, just that I have some questions.

Let's call it "opportunity for further improvement" rather than problems. :)

I suspect swap-in of large folios may help reduce the fragmentation a bit since
we are less likely to keep parts of a previously swapped-out mTHP in swap.

Also, I understand that Chris Li has been doing some thinking around an
indirection layer which would remove the requirement for pages of a large folio
to be stored contiguously in the swap file. I think he is planning to talk about
that at LSFMM? (which I sadly won't be attending).

Thanks,
Ryan

> 
> Thanks
> Barry


