Return-Path: <linux-kernel+bounces-308513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA35965DF2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 12:05:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63CE28903B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 10:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7185618990F;
	Fri, 30 Aug 2024 10:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvAyDYGR"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F4017D36A;
	Fri, 30 Aug 2024 10:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725012291; cv=none; b=qHJLj6agO4ojZiYnZfFU4Y6p6pL41ZDVPIqdQOSvt/id4ka0faxTxfg4g+8a/HGu/35BJ/CT8jH4q8opTZUBDyeatlJM7oRbKsAx28UCPa4rjhmnSOS0HTZQJx1p4VFI4UBGPjeJX6QJR5yB86gVhiHXTxKdlcHhEQT6tAd8zRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725012291; c=relaxed/simple;
	bh=XC/D3FWbSMjcdNJsMt8ddxpm9iPGUgCsLG/PvWEmTFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sh9kmfgsIshoaAbJ61CcGTn5PlFcG0MY9VU7yk+j3YD9zAISfdAaYq9CULzd9pYMx8BDrEJROSg07wJwa4Tmgaz1zFFO0VBU9Vb29wmkOVEMyuu08MwNFvqrJlYdMtoCniCzFQBO+cB6+z7J9h0911tGQwesUDp2r5Pelkff394=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvAyDYGR; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6bf84c3d043so8304896d6.3;
        Fri, 30 Aug 2024 03:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725012288; x=1725617088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+vBNVWjO6mtV26zUs32wjVtSHlbqsf20K2xRQFmV6I=;
        b=WvAyDYGRCuosNF+95VatMhnbc4kZkRtxyhn6CQZxWO7J/82ry4wCTvfpZkiZue7tzT
         o65PveullBmRO0UXNJ2nVNmXQA7REx+M3MJBIoS53HiYM/E0EidiLod3sR7RPbZZfgE3
         WcSMGdTdLyzmd1USIiL7i/NRY75otHykSuIbu7vcrSEffPgvvFmHK8uX9HIzhHnDeFXS
         9Rq8jUgW3y0TPYPWm3MiLdPG4rtgnsAW8U4Gb0LeknRhC4uTbq/InMRznkC3wOVXSPbg
         FVkuzueDDbannNJaiQMQbhDAAgh5T7p4hQC7BaAse3lE97BbvGpxtf5GOwN/P9ABzHRG
         JbcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725012288; x=1725617088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+vBNVWjO6mtV26zUs32wjVtSHlbqsf20K2xRQFmV6I=;
        b=RI798R++tJ/ulQmmF1x2ufPvUy2pu3M6dC0gqo8ehCvHDtlTBZJ5bksC3tLGTCoHxE
         VdVqFQIHSULa9FVI2YHPb/UeMnYmPlx86v7Zfcl7OstlHSr+VTgcAKuXNd0g02if744j
         Hpj85j9PIUzCS3Z6KmvaTdDl76dzZ2S87KwdwfHZjEQ7MIWtGIF9313PvZmHwv4eMCHl
         C/+Rm8eyyy30Uqx7M4tCIZMNQWHRL020QIDt9PjI6ELxbHV2qXGdsBivTyhsa5MtHwp/
         Lp3EoFkd7tUXwUpaQfElmn9n1WPtSvop0APNO0q/q8QenbAOlihZaZ/ZJaw4fCxFsYTB
         8kuw==
X-Forwarded-Encrypted: i=1; AJvYcCUI+x61tUlAhpB05NMyyZRNbnqxGlqOPCppQEJhRtdIk7v3gl/+Byo+2VhtgWxybZPkBdCwIGRGO+wvOA6b@vger.kernel.org, AJvYcCWRLDAuc8JkhxGopQK9WLBOmMdqeo3Tr4NyEKW67q4dlIKKZOaLwg/MCl/YIV5PC4HJTjUmpqaouJU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7A18FPW0a+9BP3GRTV9Fib7Cd5qdhG7RlOHXn3SKBA3DeO22t
	CtNeWIwVjbugn3ACVH6ZhaQva5/q58BClsGvklUPxIrhQbzZJbaD
