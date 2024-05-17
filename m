Return-Path: <linux-kernel+bounces-182544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A8F8C8C78
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D8A52860E9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63B71422D6;
	Fri, 17 May 2024 19:01:30 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC3913FD94
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 19:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715972490; cv=none; b=C5TlcmM19Tu4Hp4aaqSheyNikA3icCY+0Huiaf4JnT+jxhL9dDhwP231b4ea0x4De7CmzPBsE+3Li0VDQ/eKFr/+rrlWBYN4tJyBtQ6GYVPdcVnONeFla5pE5Vtt5o2JAcB54pnqOXxTuHFtXN9FiMb3jzzwP+cBDYgxLO/+2Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715972490; c=relaxed/simple;
	bh=S24pIBxGP2mbrQFGO3lIOuFe18XifxlaeypwhWa5OmM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nVUil3sX8KuBqy3lhNjI3leekr3TerOD0Hig3iPfDbIOohYh18FoniCmkPOkToHtfyOSYQQDFq8GW1GwEkngVPBu/vWK/tFHEp4Xy1bn59zv2QBsNvwvPDP2TUdS5onM6W6PGOA3k8B/uQe41fFQq1OKA5HUHj6G9NofibT5MJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4Vgx9b14Wqz9tCB;
	Fri, 17 May 2024 21:00:19 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id awkweTb108lI; Fri, 17 May 2024 21:00:19 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4Vgx9R4Tj5z9t2k;
	Fri, 17 May 2024 21:00:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 957818B775;
	Fri, 17 May 2024 21:00:11 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id xdfh3cHWQ4DC; Fri, 17 May 2024 21:00:11 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.121])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 16AE48B766;
	Fri, 17 May 2024 21:00:11 +0200 (CEST)
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
Subject: [RFC PATCH v2 15/20] powerpc/85xx: Switch to 64 bits PGD
Date: Fri, 17 May 2024 21:00:09 +0200
Message-ID: <a1d92dd7c390672c163ce0611600dde8cb0eaab4.1715971869.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1715971869.git.christophe.leroy@csgroup.eu>
References: <cover.1715971869.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715972397; l=2171; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=S24pIBxGP2mbrQFGO3lIOuFe18XifxlaeypwhWa5OmM=; b=dq4KYwp67s1XoUtlQUnziM5iWCqv4B+5JoZKA8fii7u5shKTuks/fAZJdGLz9mZklcw01TvVi NVxevrzLaMuCdgrWuh0m4GD4H5Aa8EYu47sl/Pn0TX/xCXEgTOVG6Uy
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

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


