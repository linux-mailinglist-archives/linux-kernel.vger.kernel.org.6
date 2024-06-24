Return-Path: <linux-kernel+bounces-227408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1995C9150D0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C4FA1C239CE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0818D19FA8F;
	Mon, 24 Jun 2024 14:47:18 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED31C19FA70
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240437; cv=none; b=A/OnsGOuAy7HM+LBNTiqQVYyV9Jmx3h8ejUHH5dKr4WzqtfkFXH50Xe2rYe/BnjUgBsPfzPK4gjT6tyOJ4kF5Cv6ZR5ViRfqg8veph5VIv6RjqPgeB8VRe5oKHLvcODUU3accs8tIo3bxBWa5IP8quOHkj4Wj23pf+PC5p+jPGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240437; c=relaxed/simple;
	bh=CWlk/wMDjpU6vF1ScRB8cosnmevy/J5Gz15W8u/6MPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8WOPTN1P6kk1ywmPuLuBGJKxCFKMgUT4EFIktktBCneAdVzcj8MOpTKecIQdIk+vKCi6PKNyhnt0YAYFO1uKD/0mskByJMUsdI1tc1AIhbCH/v8M/Ygt/XsW2e5qC6+ljNiM1x58j4/XWlnMdVdHah5/jDs2gvu7cHz5GCzLrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4W79kn0kLlz9vGD;
	Mon, 24 Jun 2024 16:46:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U1fcgMW5sVgy; Mon, 24 Jun 2024 16:46:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4W79kh2qRPz9vDm;
	Mon, 24 Jun 2024 16:46:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5BAC68B76D;
	Mon, 24 Jun 2024 16:46:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id hFDsl1EDVmHi; Mon, 24 Jun 2024 16:46:04 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.33])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 925798B766;
	Mon, 24 Jun 2024 16:46:03 +0200 (CEST)
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
Subject: [PATCH v6 10/23] powerpc/mm: Fix __find_linux_pte() on 32 bits with PMD leaf entries
Date: Mon, 24 Jun 2024 16:45:36 +0200
Message-ID: <a3f6c8b4d68a7a81e52009d11eff2ccbd6225c00.1719240269.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1719240269.git.christophe.leroy@csgroup.eu>
References: <cover.1719240269.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719240334; l=5393; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=CWlk/wMDjpU6vF1ScRB8cosnmevy/J5Gz15W8u/6MPI=; b=iyM+xiUQDRf/JpRC3SsOLdMp3/Rsgrpzfp+ZcvBBScJXQv4LKFMrFDKlwbEKbo4ZaGXJe/b49 /D7ScX1ZNXlDtI5KzM+09OQgIxemuIWjReVUtA7qnp5yzvwYdulRmjh
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

Behind fixing the problem, it also has the advantage of simplifying
__find_linux_pte() including the removal of stack frame:

After this patch:

	00000018 <__find_linux_pte>:
	  18:	2c 06 00 00 	cmpwi   r6,0
	  1c:	41 82 00 0c 	beq     28 <__find_linux_pte+0x10>
	  20:	39 20 00 00 	li      r9,0
	  24:	91 26 00 00 	stw     r9,0(r6)
	  28:	2f 85 00 00 	cmpwi   cr7,r5,0
	  2c:	41 9e 00 0c 	beq     cr7,38 <__find_linux_pte+0x20>
	  30:	39 20 00 00 	li      r9,0
	  34:	99 25 00 00 	stb     r9,0(r5)
	  38:	54 89 65 3a 	rlwinm  r9,r4,12,20,29
	  3c:	7c 63 48 2e 	lwzx    r3,r3,r9
	  40:	2f 83 00 00 	cmpwi   cr7,r3,0
	  44:	41 9e 00 30 	beq     cr7,74 <__find_linux_pte+0x5c>
	  48:	54 69 07 3a 	rlwinm  r9,r3,0,28,29
	  4c:	2f 89 00 0c 	cmpwi   cr7,r9,12
	  50:	54 63 00 26 	clrrwi  r3,r3,12
	  54:	54 84 b5 36 	rlwinm  r4,r4,22,20,27
	  58:	3c 63 c0 00 	addis   r3,r3,-16384
	  5c:	7c 63 22 14 	add     r3,r3,r4
	  60:	4c be 00 20 	bnelr+  cr7
	  64:	4d 82 00 20 	beqlr
	  68:	39 20 00 17 	li      r9,23
	  6c:	91 26 00 00 	stw     r9,0(r6)
	  70:	4e 80 00 20 	blr
	  74:	38 60 00 00 	li      r3,0
	  78:	4e 80 00 20 	blr

