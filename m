Return-Path: <linux-kernel+bounces-227402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8189150C6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7514D1C2267F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5889F19F46E;
	Mon, 24 Jun 2024 14:46:28 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F256219B3DA
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240387; cv=none; b=dqTyHyEJJ1hgqryDgYRsf4XUltvGCb39adV3IcHlJ9MOikTdymLNRwm9jTXbLlbBrFad+a6XTlXTnTyWsw2PgJ1ofTJBE+b9CwdrhEqvOk5S4HnyOzRXqC3HR7cx1L05KWD9AkVANEbGi48ruYYQGTEgQaZd0oOg5mMWNA3sHRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240387; c=relaxed/simple;
	bh=+D1ch9pnGL5e4M0dREn9yxYLVls9BMVXx7QtIuBnk/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOBSveVbMb4skTr2TxVwtsrUS4Jg0drZfg14Sq4uGPwyUTEpizUtAMsmOPx+lp1JnQf+iGgtK7SAphZW5BjSgQn9cTiGa33+Apy+89veHfdXdujjhc6sRAVmI0KBA8x6h91kQ/hNzfjqtF6t/QAJFb2UFAALc6KVSUmUkYzIqI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4W79kg0xhbz9vF1;
	Mon, 24 Jun 2024 16:46:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8GGeSU0PQGmk; Mon, 24 Jun 2024 16:46:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4W79kc6R90z9vDw;
	Mon, 24 Jun 2024 16:46:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D89758B768;
	Mon, 24 Jun 2024 16:46:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id wCEZkRupK3zt; Mon, 24 Jun 2024 16:46:00 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.33])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 50C608B763;
	Mon, 24 Jun 2024 16:46:00 +0200 (CEST)
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
Subject: [PATCH v6 04/23] powerpc/64e: Drop MMU_FTR_TYPE_FSL_E checks in 64-bit code
Date: Mon, 24 Jun 2024 16:45:30 +0200
Message-ID: <1b82eb3216cc6586ddb018303e1038fddc2775b6.1719240269.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1719240269.git.christophe.leroy@csgroup.eu>
References: <cover.1719240269.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719240333; l=7160; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=AHd2YOhqPsn0mmn3bUFrvBRmVpZgpV/7pvx5aQBWlRU=; b=yXqY1lJuXSLGmqvFYww+onwRxJ2Ff6HNWVnGJemuq+uEou2udUl4JpX3v/PWekIuDO9rJYJh5 gBGTGNTE18+D64VNKQwun4n0MFSGmMI1NkluengPubmBDCTplBr4j3B
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

From: Michael Ellerman <mpe@ellerman.id.au>

All 64-bit Book3E have MMU_FTR_TYPE_FSL_E, since A2 was removed, so
remove checks for it in 64-bit only code.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/setup_64.c   |  6 +-
 arch/powerpc/mm/nohash/tlb_64e.c | 97 ++++++++++++--------------------
 2 files changed, 38 insertions(+), 65 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index ae36a129789f..22f83fbbc762 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -696,11 +696,7 @@ __init u64 ppc64_bolted_size(void)
 {
 #ifdef CONFIG_PPC_BOOK3E_64
 	/* Freescale BookE bolts the entire linear mapping */
-	/* XXX: BookE ppc64_rma_limit setup seems to disagree? */
-	if (early_mmu_has_feature(MMU_FTR_TYPE_FSL_E))
-		return linear_map_top;
-	/* Other BookE, we assume the first GB is bolted */
-	return 1ul << 30;
+	return linear_map_top;
 #else
 	/* BookS radix, does not take faults on linear mapping */
 	if (early_radix_enabled())
diff --git a/arch/powerpc/mm/nohash/tlb_64e.c b/arch/powerpc/mm/nohash/tlb_64e.c
index 9db85ee9ba5b..21c4b2442fcf 100644
--- a/arch/powerpc/mm/nohash/tlb_64e.c
+++ b/arch/powerpc/mm/nohash/tlb_64e.c
@@ -86,9 +86,8 @@ static void __init setup_page_sizes(void)
 	int psize;
 
 	unsigned int mmucfg = mfspr(SPRN_MMUCFG);
-	int fsl_mmu = mmu_has_feature(MMU_FTR_TYPE_FSL_E);
 
-	if (fsl_mmu && (mmucfg & MMUCFG_MAVN) == MMUCFG_MAVN_V1) {
+	if ((mmucfg & MMUCFG_MAVN) == MMUCFG_MAVN_V1) {
 		unsigned int tlb1cfg = mfspr(SPRN_TLB1CFG);
 		unsigned int min_pg, max_pg;
 
@@ -115,7 +114,7 @@ static void __init setup_page_sizes(void)
 		goto out;
 	}
 
-	if (fsl_mmu && (mmucfg & MMUCFG_MAVN) == MMUCFG_MAVN_V2) {
+	if ((mmucfg & MMUCFG_MAVN) == MMUCFG_MAVN_V2) {
 		u32 tlb1cfg, tlb1ps;
 
 		tlb0cfg = mfspr(SPRN_TLB0CFG);
@@ -213,26 +212,24 @@ static void early_init_this_mmu(void)
 	}
 	mtspr(SPRN_MAS4, mas4);
 
-	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
-		unsigned int num_cams;
-		bool map = true;
+	unsigned int num_cams;
+	bool map = true;
 
-		/* use a quarter of the TLBCAM for bolted linear map */
-		num_cams = (mfspr(SPRN_TLB1CFG) & TLBnCFG_N_ENTRY) / 4;
+	/* use a quarter of the TLBCAM for bolted linear map */
+	num_cams = (mfspr(SPRN_TLB1CFG) & TLBnCFG_N_ENTRY) / 4;
 
-		/*
-		 * Only do the mapping once per core, or else the
-		 * transient mapping would cause problems.
-		 */
+	/*
+	 * Only do the mapping once per core, or else the
+	 * transient mapping would cause problems.
+	 */
 #ifdef CONFIG_SMP
-		if (hweight32(get_tensr()) > 1)
-			map = false;
+	if (hweight32(get_tensr()) > 1)
+		map = false;
 #endif
 
-		if (map)
-			linear_map_top = map_mem_in_cams(linear_map_top,
-							 num_cams, false, true);
-	}
+	if (map)
+		linear_map_top = map_mem_in_cams(linear_map_top,
+						 num_cams, false, true);
 
 	/* A sync won't hurt us after mucking around with
 	 * the MMU configuration
@@ -242,16 +239,10 @@ static void early_init_this_mmu(void)
 
 static void __init early_init_mmu_global(void)
 {
-	/* XXX This should be decided at runtime based on supported
-	 * page sizes in the TLB, but for now let's assume 16M is
-	 * always there and a good fit (which it probably is)
-	 *
+	/*
 	 * Freescale booke only supports 4K pages in TLB0, so use that.
 	 */
-	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E))
-		mmu_vmemmap_psize = MMU_PAGE_4K;
-	else
-		mmu_vmemmap_psize = MMU_PAGE_16M;
+	mmu_vmemmap_psize = MMU_PAGE_4K;
 
 	/* XXX This code only checks for TLB 0 capabilities and doesn't
 	 *     check what page size combos are supported by the HW. It
@@ -264,13 +255,10 @@ static void __init early_init_mmu_global(void)
 	/* Look for HW tablewalk support */
 	setup_mmu_htw();
 
