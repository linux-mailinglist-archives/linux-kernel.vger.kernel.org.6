Return-Path: <linux-kernel+bounces-294409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A838B958D4D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277E91F25427
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7274C1C8FB5;
	Tue, 20 Aug 2024 17:25:21 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8931C57A6
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 17:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174720; cv=none; b=IksixNn0ZXIGnzqVFzzosgqWkTUetbpJNW5lOApymnp6leMP/KaYJvVLKnMlOBx7X+gYHQ6WWdicz7B3P4gQb6f8pvIo7SHUOilddxCe/085gBWC63ygr/gL7CS8xi81J3DpJkaWvPr7juz9n1WkAbitGb5m6mZWw+5HIvBV24Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174720; c=relaxed/simple;
	bh=ispkF9ZJ/Yt64VqF7/CAqBf3WYI0FzEr2m4h57SdRFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+bPhdayuF7cDZf4j2nEwaIvdcNoseQnextk2xIXoUlAMRIFi3mn5TVHwAgk9oq5m9ZMVfAsVXkLOX/vrOS551lrsgvXBFv8/oBwxQe3yeMVYAugLSR0mvVLfl5oyon0WSVa5ca2qiPZDoUAi+CapqtsctWKBJvMjB51x45rKI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WpGYM2bgdz9sSW;
	Tue, 20 Aug 2024 19:24:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RoQXAjvy9bzZ; Tue, 20 Aug 2024 19:24:39 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WpGYB1ttpz9sSc;
	Tue, 20 Aug 2024 19:24:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 3250D8B779;
	Tue, 20 Aug 2024 19:24:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id b1w8SV1MamqZ; Tue, 20 Aug 2024 19:24:30 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.72])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id BA4008B778;
	Tue, 20 Aug 2024 19:24:29 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: CASAUBON Jean Michel <jean-michel.casaubon@cs-soprasteria.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 12/14] powerpc/603: Switch r0 and r3 in TLB miss handlers
Date: Tue, 20 Aug 2024 19:23:56 +0200
Message-ID: <566af5e87685b1a85d3182549c0d520ce2d8877a.1724173828.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1724173828.git.christophe.leroy@csgroup.eu>
References: <cover.1724173828.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724174648; l=7848; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=ispkF9ZJ/Yt64VqF7/CAqBf3WYI0FzEr2m4h57SdRFU=; b=8cGa/5vx12h7UEP7zBcHs/fuQMGurLlu6hsP/MUAwrQsqx+FtsOAmLTm1J0dXYIaR7d3UuoR0 Q3t8wbYPG8WDRgTHup4IalL0OLZp3B7QioIPVI2Iugyva5+1yfzZjTs
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

In preparation of next patch that will perform some additional
calculations to replace comparison, switch the use of r0 and r3
as r0 has some limitations in some instructions like 'addi/subi'.

Also remove outdated comments about the meaning of each register.
The registers are used for many things and it would be difficult
to accurately describe all things done with a given register. The
function is now small enough to get a global view without much
description.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_book3s_32.S | 94 +++++++++++-----------------
 1 file changed, 38 insertions(+), 56 deletions(-)

diff --git a/arch/powerpc/kernel/head_book3s_32.S b/arch/powerpc/kernel/head_book3s_32.S
index 57196883a00e..7995506e7fbd 100644
--- a/arch/powerpc/kernel/head_book3s_32.S
+++ b/arch/powerpc/kernel/head_book3s_32.S
@@ -411,39 +411,33 @@ END_FTR_SECTION_IFSET(CPU_FTR_FPU_UNAVAILABLE)
  */
 	. = INTERRUPT_INST_TLB_MISS_603
 InstructionTLBMiss:
-/*
- * r0:	userspace flag (later scratch)
- * r1:	linux style pte ( later becomes ppc hardware pte )
- * r2:	ptr to linux-style pte
- * r3:	fault address
- */
 	/* Get PTE (linux-style) and check access */
-	mfspr	r3,SPRN_IMISS
+	mfspr	r0,SPRN_IMISS
 #ifdef CONFIG_EXECMEM
 	lis	r1, TASK_SIZE@h		/* check if kernel address */
-	cmplw	0,r1,r3
+	cmplw	0,r1,r0
 #endif
 	mfspr	r2, SPRN_SDR1
 	li	r1,_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_EXEC
 	rlwinm	r2, r2, 28, 0xfffff000
 #ifdef CONFIG_EXECMEM
-	li	r0, 3
+	li	r3, 3
 	bgt-	112f
 	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
