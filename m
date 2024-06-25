Return-Path: <linux-kernel+bounces-229314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57074916E38
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 18:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 944DDB26668
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 16:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009D2173342;
	Tue, 25 Jun 2024 16:37:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 760F713B2B0
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 16:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719333426; cv=none; b=cRYygCWCwMoJp23OIX8GVQte4IugdSOtW17h47qTylgZEoxE5dvaCUJ++wDTgoEO1Dt9XKaTpt3njWaw+OocLJV2+//Ghkmh5C0MpANeb81502iE3CiI7L6f592m0j4iUkIr2pzbxncD6zsz0kVeSDCpLVsTpPhWLZNOAYfCbeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719333426; c=relaxed/simple;
	bh=Y1dqCGIz5xerw9PBkurDkELOjQn0JSvxFlpNIxR0Obs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpnNFwxpjxha6etGaBunJpPutc+S704XYKb/eZIeoaXraFhBKGGeCBTJtrFN17tEiIMD61OHqIsnoAUI0oOGc/O8XrZzlXRked1SVuwOM0omm9i1n0M18NKMEJ8xHUl9TgzVF9wKK8D+9Gb5MIRKgCP2UNmOMlyHaNi89oNcKu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56F27339;
	Tue, 25 Jun 2024 09:37:27 -0700 (PDT)
Received: from [10.1.39.170] (XHFQ2J9959.cambridge.arm.com [10.1.39.170])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F336E3F766;
	Tue, 25 Jun 2024 09:37:00 -0700 (PDT)
Message-ID: <7bf7437a-b0a5-4522-88ce-11e6db79a527@arm.com>
Date: Tue, 25 Jun 2024 17:36:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/5] Alternative mTHP swap allocator improvements
Content-Language: en-GB
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Kairui Song <kasong@tencent.com>, "Huang, Ying" <ying.huang@intel.com>,
 Kalesh Singh <kaleshsingh@google.com>, Barry Song <baohua@kernel.org>,
 Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240618232648.4090299-1-ryan.roberts@arm.com>
 <1cb60685-3c34-4441-81e1-a60adc70d1f2@arm.com>
 <CANeU7Qnmh6+7CSO3pTvTiJ6_4jA=+h2_KDtYz-Yx3pfT5-snyg@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CANeU7Qnmh6+7CSO3pTvTiJ6_4jA=+h2_KDtYz-Yx3pfT5-snyg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/06/2024 17:06, Chris Li wrote:
> On Tue, Jun 25, 2024 at 1:02 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 19/06/2024 00:26, Ryan Roberts wrote:
>>> Hi All,
>>>
>>> Chris has been doing great work at [1] to clean up my mess in the mTHP swap
>>> entry allocator. But Barry posted a test program and results at [2] showing that
>>> even with Chris's changes, there are still some fallbacks (around 5% - 25% in
>>> some cases). I was interested in why that might be and ended up putting this PoC
>>> patch set together to try to get a better understanding. This series ends up
>>> achieving 0% fallback, even with small folios ("-s") enabled. I haven't done
>>> much testing beyond that (yet) but thought it was worth posting on the strength
>>> of that result alone.
>>>
>>> At a high level this works in a similar way to Chris's series; it marks a
>>> cluster as being for a particular order and if a new cluster cannot be allocated
>>> then it scans through the existing non-full clusters. But it does it by scanning
>>> through the clusters rather than assembling them into a list. Cluster flags are
>>> used to mark clusters that have been scanned and are known not to have enough
>>> contiguous space, so the efficiency should be similar in practice.
>>>
>>> Because its not based around a linked list, there is less churn and I'm
>>> wondering if this is perhaps easier to review and potentially even get into
>>> v6.10-rcX to fix up what's already there, rather than having to wait until v6.11
>>> for Chris's series? I know Chris has a larger roadmap of improvements, so at
>>> best I see this as a tactical fix that will ultimately be superseeded by Chris's
>>> work.
>>>
>>> There are a few differences to note vs Chris's series:
>>>
>>> - order-0 fallback scanning is still allowed in any cluster; the argument in the
>>>   past was that swap should always use all the swap space, so I've left this
>>>   mechanism in. It is only a fallback though; first the the new per-order
>>>   scanner is invoked, even for order-0, so if there are free slots in clusters
>>>   already assigned for order-0, then the allocation will go there.
>>>
>>> - CPUs can steal slots from other CPU's current clusters; those clusters remain
>>>   scannable while they are current for a CPU and are only made unscannable when
>>>   no more CPUs are scanning that particular cluster.
>>>
>>> - I'm preferring to allocate a free cluster ahead of per-order scanning, since,
>>>   as I understand it, the original intent of a per-cpu current cluster was to
>>>   get pages for an application adjacent in the swap to speed up IO.
>>
>> [...]
>>
>> I've been having a play, trying to extend this to actively free swap entries to make sufficient space for a new allcoation if the entries are already in swap cache. (To be clear, I'm not pursuing this series for inclusion, but was just trying to put some numbers to the idea, which could later be added to Chris's series if it makes sense).
>>
>> However, I'm running into an unexpected issue; It was my previous understanding that if the swap map for an entry is SWAP_HAS_CACHE, then there is a folio in the swap cache and nothing is referencing the swap entry, so the entry can be freed with __try_to_reclaim_swap() - that's the pattern that the existing oder-0 scanner uses.
>>
>> But I'm finding that __try_to_reclaim_swap() always returns 0, indicating that no folio was associated with the swap entry. How can that be, if swap_map[offset] == SWAP_HAS_CACHE ?
> 
> I saw that in my test too. Some swap entries remain as SWAP_HAS_CACHE
> which contribute to the swap allocation failure rate.
> 
> One possibility is that the zram is hitting the synchronous IO case
> for swap in, it does not put the folio in swap cache when serving the
> swap in. In commit 13ddaf26be324a7f951891ecd9ccd04466d27458 from
> Kairui, the SWAP_HAS_CACHE flag was added for synchronous IO, in order
> to address a race in the swap in. But the SWAP_HAS_CACHE should be
> cleaned up after swap in fault though. I did not have a chance to dig
> deeper into the root cause of those SWAP_HAS_CACHE entries yet.

