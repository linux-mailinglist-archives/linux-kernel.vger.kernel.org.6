Return-Path: <linux-kernel+bounces-294399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F86958D36
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19821C2256B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98F41C5787;
	Tue, 20 Aug 2024 17:24:42 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FE51BE228
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 17:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174682; cv=none; b=ZAylSd29QctIjaTRNe/rw1LErcxBlyL9LhND6lq107EoGqy+X0inO0lAjzs/fBUcE6RnZGocVoeGnRLaMlra/lsrY5aZAZw+TKzAZWDk9rXmPzU/NcOw8dGol2nqfZzn8y/mlZYv4lPRruDxhJqu3Dxyz5cepsMQqs/75i90Ync=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174682; c=relaxed/simple;
	bh=X9o3JThADXun2vvHn0McM5c19K3Vw72HMUSgeOodXX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tBPp3gLJL6IUkdHYtSk/pM05MwWq4z2b+ROv7YooDLtOQWYdWWdH4deOpA9pVSBAGOPT8WjzkqQEfGTIw3sVFBlpYBNOPdVc3KEAMcX2yhsJ1JCxR7lsDs1mhfexzdRpmNGoYA+TQ05MtH7ds6ReAEVHEv3dq8fMbxtE3F1Fgsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WpGY81BSmz9sSV;
	Tue, 20 Aug 2024 19:24:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J9UlbHKJ-cs5; Tue, 20 Aug 2024 19:24:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WpGY64WP3z9sSH;
	Tue, 20 Aug 2024 19:24:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 859958B763;
	Tue, 20 Aug 2024 19:24:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id 2BpkqU3_bImS; Tue, 20 Aug 2024 19:24:26 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.72])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1F2F88B778;
	Tue, 20 Aug 2024 19:24:26 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: CASAUBON Jean Michel <jean-michel.casaubon@cs-soprasteria.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 03/14] powerpc/8xx: Copy kernel PGD entries into all PGDIRs
Date: Tue, 20 Aug 2024 19:23:47 +0200
Message-ID: <c6d2bf5af2ea909071a85bdca8b1f5dc2df134a8.1724173828.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1724173828.git.christophe.leroy@csgroup.eu>
References: <cover.1724173828.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724174648; l=1229; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=X9o3JThADXun2vvHn0McM5c19K3Vw72HMUSgeOodXX4=; b=h61VyfXIBr3m0v/OISV9XO60cpuN2KDeVIl6ct1dZqVS684DgAk9zwVmnT8O3vS8d9WuVtSyG J4csbztTKMEATPcsdP0Vy3wivZwYJ6yN9rxqtf/I/3NZTdGNxpDdG17
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

In order to avoid having to select PGDIR at each TLB miss based on
fault address, copy kernel PGD entries into all PGDIRs in pgd_alloc().

At first it will be used for ITLB misses for kernel TEXT, then for
execmem then for kernel DATA.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/nohash/pgalloc.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/nohash/pgalloc.h b/arch/powerpc/include/asm/nohash/pgalloc.h
index d06efac6d7aa..4ef780b291bc 100644
--- a/arch/powerpc/include/asm/nohash/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/pgalloc.h
@@ -19,8 +19,14 @@ static inline void tlb_flush_pgtable(struct mmu_gather *tlb,
 
 static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 {
-	return kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
+	pgd_t *pgd = kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
 			pgtable_gfp_flags(mm, GFP_KERNEL));
+
+#ifdef CONFIG_PPC_8xx
+	memcpy(pgd + USER_PTRS_PER_PGD, swapper_pg_dir + USER_PTRS_PER_PGD,
+	       (MAX_PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
+#endif
+	return pgd;
 }
 
 static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
-- 
2.44.0


