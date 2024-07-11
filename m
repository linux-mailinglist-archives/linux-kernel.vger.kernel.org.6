Return-Path: <linux-kernel+bounces-248696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F4B92E0D4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 09:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E9551F224D6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 07:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDC614D290;
	Thu, 11 Jul 2024 07:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1FNSVM3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2141494DA
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jul 2024 07:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720682961; cv=none; b=lR1YkJiqj7FwfrzasdjnDaRAxpLT9ijG/Lrn9KLdrOEH133UVre4C6TRS4IPvBfnqEuH4dmHE5J0IfpUgsYWUp7KZjduM0/Izo15p+SvCZTD9h8C8rTiUUQrlSg8VEd6H/UBTJYF6zCUOD7wMS02Cu1opWKDyZU4ZgvAfhYqd18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720682961; c=relaxed/simple;
	bh=XjAQzXfxPKVfEER5AVck+WfkxU99dfNna+CciF0M2zM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SpEtIWVjSLV32NC6UuWydgsyXEU3l19/7Lx7nWzK2C3gJ0e4yhVjycsBNCZpFbJdWWixu7Ec7+vhMCL2OREHsLdHXOdBPtirUYygNbDXsdK7jVZnZTI6ny28zMXGPZi4xbgBnwAKPbH+nZ7aiVwLI0d01zILCWVCZK6NHp8VwY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1FNSVM3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78E77C32782;
	Thu, 11 Jul 2024 07:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720682960;
	bh=XjAQzXfxPKVfEER5AVck+WfkxU99dfNna+CciF0M2zM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=j1FNSVM3xdztg2ij7TxwyY30FGzo6xufR1JhyfPvRV0oJq0n97eSwcvdh+wW+USVD
	 jY/YhhiC+0lLYWx46myG5PCL4tVJf8TldfmkhtCB0vZJmz5ciAarVU7XPPC4bid5tZ
	 eirw/sfH377b6WSm6m5vdadtkAF1VTTUm1nZdh+C7luj/g9o6I4ohm1hlc0rlemGEz
	 ce3EkoocL/P2JtKbCtVlIQ26BPYrbql+HjilZORwDH1XLo8b+o5fPCV64yYbq5neou
	 t73UvybxgOlUORH2OhtdPMGoMlo5miPbO3tuXMEPd2rGrqTipM7negJptHxTRIQpuV
	 G4aZKXyGzDCJw==
From: Chris Li <chrisl@kernel.org>
Date: Thu, 11 Jul 2024 00:29:05 -0700
Subject: [PATCH v4 1/3] mm: swap: swap cluster switch to double link list
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240711-swap-allocator-v4-1-0295a4d4c7aa@kernel.org>
References: <20240711-swap-allocator-v4-0-0295a4d4c7aa@kernel.org>
In-Reply-To: <20240711-swap-allocator-v4-0-0295a4d4c7aa@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <kasong@tencent.com>, Hugh Dickins <hughd@google.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
 Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Chris Li <chrisl@kernel.org>, 
 Barry Song <baohua@kernel.org>
X-Mailer: b4 0.13.0

Previously, the swap cluster used a cluster index as a pointer
to construct a custom single link list type "swap_cluster_list".
The next cluster pointer is shared with the cluster->count.
It prevents puting the non free cluster into a list.

Change the cluster to use the standard double link list instead.
This allows tracing the nonfull cluster in the follow up patch.
That way, it is faster to get to the nonfull cluster of that order.

Remove the cluster getter/setter for accessing the cluster
struct member.

The list operation is protected by the swap_info_struct->lock.

Change cluster code to use "struct swap_cluster_info *" to
reference the cluster rather than by using index. That is more
consistent with the list manipulation. It avoids the repeat
adding index to the cluser_info. The code is easier to understand.

Remove the cluster next pointer is NULL flag, the double link
list can handle the empty list pretty well.

The "swap_cluster_info" struct is two pointer bigger, because
512 swap entries share one swap struct, it has very little impact
on the average memory usage per swap entry. For 1TB swapfile, the
swap cluster data structure increases from 8MB to 24MB.

