Return-Path: <linux-kernel+bounces-268630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B06942721
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 08:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BC1E283E66
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 06:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B1A1A4B44;
	Wed, 31 Jul 2024 06:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fm0jMWWG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E390516C84A
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722408562; cv=none; b=CmL4gobPDx31GtH5CvmV/tFYeX00OuMnVB6ucdJNdRPq4DxwrPQ99op8utAiutkat9SGfrt/Dq+cATi9JmHTYBskW4KEwLpgmXm0vyBgQPAsE1rU2MOUvbDKL/WZSbb+IcoUtjQlLxkHyj7UB8Yw2I7pA65qDXxFXUp42ZPIMzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722408562; c=relaxed/simple;
	bh=hsQxDCZrtRWDWaDs5IVwKPpQSb8Rg3k3cBHZomxM8ak=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sDlRDOzQkNxuKrPXzZ4tN42Nk3WlphsVBUO35+DzqCpHoTIM1t0FxKYY/JFMpChWjX79GOV35VRkzCoVqO4Fjo7PSuvO8YhxgbMX1t4aYTOCeFPH3eFfTqhkpuWjUuYGJ82i8OMKIzP81qf9J4EkhEw3Nukw8fvXO+Fm1CEHN2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fm0jMWWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343FAC116B1;
	Wed, 31 Jul 2024 06:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722408561;
	bh=hsQxDCZrtRWDWaDs5IVwKPpQSb8Rg3k3cBHZomxM8ak=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Fm0jMWWG/eAQp2Nr2ryJaZVToF680ojI3W1usxVCU4dItPLJFCXocEnliEzCRHs4m
	 p6QbaxODPsJ7FvmYN2BjjA0YjJ/Sd6rNIBOoxhbKo85vLiD/mzXv0rQnrI2Nu0lAOw
	 BmtbMIw038i/mghBSve4dnQskSg11vp2sOytVDfgYVa5HQuRztLAQ1rOF4f4rAGf32
	 WAeV6y69sRb+lNtNXKhHemHu7QHS5QKqi8fy9YqeuA19/gAcTKp1FIG8hnwdqc3C1X
	 ZwE9hiHTcF8mC7aNdNM/FtCH+Uk7d0yUYUdI3INqBO0ogYWYmvowlwEcDEakuo9zW1
	 womIy2jawCs9g==
From: Chris Li <chrisl@kernel.org>
Date: Tue, 30 Jul 2024 23:49:14 -0700
Subject: [PATCH v5 2/9] mm: swap: mTHP allocate swap entries from nonfull
 list
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240730-swap-allocator-v5-2-cb9c148b9297@kernel.org>
References: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
In-Reply-To: <20240730-swap-allocator-v5-0-cb9c148b9297@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <kasong@tencent.com>, Hugh Dickins <hughd@google.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
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
 mm/swapfile.c        | 38 +++++++++++++++++++++++++++++++++++---
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index edafd52d7ac4..6716ef236766 100644
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
  * The first page in the swap file is the swap header, which is always marked
@@ -295,6 +297,8 @@ struct swap_info_struct {
 	unsigned long *zeromap;		/* vmalloc'ed bitmap to track zero pages */
 	struct swap_cluster_info *cluster_info; /* cluster info. Only for SSD */
 	struct list_head free_clusters; /* free clusters list */
+	struct list_head nonfull_clusters[SWAP_NR_ORDERS];
+					/* list of cluster that contains at least one free slot */
 	unsigned int lowest_bit;	/* index of first free in swap_map */
 	unsigned int highest_bit;	/* index of last free in swap_map */
 	unsigned int pages;		/* total of usable pages of swap */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index bceead7f9e3c..dcf09eb549db 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -361,14 +361,22 @@ static void swap_cluster_schedule_discard(struct swap_info_struct *si,
 	memset(si->swap_map + idx * SWAPFILE_CLUSTER,
 			SWAP_MAP_BAD, SWAPFILE_CLUSTER);
 
-	list_add_tail(&ci->list, &si->discard_clusters);
+	VM_BUG_ON(ci->flags & CLUSTER_FLAG_FREE);
+	if (ci->flags & CLUSTER_FLAG_NONFULL)
+		list_move_tail(&ci->list, &si->discard_clusters);
+	else
+		list_add_tail(&ci->list, &si->discard_clusters);
+	ci->flags = 0;
 	schedule_work(&si->discard_work);
 }
 
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
@@ -491,8 +499,15 @@ static void dec_cluster_info_page(struct swap_info_struct *p, struct swap_cluste
 	VM_BUG_ON(ci->count == 0);
 	ci->count--;
 
-	if (!ci->count)
+	if (!ci->count) {
 		free_cluster(p, ci);
+		return;
+	}
+
+	if (!(ci->flags & CLUSTER_FLAG_NONFULL)) {
+		list_add_tail(&ci->list, &p->nonfull_clusters[ci->order]);
+		ci->flags |= CLUSTER_FLAG_NONFULL;
+	}
 }
 
 /*
@@ -553,6 +568,19 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 	if (tmp == SWAP_NEXT_INVALID) {
 		if (!list_empty(&si->free_clusters)) {
 			ci = list_first_entry(&si->free_clusters, struct swap_cluster_info, list);
+			list_del(&ci->list);
+			spin_lock(&ci->lock);
+			ci->order = order;
+			ci->flags = 0;
+			spin_unlock(&ci->lock);
+			tmp = cluster_index(si, ci) * SWAPFILE_CLUSTER;
+		} else if (!list_empty(&si->nonfull_clusters[order])) {
+			ci = list_first_entry(&si->nonfull_clusters[order],
+					      struct swap_cluster_info, list);
+			list_del(&ci->list);
+			spin_lock(&ci->lock);
+			ci->flags = 0;
+			spin_unlock(&ci->lock);
 			tmp = cluster_index(si, ci) * SWAPFILE_CLUSTER;
 		} else if (!list_empty(&si->discard_clusters)) {
 			/*
@@ -967,6 +995,7 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)
 	ci = lock_cluster(si, offset);
 	memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
 	ci->count = 0;
+	ci->order = 0;
 	ci->flags = 0;
 	free_cluster(si, ci);
 	unlock_cluster(ci);
@@ -2922,6 +2951,9 @@ static int setup_swap_map_and_extents(struct swap_info_struct *p,
 	INIT_LIST_HEAD(&p->free_clusters);
 	INIT_LIST_HEAD(&p->discard_clusters);
 
+	for (i = 0; i < SWAP_NR_ORDERS; i++)
+		INIT_LIST_HEAD(&p->nonfull_clusters[i]);
+
 	for (i = 0; i < swap_header->info.nr_badpages; i++) {
 		unsigned int page_nr = swap_header->info.badpages[i];
 		if (page_nr == 0 || page_nr > swap_header->info.last_page)

-- 
2.46.0.rc1.232.g9752f9e123-goog


