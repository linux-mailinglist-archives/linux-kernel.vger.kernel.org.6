Return-Path: <linux-kernel+bounces-200481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D01CD8FB0A6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 081731C21172
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 11:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065AA1459FE;
	Tue,  4 Jun 2024 11:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkkBC+Ih"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DBB14533F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717498802; cv=none; b=ld2+YS1Y0O0I4b3hk3TEWU9C85QYuqJcDkF4RYI6d4SUeIV4bi77wNSVv/5sdxdK/66Cpa6q0EzU0eFarLpqT3KqMbzIetYloRKlnqyKHzUCX5fKAltnNA0fTMcPtQ9xIzaQrFC61gFmb/CUi2Pkbc+Ezk+d57Look+E4brB32k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717498802; c=relaxed/simple;
	bh=4/gUhKUqAkATSuExKjP8Vx66XOOcURSzQCEk7ycR0NY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRCteR1S542YNbvEEdouXy9KZemzcaQUXRXePdzy4NrNkYo+/o37uDvmFxifd5uxbTQxfBj/ljHcF9Nyek+FV8MQ1TWzv/ZfXd2aoy7UWwPoBEF1yoUlPjJdxlclcGCX9wR00GkgVpR2+71otGDNY27wT39Nwoqyf+SMLor8gEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkkBC+Ih; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6ae1059a62fso5690346d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jun 2024 04:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717498800; x=1718103600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asgpbMnZY0t8v6Jl3H5uUs1NISRsXbBHVciypDjEWY8=;
        b=jkkBC+IhyMHkDOYS9zZNsoVW/fcz6KS4gFwRm/szjOqrPDLns+TTflVogv+zf2NkeW
         V9TNce7AOUnDEi7HAAsPZYrOGZ8BNkjLzer27e7ak7QcGQIti/dMuLJ8DL+aJ3UbY24D
         99TNoP+u414fmCJ3Vf0xpQBKoSskgKekKLvTs8rMQNrXfEo8pPg/ffE0tS6SVBzNNPHR
         xiilAXraYHzICh0KBvmfR+Hg1rVoUtJAfE+3x1B7/McV4Mebqmzcxm4a3v7ANos6cqci
         VB1M/9EpcyAONy5hbpwk+prJ3At/jVyhK1O8MRIvjMeX09FQra9RTWIqIQfERbEzSRpQ
         z0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717498800; x=1718103600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=asgpbMnZY0t8v6Jl3H5uUs1NISRsXbBHVciypDjEWY8=;
        b=mpCaN2o2Z6WG1Ry8dELQxpNCSGOyFeOOeQYxpOn+RIMBaqY9p5CZmv9UDqS0Uq456N
         VcPIxKu+iGBohT0N92s84BAXT8H7CTHJOHHRvT+C/JVu8q2+ZpaKLRXnF+04ECLkacxE
         U+vit5N6AvJj44RUJUg2rfFPx+JhcTymFKtL9Zfh0KgXqjBZMN7vzKUa8Uq9XwJU+KQw
         xfEJW6Mwiorjh7m8LfFOcNPj2bwnSqmTvvjQe+pyuV8H0dSnWzDEgYZ++IcSJpwg+9ai
         yKzQSmJe7CQxhLh+kBz6id8oj9OENe/WboSdXQBwKldrmIBUso28QkDSELc9gGeSAXq2
         w7dA==
X-Forwarded-Encrypted: i=1; AJvYcCW/tK3RcOrL7gXZsceSUsTgoQ79ErpQ9ypMIyimdzY47azZI9Lgh/evg9Gdi6ZibpTvK8Lvwjn33IyW5a/Lfym+L5XNIEqCcA8H83FD
X-Gm-Message-State: AOJu0YxNEAKS5KcpvZ6022tQprIdmlX77ixb1/QTJAyYmHxaJEKlDSlx
	2XZvBPoSQRqzKzoogj57jKHOyeo8mnm5ebn/klfciYpuSuLeYEtu
X-Google-Smtp-Source: AGHT+IElTPVikfDZzSypb4x9WPBEWXCiurpJs66Y0afsj9XrVePVVfBdFKw3gJ79SVsC2AzYhyprtg==
X-Received: by 2002:a05:6214:2b88:b0:6af:bf15:3600 with SMTP id 6a1803df08f44-6afbf153bd7mr57304046d6.38.1717498799747;
        Tue, 04 Jun 2024 03:59:59 -0700 (PDT)
