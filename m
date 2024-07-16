Return-Path: <linux-kernel+bounces-253853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FC99327E6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 15:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73D681C22802
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 13:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E23619B587;
	Tue, 16 Jul 2024 13:59:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F51B19AD6B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 13:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721138359; cv=none; b=u0EK7biQ3AjaJYDMgUd6tevB3ZeTVNU3mnjEIvRubGNqlwsyijjouX0GlbmHzteWhpOrCj/XMrzf1jLGQBPGo/kxJk1BQoRUNGxPoFR5lntcuWVklRzM2ruDq3+SGZW+BzTz6xPrJsAwA+cXrENHTHMyJZDyrNH6l1egMXU53ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721138359; c=relaxed/simple;
	bh=aQ5hfll0QTq/89EgPIxvlFW6ylakwRy8Tw8Ys5SzMOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dnDIVkOtRl8sq5zy2klCGjppDmax2dmRfy6uwGcKRtz+8Eeh2e0WPCJMrDW/T+OdigIAc52gT/+wQPQj14hLMNNzte+7OIoUoILosRB9RZKiDLx8BWJ6aXs8rAVkihUD6POK3M9D4S4emZNVYNF9HF7slkqHr9xKmvy51ytr88o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE2AF106F;
	Tue, 16 Jul 2024 06:59:42 -0700 (PDT)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.27])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00A7F3F762;
	Tue, 16 Jul 2024 06:59:15 -0700 (PDT)
From: Ryan Roberts <ryan.roberts@arm.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Lance Yang <ioworker0@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Gavin Shan <gshan@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 1/3] mm: Cleanup count_mthp_stat() definition
Date: Tue, 16 Jul 2024 14:59:04 +0100
Message-ID: <20240716135907.4047689-2-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716135907.4047689-1-ryan.roberts@arm.com>
References: <20240716135907.4047689-1-ryan.roberts@arm.com>
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
index e25d9ebfdf89..b8c63c3e967f 100644
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
index 802d0d8a40f9..a50fdefb8f0b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4597,9 +4597,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 
 	folio_ref_add(folio, nr_pages - 1);
 	add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	count_mthp_stat(folio_order(folio), MTHP_STAT_ANON_FAULT_ALLOC);
-#endif
 	folio_add_new_anon_rmap(folio, vma, addr, RMAP_EXCLUSIVE);
 	folio_add_lru_vma(folio, vma);
 setpte:
diff --git a/mm/shmem.c b/mm/shmem.c
index f24dfbd387ba..fce1343f44e6 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1776,9 +1776,7 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
 
 			if (pages == HPAGE_PMD_NR)
 				count_vm_event(THP_FILE_FALLBACK);
-#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 			count_mthp_stat(order, MTHP_STAT_SHMEM_FALLBACK);
-#endif
 			order = next_order(&suitable_orders, order);
 		}
 	} else {
@@ -1803,10 +1801,8 @@ static struct folio *shmem_alloc_and_add_folio(struct vm_fault *vmf,
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
@@ -2180,9 +2176,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
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


