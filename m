Return-Path: <linux-kernel+bounces-272716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3FDF946032
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70F01C22224
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE84175D36;
	Fri,  2 Aug 2024 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Q8X1X+wF"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DE5175D3F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611861; cv=none; b=ZWKe3a8xPdMCYN2kYii+Yans+mPWytkxeb/y2Hc5MiLjXoBZTu36xdepgst8ohjct20Imbi3kwyCe4fZcKLZ7JgarITdl/YjMO4/3F5lQaFnBFMa6kDgIE2ZSEpA4lIUVJFaLpidO71kroiAAgVDmD+E/+vww8+BSY3WmfzrYJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611861; c=relaxed/simple;
	bh=xoDHgmM3tktp4Nf2WZ2ltPB+uSObC9re3iOBE5LBJ8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q1FCBQtg80U8G3Exu391DVLWWJHlkHQqrzlStD+/95Op/Yh71lD/xs+BDphYPvTtJN3aW/nqT+gCSCmTy2qj3x2qzDmbmXq4n1QPZF/peI3GEbkDxdadtcd2/SAPjrcfnwGXK7NSqqP5IJZ64DENnW+/iSOonq+Vg5aCP0qLd3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Q8X1X+wF; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4281ca54fd3so47117055e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 08:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722611858; x=1723216658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBx7bwwM+VNLmAljCjIgeC8HmfBD2FAmTGPMtsL/Kbc=;
        b=Q8X1X+wFQTyie0Fc00u7CSfpcYNLoDFSqy2u1eMFq2FY7YmUtFGCxBKPxp04riSdQd
         qupWkwKaso9xZLcLdGChXq+ncCjAyuNe7AdHpz9urpnN9dxu3TPQcOk7aqYn+ad+uhYr
         0h6bnyOmIw9ZN1dHoslghwrPMyjNXEYmL9VWVuvm7jZww/Od9z07AIvwEakFijtBzzx9
         PlbJZPlHAvkGMDJiNfGpxOdX7sg1q9/8qvWhQab9IH1Y89zl3w7GMbAVsbOK3w5gaTCR
         0USmHaeBQL2l2ZcGJdNR9AXOeEfsS+3A4e+IfppdTAHBpLMeKCW9yL3U74G3d8CgyC5e
         eSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722611858; x=1723216658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BBx7bwwM+VNLmAljCjIgeC8HmfBD2FAmTGPMtsL/Kbc=;
        b=XpsQ80C/RhduBa3xjwDQQku7Hi1tdJkfD8SlcDEWEfYFp0zqFjXdxbVDz0UKNFtjZS
         ylFqJSxGzwpESy+L6EKQKe0V4mEjkE76Q6fCV6U+vhlpPcdKkJoWdG811F7aUSS7RdGL
         M5kCkIyZYW1KZlyiEubYpg9oJNv5upzvE1jyXWse35HILlMnKrP+Vdw0WcxtzNWDXm4t
         d/i4czorekrGJWw52d2hMnMiy7WQhyMqSDQRQkRThRSBYWnxoSSkenSlXXz7s/y+qeep
         GosK00mJ+ChV4GsULaTMFgdw++LzU0LpBrMeUDXaczph2HEQPpFkW1a+HcU5J2Tz5LOL
         rrFg==
X-Forwarded-Encrypted: i=1; AJvYcCVj5ly1l78co9UkVMAOw9H17/8SGlpRCWBWC5FaInvNvUMmElxdgntoZ9/xRBGMvMjFp27+B2CqExEZVP2q8X8JoN/CTzWZ6RGRg44Y
X-Gm-Message-State: AOJu0Yxw6VwdFa2D4swJh4zGMRSr8YjkPJ+EgxPFIGzhX/gGj5cmEzel
	+rndA56r+2bzm/sQ6qqoAutcT+lGG+4NZxmVqWBuZTc5CBBWXIbmgh7pgQRRwoM=
X-Google-Smtp-Source: AGHT+IHprdXLf73S6/uvgO6HKNUd/CeSHOZgyKoYo8w2u87HFzJ7dB7zNCokVnrDRI5tmninu2XIMA==
X-Received: by 2002:a05:600c:45cd:b0:426:66e9:b844 with SMTP id 5b1f17b1804b1-428e6aeb0b3mr30207865e9.8.1722611857423;
        Fri, 02 Aug 2024 08:17:37 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6d6b8d9sm36362165e9.7.2024.08.02.08.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 08:17:37 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-mm@kvack.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v3 3/9] mm: Use common huge_ptep_get() function for riscv/arm64
