Return-Path: <linux-kernel+bounces-204219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 325358FE5F4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA1D288CC7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8BB195FDF;
	Thu,  6 Jun 2024 11:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RM6/4/Yb"
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792A4195F00
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 11:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675162; cv=none; b=uoAiShBiVoFVUEpY38CiSoDhfJ7m1Twhjv83C+6hqZal9rXU0e3SsD5lza2bA514wLWhVXwtNtS4L+J4V0sZL5FX+M8j0wFGNmcVrG24/0bIZ9mkRaa79CdvMKaLB+VnI4rdG+VWz6VHEgpvTZegvsHIbaM0Jo4dbPsEenrOmRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675162; c=relaxed/simple;
	bh=K1aaywgGvOPIWg+ZDd2XIcVWAq7l6RPCfYUvmzat4yM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CLeLfVoyHmEvScj16I1JjcUB6FNWO9xUztz/PiCe/eXkn5pYjmjWF/UNLDDtShsUDwvCmvF+7jabN5WziG3qbyZI2l6LF9RaR9TAzbuK8s7JhdgEh0uJzl5ci+SmUEZvQXgMcBl+8quFg8oX/Zc/m8KmqTtP1Bs3WhchdVZc8bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RM6/4/Yb; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717675158; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=o5pjG+XJpg8uvpOyj3LZoopMVj7n3+rVaRa69RLiHo8=;
	b=RM6/4/YbK+9Xf9JcWZ4HHChb9UcKhJvwSzseWX0XVQ3SULc5mbJ6NY5CZluLI9Zs0DRQfRFfHa3SWWQSgb32oL9QUE4eXgGFKpgjP9/8gHURhzZwky1/bRo5kfUvrGB9aUAMoOi6uo+8ZZAqZftkMwvepMuW+sHXNbkvZWQgiUs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0W7yDX0a_1717675156;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0W7yDX0a_1717675156)
          by smtp.aliyun-inc.com;
          Thu, 06 Jun 2024 19:59:17 +0800
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
Subject: [PATCH 6/7] mm: shmem: use swap_free_nr() to free shmem swap entries
Date: Thu,  6 Jun 2024 19:58:56 +0800
Message-Id: <cd4095146729a2e548664c1174f07b263dbe17a4.1717673614.git.baolin.wang@linux.alibaba.com>
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

As a preparation for supporting shmem large folio swapout, use swap_free_nr()
to free some continuous swap entries of the shmem large folio when the
large folio was swapped in from the swap cache.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 28ba603d87b8..33af3b2e5ecf 100644
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
@@ -2050,14 +2053,14 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
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


