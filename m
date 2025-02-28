Return-Path: <linux-kernel+bounces-537646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F234A48EA3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 03:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B72DD16EE4E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 02:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC3016D9AF;
	Fri, 28 Feb 2025 02:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="VtAveP9A"
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07A110E5
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 02:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=158.69.130.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740709868; cv=none; b=Tb+F42j8vtAlFq5yTM4WbSMbCDp+nZt/84IG65pOqsKp2eFng0sfUYyZ+lkQPAfCrw7LwIpZeq2w+/vSiAfomdc3/HGB2fHUOItXUQiyWZO6szBaNsGWvmCEkyknDC4tT5zbESCm9YGK57O+FwsnZuhKX7T189mSb7ma54VR1zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740709868; c=relaxed/simple;
	bh=SeGYrGpP1DhpBbiS/ptbdJruKzifKB1SHy2MBwnsS+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mrB1NZPGVx/rFKPOBbZlFFhLcQm5VZ2KX9CCmNRZ3seISGziIz4uahLY0LiQV8qr3OtzPZITWyqhVZUiUnCaKzF3h2fM/WbUt4sU/vZ6JYCgb2slJzBL6Q13biFDnvqChmFJGR/4WpNW5Z9PdqSwID9hBWHmusKWQlZ8fJS0Vr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=VtAveP9A; arc=none smtp.client-ip=158.69.130.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1740709859;
	bh=SeGYrGpP1DhpBbiS/ptbdJruKzifKB1SHy2MBwnsS+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VtAveP9AJXAPNcMG6yUNacYliDmZMVsLbX+I+FT0+5226T6VDewaavARxkPqffqtD
	 eZS07g3M1icobG9CgkWjkkbB7e1Ehj3Uh9JbDV1i5R4ST4HJnYpPElMes00OSAiTI7
	 GzCIElr+xpund56fWwSyIjtyX9OenUv+XuK+G9mlRrKCFFBqsLSFzw4z0Q7Crni/mB
	 h7wLKEEnd3eXD8FD6780cf2UEUQmpIQ/AEbm5u3ePCw5y4XJDHKorFVmfIVS9i8CwQ
	 1rMHy0Fj7M2b3DRrAaEIffY0+edPtY4cIs2Ur8LWjZyA8Y4TCkjT1il9rUbgmZX2l4
	 ZtymeBGqAg9Vg==
Received: from thinkos.internal.efficios.com (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Z3sdb56crz10GZ;
	Thu, 27 Feb 2025 21:30:59 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Olivier Dion <odion@efficios.com>,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/2] mm: Introduce SKSM: Synchronous Kernel Samepage Merging
Date: Thu, 27 Feb 2025 21:30:42 -0500
Message-Id: <20250228023043.83726-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250228023043.83726-1-mathieu.desnoyers@efficios.com>
References: <20250228023043.83726-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

* Main use-case targeted by SKSM: Code patching

The main use-case targeted by SKSM is deduplication of anonymous
pages created by COW (Copy-On-Write) triggered by patching executable
and library code for a user-space implementation of "static keys" and
"alternative" code patching. Code patching improves:

- Runtime feature detection, where a constructor can dynamically
  enable a feature by turning a no-op into a jump.

- Instrumentation activation at runtime (e.g. tracepoints) (patch
  a dormant no-op instrumentation into a jump).

- Runtime assembler specialisation, where a constructor can dynamically
  modify assembler instructions to select the best alternative for the
  detected hardware and software environment (e.g. CPU features, rseq
  availability).

The main distinction between doing code patching at kernel-level and at
user-space level is that in user-space, executable and library code is
shared across all processes mapping the same executable or library
files. This reduces memory use and improves cache locality by sharing
executable pages across processes.

Writing to those private mappings trigger COW, which allocates anonymous
pages within each process, and thus lose the benefit from sharing the
same pages from the backing storage.

Without memory deduplication, this increases memory use, and therefore
degrades cache locality: populating the patched content into separate
COW pages within each process ends up using distinct CPU cache lines,
thus trashing the CPU instruction and data caches.

* Why not use KSM ?

The KSM mechanism has the following downsides which the SKSM ABI aims to
overcome:

- KSM requires careful tuning of scan parameters for the workload by the
  system administrator.

  A) This makes KSM mostly useless with a standard distro config.

  B) KSM is workload-specific.

  C) Scanning pages adds overhead to the system, which is the reason
     why the scan parameters must be tuned for the workload.

- KSM has security implications, because it allows processes to
  confirm that an unrelated process has a page which contains a known
  content.

  A) The documentation of madvise(2) MADV_MERGEABLE would benefit from
     advising against targeting memory that contains secret data,
     due to the risk of discovery through side-channel timing attack.

  B) prctl(2) PR_SET_MEMORY_MERGE inherently marks the entire process
     memory as mergeable, which makes it incompatible with security
     oriented use-cases.

* SKSM Overview

