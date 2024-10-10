Return-Path: <linux-kernel+bounces-358214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09373997B82
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 05:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 005511C21B9A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8368C199FBA;
	Thu, 10 Oct 2024 03:50:57 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C3A19307D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 03:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728532257; cv=none; b=IyH39yM/M3d07fOFyMwhG12h2y68ux+JDdwbU71Bm6OixzA8WODgEAPolocaCgDkK28KydVUYFFXj3xln3jFFfSLp4djT1/4/0QiPjnQcSVhrganf4nfZ20TVVmq1rOgro6IXPZNksWXJ6zUMBiCR2kZXfEOndvaxkpOa9Uit8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728532257; c=relaxed/simple;
	bh=e7lRHDD94fN5J9hg3hc2VfgT+dYXDtNhlm6FH07EEhg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ju1Gz/ZWnLJDX9+8fdFFEIdM3IxhlvfhMM8+K8Bdu9Lx+U+zwTAnu7qaPHzi9LALlY77+hvLUU5M+B91AduuBbqNVM/Zg4N4XnCWe4WDazFRfS4IYHqha29q5MYTVYFXLkv2XG3WrKBjpMTO+RifYRtWNEr7KrQdoj4+8SWAfA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Dx+3IbTwdn5bsRAA--.25217S3;
	Thu, 10 Oct 2024 11:50:51 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMDx7tUZTwdnFP8hAA--.52915S6;
	Thu, 10 Oct 2024 11:50:51 +0800 (CST)
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
Subject: [PATCH 4/4] LoongArch: Use atomic operation with set_pte and pte_clear function
Date: Thu, 10 Oct 2024 11:50:48 +0800
Message-Id: <20241010035048.3422527-5-maobibo@loongson.cn>
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
X-CM-TRANSID:qMiowMDx7tUZTwdnFP8hAA--.52915S6
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

For kernel space area on LoongArch system, both two consecutive page
table entries should be enabled with PAGE_GLOBAL bit. So with function
set_pte() and pte_clear(), pte buddy entry is checked and set besides
its own pte entry. However it is not atomic operation to set both two
pte entries, there is problem with test_vmalloc test case.

With previous patch, all page table entries are set with PAGE_GLOBAL
bit at beginning. Only its own pte entry need update with function
set_pte() and pte_clear(), nothing to do with buddy pte entry.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/include/asm/pgtable.h | 44 ++++++++++------------------
 1 file changed, 15 insertions(+), 29 deletions(-)

diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index 22e3a8f96213..4be3f0dbecda 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -325,40 +325,26 @@ extern void paging_init(void);
 static inline void set_pte(pte_t *ptep, pte_t pteval)
 {
 	WRITE_ONCE(*ptep, pteval);
+}
 
-	if (pte_val(pteval) & _PAGE_GLOBAL) {
-		pte_t *buddy = ptep_buddy(ptep);
-		/*
-		 * Make sure the buddy is global too (if it's !none,
-		 * it better already be global)
-		 */
-		if (pte_none(ptep_get(buddy))) {
-#ifdef CONFIG_SMP
-			/*
-			 * For SMP, multiple CPUs can race, so we need
-			 * to do this atomically.
-			 */
-			__asm__ __volatile__(
-			__AMOR "$zero, %[global], %[buddy] \n"
-			: [buddy] "+ZB" (buddy->pte)
-			: [global] "r" (_PAGE_GLOBAL)
-			: "memory");
-
-			DBAR(0b11000); /* o_wrw = 0b11000 */
-#else /* !CONFIG_SMP */
-			WRITE_ONCE(*buddy, __pte(pte_val(ptep_get(buddy)) | _PAGE_GLOBAL));
-#endif /* CONFIG_SMP */
-		}
-	}
+static inline unsigned long __ptep_get_and_clear(pte_t *ptep)
+{
+	return atomic64_fetch_and(_PAGE_GLOBAL, (atomic64_t *)&pte_val(*ptep));
 }
 
 static inline void pte_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)
 {
-	/* Preserve global status for the pair */
-	if (pte_val(ptep_get(ptep_buddy(ptep))) & _PAGE_GLOBAL)
-		set_pte(ptep, __pte(_PAGE_GLOBAL));
-	else
-		set_pte(ptep, __pte(0));
+	__ptep_get_and_clear(ptep);
+}
+
+#define __HAVE_ARCH_PTEP_GET_AND_CLEAR
+static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
+					unsigned long addr, pte_t *ptep)
+{
+	unsigned long val;
+
+	val = __ptep_get_and_clear(ptep);
+	return __pte(val);
 }
 
 #define PGD_T_LOG2	(__builtin_ffs(sizeof(pgd_t)) - 1)
-- 
2.39.3


