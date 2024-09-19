Return-Path: <linux-kernel+bounces-333774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B8C97CDDD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 20:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE7711F23E53
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 18:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05B261F5E6;
	Thu, 19 Sep 2024 18:56:40 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E834918AEA
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 18:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726772199; cv=none; b=jgQKDGcL6+i+EeKc6Niv5AiicJLkj+xLwagHQ64FO3Yrgkmkd5hG8SsTR/U83uL99AAJXWN/5pz63NnGsv2VBIgWY2QLWlr+Q+vYLTiiGQb3laZuT9uMgE3j2N3JCs3ZmCDUp1IuzBW1NWLb6sxb4q6td3cGpkjI5uwQYMy4s6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726772199; c=relaxed/simple;
	bh=Ixprgg6LkwtGPXf5sq+EpdCerjqIvCA498WKeSc8mhw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tTX2NyDprZsrD2JYcKnN0iP7EK/mVMpJ1LTLuBES7EFiQQMfubtePqR0dh5kZzXpiLpDEy7h68Jlqe3R90fckKSpchtakjthtJO7L5DMyXZ6aeb3Vac6mcu1RmVOXMDu2T9FB4oX0bq3XP6Lquo+47POPGuQRzzKKysmkGVL7YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4X8l9T6Pm8z9tQt;
	Thu, 19 Sep 2024 20:56:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xu1xsNImuLeA; Thu, 19 Sep 2024 20:56:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4X8l9T5cQTz9tQs;
	Thu, 19 Sep 2024 20:56:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id AD9F18B77E;
	Thu, 19 Sep 2024 20:56:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id zfBuktewYKi7; Thu, 19 Sep 2024 20:56:29 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.234.38])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 410F78B77D;
	Thu, 19 Sep 2024 20:56:29 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: "Jason A . Donenfeld" <Jason@zx2c4.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: [PATCH] powerpc/vdso32: Fix use of crtsavres for PPC64
Date: Thu, 19 Sep 2024 20:55:57 +0200
Message-ID: <aded2b257018fe654db759fdfa4ab1a0b5426b1b.1726772140.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726772181; l=1070; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=Ixprgg6LkwtGPXf5sq+EpdCerjqIvCA498WKeSc8mhw=; b=5VKYFxFvFtbMuepxvehhrD2IPe9sgUYcgB8FAAa8ZN81yL6OwdYmrJznlodbv3Jy/bn91Jw6/ uwwsU639hEADF5RqWOrLWHtp8l3nvykjoH5v1k/XhW5QrjQWV0cB+aV
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

crtsavres.S content is encloded by a #ifndef CONFIG_PPC64

To be used on VDSO32 on PPC64 it's content must available on PPC64 as
well.

Replace #ifndef CONFIG_PPC64 by #ifndef __powerpc64__ as __powerpc64__
is not set when building VDSO32 on PPC64.

Reported-by: Christian Zigotzky <chzigotzky@xenosoft.de>
Closed: https://lore.kernel.org/linuxppc-dev/047b7503-af0c-4bb0-b12a-2f6b1e461752@csgroup.eu/T/
Fixes: b163596a5b6f ("powerpc/vdso32: Add crtsavres")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/lib/crtsavres.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/crtsavres.S b/arch/powerpc/lib/crtsavres.S
index 7e5e1c28e56a..8967903c15e9 100644
--- a/arch/powerpc/lib/crtsavres.S
+++ b/arch/powerpc/lib/crtsavres.S
@@ -46,7 +46,7 @@
 
 	.section ".text"
 
-#ifndef CONFIG_PPC64
+#ifndef __powerpc64__
 
 /* Routines for saving integer registers, called by the compiler.  */
 /* Called with r11 pointing to the stack header word of the caller of the */
-- 
2.44.0


