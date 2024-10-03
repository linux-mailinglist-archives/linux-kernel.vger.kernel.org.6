Return-Path: <linux-kernel+bounces-348572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4309E98E935
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 06:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B98CD281D92
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 04:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C77C3FB31;
	Thu,  3 Oct 2024 04:48:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C4FBA49
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 04:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727930933; cv=none; b=QDJdkzJXWsr7lk93iHoB0Jdm5FouvCjxzjl8/vKKYA4AO9HfjU6Pgf9Pp8A9RgTahZROh63byRVE/cxYk3/K45CfIHoK2VH8L5Ds0wWF/j5jSkEzGYn1ybKzIczGlWY/wbf4rmFdsD86D+2MFZAIWI2crZOo9wmeHM4D0n0co+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727930933; c=relaxed/simple;
	bh=leBC1dkfOlpVaF7fGaafiJOWeDEUDFkrCv7Zn4i+9H8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GrKkFVvdeOc6ZhCiJQA3A3UuPCSoczl2TBR1u13tw0hcFfjyUghZjGDqGUMmqrBKSX8CAeNIlwsc6WkzXsN1D4ya6TCkVPltDxRFg7/r60WKhsIOIUcPYXyZQR5/Z1Rk+WClSfM+ehmgI5iaHuTB98/pwcHorgpWhwbJSqMDAh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8AC4339;
	Wed,  2 Oct 2024 21:49:19 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.37.202])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 90A133F64C;
	Wed,  2 Oct 2024 21:48:45 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org,
	akpm@linux-foundation.org,
	paul.walmsley@sifive.com,
	dave.hansen@linux.intel.com
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	x86@kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] mm: Move set_pxd_safe() helpers from generic to platform
Date: Thu,  3 Oct 2024 10:18:42 +0530
Message-Id: <20241003044842.246016-1-anshuman.khandual@arm.com>
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
This patch applies on v6.12-rc1

This patch is just a resend for an earlier patch

https://lore.kernel.org/all/20240920053017.2514920-1-anshuman.khandual@arm.com/

 arch/riscv/include/asm/pgtable.h | 19 ++++++++++++++++
 arch/x86/include/asm/pgtable.h   | 37 +++++++++++++++++++++++++++++++
 include/linux/pgtable.h          | 38 --------------------------------
 3 files changed, 56 insertions(+), 38 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index e79f15293492..5d7f3e8c2e50 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -963,6 +963,25 @@ void misc_mem_init(void);
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
index 4c2d080d26b4..593f10aabd45 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1775,6 +1775,43 @@ bool arch_is_platform_page(u64 paddr);
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
index e8b2ac6bd2ae..23aeffd89a4e 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1056,44 +1056,6 @@ static inline int pgd_same(pgd_t pgd_a, pgd_t pgd_b)
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


