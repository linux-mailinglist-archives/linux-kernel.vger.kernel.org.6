Return-Path: <linux-kernel+bounces-173171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E818BFC83
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6472814C3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795DB839FF;
	Wed,  8 May 2024 11:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="JxamP8QS"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D9984A28
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168620; cv=none; b=Drp+rbFcLfIeg7ZzGXy2G4znk8i1qHqbRWej4nzh2fSuFCHQKskEmaqNsySZpl++gAj6JhKGfl0L8/ELlYn9qAxZe0EtxkJJdC37Uekd4w0X3cWZb+gQPJGoC04Tcp6xggBRxM/4YcfG6OAam32hq+GoQODGvtXCIQ1KQuWLg6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168620; c=relaxed/simple;
	bh=hNesfuK+7JIeLYO6AXmKPce2DdNjYSYJbeDcMnRQMlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gXoCeWdhvV93UgAf313MsfBFfIQz4qNetStulomFeMraP+c1Rl/lUVEtzWrDiefGDcloGEyKvULnRvunMsX+ObVrRuaYfxBdsQd7Yab/nkdNHXF2m6tyvgFfzxTinVvvnhpKYKlhXFMEEZmbAzMBFl/OuFA43fEebA6a218ewmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=JxamP8QS; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2e1fa1f1d9bso81630371fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 04:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715168617; x=1715773417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkDF3kPVXJf4AqMK0ZqTYH7UgAMmNVObdoVU0G1Ynu8=;
        b=JxamP8QSOX0cao4lrZocsBN/0YmbbhqLRJpqYeGq/P8Ck6QmTe8ultgnakKHFSFCT6
         PYyXVdyEVSBbP++jzURncN25n0uZ1ljISKJnE6Vi4hPFPUd8fU0O4r7HVSZgYWMXB7Dh
         zQd0nF7py0qSowBF+HFFbT7z3+IP9pVfl0+4+N7j0nm3sqeMlAfm5pCzZo8QmOdU8UTq
         eU5EGWtnbZwVnFvT/cSz36S2rQ5HzBEcsNyIW6+YQpXa+x2bKihGa/KFsxEkElXxif3I
         gi9iUiawUUcRDDDbBtQmgaSxuYJjfc3LFYhRiQzfayK/b/I/NFWynV6iZQ3l1/ZH6laR
         UWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715168617; x=1715773417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zkDF3kPVXJf4AqMK0ZqTYH7UgAMmNVObdoVU0G1Ynu8=;
        b=UdEZlelLij8dqVBfsuIxrBTH90wKGOnrg3E/SdZGrk5QiXpN4a+fnseri196YBnIxo
         5w+MdaaZDz8wCk/J2VbQ/ZbtZTsy5wrc9ycPz/at848Se7HmQArzYvdYCZJ0Ewpe9Rau
         RFcjgsxBtUlHagbggFv7k23VajDfMwQtLQcASJlBQQrayZ6XDHAUuS5yY4Uj5yq6bkte
         H6M1lUWU0lHQAGuDJRyANEfLQqRJGec2YrifE2pFn18FK1/HBZ1UdukNIn8J7l+qZyAL
         N7LRU5ZO9wrwV8d6apEa8ob/eZA3iKPgFEiXD1EwX/vf07smFKENLt/vOlwpyKAAqRy5
         8YRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXh2/g7RFyTSGoobsbl3NQgTYCm/Qx9YdpgEKoHsrHlGQNpwp6+E6kuHNXNp2FHj20YseM23/zB1Ge4quX/XG8DGGBYTenEZWOFTKW8
X-Gm-Message-State: AOJu0YzrmbmBlhs193zQNIA+fFkdJgESwQBVMEvc73558i1Ja+D2R7Yp
	naHIvTIQDNuXo9VlTm2vHIpWmhVBVgxu9hKj4iuP03R4vTx5Npfjkxlr0zIkuAQ=
X-Google-Smtp-Source: AGHT+IGXkVEaOMFBHx/baYrBz9derdknpbq9as3brbpiTEdPwh/hYAl2dlBH3Ljix5Ca772CLWwlVQ==
X-Received: by 2002:a2e:9257:0:b0:2e1:a504:f9ec with SMTP id 38308e7fff4ca-2e44708423amr19911671fa.23.1715168616936;
        Wed, 08 May 2024 04:43:36 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f88111028sm20610245e9.33.2024.05.08.04.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 04:43:36 -0700 (PDT)
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
Subject: [PATCH RESEND v2 9/9] mm: Use common huge_ptep_clear_flush() function for riscv/arm64
Date: Wed,  8 May 2024 13:34:19 +0200
Message-Id: <20240508113419.18620-10-alexghiti@rivosinc.com>
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
so move it to the generic code.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/arm64/mm/hugetlbpage.c | 61 -------------------------------------
 arch/riscv/mm/hugetlbpage.c | 51 -------------------------------
 mm/contpte.c                | 15 +++++++++
 3 files changed, 15 insertions(+), 112 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index e56f2c8ec7e7..5869f20ca28e 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -112,53 +112,6 @@ int find_num_contig(struct mm_struct *mm, unsigned long addr,
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
-	pte_t orig_pte = __ptep_get(ptep);
-	unsigned long i;
-
-	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++) {
-		pte_t pte = __ptep_get_and_clear(mm, addr, ptep);
-
-		/*
-		 * If HW_AFDBM is enabled, then the HW could turn on
-		 * the dirty or accessed bit for any page in the set,
-		 * so check them all.
-		 */
-		if (pte_dirty(pte))
-			orig_pte = pte_mkdirty(orig_pte);
-
-		if (pte_young(pte))
-			orig_pte = pte_mkyoung(orig_pte);
-	}
-	return orig_pte;
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
@@ -277,20 +230,6 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
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
 	if (pud_sect_supported())
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index 440d3bde88f2..47333efa2d83 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -121,42 +121,6 @@ unsigned long hugetlb_mask_last_page(struct hstate *h)
 	return 0UL;
 }
 
-static pte_t get_clear_contig(struct mm_struct *mm,
-			      unsigned long addr,
-			      pte_t *ptep,
-			      unsigned long pte_num)
-{
-	pte_t orig_pte = ptep_get(ptep);
-	unsigned long i;
-
-	for (i = 0; i < pte_num; i++, addr += PAGE_SIZE, ptep++) {
-		pte_t pte = ptep_get_and_clear(mm, addr, ptep);
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
@@ -173,21 +137,6 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
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
diff --git a/mm/contpte.c b/mm/contpte.c
index 8ad2a3099dfd..15791f6d9c41 100644
--- a/mm/contpte.c
+++ b/mm/contpte.c
@@ -27,6 +27,7 @@
  *   - huge_ptep_get_and_clear()
  *   - huge_ptep_set_access_flags()
  *   - huge_ptep_set_wrprotect()
+ *   - huge_ptep_clear_flush()
  */
 
 pte_t huge_ptep_get(pte_t *ptep)
@@ -255,3 +256,17 @@ void huge_ptep_set_wrprotect(struct mm_struct *mm,
 
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


