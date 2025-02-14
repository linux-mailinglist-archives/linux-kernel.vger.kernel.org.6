Return-Path: <linux-kernel+bounces-514698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F41DA35A69
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 10:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C48316FDBE
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 09:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F130221DAD;
	Fri, 14 Feb 2025 09:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/arBpN/"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA9418FDBD
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739525451; cv=none; b=UEET8g0vaahMxT30IIXbu8PqThRW0m+Bc9+O6hHL+7MLKYM1hNqGQiimqIsF5emBCD/RoIrLxPeYApQuifXvqhnco0XPvi9cP0tkgYUybak5hp6Onc9c+j2xwb7kQihPuae2AZgmLyPuH9t6Oihx3OnIKj5Vtx4LoJNchmzRJUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739525451; c=relaxed/simple;
	bh=fat60E0/AuDZtxv4fKUrkKoTVSxJqTnhW4q5O4B6gh8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cTp5B1F47SuLtMKhNXVx+GB8pfAItUUGTF0wMWc3f9PKVbclze7/oS+3NW2vYx7cqvEzGIhwpXP3PZ7e4Y3jxP1Hettk2qqPU9fq6pXLK34q2xw4ukWizRJUZdstvll0E2nGsZ8Iv+EJRI09Gu2U+SAOkO3shtilqzt2DFmmlrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/arBpN/; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21f78b1fb7dso31374305ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 01:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739525449; x=1740130249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYY5o/q5rsrfsQ4J/LjZ+h5x5F/3ppu3Uc96Z+8j+c0=;
        b=e/arBpN/s6bEasTRMxAn4ZRCxJYNbvUEgM7OGT5X6C2XoD1ibBZJ4ccQs4PGCidPLE
         Kq87VZkfoapgdH7XfCUZQsNUyQzmJ6WD0a0QBvsniz1lZZUdCtnWrlUQ64EC+azrza0Z
         OMaYDNBlF+VqGgtHL/+wkWB0SOmRzrCnsPsSnFOaBl5pZ+CCb6Ljve/78c9BTv2bZuHQ
         x5ZQ7POyWuK6Te+mIWB3KvvCaEOfA6dLahckeTS+Yy0HqBUi1nLBAd1MKb4MRIEOlcYY
         NbwpY32DbvSoncOVVR2cNmLOIXIt5qWdKNrKOSc0Qeen16AWgTuyQY4+9qNpKTTnAoJb
         YAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739525449; x=1740130249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYY5o/q5rsrfsQ4J/LjZ+h5x5F/3ppu3Uc96Z+8j+c0=;
        b=t8dYsxJb+0JzSkcq7XI0ZblXIRBF8Na9fI29DGPTryyK6IsDN6pRhjc5SXbQ4ZMHeE
         RylZclaAgNW4MIa6Xjx+q+DhKOzklS0YaYt3zcMZ4yR4ICJ2BEg47H+VWAcyez0I7Q8j
         XXCzfeKHfe5GzJ9TCQSR9dYXbuCLQql/d4F3sAfVVf1FgYvwY2MOqfubc5qQpx8sVFVJ
         XBIlkeqGSYLLkmudqke9JQ3RWobiVF27yBhzYjW2JHeyfMpNZFh7UvIm5dzNRNZMwcCH
         rWpjDfGbjMMZhZbdJhimr9swWmRJucYagYuR/41lGJgIGXcLm2OIYEv2iqh0c3LqsMsd
         RieQ==
X-Forwarded-Encrypted: i=1; AJvYcCWqherYqjYlJn64GUhuHH7xSvDYt2o3d8eORWAGLGLhrn2kR84VTX+eNHmZ76X5baLZT1PQinguvV2B5Ug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8JzmWSMOpxpKsMRTNzVeBFFc68DVkozX4IkHSBslMYnLRSTEB
	znv2PQQqz7SbKyTke7zHF/CfGEZRuDYF3PqUF8SNQNxq3QvrgLId
X-Gm-Gg: ASbGncu48kD6JN+xjWzZA7uJvcFx9sv0MfXAJWYs6J2pBQWKFXi5Ov2ljCS51i8Y5iO
	hUtBFWrEk1IV8XKkwEKq+9xvzcXW7rY8JwvGdKufNcWlCeg/Mntdlww3O285F+BCWeLK4cg+JvN
	KYjgl2Qsyprb/PvR1DJpCqpG8EsRx88H9u9upIUNe2nimWQVA3F0fSRUJVSXWMgorcFfvvcLtpL
	59B+ZzgQ4c/xEwpp2CqylRz3YxDBh3rJ2X9oIZPyO4BW5cxaP42y0XOJ6gm3xgeNoMnl4RdvflL
	04Ukt0i5z8U7LMimXeJa0h2uKY4xc8Q=
