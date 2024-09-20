Return-Path: <linux-kernel+bounces-333978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF4197D0F3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 07:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AADF31F247E2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 05:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821A22D613;
	Fri, 20 Sep 2024 05:30:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6C52231C
	for <linux-kernel@vger.kernel.org>; Fri, 20 Sep 2024 05:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726810230; cv=none; b=WueX8fOD5Oyc8WjtH9ZM9DnDDglRaXOkFBdzldidCGP40/NZCeLTtw0KsEbTIxjCzS/oFXF6/kNdJa1A0JM3i9AEKqD/NnQ1aFR0cvWrdZNQEEqJC4R5TuG3tETl6qPA6oTwn6bC+vuL1tPelfUE08tovAGeAhKbc1El8NC7zWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726810230; c=relaxed/simple;
	bh=ifOfwELds3PlvLLtVAjkJYbWMqw9qCexnBRbpO8LOJY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UwaD+fBDGyO1nmZQH2soAtbKVjdb6OllLJta7Xtv3WoExMTqqPM231nm/MJRAYgdr4s9YqOALMQPhOnDkKj3GAufdzsF62RuqrSi2kzZSZW2G3tkHv4+uq9CRqdPs6b0+hRxC8jJgXx3eUtdhpWw/jx+W/az390KFgUyRbJIzIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A223AFEC;
	Thu, 19 Sep 2024 22:30:55 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.35.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EFA933F66E;
	Thu, 19 Sep 2024 22:30:21 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	x86@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Move set_pxd_safe() helpers from generic to platform
Date: Fri, 20 Sep 2024 11:00:17 +0530
Message-Id: <20240920053017.2514920-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

set_pxd_safe() helpers that serve a specific purpose for both x86 and riscv
platforms, do not need to be in the common memory code. Otherwise they just
unnecessarily make the common API more complicated. This moves the helpers
from common code to platform instead.

Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: x86@kernel.org
Cc: linux-mm@kvack.org
Cc: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/riscv/include/asm/pgtable.h | 19 ++++++++++++++++
 arch/x86/include/asm/pgtable.h   | 37 +++++++++++++++++++++++++++++++
 include/linux/pgtable.h          | 38 --------------------------------
 3 files changed, 56 insertions(+), 38 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 089f3c9f56a3..39ca652c5ebe 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -957,6 +957,25 @@ void misc_mem_init(void);
 extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
 #define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
 
+/*
+ * Use set_p*_safe(), and elide TLB flushing, when confident that *no*
+ * TLB flush will be required as a result of the "set". For example, use
+ * in scenarios where it is known ahead of time that the routine is
+ * setting non-present entries, or re-setting an existing entry to the
+ * same value. Otherwise, use the typical "set" helpers and flush the
+ * TLB.
+ */
+#define set_p4d_safe(p4dp, p4d) \
+({ \
+	WARN_ON_ONCE(p4d_present(*p4dp) && !p4d_same(*p4dp, p4d)); \
+	set_p4d(p4dp, p4d); \
+})
+
+#define set_pgd_safe(pgdp, pgd) \
+({ \
+	WARN_ON_ONCE(pgd_present(*pgdp) && !pgd_same(*pgdp, pgd)); \
+	set_pgd(pgdp, pgd); \
+})
 #endif /* !__ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_PGTABLE_H */
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index e39311a89bf4..fefb52bb6b4d 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1701,6 +1701,43 @@ bool arch_is_platform_page(u64 paddr);
 #define arch_is_platform_page arch_is_platform_page
 #endif
 
+/*
+ * Use set_p*_safe(), and elide TLB flushing, when confident that *no*
+ * TLB flush will be required as a result of the "set". For example, use
+ * in scenarios where it is known ahead of time that the routine is
+ * setting non-present entries, or re-setting an existing entry to the
+ * same value. Otherwise, use the typical "set" helpers and flush the
+ * TLB.
+ */
+#define set_pte_safe(ptep, pte) \
+({ \
+	WARN_ON_ONCE(pte_present(*ptep) && !pte_same(*ptep, pte)); \
+	set_pte(ptep, pte); \
+})
+
+#define set_pmd_safe(pmdp, pmd) \
+({ \
+	WARN_ON_ONCE(pmd_present(*pmdp) && !pmd_same(*pmdp, pmd)); \
+	set_pmd(pmdp, pmd); \
+})
+
+#define set_pud_safe(pudp, pud) \
+({ \
+	WARN_ON_ONCE(pud_present(*pudp) && !pud_same(*pudp, pud)); \
+	set_pud(pudp, pud); \
+})
+
+#define set_p4d_safe(p4dp, p4d) \
+({ \
+	WARN_ON_ONCE(p4d_present(*p4dp) && !p4d_same(*p4dp, p4d)); \
+	set_p4d(p4dp, p4d); \
+})
+
+#define set_pgd_safe(pgdp, pgd) \
+({ \
+	WARN_ON_ONCE(pgd_present(*pgdp) && !pgd_same(*pgdp, pgd)); \
+	set_pgd(pgdp, pgd); \
+})
 #endif	/* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_PGTABLE_H */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 2a6a3cccfc36..0bf88e505aad 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1050,44 +1050,6 @@ static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
 }
 #endif
 
-/*
- * Use set_p*_safe(), and elide TLB flushing, when confident that *no*
- * TLB flush will be required as a result of the "set". For example, use
- * in scenarios where it is known ahead of time that the routine is
- * setting non-present entries, or re-setting an existing entry to the
- * same value. Otherwise, use the typical "set" helpers and flush the
- * TLB.
- */
-#define set_pte_safe(ptep, pte) \
-({ \
-	WARN_ON_ONCE(pte_present(*ptep) && !pte_same(*ptep, pte)); \
-	set_pte(ptep, pte); \
-})
-
-#define set_pmd_safe(pmdp, pmd) \
-({ \
-	WARN_ON_ONCE(pmd_present(*pmdp) && !pmd_same(*pmdp, pmd)); \
-	set_pmd(pmdp, pmd); \
-})
-
-#define set_pud_safe(pudp, pud) \
-({ \
-	WARN_ON_ONCE(pud_present(*pudp) && !pud_same(*pudp, pud)); \
-	set_pud(pudp, pud); \
-})
-
-#define set_p4d_safe(p4dp, p4d) \
-({ \
-	WARN_ON_ONCE(p4d_present(*p4dp) && !p4d_same(*p4dp, p4d)); \
-	set_p4d(p4dp, p4d); \
-})
-
-#define set_pgd_safe(pgdp, pgd) \
-({ \
-	WARN_ON_ONCE(pgd_present(*pgdp) && !pgd_same(*pgdp, pgd)); \
-	set_pgd(pgdp, pgd); \
-})
-
 #ifndef __HAVE_ARCH_DO_SWAP_PAGE
 static inline void arch_do_swap_page_nr(struct mm_struct *mm,
 				     struct vm_area_struct *vma,
-- 
2.25.1


