Return-Path: <linux-kernel+bounces-571244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D99A6BAE1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0584D3BA1B3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C3522A4F8;
	Fri, 21 Mar 2025 12:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="PySsYvQf"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736A3CA5A
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742560811; cv=none; b=ctBfCcQK4oibgzJUnnNPSERm4tnpX2MtCdY0QCNUT8/tP0pdTjDI2T/mgmbgHo/PyPTM/ixp9yHIfMm8aFvJskonlkEUlVgx0TbcQCasI69N4xeKVbZ6eVrkV10WtffjHPsgrRR+hQbumpkx1Fp6Ye2eUZ3G1VouorDps9UjxO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742560811; c=relaxed/simple;
	bh=wbL6Yr2fgiRGscdBgKn1i1n8hLXa3u4a9RFyc86cEU0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oO+BS92VKN+QCug5sVIQQo4dhJ+a4Pp5rFi0GCM/z9t7OogBAVagrPivMiopOGH0X0IdxcLrslkyU2klyrH1v6FhD1+xShU9Ox1YWKGJvdCNAbSaGybyyWWWxI2wJXR1/oFS722uJ1Zr/Fr/tvsoFU2BwKe0GmCY0ApL/V+RuiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=PySsYvQf; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3912fdddf8fso1967579f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742560806; x=1743165606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=54rLr9I61euILvlhMaBhXDgCyKGyEgMmgO4n1SA6YHE=;
        b=PySsYvQfnPlsQQNvdm/Bus8NIdykOoV/dRVOL3wwAP8YxGPxUrGS5z0KHm5Nz1KwJT
         WPOCcqGPWfjE+ozl+4sV4L/Ecd5fwBusb0YFozZbGNYrCLPGPUUoFxuwLF+tJto4Cc5K
         uiBUU/biamMCbNcubVI6gjWVPO3zbifuB3lbBpnT+TxS6rhJZLXtNExs+PN8i8UQEUR0
         5BvLSoT+zvV/NkHWIYCxpz9HzH7/pcaTRnASyqixgZuCUCFgSnA3iiJ759OwUUIUtWSn
         BiOd8al13e99pSEvnTideK8BiWNtGhf7DX5q8EyODdC8r6BWzJ9v/+dVssD3h1PeYZwO
         iQBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742560806; x=1743165606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=54rLr9I61euILvlhMaBhXDgCyKGyEgMmgO4n1SA6YHE=;
        b=w5PuFH+l0O7NULDHzfB/4jCOk45nx2DTlOXObN1kJS9fqkHeCw+mzQQx2bpgWFgFwd
         Wmy6KC50pmAc4me1nIIFSWJLedh8jnR4umzrIXkuofW39nCUuqo3w6AM3hMybDYPYSKC
         pkM2ye0p6pRCWn1hfQbjiIiDE9+XJ9ENZRBoEUX/aze6FHXiwHnzNURgbuS82NtT0r2s
         gs7a2zwIc+3YPjdSZEa/VzvwgJb9aJ55OyAZj/Xuyk1fLy2UEXIse9fhII2dI+6ZAM9O
         hHB2/Ohi9EB9jPbYzr6K2AIbgIp7PkmoGsLbxnk7Ve65tiRNmVVyc5EzWUme5YkAhd3u
         6dXA==
X-Forwarded-Encrypted: i=1; AJvYcCULHOaFROpgnVtTpAbMXid7PNARgJ45sw7MPd8RgYDC76QdbIZ3adS+L99ZSOz7ooWhPCsSTUg5eEQdwrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6ZCY04lQnB/qFebiHQRi85l9DPkEZo2SWCZmJLP7cyllQv3Wa
	OLzoeLOw+5GxB4mlryz4dHGdrgVEUKX87Bb7tuZqpuU8ZI5K0Q8FPVGF1r/gKcM=
X-Gm-Gg: ASbGncuTmYzd5T2ra454HAXfYWcp6X6opM+Lgv0TE0yqRoy/L9B+qJBwOxBYWI3bSik
	m/2mV9px96fC8Jjsi7P4yQQ+MKLwkIXCtvybR1vxBnp1IpGJ4r2w/H9ad3yv5uC+OfR9DPx4vSV
	wQrT+QOgJPCgh7hp61/ayYxUCSmNzNXpbQ/ndy9LS/OMdk2FxRL7R/SOOdRSS8v44KaIR0gOy4X
	D5egGwTnvhMdZerAmRUOtqJ6rdwRJ6GUWTDHyXr10woeKgvndjf8oIHwXTvgKzsP+iqi6wZQhNk
	cKYUX4vaMkXty13NUaHRgnaT+mUfeMOtJd/9Mn6ebeJoK/UC25d92Q==
