Return-Path: <linux-kernel+bounces-571309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5780A6BB91
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 558B11888D95
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F948229B29;
	Fri, 21 Mar 2025 13:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="rgiQaPpp"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9512A1CAA81
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742562955; cv=none; b=JNZhhDOfOTCiGXH4LMGf/Hi9C6lPa2CRgeDGgKRZUGl3yOa1FmDFja2bCi4j+6HquVhVL0wd6pHNn4qFxOKLduhNCV5o8kAI/u8A/66jFT+vmKWDCcYOHOnls+L+X0xlIlAsfGJaKQlPY/ooBxhIFejfpLFH+zM2NR3P7k+Tk/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742562955; c=relaxed/simple;
	bh=XZb4/7ED/yOzxaYKXsmRsh+ALKUE7iBR0oHSgbefUGA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cqWSwMnPb5EhKpgUeiaSvdLLH9l17nTFKG654TUxmH0t1/Q6AQ9JVBD9guqBY9NLTrmUGeCJJ6upQDCf948TDYvpj7l8bKC9Ojf+ZkkXa+tS3mdYfOAnAl4YrgCMWv8tW75qUekAbXtYlohTmz42ISo4Jtq7vN6Xb0BCtnpzHyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=rgiQaPpp; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4394a823036so19480765e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742562952; x=1743167752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vd9K/fWiMAnzVZgWbX0wvtztqz4Hm8uA/kr1foq/koQ=;
        b=rgiQaPppG2pz/Yd077kDMO7ash9l4bOZw52TLn218EugReSkYfezU211Sd1dTrwboy
         mlRNXKBSNMNllmxOj08R0EHZM67YZ/ehU3fvlnzBFoFeXmDGW7dXscfo6xX/mvVrv6LU
         kpRIHZ38Ig4NxUltfFvE1o/eaCq+6DrX4TKSplx2RXifgZ+tTifKthGhUerzWkYG3AF+
         aP8FGhbIyZhjHnfw8W0fgrN8mU17QJQ6S7FSd3jmuOkASge+yzjoAItIQY4ZKi9hT4Xp
         K0f08bie8q9OdA1xVEiEAirHyJ02fXDaTka2SJgpIy2i+EzWPcreH3R/01ImSJ7s4dRr
         y0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742562952; x=1743167752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vd9K/fWiMAnzVZgWbX0wvtztqz4Hm8uA/kr1foq/koQ=;
        b=IfPBOG456tynxTOdFJOXIhC9WCkFQ50pEeGQjYFaTldZU1JlUVEpuWDJwBnRhaBHLs
         ON8FVYKXGnOGn6XimZqR0ml3lvVIrf/zqW7zxKdn2tOLzELWIV1yM2KG63JP27GwDVE8
         rNKJc1k5sImX3U5+zv6eWi9AM5ZNG6KQzYIvSnFZm5gSAOcq6Lad4pU/rRn1bxKW4bs7
         9ZaMgVXNTc9Hsl5IsjPoNQnqjKAr6HiMxIv/KlOeEV9LkUL37BBSFGMMuaxd5co+J0mJ
         cJ5xIufA4tG2Y7FJKr+XTOo9hKl3pTS7XPxlUB9l1fs1h93HHl5vsJKXVkP3qacf+kpr
         sksw==
X-Forwarded-Encrypted: i=1; AJvYcCXClUWgJIt85yoqaejfSulDdpjdkYVU4rsdL1FC625A3EeJAQ+weeOxJRg/ECBKQgBSOEuln/NAjRDfXC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyxf6xDYCK0Rx5/qnyIlQEGm9XeV08DQ6kKrmdVQ2L72W46xDmG
	wD4Em7yRrBLrOid5IscTEtxpxa4OauhmotPDoSTFHykW2NNszK7e4h9nf3c3Svo=
X-Gm-Gg: ASbGnctmtNxloxOl8ro+evzq9/325Qu9/w8XLLVEsUECs8eXv9P2g7aDxCMYqtg8Rpw
	21ybnkbdiz2FiBtXxQg/iXbUcjFxyNmG+vl0C+59w7h9lP5T8TX8CNhY+Mivvk/9H1tNAoWmb08
	99rW9HXzZXkvo8doOnmuHE1Xtk7TpdpTthXZluDz6p8RkNE0G/bVF09ObvmnD9b7shdyasbFeMw
	B3Cvmu/ihRD4TEXNioFND8W5edDAJEY1IxV262c+umXY4k6K3VhuUE/k3uFXB64m6kC04CEJo7h
	hDlKk09NRn33HiRPiExtyRBlCNxcSfE8Xtgjkb6PZatgpTmfIZSQ1ZfykAG/EonnlGgBHQ==
