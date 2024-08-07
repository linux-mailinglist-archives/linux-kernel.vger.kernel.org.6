Return-Path: <linux-kernel+bounces-277977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B7494A8E5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89F71C234C2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17289205E21;
	Wed,  7 Aug 2024 13:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tx+wvUOg"
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F23720011B;
	Wed,  7 Aug 2024 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038470; cv=none; b=l2LR5EVZkGPxOO2b7r/GK1gwdquusKJ9R/irKlg1iSW4xxTb2rGsfMa8v9STBk1BXES1coYSfw0rBDMPUorECtawq3idBjnHlgzT5yhAaXO+AnDyaqq8tu51UtmGaHePEBTAKLH0umuwgXozbSubE968A1hQa7vq5SId2+rumHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038470; c=relaxed/simple;
	bh=NzFoTGqePSl75KuLTJQQAk9kviFjsUilR9P8U94mkzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfvyXQaADPNH9JUe9YLRQRaTruFBOT4shHak28B06MEmOwvU7tdBamJ+RXj7Qss7fBYCMAuDdx0Fm/Y59InNiEb+CZOLts3ab1vC9+IoIE0icBgqdSTDN555RQenn0CFfIwIa+vYGzndFfLH6dzjOaXjJvuDp21M83Wu2QfU26o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tx+wvUOg; arc=none smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-4ef76f04977so655910e0c.2;
        Wed, 07 Aug 2024 06:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723038467; x=1723643267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LrcHBbBjGvoBIcRfzqDWEX/bsJ6vuZqKnqLHD0pWlg=;
        b=Tx+wvUOg3f7OblpjBC2FNO5dEv5Qp4UinK+HStPQ0d2C1KB1lbBlcM2UQsdUlUxPy1
         aYDVcfEmFJaNe0hB210Svr4bojrplM8bj7nzUvnhdaneQnvIe9XDE1OroZgy+6M4nven
         QnWGWlhexsTzS/CW9QoKC/GxzYpyYaNVU0jo8UkfigOsk9GQdWa2CxwqEIqj6c1PhD97
         zhGLC3/1kinqFS30tMOwsomHxck0DTSOLWHqs2q3RpbhzQ8dti7c7N3JwgyuQljrJeqd
         HPqyAqL0ey1xOHWVldDxtsSZv1YSDSqNK/jLaPm1ZPfzSA4YxpSwQFtAZ8dyY6c5itMn
         XoWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723038467; x=1723643267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6LrcHBbBjGvoBIcRfzqDWEX/bsJ6vuZqKnqLHD0pWlg=;
        b=FPsapTcc1d0ziL0fDZN4sVNeucJYviN1U+W4k9vDJ/rMJBDY0OjBwbPLZCyea6YPbG
         CRZ4UkEWYWTPAZu0vLeFS5xX+zM26AD80OHFFkS7oYILc63sJ1mmjonzDNqWeovk8NcO
         aLXqxvXb8/4xLkctObdPeWfoJs9JF4gDiND2h/03Zqtkn7fIav+Oiks/ZBi3SyEwK/sh
         g/B07NCZFMfeqX8DNOXjZ1R5y8CBEETe1PQ+6NLkj1RRv2dBPbHk0BIdDkQBHAKqPtG+
         zLcQXV4NIKbkwoiu3IzzTfn3ti1s6wkTT2qiCPCUJClmwlljFVmyRuyle/ZfHBYfiv3g
         37rA==
X-Forwarded-Encrypted: i=1; AJvYcCX+IVjlC8ZRq2HuBS4UAlJcRKdTy3R1FwQkHcjreNviENtB/gIAQUMS9BMAvJ23RwTyaXFsKpW/qFdE7Wv7oEVsKQTcSX4FNFNreDYHL6JYuUQ8PySzgmdQnNmA9OG84xW8nmyF8Boj
X-Gm-Message-State: AOJu0Yy8y8JOtTs/tG46StUEvZb0Xf5jygO2RB3KZvDpUZzQ7/LzU3OH
	m00DKe2+Oq7X7Zzd/5FK3nZT/qn8ufHcn3KiFrri0KsriI27W+nx
X-Google-Smtp-Source: AGHT+IEKNRmKBXFXCoBdFW8abQCMUy54SbhOhdx5P4ZraOD0Qnn66IVQa1IpV7svr2geXrOp2Wi/sQ==
X-Received: by 2002:a05:6122:31a7:b0:4f5:14c7:822f with SMTP id 71dfb90a1353d-4f89ff3b1cfmr22113993e0c.3.1723038466827;
        Wed, 07 Aug 2024 06:47:46 -0700 (PDT)
