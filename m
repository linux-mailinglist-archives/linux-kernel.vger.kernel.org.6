Return-Path: <linux-kernel+bounces-173763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D50568C0507
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 21:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87FE8282EED
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 19:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E5D130A63;
	Wed,  8 May 2024 19:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="aNY+A7nq"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272CAD534
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715196591; cv=none; b=DIgjGZSYecxp0TJSMrqqmmXRpLTRGjo+MdCp6seoODdXiB0nrpSvL/F5+h4x0QVgUbU/rpKL3KaheoyF1RIZhnOhOihyPlmsqEDVNseG9AXHbbFoHFRdmvFm6L84LVzWDMmqybun0TFYtFZPlkiKTB+17933AvPI74EM91yWrSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715196591; c=relaxed/simple;
	bh=gHarnxk3+TQDW2Of9KtkFTyUbjl3FMDQzz2bLlhHcjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fgRp/DJiIW/WUeYxRCUOgS6ofOtUW2OTjhhYLE2v1p9P6rbfb9yFEwlE02T3VPcLwwyWkTOc3uU38TbIId8qTnHi+fFW/CL9o0UvKjwJ42D1plU9UdVnZrHxOxgvyeemCJUYGVXIdoCMsypnglHq/ZnlQXj9Gb7kGtEKPCHMnjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=aNY+A7nq; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41b794510cdso611845e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 12:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715196587; x=1715801387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uckq1a6OF7H/9ROfgD12E/DRrLJPxYkFYbl5+hSyETI=;
        b=aNY+A7nqvoGdE8Zq3WOfOfLYZWlHlLYK88ZlsUU+DYmX5vtL4glONYUnD46AZSoiVH
         UYMHQ/PgKZzxXQ990RbM2HyNfpIo57AyYpbusjBLUKJE3ozks+TK0b6YEGUTn6fy7gzR
         1q2vzmh93+FH3H2RqnQfPgjOm0DAZS3qJrLr+rh/F+/bh/zKPR3WjPFxo9Fcaf1DTvzl
         AkCLymgFRQ0JTl4D6g0YnMxEq5Tqgu6g83U+3kxuYgey83bz8DLoKHmbgW2J2OM1Hsqy
         IJEIguqyYO4qU9iu4I4uJnFDlAJvYUVl11FCBPBv67ittsZ9i5zDadcnB6hJfZkSEObo
         p1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715196587; x=1715801387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uckq1a6OF7H/9ROfgD12E/DRrLJPxYkFYbl5+hSyETI=;
        b=A/g7Ph3uTAh+e0xks5iG9ounrvTwoJ1m877HY3fWJ9YgPE86sGa3f1DLyjgC0+t03Y
         8MbpsbQ3SOC8bKFoee64OETh53QKBTAGlQnlLF/HbmZMh0sQhWFP/WCRFmWXyWs31Yqc
         tgMLh5Xutmi9eN/IL7Kli6UTWGgJohP5tsMTFOhHuZC90qBklXULQPYkuBdJKTmVAcZq
         ungbxhufdahVSqx1ZujIlthWWo5uvDpN89KogOOIASEuBN+sbhZNJVJjvyCNzsbEZC07
         jLujYmum936/lJoh6sDoL6n2n6+tFB03VDuJpa4PGhiQ9NYz5swp74xxXoDFNfBdKuUh
         a56A==
X-Forwarded-Encrypted: i=1; AJvYcCWvTMXK/lzx3lv6edgBaFUtzTtiliEKegi5Mc9I1Ae3SKk+qkDSQUznvUO1/ClIL9Kzy3xYGHhP+cwRDIZP7RuNQPlQEDo9lxXoehPQ
X-Gm-Message-State: AOJu0YxxsHUMcEMYuKYqZLci4MUv3rJM/YkNp/ykVRgzv+vWx3ohMbM2
	szxMB24wu+VyhW2gCyaIeiCQ14WfTwGs6Zw53tnxLLZ0qC1W87dkbHEwtDONJ6I=
X-Google-Smtp-Source: AGHT+IGQ61Vb4NuwkawA/0/DWqDCfOJMo7+D5f/tM30tLGXtIG6xkHE311QLb6FnYOpUeATe3M4jpQ==
X-Received: by 2002:a05:600c:4e93:b0:41b:fc3a:f1ef with SMTP id 5b1f17b1804b1-41f71acca18mr25217385e9.33.1715196587426;
        Wed, 08 May 2024 12:29:47 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id d16-20020a05600c34d000b00419f572671dsm3314921wmq.20.2024.05.08.12.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 12:29:47 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Ryan Roberts <ryan.roberts@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Ard Biesheuvel <ardb@kernel.org>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-riscv@lists.infradead.org,
	linux-efi@vger.kernel.org,
	kvm@vger.kernel.org,
	kvm-riscv@lists.infradead.org,
	linux-mm@kvack.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH 10/12] mm, riscv, arm64: Use common ptep_set_access_flags() function
