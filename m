Return-Path: <linux-kernel+bounces-327640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 325269778B0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 08:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C3321C2128F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 06:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EFB1AD241;
	Fri, 13 Sep 2024 06:14:40 +0000 (UTC)
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C904B1A0BF6
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 06:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.235.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726208080; cv=none; b=J1oHQ1fXcijdCuKE7o76d7fIrrLzKLTfCRQGnHxmeCcv9a4ZhpPbMYcUWP3dSVx+HRfqISqmlUt4jDPoWryLKCdKOPBNDtZ//2lascIX45S21JRlPnwHW01aZvESEcZbohfr0UV2jp0NVFd7vhD7NeipTFFD8UuSXfEG8p6+b44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726208080; c=relaxed/simple;
	bh=ue4rH+i1tHnl4doLUOAue2Eqx2y0vQEBqittaq3A0AI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ud5AiwwkexXwau7MxSeyTIlunjsxCZSq7eHmi/LOZY9XTnwmcIvvr78v+CUSloKsmT5onOtuwElxXTz2EoWMcLlL+tGPt7YG6UGWqw8fM1BsRMuDh8HMh1mqib8nTomQG5DXmNDEIQW/VmM2VrXbgWHma/+d6robXis+qWJ6mtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.235.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
	by localhost (Postfix) with ESMTP id 4X4kY85Gs0z9sxD;
	Fri, 13 Sep 2024 08:14:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
	by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qFt_Fj9D9qCj; Fri, 13 Sep 2024 08:14:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase2.c-s.fr (Postfix) with ESMTP id 4X4kY848K4z9sx8;
	Fri, 13 Sep 2024 08:14:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 7D2EE8B77A;
	Fri, 13 Sep 2024 08:14:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id BwLdywYuVOlU; Fri, 13 Sep 2024 08:14:36 +0200 (CEST)
Received: from PO20335.idsi0.si.c-s.fr (unknown [192.168.233.70])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 1A8C68B766;
	Fri, 13 Sep 2024 08:14:36 +0200 (CEST)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Naveen N Rao <naveen@kernel.org>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH] powerpc/vdso: Should VDSO64 functions be flagged as functions like VDSO32 ?
Date: Fri, 13 Sep 2024 08:14:33 +0200
Message-ID: <6fa86f3de610ffc180ae0f5dbd511453e7473b36.1726208058.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726208074; l=3666; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=ue4rH+i1tHnl4doLUOAue2Eqx2y0vQEBqittaq3A0AI=; b=x1ACUxhbKyS0F6m6D9/E+pdOtiUKCKgyq+c+UoEIEdJ784NuDI8QVbGYviqXwWUzp2IixT2Nm TDxkPaan0lcDAJdyhnAPGE9uyUxA35gFhTayTPr9Glc2mlyJr+YYede
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

On powerpc64 as shown below by readelf, vDSO functions symbols have
type NOTYPE.

$ powerpc64-linux-gnu-readelf -a arch/powerpc/kernel/vdso/vdso64.so.dbg
ELF Header:
  Magic:   7f 45 4c 46 02 02 01 00 00 00 00 00 00 00 00 00
  Class:                             ELF64
  Data:                              2's complement, big endian
  Version:                           1 (current)
  OS/ABI:                            UNIX - System V
  ABI Version:                       0
  Type:                              DYN (Shared object file)
  Machine:                           PowerPC64
  Version:                           0x1
...

Symbol table '.dynsym' contains 12 entries:
   Num:    Value          Size Type    Bind   Vis      Ndx Name
...
     1: 0000000000000524    84 NOTYPE  GLOBAL DEFAULT    8 __[...]@@LINUX_2.6.15
...
     4: 0000000000000000     0 OBJECT  GLOBAL DEFAULT  ABS LINUX_2.6.15
     5: 00000000000006c0    48 NOTYPE  GLOBAL DEFAULT    8 __[...]@@LINUX_2.6.15

Symbol table '.symtab' contains 56 entries:
   Num:    Value          Size Type    Bind   Vis      Ndx Name
...
    45: 0000000000000000     0 OBJECT  GLOBAL DEFAULT  ABS LINUX_2.6.15
    46: 00000000000006c0    48 NOTYPE  GLOBAL DEFAULT    8 __kernel_getcpu
    47: 0000000000000524    84 NOTYPE  GLOBAL DEFAULT    8 __kernel_clock_getres

To overcome that, commit ba83b3239e65 ("selftests: vDSO: fix vDSO
symbols lookup for powerpc64") was proposed to make selftests also
look for NOTYPE symbols, but is it the correct fix ?

VDSO32 functions are flagged as functions, why not VDSO64 functions ?
Is it because VDSO functions are not traditional C functions using
the standard API ? But it is exactly the same for VDSO32 functions,
allthough they are flagged as functions.

So lets flag them as functions and revert the selftest change.

What's your opinion on that ?

It predates git kernel history and both VDSO32 and VDSO64 were brough by
arch/ppc64/ with that difference already.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
commit ba83b3239e65 is in random git tree at the moment : https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git/commit/?id=ba83b3239e657469709d15dcea5f9b65bf9dbf34
On the list at : https://lore.kernel.org/lkml/fc1a0862516b1e11b336d409f2cb8aab10a97337.1725020674.git.christophe.leroy@csgroup.eu/T/#u
---
 arch/powerpc/include/asm/vdso.h           | 1 +
 tools/testing/selftests/vDSO/parse_vdso.c | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/vdso.h b/arch/powerpc/include/asm/vdso.h
index 7650b6ce14c8..8d972bc98b55 100644
--- a/arch/powerpc/include/asm/vdso.h
+++ b/arch/powerpc/include/asm/vdso.h
@@ -25,6 +25,7 @@ int vdso_getcpu_init(void);
 #ifdef __VDSO64__
 #define V_FUNCTION_BEGIN(name)		\
 	.globl name;			\
+	.type name,@function; 		\
 	name:				\
 
 #define V_FUNCTION_END(name)		\
diff --git a/tools/testing/selftests/vDSO/parse_vdso.c b/tools/testing/selftests/vDSO/parse_vdso.c
index d9ccc5acac18..4ae417372e9e 100644
--- a/tools/testing/selftests/vDSO/parse_vdso.c
+++ b/tools/testing/selftests/vDSO/parse_vdso.c
@@ -216,8 +216,7 @@ void *vdso_sym(const char *version, const char *name)
 		ELF(Sym) *sym = &vdso_info.symtab[chain];
 
 		/* Check for a defined global or weak function w/ right name. */
-		if (ELF64_ST_TYPE(sym->st_info) != STT_FUNC &&
-		    ELF64_ST_TYPE(sym->st_info) != STT_NOTYPE)
+		if (ELF64_ST_TYPE(sym->st_info) != STT_FUNC)
 			continue;
 		if (ELF64_ST_BIND(sym->st_info) != STB_GLOBAL &&
 		    ELF64_ST_BIND(sym->st_info) != STB_WEAK)
-- 
2.44.0


