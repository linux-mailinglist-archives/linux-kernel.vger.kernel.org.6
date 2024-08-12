Return-Path: <linux-kernel+bounces-282729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B10D94E7FC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 564BE1C21A21
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD4F1607A1;
	Mon, 12 Aug 2024 07:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ut3CYW5S"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55D2158522
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 07:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723448550; cv=none; b=QOnoDuGtxKppANTdEcEi00dI1zrpwDePsHCZTqu32VQvmm9nPQf73nbs/AwDE4SDb6tK9RZm/TJd0dINUjeVKvpzeQ+u0an289iMbjzyAMO3GAM5Eea4g0skb+0DVpKrK0vNgawcjpsqYy+UWEMqYDO2OLktcdfFbmzRtOlDsxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723448550; c=relaxed/simple;
	bh=OKG5otDDfLQNbfBVfi2UmI4LBkG1rv6xpR+T0/6hxIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ojjLrwkEsXtl2mj/g/V6AYXKTCD/2SeFj/lmN0KFovWR3AH8Qa6e7XklJtuarCNZCXaeFvXAxOko/at1hYnW2FRZWF1CiPUxrPirwEB+pNl/ucELIB3jx7ZCb+mrhJ3d1+Hz2gT5x2h2SCeT3sArDh9RW10TTO9UWx0S4oSryzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ut3CYW5S; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723448540; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=o6+ZLJUP4gIVFn0Lkl5fLomnFxVaP80TbLuhIXh/Zp0=;
	b=Ut3CYW5SgDYjK2FqRDVMQ8HZ2yoyjY6lA6C60GvRQ7vq2rUf2ffO8bYHMU0zqxzK4zcRD8HScKV/vvJbOseHTiHu3yVQZ71FBHK3jDA5dia7V0ypo0Tfq+E2K3US2zRjakcE8hMYzPNVFDccZvH+gKjp97dyxOZsZxh0dpDJGdc=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WCbAKO1_1723448538)
          by smtp.aliyun-inc.com;
          Mon, 12 Aug 2024 15:42:18 +0800
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
Subject: [PATCH v5 1/9] mm: swap: extend swap_shmem_alloc() to support batch SWAP_MAP_SHMEM flag setting
Date: Mon, 12 Aug 2024 15:42:02 +0800
Message-Id: <99f64115d04b285e009580eb177352c57119ffd0.1723434324.git.baolin.wang@linux.alibaba.com>
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

To support shmem large folio swap operations, add a new parameter to
swap_shmem_alloc() that allows batch SWAP_MAP_SHMEM flag setting for
shmem swap entries.

While we are at it, using folio_nr_pages() to get the number of pages
of the folio as a preparation.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Barry Song <baohua@kernel.org>
---
 include/linux/swap.h | 4 ++--
 mm/shmem.c           | 6 ++++--
 mm/swapfile.c        | 4 ++--
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/linux/swap.h b/include/linux/swap.h
index 1c8f844a9f0f..248db1dd7812 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -481,7 +481,7 @@ void put_swap_folio(struct folio *folio, swp_entry_t entry);
 extern swp_entry_t get_swap_page_of_type(int);
 extern int get_swap_pages(int n, swp_entry_t swp_entries[], int order);
 extern int add_swap_count_continuation(swp_entry_t, gfp_t);
-extern void swap_shmem_alloc(swp_entry_t);
+extern void swap_shmem_alloc(swp_entry_t, int);
 extern int swap_duplicate(swp_entry_t);
 extern int swapcache_prepare(swp_entry_t entry, int nr);
 extern void swap_free_nr(swp_entry_t entry, int nr_pages);
@@ -548,7 +548,7 @@ static inline int add_swap_count_continuation(swp_entry_t swp, gfp_t gfp_mask)
 	return 0;
 }
 
-static inline void swap_shmem_alloc(swp_entry_t swp)
+static inline void swap_shmem_alloc(swp_entry_t swp, int nr)
 {
 }
 
diff --git a/mm/shmem.c b/mm/shmem.c
index 4a5254bfd610..22cdc10f27ea 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1452,6 +1452,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	swp_entry_t swap;
 	pgoff_t index;
+	int nr_pages;
 
 	/*
 	 * Our capabilities prevent regular writeback or sync from ever calling
@@ -1484,6 +1485,7 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
 	}
 
 	index = folio->index;
+	nr_pages = folio_nr_pages(folio);
 
 	/*
 	 * This is somewhat ridiculous, but without plumbing a SWAP_MAP_FALLOC
@@ -1536,8 +1538,8 @@ static int shmem_writepage(struct page *page, struct writeback_control *wbc)
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
index 6de12d712c7e..1caeee676696 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3604,9 +3604,9 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
  * Help swapoff by noting that swap entry belongs to shmem/tmpfs
  * (in which case its reference count is never incremented).
  */
-void swap_shmem_alloc(swp_entry_t entry)
+void swap_shmem_alloc(swp_entry_t entry, int nr)
 {
-	__swap_duplicate(entry, SWAP_MAP_SHMEM, 1);
+	__swap_duplicate(entry, SWAP_MAP_SHMEM, nr);
 }
 
 /*
-- 
2.39.3


