Return-Path: <linux-kernel+bounces-188970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8337E8CE925
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 19:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345D31F21CCD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579A513048C;
	Fri, 24 May 2024 17:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UX/P+vhE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D8E1304A3
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 17:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716571052; cv=none; b=AL7G6yT8VyzrwAjCcuPfNDj8ELsDD+Mi5b+A05oOp3CAc+ELhhr0tWcK5wnFRThjqTCQMvwCsK/v6txJm1iNC19UQ0B9rOcZrxR0YyosmDkmRpMC872qqRoSrhEkcmkhpXW8GptlX4iWs7Wnme0RPgygH+9WhWaRA/J+L7dAeqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716571052; c=relaxed/simple;
	bh=TDa3pqk4OBaY1GRmVEGGKzMmBUluuroNy+ytnClUbpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FfUS6Pi/brcyPiS1/MFf7Ow83K7+f0VxNZzfJ8cb/RlyKMrot2wF1Nn+QDanV9J41vM4RrwEEFzdfC95mCf6mKGD5mR8wUlEns4seTIE7VCp9wTep0aM9/jOr1qBP50GuiWlWnC0UXfHhALkQrCkEFweFtPtWzznNUuu7eZ1Vz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UX/P+vhE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A68C4AF08;
	Fri, 24 May 2024 17:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716571051;
	bh=TDa3pqk4OBaY1GRmVEGGKzMmBUluuroNy+ytnClUbpo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UX/P+vhEw9dIOFUzn2jQQTmq6HFKnwx6c0OjKQ63wRYEZeLU3Ri5wEKCzRoIbEM7q
	 dQnyk5EqxLW3Cd7F/X0ksDLWKKL+Qiob2T13x/XAMNa1YH9EY1z43EZhtaZzlI5W2Q
	 jKlG8D+NPX+lhGb33tNdV8rMx+mGKVBSGgBtEW+HKb/SQfBLFr6sWKYYeQdGAK2g3T
	 jTPsz3gQ5xDWrQVNnHQDcPOrGwU6GjkstNSeRGoCh7uF0Ag8W+EjGkX8uBdfn/Xky4
	 6QeggWr4n83ARyedUCY5a3yWcXWXwLB1Yb8PVBX7SXyRHS7p9gUq0TvCUA4GMV3Cqj
	 jvov4OikiN/kw==
From: Chris Li <chrisl@kernel.org>
Date: Fri, 24 May 2024 10:17:19 -0700
Subject: [PATCH 2/2] mm: swap: mTHP allocate swap entries from nonfull list
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240524-swap-allocator-v1-2-47861b423b26@kernel.org>
References: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
In-Reply-To: <20240524-swap-allocator-v1-0-47861b423b26@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <kasong@tencent.com>, Ryan Roberts <ryan.roberts@arm.com>, 
 "Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, Chris Li <chrisl@kernel.org>, 
 Barry Song <baohua@kernel.org>
X-Mailer: b4 0.12.4

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

This situation is best addressed by the longer term "swap
buddy allocator", in future patches.
---
 include/linux/swap.h |  4 ++++
 mm/swapfile.c        | 25 +++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 0d3906eff3c9..1b7f0794b9bf 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -255,10 +255,12 @@ struct swap_cluster_info {
 				 * cluster
 				 */
 	unsigned int count:16;
+	unsigned int order:8;
 	unsigned int flags:8;
 	struct list_head next;
 };
 #define CLUSTER_FLAG_FREE 1 /* This cluster is free */
+#define CLUSTER_FLAG_NONFULL 2 /* This cluster is on nonfull list */
 
 
 /*
@@ -297,6 +299,8 @@ struct swap_info_struct {
 	unsigned char *swap_map;	/* vmalloc'ed array of usage counts */
 	struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
 	struct list_head free_clusters; /* free clusters list */
+	struct list_head nonfull_clusters[SWAP_NR_ORDERS];
+					/* list of cluster that contains at least one free slot */
 	unsigned int lowest_bit;	/* index of first free in swap_map */
 	unsigned int highest_bit;	/* index of last free in swap_map */
 	unsigned int pages;		/* total of usable pages of swap */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 205a60c5f9cb..51923aba500e 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -363,8 +363,11 @@ static void swap_cluster_schedule_discard(struct swap_info_struct *si,
 
 static void __free_cluster(struct swap_info_struct *si, struct swap_cluster_info *ci)
 {
+	if (ci->flags & CLUSTER_FLAG_NONFULL)
+		list_move_tail(&ci->next, &si->free_clusters);
+	else
+		list_add_tail(&ci->next, &si->free_clusters);
 	ci->flags = CLUSTER_FLAG_FREE;
-	list_add_tail(&ci->next, &si->free_clusters);
 }
 
 /*
@@ -486,7 +489,12 @@ static void dec_cluster_info_page(struct swap_info_struct *p, struct swap_cluste
 	ci->count--;
 
 	if (!ci->count)
-		free_cluster(p, ci);
+		return free_cluster(p, ci);
+
+	if (!(ci->flags & CLUSTER_FLAG_NONFULL)) {
+		list_add_tail(&ci->next, &p->nonfull_clusters[ci->order]);
+		ci->flags |= CLUSTER_FLAG_NONFULL;
+	}
 }
 
 /*
@@ -547,6 +555,14 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 			ci = list_first_entry(&si->free_clusters, struct swap_cluster_info, next);
 			list_del(&ci->next);
 			spin_lock(&ci->lock);
+			ci->order = order;
+			ci->flags = 0;
+			spin_unlock(&ci->lock);
+			tmp = (ci - si->cluster_info) * SWAPFILE_CLUSTER;
+		} else if (!list_empty(&si->nonfull_clusters[order])) {
+			ci = list_first_entry(&si->nonfull_clusters[order], struct swap_cluster_info, next);
+			list_del(&ci->next);
+			spin_lock(&ci->lock);
 			ci->flags = 0;
 			spin_unlock(&ci->lock);
 			tmp = (ci - si->cluster_info) * SWAPFILE_CLUSTER;
@@ -578,6 +594,7 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 				break;
 			tmp += nr_pages;
 		}
+		WARN_ONCE(ci->order != order, "expecting order %d got %d", order, ci->order);
 		unlock_cluster(ci);
 	}
 	if (tmp >= max) {
@@ -956,6 +973,7 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
 	ci = lock_cluster(si, offset);
 	memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
 	ci->count = 0;
+	ci->order = 0;
 	ci->flags = 0;
 	free_cluster(si, ci);
 	unlock_cluster(ci);
@@ -2882,6 +2900,9 @@ static int setup_swap_map_and_extents(struct swap_info_struct *p,
 	INIT_LIST_HEAD(&p->free_clusters);
 	INIT_LIST_HEAD(&p->discard_clusters);
 
+	for (i = 0; i < SWAP_NR_ORDERS; i++)
+		INIT_LIST_HEAD(&p->nonfull_clusters[i]);
+
 	for (i = 0; i < swap_header->info.nr_badpages; i++) {
 		unsigned int page_nr = swap_header->info.badpages[i];
 		if (page_nr == 0 || page_nr > swap_header->info.last_page)

-- 
2.45.1.288.g0e0cd299f1-goog