Received: from localhost (fwdproxy-nao-000.fbsv.net. [2a03:2880:23ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6afc6696d05sm13797306d6.73.2024.06.04.03.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jun 2024 03:59:58 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	willy@infradead.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v2 1/2] mm: clear pte for folios that are zero filled
Date: Tue,  4 Jun 2024 11:58:24 +0100
Message-ID: <20240604105950.1134192-2-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240604105950.1134192-1-usamaarif642@gmail.com>
References: <20240604105950.1134192-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Approximately 10-20% of pages to be swapped out are zero pages [1].
Rather than reading/writing these pages to flash resulting
in increased I/O and flash wear, the pte can be cleared for those
addresses at unmap time while shrinking folio list. When this
causes a page fault, do_pte_missing will take care of this page.
With this patch, NVMe writes in Meta server fleet decreased
by almost 10% with conventional swap setup (zswap disabled).

[1] https://lore.kernel.org/all/20171018104832epcms5p1b2232e2236258de3d03d1344dde9fce0@epcms5p1/

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 include/linux/rmap.h |   1 +
 mm/rmap.c            | 163 ++++++++++++++++++++++---------------------
 mm/vmscan.c          |  89 ++++++++++++++++-------
 3 files changed, 150 insertions(+), 103 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index bb53e5920b88..b36db1e886e4 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -100,6 +100,7 @@ enum ttu_flags {
 					 * do a final flush if necessary */
 	TTU_RMAP_LOCKED		= 0x80,	/* do not grab rmap lock:
 					 * caller holds it */
+	TTU_ZERO_FOLIO		= 0x100,/* zero folio */
 };
 
 #ifdef CONFIG_MMU
diff --git a/mm/rmap.c b/mm/rmap.c
index 52357d79917c..d98f70876327 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1819,96 +1819,101 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 			 */
 			dec_mm_counter(mm, mm_counter(folio));
 		} else if (folio_test_anon(folio)) {
-			swp_entry_t entry = page_swap_entry(subpage);
-			pte_t swp_pte;
-			/*
-			 * Store the swap location in the pte.
-			 * See handle_pte_fault() ...
-			 */
-			if (unlikely(folio_test_swapbacked(folio) !=
-					folio_test_swapcache(folio))) {
+			if (flags & TTU_ZERO_FOLIO) {
+				pte_clear(mm, address, pvmw.pte);
+				dec_mm_counter(mm, MM_ANONPAGES);
+			} else {
+				swp_entry_t entry = page_swap_entry(subpage);
+				pte_t swp_pte;
 				/*
-				 * unmap_huge_pmd_locked() will unmark a
-				 * PMD-mapped folio as lazyfree if the folio or
-				 * its PMD was redirtied.
+				 * Store the swap location in the pte.
+				 * See handle_pte_fault() ...
 				 */
-				if (!pmd_mapped)
-					WARN_ON_ONCE(1);
-				goto walk_done_err;
-			}
+				if (unlikely(folio_test_swapbacked(folio) !=
+						folio_test_swapcache(folio))) {
+					/*
+					 * unmap_huge_pmd_locked() will unmark a
+					 * PMD-mapped folio as lazyfree if the folio or
+					 * its PMD was redirtied.
+					 */
+					if (!pmd_mapped)
+						WARN_ON_ONCE(1);
+					goto walk_done_err;
+				}
 
-			/* MADV_FREE page check */
-			if (!folio_test_swapbacked(folio)) {
-				int ref_count, map_count;
+				/* MADV_FREE page check */
+				if (!folio_test_swapbacked(folio)) {
+					int ref_count, map_count;
 
-				/*
-				 * Synchronize with gup_pte_range():
-				 * - clear PTE; barrier; read refcount
-				 * - inc refcount; barrier; read PTE
-				 */
-				smp_mb();
+					/*
+					 * Synchronize with gup_pte_range():
+					 * - clear PTE; barrier; read refcount
+					 * - inc refcount; barrier; read PTE
+					 */
+					smp_mb();
 
-				ref_count = folio_ref_count(folio);
-				map_count = folio_mapcount(folio);
+					ref_count = folio_ref_count(folio);
+					map_count = folio_mapcount(folio);
 
-				/*
-				 * Order reads for page refcount and dirty flag
-				 * (see comments in __remove_mapping()).
-				 */
-				smp_rmb();
+					/*
+					 * Order reads for page refcount and dirty flag
+					 * (see comments in __remove_mapping()).
+					 */
+					smp_rmb();
 
-				/*
-				 * The only page refs must be one from isolation
-				 * plus the rmap(s) (dropped by discard:).
-				 */
-				if (ref_count == 1 + map_count &&
-				    !folio_test_dirty(folio)) {
-					dec_mm_counter(mm, MM_ANONPAGES);
-					goto discard;
-				}
+					/*
+					 * The only page refs must be one from isolation
+					 * plus the rmap(s) (dropped by discard:).
+					 */
+					if (ref_count == 1 + map_count &&
+					    !folio_test_dirty(folio)) {
+						dec_mm_counter(mm, MM_ANONPAGES);
+						goto discard;
+					}
 
-				/*
-				 * If the folio was redirtied, it cannot be
-				 * discarded. Remap the page to page table.
-				 */
-				set_pte_at(mm, address, pvmw.pte, pteval);
-				folio_set_swapbacked(folio);
-				goto walk_done_err;
-			}
+					/*
+					 * If the folio was redirtied, it cannot be
+					 * discarded. Remap the page to page table.
+					 */
+					set_pte_at(mm, address, pvmw.pte, pteval);
+					folio_set_swapbacked(folio);
+					goto walk_done_err;
+				}
 
-			if (swap_duplicate(entry) < 0) {
-				set_pte_at(mm, address, pvmw.pte, pteval);
-				goto walk_done_err;
-			}
-			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
-				swap_free(entry);
-				set_pte_at(mm, address, pvmw.pte, pteval);
-				goto walk_done_err;
-			}
+				if (swap_duplicate(entry) < 0) {
+					set_pte_at(mm, address, pvmw.pte, pteval);
+					goto walk_done_err;
+				}
+				if (arch_unmap_one(mm, vma, address, pteval) < 0) {
+					swap_free(entry);
+					set_pte_at(mm, address, pvmw.pte, pteval);
+					goto walk_done_err;
+				}
 
-			/* See folio_try_share_anon_rmap(): clear PTE first. */
-			if (anon_exclusive &&
-			    folio_try_share_anon_rmap_pte(folio, subpage)) {
-				swap_free(entry);
-				set_pte_at(mm, address, pvmw.pte, pteval);
-				goto walk_done_err;
-			}
-			if (list_empty(&mm->mmlist)) {
-				spin_lock(&mmlist_lock);
-				if (list_empty(&mm->mmlist))
-					list_add(&mm->mmlist, &init_mm.mmlist);
-				spin_unlock(&mmlist_lock);
+				/* See folio_try_share_anon_rmap(): clear PTE first. */
+				if (anon_exclusive &&
+				    folio_try_share_anon_rmap_pte(folio, subpage)) {
+					swap_free(entry);
+					set_pte_at(mm, address, pvmw.pte, pteval);
+					goto walk_done_err;
+				}
+				if (list_empty(&mm->mmlist)) {
+					spin_lock(&mmlist_lock);
+					if (list_empty(&mm->mmlist))
+						list_add(&mm->mmlist, &init_mm.mmlist);
+					spin_unlock(&mmlist_lock);
+				}
+				dec_mm_counter(mm, MM_ANONPAGES);
+				inc_mm_counter(mm, MM_SWAPENTS);
+				swp_pte = swp_entry_to_pte(entry);
+				if (anon_exclusive)
+					swp_pte = pte_swp_mkexclusive(swp_pte);
+				if (pte_soft_dirty(pteval))
+					swp_pte = pte_swp_mksoft_dirty(swp_pte);
+				if (pte_uffd_wp(pteval))
+					swp_pte = pte_swp_mkuffd_wp(swp_pte);
+				set_pte_at(mm, address, pvmw.pte, swp_pte);
 			}
-			dec_mm_counter(mm, MM_ANONPAGES);
-			inc_mm_counter(mm, MM_SWAPENTS);
-			swp_pte = swp_entry_to_pte(entry);
-			if (anon_exclusive)
-				swp_pte = pte_swp_mkexclusive(swp_pte);
-			if (pte_soft_dirty(pteval))
-				swp_pte = pte_swp_mksoft_dirty(swp_pte);
-			if (pte_uffd_wp(pteval))
-				swp_pte = pte_swp_mkuffd_wp(swp_pte);
-			set_pte_at(mm, address, pvmw.pte, swp_pte);
 		} else {
 			/*
 			 * This is a locked file-backed folio,
diff --git a/mm/vmscan.c b/mm/vmscan.c
index b9170f767353..d54f44b556f0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1026,6 +1026,38 @@ static bool may_enter_fs(struct folio *folio, gfp_t gfp_mask)
 	return !data_race(folio_swap_flags(folio) & SWP_FS_OPS);
 }
 
+static bool is_folio_page_zero_filled(struct folio *folio, int i)
+{
+	unsigned long *data;
+	unsigned int pos, last_pos = PAGE_SIZE / sizeof(*data) - 1;
+	bool ret = false;
+
+	data = kmap_local_folio(folio, i * PAGE_SIZE);
+
+	if (data[last_pos])
+		goto out;
+
+	for (pos = 0; pos < last_pos; pos++) {
+		if (data[pos])
+			goto out;
+	}
+	ret = true;
+out:
+	kunmap_local(data);
+	return ret;
+}
+
+static bool is_folio_zero_filled(struct folio *folio)
+{
+	unsigned int i;
+
+	for (i = 0; i < folio_nr_pages(folio); i++) {
+		if (!is_folio_page_zero_filled(folio, i))
+			return false;
+	}
+	return true;
+}
+
 /*
  * shrink_folio_list() returns the number of reclaimed pages
  */
@@ -1053,6 +1085,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 		enum folio_references references = FOLIOREF_RECLAIM;
 		bool dirty, writeback;
 		unsigned int nr_pages;
+		bool folio_zero_filled = false;
 
 		cond_resched();
 
@@ -1270,6 +1303,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			nr_pages = 1;
 		}
 
