Return-Path: <linux-kernel+bounces-227405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B189150CB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A60B71C2358A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF62619CD12;
	Mon, 24 Jun 2024 14:46:54 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB9919B59D
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240414; cv=none; b=iI8188I0ZefnJpq/0f7gYN50g98s+nIalJNfYRJlL9SNJnl4LDt466D30wZ4hicrTEqCPbYop4gguO/5+FBaVOVqBIbjHyu7F7YKOzau5VavsFUPpNHAz0y+P1N5MRPEZTZKZUW6MdHxyn1iYDUg1lv+5dpJcHiHmX5QTIoZwM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240414; c=relaxed/simple;
	bh=ApxdfzE7YD3L0IuoDaV5UxphNVd36HJ10PPOy4i4Q1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=turKv0dUsejKU1rTandtlUVLI3JxDtg+VwnYNXG7twIXnCFhfQepe+EJNm2+vKG7+6DX9sZy3co1z7StHMRcsc8/W6/fK2BoKmkVpjrkGg6a3304SWgyxcs7dEzSWuzssOVTXsRE6F5S2qti/a/+Xgx7+KeohiXgQue4/8lXsxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4W79kk1DQ3z9vFt;
	Mon, 24 Jun 2024 16:46:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RNZLCqwLMOhj; Mon, 24 Jun 2024 16:46:06 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4W79kf30CPz9vFR;
	Mon, 24 Jun 2024 16:46:02 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 60E048B766;
	Mon, 24 Jun 2024 16:46:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id BYiPVjqr0x0I; Mon, 24 Jun 2024 16:46:02 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.33])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id DD71C8B763;
	Mon, 24 Jun 2024 16:46:01 +0200 (CEST)
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
Subject: [PATCH v6 07/23] mm: Define __pte_leaf_size() to also take a PMD entry
Date: Mon, 24 Jun 2024 16:45:33 +0200
Message-ID: <cdb33de3c4124e2f6c46360f10a3623e0e31fdc6.1719240269.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1719240269.git.christophe.leroy@csgroup.eu>
References: <cover.1719240269.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719240333; l=1803; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=ApxdfzE7YD3L0IuoDaV5UxphNVd36HJ10PPOy4i4Q1E=; b=1v+yyodsHwTDtnfuXp4KYWw6pFDlQLxE6onELG4gmqQFzzC3JFznfnCZIj1YRQX5maLeosEdw aX+0l4dc5DyCrQ40QfdOuwE/SbzAUjyU7xAx4ONIHh8xK0XQvMR6nQq
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

On powerpc 8xx, when a page is 8M size, the information is in the PMD
entry. So allow architectures to provide __pte_leaf_size() instead of
pte_leaf_size() and provide the PMD entry to that function.

When __pte_leaf_size() is not defined, define it as a pte_leaf_size()
so that architectures not interested in the PMD arguments are not
impacted.

Only define a default pte_leaf_size() when __pte_leaf_size() is not
defined to make sure nobody adds new calls to pte_leaf_size() in the
core.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
v3: Don't change pte_leaf_size() to not impact other architectures
---
 include/linux/pgtable.h | 3 +++
 kernel/events/core.c    | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 18019f037bae..3080e7cde3de 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1888,9 +1888,12 @@ typedef unsigned int pgtbl_mod_mask;
 #ifndef pmd_leaf_size
 #define pmd_leaf_size(x) PMD_SIZE
 #endif
+#ifndef __pte_leaf_size
 #ifndef pte_leaf_size
 #define pte_leaf_size(x) PAGE_SIZE
 #endif
+#define __pte_leaf_size(x,y) pte_leaf_size(y)
+#endif
 
 /*
  * We always define pmd_pfn for all archs as it's used in lots of generic
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 8f908f077935..b2ca11bdc11e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7609,7 +7609,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 
 	pte = ptep_get_lockless(ptep);
 	if (pte_present(pte))
-		size = pte_leaf_size(pte);
+		size = __pte_leaf_size(pmd, pte);
 	pte_unmap(ptep);
 #endif /* CONFIG_HAVE_GUP_FAST */
 
-- 
2.44.0