SKSM enables synchronous dynamic sharing of identical pages found in
different memory areas, even if they are not shared by fork().

Userspace must explicitly request for pages within specific address
ranges to be merged with madvise MADV_MERGE. Those should *not* contain
secrets, as side-channel timing attacks can allow a process to learn the
existence of a known content within another process.

The synchronous memory merging performs the memory merging synchronously
within madvise. There is no global scan and no need for background
daemon.

The anonymous pages targeted for merge are write-protected and
checksummed. They are then compared to other pages targeted for merge.

The mergeable pages are added to a hash table indexed by checksum of
their content. The hash value is derived from the page content checksum,
and its comparison function is based on comparison of the page content.

If a page is written to after being targeted for merge, a COW will be
triggered, and thus a new page will be populated in its stead.

* Expected Use

User-space is expected to perform code patching, e.g. from a library
constructor, and then when the text pages are expected to stay invariant
for a long time, issue madvise(2) MADV_MERGE on those pages. At this
point, the pages will be write-protected, and merged with identical SKSM
pages. Further stores to those pages will trigger COW again.

* Results

Output of "cat /proc/vmstat | grep nr_anon_pages" while running 1000
instances of "sleep 500":

- Baseline (no preload):                nr_anon_pages  39721
- COW each executable page from libc:   nr_anon_pages 419927
- madvise MADV_MERGE after COW of libc: nr_anon_pages  45525

* Limitations

- This is a Proof-of-concept !
- It is incompatible with SKM (depends on !KSM) for now.
- Swap behavior under memory pressure is untested.
- The size of the hash table is static (65536 buckets) for now.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Olivier Dion <odion@efficios.com>
Cc: linux-mm@kvack.org
---
 include/linux/ksm.h                    |   4 +
 include/linux/mm_types.h               |   7 +
 include/linux/page-flags.h             |  42 +++++
 include/linux/sksm.h                   |  27 +++
 include/uapi/asm-generic/mman-common.h |   2 +
 mm/Kconfig                             |   5 +
 mm/Makefile                            |   1 +
 mm/ksm-common.h                        | 228 +++++++++++++++++++++++++
 mm/ksm.c                               | 219 +-----------------------
 mm/madvise.c                           |   6 +
 mm/memory.c                            |   2 +
 mm/page_alloc.c                        |   3 +
 mm/sksm.c                              | 190 +++++++++++++++++++++
 13 files changed, 518 insertions(+), 218 deletions(-)
 create mode 100644 include/linux/sksm.h
 create mode 100644 mm/ksm-common.h
 create mode 100644 mm/sksm.c

diff --git a/include/linux/ksm.h b/include/linux/ksm.h
index 6a53ac4885bb..dc3ce855863c 100644
--- a/include/linux/ksm.h
+++ b/include/linux/ksm.h
@@ -118,6 +118,10 @@ static inline void ksm_exit(struct mm_struct *mm)
 {
 }
 
+static inline void ksm_map_zero_page(struct mm_struct *mm)
+{
+}
+
 static inline void ksm_might_unmap_zero_page(struct mm_struct *mm, pte_t pte)
 {
 }
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 332cee285662..e4940562cb81 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -19,6 +19,7 @@
 #include <linux/workqueue.h>
 #include <linux/seqlock.h>
 #include <linux/percpu_counter.h>
+#include <linux/types.h>
 
 #include <asm/mmu.h>
 
@@ -216,6 +217,12 @@ struct page {
 	struct page *kmsan_shadow;
 	struct page *kmsan_origin;
 #endif
+
+#ifdef CONFIG_SKSM
+	/* TODO: move those fields into unused union fields instead. */
+	struct hlist_node sksm_node;
+	u32 checksum;
+#endif
 } _struct_page_alignment;
 
 /*
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 691506bdf2c5..4e96437ab94e 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -701,6 +701,48 @@ static __always_inline bool PageAnon(const struct page *page)
 	return folio_test_anon(page_folio(page));
 }
 
+#ifdef CONFIG_SKSM
+static __always_inline bool folio_test_sksm(const struct folio *folio)
+{
+	return !hlist_unhashed_lockless(&folio->page.sksm_node);
+}
+#else
+static __always_inline bool folio_test_sksm(const struct folio *folio)
+{
+	return false;
+}
+#endif
+
+static __always_inline bool PageSKSM(const struct page *page)
+{
+	return folio_test_sksm(page_folio(page));
+}
+
+#ifdef CONFIG_SKSM
+static inline void set_page_checksum(struct page *page, u32 checksum)
+{
+	page->checksum = checksum;
+}
+
+static inline void init_page_sksm_node(struct page *page)
+{
+	INIT_HLIST_NODE(&page->sksm_node);
+}
+
+void __sksm_page_remove(struct page *page);
+
+static inline void sksm_page_remove(struct page *page)
+{
+	if (!PageSKSM(page))
+		return;
+	__sksm_page_remove(page);
+}
+#else
+static inline void set_page_checksum(struct page *page, u32 checksum) { }
+static inline void init_page_sksm_node(struct page *page) { }
+static inline void sksm_page_remove(struct page *page) { }
+#endif
+
 static __always_inline bool __folio_test_movable(const struct folio *folio)
 {
 	return ((unsigned long)folio->mapping & PAGE_MAPPING_FLAGS) ==
diff --git a/include/linux/sksm.h b/include/linux/sksm.h
new file mode 100644
index 000000000000..4f3aaec512df
--- /dev/null
+++ b/include/linux/sksm.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_SKSM_H
+#define __LINUX_SKSM_H
+/*
+ * Synchronous memory merging support.
+ *
+ * This code enables synchronous dynamic sharing of identical pages
+ * found in different memory areas, even if they are not shared by
+ * fork().
+ */
+
+#ifdef CONFIG_SKSM
+
+int sksm_merge(struct vm_area_struct *vma, unsigned long start,
+	       unsigned long end);
+
+#else  /* !CONFIG_KSM */
+
+static inline int sksm_merge(struct vm_area_struct *vma, unsigned long start,
+			     unsigned long end)
+{
+	return 0;
+}
+
+#endif	/* !CONFIG_KSM */
+
+#endif /* __LINUX_SKSM_H */
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index 1ea2c4c33b86..8bd57eb21c12 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -79,6 +79,8 @@
 
 #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
 
