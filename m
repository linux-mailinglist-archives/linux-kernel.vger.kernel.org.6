Return-Path: <linux-kernel+bounces-207706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CB5901AAD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EDE1B233F3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3744369DF7;
	Mon, 10 Jun 2024 05:55:56 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C228112E48
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998955; cv=none; b=Y84Q8Xu6PVbVeyytl7HlFeGK16IJD5VcQSHGrZzFJROnhNvbNBIN9ZzeWZesMw2l6WW5Ko3S4jxLdi9f9erGLE/3BcpK+gjZXUTXySp9HKXJT4yjkljs+siEO34D3HJLXWzx17pndFCBI0N0a0c4G7KYqomZSEoIFp8u8Z71tUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998955; c=relaxed/simple;
	bh=s4/AO36tt/CSDTJwqMkp0Ne29mDvmColJNi/FwYddUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AAAKIukZp8ICqYFt/s3dbZB0FqPajrH/t2/51kr1zUQnen18VnaIa5lpSLdEwtXZ2SknIewW+/sAJPz7CZtKTA35XIBk4cgCbxI+gOBQscab7jrUZsf0EDCCWtvhB5C+33QPpNkxke3MD3ORASsQEk6ZxlGBSHUFVNMVcux4qJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4VyLcX4pfLz9v5s;
	Mon, 10 Jun 2024 07:55:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oDUislhVtwik; Mon, 10 Jun 2024 07:55:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4VyLcL52DXz9v6D;
	Mon, 10 Jun 2024 07:54:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A8A2E8B76E;
	Mon, 10 Jun 2024 07:54:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id PyXQSU5-K7sf; Mon, 10 Jun 2024 07:54:58 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 834C98B764;
	Mon, 10 Jun 2024 07:54:58 +0200 (CEST)
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
Subject: [PATCH v5 11/18] powerpc/e500: Switch to 64 bits PGD on 85xx (32 bits)
Date: Mon, 10 Jun 2024 07:54:56 +0200
Message-ID: <efc1a7649848e7924a1605114cbdc1e936301db8.1717955559.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1717955558.git.christophe.leroy@csgroup.eu>
References: <cover.1717955558.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717998887; l=2287; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=s4/AO36tt/CSDTJwqMkp0Ne29mDvmColJNi/FwYddUk=; b=mchxKAuqRvjFYDgiBDjvxFYzcdSlrJkxgoFKrmqyi05IMpoH75BRwcyKNjewV2rRlD8PVMU9m +B6OVQSgl6VCsgYYdUJxeiw47CC+lOBVbr2wlHtlGaCWkBk3Kh9bjF5
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


