Return-Path: <linux-kernel+bounces-189628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4538CF307
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 11:24:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14D9CB223F4
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 09:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FB9C127;
	Sun, 26 May 2024 09:23:08 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05463B676
	for <linux-kernel@vger.kernel.org>; Sun, 26 May 2024 09:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716715388; cv=none; b=V3NzG9+wmQAfZ6qeDTbu/I1lGFgPKnsA+Jpm7kxv8oxPQOqvh/bLg8zECrAAgAlps40tsBrccXxnisSW9sux7jYj0EpinuaUwArKPOIr2sEKS7HJyRKhbdSR1tmuGm/XZerb14F6SvGrYZhUxoxngc5i/PTj8sWctqc3JSUxED0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716715388; c=relaxed/simple;
	bh=14PrrCB4a2+6ypzEPLZ322xfrxYIQM2wn25R6xSXiBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXOG/KWREw/zMW7EYh5OTqthFKX6RfRZC8uHfZJXYOPm8RS5MqSLd1H9Pgjb2xJgvXEPmMmcomr8pJ5ry/ctZP48n1k6vqkMuUWPjaWhksP2iHhmknVqfl+LCaapB0w2rQpPKXtUO2FlJjLcqb5RWEujwhrNsUqagZGYe/6Miu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4VnCwp15LKz9tHZ;
	Sun, 26 May 2024 11:22:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5IAzddTqHSYF; Sun, 26 May 2024 11:22:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4VnCwl4wkhz9tBX;
	Sun, 26 May 2024 11:22:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A4FBA8B773;
	Sun, 26 May 2024 11:22:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id dWG07mPUpMKP; Sun, 26 May 2024 11:22:31 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.45])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1ED728B764;
	Sun, 26 May 2024 11:22:31 +0200 (CEST)
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
Subject: [RFC PATCH v3 07/16] powerpc/8xx: Fix size given to set_huge_pte_at()
Date: Sun, 26 May 2024 11:22:27 +0200
Message-ID: <c459a02141c4e24b204ef76c489a63ce67c9dbbb.1716714720.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1716714720.git.christophe.leroy@csgroup.eu>
References: <cover.1716714720.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716715343; l=918; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=14PrrCB4a2+6ypzEPLZ322xfrxYIQM2wn25R6xSXiBc=; b=kh3InX9YmF8QGKkVD+/iQqWsCuqq++5G9Oj7yTov8O3ch02WakowGYR43f60T/f6D84b5MmL9 Tx7lAM8OA6JDl3NxC3B56kpleXsSPn+lLcBmy5cbjgpxZ/bF/s/qa11
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

set_huge_pte_at() expects the size of the hugepage as an int, not the
psize which is the index of the page definition in table mmu_psize_defs[]

Fixes: 935d4f0c6dc8 ("mm: hugetlb: add huge page size param to set_huge_pte_at()")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
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


