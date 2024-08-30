Return-Path: <linux-kernel+bounces-308510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D628965DEB
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BABD51C2327F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8628117C9F6;
	Fri, 30 Aug 2024 10:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKxa2nEz"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63C917B50D;
	Fri, 30 Aug 2024 10:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012287; cv=none; b=oTgrjB3G9vEq4vt0MsJyPfwJPU/04hpxmJoil6MQqfdTic0NaWXqoIZYFEib4pNVxi7HgOnxKH9saGMOTm6K7EXublLqrgXzSQIPwj1dWHv6JIsJQpV3tJRAYvxlo6qPBzZTYn2nJLpv0yZIv386Ya2B/aCH3Rx9Yvs3q/n9/Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012287; c=relaxed/simple;
	bh=Fdz8y4Ewmwe+LSgIoQD8kMMFXF75XcNR2I94nxW1Epg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWgd+rCvnTElN1sJM7oelGkdBTpXWaLYLzZxv3ub29QUJzCqa831x3HFB7jqkMZfZpclnv4bambP+m25+CZ7aY2cUK6TfvOS5Lz4HbdvPg0AWogSRzBLJMoY6J1Bg44anYl3cg9NIQyzBT/m090CKM4gpLAMhbzLBeXqo9nxcnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKxa2nEz; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5de8b17db8dso915449eaf.2;
        Fri, 30 Aug 2024 03:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725012285; x=1725617085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsaItdHLrkOs94vXPLpVeca+5XkpGp6YNABO6738q6c=;
        b=RKxa2nEzIgS8iRBBDoYChz1KnryiKd44u0gyOMcPv4IWE4sOU7Rp/TpQQZRiKfwmuX
         9fwvD/K5Sgc5ga/q6xgEWKM0f/8LB55wLP8cuVt28EkmzCjaeMyYr4pqLwnvpsFRJRCg
         FX4BlIf8nr152J3Nz25M31xhqzRSnWdxSwRzF1QZb8xvpGrkNGiJQzetWyu2UNAMjkoT
         PVfIAaZreiUSHU9IFBD3lU9SWtGDT4Sr74fmDD6u2MvImc78QwKq/OSmp6/sj/bspOwi
         rxrtZCY8hLJ4COxhnmGTSzuneECXLTTw15sIkzqkicOPildbZkpGc7km/GSc8d2zJQ6/
         FACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725012285; x=1725617085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lsaItdHLrkOs94vXPLpVeca+5XkpGp6YNABO6738q6c=;
        b=Ncwsn7tU1ap22sCPOIf0z/SgSmKXJmp6zgPERAZb72JyN0BDqMMVdElrl6SN+TFoVC
         hEceLA06BDSAQ6ljNtuXZfU0sgTDACflfrqss/+CdhdJ6qZZPG/1N/sgqvJ+nCmAXhQ4
         /Yr7BFCUQIWN7mq8CoD8+OdS8uOnVcDzH41ffl56FjzHH9902LkQxqd0P8gxf0Juj3pL
         rhyHsuhp1RpA2ASO1qROKZg5OlDXbsD9MT2Wb1hxmNeHWOh1vj9JL9fdeuYorJNpj8ni
         BC5lvg9fXyGDrdrC/Q6GVvROO6arVLYBxHg2MToCj6Haq0Hq8+Ly2EkzUB365Y2ITTy9
         2B6A==
X-Forwarded-Encrypted: i=1; AJvYcCULtefZeqs0l8JYQ8eAUxH2KXYpBxSQfSr6T7GuxBQY5TDppKR7vliV4XzB8cIcA1oUwRSXTBqqXRTnrZbY@vger.kernel.org, AJvYcCXCASqz6MYR1+fqj5+i55BJ23iFINYJyy6b0QzgzX6DddzGMk2/YoNr3ZvsBiQ+eo2dZjOfIEGZTw4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3z7wDmfsYvFmNgRg4nTMhY/0jmmECCqD5Y8kmn04TEo2gNEtt
	8HRg4b/7vSXXhg5TYBz6v2NsiOdWQYVNHjo4E8aMb8tLjTp0PaONNjx6qd09
X-Google-Smtp-Source: AGHT+IHVXyDvTPcFg0d6jozxHg1gXGpjAfSA3ZiESWLvV7o1PUmHfmhl+s0Gs537cY51gwYtkOJCDA==
X-Received: by 2002:a05:6820:1c9a:b0:5d5:bce7:677 with SMTP id 006d021491bc7-5dfacf2ff24mr1741737eaf.7.1725012284525;
        Fri, 30 Aug 2024 03:04:44 -0700 (PDT)
