Return-Path: <linux-kernel+bounces-237891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A619923F8B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E954A283A09
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B861BA86D;
	Tue,  2 Jul 2024 13:52:06 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A051BA86C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719928326; cv=none; b=n/rTDQ4CNxH5Wc2YjK1sRrpj77aeQfMiO3NZOtFIAvUGCUqA8hx2k/K7DcXIRRF9SlGGPO9HeGLcUTabFYwa6wkR751dkNZQiYhinNZjVWxfQUpF4KLroC0lSIq/5BD54dmjyzSTLAGcEJ9LWKfKS8E9agVpghVtUsVefLT4hJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719928326; c=relaxed/simple;
	bh=NqqR+DBf4uYbt5gP7om6e3QFNLkHAAKdU42xGKHVcEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E14frMbxqhXPDO+9vvOFrFhcMVhjhX+Ar+pVuOkM5uWLRKjCqlOWL2+Fk4Bgm0T4iiMcV1iSnyElnCV0otUnteMqNWFWvPTzy8rSBsoMYHiKbhruib+lHM4d9eQ3KSuLFBlKQxvOStmb/uEWQlBYmEOZzIslWWangiBgW7SlRAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4WD4841fp7z9v6W;
	Tue,  2 Jul 2024 15:51:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C9od68sRy3VN; Tue,  2 Jul 2024 15:51:32 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4WD4805RNyz9v4J;
	Tue,  2 Jul 2024 15:51:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B678D8B774;
	Tue,  2 Jul 2024 15:51:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id BGNhRIrkHoLm; Tue,  2 Jul 2024 15:51:28 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.12])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 4106F8B764;
	Tue,  2 Jul 2024 15:51:28 +0200 (CEST)
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
Subject: [PATCH v7 07/23] mm: Define __pte_leaf_size() to also take a PMD entry
Date: Tue,  2 Jul 2024 15:51:19 +0200
Message-ID: <c7c008f0a314bf8029ad7288fdc908db1ec7e449.1719928057.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1719928057.git.christophe.leroy@csgroup.eu>
References: <cover.1719928057.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719928274; l=1803; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=NqqR+DBf4uYbt5gP7om6e3QFNLkHAAKdU42xGKHVcEo=; b=yV33hLP9H4xcUhyFxDXIt5LnxJgWqrCn1V5Xykpxq478yOcZTAZhwgAiteylu27VRD9Xbv6er iD0lsuBP5qqBVXJsr9LvPuLb4J+Nh0P8vxx5LpDXoG49QzJ3MzMfoS4
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
index 2f32eaccf0b9..2a6a3cccfc36 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1907,9 +1907,12 @@ typedef unsigned int pgtbl_mod_mask;
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


