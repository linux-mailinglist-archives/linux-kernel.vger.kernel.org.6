Return-Path: <linux-kernel+bounces-296849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6DC95AFC2
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11571B2327C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 07:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FBA16A94F;
	Thu, 22 Aug 2024 07:58:47 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C495165F11
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724313526; cv=none; b=iJwFmi4ay+1fAtHKvOY3dP2JS3za09asikrXh15PG0o/lcK37dtzUbqYyTnik7+MGOjuIfUORm5/z456Y7w7OB5wMSbveP2ATHVYqO6HpAnkhet1FZY89ter4cxRWfKZ4MGbcmwflvNlrA4piwlKc20xpIVjWDJ1y30bVsYAQ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724313526; c=relaxed/simple;
	bh=JVqiB4HY2Y491GrobmVbch4xQAY4hzCA5VcgYB4HTrA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lHTCgQO/7Irj1msqkt4DMYDQ5rLrZ4+Bxwc+C30OMb+EEKF7M7XgUlYf6Z97gB/LzJ9QUjWKa3tcGvL7293lH6U/CLnIfGIwAFXv4NF+SaVVlibUF9sp63ae8i5FtB8QtZzzWAo8RGfIwmdEtNmj7PincQq21qjstPHrVh+RGjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WqFvR3X7Yz9sSK;
	Thu, 22 Aug 2024 09:58:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NlYp6PfhUgnd; Thu, 22 Aug 2024 09:58:43 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WqFvR2NW0z9sSH;
	Thu, 22 Aug 2024 09:58:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 40C628B77D;
	Thu, 22 Aug 2024 09:58:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 2HbrGellHzJ0; Thu, 22 Aug 2024 09:58:43 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (PO16920.IDSI0.si.c-s.fr [192.168.232.181])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E12898B763;
	Thu, 22 Aug 2024 09:58:42 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc/mm: Fix return type of pgd_val()
Date: Thu, 22 Aug 2024 09:58:42 +0200
Message-ID: <45f8fdf298ec3df7573b66d21b03a5cda92e2cb1.1724313510.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724313522; l=2891; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=JVqiB4HY2Y491GrobmVbch4xQAY4hzCA5VcgYB4HTrA=; b=hD17Uy0LwJi8VLADyyur24FjIkg6yV8fFc4Cr9B7HXs8MxCTDoNx4jIieQX1i6j4K91CL2OmE A4Y9nqhccpLACv1qIC2wC1OoMusPAJf2yBtH/bGQalYqrwYl513/ZQp
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Commit 6b0e82791bd0 ("powerpc/e500: switch to 64 bits PGD on 85xx
(32 bits)") switched PGD entries to 64 bits, but pgd_val() returns
an unsigned long which is 32 bits on PPC32. This is not a problem
for regular PMD entries because the upper part is always NULL, but
when PMD entries are leaf they contain 64 bits values, so pgd_val()
must return an unsigned long long instead of an unsigned long.

Also change the condition to CONFIG_PPC_85xx instead of CONFIG_PPC_E500
as the change was meant for 32 bits only. Allthough this should be
harmless on PPC64, it generates a warning with pgd_ERROR print.

Fixes: 6b0e82791bd0 ("powerpc/e500: switch to 64 bits PGD on 85xx (32 bits)")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Limit it to CONFIG_PPC_85xx and use a cast instead of duplicating pgd_ERROR
---
 arch/powerpc/include/asm/nohash/32/pgtable.h |  4 ++--
 arch/powerpc/include/asm/pgtable-types.h     | 12 +++++++++---
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 9508399dd036..b481738c4bb5 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -52,7 +52,7 @@
 #define USER_PTRS_PER_PGD	(TASK_SIZE / PGDIR_SIZE)
 
 #define pgd_ERROR(e) \
-	pr_err("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
+	pr_err("%s:%d: bad pgd %08llx.\n", __FILE__, __LINE__, (unsigned long long)pgd_val(e))
 
 /*
  * This is the bottom of the PKMAP area with HIGHMEM or an arbitrary
@@ -170,7 +170,7 @@ static inline void pmd_clear(pmd_t *pmdp)
 #define pmd_pfn(pmd)		(pmd_val(pmd) >> PAGE_SHIFT)
 #else
 #define pmd_page_vaddr(pmd)	\
-	((const void *)(pmd_val(pmd) & ~(PTE_TABLE_SIZE - 1)))
+	((const void *)((unsigned long)pmd_val(pmd) & ~(PTE_TABLE_SIZE - 1)))
 #define pmd_pfn(pmd)		(__pa(pmd_val(pmd)) >> PAGE_SHIFT)
 #endif
 
diff --git a/arch/powerpc/include/asm/pgtable-types.h b/arch/powerpc/include/asm/pgtable-types.h
index 7b3d4c592a10..f3086e39e7d2 100644
--- a/arch/powerpc/include/asm/pgtable-types.h
+++ b/arch/powerpc/include/asm/pgtable-types.h
@@ -49,16 +49,22 @@ static inline unsigned long pud_val(pud_t x)
 #endif /* CONFIG_PPC64 */
 
 /* PGD level */
-#if defined(CONFIG_PPC_E500) && defined(CONFIG_PTE_64BIT)
+#if defined(CONFIG_PPC_85xx) && defined(CONFIG_PTE_64BIT)
 typedef struct { unsigned long long pgd; } pgd_t;
+
+static inline unsigned long long pgd_val(pgd_t x)
+{
+	return x.pgd;
+}
 #else
 typedef struct { unsigned long pgd; } pgd_t;
-#endif
-#define __pgd(x)	((pgd_t) { (x) })
+
 static inline unsigned long pgd_val(pgd_t x)
 {
 	return x.pgd;
 }
+#endif
+#define __pgd(x)	((pgd_t) { (x) })
 
 /* Page protection bits */
 typedef struct { unsigned long pgprot; } pgprot_t;
-- 
2.44.0


