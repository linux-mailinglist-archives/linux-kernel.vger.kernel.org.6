Return-Path: <linux-kernel+bounces-215609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AAE9094DA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 01:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7171B287572
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 23:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D546188CBA;
	Fri, 14 Jun 2024 23:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmxxD1r2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB9F187565
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 23:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718408894; cv=none; b=Jnzi/y3UFjA3DBK/VSazuhw/99df53It9NzRqqk3Vvtyke1V6b9xN87XLmJLR0S/vDgFbC3wEqiBv5XcYHFwJw0sPcobqGksymicu2yI55EI5vzfflXMp3Dg4utxphYAX5jtbgq9OogYUQHM3XFhHivceqlWYDEC8lsmCEWBItY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718408894; c=relaxed/simple;
	bh=uzaDyQbVWdU/yPUf+0A3dOmYPMQFRQEdZUccMpk/Tp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ulcxOEQ6TOzQj9OOKNm+yiMKvMD7lyUEL6NnU+VxBOIOfQdnDSt93cyRFbqqwCrJ/Mdyi8vVSnIU28T8EBEUatq90HTNyxsyjTBoZUhUiAMDcjnnpx7KMCvbiAThXM3nMUftvvKi5RRgp/tTD48k2mPWSJbECApKerxnLwetqsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmxxD1r2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C7BC4AF49;
	Fri, 14 Jun 2024 23:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718408894;
	bh=uzaDyQbVWdU/yPUf+0A3dOmYPMQFRQEdZUccMpk/Tp8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SmxxD1r2JehMSaGbsPEe2zZ9wuu30o7zHZp26vWiDGo59UpYQeaZs+f/DDbA/Izu9
	 tw81hvy8NKtK8dsGW592yHXtzwDbe/126ckg/a4ke9xJMz/v9TU/INheZk/yr15n7+
	 S6cJk52inMqBK2wODihGxU5Nvsk49qvS3lVOiFVwbZe+6Ex0jECxJl/scpmIZKsU9A
	 LtjqdWrLQrAQKYTqnkEDsTK7Bll3T8Dp6CGSh+iSrpMfL6H1Z6clqlsCKAzk9orubu
	 PB27De6gBxw1tHjjb2AENdoLOozCDVqBFE7WdZA13Kkw/a6lV/spEHdfzyk0p4dlQZ
	 DQuqJne/ub1Uw==
From: Chris Li <chrisl@kernel.org>
Date: Fri, 14 Jun 2024 16:48:08 -0700
Subject: [PATCH v2 2/2] mm: swap: mTHP allocate swap entries from nonfull
 list
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240614-swap-allocator-v2-2-2a513b4a7f2f@kernel.org>
References: <20240614-swap-allocator-v2-0-2a513b4a7f2f@kernel.org>
In-Reply-To: <20240614-swap-allocator-v2-0-2a513b4a7f2f@kernel.org>
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
list. Allocation use the nonfull cluster list before using
the the free cluster list.

This improves the mTHP swap allocation success rate.