+		folio_zero_filled = is_folio_zero_filled(folio);
 		/*
 		 * The folio is mapped into the page tables of one or more
 		 * processes. Try to unmap it here.
@@ -1295,6 +1329,9 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			if (folio_test_large(folio) && list_empty(&folio->_deferred_list))
 				flags |= TTU_SYNC;
 
+			if (folio_zero_filled)
+				flags |= TTU_ZERO_FOLIO;
+
 			try_to_unmap(folio, flags);
 			if (folio_mapped(folio)) {
 				stat->nr_unmap_fail += nr_pages;
@@ -1358,32 +1395,36 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			 * starts and then write it out here.
 			 */
 			try_to_unmap_flush_dirty();
-			switch (pageout(folio, mapping, &plug)) {
-			case PAGE_KEEP:
-				goto keep_locked;
-			case PAGE_ACTIVATE:
-				goto activate_locked;
-			case PAGE_SUCCESS:
-				stat->nr_pageout += nr_pages;
+			if (folio_zero_filled) {
+				folio_clear_dirty(folio);
+			} else {
+				switch (pageout(folio, mapping, &plug)) {
+				case PAGE_KEEP:
+					goto keep_locked;
+				case PAGE_ACTIVATE:
+					goto activate_locked;
+				case PAGE_SUCCESS:
+					stat->nr_pageout += nr_pages;
 
-				if (folio_test_writeback(folio))
-					goto keep;
-				if (folio_test_dirty(folio))
-					goto keep;
+					if (folio_test_writeback(folio))
+						goto keep;
+					if (folio_test_dirty(folio))
+						goto keep;
 
-				/*
-				 * A synchronous write - probably a ramdisk.  Go
-				 * ahead and try to reclaim the folio.
-				 */
-				if (!folio_trylock(folio))
-					goto keep;
-				if (folio_test_dirty(folio) ||
-				    folio_test_writeback(folio))
-					goto keep_locked;
-				mapping = folio_mapping(folio);
-				fallthrough;
-			case PAGE_CLEAN:
-				; /* try to free the folio below */
+					/*
+					 * A synchronous write - probably a ramdisk.  Go
+					 * ahead and try to reclaim the folio.
+					 */
+					if (!folio_trylock(folio))
+						goto keep;
+					if (folio_test_dirty(folio) ||
+					    folio_test_writeback(folio))
+						goto keep_locked;
+					mapping = folio_mapping(folio);
+					fallthrough;
+				case PAGE_CLEAN:
+					; /* try to free the folio below */
+				}
 			}
 		}
 
-- 
2.43.0


