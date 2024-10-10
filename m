Return-Path: <linux-kernel+bounces-358213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB842997B81
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827541F23CCA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A33199FA2;
	Thu, 10 Oct 2024 03:50:57 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9072E18F2FF
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 03:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728532257; cv=none; b=nCbLgTPjPhYkkXbA9GYnZTIQTVNkvFHC7xCB8+Pg6zmT2lLvvqmf/v1T3EUYqD+p8dsKD8d/uIpqznXZg1XBtHkTWC74j9/2CgM/nvwquWecYVbZCMqNZo2ftHJI58S3wtCDltMjfA2D/q59QTZI+BZy4/R3SMP7waaottamqLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728532257; c=relaxed/simple;
	bh=cmwqGpfWQFkdzlK0RLiSRImOA16DQPPls1SXPMINYLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SW4ikMk90Gkyq6UrBPEEw6QxzuFwMzVTIdQco6ugYTYKgox+47I4t71rw0kfC7g5eba6cGgNNq0lef/9EPxutbwmPFvKacak6ELcBNMQkcz0cW4hJrUUbHUZbNkSLOswiyd2m5m9tjw0IZHC7UUnfB3v8+nvtmREDAmJ23XNEcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxjnMbTwdn1bsRAA--.25500S3;
	Thu, 10 Oct 2024 11:50:51 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMDx7tUZTwdnFP8hAA--.52915S3;
	Thu, 10 Oct 2024 11:50:49 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	Barry Song <baohua@kernel.org>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org
Subject: [PATCH 1/4] LoongArch: Set pte entry with PAGE_GLOBAL for kernel space
Date: Thu, 10 Oct 2024 11:50:45 +0800
Message-Id: <20241010035048.3422527-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20241010035048.3422527-1-maobibo@loongson.cn>
References: <20241010035048.3422527-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDx7tUZTwdnFP8hAA--.52915S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Unlike general architectures, there are two pages for one TLB entry
on LoongArch system. For kernel space, it requires both two pte
entries with PAGE_GLOBAL set, else HW treats it as non-global tlb,
there will be potential problems if tlb entry for kernel space is
not global. Such as fail to flush kernel tlb with function
local_flush_tlb_kernel_range() which only flush tlb with global bit.

Here function kernel_pte_init() is added, it can be used to init
pte table when it is created, so the default inital pte is
PAGE_GLOBAL rather than zero at beginning.

Kernel space areas includes fixmap, percpu, vmalloc and kasan areas
set default pte entry with PAGE_GLOBAL set.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/pgalloc.h | 13 +++++++++++++
 arch/loongarch/include/asm/pgtable.h |  1 +
 arch/loongarch/mm/init.c             |  4 +++-
 arch/loongarch/mm/kasan_init.c       |  4 +++-
 arch/loongarch/mm/pgtable.c          | 22 ++++++++++++++++++++++
 5 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
index 4e2d6b7ca2ee..b2698c03dc2c 100644
--- a/arch/loongarch/include/asm/pgalloc.h
+++ b/arch/loongarch/include/asm/pgalloc.h
@@ -10,8 +10,21 @@
 
 #define __HAVE_ARCH_PMD_ALLOC_ONE
 #define __HAVE_ARCH_PUD_ALLOC_ONE
+#define __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL
 #include <asm-generic/pgalloc.h>
 
+static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
+{
+	pte_t *pte;
+
+	pte = (pte_t *) __get_free_page(GFP_KERNEL);
+	if (!pte)
+		return NULL;
+
+	kernel_pte_init(pte);
+	return pte;
+}
+
 static inline void pmd_populate_kernel(struct mm_struct *mm,
 				       pmd_t *pmd, pte_t *pte)
 {
diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index 9965f52ef65b..22e3a8f96213 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -269,6 +269,7 @@ extern void set_pmd_at(struct mm_struct *mm, unsigned long addr, pmd_t *pmdp, pm
 extern void pgd_init(void *addr);
 extern void pud_init(void *addr);
 extern void pmd_init(void *addr);
+extern void kernel_pte_init(void *addr);
 
 /*
  * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
diff --git a/arch/loongarch/mm/init.c b/arch/loongarch/mm/init.c
index 8a87a482c8f4..9f26e933a8a3 100644
--- a/arch/loongarch/mm/init.c
+++ b/arch/loongarch/mm/init.c
@@ -198,9 +198,11 @@ pte_t * __init populate_kernel_pte(unsigned long addr)
 	if (!pmd_present(pmdp_get(pmd))) {
 		pte_t *pte;
 
-		pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
+		pte = memblock_alloc_raw(PAGE_SIZE, PAGE_SIZE);
 		if (!pte)
 			panic("%s: Failed to allocate memory\n", __func__);
+
+		kernel_pte_init(pte);
 		pmd_populate_kernel(&init_mm, pmd, pte);
 	}
 
diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/mm/kasan_init.c
index 427d6b1aec09..34988573b0d5 100644
--- a/arch/loongarch/mm/kasan_init.c
+++ b/arch/loongarch/mm/kasan_init.c
@@ -152,6 +152,8 @@ static void __init kasan_pte_populate(pmd_t *pmdp, unsigned long addr,
 		phys_addr_t page_phys = early ?
 					__pa_symbol(kasan_early_shadow_page)
 					      : kasan_alloc_zeroed_page(node);
+		if (!early)
+			kernel_pte_init(__va(page_phys));
 		next = addr + PAGE_SIZE;
 		set_pte(ptep, pfn_pte(__phys_to_pfn(page_phys), PAGE_KERNEL));
 	} while (ptep++, addr = next, addr != end && __pte_none(early, ptep_get(ptep)));
@@ -287,7 +289,7 @@ void __init kasan_init(void)
 		set_pte(&kasan_early_shadow_pte[i],
 			pfn_pte(__phys_to_pfn(__pa_symbol(kasan_early_shadow_page)), PAGE_KERNEL_RO));
 
-	memset(kasan_early_shadow_page, 0, PAGE_SIZE);
+	kernel_pte_init(kasan_early_shadow_page);
 	csr_write64(__pa_symbol(swapper_pg_dir), LOONGARCH_CSR_PGDH);
 	local_flush_tlb_all();
 
diff --git a/arch/loongarch/mm/pgtable.c b/arch/loongarch/mm/pgtable.c
index eb6a29b491a7..228ffc1db0a3 100644
--- a/arch/loongarch/mm/pgtable.c
+++ b/arch/loongarch/mm/pgtable.c
@@ -38,6 +38,28 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 }
 EXPORT_SYMBOL_GPL(pgd_alloc);
 
+void kernel_pte_init(void *addr)
+{
+	unsigned long *p, *end;
+	unsigned long entry;
+
+	entry = (unsigned long)_PAGE_GLOBAL;
+	p = (unsigned long *)addr;
+	end = p + PTRS_PER_PTE;
+
+	do {
+		p[0] = entry;
+		p[1] = entry;
+		p[2] = entry;
+		p[3] = entry;
+		p[4] = entry;
+		p += 8;
+		p[-3] = entry;
+		p[-2] = entry;
+		p[-1] = entry;
+	} while (p != end);
+}
+
 void pgd_init(void *addr)
 {
 	unsigned long *p, *end;
-- 
2.39.3


