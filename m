Return-Path: <linux-kernel+bounces-184848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B62508CAD01
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 13:03:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470391F22F8B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 11:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A22374BED;
	Tue, 21 May 2024 11:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QqaMVMxk"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DEE44384
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 11:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716289421; cv=none; b=B9Fia6MXdJaitoP/XGIXwpcM26vpEmza7FxQ/66cBbOPJC95XVByS3pmI4inVT5CznCCt187vqIAoeLmR/MoAbmrQCEftqEwsQm4bs4LXFOl0i59xvvSt486iji7j8JeAWa+8RZM1fw7mIBiyIynmpWOSsbGrcQeOLT/KL69GzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716289421; c=relaxed/simple;
	bh=joGBV1HzsxEZPHmpZZMSyuQ/Mwl/EwRqzN4M/M0mgsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bb3gtr5e/h4/Ww9LHYsMHuXWlZ3bbT5eA9MWjnaJ+w2wGY0TfqZwF5NdFFi8iyND6iGkUDzVJ+PIhN/iJAhBcNCP63F1EEJ3hILGqfwq3sDFFvJv+H1XtR2ikdZh0W+Kep0iuYTgodHtXQxisGEao5DvER1RGVrkmBlakUjEgnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QqaMVMxk; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716289416; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=AnBwKR9CDgtaWp21L3C4wGJsMstG019ckRvWwRbPXDM=;
	b=QqaMVMxkO39baTbt3EFevek7dyw2Du373ayknRz2U6NGfFkPoppI+sT+Vo17XfRqfZYGONl4Ug32Ot3vzD/bW2GBCz9ozGGuyYuHGuzLl/ISlhLj1d3vMmIynNhNEWB+WAgDUUi0tscqPg3NkRuNDKgpAP+3eB+ugQKwUJCCv+E=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W6xkOjU_1716289413;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W6xkOjU_1716289413)
          by smtp.aliyun-inc.com;
          Tue, 21 May 2024 19:03:34 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com
Cc: willy@infradead.org,
	david@redhat.com,
	ioworker0@gmail.com,
	hrisl@kernel.org,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	wangkefeng.wang@huawei.com,
	ying.huang@intel.com,
	21cnbao@gmail.com,
	ryan.roberts@arm.com,
	shy828301@gmail.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/8] mm: swap: extend swap_shmem_alloc() to support batch SWAP_MAP_SHMEM flag setting
Date: Tue, 21 May 2024 19:03:13 +0800
Message-Id: <3ded3d39f19250ed4f16a42f22121b5f2c2dfb5c.1716285099.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1716285099.git.baolin.wang@linux.alibaba.com>
References: <cover.1716285099.git.baolin.wang@linux.alibaba.com>
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
index 48131b869a4d..78922922abbd 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -479,7 +479,7 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry);
 extern swp_entry_t get_swap_page_of_type(int);
 extern int get_swap_pages(int n, swp_entry_t swp_entries[], int order);
 extern int add_swap_count_continuation(swp_entry_t, gfp_t);
-extern void swap_shmem_alloc(swp_entry_t);
+extern void swap_shmem_alloc(swp_entry_t, int);
 extern int swap_duplicate(swp_entry_t);
 extern int swapcache_prepare(swp_entry_t);
 extern void swap_free_nr(swp_entry_t entry, int nr_pages);
@@ -546,7 +546,7 @@ static inline int add_swap_count_continuation(swp_entry_t swp, gfp_t gfp_mask)
 	return 0;
 }
 
-static inline void swap_shmem_alloc(swp_entry_t swp)
+static inline void swap_shmem_alloc(swp_entry_t swp, int nr)
 {
 }
 
diff --git a/mm/shmem.c b/mm/shmem.c
index fd2cb2e73a21..daab124c3e61 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1433,6 +1433,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	swp_entry_t swap;
 	pgoff_t index;
+	int nr_pages;
 
 	/*
 	 * Our capabilities prevent regular writeback or sync from ever calling
@@ -1465,6 +1466,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 	}
 
 	index = folio->index;
+	nr_pages = folio_nr_pages(folio);
 
 	/*
 	 * This is somewhat ridiculous, but without plumbing a SWAP_MAP_FALLOC
@@ -1517,8 +1519,8 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
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
index 99e701620562..2f23b87ddcb3 100644
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


