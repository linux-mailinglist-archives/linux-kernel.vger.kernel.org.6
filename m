Return-Path: <linux-kernel+bounces-284713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC24895045E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 284F51F24152
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7203E1993BD;
	Tue, 13 Aug 2024 12:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjp0tLUW"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C520E199221;
	Tue, 13 Aug 2024 12:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723550628; cv=none; b=AUgTdtv2A5E/2RiEIJK1MbfQLyCFqcHwTZENE8QvrcG49Oo9/+G02m26tiPRHOkKjdzlzUGG9xYNrM0zRRunDQ86dhnCJnKIgt/VBp5QN34kILHalkQcJTFqoJm2jpDlp6Oarw+YT8cV9z+diI6Td6PGrbs8slpygoko5jEaAiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723550628; c=relaxed/simple;
	bh=o4I5yjQIdFXxZ7sVL+MMpAW222CgyrF+0buKw3KytsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+aO/SjvDWZGT4At+1IqZxG7APVj1UqqROYi9kSrYR6VoFkvW1vO9mqUIFnVn2leoUFpeWJ74KpyrDn1+Pr+u1ZPsA+A8NSj5JpIq54SmE9qzhyotB27siKxnZ+l96lodByCTQxKMOvnTmApxZgyt4OtLP8/dLPGzAYHU7DG8wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjp0tLUW; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44fee8813c3so32332561cf.2;
        Tue, 13 Aug 2024 05:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723550625; x=1724155425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ArHqWK+pDk4THc6HGtgBtflIMEbd37YycfL2VsChgqA=;
        b=bjp0tLUW2HV8kjKRUlMb63g8jJe+zXS6EGrGEKtVHkLYZ2BnwG+Rn56/bzt6DaN4XT
         dRf2Nt299faRZQRL+iKMMfhShgia+jomMCyHBGc1YPMUv7KO5nzbTs9FlQGEFDePpU/o
         5UHjQV37bHrzn0oChb8c1jKDpm3495FfQEE44WLptkNnKYhR44efMDKdajyQX6QVZSrJ
         I9Vlve3JcqvRzrTS8f/fIq9zB0npIUoZl0RrJnKMso1bhi3rcmx0dG6dtgx3kWISCFxO
         qNgKPTD3kt7fMQhYPsJBiZxTiTFGYBg/z//sXtWilcEnW6nM/as3puHiWVG3+xNs8s7L
         0zxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723550625; x=1724155425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ArHqWK+pDk4THc6HGtgBtflIMEbd37YycfL2VsChgqA=;
        b=jKMeJjF1tPxCyX/rj46m46AokF9eIcfvlZTLtwSK/aCTBSAXMiurBKDKSBzGIHQSWl
         De1lRwM/3QIxlebSrhEAl5qr3OxxfLRbsUlebXzFZQDcDS3ULZop/in5Agf8ijVbNU4n
         0xuyU7p4l6O+W4ZmpUy+/iYoUOOi/XI3LR+mbF6wmttEYVdZr2+Nyi4ktI7kPPeG6YAA
         C8YZ0ZZxG/FUXweXB/aztiRvdTcERhXodUTRdE4xZDitsHeGjTswjxO+dqcXs3uSPfQK
         3koh28jqPM0cmT9voOonOKHIR+IgRJlB0SUsmRnUc0yYh8xcMSbYfMrQ4fd//54KGz4S
         pheg==
X-Forwarded-Encrypted: i=1; AJvYcCUbcRzihpJ9gviBAMXzUo5MVZJsCVjf8ojfUQlyS1mali/td/0oG1GB/jqVcDWL/XEZsSKXNZjMcJmEzoHN2avIZBWzEzotfvNOZ0Tw9HY1XsfmBM5pL6o8PubRp6eEhQqQRjtyXrHp
X-Gm-Message-State: AOJu0Yz/raWnzrsePkdVHlSbXKLwxn8zujwWRPof0P/Fz60Wl1EHlR0K
	6mjc8y7pgxMGUgxSKT4X35lWQraL7wVzyGe9vw6T1U0+iRjPRF5P
X-Google-Smtp-Source: AGHT+IFmFyxDVIM6hJt06Re344Hp5hGhJ4dfTOoArazVB1tqefIgGdnCSzB4+w1duntTekqvxAqRhA==
X-Received: by 2002:a05:622a:316:b0:453:4aaa:d585 with SMTP id d75a77b69052e-4534aaad5f5mr34502981cf.4.1723550625396;
        Tue, 13 Aug 2024 05:03:45 -0700 (PDT)
Received: from localhost (fwdproxy-ash-000.fbsv.net. [2a03:2880:20ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4531c1a7f12sm31519601cf.20.2024.08.13.05.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 05:03:45 -0700 (PDT)
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
Subject: [PATCH v3 2/6] mm: remap unused subpages to shared zeropage when splitting isolated thp
Date: Tue, 13 Aug 2024 13:02:45 +0100
Message-ID: <20240813120328.1275952-3-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240813120328.1275952-1-usamaarif642@gmail.com>
References: <20240813120328.1275952-1-usamaarif642@gmail.com>
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
 mm/migrate.c         | 71 ++++++++++++++++++++++++++++++++++++++------
 mm/migrate_device.c  |  4 +--
 4 files changed, 74 insertions(+), 16 deletions(-)

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
index 85a424e954be..6df0e9f4f56c 100644
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
@@ -3424,7 +3424,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		if (mapping)
 			xas_unlock(&xas);
 		local_irq_enable();
-		remap_page(folio, folio_nr_pages(folio));
+		remap_page(folio, folio_nr_pages(folio), 0);
 		ret = -EAGAIN;
 	}
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 66a5f73ebfdf..3288ac041d03 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -178,13 +178,56 @@ void putback_movable_pages(struct list_head *l)
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
@@ -208,6 +251,9 @@ static bool remove_migration_pte(struct folio *folio,
 			continue;
 		}
 #endif
+		if (rmap_walk_arg->map_unused_to_zeropage &&
+		    try_to_map_unused_to_zeropage(&pvmw, folio, idx))
+			continue;
 
 		folio_get(folio);
 		pte = mk_pte(new, READ_ONCE(vma->vm_page_prot));
@@ -286,14 +332,21 @@ static bool remove_migration_pte(struct folio *folio,
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
@@ -903,7 +956,7 @@ static int writeout(struct address_space *mapping, struct folio *folio)
 	 * At this point we know that the migration attempt cannot
 	 * be successful.
 	 */
-	remove_migration_ptes(folio, folio, false);
+	remove_migration_ptes(folio, folio, 0);
 
 	rc = mapping->a_ops->writepage(&folio->page, &wbc);
 
@@ -1067,7 +1120,7 @@ static void migrate_folio_undo_src(struct folio *src,
 				   struct list_head *ret)
 {
 	if (page_was_mapped)
-		remove_migration_ptes(src, src, false);
+		remove_migration_ptes(src, src, 0);
 	/* Drop an anon_vma reference if we took one */
 	if (anon_vma)
 		put_anon_vma(anon_vma);
@@ -1305,7 +1358,7 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 		lru_add_drain();
 
 	if (old_page_state & PAGE_WAS_MAPPED)
-		remove_migration_ptes(src, dst, false);
+		remove_migration_ptes(src, dst, 0);
 
 out_unlock_both:
 	folio_unlock(dst);
@@ -1443,7 +1496,7 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
 
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


