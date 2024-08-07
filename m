Return-Path: <linux-kernel+bounces-277470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6725C94A1CB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 09:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9906C1C213E5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 07:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFB31CCB46;
	Wed,  7 Aug 2024 07:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qH5quQns"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60791CB324
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 07:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723015905; cv=none; b=tCb9cc8Ek7dqRJFnNq3AB8hnKLjXT11lZn1GW8P138yEx4FWiQJ6B5T00cxzOPUdbukxNI/6ZNVxSremiZHXkf0ofwZTFHNHKtp8ABBLaHbs4YPln5SBo6vJOgnjRFuXpuAn6C9Y3O6VeKvODcVJ72G4b8aRaEx1KJJRm+fMY7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723015905; c=relaxed/simple;
	bh=68HIudlpGk+ESEOygYNQxPojYTg/dxgEFFDRbpcvT9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lUwIicvGAexK7MxWRM781SoZvII3sYswojpqZkSUhb0CQdk5zNIMvEa35F4x989cUykqGLVxCaeuMepzmbYaA/3au/WJXt5kugUfA09nwNCjXyEbpEAYNyH7Jc3awoi3GwySvurk1eeWTwgiyAnpufvjMh4yhUvlFTHlbdlm2oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qH5quQns; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723015895; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=CJ17mJWuqe6d52h6IBrZyk6CffbeYGvkfB1+lwHpEl4=;
	b=qH5quQnsdnDI4JbOS/1CvsVU5K2Lx1vyDJ/af2zfBsQ/xaWr1VQh1S9NRhpAP83PfVom1Fg/pkQj+CRSrtWyOjYhiWZ3wpK7q6jMcR2vIhmvcn8Syy9oV6C7dKU+BaaAgEKZCmeGefI/KTITc9uB615439BwHi3X0mGj0+9vlug=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0WCI1T.-_1723015893;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WCI1T.-_1723015893)
          by smtp.aliyun-inc.com;
          Wed, 07 Aug 2024 15:31:33 +0800
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
Subject: [PATCH v4 06/10] mm: shmem: use swap_free_nr() to free shmem swap entries
Date: Wed,  7 Aug 2024 15:31:11 +0800
Message-Id: <15eea8558d8980e6cf64ce8cd826cd0267742eed.1723012159.git.baolin.wang@linux.alibaba.com>
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


