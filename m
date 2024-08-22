Return-Path: <linux-kernel+bounces-296853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D533F95AFCE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 10:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1E128432E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 08:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F587165F11;
	Thu, 22 Aug 2024 08:00:45 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032AE19470
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 08:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724313644; cv=none; b=OR8/10+B6q6USW4KFrdkZZ4F+PNVxciiWRpOZJYufzPUdT/SaMT0DxG1E5ucM9GIsoSt1ATPBCea0sC7v78664jCiTv0zasmmLfSv3EEZEw/syuMW6yIw77+M3ncK/tmc0s1jY5EeJLtHATXmgNBwf9cBt4SpNYOBMFD44GS+dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724313644; c=relaxed/simple;
	bh=rrrUZCQkoW42KfO5zUMJhblysTPTkiUgjbqwdFHw7PA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RWLClNhCBoGRQQqyzxAS4ikh0Plg2zNYKNW0EceaCE53NS5FKtajgDecPQhGecRb413EApBW6htGba2Vm0xUDXPPdaMQsQjodNg4PTsAtyIwUkVpGxBklwLeP9SAcd77aWRU14uA4sRiUY3jbhcq2UFlP1515sdzwiP4VRbczXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WqFxh2mFHz9sSd;
	Thu, 22 Aug 2024 10:00:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bz4vllCOsi4r; Thu, 22 Aug 2024 10:00:40 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WqFxh23Prz9sSV;
	Thu, 22 Aug 2024 10:00:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 375878B77D;
	Thu, 22 Aug 2024 10:00:40 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id CSZ3UMcFKhXU; Thu, 22 Aug 2024 10:00:40 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (PO16920.IDSI0.si.c-s.fr [192.168.232.181])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id CE0998B763;
	Thu, 22 Aug 2024 10:00:39 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/vdso: Inconditionally use CFUNC macro
Date: Thu, 22 Aug 2024 10:00:29 +0200
Message-ID: <0fa863f2f69b2ca4094ae066fcf1430fb31110c9.1724313540.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724313630; l=930; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=rrrUZCQkoW42KfO5zUMJhblysTPTkiUgjbqwdFHw7PA=; b=zFJhWtwIybjy7bcT0PiHyvg316u3A4EuZLO4kFT5bztoTDF9PRjy9tMvWdvggWo42+NLpRZrK oEa1ZjP9a0xBmvWvXktS6/TIhg7rBxHu87F8XmgW828BYxpxfmjdNH9
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

During merge of commit 4e991e3c16a3 ("powerpc: add CFUNC assembly
label annotation") a fallback version of CFUNC macro was added at
the last minute, so it can be used inconditionally.

Fixes: 4e991e3c16a3 ("powerpc: add CFUNC assembly label annotation")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/vdso/gettimeofday.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/kernel/vdso/gettimeofday.S b/arch/powerpc/kernel/vdso/gettimeofday.S
index 48fc6658053a..894cb939cd2b 100644
--- a/arch/powerpc/kernel/vdso/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso/gettimeofday.S
@@ -38,11 +38,7 @@
 	.else
 	addi		r4, r5, VDSO_DATA_OFFSET
 	.endif
-#ifdef __powerpc64__
 	bl		CFUNC(DOTSYM(\funct))
-#else
-	bl		\funct
-#endif
 	PPC_LL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
 #ifdef __powerpc64__
 	PPC_LL		r2, PPC_MIN_STKFRM + STK_GOT(r1)
-- 
2.44.0