X-Google-Smtp-Source: AGHT+IGBw+VKYQOOSQZMxOqYuMGxHuHa76uW0Guam1HUKu41ToHalQ66sh7ofZywZvlaeJqNnNB3MA==
X-Received: by 2002:a17:903:2292:b0:20d:cb6:11e with SMTP id d9443c01a7336-220bbb101fbmr163987715ad.26.1739525448736;
        Fri, 14 Feb 2025 01:30:48 -0800 (PST)
Received: from Barrys-MBP.hub ([118.92.30.135])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545c814sm25440515ad.148.2025.02.14.01.30.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 14 Feb 2025 01:30:48 -0800 (PST)
From: Barry Song <21cnbao@gmail.com>
To: akpm@linux-foundation.org,
	linux-mm@kvack.org
Cc: 21cnbao@gmail.com,
	baolin.wang@linux.alibaba.com,
	chrisl@kernel.org,
	david@redhat.com,
	ioworker0@gmail.com,
	kasong@tencent.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	lorenzo.stoakes@oracle.com,
	ryan.roberts@arm.com,
	v-songbaohua@oppo.com,
	x86@kernel.org,
	ying.huang@intel.com,
	zhengtangquan@oppo.com,
	Catalin Marinas <catalin.marinas@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Shaoqin Huang <shahuang@redhat.com>,
	Gavin Shan <gshan@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Will Deacon <will@kernel.org>,
	Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v4 2/4] mm: Support tlbbatch flush for a range of PTEs
Date: Fri, 14 Feb 2025 22:30:13 +1300
Message-Id: <20250214093015.51024-3-21cnbao@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250214093015.51024-1-21cnbao@gmail.com>
References: <20250214093015.51024-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Barry Song <v-songbaohua@oppo.com>

This patch lays the groundwork for supporting batch PTE unmapping in
try_to_unmap_one(). It introduces range handling for TLB batch flushing,
with the range currently set to the size of PAGE_SIZE.

The function __flush_tlb_range_nosync() is architecture-specific and is
only used within arch/arm64. This function requires the mm structure
instead of the vma structure. To allow its reuse by
arch_tlbbatch_add_pending(), which operates with mm but not vma, this
patch modifies the argument of __flush_tlb_range_nosync() to take mm
as its parameter.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shaoqin Huang <shahuang@redhat.com>
Cc: Gavin Shan <gshan@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Lance Yang <ioworker0@gmail.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Yosry Ahmed <yosryahmed@google.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Barry Song <v-songbaohua@oppo.com>
Acked-by: Will Deacon <will@kernel.org>
Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm64/include/asm/tlbflush.h | 23 +++++++++++------------
 arch/arm64/mm/contpte.c           |  2 +-
 arch/riscv/include/asm/tlbflush.h |  3 +--
 arch/riscv/mm/tlbflush.c          |  3 +--
 arch/x86/include/asm/tlbflush.h   |  3 +--
 mm/rmap.c                         | 10 +++++-----
 6 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index bc94e036a26b..b7e1920570bd 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -322,13 +322,6 @@ static inline bool arch_tlbbatch_should_defer(struct mm_struct *mm)
 	return true;
 }
 
-static inline void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
-					     struct mm_struct *mm,
-					     unsigned long uaddr)
-{
-	__flush_tlb_page_nosync(mm, uaddr);
-}
-
 /*
  * If mprotect/munmap/etc occurs during TLB batched flushing, we need to
  * synchronise all the TLBI issued with a DSB to avoid the race mentioned in
@@ -448,7 +441,7 @@ static inline bool __flush_tlb_range_limit_excess(unsigned long start,
 	return false;
 }
 
-static inline void __flush_tlb_range_nosync(struct vm_area_struct *vma,
+static inline void __flush_tlb_range_nosync(struct mm_struct *mm,
 				     unsigned long start, unsigned long end,
 				     unsigned long stride, bool last_level,
 				     int tlb_level)
@@ -460,12 +453,12 @@ static inline void __flush_tlb_range_nosync(struct vm_area_struct *vma,
 	pages = (end - start) >> PAGE_SHIFT;
 
 	if (__flush_tlb_range_limit_excess(start, end, pages, stride)) {
-		flush_tlb_mm(vma->vm_mm);
+		flush_tlb_mm(mm);
 		return;
 	}
 
 	dsb(ishst);
-	asid = ASID(vma->vm_mm);
+	asid = ASID(mm);
 
 	if (last_level)
 		__flush_tlb_range_op(vale1is, start, pages, stride, asid,
@@ -474,7 +467,7 @@ static inline void __flush_tlb_range_nosync(struct vm_area_struct *vma,
 		__flush_tlb_range_op(vae1is, start, pages, stride, asid,
 				     tlb_level, true, lpa2_is_enabled());
 
-	mmu_notifier_arch_invalidate_secondary_tlbs(vma->vm_mm, start, end);
+	mmu_notifier_arch_invalidate_secondary_tlbs(mm, start, end);
 }
 
 static inline void __flush_tlb_range(struct vm_area_struct *vma,
@@ -482,7 +475,7 @@ static inline void __flush_tlb_range(struct vm_area_struct *vma,
 				     unsigned long stride, bool last_level,
 				     int tlb_level)
 {
-	__flush_tlb_range_nosync(vma, start, end, stride,
+	__flush_tlb_range_nosync(vma->vm_mm, start, end, stride,
 				 last_level, tlb_level);
 	dsb(ish);
 }
@@ -533,6 +526,12 @@ static inline void __flush_tlb_kernel_pgtable(unsigned long kaddr)
 	dsb(ish);
 	isb();
 }
+
+static inline void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
+		struct mm_struct *mm, unsigned long start, unsigned long end)
+{
+	__flush_tlb_range_nosync(mm, start, end, PAGE_SIZE, true, 3);
+}
 #endif
 
 #endif
diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
index 55107d27d3f8..bcac4f55f9c1 100644
--- a/arch/arm64/mm/contpte.c
+++ b/arch/arm64/mm/contpte.c
@@ -335,7 +335,7 @@ int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
 		 * eliding the trailing DSB applies here.
 		 */
 		addr = ALIGN_DOWN(addr, CONT_PTE_SIZE);
