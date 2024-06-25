Return-Path: <linux-kernel+bounces-228487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63570916096
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 10:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D819B20E21
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 08:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2D3146D6C;
	Tue, 25 Jun 2024 08:02:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E85C145FE8
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 08:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719302569; cv=none; b=j+5hqHrMMs10EPyofECgsSn7pBevWjJm7ig5hQWcNP2ns2p+jlVL3IuzmjA4QWFGHf6MjsHp4y6z9x4yPFnFl/QMuqWV8/3FPacg/wkrspopwHLze/bjMOdN9uI9+0pFToLO3PZ3HdcAHTImRYzjqHx3psjbieWMcm8NI5l68pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719302569; c=relaxed/simple;
	bh=UytvqOabhaGLpGa8QiaLZTx36kz60k54AUlZ1bFICE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b3qe1UWjedCkM50AhraR2WmePt7IIvcuuWlrpFUtfhO/tx4dcZ9z5IdmcS7Foy3ciAMzq35hrXdNSUfW6teyaYZzvufzC8dBPEtGYfN9U7aLHn8lmhhiGkFNNCDbXbsnTEizFnSo9wfgUGmLkYC3ruq4x5rPaiNi+1Wj0I8U9c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AB5D339;
	Tue, 25 Jun 2024 01:03:09 -0700 (PDT)
Received: from [10.57.74.104] (unknown [10.57.74.104])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E7FC3F6A8;
	Tue, 25 Jun 2024 01:02:43 -0700 (PDT)
Message-ID: <1cb60685-3c34-4441-81e1-a60adc70d1f2@arm.com>
Date: Tue, 25 Jun 2024 09:02:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 0/5] Alternative mTHP swap allocator improvements
Content-Language: en-GB
To: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, "Huang, Ying" <ying.huang@intel.com>,
 Kalesh Singh <kaleshsingh@google.com>, Barry Song <baohua@kernel.org>,
 Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240618232648.4090299-1-ryan.roberts@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240618232648.4090299-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/06/2024 00:26, Ryan Roberts wrote:
> Hi All,
> 
> Chris has been doing great work at [1] to clean up my mess in the mTHP swap
> entry allocator. But Barry posted a test program and results at [2] showing that
> even with Chris's changes, there are still some fallbacks (around 5% - 25% in
> some cases). I was interested in why that might be and ended up putting this PoC
> patch set together to try to get a better understanding. This series ends up
> achieving 0% fallback, even with small folios ("-s") enabled. I haven't done
> much testing beyond that (yet) but thought it was worth posting on the strength
> of that result alone.
> 
> At a high level this works in a similar way to Chris's series; it marks a
> cluster as being for a particular order and if a new cluster cannot be allocated
> then it scans through the existing non-full clusters. But it does it by scanning
> through the clusters rather than assembling them into a list. Cluster flags are
> used to mark clusters that have been scanned and are known not to have enough
> contiguous space, so the efficiency should be similar in practice.
> 
> Because its not based around a linked list, there is less churn and I'm
> wondering if this is perhaps easier to review and potentially even get into
> v6.10-rcX to fix up what's already there, rather than having to wait until v6.11
> for Chris's series? I know Chris has a larger roadmap of improvements, so at
> best I see this as a tactical fix that will ultimately be superseeded by Chris's
> work.
> 
> There are a few differences to note vs Chris's series:
> 
> - order-0 fallback scanning is still allowed in any cluster; the argument in the
>   past was that swap should always use all the swap space, so I've left this
>   mechanism in. It is only a fallback though; first the the new per-order
>   scanner is invoked, even for order-0, so if there are free slots in clusters
>   already assigned for order-0, then the allocation will go there.
> 
> - CPUs can steal slots from other CPU's current clusters; those clusters remain
>   scannable while they are current for a CPU and are only made unscannable when
>   no more CPUs are scanning that particular cluster.
> 
> - I'm preferring to allocate a free cluster ahead of per-order scanning, since,
>   as I understand it, the original intent of a per-cpu current cluster was to
>   get pages for an application adjacent in the swap to speed up IO.

[...]

