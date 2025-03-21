Return-Path: <linux-kernel+bounces-571297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B99A6BB73
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E4817A2F6C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF4E224237;
	Fri, 21 Mar 2025 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="HKRYh3W4"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04C21F8F09
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742562587; cv=none; b=FPMHCrl+n6uz3ptmkWTvSPbv+6YjYdSCSGvIBBMzh17mzT3MORWZKv5xsg6As6fVe0hMH56LCeFfDtFm/XOObWZqzGvKRWY1WHMgy+Ba7UUHHdhvp6HvtRmhC98sTxLHXsCsLPjkXoLUr7A4WPF0RBEwnJtd/81dBjpH+n236cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742562587; c=relaxed/simple;
	bh=p3RauSFB+74ijXsM1H7UMKUd6CXeWNsI0FXkrs+Bl2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mIh0zxw7jINbzomv2Hri22RmZzLSsK/FCJyPpg4npcna9U8LuihoETYi0wkmLT2UoKBNgQYSdsLu1wgDsXtxi9mCQwGkwArEAxahzKSfJgeQ5i8Uv6O/nJx9nU13FSDxKEs0WRwn2QKLfYKYQ6YlLBDHq4iw3g7W8aPj9hDc3e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=HKRYh3W4; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so12055355e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742562583; x=1743167383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e8EtFYpkeeZSqWY8m05eSUUviRVNOc3GBKbkMNHHDeA=;
        b=HKRYh3W4aNQ4oXGfpb7f5alz1+EUUrSbSUEq4EU7CiEGo47lcZ0pF3QSDM8QETX/AF
         WEYjlm7r+1/h+2oXq2jF4KJYoqtIM3+/vnhk/LLltHhUXFBnRLEjsCSrzZ03lpbqlNaz
         NuFYfigFdK+aTNyCBTq+CqhaLFpN5m/VbnXRWt0TOVRVZ/MiPK33rrX2qUxxHKXMl4s0
         s+ZiW6lwFLayr9jVdTB8UuNwqlwo+efuxFgpFLmPQUr3jDL38OOzWj5LLL2k8PONH8u3
         aVJrkYeZIaIofvSOvATU/jpu73xBzNKDlnZGcqR3LWpnPiqkJj5NYSGrClLk1LLAlaWq
         r1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742562583; x=1743167383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e8EtFYpkeeZSqWY8m05eSUUviRVNOc3GBKbkMNHHDeA=;
        b=ZgpH/t2KCGPRA2Jc8qfZ8Lj4+DrTkhE9Njn/oDlj58qr8jeU9/sxlYI2LeqGUt3u7g
         ghBMiDDxVVsSkaS8RyBjFx4/NGUk7iwok/SU9sxEVxzRgSedZAFLWBYRRFBjfCDRWoYU
         8bPnn5cFxIahLUG/kn9thvJShHR3LSRHxDiMGJE4UC0RA3InTUimLmZFxXayZIxr/K+U
         HcUy6L0OPxcRHdZpbH+EhvZwFRyIw+iz3fos0yQ7SRlL6JTXyGvK8BBwD4TnRepMNcgQ
         ERyPZukg9gEVwZbsbKbQev9+QrpT0X9qcnhDq8E0cy1xxUor1uM0rLNlcJHj0AJYM8tE
         3/kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpoVlgYDhOzonh1qLNmCkr9OsC6ko+HNfSQxn4YzaF1d+7tMeRsDlTWBhDhBQHU7/zqH7d7xAit5gjVuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXGY0BTRMkyDVO53DwLEVoZ4EEoRo8s1Tu830ZmiUI3lPNJsTc
	TrRlx63KIIhzx5Fvojd23L1bxILREVA8X6KPxGtyRdeF78HAV1D/hPnQivczbuk=