Other than the list conversion, there is no real function change
in this patch.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 include/linux/swap.h |  26 +++---
 mm/swapfile.c        | 225 ++++++++++++++-------------------------------------
 2 files changed, 70 insertions(+), 181 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index e473fe6cfb7a..e9be95468fc7 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -243,22 +243,21 @@ enum {
  * free clusters are organized into a list. We fetch an entry from the list to
  * get a free cluster.
  *
- * The data field stores next cluster if the cluster is free or cluster usage
- * counter otherwise. The flags field determines if a cluster is free. This is
- * protected by swap_info_struct.lock.
+ * The flags field determines if a cluster is free. This is
+ * protected by cluster lock.
  */
 struct swap_cluster_info {
 	spinlock_t lock;	/*
 				 * Protect swap_cluster_info fields
-				 * and swap_info_struct->swap_map
-				 * elements correspond to the swap
-				 * cluster
+				 * other than list, and swap_info_struct->swap_map
+				 * elements correspond to the swap cluster.
 				 */
-	unsigned int data:24;
-	unsigned int flags:8;
+	u16 count;
+	u8 flags;
+	struct list_head list;
 };
 #define CLUSTER_FLAG_FREE 1 /* This cluster is free */
-#define CLUSTER_FLAG_NEXT_NULL 2 /* This cluster has no next cluster */
+
 
 /*
  * The first page in the swap file is the swap header, which is always marked
@@ -283,11 +282,6 @@ struct percpu_cluster {
 	unsigned int next[SWAP_NR_ORDERS]; /* Likely next allocation offset */
 };
 
-struct swap_cluster_list {
-	struct swap_cluster_info head;
-	struct swap_cluster_info tail;
-};
-
 /*
  * The in-memory structure used to track swap areas.
  */
