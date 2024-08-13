Return-Path: <linux-kernel+bounces-284715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F65950461
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 14:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97C1AB25132
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 12:04:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E175719AD7D;
	Tue, 13 Aug 2024 12:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVHn0uKZ"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291D11993B7;
	Tue, 13 Aug 2024 12:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723550630; cv=none; b=W6bpJI+VNzntlY0rZqZQAZ3vN/tdZB1568isGObOhvL5Rccnnu1khfs5rvdhZbnDX2tbUS6kYS4//GQIXtgstSWFbC90oSZeU6Ii4UmbDxDYG/tZU0TqUaMjLgnUy7TVI14JSQMk0Oi1Ao7aTa1twhRS0rvhHCAM6dIP1NpHe2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723550630; c=relaxed/simple;
	bh=dWtkP23U4l8tMkGkY1qnb83yVWqh+FLWRkWBFCFBhgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4RsHKH2E4GTv7qoEzuLpg0kIu0LrvvOMCTle+OA59AFUYRJzf8USMGg0u5H77oXJJPXi2sQOViMF3Y7WcU7MKZ8VZPMcAprTXy6yi4jDFwcEBk420IfPH77yfqF6Wo5QMtmF/djeMODEg+vSJEbavJx5s93V3tr9rpNFGj9jCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVHn0uKZ; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7a1dea79e1aso306028285a.1;
        Tue, 13 Aug 2024 05:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723550628; x=1724155428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ml/fx4q0/GpQb3pUk4RTjdvQZB9z9qmUFwqEb9M1LyE=;
        b=cVHn0uKZooeZnJ5SbwR/QIC+4kNbWTBxbmMQ3kUgps5N0h8SU3TaIF4mVkWeFffWMD
         u7U+kv/Ds7r8HTnT8T2dkXt6FsoWDVMfS8RtacgOzIOgAWoGCKJBeL/EEK5LI9Q3wa0L
         tmnWRxtbmtT+20WxadIX305hSRrAbr0X8LFN/urspfEEL/a4uZyd0DHbNcwEOMKOHIqw
         40bwIggCxlwigflSpcVlK01AjBrKIv6y1CH5imO2rA4s1R4W4rIBMiOu+QxxPqv3prji
         mcMsMG4I2seYg/LQRa3TIX+XOfcCDHxIiNiH3/Zf90KPtn6w7jU436fCEvIK2rxEtrNO
         iIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723550628; x=1724155428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ml/fx4q0/GpQb3pUk4RTjdvQZB9z9qmUFwqEb9M1LyE=;
        b=uesEDnf1eIVUkJPESIbE/37+02j1K8Lo6eL0xI5nVSHRJPDlLYxAclfpyrAZRFID9P
         lnjs92v78V4bd8tq4K2rl2uLylqvr8BySPIPZ+BpREghaTZs/jMct9rsQC4VQDn1KOWZ
         gRZkYSgz+zPyZAUqwdIK9UDqYuuJVW2Vcf/nIV6wx6nBfTJ/0dixdDss7VQEQC1jzxMz
         FgCEevz/h5KnFyc67W/I/a5XVpJYq9Dg2aCkU1/7JKhQL4Lb/x6PFcxsYdOvN1n/3Cjq
         Sjped9bdha0EC+nvKwxmqNWHRTBMZ0tYTzYdg11Bc0yxLPMfS/lSKVg1iSR/9t5TUnDB
         HjIg==
X-Forwarded-Encrypted: i=1; AJvYcCUv4Q+3vUXqhhnbFNetEdKfcX2LHKm2XmIGVZqnLmHoTi+qdb9igBRm7Nkq/hyQMWw/8oMHxqMYNE/fW0AAw8NTfOLg6x2Xg0a7oLeQGfACKj7tTb7HQgDjW5sZ/Y9FcxvC95i+K/yU
X-Gm-Message-State: AOJu0YyMKEnG0/A7llx4rCrXOIAEEU8RnUJHxwVoMm60+2/Flyj1jfo1
	8uJvRjb67zdHBjGREReNuBKbAgjsLmCf114xkbsVYzuDBSJjg5lj
X-Google-Smtp-Source: AGHT+IGnLAxIgNZTQh4vIeUHubCTk+9Li27aBYorSBwfeBTlQEsQV26mOZEo4xLzaw1PA1P3cAHmZQ==
X-Received: by 2002:a05:620a:31a6:b0:7a3:7920:5500 with SMTP id af79cd13be357-7a4e15537c4mr389032385a.32.1723550627906;
        Tue, 13 Aug 2024 05:03:47 -0700 (PDT)