-	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
-		if (book3e_htw_mode == PPC_HTW_NONE) {
-			extlb_level_exc = EX_TLB_SIZE;
-			patch_exception(0x1c0, exc_data_tlb_miss_bolted_book3e);
-			patch_exception(0x1e0,
-				exc_instruction_tlb_miss_bolted_book3e);
-		}
+	if (book3e_htw_mode == PPC_HTW_NONE) {
+		extlb_level_exc = EX_TLB_SIZE;
+		patch_exception(0x1c0, exc_data_tlb_miss_bolted_book3e);
+		patch_exception(0x1e0, exc_instruction_tlb_miss_bolted_book3e);
 	}
 
 	/* Set the global containing the top of the linear mapping
@@ -283,16 +271,14 @@ static void __init early_init_mmu_global(void)
 
 static void __init early_mmu_set_memory_limit(void)
 {
-	if (mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
-		/*
-		 * Limit memory so we dont have linear faults.
-		 * Unlike memblock_set_current_limit, which limits
-		 * memory available during early boot, this permanently
-		 * reduces the memory available to Linux.  We need to
-		 * do this because highmem is not supported on 64-bit.
-		 */
-		memblock_enforce_memory_limit(linear_map_top);
-	}
+	/*
+	 * Limit memory so we dont have linear faults.
+	 * Unlike memblock_set_current_limit, which limits
+	 * memory available during early boot, this permanently
+	 * reduces the memory available to Linux.  We need to
+	 * do this because highmem is not supported on 64-bit.
+	 */
+	memblock_enforce_memory_limit(linear_map_top);
 
 	memblock_set_current_limit(linear_map_top);
 }
@@ -313,12 +299,8 @@ void early_init_mmu_secondary(void)
 void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 				phys_addr_t first_memblock_size)
 {
-	/* On non-FSL Embedded 64-bit, we adjust the RMA size to match
-	 * the bolted TLB entry. We know for now that only 1G
-	 * entries are supported though that may eventually
-	 * change.
-	 *
-	 * on FSL Embedded 64-bit, usually all RAM is bolted, but with
+	/*
+	 * On FSL Embedded 64-bit, usually all RAM is bolted, but with
 	 * unusual memory sizes it's possible for some RAM to not be mapped
 	 * (such RAM is not used at all by Linux, since we don't support
 	 * highmem on 64-bit).  We limit ppc64_rma_size to what would be
@@ -330,19 +312,14 @@ void setup_initial_memory_limit(phys_addr_t first_memblock_base,
 	 * We crop it to the size of the first MEMBLOCK to
 	 * avoid going over total available memory just in case...
 	 */
-	if (early_mmu_has_feature(MMU_FTR_TYPE_FSL_E)) {
-		unsigned long linear_sz;
-		unsigned int num_cams;
-
-		/* use a quarter of the TLBCAM for bolted linear map */
-		num_cams = (mfspr(SPRN_TLB1CFG) & TLBnCFG_N_ENTRY) / 4;
+	unsigned long linear_sz;
+	unsigned int num_cams;
 
-		linear_sz = map_mem_in_cams(first_memblock_size, num_cams,
-					    true, true);
+	/* use a quarter of the TLBCAM for bolted linear map */
+	num_cams = (mfspr(SPRN_TLB1CFG) & TLBnCFG_N_ENTRY) / 4;
 
-		ppc64_rma_size = min_t(u64, linear_sz, 0x40000000);
-	} else
-		ppc64_rma_size = min_t(u64, first_memblock_size, 0x40000000);
+	linear_sz = map_mem_in_cams(first_memblock_size, num_cams, true, true);
+	ppc64_rma_size = min_t(u64, linear_sz, 0x40000000);
 
 	/* Finally limit subsequent allocations */
 	memblock_set_current_limit(first_memblock_base + ppc64_rma_size);
-- 
2.44.0


