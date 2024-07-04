Return-Path: <linux-kernel+bounces-240955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B743092750B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721E628B38A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFC31AC444;
	Thu,  4 Jul 2024 11:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Bov+9LJF"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2B81AB513
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 11:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720092317; cv=none; b=jVdOfkrMx5UOrNXPAuebhl2qQmEHlvB0H9pKblFij7NVzsscIqMdp0nwxMhGvzPdrDQcBFgz622GThGy2V1lQBWjcgSQfwugkmMYOnuTcq53Z/ExlzASUc0Ism6BuR/D9xdUbs2VAfZpZmc9l5PPhdc6ZTIuuFrRz60VIeb0OzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720092317; c=relaxed/simple;
	bh=7F6UaAEISwgaNTN3lDcGNYayubCMQJozT/blkk3vrDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hNF+WPHOXir54Xvz8Ss/xDpGPPIKuxaU3OeB4tBwOV0lAIpT0zdBSqtscuzGVGiiVpedtTQk9boAgKmw0WaKB5P8py3iE7t+9W9o/NTGRV4vohEwRK4LfEhI2/vwlLXBEAEg6AAa+0W1cQKnnEIG2HGSB9m/2m+sUqRiAZKpV5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Bov+9LJF; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720092313; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=EpkaKZeif3DR2KNud0UcpLjPquN1O7r8iKvlNR8OHHc=;
	b=Bov+9LJFtdVMhaaNgw+ZQy/u+9KoddbSOuYovscPAIx0ywYoNK0uK1ReL6yf0nvjQdwBpVuA9NSfwqAQoj/g7IXDthYGvKmmLyyw4hpQO96rAAvZamiiXWxSo4IDKoqDlu1hCxhu33EOf/fjrL3eC3xYg4WZzdj7FKnEQ5rDr4w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W9qjOxX_1720092311;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W9qjOxX_1720092311)
          by smtp.aliyun-inc.com;
          Thu, 04 Jul 2024 19:25:11 +0800
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
Subject: [PATCH v3 04/10] mm: shmem: return number of pages beeing freed in shmem_free_swap
Date: Thu,  4 Jul 2024 19:24:53 +0800
Message-Id: <ed8173a659789a74a6c492f1557217cbb52cd017.1720079976.git.baolin.wang@linux.alibaba.com>
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

From: Daniel Gomez <da.gomez@samsung.com>

Both shmem_free_swap callers expect the number of pages being freed. In
the large folios context, this needs to support larger values other than
0 (used as 1 page being freed) and -ENOENT (used as 0 pages being
freed). In preparation for large folios adoption, make shmem_free_swap
routine return the number of pages being freed. So, returning 0 in this
context, means 0 pages being freed.

While we are at it, changing to use free_swap_and_cache_nr() to free large
order swap entry by Baolin Wang.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 42bf3176fa6c..5159d60456ed 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -847,18 +847,22 @@ static void shmem_delete_from_page_cache(struct folio *folio, void *radswap)
 }
 
 /*
- * Remove swap entry from page cache, free the swap and its page cache.
+ * Remove swap entry from page cache, free the swap and its page cache. Returns
+ * the number of pages being freed. 0 means entry not found in XArray (0 pages
+ * being freed).
  */
-static int shmem_free_swap(struct address_space *mapping,
-			   pgoff_t index, void *radswap)
+static long shmem_free_swap(struct address_space *mapping,
+			    pgoff_t index, void *radswap)
 {
+	int order = xa_get_order(&mapping->i_pages, index);
 	void *old;
 
 	old = xa_cmpxchg_irq(&mapping->i_pages, index, radswap, NULL, 0);
 	if (old != radswap)
-		return -ENOENT;
-	free_swap_and_cache(radix_to_swp_entry(radswap));
-	return 0;
+		return 0;
+	free_swap_and_cache_nr(radix_to_swp_entry(radswap), 1 << order);
+
+	return 1 << order;
 }
 
 /*
@@ -1010,7 +1014,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			if (xa_is_value(folio)) {
 				if (unfalloc)
 					continue;
-				nr_swaps_freed += !shmem_free_swap(mapping,
+				nr_swaps_freed += shmem_free_swap(mapping,
 							indices[i], folio);
 				continue;
 			}
@@ -1077,14 +1081,17 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			folio = fbatch.folios[i];
 
 			if (xa_is_value(folio)) {
+				long swaps_freed;
+
 				if (unfalloc)
 					continue;
-				if (shmem_free_swap(mapping, indices[i], folio)) {
+				swaps_freed = shmem_free_swap(mapping, indices[i], folio);
+				if (!swaps_freed) {
 					/* Swap was replaced by page: retry */
 					index = indices[i];
 					break;
 				}
-				nr_swaps_freed++;
+				nr_swaps_freed += swaps_freed;
 				continue;
 			}
 
-- 
2.39.3


