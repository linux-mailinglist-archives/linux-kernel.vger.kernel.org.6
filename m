Return-Path: <linux-kernel+bounces-240960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFC5927516
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CA481F24309
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F061AED32;
	Thu,  4 Jul 2024 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TiIL5X24"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38B31AC44A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 11:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720092321; cv=none; b=hdiyJtgc4D113SsHYoHM52K3Tx2eMy/TNwX161PXO/R6qxpdh9q6BlScOQ+h1IAFLEdcKz0+oyFG3qlCKQyE4TxKZfoG0EwnYjqS9kjOXabUJKGlIbjva/nDjbFaCRdGITmh7zefiWh2VfuRfc32ST1ZwsydKhfoRDTK2wsHL1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720092321; c=relaxed/simple;
	bh=oIfcQgh9jJLbjDRVKTDuP9iEV81A7jbp3RZN79VALFI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p8o1pBsxoA9YN05IBQBODyKt/vt0B5eYdVRoig5PuCP7iu+HQaFzc9BeO+50/VQd+Fy+U0rX3qluVKLRN1YCRs3xfWU8hvkCd1lbyIAI2bZrWz0wF/pOU+0Ma6GkcnQNCop28ZbbE5Pby0QYxThanjTJmpOrq0MaehrXKn75ETU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TiIL5X24; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720092311; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=NCJfA953k4EF8smVyxxG9pGEmrjgEHhQRz3PIQnFNcQ=;
	b=TiIL5X246bXrDN6TpR/ITxJp2OTX7npzaLg7/WcLV5tyOnffV+Vu3lMTA8/Eyd4TWKzRBFI3Cf2Xd2mZI4SdeoA1M6HO5zSdfzpsov3Vipj7+x6FXmusRnSDH+u6A4xBJWUELlbkrVFYNp2tAs0+YKOdKI7SUG0EpeY8YH1priI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W9qWV3G_1720092309;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W9qWV3G_1720092309)
          by smtp.aliyun-inc.com;
          Thu, 04 Jul 2024 19:25:09 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	wangkefeng.wang@huawei.com,
	chrisl@kernel.org,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	ioworker0@gmail.com,
	da.gomez@samsung.com,
	p.raghav@samsung.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 02/10] mm: swap: extend swap_shmem_alloc() to support batch SWAP_MAP_SHMEM flag setting
Date: Thu,  4 Jul 2024 19:24:51 +0800
Message-Id: <7da9021dcb4f59249d4738c4e6fea093bcbe5586.1720079976.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1720079976.git.baolin.wang@linux.alibaba.com>
References: <cover.1720079976.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To support shmem large folio swap operations, add a new parameter to
swap_shmem_alloc() that allows batch SWAP_MAP_SHMEM flag setting for
shmem swap entries.

While we are at it, using folio_nr_pages() to get the number of pages
of the folio as a preparation.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/swap.h |  4 +-
 mm/shmem.c           |  6 ++-
 mm/swapfile.c        | 98 +++++++++++++++++++++++---------------------
 3 files changed, 57 insertions(+), 51 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 483b760d49a4..8839bb2f2fa6 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -475,7 +475,7 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry);
 extern swp_entry_t get_swap_page_of_type(int);
 extern int get_swap_pages(int n, swp_entry_t swp_entries[], int order);
 extern int add_swap_count_continuation(swp_entry_t, gfp_t);
-extern void swap_shmem_alloc(swp_entry_t);
+extern void swap_shmem_alloc(swp_entry_t, int);
 extern int swap_duplicate(swp_entry_t);
 extern int swapcache_prepare(swp_entry_t);
 extern void swap_free_nr(swp_entry_t entry, int nr_pages);
@@ -542,7 +542,7 @@ static inline int add_swap_count_continuation(swp_entry_t swp, gfp_t gfp_mask)
 	return 0;
 }
 
-static inline void swap_shmem_alloc(swp_entry_t swp)
+static inline void swap_shmem_alloc(swp_entry_t swp, int nr)
 {
 }
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 13d139abe69a..6244b909b069 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1443,6 +1443,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	swp_entry_t swap;
 	pgoff_t index;
+	int nr_pages;
 
 	/*
 	 * Our capabilities prevent regular writeback or sync from ever calling
@@ -1475,6 +1476,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 	}
 
 	index = folio->index;
+	nr_pages = folio_nr_pages(folio);
 
 	/*
 	 * This is somewhat ridiculous, but without plumbing a SWAP_MAP_FALLOC
@@ -1527,8 +1529,8 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 	if (add_to_swap_cache(folio, swap,
 			__GFP_HIGH | __GFP_NOMEMALLOC | __GFP_NOWARN,
 			NULL) == 0) {
-		shmem_recalc_inode(inode, 0, 1);
-		swap_shmem_alloc(swap);
+		shmem_recalc_inode(inode, 0, nr_pages);
+		swap_shmem_alloc(swap, nr_pages);
 		shmem_delete_from_page_cache(folio, swp_to_radix_entry(swap));
 
 		mutex_unlock(&shmem_swaplist_mutex);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 2f5203aa2d2c..0cc8a5a72a2f 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3387,62 +3387,58 @@ void si_swapinfo(struct sysinfo *val)
  * - swap-cache reference is requested but the entry is not used. -> ENOENT
  * - swap-mapped reference requested but needs continued swap count. -> ENOMEM
  */
