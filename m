Return-Path: <linux-kernel+bounces-282736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCB094E803
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2B791C21BFF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC5016D9C5;
	Mon, 12 Aug 2024 07:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AE/C8scD"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9817A16D4C2
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 07:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723448558; cv=none; b=mLn7HYB9V6k2q2qYvB74PxhHDl+ElfcuLNeDM8y8Jv4gIFVnIQtFp56/yBBEVfxHJishDNWKtzZrYHzMM+PE6zKLygvjbKSK+eAwqJqSxp4CBz7DLIYNQ2w9zXy/6OL53ynoNnm3ErWqLDIJoihqJv3SUB2gpez7t+W6PMzJ15Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723448558; c=relaxed/simple;
	bh=Fad/wvCvAhhMbu2+GNFchjOYH9D0Up5PK5PcdgD4djw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P5Px95t82h23AYVPCHlCcnqrFiM/s4p4I456wZJ14xLCTvv5z1FtPi8J0xiW3SE83NcdKDRsLP/2VYQe1gZm8iX0qM1DKki4brRTPwZ3OyN6B5cb2+4/2yhlyIu4WWlSh124ojzSy1aIcmnky+VyJ56h0Ldpygu041qXE4KisQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AE/C8scD; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723448549; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=d32a7jBZCt/LbWrkrcBvwBUp97vywsx+8D5iSkO5umo=;
	b=AE/C8scDa77VHZn2x1S3uv59HGA2JQtdlp85JCxcurcrJzdJZ4PzulLYfg2ZbX4Z2HzTG1G57n4Bpq+NGto8/87cSFUZlFDe9uXj9fFCLfBhupy88AvP/flpnZtJyfuf/jp8Z7hsKpVf6uu9o/yhg//JIKVl/xcAlKanw5Gaoj8=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WCbAKQr_1723448546)
          by smtp.aliyun-inc.com;
          Mon, 12 Aug 2024 15:42:27 +0800
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
Subject: [PATCH v5 9/9] mm: shmem: support large folio swap out
Date: Mon, 12 Aug 2024 15:42:10 +0800
Message-Id: <d80c21abd20e1b0f5ca66b330f074060fb2f082d.1723434324.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1723434324.git.baolin.wang@linux.alibaba.com>
References: <cover.1723434324.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Shmem will support large folio allocation [1] [2] to get a better performance,
however, the memory reclaim still splits the precious large folios when trying
to swap out shmem, which may lead to the memory fragmentation issue and can not
take advantage of the large folio for shmeme.

Moreover, the swap code already supports for swapping out large folio without
split, hence this patch set supports the large folio swap out for shmem.

Note the i915_gem_shmem driver still need to be split when swapping, thus
add a new flag 'split_large_folio' for writeback_control to indicate spliting
the large folio.

[1] https://lore.kernel.org/all/cover.1717495894.git.baolin.wang@linux.alibaba.com/
[2] https://lore.kernel.org/all/20240515055719.32577-1-da.gomez@samsung.com/
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c |  1 +
 include/linux/writeback.h                 |  4 +++
 mm/shmem.c                                | 12 ++++++---
 mm/vmscan.c                               | 32 ++++++++++++++++++-----
 4 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index c5e1c718a6d2..c66cb9c585e1 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -308,6 +308,7 @@ void __shmem_writeback(size_t size, struct address_space *mapping)
 		.range_start = 0,
 		.range_end = LLONG_MAX,
 		.for_reclaim = 1,