Date: Fri,  2 Aug 2024 17:14:24 +0200
Message-Id: <20240802151430.99114-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240802151430.99114-1-alexghiti@rivosinc.com>
References: <20240802151430.99114-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After some adjustments, both architectures have the same implementation
so move it to the generic code.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/hugetlb.h |  3 +-
 arch/arm64/include/asm/pgtable.h | 48 +++++++++++++++++++++++++---
 arch/arm64/mm/hugetlbpage.c      | 55 ++------------------------------
 arch/riscv/Kconfig               |  1 +
 arch/riscv/include/asm/hugetlb.h |  6 ++--
 arch/riscv/include/asm/pgtable.h | 36 +++++++++++++++++++++
 arch/riscv/mm/hugetlbpage.c      | 45 ++++++--------------------
 include/linux/hugetlb_contpte.h  | 12 +++++++
 mm/Kconfig                       |  3 ++
 mm/Makefile                      |  1 +
 mm/hugetlb_contpte.c             | 44 +++++++++++++++++++++++++
 12 files changed, 157 insertions(+), 98 deletions(-)
 create mode 100644 include/linux/hugetlb_contpte.h
 create mode 100644 mm/hugetlb_contpte.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b3fc891f1544..0a524959804a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -104,6 +104,7 @@ config ARM64
 	select ARCH_WANT_DEFAULT_BPF_JIT
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 	select ARCH_WANT_FRAME_POINTERS
+	select ARCH_WANT_GENERAL_HUGETLB_CONTPTE
 	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_EXECMEM_LATE if EXECMEM
diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 293f880865e8..80d25b4eff25 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -12,6 +12,7 @@
 
 #include <asm/cacheflush.h>
 #include <asm/page.h>
+#include <linux/hugetlb_contpte.h>
 
 #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
 #define arch_hugetlb_migration_supported arch_hugetlb_migration_supported
@@ -45,8 +46,6 @@ extern pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 #define __HAVE_ARCH_HUGE_PTE_CLEAR
 extern void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 			   pte_t *ptep, unsigned long sz);
-#define __HAVE_ARCH_HUGE_PTEP_GET
-extern pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
 
 void __init arm64_hugetlb_cma_reserve(void);
 
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 7a4f5604be3f..2a6a01b447df 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -397,9 +397,10 @@ static inline pte_t pte_advance_pfn(pte_t pte, unsigned long nr)
 	return pfn_pte(pte_pfn(pte) + nr, pte_pgprot(pte));
 }
 
-static inline void __set_ptes(struct mm_struct *mm,
-			      unsigned long __always_unused addr,
-			      pte_t *ptep, pte_t pte, unsigned int nr)
+static inline void ___set_ptes(struct mm_struct *mm,
+			       unsigned long __always_unused addr,
+			       pte_t *ptep, pte_t pte, unsigned int nr,
+			       size_t pgsize)
 {
 	page_table_check_ptes_set(mm, ptep, pte, nr);
 	__sync_cache_and_tags(pte, nr);
@@ -410,10 +411,15 @@ static inline void __set_ptes(struct mm_struct *mm,
 		if (--nr == 0)
 			break;
 		ptep++;
-		pte = pte_advance_pfn(pte, 1);
+		pte = pte_advance_pfn(pte, pgsize >> PAGE_SHIFT);
 	}
 }
 
+#define __set_ptes(mm, addr, ptep, pte, nr)				\
+			___set_ptes(mm, addr, ptep, pte, nr, PAGE_SIZE)
+
+#define set_contptes	___set_ptes
+
 /*
  * Huge pte definitions.
  */
