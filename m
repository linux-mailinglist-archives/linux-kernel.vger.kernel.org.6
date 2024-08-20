Return-Path: <linux-kernel+bounces-294400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FCC958D39
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2581C2260F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E6E1C2325;
	Tue, 20 Aug 2024 17:24:46 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC44B1C0DCE
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 17:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174686; cv=none; b=I4eb6t2/AE2FRbmluKO35+Q31nwHZWuB9aPWJKwYCaK1X24+qUXLN7ufen6iUYGOllyx3fwhrytE/y1X60Cnh4S4xjKcYBCaMi+Yl8CkurneBNskyjykm8P/LoUj63UCGywduytfaswxDVRHBpxb4yd7I6HhZ+vImpESLEDgNm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174686; c=relaxed/simple;
	bh=89l7e72r9luYR6lws+BwxH/ueiJ6/nSxxBE3Zkxuyh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u6Tt1g9Kb9IxA5BEPXIB8S37D2XJi4j7aYxpzy1mfymSAYuciHVopehaZ9GWeZalrU0t+24xgpQJx9d1ZN6Io5P6HIpU07IPDTPC298/7O34eciS8LFdeF76ejQIDal4Ji3yMmHQfiqiRf66ENdWepulpzuD2DnrKO5PBiky2Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WpGY91VYZz9sSY;
	Tue, 20 Aug 2024 19:24:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JmDvM8lCWGJn; Tue, 20 Aug 2024 19:24:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WpGY70TDHz9sSR;
	Tue, 20 Aug 2024 19:24:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id F04C58B778;
	Tue, 20 Aug 2024 19:24:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id WCmLBWefrDZx; Tue, 20 Aug 2024 19:24:26 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.72])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 86CB88B779;
	Tue, 20 Aug 2024 19:24:26 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: CASAUBON Jean Michel <jean-michel.casaubon@cs-soprasteria.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 04/14] Revert "powerpc/8xx: Always pin kernel text TLB"
Date: Tue, 20 Aug 2024 19:23:48 +0200
Message-ID: <01b6780b860c8043b51a1ba9d83acfc6f2dde910.1724173828.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1724173828.git.christophe.leroy@csgroup.eu>
References: <cover.1724173828.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724174648; l=3163; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=89l7e72r9luYR6lws+BwxH/ueiJ6/nSxxBE3Zkxuyh0=; b=BNQReqqPqedw4Pd3O7oDfjM6EUAgl0khRY5QflVXWvRe9l8vaL6VaFp0CUgwlIC11AjvRwY0t +RzPg8Jcg52BiNZp15GSIsDHdFlY9CozqTLWn5375ShcMZ6ztlZFFKu
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

This reverts commit bccc58986a2f98e3af349c85c5f49aac7fb19ef2.

When STRICT_KERNEL_RWX is selected, EXEC memory must stop where
RW memory start. When pinning iTLBs it means an 8M alignment for
RW data start. That may be acceptable on boards with a lot of
memory but one of my supported boards only has 32 Mbytes and this
forced alignment leads to a waste of almost 4 Mbytes with is more
than 10% of the total memory.

So revert commit bccc58986a2f ("powerpc/8xx: Always pin kernel text
TLB") but don't restore previous behaviour in ITLB miss handler
as now kernel PGD entries are copied into each process PGDIR.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_8xx.S     | 8 ++++++++
 arch/powerpc/mm/nohash/8xx.c       | 3 ++-
 arch/powerpc/platforms/8xx/Kconfig | 7 +++++++
 3 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index c955a8196d55..66ee0a31d99d 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -587,6 +587,10 @@ start_here:
 	lis	r0, (MD_TWAM | MD_RSV4I)@h
 	mtspr	SPRN_MD_CTR, r0
 #endif
+#ifndef CONFIG_PIN_TLB_TEXT
+	li	r0, 0
+	mtspr	SPRN_MI_CTR, r0
+#endif
 #if !defined(CONFIG_PIN_TLB_DATA) && !defined(CONFIG_PIN_TLB_IMMR)
 	lis	r0, MD_TWAM@h
 	mtspr	SPRN_MD_CTR, r0
@@ -683,6 +687,7 @@ SYM_FUNC_START_LOCAL(initial_mmu)
 	blr
 SYM_FUNC_END(initial_mmu)
 
+#ifdef CONFIG_PIN_TLB
 _GLOBAL(mmu_pin_tlb)
 	lis	r9, (1f - PAGE_OFFSET)@h
 	ori	r9, r9, (1f - PAGE_OFFSET)@l
@@ -704,6 +709,7 @@ _GLOBAL(mmu_pin_tlb)
 	mtspr	SPRN_MD_CTR, r6
 	tlbia
 
+#ifdef CONFIG_PIN_TLB_TEXT
 	LOAD_REG_IMMEDIATE(r5, 28 << 8)
 	LOAD_REG_IMMEDIATE(r6, PAGE_OFFSET)
 	LOAD_REG_IMMEDIATE(r7, MI_SVALID | MI_PS8MEG | _PMD_ACCESSED)
@@ -724,6 +730,7 @@ _GLOBAL(mmu_pin_tlb)
 	bdnzt	lt, 2b
 	lis	r0, MI_RSV4I@h
 	mtspr	SPRN_MI_CTR, r0
+#endif
 
 	LOAD_REG_IMMEDIATE(r5, 28 << 8 | MD_TWAM)
 #ifdef CONFIG_PIN_TLB_DATA
@@ -783,3 +790,4 @@ _GLOBAL(mmu_pin_tlb)
 	mtspr	SPRN_SRR1, r10
 	mtspr	SPRN_SRR0, r11
 	rfi
+#endif
diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
index 15d918dce27d..4c2f9d716993 100644
--- a/arch/powerpc/mm/nohash/8xx.c
+++ b/arch/powerpc/mm/nohash/8xx.c
@@ -177,7 +177,8 @@ int mmu_mark_initmem_nx(void)
 	if (!debug_pagealloc_enabled_or_kfence())
 		err = mmu_mapin_ram_chunk(boundary, einittext8, PAGE_KERNEL, false);
 
-	mmu_pin_tlb(block_mapped_ram, false);
+	if (IS_ENABLED(CONFIG_PIN_TLB_TEXT))
+		mmu_pin_tlb(block_mapped_ram, false);
 
 	return err;
 }
diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
index c6cb0f3682ce..3e04329361fa 100644
--- a/arch/powerpc/platforms/8xx/Kconfig
+++ b/arch/powerpc/platforms/8xx/Kconfig
@@ -203,6 +203,13 @@ config PIN_TLB_IMMR
 	  CONFIG_PIN_TLB_DATA is also selected, it will reduce
 	  CONFIG_PIN_TLB_DATA to 24 Mbytes.
 
+config PIN_TLB_TEXT
+	bool "Pinned TLB for TEXT"
+	depends on PIN_TLB
+	default y
+	help
+	  This pins kernel text with 8M pages.
+
 endmenu
 
 endmenu
-- 
2.44.0


