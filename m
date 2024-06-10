Return-Path: <linux-kernel+bounces-207709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0BE901AB5
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 771DEB23727
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 05:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7A26F311;
	Mon, 10 Jun 2024 05:56:03 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08D673453
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 05:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717998963; cv=none; b=R2m4OVOF78/hWC8uak71Ym/WvV01IBvWGERsR0gRH7Lr7jp43GM8brSshuzRxXNL3Ebjht9/CWZdcMN+hbLMXlS85vfk5P8OqNvnw/g0uWANCQEshX0ByMz5ORp54gROHx1F5aKpx9BAja+y7Z7qNzccq89g5wolFUa/5TumctM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717998963; c=relaxed/simple;
	bh=lXkJFaNOZfYs39NvzB2t7aMNQd5E4EiqpUUgx2rbgYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j/E/QVNefy4WTfbSguSS5aKu1tnzJXwrtr+WCzqnE2QUCvc4301VoIC/EL92E7SLkNWWpszMKCBQML0C5T6sCMaUgNPX7r3y6cxyz3ep5ceKdtmFg/1DAwdInBWN+4IypAxirOd5d2vJ0FLDpOYk5vtEpC2iS90s849fe22ZNY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4VyLcZ3yQqz9v6q;
	Mon, 10 Jun 2024 07:55:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n_D9Qep5mycJ; Mon, 10 Jun 2024 07:55:10 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4VyLcL6RHvz9v6s;
	Mon, 10 Jun 2024 07:54:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id D88528B76C;
	Mon, 10 Jun 2024 07:54:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id r7jHJNprZhwF; Mon, 10 Jun 2024 07:54:58 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id BC2468B764;
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
Subject: [PATCH v5 13/18] powerpc/e500: Don't pre-check write access on data TLB error
Date: Mon, 10 Jun 2024 07:54:58 +0200
Message-ID: <0780765a5886c138237cd5dff261ba3dc2fa0c3e.1717955559.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1717955558.git.christophe.leroy@csgroup.eu>
References: <cover.1717955558.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717998887; l=1564; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=lXkJFaNOZfYs39NvzB2t7aMNQd5E4EiqpUUgx2rbgYk=; b=fyJyaGlU5NvFz815btq/r5inIMAyEky/CE3RqaurfPadYazgPcX4AA+lxvS+wpiUIvBnwvv7O C0F9qRxXucpC1wTeclXpfTB9p5U430ODMwWXulaA1tSIAx1FXouEuLP
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Don't pre-check write access on read-only pages on data TLB error.

Load the TLB anyway and take a DSI exception when it happens. This
avoids reading SPRN_ESR at every data TLB error exception.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v5: New
---
 arch/powerpc/kernel/head_85xx.S | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/powerpc/kernel/head_85xx.S b/arch/powerpc/kernel/head_85xx.S
index a305244afc9f..282e49c51deb 100644
--- a/arch/powerpc/kernel/head_85xx.S
+++ b/arch/powerpc/kernel/head_85xx.S
@@ -472,27 +472,12 @@ END_BTB_FLUSH_SECTION
 #endif
 
 4:
-	/* Mask of required permission bits. Note that while we
-	 * do copy ESR:ST to _PAGE_WRITE position as trying to write
-	 * to an RO page is pretty common, we don't do it with
-	 * _PAGE_DIRTY. We could do it, but it's a fairly rare
-	 * event so I'd rather take the overhead when it happens
-	 * rather than adding an instruction here. We should measure
-	 * whether the whole thing is worth it in the first place
-	 * as we could avoid loading SPRN_ESR completely in the first
-	 * place...
-	 *
-	 * TODO: Is it worth doing that mfspr & rlwimi in the first
-	 *       place or can we save a couple of instructions here ?
-	 */
-	mfspr	r12,SPRN_ESR
 #ifdef CONFIG_PTE_64BIT
 	li	r13,_PAGE_PRESENT|_PAGE_BAP_SR
 	oris	r13,r13,_PAGE_ACCESSED@h
 #else
 	li	r13,_PAGE_PRESENT|_PAGE_READ|_PAGE_ACCESSED
 #endif
-	rlwimi	r13,r12,11,29,29
 
 	FIND_PTE
 	andc.	r13,r13,r11		/* Check permission */
-- 
2.44.0