@@ -1760,6 +1766,40 @@ static inline void clear_young_dirty_ptes(struct vm_area_struct *vma,
 
 #endif /* CONFIG_ARM64_CONTPTE */
 
+static inline int arch_contpte_get_num_contig(pte_t *ptep,
+					      unsigned long size,
+					      size_t *pgsize)
+{
+	int contig_ptes = 0;
+
+	if (pgsize)
+		*pgsize = size;
+
+	switch (size) {
+#ifndef __PAGETABLE_PMD_FOLDED
+	case PUD_SIZE:
+		if (pud_sect_supported())
+			contig_ptes = 1;
+		break;
+#endif
+	case PMD_SIZE:
+		contig_ptes = 1;
+		break;
+	case CONT_PMD_SIZE:
+		if (pgsize)
+			*pgsize = PMD_SIZE;
+		contig_ptes = CONT_PMDS;
+		break;
+	case CONT_PTE_SIZE:
+		if (pgsize)
+			*pgsize = PAGE_SIZE;
+		contig_ptes = CONT_PTES;
+		break;
+	}
+
+	return contig_ptes;
+}
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_PGTABLE_H */
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 5f1e2103888b..58cb5e06dcb2 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -98,57 +98,6 @@ static int find_num_contig(struct mm_struct *mm, unsigned long addr,
 	return CONT_PTES;
 }
 
-static inline int num_contig_ptes(unsigned long size, size_t *pgsize)
-{
-	int contig_ptes = 0;
-
-	*pgsize = size;
-
-	switch (size) {
-#ifndef __PAGETABLE_PMD_FOLDED
-	case PUD_SIZE:
-		if (pud_sect_supported())
-			contig_ptes = 1;
-		break;
-#endif
-	case PMD_SIZE:
-		contig_ptes = 1;
-		break;
-	case CONT_PMD_SIZE:
-		*pgsize = PMD_SIZE;
-		contig_ptes = CONT_PMDS;
-		break;
-	case CONT_PTE_SIZE:
-		*pgsize = PAGE_SIZE;
-		contig_ptes = CONT_PTES;
-		break;
-	}
-
-	return contig_ptes;
-}
-
-pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
-{
-	int ncontig, i;
-	size_t pgsize;
-	pte_t orig_pte = __ptep_get(ptep);
-
-	if (!pte_present(orig_pte) || !pte_cont(orig_pte))
-		return orig_pte;
-
-	ncontig = num_contig_ptes(page_size(pte_page(orig_pte)), &pgsize);
-	for (i = 0; i < ncontig; i++, ptep++) {
-		pte_t pte = __ptep_get(ptep);
-
-		if (pte_dirty(pte))
-			orig_pte = pte_mkdirty(orig_pte);
-
-		if (pte_young(pte))
-			orig_pte = pte_mkyoung(orig_pte);
-	}
-	return orig_pte;
-}
-
 /*
  * Changing some bits of contiguous entries requires us to follow a
  * Break-Before-Make approach, breaking the whole contiguous set
@@ -229,7 +178,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 	unsigned long pfn, dpfn;
 	pgprot_t hugeprot;
 
-	ncontig = num_contig_ptes(sz, &pgsize);
+	ncontig = arch_contpte_get_num_contig(ptep, sz, &pgsize);
 
 	if (!pte_present(pte)) {
 		for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
@@ -379,7 +328,7 @@ void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 	int i, ncontig;
 	size_t pgsize;
 
-	ncontig = num_contig_ptes(sz, &pgsize);
+	ncontig = arch_contpte_get_num_contig(ptep, sz, &pgsize);
 
 	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
 		__pte_clear(mm, addr, ptep);
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e860f3e8c702..5f6ed3a43aa7 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -73,6 +73,7 @@ config RISCV
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_GENERAL_HUGETLB if !RISCV_ISA_SVNAPOT
+	select ARCH_WANT_GENERAL_HUGETLB_CONTPTE if RISCV_ISA_SVNAPOT
 	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
 	select ARCH_WANT_LD_ORPHAN_WARN if !XIP_KERNEL
 	select ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
diff --git a/arch/riscv/include/asm/hugetlb.h b/arch/riscv/include/asm/hugetlb.h
index faf3624d8057..d9f9bfb84908 100644
--- a/arch/riscv/include/asm/hugetlb.h
+++ b/arch/riscv/include/asm/hugetlb.h
@@ -4,6 +4,9 @@
 
 #include <asm/cacheflush.h>
 #include <asm/page.h>
+#ifdef CONFIG_ARCH_WANT_GENERAL_HUGETLB_CONTPTE
+#include <linux/hugetlb_contpte.h>
+#endif
 
 static inline void arch_clear_hugetlb_flags(struct folio *folio)
 {
@@ -43,9 +46,6 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 			       unsigned long addr, pte_t *ptep,
 			       pte_t pte, int dirty);
 
-#define __HAVE_ARCH_HUGE_PTEP_GET
-pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
-
 pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags);
 #define arch_make_huge_pte arch_make_huge_pte
 
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 34c4c360d4ce..412ccebcdee9 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -300,6 +300,8 @@ static inline unsigned long pte_napot(pte_t pte)
 	return pte_val(pte) & _PAGE_NAPOT;
 }
 
+#define pte_cont		pte_napot
+
 #define pte_valid_napot(pte)	(pte_present(pte) && pte_napot(pte))
 
 static inline pte_t pte_mknapot(pte_t pte, unsigned int order)
@@ -581,6 +583,38 @@ static inline void __set_ptes(struct mm_struct *mm, unsigned long addr,
 	}
 }
 
+#ifdef CONFIG_RISCV_ISA_SVNAPOT
+static inline int arch_contpte_get_num_contig(pte_t *ptep, unsigned long size,
+					      size_t *pgsize)
+{
+	unsigned long hugepage_shift;
+	pte_t __pte;
+
+	if (size >= PGDIR_SIZE)
+		hugepage_shift = PGDIR_SHIFT;
+	else if (size >= P4D_SIZE)
+		hugepage_shift = P4D_SHIFT;
+	else if (size >= PUD_SIZE)
+		hugepage_shift = PUD_SHIFT;
+	else if (size >= PMD_SIZE)
+		hugepage_shift = PMD_SHIFT;
+	else
+		hugepage_shift = PAGE_SHIFT;
+
+	if (pgsize)
+		*pgsize = BIT(hugepage_shift);
+
+	/* We must read the raw value of the pte to get the size of the mapping */
+	__pte = __ptep_get(ptep);
+
+	/* Make sure __pte is not a swap entry */
+	if (pte_valid_napot(__pte))
+		return napot_pte_num(napot_cont_order(__pte));
+
+	return size >> hugepage_shift;
+}
+#endif
+
 static inline void pte_clear(struct mm_struct *mm,
 	unsigned long addr, pte_t *ptep)
 {
@@ -665,6 +699,8 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 	__set_ptes(mm, addr, ptep, pteval, nr);
 }
 #define set_ptes			set_ptes
