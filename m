Return-Path: <linux-kernel+bounces-294410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC80C958D4E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98AC8286BA6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997DD1C8FDA;
	Tue, 20 Aug 2024 17:25:25 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8911C6884
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 17:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174725; cv=none; b=om4i4Y2oA0qNV8qEapZbSoSAJLiQ8VVN8bvGyOb33W8Jp3LaIz2BI73zG01MKwk3fDjugqvn5d8U0WS50flMYAC1xe1QEsumAsD0JIx+6Z+6baaW+SARKki5gQoPyMWhHDLDdlYJ5DCs2Oq0PKcT8PX3H3ZvcCIY5UY4BdPhvz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174725; c=relaxed/simple;
	bh=0gQfvAhs5YFK//CvvzjVtowt/pD4X2KbHREPhUMNy2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T+eNTlSbJV4LBFC7k5GGwUyFJ1Taqy6ubdcfgqE4hWywoKxuUinWicQewCtmDZUUieZMsprRnSwwTp/S2z0GqzVLlFFqsjKm/yi2mwEtv9hlZc5bgebBmpiFaV/s+UZzy8nx/AP89ZJh5MwSOZLZ28+M8+jI/gePZ2KgmWbq96A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WpGYN5S0mz9sSS;
	Tue, 20 Aug 2024 19:24:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4KsTrCJD-BLg; Tue, 20 Aug 2024 19:24:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WpGYB4ZLSz9sSL;
	Tue, 20 Aug 2024 19:24:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 88E0A8B778;
	Tue, 20 Aug 2024 19:24:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 4YCMkP3Q_kQL; Tue, 20 Aug 2024 19:24:30 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.72])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2B1D98B763;
	Tue, 20 Aug 2024 19:24:30 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: CASAUBON Jean Michel <jean-michel.casaubon@cs-soprasteria.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 13/14] powerpc/603: Inconditionally use task PGDIR in ITLB misses
Date: Tue, 20 Aug 2024 19:23:57 +0200
Message-ID: <9a3242162ad2faab8019c698e501b326a126ee9e.1724173828.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1724173828.git.christophe.leroy@csgroup.eu>
References: <cover.1724173828.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724174649; l=2327; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=0gQfvAhs5YFK//CvvzjVtowt/pD4X2KbHREPhUMNy2M=; b=kobjcUi1Wo1HmZJYLzLO19ouawHQ6QEEkhu+YYJANwOnZOAlupLqequTxqJyI25mwXhkjNG3G v6ayDAWuBvZBDgdCWl7uR31OH6y7lpm338emnoIKOMY13kdyUsmCxko
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Now that modules exec page tables are preallocated, the instruction
TLBmiss handler can use task PGDIR inconditionally.

Also revise the identification of user vs kernel user space by doing
a calculation instead of a comparison: Get the segment number and
subtract the number of the first kernel segment. The result is
positive for kernel addresses and negative for user addresses,
which means that upper 2 bits are 0 for kernel and 3 for user.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_book3s_32.S | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/head_book3s_32.S b/arch/powerpc/kernel/head_book3s_32.S
index 7995506e7fbd..156304c00ece 100644
--- a/arch/powerpc/kernel/head_book3s_32.S
+++ b/arch/powerpc/kernel/head_book3s_32.S
@@ -413,22 +413,15 @@ END_FTR_SECTION_IFSET(CPU_FTR_FPU_UNAVAILABLE)
 InstructionTLBMiss:
 	/* Get PTE (linux-style) and check access */
 	mfspr	r0,SPRN_IMISS
-#ifdef CONFIG_EXECMEM
-	lis	r1, TASK_SIZE@h		/* check if kernel address */
-	cmplw	0,r1,r0
-#endif
 	mfspr	r2, SPRN_SDR1
 	li	r1,_PAGE_PRESENT | _PAGE_ACCESSED | _PAGE_EXEC
 	rlwinm	r2, r2, 28, 0xfffff000
+	rlwimi	r2,r0,12,20,29		/* insert top 10 bits of address */
+	lwz	r2,0(r2)		/* get pmd entry */
 #ifdef CONFIG_EXECMEM
-	li	r3, 3
-	bgt-	112f
-	lis	r2, (swapper_pg_dir - PAGE_OFFSET)@ha	/* if kernel address, use */
-	li	r3, 0
-	addi	r2, r2, (swapper_pg_dir - PAGE_OFFSET)@l	/* kernel page table */
+	rlwinm	r3, r0, 4, 0xf
+	subi	r3, r3, (TASK_SIZE >> 28) & 0xf
 #endif
-112:	rlwimi	r2,r0,12,20,29		/* insert top 10 bits of address */
-	lwz	r2,0(r2)		/* get pmd entry */
 	rlwinm.	r2,r2,0,0,19		/* extract address of pte page */
 	beq-	InstructionAddressInvalid	/* return if no mapping */
 	rlwimi	r2,r0,22,20,29		/* insert next 10 bits of address */
@@ -437,7 +430,7 @@ InstructionTLBMiss:
 	bne-	InstructionAddressInvalid /* return if access not permitted */
 	/* Convert linux-style PTE to low word of PPC-style PTE */
 #ifdef CONFIG_EXECMEM
-	rlwimi	r2, r3, 0, 31, 31	/* userspace ? -> PP lsb */
+	rlwimi	r2, r3, 1, 31, 31	/* userspace ? -> PP lsb */
 #endif
 	ori	r1, r1, 0xe06		/* clear out reserved bits */
 	andc	r1, r2, r1		/* PP = user? 1 : 0 */
-- 
2.44.0


