Return-Path: <linux-kernel+bounces-432980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53CC9E528F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 11:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6661A167916
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 10:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3171F429B;
	Thu,  5 Dec 2024 10:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="aTWOpJLQ"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559B21DB951
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733395110; cv=none; b=PDtOJpU19ONHPjI/iKqod7+tOVvAohEj4NUcPKFL2g98y3XCpYCdUbLA6SZ5BbaMXPBkara7v1R13W2ogxJCsHMzOLiBI4S8YCWCcoErA2+8tCXBaqfYAjuKpG9ALyqjiL5oZYuxaagt9n9An5PuokNpykO1cKKaS8UoUebcjCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733395110; c=relaxed/simple;
	bh=iaiXED/tqibRXcFpLigD3NvJz1CulAasWjUYazfFtPc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fzrfH+FfmlHQP5Kgg/tQCZtVQuQF5e54DPZuVUPVBaGYv0XoU2Pd7YbXinrNEJB0PD1cUO4ed8sHgauEthpOkW/B5fgSgV3HKMdDzizTqTpefosLZ4WFKLpBzkd3TEAzuNxeUkb+d8flw+xa9ntCuBctRrixzAF9X+57ztyB6SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=aTWOpJLQ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fcfac22a30so832252a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 02:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1733395108; x=1733999908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HFQIXohFMC+aCLCj7cIVe0JD4G758F8Hwu3svQYABEY=;
        b=aTWOpJLQpSF75/OhWUsAWdmRJmhklV2DlaxSg/3IT7WwdLbkTHdh3/zGg+CL+tyQjn
         xY0pHJZBTS802R0y3Q78XglE5c8HjkTQaNP/rzOomPcs7q+PbLn4zYuuRQGs9hTRGLam
         jKLAYBxNNICIvWdLQRGq7XIihkVpNCvYdKLmMFKHguHJBmxJAo5B5BOBi7QrWzbH6b1k
         fh05d+UEDyDlpbowKIdZCYH37rmYwJ3wqbLQez6DlR2xWiqwct8RGA1r7alBQ/DjuUJ6
         su+/eyaAMo6Py+M4jFYz/IBKSo/lsZ95pRcEWmKLai40P64EE9BNVSsrH4o/sHt4jNB5
         N8GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733395108; x=1733999908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HFQIXohFMC+aCLCj7cIVe0JD4G758F8Hwu3svQYABEY=;
        b=mBmzc93QZrMVlEe1TqqP4ic3OIjYiUZlAYInUCTETpuImheJTLPFwa2e0Y3BNlfDvZ
         fXMlzhcWaXNLekh4pnCMJvQXfMKqDMHbxMMpkZHhZljTb53fO6F6z+0wGpPf1J/V8zkz
         SdB8dzIBCQGxQqt9Vdr0fBTW1MyaHf4hlCwvem19zTZNz5NrZTQroQWeyWYjGnr862tA
         GHRZ9DCRLVaq40VkWtJJ82v2VXll2G4wgYuZIFPaD11HRsbFRw/7H9KjnlFZtN0yGQaQ
         eUMlUzyRGJs9CV6loCYjpxM7MhHSJn6F4EGiH/1dNS6WG60L5QfH985xhlcllDgIA8hm
         2Ujg==
X-Forwarded-Encrypted: i=1; AJvYcCUbo0oTx8M/PL10N7no69rjCgtsKdNF/ZrjwWoLKPcWycEtnhFuVX7fMdwXO8hPabczeC2HXcIxGveIPP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE0Ms6EZg8t9W2fXQXiWyg53H34YHGIDCV0vIkolRzMKjQUpN/
	sxmGXKHBsEFFykwAqSYndflQ0LMLoxqSv8yAYczoZxeEt+UzK4Omc0iofarTG2Y=
X-Gm-Gg: ASbGncsdfhXeqI3OBcH8vYzjQxwg+OGe8GX4p21V/sMLQRMk3JolY4RYpy22F+3uXnT
	8JZxaq0mf3+x993VNdVvpRd6w5mt3a4+4jqXOM1b0XNxGRXdeBEn9hQ2djzWts6KCqWlRuIYpfY
	OpGz0zsDob9XkAGUChViW1RHHC0s0sdJQR84bS1iQKJXkRa61MU1x6Bnp6aWy/7mUi28K6a1tlt
	IiGr4lnrdTvgt1QEG/p3FYgN0Jp5gsvJYs7Ns4wOp5twZe9mjFNZ1IPIyqJ+oRypiiXPd1YvBH3
	F/yvdHSFgn7HQOtMBeVvDIodEKey8xmY
