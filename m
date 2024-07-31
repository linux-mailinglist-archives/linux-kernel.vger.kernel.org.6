Return-Path: <linux-kernel+bounces-268637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D55A942729
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C34BE1F219B6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 06:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A6873501;
	Wed, 31 Jul 2024 06:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMOUJDcg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF2E1A4F30
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722408565; cv=none; b=iM4HNUBJSF/HlIpy2PCeXhyid+20Gkn9YU3r17CUso87Loo9jOi582ctiZ94V+ztz0tyMR2XWpDOtoOo6C1TUOYuvdmZdipN+sv/wZWyp3+8caiuoRqwiLY9ft5QW4reTI5d7rIvhAOu9eDnwyzGTqvjqLW2obMNuwGcz88z4QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722408565; c=relaxed/simple;
	bh=85G3706WeHs7PoCDO0Xz686T8+2PYBWAt+EG2DvBdnI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rp4XpFAUM8g1uusZtfoGz6aHnm11955zd+s0job8dJfCaLkntiXvlGARrd3I2cwmq68ejNEWz52yq5awuN7yIhLklyvMs8H8CF2EGg/jVZ6BCjnLerdnbMydwouLBPbhPxyYKQ9TND+i7DnuQKsGFNyD7Z278vC3lqt28vxLKnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMOUJDcg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB2BAC4AF10;
	Wed, 31 Jul 2024 06:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722408565;
	bh=85G3706WeHs7PoCDO0Xz686T8+2PYBWAt+EG2DvBdnI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AMOUJDcgdP60QBUC88rmHTe5Zh5zwohd44U8WH5Mb1wQQYcEx7vIwtAClpIFy2Vep
	 b5TCQohg1ZdP/NBc9R12JO5c+3POLfosUwJxSVVgL3YJPH+mJZcaDkxN2XRSdmQnlJ
	 +M0v5rpBl/KCbWZeh+i9qT0Mmrq/9SBgo40ysEYmdscvJ8m7fqdAEOUUqhlFANjjY8
	 WXyVIFS6v+o5UptA+VlTlgf+jJj/8W8zZ8qG533WKAIP2A3hqoO7cFz6wr7jFbGY4i
	 VgAaYleNOW8uvKIOePo1Jt+9uBrxyYtcVxMkdDpToS6WQBLjgXSwc2zlHLJqV+ppZq
	 jbZi35hcEDjNw==
From: chrisl@kernel.org
Date: Tue, 30 Jul 2024 23:49:21 -0700
Subject: [PATCH v5 9/9] mm: swap: add a adaptive full cluster cache reclaim
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-swap-allocator-v5-9-cb9c148b9297@kernel.org>
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

Link all full cluster with one full list, and reclaim from it when the
allocation have ran out of all usable clusters.

There are many reason a folio can end up being in the swap cache while
having no swap count reference. So the best way to search for such slots
is still by iterating the swap clusters.

With the list as an LRU, iterating from the oldest cluster and keep them
rotating is a very doable and clean way to free up potentially not inuse
clusters.

When any allocation failure, try reclaim and rotate only one cluster.
This is adaptive for high order allocations they can tolerate fallback.
So this avoids latency, and give the full cluster list an fair chance
to get reclaimed. It release the usage stress for the fallback order 0
allocation or following up high order allocation.

If the swap device is getting very full, reclaim more aggresively to
ensure no OOM will happen. This ensures order 0 heavy workload won't go
OOM as order 0 won't fail if any cluster still have any space.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap.h |  1 +
 mm/swapfile.c        | 68 +++++++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 9eb740563d63..145e796dab84 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -298,6 +298,7 @@ struct swap_info_struct {
 	unsigned long *zeromap;		/* vmalloc'ed bitmap to track zero pages */
 	struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
 	struct list_head free_clusters; /* free clusters list */
+	struct list_head full_clusters; /* full clusters list */
 	struct list_head nonfull_clusters[SWAP_NR_ORDERS];
 					/* list of cluster that contains at least one free slot */
 	struct list_head frag_clusters[SWAP_NR_ORDERS];
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 50e7f600a9a1..9872e0dbfc72 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -440,10 +440,7 @@ static void swap_cluster_schedule_discard(struct swap_info_struct *si,
 			SWAP_MAP_BAD, SWAPFILE_CLUSTER);
 
 	VM_BUG_ON(ci->flags & CLUSTER_FLAG_FREE);
-	if (ci->flags & CLUSTER_FLAG_NONFULL)
-		list_move_tail(&ci->list, &si->discard_clusters);
-	else
-		list_add_tail(&ci->list, &si->discard_clusters);
+	list_move_tail(&ci->list, &si->discard_clusters);
 	ci->flags = 0;
 	schedule_work(&si->discard_work);
 }
