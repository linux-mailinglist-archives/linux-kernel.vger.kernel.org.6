Return-Path: <linux-kernel+bounces-237903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26B9F923FA0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D862428A9C9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFB41BD006;
	Tue,  2 Jul 2024 13:52:59 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EDC1BA869
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719928378; cv=none; b=AMbHmwG4xatY18OlHAcL+dLQSo7mP5EbzIHXiAJYRlMRs6u9/9OLmT4nlwfprnoSeamEQLL3FAC9NlG3FFuQZtFDnfLpNkwKBNGXxfNa/WpE45SGj3DvfY8HDC9pyNyLOXIR4OaJsQmG2JL/eEZrGfCDen+VEPOPArP3G3fdAi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719928378; c=relaxed/simple;
	bh=CGeNYqnnvnjPnGCbM1yMAoxPPNyoWmWcvtJY5TjAVy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKwWFeFF4QeJF7Gs3ZJmctQ5Dlq1mp1pPx1hb8aiBFrvDiYwJpBbAPwpYkH0X/WhPuS0l5vzhKHyouflgijpl0E7jZzazSoR1v59i6wOOQZwo7aaPPC2wncX87CcbgVzAKyGL/jGFuP1e6I84MRKDPsL8rU0ek8AhoVbrNzm5Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4WD48M2G8bz9v6q;
	Tue,  2 Jul 2024 15:51:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F1PYD05orrHY; Tue,  2 Jul 2024 15:51:47 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4WD4872gVjz9v5M;
	Tue,  2 Jul 2024 15:51:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5733E8B774;
	Tue,  2 Jul 2024 15:51:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id LSTeqtZMNkMb; Tue,  2 Jul 2024 15:51:35 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.12])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C12BE8B775;
	Tue,  2 Jul 2024 15:51:34 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Peter Xu <peterx@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v7 19/23] powerpc/e500: Free r10 for FIND_PTE
Date: Tue,  2 Jul 2024 15:51:31 +0200
Message-ID: <a3ee563ad5b13c891a15d3aae6c136c44ce8aa63.1719928057.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1719928057.git.christophe.leroy@csgroup.eu>
References: <cover.1719928057.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719928275; l=4544; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=CGeNYqnnvnjPnGCbM1yMAoxPPNyoWmWcvtJY5TjAVy0=; b=M1QWIpnPCtnELqMpfZZElEuTb8maaGQCCyTc3Ar8cokovO/DoM4+jhTmObMqHUeG6WC1Y96nA N3ZYvNGaCG7BCNl4TfIiCDNRKy//BQir7dqlmDq1vhcHqqDVpGjudhr
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Move r13 load after the call to FIND_PTE, and use r13 instead of
r10 for storing fault address. This will allow using r10 freely
in FIND_PTE in following patch to handle hugepage size.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v5: New
---
 arch/powerpc/kernel/head_85xx.S | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/head_85xx.S b/arch/powerpc/kernel/head_85xx.S
index 282e49c51deb..226f88e77d6d 100644
--- a/arch/powerpc/kernel/head_85xx.S
+++ b/arch/powerpc/kernel/head_85xx.S
@@ -294,9 +294,10 @@ set_ivor:
 /* Macros to hide the PTE size differences
  *
  * FIND_PTE -- walks the page tables given EA & pgdir pointer
- *   r10 -- EA of fault
+ *   r10 -- free
  *   r11 -- PGDIR pointer
  *   r12 -- free
+ *   r13 -- EA of fault
  *   label 2: is the bailout case
  *
  * if we find the pte (fall through):
@@ -307,7 +308,7 @@ set_ivor:
 #ifdef CONFIG_PTE_64BIT
 #ifdef CONFIG_HUGETLB_PAGE
 #define FIND_PTE	\
-	rlwinm	r12, r10, 14, 18, 28;	/* Compute pgdir/pmd offset */	\
+	rlwinm	r12, r13, 14, 18, 28;	/* Compute pgdir/pmd offset */	\
 	add	r12, r11, r12;						\
 	lwz	r11, 4(r12);		/* Get pgd/pmd entry */		\
 	rlwinm.	r12, r11, 0, 0, 20;	/* Extract pt base address */	\
@@ -317,26 +318,26 @@ set_ivor:
 	andi.	r10, r11, HUGEPD_SHIFT_MASK@l; /* extract size field */	\
 	xor	r12, r10, r11;		/* drop size bits from pointer */ \
 	b	1001f;							\
