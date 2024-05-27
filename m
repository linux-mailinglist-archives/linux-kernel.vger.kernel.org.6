Return-Path: <linux-kernel+bounces-190708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6F78D018D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:32:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879A428A9FA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB1D15FD01;
	Mon, 27 May 2024 13:30:52 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B5A15DBDD
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816652; cv=none; b=YKtKrs7S+aIM1TlZQQpONp5NRWbY+hOG18y26KsQxfXgue1ANSebDcoc0dT6gPagB1RIwYyVTM9RY+5lDxtMvNMtZZeomULoxixiF1BTduZk8VvnSgtjnK44DiD3meBjvyALGH16JgH+z9ZCIm9jSIRsUguwgTvC28HrZiLQosA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816652; c=relaxed/simple;
	bh=D5c7rc2WApQ3tCbzTNEVQ0Gk3Td9OpyCeDWt3oeDJWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LZqrQTVf27aUhRY47OTll1TC7c5fTcpD+8wQWL4iE6nm7o2shqBl6nvq8ePmgYGVYX+flhVVrDkLTlkN+E6ohoega3fpjB69VxZ6U5yajbwzHPBkrVlLlOZR5Cg8MgFUDaPKPK/BMTbtGx5UTjVEUilwdMcZO7LYfbNN7mQ1dC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4VnxNY39myz9syd;
	Mon, 27 May 2024 15:30:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QPpKG3o7xn_a; Mon, 27 May 2024 15:30:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4VnxNY2Zzjz9sqS;
	Mon, 27 May 2024 15:30:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 53AB38B773;
	Mon, 27 May 2024 15:30:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id dnmhP2yQDIxO; Mon, 27 May 2024 15:30:37 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.49])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B08078B764;
	Mon, 27 May 2024 15:30:35 +0200 (CEST)
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
Subject: [RFC PATCH v4 07/16] powerpc/8xx: Fix size given to set_huge_pte_at()
Date: Mon, 27 May 2024 15:30:05 +0200
Message-ID: <75f695241f19fd08ce4f476110b933b7850249d3.1716815901.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1716815901.git.christophe.leroy@csgroup.eu>
References: <cover.1716815901.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716816600; l=967; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=D5c7rc2WApQ3tCbzTNEVQ0Gk3Td9OpyCeDWt3oeDJWA=; b=wqFHcjPXA+RmKeGLWUXQ7d01EPFwdwnDrXyqFosPd+EELJOAwUJ3KBbQ7UPPIOF5o8fX2QyDs d5FVrFEhD65AbwWAkEOgTVWQtleIBSW0PmXTmX8yM/GA1KsMvHg8MVO
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

set_huge_pte_at() expects the size of the hugepage as an int, not the
psize which is the index of the page definition in table mmu_psize_defs[]

Fixes: 935d4f0c6dc8 ("mm: hugetlb: add huge page size param to set_huge_pte_at()")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 arch/powerpc/mm/nohash/8xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
index 43d4842bb1c7..d93433e26ded 100644
--- a/arch/powerpc/mm/nohash/8xx.c
+++ b/arch/powerpc/mm/nohash/8xx.c
@@ -94,7 +94,8 @@ static int __ref __early_map_kernel_hugepage(unsigned long va, phys_addr_t pa,
 		return -EINVAL;
 
 	set_huge_pte_at(&init_mm, va, ptep,
-			pte_mkhuge(pfn_pte(pa >> PAGE_SHIFT, prot)), psize);
+			pte_mkhuge(pfn_pte(pa >> PAGE_SHIFT, prot)),
+			1UL << mmu_psize_to_shift(psize));
 
 	return 0;
 }
-- 
2.44.0