+#define MADV_MERGE   	26		/* Synchronously merge identical pages */
+
 #define MADV_GUARD_INSTALL 102		/* fatal signal on access to range */
 #define MADV_GUARD_REMOVE 103		/* unguard range */
 
diff --git a/mm/Kconfig b/mm/Kconfig
index 84000b016808..067d4c3aa21c 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -740,6 +740,11 @@ config KSM
 	  until a program has madvised that an area is MADV_MERGEABLE, and
 	  root has set /sys/kernel/mm/ksm/run to 1 (if CONFIG_SYSFS is set).
 
+config SKSM
+	bool "Enable Synchronous KSM for page merging"
+	depends on MMU && !KSM
+	select XXHASH
+
 config DEFAULT_MMAP_MIN_ADDR
 	int "Low address space to protect from user allocation"
 	depends on MMU
diff --git a/mm/Makefile b/mm/Makefile
index dba52bb0da8a..8722c3ea572c 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -85,6 +85,7 @@ obj-$(CONFIG_SPARSEMEM)	+= sparse.o
 obj-$(CONFIG_SPARSEMEM_VMEMMAP) += sparse-vmemmap.o
 obj-$(CONFIG_MMU_NOTIFIER) += mmu_notifier.o
 obj-$(CONFIG_KSM) += ksm.o
+obj-$(CONFIG_SKSM) += sksm.o
 obj-$(CONFIG_PAGE_POISONING) += page_poison.o
 obj-$(CONFIG_KASAN)	+= kasan/
 obj-$(CONFIG_KFENCE) += kfence/
