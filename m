Return-Path: <linux-kernel+bounces-182537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBE98C8C6D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 21:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3EF1F25429
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 19:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1A21411CB;
	Fri, 17 May 2024 19:00:59 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21EA13E059
	for <linux-kernel@vger.kernel.org>; Fri, 17 May 2024 19:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715972459; cv=none; b=QBNE/MvjMw4GX7kV55fazFTtb3Fo3vkqsn/Gt/AJ3ionqymdDD4xEXFGwvbJZ2xAua2Ih/8Mp3rkVRd9qnWEmoS3FR8o7qVKLMy2Y9xXKb/tXkzznUZ3MTpzrmsYH4za0I7obUFd759hTMpp0IFC04R914gjqE3Q/sHOr7+OMnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715972459; c=relaxed/simple;
	bh=EKXFvixH1QDRMdDwLAcDFjoK2t9maiUDKOftRAhE8M8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m/ZatfASkMAw5/sJpFsieewaJeWoGa2x8r3AbbBgcqpic/8EKCvGNqwzlUwnLR8i85vVVYFHgi9CIizHL03F/gXoO2H5qpM+Sf597lYAHlN/AWZphuumhJeCYV9YUdA/ep80lAcpHEX/BxzSh7wL3WECBZbFvg8SHMAR3TgtAoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4Vgx9S1gxkz9t5l;
	Fri, 17 May 2024 21:00:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4cIGKIGNK9z9; Fri, 17 May 2024 21:00:12 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4Vgx9M672Bz9syj;
	Fri, 17 May 2024 21:00:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CD4458B766;
	Fri, 17 May 2024 21:00:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id ioM59iiRK_y8; Fri, 17 May 2024 21:00:07 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.121])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 479FE8B783;
	Fri, 17 May 2024 21:00:07 +0200 (CEST)
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
Subject: [RFC PATCH v2 08/20] powerpc/8xx: Simplify struct mmu_psize_def
Date: Fri, 17 May 2024 21:00:02 +0200
Message-ID: <ca2d232f07adfd7b3ed56d339a6071155cc9bcb7.1715971869.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1715971869.git.christophe.leroy@csgroup.eu>
References: <cover.1715971869.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715972396; l=1285; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=EKXFvixH1QDRMdDwLAcDFjoK2t9maiUDKOftRAhE8M8=; b=nX2X6vEpdK44UnfhG3HKWABTDQWPK0OwmzarT+5JSy8AVJaSKAikMUF3Rybc/nYF0xa9AiYQb w8VI07De5zHDDN3sYCq674/uu4dnjwSQUFkrAM6P02f/hMw3ZRsgD1m
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

On 8xx, only the shift field is used in struct mmu_psize_def

Remove other fields and related macros.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
index 141d82e249a8..a756a1e59c54 100644
--- a/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
+++ b/arch/powerpc/include/asm/nohash/32/mmu-8xx.h
@@ -189,19 +189,14 @@ typedef struct {
 
 #define PHYS_IMMR_BASE (mfspr(SPRN_IMMR) & 0xfff80000)
 
-/* Page size definitions, common between 32 and 64-bit
+/*
+ * Page size definitions for 8xx
  *
  *    shift : is the "PAGE_SHIFT" value for that page size
- *    penc  : is the pte encoding mask
  *
  */
 struct mmu_psize_def {
 	unsigned int	shift;	/* number of bits */
-	unsigned int	enc;	/* PTE encoding */
-	unsigned int    ind;    /* Corresponding indirect page size shift */
-	unsigned int	flags;
-#define MMU_PAGE_SIZE_DIRECT	0x1	/* Supported as a direct size */
-#define MMU_PAGE_SIZE_INDIRECT	0x2	/* Supported as an indirect size */
 };
 
 extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
-- 
2.44.0


