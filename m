Return-Path: <linux-kernel+bounces-294405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB49958D49
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8929A286CB2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65E81C4625;
	Tue, 20 Aug 2024 17:25:02 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEEF1C460B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174702; cv=none; b=mIYgErVHqrS974XhV57cYPO0lrSKy7nOmBWCXSfzLYIQepL7XSpNUQ29BB9DV9vk2ZVxpRU20ju2sOxKIZxsbtiqgzWjEVposbgF8WtJ9fXUO0ENegdg5IlcGNAYnvyIoxOoWWJ+sLyEk85Rz6414QKlT838kFZB8cS1gEsjC28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174702; c=relaxed/simple;
	bh=nwR9CoHpbJRQlif0McwHkWP0mV6sxqRZS0kN/UNtF7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IFpWfcc9mFTEom6G7jqXtInTxwjYfSzxHup+k3Z0DeToBxTfuuBJPWmTvFdaAUStPKMDpp7pFxZPv7mAzq9vnfYZybW/T2pGmfOoozmjS9dTV6YtT+yxiEr4MKGrZgEw4vWCCxen7Ci2QeAKXjMoqgbvyadJVJvNy5cUm30XxuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WpGYG0QSsz9sSH;
	Tue, 20 Aug 2024 19:24:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Xvm4j3keclx1; Tue, 20 Aug 2024 19:24:33 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WpGY84f0jz9sSW;
	Tue, 20 Aug 2024 19:24:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 89B0A8B763;
	Tue, 20 Aug 2024 19:24:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id T4N_HjS8JNnF; Tue, 20 Aug 2024 19:24:28 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.72])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 244048B779;
	Tue, 20 Aug 2024 19:24:28 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: CASAUBON Jean Michel <jean-michel.casaubon@cs-soprasteria.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 08/14] powerpc/8xx: Inconditionally use task PGDIR in ITLB misses
Date: Tue, 20 Aug 2024 19:23:52 +0200
Message-ID: <774fd766a8b9bcb9173b5e677d5dad0df2d3970f.1724173828.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1724173828.git.christophe.leroy@csgroup.eu>
References: <cover.1724173828.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724174648; l=1061; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=nwR9CoHpbJRQlif0McwHkWP0mV6sxqRZS0kN/UNtF7M=; b=i8JOyF1jdPa5ODtRED2AVFuKrmxcGAJ9STmsBuaPu7V0vn0D+ip+TZmTZW4cFhxoACPPefi+D new1uXyYGnvBqSvx9hx5EzFkJJFMuUIVPD5Bqjute5j0ofu7HuPCg2J
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Now that modules exec page tables are preallocated, the instruction
TLBmiss handler can use task PGDIR inconditionally.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_8xx.S | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index 66ee0a31d99d..f9a05648a522 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -199,18 +199,7 @@ instruction_counter:
 	mfspr	r10, SPRN_SRR0	/* Get effective address of fault */
 	INVALIDATE_ADJACENT_PAGES_CPU15(r10, r11)
 	mtspr	SPRN_MD_EPN, r10
-#ifdef CONFIG_EXECMEM
-	mfcr	r11
-	compare_to_kernel_boundary r10, r10
-#endif
 	mfspr	r10, SPRN_M_TWB	/* Get level 1 table */
-#ifdef CONFIG_EXECMEM
-	blt+	3f
-	rlwinm	r10, r10, 0, 20, 31
-	oris	r10, r10, (swapper_pg_dir - PAGE_OFFSET)@ha
-3:
-	mtcr	r11
-#endif
 	lwz	r11, (swapper_pg_dir-PAGE_OFFSET)@l(r10)	/* Get level 1 entry */
 	mtspr	SPRN_MD_TWC, r11
 	mfspr	r10, SPRN_MD_TWC
-- 
2.44.0


