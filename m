Return-Path: <linux-kernel+bounces-407350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4CB9C6C3A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 11:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02E191F21BFC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 10:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02F21F943D;
	Wed, 13 Nov 2024 09:59:42 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E082B189BBD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 09:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731491982; cv=none; b=R2o7QJtWKFrFNV8HaGT9K2nQ8an0Y1QdEfiQZ5wtPeqbVNy0xaiCF4/8ls55cQaoNZm8SPVMOt6Zeaehnd5Q8e4GEmXsUz1GuMrM/5fcx6CEC4VKKf1TzV8T+rZI0FyHXS+HbAk4a6qTnditwaLLjhTRoQXVu3j00Z0T9MQsmjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731491982; c=relaxed/simple;
	bh=EGUmauyGC1XlLu+n48t6Xj6d7eQWa61VksgIlpJ/cXk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fIA6HOMofkmtVYqJc5awlIJ+SU0gQQynaj3EUJTIwD9x+oDatRbq3JvHDnVDDo5tHAgYLe6HkNTMmpK6g28KwOStwc4RaQgYXcm4QKJUuzZkKsvLwQDQty9dFs+t+ou0fm91w3wUP9xGrTguRfCtI8m2EjL8Ze06wSBwXtF1yB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ubt.. (unknown [210.73.53.31])
	by APP-05 (Coremail) with SMTP id zQCowADHr7p4eDRnlmI4Ag--.57753S5;
	Wed, 13 Nov 2024 17:59:22 +0800 (CST)
From: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V5 3/3] riscv: mm: Add uffd write-protect support
Date: Wed, 13 Nov 2024 17:58:33 +0800
Message-Id: <20241113095833.1805746-4-zhangchunyan@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113095833.1805746-1-zhangchunyan@iscas.ac.cn>
References: <20241113095833.1805746-1-zhangchunyan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADHr7p4eDRnlmI4Ag--.57753S5
X-Coremail-Antispam: 1UD129KBjvJXoWxGw1UAFW7AF1kZF13WryDWrg_yoWrZr43pr
	s5Ga1ru3yDJFn7KayftrWxKrWrZw43Wa4DXr9xua1kJFyUKrWDXFyrK34aqryrXFWvv34x
	JrWrKryrCw47JF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
	8067AKxVWUWwA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF
	64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4x0Y4vE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIE
	c7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I
	8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCF
	s4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4
	vE14v_GFWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUI8nY
	UUUUU
X-CM-SenderInfo: x2kd0wxfkx051dq6x2xfdvhtffof0/1tbiBwkAB2c0ciEVcgABsv

Reuse PTE bit(9) to do uffd-wp tracking and make it mutually exclusive
with soft-dirty and devmap which all use this PTE bit.

Additionally for tracking the uffd-wp state as a PTE swap bit,
we use swap entry pte bit(4) which is also used by swap
soft-dirty tracking.

Signed-off-by: Chunyan Zhang <zhangchunyan@iscas.ac.cn>
---
 arch/riscv/Kconfig                    |  7 +++
 arch/riscv/include/asm/pgtable-bits.h | 13 ++++++
 arch/riscv/include/asm/pgtable.h      | 66 ++++++++++++++++++++++++++-
 3 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 3bccdcae9445..920071a05512 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -989,6 +989,13 @@ config RISCV_HAS_SOFT_DIRTY
 	help
 	  The PTE bit(9) is used for soft-dirty tracking.
 
+config RISCV_HAS_USERFAULTFD_WP
+	bool "userfaultfd write protection"
+	select HAVE_ARCH_USERFAULTFD_WP
+	depends on USERFAULTFD
+	help
+	  The PTE bit(9) is used for userfaultfd write-protected
+	  tracking.
 endchoice
 
 endmenu # "Kernel features"
diff --git a/arch/riscv/include/asm/pgtable-bits.h b/arch/riscv/include/asm/pgtable-bits.h
index c6d51fe9fc6f..7de16141c049 100644
--- a/arch/riscv/include/asm/pgtable-bits.h
+++ b/arch/riscv/include/asm/pgtable-bits.h
@@ -38,6 +38,19 @@
 #define _PAGE_SWP_SOFT_DIRTY	0
 #endif /* CONFIG_MEM_SOFT_DIRTY */
 
