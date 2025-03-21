Return-Path: <linux-kernel+bounces-571301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F445A6BB7B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 14:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9701898199
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A6422A4D8;
	Fri, 21 Mar 2025 13:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="XGzmPQ5+"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C4D224237
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 13:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742562710; cv=none; b=aBvUvM47aZIeX9E9b0nZgDM4RsxL/SZPd+hfOGu+T2eTuTPDcQByCG/0/bwrDFb3ww8UAhMKkbccMO4wcygJPr+zANwko4xts2a+eAHESE2KQgujXdc0fKQwZjALNLufRj/iAWVSQmJbHwmyOoecPb7qd0xME5npRGaBZU2XUQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742562710; c=relaxed/simple;
	bh=idmTROmFvJl3glK8KRym15s6eskRmivlfopnYW7zJZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j2dJSLVLALday4vUFRHBdFugv/CudisortM65OEcfInN3iLyHtCRCrowJvr245wwVKJ7oiuxeMd2Xq27oU9Jfs1iJWC2McDXShzljzyOfA9+uDZ2PLs9UXsO3EykRb8bPuEowx5y2lrj9N6R3eahv+OQ1nE1luc4QSBmFrBU3CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=XGzmPQ5+; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39149bccb69so1829419f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742562706; x=1743167506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g+Ba9lH6i+4JHX31VX+vvn1rf15Jq1WxTsiq92NtkJo=;
        b=XGzmPQ5+OeR6O0YAqNvVlfi3AXbKve3yKP0grCJN2dmEBm/CD0Z+Lfv8cInnAJgvAt
         4v4q078SNhZBOigAwuRRTRL1CK0+K/dyWJQz8eamI8NMW2VFiJLeg4o/877FKxrVQn/U
         X4Pa8UWIuJC6GsrLocWqyYM+aN/tf68/3ZENBrfWjQKN9zcD9iPL0pJOOeThxdfzI6eO
         sTqvrnGGJj8LRnGVpf8QAPr9sJgiVMt/eYth+SdmNmX5OaduuIYeImwwiZP+k4AtQmr3
         iS3HrkkV36BYwL9+SdyTTNB2Mx01nX+PwJC6WrDgVdcDItNV4kbg+hq+xqZ//b90QtkE
         jxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742562706; x=1743167506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g+Ba9lH6i+4JHX31VX+vvn1rf15Jq1WxTsiq92NtkJo=;
        b=JEmIyqud/VWY8LZkpA055xc+tOtSkJ6nh8bal49tJBgXiwqjTOvvSeqK7jETvdOcgS
         7pf+Ccek1RtpY00FpV6G8tBrVSO0R8/dix7DjtNnUqJ+/Y00gHi4ObixE1BtUdBe76eo
         0/hVo3xdc74UqkEeeqLerjGot+ffDUUhpuHgl9Fh5OZfHxxxH85WdMvtxUWowrRRzSvg
         YnyUqjhOu12D2xC2pRKEQT5y/rLBxBcLWI0B45ojaKrdjVDyb8cGLJv0U/vqsvjIQDPU
         0X6e8qPgInVxsdM4en5/9edW8eV9dxmkF2jiOu8rz39bsrP7eQrcLG3isvgmAADD62Ax
         aRKg==
X-Forwarded-Encrypted: i=1; AJvYcCVsQKL6PmwNSH0dexIqwmjecYMMhTpS+T08YjYvpVf6z0awoQRMNawysqJL8i9NxGNGztMxu+57zRaK/as=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8ZNC+AjmJbSC2yoGfbh42vJtrwAoSI4WMPTu2kuOMpccvwwoF
	3JK2UWm6VvAvsi0LW4aj69hGPLh7LyvyEhZ9Jlo59vC7NBdcITSolGuK7u+8Ilw=
X-Gm-Gg: ASbGncs7LIkrI/ugbYir8HnTiHTspCyM+5iplVkizrX5e/NBIe1VrwP7PYZ/JkdQk9v
	79jSVPwvdFHkFm0tLq0b53RFpB95pjWjdpCU3bYjJn+NKdnB6/JYtubJtqNnGlR0A15w5a/QSHJ
	cop3r+CHNUAlj09xAL6JolaTZme+iB0XNVCG5mQ6VyQEnT+bUMZboAUzt9GLNlKQ2z9TGN5VgjR
	NlJZnLekK+nlwGDwtwkI7mCOu0pyXwK2idmVAKQZlrt056EHnnOM/BO5yZTOe1RxjaluK+YpWrr
	hfQ7449SmRFqT8ch/IFE5DjT1WFpitsKrjxajYWgdl9o/0S2qCzppygo2LNDHzQsNTZCFQ==