X-Google-Smtp-Source: AGHT+IF5g4aUqXmT7kRUsux/61ZQuk8ahvVmMCTSCiEnwytnOngRDQHxxpHZQNkTu0VDgx0+BzQeig==
X-Received: by 2002:a5d:6485:0:b0:391:1218:d5f4 with SMTP id ffacd0b85a97d-3997f93388amr2655970f8f.23.1742560806267;
        Fri, 21 Mar 2025 05:40:06 -0700 (PDT)
Received: from alex-rivos.lan ([2001:861:3382:ef90:3d12:52fe:c1cc:c94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9ef16csm2242730f8f.86.2025.03.21.05.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 05:40:05 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH] riscv: Add support for PUD THP
Date: Fri, 21 Mar 2025 13:39:54 +0100
Message-Id: <20250321123954.225097-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the necessary page table functions to deal with PUD THP, this
enables the use of PUD pfnmap.

Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---

This patch depends on some macros defined in
https://lore.kernel.org/lkml/20250108135700.2614848-1-abrestic@rivosinc.com/
which should get merged in 6.15.

 arch/riscv/Kconfig                  |  1 +
 arch/riscv/include/asm/pgtable-64.h |  5 +-
 arch/riscv/include/asm/pgtable.h    | 97 +++++++++++++++++++++++++++++
 arch/riscv/include/asm/tlbflush.h   |  2 +
 arch/riscv/mm/pgtable.c             | 10 +++
 arch/riscv/mm/tlbflush.c            |  7 +++
 6 files changed, 120 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7612c52e9b1e..b88dea700164 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -138,6 +138,7 @@ config RISCV
 	select HAVE_ARCH_THREAD_STRUCT_WHITELIST
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_TRANSPARENT_HUGEPAGE if 64BIT && MMU
+	select HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD if 64BIT && MMU
 	select HAVE_ARCH_USERFAULTFD_MINOR if 64BIT && USERFAULTFD
 	select HAVE_ARCH_VMAP_STACK if MMU && 64BIT
 	select HAVE_ASM_MODVERSIONS
diff --git a/arch/riscv/include/asm/pgtable-64.h b/arch/riscv/include/asm/pgtable-64.h
index 0897dd99ab8d..a2c00235c447 100644
--- a/arch/riscv/include/asm/pgtable-64.h
+++ b/arch/riscv/include/asm/pgtable-64.h
@@ -184,7 +184,7 @@ static inline int pud_none(pud_t pud)
 
 static inline int pud_bad(pud_t pud)
 {
-	return !pud_present(pud);
+	return !pud_present(pud) || (pud_val(pud) & _PAGE_LEAF);
 }
 
 #define pud_leaf	pud_leaf
@@ -401,6 +401,7 @@ p4d_t *p4d_offset(pgd_t *pgd, unsigned long address);
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 static inline int pte_devmap(pte_t pte);
 static inline pte_t pmd_pte(pmd_t pmd);
+static inline pte_t pud_pte(pud_t pud);
 
 static inline int pmd_devmap(pmd_t pmd)
 {
@@ -409,7 +410,7 @@ static inline int pmd_devmap(pmd_t pmd)
 
 static inline int pud_devmap(pud_t pud)
 {
-	return 0;
+	return pte_devmap(pud_pte(pud));
 }
 
 static inline int pgd_devmap(pgd_t pgd)
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 050fdc49b5ad..10252419ed84 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -849,6 +849,103 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 #define pmdp_collapse_flush pmdp_collapse_flush
 extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
 				 unsigned long address, pmd_t *pmdp);
+
+static inline pud_t pud_wrprotect(pud_t pud)
+{
+	return pte_pud(pte_wrprotect(pud_pte(pud)));
+}
+
+static inline int pud_trans_huge(pud_t pud)
+{
+	return pud_leaf(pud);
+}
+
+static inline int pud_dirty(pud_t pud)
+{
+	return pte_dirty(pud_pte(pud));
+}
+
+static inline pud_t pud_mkyoung(pud_t pud)
+{
+	return pte_pud(pte_mkyoung(pud_pte(pud)));
+}
+
+static inline pud_t pud_mkold(pud_t pud)
+{
+	return pte_pud(pte_mkold(pud_pte(pud)));
+}
+
+static inline pud_t pud_mkdirty(pud_t pud)
+{
+	return pte_pud(pte_mkdirty(pud_pte(pud)));
+}
+
+static inline pud_t pud_mkclean(pud_t pud)
+{
+	return pte_pud(pte_mkclean(pud_pte(pud)));
+}
+
+static inline pud_t pud_mkwrite(pud_t pud)
+{
+	return pte_pud(pte_mkwrite_novma(pud_pte(pud)));
+}
+
+static inline pud_t pud_mkhuge(pud_t pud)
+{
+	return pud;
+}
+
+static inline pud_t pud_mkdevmap(pud_t pud)
+{
+	return pte_pud(pte_mkdevmap(pud_pte(pud)));
+}
+
+static inline int pudp_set_access_flags(struct vm_area_struct *vma,
+					unsigned long address, pud_t *pudp,
+					pud_t entry, int dirty)
+{
+	return ptep_set_access_flags(vma, address, (pte_t *)pudp, pud_pte(entry), dirty);
+}
+
+static inline int pudp_test_and_clear_young(struct vm_area_struct *vma,
+					    unsigned long address, pud_t *pudp)
+{
+	return ptep_test_and_clear_young(vma, address, (pte_t *)pudp);
+}
+
+static inline int pud_young(pud_t pud)
+{
+	return pte_young(pud_pte(pud));
+}
+
+static inline void update_mmu_cache_pud(struct vm_area_struct *vma,
+					unsigned long address, pud_t *pudp)
+{
+	pte_t *ptep = (pte_t *)pudp;
+
+	update_mmu_cache(vma, address, ptep);
+}
+
+static inline pud_t pudp_establish(struct vm_area_struct *vma,
+				   unsigned long address, pud_t *pudp, pud_t pud)
+{
+	page_table_check_pud_set(vma->vm_mm, pudp, pud);
+	return __pud(atomic_long_xchg((atomic_long_t *)pudp, pud_val(pud)));
+}
+
+static inline pud_t pud_mkinvalid(pud_t pud)
+{
+	return __pud(pud_val(pud) & ~(_PAGE_PRESENT | _PAGE_PROT_NONE));
+}
+
+extern pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
+			     pud_t *pudp);
+
+static inline pud_t pud_modify(pud_t pud, pgprot_t newprot)
+{
+	return pte_pud(pte_modify(pud_pte(pud), newprot));
+}
+
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 /*
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 72e559934952..be1ebd03658b 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -56,6 +56,8 @@ void local_flush_tlb_kernel_range(unsigned long start, unsigned long end);
 #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
 void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 			unsigned long end);
+void flush_pud_tlb_range(struct vm_area_struct *vma, unsigned long start,
+			 unsigned long end);
 #endif
 
 bool arch_tlbbatch_should_defer(struct mm_struct *mm);
diff --git a/arch/riscv/mm/pgtable.c b/arch/riscv/mm/pgtable.c
index 4ae67324f992..8b6c0a112a8d 100644
--- a/arch/riscv/mm/pgtable.c
+++ b/arch/riscv/mm/pgtable.c
@@ -154,4 +154,14 @@ pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
 	flush_tlb_mm(vma->vm_mm);
 	return pmd;
 }
+
+pud_t pudp_invalidate(struct vm_area_struct *vma, unsigned long address,
+		      pud_t *pudp)
+{
+	VM_WARN_ON_ONCE(!pud_present(*pudp));
+	pud_t old = pudp_establish(vma, address, pudp, pud_mkinvalid(*pudp));
+
+	flush_pud_tlb_range(vma, address, address + HPAGE_PUD_SIZE);
+	return old;
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 9b6e86ce3867..5765cb6f6c06 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -178,6 +178,13 @@ void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
 			  start, end - start, PMD_SIZE);
 }
+
+void flush_pud_tlb_range(struct vm_area_struct *vma, unsigned long start,
+			 unsigned long end)
+{
+	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
+			  start, end - start, PUD_SIZE);
+}
 #endif
 
 bool arch_tlbbatch_should_defer(struct mm_struct *mm)
-- 
2.39.2


