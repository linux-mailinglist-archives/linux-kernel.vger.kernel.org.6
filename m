Return-Path: <linux-kernel+bounces-294401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 633E3958D3B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 19:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B3BB2863E2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 17:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC2D1C37BB;
	Tue, 20 Aug 2024 17:24:50 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5561C0DCE
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 17:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724174690; cv=none; b=rtQTstxxyQ3A90dniFCgTH8K4Gpv3yJfTqtyfKmlkmhKzLB0mLeC880+taAuRRieIoouF4KksezBVVWiT5P7LFC0WYL9GfMyP2/lbErfSju1M596jMQI2QEIlMJVStoSJWK0FeBBByry1iV8VGVac4uWmOnbPLAdE4eRg7clStw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724174690; c=relaxed/simple;
	bh=MnJVIUH8gBw2ItnJCtn86iwo1JgIG33KKZWtd6UeGRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q7wEGVjOaM/ezWZ/Sf8pveNvrSO4R1jFnTFc625c6Ot13dn0VdYqmrDyuGS2s5gOmOEtsJnm2gn84jHeVwJjcBBW+1vEya1ZsdsI//yd8kavYHQst3KHRLO7W6XqYhex2JEu4VeBrX+qE67+vN6ymnCBq56GhW5XNq3CcSLIXLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WpGYB34Dzz9sSd;
	Tue, 20 Aug 2024 19:24:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QosinDhRYlkn; Tue, 20 Aug 2024 19:24:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WpGY72nwrz9sSL;
	Tue, 20 Aug 2024 19:24:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 508D18B778;
	Tue, 20 Aug 2024 19:24:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id WClfMNBcceqd; Tue, 20 Aug 2024 19:24:27 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.232.72])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E71248B763;
	Tue, 20 Aug 2024 19:24:26 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: CASAUBON Jean Michel <jean-michel.casaubon@cs-soprasteria.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 05/14] powerpc/8xx: Allow setting DATA alignment even with STRICT_KERNEL_RWX
Date: Tue, 20 Aug 2024 19:23:49 +0200
Message-ID: <d0d8b05012b392dd166cfd911f14ba2741ce7e1e.1724173828.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1724173828.git.christophe.leroy@csgroup.eu>
References: <cover.1724173828.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724174648; l=1669; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=MnJVIUH8gBw2ItnJCtn86iwo1JgIG33KKZWtd6UeGRA=; b=i0LQIPQjh0ILHZWRKNpsuMWRszOSoSW0trPtVV00cHStySE7KRks871e/W00P7Oe++H0Ab2XI vTKx3ozNw0PB6HdvsZAVFAvvGdBjaLHg/iVVKqGxM6rLtQNzT7TfAAx
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

It is now possible to not pin kernel text with a 8Mbytes TLB, so
the alignment for STRICT_KERNEL_RWX can be relaxed.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index d7b09b064a8a..3c202785a146 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -853,8 +853,8 @@ config DATA_SHIFT_BOOL
 	bool "Set custom data alignment"
 	depends on ADVANCED_OPTIONS
 	depends on STRICT_KERNEL_RWX || DEBUG_PAGEALLOC || KFENCE
-	depends on PPC_BOOK3S_32 || (PPC_8xx && !PIN_TLB_DATA && !STRICT_KERNEL_RWX) || \
-		   PPC_85xx
+	depends on (PPC_8xx && !PIN_TLB_DATA && (!STRICT_KERNEL_RWX || !PIN_TLB_TEXT)) || \
+		   PPC_BOOK3S_32 || PPC_85xx
 	help
 	  This option allows you to set the kernel data alignment. When
 	  RAM is mapped by blocks, the alignment needs to fit the size and
@@ -870,9 +870,9 @@ config DATA_SHIFT
 	range 20 24 if (STRICT_KERNEL_RWX || DEBUG_PAGEALLOC || KFENCE) && PPC_85xx
 	default 22 if STRICT_KERNEL_RWX && PPC_BOOK3S_32
 	default 18 if (DEBUG_PAGEALLOC || KFENCE) && PPC_BOOK3S_32
-	default 23 if STRICT_KERNEL_RWX && PPC_8xx
-	default 23 if (DEBUG_PAGEALLOC || KFENCE) && PPC_8xx && PIN_TLB_DATA
-	default 19 if (DEBUG_PAGEALLOC || KFENCE) && PPC_8xx
+	default 23 if (STRICT_KERNEL_RWX || DEBUG_PAGEALLOC || KFENCE) && PPC_8xx && \
+		      (PIN_TLB_DATA || PIN_TLB_TEXT)
+	default 19 if (STRICT_KERNEL_RWX || DEBUG_PAGEALLOC || KFENCE) && PPC_8xx
 	default 24 if STRICT_KERNEL_RWX && PPC_85xx
 	default PAGE_SHIFT
 	help
-- 
2.44.0