I've been having a play, trying to extend this to actively free swap entries to make sufficient space for a new allcoation if the entries are already in swap cache. (To be clear, I'm not pursuing this series for inclusion, but was just trying to put some numbers to the idea, which could later be added to Chris's series if it makes sense).

However, I'm running into an unexpected issue; It was my previous understanding that if the swap map for an entry is SWAP_HAS_CACHE, then there is a folio in the swap cache and nothing is referencing the swap entry, so the entry can be freed with __try_to_reclaim_swap() - that's the pattern that the existing oder-0 scanner uses.

But I'm finding that __try_to_reclaim_swap() always returns 0, indicating that no folio was associated with the swap entry. How can that be, if swap_map[offset] == SWAP_HAS_CACHE ?

Here is my code, for reference. Note that "evict" is always set true to be very agressive for now, but the eventual idea is that it would only be set to true when certain criteria are met (e.g. last attempt to allocate for order either failed or had to evict to succeed). 

With logging added, every single call to __try_to_reclaim_swap() returns 0. (well it also live locks due to that with code as shown, but I hacked around that in experiments). Any ideas, before I dig deeper?


diff --git a/mm/swapfile.c b/mm/swapfile.c
index f6d78723f0fd..928d61e1d9d5 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -641,13 +641,25 @@ scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
 }
 
 static inline bool swap_range_empty(char *swap_map, unsigned int start,
-                                   unsigned int nr_pages)
+                                   unsigned int nr_pages, bool *inc_cached)
 {
        unsigned int i;
-
-       for (i = 0; i < nr_pages; i++) {
-               if (swap_map[start + i])
-                       return false;
+       bool hit_cache = false;
+
+       if (*inc_cached) {
+               for (i = 0; i < nr_pages; i++) {
+                       if (swap_map[start + i]) {
+                               if (swap_map[start + i] != SWAP_HAS_CACHE)
+                                       return false;
+                               hit_cache = true;
+                       }
+               }
+               *inc_cached = hit_cache;
+       } else {
+               for (i = 0; i < nr_pages; i++) {
+                       if (swap_map[start + i])
+                               return false;
+               }
        }
 
        return true;
@@ -760,6 +772,7 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
        struct swap_cluster_info *ci;
        unsigned int tmp, max;
        unsigned int stop = SWAP_NEXT_INVALID;
+       bool evict = true;
 
 new_cluster:
        cluster = this_cpu_ptr(si->percpu_cluster);
@@ -799,18 +812,48 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
         * natural alignment.
         */
        max = ALIGN(tmp + 1, SWAPFILE_CLUSTER);
-       ci = lock_cluster(si, tmp);
-       while (tmp < max) {
-               if (swap_range_empty(si->swap_map, tmp, nr_pages))
-                       break;
-               tmp += nr_pages;
+scan_cluster:
+       if (tmp < max) {
+               ci = lock_cluster(si, tmp);
+               while (tmp < max) {
+                       if (swap_range_empty(si->swap_map, tmp, nr_pages, &evict))
+                               break;
+                       tmp += nr_pages;
+               }
+               unlock_cluster(ci);
        }
-       unlock_cluster(ci);
        if (tmp >= max) {
                cluster_dec_scanners(ci);
                cluster->next[order] = SWAP_NEXT_INVALID;
                goto new_cluster;
        }
+       if (evict) {
+               unsigned int off;
+               int nr;
+
+               spin_unlock(&si->lock);
+
+               for (off = tmp; off < tmp + nr_pages; off += nr) {
+                       nr = 1;
+                       if (READ_ONCE(si->swap_map[off]) == SWAP_HAS_CACHE) {
+                               nr = __try_to_reclaim_swap(si, off, TTRS_ANYWAY);
+                               if (nr < 0)
+                                       break;
+                               else if (nr == 0)
+                                       nr = 1;
+                               nr = ALIGN(off + 1, nr) - off;
+                       }
+               }
+
+               spin_lock(&si->lock);
+               *scan_base = this_cpu_read(*si->cluster_next_cpu);
+               *offset = *scan_base;
+
+               if (nr < 0)
+                       tmp += nr_pages;
+
+               goto scan_cluster;
+       }
        *offset = tmp;
        *scan_base = tmp;
        tmp += nr_pages;



