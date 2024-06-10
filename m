Return-Path: <linux-kernel+bounces-207705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7903901AAB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A5FC1F21F12
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECB412B72;
	Mon, 10 Jun 2024 05:55:51 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DB453398
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998951; cv=none; b=cgM4oNjXvp/z1wYYpm/FqT7RXDMJawPzgfp/pKvVVzeqxrxDEh9nxt64q+yycAYAoYp2hCK/ewKLU3k4DXh2zwTKSWesQB6SDaUkTxBGXKKGpYxOVtxvM/woM9EIojEhSMHZD+ux365/W63VMxHCwIUUaaONv0In5/b2by6mnsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998951; c=relaxed/simple;
	bh=GvUuKmINqllZ54PyQ+lDpy16CYLzBdm/Cr1rg49spF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hj2b12vGLYwkOX8Jxh/DlW/djHzlH/+wTAdiN3d0Ckk64NTBFao/Pg+9L2K8CKG7+MrriwcWFRnr+O+ACNg/Cim01i/JOV/w5T+J+9UtNaIl8uN5M3zw6ammGuTjfpAzJcIeWIMTkPBoNqsQwqqCsP2ZLS97d+JgGWyHgkt9JG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4VyLcW1FPgz9v5V;
	Mon, 10 Jun 2024 07:55:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 28k8qCYCauKS; Mon, 10 Jun 2024 07:55:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4VyLcL4Wnjz9v5s;
	Mon, 10 Jun 2024 07:54:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 964208B76E;
	Mon, 10 Jun 2024 07:54:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id FarlN4awFhBP; Mon, 10 Jun 2024 07:54:58 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 70A898B76C;
	Mon, 10 Jun 2024 07:54:58 +0200 (CEST)
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
Subject: [PATCH v5 10/18] powerpc/e500: Remove enc and ind fields from struct mmu_psize_def
Date: Mon, 10 Jun 2024 07:54:55 +0200
Message-ID: <7518b2108edf2cc1274d3adb3821065deee3bda9.1717955559.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1717955558.git.christophe.leroy@csgroup.eu>
References: <cover.1717955558.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717998887; l=3777; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=GvUuKmINqllZ54PyQ+lDpy16CYLzBdm/Cr1rg49spF8=; b=OyfQUTod/0bbw4EyQQVBA/P5N3ZO8X30iPrJ8eUIij5YQvP1dKJOWaARcm2MOfKqCKfaLPaQm mmsdnfGbb/BDD75F8+P8mFNwxh4AT33inxGqOJ1S3GkD19a9/naVxbl
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

enc field is hidden behind BOOK3E_PAGESZ_XX macros, and when you look
closer you realise that this field is nothing else than the value of
shift minus ten.

So remove enc field and calculate tsize from shift field.

Also remove inc field which is unused.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
---
 arch/powerpc/include/asm/nohash/mmu-e500.h | 3 ---
 arch/powerpc/mm/nohash/book3e_pgtable.c    | 4 ++--
 arch/powerpc/mm/nohash/tlb.c               | 9 +--------
 arch/powerpc/mm/nohash/tlb_64e.c           | 2 +-
 4 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/mmu-e500.h b/arch/powerpc/include/asm/nohash/mmu-e500.h
