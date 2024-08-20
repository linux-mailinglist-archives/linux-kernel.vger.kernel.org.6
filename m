Return-Path: <linux-kernel+bounces-294408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1DC958D4C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEA7E1C2292F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF21D1C579D;
	Tue, 20 Aug 2024 17:25:16 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6991BDA8C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 17:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174716; cv=none; b=KmcKy7fWz8CIiRA6GBazJwFuiduHCEss2zYXLM+zKbBHB/qphS00eYh9VPYLl944eOpaBcHwmAR3EEYiqn+k/IBDFGwqXXESIlvMGDcHfth8mqiowYabhIiUcqklXrL8GX7YSDCcCgz0v+3egjT1gjipi/EOBCI9NMimuA/TApU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174716; c=relaxed/simple;
	bh=GyFJyrOA257p/8jUZ/CSVQAGtRaML3IGhaLgOxyHLTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vh3j5yJg8j3H2mcMCIrPmDom+uflD1nsaTlYm64c5ltZgmtjHV6dgub2npgOw4+X4YViDdK1ZpnnXQWeNTJA5GaFksttO02UEQTw5VeOa+HRp2acAsF5nE5RGspRbsf5MOx4x49mQOVF8ZMnfvlldrrPXwKcwwc7vfqJMNS816g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WpGYL0TBXz9sSR;
	Tue, 20 Aug 2024 19:24:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y7PUeo80Ixik; Tue, 20 Aug 2024 19:24:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WpGY95kKmz9sSZ;
	Tue, 20 Aug 2024 19:24:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B5A5B8B763;
	Tue, 20 Aug 2024 19:24:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id jByNRArc64YM; Tue, 20 Aug 2024 19:24:29 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.72])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 592298B778;
	Tue, 20 Aug 2024 19:24:29 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: CASAUBON Jean Michel <jean-michel.casaubon@cs-soprasteria.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 11/14] powerpc/603: Copy kernel PGD entries into all PGDIRs and preallocate execmem page tables
Date: Tue, 20 Aug 2024 19:23:55 +0200
Message-ID: <1a0d1feee07c4cf955f6a43a704c203e5c90fa53.1724173828.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1724173828.git.christophe.leroy@csgroup.eu>
References: <cover.1724173828.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724174648; l=1632; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=GyFJyrOA257p/8jUZ/CSVQAGtRaML3IGhaLgOxyHLTI=; b=eSfDVkZKrCDgx+WGWZk9JTf5kOdejPL3Se5yUK2npB1SO1LhWBJoHK48EIMjGMPY7MwUO+z57 XwOp/Xxo3CeBS/NUWRdjfY4keOY3zq3hYRMj44Tiq7mqUtTpQXDEfFE
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

For the same reason as 8xx, copy kernel PGD entries into all
PGDIRs in pgd_alloc() and preallocate execmem page tables before
creating new PGDs so that all PGD entries related to execmem are
copied by pgd_alloc().

This will help reduce the fast-path in TLBmiss handlers.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/nohash/pgalloc.h | 2 +-
 arch/powerpc/mm/mem.c                     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/pgalloc.h b/arch/powerpc/include/asm/nohash/pgalloc.h
index 4ef780b291bc..bb5f3e8ea912 100644
--- a/arch/powerpc/include/asm/nohash/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/pgalloc.h
@@ -22,7 +22,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 	pgd_t *pgd = kmem_cache_alloc(PGT_CACHE(PGD_INDEX_SIZE),
 			pgtable_gfp_flags(mm, GFP_KERNEL));
 
-#ifdef CONFIG_PPC_8xx
+#if defined(CONFIG_PPC_8xx) || defined(CONFIG_PPC_BOOK3S_603)
 	memcpy(pgd + USER_PTRS_PER_PGD, swapper_pg_dir + USER_PTRS_PER_PGD,
 	       (MAX_PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
 #endif
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 5495572b42e6..da606ef18eae 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -410,7 +410,7 @@ EXPORT_SYMBOL_GPL(walk_system_ram_range);
 #ifdef CONFIG_EXECMEM
 static struct execmem_info execmem_info __ro_after_init;
 
-#ifdef CONFIG_PPC_8xx
+#if defined(CONFIG_PPC_8xx) || defined(CONFIG_PPC_BOOK3S_603)
 static void prealloc_execmem_pgtable(void)
 {
 	unsigned long va;
-- 
2.44.0


