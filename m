Return-Path: <linux-kernel+bounces-173156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16C778BFC47
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3621F23EB2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EDF82D89;
	Wed,  8 May 2024 11:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ln/UXvkP"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A15A82D82
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168312; cv=none; b=INgoJyQCz5sbcBqSmyKWQYmahlc/XAGhI4e7lZRBsF63LMOhiOoQ4yT/J/gcp2SEyLvKraemzbCd4/nVIPvlHvzsGaEete8VJ5NPOZ6LxKzwXydvsptrT4OtjbcAXmLfhB/M9AJN/DQ1ZKYVoRsmORQP1NsiHd5yqin8sV5TpS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168312; c=relaxed/simple;
	bh=b2CmOyaFaiwbt6cdUwy4Ez0JGf0aumlKPqvfskmokMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X5OCy3Jq+CSH51R4gnWvMscfC7HCTIlFTr42c6Nst+O8/T0ske70jMIjHryfFjwGFrEEFF9PyTSxEJYCEtUjB4HlnQGMLf46uuXTd4BlfMi2ym8wT/b9L5E2ZbD3yhgFmpVzWZ7w237m2j4ZNsEH+0I2uFcjfWcyIjiFkJR93bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ln/UXvkP; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4196c62bb4eso31778035e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 04:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715168309; x=1715773109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9tID4t35K2Xq8XfdKgfehJoKp8xw/RZTmJgN0BGYZu8=;
        b=ln/UXvkPw3KSLnnI5/btG1hIpsahkUOfABjcGqm+WqW8P2XgTwVpqw9+zolPUd/BMD
         3N7mjPo3xKnfe0yn3EQ8HFg2GlBZxCuFIw240YDqAOQ0JZzC2SYBOAfTVR7SKflVmp3+
         ldllXJ6cuXTQ874RrpZim/AhLHsJX6oSwVOiyN9HOeUFLFXpwAgiL8RXa/+gIu0C0U1M
         7bPJv7zLXW8A+v9k5vH6BLz0aht2IMz8K+L8eJGTgRiR7a1ANUJInWwCNC6z2C/0vyVy
         nCUT3IK4Gqjahu261iAGFyXnzugHOQiNIjTDZ2qqUTIkhSNcKBjkOSrKWsJ4Y9TTT6+u
         lamA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715168309; x=1715773109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9tID4t35K2Xq8XfdKgfehJoKp8xw/RZTmJgN0BGYZu8=;
        b=BxjFCEGXMpQvKzQZDiVYG9TZbBSWSPUa2jYSJnPfo77qcp0iOALyAVJYkUTCjtWVZ7
         p8Tc/sC1IiaGYi2qShpPE+vSmdzN7rZE4sNKYv2nX1v3lJN5TJYPrTe0uAohAbVILUvc
         09iKfzDRbtrxz4c6rpnUobae3eQT+LhvFm9RAwSETyfZvP5koZRN9BEnipPnm8dtmWki
         7IIkXy7QOul5dZ/N/38tQNYU/uV1jWJCXGP2MZzEuMEmpWG0zz4gGNmRDsbA1QAWdXmR
         pngtS0jueXiTWl/pdU5giKwUh29PYnPff5eGiAyFLzVnzq1Ne6MSpIjYAwihmoF5AIIF
         /kCw==
X-Forwarded-Encrypted: i=1; AJvYcCXPfr770IE9LfsHMTeK8um+LRojF8+Z36fmB1+7RfPK6tN/zDOmxYqgoy8Vhi1Gaq7mlfr7GiSLD87D0lbMCDeWm2Bw04k1mjp/XQnG
X-Gm-Message-State: AOJu0Yx6KzqJ0n9xlda1DPvVliKCzRPDUEwMQXudGroUBz9VEw2VoTAx
	LEPPSn8326loVdqmCDR2+CSqzEzONPzbHxNFMvZOGfRJ1G+GcXKWUCGsgIyWzhU=
X-Google-Smtp-Source: AGHT+IFc73xLy956G8LkxzJy48Vpp254D4XfW/OPcYqIx5DwErIqgJZXPvuWYs+kahkVNUCZ42Avig==
X-Received: by 2002:a05:600c:444e:b0:41b:935:24a9 with SMTP id 5b1f17b1804b1-41f714fbe0amr19186605e9.24.1715168308900;
        Wed, 08 May 2024 04:38:28 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87d20214sm20234005e9.24.2024.05.08.04.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 04:38:28 -0700 (PDT)
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
Subject: [PATCH RESEND v2 4/9] mm: Use common set_huge_pte_at() function for riscv/arm64
Date: Wed,  8 May 2024 13:34:14 +0200
Message-Id: <20240508113419.18620-5-alexghiti@rivosinc.com>
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