+#define set_contptes(mm, addr, ptep, pte, nr, pgsize)			\
+			set_ptes(mm, addr, ptep, pte, nr)
 
 static inline pte_t ptep_get(pte_t *ptep)
 {
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index 59ed26ce6857..d51863824540 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -3,30 +3,6 @@
 #include <linux/err.h>
 
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
-pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
-{
-	unsigned long pte_num;
-	int i;
-	pte_t orig_pte = ptep_get(ptep);
-
-	if (!pte_present(orig_pte) || !pte_napot(orig_pte))
-		return orig_pte;
-
-	pte_num = napot_pte_num(napot_cont_order(orig_pte));
-
-	for (i = 0; i < pte_num; i++, ptep++) {
-		pte_t pte = ptep_get(ptep);
-
-		if (pte_dirty(pte))
-			orig_pte = pte_mkdirty(orig_pte);
-
-		if (pte_young(pte))
-			orig_pte = pte_mkyoung(orig_pte);
-	}
-
-	return orig_pte;
-}
-
 pte_t *huge_pte_alloc(struct mm_struct *mm,
 		      struct vm_area_struct *vma,
 		      unsigned long addr,
@@ -266,15 +242,13 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 			       int dirty)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	unsigned long order;
 	pte_t orig_pte;
-	int i, pte_num;
+	int pte_num;
 
 	if (!pte_napot(pte))
 		return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
 
-	order = napot_cont_order(pte);
-	pte_num = napot_pte_num(order);
+	pte_num = arch_contpte_get_num_contig(ptep, 0, NULL);
 	orig_pte = get_clear_contig_flush(mm, addr, ptep, pte_num);
 
 	if (pte_dirty(orig_pte))
@@ -298,7 +272,7 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 	if (!pte_napot(orig_pte))
 		return ptep_get_and_clear(mm, addr, ptep);
 
-	pte_num = napot_pte_num(napot_cont_order(orig_pte));
+	pte_num = arch_contpte_get_num_contig(ptep, 0, NULL);
 
 	return get_clear_contig(mm, addr, ptep, pte_num);
 }
