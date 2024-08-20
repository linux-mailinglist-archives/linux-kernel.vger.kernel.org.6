Return-Path: <linux-kernel+bounces-294397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 444E8958D30
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00EF4282CD1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E3D1C378B;
	Tue, 20 Aug 2024 17:24:34 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B923418C92C
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 17:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174674; cv=none; b=AXRaRHY8YxPFObvq/UZ9G6Yd+WIH1fr3wCHk7gYGQ2r68YDHIh75QtnjTVEMtln5VkWYuih3RM/IiTMGuZNxjyW0apWhotKNUjtwOR2d8q6/VTQQLlmZsCXXF9cz1M3ftLzvjEmHhevlkIVJ3OfqHaV0uKDO43tXZTjGc0M3/uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174674; c=relaxed/simple;
	bh=YSS0Z4TGY3GQo2hL9A1Rle4r3NsVDHe7D8HjYIEEHmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwG31vZDtsnlfECzUfO88BfHHjJFcBuI5Cw+o9jzV/Sf1JrTz4O8ML+YBydKv2oP0WjgBs/d0OtMazBEOq7kW/mW3LMXdashnWH01eYbAh6cpk7kX0b/9ln0/75mHwtnajIPJJRebIOewSQwlz0R/Ny5KgQ/f1YudIFaBC1eh0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WpGY62GD2z9sSN;
	Tue, 20 Aug 2024 19:24:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8zCLHuRAKaCm; Tue, 20 Aug 2024 19:24:26 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WpGY55Xh8z9sSH;
	Tue, 20 Aug 2024 19:24:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id AF5518B763;
	Tue, 20 Aug 2024 19:24:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id vu3ggRc7gXuk; Tue, 20 Aug 2024 19:24:25 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.72])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 51E698B778;
	Tue, 20 Aug 2024 19:24:25 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: CASAUBON Jean Michel <jean-michel.casaubon@cs-soprasteria.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 01/14] powerpc/8xx: Fix initial memory mapping
Date: Tue, 20 Aug 2024 19:23:45 +0200
Message-ID: <dac7a828d8497c4548c91840575a706657baa4f1.1724173828.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1724173828.git.christophe.leroy@csgroup.eu>
References: <cover.1724173828.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724174647; l=1398; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=YSS0Z4TGY3GQo2hL9A1Rle4r3NsVDHe7D8HjYIEEHmg=; b=rJ+apkNytYuXWzZwrfzOPTHVel4446L8ztZ7RhbAawbvzWEAc9RqW4zTbHnviVla09/fj+Jun ZLC4A5NVQ13B5cqhq7Nc+1oaQqhvrMO6Dp7SKfdIrJUdSxWU56ZLA8N
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Commit cf209951fa7f ("powerpc/8xx: Map linear memory with huge pages")
introduced an initial mapping of kernel TEXT using PAGE_KERNEL_TEXT,
but the pages that contain kernel TEXT may also contain kernel RODATA,
and depending on selected debug options PAGE_KERNEL_TEXT may be either
RWX or ROX. RODATA must be writable during init because it also
contains ro_after_init data.

So use PAGE_KERNEL_X instead to be sure it is RWX.

Fixes: cf209951fa7f ("powerpc/8xx: Map linear memory with huge pages")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/nohash/8xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/nohash/8xx.c b/arch/powerpc/mm/nohash/8xx.c
index 388bba0ab3e7..15d918dce27d 100644
--- a/arch/powerpc/mm/nohash/8xx.c
+++ b/arch/powerpc/mm/nohash/8xx.c
@@ -150,11 +150,11 @@ unsigned long __init mmu_mapin_ram(unsigned long base, unsigned long top)
 
 	mmu_mapin_immr();
 
-	mmu_mapin_ram_chunk(0, boundary, PAGE_KERNEL_TEXT, true);
+	mmu_mapin_ram_chunk(0, boundary, PAGE_KERNEL_X, true);
 	if (debug_pagealloc_enabled_or_kfence()) {
 		top = boundary;
 	} else {
-		mmu_mapin_ram_chunk(boundary, einittext8, PAGE_KERNEL_TEXT, true);
+		mmu_mapin_ram_chunk(boundary, einittext8, PAGE_KERNEL_X, true);
 		mmu_mapin_ram_chunk(einittext8, top, PAGE_KERNEL, true);
 	}
 
-- 
2.44.0


