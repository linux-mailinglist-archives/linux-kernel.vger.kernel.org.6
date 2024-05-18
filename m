Return-Path: <linux-kernel+bounces-182791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 436798C8FED
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 09:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183901C21165
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 07:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2838DDA9;
	Sat, 18 May 2024 07:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="tQzH0J6Q"
Received: from out0-198.mail.aliyun.com (out0-198.mail.aliyun.com [140.205.0.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF928C0B
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 07:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716018710; cv=none; b=QiJgLTMC2xcF+aNUjk3IdsuEhOQpkAH3OsTr2UyEAfKqCS3YGKRxE4nD55Tjw3Oj5WWZAgJS7MhrYtymAMw+dbaZ0IgiBpoPOrG8dAIrZnebV7U+6mHuYOhxRTU3GEfRJQVicFbCQsDxJ7nhI/yCi3eWNykMDiMssWHJZL5JfXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716018710; c=relaxed/simple;
	bh=tt28RIRiqe4eHxuqz7qc6EeeemxSBDg/OmYDRTvOszg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lzXP96/lb6zrPf+yMXaSHgof3nZAtO7wLPyC5u5MKPmu8MJMMz1zmUGy1aPLoGlZKBneR9Cs1xhQY5RqrSh9nNZMx+g/quBzTjq1ExwM/yLZbI/2LDwSwHoPkw2s7ICbLk+idV/BYeKpo0M21tE+AMfVgPZzBVjhuhODsnQnd48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=tQzH0J6Q; arc=none smtp.client-ip=140.205.0.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1716018699; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=B0+VTL/IM0NbM2rCCBStVIPALiltW036NQkMXLbs88g=;
	b=tQzH0J6QWOPay4j1Bxfhhfc0jJ5aWoohj4i3yrOTJORHW94RZKHiurnOOqSKEbLR3tfY+6kQnVo3YnHiC9EZ6tbxYruyk9Fnp/QDtlDjgy71xdkWXPl+mclDAmpPXstiQtJJq3SN8eDDEZpm2U5q02Ia/MMtVXaOHCWtjA3jBts=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047190;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---.XgA9uMI_1716018696;
Received: from localhost(mailfrom:libang.li@antgroup.com fp:SMTPD_---.XgA9uMI_1716018696)
          by smtp.aliyun-inc.com;
          Sat, 18 May 2024 15:51:37 +0800
From: "Bang Li" <libang.li@antgroup.com>
To: akpm@linux-foundation.org,
	chenhuacai@kernel.org,
	tsbogend@alpha.franken.de,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	chris@zankel.net,
	jcmvbkbc@gmail.com
Cc:  <linux-kernel@vger.kernel.org>,
   <linux-mm@kvack.org>,
   <loongarch@lists.linux.dev>,
   <linux-riscv@lists.infradead.org>,
   <david@redhat.com>,
   <ryan.roberts@arm.com>,
   <ioworker0@gmail.com>,
   <libang.linux@gmail.com>,
  "Bang Li" <libang.li@antgroup.com>
Subject: [PATCH v3 2/3] mm: Refactor update_mmu_tlb()
Date: Sat, 18 May 2024 15:49:13 +0800
Message-Id: <20240518074914.52170-3-libang.li@antgroup.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240518074914.52170-1-libang.li@antgroup.com>
References: <20240518074914.52170-1-libang.li@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove update_mmu_tlb() from those architectures and define
generically via update_mmu_tlb_range(), removing the ability
for arches to override it.

Signed-off-by: Bang Li <libang.li@antgroup.com>
---
 arch/loongarch/include/asm/pgtable.h |  2 --
 arch/mips/include/asm/pgtable.h      |  2 --
 arch/riscv/include/asm/pgtable.h     |  2 --
 arch/xtensa/include/asm/pgtable.h    |  3 ---
 arch/xtensa/mm/tlb.c                 |  6 ------
 include/linux/pgtable.h              | 11 ++++++++---
 6 files changed, 8 insertions(+), 18 deletions(-)

diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index 5ccc2a3a6f7a..161dd6e10479 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -467,8 +467,6 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
 #define update_mmu_cache(vma, addr, ptep) \
 	update_mmu_cache_range(NULL, vma, addr, ptep, 1)
 
-#define __HAVE_ARCH_UPDATE_MMU_TLB
-#define update_mmu_tlb	update_mmu_cache
 #define update_mmu_tlb_range(vma, addr, ptep, nr) \
 	update_mmu_cache_range(NULL, vma, addr, ptep, nr)
 
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 0891ad7d43b6..c29a551eb0ca 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -594,8 +594,6 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
 #define update_mmu_cache(vma, address, ptep) \
 	update_mmu_cache_range(NULL, vma, address, ptep, 1)
 
-#define	__HAVE_ARCH_UPDATE_MMU_TLB
-#define update_mmu_tlb	update_mmu_cache
 #define update_mmu_tlb_range(vma, address, ptep, nr) \
 	update_mmu_cache_range(NULL, vma, address, ptep, nr)
 
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index fc07b829ac4a..158170442d2f 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -486,8 +486,6 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
 #define update_mmu_cache(vma, addr, ptep) \
 	update_mmu_cache_range(NULL, vma, addr, ptep, 1)
 
-#define __HAVE_ARCH_UPDATE_MMU_TLB
-#define update_mmu_tlb update_mmu_cache
 #define update_mmu_tlb_range(vma, addr, ptep, nr) \
 	update_mmu_cache_range(NULL, vma, addr, ptep, nr)
 
diff --git a/arch/xtensa/include/asm/pgtable.h b/arch/xtensa/include/asm/pgtable.h
index 436158bd9030..1647a7cc3fbf 100644
--- a/arch/xtensa/include/asm/pgtable.h
+++ b/arch/xtensa/include/asm/pgtable.h
@@ -410,9 +410,6 @@ void update_mmu_cache_range(struct vm_fault *vmf, struct vm_area_struct *vma,
 
 typedef pte_t *pte_addr_t;
 
-void update_mmu_tlb(struct vm_area_struct *vma,
-		    unsigned long address, pte_t *ptep);
-#define __HAVE_ARCH_UPDATE_MMU_TLB
 void update_mmu_tlb_range(struct vm_area_struct *vma,
 		unsigned long address, pte_t *ptep, unsigned int nr);
 #define update_mmu_tlb_range update_mmu_tlb_range
diff --git a/arch/xtensa/mm/tlb.c b/arch/xtensa/mm/tlb.c
index 05efba86b870..0a1a815dc796 100644
--- a/arch/xtensa/mm/tlb.c
+++ b/arch/xtensa/mm/tlb.c
@@ -163,12 +163,6 @@ void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
 	}
 }
 
-void update_mmu_tlb(struct vm_area_struct *vma,
-		    unsigned long address, pte_t *ptep)
-{
-	local_flush_tlb_page(vma, address);
-}
-
 void update_mmu_tlb_range(struct vm_area_struct *vma,
 			unsigned long address, pte_t *ptep, unsigned int nr)
 {
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 18019f037bae..117b807e3f89 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -729,13 +729,18 @@ static inline void clear_full_ptes(struct mm_struct *mm, unsigned long addr,
  * fault. This function updates TLB only, do nothing with cache or others.
  * It is the difference with function update_mmu_cache.
  */
-#ifndef __HAVE_ARCH_UPDATE_MMU_TLB
+#ifndef update_mmu_tlb_range
+static inline void update_mmu_tlb_range(struct vm_area_struct *vma,
+				unsigned long address, pte_t *ptep, unsigned int nr)
+{
+}
+#endif
+
 static inline void update_mmu_tlb(struct vm_area_struct *vma,
 				unsigned long address, pte_t *ptep)
 {
+	update_mmu_tlb_range(vma, address, ptep, 1);
 }
-#define __HAVE_ARCH_UPDATE_MMU_TLB
-#endif
 
 /*
  * Some architectures may be able to avoid expensive synchronization
-- 
2.19.1.6.gb485710b


