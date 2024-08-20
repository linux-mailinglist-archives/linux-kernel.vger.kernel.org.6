Return-Path: <linux-kernel+bounces-293988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7384B958741
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 14:44:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A675A1C21BA7
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 12:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0027118FDC4;
	Tue, 20 Aug 2024 12:44:20 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FD218FDA6
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 12:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724157859; cv=none; b=Gdm7je28c3ZAfRnCmQy47DQI9iTVOnCpVbYF7ZgWzyNh3odhH0S0t+oADtws2fBBZdFBfUAUnHMxedpJe2ZVOt/m2oWanPkabIB3/oRKBodRpAF3+QxVv25voAsQRLbq0XumEDMTQI0grqPc3vooTdwpxb76dePUerUSYSDdk4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724157859; c=relaxed/simple;
	bh=m52sHTDgGBO2+3moWYY9Rl4SZkmY12uKXz05B5wBYyc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e1FLD4KxvWG2jlQkmeRXi2SMFU13T8rWX0WPJUaGn35kNabntQOKxqJqavuVjLLccpcqJZAIoEtMa9Hb0w/SfO5YTa9iZRnUuVZ7oHqxCxn8rvCHpJJvGyO2/jbPy7fPNHq/8XEqOOvDE8frJVv5IY3nTlV82nqnbKVyzyu6p+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4Wp8Kr126kz9sSK;
	Tue, 20 Aug 2024 14:44:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cTnjbpOaup9M; Tue, 20 Aug 2024 14:44:16 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4Wp8Kr0DbSz9sSH;
	Tue, 20 Aug 2024 14:44:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id EBC268B778;
	Tue, 20 Aug 2024 14:44:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 47-SWhMf7znx; Tue, 20 Aug 2024 14:44:15 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.72])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 952AA8B763;
	Tue, 20 Aug 2024 14:44:15 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/mm: Fix return type of pgd_val()
Date: Tue, 20 Aug 2024 14:44:14 +0200
Message-ID: <c24efad37454ae48eebe79b7da10a3a4770b966a.1724157845.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724157854; l=2593; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=m52sHTDgGBO2+3moWYY9Rl4SZkmY12uKXz05B5wBYyc=; b=lVdAXBHvK0jly/dYpeXwmQWif2JJPAJHpabSO9nd3T2+wd7yLh5uuBiMy+4YknnS9GifHMJy9 4zE0zZs45W0B2xAaiTu8ZIqmivnGehjWQCMJ2kEXbvk0BLQPnEAhu9K
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Commit 6b0e82791bd0 ("powerpc/e500: switch to 64 bits PGD on 85xx
(32 bits)") switched PGD entries to 64 bits, but pgd_val() returns
an unsigned long which is 32 bits on PPC32. This is not a problem
for regular PMD entries because the upper part is always NULL, but
when PMD entries are leaf they contain 64 bits values, so pgd_val()
must return an unsigned long long instead of an unsigned long.

Fixes: 6b0e82791bd0 ("powerpc/e500: switch to 64 bits PGD on 85xx (32 bits)")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/nohash/32/pgtable.h |  7 ++++++-
 arch/powerpc/include/asm/pgtable-types.h     | 10 ++++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/pgtable.h b/arch/powerpc/include/asm/nohash/32/pgtable.h
index 9508399dd036..e2935a16ce1e 100644
--- a/arch/powerpc/include/asm/nohash/32/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/32/pgtable.h
@@ -51,8 +51,13 @@
 
 #define USER_PTRS_PER_PGD	(TASK_SIZE / PGDIR_SIZE)
 
+#if defined(CONFIG_PPC_E500) && defined(CONFIG_PTE_64BIT)
+#define pgd_ERROR(e) \
+	pr_err("%s:%d: bad pgd %08llx.\n", __FILE__, __LINE__, pgd_val(e))
+#else
 #define pgd_ERROR(e) \
 	pr_err("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
+#endif
 
 /*
  * This is the bottom of the PKMAP area with HIGHMEM or an arbitrary
@@ -170,7 +175,7 @@ static inline void pmd_clear(pmd_t *pmdp)
 #define pmd_pfn(pmd)		(pmd_val(pmd) >> PAGE_SHIFT)
 #else
 #define pmd_page_vaddr(pmd)	\
-	((const void *)(pmd_val(pmd) & ~(PTE_TABLE_SIZE - 1)))
+	((const void *)((unsigned long)pmd_val(pmd) & ~(PTE_TABLE_SIZE - 1)))
 #define pmd_pfn(pmd)		(__pa(pmd_val(pmd)) >> PAGE_SHIFT)
 #endif
 
diff --git a/arch/powerpc/include/asm/pgtable-types.h b/arch/powerpc/include/asm/pgtable-types.h
index 7b3d4c592a10..ab49642b7c37 100644
--- a/arch/powerpc/include/asm/pgtable-types.h
+++ b/arch/powerpc/include/asm/pgtable-types.h
@@ -51,14 +51,20 @@ static inline unsigned long pud_val(pud_t x)
 /* PGD level */
 #if defined(CONFIG_PPC_E500) && defined(CONFIG_PTE_64BIT)
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