index 7dc24b8632d7..b281d9eeaf1e 100644
--- a/arch/powerpc/include/asm/nohash/mmu-e500.h
+++ b/arch/powerpc/include/asm/nohash/mmu-e500.h
@@ -244,14 +244,11 @@ typedef struct {
 /* Page size definitions, common between 32 and 64-bit
  *
  *    shift : is the "PAGE_SHIFT" value for that page size
- *    penc  : is the pte encoding mask
  *
  */
 struct mmu_psize_def
 {
 	unsigned int	shift;	/* number of bits */
-	unsigned int	enc;	/* PTE encoding */
-	unsigned int    ind;    /* Corresponding indirect page size shift */
 	unsigned int	flags;
 #define MMU_PAGE_SIZE_DIRECT	0x1	/* Supported as a direct size */
 #define MMU_PAGE_SIZE_INDIRECT	0x2	/* Supported as an indirect size */
diff --git a/arch/powerpc/mm/nohash/book3e_pgtable.c b/arch/powerpc/mm/nohash/book3e_pgtable.c
index 1c5e4ecbebeb..ad2a7c26f2a0 100644
--- a/arch/powerpc/mm/nohash/book3e_pgtable.c
+++ b/arch/powerpc/mm/nohash/book3e_pgtable.c
@@ -29,10 +29,10 @@ int __meminit vmemmap_create_mapping(unsigned long start,
 		_PAGE_KERNEL_RW;
 
 	/* PTEs only contain page size encodings up to 32M */
-	BUG_ON(mmu_psize_defs[mmu_vmemmap_psize].enc > 0xf);
+	BUG_ON(mmu_psize_defs[mmu_vmemmap_psize].shift - 10 > 0xf);
 
 	/* Encode the size in the PTE */
-	flags |= mmu_psize_defs[mmu_vmemmap_psize].enc << 8;
+	flags |= (mmu_psize_defs[mmu_vmemmap_psize].shift - 10) << 8;
 
 	/* For each PTE for that area, map things. Note that we don't
 	 * increment phys because all PTEs are of the large size and
diff --git a/arch/powerpc/mm/nohash/tlb.c b/arch/powerpc/mm/nohash/tlb.c
index f57dc721d063..b653a7be4cb1 100644
--- a/arch/powerpc/mm/nohash/tlb.c
+++ b/arch/powerpc/mm/nohash/tlb.c
@@ -53,37 +53,30 @@
 struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT] = {
 	[MMU_PAGE_4K] = {
 		.shift	= 12,
-		.enc	= BOOK3E_PAGESZ_4K,
 	},
 	[MMU_PAGE_2M] = {
 		.shift	= 21,
-		.enc	= BOOK3E_PAGESZ_2M,
 	},
 	[MMU_PAGE_4M] = {
 		.shift	= 22,
-		.enc	= BOOK3E_PAGESZ_4M,
 	},
 	[MMU_PAGE_16M] = {
 		.shift	= 24,
-		.enc	= BOOK3E_PAGESZ_16M,
 	},
 	[MMU_PAGE_64M] = {
 		.shift	= 26,
-		.enc	= BOOK3E_PAGESZ_64M,
 	},
 	[MMU_PAGE_256M] = {
 		.shift	= 28,
-		.enc	= BOOK3E_PAGESZ_256M,
 	},
 	[MMU_PAGE_1G] = {
 		.shift	= 30,
-		.enc	= BOOK3E_PAGESZ_1GB,
 	},
 };
 
 static inline int mmu_get_tsize(int psize)
 {
-	return mmu_psize_defs[psize].enc;
+	return mmu_psize_defs[psize].shift - 10;
 }
 #else
 static inline int mmu_get_tsize(int psize)
diff --git a/arch/powerpc/mm/nohash/tlb_64e.c b/arch/powerpc/mm/nohash/tlb_64e.c
index 053128a5636c..7988238496d7 100644
--- a/arch/powerpc/mm/nohash/tlb_64e.c
+++ b/arch/powerpc/mm/nohash/tlb_64e.c
@@ -53,7 +53,7 @@ int extlb_level_exc;
  */
 void tlb_flush_pgtable(struct mmu_gather *tlb, unsigned long address)
 {
-	int tsize = mmu_psize_defs[mmu_pte_psize].enc;
+	int tsize = mmu_psize_defs[mmu_pte_psize].shift - 10;
 
 	if (book3e_htw_mode != PPC_HTW_NONE) {
 		unsigned long start = address & PMD_MASK;
-- 
2.44.0


