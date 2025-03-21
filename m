Return-Path: <linux-kernel+bounces-571302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F78A6BB7C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693691894874
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0288122A4DA;
	Fri, 21 Mar 2025 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="uqeZoXIb"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E1E1E376E
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742562771; cv=none; b=B6cYHt2RfqIFgG+w6QTchsT7DnoyfepQD4hL1squ7okXfyZ33c3gkOJfzyflqTK2GwVW6GPBJrrxximbh+gGgSg9vea8f2sWNgaDAEb9Dd3BpN2WtPC/fKp5T9rb6XUjXRMl57ocpaMs0UCF6eoWHINY3JtIfMSIyqe8AzXCheI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742562771; c=relaxed/simple;
	bh=N/5p1FcoIMzGJaMT97eHIHTKEwVr8Hfl1l+4m+sR1mw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rIWaYcJ/bo8f4kkF/HS6FQ61l1gu37/X/86K0+5vyZta3BpacDfsd/jQfToQs0kN/r6eiXtaxSg9ynJh9ojqyU4Hiu6GLagf6kfszjABXvn1h8YDj377v+PNGmR7u2rxTKlMXU5IJeuwRPus12KpHIy6wc8Bw8Q3dGhstc29niQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=uqeZoXIb; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so13627505e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742562768; x=1743167568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tW5CZGKlc6dgOhT2HYLkHYDVp73Jiwu1Hc2Rif5lDWM=;
        b=uqeZoXIbYta/VfL5ZA/3uL7FjhYNRhcXDB1IWMJDe2G+HUL5LD1NXZ5Rz15NBxzjWl
         KSBXwoce+jj3XTXw4ko0fbbXhs/c+6mmpbjLmRtydIqPSwHifaAu/RmXApR5yf5nJfP8
         HEEMv7+W5ZfF2Mc1S+KjmjSbH+ylgGwghrv5cnkFxLsxJqWLmFnWfWIgvn0gduOk9LTI
         NYj42hwngqKqfZbLnY6uKrE7DkaJS3S3ZTCJ2KdZ6iCIN6vq6kMxrwUXyOZPDHeWxH0A
         p5w/Ru3pcuQHiMEDOZJdRB3AzlJMZPA9zRZhCaSH2zXBKzz2FRwxyB2TaEcTrtgGgebR
         qZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742562768; x=1743167568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tW5CZGKlc6dgOhT2HYLkHYDVp73Jiwu1Hc2Rif5lDWM=;
        b=mPXsJazoJ2QU6WnYNmW01cL2PnaHU2WfQcr8QDpU8KsfhMFK+6+2qGB2wsfH2AttjH
         9otow4iUwI7ymZlevZLvPtz/GuaVoulrHb46oGGcKm8E8GPFvpLDBu5dQ3dqYDk3LGaL
         y70UIqy5FettAeMTNH2o188NkiPrqeLDD8jFfBlIMRSted4WUfYLBn7Uh38/4pFak9JO
         HnPZ4mHkk28i3bS9+HKCeIrPyu0G0jDWJQbO/Bln2s9qNRmi8mbFs59KKJScVh8zwKdu
         NsoQUG+Mnx5nYX1MLdSuhUELjpNkKLOf4lwAXwFlEFWQmIzIoFFlT3a7faokTUBj/Q0W
         y+Og==
X-Forwarded-Encrypted: i=1; AJvYcCUp2RH2UlNy76M91shaYwdYDPflL92ETT04GSmpd4T6E8z9Sh7+PF2aeiezAeCRZu8qxb3E9Q+73O0BaEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbb4NsO68tVNK9Tmlsz6hFhNxl/uZNuMgN1C3+geuCwRnxqVmP
	sUd4xknJbffLfFNEuRAi0U3YniT9jsdp9vs3Oo/dGG4UE2c0YPw1vUr3kGfuwnw=
X-Gm-Gg: ASbGncuUznIK/hplZWYLIm8+RwmS5XausKVCXNqc8hFGFJFaVFFBJd5qwaLik5hzXk0
	0sm9I02Fk3nfpBzFeDOKr7Y5MSSfPX4GFNNyW5/RlU8usSG4PqP8L7yBseSLu9nymnzyu9io3Is
	XRdfGGhO5I8z7BPE0Ax5wUfseLd1g6miI1ZInXO9FFUW8PBEFPMhSqkT85p3ERrhhMTFoOm8FI3
	+4nOdCWnj+Yca7oobRqvQQPXilVP9x1uxRVKNg9hGUWfaxRpwaOXMHOk7f3YKf1O3abyuPHXVL4
	xfGqDyVGrj+QfdebfCEAUcbZ0qg0teEkVc3eE6JTUne/l12+9uNjNTMHuaKemAWS1q+GRQ==