-1000:	rlwimi	r12, r10, 23, 20, 28;	/* Compute pte address */	\
+1000:	rlwimi	r12, r13, 23, 20, 28;	/* Compute pte address */	\
 	li	r10, 0;			/* clear r10 */			\
 1001:	lwz	r11, 4(r12);		/* Get pte entry */
 #else
 #define FIND_PTE	\
-	rlwinm	r12, r10, 14, 18, 28;	/* Compute pgdir/pmd offset */	\
+	rlwinm	r12, r13, 14, 18, 28;	/* Compute pgdir/pmd offset */	\
 	add	r12, r11, r12;						\
 	lwz	r11, 4(r12);		/* Get pgd/pmd entry */		\
 	rlwinm.	r12, r11, 0, 0, 20;	/* Extract pt base address */	\
 	beq	2f;			/* Bail if no table */		\
-	rlwimi	r12, r10, 23, 20, 28;	/* Compute pte address */	\
+	rlwimi	r12, r13, 23, 20, 28;	/* Compute pte address */	\
 	lwz	r11, 4(r12);		/* Get pte entry */
 #endif /* HUGEPAGE */
 #else /* !PTE_64BIT */
 #define FIND_PTE	\
-	rlwimi	r11, r10, 12, 20, 29;	/* Create L1 (pgdir/pmd) address */	\
+	rlwimi	r11, r13, 12, 20, 29;	/* Create L1 (pgdir/pmd) address */	\
 	lwz	r11, 0(r11);		/* Get L1 entry */			\
 	rlwinm.	r12, r11, 0, 0, 19;	/* Extract L2 (pte) base address */	\
 	beq	2f;			/* Bail if no table */			\
-	rlwimi	r12, r10, 22, 20, 29;	/* Compute PTE address */		\
+	rlwimi	r12, r13, 22, 20, 29;	/* Compute PTE address */		\
 	lwz	r11, 0(r12);		/* Get Linux PTE */
 #endif
 
@@ -443,13 +444,13 @@ START_BTB_FLUSH_SECTION
 	BTB_FLUSH(r10)
 1:
 END_BTB_FLUSH_SECTION
-	mfspr	r10, SPRN_DEAR		/* Get faulting address */
+	mfspr	r13, SPRN_DEAR		/* Get faulting address */
 
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
 	lis	r11, PAGE_OFFSET@h
-	cmplw	5, r10, r11
+	cmplw	5, r13, r11
 	blt	5, 3f
 	lis	r11, swapper_pg_dir@h
 	ori	r11, r11, swapper_pg_dir@l
@@ -472,14 +473,14 @@ END_BTB_FLUSH_SECTION
 #endif
 
 4:
+	FIND_PTE
+
 #ifdef CONFIG_PTE_64BIT
 	li	r13,_PAGE_PRESENT|_PAGE_BAP_SR
 	oris	r13,r13,_PAGE_ACCESSED@h
 #else
 	li	r13,_PAGE_PRESENT|_PAGE_READ|_PAGE_ACCESSED
 #endif
-
-	FIND_PTE
 	andc.	r13,r13,r11		/* Check permission */
 
 #ifdef CONFIG_PTE_64BIT
@@ -536,13 +537,13 @@ START_BTB_FLUSH_SECTION
 1:
 END_BTB_FLUSH_SECTION
 
-	mfspr	r10, SPRN_SRR0		/* Get faulting address */
+	mfspr	r13, SPRN_SRR0		/* Get faulting address */
 
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
 	lis	r11, PAGE_OFFSET@h
-	cmplw	5, r10, r11
+	cmplw	5, r13, r11
 	blt	5, 3f
 	lis	r11, swapper_pg_dir@h
 	ori	r11, r11, swapper_pg_dir@l
@@ -551,6 +552,7 @@ END_BTB_FLUSH_SECTION
 	rlwinm	r12,r12,0,16,1
 	mtspr	SPRN_MAS1,r12
 
+	FIND_PTE
 	/* Make up the required permissions for kernel code */
 #ifdef CONFIG_PTE_64BIT
 	li	r13,_PAGE_PRESENT | _PAGE_BAP_SX
@@ -571,6 +573,7 @@ END_BTB_FLUSH_SECTION
 	beq	2f			/* KUAP fault */
 #endif
 
+	FIND_PTE
 	/* Make up the required permissions for user code */
 #ifdef CONFIG_PTE_64BIT
 	li	r13,_PAGE_PRESENT | _PAGE_BAP_UX
@@ -580,7 +583,6 @@ END_BTB_FLUSH_SECTION
 #endif
 
 4:
-	FIND_PTE
 	andc.	r13,r13,r11		/* Check permission */
 
 #ifdef CONFIG_PTE_64BIT
-- 
2.44.0