-		__flush_tlb_range_nosync(vma, addr, addr + CONT_PTE_SIZE,
+		__flush_tlb_range_nosync(vma->vm_mm, addr, addr + CONT_PTE_SIZE,
 					 PAGE_SIZE, true, 3);
 	}
 
diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
index 72e559934952..ce0dd0fed764 100644
--- a/arch/riscv/include/asm/tlbflush.h
+++ b/arch/riscv/include/asm/tlbflush.h
@@ -60,8 +60,7 @@ void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
 
 bool arch_tlbbatch_should_defer(struct mm_struct *mm);
 void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
-			       struct mm_struct *mm,
-			       unsigned long uaddr);
+		struct mm_struct *mm, unsigned long start, unsigned long end);
 void arch_flush_tlb_batched_pending(struct mm_struct *mm);
 void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
 
diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
index 9b6e86ce3867..74dd9307fbf1 100644
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@ -186,8 +186,7 @@ bool arch_tlbbatch_should_defer(struct mm_struct *mm)
 }
 
 void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
-			       struct mm_struct *mm,
-			       unsigned long uaddr)
+		struct mm_struct *mm, unsigned long start, unsigned long end)
 {
 	cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
 }
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 02fc2aa06e9e..29373da7b00a 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -279,8 +279,7 @@ static inline u64 inc_mm_tlb_gen(struct mm_struct *mm)
 }
 
 static inline void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
-					     struct mm_struct *mm,
-					     unsigned long uaddr)
+		struct mm_struct *mm, unsigned long start, unsigned long end)
 {
 	inc_mm_tlb_gen(mm);
 	cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
diff --git a/mm/rmap.c b/mm/rmap.c
index 1320527e90cd..89e51a7a9509 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -672,7 +672,7 @@ void try_to_unmap_flush_dirty(void)
 	(TLB_FLUSH_BATCH_PENDING_MASK / 2)
 
 static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval,
-				      unsigned long uaddr)
+		unsigned long start, unsigned long end)
 {
 	struct tlbflush_unmap_batch *tlb_ubc = &current->tlb_ubc;
 	int batch;
@@ -681,7 +681,7 @@ static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval,
 	if (!pte_accessible(mm, pteval))
 		return;
 
-	arch_tlbbatch_add_pending(&tlb_ubc->arch, mm, uaddr);
+	arch_tlbbatch_add_pending(&tlb_ubc->arch, mm, start, end);
 	tlb_ubc->flush_required = true;
 
 	/*
@@ -757,7 +757,7 @@ void flush_tlb_batched_pending(struct mm_struct *mm)
 }
 #else
 static void set_tlb_ubc_flush_pending(struct mm_struct *mm, pte_t pteval,
-				      unsigned long uaddr)
+		unsigned long start, unsigned long end)
 {
 }
 
@@ -1946,7 +1946,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
 				 */
 				pteval = ptep_get_and_clear(mm, address, pvmw.pte);
 
-				set_tlb_ubc_flush_pending(mm, pteval, address);
+				set_tlb_ubc_flush_pending(mm, pteval, address, address + PAGE_SIZE);
 			} else {
 				pteval = ptep_clear_flush(vma, address, pvmw.pte);
 			}
@@ -2329,7 +2329,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
 				 */
 				pteval = ptep_get_and_clear(mm, address, pvmw.pte);
 
-				set_tlb_ubc_flush_pending(mm, pteval, address);
+				set_tlb_ubc_flush_pending(mm, pteval, address, address + PAGE_SIZE);
 			} else {
 				pteval = ptep_clear_flush(vma, address, pvmw.pte);
 			}
-- 
2.39.3 (Apple Git-146)


