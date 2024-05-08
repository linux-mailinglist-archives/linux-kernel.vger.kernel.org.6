Return-Path: <linux-kernel+bounces-173128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7A88BFBE4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6594281781
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EF081ACA;
	Wed,  8 May 2024 11:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="V7KUz1h7"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CF781729
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167364; cv=none; b=NYL3bQBbLWMArPPqe0zdXIT3a7VBDm9P44ns9tS9n30EiZw5FAtrHHVsbVRA/O14Th8Ea5HnnqbcMpIcwVOR+xiEJiU3gOcYJ4VbZJcOsxE7IEBcjogOCTD5FCy0JHWRnfJ39LulfxELbRytbRtZ9PAwcadcXTU9L4AdHrDYvpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167364; c=relaxed/simple;
	bh=b2CmOyaFaiwbt6cdUwy4Ez0JGf0aumlKPqvfskmokMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OXjj/KS8hK5cUk+0skzUpw3CyN+/VpVRkoTsLG5hVo2gxQ1RSVp7/WLF0U2a45ERRtqqv451OJR9I5PzTQybpkN3WLPUBkaX0XpCLKBtnU+poAE0xtZhHJ8tLOtLJ7m4mcM9I9Jhz7w/fPrXaswOkH1UM3FRrv1g574ANwyW8Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=V7KUz1h7; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-34b66f0500aso2932967f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 04:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715167361; x=1715772161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tID4t35K2Xq8XfdKgfehJoKp8xw/RZTmJgN0BGYZu8=;
        b=V7KUz1h7rQMqfpm8zT0LOE1o8sfLZy+Wg0iXSHEx9eeV7fVdpRSUybalFmu1XgLMtN
         szlEhekK/tEfRHZxh690GuLrI7PDSFDqLLyODQYQDe3Os/qH0o5wTdkTkkvXyJHdDicg
         0pGBvZ66r4YdnnRTMPkAi01AJLU1ZDgZItG9pylEt6LdPzkVhXjVmKs0xeNxnHxF/nCT
         jeEy+knP297C36MSZmAvPZHP2G5IDV3uUGs9trixo/u3faDBFiFdFqCEgerJeU3mEcPz
         hp5eZ3Ga2Mfek6L4Nm3XNeFXJsEvVZ4W27Ao/fmaNcyN29r7pgJDN9VN8OTYRtdEnafP
         NppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715167361; x=1715772161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tID4t35K2Xq8XfdKgfehJoKp8xw/RZTmJgN0BGYZu8=;
        b=RkTcEgk1g+bjujFlBMPanTUXHf5q6vroA7BSQCxg7xcdvsqv7HwxqM4f1uMdQipRNz
         ENJYInJ6li2vHowaT97kUa1NdxdvKNfI+zX6FyFbE+eSgX0ZROP0nUAoFTEakGJUARW/
         3jr1SdpPUWPQIPclUXLmKw7lvJ2amTUZB/4jRNRly7csyXBp09p+EbZXXrz8BI5XlXMo
         nDxN6606f9IUelTDmn+v8VOq2b9w8xh/Xmx7F1AR+ng8E3Y8mBUfchBWUm0p1WMJE0hp
         2sB6di8nDDwiF4cGx0PnOgHemFpfAFyiGiF9KyYBoIFG1CGLoaD19SG63ta46R/w+Uaz
         SnPw==
X-Forwarded-Encrypted: i=1; AJvYcCWKPdKf86ser/X4thhKKQdP5dotM+S44AEjz1SWHsLLmLKAJ/aFYJZi1xr5Weo3FOe0lBGmHGnN9krROyZUBQLVFMIgOLfhLfwNc+OH
X-Gm-Message-State: AOJu0YwmZ0r6ocwQ7nAuTEHnOvwC4HzFUyP2LhGWYpW49TNDH/9ZgLpb
	e1Qv/Y3RyEX0jOYjWTzjFGdeX7WNp1LfBhNAMHwz00FDSm6lRfWhR2n1okwfREXjIdI7uhEwB2q
	K
