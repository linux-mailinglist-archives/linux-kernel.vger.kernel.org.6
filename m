Return-Path: <linux-kernel+bounces-182541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 663BB8C8C73
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A081C224EF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A6E13FD61;
	Fri, 17 May 2024 19:01:16 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B1F13E405
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715972476; cv=none; b=BSTU2r9ELtr0lrAOw3Pp9gm7a3GKqiY0a8fUhlR9RmmMKVNhGLUsRGgGt0lrYYehj60CA7QSWYmYhuhgckyiqsyK9ZqLozcRqIdf+xWNgPAlD6marvDnm8QoCwPSDvOy19wjvHLp7FOixX+P/HdVW8dd5djRGBZ/JLR6omDUJJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715972476; c=relaxed/simple;
	bh=DGNEwOqrZPDJ6RelPMWL/atODz81+xAm8V/8D54CzmE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2zJRoNURV/SuUEjdB/TsvDnh2R24xtY8bp8jOaV/Piker1aM9ma1f7N0NdJKyNPgfz7Ey2WDqUaOTl6TKFiEnLlrOS7UNhEfA8S0IMD4gAUnuZ+8u6AhT2ZBa4e7CI1FVWoj7HROJYttvcEWM5gYhjDS3zf2k1W60dDKLiPXoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4Vgx9X0zDyz9sy4;
	Fri, 17 May 2024 21:00:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wHD1cnBBuEpX; Fri, 17 May 2024 21:00:16 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4Vgx9P72pVz9t0K;
	Fri, 17 May 2024 21:00:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id ED94B8B775;
	Fri, 17 May 2024 21:00:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id j74iBzFKdD6P; Fri, 17 May 2024 21:00:09 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.121])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 66DA08B783;
	Fri, 17 May 2024 21:00:09 +0200 (CEST)
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
Subject: [RFC PATCH v2 12/20] powerpc/64e: Remove unneeded #ifdef CONFIG_PPC_E500
Date: Fri, 17 May 2024 21:00:06 +0200
Message-ID: <f70e5249b9e6a9a06e6575aa0efbaf8ba93c3659.1715971869.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1715971869.git.christophe.leroy@csgroup.eu>
References: <cover.1715971869.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715972397; l=3490; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=DGNEwOqrZPDJ6RelPMWL/atODz81+xAm8V/8D54CzmE=; b=82BEvUxdn8ICjBdq8A7G9v2L3oUv4GZXqKIMA8sGAF7jH5d778KUHHvYbvAg1PoearWJjNtgC SOmb5SGtcAZBUlkI6VdjVJWJxfnjNtwcKB1yX+g2mykMaLm5ZxISUwj
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

When it is a nohash/64 it can't be anything else than
CONFIG_PPC_E500 so remove the #ifdef as they are always true.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/nohash/tlb.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/powerpc/mm/nohash/tlb.c b/arch/powerpc/mm/nohash/tlb.c
index 5ffa0af4328a..d16f1ef7516c 100644
--- a/arch/powerpc/mm/nohash/tlb.c
+++ b/arch/powerpc/mm/nohash/tlb.c
@@ -403,8 +403,6 @@ static void __init setup_page_sizes(void)
 	unsigned int tlb0ps;
 	unsigned int eptcfg;
 	int i, psize;
-
-#ifdef CONFIG_PPC_E500
 	unsigned int mmucfg = mfspr(SPRN_MMUCFG);
 	int fsl_mmu = mmu_has_feature(MMU_FTR_TYPE_FSL_E);
 
@@ -470,7 +468,6 @@ static void __init setup_page_sizes(void)
 
 		goto out;
 	}
-#endif
 
 	tlb0cfg = mfspr(SPRN_TLB0CFG);
 	tlb0ps = mfspr(SPRN_TLB0PS);
@@ -547,13 +544,11 @@ static void __init setup_mmu_htw(void)
 		patch_exception(0x1c0, exc_data_tlb_miss_htw_book3e);
 		patch_exception(0x1e0, exc_instruction_tlb_miss_htw_book3e);
 		break;
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
@@ -590,7 +585,6 @@ static void early_init_this_mmu(void)
 	}
 	mtspr(SPRN_MAS4, mas4);
 
-#ifdef CONFIG_PPC_E500
 	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
 		unsigned int num_cams;
 		bool map = true;
@@ -611,7 +605,6 @@ static void early_init_this_mmu(void)
 			linear_map_top = map_mem_in_cams(linear_map_top,
 							 num_cams, false, true);
 	}
-#endif
 
 	/* A sync won't hurt us after mucking around with
 	 * the MMU configuration
@@ -643,7 +636,6 @@ static void __init early_init_mmu_global(void)
 	/* Look for HW tablewalk support */
 	setup_mmu_htw();
 
-#ifdef CONFIG_PPC_E500
 	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
 		if (book3e_htw_mode == PPC_HTW_NONE) {
 			extlb_level_exc = EX_TLB_SIZE;
@@ -652,7 +644,6 @@ static void __init early_init_mmu_global(void)
 				exc_instruction_tlb_miss_bolted_book3e);
 		}
 	}
-#endif
 
 	/* Set the global containing the top of the linear mapping
 	 * for use by the TLB miss code
@@ -664,7 +655,6 @@ static void __init early_init_mmu_global(void)
 
 static void __init early_mmu_set_memory_limit(void)
 {
-#ifdef CONFIG_PPC_E500
 	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
 		/*
 		 * Limit memory so we dont have linear faults.
@@ -675,7 +665,6 @@ static void __init early_mmu_set_memory_limit(void)
 		 */
 		memblock_enforce_memory_limit(linear_map_top);
 	}
-#endif
 
 	memblock_set_current_limit(linear_map_top);
 }
@@ -713,7 +702,6 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	 * We crop it to the size of the first MEMBLOCK to
 	 * avoid going over total available memory just in case...
 	 */
-#ifdef CONFIG_PPC_E500
 	if (early_mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
 		unsigned long linear_sz;
 		unsigned int num_cams;
@@ -726,7 +714,6 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 
 		ppc64_rma_size = min_t(u64, linear_sz, 0x40000000);
 	} else
-#endif
 		ppc64_rma_size = min_t(u64, first_memblock_size, 0x40000000);
 
 	/* Finally limit subsequent allocations */
-- 
2.44.0