X-Gm-Gg: ASbGncs7uqG4HtHDg9zI5PcSEMv6Lqa0m/ZIYMC6fazVRv4nD9k58rnofqCgtaHEyDC
	LGMMFc/jZftfWyWXdmYAmuNhIH6ELudgfaYf9KWEfYPEe4dPQTP/nZMYhAv7JTiDKLh40fYkhaM
	AD+0LlHpP8b4LF8D/lBArOBRtT4/TXYYPzUFN7QqUBYObIj6Om3ZqqwzoOvU+pRkEBaOL8XKs5T
	M4FqRthJegieJJKDn4e+hD5uu/P9tc77w4JnQZfC0UrrNQ6HaKgfy/aoq6jMjWcL5dmWOmYy7u0
	U5a42rtj/5Tre70sW2t3l6Ld286KVaNgKy2gZT/h6Tc+MySG/vkQN1ANI5jy7EoQIFzAdw==
X-Google-Smtp-Source: AGHT+IFrlDybl2QKCVYqfxTyu64dXX62tEzPiiOD5kkpTcHrUIRBIEyVsyFQKXhsbfpJSLh/l0FWog==
X-Received: by 2002:a05:600c:4e4b:b0:439:9737:675b with SMTP id 5b1f17b1804b1-43d502f8536mr33623225e9.7.1742562582938;
        Fri, 21 Mar 2025 06:09:42 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com ([2001:861:3382:ef90:3d12:52fe:c1cc:c94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9a3c7fsm2377861f8f.34.2025.03.21.06.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 06:09:42 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-mm@kvack.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v5 3/9] mm: Use common huge_ptep_get() function for riscv/arm64
Date: Fri, 21 Mar 2025 14:06:29 +0100
Message-Id: <20250321130635.227011-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250321130635.227011-1-alexghiti@rivosinc.com>
References: <20250321130635.227011-1-alexghiti@rivosinc.com>
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
 arch/arm64/include/asm/pgtable.h | 57 +++++++++++++++++++++++++--
 arch/arm64/mm/hugetlbpage.c      | 66 ++------------------------------
 arch/riscv/Kconfig               |  1 +
 arch/riscv/include/asm/hugetlb.h |  6 +--
 arch/riscv/include/asm/pgtable.h | 45 ++++++++++++++++++++++
 arch/riscv/mm/hugetlbpage.c      | 62 +++---------------------------
 include/linux/hugetlb_contpte.h  | 12 ++++++
 mm/Kconfig                       |  3 ++
 mm/Makefile                      |  1 +
 mm/hugetlb_contpte.c             | 32 ++++++++++++++++
 12 files changed, 161 insertions(+), 128 deletions(-)
 create mode 100644 include/linux/hugetlb_contpte.h
 create mode 100644 mm/hugetlb_contpte.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 940343beb3d4..5a1e1bc73c15 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -113,6 +113,7 @@ config ARM64
 	select ARCH_WANT_DEFAULT_BPF_JIT
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 	select ARCH_WANT_FRAME_POINTERS
+	select ARCH_WANT_GENERAL_HUGETLB_CONTPTE
 	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_EXECMEM_LATE
diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 07fbf5bf85a7..0604e01dca97 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -13,6 +13,7 @@
 #include <asm/cacheflush.h>
 #include <asm/mte.h>
 #include <asm/page.h>
+#include <linux/hugetlb_contpte.h>
 
 #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
 #define arch_hugetlb_migration_supported arch_hugetlb_migration_supported
@@ -53,8 +54,6 @@ extern pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 #define __HAVE_ARCH_HUGE_PTE_CLEAR
 extern void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 			   pte_t *ptep, unsigned long sz);