-	li	r0, 0
+	li	r3, 0
 	addi	r2, r2, (swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
 #endif
-112:	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
+112:	rlwimi	r2,r0,12,20,29		/* insert top 10 bits of address */
 	lwz	r2,0(r2)		/* get pmd entry */
 	rlwinm.	r2,r2,0,0,19		/* extract address of pte page */
 	beq-	InstructionAddressInvalid	/* return if no mapping */
-	rlwimi	r2,r3,22,20,29		/* insert next 10 bits of address */
+	rlwimi	r2,r0,22,20,29		/* insert next 10 bits of address */
 	lwz	r2,0(r2)		/* get linux-style pte */
 	andc.	r1,r1,r2		/* check access & ~permission */
 	bne-	InstructionAddressInvalid /* return if access not permitted */
 	/* Convert linux-style PTE to low word of PPC-style PTE */
 #ifdef CONFIG_EXECMEM
-	rlwimi	r2, r0, 0, 31, 31	/* userspace ? -> PP lsb */
+	rlwimi	r2, r3, 0, 31, 31	/* userspace ? -> PP lsb */
 #endif
 	ori	r1, r1, 0xe06		/* clear out reserved bits */
 	andc	r1, r2, r1		/* PP = user? 1 : 0 */
@@ -451,7 +445,7 @@ BEGIN_FTR_SECTION
 	rlwinm	r1,r1,0,~_PAGE_COHERENT	/* clear M (coherence not required) */
 END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
 	mtspr	SPRN_RPA,r1
-	tlbli	r3
+	tlbli	r0
 	mfspr	r3,SPRN_SRR1		/* Need to restore CR0 */
 	mtcrf	0x80,r3
 	rfi
@@ -480,35 +474,29 @@ InstructionAddressInvalid:
  */
 	. = INTERRUPT_DATA_LOAD_TLB_MISS_603
 DataLoadTLBMiss:
-/*
- * r0:	userspace flag (later scratch)
- * r1:	linux style pte ( later becomes ppc hardware pte )
- * r2:	ptr to linux-style pte
- * r3:	fault address
- */
 	/* Get PTE (linux-style) and check access */
-	mfspr	r3,SPRN_DMISS
+	mfspr	r0,SPRN_DMISS
 	lis	r1, TASK_SIZE@h		/* check if kernel address */
-	cmplw	0,r1,r3
+	cmplw	0,r1,r0
 	mfspr	r2, SPRN_SDR1
 	li	r1, _PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_READ
 	rlwinm	r2, r2, 28, 0xfffff000
-	li	r0, 3
+	li	r3, 3
 	bgt-	112f
 	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
-	li	r0, 0
+	li	r3, 0
 	addi	r2, r2, (swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
-112:	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
+112:	rlwimi	r2,r0,12,20,29		/* insert top 10 bits of address */
 	lwz	r2,0(r2)		/* get pmd entry */
 	rlwinm.	r2,r2,0,0,19		/* extract address of pte page */
 	beq-	DataAddressInvalid	/* return if no mapping */
-	rlwimi	r2,r3,22,20,29		/* insert next 10 bits of address */
+	rlwimi	r2,r0,22,20,29		/* insert next 10 bits of address */
 	lwz	r2,0(r2)		/* get linux-style pte */
 	andc.	r1,r1,r2		/* check access & ~permission */
 	bne-	DataAddressInvalid	/* return if access not permitted */
 	/* Convert linux-style PTE to low word of PPC-style PTE */
 	rlwinm	r1,r2,32-9,30,30	/* _PAGE_WRITE -> PP msb */
-	rlwimi	r2,r0,0,30,31		/* userspace ? -> PP */
+	rlwimi	r2,r3,0,30,31		/* userspace ? -> PP */
 	rlwimi	r1,r2,32-3,24,24	/* _PAGE_WRITE -> _PAGE_DIRTY */
 	xori	r1,r1,_PAGE_DIRTY	/* clear dirty when not rw */
 	ori	r1,r1,0xe04		/* clear out reserved bits */
@@ -518,23 +506,23 @@ BEGIN_FTR_SECTION
 END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
 	mtspr	SPRN_RPA,r1
 BEGIN_MMU_FTR_SECTION
-	li	r0,1
+	li	r3,1
 	mfspr	r1,SPRN_SPRG_603_LRU
-	rlwinm	r2,r3,20,27,31		/* Get Address bits 15:19 */
-	slw	r0,r0,r2
-	xor	r1,r0,r1
-	srw	r0,r1,r2
+	rlwinm	r2,r0,20,27,31		/* Get Address bits 15:19 */
+	slw	r3,r3,r2
+	xor	r1,r3,r1
+	srw	r3,r1,r2
 	mtspr   SPRN_SPRG_603_LRU,r1
 	mfspr	r2,SPRN_SRR1
-	rlwimi	r2,r0,31-14,14,14
+	rlwimi	r2,r3,31-14,14,14
 	mtspr   SPRN_SRR1,r2
 	mtcrf	0x80,r2
-	tlbld	r3
+	tlbld	r0
 	rfi
 MMU_FTR_SECTION_ELSE
 	mfspr	r2,SPRN_SRR1		/* Need to restore CR0 */
 	mtcrf	0x80,r2
-	tlbld	r3
+	tlbld	r0
 	rfi
 ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
 DataAddressInvalid:
@@ -560,34 +548,28 @@ DataAddressInvalid:
  */
 	. = INTERRUPT_DATA_STORE_TLB_MISS_603
 DataStoreTLBMiss:
-/*
- * r0:	userspace flag (later scratch)
- * r1:	linux style pte ( later becomes ppc hardware pte )
- * r2:	ptr to linux-style pte
- * r3:	fault address
- */
 	/* Get PTE (linux-style) and check access */
-	mfspr	r3,SPRN_DMISS
+	mfspr	r0,SPRN_DMISS
 	lis	r1, TASK_SIZE@h		/* check if kernel address */
-	cmplw	0,r1,r3
+	cmplw	0,r1,r0
 	mfspr	r2, SPRN_SDR1
 	li	r1, _PAGE_RW | _PAGE_DIRTY | _PAGE_PRESENT | _PAGE_ACCESSED
 	rlwinm	r2, r2, 28, 0xfffff000
-	li	r0, 3
+	li	r3, 3
 	bgt-	112f
 	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
-	li	r0, 0
+	li	r3, 0
 	addi	r2, r2, (swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
-112:	rlwimi	r2,r3,12,20,29		/* insert top 10 bits of address */
+112:	rlwimi	r2,r0,12,20,29		/* insert top 10 bits of address */
 	lwz	r2,0(r2)		/* get pmd entry */
 	rlwinm.	r2,r2,0,0,19		/* extract address of pte page */
 	beq-	DataAddressInvalid	/* return if no mapping */
-	rlwimi	r2,r3,22,20,29		/* insert next 10 bits of address */
+	rlwimi	r2,r0,22,20,29		/* insert next 10 bits of address */
 	lwz	r2,0(r2)		/* get linux-style pte */
 	andc.	r1,r1,r2		/* check access & ~permission */
 	bne-	DataAddressInvalid	/* return if access not permitted */
 	/* Convert linux-style PTE to low word of PPC-style PTE */
-	rlwimi	r2,r0,0,31,31		/* userspace ? -> PP lsb */
+	rlwimi	r2,r3,0,31,31		/* userspace ? -> PP lsb */
 	li	r1,0xe06		/* clear out reserved bits & PP msb */
 	andc	r1,r2,r1		/* PP = user? 1: 0 */
 BEGIN_FTR_SECTION
@@ -597,23 +579,23 @@ END_FTR_SECTION_IFCLR(CPU_FTR_NEED_COHERENT)
 	mfspr	r2,SPRN_SRR1		/* Need to restore CR0 */
 	mtcrf	0x80,r2
 BEGIN_MMU_FTR_SECTION
-	li	r0,1
+	li	r3,1
 	mfspr	r1,SPRN_SPRG_603_LRU
-	rlwinm	r2,r3,20,27,31		/* Get Address bits 15:19 */
-	slw	r0,r0,r2
-	xor	r1,r0,r1
-	srw	r0,r1,r2
+	rlwinm	r2,r0,20,27,31		/* Get Address bits 15:19 */
+	slw	r3,r3,r2
+	xor	r1,r3,r1
+	srw	r3,r1,r2
 	mtspr   SPRN_SPRG_603_LRU,r1
 	mfspr	r2,SPRN_SRR1
-	rlwimi	r2,r0,31-14,14,14
+	rlwimi	r2,r3,31-14,14,14
 	mtspr   SPRN_SRR1,r2
 	mtcrf	0x80,r2
-	tlbld	r3
+	tlbld	r0
 	rfi
 MMU_FTR_SECTION_ELSE
 	mfspr	r2,SPRN_SRR1		/* Need to restore CR0 */
 	mtcrf	0x80,r2
-	tlbld	r3
+	tlbld	r0
 	rfi
 ALT_MMU_FTR_SECTION_END_IFSET(MMU_FTR_NEED_DTLB_SW_LRU)
 
-- 
2.44.0