X-Google-Smtp-Source: AGHT+IEhj4x90HF7qk4DaGHuIQAJSSwdJ9BqGTmqhMoZKfcOAwPZQ6Sx+t8ghfaCru80kzJxCAbXqg==
X-Received: by 2002:a05:6000:1b85:b0:349:7e8e:b29a with SMTP id ffacd0b85a97d-34fca80e9a8mr1884287f8f.62.1715167361084;
        Wed, 08 May 2024 04:22:41 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id p12-20020adfe60c000000b0034ccd06a6a3sm15154549wrm.18.2024.05.08.04.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 04:22:40 -0700 (PDT)
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
Subject: [PATCH v2 4/9] mm: Use common set_huge_pte_at() function for riscv/arm64
Date: Wed,  8 May 2024 13:18:24 +0200
Message-Id: <20240508111829.16891-5-alexghiti@rivosinc.com>
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

After some adjustments, both architectures have the same implementation
so move it to generic code.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/arm64/include/asm/pgtable.h | 14 +++++---
 arch/arm64/mm/hugetlbpage.c      | 56 -----------------------------
 arch/riscv/include/asm/pgtable.h | 39 +++++++++++++-------
 arch/riscv/mm/hugetlbpage.c      | 62 --------------------------------
 mm/contpte.c                     | 59 ++++++++++++++++++++++++++++++
 5 files changed, 95 insertions(+), 135 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index e30149a128f2..2e0415fd5083 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -372,9 +372,10 @@ static inline pte_t pte_advance_pfn(pte_t pte, unsigned long nr)
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
@@ -385,10 +386,15 @@ static inline void __set_ptes(struct mm_struct *mm,
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
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 9e9c80ec6e74..b8353b0a273c 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -159,62 +159,6 @@ static pte_t get_clear_contig_flush(struct mm_struct *mm,
 	return orig_pte;
 }
 
-/*
- * Changing some bits of contiguous entries requires us to follow a
- * Break-Before-Make approach, breaking the whole contiguous set
- * before we can change any entries. See ARM DDI 0487A.k_iss10775,
- * "Misprogramming of the Contiguous bit", page D4-1762.
- *
- * This helper performs the break step for use cases where the
- * original pte is not needed.
- */
-static void clear_flush(struct mm_struct *mm,
-			     unsigned long addr,
-			     pte_t *ptep,
-			     unsigned long pgsize,
-			     unsigned long ncontig)
-{
-	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
-	unsigned long i, saddr = addr;
-
-	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
-		__ptep_get_and_clear(mm, addr, ptep);
-
-	flush_tlb_range(&vma, saddr, addr);
-}
-
-void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
-			    pte_t *ptep, pte_t pte, unsigned long sz)
-{
-	size_t pgsize;
-	int i;
-	int ncontig;
-	unsigned long pfn, dpfn;
-	pgprot_t hugeprot;
-
-	ncontig = arch_contpte_get_num_contig(ptep, sz, &pgsize);
-
-	if (!pte_present(pte)) {
-		for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
-			__set_ptes(mm, addr, ptep, pte, 1);
-		return;
-	}
-
-	if (!pte_cont(pte)) {
-		__set_ptes(mm, addr, ptep, pte, 1);
-		return;
-	}
-
-	pfn = pte_pfn(pte);
-	dpfn = pgsize >> PAGE_SHIFT;
-	hugeprot = pte_pgprot(pte);
-
-	clear_flush(mm, addr, ptep, pgsize, ncontig);
-
-	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize, pfn += dpfn)
-		__set_ptes(mm, addr, ptep, pfn_pte(pfn, hugeprot), 1);
-}
-
 pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, unsigned long sz)
 {
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 66061002ff36..5d1d3a6c7c44 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -535,29 +535,39 @@ static inline void __set_pte_at(struct mm_struct *mm, pte_t *ptep, pte_t pteval)
 static inline int arch_contpte_get_num_contig(pte_t *ptep, unsigned long size,
 					      size_t *pgsize)
 {
+	unsigned long hugepage_shift;
 	pte_t __pte;
 
 	/* We must read the raw value of the pte to get the size of the mapping */
 	__pte = READ_ONCE(*ptep);
 
-	if (pgsize) {
-		if (size >= PGDIR_SIZE)
+	if (size >= PGDIR_SIZE) {
+		if (pgsize)
 			*pgsize = PGDIR_SIZE;
-		else if (size >= P4D_SIZE)
+		hugepage_shift = PGDIR_SHIFT;
+	} else if (size >= P4D_SIZE) {
+		if (pgsize)
 			*pgsize = P4D_SIZE;
-		else if (size >= PUD_SIZE)
+		hugepage_shift = P4D_SHIFT;
+	} else if (size >= PUD_SIZE) {
+		if (pgsize)
 			*pgsize = PUD_SIZE;
-		else if (size >= PMD_SIZE)
+		hugepage_shift = PUD_SHIFT;
+	} else if (size >= PMD_SIZE) {
+		if (pgsize)
 			*pgsize = PMD_SIZE;
-		else
+		hugepage_shift = PMD_SHIFT;
+	} else {
+		if (pgsize)
 			*pgsize = PAGE_SIZE;
+		hugepage_shift = PAGE_SHIFT;
 	}
 
 	/* Make sure __pte is not a swap entry */
 	if (pte_valid_napot(__pte))
 		return napot_pte_num(napot_cont_order(__pte));
 
-	return 1;
+	return size >> hugepage_shift;
 }
 #endif
 
@@ -586,8 +596,8 @@ static inline pte_t __ptep_get(pte_t *ptep)
 	return pte;
 }
 
-static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
-		pte_t *ptep, pte_t pteval, unsigned int nr)
+static inline void __set_ptes(struct mm_struct *mm, unsigned long addr,
+			      pte_t *ptep, pte_t pteval, unsigned int nr)
 {
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
 	if (unlikely(pte_valid_napot(pteval))) {
@@ -631,7 +641,8 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 		pte_val(pteval) += 1 << _PAGE_PFN_SHIFT;
 	}
 }
