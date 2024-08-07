Return-Path: <linux-kernel+bounces-277464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE4494A1C4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B232282DF7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0BA1C9DE3;
	Wed,  7 Aug 2024 07:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="S7hzn6CK"
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EC11C7B97
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 07:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723015897; cv=none; b=Dpzw4ARLoKj+C8GzAwjzP5fbq9zH1fyK9aAGD03nKgqrFI9aJB7cBFiEFMrkuJImslQJtc0vwzGbPOUCbokkfm9ALeIdLqrnreSEQIe3CpsRy51krx+ZT3p7NTRorl6wHHhXy4co8t17s7FM5KQje91uHaPPcL7MwNhIPFqLWVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723015897; c=relaxed/simple;
	bh=wU+mvmFmyXxD/VfwSu8JkQrOHqzi5LfMKdgy7Mj74U4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LmrUK4Un2sTuAK2ZV+yoKCRVoM6QJtS4kojZCAJIQXsrXSaY09j6D00UMP8HZ7e1/ehLvdmnIuGs9+l4XI/WC7YW9lvH8I0jNBvPwCAnKYkOpr3WN6QY3UB4QPoBScAJjab57/xma9j1Jj54EUb6AZfZEWa64XSRsSgZG744XwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=S7hzn6CK; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723015893; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=71u6PF0T766CyIr04AjwEpJvSI8v+1Ntw3LK3owxVuQ=;
	b=S7hzn6CKgeU8NUSo5qaEz9OYqL8WWvlMR+LmOe8Y/UlrOUNKsnVkVOCetzQWkEY83W45FXkp8e7FpVKaA+dHQpvjviTrReQmZjRrJ4FG4ksX0FJthSBIBnU9zIXjdwLHcrHvCtlr088GWMRqbmjZ7bx0tdUsIbGzLdIdf2aT4Kk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0WCI9Fpo_1723015891;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WCI9Fpo_1723015891)
          by smtp.aliyun-inc.com;
          Wed, 07 Aug 2024 15:31:31 +0800
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
Subject: [PATCH v4 04/10] mm: shmem: return number of pages beeing freed in shmem_free_swap
Date: Wed,  7 Aug 2024 15:31:09 +0800
Message-Id: <997c9f9694cabfb74505a866b335da9453fa6994.1723012159.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1723012159.git.baolin.wang@linux.alibaba.com>
References: <cover.1723012159.git.baolin.wang@linux.alibaba.com>
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
index 02fb188d627f..d0d54939da48 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -856,18 +856,22 @@ static void shmem_delete_from_page_cache(struct folio *folio, void *radswap)
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
@@ -1019,7 +1023,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			if (xa_is_value(folio)) {
 				if (unfalloc)
 					continue;
-				nr_swaps_freed += !shmem_free_swap(mapping,
+				nr_swaps_freed += shmem_free_swap(mapping,
 							indices[i], folio);
 				continue;
 			}
@@ -1086,14 +1090,17 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
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