Received: from localhost (fwdproxy-ash-006.fbsv.net. [2a03:2880:20ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3785e5c54sm62238785a.48.2024.08.07.06.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 06:47:46 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	yuzhao@google.com,
	david@redhat.com,
	baohua@kernel.org,
	ryan.roberts@arm.com,
	rppt@kernel.org,
	willy@infradead.org,
	cerasuolodomenico@gmail.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	Shuang Zhai <zhais@google.com>,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v2 2/4] mm: remap unused subpages to shared zeropage when splitting isolated thp
Date: Wed,  7 Aug 2024 14:46:47 +0100
Message-ID: <20240807134732.3292797-3-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240807134732.3292797-1-usamaarif642@gmail.com>
References: <20240807134732.3292797-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yu Zhao <yuzhao@google.com>

Here being unused means containing only zeros and inaccessible to
userspace. When splitting an isolated thp under reclaim or migration,
the unused subpages can be mapped to the shared zeropage, hence saving
memory. This is particularly helpful when the internal
fragmentation of a thp is high, i.e. it has many untouched subpages.

This is also a prerequisite for THP low utilization shrinker which will
be introduced in later patches, where underutilized THPs are split, and
the zero-filled pages are freed saving memory.

Signed-off-by: Yu Zhao <yuzhao@google.com>
Tested-by: Shuang Zhai <zhais@google.com>
Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 include/linux/rmap.h |  3 +-
 mm/huge_memory.c     |  8 ++---
 mm/migrate.c         | 70 +++++++++++++++++++++++++++++++++++++++-----
 mm/migrate_device.c  |  4 +--
 4 files changed, 70 insertions(+), 15 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 0978c64f49d8..1d338466a495 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -745,7 +745,8 @@ int folio_mkclean(struct folio *);
 int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
 		      struct vm_area_struct *vma);
 
