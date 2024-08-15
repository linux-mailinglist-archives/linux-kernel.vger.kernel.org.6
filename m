Return-Path: <linux-kernel+bounces-287898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30379952DDC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54CAB1C22E3B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 12:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A34A0176AC6;
	Thu, 15 Aug 2024 12:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="d5GSPwm8"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0271AC8A2
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 12:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723723661; cv=none; b=Kz3nT4ZnXgv/DkvJwclWigRKL6CNKUCy6h7lTm30WzZ6LF+nwECV+vga1nCqHvXwsi0iDJhtlD6NfP4BK1/j1dJlPqfZFEUpc/lvOxb9m0I26VNzMVWMVYY7MAIqLu+ztugK3xPFGRtwKA6XpUah3hJmAMMdLS0ebdRGasqL8G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723723661; c=relaxed/simple;
	bh=qOqZKFf3y6u/EAyGcj4flRMfad/hXpjlmzv4VQ0HRDs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=snYxjWULxxb6jdlHU0kX6QZrRYC51M6GGJfhjSAKX7SGCxZTvrhjGymf3FBGSAZdSbUaLZpSMwLGG0MWLCF3bN+sjm+l9wVwGJeAh5TYWKyX6+NRpsnRQi8/lwa18iuEdCVD1kDf3d6744+ezBKiQpcXFPeolxVQz3eyyI3+k0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=d5GSPwm8; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-78f86e56b4cso92434a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 05:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723723658; x=1724328458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L7a//F/n55DF+ji90k6iCPOdVshlEXnCZnjGhcClLNw=;
        b=d5GSPwm8Iy03XuQRIMzrM7KtBtskUAy7dqSNFfv1IwNnk754oVeQHjyVXJ98qM7qC3
         XeCsx5FAyfRf1R6VSevyRJg1ahmLy6okeoxFsKI1oRdAt4retdg1Tll084F+Mo0GLBsj
         hXPo6xWYm0mWUzbDYBCE1y81VFt1y9ZcqplwJG7HoOG66OJ2cCjpTDFmTxKXKlQkDEab
         +FHphMTt4DUpM9Lx2KDxGd0qVdX43e+QT+ZrnwJvKSJvfs3iip/+hyHs261zdqPoJXkV
         97fzQjxaE9t/4CFIy+gktU343JbbWU2Xs/djX1M9aZGOUDQxiLpaE1fSmVob49YV1RVk
         e6dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723723658; x=1724328458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L7a//F/n55DF+ji90k6iCPOdVshlEXnCZnjGhcClLNw=;
        b=Bm7phFDQtUjyy3BynZ1CHOh4amSm4GsAvTB/Fmi+8tC/ZgMMCorXQEwPSjnmpecjBc
         C8slpXGBCwbawJ6uU784+yyZm/4/VKxuZ7f1JHbQSWrlp4Z7y96YMcCUIfyXeJHjYjIX
         9PFOn5cf41fXvyaCkplAkCCA7b6GpvWWyKYam2Jrm7KhTvdLFVAjmRuuTcHLX1Eae2Nv
         1La+LpUBXQjT3I3Kn2yqZSyaav4pacznLsocn7s+LQTZdLbqTZQ6znUcnmMH/CI14onK
         GR1U8oBQCGlhrBd5yjeLxqk5KtFmiUmAdfU3RpbhrGOCOk9gCR3Tf+0XF9Mf3O1DCVlX
         Ghsw==
X-Forwarded-Encrypted: i=1; AJvYcCUYq8VwvSyNOiF7pmhEDBXwmIdZhAw/ZfMaIS2QlOaoiMLCdCHxsERAEPhQGWdEM20IcK/LE9157apLdks=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfFkb/0DX+jzaq1hGpv5M4eH2rbZ7eAGP+c4R34/E9SsgRyxYC
	wKqHVzfJtxoC8mpOVDMmolU18Wlq4UeDMXbdENe5agPdMxT4/PkhS1jIsenUXXc=
