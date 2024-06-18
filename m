Return-Path: <linux-kernel+bounces-218703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 191A790C41B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 09:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50FC1B20A99
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 07:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB64D7F489;
	Tue, 18 Jun 2024 06:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xnbiavfM"
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF52F73537
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718693678; cv=none; b=busqpHe1DBgEpihVpD4xF0ZqlW33eP7+JRK/6Yy/Wl76NKbSpimbaX2d7MRgOAXO6J86wZXVyfI9bPRkQ+BklZRJHB093cvjYnUAb+/wNeF6kUHWVJrEoeKxvfMSNPVn+6WyLiAxlZJfxfOK1ngh5iFT1eLvKYOz1hPmLJdkr7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718693678; c=relaxed/simple;
	bh=y/bLAyJVcfx/xNGxU0XeAS0dLKu3XWOVnCuwHcKPo3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DFMgGAbLgyoCLGbgaL0TyoeQM6qv9vtxGayu/XUrttiK9WODe6+c24ileCYS/qFmRw3SZ2QSly0ZP7te9YtM8WRknn5IqiG7+zLJ3WcyDHoAdHwjqEI2+5rZh4bl6+vr6GrMpASKKxEDpCtuFhybJY13hamOr1EwBybaW6GK45s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xnbiavfM; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718693673; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=oU/PcFIl06vSDqEtjZujhmAzGqRrrYre+wfF0/f2UwU=;
	b=xnbiavfMUiKo/s15gGly/qLRpFpIiM4Dhzae0MlQh12ZoF06eMrjOyODaVyxZGoOMO+mAHpAzHXXre3gJQEdNhx0R3KgcomLgoVm2hpcdBZu+MLregMlZhThhHG8hLohmUyA/8RgvCggVGpXyb0hESFV2hfeLQ3hZxFtKu53ntE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045075189;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W8jFFL._1718693671;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8jFFL._1718693671)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 14:54:31 +0800
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
Subject: [PATCH v2 4/9] mm: shmem: return number of pages beeing freed in shmem_free_swap
Date: Tue, 18 Jun 2024 14:54:16 +0800
Message-Id: <6e567bfbb6bac0bfbdd63e60718bd1aaf8eade6c.1718690645.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1718690645.git.baolin.wang@linux.alibaba.com>
References: <cover.1718690645.git.baolin.wang@linux.alibaba.com>
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
index 012a06ef39aa..a73d2da54897 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -836,18 +836,22 @@ static void shmem_delete_from_page_cache(struct folio *folio, void *radswap)
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
@@ -999,7 +1003,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			if (xa_is_value(folio)) {
 				if (unfalloc)
 					continue;
-				nr_swaps_freed += !shmem_free_swap(mapping,
+				nr_swaps_freed += shmem_free_swap(mapping,
 							indices[i], folio);
 				continue;
 			}
@@ -1066,14 +1070,17 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
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


