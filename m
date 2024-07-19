Return-Path: <linux-kernel+bounces-257205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DEB9376AC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 12:30:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D85281972
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 10:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEC883CDA;
	Fri, 19 Jul 2024 10:30:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369E1C147
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721385032; cv=none; b=bAoFwB9nMEOh/VkfHM+EKFSxz4Vu7bEtLtwnWLXgGfroyVnF68Y6aJ/sn1yVGZWVwSGOb0yf19oasBXAzeLJIm+7Ziha/3SKHT2qcwtfTPHNFeO2TIDTC/gsIw32TiajRO0iyF9bsSWyu5E7hchkiVlHU6FnAN7Gq/belDkQBek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721385032; c=relaxed/simple;
	bh=nN+hNbHlnmAfRaYtpDSGu8o07vmRoGV4Q7RnvS7ALTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OcMhdr4ncx4gEtiIwBMaKaqdFeHgJxPLbKBQqmA4ZNd15TA1bUGmnXUdBKgiepS9uBlAnVkVKAGKr/elfeeII7BIJ+d/mJRucmCVADcKJlGSsfQEJNJ2h76siQhlkXstx4gcHXA3mJkDRiuc2OcFQlMz9onGazOI+hx3czdA8n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AFCFC1042;
	Fri, 19 Jul 2024 03:30:53 -0700 (PDT)
Received: from [10.1.34.164] (XHFQ2J9959.cambridge.arm.com [10.1.34.164])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21F7E3F762;
	Fri, 19 Jul 2024 03:30:27 -0700 (PDT)
Message-ID: <a50fe2d0-f22d-4ba0-8796-56732da0a5c4@arm.com>
Date: Fri, 19 Jul 2024 11:30:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] mm: swap: mTHP allocate swap entries from nonfull
 list
Content-Language: en-GB
To: "Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Kairui Song <kasong@tencent.com>, Hugh Dickins <hughd@google.com>,
 Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Barry Song <baohua@kernel.org>
References: <20240711-swap-allocator-v4-0-0295a4d4c7aa@kernel.org>
 <20240711-swap-allocator-v4-2-0295a4d4c7aa@kernel.org>
 <ea720b4a-da70-4ee3-8f74-2c7344480170@arm.com>
 <CACePvbW_g4T10mqcG-FnJ11nP0obRG8ZgtdAN_EMCosnk9EQpA@mail.gmail.com>
 <b4b31314-1125-40ee-b784-20abc78bd468@arm.com>
 <CACePvbXfeyt5cSX3zQhbZQ4Z5suW6iXw4Kb8BDH96SeMi54o8Q@mail.gmail.com>
 <874j8nxhiq.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <874j8nxhiq.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/07/2024 08:53, Huang, Ying wrote:
