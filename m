Return-Path: <linux-kernel+bounces-182794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F918C8FF0
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 09:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C011C219D6
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 07:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72521B95B;
	Sat, 18 May 2024 07:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="AzLk0Rnp"
Received: from out187-6.us.a.mail.aliyun.com (out187-6.us.a.mail.aliyun.com [47.90.187.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE8F15E88
	for <linux-kernel@vger.kernel.org>; Sat, 18 May 2024 07:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.187.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716018716; cv=none; b=aj3Ef+9i9b9qhvQJGZ15wLaTBFY8QnKz7OfFh5wrXFT/ge5aQcWZ0ptf13M8BFSna9friMOFuerADx41Kz/xxLnFXu8jCjqye1N1FUo+pFHBjPOe5YXxfUmrtA9k3xLFTUpMX+J/4/R/gvMOR8WnALnO3RDFXvJpeBZJIu+yECk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716018716; c=relaxed/simple;
	bh=6gtRMnaRzMAo6exZJs5FKaI/uLBziV/3VFxpenmnOQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IJ3OTnY9r4c96psyXpLF90vT8J4jhGoLCoAicuZxtuaKKYjZlsYxaUEdOnxeQDs0MLhS9Bz/UyF62prcWaaqF/xVMjyLBxdPwbsl1J9ypd6jx6JIrcc8qsJYPsJ9xIRbfAzgtr1SQc1pCtNWYEMSkzZyVcrypCH9z2JKnqGPaNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=AzLk0Rnp; arc=none smtp.client-ip=47.90.187.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1716018697; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=+bO7c6Fed9Mvc6QZ6EoE0oDQLTarOYB8F6MuXkDP9CA=;
	b=AzLk0RnprnZBHaKRrVrIKGKWZ3zjnjh95w7mg6XVEdf0WyROrrm3pKgR55nGOxhPPIvLDJn51z1oNxNsBXsqACYyPYz1TskobQoTXmOe/9lf9e2wTYZIL+T0FqwqKEqkKqJlKLUvZTcILxQrPcWhjpRiq5ye3lYXSyF/Vye//Ko=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047207;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---.Xg92GHN_1716018694;
Received: from localhost(mailfrom:libang.li@antgroup.com fp:SMTPD_---.Xg92GHN_1716018694)
          by smtp.aliyun-inc.com;
          Sat, 18 May 2024 15:51:35 +0800
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
Subject: [PATCH v3 1/3] mm: Add update_mmu_tlb_range()
Date: Sat, 18 May 2024 15:49:12 +0800
Message-Id: <20240518074914.52170-2-libang.li@antgroup.com>
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

Added update_mmu_tlb_range(), we can batch update tlb of an
address range.

Signed-off-by: Bang Li <libang.li@antgroup.com>
---
 arch/loongarch/include/asm/pgtable.h | 2 ++
 arch/mips/include/asm/pgtable.h      | 2 ++
 arch/riscv/include/asm/pgtable.h     | 2 ++
 arch/xtensa/include/asm/pgtable.h    | 3 +++
 arch/xtensa/mm/tlb.c                 | 6 ++++++
 5 files changed, 15 insertions(+)

diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index af3acdf3481a..5ccc2a3a6f7a 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -469,6 +469,8 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
 
 #define __HAVE_ARCH_UPDATE_MMU_TLB
 #define update_mmu_tlb	update_mmu_cache
+#define update_mmu_tlb_range(vma, addr, ptep, nr) \
+	update_mmu_cache_range(NULL, vma, addr, ptep, nr)
 
 static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
 			unsigned long address, pmd_t *pmdp)
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index e27a4c83c548..0891ad7d43b6 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -596,6 +596,8 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
 
 #define	__HAVE_ARCH_UPDATE_MMU_TLB
 #define update_mmu_tlb	update_mmu_cache
+#define update_mmu_tlb_range(vma, address, ptep, nr) \
+	update_mmu_cache_range(NULL, vma, address, ptep, nr)
 
 static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
 	unsigned long address, pmd_t *pmdp)
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 661b2b4fe758..fc07b829ac4a 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -488,6 +488,8 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
 
 #define __HAVE_ARCH_UPDATE_MMU_TLB
 #define update_mmu_tlb update_mmu_cache
+#define update_mmu_tlb_range(vma, addr, ptep, nr) \
+	update_mmu_cache_range(NULL, vma, addr, ptep, nr)
 
 static inline void update_mmu_cache_pmd(struct vm_area_struct *vma,
 		unsigned long address, pmd_t *pmdp)
diff --git a/arch/xtensa/include/asm/pgtable.h b/arch/xtensa/include/asm/pgtable.h
index 9a7e5e57ee9a..436158bd9030 100644
--- a/arch/xtensa/include/asm/pgtable.h
+++ b/arch/xtensa/include/asm/pgtable.h
@@ -413,6 +413,9 @@ typedef pte_t *pte_addr_t;
 void update_mmu_tlb(struct vm_area_struct *vma,
 		    unsigned long address, pte_t *ptep);
 #define __HAVE_ARCH_UPDATE_MMU_TLB
+void update_mmu_tlb_range(struct vm_area_struct *vma,
+		unsigned long address, pte_t *ptep, unsigned int nr);
+#define update_mmu_tlb_range update_mmu_tlb_range
 
 #endif /* !defined (__ASSEMBLY__) */
 
diff --git a/arch/xtensa/mm/tlb.c b/arch/xtensa/mm/tlb.c
index d8b60d6e50a8..05efba86b870 100644
--- a/arch/xtensa/mm/tlb.c
+++ b/arch/xtensa/mm/tlb.c
@@ -169,6 +169,12 @@ void update_mmu_tlb(struct vm_area_struct *vma,
 	local_flush_tlb_page(vma, address);
 }
 
+void update_mmu_tlb_range(struct vm_area_struct *vma,
+			unsigned long address, pte_t *ptep, unsigned int nr)
+{
+	local_flush_tlb_range(vma, address, address + PAGE_SIZE * nr);
+}
+
 #ifdef CONFIG_DEBUG_TLB_SANITY
 
 static unsigned get_pte_for_vaddr(unsigned vaddr)
-- 
2.19.1.6.gb485710b


