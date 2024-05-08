Return-Path: <linux-kernel+bounces-173150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5C78BFC3A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2A251F21CD1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5E9823BF;
	Wed,  8 May 2024 11:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="2DnZdhP1"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9197129CF0
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168251; cv=none; b=PoH2zfftPNBMIXuaij0qelZ0UvwW0WVcLu/KZjCKuoGcO178+u3pDGyWnPE/2e6YQvum7Ka4Dhg/TnxW6+pQMYK8MZM1HYXB6a+pL0EB9HpCiBjbUXIiDreYa5FOhiM4uipPs+Lj/EqmCjFRn9FrMfY9PQOqFiBN6kZ6zp3VDSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168251; c=relaxed/simple;
	bh=LTPolNLc2BtJe/sbMhKBvagG7gardGR2JEHb8WqnbWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rqs527cI587gy+DqkARu90eTvAfFhr/CelvwJc71VfEw6W1a+FpzSkAlCW8KH6FWBaiRALzaog+2SoOXbOd0zW7XkomV/A4ePsFPLrDxCi7+sF8RC/sD6+eV61/EleoyuG9Efz7qscm9mAWRVZ7vCzptFjkHonMVhGy6huE33QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=2DnZdhP1; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41ba1ba5591so31812645e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 04:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715168248; x=1715773048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YO7yDIQr+QJFeAZFjf5GxhWsbGb5WjqA2EGZTufF1Fc=;
        b=2DnZdhP1bGcZIZu/DLZXxWe9CVX3J+JOp5QF2hJhMHssnAy2849cUZQMMNpZ9MN/GB
         ZfK4VDPSBoaGPIIv8gR3dCwbiziMVS4yyg3tvlJYg5lPOCJnsZdT0Jiny33G34YpL59w
         cji7nnzpIdwwo5HxJN7oKzMcEcSqT0fh/paRBjmH8dfJHtHC7+ojibXBdlorQAGGmRFj
         /+maRlF23NKaYzHIB1vExJeHMTg+ZH3uUmRpIjbWN0gLUmoWekt6XydADjdHopWLRy2b
         uZCFRx2RsCdXFGHFLGX3HykTxXVzQKB4AUcbRay1eYiYbqKW0FO9+ZNF6k+r1YcnuTU5
         fELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715168248; x=1715773048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YO7yDIQr+QJFeAZFjf5GxhWsbGb5WjqA2EGZTufF1Fc=;
        b=k4d6G+6NGJPFg9iVJ8/6+/vZfJDcM4F0PYj6eDjdV20Izf/pf2yJu7x60x6LUhb7ow
         BLANcdFHHeWIO9DT1GX8Up2SbZGoWtr9jMiC9oa1rLAacDrziCuau/2p3ze/DKvcXEHk
         qKz2hd3HroJeGS/Dc8XbK3MAyjfaiZX0skpvYXWLG91vPXQKS9QFLJErm0IRGDl5x+i6
         vHOxN58/n/k5FbUWPiwrYDJgcbPwfZ71Ruz/qZddBb3G7Jz8egOkl+HHa/MgIe+oWu3r
         vUjN3RjMwSHeQMjPPM+nGWaozf5kFvmWuuALjm4vpI+MVkSc0iSDeTfh2fwr18QT1uKT
         zqMw==
X-Forwarded-Encrypted: i=1; AJvYcCXIERA1Zt8/VRRofvzMc0aE2blPgwqJce/z3OKMGk+gBcAiUiZsr2BJ/p568MTXj7zoqPwGan9U2mFNxCT+vsN1yBR/0NySmcxBbL62
X-Gm-Message-State: AOJu0YzSjq9+Kol6SmfiaKOcyUSR2VVvs2XN1BkpusNFEanZKVbIveRZ
	Wh6Fev2PlxdWAlme5XtTw6W8bcZ31TXjqmKkesU8O9FwdhIb+HwR3yYQa2Ilu+E=
X-Google-Smtp-Source: AGHT+IEExaDEn0vN6E4Lxk1Zj77Ju6cFib9bZTV4G4rk0yK8V1Cj9z0Mbupc0fzpXub0lh02TBpHRw==
X-Received: by 2002:a05:600c:4f0d:b0:41a:7bbe:c3bf with SMTP id 5b1f17b1804b1-41f714f717bmr19142655e9.22.1715168247871;
        Wed, 08 May 2024 04:37:27 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id dd3-20020a0560001e8300b0034c9f060a14sm15085210wrb.11.2024.05.08.04.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 04:37:27 -0700 (PDT)
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
Subject: [PATCH RESEND v2 3/9] mm: Use common huge_ptep_get() function for riscv/arm64
Date: Wed,  8 May 2024 13:34:13 +0200
Message-Id: <20240508113419.18620-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240508113419.18620-1-alexghiti@rivosinc.com>
References: <20240508113419.18620-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For that, we need to introduce:

- a new config: ARCH_HAS_CONTPTE,
- a new arch specific function which returns the number of contiguous PTE
  in a mapping and its base page size,
- a pte_cont() helper, only introduced for riscv since we keep the arm64
  naming (contpte) which is more explicit than the riscv's (napot).

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/pgtable.h | 30 +++++++++++++++++
 arch/arm64/mm/hugetlbpage.c      | 55 ++------------------------------
 arch/riscv/Kconfig               |  1 +
 arch/riscv/include/asm/hugetlb.h |  2 +-
 arch/riscv/include/asm/pgtable.h |  6 ++--
 arch/riscv/mm/hugetlbpage.c      | 24 --------------
 mm/Kconfig                       |  3 ++
 mm/Makefile                      |  1 +
 mm/contpte.c                     | 45 ++++++++++++++++++++++++++
 10 files changed, 88 insertions(+), 80 deletions(-)
 create mode 100644 mm/contpte.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b11c98b3e84..ac2f6d906cc3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -20,6 +20,7 @@ config ARM64
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_CACHE_LINE_SIZE
+	select ARCH_HAS_CONTPTE
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index afdd56d26ad7..e30149a128f2 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1638,6 +1638,36 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
 
 #endif /* CONFIG_ARM64_CONTPTE */
 
