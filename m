Return-Path: <linux-kernel+bounces-235855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2547191DA76
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 10:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E4CFB249D3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 08:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038AE148841;
	Mon,  1 Jul 2024 08:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RltasCJm"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1938A12C544
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 08:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823703; cv=none; b=FYWrm4Q+QxMMr0giMG93JbMkiXpW9c5abTiE3BCZWYBr2mMbwooMCjhVVTFdw6ntsKDFtRRXcTXlgSTxF3BagfymOl8kkodZ0Rjj1XinhaRDPhwdnFGSahxT8ItyjPtB1pkVB5YV7j9n4G7FlySoFz+8YUEH+YuQ+8s9MPiGdxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823703; c=relaxed/simple;
	bh=betnwoFaHdTUaSy772c73rSTFV5TeDM3Z4D9bCnscSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FFwSlf6j/yty84CEfdXrv4aA9K2uRTSzDTulFCrQ+kIiLXneDFrXrlxLVG7tutfzZFBnGpAMXbBy+h63yIFnJ6IQ4UTsj34AxvilKQ47YmRZJbVPCxBuAxq4SVGy0PWS/YUtXNQtdUxlDaJsB2jNkdN0PjhlGoI4vj3aZddtUCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RltasCJm; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70685423a06so139516b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 01:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1719823701; x=1720428501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8iGTSPNawa0GagXOh9xE0UwlegG4b1kDfjCNd9R6avY=;
        b=RltasCJmTvWQfbAtzz2NW05/WDfbjeUQTBk5Qcl5sYkVn5FlkZ3U8/0ZkXxkZnpmJq
         GUW6y8MgmVzVEFhdbigGX+TqkmuMDVs0ArxJO7epY7d6hhq8n4BDXrnHb85Iu6Fd5QAj
         uNtMES0xg4eAz6fsN79oWTc8S+viO7O0Qf+iVYbRzscgLXDNwqjpUdgQjH7LJOvmxDus
         LerkDMHXialnIUw4afgOCmKr29P8HexIZnPZnoHC+zb8SvCs69sSvv4vMeEIhLChdSvQ
         tafMjCF90yLVVOJEj3WfdSb9dKF3gbJO1tmiY1kbYOmqg1DQ8Goi7qGBA+abOdL7tYDd
         2J0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719823701; x=1720428501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8iGTSPNawa0GagXOh9xE0UwlegG4b1kDfjCNd9R6avY=;
        b=h32wsbuMIER0kPjcdNpagKovhcnVolxwzQWrQ0bYQvW8bkA3voRrSy71t3QpLGqLzA
         39Ug2dnzY9RybMxCwl+SeXs0f2pmNdwk/OSxL952xpHKuGqBBcF73XaKhZy1TTIAz45y
         HQVqI9/ihPqqOur2ALqNCQ0Q4iOqk+/RK6HiMFIh2tmQVGsOuJlry+1faGHgYu7pIrAz
         Xi62SiPXuiciyP8hVyzHvAy3vIzX4vI1jO0bgz+DEAY5Opw7FNR1xhWI7WcDxJ6SVn6+
         UpDERq2gdHiC6Gf/fhq50r/ScJhjnVqQZDvv3dS9TyN7oSaNK/M/yP7Df6FIjeR8vTrA
         vjSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx3yLL5Pmg64XeHQo7EL3h8G5YRKqrqNZh8NOzhk+0+cMeousBRVFr2fz58BurDLZ1vwVVSnzx9dNYDV8yH3+ONTeWQ3nSNY5cR/mN
X-Gm-Message-State: AOJu0YzMMJk1z2dRZWXb67RT3AEgOAG+4beaiHLepHljqSte3keeIlwY
	7pMWKMt1Nn/uUSDGgQI2Eys5j0ImhR3Bnpm467IxVpRZqzTj+jsLJvNWU9lSfmU=
X-Google-Smtp-Source: AGHT+IFls0oOjbzAtOgY83MipQfLTlG0nuWQRUmCut8mpMpDbM18C75DCE0fKwS+uZ7TURaRFkpcBQ==
X-Received: by 2002:aa7:8ecc:0:b0:704:21c2:ae92 with SMTP id d2e1a72fcca58-70aaaefd3bamr5492602b3a.2.1719823701163;
        Mon, 01 Jul 2024 01:48:21 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804a7e7e0sm5932374b3a.204.2024.07.01.01.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 01:48:20 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	mgorman@suse.de,
	muchun.song@linux.dev,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH 4/7] mm: pgtable: try to reclaim empty PTE pages in zap_page_range_single()