diff --git a/mm/ksm-common.h b/mm/ksm-common.h
new file mode 100644
index 000000000000..b676f1f5c10f
--- /dev/null
+++ b/mm/ksm-common.h
@@ -0,0 +1,228 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Memory merging support, common code.
+ */
+#ifndef _KSM_COMMON_H
+#define _KSM_COMMON_H
+
+#include <linux/ksm.h>
+
+static bool vma_ksm_compatible(struct vm_area_struct *vma)
+{
+	if (vma->vm_flags & (VM_SHARED  | VM_MAYSHARE   | VM_PFNMAP  |
+			     VM_IO      | VM_DONTEXPAND | VM_HUGETLB |
+			     VM_MIXEDMAP| VM_DROPPABLE))
+		return false;		/* just ignore the advice */
+
+	if (vma_is_dax(vma))
+		return false;
+
+#ifdef VM_SAO
+	if (vma->vm_flags & VM_SAO)
+		return false;
+#endif
+#ifdef VM_SPARC_ADI
+	if (vma->vm_flags & VM_SPARC_ADI)
+		return false;
+#endif
+
+	return true;
+}
+
+static u32 calc_checksum(struct page *page)
+{
+	u32 checksum;
+	void *addr = kmap_local_page(page);
+	checksum = xxhash(addr, PAGE_SIZE, 0);
+	kunmap_local(addr);
+	return checksum;
+}
+
+static int write_protect_page(struct vm_area_struct *vma, struct folio *folio,
+			      pte_t *orig_pte)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, 0, 0);
+	int swapped;
+	int err = -EFAULT;
+	struct mmu_notifier_range range;
+	bool anon_exclusive;
+	pte_t entry;
+
+	if (WARN_ON_ONCE(folio_test_large(folio)))
+		return err;
+
+	pvmw.address = page_address_in_vma(folio, folio_page(folio, 0), vma);
+	if (pvmw.address == -EFAULT)
+		goto out;
+
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, pvmw.address,
+				pvmw.address + PAGE_SIZE);
+	mmu_notifier_invalidate_range_start(&range);
+
+	if (!page_vma_mapped_walk(&pvmw))
+		goto out_mn;
+	if (WARN_ONCE(!pvmw.pte, "Unexpected PMD mapping?"))
+		goto out_unlock;
+
+	anon_exclusive = PageAnonExclusive(&folio->page);
+	entry = ptep_get(pvmw.pte);
+	if (pte_write(entry) || pte_dirty(entry) ||
+	    anon_exclusive || mm_tlb_flush_pending(mm)) {
+		swapped = folio_test_swapcache(folio);
+		flush_cache_page(vma, pvmw.address, folio_pfn(folio));
+		/*
+		 * Ok this is tricky, when get_user_pages_fast() run it doesn't
+		 * take any lock, therefore the check that we are going to make
+		 * with the pagecount against the mapcount is racy and
+		 * O_DIRECT can happen right after the check.
+		 * So we clear the pte and flush the tlb before the check
+		 * this assure us that no O_DIRECT can happen after the check
+		 * or in the middle of the check.
+		 *
+		 * No need to notify as we are downgrading page table to read
+		 * only not changing it to point to a new page.
+		 *
+		 * See Documentation/mm/mmu_notifier.rst
+		 */
+		entry = ptep_clear_flush(vma, pvmw.address, pvmw.pte);
+		/*
+		 * Check that no O_DIRECT or similar I/O is in progress on the
+		 * page
+		 */
+		if (folio_mapcount(folio) + 1 + swapped != folio_ref_count(folio)) {
+			set_pte_at(mm, pvmw.address, pvmw.pte, entry);
+			goto out_unlock;
+		}
+
+		/* See folio_try_share_anon_rmap_pte(): clear PTE first. */
+		if (anon_exclusive &&
+		    folio_try_share_anon_rmap_pte(folio, &folio->page)) {
+			set_pte_at(mm, pvmw.address, pvmw.pte, entry);
+			goto out_unlock;
+		}
+
+		if (pte_dirty(entry))
+			folio_mark_dirty(folio);
+		entry = pte_mkclean(entry);
+
+		if (pte_write(entry))
+			entry = pte_wrprotect(entry);
+
+		set_pte_at(mm, pvmw.address, pvmw.pte, entry);
+	}
+	*orig_pte = entry;
+	err = 0;
+
+out_unlock:
+	page_vma_mapped_walk_done(&pvmw);
+out_mn:
+	mmu_notifier_invalidate_range_end(&range);
+out:
+	return err;
+}
+
+/**
+ * replace_page - replace page in vma by new ksm page
+ * @vma:      vma that holds the pte pointing to page
+ * @page:     the page we are replacing by kpage
+ * @kpage:    the ksm page we replace page by
+ * @orig_pte: the original value of the pte
+ *
+ * Returns 0 on success, -EFAULT on failure.
+ */
+static int replace_page(struct vm_area_struct *vma, struct page *page,
+			struct page *kpage, pte_t orig_pte)
+{
+	struct folio *kfolio = page_folio(kpage);
+	struct mm_struct *mm = vma->vm_mm;
+	struct folio *folio = page_folio(page);
+	pmd_t *pmd;
+	pmd_t pmde;
+	pte_t *ptep;
+	pte_t newpte;
+	spinlock_t *ptl;
+	unsigned long addr;
+	int err = -EFAULT;
+	struct mmu_notifier_range range;
+
+	addr = page_address_in_vma(folio, page, vma);
+	if (addr == -EFAULT)
+		goto out;
+
+	pmd = mm_find_pmd(mm, addr);
+	if (!pmd)
+		goto out;
+	/*
+	 * Some THP functions use the sequence pmdp_huge_clear_flush(), set_pmd_at()
+	 * without holding anon_vma lock for write.  So when looking for a
+	 * genuine pmde (in which to find pte), test present and !THP together.
+	 */
+	pmde = pmdp_get_lockless(pmd);
+	if (!pmd_present(pmde) || pmd_trans_huge(pmde))
+		goto out;
+
+	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, addr,
+				addr + PAGE_SIZE);
+	mmu_notifier_invalidate_range_start(&range);
+
+	ptep = pte_offset_map_lock(mm, pmd, addr, &ptl);
+	if (!ptep)
+		goto out_mn;
+	if (!pte_same(ptep_get(ptep), orig_pte)) {
+		pte_unmap_unlock(ptep, ptl);
+		goto out_mn;
+	}
+	VM_BUG_ON_PAGE(PageAnonExclusive(page), page);
+	VM_BUG_ON_FOLIO(folio_test_anon(kfolio) && PageAnonExclusive(kpage),
+			kfolio);
+
+	/*
+	 * No need to check ksm_use_zero_pages here: we can only have a
+	 * zero_page here if ksm_use_zero_pages was enabled already.
+	 */
+	if (!is_zero_pfn(page_to_pfn(kpage))) {
+		folio_get(kfolio);
+		folio_add_anon_rmap_pte(kfolio, kpage, vma, addr, RMAP_NONE);
+		newpte = mk_pte(kpage, vma->vm_page_prot);
+	} else {
+		/*
+		 * Use pte_mkdirty to mark the zero page mapped by KSM, and then
+		 * we can easily track all KSM-placed zero pages by checking if
+		 * the dirty bit in zero page's PTE is set.
+		 */
+		newpte = pte_mkdirty(pte_mkspecial(pfn_pte(page_to_pfn(kpage), vma->vm_page_prot)));
+		ksm_map_zero_page(mm);
+		/*
+		 * We're replacing an anonymous page with a zero page, which is
+		 * not anonymous. We need to do proper accounting otherwise we
+		 * will get wrong values in /proc, and a BUG message in dmesg
+		 * when tearing down the mm.
+		 */
+		dec_mm_counter(mm, MM_ANONPAGES);
+	}
+
+	flush_cache_page(vma, addr, pte_pfn(ptep_get(ptep)));
+	/*
+	 * No need to notify as we are replacing a read only page with another
+	 * read only page with the same content.
+	 *
+	 * See Documentation/mm/mmu_notifier.rst
+	 */
+	ptep_clear_flush(vma, addr, ptep);
+	set_pte_at(mm, addr, ptep, newpte);
+
+	folio_remove_rmap_pte(folio, page, vma);
+	if (!folio_mapped(folio))
+		folio_free_swap(folio);
+	folio_put(folio);
+
+	pte_unmap_unlock(ptep, ptl);
+	err = 0;
+out_mn:
+	mmu_notifier_invalidate_range_end(&range);
+out:
+	return err;
+}
+
+#endif /* _KSM_COMMON_H */
diff --git a/mm/ksm.c b/mm/ksm.c
index 31a9bc365437..c495469a8329 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -44,6 +44,7 @@
 #include <asm/tlbflush.h>
 #include "internal.h"
 #include "mm_slot.h"
