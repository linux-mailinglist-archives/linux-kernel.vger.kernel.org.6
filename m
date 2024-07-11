Return-Path: <linux-kernel+bounces-248698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D6192E0D5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C0E1F22641
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A167E14E2D8;
	Thu, 11 Jul 2024 07:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKzIb9QW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5015614B978
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 07:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720682962; cv=none; b=kn6Bi+4z6HJuZEBY3k7Ver0D9rN+hMuJeGgNRMhyC3I6GMjeOUXATdJu1FyAERI3AATatrCL/CATV80U3JL9TB+qwAq1SuXAZX+zP7IhAuHLaohN2Ra016TBhyWNkZevT62tALE5Ydtx5Po/Z//WGx7XVNRo7LyH5Con2NxGx38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720682962; c=relaxed/simple;
	bh=J8FHwdhxltN0qeCWTQ9ab5ob3eCGGqwb0L98++XBWds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WorAylRtwXx/TsrNnbnHGNiPBCTWjsH6xKf7q24lbeC+q1+/yY76C9uWYpMSUkxisavtta8lzMasSBt1Y7Qi0XU5gTu7+acEQGXXcNCZn9G272Gu259wJduSOo6VpacisVXA83K2o5dcPthpJOowfO4J87IRazoVPTpT0HyGigE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKzIb9QW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB43C32782;
	Thu, 11 Jul 2024 07:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720682961;
	bh=J8FHwdhxltN0qeCWTQ9ab5ob3eCGGqwb0L98++XBWds=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RKzIb9QWrld3pBFgu1zmeH8UGMrXIJu9UXtR34ZI/3euR0R5rYfXeFdgNRQ78Rkki
	 8CjdagylbLSKsVDQuP0iBsEDiUL0g0ew/v4z3jVh2NtbksAFCzv1KIrsP3a9ynLvrq
	 ERc4Xra0gSExAT2XmxWonKjbMFx5FvNPs2OwiXj1qel/P+qSfIHJqDSBBgxzVFM+oZ
	 FlP3DNOtqDl8hH2cGTwYYeRbEtMpTs84Hh9LxvZ9IQGkOLANCCmefE0nLe5dCtiSma
	 WSywXv8veB4zsB6vHHkWSVYeyqU4CnxtV/mXPnjUmWIwPo9ql4GEF63Rl/gQTIwixw
	 0ciOSieokvGjw==
From: Chris Li <chrisl@kernel.org>
Date: Thu, 11 Jul 2024 00:29:07 -0700
Subject: [PATCH v4 3/3] RFC: mm: swap: seperate SSD allocation from
 scan_swap_map_slots()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-swap-allocator-v4-3-0295a4d4c7aa@kernel.org>
References: <20240711-swap-allocator-v4-0-0295a4d4c7aa@kernel.org>
In-Reply-To: <20240711-swap-allocator-v4-0-0295a4d4c7aa@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <kasong@tencent.com>, Hugh Dickins <hughd@google.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
 Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Chris Li <chrisl@kernel.org>, 
 Barry Song <baohua@kernel.org>
X-Mailer: b4 0.13.0

Previously the SSD and HDD share the same swap_map scan loop in
scan_swap_map_slots(). This function is complex and hard to flow
the execution flow.

scan_swap_map_try_ssd_cluster() can already do most of the heavy
lifting to locate the candidate swap range in the cluster. However
it needs to go back to scan_swap_map_slots() to check conflict
and then perform the allocation.

When scan_swap_map_try_ssd_cluster() failed, it still depended on
the scan_swap_map_slots() to do brute force scanning of the swap_map.
When the swapfile is large and almost full, it will take some CPU
time to go through the swap_map array.

Get rid of the cluster allocation dependency on the swap_map scan
loop in scan_swap_map_slots(). Streamline the cluster allocation
code path.  No more conflict checks.

For order 0 swap entry, when run out of free and nonfull list.
It will allocate from the higher order nonfull cluster list.

Users should see less CPU time spent on searching the free swap
slot when swapfile is almost full.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 mm/swapfile.c | 297 ++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 166 insertions(+), 131 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index e13a33664cfa..b967e628ae65 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -53,6 +53,8 @@
 static bool swap_count_continued(struct swap_info_struct *, pgoff_t,
 				 unsigned char);
 static void free_swap_count_continuations(struct swap_info_struct *);
