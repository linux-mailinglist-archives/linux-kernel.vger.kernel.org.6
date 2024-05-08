Return-Path: <linux-kernel+bounces-173120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F998BFBCA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EB9F1F22B4A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C877A81AB2;
	Wed,  8 May 2024 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pxCGIJ8P"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BBC81AD0
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167183; cv=none; b=dRg0eBXIR+KFz3ZgfKOG7i6u8hR+SsIN9gn7OWmnq0npamjShcWIoQHIyI1WyqEm8e49I6juCV1k7lDHcQ5X6+4WOHdl1az4ZSl/nJeV6ysIi8UZNP7wqAAOqz3TxbQfqNkv3pHFV9MZzSUpGyhaj8Qjnwp0gFMhMlOKE/7nzng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167183; c=relaxed/simple;
	bh=8ZxiyUP5gIiH0WRirWNIF7sS4bbZ6hp/AtvYaVBucsk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pgQ8l1jKM5pXX1fB+rFBiCQFIDda3F253M631CHg2EUCBlbMASBhnPVkulc7xn/3HaCiW6XTw8GBebE6j4fdqPN1ugQc6XXYRcwxEmI8Nff+Fjyi+SI9CchYkuetVCS2ejqPjuy9k5jD5a1Gfy5d5B3FmO1YCJY0GdoQ5IHU0Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pxCGIJ8P; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-34d96054375so2596261f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 04:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715167178; x=1715771978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eptZ1TC6/9ugjFjSR/N9yJ6dEI/3FvKeew1j70YJt7s=;
        b=pxCGIJ8P8NUXFOICkN/3DIGJFggZ2WhP9cn1+ZVt5bqLyWV/3IuhxMIeNqGwwva/+t
         rOBXN5kG1o4GQXj0MaFxnSuCa218tYmt2eWZlXNFw7NUGjFY5hnmRifRMQAk7V1vxzSb
         CYHov4Ial2b/KBEKI19mm1YhvfvWmTDRNYdwSIwlRnkHu9drYDCsV0OybcolksUwLLPp
         Elsz6MvvdTbtN1hVXP/xTnpqjEj2OXUXSyFT3r9tYfw2SqP4eNzAnu5UnDRYZlZpA9Wb
         gN0jnaHxP+ftEl2jp+vXCs8MAiv/qJ2hwQ4LHoKG8jwLdw20Hop4UFWJcbZNBHkv2C5B
         ZrOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715167178; x=1715771978;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eptZ1TC6/9ugjFjSR/N9yJ6dEI/3FvKeew1j70YJt7s=;
        b=PMFPi0F9mEc/DuIYQoT8L+y4iFNhmtj2tWnEQxMLyztF+3XCu4X6nnwBJ/CxUSypex
         DQJ+jisW2c052cruRE2ypxMiPE3sy8Dvwtc9+y+TVU/LIXQbpsNrB4603im2CFJvEjxh
         d+LMODVSCF/5cbsQYF4AcD1vIOG32JMXbxJjxdu3pknhyOqNGKChYjE51mciVv3FyvtH
         CEKltCWjdL0jhov80LfgZe5aQ0ezovIwIg5egMfHQdazQqx8MV5Njx9qrr7+aPkBkiZT
         oXbh4dwD6IRQVLmHA/8zlLlR19CPxlsY4VfBmWfKuKxp5Ye7Jq6III/bbMtOBk6GH2Nc
         KBYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXAmQkeojmjSNFYPnBD2Ih1a+9SNdM/WweNqNy4sJWgW2F5271v+Fdwh+Zl6dm9A6VFP7DFJNmutfFzqz0Pw8CPXSaYVDBiKA7fpUU
X-Gm-Message-State: AOJu0YxUuqGwo5D4y+/y3CXW3GbVuFgBoiYGVW+5lOdd0fWEzqwBs/EO
	VKj+EfJBHA8nvaxVikYPCdp4IigeTc6+Y8QAKSFrb+Uk/lGeg/H2kCYNoKc3uek=
