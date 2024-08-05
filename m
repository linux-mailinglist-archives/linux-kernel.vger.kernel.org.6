Return-Path: <linux-kernel+bounces-274686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB70947B73
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30EF01C21235
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FDF15ECEA;
	Mon,  5 Aug 2024 12:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="I3zCJxuW"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D01415E5D2
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862568; cv=none; b=cFD3b/dzAMxh4mHvetiW6snLsshwqblcT0ZBHwCuxoiA1zgw3UcBg2QTqcRYxCuTwDvEqQnhxfIJEBOkTbqUvJPS4p2+RW4jmG/XcyQZFruahW0hbIah4kxX6Yb5tvkqBjD1Aua6BSDtburSm1HAE29g+2BVcZ8DSGstnOZJCM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862568; c=relaxed/simple;
	bh=L1uI+cjpnbWMQ8R4wTw2lvTGlCh3KmgzGDSMichkW54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uWSR80NS15NunSkBctMX97G/zRn+u1t7LKSPA8KFhwGtR2FCgWcrxF/exA1vG8z7Eh7JWv7NwnDLMswuT7R8P0+netNVGXUHlYvV7A2RoitSb+BD0mbNGDHU6xAoDonB0hCiaZ90jCppw/juyiYHEUHdpttrZD7GKHjwZoDwz28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=I3zCJxuW; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2cd46049d2bso1778950a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 05:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1722862566; x=1723467366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsBfabV4yKHDUnZv1G5PTky4g9osbznwx2f7l8Y7SBU=;
        b=I3zCJxuWV5Uha0dWatt0Mz7JOktMKXm6PUlw1sIiKkRdLcV/pB07clmgQAv96zPMIT
         Gi1PwODMoEAJsJDvU+3fceuLJMliFd+YHw/HZBOwbT/839vOM456sv9inhE5eB5vJ/bN
         eDBhxxBM+eMvo/PMCiO/9yMx818f2YEeJlXvlrGP6OoiIDCxoxXS+uXbUbyX3LkvPmwj
         WKIahGeo0sI72DOc8b5F7kk287UN+stzWtLbwcnxJSix/2J0I0cRO7jYpqZ/1/SH3OdT
         z3+e3U99Oe3aSvteETOhMkoC52lGpO7X6hTeoXYqNQPmir6+J5j0hrR1iErTiwb8Jc+N
         XBrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722862566; x=1723467366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsBfabV4yKHDUnZv1G5PTky4g9osbznwx2f7l8Y7SBU=;
        b=rIsyydFgMWkBbynT5X3wSgiCGmspZHsrIBcd2Jw92Zeuujm3IpyA4YxI7mkRrl4AoW
         v9Y1/P63wptYBJLg0YOSd+3uC/+XUCLEKlAhRUEvCkIBsD0aH5npCe/Rn2fEdmoNsStl
         BvKb1mbzncGT8iQnXUW5fZMGLWSFRvZxvl6tAis5xbOi6KRUrlLLFzNKjf50VtnJcWfA
         kpNf2MEpFGFgCXE8mJELZ89ERGICH88TTpnmSZxvKhd/TMhbn47rsGHcZlMxdmzPE+Lm
         2uZG+fXXeNGH4jg2tTvv8KvOvlHWvPkb1hJSC4TVejVzfLP86q4f3n3gXEJutdnEA8Ly
         J2ow==
X-Forwarded-Encrypted: i=1; AJvYcCUCTiZEy2g3+toNA5BJOriidC8vulnowr8QL5xDOJOf8M3ynRGscrw5yJdieIoE5SClmlNNjSss8xQcwHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLwRP+tD8RSvkaEhpyVFS3ln2SyQnHO45zYVRhQTQE+UGy6b54
	GpMO2buIUIi38CpSTXwmjEvmksv8FvC7esPlqVoMvZr4SoG0bUKzq8QAdN9bcx0=
