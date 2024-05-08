Return-Path: <linux-kernel+bounces-173131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B317D8BFBEB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 427FB1F2236C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DD981ABF;
	Wed,  8 May 2024 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="dDOFrl+K"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D954C61F
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167487; cv=none; b=A8OK4fGWBKGRzReJybim3d9D5t8xQc9tvZ/0BGkSySTVKzkxE8cqkUqChbNhgHYId4YB+xMS/vEgIH4H9F7iYWLzufrL1MSeVEKYC9N4v6E67Jmb3G0rkXuevSjvf2TXyrNLNCs0cZ1R203lZa3QMxB/45kgUGnr9LkZeel2Alc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167487; c=relaxed/simple;
	bh=VABY+Ba0JMwODv7U/E8RCXCu+cNtq0sU3lmtzPLVeMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JXZx9zsxCtz7HLkLmvNY8aUo9LrgwHiUo9icIHSjEmndyJQuUI5cFHRXwj/CQ6rokx4b0xtiOB9UoPDgPGdYlwolv6amtVEMVpdTbFKLcB77dFu6NdyYlvh5cDDwsRRxP1YTLvDaf2M0ZlNbcNEVtSyDfSofIxTUTjY4s4z4hxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=dDOFrl+K; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34e0d8b737eso429966f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 04:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715167484; x=1715772284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7TbOelFCBPjD//aDEZ907vn9YCYdQxapVfhTuFqwGo=;
        b=dDOFrl+KtxyDvi3pnN6m+o8CSoO9AHR6OezIezR0N+v1dcZeUhIY7yRl/DUS++53UP
         q1RYmmEeL/vnnqt4XEh8eqdwDQjNf99z3QLBkfJIaiq23fj5ovFt4BRxmcj1TLc3Dlvs
         8RwzGjlNQA4hLTsgFYTRK2AnBm1DdgzDQLPPd4pAIGZyk5Ffrsq/coaZaMp4DiL5x76r
         LYS/Ms1nYIxS53SUrVBHvaXdAa4QVUbsIAre8gsVk3FYRgAlt0/GMHZJUR3PpAw3EQ8F
         PuNAytbHDTsEo6tA6iEvYIYduEEyVVwu5W/xnDPHyXUBZlVLOJo7KnX/AL2KcERzBm7e
         ZZ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715167484; x=1715772284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7TbOelFCBPjD//aDEZ907vn9YCYdQxapVfhTuFqwGo=;
        b=uou6KV7M2Tx1Bp1y4yiHO32hf6qBMlH8yrH8dzU0w72ihjbNrFW2DeFdPPOhb3OQjo
         PEgOEwtrZFtUOBylZMXgunZYO7638kZvGpMDVh1UpFmKvDGVsH50zyS0ivWHMsa0kKzf
         ex+hd/kcBZj3H97MdxjyyLWp+kw2i7qcVuCqA+rJgGeIcEGJ0hUz0dzXrL0+a/QChHgM
         bSgcxA/y/VqscSiPXeRA8CG6cvs62ZiqF6aN4GU5+tlVyvqfop3vbxca5LxeDZcWUU/2
         GG2Gjx3rdMQRfJePr8J5fA8typZDzIlSRNUJ5FbezgENj4fo3VT18sNUoNtpFXTImGoY
         Vkuw==
X-Forwarded-Encrypted: i=1; AJvYcCUSgq0BBxkHX1pkIbN3CwMpMMFVnMq1tYWAmg2sJ6TeAWcxXBtDnUF2P3iodYIsHdjhj9fEiu/bWMjPmLZwnXmd7QevxsTHYuwH3Caa
X-Gm-Message-State: AOJu0YyPn3ibh4feGtS9OaFigttM4QPCpBzodrDAoFbgFKWP6bzauc5J
	U+T9d6IoGyFlHGKr593sdCVODxblpnxk6gIF8ww5U2Z297jsqTUJNeqlDLekwJ8=
