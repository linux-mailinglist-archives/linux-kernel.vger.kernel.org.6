Return-Path: <linux-kernel+bounces-545784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8E0A4F15A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 00:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EBCE188EBB1
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702AF1FAC4C;
	Tue,  4 Mar 2025 23:20:06 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368E427811E
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 23:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741130406; cv=none; b=O/+bnkrXuaL1qILooyalpE/VjECqHsSNUftnvuiwYqn0M2VBEIUpjrq503ClTXC5/+X3I6qKB4b2ekWEeaVXy0APZHaM7qEWv6rQlhFaZqBj0KQA+0xv4k7SUtZOGQQMHZVWpaMFmhZo+bqHzsgDTy/PddgmUFN5We7W/PDAiEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741130406; c=relaxed/simple;
	bh=zj/1hg648gPj2/H3MIvqSLwL5kgx31RsIUiX/gZMNZI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aTu2ouO3J4jPnm/ACquqTJ+U5EbFHZg0Lgke0VoUwfrmplgtsQw5jNBjk8MFcOq+vgZZYkPyUjbWlitHE1vf+Pvgj3qciaaP27s1ugR/qekSa8GrMzGf57oNipDEPKHVsu4GobPTHa4Fk6U7HWkCYa7MOlmMI5afViNZczad0ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Z6rjw6nlzz9stH;
	Wed,  5 Mar 2025 00:00:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BLfibhs76Dlw; Wed,  5 Mar 2025 00:00:04 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Z6rjv31DTz9stG;
	Wed,  5 Mar 2025 00:00:03 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 537F88B776;
	Wed,  5 Mar 2025 00:00:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id A0eNGyMj1i94; Wed,  5 Mar 2025 00:00:03 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.202.221])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 70FCA8B763;
	Wed,  5 Mar 2025 00:00:02 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Fix address calculation in clear_utlb_entry()
Date: Tue,  4 Mar 2025 23:59:56 +0100
Message-ID: <e7ef54814c5341f201bee89aa401b5ab20164af6.1741128988.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741129197; l=1214; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=zj/1hg648gPj2/H3MIvqSLwL5kgx31RsIUiX/gZMNZI=; b=9R4+xIsE5RbZ7e//sO6xPodl1H9aLYMmhkehdnx/c98wFnoNGl6DsVCXQ31j+Ofnli45EUKzC Jxv4xV0nXrrBre25Jwmd4k9ocgYsDz2urrKguoXJLjyh7ucKQmAodPU
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

In relocatable.S, function clear_utlb_entry() goes into real mode. To
do so, it has to calculate the physical address based on the virtual
address. To get the virtual address it used 'bl' which is problematic
(see commit XXX). In addition, the calculation is done on a bad address,
which may lead to unexpected behaviour.

Fix it by re-writing the code so that is goes via another path which
is based 'bcl 20,31,.+4' which is the right instruction to use for that.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
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