Received: from localhost (fwdproxy-ash-006.fbsv.net. [2a03:2880:20ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4c7d62678sm333062785a.5.2024.08.13.05.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 05:03:47 -0700 (PDT)
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
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v3 4/6] mm: Introduce a pageflag for partially mapped folios
Date: Tue, 13 Aug 2024 13:02:47 +0100
Message-ID: <20240813120328.1275952-5-usamaarif642@gmail.com>
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

Currently folio->_deferred_list is used to keep track of
partially_mapped folios that are going to be split under memory
pressure. In the next patch, all THPs that are faulted in and collapsed
by khugepaged are also going to be tracked using _deferred_list.

This patch introduces a pageflag to be able to distinguish between
partially mapped folios and others in the deferred_list at split time in
deferred_split_scan. Its needed as __folio_remove_rmap decrements
_mapcount, _large_mapcount and _entire_mapcount, hence it won't be
possible to distinguish between partially mapped folios and others in
deferred_split_scan.

Eventhough it introduces an extra flag to track if the folio is
partially mapped, there is no functional change intended with this
patch and the flag is not useful in this patch itself, it will
become useful in the next patch when _deferred_list has non partially
mapped folios.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 include/linux/huge_mm.h    |  4 ++--
 include/linux/page-flags.h |  3 +++
 mm/huge_memory.c           | 21 +++++++++++++--------
 mm/hugetlb.c               |  1 +
 mm/internal.h              |  4 +++-
 mm/memcontrol.c            |  3 ++-
 mm/migrate.c               |  3 ++-
 mm/page_alloc.c            |  5 +++--
 mm/rmap.c                  |  3 ++-
 mm/vmscan.c                |  3 ++-
 10 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 4c32058cacfe..969f11f360d2 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -321,7 +321,7 @@ static inline int split_huge_page(struct page *page)
 {
 	return split_huge_page_to_list_to_order(page, NULL, 0);
 }
-void deferred_split_folio(struct folio *folio);
+void deferred_split_folio(struct folio *folio, bool partially_mapped);
 
 void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long address, bool freeze, struct folio *folio);
@@ -495,7 +495,7 @@ static inline int split_huge_page(struct page *page)
 {
 	return 0;
 }
-static inline void deferred_split_folio(struct folio *folio) {}
+static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
 #define split_huge_pmd(__vma, __pmd, __address)	\
 	do { } while (0)
 
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index a0a29bd092f8..cecc1bad7910 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -182,6 +182,7 @@ enum pageflags {
 	/* At least one page in this folio has the hwpoison flag set */
 	PG_has_hwpoisoned = PG_active,
 	PG_large_rmappable = PG_workingset, /* anon or file-backed */
+	PG_partially_mapped, /* was identified to be partially mapped */
 };
 
 #define PAGEFLAGS_MASK		((1UL << NR_PAGEFLAGS) - 1)
@@ -861,8 +862,10 @@ static inline void ClearPageCompound(struct page *page)
 	ClearPageHead(page);
 }
 FOLIO_FLAG(large_rmappable, FOLIO_SECOND_PAGE)
+FOLIO_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
 #else
 FOLIO_FLAG_FALSE(large_rmappable)
+FOLIO_FLAG_FALSE(partially_mapped)
 #endif
 
 #define PG_head_mask ((1UL << PG_head))
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 6df0e9f4f56c..c024ab0f745c 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3397,6 +3397,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 			 * page_deferred_list.
 			 */
 			list_del_init(&folio->_deferred_list);
+			folio_clear_partially_mapped(folio);
 		}
 		spin_unlock(&ds_queue->split_queue_lock);
 		if (mapping) {
@@ -3453,11 +3454,12 @@ void __folio_undo_large_rmappable(struct folio *folio)
 	if (!list_empty(&folio->_deferred_list)) {
 		ds_queue->split_queue_len--;
 		list_del_init(&folio->_deferred_list);
+		folio_clear_partially_mapped(folio);
 	}
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
 }
 
