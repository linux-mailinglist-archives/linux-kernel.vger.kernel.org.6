Return-Path: <linux-kernel+bounces-204220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CB88FE5F5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD21E1C23CF1
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD5F195988;
	Thu,  6 Jun 2024 11:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TffbrXVz"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A5A195978
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 11:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675167; cv=none; b=pM+TcSuZHutNSBYtUMa324L5uOVEjkle6hlzBK0NtEmCSGALjO6rofVsN64UY8h9mplV8BxKNgabVU59ttBeRd72P0w9W1z2GOpCBQYwkHGNtFJdq/yuSjmer5V9uKjRFjLzUtIWjRAQx/ORmVrNfM8FIQLFZ0ctAn39xlD57Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675167; c=relaxed/simple;
	bh=C47jcCKzOoryOFp8A3tdkgy4JTiX5Q1m2tAsWCp5yTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pme8WMGPohSAe82HvBRz3BxIsVGvrQD4B9cx0/PAuhWax1eYy6GcVPpeE0WKm6Hw1LTsczDLwbkR/scBDkllVfkJ1KVmSH4dTjBC/gZdOMGIpzAZeRLy5mdeBrbbeEHC1EneML58/4LAt7557NLQPCTF0uSL8N2G+P8QDa3X6nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TffbrXVz; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717675158; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Qh0W+u+9QDljuV5HDKuRhphJVSSVQ9c48/ae0QqTnoM=;
	b=TffbrXVza3Ugakwy1aanpDPlcmPBTmlXQoWFolgfP32pnhGjHHqaCIjf0ud5ybdXRqaOxEOU0OWG/xkj5xOfx5cFn63JcsdVZbmXSLz9vmnv4Ln1jvuF3gfE57v2lHcZqkX2keCVDIzhgmLMsS9qMTsrG3iiS1jCUyZJ826Kqic=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W7y6tqN_1717675155;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7y6tqN_1717675155)
          by smtp.aliyun-inc.com;
          Thu, 06 Jun 2024 19:59:16 +0800
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
Subject: [PATCH 5/7] mm: add new 'orders' parameter for find_get_entries() and find_lock_entries()
Date: Thu,  6 Jun 2024 19:58:55 +0800
Message-Id: <5304c4c54868336985b396d2c46132c2e0cdf803.1717673614.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <cover.1717673614.git.baolin.wang@linux.alibaba.com>
References: <cover.1717673614.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the following patches, shmem will support the swap out of large folios,
which means the shmem mappings may contain large order swap entries, so an
'orders' array is added for find_get_entries() and find_lock_entries() to
obtain the order size of shmem swap entries, which will help in the release
of shmem large folio swap entries.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/filemap.c  | 27 +++++++++++++++++++++++++--
 mm/internal.h |  4 ++--
 mm/shmem.c    | 17 +++++++++--------
 mm/truncate.c |  8 ++++----
 4 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 37061aafd191..47fcd9ee6012 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2036,14 +2036,24 @@ static inline struct folio *find_get_entry(struct xa_state *xas, pgoff_t max,
  * Return: The number of entries which were found.
  */
 unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
-		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices)
+		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices,
+		int *orders)
 {
 	XA_STATE(xas, &mapping->i_pages, *start);
 	struct folio *folio;
+	int order;
 
 	rcu_read_lock();
 	while ((folio = find_get_entry(&xas, end, XA_PRESENT)) != NULL) {
 		indices[fbatch->nr] = xas.xa_index;
+		if (orders) {
+			if (!xa_is_value(folio))
+				order = folio_order(folio);
+			else
+				order = xa_get_order(xas.xa, xas.xa_index);
+
+			orders[fbatch->nr] = order;
+		}
 		if (!folio_batch_add(fbatch, folio))
 			break;
 	}
@@ -2056,6 +2066,8 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
 		folio = fbatch->folios[idx];
 		if (!xa_is_value(folio))
 			nr = folio_nr_pages(folio);
+		else if (orders)
+			nr = 1 << orders[idx];
 		*start = indices[idx] + nr;
 	}
 	return folio_batch_count(fbatch);
@@ -2082,10 +2094,12 @@ unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
  * Return: The number of entries which were found.
  */
 unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
-		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices)
+		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices,
+		int *orders)
 {
 	XA_STATE(xas, &mapping->i_pages, *start);
 	struct folio *folio;
+	int order;
 
 	rcu_read_lock();
 	while ((folio = find_get_entry(&xas, end, XA_PRESENT))) {
@@ -2099,9 +2113,16 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 			if (folio->mapping != mapping ||
 			    folio_test_writeback(folio))
 				goto unlock;
+			if (orders)
+				order = folio_order(folio);
 			VM_BUG_ON_FOLIO(!folio_contains(folio, xas.xa_index),
 					folio);
+		} else if (orders) {
+			order = xa_get_order(xas.xa, xas.xa_index);
 		}
+
+		if (orders)
+			orders[fbatch->nr] = order;
 		indices[fbatch->nr] = xas.xa_index;
 		if (!folio_batch_add(fbatch, folio))
 			break;
@@ -2120,6 +2141,8 @@ unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
 		folio = fbatch->folios[idx];
 		if (!xa_is_value(folio))
 			nr = folio_nr_pages(folio);
+		else if (orders)
+			nr = 1 << orders[idx];
 		*start = indices[idx] + nr;
 	}
 	return folio_batch_count(fbatch);
