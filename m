Return-Path: <linux-kernel+bounces-208069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322BF902038
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 13:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37D5280DED
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2387E0E9;
	Mon, 10 Jun 2024 11:18:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB5E6BFCA
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718018323; cv=none; b=HhW6cEPcD5nuh1rh76n4bUnBXp0R/94OAwohejq/ro/i8L7bNBqsQFcBhBlt7cpFMQI+dWQCaSN5f0qEfJCyPX6dHLAqyKtzhlxfMDsxvREzPJDTVUg7wPaqKqVQLNoF+RwT+JjaPy89ca8vjbPrC5brn7uqPrZvL3J1uL8ir6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718018323; c=relaxed/simple;
	bh=8sYtVeF8+Q9fdPOVQY12dZqQN5bdnTUzccDMjtcs5ZA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJH0Ys2HlVNT8lZN+d9db7E72XANGT24SBdufkcYEHUj8Jz/R8FKIXr6714eiGZP/b6kB9/VWkK1rqBfVXWRhM0yoPX2Pv8Mp5FE5nOyq+e0DoqOjD6tmtVFnwm3afM3J0d4AwsnypD0I7gLZxAJq9RowWI4ObNey1b+yH+HMFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A483F12FC;
	Mon, 10 Jun 2024 04:19:04 -0700 (PDT)
Received: from [10.57.70.148] (unknown [10.57.70.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E1BD3F73B;
	Mon, 10 Jun 2024 04:18:39 -0700 (PDT)
Message-ID: <64a5020e-72cf-49f4-89d7-833cc7a12827@arm.com>
Date: Mon, 10 Jun 2024 12:18:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: swap: mTHP allocate swap entries from nonfull
 list
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Kairui Song <kasong@tencent.com>, "Huang, Ying" <ying.huang@intel.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Barry Song <baohua@kernel.org>
References: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
 <20240524-swap-allocator-v1-2-47861b423b26@kernel.org>
 <edb439ea-4754-4d63-8d5f-edc116465d7b@arm.com>
 <CANeU7Q=uT-sZjwvcL4EJUbkZ8dbhnVpQEfNndMXvhBwZOSyr0Q@mail.gmail.com>
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CANeU7Q=uT-sZjwvcL4EJUbkZ8dbhnVpQEfNndMXvhBwZOSyr0Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/06/2024 21:52, Chris Li wrote:
> On Fri, Jun 7, 2024 at 3:35 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 24/05/2024 18:17, Chris Li wrote:
>>> Track the nonfull cluster as well as the empty cluster
>>> on lists. Each order has one nonfull cluster list.
>>>
>>> The cluster will remember which order it was used during
>>> new cluster allocation.
>>>
>>> When the cluster has free entry, add to the nonfull[order]
>>> list.  When the free cluster list is empty, also allocate
>>> from the nonempty list of that order.
>>>
>>> This improves the mTHP swap allocation success rate.
>>
>> If I've understood correctly, the aim here is to link all the current per-cpu
>> clusters for a given order together so that if a cpu can't allocate a new
>> cluster for a given order, then it can steal another CPU's current cluster for
>> that order?
> 
> Stealing other CPU's *current* cluster is not the intent. The intent
> is after all current per-cpu done with this cluster(full), those full
> clusters are not tracked by any per-cpu struct. When those full
> clusters become non-full. Track it in the global nonfull cluster list.
> The per-cpu allocation can take a cluster from that nonfull cluster
> list and start allocating from it.
> 
> The V1 code does not specifically check for the stealing behavior, the
> V2 code will prevent that from happening. Basically each cluster has 4
> states and owners:
> 1) empty, owned by a global free cluster list.
> 2) per cpu allocating. owned by per CPU current.
> 3) nonfull (also non empty). own global nonfull list.
> 4) full, currently not tracked, we can track it under global full list.
> 
> When the per cpu runs out of free cluster, it can take a cluster from
> 3) and move it to 2).

OK, sorry for my misunderstanding, and thanks for the explanaiton. I've taken a
proper look at the patch and with this explanation now understand the intent.

I guess in effect, this is a scanning approach, but you are limiting the
clusters that you scan to those that were originally allocated for the required
order and which are known to have some free space.

I guess this will work more effectively with Barry's series that swaps in a
whole large folio in one go, because it is more likely that holes of the
required size will appear in the non-full clusters. But previous discussions
concluded that it was not always going to be the right approach to swap-in large
folios in one go (certainly not for higer orders). So I don't think you can
(yet) rely on swap slots being freed as order-sized blocks. That said I still
think that your approach should improve the situation even without Barry's series.

