Return-Path: <linux-kernel+bounces-173158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F638BFC4A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B791C1C2292E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FACA823BF;
	Wed,  8 May 2024 11:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="PtJNC531"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64801823D1
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168373; cv=none; b=S8po4BeN4QwlZwt5yWPW1ffbdKPzyx2I1MHVPDZr7pmJsGCAaVAYXl2IoQMNR8veKA0GD0+SWOvBF2z0qd3PoZooU5hLbDtCCmfRj+LxerYZrOBjjlF7cdDl3BKfLh/I/LVFmZGfsLB7GIuaW4xHid9us4JsFfe+FDOakMhoQ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168373; c=relaxed/simple;
	bh=VcXd6zYXwEr2WPHeuoMzH4NNHOKAqqGKrEMxYOSoP+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wzxj4ieOyEIbk7vQqSK6ADh2wV0+Q9AOhIaopiBs74IG4g2I0Gyx3VIMrLhCOmtUjGlbLYegQyL+qxOMH65RBkLUHkq3upvmcXgrpLsIdMaFt5ebuFrUaAl2Ca9EXFPFgUy2F0NNCVuWj1IIBt6dqHd26zUI4R6Aab0Vf4kCnCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=PtJNC531; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41bab13ca81so43858135e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 04:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715168370; x=1715773170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkOJ479CewvDdU5HWPEgLgm2sAjKEVUPHaCHVUUKnDI=;
        b=PtJNC531nvw14TSDwudd1ix+TWHgxDy1kUHhkvgqaF+9iKum0PsXMf3+Gz6YmN0nLM
         zsbafbI5HRrUA5BvopsPX+YrD5WwGoMcpD9JrmcxV9FQpbEydlVYZnf57Hte0mwvBH6Z
         /AB9qMPHhFON0KKRevnb7RxorspyC9lONdy6kPIieL+Ggrr4Ldh8YvAKhre7oZXUZ4xE
         G6KgeMizXqi2bodLZZMI7iCQ+oBvL0eqeDELpZG3mlI8toErpFuMaskQT0MvxxyVeCiD
         aG68I7ytfGrYbiuPprKMxmpjdj2CfEHQAfcCVfTXdHw+ISI1X6J0VgdclVABjpPDicdd
         zEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715168370; x=1715773170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkOJ479CewvDdU5HWPEgLgm2sAjKEVUPHaCHVUUKnDI=;
        b=nwrZfWENK2hq/hla+uN0NhfQJJIEAEIOSG4+PSwoU+4+cuDrwklaUI6psFzUaxN0Ba
         ZaraiJXXH2NCrrZfjiPS50L7uLKJ1en+5Ww58wN7vgtwt4S+xObZLmAVhWDMK8MZyIxX
         r/Tlob0A7e5xwG12QE6nhTiW2sizr42h6LjEui66kHglrw8KhYcz6URk0Tnl1Db3n020
         ZYejhasTNoOOsZrsTXshlUFOrQfSB6f3RtAwOVymyrWNN58APvkH2hf2+eeYMDEAblW1
         NZ+3F15+zUtjkDUH4bbteySZyGt5pCpXkJoUBe6i6FAFflzFxEP2U2D6LTczZuCOujfW
         UODA==
X-Forwarded-Encrypted: i=1; AJvYcCVHHhzLdUA+A6Ikss06+tlbLI+QfsyIusWCQthaDmaMpK8+CU5GimMAwBs3HqenY10XpgZOffldZ5EIp/ScGz4JlpSmqqvNkcdmJ4Dv
X-Gm-Message-State: AOJu0YwUJOuipgrskfXjQuYdOyuzkMWLBlMxrqRb6TKbtOP9xWxVEkDm
	FWn8yBL6iN2KZi1i7C8Z5z5ys2lqBhEgCEJGxwcOnsNiHDxnZcIpFv4gVTtIaFQ=
X-Google-Smtp-Source: AGHT+IEZS4ddGwIWcQuhI1g6wktPlm5wrgDKEngfcuzPllSn67aCj73nYZBEmuYd+HrBwCZhVDrutw==
X-Received: by 2002:adf:e752:0:b0:34d:17f2:956d with SMTP id ffacd0b85a97d-34fca80dffcmr2356969f8f.66.1715168369782;
        Wed, 08 May 2024 04:39:29 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f88110ff8sm20241365e9.38.2024.05.08.04.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 04:39:29 -0700 (PDT)
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
Subject: [PATCH RESEND v2 5/9] mm: Use common huge_pte_clear() function for riscv/arm64
Date: Wed,  8 May 2024 13:34:15 +0200
Message-Id: <20240508113419.18620-6-alexghiti@rivosinc.com>
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

Both architectures have the same implementation so move it to generic code.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/arm64/mm/hugetlbpage.c      | 12 ------------
 arch/riscv/include/asm/pgtable.h |  5 +++--
 arch/riscv/mm/hugetlbpage.c      | 19 -------------------
 mm/contpte.c                     | 14 ++++++++++++++
 4 files changed, 17 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index b8353b0a273c..cf44837369be 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -277,18 +277,6 @@ pte_t arch_make_huge_pte(pte_t entry, unsigned int shift, vm_flags_t flags)
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
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 5d1d3a6c7c44..0847a7fb8661 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -644,8 +644,8 @@ static inline void __set_ptes(struct mm_struct *mm, unsigned long addr,
 #define set_contptes(mm, addr, ptep, pte, nr, pgsize)			\
 			__set_ptes(mm, addr, ptep, pte, nr)
 
-static inline void pte_clear(struct mm_struct *mm,
-	unsigned long addr, pte_t *ptep)
+static inline void __pte_clear(struct mm_struct *mm,
+			       unsigned long addr, pte_t *ptep)
 {
 	__set_pte_at(mm, ptep, __pte(0));
 }
@@ -700,6 +700,7 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 #define set_ptes		__set_ptes
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 #define ptep_get_and_clear	__ptep_get_and_clear
+#define pte_clear		__pte_clear
 
 #define pgprot_nx pgprot_nx
 static inline pgprot_t pgprot_nx(pgprot_t _prot)
diff --git a/arch/riscv/mm/hugetlbpage.c b/arch/riscv/mm/hugetlbpage.c
index d8f07aef758b..437b1df059eb 100644
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
-	pte_num = arch_contpte_get_num_contig(ptep, 0, &pgsize);
-	for (i = 0; i < pte_num; i++, addr += pgsize, ptep++)
-		pte_clear(mm, addr, ptep);
-}
-
 static bool is_napot_size(unsigned long size)
 {
 	unsigned long order;
diff --git a/mm/contpte.c b/mm/contpte.c
index 2320ee23478a..22e0de197bd3 100644
--- a/mm/contpte.c
+++ b/mm/contpte.c
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
 
 pte_t huge_ptep_get(pte_t *ptep)
@@ -102,3 +104,15 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 
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


