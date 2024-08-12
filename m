Return-Path: <linux-kernel+bounces-282733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A3C94E800
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 09:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66351280F18
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 07:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C084416BE2A;
	Mon, 12 Aug 2024 07:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YqK8RcEK"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89596163A9B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 07:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723448554; cv=none; b=FUnijMGLhVWWdlNLncWPMVaKoeUyCMKBCx/F7OOVuzagf/KM2ujYMY7xmiJ/arK7VTCdYej8Ix1GVrNWJzWAwzBDtnj9xoC1T8mG8uUPES91Mvv0aFcK2ront8Y9jXGfFPZqtDwhioJ+B/Wcja8parpmznmq6R16KA/6MsOZZx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723448554; c=relaxed/simple;
	bh=68HIudlpGk+ESEOygYNQxPojYTg/dxgEFFDRbpcvT9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TAtjZETJ05Q5m/pT3VOcM4dLUKQ/4u33mDYYWovpxxv6Aa3zAliJ5hgcjuinmRHYpNR0ykQdy9nwmCYwvUsOWyLEKa4ABI+G8WkL9fcJly0e9BxxKJvAfzRUhe7u4peczw0Ge14L4HzrJbXue6s8G1zOo9AldZcELKtqUHH2paE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YqK8RcEK; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723448544; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=CJ17mJWuqe6d52h6IBrZyk6CffbeYGvkfB1+lwHpEl4=;
	b=YqK8RcEK97o5sDSbuo9hOYNwKT1ZNBSWmLzGGWQ/3gW5BMP0VeNaVm+JTvPKTW2kvy8bEd3E4BTfs20QEyMLlPNq0pHOa2uMbyMn27noS/F1426h8BidOfpHz4RfF3Uj60a0twx+9TGfLLtL+jPcU9cL/+2j+5kZaGdywgwvDNI=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WCazOiu_1723448542)
          by smtp.aliyun-inc.com;
          Mon, 12 Aug 2024 15:42:23 +0800
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
Subject: [PATCH v5 5/9] mm: shmem: use swap_free_nr() to free shmem swap entries
Date: Mon, 12 Aug 2024 15:42:06 +0800
Message-Id: <342207fa679fc88a447dac2e101ad79e6050fe79.1723434324.git.baolin.wang@linux.alibaba.com>
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
index d0d54939da48..f6bab42180ea 100644
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