X-Google-Smtp-Source: AGHT+IHkzhqoYQlQehKFtJ3LJJ5+7RQutnDUAdNcSC3wCxgx+3uG7RvB8HMwIjEauHZgX9T5Lzrpyg==
X-Received: by 2002:adf:f7cb:0:b0:34d:f6c0:cc69 with SMTP id ffacd0b85a97d-34fca2446c2mr1975865f8f.41.1715167177905;
        Wed, 08 May 2024 04:19:37 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id q27-20020adfab1b000000b0034e24be18a1sm15242609wrc.15.2024.05.08.04.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 04:19:37 -0700 (PDT)
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
Subject: [PATCH v2 1/9] riscv: Restore the pfn in a NAPOT pte when manipulated by core mm code
Date: Wed,  8 May 2024 13:18:21 +0200
Message-Id: <20240508111829.16891-2-alexghiti@rivosinc.com>
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

The core mm code expects to be able to extract the pfn from a pte. NAPOT
mappings work differently since its ptes actually point to the first pfn
of the mapping, the other bits being used to encode the size of the
mapping.

So modify ptep_get() so that it returns a pte value that contains the
*real* pfn (which is then different from what the HW expects) and right
before storing the ptes to the page table, reset the pfn LSBs to the
size of the mapping.

And make sure that all NAPOT mappings are set using set_ptes().

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/pgtable-64.h |  11 +++
 arch/riscv/include/asm/pgtable.h    | 105 ++++++++++++++++++++++++++--
 arch/riscv/mm/hugetlbpage.c         |  38 +++++-----
 3 files changed, 128 insertions(+), 26 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 221a5c1ee287..9fe076fc503e 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -106,6 +106,17 @@ enum napot_cont_order {
 #define napot_cont_mask(order)	(~(napot_cont_size(order) - 1UL))
 #define napot_pte_num(order)	BIT(order)
 
+static inline bool is_napot_order(unsigned int order)
+{
+	unsigned int napot_order;
+
+	for_each_napot_order(napot_order)
+		if (order == napot_order)
+			return true;
+
+	return false;
+}
+
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
 #define HUGE_MAX_HSTATE		(2 + (NAPOT_ORDER_MAX - NAPOT_CONT_ORDER_BASE))
 #else
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 9f8ea0e33eb1..268c828f5152 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -297,6 +297,8 @@ static inline unsigned long pte_napot(pte_t pte)
 	return pte_val(pte) & _PAGE_NAPOT;
 }
 
+#define pte_valid_napot(pte)	(pte_present(pte) && pte_napot(pte))
+
 static inline pte_t pte_mknapot(pte_t pte, unsigned int order)
 {
 	int pos = order - 1 + _PAGE_PFN_SHIFT;
@@ -306,6 +308,12 @@ static inline pte_t pte_mknapot(pte_t pte, unsigned int order)
 	return __pte((pte_val(pte) & napot_mask) | napot_bit | _PAGE_NAPOT);
 }
 
+/* pte at entry must *not* encode the mapping size in the pfn LSBs. */
+static inline pte_t pte_clear_napot(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~_PAGE_NAPOT);
+}
+
 #else
 
 static __always_inline bool has_svnapot(void) { return false; }
@@ -315,17 +323,14 @@ static inline unsigned long pte_napot(pte_t pte)
 	return 0;
 }
 
+#define pte_valid_napot(pte)	false
+
 #endif /* CONFIG_RISCV_ISA_SVNAPOT */
 
 /* Yields the page frame number (PFN) of a page table entry */
 static inline unsigned long pte_pfn(pte_t pte)
 {
-	unsigned long res  = __page_val_to_pfn(pte_val(pte));
-
-	if (has_svnapot() && pte_napot(pte))
-		res = res & (res - 1UL);
-
-	return res;
+	return __page_val_to_pfn(pte_val(pte));
 }
 
 #define pte_page(x)     pfn_to_page(pte_pfn(x))
@@ -525,9 +530,91 @@ static inline void __set_pte_at(struct mm_struct *mm, pte_t *ptep, pte_t pteval)
 
 #define PFN_PTE_SHIFT		_PAGE_PFN_SHIFT
 
