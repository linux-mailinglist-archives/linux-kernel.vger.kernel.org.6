Return-Path: <linux-kernel+bounces-291348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 531A795611A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 04:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86793B221A1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 02:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D106F4503A;
	Mon, 19 Aug 2024 02:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/3TRjPq"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085F93BBE5;
	Mon, 19 Aug 2024 02:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724034718; cv=none; b=cIhVsW8a2gdh35d5YozSeIoXFSdcR3j3gwKI8PzZMPKR3duT6mXRFgO/1hZ3xN6E5BnSTSY0W/PLKfPJhawg3JkvWb7X9dlHSnWtloRTFEDSYcCSSsWUWPdEeSSp4tQ42HXR/dGvCr1spD76oN2QQyHwa7OqHLosFQGtkn2IA2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724034718; c=relaxed/simple;
	bh=4nTOFR0lFrNStvg4j9Qi3T6hCV1VVwmpLrLVXzIzNnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rMV88M6g63ZaC2NWFNVvHkFH5xiIYu/KPdDsKUGvsCnUXTts/AYrlYLAfvVcdTs3sGZPiRtuAPHhfw62W/6bTcJz3T8eJeG9OVI+qzQbF6HzZULruCAky99Iwi2ihRcNc9YJhqU6pyU8Vq1llYCbMbufmn1W+0Vw8vDLVWhgSiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/3TRjPq; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-45007373217so42795311cf.0;
        Sun, 18 Aug 2024 19:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724034716; x=1724639516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7qMuNDyBvGp6REiF+VtGrTnesU92EL9IKEWMO4HzFdQ=;
        b=a/3TRjPqy2KhmBpvGsLeztKAjq6oK3dVyhe1yYi0oGqqOHt8cB6T51ElkwPt7FEKYu
         vBmMrpf3gMUrSHTs74QX38FFer0X3G0mw1OvPy8kqkMI31K/208eR9mcH+R/Qoh5fEqy
         4XMlC7vn0BYPbh4JAbj9dQ7e7hNqJ6TD1TGeBLaklcuhYSPs2+d0VOMqULLWoaulAlU0
         OJREgCv7NvQH3xRTfywHflq52MMzWUq9rK3H+0l/X7MMjKq1CdqoVu9tqeS1kSbP9uGt
         RPVwBj9t2GOXcDfId+Sm6vcw3H/uv2qmZqMq8JZNTn6FvnlDpjKa11CpJw6gJ6YhgJTW
         R5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724034716; x=1724639516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7qMuNDyBvGp6REiF+VtGrTnesU92EL9IKEWMO4HzFdQ=;
        b=DCoN4XS/t6X0Q62raSmbNsCA78DpYP99cVZaoN2JqgMw6lKBn4sB5Ln+EcWICO27Dy
         TddS4mqMiZruOTJqXi+fMJgehWUADhg9f3TPykNU9A70XEvxGuE+HFCwy2uWydoHSvUX
         eqlDGfkKCrwq/0yJZTW7nanN1timzOQSEoZQcmN6ueGAWVLJosq0cfkq8/r08urRwpaO
         FuURlGFWD5quiOxWRFHUH1ZAF5Ng5JtYHV8oA8j4idz8MZ4iivD+5lj13mktJnvm1Pk2
         fM8wKHyrmBBPzFUsXARFV4wTHxORXdT7c1m95FZP83KWgZOFr8tL4hg8sjGAMXXg7ghP
         TOOw==
X-Forwarded-Encrypted: i=1; AJvYcCWPwEn78we/f4n4RuPv3kGxEDcNY3ALK9y1tIZR2tOVphjMklQTmd9DUtbr+oayH7eRgmF0kICqpNxhZieY3WSCzASZtJvzkwY7saCJ/MBpvyJ0m+7WAk9nG5YrDyuBR/u9bq3xwHGv
X-Gm-Message-State: AOJu0Yyc3wQMgr63M+2TMrQvPneEPDsFU4czSNvoFjbIlYBqYSslnCqD
	LDyxY9MqmDEqHac0EQs2g8RZ7Z2P/k71POtsDvkiGcnCTlpljHA6
X-Google-Smtp-Source: AGHT+IFmtPd7hU7za122IjXT3WTFdEVF9e2slXlOQoczJAWqePZoKzw0RZWmiFcdFLHebyhRGR/CwA==
X-Received: by 2002:a05:622a:4d0c:b0:453:1334:9725 with SMTP id d75a77b69052e-45374f5468cmr173712171cf.3.1724034715718;
        Sun, 18 Aug 2024 19:31:55 -0700 (PDT)
