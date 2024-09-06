Return-Path: <linux-kernel+bounces-318451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5E596EE35
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBE171C23F3F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9355D158A1F;
	Fri,  6 Sep 2024 08:34:06 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90492158205
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611646; cv=none; b=jlopFciaBm8sIXSGI4GnPGFkzzEDRRw7vH14kdHlUvm+E1Ag1XCM8LbG6eGOeXdm88o++HhK8wIybTDIdKt5U+vQLgPn7WrSlGwX8eqPqmbnJdx5vBagDlJ8gwVnvTABQLUrMC3ckOGclScgpopSIEiIYYcd0amMiLwj4sP3118=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611646; c=relaxed/simple;
	bh=/x35oQvh5k9BBpuokbemChsJLjrttc1Fa44tLuwAFfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L0PBqbcXgB1gl0ikE66yaUz/5WiMhSznPRF3FW4lGBPhyMbZD4fUv1acBfZFqFqp7rb0pucjUSt5Ya3vKpeK0NpvN3w40hga7uYeb0vfpbyyAMY1zELPdDpAocK/wMRQJ4mD2ncURLqX/lfv9hYUIxWjFj427lcv9yhHp2DUmwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4X0Tz94Jn1z9sRy;
	Fri,  6 Sep 2024 10:33:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TG1PLnKkNXF4; Fri,  6 Sep 2024 10:33:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4X0Tz93Vpdz9sRr;
	Fri,  6 Sep 2024 10:33:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 699B78B764;
	Fri,  6 Sep 2024 10:33:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id VLDe3sqJRDYo; Fri,  6 Sep 2024 10:33:57 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.70])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id A81EB8B778;
	Fri,  6 Sep 2024 10:33:56 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Andrei Vagin <avagin@gmail.com>
Subject: [PATCH 2/2] Fixup for 3279be36b671 ("powerpc/vdso: Wire up getrandom() vDSO implementation on VDSO32")
Date: Fri,  6 Sep 2024 10:33:44 +0200
Message-ID: <ffd7fc255e194d1e2b0aa3d9d129e826c53219d4.1725611321.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <700dbf296d02e32376329774be35cfbead08041d.1725611321.git.christophe.leroy@csgroup.eu>
References: <700dbf296d02e32376329774be35cfbead08041d.1725611321.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725611624; l=744; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=/x35oQvh5k9BBpuokbemChsJLjrttc1Fa44tLuwAFfM=; b=6AyXhA5x8UZSu669tkJkKDz05fAfvHARHPnGBuOcxmLsRUSQZjSVlBinNk/3LziSPIHodw8YT aqVJFistZ+yA8GVNsGzoeVOdDkyVE+7aaFPvHHqGvviH98kG7qziZXJ
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

Use the new get_realdatapage macro instead of get_datapage

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/vdso/getrandom.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/vdso/getrandom.S b/arch/powerpc/kernel/vdso/getrandom.S
index a957cd2b2b03..f3bbf931931c 100644
--- a/arch/powerpc/kernel/vdso/getrandom.S
+++ b/arch/powerpc/kernel/vdso/getrandom.S
@@ -31,7 +31,7 @@
 	PPC_STL		r2, PPC_MIN_STKFRM + STK_GOT(r1)
   .cfi_rel_offset r2, PPC_MIN_STKFRM + STK_GOT
 #endif
-	get_datapage	r8
+	get_realdatapage	r8, r11
 	addi		r8, r8, VDSO_RNG_DATA_OFFSET
 	bl		CFUNC(DOTSYM(\funct))
 	PPC_LL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
-- 
2.44.0