Received: from localhost (fwdproxy-ash-113.fbsv.net. [2a03:2880:20ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340c96856sm13189406d6.89.2024.08.30.03.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 03:04:43 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	yuzhao@google.com,
	david@redhat.com,
	npache@redhat.com,
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
Subject: [PATCH v5 2/6] mm: remap unused subpages to shared zeropage when splitting isolated thp
Date: Fri, 30 Aug 2024 11:03:36 +0100
Message-ID: <20240830100438.3623486-3-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240830100438.3623486-1-usamaarif642@gmail.com>
References: <20240830100438.3623486-1-usamaarif642@gmail.com>
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
index 91b5935e8485..d5e93e44322e 100644
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
index 0c48806ccb9a..af60684e7c70 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3020,7 +3020,7 @@ bool unmap_huge_pmd_locked(struct vm_area_struct *vma, unsigned long addr,
 	return false;
 }
 
-static void remap_page(struct folio *folio, unsigned long nr)
+static void remap_page(struct folio *folio, unsigned long nr, int flags)
 {
 	int i = 0;
 
@@ -3028,7 +3028,7 @@ static void remap_page(struct folio *folio, unsigned long nr)
 	if (!folio_test_anon(folio))
 		return;
 	for (;;) {
-		remove_migration_ptes(folio, folio, true);
+		remove_migration_ptes(folio, folio, RMP_LOCKED | flags);
 		i += folio_nr_pages(folio);
 		if (i >= nr)
 			break;
@@ -3240,7 +3240,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
 
 	if (nr_dropped)
 		shmem_uncharge(folio->mapping->host, nr_dropped);
-	remap_page(folio, nr);
+	remap_page(folio, nr, PageAnon(head) ? RMP_USE_SHARED_ZEROPAGE : 0);
 
 	/*
 	 * set page to its compound_head when split to non order-0 pages, so
@@ -3542,7 +3542,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		if (mapping)
 			xas_unlock(&xas);
 		local_irq_enable();
-		remap_page(folio, folio_nr_pages(folio));
+		remap_page(folio, folio_nr_pages(folio), 0);
 		ret = -EAGAIN;
 	}
 
diff --git a/mm/migrate.c b/mm/migrate.c
index 6f9c62c746be..d039863e014b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -204,13 +204,57 @@ bool isolate_folio_to_list(struct folio *folio, struct list_head *list)
 	return true;
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
+	if (folio_test_mlocked(folio) || (pvmw->vma->vm_flags & VM_LOCKED) ||
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
@@ -234,6 +278,9 @@ static bool remove_migration_pte(struct folio *folio,
 			continue;
 		}
 #endif
+		if (rmap_walk_arg->map_unused_to_zeropage &&
+		    try_to_map_unused_to_zeropage(&pvmw, folio, idx))
+			continue;
 
 		folio_get(folio);
 		pte = mk_pte(new, READ_ONCE(vma->vm_page_prot));
@@ -312,14 +359,21 @@ static bool remove_migration_pte(struct folio *folio,
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
@@ -934,7 +988,7 @@ static int writeout(struct address_space *mapping, struct folio *folio)
 	 * At this point we know that the migration attempt cannot
 	 * be successful.
 	 */
-	remove_migration_ptes(folio, folio, false);
+	remove_migration_ptes(folio, folio, 0);
 
 	rc = mapping->a_ops->writepage(&folio->page, &wbc);
 
@@ -1098,7 +1152,7 @@ static void migrate_folio_undo_src(struct folio *src,
 				   struct list_head *ret)
 {
 	if (page_was_mapped)
-		remove_migration_ptes(src, src, false);
+		remove_migration_ptes(src, src, 0);
 	/* Drop an anon_vma reference if we took one */
 	if (anon_vma)
 		put_anon_vma(anon_vma);
@@ -1336,7 +1390,7 @@ static int migrate_folio_move(free_folio_t put_new_folio, unsigned long private,
 		lru_add_drain();
 
 	if (old_page_state & PAGE_WAS_MAPPED)
-		remove_migration_ptes(src, dst, false);
+		remove_migration_ptes(src, dst, 0);
 
 out_unlock_both:
 	folio_unlock(dst);
@@ -1474,7 +1528,7 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
 
 	if (page_was_mapped)
 		remove_migration_ptes(src,
-			rc == MIGRATEPAGE_SUCCESS ? dst : src, false);
+			rc == MIGRATEPAGE_SUCCESS ? dst : src, 0);
 
 unlock_put_anon:
 	folio_unlock(dst);
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 8d687de88a03..9cf26592ac93 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -424,7 +424,7 @@ static unsigned long migrate_device_unmap(unsigned long *src_pfns,
 			continue;
 
 		folio = page_folio(page);
-		remove_migration_ptes(folio, folio, false);
+		remove_migration_ptes(folio, folio, 0);
 
 		src_pfns[i] = 0;
 		folio_unlock(folio);
@@ -840,7 +840,7 @@ void migrate_device_finalize(unsigned long *src_pfns,
 			dst = src;
 		}
 
-		remove_migration_ptes(src, dst, false);
+		remove_migration_ptes(src, dst, 0);
 		folio_unlock(src);
 
 		if (folio_is_zone_device(src))
-- 
2.43.5


