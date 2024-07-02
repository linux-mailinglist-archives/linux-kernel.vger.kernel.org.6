Return-Path: <linux-kernel+bounces-237900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD82923F9A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28E01C25209
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017471BBBEF;
	Tue,  2 Jul 2024 13:52:48 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3281A1BA087
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719928367; cv=none; b=m3UOx6PcR/BWpa/853h0DiX7UYjSE4FVoZt6iyrzWDWzrfzeAsOcIU4OKdgWyRTPgl9pN5EVFQU6j0W3SGczXiGIVhHhwn9rxWU7Ub9RkzDqGvaknxUv1Zg4yo7yx6GYhXK6Y0IK078eXY3UEfZRt6rUUOp1fvia54gAdlgsGqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719928367; c=relaxed/simple;
	bh=s4/AO36tt/CSDTJwqMkp0Ne29mDvmColJNi/FwYddUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYhviWUZInRLQ7eP0R2HfWV03/ljcKiR6KpYPBEnXC7jnwB1IE8cZdCaIgQGkbcrJL2kJzfaS8m8lJ94GwMjaA3EjkNMSqfxmFZWFXCoxLp3v7kKHbUBxc1KOeyfJ0Y58W3vuW/M2h3DmEb2ZWLXF8W/FfmIWbeRgHdc6oeDTTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4WD48F0cdQz9v4N;
	Tue,  2 Jul 2024 15:51:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZTLqpHpbv2Is; Tue,  2 Jul 2024 15:51:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4WD4855vHtz9v6q;
	Tue,  2 Jul 2024 15:51:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C667F8B764;
	Tue,  2 Jul 2024 15:51:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id lj50rkcB16g6; Tue,  2 Jul 2024 15:51:33 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.12])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 52B598B774;
	Tue,  2 Jul 2024 15:51:33 +0200 (CEST)
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
Subject: [PATCH v7 16/23] powerpc/e500: Switch to 64 bits PGD on 85xx (32 bits)
Date: Tue,  2 Jul 2024 15:51:28 +0200
Message-ID: <ca85397df02564e5edc3a3c27b55cf43af3e4ef3.1719928057.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1719928057.git.christophe.leroy@csgroup.eu>
References: <cover.1719928057.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719928275; l=2287; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=s4/AO36tt/CSDTJwqMkp0Ne29mDvmColJNi/FwYddUk=; b=+NpDIeX7nxezV8uqAJ+f57QTY8UArzmZcZxJfj50jBMGOKDntXyi6N/EbhjHi0DWOtnmkfflf MC8J1A9UT7YBjgzvu0eLLJeFz4PIekERDRRdcjgnRQgwYn84jNHhjaP
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

At the time being when CONFIG_PTE_64BIT is selected, PTE entries are
64 bits but PGD entries are still 32 bits.

In order to allow leaf PMD entries, switch the PGD to 64 bits entries.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/pgtable-types.h |  4 ++++
 arch/powerpc/kernel/head_85xx.S          | 10 ++++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-types.h b/arch/powerpc/include/asm/pgtable-types.h
index 082c85cc09b1..db965d98e0ae 100644
--- a/arch/powerpc/include/asm/pgtable-types.h
+++ b/arch/powerpc/include/asm/pgtable-types.h
@@ -49,7 +49,11 @@ static inline unsigned long pud_val(pud_t x)
 #endif /* CONFIG_PPC64 */
 
 /* PGD level */
+#if defined(CONFIG_PPC_E500) && defined(CONFIG_PTE_64BIT)
+typedef struct { unsigned long long pgd; } pgd_t;
+#else
 typedef struct { unsigned long pgd; } pgd_t;
+#endif
 #define __pgd(x)	((pgd_t) { (x) })
 static inline unsigned long pgd_val(pgd_t x)
 {
diff --git a/arch/powerpc/kernel/head_85xx.S b/arch/powerpc/kernel/head_85xx.S
index 39724ff5ae1f..a305244afc9f 100644
--- a/arch/powerpc/kernel/head_85xx.S
+++ b/arch/powerpc/kernel/head_85xx.S
@@ -307,8 +307,9 @@ set_ivor:
 #ifdef CONFIG_PTE_64BIT
 #ifdef CONFIG_HUGETLB_PAGE
 #define FIND_PTE	\
-	rlwinm	r12, r10, 13, 19, 29;	/* Compute pgdir/pmd offset */	\
-	lwzx	r11, r12, r11;		/* Get pgd/pmd entry */		\
+	rlwinm	r12, r10, 14, 18, 28;	/* Compute pgdir/pmd offset */	\
+	add	r12, r11, r12;						\
+	lwz	r11, 4(r12);		/* Get pgd/pmd entry */		\
 	rlwinm.	r12, r11, 0, 0, 20;	/* Extract pt base address */	\
 	blt	1000f;			/* Normal non-huge page */	\
 	beq	2f;			/* Bail if no table */		\
@@ -321,8 +322,9 @@ set_ivor:
 1001:	lwz	r11, 4(r12);		/* Get pte entry */
 #else
 #define FIND_PTE	\
-	rlwinm	r12, r10, 13, 19, 29;	/* Compute pgdir/pmd offset */	\
-	lwzx	r11, r12, r11;		/* Get pgd/pmd entry */		\
+	rlwinm	r12, r10, 14, 18, 28;	/* Compute pgdir/pmd offset */	\
+	add	r12, r11, r12;						\
+	lwz	r11, 4(r12);		/* Get pgd/pmd entry */		\
 	rlwinm.	r12, r11, 0, 0, 20;	/* Extract pt base address */	\
 	beq	2f;			/* Bail if no table */		\
 	rlwimi	r12, r10, 23, 20, 28;	/* Compute pte address */	\
-- 
2.44.0


