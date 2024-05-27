Return-Path: <linux-kernel+bounces-190706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833D28D018B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:32:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E47A28C403
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9E915FA86;
	Mon, 27 May 2024 13:30:45 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED3F15DBDD
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816644; cv=none; b=t3Hb0xGIpAckcThRnEt9nzBFIrHAX1ByhavPQaPa+KgvebH3sQD3H3TOr/YaHJRDFr1eybU4Kj4cpWcGaUiQ/TleRLArOQ9N2+zkal8Jci9IU6N/ibwfsrPA9Mf2efrxjRMk9dkBkNIXRJ7EL2+QcT7WUaHCGxumGB6xozT6ajg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816644; c=relaxed/simple;
	bh=CgsurgT/HBdZ/v9IT1Gnjjxrc//xCkwC6Uo2ZbsMc0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iUNLRw0MaD2RqNab3MD+ypFniy+DlrIkT7LsSVsFgchuI7qtb2cSqiclUmU0IrLMmMcCwojTzuLpKxytSNgxPQh3WFbY7ljkbLqzQu77IvPB+PLyqq5T9guIUnEUAbkwIA/8CWX8HWaDG0negucAH3r9X+P4P+vM5HufeJFSSyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4VnxNT6zt4z9tCl;
	Mon, 27 May 2024 15:30:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mnRJFRISjg-U; Mon, 27 May 2024 15:30:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4VnxNT69BJz9sqS;
	Mon, 27 May 2024 15:30:33 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CED8E8B773;
	Mon, 27 May 2024 15:30:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id nNWVwUBAoKxI; Mon, 27 May 2024 15:30:33 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.49])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4EAC88B764;
	Mon, 27 May 2024 15:30:32 +0200 (CEST)
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
Subject: [RFC PATCH v4 05/16] powerpc/mm: Fix __find_linux_pte() on 32 bits with PMD leaf entries
Date: Mon, 27 May 2024 15:30:03 +0200
Message-ID: <d27becf9f8d9bbe6d89bd9aca7fdd2fbc6c39080.1716815901.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1716815901.git.christophe.leroy@csgroup.eu>
References: <cover.1716815901.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716816600; l=2268; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=CgsurgT/HBdZ/v9IT1Gnjjxrc//xCkwC6Uo2ZbsMc0U=; b=IfJ51RBuoaijjVJUpXSYAenvJ2xeDUJnOsadh4SsDBYVzR3VhIS7lTxdFZA6qrF8yyk96WhQi Uy+dEMH3SUzA4HGrpgq60Nk62vjH7QKtycWTD5UA/ytzt+kydidbAMU
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
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
v3: Removed p4dp and pudp locals for PPC32 and add a comment.
v4: Properly set pdshift on PPC32 case
---
 arch/powerpc/mm/pgtable.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index 9e7ba9c3851f..bce8a8619589 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -382,8 +382,10 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
 			bool *is_thp, unsigned *hpage_shift)
 {
 	pgd_t *pgdp;
+#ifdef CONFIG_PPC64
 	p4d_t p4d, *p4dp;
 	pud_t pud, *pudp;
+#endif
 	pmd_t pmd, *pmdp;
 	pte_t *ret_pte;
 	hugepd_t *hpdp = NULL;
@@ -401,8 +403,12 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
 	 * page fault or a page unmap. The return pte_t * is still not
 	 * stable. So should be checked there for above conditions.
 	 * Top level is an exception because it is folded into p4d.
+	 *
+	 * On PPC32, P4D/PUD/PMD are folded into PGD so go straight to
+	 * PMD level.
 	 */
 	pgdp = pgdir + pgd_index(ea);
+#ifdef CONFIG_PPC64
 	p4dp = p4d_offset(pgdp, ea);
 	p4d  = READ_ONCE(*p4dp);
 	pdshift = P4D_SHIFT;
@@ -442,8 +448,11 @@ pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
 		goto out_huge;
 	}
 
-	pdshift = PMD_SHIFT;
 	pmdp = pmd_offset(&pud, ea);
+#else
+	pmdp = pmd_offset(pud_offset(p4d_offset(pgdp, ea), ea), ea);
+#endif
+	pdshift = PMD_SHIFT;
 	pmd  = READ_ONCE(*pmdp);
 
 	/*
-- 
2.44.0


