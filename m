Return-Path: <linux-kernel+bounces-291347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA28956116
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B97E28174C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31EF3B298;
	Mon, 19 Aug 2024 02:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knxV/M/P"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2764824B34;
	Mon, 19 Aug 2024 02:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724034715; cv=none; b=GpRco34jPhM/lAlM1yFnf8BeF4ZQ1xBiIS2UXE4/m3XWPryPP5Rq6phJje6VutmS4jCUNx5p/sYleKOarZ94ZKxANNnBVBK/d4xTpqnL2xbMqfez70PmKWliOr8orPxeeoWmBMRhZAUtpWKBTQc2iva4uGripiCF5OOe8Bj6yLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724034715; c=relaxed/simple;
	bh=OY3jL/RuT63CJ01Gu3hoK0+Ys0L8lwLLwKKANlweKos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KhTGThJ7vOxhScDEs6i/Q1RYLiiQm4aLmnIywc+jhKw+mD2EmnhAiSkz76oCnz+HOOW29/vEBsewaQaGWmjfvIoiEBIokD18pVb4AAgAhWHhuDi3NEZGdtd9GAe06H999RUlx0V1eAr3x/aJBg2yzYHdWHA2B7Jy75uzBHCUsgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knxV/M/P; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-454b3d89a18so10857911cf.2;
        Sun, 18 Aug 2024 19:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724034713; x=1724639513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Be5wg7AuGlyVLPd79rHyMZjywH2a3H2lUduVQVliSc=;
        b=knxV/M/PEZZ+ppwYuKLT1gX3blNNdLCRGqT6gVZXezJSoaqZ0Mpuwn4TACg46Zay4h
         yHiMjY4YrVLcr0UXzfRspgkd6trLXK1h4Fp6eGE29mjYiWx4HgjVAj8rOZswYVVNNnzq
         OnhOlZcntOgCHtRZIgEVawzeE04Q55njuUjZuUmdGn0Ufmd60jcUnaQGFiUp2B0umW6h
         SENe9NDfKIIsRz0jBIWur4G5n6hhi6KvkvDIgXlhw4ywwQb1aDODTPaGyb3RGMrTkqc7
         NJzxRgUMjfq2K5nlBX/G7+6t6Q+SWOkbfaYM/vARcHxVzLZ1CDvPSvLZYzpiZihj3sSk
         gCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724034713; x=1724639513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Be5wg7AuGlyVLPd79rHyMZjywH2a3H2lUduVQVliSc=;
        b=DK3MFk4Fzfa+kIM2mrC39HWf7kF0kZcI38FDrOb2bVJ3pwodRqpbmNkXm9PAHQfPEn
         3S/O/+ktiU7DQl9UEHR/XguqGJoxdSMv18zO/X1/gcgMcpie02glSbdwjU7jZKBEOn9d
         SAWjio2J5YWyA5Y8fZS7t3Sc72tHzrvG5gO5O9bb+4z10aoNF6yarHwD4BLhUEX9Dpc3
         x88d6K4YCEobbTPnrAdAaMkTc4gsyIaG8RjvxryhEUkESYga0mksDFvPMK+Zw9Zlf5Ce
         ot9dVVT5xd4HzntNdizgYJO87m3x97EMokibmBEx7LiWNVtEukevRU5AaqjwXFSHsyWr
         ZVRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsmE5xSvAJXQmKnnE0tTBrIHKP0LrYG2eOFGbmeoRHifW6dxmzKeJ1qDiSMrP1HGGFVf2r1pN7bweQCp+c6ZGc5h+QQM23/Q9Ukr7GiORxXt0aoz8ZAFeJuluXCNo82ocRjv89MeN+
X-Gm-Message-State: AOJu0Yww2ZWeLB6sTVw92D4OdJV7mY4ws7efRqHgPuAvjDjwSY7Phm5i
	bVltasnXue5fkrQJEDuFzPewyXaymMZPaa1aKSm2Ki+CmRbxZuUj
X-Google-Smtp-Source: AGHT+IFeP4hzF59Alq38selex7r4IkghqvqpA36paciq5N3TrCWUhapW14wSlaHsVPgGfZ79jyfiJw==
X-Received: by 2002:a05:622a:4c8b:b0:451:d557:22ed with SMTP id d75a77b69052e-454b67b6fd7mr63370071cf.11.1724034712823;
        Sun, 18 Aug 2024 19:31:52 -0700 (PDT)