X-Google-Smtp-Source: AGHT+IEUtROIBbu/cy/pImYWjl+q4lRngYo9z7idT6KT9+6QFPXCkP6BZJtyCAPZK3CSSAem4Gc0LA==
X-Received: by 2002:a5d:64af:0:b0:391:2db0:2961 with SMTP id ffacd0b85a97d-3997f932efcmr3394631f8f.38.1742562767493;
        Fri, 21 Mar 2025 06:12:47 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com ([2001:861:3382:ef90:3d12:52fe:c1cc:c94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e66c7sm2356167f8f.79.2025.03.21.06.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 06:12:47 -0700 (PDT)
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
Subject: [PATCH v5 6/9] mm: Use common huge_ptep_get_and_clear() function for riscv/arm64
Date: Fri, 21 Mar 2025 14:06:32 +0100
Message-Id: <20250321130635.227011-7-alexghiti@rivosinc.com>
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

Note that get_clear_contig() function is duplicated in the generic and
the arm64 code because it is still used by some arm64 functions that
will, in the next commits, be moved to the generic code. Once all have
been moved, the arm64 version will be removed.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/arm64/include/asm/hugetlb.h |  3 --
 arch/arm64/mm/hugetlbpage.c      | 10 -------
 arch/riscv/include/asm/hugetlb.h |  5 ----
 arch/riscv/mm/hugetlbpage.c      | 15 ----------
 include/linux/hugetlb_contpte.h  |  5 ++++
 mm/hugetlb_contpte.c             | 51 ++++++++++++++++++++++++++++++++
 6 files changed, 56 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index ed75631ad63c..9b1c25775bea 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -39,9 +39,6 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags);
 extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 				      unsigned long addr, pte_t *ptep,
 				      pte_t pte, int dirty);
-#define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
-extern pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
-				     pte_t *ptep, unsigned long sz);
 #define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
 extern void huge_ptep_set_wrprotect(struct mm_struct *mm,
 				    unsigned long addr, pte_t *ptep);
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 99728b02a3ca..62a66ce2b2fe 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -260,16 +260,6 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 	return entry;
 }
 
-pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
-			      pte_t *ptep, unsigned long sz)
-{
-	int ncontig;
-	size_t pgsize;
-
-	ncontig = arch_contpte_get_num_contig(ptep, sz, &pgsize);
-	return get_clear_contig(mm, addr, ptep, pgsize, ncontig);
-}
-
 /*
  * huge_ptep_set_access_flags will update access flags (dirty, accesssed)
  * and write permission.
diff --git a/arch/riscv/include/asm/hugetlb.h b/arch/riscv/include/asm/hugetlb.h
index 467bc30c2153..0fbb6b19df79 100644
--- a/arch/riscv/include/asm/hugetlb.h
+++ b/arch/riscv/include/asm/hugetlb.h
@@ -20,11 +20,6 @@ bool arch_hugetlb_migration_supported(struct hstate *h);
 #endif
 
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
-#define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
-pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-			      unsigned long addr, pte_t *ptep,
-			      unsigned long sz);
-
 #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
 pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 			    unsigned long addr, pte_t *ptep);
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index fe82284c3dc4..87168123d4a2 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -203,21 +203,6 @@ int huge_ptep_set_access_flags(struct vm_area_struct *vma,
 	return true;
 }
 
-pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
-			      unsigned long addr,
-			      pte_t *ptep, unsigned long sz)
-{
-	pte_t orig_pte = ptep_get(ptep);
-	int pte_num;
-
-	if (!pte_napot(orig_pte))
-		return ptep_get_and_clear(mm, addr, ptep);
-
-	pte_num = arch_contpte_get_num_contig(ptep, sz, NULL);
-
-	return get_clear_contig(mm, addr, ptep, pte_num);
-}
-
 void huge_ptep_set_wrprotect(struct mm_struct *mm,
 			     unsigned long addr,
 			     pte_t *ptep)
diff --git a/include/linux/hugetlb_contpte.h b/include/linux/hugetlb_contpte.h
index e6aa9befa78c..1c8f46ff95ea 100644
--- a/include/linux/hugetlb_contpte.h
+++ b/include/linux/hugetlb_contpte.h
@@ -18,4 +18,9 @@ extern void set_huge_pte_at(struct mm_struct *mm,
 extern void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 			   pte_t *ptep, unsigned long sz);
 
+#define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
+extern pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
+				     unsigned long addr, pte_t *ptep,
+				     unsigned long sz);
+
 #endif /* _LINUX_HUGETLB_CONTPTE_H */
diff --git a/mm/hugetlb_contpte.c b/mm/hugetlb_contpte.c
index e881b302dd63..82f49eb79ffb 100644
--- a/mm/hugetlb_contpte.c
+++ b/mm/hugetlb_contpte.c
@@ -98,3 +98,54 @@ void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
 	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
 		__pte_clear(mm, addr, ptep);
 }
+
+/*
+ * ARM: Changing some bits of contiguous entries requires us to follow a
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
+ * This helper performs the break step.
+ */
+static pte_t get_clear_contig(struct mm_struct *mm,
+			     unsigned long addr,
+			     pte_t *ptep,
+			     unsigned long pgsize,
+			     unsigned long ncontig)
+{
+	pte_t pte, tmp_pte;
+	bool present;
+
+	pte = __ptep_get_and_clear(mm, addr, ptep);
+	present = pte_present(pte);
+	while (--ncontig) {
+		ptep++;
+		addr += pgsize;
+		tmp_pte = __ptep_get_and_clear(mm, addr, ptep);
+		if (present) {
+			if (pte_dirty(tmp_pte))
+				pte = pte_mkdirty(pte);
+			if (pte_young(tmp_pte))
+				pte = pte_mkyoung(pte);
+		}
+	}
+	return pte;
+}
+
+pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
+			      unsigned long addr, pte_t *ptep, unsigned long sz)
+{
+	int ncontig;
+	size_t pgsize;
+
+	ncontig = arch_contpte_get_num_contig(ptep, sz, &pgsize);
+
+	return get_clear_contig(mm, addr, ptep, pgsize, ncontig);
+}
-- 
2.39.2


