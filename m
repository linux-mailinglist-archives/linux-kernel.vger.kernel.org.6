Return-Path: <linux-kernel+bounces-279348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0126D94BC1D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 13:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03BA1F217E6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 11:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EDE18A93F;
	Thu,  8 Aug 2024 11:19:02 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF64918B474
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 11:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723115941; cv=none; b=EkgBVcmEjlEbxVgridd0wxFfxbkRIV5vbSN6DXnWTQ6VZBOWmAI7w457+o7X96pF+mOd93l8RYnCOh/nr+PPH1mIuQRLRV75NA83CRj5+lQCU70XQ4OUmvLvheBXJ+2ieB9TTN0DYt2g1CO0gM4rnX/+UibIqFEWMa1Rh48ezLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723115941; c=relaxed/simple;
	bh=rKWnLje+3XCbY3wPN+vMhOC5+eitLItFmOJp2JKVgHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbGiFo8N1Yfb95mDCqqOoCAI8hEBJorXwysnKEpdk5K97a+FW0XEEtaq/QtylzaSLh64BLh16jJjGcXvzBI6yJeLPLVZjeCbpocwaw5z2Jiab9ErTASO7qzP4VF3vc0PUitasBp2aiEToLKgrSphapXC4HjnBYxzqmvTO6vkTdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0255D1042;
	Thu,  8 Aug 2024 04:19:25 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD3003F71E;
	Thu,  8 Aug 2024 04:18:57 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <ioworker0@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Gavin Shan <gshan@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 1/2] mm: Cleanup count_mthp_stat() definition
Date: Thu,  8 Aug 2024 12:18:46 +0100
Message-ID: <20240808111849.651867-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240808111849.651867-1-ryan.roberts@arm.com>
References: <20240808111849.651867-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's move count_mthp_stat() so that it's always defined, even when THP
is disabled. Previously uses of the function in files such as shmem.c,
which are compiled even when THP is disabled, required ugly THP
ifdeferry. With this cleanup, we can remove those ifdefs and the
function resolves to a nop when THP is disabled.

I shortly plan to call count_mthp_stat() from more THP-invariant source
files.

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Acked-by: Barry Song <baohua@kernel.org>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Lance Yang <ioworker0@gmail.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 include/linux/huge_mm.h | 70 ++++++++++++++++++++---------------------
 mm/memory.c             |  2 --
 mm/shmem.c              |  6 ----
 3 files changed, 35 insertions(+), 43 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2b5a175196e7a..969f11f360d29 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -114,6 +114,41 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
 #define HPAGE_PUD_MASK	(~(HPAGE_PUD_SIZE - 1))
 #define HPAGE_PUD_SIZE	((1UL) << HPAGE_PUD_SHIFT)
 
+enum mthp_stat_item {
+	MTHP_STAT_ANON_FAULT_ALLOC,
+	MTHP_STAT_ANON_FAULT_FALLBACK,
+	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
+	MTHP_STAT_SWPOUT,
+	MTHP_STAT_SWPOUT_FALLBACK,
+	MTHP_STAT_SHMEM_ALLOC,
+	MTHP_STAT_SHMEM_FALLBACK,
+	MTHP_STAT_SHMEM_FALLBACK_CHARGE,
+	MTHP_STAT_SPLIT,
+	MTHP_STAT_SPLIT_FAILED,
+	MTHP_STAT_SPLIT_DEFERRED,
+	__MTHP_STAT_COUNT
+};
+
+#if defined(CONFIG_TRANSPARENT_HUGEPAGE) && defined(CONFIG_SYSFS)
+struct mthp_stat {
+	unsigned long stats[ilog2(MAX_PTRS_PER_PTE) + 1][__MTHP_STAT_COUNT];
+};
+
+DECLARE_PER_CPU(struct mthp_stat, mthp_stats);
+
+static inline void count_mthp_stat(int order, enum mthp_stat_item item)
+{
+	if (order <= 0 || order > PMD_ORDER)
+		return;
+
+	this_cpu_inc(mthp_stats.stats[order][item]);
+}
+#else
+static inline void count_mthp_stat(int order, enum mthp_stat_item item)
+{
+}
+#endif
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 
 extern unsigned long transparent_hugepage_flags;
@@ -269,41 +304,6 @@ struct thpsize {
 
 #define to_thpsize(kobj) container_of(kobj, struct thpsize, kobj)
 
-enum mthp_stat_item {
-	MTHP_STAT_ANON_FAULT_ALLOC,
-	MTHP_STAT_ANON_FAULT_FALLBACK,
-	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
-	MTHP_STAT_SWPOUT,
-	MTHP_STAT_SWPOUT_FALLBACK,
-	MTHP_STAT_SHMEM_ALLOC,
-	MTHP_STAT_SHMEM_FALLBACK,
-	MTHP_STAT_SHMEM_FALLBACK_CHARGE,
-	MTHP_STAT_SPLIT,
-	MTHP_STAT_SPLIT_FAILED,
-	MTHP_STAT_SPLIT_DEFERRED,
-	__MTHP_STAT_COUNT
-};
-
-struct mthp_stat {
-	unsigned long stats[ilog2(MAX_PTRS_PER_PTE) + 1][__MTHP_STAT_COUNT];
-};
-
-#ifdef CONFIG_SYSFS
-DECLARE_PER_CPU(struct mthp_stat, mthp_stats);
-
-static inline void count_mthp_stat(int order, enum mthp_stat_item item)
-{
-	if (order <= 0 || order > PMD_ORDER)
-		return;
-
-	this_cpu_inc(mthp_stats.stats[order][item]);
-}
-#else
-static inline void count_mthp_stat(int order, enum mthp_stat_item item)
-{
-}
-#endif
-
 #define transparent_hugepage_use_zero_page()				\
 	(transparent_hugepage_flags &					\
 	 (1<<TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG))
diff --git a/mm/memory.c b/mm/memory.c
index 87a5c900c77f2..c96ac5b2464fa 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4761,9 +4761,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 
 	folio_ref_add(folio, nr_pages - 1);
 	add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_FAULT_ALLOC);
-#endif
 	folio_add_new_anon_rmap(folio, vma, addr, RMAP_EXCLUSIVE);
 	folio_add_lru_vma(folio, vma);
 setpte:
diff --git a/mm/shmem.c b/mm/shmem.c
index 68c9a31bc763b..33a146843e4c0 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1791,9 +1791,7 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
 
 			if (pages == HPAGE_PMD_NR)
 				count_vm_event(THP_FILE_FALLBACK);
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 			count_mthp_stat(order, MTHP_STAT_SHMEM_FALLBACK);
-#endif
 			order = next_order(&suitable_orders, order);
 		}
 	} else {
@@ -1818,10 +1816,8 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
 				count_vm_event(THP_FILE_FALLBACK);
 				count_vm_event(THP_FILE_FALLBACK_CHARGE);
 			}
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 			count_mthp_stat(folio_order(folio), MTHP_STAT_SHMEM_FALLBACK);
 			count_mthp_stat(folio_order(folio), MTHP_STAT_SHMEM_FALLBACK_CHARGE);
-#endif
 		}
 		goto unlock;
 	}
@@ -2301,9 +2297,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 		if (!IS_ERR(folio)) {
 			if (folio_test_pmd_mappable(folio))
 				count_vm_event(THP_FILE_ALLOC);
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 			count_mthp_stat(folio_order(folio), MTHP_STAT_SHMEM_ALLOC);
-#endif
 			goto alloced;
 		}
 		if (PTR_ERR(folio) == -EEXIST)
-- 
2.43.0