Before this patch:

	00000018 <__find_linux_pte>:
	  18:	2c 06 00 00 	cmpwi   r6,0
	  1c:	94 21 ff e0 	stwu    r1,-32(r1)
	  20:	41 82 00 0c 	beq     2c <__find_linux_pte+0x14>
	  24:	39 20 00 00 	li      r9,0
	  28:	91 26 00 00 	stw     r9,0(r6)
	  2c:	2f 85 00 00 	cmpwi   cr7,r5,0
	  30:	41 9e 00 0c 	beq     cr7,3c <__find_linux_pte+0x24>
	  34:	39 20 00 00 	li      r9,0
	  38:	99 25 00 00 	stb     r9,0(r5)
	  3c:	54 89 65 3a 	rlwinm  r9,r4,12,20,29
	  40:	7c 63 48 2e 	lwzx    r3,r3,r9
	  44:	54 69 07 3a 	rlwinm  r9,r3,0,28,29
	  48:	2f 89 00 0c 	cmpwi   cr7,r9,12
	  4c:	90 61 00 0c 	stw     r3,12(r1)
	  50:	41 9e 00 4c 	beq     cr7,9c <__find_linux_pte+0x84>
	  54:	80 61 00 0c 	lwz     r3,12(r1)
	  58:	54 69 07 3a 	rlwinm  r9,r3,0,28,29
	  5c:	2f 89 00 0c 	cmpwi   cr7,r9,12
	  60:	90 61 00 08 	stw     r3,8(r1)
	  64:	41 9e 00 38 	beq     cr7,9c <__find_linux_pte+0x84>
	  68:	80 61 00 08 	lwz     r3,8(r1)
	  6c:	2f 83 00 00 	cmpwi   cr7,r3,0
	  70:	41 9e 00 54 	beq     cr7,c4 <__find_linux_pte+0xac>
	  74:	54 69 07 3a 	rlwinm  r9,r3,0,28,29
	  78:	2f 89 00 0c 	cmpwi   cr7,r9,12
	  7c:	54 69 00 26 	clrrwi  r9,r3,12
	  80:	54 8a b5 36 	rlwinm  r10,r4,22,20,27
	  84:	3c 69 c0 00 	addis   r3,r9,-16384
	  88:	7c 63 52 14 	add     r3,r3,r10
	  8c:	54 84 93 be 	srwi    r4,r4,14
	  90:	41 9e 00 14 	beq     cr7,a4 <__find_linux_pte+0x8c>
	  94:	38 21 00 20 	addi    r1,r1,32
	  98:	4e 80 00 20 	blr
	  9c:	54 69 00 26 	clrrwi  r9,r3,12
	  a0:	54 84 93 be 	srwi    r4,r4,14
	  a4:	3c 69 c0 00 	addis   r3,r9,-16384
	  a8:	54 84 25 36 	rlwinm  r4,r4,4,20,27
	  ac:	7c 63 22 14 	add     r3,r3,r4
	  b0:	41 a2 ff e4 	beq     94 <__find_linux_pte+0x7c>
	  b4:	39 20 00 17 	li      r9,23
	  b8:	91 26 00 00 	stw     r9,0(r6)
	  bc:	38 21 00 20 	addi    r1,r1,32
	  c0:	4e 80 00 20 	blr
	  c4:	38 60 00 00 	li      r3,0
	  c8:	38 21 00 20 	addi    r1,r1,32
	  cc:	4e 80 00 20 	blr

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
v3: Removed p4dp and pudp locals for PPC32 and add a comment.
v4: Properly set pdshift on PPC32 case
v5: Enhanced commit message
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