-static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
+static int __swap_duplicate(struct swap_info_struct *p, unsigned long offset,
+			    int nr, unsigned char usage)
 {
-	struct swap_info_struct *p;
 	struct swap_cluster_info *ci;
-	unsigned long offset;
 	unsigned char count;
 	unsigned char has_cache;
-	int err;
+	int err, i;
 
-	p = swp_swap_info(entry);
-
-	offset = swp_offset(entry);
 	ci = lock_cluster_or_swap_info(p, offset);
 
-	count = p->swap_map[offset];
-
-	/*
-	 * swapin_readahead() doesn't check if a swap entry is valid, so the
-	 * swap entry could be SWAP_MAP_BAD. Check here with lock held.
-	 */
-	if (unlikely(swap_count(count) == SWAP_MAP_BAD)) {
-		err = -ENOENT;
-		goto unlock_out;
-	}
-
-	has_cache = count & SWAP_HAS_CACHE;
-	count &= ~SWAP_HAS_CACHE;
-	err = 0;
-
-	if (usage == SWAP_HAS_CACHE) {
+	for (i = 0; i < nr; i++) {
+		count = p->swap_map[offset + i];
 
-		/* set SWAP_HAS_CACHE if there is no cache and entry is used */
-		if (!has_cache && count)
-			has_cache = SWAP_HAS_CACHE;
-		else if (has_cache)		/* someone else added cache */
-			err = -EEXIST;
-		else				/* no users remaining */
+		/*
+		 * swapin_readahead() doesn't check if a swap entry is valid, so the
+		 * swap entry could be SWAP_MAP_BAD. Check here with lock held.
+		 */
+		if (unlikely(swap_count(count) == SWAP_MAP_BAD)) {
 			err = -ENOENT;
+			break;
+		}
 
-	} else if (count || has_cache) {
+		has_cache = count & SWAP_HAS_CACHE;
+		count &= ~SWAP_HAS_CACHE;
+		err = 0;
+
+		if (usage == SWAP_HAS_CACHE) {
+			/* set SWAP_HAS_CACHE if there is no cache and entry is used */
+			if (!has_cache && count)
+				has_cache = SWAP_HAS_CACHE;
+			else if (has_cache)		/* someone else added cache */
+				err = -EEXIST;
+			else				/* no users remaining */
+				err = -ENOENT;
+		} else if (count || has_cache) {
+			if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
+				count += usage;
+			else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
+				err = -EINVAL;
+			else if (swap_count_continued(p, offset + i, count))
+				count = COUNT_CONTINUED;
+			else
+				err = -ENOMEM;
+		} else
+			err = -ENOENT;			/* unused swap entry */
 
-		if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
-			count += usage;
-		else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
-			err = -EINVAL;
-		else if (swap_count_continued(p, offset, count))
-			count = COUNT_CONTINUED;
-		else
-			err = -ENOMEM;
-	} else
-		err = -ENOENT;			/* unused swap entry */
+		if (err)
+			break;
 
-	if (!err)
-		WRITE_ONCE(p->swap_map[offset], count | has_cache);
+		WRITE_ONCE(p->swap_map[offset + i], count | has_cache);
+	}
 
-unlock_out:
 	unlock_cluster_or_swap_info(p, ci);
 	return err;
 }
@@ -3451,9 +3447,12 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
  * Help swapoff by noting that swap entry belongs to shmem/tmpfs
  * (in which case its reference count is never incremented).
  */
-void swap_shmem_alloc(swp_entry_t entry)
+void swap_shmem_alloc(swp_entry_t entry, int nr)
 {
-	__swap_duplicate(entry, SWAP_MAP_SHMEM);
+	struct swap_info_struct *p = swp_swap_info(entry);
+	unsigned long offset = swp_offset(entry);
+
+	__swap_duplicate(p, offset, nr, SWAP_MAP_SHMEM);
 }
 
 /*
@@ -3465,9 +3464,11 @@ void swap_shmem_alloc(swp_entry_t entry)
  */
 int swap_duplicate(swp_entry_t entry)
 {
+	struct swap_info_struct *p = swp_swap_info(entry);
+	unsigned long offset = swp_offset(entry);
 	int err = 0;
 
-	while (!err && __swap_duplicate(entry, 1) == -ENOMEM)
+	while (!err && __swap_duplicate(p, offset, 1, 1) == -ENOMEM)
 		err = add_swap_count_continuation(entry, GFP_ATOMIC);
 	return err;
 }
@@ -3482,7 +3483,10 @@ int swap_duplicate(swp_entry_t entry)
  */
 int swapcache_prepare(swp_entry_t entry)
 {
-	return __swap_duplicate(entry, SWAP_HAS_CACHE);
+	struct swap_info_struct *p = swp_swap_info(entry);
+	unsigned long offset = swp_offset(entry);
+
+	return __swap_duplicate(p, offset, 1, SWAP_HAS_CACHE);
 }
 
 void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
-- 
2.39.3


