Return-Path: <linux-kernel+bounces-294974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C2B9594F8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 08:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D901C211FC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 06:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABD52139B2;
	Wed, 21 Aug 2024 06:48:00 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D6F2139A2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 06:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724222879; cv=none; b=BlNqztvg8Bbx4wX5NC2s2HKTCzna9bC4qGwfUbfoEodbfNPw7NPejL0rLQPmAypL2WAJs9Bjrhjn4FYFouHOC9iqUvVD/CH7tvWAv013tpN17ornMMeebPNc6EvXC9IhyI33wOBXq4SZsj18OvnW6zu//6ejHccWvOR+ZFYD0R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724222879; c=relaxed/simple;
	bh=QzA1iwpdIWaUpbbbRXkE+PetQ+6HUMW3FsrcPJprMhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o4OUrDWtIxW9lgKt+oaccH+t9ESmaUH5H99oji0YNWpmbdhwFUPzDHyXFOzHmf6HIWtMXLsftWrdxZQGPgQWvDlTx66TItEqDzivKIh3JKKNuM9F4b0FZia9XWeQIOR4l4UmJO567cJ5StiC5r6ErWIoviKrdqy+p4wVOwH80RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4WpcN82Jcxz9sSL;
	Wed, 21 Aug 2024 08:47:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qc2-O7sfsnYc; Wed, 21 Aug 2024 08:47:52 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4WpcN81cTSz9sSK;
	Wed, 21 Aug 2024 08:47:52 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 28BBC8B778;
	Wed, 21 Aug 2024 08:47:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id Jv9pzxhi_2wt; Wed, 21 Aug 2024 08:47:52 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 07DC78B763;
	Wed, 21 Aug 2024 08:47:52 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Remove LHZX_BE macro
Date: Wed, 21 Aug 2024 08:47:51 +0200
Message-ID: <fd332b01c47bb9cb6c3af1696a2e109be655f5b5.1724222856.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724222871; l=929; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=QzA1iwpdIWaUpbbbRXkE+PetQ+6HUMW3FsrcPJprMhM=; b=8iRP43m8ZL0jcO70Bsi7+2lojNQMCS/Vvqf4b5qQeMWKdybzhsOeHxKfIbRd4ZDb8LAB4R3Zc aOHtIj+eQ5XC4J0kCEAxtxPc1eZTCDAXz8LIcC/h/ewVzeenJp/sVGm
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

LHZX_BE has been unused since commit dbf44daf7c88 ("bpf, ppc64: remove
ld_abs/ld_ind")

Remove it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/asm-compat.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/include/asm/asm-compat.h b/arch/powerpc/include/asm/asm-compat.h
index 2bc53c646ccd..b0b209c1df50 100644
--- a/arch/powerpc/include/asm/asm-compat.h
+++ b/arch/powerpc/include/asm/asm-compat.h
@@ -26,13 +26,11 @@
 #define PPC_MIN_STKFRM	112
 
 #ifdef __BIG_ENDIAN__
-#define LHZX_BE	stringify_in_c(lhzx)
 #define LWZX_BE	stringify_in_c(lwzx)
 #define LDX_BE	stringify_in_c(ldx)
 #define STWX_BE	stringify_in_c(stwx)
 #define STDX_BE	stringify_in_c(stdx)
 #else
-#define LHZX_BE	stringify_in_c(lhbrx)
 #define LWZX_BE	stringify_in_c(lwbrx)
 #define LDX_BE	stringify_in_c(ldbrx)
 #define STWX_BE	stringify_in_c(stwbrx)
-- 
2.44.0