X-Google-Smtp-Source: AGHT+IGC1DBrGh4Hjx0OyIm/9r87y3+3knx7wGDASaN8LJsQ77h18R7/hh4KYzuDRNZTKJBgub17iA==
X-Received: by 2002:a05:6a20:8414:b0:1c4:a742:ab20 with SMTP id adf61e73a8af0-1c69943c40cmr6974660637.0.1722862565538;
        Mon, 05 Aug 2024 05:56:05 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecfaf1asm5503030b3a.142.2024.08.05.05.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 05:56:05 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	mgorman@suse.de,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	zokeefe@google.com,
	rientjes@google.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH v2 4/7] mm: pgtable: try to reclaim empty PTE pages in zap_page_range_single()
Date: Mon,  5 Aug 2024 20:55:08 +0800
Message-Id: <9fb3dc75cb7f023750da2b4645fd098429deaad5.1722861064.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1722861064.git.zhengqi.arch@bytedance.com>
References: <cover.1722861064.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now in order to pursue high performance, applications mostly use some
high-performance user-mode memory allocators, such as jemalloc or
tcmalloc. These memory allocators use madvise(MADV_DONTNEED or MADV_FREE)
to release physical memory, but neither MADV_DONTNEED nor MADV_FREE will
release page table memory, which may cause huge page table memory usage.

The following are a memory usage snapshot of one process which actually
happened on our server:

        VIRT:  55t
        RES:   590g
        VmPTE: 110g

In this case, most of the page table entries are empty. For such a PTE
page where all entries are empty, we can actually free it back to the
system for others to use.

As a first step, this commit attempts to synchronously free the empty PTE
pages in zap_page_range_single() (MADV_DONTNEED etc will invoke this). In
order to reduce overhead, we only handle the cases with a high probability
of generating empty PTE pages, and other cases will be filtered out, such
as:

 - hugetlb vma (unsuitable)
 - userfaultfd_wp vma (may reinstall the pte entry)
 - writable private file mapping case (COW-ed anon page is not zapped)
 - etc

For userfaultfd_wp and private file mapping cases (and MADV_FREE case, of
course), consider scanning and freeing empty PTE pages asynchronously in
the future.

The following code snippet can show the effect of optimization:

        mmap 50G
        while (1) {
                for (; i < 1024 * 25; i++) {
                        touch 2M memory
                        madvise MADV_DONTNEED 2M
                }
        }

As we can see, the memory usage of VmPTE is reduced:

                        before                          after
VIRT                   50.0 GB                        50.0 GB
RES                     3.1 MB                         3.1 MB
VmPTE                102640 KB                         240 KB

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/pgtable.h |  14 +++++
 mm/Makefile             |   1 +
 mm/huge_memory.c        |   3 +
 mm/internal.h           |  14 +++++
 mm/khugepaged.c         |  30 +++++++--
 mm/memory.c             |   2 +
 mm/pt_reclaim.c         | 131 ++++++++++++++++++++++++++++++++++++++++
 7 files changed, 189 insertions(+), 6 deletions(-)
 create mode 100644 mm/pt_reclaim.c

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 2a6a3cccfc367..572343650eb0f 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -447,6 +447,20 @@ static inline void arch_check_zapped_pmd(struct vm_area_struct *vma,
 }
 #endif
 
+#ifndef arch_flush_tlb_before_set_huge_page
+static inline void arch_flush_tlb_before_set_huge_page(struct mm_struct *mm,
+						       unsigned long addr)
+{
+}
+#endif
+
+#ifndef arch_flush_tlb_before_set_pte_page
+static inline void arch_flush_tlb_before_set_pte_page(struct mm_struct *mm,
+						      unsigned long addr)
+{
+}
+#endif
+
 #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 				       unsigned long address,
diff --git a/mm/Makefile b/mm/Makefile
index ab5ed56c5c033..8bec86469c1d5 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -145,3 +145,4 @@ obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
 obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
 obj-$(CONFIG_EXECMEM) += execmem.o
 obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
