Return-Path: <linux-kernel+bounces-272721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1308D94603B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 17:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C82F62854AE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 15:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C6A1537B0;
	Fri,  2 Aug 2024 15:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="bUaJ5lJg"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5569E1537AF
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722611985; cv=none; b=BgYtej3pfglUQRuwy+uBkCJT85aYhNqu6s7BiK/Unb9t9AzTb7wWMlOIiKV6W5fDnwfg3fgSKlWDjsxq+NgWI3Yx8Aron16BelJgHFMW0o4JrUWtrVF45CSU0EwwuhVSZZRtt3O5F2qse48L9Ut7UaBau+20NWGze5ZbGYugDHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722611985; c=relaxed/simple;
	bh=9FrFlj2L0ryStjbifv1/nU9eaMk3fNfgko5/2YZO9rk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ROq7q2GlgjCA1mym3p3PmLz6FwV7NL3ayOpo7BlE1KX0jKnEDZJGhY8nV+zG5rJxxRYSjrQkgr6I63fvarofrh9HclSvrnEKLoJPbWbpiui6PsHr8o69NSTPnr+LXXDqei7aqyDbMxQIEU16hl5khHP+DE5g0kYGLlRD0Y5QGII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=bUaJ5lJg; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso105961351fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 08:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1722611981; x=1723216781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgy6e6djKCEiajpx++weOAekuViyBMKy0O9RS2EJI5E=;
        b=bUaJ5lJg77SJhlI+K5OKgMCJJl1sEDADHLWGThkmByDN+18iF5s+AGEluF/V1+eTjs
         pvuUkJugXET6WKxPYyljYLbhYHNr45Z05zFcchaZNOyOUwym2fnuWSsP6jJEMdW7M/BZ
         W1os0jZIfmBb1DnujYMbLrLbN8RIDQtKWErDa6aOhe5PTKWUZCwv220P0hej1Hz6OV6L
         ZyH52OYV/qoXvsJnsLsL1H7KFpqFftSMgGfvnVDDd8BPP5TdGMMxYeEsZl1Fr2hDkSIb
         ln51mo4ZjHi0FdpcUI2/Wz9GNjA/dBxFMvBNcEv05i0X8UOcdcveFJUMvFKfyyQYyIzK
         rmbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722611981; x=1723216781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgy6e6djKCEiajpx++weOAekuViyBMKy0O9RS2EJI5E=;
        b=RMhhhpKazfIT+UEbzsVKp2Rs0jmbBBOKSqRk1xcENliHNBPfYe8fv+HEWpCqOoMYIk
         RByxDIRG6BreZGbPK0JecM4E4bxMBZ0B99QRq1TAXfARm141Cw2IiRva586HLIzlrpT/
         3Q2GSLijiyLlsnQ4jQ5lOeq+A8I+9ENlXdPwdEPqoVqdRqkM2BGsYPwbS19VyDhmTriZ
         w48nUUKKAgeaVQx7h4WX9mPKMqRjazqXWvLF1cix0DhbjxyD6cD6FlyKC24reeTeQa2p
         Eq2WqXBgSum0L1mw6wHAM7DccIzLRNI1eGVDPkHKC2jJJGxKMuadroQkt2C1crcowaEZ
         tqcg==
X-Forwarded-Encrypted: i=1; AJvYcCWL/iyYdxBihn48YFImAj5X+TbfY+4Q+AxHZC5ZyRv59jXyC79VLmv6Enb2RE68GZMt6nMI+3TkvDYkHScwEtd5t4ThtUD2EEnCth3i
X-Gm-Message-State: AOJu0Yxgcuh5o1ouv40jH96/6RNPAYbFLr6IAVNCFvDpf01zkGGivcsl
	mphMMwTmh15ZALj5ZVpC/jl9iqRKJeMaDJ4USwLn6JqwQRurjTZ4+oQwsvAG8NU=
