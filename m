Return-Path: <linux-kernel+bounces-227413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C399150EC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 904E31F25390
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 14:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509731A0738;
	Mon, 24 Jun 2024 14:47:38 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4411A0727
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240457; cv=none; b=gyDIN22A57qPFmkAHxIY8HYSdlkPWKYdaAPA7JpmvONUpVbalWOKGM1qneZSmJeGaw8NgPqpJpv+JoFv/YEvV5E7fe+qa1Qf9vJ53AK8hzpkZWaRzH2VkoFE5lf3Teq+OVr5OpXQe37/6JpzIoDmeilMb5r5qwCmDPH6ikWXpcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240457; c=relaxed/simple;
	bh=foRpSg705p76Fv1R91+1LawwFjSx303hjdxd+UuPeuU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pxZCNFfzKSPe5gTPe2OkfcpzDS/RT3o/TS5vbz5JGzMf4LX+X9Bi3XJe4ZwOmaYWSy07NiwwEFczfuTDsUbKCQl2XrfarVUy6Qagfjc90OfKaq2EIrevQ/272rHR57QMM28tAtkPNVTNjwO1lrbeqfQkHc4xMV4v7ueURH0U73Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4W79kv2FN4z9vFM;
	Mon, 24 Jun 2024 16:46:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XyoFJLzfiuTu; Mon, 24 Jun 2024 16:46:15 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4W79kk4PyDz9vG4;
	Mon, 24 Jun 2024 16:46:06 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 937398B766;
	Mon, 24 Jun 2024 16:46:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 4a8728aM7DXV; Mon, 24 Jun 2024 16:46:06 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.33])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 050818B763;
	Mon, 24 Jun 2024 16:46:05 +0200 (CEST)
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
Subject: [PATCH v6 14/23] powerpc/8xx: Simplify struct mmu_psize_def
Date: Mon, 24 Jun 2024 16:45:40 +0200
Message-ID: <c5ad47f72091771e2ae483ee6b52b74b1a5fc172.1719240269.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1719240269.git.christophe.leroy@csgroup.eu>
References: <cover.1719240269.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719240334; l=1334; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=foRpSg705p76Fv1R91+1LawwFjSx303hjdxd+UuPeuU=; b=mwMUq2Y2c5ye7WW6fiTKSS3ln99BJVhVuNez0/0J7hzBMWwNcS2TTJru9TXiKOvNj9SrhELAk sJOBewBlTFUAiSpMGk9ALTg3dCwTPTNXgdU0I/1ycLDj6BJxAInura6
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