Received: from localhost (fwdproxy-ash-000.fbsv.net. [2a03:2880:20ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369fee649sm36828591cf.29.2024.08.18.19.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 19:31:55 -0700 (PDT)
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
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v4 4/6] mm: Introduce a pageflag for partially mapped folios
Date: Mon, 19 Aug 2024 03:30:57 +0100
Message-ID: <20240819023145.2415299-5-usamaarif642@gmail.com>
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
 include/linux/page-flags.h | 11 +++++++++++
 mm/huge_memory.c           | 23 ++++++++++++++++-------
 mm/internal.h              |  4 +++-
 mm/memcontrol.c            |  3 ++-
 mm/migrate.c               |  3 ++-
 mm/page_alloc.c            |  5 +++--
 mm/rmap.c                  |  5 +++--
 mm/vmscan.c                |  3 ++-
 9 files changed, 44 insertions(+), 17 deletions(-)

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
index a0a29bd092f8..c3bb0e0da581 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -182,6 +182,7 @@ enum pageflags {
 	/* At least one page in this folio has the hwpoison flag set */
 	PG_has_hwpoisoned = PG_active,
 	PG_large_rmappable = PG_workingset, /* anon or file-backed */
+	PG_partially_mapped = PG_reclaim, /* was identified to be partially mapped */
 };
 
 #define PAGEFLAGS_MASK		((1UL << NR_PAGEFLAGS) - 1)
@@ -861,8 +862,18 @@ static inline void ClearPageCompound(struct page *page)
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
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 2d77b5d2291e..70ee49dfeaad 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3398,6 +3398,7 @@ int split_huge_page_to_list_to_order(struct page *page, struct list_head *list,
 			 * page_deferred_list.
 			 */
 			list_del_init(&folio->_deferred_list);
+			__folio_clear_partially_mapped(folio);
 		}
 		spin_unlock(&ds_queue->split_queue_lock);
 		if (mapping) {
@@ -3454,11 +3455,13 @@ void __folio_undo_large_rmappable(struct folio *folio)
 	if (!list_empty(&folio->_deferred_list)) {
 		ds_queue->split_queue_len--;
 		list_del_init(&folio->_deferred_list);
+		__folio_clear_partially_mapped(folio);
 	}
 	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
 }
 
-void deferred_split_folio(struct folio *folio)
+/* partially_mapped=false won't clear PG_partially_mapped folio flag */
+void deferred_split_folio(struct folio *folio, bool partially_mapped)
 {
 	struct deferred_split *ds_queue = get_deferred_split_queue(folio);
 #ifdef CONFIG_MEMCG
@@ -3486,14 +3489,19 @@ void deferred_split_folio(struct folio *folio)
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
+		}
+	} else {
+		/* partially mapped folios cannot become non-partially mapped */
+		VM_WARN_ON_FOLIO(folio_test_partially_mapped(folio), folio);
+	}
 	if (list_empty(&folio->_deferred_list)) {
-		if (folio_test_pmd_mappable(folio))
-			count_vm_event(THP_DEFERRED_SPLIT_PAGE);
-		count_mthp_stat(folio_order(folio), MTHP_STAT_SPLIT_DEFERRED);
 		list_add_tail(&folio->_deferred_list, &ds_queue->split_queue);
 		ds_queue->split_queue_len++;
 #ifdef CONFIG_MEMCG
@@ -3542,6 +3550,7 @@ static unsigned long deferred_split_scan(struct shrinker *shrink,
 		} else {
 			/* We lost race with folio_put() */
 			list_del_init(&folio->_deferred_list);
+			__folio_clear_partially_mapped(folio);
 			ds_queue->split_queue_len--;
 		}
 		if (!--sc->nr_to_scan)
diff --git a/mm/internal.h b/mm/internal.h
index 52f7fc4e8ac3..27cbb5365841 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -662,8 +662,10 @@ static inline void prep_compound_head(struct page *page, unsigned int order)
 	atomic_set(&folio->_entire_mapcount, -1);
 	atomic_set(&folio->_nr_pages_mapped, 0);
 	atomic_set(&folio->_pincount, 0);
-	if (order > 1)
+	if (order > 1) {
 		INIT_LIST_HEAD(&folio->_deferred_list);
+		__folio_clear_partially_mapped(folio);
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
index 2d2e65d69427..ef4a732f22b1 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1735,7 +1735,8 @@ static int migrate_pages_batch(struct list_head *from,
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
index a6b9cd0b2b18..4c330635aa4e 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1578,8 +1578,9 @@ static __always_inline void __folio_remove_rmap(struct folio *folio,
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


