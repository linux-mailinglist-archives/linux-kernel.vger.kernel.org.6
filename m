Return-Path: <linux-kernel+bounces-185799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C37978CBB0B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 08:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2372DB2184A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 06:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782E178C7C;
	Wed, 22 May 2024 06:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="n4XTxQW7"
Received: from out0-218.mail.aliyun.com (out0-218.mail.aliyun.com [140.205.0.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9937580A
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 06:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716358413; cv=none; b=meWiHTPNepB0+Yp/EmZbVXiAw3LxnoLdNOt0gN6Lc3CT97fduL8N0hUQXkyDIUyKpC6W7KfZVNQXlkuniZNwDAsoEf9xCPh67dICLTo4li5BVbWfjYQ3zqkKax6xL5Im3KH88m1hvB/PKKlvrPLUpopHYn8UE7Tk0BQIFYHzn/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716358413; c=relaxed/simple;
	bh=Xt0REtd+DR/3fOTEBJmnS1QOQXtPn9QES5jayrguzf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=peSC4nHBIv6GMuxiiX4FucoY1Y2G654JK/pJbqdMHjyMRCma5jwTrsJZ0Ftz/upZ4+GcM9LsivWREdWMlPPpEaRMNxqVmR7tnonzs41x5T1Nhx09UxAhwjfKi8ghQS7QLYcg9bw8eJQsryEE7YZtLBQMpPBLwjSHWzzhzA8grZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=n4XTxQW7; arc=none smtp.client-ip=140.205.0.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1716358403; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=NpGCr7uMs7nN0Q+sV09/b3UAtSy1OaurTOZpW7g+KIc=;
	b=n4XTxQW7iyJ2SH9oAXmAdIPlldLlTIEYLs4dtnbe8LenqEk2V1X7j23n/HMbRoHzcpmmbsVKN39V/YJUbayd6Wtn6A/gUQcsTv7n8q8A/GOnKL/MKRXb2L8cKedl7uBsXBGFZpbJpCea3sQsN7MDu6Ro0aPspWqUeFZI+/ui0XU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045002061;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---.XjzNVuG_1716358401;
Received: from localhost(mailfrom:libang.li@antgroup.com fp:SMTPD_---.XjzNVuG_1716358401)
          by smtp.aliyun-inc.com;
          Wed, 22 May 2024 14:13:22 +0800
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
Subject: [PATCH v4 1/3] mm: Add update_mmu_tlb_range()
Date: Wed, 22 May 2024 14:12:02 +0800
Message-Id: <20240522061204.117421-2-libang.li@antgroup.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20240522061204.117421-1-libang.li@antgroup.com>
References: <20240522061204.117421-1-libang.li@antgroup.com>
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
 include/linux/pgtable.h              | 7 +++++++
 6 files changed, 22 insertions(+)

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
index 55a7c3ec246b..4630815b0253 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -491,6 +491,8 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
 
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
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 18019f037bae..17d1caee39ab 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -729,6 +729,13 @@ static inline void clear_full_ptes(struct mm_struct *mm, unsigned long addr,
  * fault. This function updates TLB only, do nothing with cache or others.
  * It is the difference with function update_mmu_cache.
  */
+#ifndef update_mmu_tlb_range
+static inline void update_mmu_tlb_range(struct vm_area_struct *vma,
+				unsigned long address, pte_t *ptep, unsigned int nr)
+{
+}
+#endif
+
 #ifndef __HAVE_ARCH_UPDATE_MMU_TLB
 static inline void update_mmu_tlb(struct vm_area_struct *vma,
 				unsigned long address, pte_t *ptep)
-- 
2.19.1.6.gb485710b


