Return-Path: <linux-kernel+bounces-318450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA5696EE34
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 10:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CE141C23DFD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 08:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73052158216;
	Fri,  6 Sep 2024 08:34:01 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311AE158205
	for <linux-kernel@vger.kernel.org>; Fri,  6 Sep 2024 08:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725611641; cv=none; b=Mj8tD20P6DZElWgZXxigC7Toexya9Lzv7LjZtoAD1hlNE1HTN1N5NcdoGxbLfcyRYtsdlUkjOZJ6veWdUQ5kBNWeDb6EbumcABdDyHY830BdYp2tt+jCCXqpLgZBH9UpPT7hueqiz/xhXxTSk/HhfSVakMxPRSFlmEpRpnXBahY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725611641; c=relaxed/simple;
	bh=k9FuvOEmK/1gQYxA9EMdGLyTvjpxpy8oRJUJTi/fyuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tO5Qvjf16ZB+z2IZADFLgCfMj1sy8VO3B9675+NbGM6UxGENkC6Hi7GLX6fhnm519dO8l7T5SfkhyKozNrfB9sceDJVL3nbsNAoflNs9soUzulUudIQh0HXDXpBpJdIW5YAUn2L4LKPIBcmDAM8l0jLcRm0ewd2HTmP7Uc4jKsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4X0Tz86SRrz9sRs;
	Fri,  6 Sep 2024 10:33:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LvZ6uifAMcER; Fri,  6 Sep 2024 10:33:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4X0Tz85Ztlz9sRr;
	Fri,  6 Sep 2024 10:33:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id ACDED8B77C;
	Fri,  6 Sep 2024 10:33:56 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id ZD8DcvanrHnh; Fri,  6 Sep 2024 10:33:56 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.235.70])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id E92688B764;
	Fri,  6 Sep 2024 10:33:55 +0200 (CEST)
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
Subject: [PATCH 1/2] powerpc/vdso: Fix VDSO data access when running in a non-root time namespace
Date: Fri,  6 Sep 2024 10:33:43 +0200
Message-ID: <700dbf296d02e32376329774be35cfbead08041d.1725611321.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725611624; l=3823; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=k9FuvOEmK/1gQYxA9EMdGLyTvjpxpy8oRJUJTi/fyuI=; b=nX3SmYIkJKIljITFXxDqbMnj5EJjUmmKYZfNZ9b9qaKQ+lctkvzNw/1Ss42lUZ48SFSTtdwZs EH3vr4+iyWCBtSGBkf7IpshNODLT7CY7pJ8qJa5FsxLxVwIxQt6MDwD
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

When running in a non-root time namespace, the global VDSO data page
is replaced by a dedicated namespace data page and the global data
page is mapped next to it. Detailed explanations can be found at
commit 660fd04f9317 ("lib/vdso: Prepare for time namespace support").

When it happens, __kernel_get_syscall_map and __kernel_get_tbfreq
and __kernel_sync_dicache don't work anymore because they read 0
instead of the data they need.

To address that, clock_mode has to be read. When it is set to
VDSO_CLOCKMODE_TIMENS, it means it is a dedicated namespace data page
and the global data is located on the following page.

Add a macro called get_realdatapage which reads clock_mode and add
PAGE_SIZE to the pointer provided by get_datapage macro when
clock_mode is equal to VDSO_CLOCKMODE_TIMENS. Use this new macro
instead of get_datapage macro except for time functions as they handle
it internally.

Fixes: 74205b3fc2ef ("powerpc/vdso: Add support for time namespaces")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/vdso_datapage.h | 15 +++++++++++++++
 arch/powerpc/kernel/asm-offsets.c        |  2 ++
 arch/powerpc/kernel/vdso/cacheflush.S    |  2 +-
 arch/powerpc/kernel/vdso/datapage.S      |  4 ++--
 4 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/vdso_datapage.h b/arch/powerpc/include/asm/vdso_datapage.h
index e17500c5237e..248dee138f7b 100644
--- a/arch/powerpc/include/asm/vdso_datapage.h
+++ b/arch/powerpc/include/asm/vdso_datapage.h
@@ -113,6 +113,21 @@ extern struct vdso_arch_data *vdso_data;
 	addi	\ptr, \ptr, (_vdso_datapage - 999b)@l
 .endm
 
+#include <asm/asm-offsets.h>
+#include <asm/page.h>
+
+.macro get_realdatapage ptr scratch
+	get_datapage \ptr
+#ifdef CONFIG_TIME_NS
+	lwz	\scratch, VDSO_CLOCKMODE_OFFSET(\ptr)
+	xoris	\scratch, \scratch, VDSO_CLOCKMODE_TIMENS@h
+	xori	\scratch, \scratch, VDSO_CLOCKMODE_TIMENS@l
+	cntlzw	\scratch, \scratch
+	rlwinm	\scratch, \scratch, PAGE_SHIFT - 5, 1 << PAGE_SHIFT
+	add	\ptr, \ptr, \scratch
+#endif
+.endm
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index eedb2e04c785..131a8cc10dbe 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -347,6 +347,8 @@ int main(void)
 #else
 	OFFSET(CFG_SYSCALL_MAP32, vdso_arch_data, syscall_map);
 #endif
+	OFFSET(VDSO_CLOCKMODE_OFFSET, vdso_arch_data, data[0].clock_mode);
+	DEFINE(VDSO_CLOCKMODE_TIMENS, VDSO_CLOCKMODE_TIMENS);
 
 #ifdef CONFIG_BUG
 	DEFINE(BUG_ENTRY_SIZE, sizeof(struct bug_entry));
diff --git a/arch/powerpc/kernel/vdso/cacheflush.S b/arch/powerpc/kernel/vdso/cacheflush.S
index 0085ae464dac..3b2479bd2f9a 100644
--- a/arch/powerpc/kernel/vdso/cacheflush.S
+++ b/arch/powerpc/kernel/vdso/cacheflush.S
@@ -30,7 +30,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 #ifdef CONFIG_PPC64
 	mflr	r12
   .cfi_register lr,r12
-	get_datapage	r10
+	get_realdatapage	r10, r11
 	mtlr	r12
   .cfi_restore	lr
 #endif
diff --git a/arch/powerpc/kernel/vdso/datapage.S b/arch/powerpc/kernel/vdso/datapage.S
index db8e167f0166..2b19b6201a33 100644
--- a/arch/powerpc/kernel/vdso/datapage.S
+++ b/arch/powerpc/kernel/vdso/datapage.S
@@ -28,7 +28,7 @@ V_FUNCTION_BEGIN(__kernel_get_syscall_map)
 	mflr	r12
   .cfi_register lr,r12
 	mr.	r4,r3
-	get_datapage	r3
+	get_realdatapage	r3, r11
 	mtlr	r12
 #ifdef __powerpc64__
 	addi	r3,r3,CFG_SYSCALL_MAP64
@@ -52,7 +52,7 @@ V_FUNCTION_BEGIN(__kernel_get_tbfreq)
   .cfi_startproc
 	mflr	r12
   .cfi_register lr,r12
-	get_datapage	r3
+	get_realdatapage	r3, r11
 #ifndef __powerpc64__
 	lwz	r4,(CFG_TB_TICKS_PER_SEC + 4)(r3)
 #endif
-- 
2.44.0


