Return-Path: <linux-kernel+bounces-268636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D70D0942728
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DB12283F19
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 06:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957481A71EC;
	Wed, 31 Jul 2024 06:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qf8E8DJt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6821A4F1E
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722408564; cv=none; b=JDySgd0wNI6V65AQbZN3IN32Rl4dRfCJwkNIsA+OVHoxigx+cam7/P5YiWdyiLKC4kJqcnrq4YyYxA4xpxTX0EBCaIGiJn5fZMvVa2yyteo8O5YELMo+g8emvgrYrbl6YJygbPiPR7O9Q7Cbu3oiB0/QLBuQtJCi41bPuyDYF2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722408564; c=relaxed/simple;
	bh=bGhHEHa6OStA/L6zX9n/5nX1MnDqB9/9wXUAWu7kmvs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OY8l/hHRAxv/e9Ly/C9yUvo7+Y4JA4o3n20nWCJTK2jKXspgR2KuurSGmPD0ons+vZsqjoWRjVnDc88uaExFiW36f/QW2rPJI1IrmQbkyKxWa1wkzlLbZm7dZ+Yg0Qj8UehbcpQvAcUdHyDa5NrwtYiEZFl1oieQypQkP2sINJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qf8E8DJt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E058C4AF16;
	Wed, 31 Jul 2024 06:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722408564;
	bh=bGhHEHa6OStA/L6zX9n/5nX1MnDqB9/9wXUAWu7kmvs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qf8E8DJt+TyJxgGeW+MoN9f10/VCDxTPe/27P7EIijJOawJ5WT4ZoQXslSCKgdZAX
	 r+sq7N/EUp+65m4HpvtbITV1ND1wvD0bEuMyqpU80Tt9aQwQYCOFTy2PGAjkbwUCE0
	 EsUgx5Ew92LWr6GRpWG1yzi029EzdChEOYnb7nM/AFTuBdWcj3CE2s0QCCSNzTtMSG
	 2EoQpvjSf7fGZdI0OTDXzIyWfq4f8qEVZi0tLy2ny/XWtm/9OsxIwe+sR8BtECOuKx
	 aFizmjxAKCnvF0b2gmG50glRnB/Z77N9wV1vIaHsJK9H4l7ZuoVsKuZzlE5lO1AvrJ
	 uKhKaj2Dz7Plw==
From: chrisl@kernel.org
Date: Tue, 30 Jul 2024 23:49:20 -0700
Subject: [PATCH v5 8/9] mm: swap: relaim the cached parts that got scanned
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-swap-allocator-v5-8-cb9c148b9297@kernel.org>
References: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
In-Reply-To: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <kasong@tencent.com>, Hugh Dickins <hughd@google.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
 Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Chris Li <chrisl@kernel.org>, 
 Barry Song <baohua@kernel.org>
X-Mailer: b4 0.13.0

From: Kairui Song <kasong@tencent.com>

This commit implements reclaim during scan for cluster allocator.

Cluster scanning were unable to reuse SWAP_HAS_CACHE slots, which
could result in low allocation success rate or early OOM.