+obj-$(CONFIG_PT_RECLAIM) += pt_reclaim.o
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 697fcf89f975b..0afbb1e45cdac 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -999,6 +999,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 		folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
 		folio_add_lru_vma(folio, vma);
 		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
+		arch_flush_tlb_before_set_huge_page(vma->vm_mm, haddr);
 		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
 		update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 		add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
@@ -1066,6 +1067,7 @@ static void set_huge_zero_folio(pgtable_t pgtable, struct mm_struct *mm,
 	entry = mk_pmd(&zero_folio->page, vma->vm_page_prot);
 	entry = pmd_mkhuge(entry);
 	pgtable_trans_huge_deposit(mm, pmd, pgtable);
+	arch_flush_tlb_before_set_huge_page(mm, haddr);
 	set_pmd_at(mm, haddr, pmd, entry);
 	mm_inc_nr_ptes(mm);
 }
@@ -1173,6 +1175,7 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 		pgtable = NULL;
 	}
 
+	arch_flush_tlb_before_set_huge_page(mm, addr);
 	set_pmd_at(mm, addr, pmd, entry);
 	update_mmu_cache_pmd(vma, addr, pmd);
 
diff --git a/mm/internal.h b/mm/internal.h
index dfc992de01115..09bd1cee7a523 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1441,4 +1441,18 @@ static inline bool try_to_accept_memory(struct zone *zone, unsigned int order)
 }
 #endif /* CONFIG_UNACCEPTED_MEMORY */
 
+#ifdef CONFIG_PT_RECLAIM
+void try_to_reclaim_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
+			     unsigned long start_addr, unsigned long end_addr,
+			     struct zap_details *details);
+#else
+static inline void try_to_reclaim_pgtables(struct mmu_gather *tlb,
+					   struct vm_area_struct *vma,
+					   unsigned long start_addr,
+					   unsigned long end_addr,
+					   struct zap_details *details)
+{
+}
+#endif /* CONFIG_PT_RECLAIM */
+
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 91b93259ee214..ffd3963b1c3d1 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1598,7 +1598,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	if (userfaultfd_armed(vma) && !(vma->vm_flags & VM_SHARED))
 		pml = pmd_lock(mm, pmd);
 
-	start_pte = pte_offset_map_nolock(mm, pmd, NULL, haddr, &ptl);
+	start_pte = pte_offset_map_nolock(mm, pmd, &pgt_pmd, haddr, &ptl);
 	if (!start_pte)		/* mmap_lock + page lock should prevent this */
 		goto abort;
 	if (!pml)
@@ -1606,6 +1606,11 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	else if (ptl != pml)
 		spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
 
