Return-Path: <linux-kernel+bounces-185809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC43E8CBB4C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 08:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6754C282886
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 06:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678E278C9E;
	Wed, 22 May 2024 06:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="aPmlrugy"
Received: from out0-200.mail.aliyun.com (out0-200.mail.aliyun.com [140.205.0.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80B178C6E
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 06:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716359349; cv=none; b=CEp6EI+555YD0Q8+qWcdh7Hx1u2PUsVDvlEnH4kJMCNnMdIRLTCLAggYHOOJIIWltn+hQr0P6aGVEO3iyweMAGRd8kE45NY5OqTu/5UOdTaBgDWdPQLZ12H5GE2rYT28zmyLgHO7erkPHIxT50urqjMpRRLCaz8Q70dLlmuBG+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716359349; c=relaxed/simple;
	bh=XAZ1dhi8yd4t8p+lEu8vHI92ztkq6k1sOBmrDIIR6tM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=atmlY49VTvQMXmSMQqMEunEjM188TUSQE3PDxyC4mMjB/5c31SUrd61Hxo+GGGaqAMm4n5lYtq5Txs2ZyOGVwR6TX94m2sw8Q9/KV1UNQgRakw4T/VWd+cQAmGdeEdw2COce8sEdWmVoF+R3pv2vOpUQfHxPN3jmSK7FdZmKIAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=aPmlrugy; arc=none smtp.client-ip=140.205.0.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1716359338; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=TlFp/9e3+paphJkYj5hBfGpalgoFCMsN0GnLIT6/eZ4=;
	b=aPmlrugyX6ByEKQjaTagLMd103I3SgkF5f5gh1FpgN68RUFZO91f+n9/muKx03EYHhh+/FyOni9CcINz8YlhHRdH91pk4FHSWb04HlW/Q3sEfXg2VCj06srujHHg4H2AcIL4wjUaLBk2yHpWjznkeicswt3c1kdc6Pc028aeDkc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033070043001;MF=libang.li@antgroup.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---.XjzNVv6_1716358403;
Received: from localhost(mailfrom:libang.li@antgroup.com fp:SMTPD_---.XjzNVv6_1716358403)
          by smtp.aliyun-inc.com;
          Wed, 22 May 2024 14:13:24 +0800
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
Subject: [PATCH v4 2/3] mm: implement update_mmu_tlb() using update_mmu_tlb_range()
Date: Wed, 22 May 2024 14:12:03 +0800
Message-Id: <20240522061204.117421-3-libang.li@antgroup.com>
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

Let's make update_mmu_tlb() simply a generic wrapper around
update_mmu_tlb_range(). Only the latter can now be overridden by the
architecture. We can now remove __HAVE_ARCH_UPDATE_MMU_TLB as well.

Acked-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Bang Li <libang.li@antgroup.com>
---
 arch/loongarch/include/asm/pgtable.h | 2 --
 arch/mips/include/asm/pgtable.h      | 2 --
 arch/riscv/include/asm/pgtable.h     | 2 --
 arch/xtensa/include/asm/pgtable.h    | 3 ---
 arch/xtensa/mm/tlb.c                 | 6 ------
 include/linux/pgtable.h              | 4 +---
 6 files changed, 1 insertion(+), 18 deletions(-)

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
index 4630815b0253..ddfd6f8cdcb3 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -489,8 +489,6 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
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
index 17d1caee39ab..117b807e3f89 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -736,13 +736,11 @@ static inline void update_mmu_tlb_range(struct vm_area_struct *vma,
 }
 #endif
 
-#ifndef __HAVE_ARCH_UPDATE_MMU_TLB
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


