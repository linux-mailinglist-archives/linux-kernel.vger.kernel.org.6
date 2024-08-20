Return-Path: <linux-kernel+bounces-294406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC70958D4A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A39692862AD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961001C824A;
	Tue, 20 Aug 2024 17:25:07 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6151C824C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174707; cv=none; b=PQ+Zb3TI5Hl8EV0nq46KXpPjd2sXPFudOApKXgYvF1ihycUprOw07nagpLTslxyVy6FdkBHvuA5fkZH51zFHGtwl2vBG9j3bheAtogSj97kBiXuLx1ZDbBy5wY0M7CfwXMMKLTL7wyigpcFHj93DyrgEASIW7oQ1TNo02XE63TM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174707; c=relaxed/simple;
	bh=r7hgp5a1WbmT5mtWsfG22jTzXMvaQbiUDa0bT4sYRAY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2KdZ5KmqlGnvnyFL0KtxKAKJs/+QclF4I++T9nEPlw2MQr023ZpZEYDzSeKHGX1N/pijmq4AfrtFxDLFlEAKCm/JkaGOd2dj7e+f6+HzOA3RfXPmHhUhDh/wxmiH8TGzFSyh2yJOiikqDP+Jay5CyeAzJCQmDnmqSNFJ66Yo04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WpGYH10g7z9sST;
	Tue, 20 Aug 2024 19:24:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R--vwrYBHKFw; Tue, 20 Aug 2024 19:24:35 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WpGY90Wn0z9sSX;
	Tue, 20 Aug 2024 19:24:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id F2F158B779;
	Tue, 20 Aug 2024 19:24:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id SgMwWgLloowk; Tue, 20 Aug 2024 19:24:28 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.72])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 8AFD18B778;
	Tue, 20 Aug 2024 19:24:28 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: CASAUBON Jean Michel <jean-michel.casaubon@cs-soprasteria.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 09/14] powerpc/8xx: Inconditionally use task PGDIR in DTLB misses
Date: Tue, 20 Aug 2024 19:23:53 +0200
Message-ID: <7a76a923d2a111f1d843d8b20b4df0c65d2f4a7b.1724173828.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1724173828.git.christophe.leroy@csgroup.eu>
References: <cover.1724173828.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724174648; l=4030; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=r7hgp5a1WbmT5mtWsfG22jTzXMvaQbiUDa0bT4sYRAY=; b=9cw+ytRAHbp5kWvJTpij8S81pfY0dVYt82UU1oClVTMrjDPYSayaMH+aFGOknPNIF4O+UnmU9 1f1wnW9ZPsDCe7phDD5XXUKIangM75jNG6+lTbkDuYwtOnYI1PYryw9
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

At the time being, DATA TLB miss handlers use task PGDIR for user
addresses and swapper_pg_dir for kernel addresses.

Now that kernel part of swapper_pg_dir is copied into task PGDIR
at PGD allocation, it is possible to avoid the above logic and
always use task PGDIR.

But new kernel PGD entries can still be created after init, in
which case those PGD entries may miss in task PGDIR. This can be
handled in DATA TLB error handler.

However, it needs to be done in real mode because the missing
entry might be related to the stack.

So implement copy of missing PGD entry in the prolog of DATA TLB
ERROR handler just after the fixup of DAR.

Note that this is feasible because 8xx doesn't implement vmap or
ioremap with 8Mbytes pages but only 512kbytes pages which are at
PTE level.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_8xx.S | 57 ++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index f9a05648a522..811a7130505c 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -40,16 +40,6 @@
 
 #include "head_32.h"
 
-.macro compare_to_kernel_boundary scratch, addr
-#if CONFIG_TASK_SIZE <= 0x80000000 && MODULES_VADDR >= 0x80000000
-/* By simply checking Address >= 0x80000000, we know if its a kernel address */
-	not.	\scratch, \addr
-#else
-	rlwinm	\scratch, \addr, 16, 0xfff8
-	cmpli	cr0, \scratch, TASK_SIZE@h
-#endif
-.endm
-
 #define PAGE_SHIFT_512K		19
 #define PAGE_SHIFT_8M		23
 
