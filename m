Return-Path: <linux-kernel+bounces-173165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9F98BFC6B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E822728691D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA158288A;
	Wed,  8 May 2024 11:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="LYuHBz/R"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05228248E
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168497; cv=none; b=A3Ub7TSEmqcWog+yxZmViqy2YV+axSKWVTLbO1H+O/vNTOU0R526D+9JkC9AeW5w54fL3fanHfcDHIKEBWyWnnden9hKgOzLtNsb8ShrI1f2Y0kbzLYRcuOfLXHVhOFhH9ZquyHdHrqEvW3QCy15f00UNbS0E9t1TZ3QLQKlFLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168497; c=relaxed/simple;
	bh=zGi5q+eAqWa60YcKcWrBwZMi6pUW6tpG+DnGl1U0u5U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fj+9hT9i/Xyy1cpKe6zEpAmCEdAGkxhG5RV0D47HCnk7q/Darlx5ha+aN64SUDoIcXMNaWhThpVLz6QvxGOyOb7g3jI534I9EajPHyL7Rx4JDxQDvX3kheDQauli+ZmD36K7Fk8nyqI9kTkNwKHsRWn5JEbHbS5kzQaoIlBwyDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=LYuHBz/R; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-792b94301eeso21284885a.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 04:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715168494; x=1715773294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p6iTAuwd3BKroPVlGkkNGENGW7uKwPOOcXR0pGzhYec=;
        b=LYuHBz/RWbfcLrq9Kl+0BWWHguzo4tYgqL5l3NL6m5Qe1ORkqs+wuH7gA0uZGBQUtj
         yRXXJ4Y20OqTjtIq5LipoIv5c4SrFF9FAYp3OEczQIbw02f4LhKyL6aW5MUETUOstyIZ
         GxKyJLVc61iW3V9OJWflB2717EEy0o4GV7JxEkvVb85Xc1+pcxO8/i83LHRuyWnBDBfJ
         gOscIj7cl3iDQACxliqL1y5ktZcQxzn7qUd8X3VjHKzYU1U3f8X+gD5O75tgk8oflv7t
         4pCCRTHAJjni1N7zeFTXJQadD70Z1QOprkPcRmu9xayak+scTyRlZZJKmewz+iDOW1f0
         I18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715168494; x=1715773294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p6iTAuwd3BKroPVlGkkNGENGW7uKwPOOcXR0pGzhYec=;
        b=H5K/b51r+MmCYXvtRaDYd0bNSm+IFFf7uMN0NDawG4MRlQcrhQ6gPNNRxfPB41lwdO
         juQArgZeHsp3RqqE5Z8d8RlWhxa5fDey7qkCKGXk+6iYZ6pcRAn/Kl9bW9p6sptvvdcG
         ktahk1i06qXkunDaoE1MxUtIGFuSrYkRV5SnBwBIVJJfNPmGpg/LVpJGuA38O5ovSTUw
         ljwvg2/uXDjBeVLaFi3L0AaIl2y/I4dGGYYn+TEbs2Po5vwot0Op6MSdNDw/aaOB08q2
         QJDDsmSxn/pOEsDsZqqkv98KHcCGjRZjeLVS6yqEI4/WaVsAWQ87aEL24N+pwCWy6XJy
         r37w==
X-Forwarded-Encrypted: i=1; AJvYcCUVOBC8/Kfpw3BG7cfYPL5uTKkMSWUoX+HP/aXgtUoTg9x3mNOMZvm5m3mknw6+WPcUINJb8mGwWE+Bq9uau78uBT7LhtlzP18q8x5s
X-Gm-Message-State: AOJu0YyumyQOgBy2or34AP0/r6skc64GaP7AgoFjHfVh3UUqUfpshQXR
	sKOsaU4yQiXzhYAUP/e4c9DGbhh+fgIKjHb2cqyZfwZZdheWTnf4xN+rtjTCh3IVyOjdm3jvIt7
	R
X-Google-Smtp-Source: AGHT+IEf9c2lQsdOpkInfpCnqc/bzKruRrtsh40+8uzVrWPXvCoLmGvCA0UiasJn6iJt4vC5DbH2zA==
X-Received: by 2002:a05:620a:394b:b0:78e:df14:19dc with SMTP id af79cd13be357-792b26d4b61mr350150385a.20.1715168494636;
        Wed, 08 May 2024 04:41:34 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id de42-20020a05620a372a00b0078d7213de13sm5753377qkb.136.2024.05.08.04.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 04:41:34 -0700 (PDT)
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
Subject: [PATCH RESEND v2 7/9] mm: Use common huge_ptep_set_access_flags() function for riscv/arm64
Date: Wed,  8 May 2024 13:34:17 +0200
Message-Id: <20240508113419.18620-8-alexghiti@rivosinc.com>
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