+static void swap_range_alloc(struct swap_info_struct *si, unsigned long offset,
+			     unsigned int nr_entries);
 
 static DEFINE_SPINLOCK(swap_lock);
 static unsigned int nr_swapfiles;
@@ -301,6 +303,12 @@ static inline unsigned int cluster_index(struct swap_info_struct *si,
 	return ci - si->cluster_info;
 }
 
+static inline unsigned int cluster_offset(struct swap_info_struct *si,
+					  struct swap_cluster_info *ci)
+{
+	return cluster_index(si, ci) * SWAPFILE_CLUSTER;
+}
+
 static inline struct swap_cluster_info *lock_cluster(struct swap_info_struct *si,
 						     unsigned long offset)
 {
@@ -371,11 +379,15 @@ static void swap_cluster_schedule_discard(struct swap_info_struct *si,
 
 static void __free_cluster(struct swap_info_struct *si, struct swap_cluster_info *ci)
 {
+	VM_BUG_ON(!spin_is_locked(&si->lock));
+	VM_BUG_ON(!spin_is_locked(&ci->lock));
+
 	if (ci->flags & CLUSTER_FLAG_NONFULL)
 		list_move_tail(&ci->list, &si->free_clusters);
 	else
 		list_add_tail(&ci->list, &si->free_clusters);
 	ci->flags = CLUSTER_FLAG_FREE;
+	ci->order = 0;
 }
 
 /*
@@ -430,8 +442,10 @@ static struct swap_cluster_info *alloc_cluster(struct swap_info_struct *si, unsi
 	struct swap_cluster_info *ci = list_first_entry(&si->free_clusters, struct swap_cluster_info, list);
 
 	VM_BUG_ON(cluster_index(si, ci) != idx);
+	VM_BUG_ON(!spin_is_locked(&si->lock));
+	VM_BUG_ON(!spin_is_locked(&ci->lock));
+	VM_BUG_ON(ci->count);
 	list_del(&ci->list);
-	ci->count = 0;
 	ci->flags = 0;
 	return ci;
 }
@@ -439,6 +453,8 @@ static struct swap_cluster_info *alloc_cluster(struct swap_info_struct *si, unsi
 static void free_cluster(struct swap_info_struct *si, struct swap_cluster_info *ci)
 {
 	VM_BUG_ON(ci->count != 0);
+	VM_BUG_ON(!spin_is_locked(&si->lock));
+	VM_BUG_ON(!spin_is_locked(&ci->lock));
 	/*
 	 * If the swap is discardable, prepare discard the cluster
 	 * instead of free it immediately. The cluster will be freed
@@ -495,52 +511,96 @@ static void dec_cluster_info_page(struct swap_info_struct *p, struct swap_cluste
 		return;
 
 	VM_BUG_ON(ci->count == 0);
+	VM_BUG_ON(cluster_is_free(ci));
+	VM_BUG_ON(!spin_is_locked(&p->lock));
+	VM_BUG_ON(!spin_is_locked(&ci->lock));
 	ci->count--;
 
 	if (!ci->count)
 		return free_cluster(p, ci);
 
 	if (!(ci->flags & CLUSTER_FLAG_NONFULL)) {
+		VM_BUG_ON(ci->flags & CLUSTER_FLAG_FREE);
 		list_add_tail(&ci->list, &p->nonfull_clusters[ci->order]);
-		ci->flags |= CLUSTER_FLAG_NONFULL;
+		ci->flags = CLUSTER_FLAG_NONFULL;
 	}
 }
 
-/*
- * It's possible scan_swap_map_slots() uses a free cluster in the middle of free
- * cluster list. Avoiding such abuse to avoid list corruption.
- */
-static bool
-scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
-	unsigned long offset, int order)
-{
-	struct percpu_cluster *percpu_cluster;
-	bool conflict;
-	struct swap_cluster_info *first = list_first_entry(&si->free_clusters, struct swap_cluster_info, list);
-	offset /= SWAPFILE_CLUSTER;
-	conflict = !list_empty(&si->free_clusters) &&
-		offset !=  first - si->cluster_info &&
-		cluster_is_free(&si->cluster_info[offset]);
-
-	if (!conflict)
-		return false;
+static inline bool cluster_scan_range(struct swap_info_struct *si, unsigned int start,
+				      unsigned int nr_pages)
+{
+	unsigned char *p = si->swap_map + start;
+	unsigned char *end = p + nr_pages;
+
+	while (p < end)
+		if (*p++)
+			return false;
 
-	percpu_cluster = this_cpu_ptr(si->percpu_cluster);
-	percpu_cluster->next[order] = SWAP_NEXT_INVALID;
 	return true;
 }
 
-static inline bool swap_range_empty(char *swap_map, unsigned int start,
-				    unsigned int nr_pages)
+
+static inline void cluster_alloc_range(struct swap_info_struct *si, struct swap_cluster_info *ci,
+						unsigned int start, unsigned char usage,
+						unsigned int order)
 {
-	unsigned int i;
+	unsigned int nr_pages = 1 << order;
 
-	for (i = 0; i < nr_pages; i++) {
-		if (swap_map[start + i])
-			return false;
+	if (cluster_is_free(ci)) {
+		if (nr_pages < SWAPFILE_CLUSTER) {
+			list_move_tail(&ci->list, &si->nonfull_clusters[order]);
+			ci->flags = CLUSTER_FLAG_NONFULL;
+		}
+		ci->order = order;
 	}
 
-	return true;
+	memset(si->swap_map + start, usage, nr_pages);
+	swap_range_alloc(si, start, nr_pages);
+	ci->count += nr_pages;
+
+	if (ci->count == SWAPFILE_CLUSTER) {
+		VM_BUG_ON(!(ci->flags & (CLUSTER_FLAG_FREE | CLUSTER_FLAG_NONFULL)));
+		list_del(&ci->list);
+		ci->flags = 0;
+	}
+}
+
+static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si, unsigned long offset, unsigned int *foundp,
+					    unsigned int order, unsigned char usage)
+{
+	unsigned long start = offset & ~(SWAPFILE_CLUSTER - 1);
+	unsigned long end = min(start + SWAPFILE_CLUSTER, si->max);
+	unsigned int nr_pages = 1 << order;
+	struct swap_cluster_info *ci;
+
+	if (end < nr_pages)
+		return SWAP_NEXT_INVALID;
+	end -= nr_pages;
+
+	ci = lock_cluster(si, offset);
+	if (ci->count + nr_pages > SWAPFILE_CLUSTER) {
+		offset = SWAP_NEXT_INVALID;
+		goto done;
+	}
+
+	while (offset <= end) {
+		if (cluster_scan_range(si, offset, nr_pages)) {
+			cluster_alloc_range(si, ci, offset, usage, order);
+			*foundp = offset;
+			if (ci->count == SWAPFILE_CLUSTER) {
+				offset = SWAP_NEXT_INVALID;
+				goto done;
+			}
+			offset += nr_pages;
+			break;
+		}
+		offset += nr_pages;
+	}
+	if (offset > end)
+		offset = SWAP_NEXT_INVALID;
+done:
+	unlock_cluster(ci);
+	return offset;
 }
 
 /*
@@ -548,71 +608,63 @@ static inline bool swap_range_empty(char *swap_map, unsigned int start,
  * pool (a cluster). This might involve allocating a new cluster for current CPU
  * too.
  */
-static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
-	unsigned long *offset, unsigned long *scan_base, int order)
+static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int order, unsigned char usage)
 {
-	unsigned int nr_pages = 1 << order;
 	struct percpu_cluster *cluster;
-	struct swap_cluster_info *ci;
-	unsigned int tmp, max;
+	struct swap_cluster_info *ci, *n;
+	unsigned int offset, found = 0;
 
 new_cluster:
+	VM_BUG_ON(!spin_is_locked(&si->lock));
 	cluster = this_cpu_ptr(si->percpu_cluster);
-	tmp = cluster->next[order];
-	if (tmp == SWAP_NEXT_INVALID) {
-		if (!list_empty(&si->free_clusters)) {
-			ci = list_first_entry(&si->free_clusters, struct swap_cluster_info, list);
-			list_del(&ci->list);
-			spin_lock(&ci->lock);
-			ci->order = order;
-			ci->flags = 0;
-			spin_unlock(&ci->lock);
-			tmp = cluster_index(si, ci) * SWAPFILE_CLUSTER;
-		} else if (!list_empty(&si->nonfull_clusters[order])) {
-			ci = list_first_entry(&si->nonfull_clusters[order], struct swap_cluster_info, list);
-			list_del(&ci->list);
-			spin_lock(&ci->lock);
-			ci->flags = 0;
-			spin_unlock(&ci->lock);
-			tmp = cluster_index(si, ci) * SWAPFILE_CLUSTER;
-		} else if (!list_empty(&si->discard_clusters)) {
-			/*
-			 * we don't have free cluster but have some clusters in
-			 * discarding, do discard now and reclaim them, then
-			 * reread cluster_next_cpu since we dropped si->lock
-			 */
-			swap_do_scheduled_discard(si);
-			*scan_base = this_cpu_read(*si->cluster_next_cpu);
-			*offset = *scan_base;
-			goto new_cluster;
-		} else
-			return false;
+	offset = cluster->next[order];
+	if (offset) {
+		offset = alloc_swap_scan_cluster(si, offset, &found, order, usage);
+		if (found)
+			goto done;
 	}
 
-	/*
-	 * Other CPUs can use our cluster if they can't find a free cluster,
-	 * check if there is still free entry in the cluster, maintaining
-	 * natural alignment.
-	 */
-	max = min_t(unsigned long, si->max, ALIGN(tmp + 1, SWAPFILE_CLUSTER));
-	if (tmp < max) {
-		ci = lock_cluster(si, tmp);
-		while (tmp < max) {
-			if (swap_range_empty(si->swap_map, tmp, nr_pages))
-				break;
-			tmp += nr_pages;
+	list_for_each_entry_safe(ci, n, &si->free_clusters, list) {
+		offset = alloc_swap_scan_cluster(si, cluster_offset(si, ci), &found, order, usage);
+		if (found)
+			goto done;
+		VM_BUG_ON(1);
+	}
+
+	if (order < PMD_ORDER) {
+		list_for_each_entry_safe(ci, n, &si->nonfull_clusters[order], list) {
+			offset = alloc_swap_scan_cluster(si, cluster_offset(si, ci), &found, order, usage);
+			if (found)
+				goto done;
 		}
-		unlock_cluster(ci);
 	}
-	if (tmp >= max) {
-		cluster->next[order] = SWAP_NEXT_INVALID;
+
+	if (!list_empty(&si->discard_clusters)) {
+		/*
+		 * we don't have free cluster but have some clusters in
+		 * discarding, do discard now and reclaim them, then
+		 * reread cluster_next_cpu since we dropped si->lock
+		 */
+		swap_do_scheduled_discard(si);
 		goto new_cluster;
 	}
-	*offset = tmp;
-	*scan_base = tmp;
-	tmp += nr_pages;
-	cluster->next[order] = tmp < max ? tmp : SWAP_NEXT_INVALID;
-	return true;
+
+	if (order)
+		goto done;
+
+	for (int o = order + 1; o < SWAP_NR_ORDERS; o++) {
+		struct swap_cluster_info *ci, *n;
+
+		list_for_each_entry_safe(ci, n, &si->nonfull_clusters[o], list) {
+			offset = alloc_swap_scan_cluster(si, cluster_offset(si, ci), &found, order, usage);
+			if (found)
+				goto done;
+		}
+	}
+
+done:
+	cluster->next[order] = offset;
+	return found;
 }
 
 static void __del_from_avail_list(struct swap_info_struct *p)
@@ -747,11 +799,29 @@ static bool swap_offset_available_and_locked(struct swap_info_struct *si,
 	return false;
 }
 
+static int cluster_alloc_swap(struct swap_info_struct *si,
+			     unsigned char usage, int nr,
+			     swp_entry_t slots[], int order)
+{
+	int n_ret = 0;
+
+	VM_BUG_ON(!si->cluster_info);
+
+	while (n_ret < nr) {
+		unsigned long offset = cluster_alloc_swap_entry(si, order, usage);
+
+		if (!offset)
+			break;
+		slots[n_ret++] = swp_entry(si->type, offset);
+	}
+
+	return n_ret;
+}
+
 static int scan_swap_map_slots(struct swap_info_struct *si,
 			       unsigned char usage, int nr,
 			       swp_entry_t slots[], int order)
 {
-	struct swap_cluster_info *ci;
 	unsigned long offset;
 	unsigned long scan_base;
 	unsigned long last_in_cluster = 0;
@@ -790,26 +860,16 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 			return 0;
 	}
 
+	if (si->cluster_info)
+		return cluster_alloc_swap(si, usage, nr, slots, order);
+
 	si->flags += SWP_SCANNING;
-	/*
-	 * Use percpu scan base for SSD to reduce lock contention on
-	 * cluster and swap cache.  For HDD, sequential access is more
-	 * important.
-	 */
-	if (si->flags & SWP_SOLIDSTATE)
-		scan_base = this_cpu_read(*si->cluster_next_cpu);
-	else
-		scan_base = si->cluster_next;
+
+	/* For HDD, sequential access is more important. */
+	scan_base = si->cluster_next;
 	offset = scan_base;
 
-	/* SSD algorithm */
-	if (si->cluster_info) {
-		if (!scan_swap_map_try_ssd_cluster(si, &offset, &scan_base, order)) {
-			if (order > 0)
-				goto no_page;
-			goto scan;
-		}
-	} else if (unlikely(!si->cluster_nr--)) {
+	if (unlikely(!si->cluster_nr--)) {
 		if (si->pages - si->inuse_pages < SWAPFILE_CLUSTER) {
 			si->cluster_nr = SWAPFILE_CLUSTER - 1;
 			goto checks;
@@ -820,8 +880,6 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 		/*
 		 * If seek is expensive, start searching for new cluster from
 		 * start of partition, to minimize the span of allocated swap.
-		 * If seek is cheap, that is the SWP_SOLIDSTATE si->cluster_info
-		 * case, just handled by scan_swap_map_try_ssd_cluster() above.
 		 */
 		scan_base = offset = si->lowest_bit;
 		last_in_cluster = offset + SWAPFILE_CLUSTER - 1;
@@ -849,19 +907,6 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 	}
 
 checks:
-	if (si->cluster_info) {
-		while (scan_swap_map_ssd_cluster_conflict(si, offset, order)) {
-		/* take a break if we already got some slots */
-			if (n_ret)
-				goto done;
-			if (!scan_swap_map_try_ssd_cluster(si, &offset,
-							&scan_base, order)) {
-				if (order > 0)
-					goto no_page;
-				goto scan;
-			}
-		}
-	}
 	if (!(si->flags & SWP_WRITEOK))
 		goto no_page;
 	if (!si->highest_bit)
@@ -869,11 +914,9 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 	if (offset > si->highest_bit)
 		scan_base = offset = si->lowest_bit;
 
-	ci = lock_cluster(si, offset);
 	/* reuse swap entry of cache-only swap if not busy. */
 	if (vm_swap_full() && si->swap_map[offset] == SWAP_HAS_CACHE) {
 		int swap_was_freed;
-		unlock_cluster(ci);
 		spin_unlock(&si->lock);
 		swap_was_freed = __try_to_reclaim_swap(si, offset, TTRS_ANYWAY);
 		spin_lock(&si->lock);
@@ -884,15 +927,12 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 	}
 
 	if (si->swap_map[offset]) {
-		unlock_cluster(ci);
 		if (!n_ret)
 			goto scan;
 		else
 			goto done;
 	}
 	memset(si->swap_map + offset, usage, nr_pages);
-	add_cluster_info_page(si, si->cluster_info, offset, nr_pages);
-	unlock_cluster(ci);
 
 	swap_range_alloc(si, offset, nr_pages);
 	slots[n_ret++] = swp_entry(si->type, offset);
@@ -913,13 +953,7 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 		latency_ration = LATENCY_LIMIT;
 	}
 
-	/* try to get more slots in cluster */
-	if (si->cluster_info) {
-		if (scan_swap_map_try_ssd_cluster(si, &offset, &scan_base, order))
-			goto checks;
-		if (order > 0)
-			goto done;
-	} else if (si->cluster_nr && !si->swap_map[++offset]) {
+	if (si->cluster_nr && !si->swap_map[++offset]) {
 		/* non-ssd case, still more slots in cluster? */
 		--si->cluster_nr;
 		goto checks;
@@ -988,8 +1022,6 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
 	ci = lock_cluster(si, offset);
 	memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
 	ci->count = 0;
-	ci->order = 0;
-	ci->flags = 0;
 	free_cluster(si, ci);
 	unlock_cluster(ci);
 	swap_range_free(si, offset, SWAPFILE_CLUSTER);
@@ -3001,8 +3033,11 @@ static int setup_swap_map_and_extents(struct swap_info_struct *p,
 			ci = cluster_info + idx;
 			if (idx >= nr_clusters)
 				continue;
-			if (ci->count)
+			if (ci->count) {
+				ci->flags = CLUSTER_FLAG_NONFULL;
+				list_add_tail(&ci->list, &p->nonfull_clusters[0]);
 				continue;
+			}
 			ci->flags = CLUSTER_FLAG_FREE;
 			list_add_tail(&ci->list, &p->free_clusters);
 		}

-- 
2.45.2.803.g4e1b14247a-goog