> Chris Li <chrisl@kernel.org> writes:
> 
>> On Wed, Jul 17, 2024 at 3:14 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>
>>> On 16/07/2024 23:46, Chris Li wrote:
>>>> On Mon, Jul 15, 2024 at 8:40 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>
>>>>> On 11/07/2024 08:29, Chris Li wrote:
>>>>>> Track the nonfull cluster as well as the empty cluster
>>>>>> on lists. Each order has one nonfull cluster list.
>>>>>>
>>>>>> The cluster will remember which order it was used during
>>>>>> new cluster allocation.
>>>>>>
>>>>>> When the cluster has free entry, add to the nonfull[order]
>>>>>> list.  When the free cluster list is empty, also allocate
>>>>>> from the nonempty list of that order.
>>>>>>
>>>>>> This improves the mTHP swap allocation success rate.
>>>>>>
>>>>>> There are limitations if the distribution of numbers of
>>>>>> different orders of mTHP changes a lot. e.g. there are a lot
>>>>>> of nonfull cluster assign to order A while later time there
>>>>>> are a lot of order B allocation while very little allocation
>>>>>> in order A. Currently the cluster used by order A will not
>>>>>> reused by order B unless the cluster is 100% empty.
>>>>>>
>>>>>> Signed-off-by: Chris Li <chrisl@kernel.org>
>>>>>> ---
>>>>>>  include/linux/swap.h |  4 ++++
>>>>>>  mm/swapfile.c        | 34 +++++++++++++++++++++++++++++++---
>>>>>>  2 files changed, 35 insertions(+), 3 deletions(-)
>>>>>>
>>>>>> diff --git a/include/linux/swap.h b/include/linux/swap.h
>>>>>> index e9be95468fc7..db8d6000c116 100644
>>>>>> --- a/include/linux/swap.h
>>>>>> +++ b/include/linux/swap.h
>>>>>> @@ -254,9 +254,11 @@ struct swap_cluster_info {
>>>>>>                                */
>>>>>>       u16 count;
>>>>>>       u8 flags;
>>>>>> +     u8 order;
>>>>>>       struct list_head list;
>>>>>>  };
>>>>>>  #define CLUSTER_FLAG_FREE 1 /* This cluster is free */
>>>>>> +#define CLUSTER_FLAG_NONFULL 2 /* This cluster is on nonfull list */
>>>>>>
>>>>>>
>>>>>>  /*
>>>>>> @@ -296,6 +298,8 @@ struct swap_info_struct {
>>>>>>       unsigned long *zeromap;         /* vmalloc'ed bitmap to track zero pages */
>>>>>>       struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
>>>>>>       struct list_head free_clusters; /* free clusters list */
>>>>>> +     struct list_head nonfull_clusters[SWAP_NR_ORDERS];
>>>>>> +                                     /* list of cluster that contains at least one free slot */
>>>>>>       unsigned int lowest_bit;        /* index of first free in swap_map */
>>>>>>       unsigned int highest_bit;       /* index of last free in swap_map */
>>>>>>       unsigned int pages;             /* total of usable pages of swap */
>>>>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>>>>>> index f70d25005d2c..e13a33664cfa 100644
>>>>>> --- a/mm/swapfile.c
>>>>>> +++ b/mm/swapfile.c
>>>>>> @@ -361,14 +361,21 @@ static void swap_cluster_schedule_discard(struct swap_info_struct *si,
>>>>>>       memset(si->swap_map + idx * SWAPFILE_CLUSTER,
>>>>>>                       SWAP_MAP_BAD, SWAPFILE_CLUSTER);
>>>>>>
>>>>>> -     list_add_tail(&ci->list, &si->discard_clusters);
>>>>>> +     if (ci->flags)
>>>>>
>>>>> I'm not sure this is future proof; what happens if a flag is added in future
>>>>> that does not indicate that the cluster is on a list. Perhaps explicitly check
>>>>> CLUSTER_FLAG_NONFULL? Or `if (!list_empty(&ci->list))`.
>>>>
>>>> Currently flags are only used to track which list it is on.
>>>
>>> Yes, I get that it works correctly at the moment. I just don't think it's wise
>>> for the code to assume that any flag being set means its on a list; that feels
>>> fragile for future.
>>
>> ACK.
>>
>>>
>>>> BTW, this
>>>> line has changed to check for explicite which list in patch 3 the big
>>>> rewrite. I can move that line change to patch 2 if you want.
>>>
>>> That would get my vote; let's make every patch as good as it can be.
>>
>> Done.
>>
>>>
>>>>
>>>>>
>>>>>> +             list_move_tail(&ci->list, &si->discard_clusters);
>>>>>> +     else
>>>>>> +             list_add_tail(&ci->list, &si->discard_clusters);
>>>>>> +     ci->flags = 0;
>>>>>
>>>>> Bug: (I think?) the cluster ends up on the discard_clusters list and
>>>>> swap_do_scheduled_discard() calls __free_cluster() which will then call
>>>>
>>>> swap_do_scheduled_discard() delete the entry from discard list.
>>>
>>> Ahh yes, my bad!
>>>
>>>> The flag does not track the discard list state.
>>>>
>>>>> list_add_tail() to put it on the free_clusters list. But since it is on the
>>>>> discard_list at that point, shouldn't it call list_move_tail()?
>>>>
>>>> See above. Call list_move_tail() would be a mistake.
>>>>
>>>>>
>>>>>>       schedule_work(&si->discard_work);
>>>>>>  }
>>>>>>
>>>>>>  static void __free_cluster(struct swap_info_struct *si, struct swap_cluster_info *ci)
>>>>>>  {
>>>>>> +     if (ci->flags & CLUSTER_FLAG_NONFULL)
>>>>>> +             list_move_tail(&ci->list, &si->free_clusters);
>>>>>> +     else
>>>>>> +             list_add_tail(&ci->list, &si->free_clusters);
>>>>>>       ci->flags = CLUSTER_FLAG_FREE;
>>>>>> -     list_add_tail(&ci->list, &si->free_clusters);
>>>>>>  }
>>>>>>
>>>>>>  /*
>>>>>> @@ -491,7 +498,12 @@ static void dec_cluster_info_page(struct swap_info_struct *p, struct swap_cluste
>>>>>>       ci->count--;
>>>>>>
>>>>>>       if (!ci->count)
>>>>>> -             free_cluster(p, ci);
>>>>>> +             return free_cluster(p, ci);
>>>>>
>>>>> nit: I'm not sure what the kernel style guide says about this, but I'm not a
>>>>> huge fan of returning void. I'd find it clearer if you just turn the below `if`
>>>>> into an `else if`.
>>>>
>>>> I try to avoid 'else if' if possible.
>>>> Changed to
>>>> if (!ci->count) {
>>>>               free_cluster(p, ci);
>>>>               return;
>>>> }
>>>
>>> ok
>>>
>>>>
>>>>>
>>>>>> +
>>>>>> +     if (!(ci->flags & CLUSTER_FLAG_NONFULL)) {
>>>>>> +             list_add_tail(&ci->list, &p->nonfull_clusters[ci->order]);
>>>>>
>>>>> I find the transitions when you add and remove a cluster from the
>>>>> nonfull_clusters list a bit strange (if I've understood correctly): It is added
>>>>> to the list whenever there is at least one free swap entry if not already on the
>>>>> list. But you take it off the list when assigning it as the current cluster for
>>>>> a cpu in scan_swap_map_try_ssd_cluster().
>>>>>
>>>>> So you could have this situation:
>>>>>
>>>>>   - cpuA allocs cluster from free list (exclusive to that cpu)
>>>>>   - cpuA allocs 1 swap entry from current cluster
>>>>>   - swap entry is freed; cluster added to nonfull_clusters
>>>>>   - cpuB "allocs" cluster from nonfull_clusters
>>>>>
>>>>> At this point both cpuA and cpuB share the same cluster as their current
>>>>> cluster. So why not just put the cluster on the nonfull_clusters list at
>>>>> allocation time (when removed from free_list) and only remove it from the
>>>>
>>>> The big rewrite on patch 3 does that, taking it off the free list and
>>>> moving it into nonfull.
>>>
>>> Oh, from the title, "RFC: mm: swap: seperate SSD allocation from
>>> scan_swap_map_slots()" I assumed that was just a refactoring of the code to
>>> separate the SSD and HDD code paths. Personally I'd prefer to see the
>>> refactoring separated from behavioural changes.
>>
>> It is not a refactoring. It is a big rewrite of the swap allocator
>> using the cluster. Behavior change is expected. The goal is completely
>> removing the brute force scanning of swap_map[] array for cluster swap
>> allocation.
>>
>>>
>>> Since the patch was titled RFC and I thought it was just refactoring, I was
>>> deferring review. But sounds like it is actually required to realize the test
>>> results quoted on the cover letter?
>>
>> Yes, required because it handles the previous fall out case try_ssd()
>> failed. This big rewrite has gone through a lot of testing and bug
>> fix. It is pretty stable now. The only reason I keep it as RFC is
>> because it is not feature complete. Currently it does not do swap
>> cache reclaim. The next version will have swap cache reclaim and
>> remove the RFC.
>>
>>>
>>>> I am only making the minimal change in this step so the big rewrite can land.
>>>>
>>>>> nonfull_clusters list when it is completely full (or at least definitely doesn't
>>>>> have room for an `order` allocation)? Then you allow "stealing" always instead
>>>>> of just sometimes. You would likely want to move the cluster to the end of the
>>>>> nonfull list when selecting it in scan_swap_map_try_ssd_cluster() to reduce the
>>>>> chances of multiple CPUs using the same cluster.
>>>>
>>>> For nonfull clusters it is less important to avoid multiple CPU
>>>> sharing the cluster. Because the cluster already has previous swap
>>>> entries allocated from the previous CPU.
>>>
>>> But if 2 CPUs have the same cluster, isn't there a pathalogical case where cpuA
>>> could be slightly ahead of cpuB so that cpuA allocates all the free pages and
>>
>> That happens to exist per cpu next pointer already. When the other CPU
>> advances to the next cluster pointer, it can cross with the other
>> CPU's next cluster pointer.
> 
> No.  si->percpu_cluster[cpu].next will keep in the current per cpu
> cluster only.  If it doesn't do that, we should fix it.
> 
> I agree with Ryan that we should make per cpu cluster correct.  A
> cluster in per cpu cluster shouldn't be put in nonfull list.  When we
> scan to the end of a per cpu cluster, we can put the cluster in nonfull
> list if necessary.  And, we should make it correct in this patch instead
> of later in series.  I understand that you want to make the patch itself
> simple, but it's important to make code simple to be understood too.
> Consistent design choice will do that.

I think I'm actually arguing for the opposite of what you suggest here.

As I see it, there are 2 possible approaches; either a cluster is always
considered exclusive to a single cpu when its set as a per-cpu cluster, so it
does not appear on the nonfull list. Or a cluster is considered sharable in this
case, in which case it should be added to the nonfull list.

The code at the moment sort of does both; when a cpu decides to use a cluster in
the nonfull list, it removes it from that list to make it exclusive. But as soon
as a single swap entry is freed from that cluster it is put back on the list.
This neither-one-policy-nor-the-other seems odd to me.

I think Huang, Ying is arguing to keep it always exclusive while installed as a
per-cpu cluster. I was arguing to make it always shared. Perhaps the best
approach is to implement the exclusive policy in this patch (you'd need a flag
to note if any pages were freed while in exclusive use, then when exclusive use
completes, put it back on the nonfull list if the flag was set). Then migrate to
the shared approach as part of the "big rewrite"?

> 
>>> cpuB just ends up scanning and finding nothing to allocate. I think do want to
>>> share the cluster when you really need to, but try to avoid it if there are
>>> other options, and I think moving the cluster to the end of the list might be a
>>> way to help that?
>>
>> Simply moving to the end of the list can create a possible deadloop
>> when all clusters have been scanned and not available swap range
>> found.
> 
> This is another reason that we should put the cluster in
> nonfull_clusters[order--] if there are no free swap entry with "order"
> in the cluster.  It makes design complex to keep it in
> nonfull_clusters[order].
> 
>> We have tried many different approaches including moving to the end of
>> the list. It can cause more fragmentation because each CPU allocates
>> their swap slot cache (64 entries) from a different cluster.
>>
>>>> Those behaviors will be fine
>>>> tuned after the patch 3 big rewrite. Try to make this patch simple.
>>
>> Again, I want to keep it simple here so patch 3 can land.
>>
>>>>> Another potential optimization (which was in my hacked version IIRC) is to only
>>>>> add/remove from nonfull list when `total - count` crosses the (1 << order)
>>>>> boundary rather than when becoming completely full. You definitely won't be able
>>>>> to allocate order-2 if there are only 3 pages available, for example.
>>>>
>>>> That is in patch 3 as well. This patch is just doing the bare minimum
>>>> to introduce the nonfull list.
>>>>
>>>>>
>>>>>> +             ci->flags |= CLUSTER_FLAG_NONFULL;
>>>>>> +     }
>>>>>>  }
>>>>>>
>>>>>>  /*
>>>>>> @@ -550,6 +562,18 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>>>>>>       if (tmp == SWAP_NEXT_INVALID) {
>>>>>>               if (!list_empty(&si->free_clusters)) {
>>>>>>                       ci = list_first_entry(&si->free_clusters, struct swap_cluster_info, list);
>>>>>> +                     list_del(&ci->list);
>>>>>> +                     spin_lock(&ci->lock);
>>>>>> +                     ci->order = order;
>>>>>> +                     ci->flags = 0;
>>>>>> +                     spin_unlock(&ci->lock);
>>>>>> +                     tmp = cluster_index(si, ci) * SWAPFILE_CLUSTER;
>>>>>> +             } else if (!list_empty(&si->nonfull_clusters[order])) {
>>>>>> +                     ci = list_first_entry(&si->nonfull_clusters[order], struct swap_cluster_info, list);
>>>>>> +                     list_del(&ci->list);
>>>>>> +                     spin_lock(&ci->lock);
>>>>>> +                     ci->flags = 0;
>>>>>> +                     spin_unlock(&ci->lock);
>>>>>>                       tmp = cluster_index(si, ci) * SWAPFILE_CLUSTER;
>>>>>>               } else if (!list_empty(&si->discard_clusters)) {
>>>>>>                       /*
>>>>>> @@ -964,6 +988,7 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
>>>>>>       ci = lock_cluster(si, offset);
>>>>>>       memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
>>>>>>       ci->count = 0;
>>>>>> +     ci->order = 0;
>>>>>>       ci->flags = 0;
>>>>>
>>>>> Wonder if it would be better to put this in __free_cluster()?
>>>>
>>>> Both flags and order were moved to __free_cluster() in patch 3 of this
>>>> series. The order is best assigned together with flags when the
>>>> cluster changes the list.
>>>>
>>>> Thanks for the review. The patch 3 big rewrite is the heavy lifting.
>>>
>>> OK, but sounds like patch 3 isn't really RFC after all, but a crucial part of
>>> the series? I'll try to take a look at it today.
>>
>> Yes, it is the cluster swap allocator big rewrite.
>>
>> Thank you for taking a look.
> 
> --
> Best Regards,
> Huang, Ying