X-Google-Smtp-Source: AGHT+IEGZPDoYAPQGYmkPYx5aU5RVlINcZRG7cNrGB3gR0sMYyiWL8XPHTT0J17da9GbtboJpKfvoQ==
X-Received: by 2002:a05:6000:154a:b0:38f:3224:660b with SMTP id ffacd0b85a97d-3997f90a69bmr2874098f8f.22.1742562705888;
        Fri, 21 Mar 2025 06:11:45 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com ([2001:861:3382:ef90:3d12:52fe:c1cc:c94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9b26a6sm2310275f8f.44.2025.03.21.06.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 06:11:45 -0700 (PDT)
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
Subject: [PATCH v5 5/9] mm: Use common huge_pte_clear() function for riscv/arm64
Date: Fri, 21 Mar 2025 14:06:31 +0100
Message-Id: <20250321130635.227011-6-alexghiti@rivosinc.com>
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

Both architectures have the same implementation so move it to generic code.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/arm64/include/asm/hugetlb.h |  3 ---
 arch/arm64/mm/hugetlbpage.c      | 12 ------------
 arch/riscv/include/asm/hugetlb.h |  4 ----
 arch/riscv/include/asm/pgtable.h |  5 +++--
 arch/riscv/mm/hugetlbpage.c      | 19 -------------------
 include/linux/hugetlb_contpte.h  |  4 ++++
 mm/hugetlb_contpte.c             | 12 ++++++++++++
 7 files changed, 19 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index cfdc04e11585..ed75631ad63c 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -48,9 +48,6 @@ extern void huge_ptep_set_wrprotect(struct mm_struct *mm,
 #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
 extern pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 				   unsigned long addr, pte_t *ptep);
-#define __HAVE_ARCH_HUGE_PTE_CLEAR
-extern void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
-			   pte_t *ptep, unsigned long sz);
 
 void __init arm64_hugetlb_cma_reserve(void);
 
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 6feb90ed2e7d..99728b02a3ca 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -260,18 +260,6 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
 	return entry;
 }
 
-void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
-		    pte_t *ptep, unsigned long sz)
-{
-	int i, ncontig;
-	size_t pgsize;
-
-	ncontig = arch_contpte_get_num_contig(ptep, sz, &pgsize);
-
-	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
-		__pte_clear(mm, addr, ptep);
-}
-
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, unsigned long sz)
 {
diff --git a/arch/riscv/include/asm/hugetlb.h b/arch/riscv/include/asm/hugetlb.h
index 7049a17b819d..467bc30c2153 100644
--- a/arch/riscv/include/asm/hugetlb.h
+++ b/arch/riscv/include/asm/hugetlb.h
@@ -20,10 +20,6 @@ bool arch_hugetlb_migration_supported(struct hstate *h);
 #endif
 
 #ifdef CONFIG_RISCV_ISA_SVNAPOT
-#define __HAVE_ARCH_HUGE_PTE_CLEAR
-void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
-		    pte_t *ptep, unsigned long sz);
-
 #define __HAVE_ARCH_HUGE_PTEP_GET_AND_CLEAR
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 			      unsigned long addr, pte_t *ptep,
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 5b34b3c9c0f9..72d3592454d3 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -651,8 +651,8 @@ static inline int arch_contpte_get_num_contig(pte_t *ptep, unsigned long size,
 }
 #endif
 
-static inline void pte_clear(struct mm_struct *mm,
-	unsigned long addr, pte_t *ptep)
+static inline void __pte_clear(struct mm_struct *mm,
+			       unsigned long addr, pte_t *ptep)
 {
 	__set_pte_at(mm, ptep, __pte(0));
 }
@@ -787,6 +787,7 @@ static inline pte_t __ptep_get_and_clear(struct mm_struct *mm,
 
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 #define ptep_get_and_clear	__ptep_get_and_clear
+#define pte_clear		__pte_clear
 
 #define pgprot_nx pgprot_nx
 static inline pgprot_t pgprot_nx(pgprot_t _prot)
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index 75faeacc8138..fe82284c3dc4 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -254,25 +254,6 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 	return get_clear_contig_flush(vma->vm_mm, addr, ptep, pte_num);
 }
 
-void huge_pte_clear(struct mm_struct *mm,
-		    unsigned long addr,
-		    pte_t *ptep,
-		    unsigned long sz)
-{
-	size_t pgsize;
-	pte_t pte = ptep_get(ptep);
-	int i, pte_num;
-
-	if (!pte_napot(pte)) {
-		pte_clear(mm, addr, ptep);
-		return;
-	}
-
-	pte_num = arch_contpte_get_num_contig(ptep, sz, &pgsize);
-	for (i = 0; i < pte_num; i++, addr += pgsize, ptep++)
-		pte_clear(mm, addr, ptep);
-}
-
 static bool is_napot_size(unsigned long size)
 {
 	unsigned long order;
diff --git a/include/linux/hugetlb_contpte.h b/include/linux/hugetlb_contpte.h
index 135b68bd09ca..e6aa9befa78c 100644
--- a/include/linux/hugetlb_contpte.h
+++ b/include/linux/hugetlb_contpte.h
@@ -14,4 +14,8 @@ extern void set_huge_pte_at(struct mm_struct *mm,
 			    unsigned long addr, pte_t *ptep, pte_t pte,
 			    unsigned long sz);
 
+#define __HAVE_ARCH_HUGE_PTE_CLEAR
+extern void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
+			   pte_t *ptep, unsigned long sz);
+
 #endif /* _LINUX_HUGETLB_CONTPTE_H */
diff --git a/mm/hugetlb_contpte.c b/mm/hugetlb_contpte.c
index cbf93ffcd882..e881b302dd63 100644
--- a/mm/hugetlb_contpte.c
+++ b/mm/hugetlb_contpte.c
@@ -86,3 +86,15 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 
 	set_contptes(mm, addr, ptep, pte, ncontig, pgsize);
 }
+
+void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
+		    pte_t *ptep, unsigned long sz)
+{
+	int i, ncontig;
+	size_t pgsize;
+
+	ncontig = arch_contpte_get_num_contig(ptep, sz, &pgsize);
+
+	for (i = 0; i < ncontig; i++, addr += pgsize, ptep++)
+		__pte_clear(mm, addr, ptep);
+}
-- 
2.39.2