diff --git a/mm/internal.h b/mm/internal.h
index 3419c329b3bc..0b5adb6c33cc 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -339,9 +339,9 @@ static inline void force_page_cache_readahead(struct address_space *mapping,
 }
 
 unsigned find_lock_entries(struct address_space *mapping, pgoff_t *start,
-		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
+		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices, int *orders);
 unsigned find_get_entries(struct address_space *mapping, pgoff_t *start,
-		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices);
+		pgoff_t end, struct folio_batch *fbatch, pgoff_t *indices, int *orders);
 void filemap_free_folio(struct address_space *mapping, struct folio *folio);
 int truncate_inode_folio(struct address_space *mapping, struct folio *folio);
 bool truncate_inode_partial_folio(struct folio *folio, loff_t start,
diff --git a/mm/shmem.c b/mm/shmem.c
index 0ac71580decb..28ba603d87b8 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -840,14 +840,14 @@ static void shmem_delete_from_page_cache(struct folio *folio, void *radswap)
  * Remove swap entry from page cache, free the swap and its page cache.
  */
 static int shmem_free_swap(struct address_space *mapping,
-			   pgoff_t index, void *radswap)
+			   pgoff_t index, void *radswap, int order)
 {
 	void *old;
 
 	old = xa_cmpxchg_irq(&mapping->i_pages, index, radswap, NULL, 0);
 	if (old != radswap)
 		return -ENOENT;
-	free_swap_and_cache(radix_to_swp_entry(radswap));
+	free_swap_and_cache_nr(radix_to_swp_entry(radswap), 1 << order);
 	return 0;
 }
 
@@ -981,6 +981,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	pgoff_t end = (lend + 1) >> PAGE_SHIFT;
 	struct folio_batch fbatch;
 	pgoff_t indices[PAGEVEC_SIZE];
+	int orders[PAGEVEC_SIZE];
 	struct folio *folio;
 	bool same_folio;
 	long nr_swaps_freed = 0;
@@ -996,15 +997,15 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 	folio_batch_init(&fbatch);
 	index = start;
 	while (index < end && find_lock_entries(mapping, &index, end - 1,
-			&fbatch, indices)) {
+			&fbatch, indices, orders)) {
 		for (i = 0; i < folio_batch_count(&fbatch); i++) {
 			folio = fbatch.folios[i];
 
 			if (xa_is_value(folio)) {
 				if (unfalloc)
 					continue;
-				nr_swaps_freed += !shmem_free_swap(mapping,
-							indices[i], folio);
+				if (!shmem_free_swap(mapping, indices[i], folio, orders[i]))
+					nr_swaps_freed += 1 << orders[i];
 				continue;
 			}
 
@@ -1058,7 +1059,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 		cond_resched();
 
 		if (!find_get_entries(mapping, &index, end - 1, &fbatch,
-				indices)) {
+				indices, orders)) {
 			/* If all gone or hole-punch or unfalloc, we're done */
 			if (index == start || end != -1)
 				break;
@@ -1072,12 +1073,12 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 			if (xa_is_value(folio)) {
 				if (unfalloc)
 					continue;
-				if (shmem_free_swap(mapping, indices[i], folio)) {
+				if (shmem_free_swap(mapping, indices[i], folio, orders[i])) {
 					/* Swap was replaced by page: retry */
 					index = indices[i];
 					break;
 				}
-				nr_swaps_freed++;
+				nr_swaps_freed += 1 << orders[i];
 				continue;
 			}
 
diff --git a/mm/truncate.c b/mm/truncate.c
index 5ce62a939e55..3a4bc9dba451 100644
--- a/mm/truncate.c
+++ b/mm/truncate.c
@@ -352,7 +352,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	folio_batch_init(&fbatch);
 	index = start;
 	while (index < end && find_lock_entries(mapping, &index, end - 1,
-			&fbatch, indices)) {
+			&fbatch, indices, NULL)) {
 		truncate_folio_batch_exceptionals(mapping, &fbatch, indices);
 		for (i = 0; i < folio_batch_count(&fbatch); i++)
 			truncate_cleanup_folio(fbatch.folios[i]);
@@ -392,7 +392,7 @@ void truncate_inode_pages_range(struct address_space *mapping,
 	while (index < end) {
 		cond_resched();
 		if (!find_get_entries(mapping, &index, end - 1, &fbatch,
-				indices)) {
+				indices, NULL)) {
 			/* If all gone from start onwards, we're done */
 			if (index == start)
 				break;
@@ -496,7 +496,7 @@ unsigned long mapping_try_invalidate(struct address_space *mapping,
 	int i;
 
 	folio_batch_init(&fbatch);
-	while (find_lock_entries(mapping, &index, end, &fbatch, indices)) {
+	while (find_lock_entries(mapping, &index, end, &fbatch, indices, NULL)) {
 		for (i = 0; i < folio_batch_count(&fbatch); i++) {
 			struct folio *folio = fbatch.folios[i];
 
@@ -622,7 +622,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
 
 	folio_batch_init(&fbatch);
 	index = start;
-	while (find_get_entries(mapping, &index, end, &fbatch, indices)) {
+	while (find_get_entries(mapping, &index, end, &fbatch, indices, NULL)) {
 		for (i = 0; i < folio_batch_count(&fbatch); i++) {
 			struct folio *folio = fbatch.folios[i];
 
-- 
2.39.3


