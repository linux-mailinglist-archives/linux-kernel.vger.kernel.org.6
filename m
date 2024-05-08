Return-Path: <linux-kernel+bounces-173169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E9A8BFC74
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 722C71F24F36
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E703882899;
	Wed,  8 May 2024 11:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="if4/jnMv"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A5A823BF
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168559; cv=none; b=iSUFBvJKKPCunZtdMgizZX7Dy+2yz7hKLaCA6c+7ZdFU/3O1HV6HyLs818/WfvT+DsuqTX1igyNyfgh1bWFo68s6BJ1UAbG7k4Y1QiPHepr0MimbTplv5B9IfonHhZ6wKI+83WaimFbJwyQKmzVq+i6t/hjZ6/Mezx3lp5JheUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168559; c=relaxed/simple;
	bh=aYCSefvuwvBFoXfcrr/GEE+3rpoeZV2FFN9GK0hbENI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nZarRP1sXWJ/LGfpB8BDjc774AT8tO/N1aIVcUsxzcPWOk9XN/gkTKXNktyQS2whEi/e88msftJlbdJKIdea9zOnmJMXDbviyHJU1V/Z9eZIWHrj/ZmzYRr4qCz6I/ldj0V42zVs6tkYH/v4jHoCG+xxxufQZdI80h3DWv1R3B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=if4/jnMv; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41bca450fa3so27151385e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 04:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715168556; x=1715773356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3J74NkW9ioW00Pqnp327XZ4SYUtOBKlfZoGCCQmZ+M=;
        b=if4/jnMvYadWbv/wQ0STx/VI59DVCRSTuLANWMkUVloybzTlKrs0nlZ+UygjSk/qH4
         siR2N1oa+Qm8UcpXNTHIW3NNu83yMGDlwWU7ObrgQ4JEthWFXN7v7TOIm9atQE79jDLW
         sHUVdtIfWRb5ISagQ6bHKO0KewZkwi+k4ckLBxWBvQgOEaMHzEpSIJNwk5zDksbbacTr
         vPSPCxJ09gYtgfmNE2NiNR4Y1+UeoZMLbqC+qruOFsk6Ac0fOqlpDuksfmBASAKRrWDL
         NzntqQS+6ap1plPZfvxEzvVY0GMc/f5FFPQBJjqDfrjNeL5sK2kNqnVOqCeA+s7KQqqS
         lp7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715168556; x=1715773356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p3J74NkW9ioW00Pqnp327XZ4SYUtOBKlfZoGCCQmZ+M=;
        b=aPM/yjwBNnNuq+i6UuWofmbcndGiwWqBQkzvVYG03aQaufPYNZd5V6Jr1lWNMM0laH
         37+7cr4U0DfW2WO/RtjalO/1sv8qyc+h3sroL9/oUmIJ4raROtwNjI/W2wa39T69cHFy
         9gwyiRepqFDCexT/HCn6MRENV4gb/d5inINbTYhigVbgLmvhHKF75YPngpm0YHvDtPBy
         EBvRkBUgfuMiXZadYQVyJ/5CKzO7vhW/VmIMsOpjMuIRlWWZxCFLxYmcMD3EzsIVKZJK
         OpdZdnLvwUqL+kS+FQdXXhidj5bkxo047dB358kBkY0cO0IiUW9Ir4oiGOzrJdXJenyU
         pOKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRFr/ewfbgsrIuOl2w2N/eD7D5dt6Z8cLwJ2LMs83q9syv/qXMDMZhGUflO+h3L8vFr3ceMUs0YcGvprRKYelW1XHlhye7DoXaA97r
X-Gm-Message-State: AOJu0YxNVAdX2cG0ElJfZ8dVKZQS+lBhH7415IHkv6KChY7/VKB5Xd9/
	FH1ZabjmQx0Z5rkmU8+3IvuAHfRPwrn7oMksAUQdp0MvTOngXJYCjIGXrdNSOW4=
X-Google-Smtp-Source: AGHT+IHE8o6Es8ZSc8TwRFtN83wex84gZARiN4tVTDQiUBBDnfszL6lfcSMLSwFM5H55V+vhK3nrvQ==
X-Received: by 2002:adf:b1d1:0:b0:34f:6c9c:19a3 with SMTP id ffacd0b85a97d-34fcade2a1cmr2221817f8f.15.1715168555855;
        Wed, 08 May 2024 04:42:35 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id h1-20020a056000000100b0034e0b56a62bsm15118070wrx.44.2024.05.08.04.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 04:42:35 -0700 (PDT)
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
Subject: [PATCH RESEND v2 8/9] mm: Use common huge_ptep_set_wrprotect() function for riscv/arm64
Date: Wed,  8 May 2024 13:34:18 +0200
Message-Id: <20240508113419.18620-9-alexghiti@rivosinc.com>
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
 arch/arm64/mm/hugetlbpage.c      | 27 ---------------------------
 arch/riscv/include/asm/pgtable.h |  7 ++++---
 arch/riscv/mm/hugetlbpage.c      | 22 ----------------------
 mm/contpte.c                     | 22 ++++++++++++++++++++++
 4 files changed, 26 insertions(+), 52 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 052a5bf2926c..e56f2c8ec7e7 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -277,33 +277,6 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 	return entry;
 }
 