Date: Wed,  8 May 2024 21:19:29 +0200
Message-Id: <20240508191931.46060-11-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240508191931.46060-1-alexghiti@rivosinc.com>
References: <20240508191931.46060-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make riscv use the contpte aware ptep_set_access_flags() function from
arm64.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/arm64/include/asm/pgtable.h | 19 ++--------
 arch/arm64/mm/contpte.c          | 46 -----------------------
 arch/riscv/include/asm/pgtable.h | 10 +++--
 include/linux/contpte.h          |  3 ++
 mm/contpte.c                     | 63 ++++++++++++++++++++++++++++++++
 5 files changed, 76 insertions(+), 65 deletions(-)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 92c12fb85cb4..6591aab11c67 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1391,9 +1391,6 @@ extern pte_t contpte_get_and_clear_full_ptes(struct mm_struct *mm,
 				unsigned int nr, int full);
 extern void contpte_wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
 				pte_t *ptep, unsigned int nr);
-extern int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
-				unsigned long addr, pte_t *ptep,
-				pte_t entry, int dirty);
 
 #define pte_batch_hint pte_batch_hint
 static inline unsigned int pte_batch_hint(pte_t *ptep, pte_t pte)
@@ -1512,19 +1509,9 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm,
 }
 
 #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
-static inline int ptep_set_access_flags(struct vm_area_struct *vma,
-				unsigned long addr, pte_t *ptep,
-				pte_t entry, int dirty)
-{
-	pte_t orig_pte = __ptep_get(ptep);
-
-	entry = pte_mknoncont(entry);
-
-	if (likely(!pte_valid_cont(orig_pte)))
-		return __ptep_set_access_flags(vma, addr, ptep, entry, dirty);
-
-	return contpte_ptep_set_access_flags(vma, addr, ptep, entry, dirty);
-}
+extern int ptep_set_access_flags(struct vm_area_struct *vma,
+				 unsigned long addr, pte_t *ptep,
+				 pte_t entry, int dirty);
 
 #else /* CONFIG_THP_CONTPTE */
 
diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index 16940511943c..5675a61452ac 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -62,49 +62,3 @@ void contpte_wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
 	__wrprotect_ptes(mm, addr, ptep, nr);
 }
 EXPORT_SYMBOL_GPL(contpte_wrprotect_ptes);
-
-int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
-					unsigned long addr, pte_t *ptep,
-					pte_t entry, int dirty)
-{
-	unsigned long start_addr;
-	pte_t orig_pte;
-	int i;
-
-	/*
-	 * Gather the access/dirty bits for the contiguous range. If nothing has
-	 * changed, its a noop.
-	 */
-	orig_pte = pte_mknoncont(ptep_get(ptep));
-	if (pte_val(orig_pte) == pte_val(entry))
-		return 0;
-
-	/*
-	 * We can fix up access/dirty bits without having to unfold the contig
-	 * range. But if the write bit is changing, we must unfold.
-	 */
-	if (pte_write(orig_pte) == pte_write(entry)) {
-		/*
-		 * For HW access management, we technically only need to update
-		 * the flag on a single pte in the range. But for SW access
-		 * management, we need to update all the ptes to prevent extra
-		 * faults. Avoid per-page tlb flush in __ptep_set_access_flags()
-		 * and instead flush the whole range at the end.
-		 */
-		ptep = arch_contpte_align_down(ptep);
-		start_addr = addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
-
-		for (i = 0; i < CONT_PTES; i++, ptep++, addr += PAGE_SIZE)
-			__ptep_set_access_flags(vma, addr, ptep, entry, 0);
-
-		if (dirty)
-			__flush_tlb_range(vma, start_addr, addr,
-							PAGE_SIZE, true, 3);
-	} else {
-		__contpte_try_unfold(vma->vm_mm, addr, ptep, orig_pte);
-		__ptep_set_access_flags(vma, addr, ptep, entry, dirty);
-	}
-
-	return 1;
-}
-EXPORT_SYMBOL_GPL(contpte_ptep_set_access_flags);
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 42c7884b8d2e..b151a5aa4de8 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -803,6 +803,10 @@ extern int ptep_test_and_clear_young(struct vm_area_struct *vma,
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
 extern int ptep_clear_flush_young(struct vm_area_struct *vma,
 				  unsigned long addr, pte_t *ptep);
+#define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
+extern int ptep_set_access_flags(struct vm_area_struct *vma,
+				 unsigned long address, pte_t *ptep,
+				 pte_t entry, int dirty);
 
 #else /* CONFIG_THP_CONTPTE */
 
@@ -816,11 +820,11 @@ extern int ptep_clear_flush_young(struct vm_area_struct *vma,
 #define ptep_test_and_clear_young	__ptep_test_and_clear_young
 #define __HAVE_ARCH_PTEP_CLEAR_YOUNG_FLUSH
 #define ptep_clear_flush_young	__ptep_clear_flush_young
+#define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
+#define ptep_set_access_flags	__ptep_set_access_flags
 
 #endif /* CONFIG_THP_CONTPTE */
 
-#define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
-#define ptep_set_access_flags	__ptep_set_access_flags
 #define __HAVE_ARCH_PTEP_SET_WRPROTECT
 #define ptep_set_wrprotect	__ptep_set_wrprotect
 
@@ -990,7 +994,7 @@ static inline int pmdp_set_access_flags(struct vm_area_struct *vma,
 					unsigned long address, pmd_t *pmdp,
 					pmd_t entry, int dirty)
 {
-	return ptep_set_access_flags(vma, address, (pte_t *)pmdp, pmd_pte(entry), dirty);
+	return __ptep_set_access_flags(vma, address, (pte_t *)pmdp, pmd_pte(entry), dirty);
 }
 
 #define __HAVE_ARCH_PMDP_TEST_AND_CLEAR_YOUNG
diff --git a/include/linux/contpte.h b/include/linux/contpte.h
index 76a49ac8b6f5..76244b0c678a 100644
--- a/include/linux/contpte.h
+++ b/include/linux/contpte.h
@@ -23,5 +23,8 @@ int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
 				      unsigned long addr, pte_t *ptep);
 int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
 				   unsigned long addr, pte_t *ptep);