+#include "ksm-common.h"
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/ksm.h>
@@ -677,28 +678,6 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr, bool lock_v
 	return (ret & VM_FAULT_OOM) ? -ENOMEM : 0;
 }
 
-static bool vma_ksm_compatible(struct vm_area_struct *vma)
-{
-	if (vma->vm_flags & (VM_SHARED  | VM_MAYSHARE   | VM_PFNMAP  |
-			     VM_IO      | VM_DONTEXPAND | VM_HUGETLB |
-			     VM_MIXEDMAP| VM_DROPPABLE))
-		return false;		/* just ignore the advice */
-
-	if (vma_is_dax(vma))
-		return false;
-
-#ifdef VM_SAO
-	if (vma->vm_flags & VM_SAO)
-		return false;
-#endif
-#ifdef VM_SPARC_ADI
-	if (vma->vm_flags & VM_SPARC_ADI)
-		return false;
-#endif
-
-	return true;
-}
-
 static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
 		unsigned long addr)
 {
@@ -1234,202 +1213,6 @@ static int unmerge_and_remove_all_rmap_items(void)
 }
 #endif /* CONFIG_SYSFS */
 
-static u32 calc_checksum(struct page *page)
-{
-	u32 checksum;
-	void *addr = kmap_local_page(page);
-	checksum = xxhash(addr, PAGE_SIZE, 0);
-	kunmap_local(addr);
-	return checksum;
-}
-
-static int write_protect_page(struct vm_area_struct *vma, struct folio *folio,
-			      pte_t *orig_pte)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	DEFINE_FOLIO_VMA_WALK(pvmw, folio, vma, 0, 0);
-	int swapped;
-	int err = -EFAULT;
-	struct mmu_notifier_range range;
-	bool anon_exclusive;
-	pte_t entry;
-
-	if (WARN_ON_ONCE(folio_test_large(folio)))
-		return err;
-
-	pvmw.address = page_address_in_vma(folio, folio_page(folio, 0), vma);
-	if (pvmw.address == -EFAULT)
-		goto out;
-
-	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, pvmw.address,
-				pvmw.address + PAGE_SIZE);
-	mmu_notifier_invalidate_range_start(&range);
-
-	if (!page_vma_mapped_walk(&pvmw))
-		goto out_mn;
-	if (WARN_ONCE(!pvmw.pte, "Unexpected PMD mapping?"))
-		goto out_unlock;
-
-	anon_exclusive = PageAnonExclusive(&folio->page);
-	entry = ptep_get(pvmw.pte);
-	if (pte_write(entry) || pte_dirty(entry) ||
-	    anon_exclusive || mm_tlb_flush_pending(mm)) {
-		swapped = folio_test_swapcache(folio);
-		flush_cache_page(vma, pvmw.address, folio_pfn(folio));
-		/*
-		 * Ok this is tricky, when get_user_pages_fast() run it doesn't
-		 * take any lock, therefore the check that we are going to make
-		 * with the pagecount against the mapcount is racy and
-		 * O_DIRECT can happen right after the check.
-		 * So we clear the pte and flush the tlb before the check
-		 * this assure us that no O_DIRECT can happen after the check
-		 * or in the middle of the check.
-		 *
-		 * No need to notify as we are downgrading page table to read
-		 * only not changing it to point to a new page.
-		 *
-		 * See Documentation/mm/mmu_notifier.rst
-		 */
-		entry = ptep_clear_flush(vma, pvmw.address, pvmw.pte);
-		/*
-		 * Check that no O_DIRECT or similar I/O is in progress on the
-		 * page
-		 */
-		if (folio_mapcount(folio) + 1 + swapped != folio_ref_count(folio)) {
-			set_pte_at(mm, pvmw.address, pvmw.pte, entry);
-			goto out_unlock;
-		}
-
-		/* See folio_try_share_anon_rmap_pte(): clear PTE first. */
-		if (anon_exclusive &&
-		    folio_try_share_anon_rmap_pte(folio, &folio->page)) {
-			set_pte_at(mm, pvmw.address, pvmw.pte, entry);
-			goto out_unlock;
-		}
-
-		if (pte_dirty(entry))
-			folio_mark_dirty(folio);
-		entry = pte_mkclean(entry);
-
-		if (pte_write(entry))
-			entry = pte_wrprotect(entry);
-
-		set_pte_at(mm, pvmw.address, pvmw.pte, entry);
-	}
-	*orig_pte = entry;
-	err = 0;
-
-out_unlock:
-	page_vma_mapped_walk_done(&pvmw);
-out_mn:
-	mmu_notifier_invalidate_range_end(&range);
-out:
-	return err;
-}
-
-/**
- * replace_page - replace page in vma by new ksm page
- * @vma:      vma that holds the pte pointing to page
- * @page:     the page we are replacing by kpage
- * @kpage:    the ksm page we replace page by
- * @orig_pte: the original value of the pte
- *
- * Returns 0 on success, -EFAULT on failure.
- */
-static int replace_page(struct vm_area_struct *vma, struct page *page,
-			struct page *kpage, pte_t orig_pte)
-{
-	struct folio *kfolio = page_folio(kpage);
-	struct mm_struct *mm = vma->vm_mm;
-	struct folio *folio = page_folio(page);
-	pmd_t *pmd;
-	pmd_t pmde;
-	pte_t *ptep;
-	pte_t newpte;
-	spinlock_t *ptl;
-	unsigned long addr;
-	int err = -EFAULT;
-	struct mmu_notifier_range range;
-
-	addr = page_address_in_vma(folio, page, vma);
-	if (addr == -EFAULT)
-		goto out;
-
-	pmd = mm_find_pmd(mm, addr);
-	if (!pmd)
-		goto out;
-	/*
-	 * Some THP functions use the sequence pmdp_huge_clear_flush(), set_pmd_at()
-	 * without holding anon_vma lock for write.  So when looking for a
-	 * genuine pmde (in which to find pte), test present and !THP together.
-	 */
-	pmde = pmdp_get_lockless(pmd);
-	if (!pmd_present(pmde) || pmd_trans_huge(pmde))
-		goto out;
-
-	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, addr,
-				addr + PAGE_SIZE);
-	mmu_notifier_invalidate_range_start(&range);
-
-	ptep = pte_offset_map_lock(mm, pmd, addr, &ptl);
-	if (!ptep)
-		goto out_mn;
-	if (!pte_same(ptep_get(ptep), orig_pte)) {
-		pte_unmap_unlock(ptep, ptl);
-		goto out_mn;
-	}
-	VM_BUG_ON_PAGE(PageAnonExclusive(page), page);
-	VM_BUG_ON_FOLIO(folio_test_anon(kfolio) && PageAnonExclusive(kpage),
-			kfolio);
-
-	/*
-	 * No need to check ksm_use_zero_pages here: we can only have a
-	 * zero_page here if ksm_use_zero_pages was enabled already.
-	 */
-	if (!is_zero_pfn(page_to_pfn(kpage))) {
-		folio_get(kfolio);
-		folio_add_anon_rmap_pte(kfolio, kpage, vma, addr, RMAP_NONE);
-		newpte = mk_pte(kpage, vma->vm_page_prot);
-	} else {
-		/*
-		 * Use pte_mkdirty to mark the zero page mapped by KSM, and then
-		 * we can easily track all KSM-placed zero pages by checking if
-		 * the dirty bit in zero page's PTE is set.
-		 */
-		newpte = pte_mkdirty(pte_mkspecial(pfn_pte(page_to_pfn(kpage), vma->vm_page_prot)));
-		ksm_map_zero_page(mm);
-		/*
-		 * We're replacing an anonymous page with a zero page, which is
-		 * not anonymous. We need to do proper accounting otherwise we
-		 * will get wrong values in /proc, and a BUG message in dmesg
-		 * when tearing down the mm.
-		 */
-		dec_mm_counter(mm, MM_ANONPAGES);
-	}
-
-	flush_cache_page(vma, addr, pte_pfn(ptep_get(ptep)));
-	/*
-	 * No need to notify as we are replacing a read only page with another
-	 * read only page with the same content.
-	 *
-	 * See Documentation/mm/mmu_notifier.rst
-	 */
-	ptep_clear_flush(vma, addr, ptep);
-	set_pte_at(mm, addr, ptep, newpte);
-
-	folio_remove_rmap_pte(folio, page, vma);
-	if (!folio_mapped(folio))
-		folio_free_swap(folio);
-	folio_put(folio);
-
-	pte_unmap_unlock(ptep, ptl);
-	err = 0;
-out_mn:
-	mmu_notifier_invalidate_range_end(&range);
-out:
-	return err;
-}
-
 /*
  * try_to_merge_one_page - take two pages and merge them into one
  * @vma: the vma that holds the pte pointing to page
diff --git a/mm/madvise.c b/mm/madvise.c
index 0ceae57da7da..d9d678053ca2 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -22,6 +22,7 @@
 #include <linux/string.h>
 #include <linux/uio.h>
 #include <linux/ksm.h>
+#include <linux/sksm.h>
 #include <linux/fs.h>
 #include <linux/file.h>
 #include <linux/blkdev.h>
@@ -1318,6 +1319,8 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
 		return madvise_guard_install(vma, prev, start, end);
 	case MADV_GUARD_REMOVE:
 		return madvise_guard_remove(vma, prev, start, end);
+	case MADV_MERGE:
+		return sksm_merge(vma, start, end);
 	}
 
 	anon_name = anon_vma_name(vma);
@@ -1422,6 +1425,9 @@ madvise_behavior_valid(int behavior)
 #ifdef CONFIG_MEMORY_FAILURE
 	case MADV_SOFT_OFFLINE:
 	case MADV_HWPOISON:
+#endif
+#ifdef CONFIG_SKSM
+	case MADV_MERGE:
 #endif
 		return true;
 
diff --git a/mm/memory.c b/mm/memory.c
index 398c031be9ba..782363315b31 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3618,6 +3618,8 @@ static bool wp_can_reuse_anon_folio(struct folio *folio,
 	 */
 	if (folio_test_ksm(folio) || folio_ref_count(folio) > 3)
 		return false;
