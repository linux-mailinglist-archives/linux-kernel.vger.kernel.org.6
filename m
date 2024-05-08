Return-Path: <linux-kernel+bounces-173130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 205358BFBE8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 13:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F0C281C9F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 11:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0250181ADA;
	Wed,  8 May 2024 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qLK70wl7"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7189D8174F
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715167426; cv=none; b=M5wGyzlBh61WIf1XOwaTJfgwKqRQmnNin7Z9i8T0IvBVbaReJleEYR8+NhNNqoefsy3TMuS3+jU9af9Rcz4h3NHtmxwFuza9kMtY53897spXlIQblEesvmIazWxwQJlnEkDJDYhTOePTmxH3jm+7D6W1o8TrTGfZrcx7QPOn8/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715167426; c=relaxed/simple;
	bh=VcXd6zYXwEr2WPHeuoMzH4NNHOKAqqGKrEMxYOSoP+o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rvfQOadubDaiPzrxWCCYg3mOqzjAXdHI4ntMRyrLDAAXA/K5SCAlbG85bP1BM55FOcDptDKTiRgKNMxFbJLNM+vz2YnhmHHGLVnufDxRZTMOraUlxWFboVFq14y2MzXPHWGe3I1objkgcuEvpugvg4/KLXy/PXYRuOmxtxI6sWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qLK70wl7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41bab13ca81so43728025e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 04:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715167423; x=1715772223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hkOJ479CewvDdU5HWPEgLgm2sAjKEVUPHaCHVUUKnDI=;
        b=qLK70wl7BKlsjrXg+woIQ6opeKCaEhGczrgHAWgau8aTkO44EMGrp5cz8pa6ZEfpAJ
         gnX7wqgZhi4HTmdl3Fu9VAVraGUfrOoDvDX6xkMRo/bhEMaOHYCAD1hnDIguZuCq0MW7
         /3TbcPjeg7GU6aVaNsg8pLEixubR7NYEiPJPd7ndANaFPQOQvc36icaXCBqUoo9Jah51
         niul8J9iOVF03BOfZja8T62A7HGwc8+qsShDi42TUTp8rJhtMn9fhzujknxABxAF+NvF
         z8yk1Oe6EyA5LO4SyD6qoeVh9SWYvAF1jlalXn8wSTbVOEYauRZcpdNT4Qp8oqqUCwHT
         IEXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715167423; x=1715772223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hkOJ479CewvDdU5HWPEgLgm2sAjKEVUPHaCHVUUKnDI=;
        b=mxAuS7LcRnw0w0czgPnAFeqNmvV4xFIIG2hhL4pUnq2ndVHd8DTFzkNxB3urUOcUlX
         ThG9gh+Qx8kToAQ/9nvlQJVwyYMyec+mUt5f1IsHkG6OCWDi/kIkpguz4Ks01htHlesV
         jzUKmg27XXYgGKacmlNa/veNQQ/zKD6BvZJTtRelIfHQi2CSAn5UUkVpzW6qaPHSlzB1
         GL8SBp75+Iz6X6dWjcazH9pNO9r/jkC0nN9MiG0NNYaESaALpqEnBpMLe91cRHGDiWsO
         W7vAOI4wlOuYus/p8xtuNsjjk4Fjy5AvdiDHSiZwfZdclrastMX8i86+zqs7qbM/hxVP
         1O/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtrzHoscAQ5IyOej5Q8dZcG4dA3zoBdJ9Tt0/zyNFoZYhNVdKcb5zxThZnf8O3ousKY4TRaToJt4orNbHQtoElZ/ORBCivQL3GpN/Y
X-Gm-Message-State: AOJu0Yw2UNasdOhsQs3qxT13xfJcJ4dvcZXXOs1hyouJ7m7O482KE0ER
	R9uJRyl2/JSQqOgP81wi+0266YUdG5IabMQAYxAvUULhb1+/lJ1xnycA9wS2qA8=
X-Google-Smtp-Source: AGHT+IFALljM8hm4oiWBT04Jw0JLiRkkyPDpkUx9yCVH0D1QlIeoTfNU3Xx59AzAW7ujf7brtTm4rA==
X-Received: by 2002:a05:600c:3d93:b0:41a:adc3:f777 with SMTP id 5b1f17b1804b1-41f7130a17bmr26482125e9.16.1715167422759;
        Wed, 08 May 2024 04:23:42 -0700 (PDT)
Received: from localhost.localdomain (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c4fce00b0041bf685921dsm1992749wmq.0.2024.05.08.04.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 04:23:41 -0700 (PDT)
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
Subject: [PATCH v2 5/9] mm: Use common huge_pte_clear() function for riscv/arm64
Date: Wed,  8 May 2024 13:18:25 +0200
Message-Id: <20240508111829.16891-6-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240508111829.16891-1-alexghiti@rivosinc.com>
References: <20240508111829.16891-1-alexghiti@rivosinc.com>
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