X-Google-Smtp-Source: AGHT+IEuRKwvUl/1iU8m/qAmuebT6iYnhpIALd3qCECgFAD0Ihnkghykkuo0zLxpdKKtzKznQe/WeQ==
X-Received: by 2002:a05:6a20:8416:b0:1c4:c4cc:fa49 with SMTP id adf61e73a8af0-1c8fa0a610dmr2012436637.7.1723723658344;
        Thu, 15 Aug 2024 05:07:38 -0700 (PDT)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af19098sm876354b3a.168.2024.08.15.05.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 05:07:37 -0700 (PDT)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: david@redhat.com,
	hughd@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	akpm@linux-foundation.org,
	ying.huang@intel.com,
	mgorman@techsingularity.net
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [RFC PATCH] mm: fix missing TLB flushing
Date: Thu, 15 Aug 2024 20:07:15 +0800
Message-Id: <20240815120715.14516-1-zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In madvise(MADV_DONTNEED) case, we use mmu_gather to batch flush TLB and
free pages, and the TLB is not flushed before PTL is unlocked. This may
result in the following two situations:

1) For the same virtual address, huge size and small size TLBs coexist:

	CPU 0				CPU 1
	-----				-----

zap_huge_pmd()
--> pmdp_huge_get_and_clear_full()
    spin_unlock()
				page fault
				--> pte_alloc
                                    --> pmd_lock()
				        pmd_populate()
				        spin_unlock()
				    pte_offset_map_lock()
				    set_ptes()
    mmu_gather flush tlb

2) For the same virtual address, TLBs of the same size but mapping
different physical addresses coexist:

	CPU 0				CPU 1
	-----				-----

zap_pte_range()
--> clear pte entry
    pte_unmap_unlock()
				page fault
				--> pte_offset_map_lock()
				    set_ptes()
    mmu_gather flush tlb

For case 1), according to Intel's TLB Application note (317080), some CPUs
of x86 do not allow it:

```
If software modifies the paging structures so that the page size used for
a 4-KByte range of linear addresses changes, the TLBs may subsequently
contain both ordinary and large-page translations for the address range.12
A reference to a linear address in the address range may use either
translation. Which of the two translations is used may vary from one
execution to another and the choice may be implementation-specific.

Software wishing to prevent this uncertainty should not write to a paging-
structure entry in a way that would change, for any linear address, both
the page size and either the page frame or attributes. It can instead use
the following algorithm: first mark the relevant paging-structure entry
(e.g., PDE) not present; then invalidate any translations for the affected
linear addresses (see Section 5.2); and then modify the relevant
paging-structure entry to mark it present and establish translation(s) for
the new page size.
```

And the BBM (Break Before Make) method of arm also does not allow the
above situation to occur.

We can also learn more information from the comments above
pmdp_invalidate() in __split_huge_pmd_locked().

For case 2), we can see from the comments above ptep_clear_flush() in
wp_page_copy() that this situation is also not allowed.

However, I am not sure about the specific impact of the above issues,
which needs to be confirmed by people related to each architecture.

To fix the above issues, this commit chooses to use mm->tlb_flush_pending
to detect the above two situations in page fault path. If detected, flush
the corresponding TLB before setting the page table entry.

Considering that the above issues are not caused by a regular user-mode
usage (it should hold a lock to prevent madvise(MADV_DONTNEED) and
touching concurrency), this commit does not define a function for
architecture implementation, but instead flushes the TLB uniformly.

Possible future optimization: define a new field in vma to replace
mm->tlb_flush_pending for detection, which can reduce unnecessary TLB
flushing.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/hugetlb.h   |  2 +-
 include/linux/mm.h        |  9 +++++----
 include/linux/mm_inline.h |  8 ++++++++
 mm/debug_vm_pgtable.c     |  2 +-
 mm/filemap.c              |  2 +-
 mm/gup.c                  |  2 +-
 mm/huge_memory.c          |  3 +++
 mm/internal.h             |  3 ++-
 mm/memory.c               | 16 +++++++++-------
 mm/migrate_device.c       |  2 +-
 mm/mprotect.c             |  8 ++++----
 mm/mremap.c               |  2 +-
 mm/userfaultfd.c          |  6 +++---
 13 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 3100a52ceb735..8754469a96d67 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -189,7 +189,7 @@ static inline pte_t *pte_offset_huge(pmd_t *pmd, unsigned long address)
 static inline pte_t *pte_alloc_huge(struct mm_struct *mm, pmd_t *pmd,
 				    unsigned long address)
 {
-	return pte_alloc(mm, pmd) ? NULL : pte_offset_huge(pmd, address);
+	return pte_alloc(mm, pmd, address) ? NULL : pte_offset_huge(pmd, address);
 }
 #endif
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index b1eed30fdc06b..15455af2d0dba 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2758,7 +2758,7 @@ static inline void mm_inc_nr_ptes(struct mm_struct *mm) {}
 static inline void mm_dec_nr_ptes(struct mm_struct *mm) {}
 #endif
 