+	if (folio_test_sksm(folio))
+		return false;
 	if (!folio_test_lru(folio))
 		/*
 		 * We cannot easily detect+handle references from
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 01eab25edf89..0bb9755896ce 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1122,6 +1122,7 @@ __always_inline bool free_pages_prepare(struct page *page,
 			return false;
 	}
 
+	sksm_page_remove(page);
 	page_cpupid_reset_last(page);
 	page->flags &= ~PAGE_FLAGS_CHECK_AT_PREP;
 	reset_page_owner(page, order);
@@ -1509,6 +1510,8 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 
 	set_page_private(page, 0);
 	set_page_refcounted(page);
+	set_page_checksum(page, 0);
+	init_page_sksm_node(page);
 
 	arch_alloc_page(page, order);
 	debug_pagealloc_map_pages(page, 1 << order);
diff --git a/mm/sksm.c b/mm/sksm.c
new file mode 100644
index 000000000000..190f6bc05f2d
--- /dev/null
+++ b/mm/sksm.c
@@ -0,0 +1,190 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Synchronous memory merging support.
+ *
+ * This code enables synchronous dynamic sharing of identical pages
+ * found in different memory areas, even if they are not shared by
+ * fork().
+ *
+ * Userspace must explicitly request for pages within specific address
+ * ranges to be merged with madvise MADV_MERGE. Those should *not*
+ * contain secrets, as side-channel timing attacks can allow a process
+ * to learn the existence of a known content within another process.
+ *
+ * The synchronous memory merging performs the memory merging
+ * synchronously within madvise. There is no global scan and no need
+ * for background daemon.
+ *
+ * The anonymous pages targeted for merge are write-protected and
+ * checksummed. They are then compared to other pages targeted for
+ * merge.
+ *
+ * The mergeable pages are added to a hash table indexed by checksum of
+ * their content. The hash value is derived from the page content
+ * checksum, and its comparison function is based on comparison of
+ * the page content.
+ *
+ * If a page is written to after being targeted for merge, a COW will be
+ * triggered, and thus a new page will be populated in its stead.
+ *
+ * The typical usage pattern expected from userspace is:
+ *
+ * 1) Userspace writes non-secret content to a MAP_PRIVATE page, thus
+ *    triggering COW.
+ *
+ * 2) After userspace has completed writing to the page, it issues
+ *    madvise MADV_MERGE on a range containing the page, which
+ *    write-protect, checksum, and add the page to the sksm hash
+ *    table. It then merges this page with other mergeable pages
+ *    that have the same content.
+ *
+ * 3) It is typically expected that this page's content stays invariant
+ *    for a long time. If userspace issues writes to the page after
+ *    madvise MADV_MERGE, another COW will be triggered, which will
+ *    populate a new page copy into the process page table and release
+ *    the reference to the old page.
+ */
+
+#include <linux/mutex.h>
+#include <linux/cleanup.h>
+#include <linux/mm_types.h>
+#include <linux/hashtable.h>
+#include <linux/highmem.h>
+#include <linux/xxhash.h>
+#include <linux/rmap.h>
+#include <linux/mm.h>
+#include <linux/pagewalk.h>
+#include <linux/sksm.h>
+#include <linux/swap.h>
+#include <linux/mm_inline.h>
+
+#include "internal.h"
+#include "ksm-common.h"
+
+#define SKSM_HT_BITS	16
+
+static DEFINE_MUTEX(sksm_lock);
+
+/*
+ * The hash is derived from the page checksum.
+ */
+static DEFINE_HASHTABLE(sksm_ht, SKSM_HT_BITS);
+
+void __sksm_page_remove(struct page *page)
+{
+	guard(mutex)(&sksm_lock);
+	hash_del(&page->sksm_node);
+}
+
+static int sksm_merge_page(struct vm_area_struct *vma, struct page *page)
+{
+	struct folio *folio = page_folio(page);
+	pte_t orig_pte = __pte(0);
+	struct page *kpage;
+	int err = 0;
+
+	folio_lock(folio);
+
+	if (folio_test_large(folio)) {
+		if (split_huge_page(page))
+			goto out_unlock;
+		folio = page_folio(page);
+	}
+
+	/* Write protect page. */
+	if (write_protect_page(vma, folio, &orig_pte) != 0)
+		goto out_unlock;
+
+	/* Checksum page. */
+	page->checksum = calc_checksum(page);
+
+	guard(mutex)(&sksm_lock);
+
+	/* Merge page with duplicates. */
+	hash_for_each_possible(sksm_ht, kpage, sksm_node, page->checksum) {
+		if (page->checksum != kpage->checksum || !pages_identical(page, kpage))
+			continue;
+		if (!get_page_unless_zero(kpage))
+			continue;
+		err = replace_page(vma, page, kpage, orig_pte);
+		put_page(kpage);
+		if (!err)
+			goto out_unlock;
+	}
+
+	/*
+	 * This page is not linked to its address_space anymore because it
+	 * can be shared with other processes and replace pages originally
+	 * associated with other address spaces.
+	 */
+	page->mapping = (void *) PAGE_MAPPING_ANON;
+
+	/* Add page to hash table. */
+	hash_add(sksm_ht, &page->sksm_node, page->checksum);
+out_unlock:
+	folio_unlock(folio);
+	return err;
+}
+
+static struct page *get_vma_page_from_addr(struct vm_area_struct *vma, unsigned long addr)
+{
+	struct page *page = NULL;
+	struct folio_walk fw;
+	struct folio *folio;
+
+	folio = folio_walk_start(&fw, vma, addr, 0);
+	if (folio) {
+		if (!folio_is_zone_device(folio) &&
+		    folio_test_anon(folio)) {
+			folio_get(folio);
+			page = fw.page;
+		}
+		folio_walk_end(&fw, vma);
+	}
+	if (page) {
+		flush_anon_page(vma, page, addr);
+		flush_dcache_page(page);
+	}
+	return page;
+}
+
+/* Called with mmap write lock held. */
+int sksm_merge(struct vm_area_struct *vma, unsigned long start,
+	       unsigned long end)
+{
+	unsigned long addr;
+	int err = 0;
+
+	if (!PAGE_ALIGNED(start) || !PAGE_ALIGNED(end))
+		return -EINVAL;
+	if (!vma_ksm_compatible(vma))
+		return 0;
+
+	/*
+	 * A number of pages can hang around indefinitely in per-cpu
+	 * LRU cache, raised page count preventing write_protect_page
+	 * from merging them.
+	 */
+	lru_add_drain_all();
+
+	for (addr = start; addr < end && !err; addr += PAGE_SIZE) {
+		struct page *page = get_vma_page_from_addr(vma, addr);
+
+		if (!page)
+			continue;
+		err = sksm_merge_page(vma, page);
+		put_page(page);
+	}
+	return err;
+}
+
+static int __init sksm_init(void)
+{
+	struct page *zero_page = ZERO_PAGE(0);
+
+	zero_page->checksum = calc_checksum(zero_page);
+	/* Add page to hash table. */
+	hash_add(sksm_ht, &zero_page->sksm_node, zero_page->checksum);
+	return 0;
+}
+subsys_initcall(sksm_init);
-- 
2.39.5