+static inline int arch_contpte_get_num_contig(pte_t *ptep, unsigned long size,
+					      size_t *pgsize)
+{
+	int contig_ptes = 0;
+
+	*pgsize = size;
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
+		*pgsize = PMD_SIZE;
+		contig_ptes = CONT_PMDS;
+		break;
+	case CONT_PTE_SIZE:
+		*pgsize = PAGE_SIZE;
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
index 0f0e10bb0a95..9e9c80ec6e74 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -112,57 +112,6 @@ static int find_num_contig(struct mm_struct *mm, unsigned long addr,
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
-pte_t huge_ptep_get(pte_t *ptep)
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
@@ -243,7 +192,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 	unsigned long pfn, dpfn;
 	pgprot_t hugeprot;
 
-	ncontig = num_contig_ptes(sz, &pgsize);
+	ncontig = arch_contpte_get_num_contig(ptep, sz, &pgsize);
 
 	if (!pte_present(pte)) {
 		for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
@@ -390,7 +339,7 @@ void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 	int i, ncontig;
 	size_t pgsize;
 
-	ncontig = num_contig_ptes(sz, &pgsize);
+	ncontig = arch_contpte_get_num_contig(ptep, sz, &pgsize);
 
 	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
 		__pte_clear(mm, addr, ptep);
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8a0f403432e8..38d93cf44456 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -19,6 +19,7 @@ config RISCV
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_BINFMT_FLAT
+	select ARCH_HAS_CONTPTE if RISCV_ISA_SVNAPOT
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DEBUG_VM_PGTABLE
diff --git a/arch/riscv/include/asm/hugetlb.h b/arch/riscv/include/asm/hugetlb.h
index 22deb7a2a6ec..f195f611722b 100644
--- a/arch/riscv/include/asm/hugetlb.h
+++ b/arch/riscv/include/asm/hugetlb.h
@@ -49,7 +49,7 @@ pte_t huge_ptep_get(pte_t *ptep);
 pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags);
 #define arch_make_huge_pte arch_make_huge_pte
 
-#endif /*CONFIG_RISCV_ISA_SVNAPOT*/
+#endif /* CONFIG_RISCV_ISA_SVNAPOT */
 
 #include <asm-generic/hugetlb.h>
 
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 268c828f5152..66061002ff36 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -296,6 +296,7 @@ static inline unsigned long pte_napot(pte_t pte)
 {
 	return pte_val(pte) & _PAGE_NAPOT;
 }
+#define pte_cont	pte_napot
 
 #define pte_valid_napot(pte)	(pte_present(pte) && pte_napot(pte))
 
@@ -560,7 +561,7 @@ static inline int arch_contpte_get_num_contig(pte_t *ptep, unsigned long size,
 }
 #endif
 
-static inline pte_t ptep_get(pte_t *ptep)
+static inline pte_t __ptep_get(pte_t *ptep)
 {
 	pte_t pte = READ_ONCE(*ptep);
 
@@ -584,7 +585,6 @@ static inline pte_t ptep_get(pte_t *ptep)
 
 	return pte;
 }
-#define ptep_get	ptep_get
 
 static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 		pte_t *ptep, pte_t pteval, unsigned int nr)
@@ -686,6 +686,8 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 	return ptep_test_and_clear_young(vma, address, ptep);
 }
 
+#define ptep_get		__ptep_get
+
 #define pgprot_nx pgprot_nx
 static inline pgprot_t pgprot_nx(pgprot_t _prot)
 {
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index f042f5c8bdb7..be129f4f1503 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -3,30 +3,6 @@
 #include <linux/err.h>
 
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
-pte_t huge_ptep_get(pte_t *ptep)
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
diff --git a/mm/Kconfig b/mm/Kconfig
index b1448aa81e15..c325003d6552 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -981,6 +981,9 @@ config ARCH_HAS_CPU_CACHE_ALIASING
 config ARCH_HAS_CACHE_LINE_SIZE
 	bool
 
+config ARCH_HAS_CONTPTE
+	bool
+
 config ARCH_HAS_CURRENT_STACK_POINTER
 	bool
 	help
diff --git a/mm/Makefile b/mm/Makefile
index 4abb40b911ec..605ead58403b 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -89,6 +89,7 @@ obj-$(CONFIG_MIGRATION) += migrate.o
 obj-$(CONFIG_NUMA) += memory-tiers.o
 obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
 obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
+obj-$(CONFIG_ARCH_HAS_CONTPTE) += contpte.o
 obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
 obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
 ifdef CONFIG_SWAP
diff --git a/mm/contpte.c b/mm/contpte.c
new file mode 100644
index 000000000000..e8574051d0b9
--- /dev/null
+++ b/mm/contpte.c
@@ -0,0 +1,45 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Rivos Inc.
+ */
+
+#include <linux/mm.h>
+#include <linux/pgtable.h>
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
+pte_t huge_ptep_get(pte_t *ptep)
+{
+	int ncontig, i;
+	size_t pgsize;
+	pte_t orig_pte = __ptep_get(ptep);
+
+	if (!pte_present(orig_pte) || !pte_cont(orig_pte))
+		return orig_pte;
+
+	ncontig = arch_contpte_get_num_contig(ptep,
+					      page_size(pte_page(orig_pte)),
+					      &pgsize);
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