X-Google-Smtp-Source: AGHT+IGIT5fRmSU5mTHAtfUSvBO8bSYE3S8hCevxI+ZKnPLL6EPNP04SFEUKamUPrL/Drlv8BwdKKg==
X-Received: by 2002:a5d:6d52:0:b0:34d:b3a0:5614 with SMTP id ffacd0b85a97d-34fca4326b6mr2190198f8f.8.1715167483962;
        Wed, 08 May 2024 04:24:43 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id dn15-20020a0560000c0f00b0034d9012e74bsm15257565wrb.72.2024.05.08.04.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 04:24:43 -0700 (PDT)
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
Subject: [PATCH v2 6/9] mm: Use common huge_ptep_get_and_clear() function for riscv/arm64
Date: Wed,  8 May 2024 13:18:26 +0200
Message-Id: <20240508111829.16891-7-alexghiti@rivosinc.com>
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
so move it to the generic code.

Note that get_clear_contig() function is duplicated in the generic and
the arm64 code because it is still used by some arm64 functions that
will, in the next commits, be moved to the generic code. Once all have
been moved, the arm64 version will be removed.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/arm64/include/asm/pgtable.h | 14 +++++++++-
 arch/arm64/mm/hugetlbpage.c      | 19 ++-----------
 arch/riscv/include/asm/pgtable.h |  4 ++-
 arch/riscv/mm/hugetlbpage.c      | 21 ++------------
 mm/contpte.c                     | 48 ++++++++++++++++++++++++++++++--
 5 files changed, 66 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 2e0415fd5083..7c2938cb70b9 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1644,11 +1644,23 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
 
 #endif /* CONFIG_ARM64_CONTPTE */
 
