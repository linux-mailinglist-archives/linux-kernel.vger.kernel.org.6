Return-Path: <linux-kernel+bounces-182539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 067F98C8C70
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37EF21C230D6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D6A13F00F;
	Fri, 17 May 2024 19:01:09 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8361213E8A9
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 19:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715972469; cv=none; b=oqEe+3BD34W0+K0+satWr8RWfF5xkQ5sHwe89XT3G9uBbCaCJjDguLaUEGlSc/HYDDWZKWvtiTzSip/4Sb7+3TsULER3RDWPXdqFiF+AWooyGyT5r4setAZxWccFVN+wCah1M2NXSgnsfUNiVWdldS5rtDhdNRQbdnyhATx5PSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715972469; c=relaxed/simple;
	bh=kVzvPEvnbNpLZgrsFncGoYKqpWB/WmWN/OrrU/zv3+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPRsfs3l9xfsrSjhhW+/O4e4TwYAH9X1KxgfST2yUwVd/4M9KYPST7JmX6YLBFqK5AhK55ahC7885lof1mDzrPHjOA3xufsvIAmmMV8wqAO+KXSS+6sFmv2RfU4VC5CFKVVrDSutg1LVFYHk0BWRnCyEHSfNe6R2g+JChFaiYos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4Vgx9V19jLz9t9W;
	Fri, 17 May 2024 21:00:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id eKTUd7JkpiBX; Fri, 17 May 2024 21:00:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4Vgx9N6CJPz9sx4;
	Fri, 17 May 2024 21:00:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D0D6A8B775;
	Fri, 17 May 2024 21:00:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 7lIzL2huhLzn; Fri, 17 May 2024 21:00:08 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.121])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 57D4D8B766;
	Fri, 17 May 2024 21:00:08 +0200 (CEST)
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
Subject: [RFC PATCH v2 10/20] powerpc/mm: Fix __find_linux_pte() on 32 bits with PMD leaf entries
Date: Fri, 17 May 2024 21:00:04 +0200
Message-ID: <41bf05806501c0091a7d52e118b187416d24a76f.1715971869.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1715971869.git.christophe.leroy@csgroup.eu>
References: <cover.1715971869.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715972396; l=1880; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=kVzvPEvnbNpLZgrsFncGoYKqpWB/WmWN/OrrU/zv3+M=; b=DrH60uKcoJ3TUqUVGJIHzeRTo/QEhq0NbZwQuSmTPJNyu+FPGl+QcTNq8333LXYou56YwLHFh MrWGMpoXWbAAPQ7XmRGjg4SFszqdGu3pTjfeZJ8t6mKltezMEOFfrbG
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Building on 32 bits with pmd_leaf() not returning always false leads
to the following error:

  CC      arch/powerpc/mm/pgtable.o
arch/powerpc/mm/pgtable.c: In function '__find_linux_pte':
arch/powerpc/mm/pgtable.c:506:1: error: function may return address of local variable [-Werror=return-local-addr]
  506 | }
      | ^
arch/powerpc/mm/pgtable.c:394:15: note: declared here
  394 |         pud_t pud, *pudp;
      |               ^~~
arch/powerpc/mm/pgtable.c:394:15: note: declared here

This is due to pmd_offset() being a no-op in that case.

So rework it for powerpc/32 so that pXd_offset() are used on real
pointers and not on on-stack copies.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/pgtable.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 59f0d7706d2f..51ee508eeb5b 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -390,8 +390,12 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
 			bool *is_thp, unsigned *hpage_shift)
 {
 	pgd_t *pgdp;
-	p4d_t p4d, *p4dp;
-	pud_t pud, *pudp;
+	p4d_t *p4dp;
+	pud_t *pudp;
+#ifdef CONFIG_PPC64
+	p4d_t p4d;
+	pud_t pud;
+#endif
 	pmd_t pmd, *pmdp;
 	pte_t *ret_pte;
 	hugepd_t *hpdp = NULL;
@@ -412,6 +416,7 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
 	 */
 	pgdp = pgdir + pgd_index(ea);
 	p4dp = p4d_offset(pgdp, ea);
+#ifdef CONFIG_PPC64
 	p4d  = READ_ONCE(*p4dp);
 	pdshift = P4D_SHIFT;
 
@@ -452,6 +457,11 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
 
 	pdshift = PMD_SHIFT;
 	pmdp = pmd_offset(&pud, ea);
+#else
+	p4dp = p4d_offset(pgdp, ea);
+	pudp = pud_offset(p4dp, ea);
+	pmdp = pmd_offset(pudp, ea);
+#endif
 	pmd  = READ_ONCE(*pmdp);
 
 	/*
-- 
2.44.0