-void remove_migration_ptes(struct folio *src, struct folio *dst, bool locked);
+void remove_migration_ptes(struct folio *src, struct folio *dst, bool locked,
+			   bool map_unused_to_zeropage);
 
 /*
  * rmap_walk_control: To control rmap traversing for specific needs
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 35c1089d8d61..891562665e19 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2775,7 +2775,7 @@ bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long addr,
 	return false;
 }
 
-static void remap_page(struct folio *folio, unsigned long nr)
+static void remap_page(struct folio *folio, unsigned long nr, bool map_unused_to_zeropage)
 {
 	int i = 0;
 
@@ -2783,7 +2783,7 @@ static void remap_page(struct folio *folio, unsigned long nr)
 	if (!folio_test_anon(folio))
 		return;
 	for (;;) {
-		remove_migration_ptes(folio, folio, true);
+		remove_migration_ptes(folio, folio, true, map_unused_to_zeropage);
 		i += folio_nr_pages(folio);
 		if (i >= nr)
 			break;
@@ -2993,7 +2993,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 
 	if (nr_dropped)
 		shmem_uncharge(folio->mapping->host, nr_dropped);
-	remap_page(folio, nr);
+	remap_page(folio, nr, PageAnon(head));
 
 	/*
 	 * set page to its compound_head when split to non order-0 pages, so
@@ -3287,7 +3287,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		if (mapping)
 			xas_unlock(&xas);
 		local_irq_enable();
-		remap_page(folio, folio_nr_pages(folio));
+		remap_page(folio, folio_nr_pages(folio), false);
 		ret = -EAGAIN;
 	}
 
diff --git a/mm/migrate.c b/mm/migrate.c
index b273bac0d5ae..151bf1b6204d 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -177,13 +177,56 @@ void putback_movable_pages(struct list_head *l)
 	}
 }
 
+static bool try_to_map_unused_to_zeropage(struct page_vma_mapped_walk *pvmw,
+					  struct folio *folio,
+					  unsigned long idx)
+{
+	struct page *page = folio_page(folio, idx);
+	bool contains_data;
+	pte_t newpte;
+	void *addr;
+
+	VM_BUG_ON_PAGE(PageCompound(page), page);
+	VM_BUG_ON_PAGE(!PageAnon(page), page);
+	VM_BUG_ON_PAGE(!PageLocked(page), page);
+	VM_BUG_ON_PAGE(pte_present(*pvmw->pte), page);
+
+	if (PageMlocked(page) || (pvmw->vma->vm_flags & VM_LOCKED))
+		return false;
+
+	/*
+	 * The pmd entry mapping the old thp was flushed and the pte mapping
+	 * this subpage has been non present. If the subpage is only zero-filled
+	 * then map it to the shared zeropage.
+	 */
+	addr = kmap_local_page(page);
+	contains_data = memchr_inv(addr, 0, PAGE_SIZE);
+	kunmap_local(addr);
+
+	if (contains_data || mm_forbids_zeropage(pvmw->vma->vm_mm))
+		return false;
+
+	newpte = pte_mkspecial(pfn_pte(page_to_pfn(ZERO_PAGE(pvmw->address)),
+					pvmw->vma->vm_page_prot));
+	set_pte_at(pvmw->vma->vm_mm, pvmw->address, pvmw->pte, newpte);
+
+	dec_mm_counter(pvmw->vma->vm_mm, mm_counter(folio));
+	return true;
+}
+
+struct rmap_walk_arg {
+	struct folio *folio;
+	bool map_unused_to_zeropage;
+};
+
 /*
  * Restore a potential migration pte to a working pte entry
  */
 static bool remove_migration_pte(struct folio *folio,
-		struct vm_area_struct *vma, unsigned long addr, void *old)
+		struct vm_area_struct *vma, unsigned long addr, void *arg)
 {
-	DEFINE_FOLIO_VMA_WALK(pvmw, old, vma, addr, PVMW_SYNC | PVMW_MIGRATION);
+	struct rmap_walk_arg *rmap_walk_arg = arg;
+	DEFINE_FOLIO_VMA_WALK(pvmw, rmap_walk_arg->folio, vma, addr, PVMW_SYNC | PVMW_MIGRATION);
 
 	while (page_vma_mapped_walk(&pvmw)) {
 		rmap_t rmap_flags = RMAP_NONE;
@@ -207,6 +250,9 @@ static bool remove_migration_pte(struct folio *folio,
 			continue;
 		}
 #endif
+		if (rmap_walk_arg->map_unused_to_zeropage &&
+		    try_to_map_unused_to_zeropage(&pvmw, folio, idx))
+			continue;
 
 		folio_get(folio);
 		pte = mk_pte(new, READ_ONCE(vma->vm_page_prot));
@@ -285,13 +331,21 @@ static bool remove_migration_pte(struct folio *folio,
  * Get rid of all migration entries and replace them by
  * references to the indicated page.
  */
-void remove_migration_ptes(struct folio *src, struct folio *dst, bool locked)
+void remove_migration_ptes(struct folio *src, struct folio *dst, bool locked,
+			   bool map_unused_to_zeropage)
 {
+	struct rmap_walk_arg rmap_walk_arg = {
+		.folio = src,
+		.map_unused_to_zeropage = map_unused_to_zeropage,
+	};
+
 	struct rmap_walk_control rwc = {
 		.rmap_one = remove_migration_pte,
-		.arg = src,
+		.arg = &rmap_walk_arg,
 	};
 
+	VM_BUG_ON_FOLIO(map_unused_to_zeropage && src != dst, src);
+
 	if (locked)
 		rmap_walk_locked(dst, &rwc);
 	else
@@ -904,7 +958,7 @@ static int writeout(struct address_space *mapping, struct folio *folio)
 	 * At this point we know that the migration attempt cannot
 	 * be successful.
 	 */
-	remove_migration_ptes(folio, folio, false);
+	remove_migration_ptes(folio, folio, false, false);
 
 	rc = mapping->a_ops->writepage(&folio->page, &wbc);
 
@@ -1068,7 +1122,7 @@ static void migrate_folio_undo_src(struct folio *src,
 				   struct list_head *ret)
 {
 	if (page_was_mapped)
-		remove_migration_ptes(src, src, false);
+		remove_migration_ptes(src, src, false, false);
 	/* Drop an anon_vma reference if we took one */
 	if (anon_vma)
 		put_anon_vma(anon_vma);
@@ -1306,7 +1360,7 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 		lru_add_drain();
 
 	if (old_page_state & PAGE_WAS_MAPPED)
-		remove_migration_ptes(src, dst, false);
+		remove_migration_ptes(src, dst, false, false);
 
 out_unlock_both:
 	folio_unlock(dst);
@@ -1444,7 +1498,7 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
 
 	if (page_was_mapped)
 		remove_migration_ptes(src,
-			rc == MIGRATEPAGE_SUCCESS ? dst : src, false);
+			rc == MIGRATEPAGE_SUCCESS ? dst : src, false, false);
 
 unlock_put_anon:
 	folio_unlock(dst);
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 6d66dc1c6ffa..a1630d8e0d95 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -424,7 +424,7 @@ static unsigned long migrate_device_unmap(unsigned long *src_pfns,
 			continue;
 
 		folio = page_folio(page);
-		remove_migration_ptes(folio, folio, false);
+		remove_migration_ptes(folio, folio, false, false);
 
 		src_pfns[i] = 0;
 		folio_unlock(folio);
@@ -837,7 +837,7 @@ void migrate_device_finalize(unsigned long *src_pfns,
 
 		src = page_folio(page);
 		dst = page_folio(newpage);
-		remove_migration_ptes(src, dst, false);
+		remove_migration_ptes(src, dst, false, false);
 		folio_unlock(src);
 
 		if (is_zone_device_page(page))
-- 
2.43.5


