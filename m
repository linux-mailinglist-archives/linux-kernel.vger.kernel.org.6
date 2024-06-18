Return-Path: <linux-kernel+bounces-218710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FF990C42B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 09:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA12B1C208C8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 07:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7F113AA22;
	Tue, 18 Jun 2024 06:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Zec3z7y8"
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B5A13A276
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 06:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718693684; cv=none; b=OVBGuXJlWB/xa5z/P8Xfa+4zau7LRbYLwnGNmxL1rFkKU3gf4B/35MWm2/ubndBSIXTS+P9MGTkXlQgAIeNTpSXhLCwFDCdxTBLvu8Ef7vjzy+siA/ZCpOXOvWJtAaWW/mqoGJo8pGNn8MNgP/vn8KxtkCNbNnBQjqpbsg6usBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718693684; c=relaxed/simple;
	bh=oAeBF5uoFhvlx+e/P4CdH7gVwx6K9SJHEsXMg/F3Cy8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m8qUuV4G7sYgSSc9MqsVnkm1BUs4HxD1PNby9l0oOioyYKbHnp8BN8HJKc/WypXfOuXTZUmaMWA1Jk2T6lFxeKal4Wx4ENKvl6TNhL1ZL2BUTaCVpDDDf4987OZ2A8JDJDoYuiP1blftBkS8S48Ts3ipXd15GII0hsQNFJj6pt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Zec3z7y8; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718693675; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Y0p1KmYvp9sydPHpYYHL11MSmx/npKoL7TRhS1PPQNA=;
	b=Zec3z7y8JJvzLm7WW1yS+ga26w9+4x6ND726snHCSXHo2uY+geDg1sWmzlXTUCqXIogRjryfOi7zTMh9Za8xhQtMqD4KHVrWmnj/cnhbgD9xMS9c10Nyqrv4+8grFwigY7HifLlC+hkf7tB8UuLrFGwcEDW7oOFr4IBLtcIW8Hg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W8jKUYu_1718693673;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W8jKUYu_1718693673)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 14:54:33 +0800
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
Subject: [PATCH v2 6/9] mm: shmem: use swap_free_nr() to free shmem swap entries
Date: Tue, 18 Jun 2024 14:54:18 +0800
Message-Id: <373a0d959930494b83f68169eddb62d0d49a29cf.1718690645.git.baolin.wang@linux.alibaba.com>
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
index a73d2da54897..4d7996962388 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1950,6 +1950,7 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 	struct address_space *mapping = inode->i_mapping;
 	swp_entry_t swapin_error;
 	void *old;
+	int nr_pages;
 
 	swapin_error = make_poisoned_swp_entry();
 	old = xa_cmpxchg_irq(&mapping->i_pages, index,
@@ -1958,6 +1959,7 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 	if (old != swp_to_radix_entry(swap))
 		return;
 
+	nr_pages = folio_nr_pages(folio);
 	folio_wait_writeback(folio);
 	delete_from_swap_cache(folio);
 	/*
@@ -1965,8 +1967,8 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
 	 * won't be 0 when inode is released and thus trigger WARN_ON(i_blocks)
 	 * in shmem_evict_inode().
 	 */
-	shmem_recalc_inode(inode, -1, -1);
-	swap_free(swap);
+	shmem_recalc_inode(inode, -nr_pages, -nr_pages);
+	swap_free_nr(swap, nr_pages);
 }
 
 /*
@@ -1985,7 +1987,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	struct swap_info_struct *si;
 	struct folio *folio = NULL;
 	swp_entry_t swap;
-	int error;
+	int error, nr_pages;
 
 	VM_BUG_ON(!*foliop || !xa_is_value(*foliop));
 	swap = radix_to_swp_entry(*foliop);
@@ -2032,6 +2034,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 		goto failed;
 	}
 	folio_wait_writeback(folio);
+	nr_pages = folio_nr_pages(folio);
 
 	/*
 	 * Some architectures may have to restore extra metadata to the
@@ -2045,19 +2048,20 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
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