-static inline int arch_contpte_get_num_contig(pte_t *ptep, unsigned long size,
+int find_num_contig(struct mm_struct *mm, unsigned long addr,
+		    pte_t *ptep, size_t *pgsize);
+
+static inline int arch_contpte_get_num_contig(struct mm_struct *mm,
+					      unsigned long addr,
+					      pte_t *ptep, unsigned long size,
 					      size_t *pgsize)
 {
 	int contig_ptes = 0;
 
+	/*
+	 * If the size is not passed, we need to go through the page table to
+	 * find out the number of contiguous ptes.
+	 */
+	if (size == 0)
+		return find_num_contig(mm, addr, ptep, pgsize);
+
 	*pgsize = size;
 
 	switch (size) {
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index cf44837369be..5ace4bf7ce35 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -93,8 +93,8 @@ int pud_huge(pud_t pud)
 #endif
 }
 
-static int find_num_contig(struct mm_struct *mm, unsigned long addr,
-			   pte_t *ptep, size_t *pgsize)
+int find_num_contig(struct mm_struct *mm, unsigned long addr,
+		    pte_t *ptep, size_t *pgsize)
 {
 	pgd_t *pgdp = pgd_offset(mm, addr);
 	p4d_t *p4dp;
@@ -277,21 +277,6 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 	return entry;
 }
 
-pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-			      unsigned long addr, pte_t *ptep)
-{
-	int ncontig;
-	size_t pgsize;
-	pte_t orig_pte = __ptep_get(ptep);
-
-	if (!pte_cont(orig_pte))
-		return __ptep_get_and_clear(mm, addr, ptep);
-
-	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
-
-	return get_clear_contig(mm, addr, ptep, pgsize, ncontig);
-}
-
 /*
  * huge_ptep_set_access_flags will update access flags (dirty, accesssed)
  * and write permission.
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 0847a7fb8661..d976113a370d 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -532,7 +532,9 @@ static inline void __set_pte_at(struct mm_struct *mm, pte_t *ptep, pte_t pteval)
 #define PFN_PTE_SHIFT		_PAGE_PFN_SHIFT
 
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
-static inline int arch_contpte_get_num_contig(pte_t *ptep, unsigned long size,
+static inline int arch_contpte_get_num_contig(struct mm_struct *mm,
+					      unsigned long addr,
+					      pte_t *ptep, unsigned long size,
 					      size_t *pgsize)
 {
 	unsigned long hugepage_shift;
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index 437b1df059eb..a757e0b2f090 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -187,7 +187,7 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	if (!pte_napot(pte))
 		return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
 
-	pte_num = arch_contpte_get_num_contig(ptep, 0, &pgsize);
+	pte_num = arch_contpte_get_num_contig(vma->vm_mm, addr, ptep, 0, &pgsize);
 
 	orig_pte = get_clear_contig_flush(mm, addr, ptep, pte_num);
 
@@ -202,21 +202,6 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	return true;
 }
 
-pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-			      unsigned long addr,
-			      pte_t *ptep)
-{
-	pte_t orig_pte = ptep_get(ptep);
-	int pte_num;
-
-	if (!pte_napot(orig_pte))
-		return ptep_get_and_clear(mm, addr, ptep);
-
-	pte_num = arch_contpte_get_num_contig(ptep, 0, NULL);
-
-	return get_clear_contig(mm, addr, ptep, pte_num);
-}
-
 void huge_ptep_set_wrprotect(struct mm_struct *mm,
 			     unsigned long addr,
 			     pte_t *ptep)
@@ -231,7 +216,7 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 		return;
 	}
 
-	pte_num = arch_contpte_get_num_contig(ptep, 0, &pgsize);
+	pte_num = arch_contpte_get_num_contig(mm, addr, ptep, 0, &pgsize);
 
 	orig_pte = get_clear_contig_flush(mm, addr, ptep, pte_num);
 	orig_pte = pte_wrprotect(orig_pte);
@@ -249,7 +234,7 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 	if (!pte_napot(pte))
 		return ptep_clear_flush(vma, addr, ptep);
 
-	pte_num = arch_contpte_get_num_contig(ptep, 0, NULL);
+	pte_num = arch_contpte_get_num_contig(vma->vm_mm, addr, ptep, 0, NULL);
 
 	return get_clear_contig_flush(vma->vm_mm, addr, ptep, pte_num);
 }
diff --git a/mm/contpte.c b/mm/contpte.c
index 22e0de197bd3..68eb1634b922 100644
--- a/mm/contpte.c
+++ b/mm/contpte.c
@@ -22,6 +22,7 @@
  *   - huge_ptep_get()
  *   - set_huge_pte_at()
  *   - huge_pte_clear()
+ *   - huge_ptep_get_and_clear()
  */
 
 pte_t huge_ptep_get(pte_t *ptep)
@@ -33,7 +34,7 @@ pte_t huge_ptep_get(pte_t *ptep)
 	if (!pte_present(orig_pte) || !pte_cont(orig_pte))
 		return orig_pte;
 
-	ncontig = arch_contpte_get_num_contig(ptep,
+	ncontig = arch_contpte_get_num_contig(NULL, 0, ptep,
 					      page_size(pte_page(orig_pte)),
 					      &pgsize);
 
@@ -87,7 +88,7 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 	int i;
 	int ncontig;
 
-	ncontig = arch_contpte_get_num_contig(ptep, sz, &pgsize);
+	ncontig = arch_contpte_get_num_contig(mm, addr, ptep, sz, &pgsize);
 
 	if (!pte_present(pte)) {
 		for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
@@ -111,8 +112,49 @@ void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 	int i, ncontig;
 	size_t pgsize;
 
-	ncontig = arch_contpte_get_num_contig(ptep, sz, &pgsize);
+	ncontig = arch_contpte_get_num_contig(mm, addr, ptep, sz, &pgsize);
 
 	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
 		__pte_clear(mm, addr, ptep);
 }
+
+static pte_t get_clear_contig(struct mm_struct *mm,
+			      unsigned long addr,
+			      pte_t *ptep,
+			      unsigned long pgsize,
+			      unsigned long ncontig)
+{
+	pte_t orig_pte = __ptep_get(ptep);
+	unsigned long i;
+
+	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++) {
+		pte_t pte = __ptep_get_and_clear(mm, addr, ptep);
+
+		/*
+		 * If HW_AFDBM (arm64) or svadu (riscv) is enabled, then the HW
+		 * could turn on the dirty or accessed bit for any page in the
+		 * set, so check them all.
+		 */
+		if (pte_dirty(pte))
+			orig_pte = pte_mkdirty(orig_pte);
+
+		if (pte_young(pte))
+			orig_pte = pte_mkyoung(orig_pte);
+	}
+	return orig_pte;
+}
+
+pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
+			      unsigned long addr, pte_t *ptep)
+{
+	int ncontig;
+	size_t pgsize;
+	pte_t orig_pte = __ptep_get(ptep);
+
+	if (!pte_cont(orig_pte))
+		return __ptep_get_and_clear(mm, addr, ptep);
+
+	ncontig = arch_contpte_get_num_contig(mm, addr, ptep, 0, &pgsize);
+
+	return get_clear_contig(mm, addr, ptep, pgsize, ncontig);
+}
-- 
2.39.2


