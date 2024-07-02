Return-Path: <linux-kernel+bounces-237887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67724923F87
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 15:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07C1DB2309D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88B01BA065;
	Tue,  2 Jul 2024 13:51:49 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A211B5838
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719928309; cv=none; b=LiYx1L9OqlPDkDb9+tTa+fjEljrj3iuHxEd/1zexa1MHxuWyXgwCslAPI/oM47h/pbXRHCxi2HQeu9oeAHQWXlWQC4vX89XheANct6/4Qn3Z5a1pVM50OiyFjRPzdmB2oFMkM2/4wuJuoa3vj+f74TNsYB3d3cGLgATi/FHh3iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719928309; c=relaxed/simple;
	bh=qXbozt1kGgrHLvcmvKqTNqOnlgbhOCUMEjOjKB27jaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tqNN9xRsxDGj7Oq1Mam43LgFgFP+VCQtCBo308b6mBN/+SJOzY/8LLK+iL9wP2EsOFdjZUbnrbvniMyfzQbHIrSd/Y80V2M4jfDrmpk75nQPjSmgFyDmwXqowftYC0uFMGFNfo3/3EUjh5j1dothCGfPCkejqqvOWZXVXzwfCTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4WD4801J1Zz9v4H;
	Tue,  2 Jul 2024 15:51:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FQWF2oZxyNDX; Tue,  2 Jul 2024 15:51:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4WD47y5PTYz9tZl;
	Tue,  2 Jul 2024 15:51:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B4B878B774;
	Tue,  2 Jul 2024 15:51:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Fl5X96vf0VcP; Tue,  2 Jul 2024 15:51:26 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.12])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2C3A78B775;
	Tue,  2 Jul 2024 15:51:26 +0200 (CEST)
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
Subject: [PATCH v7 03/23] powerpc/64e: Drop E500 ifdefs in 64-bit code
Date: Tue,  2 Jul 2024 15:51:15 +0200
Message-ID: <7fb88809c88a1b774063eda602a9333079403f83.1719928057.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1719928057.git.christophe.leroy@csgroup.eu>
References: <cover.1719928057.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719928274; l=3405; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=A/9Ib78BLDVf4ZZ6WCRXnSh8JY4Xq2JsVQD062iffmM=; b=g9oCLvuqYm4sq/y4JjtDVo3V9hIsS7weLayXFdlnj+TrEWskwNYdes3hLWc80t0ePYH+p9ExO LGaYGNYQoajApTZiUVIq8OcpmyIAgR+cOjb67IdwEgpXqmtVIndKL3t
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

From: Michael Ellerman <mpe@ellerman.id.au>

All 64-bit Book3E have E500=y, so drop the unneeded ifdefs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/nohash/tlb_64e.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/powerpc/mm/nohash/tlb_64e.c b/arch/powerpc/mm/nohash/tlb_64e.c
index 7d5506d23eab..9db85ee9ba5b 100644
--- a/arch/powerpc/mm/nohash/tlb_64e.c
+++ b/arch/powerpc/mm/nohash/tlb_64e.c
@@ -85,7 +85,6 @@ static void __init setup_page_sizes(void)
 	unsigned int eptcfg;
 	int psize;
 
-#ifdef CONFIG_PPC_E500
 	unsigned int mmucfg = mfspr(SPRN_MMUCFG);
 	int fsl_mmu = mmu_has_feature(MMU_FTR_TYPE_FSL_E);
 
@@ -151,7 +150,6 @@ static void __init setup_page_sizes(void)
 
 		goto out;
 	}
-#endif
 out:
 	/* Cleanup array and print summary */
 	pr_info("MMU: Supported page sizes\n");
@@ -180,13 +178,11 @@ static void __init setup_mmu_htw(void)
 	 */
 
 	switch (book3e_htw_mode) {
-#ifdef CONFIG_PPC_E500
 	case PPC_HTW_E6500:
 		extlb_level_exc = EX_TLB_SIZE;
 		patch_exception(0x1c0, exc_data_tlb_miss_e6500_book3e);
 		patch_exception(0x1e0, exc_instruction_tlb_miss_e6500_book3e);
 		break;
-#endif
 	}
 	pr_info("MMU: Book3E HW tablewalk %s\n",
 		book3e_htw_mode != PPC_HTW_NONE ? "enabled" : "not supported");
@@ -217,7 +213,6 @@ static void early_init_this_mmu(void)
 	}
 	mtspr(SPRN_MAS4, mas4);
 
-#ifdef CONFIG_PPC_E500
 	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
 		unsigned int num_cams;
 		bool map = true;
@@ -238,7 +233,6 @@ static void early_init_this_mmu(void)
 			linear_map_top = map_mem_in_cams(linear_map_top,
 							 num_cams, false, true);
 	}
-#endif
 
 	/* A sync won't hurt us after mucking around with
 	 * the MMU configuration
@@ -270,7 +264,6 @@ static void __init early_init_mmu_global(void)
 	/* Look for HW tablewalk support */
 	setup_mmu_htw();
 
-#ifdef CONFIG_PPC_E500
 	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
 		if (book3e_htw_mode == PPC_HTW_NONE) {
 			extlb_level_exc = EX_TLB_SIZE;
@@ -279,7 +272,6 @@ static void __init early_init_mmu_global(void)
 				exc_instruction_tlb_miss_bolted_book3e);
 		}
 	}
-#endif
 
 	/* Set the global containing the top of the linear mapping
 	 * for use by the TLB miss code
@@ -291,7 +283,6 @@ static void __init early_init_mmu_global(void)
 
 static void __init early_mmu_set_memory_limit(void)
 {
-#ifdef CONFIG_PPC_E500
 	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
 		/*
 		 * Limit memory so we dont have linear faults.
@@ -302,7 +293,6 @@ static void __init early_mmu_set_memory_limit(void)
 		 */
 		memblock_enforce_memory_limit(linear_map_top);
 	}
-#endif
 
 	memblock_set_current_limit(linear_map_top);
 }
@@ -340,7 +330,6 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	 * We crop it to the size of the first MEMBLOCK to
 	 * avoid going over total available memory just in case...
 	 */
-#ifdef CONFIG_PPC_E500
 	if (early_mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
 		unsigned long linear_sz;
 		unsigned int num_cams;
@@ -353,7 +342,6 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 
 		ppc64_rma_size = min_t(u64, linear_sz, 0x40000000);
 	} else
-#endif
 		ppc64_rma_size = min_t(u64, first_memblock_size, 0x40000000);
 
 	/* Finally limit subsequent allocations */
-- 
2.44.0