X-Google-Smtp-Source: AGHT+IH5AyMQZDNKx+vMxR5PHzOCBM3mGoXbZzUBy0tcyWMwXEM0DbfBsCwTeIM/EkOxrAzZrQbkmg==
X-Received: by 2002:a0c:fa03:0:b0:6bf:6b8a:40a1 with SMTP id 6a1803df08f44-6c34ae4a03amr11113366d6.29.1725012288019;
        Fri, 30 Aug 2024 03:04:48 -0700 (PDT)
Received: from localhost (fwdproxy-ash-001.fbsv.net. [2a03:2880:20ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c340bfa666sm13303256d6.2.2024.08.30.03.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Aug 2024 03:04:47 -0700 (PDT)
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
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v5 4/6] mm: Introduce a pageflag for partially mapped folios
Date: Fri, 30 Aug 2024 11:03:38 +0100
Message-ID: <20240830100438.3623486-5-usamaarif642@gmail.com>
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
 include/linux/page-flags.h | 13 +++++++++++-
 mm/huge_memory.c           | 41 ++++++++++++++++++++++++++++----------
 mm/memcontrol.c            |  3 ++-
 mm/migrate.c               |  3 ++-
 mm/page_alloc.c            |  5 +++--
 mm/rmap.c                  |  5 +++--
 mm/vmscan.c                |  3 ++-
 8 files changed, 56 insertions(+), 21 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 4da102b74a8c..0b0539f4ee1a 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -333,7 +333,7 @@ static inline int split_huge_page(struct page *page)
 {
 	return split_huge_page_to_list_to_order(page, NULL, 0);
 }
-void deferred_split_folio(struct folio *folio);
+void deferred_split_folio(struct folio *folio, bool partially_mapped);
 
 void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 		unsigned long address, bool freeze, struct folio *folio);
@@ -502,7 +502,7 @@ static inline int split_huge_page(struct page *page)
 {
 	return 0;
 }
-static inline void deferred_split_folio(struct folio *folio) {}
+static inline void deferred_split_folio(struct folio *folio, bool partially_mapped) {}
 #define split_huge_pmd(__vma, __pmd, __address)	\
 	do { } while (0)
 
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 2175ebceb41c..1b3a76710487 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -186,6 +186,7 @@ enum pageflags {
 	/* At least one page in this folio has the hwpoison flag set */
 	PG_has_hwpoisoned = PG_active,
 	PG_large_rmappable = PG_workingset, /* anon or file-backed */
+	PG_partially_mapped = PG_reclaim, /* was identified to be partially mapped */
 };
 
 #define PAGEFLAGS_MASK		((1UL << NR_PAGEFLAGS) - 1)
@@ -859,8 +860,18 @@ static inline void ClearPageCompound(struct page *page)
 	ClearPageHead(page);
 }
 FOLIO_FLAG(large_rmappable, FOLIO_SECOND_PAGE)
+FOLIO_TEST_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
+/*
+ * PG_partially_mapped is protected by deferred_split split_queue_lock,
+ * so its safe to use non-atomic set/clear.
+ */
+__FOLIO_SET_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
+__FOLIO_CLEAR_FLAG(partially_mapped, FOLIO_SECOND_PAGE)
 #else
 FOLIO_FLAG_FALSE(large_rmappable)
+FOLIO_TEST_FLAG_FALSE(partially_mapped)
+__FOLIO_SET_FLAG_NOOP(partially_mapped)
+__FOLIO_CLEAR_FLAG_NOOP(partially_mapped)
 #endif
 
 #define PG_head_mask ((1UL << PG_head))