-int __pte_alloc(struct mm_struct *mm, pmd_t *pmd);
+int __pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long addr);
 int __pte_alloc_kernel(pmd_t *pmd);
 
 #if defined(CONFIG_MMU)
@@ -2956,13 +2956,14 @@ pte_t *pte_offset_map_nolock(struct mm_struct *mm, pmd_t *pmd,
 	pte_unmap(pte);					\
 } while (0)
 
-#define pte_alloc(mm, pmd) (unlikely(pmd_none(*(pmd))) && __pte_alloc(mm, pmd))
+#define pte_alloc(mm, pmd, addr)			\
+	(unlikely(pmd_none(*(pmd))) && __pte_alloc(mm, pmd, addr))
 
 #define pte_alloc_map(mm, pmd, address)			\
-	(pte_alloc(mm, pmd) ? NULL : pte_offset_map(pmd, address))
+	(pte_alloc(mm, pmd, address) ? NULL : pte_offset_map(pmd, address))
 
 #define pte_alloc_map_lock(mm, pmd, address, ptlp)	\
-	(pte_alloc(mm, pmd) ?			\
+	(pte_alloc(mm, pmd, address) ?			\
 		 NULL : pte_offset_map_lock(mm, pmd, address, ptlp))
 
 #define pte_alloc_kernel(pmd, address)			\
diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index f4fe593c1400e..7fe2384effbfa 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -510,6 +510,14 @@ static inline bool mm_tlb_flush_nested(struct mm_struct *mm)
 	return atomic_read(&mm->tlb_flush_pending) > 1;
 }
 
+static inline void cond_flush_tlb_mm_range(struct mm_struct *mm,
+					   unsigned long start,
+					   unsigned long end)
+{
+	if (atomic_read(&mm->tlb_flush_pending))
+		flush_tlb_mm_range(mm, start, end, PAGE_SHIFT, false);
+}
+
 #ifdef CONFIG_MMU
 /*
  * Computes the pte marker to copy from the given source entry into dst_vma.
diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index e4969fb54da34..18375744e1845 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -1246,7 +1246,7 @@ static int __init init_args(struct pgtable_debug_args *args)
 	args->start_pmdp = pmd_offset(args->pudp, 0UL);
 	WARN_ON(!args->start_pmdp);
 
-	if (pte_alloc(args->mm, args->pmdp)) {
+	if (pte_alloc(args->mm, args->pmdp, args->vaddr)) {
 		pr_err("Failed to allocate pte entries\n");
 		ret = -ENOMEM;
 		goto error;
diff --git a/mm/filemap.c b/mm/filemap.c
index e47001527f193..cdbdd7c5d64b4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3449,7 +3449,7 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct folio *folio,
 	}
 
 	if (pmd_none(*vmf->pmd) && vmf->prealloc_pte)
-		pmd_install(mm, vmf->pmd, &vmf->prealloc_pte);
+		pmd_install(mm, vmf->pmd, vmf->address, &vmf->prealloc_pte);
 
 	return false;
 }
diff --git a/mm/gup.c b/mm/gup.c
index d19884e097fd2..53c3b73810150 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -972,7 +972,7 @@ static struct page *follow_pmd_mask(struct vm_area_struct *vma,
 		spin_unlock(ptl);
 		split_huge_pmd(vma, pmd, address);
 		/* If pmd was left empty, stuff a page table in there quickly */
