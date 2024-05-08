Return-Path: <linux-kernel+bounces-173127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5788BFBDD
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFA6B1C23039
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BD8823BF;
	Wed,  8 May 2024 11:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vg1hdBev"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F8876037
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167304; cv=none; b=puA+ZxlCK0eQRvXJgepYr9gUlrFan4USsnZUmJuuSupfsX/8Raottg2RlxI6w17ev8v+9k1hHBJvgOg75DilX+22UEIsyzUQBdKiNQK2sZX9fNY2bRPe14f1rJSfxznZXESubnmW9FfWvkZRe2dgpYyl02jJ9rGQoRpsGkVMygg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167304; c=relaxed/simple;
	bh=LTPolNLc2BtJe/sbMhKBvagG7gardGR2JEHb8WqnbWo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f/RjUSz7XXAV3o6uc+yukq1b8lUrnHhT2uTT28mwqb6VznrLobMi1IXX2JTMHSMjy+niC4XwPhomyfQ0m37afRPM58iF9lnK57mrDxOMTW9+kixW52gTo3qSasCUvrAcxDUbWESVWh8r0DjPF32ksBnYz+lHDdiwj/jdnXwJj6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vg1hdBev; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5210684cee6so2711348e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 04:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715167300; x=1715772100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YO7yDIQr+QJFeAZFjf5GxhWsbGb5WjqA2EGZTufF1Fc=;
        b=vg1hdBevY0ncsovj/Kd7TUKDqeqWwfzYq1CirkIeRJ2B1It+4dATUJVCAqMX7X7XQ1
         H/MGWu2I1iNvBMPWNZ+CGRcAHwdHd4hx+y25GOEI4nS4goY6K/eHsAE5fLmLESu0fThf
         AkFqfoIbYuQ0iM3UaUF9qLkhaqP1w4ctoEYkhaQwtvcXhS8gFdOAhhHc3AQtW/bWbudW
         AxDruzVNy0aGPU6XKxZM2w7uTwo7a1VHN8hPbDYaDHVQWP1fqOSWg0S8xaTzaPNJUu2h
         oA+srvyZK60CmdfAfnE1Qg6G0vxw3s9/BzJzz6jWzdBnppJ3MosQLZb2Ne2DdGVr2cAc
         GSFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715167300; x=1715772100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YO7yDIQr+QJFeAZFjf5GxhWsbGb5WjqA2EGZTufF1Fc=;
        b=azmGwz6FMmiLWJ1TgVEPre6BRFosbInvbN5Z/ELBlHRybitYGQ+7jItbMHfusjRSuw
         mQa00cmxUfpz2h9q8l27kmB5ykn4vtVH2Kb01Wvam1wjzqQxwUUTQt1nv1+GFCARslVo
         cH+v9tC15xVMS6ux7pEZM1U26Ivons4PeBu3jxfcomawpEgZtbGVh3XfNRui5PUqXVEb
         DyF4djU8gmHOtvSbPfRNyMEv2NtEJMygOMWAK8t5TdOdMjW4n713yDRbJjAjN+Js0hL8
         NnclMa7Ws+O9CRL2Z7pibd0zI9H8R2ADHfkO1CyAytW+LOamA7L6obnV/wK4Zj5UvB+g
         0IrA==
X-Forwarded-Encrypted: i=1; AJvYcCUaGda1razIv+7lQlTgApUKYUV9ggJRW41ixGxKU1LAtyVgTIm9ut6D4GXffe1VZGIVyUUwiOytZ+CPr+Ygn46ig5DjSbdwewHAcYF1
X-Gm-Message-State: AOJu0YxwFiA7Syrz8Zplx7LlV9F+iqYunfcdXZfOh1ilVRfdRa3YLE0t
	5gUK9JdVhPmXwOuRkWxHdF/lU6qPVJlvGY9WPaNNMoHtAOZUVEZxH5f2BYRyu9c=
X-Google-Smtp-Source: AGHT+IGlIF5qrXIZLx6k07SYUl4uhRcj6nfG/t1miugJV1fwoSAC2HF4MbIjFtO5Wp6+YeTrOF+Wmg==
X-Received: by 2002:a05:6512:3ba6:b0:520:dc1c:3c5d with SMTP id 2adb3069b0e04-5217cc458a8mr1935422e87.42.1715167300050;
        Wed, 08 May 2024 04:21:40 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id h4-20020adff4c4000000b0034cee43238fsm15052972wrp.27.2024.05.08.04.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 04:21:39 -0700 (PDT)
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
Subject: [PATCH v2 3/9] mm: Use common huge_ptep_get() function for riscv/arm64
Date: Wed,  8 May 2024 13:18:23 +0200
Message-Id: <20240508111829.16891-4-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240508111829.16891-1-alexghiti@rivosinc.com>
References: <20240508111829.16891-1-alexghiti@rivosinc.com>
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


