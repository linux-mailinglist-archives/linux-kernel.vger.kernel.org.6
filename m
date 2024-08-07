Return-Path: <linux-kernel+bounces-277465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BB894A1C5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB8B1F21867
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DAF1C9ECA;
	Wed,  7 Aug 2024 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BrLn6V3C"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DA01C9DE7
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 07:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723015900; cv=none; b=HRGYxb9bqILs38DnUmbmt8TJ0HIDqN1YsupgGGTy2LKVcaRNt3thbajlht3FDvfrQBP83dICkPjVDChXebgYAorxbldqadLQXDlAGtq9DIWrcinAISiulXbYu8fUfcV8FgrVRWReDxH1MxDbUrt/UBdPkzKI2C6pxd/1k2IpkxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723015900; c=relaxed/simple;
	bh=Fyf147nmWm0HWzBPlS492Q/Gdv+ZSkkrV6PKaTePt8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hwI5VGgt6Z9bAQUj5ltalAXUNooOYhcvivzzQ3PSao3zGEQKc6ZgkfeRNgVAoXT9akCXyf/AWf74Rpc6SI7AHKZlemTRr7xz8toQkhYSjLyXeTgpqFg6HQD8DUghQUW7FfetPHTRt8yuNop6jggOtozmxZ3yoWqCQ+O/oz/0x/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BrLn6V3C; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723015896; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+R9mz0zB2CI8dFveIvPvJwpF+8EOZp0Xn71CWrw5Br0=;
	b=BrLn6V3CtcULyXhNiUvZpl0mWGE8mKUY2eZEDY/KfdMhLwqg/h5MSOWDFbMKeIHc68QVIKwz4C53oAzFSUJm+R0JySN5UvtK8uDqog/gJyrbmAeBqO6lgY1mSyYvvJSa3Ycead4w8gpHmlDQxU8/wgspXFF6N5Savp6frPLEg9U=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0WCI3giE_1723015894;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WCI3giE_1723015894)
          by smtp.aliyun-inc.com;
          Wed, 07 Aug 2024 15:31:34 +0800
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
Subject: [PATCH v4 07/10] mm: shmem: support large folio allocation for shmem_replace_folio()
Date: Wed,  7 Aug 2024 15:31:12 +0800
Message-Id: <bb7618a28a771acc86ca8756d56a7a9f73935ca3.1723012159.git.baolin.wang@linux.alibaba.com>
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

To support large folio swapin for shmem in the following patches, add
large folio allocation for the new replacement folio in shmem_replace_folio().
Moreover large folios occupy N consecutive entries in the swap cache
instead of using multi-index entries like the page cache, therefore
we should replace each consecutive entries in the swap cache instead
of using the shmem_replace_entry().

As well as updating statistics and folio reference count using the number
of pages in the folio.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 54 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index f6bab42180ea..d94f02ad7bd1 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1889,28 +1889,24 @@ static bool shmem_should_replace_folio(struct folio *folio, gfp_t gfp)
 static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
 				struct shmem_inode_info *info, pgoff_t index)
 {
-	struct folio *old, *new;
-	struct address_space *swap_mapping;
-	swp_entry_t entry;
-	pgoff_t swap_index;
-	int error;
-
-	old = *foliop;
-	entry = old->swap;
-	swap_index = swap_cache_index(entry);
-	swap_mapping = swap_address_space(entry);
+	struct folio *new, *old = *foliop;
+	swp_entry_t entry = old->swap;
+	struct address_space *swap_mapping = swap_address_space(entry);
+	pgoff_t swap_index = swap_cache_index(entry);
+	XA_STATE(xas, &swap_mapping->i_pages, swap_index);
+	int nr_pages = folio_nr_pages(old);
+	int error = 0, i;
 
 	/*
 	 * We have arrived here because our zones are constrained, so don't
 	 * limit chance of success by further cpuset and node constraints.
 	 */
 	gfp &= ~GFP_CONSTRAINT_MASK;
-	VM_BUG_ON_FOLIO(folio_test_large(old), old);
-	new = shmem_alloc_folio(gfp, 0, info, index);
+	new = shmem_alloc_folio(gfp, folio_order(old), info, index);
 	if (!new)
 		return -ENOMEM;
 
-	folio_get(new);
+	folio_ref_add(new, nr_pages);
 	folio_copy(new, old);
 	flush_dcache_folio(new);
 
@@ -1920,18 +1916,25 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
 	new->swap = entry;
 	folio_set_swapcache(new);
 
-	/*
-	 * Our caller will very soon move newpage out of swapcache, but it's
-	 * a nice clean interface for us to replace oldpage by newpage there.
-	 */
+	/* Swap cache still stores N entries instead of a high-order entry */
 	xa_lock_irq(&swap_mapping->i_pages);
-	error = shmem_replace_entry(swap_mapping, swap_index, old, new);
+	for (i = 0; i < nr_pages; i++) {
+		void *item = xas_load(&xas);
+
+		if (item != old) {
+			error = -ENOENT;
+			break;
+		}
+
+		xas_store(&xas, new);
+		xas_next(&xas);
+	}
 	if (!error) {
 		mem_cgroup_replace_folio(old, new);
-		__lruvec_stat_mod_folio(new, NR_FILE_PAGES, 1);
-		__lruvec_stat_mod_folio(new, NR_SHMEM, 1);
-		__lruvec_stat_mod_folio(old, NR_FILE_PAGES, -1);
-		__lruvec_stat_mod_folio(old, NR_SHMEM, -1);
+		__lruvec_stat_mod_folio(new, NR_FILE_PAGES, nr_pages);
+		__lruvec_stat_mod_folio(new, NR_SHMEM, nr_pages);
+		__lruvec_stat_mod_folio(old, NR_FILE_PAGES, -nr_pages);
+		__lruvec_stat_mod_folio(old, NR_SHMEM, -nr_pages);
 	}
 	xa_unlock_irq(&swap_mapping->i_pages);
 
@@ -1951,7 +1954,12 @@ static int shmem_replace_folio(struct folio **foliop, gfp_t gfp,
 	old->private = NULL;
 
 	folio_unlock(old);
-	folio_put_refs(old, 2);
+	/*
+	 * The old folio are removed from swap cache, drop the 'nr_pages'
+	 * reference, as well as one temporary reference getting from swap
+	 * cache.
+	 */
+	folio_put_refs(old, nr_pages + 1);
 	return error;
 }
 
-- 
2.39.3