Both architectures have almost the same implementation:
__cont_access_flags_changed() is also correct on riscv and brings the
same benefits (ie don't do anything if the flags are unchanged).

As in the previous commit, get_clear_contig_flush() is duplicated in both
the arch and the generic codes, it will be removed from the arch code when
the last reference there gets moved to the generic code.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/arm64/mm/hugetlbpage.c      | 65 ---------------------------
 arch/riscv/include/asm/pgtable.h |  7 +--
 arch/riscv/mm/hugetlbpage.c      | 29 ------------
 arch/riscv/mm/pgtable.c          |  6 +--
 mm/contpte.c                     | 75 ++++++++++++++++++++++++++++++++
 5 files changed, 82 insertions(+), 100 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 5ace4bf7ce35..052a5bf2926c 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -277,71 +277,6 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 	return entry;
 }
 
-/*
- * huge_ptep_set_access_flags will update access flags (dirty, accesssed)
- * and write permission.
- *
- * For a contiguous huge pte range we need to check whether or not write
- * permission has to change only on the first pte in the set. Then for
- * all the contiguous ptes we need to check whether or not there is a
- * discrepancy between dirty or young.
- */
-static int __cont_access_flags_changed(pte_t *ptep, pte_t pte, int ncontig)
-{
-	int i;
-
-	if (pte_write(pte) != pte_write(__ptep_get(ptep)))
-		return 1;
-
-	for (i = 0; i < ncontig; i++) {
-		pte_t orig_pte = __ptep_get(ptep + i);
-
-		if (pte_dirty(pte) != pte_dirty(orig_pte))
-			return 1;
-
-		if (pte_young(pte) != pte_young(orig_pte))
-			return 1;
-	}
-
-	return 0;
-}
-
-int huge_ptep_set_access_flags(struct vm_area_struct *vma,
-			       unsigned long addr, pte_t *ptep,
-			       pte_t pte, int dirty)
-{
-	int ncontig, i;
-	size_t pgsize = 0;
-	unsigned long pfn = pte_pfn(pte), dpfn;
-	struct mm_struct *mm = vma->vm_mm;
-	pgprot_t hugeprot;
-	pte_t orig_pte;
-
-	if (!pte_cont(pte))
-		return __ptep_set_access_flags(vma, addr, ptep, pte, dirty);
-
-	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
-	dpfn = pgsize >> PAGE_SHIFT;
-
-	if (!__cont_access_flags_changed(ptep, pte, ncontig))
-		return 0;
-
-	orig_pte = get_clear_contig_flush(mm, addr, ptep, pgsize, ncontig);
-
-	/* Make sure we don't lose the dirty or young state */
-	if (pte_dirty(orig_pte))
-		pte = pte_mkdirty(pte);
-
-	if (pte_young(orig_pte))
-		pte = pte_mkyoung(pte);
-
-	hugeprot = pte_pgprot(pte);
-	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize, pfn += dpfn)
-		__set_ptes(mm, addr, ptep, pfn_pte(pfn, hugeprot), 1);
-
-	return 1;
-}
-
 void huge_ptep_set_wrprotect(struct mm_struct *mm,
 			     unsigned long addr, pte_t *ptep)
 {
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index d976113a370d..20f62505d0bc 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -652,9 +652,8 @@ static inline void __pte_clear(struct mm_struct *mm,
 	__set_pte_at(mm, ptep, __pte(0));
 }
 
-#define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS	/* defined in mm/pgtable.c */
-extern int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
-				 pte_t *ptep, pte_t entry, int dirty);
+extern int __ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
+				   pte_t *ptep, pte_t entry, int dirty);
 #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG	/* defined in mm/pgtable.c */
 extern int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long address,
 				     pte_t *ptep);
@@ -703,6 +702,8 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 #define ptep_get_and_clear	__ptep_get_and_clear
 #define pte_clear		__pte_clear
+#define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
+#define ptep_set_access_flags	__ptep_set_access_flags
 
 #define pgprot_nx pgprot_nx
 static inline pgprot_t pgprot_nx(pgprot_t _prot)
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index a757e0b2f090..a59b776e9c8b 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -173,35 +173,6 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 	return entry;
 }
 
