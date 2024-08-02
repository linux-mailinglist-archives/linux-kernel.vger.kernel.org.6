Return-Path: <linux-kernel+bounces-272735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDB3946062
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0A991F21654
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A3D1537A7;
	Fri,  2 Aug 2024 15:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="L5sKUF/p"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0086F13635B
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722612169; cv=none; b=hlXFVpGdYqrE16gMSzgamF1LWq3JQxQha5R2Pwg9vDuV/u3JZbvBgQZ5fWhQMma2IeIvrXiiAZpHpWOfx7wE042pl3M7OA2JzXJAlZ5RJKoTXEpqO/NwE3k1eMZqnln9xyST58o+IDAIDjN+6cnruoNH/1oiAUAhXs7TOrIDLlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722612169; c=relaxed/simple;
	bh=0CCV5WLNVRInM6T0LDpHdSlX54agrillAadfsmmms1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CAbQ877BWiFsCJJGmzHr3asufWm/QiOZRdTsXkIiMl9U4H7T6NacHbIqlvIHJrDW/ntEpbcWrddXAc7fISo5lWUTBv4kH/g0dHo+jjrG7DudD18MqB9IZfY6IYfGhzc8E3D+5T3pkihpMILGkZ3flwAiaO66EtJqvE0PGUAQn/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=L5sKUF/p; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-368313809a4so1971736f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 08:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722612165; x=1723216965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1cBbOZt36mdcwgOJ6aPskHFTTaexGabCNqRxjg6Oh0=;
        b=L5sKUF/pljYynHDs+ttuS0r2i8MmBprfyCO9FaQmt0QXy7rOZoJjOp0dD2GTzSMTD7
         V3vMnpQiNx5ph6RM7Q9lyc3Y0measRPAF1RP9SZ+jP8nVl1LbsTbB3kxqKzsI+ZepLz4
         7Uar2xDSOt8UD0tQfJ7+Dn0WtU6tnBpQUmK4DmKtY9Zl5EGrPWjXIF1J1IBzZUh561K4
         riIKM+AC2foV04wzlNyhk7n7Nhq/04KUzByByNUCWRhhL4i0I4UVH8/gXkYzrVCwMYZm
         KYwoYSm30fw4k/hd3ELo5hQItHAldeZgprwFI1uUIuwjBqyZiWvXoSJ6qIofd8EyatYk
         wxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722612165; x=1723216965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1cBbOZt36mdcwgOJ6aPskHFTTaexGabCNqRxjg6Oh0=;
        b=sB7gbwGi//uN9mX6uRMLKHZNyendTGlqdz1ZmHzsnJR+Pc/mTFwsN+Go3GN/4wQxqe
         Fl08YnBrk8kexafzyX7i8QsJaPZ3Hj4+ic39JdGyTzqxJbBCD81nhWd7v71x4+Bze9EQ
         8IpXt36m6OOswnyYltB2074+DYBdsmS7tdUbGXdf7JFZyZDwD6iuzd/LI1IzEt/xZv5c
         JtQ0AMdjDn/xHtrR1lKulqtFOOCsgmKKZvUx90xNhSTVm1Kl2o7Eonpv20mlOq+uEL2O
         +S4JLQGO8c7hLzT7H7BPLV3jHWa8hb37xpawph01AkOwI2fTB5Ctu/2CO5olAWg2T4Vy
         OLhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg0TFtOBudULsRBuA0fzXRIvxlzJ6gQ+mp7iVQeYzW0P8pc2b4rtT1joErhLz12JCF1mUcT2ppfuMfXGxYdKA5T06+xUmIU2vnuUsj
X-Gm-Message-State: AOJu0YyskhlskylEnQ/hphmgDI5hn2WN8nXi3ipAihzcow04nZ9T7e1A
	iQzDmrsROy8absE+GELipbv092nUAlzeftniXuP9TDPAmdaV/3K7ZLzsGaHPV/M=
