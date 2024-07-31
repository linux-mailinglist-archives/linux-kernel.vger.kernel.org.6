Return-Path: <linux-kernel+bounces-268635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FE5942727
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF4D5283FCA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 06:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5431A71E8;
	Wed, 31 Jul 2024 06:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="itCPSWVG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBCF1A4F19
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722408564; cv=none; b=VysX9X2Ruikok/bs+aGnmPD0PvGASU41zZtu7abgwW7UgiRh+Zg2kNfjKM1yBA1nRDPDlQL1taf40z8Z5UZmi8YtklgkXteeRUQ8lmJO85DYBDD8mpNabDVTdq5oRQBAczx2T8Q+WNYgmj4NspgizYGYxoFx9aO1C6mQZasULPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722408564; c=relaxed/simple;
	bh=LMjsqNTIwXS2shaii6dMa6mkdJXeL7A42/t9cu9stO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TwZZVcPTv+3fcgLSIa4XMIrSwdjuQLZRSTAk+WtOGBNAuXS2Hoz/sPtYVkQFnEfsi+otFsyRFWqDl33aNwEkfU65/fRqYfZBCgDhbPCV8n83AUZPyQfG1c0B25Z1yYD6N/vghp4LVhcxCqKJPErCsHXwQuIbXMjwYRtWr4TO2YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=itCPSWVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4391C4AF14;
	Wed, 31 Jul 2024 06:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722408564;
	bh=LMjsqNTIwXS2shaii6dMa6mkdJXeL7A42/t9cu9stO0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=itCPSWVG1mWJFeRuT4Y6xvyqL/gB+zuPWdzR33gpL1Asheo80VUsMCQHBVfoZArOk
	 A61aAkf+gAfsUAp6AjgSvGn71FnPDV8s4sgoFmId49e2kUoTzC3ziLTPzqiUhM4Sn9
	 i0vulb+sGgvlwyMr9an1j5zyq4a5NN5E37YRkg1FJTzPgTo6FZNIFwMUgdAP1KcRMy
	 G+kMbs3mIKIMdqYCzCbyamHCcNTZNoDebnkDkKEnhPjPVFWespNM55cOxnPgHrG09Y
	 4ZRt5i4lV1uxB+J/7BDfyDBItiKzUJEv6qUOdjqdxgIy1zIJjYIG/LhUmvdNj0eVgN
	 dHPh1Bf9yuX1g==
From: chrisl@kernel.org
Date: Tue, 30 Jul 2024 23:49:19 -0700
Subject: [PATCH v5 7/9] mm: swap: add a fragment cluster list
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240730-swap-allocator-v5-7-cb9c148b9297@kernel.org>
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

Now swap cluster allocator arranges the clusters in LRU style, so the
"cold" cluster stay at the head of nonfull lists are the ones that were
used for allocation long time ago and still partially occupied. So if
allocator can't find enough contiguous slots to satisfy an high order
allocation, it's unlikely there will be slot being free on them to
satisfy the allocation, at least in a short period.

As a result, nonfull cluster scanning will waste time repeatly scanning
the unusable head of the list.

Also, multiple CPUs could content on the same head cluster of nonfull
list. Unlike free clusters which are removed from the list when any
CPU starts using it, nonfull cluster stays on the head.

So introduce a new list frag list, all scanned nonfull clusters will be
moved to this list. Both for avoiding repeated scanning and contention.

Frag list is still used as fallback for allocations, so if one CPU
failed to allocate one order of slots, it can still steal other CPU's
clusters. And order 0 will favor the fragmented clusters to better
protect nonfull clusters

If any slots on a fragment list are being freed, move the fragment list
back to nonfull list indicating it worth another scan on the cluster.
Compared to scan upon freeing a slot, this keep the scanning lazy and
save some CPU if there are still other clusters to use.

It may seems unneccessay to keep the fragmented cluster on list at all
if they can't be used for specific order allocation. But this will
start to make sense once reclaim dring scanning is ready.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 include/linux/swap.h |  3 +++
 mm/swapfile.c        | 41 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 6716ef236766..5a14b6c65949 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -259,6 +259,7 @@ struct swap_cluster_info {
 };
 #define CLUSTER_FLAG_FREE 1 /* This cluster is free */
 #define CLUSTER_FLAG_NONFULL 2 /* This cluster is on nonfull list */
+#define CLUSTER_FLAG_FRAG 4 /* This cluster is on nonfull list */
 
 /*
  * The first page in the swap file is the swap header, which is always marked
@@ -299,6 +300,8 @@ struct swap_info_struct {
 	struct list_head free_clusters; /* free clusters list */
 	struct list_head nonfull_clusters[SWAP_NR_ORDERS];
 					/* list of cluster that contains at least one free slot */