+#ifdef CONFIG_RISCV_ISA_SVNAPOT
+static inline int arch_contpte_get_num_contig(pte_t *ptep, unsigned long size,
+					      size_t *pgsize)
+{
+	pte_t __pte;
+
+	/* We must read the raw value of the pte to get the size of the mapping */
+	__pte = READ_ONCE(*ptep);
+
+	if (pgsize) {
+		if (size >= PGDIR_SIZE)
+			*pgsize = PGDIR_SIZE;
+		else if (size >= P4D_SIZE)
+			*pgsize = P4D_SIZE;
+		else if (size >= PUD_SIZE)
+			*pgsize = PUD_SIZE;
+		else if (size >= PMD_SIZE)
+			*pgsize = PMD_SIZE;
+		else
+			*pgsize = PAGE_SIZE;
+	}
+
+	/* Make sure __pte is not a swap entry */
+	if (pte_valid_napot(__pte))
+		return napot_pte_num(napot_cont_order(__pte));
+
+	return 1;
+}
+#endif
+
+static inline pte_t ptep_get(pte_t *ptep)
+{
+	pte_t pte = READ_ONCE(*ptep);
+
+#ifdef CONFIG_RISCV_ISA_SVNAPOT
+	/*
+	 * The pte we load has the N bit set and the size of the mapping in
+	 * the pfn LSBs: keep the N bit and replace the mapping size with
+	 * the *real* pfn since the core mm code expects to find it there.
+	 * The mapping size will be reset just before being written to the
+	 * page table in set_ptes().
+	 */
+	if (unlikely(pte_valid_napot(pte))) {
+		unsigned int order = napot_cont_order(pte);
+		int pos = order - 1 + _PAGE_PFN_SHIFT;
+		unsigned long napot_mask = ~GENMASK(pos, _PAGE_PFN_SHIFT);
+		pte_t *orig_ptep = PTR_ALIGN_DOWN(ptep, sizeof(*ptep) * napot_pte_num(order));
+
+		pte = __pte((pte_val(pte) & napot_mask) + ((ptep - orig_ptep) << _PAGE_PFN_SHIFT));
+	}
+#endif
+
+	return pte;
+}
+#define ptep_get	ptep_get
+
 static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 		pte_t *ptep, pte_t pteval, unsigned int nr)
 {
+#ifdef CONFIG_RISCV_ISA_SVNAPOT
+	if (unlikely(pte_valid_napot(pteval))) {
+		unsigned int order = ilog2(nr);
+
+		if (!is_napot_order(order)) {
+			/*
+			 * Something's weird, we are given a NAPOT pte but the
+			 * size of the mapping is not a known NAPOT mapping
+			 * size, so clear the NAPOT bit and map this without
+			 * NAPOT support: core mm only manipulates pte with the
+			 * real pfn so we know the pte is valid without the N
+			 * bit.
+			 */
+			pr_err("Incorrect NAPOT mapping, resetting.\n");
+			pteval = pte_clear_napot(pteval);
+		} else {
+			/*
+			 * NAPOT ptes that arrive here only have the N bit set
+			 * and their pfn does not contain the mapping size, so
+			 * set that here.
+			 */
+			pteval = pte_mknapot(pteval, order);
+		}
+	}
+#endif
+
 	page_table_check_ptes_set(mm, ptep, pteval, nr);
 
 	for (;;) {
@@ -535,6 +622,12 @@ static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 		if (--nr == 0)
 			break;
 		ptep++;
+
+#ifdef CONFIG_RISCV_ISA_SVNAPOT
+		if (unlikely(pte_valid_napot(pteval)))
+			continue;
+#endif
+
 		pte_val(pteval) += 1 << _PAGE_PFN_SHIFT;
 	}
 }
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index 5ef2a6891158..fe8067ee71b4 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -256,8 +256,7 @@ void set_huge_pte_at(struct mm_struct *mm,
 
 	clear_flush(mm, addr, ptep, pgsize, pte_num);
 
-	for (i = 0; i < pte_num; i++, ptep++, addr += pgsize)
-		set_pte_at(mm, addr, ptep, pte);
+	set_ptes(mm, addr, ptep, pte, pte_num);
 }
 
 int huge_ptep_set_access_flags(struct vm_area_struct *vma,
@@ -267,16 +266,16 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 			       int dirty)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	unsigned long order;
+	size_t pgsize;
 	pte_t orig_pte;