X-Google-Smtp-Source: AGHT+IEVSD+tgAqJx2WiLXY6iHldH8R0b3LHGoJ+robZaZ03Gbz5dxvb2ZG0GtuQ60x2xrNdVJqFOw==
X-Received: by 2002:a05:6300:4041:b0:1e1:1659:82a4 with SMTP id adf61e73a8af0-1e16541341fmr16353259637.41.1733395107751;
        Thu, 05 Dec 2024 02:38:27 -0800 (PST)
Received: from J9GPGXL7NT.bytedance.net ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156f048csm886826a12.39.2024.12.05.02.38.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Dec 2024 02:38:27 -0800 (PST)
From: Xu Lu <luxu.kernel@bytedance.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	ardb@kernel.org,
	anup@brainfault.org,
	atishp@atishpatra.org
Cc: xieyongji@bytedance.com,
	lihangjing@bytedance.com,
	punit.agrawal@bytedance.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Xu Lu <luxu.kernel@bytedance.com>
Subject: [RFC PATCH v2 12/21] riscv: mm: Reimplement tlb flush function
Date: Thu,  5 Dec 2024 18:37:20 +0800
Message-Id: <20241205103729.14798-13-luxu.kernel@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241205103729.14798-1-luxu.kernel@bytedance.com>
References: <20241205103729.14798-1-luxu.kernel@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When tlb flushing a page correponding to a certain address, CPU actually
only flushes tlb entries of the first 4K hardware page. This commit
reimplements tlb flushing function to flush all tlb entries of hardware pages
in the same software page.

Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>
---
 arch/riscv/include/asm/pgtable.h  |  9 ++++++---
 arch/riscv/include/asm/tlbflush.h | 26 ++++++++++++++++++++------
 arch/riscv/mm/fault.c             | 13 +++++++++----
 arch/riscv/mm/init.c              |  2 +-
 arch/riscv/mm/tlbflush.c          | 31 +++++++++++++++++++++----------
 5 files changed, 57 insertions(+), 24 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index c0f7442c8a9e..9fa16c0c20aa 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -701,7 +701,7 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
 	 * the extra traps reduce performance.  So, eagerly SFENCE.VMA.
 	 */
 	while (nr--)
-		local_flush_tlb_page(address + nr * PAGE_SIZE);
+		local_flush_tlb_page(address + nr * PAGE_SIZE, PAGE_SIZE);
 
 svvptc:;
 	/*
@@ -719,9 +719,12 @@ svvptc:;
 static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
 		unsigned long address, pmd_t *pmdp)
 {
-	pte_t *ptep = (pte_t *)pmdp;
+	asm goto(ALTERNATIVE("nop", "j %l[svvptc]", 0, RISCV_ISA_EXT_SVVPTC, 1)
+		 : : : : svvptc);
 
-	update_mmu_cache(vma, address, ptep);
+	local_flush_tlb_page(address, PMD_SIZE);
+
+svvptc:;
 }
 
 #define __HAVE_ARCH_PTE_SAME
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 72e559934952..25cc39ab84d5 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -29,18 +29,32 @@ static inline void local_flush_tlb_all_asid(unsigned long asid)
 }
 
 /* Flush one page from local TLB */
-static inline void local_flush_tlb_page(unsigned long addr)
+static inline void local_flush_tlb_page(unsigned long addr,
+					unsigned long page_size)
 {
-	ALT_SFENCE_VMA_ADDR(addr);
+	unsigned int i;
+	unsigned long hw_page_num = 1 << (PAGE_SHIFT - HW_PAGE_SHIFT);
+	unsigned long hw_page_size = page_size >> (PAGE_SHIFT - HW_PAGE_SHIFT);
+
+	for (i = 0; i < hw_page_num; i++, addr += hw_page_size)
+		ALT_SFENCE_VMA_ADDR(addr);
 }
 
 static inline void local_flush_tlb_page_asid(unsigned long addr,
+					     unsigned long page_size,
 					     unsigned long asid)
 {
-	if (asid != FLUSH_TLB_NO_ASID)
-		ALT_SFENCE_VMA_ADDR_ASID(addr, asid);
-	else
-		local_flush_tlb_page(addr);
+	unsigned int i;
+	unsigned long hw_page_num, hw_page_size;
+
+	if (asid != FLUSH_TLB_NO_ASID) {
+		hw_page_num = 1 << (PAGE_SHIFT - HW_PAGE_SHIFT);
+		hw_page_size = page_size >> (PAGE_SHIFT - HW_PAGE_SHIFT);
+
+		for (i = 0; i < hw_page_num; i++, addr += hw_page_size)
+			ALT_SFENCE_VMA_ADDR_ASID(addr, asid);
+	} else
+		local_flush_tlb_page(addr, page_size);
 }
 
 void flush_tlb_all(void);
diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
index 4772152be0f9..94524e5adc0b 100644
--- a/arch/riscv/mm/fault.c
+++ b/arch/riscv/mm/fault.c
@@ -118,7 +118,7 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
 	pmd_t *pmd_k;
 	pte_t *pte_k;
 	int index;
-	unsigned long pfn;
+	unsigned long pfn, page_size;
 
 	/* User mode accesses just cause a SIGSEGV */
 	if (user_mode(regs))
@@ -154,8 +154,10 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
 		no_context(regs, addr);
 		return;
 	}
-	if (pud_leaf(pudp_get(pud_k)))
+	if (pud_leaf(pudp_get(pud_k))) {
+		page_size = PUD_SIZE;
 		goto flush_tlb;
+	}
 
 	/*
 	 * Since the vmalloc area is global, it is unnecessary
@@ -166,8 +168,10 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
 		no_context(regs, addr);
 		return;
 	}
-	if (pmd_leaf(pmdp_get(pmd_k)))
+	if (pmd_leaf(pmdp_get(pmd_k))) {
+		page_size = PMD_SIZE;
 		goto flush_tlb;
+	}
 
 	/*
 	 * Make sure the actual PTE exists as well to
@@ -180,6 +184,7 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
 		no_context(regs, addr);
 		return;
 	}
+	page_size = PAGE_SIZE;
 
 	/*
 	 * The kernel assumes that TLBs don't cache invalid
@@ -188,7 +193,7 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
 	 * necessary even after writing invalid entries.
 	 */
 flush_tlb:
-	local_flush_tlb_page(addr);
+	local_flush_tlb_page(addr, page_size);
 }
 
 static inline bool access_error(unsigned long cause, struct vm_area_struct *vma)
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index f9334aab45a6..678b892b4ed8 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -356,7 +356,7 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
 		set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, prot));
 	else
 		pte_clear(&init_mm, addr, ptep);
-	local_flush_tlb_page(addr);
+	local_flush_tlb_page(addr, PAGE_SIZE);
 }
 
 static inline pte_t *__init get_pte_virt_early(phys_addr_t pa)
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 9b6e86ce3867..d5036f2a8244 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -27,7 +27,7 @@ static void local_flush_tlb_range_threshold_asid(unsigned long start,
 	}
 
 	for (i = 0; i < nr_ptes_in_range; ++i) {
-		local_flush_tlb_page_asid(start, asid);
+		local_flush_tlb_page_asid(start, stride, asid);
 		start += stride;
 	}
 }
@@ -36,7 +36,7 @@ static inline void local_flush_tlb_range_asid(unsigned long start,
 		unsigned long size, unsigned long stride, unsigned long asid)
 {
 	if (size <= stride)
-		local_flush_tlb_page_asid(start, asid);
+		local_flush_tlb_page_asid(start, stride, asid);
 	else if (size == FLUSH_TLB_MAX_SIZE)
 		local_flush_tlb_all_asid(asid);
 	else
@@ -126,14 +126,7 @@ void flush_tlb_mm_range(struct mm_struct *mm,
 			  start, end - start, page_size);
 }
 
-void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
-{
-	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
-			  addr, PAGE_SIZE, PAGE_SIZE);
-}
-
-void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
-		     unsigned long end)
+static inline unsigned long local_flush_tlb_page_size(struct vm_area_struct *vma)
 {
 	unsigned long stride_size;
 
@@ -161,6 +154,24 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
 		}
 	}
 
+	return stride_size;
+}
+
+void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
+{
+	unsigned long page_size;
+
+	page_size = local_flush_tlb_page_size(vma);
+	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
+			  addr, page_size, page_size);
+}
+
+void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
+		     unsigned long end)
+{
+	unsigned long stride_size;
+
+	stride_size = local_flush_tlb_page_size(vma);
 	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
 			  start, end - start, stride_size);
 }
-- 
2.20.1