+	struct list_head frag_clusters[SWAP_NR_ORDERS];
+					/* list of cluster that are fragmented or contented */
 	unsigned int lowest_bit;	/* index of first free in swap_map */
 	unsigned int highest_bit;	/* index of last free in swap_map */
 	unsigned int pages;		/* total of usable pages of swap */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 4c0fc0409d3c..eb3e387e86b2 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -572,7 +572,10 @@ static void dec_cluster_info_page(struct swap_info_struct *p,
 
 	if (!(ci->flags & CLUSTER_FLAG_NONFULL)) {
 		VM_BUG_ON(ci->flags & CLUSTER_FLAG_FREE);
-		list_add_tail(&ci->list, &p->nonfull_clusters[ci->order]);
+		if (ci->flags & CLUSTER_FLAG_FRAG)
+			list_move_tail(&ci->list, &p->nonfull_clusters[ci->order]);
+		else
+			list_add_tail(&ci->list, &p->nonfull_clusters[ci->order]);
 		ci->flags = CLUSTER_FLAG_NONFULL;
 	}
 }
@@ -610,7 +613,8 @@ static inline void cluster_alloc_range(struct swap_info_struct *si, struct swap_
 	ci->count += nr_pages;
 
 	if (ci->count == SWAPFILE_CLUSTER) {
-		VM_BUG_ON(!(ci->flags & (CLUSTER_FLAG_FREE | CLUSTER_FLAG_NONFULL)));
+		VM_BUG_ON(!(ci->flags &
+			  (CLUSTER_FLAG_FREE | CLUSTER_FLAG_NONFULL | CLUSTER_FLAG_FRAG)));
 		list_del(&ci->list);
 		ci->flags = 0;
 	}
@@ -666,6 +670,7 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 	struct percpu_cluster *cluster;
 	struct swap_cluster_info *ci, *n;
 	unsigned int offset, found = 0;
+	LIST_HEAD(fraged);
 
 new_cluster:
 	lockdep_assert_held(&si->lock);
@@ -686,13 +691,29 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 
 	if (order < PMD_ORDER) {
 		list_for_each_entry_safe(ci, n, &si->nonfull_clusters[order], list) {
+			list_move_tail(&ci->list, &fraged);
+			ci->flags = CLUSTER_FLAG_FRAG;
 			offset = alloc_swap_scan_cluster(si, cluster_offset(si, ci),
 							 &found, order, usage);
 			if (found)
-				goto done;
+				break;
 		}
+
+		if (!found) {
+			list_for_each_entry_safe(ci, n, &si->frag_clusters[order], list) {
+				offset = alloc_swap_scan_cluster(si, cluster_offset(si, ci),
+								 &found, order, usage);
+				if (found)
+					break;
+			}
+		}
+
+		list_splice_tail(&fraged, &si->frag_clusters[order]);
 	}
 
+	if (found)
+		goto done;
+
 	if (!list_empty(&si->discard_clusters)) {
 		/*
 		 * we don't have free cluster but have some clusters in
@@ -706,7 +727,17 @@ static unsigned long cluster_alloc_swap_entry(struct swap_info_struct *si, int o
 	if (order)
 		goto done;
 
+	/* Order 0 stealing from higher order */
 	for (int o = 1; o < PMD_ORDER; o++) {
+		if (!list_empty(&si->frag_clusters[o])) {
+			ci = list_first_entry(&si->frag_clusters[o],
+					      struct swap_cluster_info, list);
+			offset = alloc_swap_scan_cluster(si, cluster_offset(si, ci), &found,
+							 0, usage);
+			VM_BUG_ON(!found);
+			goto done;
+		}
+
 		if (!list_empty(&si->nonfull_clusters[o])) {
 			ci = list_first_entry(&si->nonfull_clusters[o], struct swap_cluster_info,
 					      list);
@@ -3019,8 +3050,10 @@ static int setup_swap_map_and_extents(struct swap_info_struct *p,
 	INIT_LIST_HEAD(&p->free_clusters);
 	INIT_LIST_HEAD(&p->discard_clusters);
 
-	for (i = 0; i < SWAP_NR_ORDERS; i++)
+	for (i = 0; i < SWAP_NR_ORDERS; i++) {
 		INIT_LIST_HEAD(&p->nonfull_clusters[i]);
+		INIT_LIST_HEAD(&p->frag_clusters[i]);
+	}
 
 	for (i = 0; i < swap_header->info.nr_badpages; i++) {
 		unsigned int page_nr = swap_header->info.badpages[i];

-- 
2.46.0.rc1.232.g9752f9e123-goog