-#define __HAVE_ARCH_HUGE_PTEP_GET
-extern pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
 
 void __init arm64_hugetlb_cma_reserve(void);
 
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 0b2a2ad1b9e8..af8156929c1d 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -420,9 +420,10 @@ static inline pte_t pte_advance_pfn(pte_t pte, unsigned long nr)
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
@@ -433,10 +434,15 @@ static inline void __set_ptes(struct mm_struct *mm,
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
  * Hugetlb definitions.
  */
@@ -1825,6 +1831,49 @@ static inline void clear_young_dirty_ptes(struct vm_area_struct *vma,
 
 #endif /* CONFIG_ARM64_CONTPTE */
 
+static inline bool __hugetlb_valid_size(unsigned long size)
+{
+	switch (size) {
+#ifndef __PAGETABLE_PMD_FOLDED
+	case PUD_SIZE:
+		return pud_sect_supported();
+#endif
+	case CONT_PMD_SIZE:
+	case PMD_SIZE:
+	case CONT_PTE_SIZE:
+		return true;
+	}
+
+	return false;
+}
+
+static inline int arch_contpte_get_num_contig(pte_t *ptep,
+					      unsigned long size,
+					      size_t *pgsize)
+{
+	int contig_ptes = 1;
+
+	if (pgsize)
+		*pgsize = size;
+
+	switch (size) {
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
+	default:
+		WARN_ON(!__hugetlb_valid_size(size));
+	}
+
+	return contig_ptes;
+}
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_PGTABLE_H */
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index b3a7fafe8892..60a2bb7575c1 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -49,22 +49,6 @@ void __init arm64_hugetlb_cma_reserve(void)
 }
 #endif /* CONFIG_CMA */
 
-static bool __hugetlb_valid_size(unsigned long size)
-{
-	switch (size) {
-#ifndef __PAGETABLE_PMD_FOLDED
-	case PUD_SIZE:
-		return pud_sect_supported();
-#endif
-	case CONT_PMD_SIZE:
-	case PMD_SIZE:
-	case CONT_PTE_SIZE:
-		return true;
-	}
-
-	return false;
-}
-
 #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
 bool arch_hugetlb_migration_supported(struct hstate *h)
 {
@@ -98,50 +82,6 @@ static int find_num_contig(struct mm_struct *mm, unsigned long addr,
 	return CONT_PTES;
 }
 
-static inline int num_contig_ptes(unsigned long size, size_t *pgsize)
-{
-	int contig_ptes = 1;
-
-	*pgsize = size;
-
-	switch (size) {
-	case CONT_PMD_SIZE:
-		*pgsize = PMD_SIZE;
-		contig_ptes = CONT_PMDS;
-		break;
-	case CONT_PTE_SIZE:
-		*pgsize = PAGE_SIZE;
-		contig_ptes = CONT_PTES;
-		break;
-	default:
-		WARN_ON(!__hugetlb_valid_size(size));
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
@@ -221,7 +161,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 	unsigned long pfn, dpfn;
 	pgprot_t hugeprot;
 
-	ncontig = num_contig_ptes(sz, &pgsize);
+	ncontig = arch_contpte_get_num_contig(ptep, sz, &pgsize);
 
 	if (!pte_present(pte)) {
 		for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
@@ -382,7 +322,7 @@ void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 	int i, ncontig;
 	size_t pgsize;
 
-	ncontig = num_contig_ptes(sz, &pgsize);
+	ncontig = arch_contpte_get_num_contig(ptep, sz, &pgsize);
 
 	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
 		__pte_clear(mm, addr, ptep);
@@ -394,7 +334,7 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 	int ncontig;
 	size_t pgsize;
 
-	ncontig = num_contig_ptes(sz, &pgsize);
+	ncontig = arch_contpte_get_num_contig(ptep, sz, &pgsize);
 	return get_clear_contig(mm, addr, ptep, pgsize, ncontig);
 }
 
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7612c52e9b1e..2a5b2a9f2816 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -79,6 +79,7 @@ config RISCV
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_GENERAL_HUGETLB if !RISCV_ISA_SVNAPOT
+	select ARCH_WANT_GENERAL_HUGETLB_CONTPTE if RISCV_ISA_SVNAPOT
 	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
 	select ARCH_WANT_LD_ORPHAN_WARN if !XIP_KERNEL
 	select ARCH_WANT_OPTIMIZE_DAX_VMEMMAP
diff --git a/arch/riscv/include/asm/hugetlb.h b/arch/riscv/include/asm/hugetlb.h
index 446126497768..69393346ade0 100644
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
@@ -44,9 +47,6 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 			       unsigned long addr, pte_t *ptep,
 			       pte_t pte, int dirty);
 
-#define __HAVE_ARCH_HUGE_PTEP_GET
-pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
-
 pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags);
 #define arch_make_huge_pte arch_make_huge_pte
 
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 2e62d7e607db..286fe1a32ded 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -296,6 +296,8 @@ static inline unsigned long pte_napot(pte_t pte)
 	return pte_val(pte) & _PAGE_NAPOT;
 }
 
+#define pte_cont		pte_napot
+
 #define pte_valid_napot(pte)	(pte_present(pte) && pte_napot(pte))
 
 /*
@@ -606,6 +608,49 @@ static inline void ___set_ptes(struct mm_struct *mm, unsigned long addr,
 	}
 }
 
+#ifdef CONFIG_RISCV_ISA_SVNAPOT
+/*
+ * Some hugetlb functions can be called on !present ptes, so we must use the
+ * size parameter when it is passed.
+ */
+static inline int arch_contpte_get_num_contig(pte_t *ptep, unsigned long size,
+					      size_t *pgsize)
+{
+	unsigned long hugepage_shift;
+	pte_t __pte;
+
+	if (size) {
+		if (size >= PGDIR_SIZE)
+			hugepage_shift = PGDIR_SHIFT;
+		else if (size >= P4D_SIZE)
+			hugepage_shift = P4D_SHIFT;
+		else if (size >= PUD_SIZE)
+			hugepage_shift = PUD_SHIFT;
+		else if (size >= PMD_SIZE)
+			hugepage_shift = PMD_SHIFT;
+		else
+			hugepage_shift = PAGE_SHIFT;
+	} else {
+		/*
+		 * We must read the raw value of the pte to get the size of
+		 * the mapping
+		 */
+		__pte = ___ptep_get(ptep);
+
+		/* Make sure __pte is not a swap entry */
+		BUG_ON(!pte_valid_napot(__pte));
+
+		hugepage_shift = PAGE_SHIFT;
+		size = napot_cont_size(napot_cont_order(__pte));
+	}
+
+	if (pgsize)
+		*pgsize = BIT(hugepage_shift);
+
+	return size >> hugepage_shift;
+}
+#endif
+
 static inline void pte_clear(struct mm_struct *mm,
 	unsigned long addr, pte_t *ptep)
 {
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index 60b7e738b31a..b9eb6b7b214d 100644
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
@@ -215,26 +191,6 @@ static void clear_flush(struct mm_struct *mm,
 	flush_tlb_range(&vma, saddr, addr);
 }
 
-static int num_contig_ptes_from_size(unsigned long sz, size_t *pgsize)
-{
-	unsigned long hugepage_shift;
-
-	if (sz >= PGDIR_SIZE)
-		hugepage_shift = PGDIR_SHIFT;
-	else if (sz >= P4D_SIZE)
-		hugepage_shift = P4D_SHIFT;
-	else if (sz >= PUD_SIZE)
-		hugepage_shift = PUD_SHIFT;
-	else if (sz >= PMD_SIZE)
-		hugepage_shift = PMD_SHIFT;
-	else
-		hugepage_shift = PAGE_SHIFT;
-
-	*pgsize = 1 << hugepage_shift;
-
-	return sz >> hugepage_shift;
-}
-
 /*
  * When dealing with NAPOT mappings, the privileged specification indicates that
  * "if an update needs to be made, the OS generally should first mark all of the
@@ -252,7 +208,7 @@ void set_huge_pte_at(struct mm_struct *mm,
 	size_t pgsize;
 	int i, pte_num;
 
-	pte_num = num_contig_ptes_from_size(sz, &pgsize);
+	pte_num = arch_contpte_get_num_contig(ptep, sz, &pgsize);
 
 	if (!pte_present(pte)) {
 		for (i = 0; i < pte_num; i++, ptep++, addr += pgsize)
@@ -277,15 +233,13 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 			       int dirty)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	unsigned long order;
 	pte_t orig_pte;
 	int pte_num;
 
 	if (!pte_napot(pte))
 		return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
 
-	order = napot_cont_order(pte);
-	pte_num = napot_pte_num(order);
+	pte_num = arch_contpte_get_num_contig(ptep, 0, NULL);
 	orig_pte = get_clear_contig_flush(mm, addr, ptep, pte_num);
 
 	if (pte_dirty(orig_pte))
@@ -303,14 +257,13 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 			      unsigned long addr,
 			      pte_t *ptep, unsigned long sz)
 {
-	size_t pgsize;
 	pte_t orig_pte = ptep_get(ptep);
 	int pte_num;
 
 	if (!pte_napot(orig_pte))
 		return ptep_get_and_clear(mm, addr, ptep);
 
-	pte_num = num_contig_ptes_from_size(sz, &pgsize);
+	pte_num = arch_contpte_get_num_contig(ptep, sz, NULL);
 
 	return get_clear_contig(mm, addr, ptep, pte_num);
 }
@@ -320,7 +273,6 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 			     pte_t *ptep)
 {
 	pte_t pte = ptep_get(ptep);
-	unsigned long order;
 	pte_t orig_pte;
 	int pte_num;
 
@@ -329,8 +281,7 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 		return;
 	}
 
-	order = napot_cont_order(pte);
-	pte_num = napot_pte_num(order);
+	pte_num = arch_contpte_get_num_contig(ptep, 0, NULL);
 	orig_pte = get_clear_contig_flush(mm, addr, ptep, pte_num);
 
 	orig_pte = pte_wrprotect(orig_pte);
@@ -348,7 +299,7 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 	if (!pte_napot(pte))
 		return ptep_clear_flush(vma, addr, ptep);
 
-	pte_num = napot_pte_num(napot_cont_order(pte));
+	pte_num = arch_contpte_get_num_contig(ptep, 0, NULL);
 
 	return get_clear_contig_flush(vma->vm_mm, addr, ptep, pte_num);
 }
@@ -367,8 +318,7 @@ void huge_pte_clear(struct mm_struct *mm,
 		return;
 	}
 
-	pte_num = num_contig_ptes_from_size(sz, &pgsize);
-
+	pte_num = arch_contpte_get_num_contig(ptep, sz, &pgsize);
 	for (i = 0; i < pte_num; i++, addr += pgsize, ptep++)
 		pte_clear(mm, addr, ptep);
 }
diff --git a/include/linux/hugetlb_contpte.h b/include/linux/hugetlb_contpte.h
new file mode 100644
index 000000000000..2ea17e4fe36b
--- /dev/null
+++ b/include/linux/hugetlb_contpte.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2025 Rivos Inc.
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
index 1b501db06417..f9d3f3d49f3e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -853,6 +853,9 @@ config NOMMU_INITIAL_TRIM_EXCESS
 config ARCH_WANT_GENERAL_HUGETLB
 	bool
 
+config ARCH_WANT_GENERAL_HUGETLB_CONTPTE
+	bool
+
 config ARCH_WANTS_THP_SWAP
 	def_bool n
 
diff --git a/mm/Makefile b/mm/Makefile
index 850386a67b3e..76e8b995f551 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -96,6 +96,7 @@ obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_NUMA) += memory-tiers.o
 obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
+obj-$(CONFIG_ARCH_WANT_GENERAL_HUGETLB_CONTPTE) += hugetlb_contpte.o
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
 obj-$(CONFIG_MEMCG_V1) += memcontrol-v1.o
 obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
diff --git a/mm/hugetlb_contpte.c b/mm/hugetlb_contpte.c
new file mode 100644
index 000000000000..500d0b96a680
--- /dev/null
+++ b/mm/hugetlb_contpte.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2025 Rivos Inc.
+ */
+
+#include <linux/pgtable.h>
+#include <linux/mm.h>
+#include <linux/hugetlb.h>
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