-void huge_ptep_set_wrprotect(struct mm_struct *mm,
-			     unsigned long addr, pte_t *ptep)
-{
-	unsigned long pfn, dpfn;
-	pgprot_t hugeprot;
-	int ncontig, i;
-	size_t pgsize;
-	pte_t pte;
-
-	if (!pte_cont(__ptep_get(ptep))) {
-		__ptep_set_wrprotect(mm, addr, ptep);
-		return;
-	}
-
-	ncontig = find_num_contig(mm, addr, ptep, &pgsize);
-	dpfn = pgsize >> PAGE_SHIFT;
-
-	pte = get_clear_contig_flush(mm, addr, ptep, pgsize, ncontig);
-	pte = pte_wrprotect(pte);
-
-	hugeprot = pte_pgprot(pte);
-	pfn = pte_pfn(pte);
-
-	for (i = 0; i < ncontig; i++, ptep++, addr += pgsize, pfn += dpfn)
-		__set_ptes(mm, addr, ptep, pfn_pte(pfn, hugeprot), 1);
-}
-
 pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 			    unsigned long addr, pte_t *ptep)
 {
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 20f62505d0bc..9e397935536e 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -668,9 +668,8 @@ static inline pte_t __ptep_get_and_clear(struct mm_struct *mm,
 	return pte;
 }
 
-#define __HAVE_ARCH_PTEP_SET_WRPROTECT
-static inline void ptep_set_wrprotect(struct mm_struct *mm,
-				      unsigned long address, pte_t *ptep)
+static inline void __ptep_set_wrprotect(struct mm_struct *mm,
+					unsigned long address, pte_t *ptep)
 {
 	atomic_long_and(~(unsigned long)_PAGE_WRITE, (atomic_long_t *)ptep);
 }
@@ -704,6 +703,8 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 #define pte_clear		__pte_clear
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 #define ptep_set_access_flags	__ptep_set_access_flags
+#define __HAVE_ARCH_PTEP_SET_WRPROTECT
+#define ptep_set_wrprotect	__ptep_set_wrprotect
 
 #define pgprot_nx pgprot_nx
 static inline pgprot_t pgprot_nx(pgprot_t _prot)
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index a59b776e9c8b..440d3bde88f2 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -173,28 +173,6 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 	return entry;
 }
 
-void huge_ptep_set_wrprotect(struct mm_struct *mm,
-			     unsigned long addr,
-			     pte_t *ptep)
-{
-	pte_t pte = ptep_get(ptep);
-	size_t pgsize;
-	pte_t orig_pte;
-	int pte_num;
-
-	if (!pte_napot(pte)) {
-		ptep_set_wrprotect(mm, addr, ptep);
-		return;
-	}
-
-	pte_num = arch_contpte_get_num_contig(mm, addr, ptep, 0, &pgsize);
-
-	orig_pte = get_clear_contig_flush(mm, addr, ptep, pte_num);
-	orig_pte = pte_wrprotect(orig_pte);
-
-	set_ptes(mm, addr, ptep, orig_pte, pte_num);
-}
-
 pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 			    unsigned long addr,
 			    pte_t *ptep)
diff --git a/mm/contpte.c b/mm/contpte.c
index 9c7a9f250bca..8ad2a3099dfd 100644
--- a/mm/contpte.c
+++ b/mm/contpte.c
@@ -14,6 +14,7 @@
  *   - __ptep_get_and_clear()
  *   - __pte_clear()
  *   - __ptep_set_access_flags()
+ *   - __ptep_set_wrprotect()
  *   - pte_cont()
  *   - arch_contpte_get_num_contig()
  */
@@ -25,6 +26,7 @@
  *   - huge_pte_clear()
  *   - huge_ptep_get_and_clear()
  *   - huge_ptep_set_access_flags()
+ *   - huge_ptep_set_wrprotect()
  */
 
 pte_t huge_ptep_get(pte_t *ptep)
@@ -233,3 +235,23 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 
 	return 1;
 }
+
+void huge_ptep_set_wrprotect(struct mm_struct *mm,
+			     unsigned long addr, pte_t *ptep)
+{
+	int ncontig;
+	size_t pgsize;
+	pte_t pte;
+
+	if (!pte_cont(__ptep_get(ptep))) {
+		__ptep_set_wrprotect(mm, addr, ptep);
+		return;
+	}
+
+	ncontig = arch_contpte_get_num_contig(mm, addr, ptep, 0, &pgsize);
+
+	pte = get_clear_contig_flush(mm, addr, ptep, pgsize, ncontig);
+	pte = pte_wrprotect(pte);
+
+	set_contptes(mm, addr, ptep, pte, ncontig, pgsize);
+}
-- 
2.39.2