+int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
+				  unsigned long addr, pte_t *ptep,
+				  pte_t entry, int dirty);
 
 #endif /* _LINUX_CONTPTE_H */
diff --git a/mm/contpte.c b/mm/contpte.c
index 600277b1196c..9cbbff1f67ad 100644
--- a/mm/contpte.c
+++ b/mm/contpte.c
@@ -769,4 +769,67 @@ __always_inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 
 	return contpte_ptep_clear_flush_young(vma, addr, ptep);
 }
+
+int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
+				  unsigned long addr, pte_t *ptep,
+				  pte_t entry, int dirty)
+{
+	unsigned long start_addr;
+	pte_t orig_pte;
+	int i;
+
+	/*
+	 * Gather the access/dirty bits for the contiguous range. If nothing has
+	 * changed, its a noop.
+	 */
+	orig_pte = pte_mknoncont(ptep_get(ptep));
+	if (pte_val(orig_pte) == pte_val(entry))
+		return 0;
+
+	/*
+	 * We can fix up access/dirty bits without having to unfold the contig
+	 * range. But if the write bit is changing, we must unfold.
+	 */
+	if (pte_write(orig_pte) == pte_write(entry)) {
+		/*
+		 * For HW access management, we technically only need to update
+		 * the flag on a single pte in the range. But for SW access
+		 * management, we need to update all the ptes to prevent extra
+		 * faults. Avoid per-page tlb flush in __ptep_set_access_flags()
+		 * and instead flush the whole range at the end.
+		 */
+		size_t pgsize;
+		int ncontig;
+
+		ptep = arch_contpte_align_down(ptep);
+		ncontig = arch_contpte_get_num_contig(vma->vm_mm, addr, ptep, 0, &pgsize);
+		start_addr = addr = ALIGN_DOWN(addr, ncontig * pgsize);
+
+		for (i = 0; i < ncontig; i++, ptep++, addr += pgsize)
+			__ptep_set_access_flags(vma, addr, ptep, entry, 0);
+
+		if (dirty)
+			arch_contpte_flush_tlb_range(vma, start_addr, addr, pgsize);
+	} else {
+		__contpte_try_unfold(vma->vm_mm, addr, ptep, orig_pte);
+		__ptep_set_access_flags(vma, addr, ptep, entry, dirty);
+	}
+
+	return 1;
+}
+EXPORT_SYMBOL_GPL(contpte_ptep_set_access_flags);
+
+__always_inline int ptep_set_access_flags(struct vm_area_struct *vma,
+					  unsigned long addr, pte_t *ptep,
+					  pte_t entry, int dirty)
+{
+	pte_t orig_pte = __ptep_get(ptep);
+
+	entry = pte_mknoncont(entry);
+
+	if (likely(!pte_valid_cont(orig_pte)))
+		return __ptep_set_access_flags(vma, addr, ptep, entry, dirty);
+
+	return contpte_ptep_set_access_flags(vma, addr, ptep, entry, dirty);
+}
 #endif /* CONFIG_THP_CONTPTE */
-- 
2.39.2