+		.split_large_folio = 1,
 	};
 	unsigned long i;
 
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 1a54676d843a..10100e22d5c6 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -63,6 +63,7 @@ struct writeback_control {
 	unsigned range_cyclic:1;	/* range_start is cyclic */
 	unsigned for_sync:1;		/* sync(2) WB_SYNC_ALL writeback */
 	unsigned unpinned_netfs_wb:1;	/* Cleared I_PINNING_NETFS_WB */
+	unsigned split_large_folio:1;	/* Split large folio for shmem writeback */
 
 	/*
 	 * When writeback IOs are bounced through async layers, only the
@@ -79,6 +80,9 @@ struct writeback_control {
 	 */
 	struct swap_iocb **swap_plug;
 
+	/* Target list for splitting a large folio */
+	struct list_head *list;
+
 	/* internal fields used by the ->writepages implementation: */
 	struct folio_batch fbatch;
 	pgoff_t index;
diff --git a/mm/shmem.c b/mm/shmem.c
index 996062dc196b..50aeb03c4d34 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -795,7 +795,6 @@ static int shmem_add_to_page_cache(struct folio *folio,
 	VM_BUG_ON_FOLIO(index != round_down(index, nr), folio);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
 	VM_BUG_ON_FOLIO(!folio_test_swapbacked(folio), folio);
-	VM_BUG_ON(expected && folio_test_large(folio));
 
 	folio_ref_add(folio, nr);
 	folio->mapping = mapping;
@@ -1482,10 +1481,11 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 	 * "force", drivers/gpu/drm/i915/gem/i915_gem_shmem.c gets huge pages,
 	 * and its shmem_writeback() needs them to be split when swapping.
 	 */
-	if (folio_test_large(folio)) {
+	if (wbc->split_large_folio && folio_test_large(folio)) {
+try_split:
 		/* Ensure the subpages are still dirty */
 		folio_test_set_dirty(folio);
-		if (split_huge_page(page) < 0)
+		if (split_huge_page_to_list_to_order(page, wbc->list, 0))
 			goto redirty;
 		folio = page_folio(page);
 		folio_clear_dirty(folio);
@@ -1527,8 +1527,12 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 	}
 
 	swap = folio_alloc_swap(folio);
-	if (!swap.val)
+	if (!swap.val) {
+		if (nr_pages > 1)
+			goto try_split;
+
 		goto redirty;
+	}
 
 	/*
 	 * Add inode to shmem_unuse()'s list of swapped-out inodes,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 96ce889ea3d0..ba7b67218caf 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -628,7 +628,7 @@ typedef enum {
  * Calls ->writepage().
  */
 static pageout_t pageout(struct folio *folio, struct address_space *mapping,
-			 struct swap_iocb **plug)
+			 struct swap_iocb **plug, struct list_head *folio_list)
 {
 	/*
 	 * If the folio is dirty, only perform writeback if that write
@@ -676,6 +676,16 @@ static pageout_t pageout(struct folio *folio, struct address_space *mapping,
 			.swap_plug = plug,
 		};
 
+		/*
+		 * The large shmem folio can be split if CONFIG_THP_SWAP is
+		 * not enabled or contiguous swap entries are failed to
+		 * allocate.
+		 */
+		if (shmem_mapping(mapping) && folio_test_large(folio)) {
+			wbc.list = folio_list;
+			wbc.split_large_folio = !IS_ENABLED(CONFIG_THP_SWAP);
+		}
+
 		folio_set_reclaim(folio);
 		res = mapping->a_ops->writepage(&folio->page, &wbc);
 		if (res < 0)
@@ -1257,11 +1267,6 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 						goto activate_locked_split;
 				}
 			}
-		} else if (folio_test_swapbacked(folio) &&
-			   folio_test_large(folio)) {
-			/* Split shmem folio */
-			if (split_folio_to_list(folio, folio_list))
-				goto keep_locked;
 		}
 
 		/*
@@ -1362,12 +1367,25 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			 * starts and then write it out here.
 			 */
 			try_to_unmap_flush_dirty();
-			switch (pageout(folio, mapping, &plug)) {
+			switch (pageout(folio, mapping, &plug, folio_list)) {
 			case PAGE_KEEP:
 				goto keep_locked;
 			case PAGE_ACTIVATE:
+				/*
+				 * If shmem folio is split when writeback to swap,
+				 * the tail pages will make their own pass through
+				 * this function and be accounted then.
+				 */
+				if (nr_pages > 1 && !folio_test_large(folio)) {
+					sc->nr_scanned -= (nr_pages - 1);
+					nr_pages = 1;
+				}
 				goto activate_locked;
 			case PAGE_SUCCESS:
+				if (nr_pages > 1 && !folio_test_large(folio)) {
+					sc->nr_scanned -= (nr_pages - 1);
+					nr_pages = 1;
+				}
 				stat->nr_pageout += nr_pages;
 
 				if (folio_test_writeback(folio))
-- 
2.39.3


