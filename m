Return-Path: <linux-kernel+bounces-571307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE37A6BB8A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9289A3ADEA9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3DB22A4E2;
	Fri, 21 Mar 2025 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="W19MMX24"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2CF1EA7C1
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742562894; cv=none; b=aB22c0/58DSOmzhN4oBcrCFeMZYZ2/oFSqZMiesTnwF95VWxKgcEOPuiQaHTpxfda3LQQzFaD9mckHzWTHgwWju/ADCGefssUo6LmwrONqIL72CgdKq+/ruoo6AGhmNN+Ol7P37wruVz6kuRcKBWAWoKLiqoHYZQ32IQtVrG3pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742562894; c=relaxed/simple;
	bh=lmavtcPyTtLYZ2+vrTeUXw3teb+/K/n3qiMuem1Xy1o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f1WqrPJS0jyZTn14YDe31KTjHptyxnAXMZrAzYuME8TODybtb19ZydLcLFYd6MDEwDwn/oqI8F5rMA0CjQHj7mQpo9HSbesCjzCFel1Sp8YTMDynswDWMLP6DYZ3Onh5+06DAusH6g6eEHfYubXUmcxoF64D8zRmrnW7nSOB5f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=W19MMX24; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso1778461f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742562890; x=1743167690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOImW0XTENLZqMOVas1NKgXRQH/ppGnjlH3sp/4Pu3c=;
        b=W19MMX24Sy7qd9CkoPcLIqrV+DPHglWCB2iRltM5BPk7S8e2xBqbguXRLejMcvWMQC
         WJuNSiUPRWwn8aE6Fo64TBo7kLeVKIv61OZvFXD0K05aNXkOWtynb1qoUhCVBLT7uk5/
         LgX+6rAnzU7eu5d00NVlZXU69zzsityBUzusZwQ+M0blz4UoCI5zAEt1rkmVfSMCfXe7
         4TRUna7ttc53BTnagIZyR4Uofh9su1WnJTBImJ8cdZWlSskjIHW8x+oUgQF5ng3IhmFS
         ZtQhKjfuUJJAjPfLj9wwRoqHNQDj7SH1+db/FTKyhfg1GzLIt+VMSlmJgRLYkbTUvk/T
         Ndjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742562890; x=1743167690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOImW0XTENLZqMOVas1NKgXRQH/ppGnjlH3sp/4Pu3c=;
        b=b7t6dRJoxbWCGsZgWjxc1pVvPjSJvIwriQwKiqqSgI5AgD+20uT1yAMwkQkx2nqUVC
         AqSw7I+t6636nZt2dzfjU2JRV4fME/wPsCoD3A4Ebi8Fsp6PRUixMV4YTdyNJwe9w/pL
         t8HR086qts3zMgqhqUVNFLuXMffwGgFxR///pFib3FwinVIR6Xm+y7JU7SNpHu/1YTTj
         6/GVzl5CfdA6WSxAcksuISoMCC9lC3Pt45l7bQMy2Ytifn4rfjvLzTVZC2dkty6PqfUq
         rfZVlQ7PNABvkZDqz0xNJ9EEPtcnYwJ7F+OBx6rroycY1I9K9NZ8ePaUiEZdo7DiuK5y
         sPUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5Aj9AcU8/otCxODarMS7r12FycPpecH0bkTg16jcs//ljdjshccE9TYMmMiUC9VpIxumwVFQOjcil5h8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPYy1M9yNxCfNpc2LuUKNODQnIleQxDLZB0QScWX1iUj10yKKP
	Z5iDurWYW/fRpwXvCUL+OtzsyK/+jC1ZAaBvnlfb3kHxzBC4Eg0dSJ8Hj/+plQM=
X-Gm-Gg: ASbGncsPbQ+osD5BpKQCnjVMzkrko7O22UcgZ8tpO73DcZJvkMF3YXFAuFGw6JWA0r7
	G6oCNYta+rHJD33JcFDT5iE52hVeu/O3kJLUYH8aJUvbQVxLD8eoksyCC4OCVlyc80fIsmA0VhS
	3052XkmesuO6A9pJllVOsBSXvliQEnDp2jHnLSNwl74BG2+KV+6wH6u1FSLGucqKEha41EJWi3T
	UWcRAq2U8lTQX0zsIUTUcNQDvM6fQKAeUNmLa6gSei1IcyyVQAA9A+B/fwnDDlgF+36UQrJBEMJ
	ENqhsPeKpjMAlMItxhnOrcuSrSeO+tPAPPioXuGzKCKQxrh4if12Un+SthJSa+gz/7XaiQ==