In fact, why don't you put the cluster on the non-full list at cluster
allocation time? Then you can also allow a cpu to steal from another cpu's
current cluster (as I initially thought you were doing). I think this should
work with pretty much the same logic? And improve chances of allocation without
increasing chances of fragmentation? (more on this below).

> 
>>
>> If that's the intent, couldn't that be done just by iterating over the per-cpu,
>> per-order cluster pointers? Then you don't need all the linked list churn
> 
> Again, that is not the intent.
> 
>> (althogh I like the linked list changes as a nice cleanup, I'm not sure the
>> churn is neccessary for this change?). There would likely need to be some
>> locking considerations, but it would also allow you to get access to the next
>> entry within the cluster for allocation.
>>
>> However, fundamentally, I don't think this change solves the problem; it just
>> takes a bit longer before the allocation fails. The real problem is
>> fragmentation due to freeing individual pages from swap entries at different times.
> 
> It definitely helps to find nonfull clusters quicker. Please take a
> look at my above comment and read the patch again.
> 
>>
>> Wouldn't it be better to just extend scanning to support high order allocations?
>> Then we can steal a high order block from any cluster, even clusters that were
> 
> Steal from higher order causes the higher order harder to allocate,
> that is downside.
> In my mind, ideally have some high order cluster reservation scheme so
> the high order one doesn't mix with the low order one.

Yes, that would make sense; you could limit the number of clusters allocated for
each order at any given time.

Order-0 stealing will still cause problems. You could probably just remove that
and limit order-0 scanning/stealing to clusters that were originally allocated
for order-0 too, using the same logic.

