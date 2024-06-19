Return-Path: <linux-kernel+bounces-220770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D5F90E6CD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6B11F22028
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 09:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEFA80035;
	Wed, 19 Jun 2024 09:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aqt/s8BR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16C67FBBF
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 09:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788836; cv=none; b=nOUWyXOcrsPtz09f0DgaZqwFj6Cd+Aqxl+NELwJcFPhTqnqsBoQy1enJC+YgJJNgfpWXXFQwZ68VJ9uIt3bL5vmN71BWFNu2/CGfxj5UgPia0NDxomOi+zb73Fa9+1DMdRBCZUR+M2TAeQbXFzzQ0ZcOYtrb4jOnirf5wjp7+Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788836; c=relaxed/simple;
	bh=FKmZEOOj+8xe3zO8a1V3U71PZl7D+ukIzZ+enpM2r0A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H9xqQ68XKNtRDfz0TiA3RTzEejbCsdHjXTB2Ar1f8FBE3piPnj6N/8WGTMiXwuqBGyYaRYgSZW2NcCgwWwVTM2CLAXZI52wuplAbEdcJeYT3dhOYfPPCAuKsdGlAhEA8QfLb5eVaiueztLQxtzLcFhBqEDqCN0kAkTKrtDSJ69w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aqt/s8BR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFE4C4AF49;
	Wed, 19 Jun 2024 09:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718788836;
	bh=FKmZEOOj+8xe3zO8a1V3U71PZl7D+ukIzZ+enpM2r0A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aqt/s8BRPJSS1M01V9JHeMII64IVR1p02doAtxRFDlR/L+DPjSim/Pqt13AvzEHD9
	 dh3CcggMBedVDbdEC0Agp3EnRQ0dlwlCZQXKrGJul8lPzNpfEml1ggoyc2REh08bDh
	 fpeupgIz/feW1X98iKCWGIteeJVzmdCNfFePwBtSX16RUkBgq/tCo7be9T5hdJJiDx
	 KI1cQi2WgByDXQMUDYVnwpw/5EzJOnvEjngE+fSozFZc+RAiIdBjNCWchUHYDCUW5C
	 CNH7JgKsN3F3cCd3XTw3C9nm0YRJyLOpXKMN+tlrET2ToGJx3a0Ryk10wXY8qAKEfq
	 waMXB9N+j//OQ==
From: Chris Li <chrisl@kernel.org>
Date: Wed, 19 Jun 2024 02:20:30 -0700
Subject: [PATCH v3 2/2] mm: swap: mTHP allocate swap entries from nonfull
 list
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240619-swap-allocator-v3-2-e973a3102444@kernel.org>
References: <20240619-swap-allocator-v3-0-e973a3102444@kernel.org>
In-Reply-To: <20240619-swap-allocator-v3-0-e973a3102444@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>, 
 "Huang, Ying" <ying.huang@intel.com>, Kairui Song <kasong@tencent.com>, 
 Kalesh Singh <kaleshsingh@google.com>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Chris Li <chrisl@kernel.org>, 
 Barry Song <baohua@kernel.org>
X-Mailer: b4 0.13.0

Track the nonfull cluster as well as the empty cluster
on lists. Each order has one nonfull cluster list.

The cluster will remember which order it was used during
new cluster allocation.

When the cluster has free entry, add to the nonfull[order]
list.  When the free cluster list is empty, also allocate
from the nonempty list of that order.

This improves the mTHP swap allocation success rate.

There are limitations if the distribution of numbers of
different orders of mTHP changes a lot. e.g. there are a lot
of nonfull cluster assign to order A while later time there
are a lot of order B allocation while very little allocation
in order A. Currently the cluster used by order A will not
reused by order B unless the cluster is 100% empty.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 include/linux/swap.h |  4 ++++
 mm/swapfile.c        | 27 ++++++++++++++++++++++++---
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 690a04f06674..92613bb4a87b 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -254,9 +254,11 @@ struct swap_cluster_info {
 				 */
 	u16 count;
 	u8 flags;
+	u8 order;
 	struct list_head list;
 };
 #define CLUSTER_FLAG_FREE 1 /* This cluster is free */
