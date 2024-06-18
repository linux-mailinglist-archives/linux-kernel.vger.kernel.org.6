Return-Path: <linux-kernel+bounces-220332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D6B90DFD8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 01:27:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 234C51C22EBD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 23:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11B81891B3;
	Tue, 18 Jun 2024 23:27:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECBA23759
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 23:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718753226; cv=none; b=mV6CrHuowSjYXbjojOz1Gfo1r2yUF6sBO9BNHLHfs36PHOm75Z/RnQhPBXfsRUkPo7AZbA5zxoGn1K8PalU+BP/GNmIq4TZQPez0RLpgr8NqdWl1pryaRmRg9UeA3h2CKrkxH6tcXzGWw3Imdn4+nmVnFOUdIwoIplG5yd6RNF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718753226; c=relaxed/simple;
	bh=OvWkGAiTCnldUmxHd3cu95ToTjRntwaLtWx2AD+68yM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEvNqa5IBPK1N6FQlFPZCSgV2cGQ1AlFqOsLJyS7Qwh3BYC+iRLgaOM2PARmhPa2WPp40WGz0OXJ63lTHvfWndkr2p6yWodvOdj0dj3SpaujlLvbglJwDgE2TkDQ8E76aXjzedpjdF/gNaVs9P9ZSjrf0ffs8ZWCHJixMXu2dcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D21A1477;
	Tue, 18 Jun 2024 16:27:28 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED9C93F64C;
	Tue, 18 Jun 2024 16:27:01 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	Barry Song <baohua@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1 3/5] mm: swap: Track allocation order for clusters
Date: Wed, 19 Jun 2024 00:26:43 +0100
Message-ID: <20240618232648.4090299-4-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240618232648.4090299-1-ryan.roberts@arm.com>
References: <20240618232648.4090299-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an `order` field to `struct swap_cluster_info`, which applies to
allocated clusters (i.e. those not on the free list) and tracks the swap
entry order that the cluster should be used to allocate. A future commit
will use this information to scan partially filled clusters to find
appropriate free swap entries for allocation. Note that it is still
possible that order-0 swap entries will be allocated in clusters that
indicate a higher order due to the order-0 scanning mechanism.

The maximum order we ever expect to see is 13 - PMD-size on arm64 with
64K base pages. 13 fits into 4 bits, so let's steal 4 unused flags bits
for this purpose to avoid making `struct swap_cluster_info` any bigger.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 include/linux/swap.h |  3 ++-
 mm/swapfile.c        | 24 +++++++++++++++---------
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 66566251ba31..2a40fe02d281 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -255,7 +255,8 @@ struct swap_cluster_info {
 				 * cluster
 				 */
 	unsigned int data:24;
-	unsigned int flags:8;
+	unsigned int flags:4;
+	unsigned int order:4;
 };
 #define CLUSTER_FLAG_FREE 1 /* This cluster is free */
 #define CLUSTER_FLAG_NEXT_NULL 2 /* This cluster has no next cluster */
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 30e79739dfdc..7b13f02a7ac2 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -307,11 +307,13 @@ static inline void cluster_set_count(struct swap_cluster_info *info,
 	info->data = c;
 }

-static inline void cluster_set_count_flag(struct swap_cluster_info *info,
-					 unsigned int c, unsigned int f)
+static inline void cluster_set_count_flag_order(struct swap_cluster_info *info,
+						unsigned int c, unsigned int f,
+						unsigned int o)
 {
 	info->flags = f;
 	info->data = c;
+	info->order = o;
 }

 static inline unsigned int cluster_next(struct swap_cluster_info *info)
@@ -330,6 +332,7 @@ static inline void cluster_set_next_flag(struct swap_cluster_info *info,
 {
 	info->flags = f;
 	info->data = n;
+	info->order = 0;
 }

 static inline bool cluster_is_free(struct swap_cluster_info *info)
@@ -346,6 +349,7 @@ static inline void cluster_set_null(struct swap_cluster_info *info)
 {
 	info->flags = CLUSTER_FLAG_NEXT_NULL;
 	info->data = 0;
+	info->order = 0;
 }

 static inline struct swap_cluster_info *lock_cluster(struct swap_info_struct *si,
@@ -521,13 +525,14 @@ static void swap_users_ref_free(struct percpu_ref *ref)
 	complete(&si->comp);
 }

-static void alloc_cluster(struct swap_info_struct *si, unsigned long idx)
+static void alloc_cluster(struct swap_info_struct *si, unsigned long idx,
+			  int order)
 {
 	struct swap_cluster_info *ci = si->cluster_info;

 	VM_BUG_ON(cluster_list_first(&si->free_clusters) != idx);
 	cluster_list_del_first(&si->free_clusters, ci);
-	cluster_set_count_flag(ci + idx, 0, 0);
+	cluster_set_count_flag_order(ci + idx, 0, 0, order);
 }

 static void free_cluster(struct swap_info_struct *si, unsigned long idx)
@@ -556,14 +561,15 @@ static void free_cluster(struct swap_info_struct *si, unsigned long idx)
  */
 static void add_cluster_info_page(struct swap_info_struct *p,
 	struct swap_cluster_info *cluster_info, unsigned long page_nr,
-	unsigned long count)
+	int order)
 {
 	unsigned long idx = page_nr / SWAPFILE_CLUSTER;
+	unsigned long count = 1 << order;

 	if (!cluster_info)
 		return;
 	if (cluster_is_free(&cluster_info[idx]))
-		alloc_cluster(p, idx);
+		alloc_cluster(p, idx, order);

 	VM_BUG_ON(cluster_count(&cluster_info[idx]) + count > SWAPFILE_CLUSTER);
 	cluster_set_count(&cluster_info[idx],
@@ -577,7 +583,7 @@ static void add_cluster_info_page(struct swap_info_struct *p,
 static void inc_cluster_info_page(struct swap_info_struct *p,
 	struct swap_cluster_info *cluster_info, unsigned long page_nr)
 {
-	add_cluster_info_page(p, cluster_info, page_nr, 1);
+	add_cluster_info_page(p, cluster_info, page_nr, 0);
 }

 /*
@@ -964,7 +970,7 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 			goto done;
 	}
 	memset(si->swap_map + offset, usage, nr_pages);
-	add_cluster_info_page(si, si->cluster_info, offset, nr_pages);
+	add_cluster_info_page(si, si->cluster_info, offset, order);
 	unlock_cluster(ci);

 	swap_range_alloc(si, offset, nr_pages);
@@ -1060,7 +1066,7 @@ static void swap_free_cluster(struct swap_info_struct *si, unsigned long idx)

 	ci = lock_cluster(si, offset);
 	memset(si->swap_map + offset, 0, SWAPFILE_CLUSTER);
-	cluster_set_count_flag(ci, 0, 0);
+	cluster_set_count_flag_order(ci, 0, 0, 0);
 	free_cluster(si, idx);
 	unlock_cluster(ci);
 	swap_range_free(si, offset, SWAPFILE_CLUSTER);
--
2.43.0