-void deferred_split_folio(struct folio *folio)
+void deferred_split_folio(struct folio *folio, bool partially_mapped)
 {
 	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
 #ifdef CONFIG_MEMCG
@@ -3485,14 +3487,17 @@ void deferred_split_folio(struct folio *folio)
 	if (folio_test_swapcache(folio))
 		return;
 
-	if (!list_empty(&folio->_deferred_list))
-		return;
-
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
+	if (partially_mapped)
+		folio_set_partially_mapped(folio);
+	else
+		folio_clear_partially_mapped(folio);
 	if (list_empty(&folio->_deferred_list)) {
-		if (folio_test_pmd_mappable(folio))
-			count_vm_event(THP_DEFERRED_SPLIT_PAGE);
-		count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
+		if (partially_mapped) {
+			if (folio_test_pmd_mappable(folio))
+				count_vm_event(THP_DEFERRED_SPLIT_PAGE);
+			count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
+		}
 		list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
 		ds_queue->split_queue_len++;
 #ifdef CONFIG_MEMCG
@@ -3541,6 +3546,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 		} else {
 			/* We lost race with folio_put() */
 			list_del_init(&folio->_deferred_list);
+			folio_clear_partially_mapped(folio);
 			ds_queue->split_queue_len--;
 		}
 		if (!--sc->nr_to_scan)
@@ -3558,7 +3564,6 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 next:
 		folio_put(folio);
 	}
-
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
 	list_splice_tail(&list, &ds_queue->split_queue);
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1fdd9eab240c..2ae2d9a18e40 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1758,6 +1758,7 @@ static void __update_and_free_hugetlb_folio(struct hstate *h,
 		free_gigantic_folio(folio, huge_page_order(h));
 	} else {
 		INIT_LIST_HEAD(&folio->_deferred_list);
+		folio_clear_partially_mapped(folio);
 		folio_put(folio);
 	}
 }
diff --git a/mm/internal.h b/mm/internal.h
index 52f7fc4e8ac3..d64546b8d377 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -662,8 +662,10 @@ static inline void prep_compound_head(struct page *page, unsigned int order)
 	atomic_set(&folio->_entire_mapcount, -1);
 	atomic_set(&folio->_nr_pages_mapped, 0);
 	atomic_set(&folio->_pincount, 0);
-	if (order > 1)
+	if (order > 1) {
 		INIT_LIST_HEAD(&folio->_deferred_list);
+		folio_clear_partially_mapped(folio);
+	}
 }
 
 static inline void prep_compound_tail(struct page *head, int tail_idx)
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index e1ffd2950393..0fd95daecf9a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4669,7 +4669,8 @@ static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 	VM_BUG_ON_FOLIO(folio_order(folio) > 1 &&
 			!folio_test_hugetlb(folio) &&
-			!list_empty(&folio->_deferred_list), folio);
+			!list_empty(&folio->_deferred_list) &&
+			folio_test_partially_mapped(folio), folio);
 
 	/*
 	 * Nobody should be changing or seriously looking at
diff --git a/mm/migrate.c b/mm/migrate.c
index 3288ac041d03..6e32098ac2dc 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1734,7 +1734,8 @@ static int migrate_pages_batch(struct list_head *from,
 			 * use _deferred_list.
 			 */
 			if (nr_pages > 2 &&
-			   !list_empty(&folio->_deferred_list)) {
+			   !list_empty(&folio->_deferred_list) &&
+			   folio_test_partially_mapped(folio)) {
 				if (!try_split_folio(folio, split_folios, mode)) {
 					nr_failed++;
 					stats->nr_thp_failed += is_thp;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 408ef3d25cf5..a145c550dd2a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -957,8 +957,9 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
 		break;
 	case 2:
 		/* the second tail page: deferred_list overlaps ->mapping */
-		if (unlikely(!list_empty(&folio->_deferred_list))) {
-			bad_page(page, "on deferred list");
+		if (unlikely(!list_empty(&folio->_deferred_list) &&
+		    folio_test_partially_mapped(folio))) {
+			bad_page(page, "partially mapped folio on deferred list");
 			goto out;
 		}
 		break;
diff --git a/mm/rmap.c b/mm/rmap.c
index a6b9cd0b2b18..9ad558c2bad0 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1579,7 +1579,8 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 	 */
 	if (partially_mapped && folio_test_anon(folio) &&
 	    list_empty(&folio->_deferred_list))
-		deferred_split_folio(folio);
+		deferred_split_folio(folio, true);
+
 	__folio_mod_stat(folio, -nr, -nr_pmdmapped);
 
 	/*
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 25e43bb3b574..25f4e8403f41 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1233,7 +1233,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 					 * Split partially mapped folios right away.
 					 * We can free the unmapped pages without IO.
 					 */
-					if (data_race(!list_empty(&folio->_deferred_list)) &&
+					if (data_race(!list_empty(&folio->_deferred_list) &&
+					    folio_test_partially_mapped(folio)) &&
 					    split_folio_to_list(folio, folio_list))
 						goto activate_locked;
 				}
-- 
2.43.5