Oh wait, I think they are probably in the swap slot cache waiting to be freed.
Once the count goes to 0 (inc SWAP_HAS_CACHE), __swap_entry_free_locked
temporarily adds SWAP_HAS_CACHE back in, and free_swap_slot() is called. The
entry is buffered in that layer until the buffer is full and they are all
flushed together. So should be able to trigger that flush to free some slots.

> 
> Chris
> 
>>
>> Here is my code, for reference. Note that "evict" is always set true to be very agressive for now, but the eventual idea is that it would only be set to true when certain criteria are met (e.g. last attempt to allocate for order either failed or had to evict to succeed).
>>
>> With logging added, every single call to __try_to_reclaim_swap() returns 0. (well it also live locks due to that with code as shown, but I hacked around that in experiments). Any ideas, before I dig deeper?
>>
>>
>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> index f6d78723f0fd..928d61e1d9d5 100644
>> --- a/mm/swapfile.c
>> +++ b/mm/swapfile.c
>> @@ -641,13 +641,25 @@ scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
>>  }
>>
>>  static inline bool swap_range_empty(char *swap_map, unsigned int start,
>> -                                   unsigned int nr_pages)
>> +                                   unsigned int nr_pages, bool *inc_cached)
>>  {
>>         unsigned int i;
>> -
>> -       for (i = 0; i < nr_pages; i++) {
>> -               if (swap_map[start + i])
>> -                       return false;
>> +       bool hit_cache = false;
>> +
>> +       if (*inc_cached) {
>> +               for (i = 0; i < nr_pages; i++) {
>> +                       if (swap_map[start + i]) {
>> +                               if (swap_map[start + i] != SWAP_HAS_CACHE)
>> +                                       return false;
>> +                               hit_cache = true;
>> +                       }
>> +               }
>> +               *inc_cached = hit_cache;
>> +       } else {
>> +               for (i = 0; i < nr_pages; i++) {
>> +                       if (swap_map[start + i])
>> +                               return false;
>> +               }
>>         }
>>
>>         return true;
>> @@ -760,6 +772,7 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>>         struct swap_cluster_info *ci;
>>         unsigned int tmp, max;
>>         unsigned int stop = SWAP_NEXT_INVALID;
>> +       bool evict = true;
>>
>>  new_cluster:
>>         cluster = this_cpu_ptr(si->percpu_cluster);
>> @@ -799,18 +812,48 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>>          * natural alignment.
>>          */
>>         max = ALIGN(tmp + 1, SWAPFILE_CLUSTER);
>> -       ci = lock_cluster(si, tmp);
>> -       while (tmp < max) {
>> -               if (swap_range_empty(si->swap_map, tmp, nr_pages))
>> -                       break;
>> -               tmp += nr_pages;
>> +scan_cluster:
>> +       if (tmp < max) {
>> +               ci = lock_cluster(si, tmp);
>> +               while (tmp < max) {
>> +                       if (swap_range_empty(si->swap_map, tmp, nr_pages, &evict))
>> +                               break;
>> +                       tmp += nr_pages;
>> +               }
>> +               unlock_cluster(ci);
>>         }
>> -       unlock_cluster(ci);
>>         if (tmp >= max) {
>>                 cluster_dec_scanners(ci);
>>                 cluster->next[order] = SWAP_NEXT_INVALID;
>>                 goto new_cluster;
>>         }
>> +       if (evict) {
>> +               unsigned int off;
>> +               int nr;
>> +
>> +               spin_unlock(&si->lock);
>> +
>> +               for (off = tmp; off < tmp + nr_pages; off += nr) {
>> +                       nr = 1;
>> +                       if (READ_ONCE(si->swap_map[off]) == SWAP_HAS_CACHE) {
>> +                               nr = __try_to_reclaim_swap(si, off, TTRS_ANYWAY);
>> +                               if (nr < 0)
>> +                                       break;
>> +                               else if (nr == 0)
>> +                                       nr = 1;
>> +                               nr = ALIGN(off + 1, nr) - off;
>> +                       }
>> +               }
>> +
>> +               spin_lock(&si->lock);
>> +               *scan_base = this_cpu_read(*si->cluster_next_cpu);
>> +               *offset = *scan_base;
>> +
>> +               if (nr < 0)
>> +                       tmp += nr_pages;
>> +
>> +               goto scan_cluster;
>> +       }
>>         *offset = tmp;
>>         *scan_base = tmp;
>>         tmp += nr_pages;
>>
>>