-	int i, pte_num;
+	int pte_num;
 
 	if (!pte_napot(pte))
 		return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
 
-	order = napot_cont_order(pte);
-	pte_num = napot_pte_num(order);
-	ptep = huge_pte_offset(mm, addr, napot_cont_size(order));
+	pte_num = arch_contpte_get_num_contig(ptep, 0, &pgsize);
+	ptep = huge_pte_offset(mm, addr, pte_num * pgsize);
+
 	orig_pte = get_clear_contig_flush(mm, addr, ptep, pte_num);
 
 	if (pte_dirty(orig_pte))
@@ -285,8 +284,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	if (pte_young(orig_pte))
 		pte = pte_mkyoung(pte);
 
-	for (i = 0; i < pte_num; i++, addr += PAGE_SIZE, ptep++)
-		set_pte_at(mm, addr, ptep, pte);
+	set_ptes(mm, addr, ptep, pte, pte_num);
 
 	return true;
 }
@@ -301,7 +299,7 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 	if (!pte_napot(orig_pte))
 		return ptep_get_and_clear(mm, addr, ptep);
 
-	pte_num = napot_pte_num(napot_cont_order(orig_pte));
+	pte_num = arch_contpte_get_num_contig(ptep, 0, NULL);
 
 	return get_clear_contig(mm, addr, ptep, pte_num);
 }
@@ -311,24 +309,23 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 			     pte_t *ptep)
 {
 	pte_t pte = ptep_get(ptep);
-	unsigned long order;
+	size_t pgsize;
 	pte_t orig_pte;
-	int i, pte_num;
+	int pte_num;
 
 	if (!pte_napot(pte)) {
 		ptep_set_wrprotect(mm, addr, ptep);
 		return;
 	}
 
-	order = napot_cont_order(pte);
-	pte_num = napot_pte_num(order);
-	ptep = huge_pte_offset(mm, addr, napot_cont_size(order));
+	pte_num = arch_contpte_get_num_contig(ptep, 0, &pgsize);
+	ptep = huge_pte_offset(mm, addr, pte_num * pgsize);
+
 	orig_pte = get_clear_contig_flush(mm, addr, ptep, pte_num);
 
 	orig_pte = pte_wrprotect(orig_pte);
 
-	for (i = 0; i < pte_num; i++, addr += PAGE_SIZE, ptep++)
-		set_pte_at(mm, addr, ptep, orig_pte);
+	set_ptes(mm, addr, ptep, orig_pte, pte_num);
 }
 
 pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
@@ -341,7 +338,7 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 	if (!pte_napot(pte))
 		return ptep_clear_flush(vma, addr, ptep);
 
-	pte_num = napot_pte_num(napot_cont_order(pte));
+	pte_num = arch_contpte_get_num_contig(ptep, 0, NULL);
 
 	return get_clear_contig_flush(vma->vm_mm, addr, ptep, pte_num);
 }
@@ -351,6 +348,7 @@ void huge_pte_clear(struct mm_struct *mm,
 		    pte_t *ptep,
 		    unsigned long sz)
 {
+	size_t pgsize;
 	pte_t pte = ptep_get(ptep);
 	int i, pte_num;
 
@@ -359,8 +357,8 @@ void huge_pte_clear(struct mm_struct *mm,
 		return;
 	}
 
-	pte_num = napot_pte_num(napot_cont_order(pte));
-	for (i = 0; i < pte_num; i++, addr += PAGE_SIZE, ptep++)
+	pte_num = arch_contpte_get_num_contig(ptep, 0, &pgsize);
+	for (i = 0; i < pte_num; i++, addr += pgsize, ptep++)
 		pte_clear(mm, addr, ptep);
 }
 
-- 
2.39.2