X-Google-Smtp-Source: AGHT+IEeSuJJCualMyRGxNrWV663ipohlvvxYL4TpbesKMPlj8TlM2yLM3TCv4QBVXMIE7MjteYhiA==
X-Received: by 2002:a05:600c:83cf:b0:43c:ec28:d310 with SMTP id 5b1f17b1804b1-43d509ec838mr36046425e9.10.1742562951783;
        Fri, 21 Mar 2025 06:15:51 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com ([2001:861:3382:ef90:3d12:52fe:c1cc:c94])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d4fdb06b9sm26435515e9.36.2025.03.21.06.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 06:15:51 -0700 (PDT)
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
Subject: [PATCH v5 9/9] mm: Use common huge_ptep_clear_flush() function for riscv/arm64
Date: Fri, 21 Mar 2025 14:06:35 +0100
Message-Id: <20250321130635.227011-10-alexghiti@rivosinc.com>
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
 arch/arm64/include/asm/hugetlb.h |  3 --
 arch/arm64/mm/hugetlbpage.c      | 60 --------------------------------
 arch/riscv/include/asm/hugetlb.h |  7 +---
 arch/riscv/mm/hugetlbpage.c      | 54 ----------------------------
 include/linux/hugetlb_contpte.h  |  4 +++
 mm/hugetlb_contpte.c             | 14 ++++++++
 6 files changed, 19 insertions(+), 123 deletions(-)

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index f568467e8ba2..368600764127 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -35,9 +35,6 @@ static inline void arch_clear_hugetlb_flags(struct folio *folio)
 
 pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags);
 #define arch_make_huge_pte arch_make_huge_pte
-#define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
-extern pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
-				   unsigned long addr, pte_t *ptep);
 
 void __init arm64_hugetlb_cma_reserve(void);
 
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 17f1ed34356d..08316cf4b104 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -82,52 +82,6 @@ int find_num_contig(struct mm_struct *mm, unsigned long addr,
 	return CONT_PTES;
 }
 
-/*
- * Changing some bits of contiguous entries requires us to follow a
- * Break-Before-Make approach, breaking the whole contiguous set
- * before we can change any entries. See ARM DDI 0487A.k_iss10775,
- * "Misprogramming of the Contiguous bit", page D4-1762.
- *
- * This helper performs the break step.
- */
-static pte_t get_clear_contig(struct mm_struct *mm,
-			     unsigned long addr,
-			     pte_t *ptep,
-			     unsigned long pgsize,
-			     unsigned long ncontig)
-{
-	pte_t pte, tmp_pte;
-	bool present;
-
-	pte = __ptep_get_and_clear(mm, addr, ptep);
-	present = pte_present(pte);
-	while (--ncontig) {
-		ptep++;
-		addr += pgsize;
-		tmp_pte = __ptep_get_and_clear(mm, addr, ptep);
-		if (present) {
-			if (pte_dirty(tmp_pte))
-				pte = pte_mkdirty(pte);
-			if (pte_young(tmp_pte))
-				pte = pte_mkyoung(pte);
-		}
-	}
-	return pte;
-}
-
-static pte_t get_clear_contig_flush(struct mm_struct *mm,
-				    unsigned long addr,
-				    pte_t *ptep,
-				    unsigned long pgsize,
-				    unsigned long ncontig)
-{
-	pte_t orig_pte = get_clear_contig(mm, addr, ptep, pgsize, ncontig);
-	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
-
-	flush_tlb_range(&vma, addr, addr + (pgsize * ncontig));
-	return orig_pte;
-}
-
 pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, unsigned long sz)
 {
@@ -260,20 +214,6 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 	return entry;
 }
 
-pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
-			    unsigned long addr, pte_t *ptep)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	size_t pgsize;
-	int ncontig;
-
-	if (!pte_cont(__ptep_get(ptep)))
-		return ptep_clear_flush(vma, addr, ptep);
-
-	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
-	return get_clear_contig_flush(mm, addr, ptep, pgsize, ncontig);
-}
-
 static int __init hugetlbpage_init(void)
 {
 	/*
diff --git a/arch/riscv/include/asm/hugetlb.h b/arch/riscv/include/asm/hugetlb.h
index 4c692dd82779..63c7e4fa342a 100644
--- a/arch/riscv/include/asm/hugetlb.h
+++ b/arch/riscv/include/asm/hugetlb.h
@@ -20,14 +20,9 @@ bool arch_hugetlb_migration_supported(struct hstate *h);
 #endif
 
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
-#define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
-pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
-			    unsigned long addr, pte_t *ptep);
-
 pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags);
 #define arch_make_huge_pte arch_make_huge_pte
-
-#endif /*CONFIG_RISCV_ISA_SVNAPOT*/
+#endif /* CONFIG_RISCV_ISA_SVNAPOT */
 
 #include <asm-generic/hugetlb.h>
 
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index db13f7bcdd54..a6176415432a 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -121,45 +121,6 @@ unsigned long hugetlb_mask_last_page(struct hstate *h)
 	return 0UL;
 }
 
-static pte_t get_clear_contig(struct mm_struct *mm,
-			      unsigned long addr,
-			      pte_t *ptep,
-			      unsigned long ncontig)
-{
-	pte_t pte, tmp_pte;
-	bool present;
-
-	pte = ptep_get_and_clear(mm, addr, ptep);
-	present = pte_present(pte);
-	while (--ncontig) {
-		ptep++;
-		addr += PAGE_SIZE;
-		tmp_pte = ptep_get_and_clear(mm, addr, ptep);
-		if (present) {
-			if (pte_dirty(tmp_pte))
-				pte = pte_mkdirty(pte);
-			if (pte_young(tmp_pte))
-				pte = pte_mkyoung(pte);
-		}
-	}
-	return pte;
-}
-
-static pte_t get_clear_contig_flush(struct mm_struct *mm,
-				    unsigned long addr,
-				    pte_t *ptep,
-				    unsigned long pte_num)
-{
-	pte_t orig_pte = get_clear_contig(mm, addr, ptep, pte_num);
-	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
-	bool valid = !pte_none(orig_pte);
-
-	if (valid)
-		flush_tlb_range(&vma, addr, addr + (PAGE_SIZE * pte_num));
-
-	return orig_pte;
-}
-
 pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 {
 	unsigned long order;
@@ -176,21 +137,6 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 	return entry;
 }
 
-pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
-			    unsigned long addr,
-			    pte_t *ptep)
-{
-	pte_t pte = ptep_get(ptep);
-	int pte_num;
-
-	if (!pte_napot(pte))
-		return ptep_clear_flush(vma, addr, ptep);
-
-	pte_num = arch_contpte_get_num_contig(vma->vm_mm, addr, ptep, 0, NULL);
-
-	return get_clear_contig_flush(vma->vm_mm, addr, ptep, pte_num);
-}
-
 static bool is_napot_size(unsigned long size)
 {
 	unsigned long order;
diff --git a/include/linux/hugetlb_contpte.h b/include/linux/hugetlb_contpte.h
index 9ec8792a2f4d..e217a3412b13 100644
--- a/include/linux/hugetlb_contpte.h
+++ b/include/linux/hugetlb_contpte.h
@@ -32,4 +32,8 @@ extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 extern void huge_ptep_set_wrprotect(struct mm_struct *mm,
 				    unsigned long addr, pte_t *ptep);
 
+#define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
+extern pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
+				   unsigned long addr, pte_t *ptep);
+
 #endif /* _LINUX_HUGETLB_CONTPTE_H */
diff --git a/mm/hugetlb_contpte.c b/mm/hugetlb_contpte.c
index 629878765081..1dc211d6fbe1 100644
--- a/mm/hugetlb_contpte.c
+++ b/mm/hugetlb_contpte.c
@@ -242,3 +242,17 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 
 	set_contptes(mm, addr, ptep, pte, ncontig, pgsize);
 }
+
+pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
+			    unsigned long addr, pte_t *ptep)
+{
+	struct mm_struct *mm = vma->vm_mm;
+	size_t pgsize;
+	int ncontig;
+
+	if (!pte_cont(__ptep_get(ptep)))
+		return ptep_clear_flush(vma, addr, ptep);
+
+	ncontig = arch_contpte_get_num_contig(mm, addr, ptep, 0, &pgsize);
+	return get_clear_contig_flush(mm, addr, ptep, pgsize, ncontig);
+}
-- 
2.39.2


