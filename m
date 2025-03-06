Return-Path: <linux-kernel+bounces-548703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A701A54862
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 11:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B033ABC71
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 10:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C65318A6B5;
	Thu,  6 Mar 2025 10:50:06 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56352202F92
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 10:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741258206; cv=none; b=j+E5Vm9azN59GyFqObjHslB66PlDnYhKAK6nGix0Dzt61gag7qvrOwaHkcfSzCj80NgfyMJoxuWVFCU5KK5tI0MzPQ6rjjiQImPYQ3UEFLgHMhhzyPgMrOqhxG/gXNU0XA0kzqNxKqLG0z+Xqjdq5U6E/1Wwsce/sqaIQKTyW2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741258206; c=relaxed/simple;
	bh=aOImr5/U4ykbLTFYU0AB+Akmi9BbY0kGzfkbj74bCbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jTYVWp9a02RyJvnOp3RBUorLrwdw5Sl3NccVa3onq1TNzKx4nSs5iKY6edsgKfvtlTeDi7XLkj5zn/UaJ4B4mnk7tYo/P0Wa0hnFBYKqGZNXBmf+i4HVgv17QJpUHD+c4a4ZbSvNONFU1OIra4JFAY9ObTJm4hbgb9XsXZv8iUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Z7lsP5KYTz9stG;
	Thu,  6 Mar 2025 11:24:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id e4vbfzpb9Tx7; Thu,  6 Mar 2025 11:24:41 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Z7lsP4K5zz9rvV;
	Thu,  6 Mar 2025 11:24:41 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5A1338B766;
	Thu,  6 Mar 2025 11:24:41 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id cLeejrd8zjee; Thu,  6 Mar 2025 11:24:41 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.99])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E9DD58B763;
	Thu,  6 Mar 2025 11:24:40 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/kexec: fix physical address calculation in clear_utlb_entry()
Date: Thu,  6 Mar 2025 11:24:28 +0100
Message-ID: <dc4f9616fba9c05c5dbf9b4b5480eb1c362adc17.1741256651.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741256668; l=1671; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=aOImr5/U4ykbLTFYU0AB+Akmi9BbY0kGzfkbj74bCbw=; b=63/dW0ZW/45Bs9gOVtFdTdT4ylZccTHf357VIIIUuXR8lbn4iNW72GNZX4ilfWq8C5hADM0qG TBMsNMy1qQRDXRvsnpovR4/UyApzga3NB8oKN3M68m5tr8+cuj4rQJ4
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

In relocate_32.S, function clear_utlb_entry() goes into real mode. To
do so, it has to calculate the physical address based on the virtual
address. To get the virtual address it uses 'bl' which is problematic
(see commit c974809a26a1 ("powerpc/vdso: Avoid link stack corruption
in __get_datapage()")). In addition, the calculation is done on a
wrong address because 'bl' loads LR with the address of the following
instruction, not the address of the target. So when the target is not
the instruction following the 'bl' instruction, it may lead to
unexpected behaviour.

Fix it by re-writing the code so that is goes via another path which
is based 'bcl 20,31,.+4' which is the right instruction to use for that.

Fixes: 683430200315 ("powerpc/47x: Kernel support for KEXEC")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Fixed patch description and added Fixes: tag.
[Previous patch subject was "powerpc: Fix address calculation in clear_utlb_entry()"]
---
 arch/powerpc/kexec/relocate_32.S | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kexec/relocate_32.S b/arch/powerpc/kexec/relocate_32.S
index 104c9911f406..dd86e338307d 100644
--- a/arch/powerpc/kexec/relocate_32.S
+++ b/arch/powerpc/kexec/relocate_32.S
@@ -348,16 +348,13 @@ write_utlb:
 	rlwinm	r10, r24, 0, 22, 27
 
 	cmpwi	r10, PPC47x_TLB0_4K
-	bne	0f
 	li	r10, 0x1000			/* r10 = 4k */
-	ANNOTATE_INTRA_FUNCTION_CALL
-	bl	1f
+	beq	0f
 
-0:
 	/* Defaults to 256M */
 	lis	r10, 0x1000
 
-	bcl	20,31,$+4
+0:	bcl	20,31,$+4
 1:	mflr	r4
 	addi	r4, r4, (2f-1b)			/* virtual address  of 2f */
 
-- 
2.47.0


