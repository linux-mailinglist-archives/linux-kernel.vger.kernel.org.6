Return-Path: <linux-kernel+bounces-238006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 357AF924210
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 17:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677DF1C24083
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4DA1BC07C;
	Tue,  2 Jul 2024 15:14:43 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407BC1BC073;
	Tue,  2 Jul 2024 15:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933283; cv=none; b=GRSVnr1gpaCrQU5Tmn+ZIfihScbf6Erq4PS5/XCfBfglPqeCatI60fz/wbP2a2zYXN9ThCpH7aW75mWv7kL7EWvOtA+T1pc1IhQ1u1WuKSeVnc755h/OI7WDTRDBcpzbbXkrKKXnFdPp0+U11hnl9Cy58qfPPIxiEetjpFpV36M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933283; c=relaxed/simple;
	bh=uTxkOB0T/LfbUvfT2XfWPcBUiayUthdfWv5PGeo39fM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YqhzjNsVfDtsKJPwOWR3ghnl0U8RmtMbox2DSJW62orwGRIIYBlszHZG7XsO4Q64P255zjCrRol5mGwayvIxPpvlbdRSHZY3c9CxgXxgla9k5XdgraG2MHUdZjlrsZ3sKjjG8+iCh0VF2ur1nEjQN1VheZN8NBcXVPR7SCN1lTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32307C4AF0D;
	Tue,  2 Jul 2024 15:14:39 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	loongson-kernel@lists.loongnix.cn,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Add ARCH_HAS_PTE_DEVMAP support
Date: Tue,  2 Jul 2024 23:14:31 +0800
Message-ID: <20240702151431.1160915-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order for things like get_user_pages() to work on ZONE_DEVICE memory,
we need a software PTE bit to identify device-backed PFNs.  Hook this up
along with the relevant helpers to join in with ARCH_HAS_PTE_DEVMAP.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig                    |  1 +
 arch/loongarch/include/asm/pgtable-bits.h |  6 ++++--
 arch/loongarch/include/asm/pgtable.h      | 19 +++++++++++++++++++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index ddc042895d01..d8ca8b1b01f3 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -22,6 +22,7 @@ config LOONGARCH
 	select ARCH_HAS_KERNEL_FPU_SUPPORT if CPU_HAS_FPU
 	select ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
+	select ARCH_HAS_PTE_DEVMAP
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_INLINE_READ_LOCK if !PREEMPTION
diff --git a/arch/loongarch/include/asm/pgtable-bits.h b/arch/loongarch/include/asm/pgtable-bits.h
index 21319c1e045c..82cd3a9f094b 100644
--- a/arch/loongarch/include/asm/pgtable-bits.h
+++ b/arch/loongarch/include/asm/pgtable-bits.h
@@ -22,6 +22,7 @@
 #define	_PAGE_PFN_SHIFT		12
 #define	_PAGE_SWP_EXCLUSIVE_SHIFT 23
 #define	_PAGE_PFN_END_SHIFT	48
+#define	_PAGE_DEVMAP_SHIFT	59
 #define	_PAGE_PRESENT_INVALID_SHIFT 60
 #define	_PAGE_NO_READ_SHIFT	61
 #define	_PAGE_NO_EXEC_SHIFT	62
@@ -35,6 +36,7 @@
 #define _PAGE_MODIFIED		(_ULCAST_(1) << _PAGE_MODIFIED_SHIFT)
 #define _PAGE_PROTNONE		(_ULCAST_(1) << _PAGE_PROTNONE_SHIFT)
 #define _PAGE_SPECIAL		(_ULCAST_(1) << _PAGE_SPECIAL_SHIFT)
+#define _PAGE_DEVMAP		(_ULCAST_(1) << _PAGE_DEVMAP_SHIFT)
 
 /* We borrow bit 23 to store the exclusive marker in swap PTEs. */
 #define _PAGE_SWP_EXCLUSIVE	(_ULCAST_(1) << _PAGE_SWP_EXCLUSIVE_SHIFT)
@@ -74,8 +76,8 @@
 #define __READABLE	(_PAGE_VALID)
 #define __WRITEABLE	(_PAGE_DIRTY | _PAGE_WRITE)
 
-#define _PAGE_CHG_MASK	(_PAGE_MODIFIED | _PAGE_SPECIAL | _PFN_MASK | _CACHE_MASK | _PAGE_PLV)
-#define _HPAGE_CHG_MASK	(_PAGE_MODIFIED | _PAGE_SPECIAL | _PFN_MASK | _CACHE_MASK | _PAGE_PLV | _PAGE_HUGE)
+#define _PAGE_CHG_MASK	(_PAGE_MODIFIED | _PAGE_SPECIAL | _PAGE_DEVMAP | _PFN_MASK | _CACHE_MASK | _PAGE_PLV)
+#define _HPAGE_CHG_MASK	(_PAGE_MODIFIED | _PAGE_SPECIAL | _PAGE_DEVMAP | _PFN_MASK | _CACHE_MASK | _PAGE_PLV | _PAGE_HUGE)
 
 #define PAGE_NONE	__pgprot(_PAGE_PROTNONE | _PAGE_NO_READ | \
 				 _PAGE_USER | _CACHE_CC)
diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index af3acdf3481a..0e821be63268 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -424,6 +424,9 @@ static inline int pte_special(pte_t pte)	{ return pte_val(pte) & _PAGE_SPECIAL;
 static inline pte_t pte_mkspecial(pte_t pte)	{ pte_val(pte) |= _PAGE_SPECIAL; return pte; }
 #endif /* CONFIG_ARCH_HAS_PTE_SPECIAL */
 
+static inline int pte_devmap(pte_t pte)		{ return !!(pte_val(pte) & _PAGE_DEVMAP); }
+static inline pte_t pte_mkdevmap(pte_t pte)	{ pte_val(pte) |= _PAGE_DEVMAP; return pte; }
+
 #define pte_accessible pte_accessible
 static inline unsigned long pte_accessible(struct mm_struct *mm, pte_t a)
 {
@@ -558,6 +561,17 @@ static inline pmd_t pmd_mkyoung(pmd_t pmd)
 	return pmd;
 }
 
+static inline int pmd_devmap(pmd_t pmd)
+{
+	return !!(pmd_val(pmd) & _PAGE_DEVMAP);
+}
+
+static inline pmd_t pmd_mkdevmap(pmd_t pmd)
+{
+	pmd_val(pmd) |= _PAGE_DEVMAP;
+	return pmd;
+}
+
 static inline struct page *pmd_page(pmd_t pmd)
 {
 	if (pmd_trans_huge(pmd))
@@ -613,6 +627,11 @@ static inline long pmd_protnone(pmd_t pmd)
 #define pmd_leaf(pmd)		((pmd_val(pmd) & _PAGE_HUGE) != 0)
 #define pud_leaf(pud)		((pud_val(pud) & _PAGE_HUGE) != 0)
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+#define pud_devmap(pud)		(0)
+#define pgd_devmap(pgd)		(0)
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
 /*
  * We provide our own get_unmapped area to cope with the virtual aliasing
  * constraints placed on us by the cache architecture.
-- 
2.43.0