Date: Mon,  1 Jul 2024 16:46:45 +0800
Message-Id: <09a7b82e61bc87849ca6bde35f98345d109817e2.1719570849.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1719570849.git.zhengqi.arch@bytedance.com>
References: <cover.1719570849.git.zhengqi.arch@bytedance.com>
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
 mm/khugepaged.c         |  22 ++++++-
 mm/memory.c             |   2 +
 mm/pt_reclaim.c         | 131 ++++++++++++++++++++++++++++++++++++++++
 7 files changed, 186 insertions(+), 1 deletion(-)
 create mode 100644 mm/pt_reclaim.c

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 2f32eaccf0b9..59e894f705a7 100644
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
index d2915f8c9dc0..3cb3c1f5d090 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -141,3 +141,4 @@ obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
 obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
 obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
 obj-$(CONFIG_EXECMEM) += execmem.o
+obj-$(CONFIG_PT_RECLAIM) += pt_reclaim.o
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index c7ce28f6b7f3..444a1cdaf06d 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -977,6 +977,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 		folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
 		folio_add_lru_vma(folio, vma);
 		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
+		arch_flush_tlb_before_set_huge_page(vma->vm_mm, haddr);
 		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
 		update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 		add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
@@ -1044,6 +1045,7 @@ static void set_huge_zero_folio(pgtable_t pgtable, struct mm_struct *mm,
 	entry = mk_pmd(&zero_folio->page, vma->vm_page_prot);
 	entry = pmd_mkhuge(entry);
 	pgtable_trans_huge_deposit(mm, pmd, pgtable);
+	arch_flush_tlb_before_set_huge_page(mm, haddr);
 	set_pmd_at(mm, haddr, pmd, entry);
 	mm_inc_nr_ptes(mm);
 }
@@ -1151,6 +1153,7 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 		pgtable = NULL;
 	}
 
+	arch_flush_tlb_before_set_huge_page(mm, addr);
 	set_pmd_at(mm, addr, pmd, entry);
 	update_mmu_cache_pmd(vma, addr, pmd);
 
diff --git a/mm/internal.h b/mm/internal.h
index 1dfdad110a9a..ac1fdd4681dc 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1579,4 +1579,18 @@ void unlink_file_vma_batch_init(struct unlink_vma_file_batch *);
 void unlink_file_vma_batch_add(struct unlink_vma_file_batch *, struct vm_area_struct *);
 void unlink_file_vma_batch_final(struct unlink_vma_file_batch *);
 
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
index 7b7c858d5f99..63551077795d 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1578,7 +1578,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	if (userfaultfd_armed(vma) && !(vma->vm_flags & VM_SHARED))
 		pml = pmd_lock(mm, pmd);
 
-	start_pte = pte_offset_map_nolock(mm, pmd, NULL, haddr, &ptl);
+	start_pte = pte_offset_map_nolock(mm, pmd, &pgt_pmd, haddr, &ptl);
 	if (!start_pte)		/* mmap_lock + page lock should prevent this */
 		goto abort;
 	if (!pml)
@@ -1586,6 +1586,11 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
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
@@ -1633,6 +1638,12 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 		pml = pmd_lock(mm, pmd);
 		if (ptl != pml)
 			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
+
+		if (unlikely(IS_ENABLED(CONFIG_PT_RECLAIM) &&
+			     !pmd_same(pgt_pmd, pmdp_get_lockless(pmd)))) {
+			spin_unlock(ptl);
+			goto unlock;
+		}
 	}
 	pgt_pmd = pmdp_collapse_flush(vma, haddr, pmd);
 	pmdp_get_lockless_sync();
@@ -1660,6 +1671,7 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
 	}
 	if (start_pte)
 		pte_unmap_unlock(start_pte, ptl);
+unlock:
 	if (pml && pml != ptl)
 		spin_unlock(pml);
 	if (notified)
@@ -1719,6 +1731,14 @@ static void retract_page_tables(struct address_space *mapping, pgoff_t pgoff)
 		mmu_notifier_invalidate_range_start(&range);
 
 		pml = pmd_lock(mm, pmd);
+#ifdef CONFIG_PT_RECLAIM
+		/* check if the pmd is still valid */
+		if (check_pmd_still_valid(mm, addr, pmd) != SCAN_SUCCEED) {
+			spin_unlock(pml);
+			mmu_notifier_invalidate_range_end(&range);
+			continue;
+		}
+#endif
 		ptl = pte_lockptr(mm, pmd);
 		if (ptl != pml)
 			spin_lock_nested(ptl, SINGLE_DEPTH_NESTING);
diff --git a/mm/memory.c b/mm/memory.c
index 09db2c97cc5c..b07d63767d93 100644
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
index 000000000000..e375e7f2059f
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


