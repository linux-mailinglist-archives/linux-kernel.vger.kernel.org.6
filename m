Return-Path: <linux-kernel+bounces-227416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 724C59150F2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E9E8286C77
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA9A1A08DF;
	Mon, 24 Jun 2024 14:47:46 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8108919DF41
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240465; cv=none; b=PHT+iQaNz0SZC5pSprCeW/fQ4lGWXq/qN++OpiEwI1N6geXptAcD7AuTYxJiPSpwmQK0xt4iHmSc3I/VyOo9puLUxN2fQfmjnmBBLPdaHd29j65mGx0PRHRoTsFNFu4CNhX5Pvlitk7wV7MIIXQSZLwAVtxafxdmFSeJ7f9OFuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240465; c=relaxed/simple;
	bh=s4/AO36tt/CSDTJwqMkp0Ne29mDvmColJNi/FwYddUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rr97Zh7JDoRpQpQZNBios4m1dZqNnWmB/4xOuMw1fY4hz7O3IRn1WtjJ/KF4XUvuZW7MVWLrggrntla0t3XiVTEYWNhx4e9EZhsZRzvDcLZm7oHIUL2pLEYa7L8buhnZ0F99GHjch73v7Xjwi6LxYM54pQZPD6U7l5JvXgBV5ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4W79kx2drHz9vFJ;
	Mon, 24 Jun 2024 16:46:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PHHUjczuVrWQ; Mon, 24 Jun 2024 16:46:17 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4W79km0vPVz9vG8;
	Mon, 24 Jun 2024 16:46:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 18F208B766;
	Mon, 24 Jun 2024 16:46:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id g0hKsUL5lKmX; Mon, 24 Jun 2024 16:46:08 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.33])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 895D88B763;
	Mon, 24 Jun 2024 16:46:07 +0200 (CEST)
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
Subject: [PATCH v6 16/23] powerpc/e500: Switch to 64 bits PGD on 85xx (32 bits)
Date: Mon, 24 Jun 2024 16:45:42 +0200
Message-ID: <472a140a443ced56cb269e6a5a09765b8443be73.1719240269.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1719240269.git.christophe.leroy@csgroup.eu>
References: <cover.1719240269.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719240334; l=2287; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=s4/AO36tt/CSDTJwqMkp0Ne29mDvmColJNi/FwYddUk=; b=CN4pIruJZfaP8pqI7raFC9PzJ8jVK1os0okmAd4KjnuTUb7LanOI/mt7emthOnTUJhA/4DTJe IvRlknT8wf/Ct529vr7nkJeztvHn+b8iqrnvJLFphIFyH0zwpiaJn55
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