X-Google-Smtp-Source: AGHT+IGevEgshEH6AuLTp8Bo7gjdyVs7Lhu/RR9IyqwSflPacf3rHkteywexmhQW20qeFqo6GEOMhQ==
X-Received: by 2002:a05:6000:400d:b0:367:8f89:f7c9 with SMTP id ffacd0b85a97d-36bbbef1261mr3849953f8f.33.1722612165098;
        Fri, 02 Aug 2024 08:22:45 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd01619csm2202892f8f.36.2024.08.02.08.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 08:22:44 -0700 (PDT)
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
Subject: [PATCH v3 8/9] mm: Use common huge_ptep_set_wrprotect() function for riscv/arm64
Date: Fri,  2 Aug 2024 17:14:29 +0200
Message-Id: <20240802151430.99114-9-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240802151430.99114-1-alexghiti@rivosinc.com>
References: <20240802151430.99114-1-alexghiti@rivosinc.com>
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
 arch/arm64/include/asm/hugetlb.h |  3 ---
 arch/arm64/mm/hugetlbpage.c      | 27 ---------------------------
 arch/riscv/include/asm/hugetlb.h |  4 ----
 arch/riscv/include/asm/pgtable.h |  7 ++++---
 arch/riscv/mm/hugetlbpage.c      | 22 ----------------------
 include/linux/hugetlb_contpte.h  |  4 ++++
 mm/hugetlb_contpte.c             | 22 ++++++++++++++++++++++
 7 files changed, 30 insertions(+), 59 deletions(-)

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 6b84e287b72d..4ceb6cb1bec5 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -27,9 +27,6 @@ static inline void arch_clear_hugetlb_flags(struct folio *folio)
 
 pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags);
 #define arch_make_huge_pte arch_make_huge_pte
-#define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
-extern void huge_ptep_set_wrprotect(struct mm_struct *mm,
-				    unsigned long addr, pte_t *ptep);
 #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
 extern pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 				   unsigned long addr, pte_t *ptep);
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 658635022e4d..8d271e175848 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -266,33 +266,6 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
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
diff --git a/arch/riscv/include/asm/hugetlb.h b/arch/riscv/include/asm/hugetlb.h
index bf533c2cef84..4c692dd82779 100644
--- a/arch/riscv/include/asm/hugetlb.h
+++ b/arch/riscv/include/asm/hugetlb.h
@@ -24,10 +24,6 @@ bool arch_hugetlb_migration_supported(struct hstate *h);
 pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 			    unsigned long addr, pte_t *ptep);
 
-#define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
-void huge_ptep_set_wrprotect(struct mm_struct *mm,
-			     unsigned long addr, pte_t *ptep);
-
 pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags);
 #define arch_make_huge_pte arch_make_huge_pte
 
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 5d9b051ac51c..f4bb0c971bd8 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -639,9 +639,8 @@ static inline pte_t __ptep_get_and_clear(struct mm_struct *mm,
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
@@ -735,6 +734,8 @@ static inline pte_t ptep_get(pte_t *ptep)
 #define pte_clear		__pte_clear
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 #define ptep_set_access_flags	__ptep_set_access_flags
+#define __HAVE_ARCH_PTEP_SET_WRPROTECT
+#define ptep_set_wrprotect	__ptep_set_wrprotect
 
 #define pgprot_nx pgprot_nx
 static inline pgprot_t pgprot_nx(pgprot_t _prot)
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index 0e2ca7327479..8963a4e77742 100644
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
-	pte_t orig_pte;
-	int pte_num;
-
-	if (!pte_napot(pte)) {
-		ptep_set_wrprotect(mm, addr, ptep);
-		return;
-	}
-
-	pte_num = arch_contpte_get_num_contig(mm, addr, ptep, 0, NULL);
-
-	orig_pte = get_clear_contig_flush(mm, addr, ptep, pte_num);
-
-	orig_pte = pte_wrprotect(orig_pte);
-
-	set_ptes(mm, addr, ptep, orig_pte, pte_num);
-}
-
 pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 			    unsigned long addr,
 			    pte_t *ptep)
diff --git a/include/linux/hugetlb_contpte.h b/include/linux/hugetlb_contpte.h
index fea47035ac38..02bce0ed93d8 100644
--- a/include/linux/hugetlb_contpte.h
+++ b/include/linux/hugetlb_contpte.h
@@ -27,4 +27,8 @@ extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 				      unsigned long addr, pte_t *ptep,
 				      pte_t pte, int dirty);
 
+#define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
+extern void huge_ptep_set_wrprotect(struct mm_struct *mm,
+				    unsigned long addr, pte_t *ptep);
+
 #endif /* _LINUX_HUGETLB_CONTPTE_H */
diff --git a/mm/hugetlb_contpte.c b/mm/hugetlb_contpte.c
index 21f5c89daa6b..b00bbcc2d939 100644
--- a/mm/hugetlb_contpte.c
+++ b/mm/hugetlb_contpte.c
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
 
 pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
@@ -232,3 +234,23 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 
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


