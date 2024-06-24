Return-Path: <linux-kernel+bounces-227403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045DE9150C8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7078DB22D6C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FB319CCE9;
	Mon, 24 Jun 2024 14:46:36 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C7719CCE4
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240396; cv=none; b=XNtSOLmJhwBGHWHlFfUpresL4HRjhhpwHpp0zYwbkMfBHrmVCTlKT8Yn5nwm3sv0buWLJVDAl2vDVZWs5gox5m8GGeoZcnMvXmTSwnO54Rn4bZ857Y+ZPMX42yCinyVNbBNyP8JIJAlURkk6RnugiqZ38/FlRRmC9Iu4dvJvAho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240396; c=relaxed/simple;
	bh=8npDU7aQvr19s9MKDH2AGurX1e7j8WxC5m6DZl26PXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLr68SEwqI5q+sJXjqLtYPlDA4VjT+Xe6msP/R08H8uQjik5zLUYmj7bpo1+ALK2FviSN0Y3IawlL3uCV6l6ASLOB1SKrMKj/QtfY6ZxcoyUezjA+4KUgKV7XELyrMaai+PI9HOu5A+Kqx2WT6sUOfJGGxCm8k/tzimHcbX7JW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4W79kh0zL7z9vFb;
	Mon, 24 Jun 2024 16:46:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mT_99uqCl_Ji; Mon, 24 Jun 2024 16:46:04 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4W79kd2hBrz9vDm;
	Mon, 24 Jun 2024 16:46:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 57EDE8B763;
	Mon, 24 Jun 2024 16:46:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id dl2xSjanXuqw; Mon, 24 Jun 2024 16:46:01 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.33])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CF8868B766;
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
Subject: [PATCH v6 05/23] powerpc/64e: Consolidate TLB miss handler patching
Date: Mon, 24 Jun 2024 16:45:31 +0200
Message-ID: <36c74a4064fd41b7d6c5091a246af3b701796ad9.1719240269.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1719240269.git.christophe.leroy@csgroup.eu>
References: <cover.1719240269.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719240333; l=2333; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=yAiKCEuhEewOEpS5oDWNvn73wPUuV/itXZW+PYTcfsA=; b=+XTT6AkxG3EFjxftGNfmlTkUuaYmJH01p/9nUYoAQFaR+jzgkqMC8HxjrurdqmEWKZCzMq9Tp VbObSpB9doeAc4xp8h+7qaY0bGS9yfOxnJUZSJsS/t7n5CQEqFksnn+
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

From: Michael Ellerman <mpe@ellerman.id.au>

The 64e TLB miss handler patching is done in setup_mmu_htw(), and then
again immediately afterward in early_init_mmu_global(). Consolidate it
into a single location.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/nohash/tlb_64e.c | 38 +++++++++++++-------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/mm/nohash/tlb_64e.c b/arch/powerpc/mm/nohash/tlb_64e.c
index 21c4b2442fcf..d83ecf466929 100644
--- a/arch/powerpc/mm/nohash/tlb_64e.c
+++ b/arch/powerpc/mm/nohash/tlb_64e.c
@@ -169,24 +169,6 @@ static void __init setup_page_sizes(void)
 	}
 }
 
-static void __init setup_mmu_htw(void)
-{
-	/*
-	 * If we want to use HW tablewalk, enable it by patching the TLB miss
-	 * handlers to branch to the one dedicated to it.
-	 */
-
-	switch (book3e_htw_mode) {
-	case PPC_HTW_E6500:
-		extlb_level_exc = EX_TLB_SIZE;
-		patch_exception(0x1c0, exc_data_tlb_miss_e6500_book3e);
-		patch_exception(0x1e0, exc_instruction_tlb_miss_e6500_book3e);
-		break;
-	}
-	pr_info("MMU: Book3E HW tablewalk %s\n",
-		book3e_htw_mode != PPC_HTW_NONE ? "enabled" : "not supported");
-}
-
 /*
  * Early initialization of the MMU TLB code
  */
@@ -252,15 +234,25 @@ static void __init early_init_mmu_global(void)
 	/* Look for supported page sizes */
 	setup_page_sizes();
 
-	/* Look for HW tablewalk support */
-	setup_mmu_htw();
-
-	if (book3e_htw_mode == PPC_HTW_NONE) {
-		extlb_level_exc = EX_TLB_SIZE;
+	/*
+	 * If we want to use HW tablewalk, enable it by patching the TLB miss
+	 * handlers to branch to the one dedicated to it.
+	 */
+	extlb_level_exc = EX_TLB_SIZE;
+	switch (book3e_htw_mode) {
+	case PPC_HTW_E6500:
+		patch_exception(0x1c0, exc_data_tlb_miss_e6500_book3e);
+		patch_exception(0x1e0, exc_instruction_tlb_miss_e6500_book3e);
+		break;
+	case PPC_HTW_NONE:
 		patch_exception(0x1c0, exc_data_tlb_miss_bolted_book3e);
 		patch_exception(0x1e0, exc_instruction_tlb_miss_bolted_book3e);
+		break;
 	}
 
+	pr_info("MMU: Book3E HW tablewalk %s\n",
+		book3e_htw_mode != PPC_HTW_NONE ? "enabled" : "not supported");
+
 	/* Set the global containing the top of the linear mapping
 	 * for use by the TLB miss code
 	 */
-- 
2.44.0