X-Google-Smtp-Source: AGHT+IEILpnFvb14vizaqdHNCAsEefKY8W5fJrghMGpJs4NQI541WsQVt7UAPN57wbPSjoIKa73jbQ==
X-Received: by 2002:a05:651c:b06:b0:2f1:6a30:6754 with SMTP id 38308e7fff4ca-2f16a3067dbmr1525221fa.12.1722611981105;
        Fri, 02 Aug 2024 08:19:41 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f15e17e840sm1828141fa.12.2024.08.02.08.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 08:19:40 -0700 (PDT)
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
Subject: [PATCH v3 5/9] mm: Use common huge_pte_clear() function for riscv/arm64
Date: Fri,  2 Aug 2024 17:14:26 +0200
Message-Id: <20240802151430.99114-6-alexghiti@rivosinc.com>
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

Both architectures have the same implementation so move it to generic code.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/arm64/include/asm/hugetlb.h |  3 ---
 arch/arm64/mm/hugetlbpage.c      | 12 ------------
 arch/riscv/include/asm/hugetlb.h |  4 ----
 arch/riscv/include/asm/pgtable.h |  5 +++--
 arch/riscv/mm/hugetlbpage.c      | 19 -------------------
 include/linux/hugetlb_contpte.h  |  4 ++++
 mm/hugetlb_contpte.c             | 14 ++++++++++++++
 7 files changed, 21 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
index d35093b7ab59..fab0afbe4eea 100644
--- a/arch/arm64/include/asm/hugetlb.h
+++ b/arch/arm64/include/asm/hugetlb.h
@@ -40,9 +40,6 @@ extern void huge_ptep_set_wrprotect(struct mm_struct *mm,
 #define __HAVE_ARCH_HUGE_PTEP_CLEAR_FLUSH
 extern pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 				   unsigned long addr, pte_t *ptep);
-#define __HAVE_ARCH_HUGE_PTE_CLEAR
-extern void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
-			   pte_t *ptep, unsigned long sz);
 
 void __init arm64_hugetlb_cma_reserve(void);
 
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index c7130d1f07c4..495f706e0170 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -266,18 +266,6 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
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
 pte_t huge_ptep_get_and_clear(struct mm_struct *mm,
 			      unsigned long addr, pte_t *ptep)
 {
diff --git a/arch/riscv/include/asm/hugetlb.h b/arch/riscv/include/asm/hugetlb.h
index 28cbf5d761e1..ca9930cdf2e6 100644
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
 			      unsigned long addr, pte_t *ptep);
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 46b409e558b3..5ab0559b0bd2 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -615,8 +615,8 @@ static inline int arch_contpte_get_num_contig(pte_t *ptep, unsigned long size,
 }
 #endif
 
-static inline void pte_clear(struct mm_struct *mm,
-	unsigned long addr, pte_t *ptep)
+static inline void __pte_clear(struct mm_struct *mm,
+			       unsigned long addr, pte_t *ptep)
 {
 	__set_pte_at(mm, ptep, __pte(0));
 }
@@ -731,6 +731,7 @@ static inline pte_t ptep_get(pte_t *ptep)
 
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 #define ptep_get_and_clear	__ptep_get_and_clear
+#define pte_clear		__pte_clear
 
 #define pgprot_nx pgprot_nx
 static inline pgprot_t pgprot_nx(pgprot_t _prot)
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index 0ecb2846c3f0..e2093e7266a5 100644
--- a/arch/riscv/mm/hugetlbpage.c
+++ b/arch/riscv/mm/hugetlbpage.c
@@ -251,25 +251,6 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
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
index 7acd734a75e8..d9892a047b2b 100644
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
index 9a3a376784b0..b9634ffa1bad 100644
--- a/mm/hugetlb_contpte.c
+++ b/mm/hugetlb_contpte.c
@@ -12,6 +12,7 @@
  *   - __ptep_get()
  *   - __set_ptes()
  *   - __ptep_get_and_clear()
+ *   - __pte_clear()
  *   - pte_cont()
  *   - arch_contpte_get_num_contig()
  */
@@ -20,6 +21,7 @@
  * This file implements the following contpte aware API:
  *   - huge_ptep_get()
  *   - set_huge_pte_at()
+ *   - huge_pte_clear()
  */
 
 pte_t huge_ptep_get(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
@@ -101,3 +103,15 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 
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