> 
>> previously full, just like we currently do for order-0. Given we are already
>> falling back to this path for order-0, I don't think it would be any more
>> expensive; infact its less expensive because we only scan once for the high
>> order block, rather than scan for every split order-0 page.
>>
>> Of course that still doesn't solve the proplem entirely; if swap is so
>> fragmented that there is no contiguous block of the required order then you
>> still have to fall back to splitting. As an extra optimization, you could store
> 
> Exactly. That is why I think some high order cluster reservation
> scheme is needed for a short term solution.
> The change itself is not too complicated if we can agree on this approach.
> 
>> the largest contiguous free space available in each cluster to avoid scanning in
>> case its too small?
> 
> Avoid scanning does just get to the non available high order result quicker.
> Does not seem to help increase the high order allocation success rate.
> 
>>
>>
>>>
>>> There are limitations if the distribution of numbers of
>>> different orders of mTHP changes a lot. e.g. there are a lot
>>> of nonfull cluster assign to order A while later time there
>>> are a lot of order B allocation while very little allocation
>>> in order A. Currently the cluster used by order A will not
>>> reused by order B unless the cluster is 100% empty.
>>>
>>> This situation is best addressed by the longer term "swap
>>> buddy allocator", in future patches.
>>> ---
>>>  include/linux/swap.h |  4 ++++
>>>  mm/swapfile.c        | 25 +++++++++++++++++++++++--
>>>  2 files changed, 27 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>> index 0d3906eff3c9..1b7f0794b9bf 100644
>>> --- a/include/linux/swap.h
>>> +++ b/include/linux/swap.h
>>> @@ -255,10 +255,12 @@ struct swap_cluster_info {
>>>                                * cluster
>>>                                */
>>>       unsigned int count:16;
>>> +     unsigned int order:8;
>>>       unsigned int flags:8;
>>>       struct list_head next;
>>>  };
>>>  #define CLUSTER_FLAG_FREE 1 /* This cluster is free */
>>> +#define CLUSTER_FLAG_NONFULL 2 /* This cluster is on nonfull list */
>>>
>>>
>>>  /*
>>> @@ -297,6 +299,8 @@ struct swap_info_struct {
>>>       unsigned char *swap_map;        /* vmalloc'ed array of usage counts */
>>>       struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
>>>       struct list_head free_clusters; /* free clusters list */
>>> +     struct list_head nonfull_clusters[SWAP_NR_ORDERS];
>>> +                                     /* list of cluster that contains at least one free slot */
>>>       unsigned int lowest_bit;        /* index of first free in swap_map */
>>>       unsigned int highest_bit;       /* index of last free in swap_map */
>>>       unsigned int pages;             /* total of usable pages of swap */
>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>>> index 205a60c5f9cb..51923aba500e 100644
>>> --- a/mm/swapfile.c
>>> +++ b/mm/swapfile.c
>>> @@ -363,8 +363,11 @@ static void swap_cluster_schedule_discard(struct swap_info_struct *si,
>>>
>>>  static void __free_cluster(struct swap_info_struct *si, struct swap_cluster_info *ci)
>>>  {
>>> +     if (ci->flags & CLUSTER_FLAG_NONFULL)
>>> +             list_move_tail(&ci->next, &si->free_clusters);
>>> +     else
>>> +             list_add_tail(&ci->next, &si->free_clusters);
>>>       ci->flags = CLUSTER_FLAG_FREE;
>>> -     list_add_tail(&ci->next, &si->free_clusters);
>>>  }
>>>
>>>  /*
>>> @@ -486,7 +489,12 @@ static void dec_cluster_info_page(struct swap_info_struct *p, struct swap_cluste
>>>       ci->count--;
>>>
>>>       if (!ci->count)
>>> -             free_cluster(p, ci);
>>> +             return free_cluster(p, ci);
>>> +
>>> +     if (!(ci->flags & CLUSTER_FLAG_NONFULL)) {
>>> +             list_add_tail(&ci->next, &p->nonfull_clusters[ci->order]);
>>> +             ci->flags |= CLUSTER_FLAG_NONFULL;
>>> +     }
>>>  }
>>>
>>>  /*
>>> @@ -547,6 +555,14 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>>>                       ci = list_first_entry(&si->free_clusters, struct swap_cluster_info, next);
>>>                       list_del(&ci->next);
>>>                       spin_lock(&ci->lock);
>>> +                     ci->order = order;
>>> +                     ci->flags = 0;
>>> +                     spin_unlock(&ci->lock);
>>> +                     tmp = (ci - si->cluster_info) * SWAPFILE_CLUSTER;
>>> +             } else if (!list_empty(&si->nonfull_clusters[order])) {

You are preferring to scan the nonfull clusters over doing discard and
allocating a newly freed cluster; wouldn't it be better to prefer discard over
nonfull scanning?

>>> +                     ci = list_first_entry(&si->nonfull_clusters[order], struct swap_cluster_info, next);
>>> +                     list_del(&ci->next);

I'm struggling a bit with what the value of the nonfull_clusters linked list is.
I wonder if it would be simpler to just track the number of free slots in the
cluster and iterate over the clusters, scanning the ones with the desired order
and which have at least (1 << order) free slots? I guess this list is giving you
an ordering such that the cluster you pull off the list first had its first slot
freed longest ago so it is most likely to have most space?

>>> +                     spin_lock(&ci->lock);
>>>                       ci->flags = 0;
>>>                       spin_unlock(&ci->lock);
>>>                       tmp = (ci - si->cluster_info) * SWAPFILE_CLUSTER;
>>
>> This looks wrong to me; if the cluster is on the nonfull list then it will have
>> had some entries already allocated (by another cpu). So pointing tmp to the
>> first block in the cluster will never yield a free block. The cpu from which you
> 
> I believe it will scan until it finds a free block with alignment down
> in the offset < max loop.

Yes agreed, my bad. Sorry about that.

Thanks,
Ryan

> 
> while (offset < max) {
>     if (swap_range_empty(si->swap_map, offset, nr_pages))
>         break;
>     offset += nr_pages;
> }
> 
>> are stealing the cluster stores the next free block location in its per-cpu
>> structure. So perhaps iterating over the other cpu's `struct percpu_cluster`s is
>> a better approach than the nonfull list?
> 
> No, stealing is not the intent. The intent is  quickly finding the non
> full cluster NOT in other per cpu allocation.
> 
>>
>> Additionally, this cluster will be stored back to this cpu's current cluster at
>> the bottom of the function. That may or may not be what you intended.
> 
> That is what I intended. It remembers the current allocating cluster,
> in case this cluster has more than one high order swap entries.
> 
> Chris
> 
>>
>>> @@ -578,6 +594,7 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>>>                               break;
>>>                       tmp += nr_pages;
>>>               }
>>> +             WARN_ONCE(ci->order != order, "expecting order %d got %d", order, ci->order);
>>>               unlock_cluster(ci);
>>>       }
>>>       if (tmp >= max) {
>>> @@ -956,6 +973,7 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
>>>       ci = lock_cluster(si, offset);
>>>       memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
>>>       ci->count = 0;
>>> +     ci->order = 0;
>>>       ci->flags = 0;
>>>       free_cluster(si, ci);
>>>       unlock_cluster(ci);
>>> @@ -2882,6 +2900,9 @@ static int setup_swap_map_and_extents(struct swap_info_struct *p,
>>>       INIT_LIST_HEAD(&p->free_clusters);
>>>       INIT_LIST_HEAD(&p->discard_clusters);
>>>
>>> +     for (i = 0; i < SWAP_NR_ORDERS; i++)
>>> +             INIT_LIST_HEAD(&p->nonfull_clusters[i]);
>>> +
>>>       for (i = 0; i < swap_header->info.nr_badpages; i++) {
>>>               unsigned int page_nr = swap_header->info.badpages[i];
>>>               if (page_nr == 0 || page_nr > swap_header->info.last_page)
>>>
>>