+#define CLUSTER_FLAG_NONFULL 2 /* This cluster is on nonfull list */
 
 
 /*
@@ -295,6 +297,8 @@ struct swap_info_struct {
 	unsigned char *swap_map;	/* vmalloc'ed array of usage counts */
 	struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
 	struct list_head free_clusters; /* free clusters list */
+	struct list_head nonfull_clusters[SWAP_NR_ORDERS];
+					/* list of cluster that contains at least one free slot */
 	unsigned int lowest_bit;	/* index of first free in swap_map */
 	unsigned int highest_bit;	/* index of last free in swap_map */
 	unsigned int pages;		/* total of usable pages of swap */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 0b11c437f9cc..ba6676a4a8ef 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -361,8 +361,11 @@ static void swap_cluster_schedule_discard(struct swap_info_struct *si,
 
 static void __free_cluster(struct swap_info_struct *si, struct swap_cluster_info *ci)
 {
+	if (ci->flags & CLUSTER_FLAG_NONFULL)
+		list_move_tail(&ci->list, &si->free_clusters);
+	else
+		list_add_tail(&ci->list, &si->free_clusters);
 	ci->flags = CLUSTER_FLAG_FREE;
-	list_add_tail(&ci->list, &si->free_clusters);
 }
 
 /*
@@ -485,7 +488,12 @@ static void dec_cluster_info_page(struct swap_info_struct *p, struct swap_cluste
 	ci->count--;
 
 	if (!ci->count)
-		free_cluster(p, ci);
+		return free_cluster(p, ci);
+
+	if (!(ci->flags & CLUSTER_FLAG_NONFULL)) {
+		list_add_tail(&ci->list, &p->nonfull_clusters[ci->order]);
+		ci->flags |= CLUSTER_FLAG_NONFULL;
+	}
 }
 
 /*
@@ -542,10 +550,18 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 	cluster = this_cpu_ptr(si->percpu_cluster);
 	tmp = cluster->next[order];
 	if (tmp == SWAP_NEXT_INVALID) {
-		if (!list_empty(&si->free_clusters)) {
+		if (!list_empty(&si->nonfull_clusters[order])) {
+			ci = list_first_entry(&si->nonfull_clusters[order], struct swap_cluster_info, list);
+			list_del(&ci->list);
+			spin_lock(&ci->lock);
+			ci->flags = 0;
+			spin_unlock(&ci->lock);
+			tmp = (ci - si->cluster_info) * SWAPFILE_CLUSTER;
+		} else if (!list_empty(&si->free_clusters)) {
 			ci = list_first_entry(&si->free_clusters, struct swap_cluster_info, list);
 			list_del(&ci->list);
 			spin_lock(&ci->lock);
+			ci->order = order;
 			ci->flags = 0;
 			spin_unlock(&ci->lock);
 			tmp = (ci - si->cluster_info) * SWAPFILE_CLUSTER;
@@ -576,6 +592,7 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 				break;
 			tmp += nr_pages;
 		}
+		WARN_ONCE(ci->order != order, "expecting order %d got %d", order, ci->order);
 		unlock_cluster(ci);
 	}
 	if (tmp >= max) {
@@ -954,6 +971,7 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
 	ci = lock_cluster(si, offset);
 	memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
 	ci->count = 0;
+	ci->order = 0;
 	ci->flags = 0;
 	free_cluster(si, ci);
 	unlock_cluster(ci);
@@ -2898,6 +2916,9 @@ static int setup_swap_map_and_extents(struct swap_info_struct *p,
 	INIT_LIST_HEAD(&p->free_clusters);
 	INIT_LIST_HEAD(&p->discard_clusters);
 
+	for (i = 0; i < SWAP_NR_ORDERS; i++)
+		INIT_LIST_HEAD(&p->nonfull_clusters[i]);
+
 	for (i = 0; i < swap_header->info.nr_badpages; i++) {
 		unsigned int page_nr = swap_header->info.badpages[i];
 		if (page_nr == 0 || page_nr > swap_header->info.last_page)

-- 
2.45.2.627.g7a2c4fd464-goog