So to ensure maximum allocation success rate, integrate reclaiming
with scanning. If found a range of suitable swap slots but fragmented
due to HAS_CACHE, just try to reclaim the slots.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap.h |   1 +
 mm/swapfile.c        | 140 +++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 110 insertions(+), 31 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 5a14b6c65949..9eb740563d63 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -302,6 +302,7 @@ struct swap_info_struct {
 					/* list of cluster that contains at least one free slot */
 	struct list_head frag_clusters[SWAP_NR_ORDERS];
 					/* list of cluster that are fragmented or contented */
+	unsigned int frag_cluster_nr[SWAP_NR_ORDERS];
 	unsigned int lowest_bit;	/* index of first free in swap_map */
 	unsigned int highest_bit;	/* index of last free in swap_map */
 	unsigned int pages;		/* total of usable pages of swap */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index eb3e387e86b2..50e7f600a9a1 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -513,6 +513,10 @@ static void free_cluster(struct swap_info_struct *si, struct swap_cluster_info *
 	VM_BUG_ON(ci->count != 0);
 	lockdep_assert_held(&si->lock);
 	lockdep_assert_held(&ci->lock);
+
+	if (ci->flags & CLUSTER_FLAG_FRAG)
+		si->frag_cluster_nr[ci->order]--;
+
 	/*
 	 * If the swap is discardable, prepare discard the cluster
 	 * instead of free it immediately. The cluster will be freed
@@ -572,31 +576,84 @@ static void dec_cluster_info_page(struct swap_info_struct *p,
 
 	if (!(ci->flags & CLUSTER_FLAG_NONFULL)) {
 		VM_BUG_ON(ci->flags & CLUSTER_FLAG_FREE);
-		if (ci->flags & CLUSTER_FLAG_FRAG)
+		if (ci->flags & CLUSTER_FLAG_FRAG) {
+			p->frag_cluster_nr[ci->order]--;
 			list_move_tail(&ci->list, &p->nonfull_clusters[ci->order]);
-		else
+		} else {
 			list_add_tail(&ci->list, &p->nonfull_clusters[ci->order]);
+		}
 		ci->flags = CLUSTER_FLAG_NONFULL;
 	}
 }
 
-static inline bool cluster_scan_range(struct swap_info_struct *si, unsigned int start,
-				      unsigned int nr_pages)
+static bool cluster_reclaim_range(struct swap_info_struct *si,
+				  struct swap_cluster_info *ci,
+				  unsigned long start, unsigned long end)
 {
-	unsigned char *p = si->swap_map + start;
-	unsigned char *end = p + nr_pages;
+	unsigned char *map = si->swap_map;
+	unsigned long offset;
+
+	spin_unlock(&ci->lock);
+	spin_unlock(&si->lock);
+
+	for (offset = start; offset < end; offset++) {
+		switch (READ_ONCE(map[offset])) {
+		case 0:
+			continue;
+		case SWAP_HAS_CACHE:
+			if (__try_to_reclaim_swap(si, offset, TTRS_ANYWAY | TTRS_DIRECT) > 0)
+				continue;
+			goto out;
+		default:
+			goto out;
+		}
+	}
+out:
+	spin_lock(&si->lock);
+	spin_lock(&ci->lock);
 
-	while (p < end)
-		if (*p++)
+	/*
+	 * Recheck the range no matter reclaim succeeded or not, the slot
+	 * could have been be freed while we are not holding the lock.
+	 */
+	for (offset = start; offset < end; offset++)
+		if (READ_ONCE(map[offset]))
 			return false;
 
 	return true;
 }
 
+static bool cluster_scan_range(struct swap_info_struct *si,
+			       struct swap_cluster_info *ci,
+			       unsigned long start, unsigned int nr_pages)
+{
+	unsigned long offset, end = start + nr_pages;
+	unsigned char *map = si->swap_map;
+	bool need_reclaim = false;
 
-static inline void cluster_alloc_range(struct swap_info_struct *si, struct swap_cluster_info *ci,
-						unsigned int start, unsigned char usage,
-						unsigned int order)
+	for (offset = start; offset < end; offset++) {
+		switch (READ_ONCE(map[offset])) {
+		case 0:
+			continue;
+		case SWAP_HAS_CACHE:
+			if (!vm_swap_full())
+				return false;
+			need_reclaim = true;
+			continue;
+		default:
+			return false;
+		}
+	}
+
+	if (need_reclaim)
+		return cluster_reclaim_range(si, ci, start, end);
+
+	return true;
+}
+
+static void cluster_alloc_range(struct swap_info_struct *si, struct swap_cluster_info *ci,
+				unsigned int start, unsigned char usage,
+				unsigned int order)
 {
 	unsigned int nr_pages = 1 << order;
 
@@ -615,6 +672,8 @@ static inline void cluster_alloc_range(struct swap_info_struct *si, struct swap_
 	if (ci->count == SWAPFILE_CLUSTER) {
 		VM_BUG_ON(!(ci->flags &
 			  (CLUSTER_FLAG_FREE | CLUSTER_FLAG_NONFULL | CLUSTER_FLAG_FRAG)));
+		if (ci->flags & CLUSTER_FLAG_FRAG)
+			si->frag_cluster_nr[ci->order]--;
 		list_del(&ci->list);
 		ci->flags = 0;
 	}
@@ -640,7 +699,7 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si, unsigne
 	}
 
 	while (offset <= end) {
-		if (cluster_scan_range(si, offset, nr_pages)) {
+		if (cluster_scan_range(si, ci, offset, nr_pages)) {
 			cluster_alloc_range(si, ci, offset, usage, order);
 			*foundp = offset;
 			if (ci->count == SWAPFILE_CLUSTER) {
@@ -668,9 +727,8 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 					      unsigned char usage)
 {
 	struct percpu_cluster *cluster;
-	struct swap_cluster_info *ci, *n;
+	struct swap_cluster_info *ci;
 	unsigned int offset, found = 0;
-	LIST_HEAD(fraged);
 
 new_cluster:
 	lockdep_assert_held(&si->lock);
@@ -690,25 +748,42 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 	}
 
 	if (order < PMD_ORDER) {
-		list_for_each_entry_safe(ci, n, &si->nonfull_clusters[order], list) {
-			list_move_tail(&ci->list, &fraged);
+		unsigned int frags = 0;
+
+		while (!list_empty(&si->nonfull_clusters[order])) {
+			ci = list_first_entry(&si->nonfull_clusters[order],
+					      struct swap_cluster_info, list);
+			list_move_tail(&ci->list, &si->frag_clusters[order]);
 			ci->flags = CLUSTER_FLAG_FRAG;
+			si->frag_cluster_nr[order]++;
 			offset = alloc_swap_scan_cluster(si, cluster_offset(si, ci),
 							 &found, order, usage);
+			frags++;
 			if (found)
 				break;
 		}
 
 		if (!found) {
-			list_for_each_entry_safe(ci, n, &si->frag_clusters[order], list) {
+			/*
+			 * Nonfull clusters are moved to frag tail if we reached
+			 * here, count them too, don't over scan the frag list.
+			 */
+			while (frags < si->frag_cluster_nr[order]) {
+				ci = list_first_entry(&si->frag_clusters[order],
+						      struct swap_cluster_info, list);
+				/*
+				 * Rotate the frag list to iterate, they were all failing
+				 * high order allocation or moved here due to per-CPU usage,
+				 * this help keeping usable cluster ahead.
+				 */
+				list_move_tail(&ci->list, &si->frag_clusters[order]);
 				offset = alloc_swap_scan_cluster(si, cluster_offset(si, ci),
 								 &found, order, usage);
+				frags++;
 				if (found)
 					break;
 			}
 		}
-
-		list_splice_tail(&fraged, &si->frag_clusters[order]);
 	}
 
 	if (found)
@@ -729,25 +804,28 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 
 	/* Order 0 stealing from higher order */
 	for (int o = 1; o < PMD_ORDER; o++) {
-		if (!list_empty(&si->frag_clusters[o])) {
+		/*
+		 * Clusters here have at least one usable slots and can't fail order 0
+		 * allocation, but reclaim may drop si->lock and race with another user.
+		 */
+		while (!list_empty(&si->frag_clusters[o])) {
 			ci = list_first_entry(&si->frag_clusters[o],
 					      struct swap_cluster_info, list);
-			offset = alloc_swap_scan_cluster(si, cluster_offset(si, ci), &found,
-							 0, usage);
-			VM_BUG_ON(!found);
-			goto done;
+			offset = alloc_swap_scan_cluster(si, cluster_offset(si, ci),
+							 &found, 0, usage);
+			if (found)
+				goto done;
 		}
 
-		if (!list_empty(&si->nonfull_clusters[o])) {
-			ci = list_first_entry(&si->nonfull_clusters[o], struct swap_cluster_info,
-					      list);
+		while (!list_empty(&si->nonfull_clusters[o])) {
+			ci = list_first_entry(&si->nonfull_clusters[o],
+					      struct swap_cluster_info, list);
 			offset = alloc_swap_scan_cluster(si, cluster_offset(si, ci),
 							 &found, 0, usage);
-			VM_BUG_ON(!found);
-			goto done;
+			if (found)
+				goto done;
 		}
 	}
-
 done:
 	cluster->next[order] = offset;
 	return found;
@@ -3053,6 +3131,7 @@ static int setup_swap_map_and_extents(struct swap_info_struct *p,
 	for (i = 0; i < SWAP_NR_ORDERS; i++) {
 		INIT_LIST_HEAD(&p->nonfull_clusters[i]);
 		INIT_LIST_HEAD(&p->frag_clusters[i]);
+		p->frag_cluster_nr[i] = 0;
 	}
 
 	for (i = 0; i < swap_header->info.nr_badpages; i++) {
@@ -3096,7 +3175,6 @@ static int setup_swap_map_and_extents(struct swap_info_struct *p,
 	if (!cluster_info)
 		return nr_extents;
 
-
 	/*
 	 * Reduce false cache line sharing between cluster_info and
 	 * sharing same address space.

-- 
2.46.0.rc1.232.g9752f9e123-goog


