Return-Path: <linux-kernel+bounces-240961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E592E927517
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7342E1F21ED2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C4B1AED35;
	Thu,  4 Jul 2024 11:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="B7EEJvKz"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4267A1AC43C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 11:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720092321; cv=none; b=NaqzVCF2r9Y9N1cNUyYckNL718Lh2g1uNkLwCWHu2h8fxWiSHQJqkmG10MTPCmM0aKypG/CWmIREkXclOt/EBjE1qNy0fuQvWxavBHhbPvGkfbLMwr9r8aAuP4UGBu3CJHPREf4+dxv+LH1xliJbgSTCVPX60JWf4VjO5XRtHYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720092321; c=relaxed/simple;
	bh=EwMq0nRZSO0UNVZcx6vJx8Z3PbK3Biscr0/ozCwmLws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WKMZMcHDv2dCLbkkXygX3lPi0aA74m6djewAbm79G+b29ytuElmo2uZ7ovMyiS657EU/MQhJjbeQHw6Oyd9oi4qjnBQ22CoLhzo2jiFT7A9yoRe78t8XZBILJyCYF6GNdmT0Pl1rTJbF5zBYiwv7jK0TqMy75J2cMLmL9sVYEI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=B7EEJvKz; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720092316; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=cw7XWKxljyeN4WJVgu0jE9S3cyW8I72GFf5V991lB4Y=;
	b=B7EEJvKz/X883XfMGuFi9jG+UE8TcyudSYkIYIzSCzUj4Prl/bx6hMf3/ErL9rvba1KHDRrX5YPn333FhqxQQWGYSaYs49Gl9f60zGHW1Ak0fQUaL8Ut2xb6N3nF65CfHt4esy3VCbonkJzPDsYblZfuEtfjyLXAOh8QGjrwKuY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033023225041;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W9qjnNh_1720092313;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W9qjnNh_1720092313)
          by smtp.aliyun-inc.com;
          Thu, 04 Jul 2024 19:25:14 +0800
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
Subject: [PATCH v3 06/10] mm: shmem: use swap_free_nr() to free shmem swap entries
Date: Thu,  4 Jul 2024 19:24:55 +0800
Message-Id: <23ca2d1733c1a4e9f9781312a2dc21c8873b3bd5.1720079976.git.baolin.wang@linux.alibaba.com>
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

As a preparation for supporting shmem large folio swapout, use swap_free_nr()
to free some continuous swap entries of the shmem large folio when the
large folio was swapped in from the swap cache. In addition, the index
should also be round down to the number of pages when adding the swapin
folio into the pagecache.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 5159d60456ed..c1b6cdc61619 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1961,6 +1961,7 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 	struct address_space *mapping = inode->i_mapping;
 	swp_entry_t swapin_error;
 	void *old;
+	int nr_pages;
 
 	swapin_error = make_poisoned_swp_entry();
 	old = xa_cmpxchg_irq(&mapping->i_pages, index,
@@ -1969,6 +1970,7 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 	if (old != swp_to_radix_entry(swap))
 		return;
 
+	nr_pages = folio_nr_pages(folio);
 	folio_wait_writeback(folio);
 	delete_from_swap_cache(folio);
 	/*
@@ -1976,8 +1978,8 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 	 * won't be 0 when inode is released and thus trigger WARN_ON(i_blocks)
 	 * in shmem_evict_inode().
 	 */
-	shmem_recalc_inode(inode, -1, -1);
-	swap_free(swap);
+	shmem_recalc_inode(inode, -nr_pages, -nr_pages);
+	swap_free_nr(swap, nr_pages);
 }
 
 /*
@@ -1996,7 +1998,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	struct swap_info_struct *si;
 	struct folio *folio = NULL;
 	swp_entry_t swap;
-	int error;
+	int error, nr_pages;
 
 	VM_BUG_ON(!*foliop || !xa_is_value(*foliop));
 	swap = radix_to_swp_entry(*foliop);
@@ -2043,6 +2045,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 		goto failed;
 	}
 	folio_wait_writeback(folio);
+	nr_pages = folio_nr_pages(folio);
 
 	/*
 	 * Some architectures may have to restore extra metadata to the
@@ -2056,19 +2059,20 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			goto failed;
 	}
 
-	error = shmem_add_to_page_cache(folio, mapping, index,
+	error = shmem_add_to_page_cache(folio, mapping,
+					round_down(index, nr_pages),
 					swp_to_radix_entry(swap), gfp);
 	if (error)
 		goto failed;
 
-	shmem_recalc_inode(inode, 0, -1);
+	shmem_recalc_inode(inode, 0, -nr_pages);
 
 	if (sgp == SGP_WRITE)
 		folio_mark_accessed(folio);
 
 	delete_from_swap_cache(folio);
 	folio_mark_dirty(folio);
-	swap_free(swap);
+	swap_free_nr(swap, nr_pages);
 	put_swap_device(si);
 
 	*foliop = folio;
-- 
2.39.3