-#define set_ptes set_ptes
+#define set_contptes(mm, addr, ptep, pte, nr, pgsize)			\
+			__set_ptes(mm, addr, ptep, pte, nr)
 
 static inline void pte_clear(struct mm_struct *mm,
 	unsigned long addr, pte_t *ptep)
@@ -646,9 +657,8 @@ extern int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long addre
 extern int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long address,
 				     pte_t *ptep);
 
-#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
-static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
-				       unsigned long address, pte_t *ptep)
+static inline pte_t __ptep_get_and_clear(struct mm_struct *mm,
+					 unsigned long address, pte_t *ptep)
 {
 	pte_t pte = __pte(atomic_long_xchg((atomic_long_t *)ptep, 0));
 
@@ -687,6 +697,9 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 }
 
 #define ptep_get		__ptep_get
+#define set_ptes		__set_ptes
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
+#define ptep_get_and_clear	__ptep_get_and_clear
 
 #define pgprot_nx pgprot_nx
 static inline pgprot_t pgprot_nx(pgprot_t _prot)
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index be129f4f1503..d8f07aef758b 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -173,68 +173,6 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 	return entry;
 }
 
-static void clear_flush(struct mm_struct *mm,
-			unsigned long addr,
-			pte_t *ptep,
-			unsigned long pgsize,
-			unsigned long ncontig)
-{
-	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
-	unsigned long i, saddr = addr;
-
-	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
-		ptep_get_and_clear(mm, addr, ptep);
-
-	flush_tlb_range(&vma, saddr, addr);
-}
-
-/*
- * When dealing with NAPOT mappings, the privileged specification indicates that
- * "if an update needs to be made, the OS generally should first mark all of the
- * PTEs invalid, then issue SFENCE.VMA instruction(s) covering all 4 KiB regions
- * within the range, [...] then update the PTE(s), as described in Section
- * 4.2.1.". That's the equivalent of the Break-Before-Make approach used by
- * arm64.
- */
-void set_huge_pte_at(struct mm_struct *mm,
-		     unsigned long addr,
-		     pte_t *ptep,
-		     pte_t pte,
-		     unsigned long sz)
-{
-	unsigned long hugepage_shift, pgsize;
-	int i, pte_num;
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
-	pte_num = sz >> hugepage_shift;
-	pgsize = 1 << hugepage_shift;
-
-	if (!pte_present(pte)) {
-		for (i = 0; i < pte_num; i++, ptep++, addr += pgsize)
-			set_ptes(mm, addr, ptep, pte, 1);
-		return;
-	}
-
-	if (!pte_napot(pte)) {
-		set_ptes(mm, addr, ptep, pte, 1);
-		return;
-	}
-
-	clear_flush(mm, addr, ptep, pgsize, pte_num);
-
-	set_ptes(mm, addr, ptep, pte, pte_num);
-}
-
 int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 			       unsigned long addr,
 			       pte_t *ptep,