X-Google-Smtp-Source: AGHT+IG4Bh4b8ljgMGozvKhj+gGf/zTKUltGlpRU5vbjoRJl/qtI6QCkciAO8DnHWDVRjHELB4GFxw==
X-Received: by 2002:a05:6000:381:b0:399:737f:4e02 with SMTP id ffacd0b85a97d-3997f938798mr3602833f8f.39.1742562890297;
        Fri, 21 Mar 2025 06:14:50 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com ([2001:861:3382:ef90:3d12:52fe:c1cc:c94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9eef37sm2294241f8f.85.2025.03.21.06.14.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 06:14:49 -0700 (PDT)
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
Subject: [PATCH v5 8/9] mm: Use common huge_ptep_set_wrprotect() function for riscv/arm64
Date: Fri, 21 Mar 2025 14:06:34 +0100
Message-Id: <20250321130635.227011-9-alexghiti@rivosinc.com>
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
 arch/arm64/include/asm/hugetlb.h |  3 ---
 arch/arm64/mm/hugetlbpage.c      | 27 ---------------------------
 arch/riscv/include/asm/hugetlb.h |  4 ----
 arch/riscv/include/asm/pgtable.h |  7 ++++---
 arch/riscv/mm/hugetlbpage.c      | 22 ----------------------
 include/linux/hugetlb_contpte.h  |  4 ++++
 mm/hugetlb_contpte.c             | 20 ++++++++++++++++++++
 7 files changed, 28 insertions(+), 59 deletions(-)

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index 29a9dac52cef..f568467e8ba2 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -35,9 +35,6 @@ static inline void arch_clear_hugetlb_flags(struct folio *folio)
 
 pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags);
 #define arch_make_huge_pte arch_make_huge_pte
-#define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
-extern void huge_ptep_set_wrprotect(struct mm_struct *mm,
-				    unsigned long addr, pte_t *ptep);
 #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
 extern pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 				   unsigned long addr, pte_t *ptep);
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 03cb757f7935..17f1ed34356d 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -260,33 +260,6 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
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
index 081385e0d10a..c41b49948ee9 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -665,9 +665,8 @@ extern int __ptep_set_access_flags(struct vm_area_struct *vma, unsigned long add
 extern int ptep_test_and_clear_young(struct vm_area_struct *vma, unsigned long address,
 				     pte_t *ptep);
 
-#define __HAVE_ARCH_PTEP_SET_WRPROTECT
-static inline void ptep_set_wrprotect(struct mm_struct *mm,
-				      unsigned long address, pte_t *ptep)
+static inline void __ptep_set_wrprotect(struct mm_struct *mm,
+					unsigned long address, pte_t *ptep)
 {
 	atomic_long_and(~(unsigned long)_PAGE_WRITE, (atomic_long_t *)ptep);
 }
@@ -791,6 +790,8 @@ static inline pte_t __ptep_get_and_clear(struct mm_struct *mm,
 #define pte_clear		__pte_clear
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
 #define ptep_set_access_flags	__ptep_set_access_flags
+#define __HAVE_ARCH_PTEP_SET_WRPROTECT
+#define ptep_set_wrprotect	__ptep_set_wrprotect
 
 #define pgprot_nx pgprot_nx
 static inline pgprot_t pgprot_nx(pgprot_t _prot)
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index b2046f4bd445..db13f7bcdd54 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -176,28 +176,6 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
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
index e129578f6500..9ec8792a2f4d 100644
--- a/include/linux/hugetlb_contpte.h
+++ b/include/linux/hugetlb_contpte.h
@@ -28,4 +28,8 @@ extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 				      unsigned long addr, pte_t *ptep,
 				      pte_t pte, int dirty);
 
+#define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
+extern void huge_ptep_set_wrprotect(struct mm_struct *mm,
+				    unsigned long addr, pte_t *ptep);
+
 #endif /* _LINUX_HUGETLB_CONTPTE_H */
diff --git a/mm/hugetlb_contpte.c b/mm/hugetlb_contpte.c
index b4c409d11195..629878765081 100644
--- a/mm/hugetlb_contpte.c
+++ b/mm/hugetlb_contpte.c
@@ -222,3 +222,23 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 
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