Received: from localhost (fwdproxy-ash-000.fbsv.net. [2a03:2880:20ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369ff5460sm36860341cf.35.2024.08.18.19.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 19:31:52 -0700 (PDT)
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
	ryncsn@gmail.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kernel-team@meta.com,
	Shuang Zhai <zhais@google.com>,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v4 2/6] mm: remap unused subpages to shared zeropage when splitting isolated thp
Date: Mon, 19 Aug 2024 03:30:55 +0100
Message-ID: <20240819023145.2415299-3-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240819023145.2415299-1-usamaarif642@gmail.com>
References: <20240819023145.2415299-1-usamaarif642@gmail.com>
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
 include/linux/rmap.h |  7 ++++-
 mm/huge_memory.c     |  8 ++---
 mm/migrate.c         | 72 ++++++++++++++++++++++++++++++++++++++------
 mm/migrate_device.c  |  4 +--
 4 files changed, 75 insertions(+), 16 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index 0978c64f49d8..07854d1f9ad6 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -745,7 +745,12 @@ int folio_mkclean(struct folio *);
 int pfn_mkclean_range(unsigned long pfn, unsigned long nr_pages, pgoff_t pgoff,
 		      struct vm_area_struct *vma);
 
-void remove_migration_ptes(struct folio *src, struct folio *dst, bool locked);
+enum rmp_flags {
+	RMP_LOCKED		= 1 << 0,
+	RMP_USE_SHARED_ZEROPAGE	= 1 << 1,
+};
+
+void remove_migration_ptes(struct folio *src, struct folio *dst, int flags);
 
 /*
  * rmap_walk_control: To control rmap traversing for specific needs
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 147655821f09..2d77b5d2291e 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2911,7 +2911,7 @@ bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long addr,
 	return false;
 }
 
-static void remap_page(struct folio *folio, unsigned long nr)
+static void remap_page(struct folio *folio, unsigned long nr, int flags)
 {
 	int i = 0;
 
@@ -2919,7 +2919,7 @@ static void remap_page(struct folio *folio, unsigned long nr)
 	if (!folio_test_anon(folio))
 		return;
 	for (;;) {
-		remove_migration_ptes(folio, folio, true);
+		remove_migration_ptes(folio, folio, RMP_LOCKED | flags);
 		i += folio_nr_pages(folio);
 		if (i >= nr)
 			break;
@@ -3129,7 +3129,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 
 	if (nr_dropped)
 		shmem_uncharge(folio->mapping->host, nr_dropped);
-	remap_page(folio, nr);
+	remap_page(folio, nr, PageAnon(head) ? RMP_USE_SHARED_ZEROPAGE : 0);
 
 	/*
 	 * set page to its compound_head when split to non order-0 pages, so
@@ -3425,7 +3425,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		if (mapping)
 			xas_unlock(&xas);
 		local_irq_enable();
-		remap_page(folio, folio_nr_pages(folio));
+		remap_page(folio, folio_nr_pages(folio), 0);
 		ret = -EAGAIN;
 	}
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 66a5f73ebfdf..2d2e65d69427 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -178,13 +178,57 @@ void putback_movable_pages(struct list_head *l)
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
+	if (PageMlocked(page) || (pvmw->vma->vm_flags & VM_LOCKED) ||
+	    mm_forbids_zeropage(pvmw->vma->vm_mm))
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
+	if (contains_data)
+		return false;
+
+	newpte = pte_mkspecial(pfn_pte(my_zero_pfn(pvmw->address),
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
@@ -208,6 +252,9 @@ static bool remove_migration_pte(struct folio *folio,
 			continue;
 		}
 #endif
+		if (rmap_walk_arg->map_unused_to_zeropage &&
+		    try_to_map_unused_to_zeropage(&pvmw, folio, idx))
+			continue;
 
 		folio_get(folio);
 		pte = mk_pte(new, READ_ONCE(vma->vm_page_prot));
@@ -286,14 +333,21 @@ static bool remove_migration_pte(struct folio *folio,
  * Get rid of all migration entries and replace them by
  * references to the indicated page.
  */
-void remove_migration_ptes(struct folio *src, struct folio *dst, bool locked)
+void remove_migration_ptes(struct folio *src, struct folio *dst, int flags)
 {
+	struct rmap_walk_arg rmap_walk_arg = {
+		.folio = src,
+		.map_unused_to_zeropage = flags & RMP_USE_SHARED_ZEROPAGE,
+	};
+
 	struct rmap_walk_control rwc = {
 		.rmap_one = remove_migration_pte,
-		.arg = src,
+		.arg = &rmap_walk_arg,
 	};
 
-	if (locked)
+	VM_BUG_ON_FOLIO((flags & RMP_USE_SHARED_ZEROPAGE) && (src != dst), src);
+
+	if (flags & RMP_LOCKED)
 		rmap_walk_locked(dst, &rwc);
 	else
 		rmap_walk(dst, &rwc);
@@ -903,7 +957,7 @@ static int writeout(struct address_space *mapping, struct folio *folio)
 	 * At this point we know that the migration attempt cannot
 	 * be successful.
 	 */
-	remove_migration_ptes(folio, folio, false);
+	remove_migration_ptes(folio, folio, 0);
 
 	rc = mapping->a_ops->writepage(&folio->page, &wbc);
 
@@ -1067,7 +1121,7 @@ static void migrate_folio_undo_src(struct folio *src,
 				   struct list_head *ret)
 {
 	if (page_was_mapped)
-		remove_migration_ptes(src, src, false);
+		remove_migration_ptes(src, src, 0);
 	/* Drop an anon_vma reference if we took one */
 	if (anon_vma)
 		put_anon_vma(anon_vma);
@@ -1305,7 +1359,7 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 		lru_add_drain();
 
 	if (old_page_state & PAGE_WAS_MAPPED)
-		remove_migration_ptes(src, dst, false);
+		remove_migration_ptes(src, dst, 0);
 
 out_unlock_both:
 	folio_unlock(dst);
@@ -1443,7 +1497,7 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
 
 	if (page_was_mapped)
 		remove_migration_ptes(src,
-			rc == MIGRATEPAGE_SUCCESS ? dst : src, false);
+			rc == MIGRATEPAGE_SUCCESS ? dst : src, 0);
 
 unlock_put_anon:
 	folio_unlock(dst);
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 6d66dc1c6ffa..8f875636b35b 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -424,7 +424,7 @@ static unsigned long migrate_device_unmap(unsigned long *src_pfns,
 			continue;
 
 		folio = page_folio(page);
-		remove_migration_ptes(folio, folio, false);
+		remove_migration_ptes(folio, folio, 0);
 
 		src_pfns[i] = 0;
 		folio_unlock(folio);
@@ -837,7 +837,7 @@ void migrate_device_finalize(unsigned long *src_pfns,
 
 		src = page_folio(page);
 		dst = page_folio(newpage);
-		remove_migration_ptes(src, dst, false);
+		remove_migration_ptes(src, dst, 0);
 		folio_unlock(src);
 
 		if (is_zone_device_page(page))
-- 
2.43.5


