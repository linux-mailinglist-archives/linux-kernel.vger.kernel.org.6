Return-Path: <linux-kernel+bounces-190711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBD28D018F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AABFC1C24294
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF74160797;
	Mon, 27 May 2024 13:31:00 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE1615FCFC
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816660; cv=none; b=nqeB0U0N3vu2WrlwQm3AhBDxBA29OWXTYtW4/tmopr8WmVcTC+BZmCR27e/1NomDlT1tq3nIG3W/HKWoPFWrMeQ5kt3bt4xS9Zv4ubwwzGXbTZleQngrwGv7zpPhMGVO9/H5pxKPiD+FN//hSXBFB6fdDIUEI13O+IDg7U9FL7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816660; c=relaxed/simple;
	bh=foRpSg705p76Fv1R91+1LawwFjSx303hjdxd+UuPeuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nr7WQpxNJOdViw6KveSUWzVhQlvS76953gYL5eVsN6gvVlWTNnSeYB4/QIKwfjdD+w1ZKkNHwBKkesg83XikFuSq5S0AQzanhssNatxGBKatU8tPM571iULV2aLnl8GZsMmFrmX1z6AC9SD9aSe4yfc5gTIu1gm/6nUTY4zQafI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4VnxNh4CNPz9sqS;
	Mon, 27 May 2024 15:30:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xjPC1R4_n9Zd; Mon, 27 May 2024 15:30:44 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4VnxNg1JK8z9tHF;
	Mon, 27 May 2024 15:30:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 276B48B773;
	Mon, 27 May 2024 15:30:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id oFrG5_RqJUcI; Mon, 27 May 2024 15:30:43 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.49])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 36A748B764;
	Mon, 27 May 2024 15:30:40 +0200 (CEST)
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
Subject: [RFC PATCH v4 09/16] powerpc/8xx: Simplify struct mmu_psize_def
Date: Mon, 27 May 2024 15:30:07 +0200
Message-ID: <de6b024e2e63e6faf2a903a1a87823043494a56d.1716815901.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1716815901.git.christophe.leroy@csgroup.eu>
References: <cover.1716815901.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716816601; l=1334; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=foRpSg705p76Fv1R91+1LawwFjSx303hjdxd+UuPeuU=; b=atjAkuPvr2Ff19HnM3/JJDA8hanr8ssPzuScrr4EAW+e8KY9FkfkPIo6ifYbiRWCmKLcT2yim WqCOkcm1cUIC5pqBbEtGzVFjE8KrVm19vJe/pprh/0CxgsyxAvsnX++
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

On 8xx, only the shift field is used in struct mmu_psize_def

Remove other fields and related macros.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
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