-int huge_ptep_set_access_flags(struct vm_area_struct *vma,
-			       unsigned long addr,
-			       pte_t *ptep,
-			       pte_t pte,
-			       int dirty)
-{
-	struct mm_struct *mm = vma->vm_mm;
-	size_t pgsize;
-	pte_t orig_pte;
-	int pte_num;
-
-	if (!pte_napot(pte))
-		return ptep_set_access_flags(vma, addr, ptep, pte, dirty);
-
-	pte_num = arch_contpte_get_num_contig(vma->vm_mm, addr, ptep, 0, &pgsize);
-
-	orig_pte = get_clear_contig_flush(mm, addr, ptep, pte_num);
-
-	if (pte_dirty(orig_pte))
-		pte = pte_mkdirty(pte);
-
-	if (pte_young(orig_pte))
-		pte = pte_mkyoung(pte);
-
-	set_ptes(mm, addr, ptep, pte, pte_num);
-
-	return true;
-}
-
 void huge_ptep_set_wrprotect(struct mm_struct *mm,
 			     unsigned long addr,
 			     pte_t *ptep)
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
index 533ec9055fa0..e86df7ef193c 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -5,9 +5,9 @@
 #include <linux/kernel.h>
 #include <linux/pgtable.h>
 
-int ptep_set_access_flags(struct vm_area_struct *vma,
-			  unsigned long address, pte_t *ptep,
-			  pte_t entry, int dirty)
+int __ptep_set_access_flags(struct vm_area_struct *vma,
+			    unsigned long address, pte_t *ptep,
+			    pte_t entry, int dirty)
 {
 	if (!pte_same(ptep_get(ptep), entry))
 		__set_pte_at(vma->vm_mm, ptep, entry);
diff --git a/mm/contpte.c b/mm/contpte.c
index 68eb1634b922..9c7a9f250bca 100644
--- a/mm/contpte.c
+++ b/mm/contpte.c
@@ -13,6 +13,7 @@
  *   - __set_ptes()
  *   - __ptep_get_and_clear()
  *   - __pte_clear()
+ *   - __ptep_set_access_flags()
  *   - pte_cont()
  *   - arch_contpte_get_num_contig()
  */
@@ -23,6 +24,7 @@
  *   - set_huge_pte_at()
  *   - huge_pte_clear()
  *   - huge_ptep_get_and_clear()
+ *   - huge_ptep_set_access_flags()
  */
 
 pte_t huge_ptep_get(pte_t *ptep)
@@ -158,3 +160,76 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 
 	return get_clear_contig(mm, addr, ptep, pgsize, ncontig);
 }
+
+/*
+ * huge_ptep_set_access_flags will update access flags (dirty, accesssed)
+ * and write permission.
+ *
+ * For a contiguous huge pte range we need to check whether or not write
+ * permission has to change only on the first pte in the set. Then for
+ * all the contiguous ptes we need to check whether or not there is a
+ * discrepancy between dirty or young.
+ */
+static int __cont_access_flags_changed(pte_t *ptep, pte_t pte, int ncontig)
+{
+	int i;
+
+	if (pte_write(pte) != pte_write(__ptep_get(ptep)))
+		return 1;
+
+	for (i = 0; i < ncontig; i++) {
+		pte_t orig_pte = __ptep_get(ptep + i);
+
+		if (pte_dirty(pte) != pte_dirty(orig_pte))
+			return 1;
+
+		if (pte_young(pte) != pte_young(orig_pte))
+			return 1;
+	}
+
+	return 0;
+}
+
+static pte_t get_clear_contig_flush(struct mm_struct *mm,
+				    unsigned long addr,
+				    pte_t *ptep,
+				    unsigned long pgsize,
+				    unsigned long ncontig)
+{
+	pte_t orig_pte = get_clear_contig(mm, addr, ptep, pgsize, ncontig);
+	struct vm_area_struct vma = TLB_FLUSH_VMA(mm, 0);
+
+	flush_tlb_range(&vma, addr, addr + (pgsize * ncontig));
+	return orig_pte;
+}
+
+int huge_ptep_set_access_flags(struct vm_area_struct *vma,
+			       unsigned long addr, pte_t *ptep,
+			       pte_t pte, int dirty)
+{
+	int ncontig;
+	size_t pgsize = 0;
+	struct mm_struct *mm = vma->vm_mm;
+	pte_t orig_pte;
+
+	if (!pte_cont(pte))
+		return __ptep_set_access_flags(vma, addr, ptep, pte, dirty);
+
+	ncontig = arch_contpte_get_num_contig(vma->vm_mm, addr, ptep, 0, &pgsize);
+
+	if (!__cont_access_flags_changed(ptep, pte, ncontig))
+		return 0;
+
+	orig_pte = get_clear_contig_flush(mm, addr, ptep, pgsize, ncontig);
+
+	/* Make sure we don't lose the dirty or young state */
+	if (pte_dirty(orig_pte))
+		pte = pte_mkdirty(pte);
+
+	if (pte_young(orig_pte))
+		pte = pte_mkyoung(pte);
+
+	set_contptes(mm, addr, ptep, pte, ncontig, pgsize);
+
+	return 1;
+}
-- 
2.39.2