There are limitations if the distribution of numbers of
different orders of mTHP changes a lot. e.g. there are a lot
of nonfull cluster assign to order A while later time there
are a lot of order B allocation while very little allocation
in order A. Currently the cluster used by order A will not
reused by order B unless the cluster is 100% empty.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 include/linux/swap.h |  9 +++++++--
 mm/swapfile.c        | 49 ++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index cd9154a3e934..fcb21f9883a5 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -245,18 +245,21 @@ enum {
  */
 struct swap_cluster_info {
 	spinlock_t lock;	/*
-				 * Protect swap_cluster_info count and state
-				 * field and swap_info_struct->swap_map
+				 * Protect swap_cluster_info bitfields
+				 * and swap_info_struct->swap_map
 				 * elements correspond to the swap
 				 * cluster
 				 */
 	unsigned int count:12;
 	unsigned int state:3;
+	unsigned int order:4;
 	struct list_head list;	/* Protected by swap_info_struct->lock */
 };
 
 #define CLUSTER_STATE_FREE	1 /* This cluster is free */
 #define CLUSTER_STATE_PER_CPU	2 /* This cluster on per_cpu_cluster  */
+#define CLUSTER_STATE_SCANNED	3 /* This cluster off per_cpu_cluster */
+#define CLUSTER_STATE_NONFULL	4 /* This cluster is on nonfull list */
 
 
 /*
@@ -295,6 +298,8 @@ struct swap_info_struct {
 	unsigned char *swap_map;	/* vmalloc'ed array of usage counts */
 	struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
 	struct list_head free_clusters; /* free clusters list */
+	struct list_head nonfull_clusters[SWAP_NR_ORDERS];
+					/* list of cluster that contains at least one free slot */
 	unsigned int lowest_bit;	/* index of first free in swap_map */
 	unsigned int highest_bit;	/* index of last free in swap_map */
 	unsigned int pages;		/* total of usable pages of swap */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 2f878b374349..85a96178fd27 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -361,8 +361,12 @@ static void swap_cluster_schedule_discard(struct swap_info_struct *si,
 
 static void __free_cluster(struct swap_info_struct *si, struct swap_cluster_info *ci)
 {
+	if (ci->state == CLUSTER_STATE_NONFULL)
+		list_move_tail(&ci->list, &si->free_clusters);
+	else
+		list_add_tail(&ci->list, &si->free_clusters);
 	ci->state = CLUSTER_STATE_FREE;
-	list_add_tail(&ci->list, &si->free_clusters);
+	ci->order = 0;
 }
 
 /*
@@ -484,7 +488,12 @@ static void dec_cluster_info_page(struct swap_info_struct *p, struct swap_cluste
 	ci->count--;
 
 	if (!ci->count)
-		free_cluster(p, ci);
+		return free_cluster(p, ci);
+
+	if (ci->state == CLUSTER_STATE_SCANNED) {
+		list_add_tail(&ci->list, &p->nonfull_clusters[ci->order]);
+		ci->state = CLUSTER_STATE_NONFULL;
+	}
 }
 
 /*
@@ -535,17 +544,25 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 	unsigned int nr_pages = 1 << order;
 	struct percpu_cluster *cluster;
 	struct swap_cluster_info *ci;
-	unsigned int tmp, max;
+	unsigned int tmp, max, found = 0;
 
 new_cluster:
 	cluster = this_cpu_ptr(si->percpu_cluster);
 	tmp = cluster->next[order];
 	if (tmp == SWAP_NEXT_INVALID) {
-		if (!list_empty(&si->free_clusters)) {
+		if (!list_empty(&si->nonfull_clusters[order])) {
+			ci = list_first_entry(&si->nonfull_clusters[order], struct swap_cluster_info, list);
+			list_del(&ci->list);
+			spin_lock(&ci->lock);
+			ci->state = CLUSTER_STATE_PER_CPU;
+			spin_unlock(&ci->lock);
+			tmp = (ci - si->cluster_info) * SWAPFILE_CLUSTER;
+		} else if (!list_empty(&si->free_clusters)) {
 			ci = list_first_entry(&si->free_clusters, struct swap_cluster_info, list);
 			list_del(&ci->list);
 			spin_lock(&ci->lock);
 			ci->state = CLUSTER_STATE_PER_CPU;
+			ci->order = order;
 			spin_unlock(&ci->lock);
 			tmp = (ci - si->cluster_info) * SWAPFILE_CLUSTER;
 		} else if (!list_empty(&si->discard_clusters)) {
@@ -570,21 +587,24 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 	max = min_t(unsigned long, si->max, ALIGN(tmp + 1, SWAPFILE_CLUSTER));
 	if (tmp < max) {
 		ci = lock_cluster(si, tmp);
-		while (tmp < max) {
+		while (!found && tmp < max) {
 			if (swap_range_empty(si->swap_map, tmp, nr_pages))
-				break;
+				found = tmp;
 			tmp += nr_pages;
 		}
+		if (tmp >= max) {
+			ci->state = CLUSTER_STATE_SCANNED;
+			cluster->next[order] = SWAP_NEXT_INVALID;
+		} else
+			cluster->next[order] = tmp;
+		WARN_ONCE(ci->order != order, "expecting order %d got %d", order, ci->order);
 		unlock_cluster(ci);
 	}
-	if (tmp >= max) {
-		cluster->next[order] = SWAP_NEXT_INVALID;
+	if (!found)
 		goto new_cluster;
-	}
-	*offset = tmp;
-	*scan_base = tmp;
-	tmp += nr_pages;
-	cluster->next[order] = tmp < max ? tmp : SWAP_NEXT_INVALID;
+
+	*offset = found;
+	*scan_base = found;
 	return true;
 }
 
@@ -2896,6 +2916,9 @@ static int setup_swap_map_and_extents(struct swap_info_struct *p,
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