+#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
+/*
+ * CONFIG_HAVE_ARCH_USERFAULTFD_WP is mutually exclusive with
+ * HAVE_ARCH_SOFT_DIRTY so we can use the same bit for uffd-wp
+ * and soft-dirty tracking.
+ */
+#define _PAGE_UFFD_WP		(1 << 9) /* RSW: 0x2 for uffd-wp tracking */
+#define _PAGE_SWP_UFFD_WP	_PAGE_USER
+#else
+#define _PAGE_UFFD_WP		0
+#define _PAGE_SWP_UFFD_WP	0
+#endif
+
 #define _PAGE_TABLE     _PAGE_PRESENT
 
 /*
diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 1779eae5cb49..f241c444cebd 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -413,6 +413,38 @@ static inline pte_t pte_wrprotect(pte_t pte)
 	return __pte(pte_val(pte) & ~(_PAGE_WRITE));
 }
 
+#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
+static inline int pte_uffd_wp(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_UFFD_WP;
+}
+
+static inline pte_t pte_mkuffd_wp(pte_t pte)
+{
+	return pte_wrprotect(__pte(pte_val(pte) | _PAGE_UFFD_WP));
+}
+
+static inline pte_t pte_clear_uffd_wp(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~(_PAGE_UFFD_WP));
+}
+
+static inline int pte_swp_uffd_wp(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_SWP_UFFD_WP;
+}
+
+static inline pte_t pte_swp_mkuffd_wp(pte_t pte)
+{
+	return __pte(pte_val(pte) | _PAGE_SWP_UFFD_WP);
+}
+
+static inline pte_t pte_swp_clear_uffd_wp(pte_t pte)
+{
+	return __pte(pte_val(pte) & ~(_PAGE_SWP_UFFD_WP));
+}
+#endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
+
 /* static inline pte_t pte_mkread(pte_t pte) */
 
 static inline pte_t pte_mkwrite_novma(pte_t pte)
@@ -789,6 +821,38 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
 	return pte_pmd(pte_mkdevmap(pmd_pte(pmd)));
 }
 
+#ifdef CONFIG_HAVE_ARCH_USERFAULTFD_WP
+static inline int pmd_uffd_wp(pmd_t pmd)
+{
+	return pte_uffd_wp(pmd_pte(pmd));
+}
+
+static inline pmd_t pmd_mkuffd_wp(pmd_t pmd)
+{
+	return pte_pmd(pte_mkuffd_wp(pmd_pte(pmd)));
+}
+
+static inline pmd_t pmd_clear_uffd_wp(pmd_t pmd)
+{
+	return pte_pmd(pte_clear_uffd_wp(pmd_pte(pmd)));
+}
+
+static inline int pmd_swp_uffd_wp(pmd_t pmd)
+{
+	return pte_swp_uffd_wp(pmd_pte(pmd));
+}
+
+static inline pmd_t pmd_swp_mkuffd_wp(pmd_t pmd)
+{
+	return pte_pmd(pte_swp_mkuffd_wp(pmd_pte(pmd)));
+}
+
+static inline pmd_t pmd_swp_clear_uffd_wp(pmd_t pmd)
+{
+	return pte_pmd(pte_swp_clear_uffd_wp(pmd_pte(pmd)));
+}
+#endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
+
 #ifdef CONFIG_HAVE_ARCH_SOFT_DIRTY
 static inline int pmd_soft_dirty(pmd_t pmd)
 {
@@ -913,7 +977,7 @@ extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
  * Format of swap PTE:
  *	bit            0:	_PAGE_PRESENT (zero)
  *	bit       1 to 3:       _PAGE_LEAF (zero)
- *	bit	       4:	_PAGE_SWP_SOFT_DIRTY
+ *	bit	       4:	_PAGE_SWP_SOFT_DIRTY or _PAGE_SWP_UFFD_WP
  *	bit            5:	_PAGE_PROT_NONE (zero)
  *	bit            6:	exclusive marker
  *	bits      7 to 11:	swap type
-- 
2.34.1