@@ -453,10 +450,7 @@ static void __free_cluster(struct swap_info_struct *si, struct swap_cluster_info
 	lockdep_assert_held(&si->lock);
 	lockdep_assert_held(&ci->lock);
 
-	if (ci->flags & CLUSTER_FLAG_NONFULL)
-		list_move_tail(&ci->list, &si->free_clusters);
-	else
-		list_add_tail(&ci->list, &si->free_clusters);
+	list_move_tail(&ci->list, &si->free_clusters);
 	ci->flags = CLUSTER_FLAG_FREE;
 	ci->order = 0;
 }
@@ -576,12 +570,9 @@ static void dec_cluster_info_page(struct swap_info_struct *p,
 
 	if (!(ci->flags & CLUSTER_FLAG_NONFULL)) {
 		VM_BUG_ON(ci->flags & CLUSTER_FLAG_FREE);
-		if (ci->flags & CLUSTER_FLAG_FRAG) {
+		if (ci->flags & CLUSTER_FLAG_FRAG)
 			p->frag_cluster_nr[ci->order]--;
-			list_move_tail(&ci->list, &p->nonfull_clusters[ci->order]);
-		} else {
-			list_add_tail(&ci->list, &p->nonfull_clusters[ci->order]);
-		}
+		list_move_tail(&ci->list, &p->nonfull_clusters[ci->order]);
 		ci->flags = CLUSTER_FLAG_NONFULL;
 	}
 }
@@ -674,7 +665,7 @@ static void cluster_alloc_range(struct swap_info_struct *si, struct swap_cluster
 			  (CLUSTER_FLAG_FREE | CLUSTER_FLAG_NONFULL | CLUSTER_FLAG_FRAG)));
 		if (ci->flags & CLUSTER_FLAG_FRAG)
 			si->frag_cluster_nr[ci->order]--;
-		list_del(&ci->list);
+		list_move_tail(&ci->list, &si->full_clusters);
 		ci->flags = 0;
 	}
 }
@@ -718,6 +709,46 @@ static unsigned int alloc_swap_scan_cluster(struct swap_info_struct *si, unsigne
 	return offset;
 }
 
+static void swap_reclaim_full_clusters(struct swap_info_struct *si)
+{
+	long to_scan = 1;
+	unsigned long offset, end;
+	struct swap_cluster_info *ci;
+	unsigned char *map = si->swap_map;
+	int nr_reclaim, total_reclaimed = 0;
+
+	if (atomic_long_read(&nr_swap_pages) <= SWAPFILE_CLUSTER)
+		to_scan = si->inuse_pages / SWAPFILE_CLUSTER;
+
+	while (!list_empty(&si->full_clusters)) {
+		ci = list_first_entry(&si->full_clusters, struct swap_cluster_info, list);
+		list_move_tail(&ci->list, &si->full_clusters);
+		offset = cluster_offset(si, ci);
+		end = min(si->max, offset + SWAPFILE_CLUSTER);
+		to_scan--;
+
+		while (offset < end) {
+			if (READ_ONCE(map[offset]) == SWAP_HAS_CACHE) {
+				spin_unlock(&si->lock);
+				nr_reclaim = __try_to_reclaim_swap(si, offset,
+								   TTRS_ANYWAY | TTRS_DIRECT);
+				spin_lock(&si->lock);
+				if (nr_reclaim > 0) {
+					offset += nr_reclaim;
+					total_reclaimed += nr_reclaim;
+					continue;
+				} else if (nr_reclaim < 0) {
+					offset += -nr_reclaim;
+					continue;
+				}
+			}
+			offset++;
+		}
+		if (to_scan <= 0 || total_reclaimed)
+			break;
+	}
+}
+
 /*
  * Try to get swap entries with specified order from current cpu's swap entry
  * pool (a cluster). This might involve allocating a new cluster for current CPU
@@ -826,7 +857,15 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 				goto done;
 		}
 	}
+
 done:
+	/* Try reclaim from full clusters if device is nearfull */
+	if (vm_swap_full() && (!found || (si->pages - si->inuse_pages) < SWAPFILE_CLUSTER)) {
+		swap_reclaim_full_clusters(si);
+		if (!found && !order && si->pages != si->inuse_pages)
+			goto new_cluster;
+	}
+
 	cluster->next[order] = offset;
 	return found;
 }
@@ -3126,6 +3165,7 @@ static int setup_swap_map_and_extents(struct swap_info_struct *p,
 	nr_good_pages = maxpages - 1;	/* omit header page */
 
 	INIT_LIST_HEAD(&p->free_clusters);
+	INIT_LIST_HEAD(&p->full_clusters);
 	INIT_LIST_HEAD(&p->discard_clusters);
 
 	for (i = 0; i < SWAP_NR_ORDERS; i++) {

-- 
2.46.0.rc1.232.g9752f9e123-goog