-		return pte_alloc(mm, pmd) ? ERR_PTR(-ENOMEM) :
+		return pte_alloc(mm, pmd, address) ? ERR_PTR(-ENOMEM) :
 			follow_page_pte(vma, address, pmd, flags, &ctx->pgmap);
 	}
 	page = follow_huge_pmd(vma, address, pmd, flags, ctx);
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d90d6e94a8003..460f3b5e36daf 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1083,6 +1083,7 @@ static vm_fault_t __do_huge_pmd_anonymous_page(struct vm_fault *vmf,
 		folio_add_new_anon_rmap(folio, vma, haddr, RMAP_EXCLUSIVE);
 		folio_add_lru_vma(folio, vma);
 		pgtable_trans_huge_deposit(vma->vm_mm, vmf->pmd, pgtable);
+		cond_flush_tlb_mm_range(vma->vm_mm, haddr, haddr + PMD_SIZE);
 		set_pmd_at(vma->vm_mm, haddr, vmf->pmd, entry);
 		update_mmu_cache_pmd(vma, vmf->address, vmf->pmd);
 		add_mm_counter(vma->vm_mm, MM_ANONPAGES, HPAGE_PMD_NR);
@@ -1150,6 +1151,7 @@ static void set_huge_zero_folio(pgtable_t pgtable, struct mm_struct *mm,
 	entry = mk_pmd(&zero_folio->page, vma->vm_page_prot);
 	entry = pmd_mkhuge(entry);
 	pgtable_trans_huge_deposit(mm, pmd, pgtable);
+	cond_flush_tlb_mm_range(mm, haddr, haddr + PMD_SIZE);
 	set_pmd_at(mm, haddr, pmd, entry);
 	mm_inc_nr_ptes(mm);
 }
@@ -1257,6 +1259,7 @@ static void insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
 		pgtable = NULL;
 	}
 
+	cond_flush_tlb_mm_range(mm, addr, addr + PMD_SIZE);
 	set_pmd_at(mm, addr, pmd, entry);
 	update_mmu_cache_pmd(vma, addr, pmd);
 
diff --git a/mm/internal.h b/mm/internal.h
index acda347620c6a..321b06f41a1f4 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -325,7 +325,8 @@ void folio_activate(struct folio *folio);
 void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 		   struct vm_area_struct *start_vma, unsigned long floor,
 		   unsigned long ceiling, bool mm_wr_locked);
-void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
+void pmd_install(struct mm_struct *mm, pmd_t *pmd, unsigned long addr,
+		 pgtable_t *pte);
 
 struct zap_details;
 void unmap_page_range(struct mmu_gather *tlb,
diff --git a/mm/memory.c b/mm/memory.c
index 13b679ad182c8..aa6777ce0506d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -417,11 +417,13 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
 	} while (vma);
 }
 
