Return-Path: <linux-kernel+bounces-190703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A74248D0186
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C7212868BC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865F515F3EB;
	Mon, 27 May 2024 13:30:31 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B8A15EFBC
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816631; cv=none; b=AMniTkf7gDyr6T0J+QpmUt6zfYmabTSs5+sCZE5VotDq83aekgcOa2Wvq/hEc2KM98S1njD3MXL7HmewZbTd//is9yYDYinhIg1RbzrNoMnKq2qoY+FdfPzI4Kq8TQcARDZdWP6bdNA5gvsvfX74iThFqff/qTWWk60a7WKwwwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816631; c=relaxed/simple;
	bh=UzfhNq5PmSTEAt037maHDDYdpiu9u0KQG11+Ji9a3Ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iAmPPnU6I+draWE3MVDthTVZCzqD9fBxN9OrDglLBq7nmsboOjkwgRIsqBuh/HPtv7/cKIEmfJwQVAS4gMP7JIS7TGmUlMLAnQFHzSUUGAW2Ce6/T6FbON0s0NBYa85BV4WMNU4msUx+dEDz4b33qU3sA7Zmg9LJssJZt+NnzO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4VnxNH3X8Nz9syd;
	Mon, 27 May 2024 15:30:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lK-Qu1YbbiXB; Mon, 27 May 2024 15:30:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4VnxNH2tB8z9sqS;
	Mon, 27 May 2024 15:30:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 5D3D88B773;
	Mon, 27 May 2024 15:30:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id hmmxoWXQmTJi; Mon, 27 May 2024 15:30:23 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.49])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A92238B764;
	Mon, 27 May 2024 15:30:19 +0200 (CEST)
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
Subject: [RFC PATCH v4 02/16] mm: Define __pte_leaf_size() to also take a PMD entry
Date: Mon, 27 May 2024 15:30:00 +0200
Message-ID: <c5b20513c335fda52c9ebbd813c4ed2f221ace30.1716815901.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1716815901.git.christophe.leroy@csgroup.eu>
References: <cover.1716815901.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716816600; l=1803; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=UzfhNq5PmSTEAt037maHDDYdpiu9u0KQG11+Ji9a3Ko=; b=QTMHKiCYoXWonuyH5nH6U6kLDwMLXHwSww1cSyPU33riwsvrJQGt9NlFB1qDR9YbUHKo9aZhD LWoqX2Vka/mAIu3z8TYAq2rQ45aYu14RwGhgdDeAjsMt9EKpC5bwNit
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
index f0128c5ff278..880df84ce07c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7596,7 +7596,7 @@ static u64 perf_get_pgtable_size(struct mm_struct *mm, unsigned long addr)
 
 	pte = ptep_get_lockless(ptep);
 	if (pte_present(pte))
-		size = pte_leaf_size(pte);
+		size = __pte_leaf_size(pmd, pte);
 	pte_unmap(ptep);
 #endif /* CONFIG_HAVE_GUP_FAST */
 
-- 
2.44.0


