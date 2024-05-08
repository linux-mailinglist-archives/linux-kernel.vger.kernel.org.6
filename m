Return-Path: <linux-kernel+bounces-173161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A3B8BFC56
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A7C28414F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E783824BB;
	Wed,  8 May 2024 11:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Nijyms6r"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EBD8248E
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168434; cv=none; b=X0rCmoO0GSTcxYoYe5ZlfT2lSL38a5NoHxoiMJiL6e/0Zix0dCx0IfpRfCevBvwBToqL151+z+S6YPpq9fVJ8Ed9YkwnNy4MSRYBmGYi68OQ5I8WVmehOnKnOA/vrItREGy9rVJpV0Bj58M4FaH4iWdl6wTySbVcwgYOzaZ4D0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168434; c=relaxed/simple;
	bh=VABY+Ba0JMwODv7U/E8RCXCu+cNtq0sU3lmtzPLVeMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a58di6LqMIUDjUwmfbOS9taIZIPP97dMGpSDOlEBafu20t57deoPOos83EMn79Mw4sSStk5/K+Nyqhy20Y9ui8PsRDP22g0/mR+Yxn25UJvZYsMoaV7I9SSQWzYfqlnWWQyVtp4i7fGO5+aSNH8UJ1EDyAsekN3q6Xah8cBLiyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Nijyms6r; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e242b1df60so51971411fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 04:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715168431; x=1715773231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7TbOelFCBPjD//aDEZ907vn9YCYdQxapVfhTuFqwGo=;
        b=Nijyms6rYYB1G02T2NcUP9wbzWm0bpP6ugmPzIykXA5jkewgGgbKq1Y1wOmolkS03r
         2qFsv6t5nEyAmRWYamCJkYEzOYFvT/mXdMjFCJHbiOkvZRQp2D2aYRW8D87oJKpkTl+6
         6uepsgMh+x9j8iLrtcQoJohsUmM8vbPXbY0keOAubRhtxsT0vEcsZNV9Dynb/hySVYBP
         7ZjAmavzmSzAXu5+cudEdKulhj3PuZ0Wch1nNSpO5YBtBbWom3qtKpHbStBFxz6RCAso
         9r2l7QO2qhLIY2+EWwU6dCZP7z/jIL+NZaAwDIud7ZAki2I282eHppnleJGgLcDNSIk1
         NIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715168431; x=1715773231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7TbOelFCBPjD//aDEZ907vn9YCYdQxapVfhTuFqwGo=;
        b=Tec93bLROxRFE6AajGqiFTpown4eVcKVqbyArrwpuRDAc+OYX8q9hV8CAOALEqwaF9
         9Mu9SYFOGmrw9eiuh5nZzVMhRy3nACKuY+ZfUM8j9CzdZqS/sY9EUI9+OuUnNR7Ahpuv
         7320349r1/9zUQdCdZpLRtvPkC6aNEw22kd46e8+AcUdbZSVxmrOYvqqONaXuavg0Xe/
         VJlUVZ4vZ3KgJmU1ff1GiueptRo2wK6klqWd45fhrrs+ztTE/e9L5KB5b/JE7FmYAshR
         SIpxcs2V693a4rAnCA2nH6xJYbGhQv1i+HMEfKovwjCmODtU3+AP/C8P3Qta8mVHp5yZ
         rshg==
X-Forwarded-Encrypted: i=1; AJvYcCWKJe3fblvfmvzhKWu4a65eHt0AC5Y+kocA8hI3IM2peCHFluqMV+/LxVckPx0U82l4FpPKae2v0zWw9pfsg7z6OAceCvgKNYL8FO8z
X-Gm-Message-State: AOJu0YyCC6CoU5TUfManqY9OfyQahqsNh5NSFQ48Ti4mG62mRH6cvt7i
	rceviRTqt3UWT6FqVdiPtC4cMjsrF9uHVjKlsnSr0gqmFKSdptJZKfNG72W2dSUeZjL63G9mYt5
	8
X-Google-Smtp-Source: AGHT+IHoKXWUN4OirZVjujYdTPRjtHlf5MTjdp4rZ05v4P+q2zGuw+P9Rq7y6u6CQwAZzw3ytsfSow==
X-Received: by 2002:a2e:8749:0:b0:2e1:ae29:f28a with SMTP id 38308e7fff4ca-2e447697612mr22142151fa.34.1715168430817;
        Wed, 08 May 2024 04:40:30 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id b15-20020a05600c4e0f00b0041aa79f27a0sm2003785wmq.38.2024.05.08.04.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 04:40:30 -0700 (PDT)
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
Subject: [PATCH RESEND v2 6/9] mm: Use common huge_ptep_get_and_clear() function for riscv/arm64
Date: Wed,  8 May 2024 13:34:16 +0200
Message-Id: <20240508113419.18620-7-alexghiti@rivosinc.com>
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


