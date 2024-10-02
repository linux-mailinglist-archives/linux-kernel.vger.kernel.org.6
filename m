Return-Path: <linux-kernel+bounces-347168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1696C98CEF4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 10:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BCFFB21FE9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 08:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC7C1974EA;
	Wed,  2 Oct 2024 08:39:40 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C81F46BA
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 08:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727858380; cv=none; b=TmfFMMakm3X5ivBubXgTSYPivs1aiIBG7Abfuann4HSf+1efbHgOQSdhUshrp6WI76CoB+wbNSwu86vjXcNldDGj2XpKMvDKg+XGDpS7It85PtuDpfv4V/IibB7PSKKdpTqCyGNQX7+urf1H35kESPUPpDFqKgmzIqm8E7goDs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727858380; c=relaxed/simple;
	bh=JzDBdvC4YvowjeOLvmzIUrVV6f0CO+QwXA1RW6itCK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VsKk710AcH8F6ivV2AuAAP2YFYWNx6ndCW+vGAlEam3gfesCnyHGPydZTr7VWJ2dYTiQHraC/yoM4R96hWZgvTlY2kKHsDrjOCY7uqvfjsqhCJM3p6fDic1jrgUj/LT4JoFXo9U2dfKgSAjGOWtZxbT3arEm9abY0UV/6ZXBQbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4XJSsb6nN6z9sRk;
	Wed,  2 Oct 2024 10:39:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2DmTPm4dC-nN; Wed,  2 Oct 2024 10:39:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4XJSsb5lcvz9rvV;
	Wed,  2 Oct 2024 10:39:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id B41E48B766;
	Wed,  2 Oct 2024 10:39:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id dXdr3hYcVVcU; Wed,  2 Oct 2024 10:39:31 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.39])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 628228B763;
	Wed,  2 Oct 2024 10:39:31 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Jason@zx2c4.com
Subject: [PATCH 2/2] powerpc/vdso: Implement __arch_get_vdso_rng_data()
Date: Wed,  2 Oct 2024 10:39:29 +0200
Message-ID: <a1a9bd0df508f1b5c04684b7366940577dfc6262.1727858295.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <0557d3ec898c1d0ea2fc59fa8757618e524c5d94.1727858295.git.christophe.leroy@csgroup.eu>
References: <0557d3ec898c1d0ea2fc59fa8757618e524c5d94.1727858295.git.christophe.leroy@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727858369; l=4123; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=JzDBdvC4YvowjeOLvmzIUrVV6f0CO+QwXA1RW6itCK4=; b=CAJXwT5W+IyMvgWwGaVWRrGQ63Iatp6sYeqEWkqxDbP9BeHK2vTNxlaV6/k9wbD/bBhApWu+e QeOcmy3vUglAXXM/9X579wHXS7HCDY9J42QCgw99FfXRS6NaSiZTyit
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

VDSO time functions do not call any other function, so they don't
need to save/restore LR. However, retrieving the address of VDSO data
page requires using LR hence saving then restoring it, which can be
heavy on some CPUs. On the other hand, VDSO functions on powerpc are
not standard functions and require a wrapper function to call C VDSO
functions. And that wrapper has to save and restore LR in order to
call the C VDSO function, so retrieving VDSO data page address in that
wrapper doesn't require additional save/restore of LR.

For random VDSO functions it is a bit different. Because the function
calls __arch_chacha20_blocks_nostack(), it saves and restores LR.
Retrieving VDSO data page address can then be done there without
additional save/restore of LR.

So lets implement __arch_get_vdso_rng_data() and simplify the wrapper.

It starts paving the way for the day powerpc will implement a more
standard ABI for VDSO functions.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/vdso/getrandom.h | 15 +++++++++++++--
 arch/powerpc/kernel/asm-offsets.c         |  1 -
 arch/powerpc/kernel/vdso/getrandom.S      |  1 -
 arch/powerpc/kernel/vdso/vgetrandom.c     |  4 ++--
 4 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/vdso/getrandom.h b/arch/powerpc/include/asm/vdso/getrandom.h
index 501d6bb14e8a..4302e7c67aa5 100644
--- a/arch/powerpc/include/asm/vdso/getrandom.h
+++ b/arch/powerpc/include/asm/vdso/getrandom.h
@@ -7,6 +7,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <asm/vdso_datapage.h>
+
 static __always_inline int do_syscall_3(const unsigned long _r0, const unsigned long _r3,
 					const unsigned long _r4, const unsigned long _r5)
 {
@@ -43,11 +45,20 @@ static __always_inline ssize_t getrandom_syscall(void *buffer, size_t len, unsig
 
 static __always_inline struct vdso_rng_data *__arch_get_vdso_rng_data(void)
 {
-	return NULL;
+	struct vdso_arch_data *data;
+
+	asm(
+		"	bcl	20, 31, .+4\n"
+		"0:	mflr	%0\n"
+		"	addis	%0, %0, (_vdso_datapage - 0b)@ha\n"
+		"	addi	%0, %0, (_vdso_datapage - 0b)@l\n"
+	: "=r" (data) :: "lr");
+
+	return &data->rng_data;
 }
 
 ssize_t __c_kernel_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state,
-			     size_t opaque_len, const struct vdso_rng_data *vd);
+			     size_t opaque_len);
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 131a8cc10dbe..7b3feb6bc210 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -335,7 +335,6 @@ int main(void)
 
 	/* datapage offsets for use by vdso */
 	OFFSET(VDSO_DATA_OFFSET, vdso_arch_data, data);
-	OFFSET(VDSO_RNG_DATA_OFFSET, vdso_arch_data, rng_data);
 	OFFSET(CFG_TB_TICKS_PER_SEC, vdso_arch_data, tb_ticks_per_sec);
 #ifdef CONFIG_PPC64
 	OFFSET(CFG_ICACHE_BLOCKSZ, vdso_arch_data, icache_block_size);
diff --git a/arch/powerpc/kernel/vdso/getrandom.S b/arch/powerpc/kernel/vdso/getrandom.S
index 3deddcf89f99..a80d9fb436f7 100644
--- a/arch/powerpc/kernel/vdso/getrandom.S
+++ b/arch/powerpc/kernel/vdso/getrandom.S
@@ -31,7 +31,6 @@
 	PPC_STL		r2, PPC_MIN_STKFRM + STK_GOT(r1)
   .cfi_rel_offset r2, PPC_MIN_STKFRM + STK_GOT
 #endif
-	get_datapage	r8 VDSO_RNG_DATA_OFFSET
 	bl		CFUNC(DOTSYM(\funct))
 	PPC_LL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
 #ifdef __powerpc64__
diff --git a/arch/powerpc/kernel/vdso/vgetrandom.c b/arch/powerpc/kernel/vdso/vgetrandom.c
index 5f855d45fb7b..cc79b960a541 100644
--- a/arch/powerpc/kernel/vdso/vgetrandom.c
+++ b/arch/powerpc/kernel/vdso/vgetrandom.c
@@ -8,7 +8,7 @@
 #include <linux/types.h>
 
 ssize_t __c_kernel_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state,
-			     size_t opaque_len, const struct vdso_rng_data *vd)
+			     size_t opaque_len)
 {
-	return __cvdso_getrandom_data(vd, buffer, len, flags, opaque_state, opaque_len);
+	return __cvdso_getrandom(buffer, len, flags, opaque_state, opaque_len);
 }
-- 
2.44.0