@@ -308,17 +282,15 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 			     pte_t *ptep)
 {
 	pte_t pte = ptep_get(ptep);
-	unsigned long order;
 	pte_t orig_pte;
-	int i, pte_num;
+	int pte_num;
 
 	if (!pte_napot(pte)) {
 		ptep_set_wrprotect(mm, addr, ptep);
 		return;
 	}
 
-	order = napot_cont_order(pte);
-	pte_num = napot_pte_num(order);
+	pte_num = arch_contpte_get_num_contig(ptep, 0, NULL);
 	orig_pte = get_clear_contig_flush(mm, addr, ptep, pte_num);
 
 	orig_pte = pte_wrprotect(orig_pte);
@@ -336,7 +308,7 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 	if (!pte_napot(pte))
 		return ptep_clear_flush(vma, addr, ptep);
 
-	pte_num = napot_pte_num(napot_cont_order(pte));
+	pte_num = arch_contpte_get_num_contig(ptep, 0, NULL);
 
 	return get_clear_contig_flush(vma->vm_mm, addr, ptep, pte_num);
 }
@@ -346,6 +318,7 @@ void huge_pte_clear(struct mm_struct *mm,
 		    pte_t *ptep,
 		    unsigned long sz)
 {
+	size_t pgsize;
 	pte_t pte = ptep_get(ptep);
 	int i, pte_num;
 
@@ -354,8 +327,8 @@ void huge_pte_clear(struct mm_struct *mm,
 		return;
 	}
 
-	pte_num = napot_pte_num(napot_cont_order(pte));
-	for (i = 0; i < pte_num; i++, addr += PAGE_SIZE, ptep++)
+	pte_num = arch_contpte_get_num_contig(ptep, sz, &pgsize);
+	for (i = 0; i < pte_num; i++, addr += pgsize, ptep++)
 		pte_clear(mm, addr, ptep);
 }
 
diff --git a/include/linux/hugetlb_contpte.h b/include/linux/hugetlb_contpte.h
new file mode 100644
index 000000000000..ec4189cd65b8
--- /dev/null
+++ b/include/linux/hugetlb_contpte.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 Rivos Inc.
+ */
+
+#ifndef _LINUX_HUGETLB_CONTPTE_H
+#define _LINUX_HUGETLB_CONTPTE_H
+
+#define __HAVE_ARCH_HUGE_PTEP_GET
+extern pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
+
+#endif /* _LINUX_HUGETLB_CONTPTE_H */
diff --git a/mm/Kconfig b/mm/Kconfig
index b72e7d040f78..0bba50d0639a 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -798,6 +798,9 @@ config NOMMU_INITIAL_TRIM_EXCESS
 config ARCH_WANT_GENERAL_HUGETLB
 	bool
 
+config ARCH_WANT_GENERAL_HUGETLB_CONTPTE
+	bool
+
 config ARCH_WANTS_THP_SWAP
 	def_bool n
 
diff --git a/mm/Makefile b/mm/Makefile
index d2915f8c9dc0..3dd91c4466aa 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -95,6 +95,7 @@ obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_NUMA) += memory-tiers.o
 obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
+obj-$(CONFIG_ARCH_WANT_GENERAL_HUGETLB_CONTPTE) += hugetlb_contpte.o
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
 obj-$(CONFIG_MEMCG_V1) += memcontrol-v1.o
 obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
diff --git a/mm/hugetlb_contpte.c b/mm/hugetlb_contpte.c
new file mode 100644
index 000000000000..0e3ba6f97c58
--- /dev/null
+++ b/mm/hugetlb_contpte.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2024 Rivos Inc.
+ */
+
+#include <linux/pgtable.h>
+#include <linux/mm.h>
+#include <linux/hugetlb.h>
+
+/*
+ * Any arch that wants to use that needs to define:
+ *   - __ptep_get()
+ *   - pte_cont()
+ *   - arch_contpte_get_num_contig()
+ */
+
+/*
+ * This file implements the following contpte aware API:
+ *   - huge_ptep_get()
+ */
+
+pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
+{
+	int ncontig, i;
+	pte_t orig_pte = __ptep_get(ptep);
+
+	if (!pte_present(orig_pte) || !pte_cont(orig_pte))
+		return orig_pte;
+
+	ncontig = arch_contpte_get_num_contig(ptep,
+					      page_size(pte_page(orig_pte)),
+					      NULL);
+
+	for (i = 0; i < ncontig; i++, ptep++) {
+		pte_t pte = __ptep_get(ptep);
+
+		if (pte_dirty(pte))
+			orig_pte = pte_mkdirty(orig_pte);
+
+		if (pte_young(pte))
+			orig_pte = pte_mkyoung(orig_pte);
+	}
+	return orig_pte;
+}
-- 
2.39.2


