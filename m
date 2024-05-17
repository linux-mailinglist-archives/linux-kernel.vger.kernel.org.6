Return-Path: <linux-kernel+bounces-182540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 056758C8C72
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35FF71C23317
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C97E1420A5;
	Fri, 17 May 2024 19:01:13 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E4513E8A9
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715972472; cv=none; b=h/Fbd5qZ9caRrKuIuC7ayCBUyZOsfaazPaQLRlX3eN+bu9z+Jr3Lt1KYgEUgz5tn0IH8HZc7NkxcDlH9vk9kfdE9YadkA9JYa1hQSUYw/okXgNIqNqV0RNvE38i+AtaScLEi2DGF2SlKKnpYyNXZvdGPs+6C4DRI1CLykRUW23s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715972472; c=relaxed/simple;
	bh=IT/tSfyWdCwFAQquhyDiq+kzMKWp84Hw7YMsyU+LWjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ch7ywazH95im50Dmy3LYA+l6zdpSYtr1UaasEqzV8XesM+eC+oiWpG5dZhpC9ndEjgXIka2XUFphFqhwcmC4cNyyEcZSJwNhbEg7kWDGXY6KDqscktmAwNZOpaLgWc7nFOCpl10Y0SZxUUwA5SUPt5NLkm0GJODpv2fUwfi2rRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4Vgx9W5BDZz9tBX;
	Fri, 17 May 2024 21:00:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id APkE2dAeSGeG; Fri, 17 May 2024 21:00:15 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4Vgx9P35mKz9sy4;
	Fri, 17 May 2024 21:00:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 665F98B775;
	Fri, 17 May 2024 21:00:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 1qih5qF9Tb3h; Fri, 17 May 2024 21:00:09 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.121])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DF5778B766;
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
Subject: [RFC PATCH v2 11/20] powerpc/mm: Complement huge_pte_alloc() for all non HUGEPD setups
Date: Fri, 17 May 2024 21:00:05 +0200
Message-ID: <59a1390923c40b0b83ae062e3041873292186577.1715971869.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1715971869.git.christophe.leroy@csgroup.eu>
References: <cover.1715971869.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715972397; l=1444; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=IT/tSfyWdCwFAQquhyDiq+kzMKWp84Hw7YMsyU+LWjk=; b=xeNYo6T9SlQCmQdaVEVuhPSLO92GVMmtdd8ewCjcRyAthyc3B93Izly6FJnXDDAqd3LJCizPr Ho/DtnJbATqBF1PnhrmfagQSJ1vAzdiSBSQ3lX4IQlpG+4gBP9OGJa+
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

huge_pte_alloc() for non-HUGEPD targets is reserved for 8xx at the
moment. In order to convert other targets for non-HUGEPD, complement
huge_pte_alloc() to support any standard cont-PxD setup.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/hugetlbpage.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 42b12e1ec851..f8aefa1e7363 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -195,11 +195,34 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, unsigned long sz)
 {
-	pmd_t *pmd = pmd_off(mm, addr);
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+
+	addr &= ~(sz - 1);
+	pgd = pgd_offset(mm, addr);
+
+	p4d = p4d_offset(pgd, addr);
+	if (sz >= PGDIR_SIZE)
+		return (pte_t *)p4d;
+
+	pud = pud_alloc(mm, p4d, addr);
+	if (!pud)
+		return NULL;
+	if (sz >= PUD_SIZE)
+		return (pte_t *)pud;
+
+	pmd = pmd_alloc(mm, pud, addr);
+	if (!pmd)
+		return NULL;
 
 	if (sz < PMD_SIZE)
 		return pte_alloc_huge(mm, pmd, addr, sz);
 
+	if (!IS_ENABLED(CONFIG_PPC_8xx))
+		return (pte_t *)pmd;
+
 	if (sz != SZ_8M)
 		return NULL;
 	if (!pte_alloc_huge(mm, pmd, addr, sz))
-- 
2.44.0