@@ -1171,7 +1182,7 @@ static __always_inline void __ClearPageAnonExclusive(struct page *page)
  */
 #define PAGE_FLAGS_SECOND						\
 	(0xffUL /* order */		| 1UL << PG_has_hwpoisoned |	\
-	 1UL << PG_large_rmappable)
+	 1UL << PG_large_rmappable	| 1UL << PG_partially_mapped)
 
 #define PAGE_FLAGS_PRIVATE				\
 	(1UL << PG_private | 1UL << PG_private_2)
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index af60684e7c70..166f8810f3c6 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3503,7 +3503,11 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 		if (folio_order(folio) > 1 &&
 		    !list_empty(&folio->_deferred_list)) {
 			ds_queue->split_queue_len--;
-			mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
+			if (folio_test_partially_mapped(folio)) {
+				__folio_clear_partially_mapped(folio);
+				mod_mthp_stat(folio_order(folio),
+					      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
+			}
 			/*
 			 * Reinitialize page_deferred_list after removing the
 			 * page from the split_queue, otherwise a subsequent
@@ -3570,13 +3574,18 @@ void __folio_undo_large_rmappable(struct folio *folio)
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
 	if (!list_empty(&folio->_deferred_list)) {
 		ds_queue->split_queue_len--;
-		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
+		if (folio_test_partially_mapped(folio)) {
+			__folio_clear_partially_mapped(folio);
+			mod_mthp_stat(folio_order(folio),
+				      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
+		}
 		list_del_init(&folio->_deferred_list);
 	}
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
 }
 
-void deferred_split_folio(struct folio *folio)
+/* partially_mapped=false won't clear PG_partially_mapped folio flag */
+void deferred_split_folio(struct folio *folio, bool partially_mapped)
 {
 	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
 #ifdef CONFIG_MEMCG
@@ -3604,15 +3613,21 @@ void deferred_split_folio(struct folio *folio)
 	if (folio_test_swapcache(folio))
 		return;
 
-	if (!list_empty(&folio->_deferred_list))
-		return;
-
 	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
+	if (partially_mapped) {
+		if (!folio_test_partially_mapped(folio)) {
+			__folio_set_partially_mapped(folio);
+			if (folio_test_pmd_mappable(folio))
+				count_vm_event(THP_DEFERRED_SPLIT_PAGE);
+			count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
+			mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, 1);
+
+		}
+	} else {
+		/* partially mapped folios cannot become non-partially mapped */
+		VM_WARN_ON_FOLIO(folio_test_partially_mapped(folio), folio);
+	}
 	if (list_empty(&folio->_deferred_list)) {
-		if (folio_test_pmd_mappable(folio))
-			count_vm_event(THP_DEFERRED_SPLIT_PAGE);
-		count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
-		mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, 1);
 		list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
 		ds_queue->split_queue_len++;
 #ifdef CONFIG_MEMCG
@@ -3660,7 +3675,11 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 			list_move(&folio->_deferred_list, &list);
 		} else {
 			/* We lost race with folio_put() */
-			mod_mthp_stat(folio_order(folio), MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
+			if (folio_test_partially_mapped(folio)) {
+				__folio_clear_partially_mapped(folio);
+				mod_mthp_stat(folio_order(folio),
+					      MTHP_STAT_NR_ANON_PARTIALLY_MAPPED, -1);
+			}
 			list_del_init(&folio->_deferred_list);
 			ds_queue->split_queue_len--;
 		}
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 087a8cb1a6d8..e66da58a365d 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4629,7 +4629,8 @@ static void uncharge_folio(struct folio *folio, struct uncharge_gather *ug)
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 	VM_BUG_ON_FOLIO(folio_order(folio) > 1 &&
 			!folio_test_hugetlb(folio) &&
-			!list_empty(&folio->_deferred_list), folio);
+			!list_empty(&folio->_deferred_list) &&
+			folio_test_partially_mapped(folio), folio);
 
 	/*
 	 * Nobody should be changing or seriously looking at
diff --git a/mm/migrate.c b/mm/migrate.c
index d039863e014b..35cc9d35064b 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1766,7 +1766,8 @@ static int migrate_pages_batch(struct list_head *from,
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
index c2ffccf9d213..a82c221b7c2e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -962,8 +962,9 @@ static int free_tail_page_prepare(struct page *head_page, struct page *page)
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
index 78529cf0fd66..a8797d1b3d49 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1579,8 +1579,9 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
 	 * Check partially_mapped first to ensure it is a large folio.
 	 */
 	if (partially_mapped && folio_test_anon(folio) &&
-	    list_empty(&folio->_deferred_list))
-		deferred_split_folio(folio);
+	    !folio_test_partially_mapped(folio))
+		deferred_split_folio(folio, true);
+
 	__folio_mod_stat(folio, -nr, -nr_pmdmapped);
 
 	/*
diff --git a/mm/vmscan.c b/mm/vmscan.c
index f27792e77a0f..4ca612f7e473 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1238,7 +1238,8 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
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