-void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
+void pmd_install(struct mm_struct *mm, pmd_t *pmd, unsigned long addr,
+		 pgtable_t *pte)
 {
 	spinlock_t *ptl = pmd_lock(mm, pmd);
 
 	if (likely(pmd_none(*pmd))) {	/* Has another populated it ? */
+		cond_flush_tlb_mm_range(mm, addr, addr + PAGE_SIZE);
 		mm_inc_nr_ptes(mm);
 		/*
 		 * Ensure all pte setup (eg. pte page lock and page clearing) are
@@ -443,13 +445,13 @@ void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte)
 	spin_unlock(ptl);
 }
 
-int __pte_alloc(struct mm_struct *mm, pmd_t *pmd)
+int __pte_alloc(struct mm_struct *mm, pmd_t *pmd, unsigned long addr)
 {
 	pgtable_t new = pte_alloc_one(mm);
 	if (!new)
 		return -ENOMEM;
 
-	pmd_install(mm, pmd, &new);
+	pmd_install(mm, pmd, addr, &new);
 	if (new)
 		pte_free(mm, new);
 	return 0;
@@ -2115,7 +2117,7 @@ static int insert_pages(struct vm_area_struct *vma, unsigned long addr,
 
 	/* Allocate the PTE if necessary; takes PMD lock once only. */
 	ret = -ENOMEM;
-	if (pte_alloc(mm, pmd))
+	if (pte_alloc(mm, pmd, addr))
 		goto out;
 
 	while (pages_to_write_in_pmd) {
@@ -4684,7 +4686,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	 * Use pte_alloc() instead of pte_alloc_map(), so that OOM can
 	 * be distinguished from a transient failure of pte_offset_map().
 	 */
-	if (pte_alloc(vma->vm_mm, vmf->pmd))
+	if (pte_alloc(vma->vm_mm, vmf->pmd, vmf->address))
 		return VM_FAULT_OOM;
 
 	/* Use the zero-page for reads */
@@ -5029,8 +5031,8 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
 		}
 
 		if (vmf->prealloc_pte)
-			pmd_install(vma->vm_mm, vmf->pmd, &vmf->prealloc_pte);
-		else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd)))
+			pmd_install(vma->vm_mm, vmf->pmd, vmf->address, &vmf->prealloc_pte);
+		else if (unlikely(pte_alloc(vma->vm_mm, vmf->pmd, vmf->address)))
 			return VM_FAULT_OOM;
 	}
 
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 6d66dc1c6ffa0..e4d2e19e6611d 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -598,7 +598,7 @@ static void migrate_vma_insert_page(struct migrate_vma *migrate,
 		goto abort;
 	if (pmd_trans_huge(*pmdp) || pmd_devmap(*pmdp))
 		goto abort;
-	if (pte_alloc(mm, pmdp))
+	if (pte_alloc(mm, pmdp, addr))
 		goto abort;
 	if (unlikely(anon_vma_prepare(vma)))
 		goto abort;
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 446f8e5f10d98..67548db13169e 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -330,11 +330,11 @@ pgtable_populate_needed(struct vm_area_struct *vma, unsigned long cp_flags)
  * allocation failures during page faults by kicking OOM and returning
  * error.
  */
-#define  change_pmd_prepare(vma, pmd, cp_flags)				\
+#define  change_pmd_prepare(vma, pmd, addr, cp_flags)			\
 	({								\
 		long err = 0;						\
 		if (unlikely(pgtable_populate_needed(vma, cp_flags))) {	\
-			if (pte_alloc(vma->vm_mm, pmd))			\
+			if (pte_alloc(vma->vm_mm, pmd, addr))		\
 				err = -ENOMEM;				\
 		}							\
 		err;							\
@@ -372,7 +372,7 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 again:
 		next = pmd_addr_end(addr, end);
 
-		ret = change_pmd_prepare(vma, pmd, cp_flags);
+		ret = change_pmd_prepare(vma, pmd, addr, cp_flags);
 		if (ret) {
 			pages = ret;
 			break;
@@ -391,7 +391,7 @@ static inline long change_pmd_range(struct mmu_gather *tlb,
 				 * cleared; make sure pmd populated if
 				 * necessary, then fall-through to pte level.
 				 */
-				ret = change_pmd_prepare(vma, pmd, cp_flags);
+				ret = change_pmd_prepare(vma, pmd, addr, cp_flags);
 				if (ret) {
 					pages = ret;
 					break;
diff --git a/mm/mremap.c b/mm/mremap.c
index e7ae140fc6409..1afbf60802540 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -628,7 +628,7 @@ unsigned long move_page_tables(struct vm_area_struct *vma,
 		}
 		if (pmd_none(*old_pmd))
 			continue;
-		if (pte_alloc(new_vma->vm_mm, new_pmd))
+		if (pte_alloc(new_vma->vm_mm, new_pmd, new_addr))
 			break;
 		if (move_ptes(vma, old_pmd, old_addr, old_addr + extent,
 			      new_vma, new_pmd, new_addr, need_rmap_locks) < 0)
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 966e6c81a685d..ebbe9fbe75d70 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -796,7 +796,7 @@ static __always_inline ssize_t mfill_atomic(struct userfaultfd_ctx *ctx,
 			break;
 		}
 		if (unlikely(pmd_none(dst_pmdval)) &&
-		    unlikely(__pte_alloc(dst_mm, dst_pmd))) {
+		    unlikely(__pte_alloc(dst_mm, dst_pmd, dst_addr))) {
 			err = -ENOMEM;
 			break;
 		}
@@ -1713,13 +1713,13 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 					err = -ENOENT;
 					break;
 				}
-				if (unlikely(__pte_alloc(mm, src_pmd))) {
+				if (unlikely(__pte_alloc(mm, src_pmd, src_addr))) {
 					err = -ENOMEM;
 					break;
 				}
 			}
 
-			if (unlikely(pte_alloc(mm, dst_pmd))) {
+			if (unlikely(pte_alloc(mm, dst_pmd, dst_addr))) {
 				err = -ENOMEM;
 				break;
 			}
-- 
2.20.1