@@ -237,19 +227,12 @@ instruction_counter:
 	START_EXCEPTION(INTERRUPT_DATA_TLB_MISS_8xx, DataStoreTLBMiss)
 	mtspr	SPRN_SPRG_SCRATCH2, r10
 	mtspr	SPRN_M_TW, r11
-	mfcr	r11
 
 	/* If we are faulting a kernel address, we have to use the
 	 * kernel page tables.
 	 */
 	mfspr	r10, SPRN_MD_EPN
-	compare_to_kernel_boundary r10, r10
 	mfspr	r10, SPRN_M_TWB	/* Get level 1 table */
-	blt+	3f
-	rlwinm	r10, r10, 0, 20, 31
-	oris	r10, r10, (swapper_pg_dir - PAGE_OFFSET)@ha
-3:
-	mtcr	r11
 	lwz	r11, (swapper_pg_dir-PAGE_OFFSET)@l(r10)	/* Get level 1 entry */
 
 	mtspr	SPRN_MD_TWC, r11
@@ -321,15 +304,19 @@ instruction_counter:
 	cmpwi	cr1, r11, RPN_PATTERN
 	beq-	cr1, FixupDAR	/* must be a buggy dcbX, icbi insn. */
 DARFixed:/* Return from dcbx instruction bug workaround */
+	mfspr	r11, SPRN_DSISR
+	rlwinm	r11, r11, 0, DSISR_NOHPTE
+	cmpwi	cr1, r11, 0
+	beq+	cr1, .Ldtlbie
+	mfspr	r11, SPRN_DAR
+	tlbie	r11
+	rlwinm	r11, r11, 16, 0xffff
+	cmplwi	cr1, r11, TASK_SIZE@h
+	bge-	cr1, FixupPGD
+.Ldtlbie:
 	EXCEPTION_PROLOG_1
 	/* 0x300 is DataAccess exception, needed by bad_page_fault() */
 	EXCEPTION_PROLOG_2 INTERRUPT_DATA_STORAGE DataTLBError handle_dar_dsisr=1
-	lwz	r4, _DAR(r11)
-	lwz	r5, _DSISR(r11)
-	andis.	r10,r5,DSISR_NOHPTE@h
-	beq+	.Ldtlbie
-	tlbie	r4
-.Ldtlbie:
 	prepare_transfer_to_handler
 	bl	do_page_fault
 	b	interrupt_return
@@ -383,6 +370,30 @@ DARFixed:/* Return from dcbx instruction bug workaround */
 	__HEAD
 	. = 0x2000
 
+FixupPGD:
+	mtspr	SPRN_M_TW, r10
+	mfspr	r10, SPRN_DAR
+	mtspr	SPRN_MD_EPN, r10
+	mfspr	r11, SPRN_M_TWB	/* Get level 1 table */
+	lwz	r10, (swapper_pg_dir - PAGE_OFFSET)@l(r11)	/* Get the level 1 entry */
+	cmpwi	cr1, r10, 0
+	bne	cr1, 1f
+
+	rlwinm	r10, r11, 0, 20, 31
+	oris	r10, r10, (swapper_pg_dir - PAGE_OFFSET)@ha
+	lwz	r10, (swapper_pg_dir - PAGE_OFFSET)@l(r10)	/* Get the level 1 entry */
+	cmpwi	cr1, r10, 0
+	beq	cr1, 1f
+	stw	r10, (swapper_pg_dir - PAGE_OFFSET)@l(r11)	/* Set the level 1 entry */
+	mfspr	r10, SPRN_M_TW
+	mtcr	r10
+	mfspr	r10, SPRN_SPRG_SCRATCH0
+	mfspr	r11, SPRN_SPRG_SCRATCH1
+	rfi
+1:
+	mfspr	r10, SPRN_M_TW
+	b	.Ldtlbie
+
 /* This is the procedure to calculate the data EA for buggy dcbx,dcbi instructions
  * by decoding the registers used by the dcbx instruction and adding them.
  * DAR is set to the calculated address.
-- 
2.44.0