+	/* pmd entry may be changed by others */
+	if (unlikely(IS_ENABLED(CONFIG_PT_RECLAIM) && !pml &&
+		     !pmd_same(pgt_pmd, pmdp_get_lockless(pmd))))
+		goto abort;
+
 	/* step 2: clear page table and adjust rmap */
 	for (i = 0, addr = haddr, pte = start_pte;
 	     i < HPAGE_PMD_NR; i++, addr += PAGE_SIZE, pte++) {
@@ -1651,6 +1656,11 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	/* step 4: remove empty page table */
 	if (!pml) {
 		pml = pmd_lock(mm, pmd);
+		if (unlikely(IS_ENABLED(CONFIG_PT_RECLAIM) &&
+			     !pmd_same(pgt_pmd, pmdp_get_lockless(pmd)))) {
+			spin_unlock(pml);
+			goto pmd_change;
+		}
 		if (ptl != pml)
 			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
 	}
@@ -1682,6 +1692,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		pte_unmap_unlock(start_pte, ptl);
 	if (pml && pml != ptl)
 		spin_unlock(pml);
+pmd_change:
 	if (notified)
 		mmu_notifier_invalidate_range_end(&range);
 drop_folio:
@@ -1703,6 +1714,7 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		spinlock_t *pml;
 		spinlock_t *ptl;
 		bool skipped_uffd = false;
+		pte_t *pte;
 
 		/*
 		 * Check vma->anon_vma to exclude MAP_PRIVATE mappings that
@@ -1738,11 +1750,17 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 					addr, addr + HPAGE_PMD_SIZE);
 		mmu_notifier_invalidate_range_start(&range);
 
+		pte = pte_offset_map_nolock(mm, pmd, &pgt_pmd, addr, &ptl);
+		if (!pte)
+			goto skip;
+
 		pml = pmd_lock(mm, pmd);
-		ptl = pte_lockptr(mm, pmd);
 		if (ptl != pml)
 			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
 
+		if (unlikely(IS_ENABLED(CONFIG_PT_RECLAIM) &&
+		    !pmd_same(pgt_pmd, pmdp_get_lockless(pmd))))
+			goto unlock_skip;
 		/*
 		 * Huge page lock is still held, so normally the page table
 		 * must remain empty; and we have already skipped anon_vma
@@ -1758,11 +1776,11 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 			pgt_pmd = pmdp_collapse_flush(vma, addr, pmd);
 			pmdp_get_lockless_sync();
 		}
-
+unlock_skip:
+		pte_unmap_unlock(pte, ptl);
 		if (ptl != pml)
-			spin_unlock(ptl);
-		spin_unlock(pml);
-
+			spin_unlock(pml);
+skip:
 		mmu_notifier_invalidate_range_end(&range);
 
 		if (!skipped_uffd) {
diff --git a/mm/memory.c b/mm/memory.c
index fef1e425e4702..a8108451e4dac 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -423,6 +423,7 @@ void pmd_install(struct mm_struct *mm, pmd_t *pmd, unsigned long addr,
 	spinlock_t *ptl = pmd_lock(mm, pmd);
 
 	if (likely(pmd_none(*pmd))) {	/* Has another populated it ? */
+		arch_flush_tlb_before_set_pte_page(mm, addr);
 		mm_inc_nr_ptes(mm);
 		/*
 		 * Ensure all pte setup (eg. pte page lock and page clearing) are
@@ -1931,6 +1932,7 @@ void zap_page_range_single(struct vm_area_struct *vma, unsigned long address,
 	 * could have been expanded for hugetlb pmd sharing.
 	 */
 	unmap_single_vma(&tlb, vma, address, end, details, false);
+	try_to_reclaim_pgtables(&tlb, vma, address, end, details);
 	mmu_notifier_invalidate_range_end(&range);
 	tlb_finish_mmu(&tlb);
 	hugetlb_zap_end(vma, details);
diff --git a/mm/pt_reclaim.c b/mm/pt_reclaim.c
new file mode 100644
index 0000000000000..e375e7f2059f8
--- /dev/null
+++ b/mm/pt_reclaim.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/pagewalk.h>
+#include <linux/hugetlb.h>
+#include <asm-generic/tlb.h>
+#include <asm/pgalloc.h>
+
+#include "internal.h"
+
+/*
+ * Locking:
+ *  - already held the mmap read lock to traverse the pgtable
+ *  - use pmd lock for clearing pmd entry
+ *  - use pte lock for checking empty PTE page, and release it after clearing
+ *    pmd entry, then we can capture the changed pmd in pte_offset_map_lock()
+ *    etc after holding this pte lock. Thanks to this, we don't need to hold the
+ *    rmap-related locks.
+ *  - users of pte_offset_map_lock() etc all expect the PTE page to be stable by
+ *    using rcu lock, so PTE pages should be freed by RCU.
+ */
+static int reclaim_pgtables_pmd_entry(pmd_t *pmd, unsigned long addr,
+				      unsigned long next, struct mm_walk *walk)
+{
+	struct mm_struct *mm = walk->mm;
+	struct mmu_gather *tlb = walk->private;
+	pte_t *start_pte, *pte;
+	pmd_t pmdval;
+	spinlock_t *pml = NULL, *ptl;
+	int i;
+
+	start_pte = pte_offset_map_nolock(mm, pmd, &pmdval, addr, &ptl);
+	if (!start_pte)
+		return 0;
+
+	pml = pmd_lock(mm, pmd);
+	if (ptl != pml)
+		spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
+
+	if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pmd))))
+		goto out_ptl;
+
+	/* Check if it is empty PTE page */
+	for (i = 0, pte = start_pte; i < PTRS_PER_PTE; i++, pte++) {
+		if (!pte_none(ptep_get(pte)))
+			goto out_ptl;
+	}
+	pte_unmap(start_pte);
+
+	pmd_clear(pmd);
+	if (ptl != pml)
+		spin_unlock(ptl);
+	spin_unlock(pml);
+
+	/*
+	 * NOTE:
+	 *   In order to reuse mmu_gather to batch flush tlb and free PTE pages,
+	 *   here tlb is not flushed before pmd lock is unlocked. This may
+	 *   result in the following two situations:
+	 *
+	 *   1) Userland can trigger page fault and fill a huge page, which will
+	 *      cause the existence of small size TLB and huge TLB for the same
+	 *      address.
+	 *
+	 *   2) Userland can also trigger page fault and fill a PTE page, which
+	 *      will cause the existence of two small size TLBs, but the PTE
+	 *      page they map are different.
+	 *
+	 * Some CPUs do not allow these, to solve this, we can define
+	 * arch_flush_tlb_before_set_{huge|pte}_page to detect this case and
+	 * flush TLB before filling a huge page or a PTE page in page fault
+	 * path.
+	 */
+	pte_free_tlb(tlb, pmd_pgtable(pmdval), addr);
+	mm_dec_nr_ptes(mm);
+
+	return 0;
+
+out_ptl:
+	pte_unmap_unlock(start_pte, ptl);
+	if (pml != ptl)
+		spin_unlock(pml);
+
+	return 0;
+}
+
+static const struct mm_walk_ops reclaim_pgtables_walk_ops = {
+	.pmd_entry = reclaim_pgtables_pmd_entry,
+	.walk_lock = PGWALK_RDLOCK,
+};
+
+void try_to_reclaim_pgtables(struct mmu_gather *tlb, struct vm_area_struct *vma,
+			     unsigned long start_addr, unsigned long end_addr,
+			     struct zap_details *details)
+{
+	unsigned long start = max(vma->vm_start, start_addr);
+	unsigned long end;
+
+	if (start >= vma->vm_end)
+		return;
+	end = min(vma->vm_end, end_addr);
+	if (end <= vma->vm_start)
+		return;
+
+	/* Skip hugetlb case  */
+	if (is_vm_hugetlb_page(vma))
+		return;
+
+	/* Leave this to the THP path to handle */
+	if (vma->vm_flags & VM_HUGEPAGE)
+		return;
+
+	/* userfaultfd_wp case may reinstall the pte entry, also skip */
+	if (userfaultfd_wp(vma))
+		return;
+
+	/*
+	 * For private file mapping, the COW-ed page is an anon page, and it
+	 * will not be zapped. For simplicity, skip the all writable private
+	 * file mapping cases.
+	 */
+	if (details && !vma_is_anonymous(vma) &&
+	    !(vma->vm_flags & VM_MAYSHARE) &&
+	    (vma->vm_flags & VM_WRITE))
+		return;
+
+	start = ALIGN(start, PMD_SIZE);
+	end = ALIGN_DOWN(end, PMD_SIZE);
+	if (end - start < PMD_SIZE)
+		return;
+
+	walk_page_range_vma(vma, start, end, &reclaim_pgtables_walk_ops, tlb);
+}
-- 
2.20.1