@@ -301,7 +295,7 @@ struct swap_info_struct {
 	unsigned char *swap_map;	/* vmalloc'ed array of usage counts */
 	unsigned long *zeromap;		/* vmalloc'ed bitmap to track zero pages */
 	struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
-	struct swap_cluster_list free_clusters; /* free clusters list */
+	struct list_head free_clusters; /* free clusters list */
 	unsigned int lowest_bit;	/* index of first free in swap_map */
 	unsigned int highest_bit;	/* index of last free in swap_map */
 	unsigned int pages;		/* total of usable pages of swap */
@@ -332,7 +326,7 @@ struct swap_info_struct {
 					 * list.
 					 */
 	struct work_struct discard_work; /* discard worker */
-	struct swap_cluster_list discard_clusters; /* discard clusters list */
+	struct list_head discard_clusters; /* discard clusters list */
 	struct plist_node avail_lists[]; /*
 					   * entries in swap_avail_heads, one
 					   * entry per node.
diff --git a/mm/swapfile.c b/mm/swapfile.c
index f7224bc1320c..f70d25005d2c 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -290,62 +290,15 @@ static void discard_swap_cluster(struct swap_info_struct *si,
 #endif
 #define LATENCY_LIMIT		256
 
-static inline void cluster_set_flag(struct swap_cluster_info *info,
-	unsigned int flag)
-{
-	info->flags = flag;
-}
-
-static inline unsigned int cluster_count(struct swap_cluster_info *info)
-{
-	return info->data;
-}
-
-static inline void cluster_set_count(struct swap_cluster_info *info,
-				     unsigned int c)
-{
-	info->data = c;
-}
-
-static inline void cluster_set_count_flag(struct swap_cluster_info *info,
-					 unsigned int c, unsigned int f)
-{
-	info->flags = f;
-	info->data = c;
-}
-
-static inline unsigned int cluster_next(struct swap_cluster_info *info)
-{
-	return info->data;
-}
-
-static inline void cluster_set_next(struct swap_cluster_info *info,
-				    unsigned int n)
-{
-	info->data = n;
-}
-
-static inline void cluster_set_next_flag(struct swap_cluster_info *info,
-					 unsigned int n, unsigned int f)
-{
-	info->flags = f;
-	info->data = n;
-}
-
 static inline bool cluster_is_free(struct swap_cluster_info *info)
 {
 	return info->flags & CLUSTER_FLAG_FREE;
 }
 
-static inline bool cluster_is_null(struct swap_cluster_info *info)
-{
-	return info->flags & CLUSTER_FLAG_NEXT_NULL;
-}
-
-static inline void cluster_set_null(struct swap_cluster_info *info)
+static inline unsigned int cluster_index(struct swap_info_struct *si,
+					 struct swap_cluster_info *ci)
 {
-	info->flags = CLUSTER_FLAG_NEXT_NULL;
-	info->data = 0;
+	return ci - si->cluster_info;
 }
 
 static inline struct swap_cluster_info *lock_cluster(struct swap_info_struct *si,
@@ -394,65 +347,11 @@ static inline void unlock_cluster_or_swap_info(struct swap_info_struct *si,
 		spin_unlock(&si->lock);
 }
 
-static inline bool cluster_list_empty(struct swap_cluster_list *list)
-{
-	return cluster_is_null(&list->head);
-}
-
-static inline unsigned int cluster_list_first(struct swap_cluster_list *list)
-{
-	return cluster_next(&list->head);
-}
-
-static void cluster_list_init(struct swap_cluster_list *list)
-{
-	cluster_set_null(&list->head);
-	cluster_set_null(&list->tail);
-}
-
-static void cluster_list_add_tail(struct swap_cluster_list *list,
-				  struct swap_cluster_info *ci,
-				  unsigned int idx)
-{
-	if (cluster_list_empty(list)) {
-		cluster_set_next_flag(&list->head, idx, 0);
-		cluster_set_next_flag(&list->tail, idx, 0);
-	} else {
-		struct swap_cluster_info *ci_tail;
-		unsigned int tail = cluster_next(&list->tail);
-
-		/*
-		 * Nested cluster lock, but both cluster locks are
-		 * only acquired when we held swap_info_struct->lock
-		 */
-		ci_tail = ci + tail;
-		spin_lock_nested(&ci_tail->lock, SINGLE_DEPTH_NESTING);
-		cluster_set_next(ci_tail, idx);
-		spin_unlock(&ci_tail->lock);
-		cluster_set_next_flag(&list->tail, idx, 0);
-	}
-}
-
-static unsigned int cluster_list_del_first(struct swap_cluster_list *list,
-					   struct swap_cluster_info *ci)
-{
-	unsigned int idx;
-
-	idx = cluster_next(&list->head);
-	if (cluster_next(&list->tail) == idx) {
-		cluster_set_null(&list->head);
-		cluster_set_null(&list->tail);
-	} else
-		cluster_set_next_flag(&list->head,
-				      cluster_next(&ci[idx]), 0);
-
-	return idx;
-}
-
 /* Add a cluster to discard list and schedule it to do discard */
 static void swap_cluster_schedule_discard(struct swap_info_struct *si,
-		unsigned int idx)
+		struct swap_cluster_info *ci)
 {
+	unsigned int idx = cluster_index(si, ci);
 	/*
 	 * If scan_swap_map_slots() can't find a free cluster, it will check
 	 * si->swap_map directly. To make sure the discarding cluster isn't
@@ -462,17 +361,14 @@ static void swap_cluster_schedule_discard(struct swap_info_struct *si,
 	memset(si->swap_map + idx * SWAPFILE_CLUSTER,
 			SWAP_MAP_BAD, SWAPFILE_CLUSTER);
 
-	cluster_list_add_tail(&si->discard_clusters, si->cluster_info, idx);
-
+	list_add_tail(&ci->list, &si->discard_clusters);
 	schedule_work(&si->discard_work);
 }
 
-static void __free_cluster(struct swap_info_struct *si, unsigned long idx)
+static void __free_cluster(struct swap_info_struct *si, struct swap_cluster_info *ci)
 {
-	struct swap_cluster_info *ci = si->cluster_info;
-
-	cluster_set_flag(ci + idx, CLUSTER_FLAG_FREE);
-	cluster_list_add_tail(&si->free_clusters, ci, idx);
+	ci->flags = CLUSTER_FLAG_FREE;
+	list_add_tail(&ci->list, &si->free_clusters);
 }
 
 /*
@@ -481,24 +377,25 @@ static void __free_cluster(struct swap_info_struct *si, unsigned long idx)
 */
 static void swap_do_scheduled_discard(struct swap_info_struct *si)
 {
-	struct swap_cluster_info *info, *ci;
+	struct swap_cluster_info *ci;
 	unsigned int idx;
 
-	info = si->cluster_info;
-
-	while (!cluster_list_empty(&si->discard_clusters)) {
-		idx = cluster_list_del_first(&si->discard_clusters, info);
+	while (!list_empty(&si->discard_clusters)) {
+		ci = list_first_entry(&si->discard_clusters, struct swap_cluster_info, list);
+		list_del(&ci->list);
+		idx = cluster_index(si, ci);
 		spin_unlock(&si->lock);
 
 		discard_swap_cluster(si, idx * SWAPFILE_CLUSTER,
 				SWAPFILE_CLUSTER);
 
 		spin_lock(&si->lock);
-		ci = lock_cluster(si, idx * SWAPFILE_CLUSTER);
-		__free_cluster(si, idx);
+
+		spin_lock(&ci->lock);
+		__free_cluster(si, ci);
 		memset(si->swap_map + idx * SWAPFILE_CLUSTER,
 				0, SWAPFILE_CLUSTER);
-		unlock_cluster(ci);
+		spin_unlock(&ci->lock);
 	}
 }
 
@@ -521,20 +418,20 @@ static void swap_users_ref_free(struct percpu_ref *ref)
 	complete(&si->comp);
 }
 
-static void alloc_cluster(struct swap_info_struct *si, unsigned long idx)
+static struct swap_cluster_info *alloc_cluster(struct swap_info_struct *si, unsigned long idx)
 {
-	struct swap_cluster_info *ci = si->cluster_info;
+	struct swap_cluster_info *ci = list_first_entry(&si->free_clusters, struct swap_cluster_info, list);
 
-	VM_BUG_ON(cluster_list_first(&si->free_clusters) != idx);
-	cluster_list_del_first(&si->free_clusters, ci);
-	cluster_set_count_flag(ci + idx, 0, 0);
+	VM_BUG_ON(cluster_index(si, ci) != idx);
+	list_del(&ci->list);
+	ci->count = 0;
+	ci->flags = 0;
+	return ci;
 }
 
-static void free_cluster(struct swap_info_struct *si, unsigned long idx)
+static void free_cluster(struct swap_info_struct *si, struct swap_cluster_info *ci)
 {
-	struct swap_cluster_info *ci = si->cluster_info + idx;
-
-	VM_BUG_ON(cluster_count(ci) != 0);
+	VM_BUG_ON(ci->count != 0);
 	/*
 	 * If the swap is discardable, prepare discard the cluster
 	 * instead of free it immediately. The cluster will be freed
@@ -542,11 +439,11 @@ static void free_cluster(struct swap_info_struct *si, unsigned long idx)
 	 */
 	if ((si->flags & (SWP_WRITEOK | SWP_PAGE_DISCARD)) ==
 	    (SWP_WRITEOK | SWP_PAGE_DISCARD)) {
-		swap_cluster_schedule_discard(si, idx);
+		swap_cluster_schedule_discard(si, ci);
 		return;
 	}
 
-	__free_cluster(si, idx);
+	__free_cluster(si, ci);
 }
 
 /*
@@ -559,15 +456,15 @@ static void add_cluster_info_page(struct swap_info_struct *p,
 	unsigned long count)
 {
 	unsigned long idx = page_nr / SWAPFILE_CLUSTER;
+	struct swap_cluster_info *ci = cluster_info + idx;
 
 	if (!cluster_info)
 		return;
-	if (cluster_is_free(&cluster_info[idx]))
+	if (cluster_is_free(ci))
 		alloc_cluster(p, idx);
 
-	VM_BUG_ON(cluster_count(&cluster_info[idx]) + count > SWAPFILE_CLUSTER);
-	cluster_set_count(&cluster_info[idx],
-		cluster_count(&cluster_info[idx]) + count);
+	VM_BUG_ON(ci->count + count > SWAPFILE_CLUSTER);
+	ci->count += count;
 }
 
 /*
@@ -581,24 +478,20 @@ static void inc_cluster_info_page(struct swap_info_struct *p,
 }
 
 /*
- * The cluster corresponding to page_nr decreases one usage. If the usage
- * counter becomes 0, which means no page in the cluster is in using, we can
- * optionally discard the cluster and add it to free cluster list.
+ * The cluster ci decreases one usage. If the usage counter becomes 0,
+ * which means no page in the cluster is in using, we can optionally discard
+ * the cluster and add it to free cluster list.
  */
-static void dec_cluster_info_page(struct swap_info_struct *p,
-	struct swap_cluster_info *cluster_info, unsigned long page_nr)
+static void dec_cluster_info_page(struct swap_info_struct *p, struct swap_cluster_info *ci)
 {
-	unsigned long idx = page_nr / SWAPFILE_CLUSTER;
-
-	if (!cluster_info)
+	if (!p->cluster_info)
 		return;
 
-	VM_BUG_ON(cluster_count(&cluster_info[idx]) == 0);
-	cluster_set_count(&cluster_info[idx],
-		cluster_count(&cluster_info[idx]) - 1);
+	VM_BUG_ON(ci->count == 0);
+	ci->count--;
 
-	if (cluster_count(&cluster_info[idx]) == 0)
-		free_cluster(p, idx);
+	if (!ci->count)
+		free_cluster(p, ci);
 }
 
 /*
@@ -611,10 +504,10 @@ scan_swap_map_ssd_cluster_conflict(struct swap_info_struct *si,
 {
 	struct percpu_cluster *percpu_cluster;
 	bool conflict;
-
+	struct swap_cluster_info *first = list_first_entry(&si->free_clusters, struct swap_cluster_info, list);
 	offset /= SWAPFILE_CLUSTER;
-	conflict = !cluster_list_empty(&si->free_clusters) &&
-		offset != cluster_list_first(&si->free_clusters) &&
+	conflict = !list_empty(&si->free_clusters) &&
+		offset !=  first - si->cluster_info &&
 		cluster_is_free(&si->cluster_info[offset]);
 
 	if (!conflict)
@@ -655,10 +548,10 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 	cluster = this_cpu_ptr(si->percpu_cluster);
 	tmp = cluster->next[order];
 	if (tmp == SWAP_NEXT_INVALID) {
-		if (!cluster_list_empty(&si->free_clusters)) {
-			tmp = cluster_next(&si->free_clusters.head) *
-					SWAPFILE_CLUSTER;
-		} else if (!cluster_list_empty(&si->discard_clusters)) {
+		if (!list_empty(&si->free_clusters)) {
+			ci = list_first_entry(&si->free_clusters, struct swap_cluster_info, list);
+			tmp = cluster_index(si, ci) * SWAPFILE_CLUSTER;
+		} else if (!list_empty(&si->discard_clusters)) {
 			/*
 			 * we don't have free cluster but have some clusters in
 			 * discarding, do discard now and reclaim them, then
@@ -1070,8 +963,9 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
 
 	ci = lock_cluster(si, offset);
 	memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
-	cluster_set_count_flag(ci, 0, 0);
-	free_cluster(si, idx);
+	ci->count = 0;
+	ci->flags = 0;
+	free_cluster(si, ci);
 	unlock_cluster(ci);
 	swap_range_free(si, offset, SWAPFILE_CLUSTER);
 }
@@ -1344,7 +1238,7 @@ static void swap_entry_free(struct swap_info_struct *p, swp_entry_t entry)
 	count = p->swap_map[offset];
 	VM_BUG_ON(count != SWAP_HAS_CACHE);
 	p->swap_map[offset] = 0;
-	dec_cluster_info_page(p, p->cluster_info, offset);
+	dec_cluster_info_page(p, ci);
 	unlock_cluster(ci);
 
 	mem_cgroup_uncharge_swap(entry, 1);
@@ -3022,8 +2916,8 @@ static int setup_swap_map_and_extents(struct swap_info_struct *p,
 
 	nr_good_pages = maxpages - 1;	/* omit header page */
 
-	cluster_list_init(&p->free_clusters);
-	cluster_list_init(&p->discard_clusters);
+	INIT_LIST_HEAD(&p->free_clusters);
+	INIT_LIST_HEAD(&p->discard_clusters);
 
 	for (i = 0; i < swap_header->info.nr_badpages; i++) {
 		unsigned int page_nr = swap_header->info.badpages[i];
@@ -3074,14 +2968,15 @@ static int setup_swap_map_and_extents(struct swap_info_struct *p,
 	for (k = 0; k < SWAP_CLUSTER_COLS; k++) {
 		j = (k + col) % SWAP_CLUSTER_COLS;
 		for (i = 0; i < DIV_ROUND_UP(nr_clusters, SWAP_CLUSTER_COLS); i++) {
+			struct swap_cluster_info *ci;
 			idx = i * SWAP_CLUSTER_COLS + j;
+			ci = cluster_info + idx;
 			if (idx >= nr_clusters)
 				continue;
-			if (cluster_count(&cluster_info[idx]))
+			if (ci->count)
 				continue;
-			cluster_set_flag(&cluster_info[idx], CLUSTER_FLAG_FREE);
-			cluster_list_add_tail(&p->free_clusters, cluster_info,
-					      idx);
+			ci->flags = CLUSTER_FLAG_FREE;
+			list_add_tail(&ci->list, &p->free_clusters);
 		}
 	}
 	return nr_extents;

-- 
2.45.2.803.g4e1b14247a-goog