diff --git a/mm/contpte.c b/mm/contpte.c
index e8574051d0b9..2320ee23478a 100644
--- a/mm/contpte.c
+++ b/mm/contpte.c
@@ -10,6 +10,8 @@
 /*
  * Any arch that wants to use that needs to define:
  *   - __ptep_get()
+ *   - __set_ptes()
+ *   - __ptep_get_and_clear()
  *   - pte_cont()
  *   - arch_contpte_get_num_contig()
  */
@@ -17,6 +19,7 @@
 /*
  * This file implements the following contpte aware API:
  *   - huge_ptep_get()
+ *   - set_huge_pte_at()
  */
 
 pte_t huge_ptep_get(pte_t *ptep)
@@ -43,3 +46,59 @@ pte_t huge_ptep_get(pte_t *ptep)
 	}
 	return orig_pte;
 }
+
+/*
+ * ARM64: Changing some bits of contiguous entries requires us to follow a
+ * Break-Before-Make approach, breaking the whole contiguous set
+ * before we can change any entries. See ARM DDI 0487A.k_iss10775,
+ * "Misprogramming of the Contiguous bit", page D4-1762.
+ *
+ * RISCV: When dealing with NAPOT mappings, the privileged specification
+ * indicates that "if an update needs to be made, the OS generally should first
+ * mark all of the PTEs invalid, then issue SFENCE.VMA instruction(s) covering
+ * all 4 KiB regions within the range, [...] then update the PTE(s), as
+ * described in Section 4.2.1.". That's the equivalent of the Break-Before-Make
+ * approach used by arm64.
+ *
+ * This helper performs the break step for use cases where the
+ * original pte is not needed.
+ */
+static void clear_flush(struct mm_struct *mm,
+			unsigned long addr,
+			pte_t *ptep,
+			unsigned long pgsize,
+			unsigned long ncontig)
+{
+	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
+	unsigned long i, saddr = addr;
+
+	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
+		__ptep_get_and_clear(mm, addr, ptep);
+
+	flush_tlb_range(&vma, saddr, addr);
+}
+
+void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
+		     pte_t *ptep, pte_t pte, unsigned long sz)
+{
+	size_t pgsize;
+	int i;
+	int ncontig;
+
+	ncontig = arch_contpte_get_num_contig(ptep, sz, &pgsize);
+
+	if (!pte_present(pte)) {
+		for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
+			__set_ptes(mm, addr, ptep, pte, 1);
+		return;
+	}
+
+	if (!pte_cont(pte)) {
+		__set_ptes(mm, addr, ptep, pte, 1);
+		return;
+	}
+
+	clear_flush(mm, addr, ptep, pgsize, ncontig);
+
+	set_contptes(mm, addr, ptep, pte, ncontig, pgsize);
+}
-- 
2.39.2


