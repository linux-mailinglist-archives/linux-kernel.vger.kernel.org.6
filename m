Return-Path: <linux-kernel+bounces-227401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EA69150C5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C102F1F24550
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B380A19EEDD;
	Mon, 24 Jun 2024 14:46:22 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E53619D889
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240382; cv=none; b=ZArlF7X0bRw4m6ba5grbSlWPd/pujrO0o/Z9U/aatcSoszxgjsAiHg63VpO1bBrZV5eG+Q5qXk+8X95hm20HINunQCIB6c1YcZGRQpoE1g5/RQbYcZETYG4wnKmYv0T1s2JJfIQLX3wFaU6FcjW8EyLGzOTyQYAXPsoNKKgYHGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240382; c=relaxed/simple;
	bh=qXbozt1kGgrHLvcmvKqTNqOnlgbhOCUMEjOjKB27jaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VgHcMxtA+jaeDcly1bz2TNo4n4UH7KoxO1ZnBbOcAJrFEsyvoEpq0ozO+kTzBrT8mjQDib33CaOSWsou2oJusaruOmO/KCLQSeh+Xvi+uy3AV1wx+HZ9UVnZ3xJgKxgKCaIjYnrZYu32Sfe2HAhWaOtvU5EJZz2USRTWE3BrPP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4W79kf3dsNz9vFX;
	Mon, 24 Jun 2024 16:46:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EY7GCR8t9pSa; Mon, 24 Jun 2024 16:46:02 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4W79kc2jcpz9vF1;
	Mon, 24 Jun 2024 16:46:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 58A998B766;
	Mon, 24 Jun 2024 16:46:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id UIgShAoMAc_G; Mon, 24 Jun 2024 16:46:00 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.33])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id C98B08B768;
	Mon, 24 Jun 2024 16:45:59 +0200 (CEST)
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
Subject: [PATCH v6 03/23] powerpc/64e: Drop E500 ifdefs in 64-bit code
Date: Mon, 24 Jun 2024 16:45:29 +0200
Message-ID: <e163c251d15cd47d47360dfca0227f0569972cfe.1719240269.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1719240269.git.christophe.leroy@csgroup.eu>
References: <cover.1719240269.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719240333; l=3405; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=A/9Ib78BLDVf4ZZ6WCRXnSh8JY4Xq2JsVQD062iffmM=; b=8FTQ/XsgpMtj8tgzx29zcK6osHbRp6R69N5CSdY5G3WPcnNxRDFIzd92IfJl3Nzuitx544sQK vPxDYhj/5R7C7L17nvs0ksxlDCGmc3LEDNqRLVKLi7vL27Et6NGMOVB
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


