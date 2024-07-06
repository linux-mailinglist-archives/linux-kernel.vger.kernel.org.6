Return-Path: <linux-kernel+bounces-243095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD0D92918D
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 09:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 374561F221E7
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 07:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320AC24205;
	Sat,  6 Jul 2024 07:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="PU7FsXvS"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C077B22EE4
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 07:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720251583; cv=none; b=HcbZbflnBVf1Z/nuVmOiodrw/XlHxaBRpRvAwFUELPjhl54SpJLGqJtd4IrG55hi56e8HckuWxdXyR5kNbX7QpJZ4Eyesr16ZTP5+jAM3vZAyzJch+XPbe69fOxvkftMaKL+XbdGYMGjnuc2stN9IEbUUPjbCX/gwSjT7F7/Q5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720251583; c=relaxed/simple;
	bh=MvAhHD0mCFd5HZCn7eaIcksLlpWJk6ZfkvX77KevoqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AuNuJWE2g7Ju8KBAzklZumirzfdgO2cwUdOKeVw16pTHpLpd/PsVGPo/lumG54dlqUehrxDd72+cBJ1wxn89mMNWY7qoZaDqFMa8CF/NdcZa/vIgy1w1TyHgiZxx70jYUUaFJGxFQQNjRPXyDKcPf4Lizu5aqv2/EnPuF0IzaPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=PU7FsXvS; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1720251580;
	bh=MvAhHD0mCFd5HZCn7eaIcksLlpWJk6ZfkvX77KevoqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PU7FsXvSa73P3jBx11/rXs5xlAqHGkfOzWv+fP8AACXxeqbQREvwfuhPB63zd6HKb
	 vHYQjJ31XQUtItkh2frJwIGG8cRo+xlqYDIzho2wc955dWUJB6CbYUt3AZIwdT51DL
	 Ty5HsNGWA1waap/XklxtSF09HwNEqcvJlir6FTwA=
Received: from stargazer.. (unknown [IPv6:240e:358:11fb:d500:dc73:854d:832e:4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id CC6011A411D;
	Sat,  6 Jul 2024 03:39:35 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>
Cc: Jinyang He <hejinyang@loongson.cn>,
	Youling Tang <tangyouling@kylinos.cn>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Fangrui Song <maskray@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH 2/2] LoongArch: Add support for relocating the kernel with RELR relocation
Date: Sat,  6 Jul 2024 15:38:58 +0800
Message-ID: <20240706073858.161035-2-xry111@xry111.site>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240706073858.161035-1-xry111@xry111.site>
References: <20240706073858.161035-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RELR as a relocation packing format for relative relocations for
reducing the size of relative relocation records.  In a position
independent executable there are often many relative relocation
records, and our vmlinux is a PIE.

The LLD linker (since 17.0.0) and the BFD linker (since 2.43) supports
packing the relocations in the RELR format for LoongArch, with the flag
-z pack-relative-relocs.

Commits 5cf896fb6be3
("arm64: Add support for relocating the kernel with RELR relocations")
and ccb2d173b983
("Makefile: use -z pack-relative-relocs") have already added the
framework to use RELR.  We just need to wire it up and process the RELR
relocation records in relocate_relative() in addition to the RELA
relocation records.

A ".p2align 3" directive is added to la_abs macro or the BFD linker
cannot pack the relocation records against the .la_abs section (the
". = ALIGN(8);" directive in vmlinux.lds.S is too late in the linking
process).

With defconfig and CONFIG_RELR vmlinux.efi is 2.1 MiB (6%) smaller, and
vmlinuz.efi (using gzip compression) is 384 KiB (2.8%) smaller.

Link: https://groups.google.com/d/topic/generic-abi/bX460iggiKg
Link: https://reviews.llvm.org/D138135#4531389
Link: https://sourceware.org/git/?p=binutils-gdb.git;a=commit;h=d89ecf33ab6d
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/Kconfig                |  1 +
 arch/loongarch/include/asm/asmmacro.h |  1 +
 arch/loongarch/include/asm/setup.h    |  5 +++++
 arch/loongarch/kernel/relocate.c      | 18 ++++++++++++++++++
 arch/loongarch/kernel/vmlinux.lds.S   |  8 ++++++++
 5 files changed, 33 insertions(+)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index ddc042895d01..03b3ef5edd24 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -607,6 +607,7 @@ config ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION
 
 config RELOCATABLE
 	bool "Relocatable kernel"
+	select ARCH_HAS_RELR
 	help
 	  This builds the kernel as a Position Independent Executable (PIE),
 	  which retains all relocation metadata required, so as to relocate
diff --git a/arch/loongarch/include/asm/asmmacro.h b/arch/loongarch/include/asm/asmmacro.h
index 655db7d7a427..8d7f501b0a12 100644
--- a/arch/loongarch/include/asm/asmmacro.h
+++ b/arch/loongarch/include/asm/asmmacro.h
@@ -609,6 +609,7 @@
 	lu32i.d	\reg, 0
 	lu52i.d	\reg, \reg, 0
 	.pushsection ".la_abs", "aw", %progbits
+	.p2align 3
 	.dword	766b
 	.dword	\sym
 	.popsection
diff --git a/arch/loongarch/include/asm/setup.h b/arch/loongarch/include/asm/setup.h
index ee52fb1e9963..3c2fb16b11b6 100644
--- a/arch/loongarch/include/asm/setup.h
+++ b/arch/loongarch/include/asm/setup.h
@@ -34,6 +34,11 @@ extern long __la_abs_end;
 extern long __rela_dyn_begin;
 extern long __rela_dyn_end;
 
+#ifdef CONFIG_RELR
+extern long __relr_dyn_begin;
+extern long __relr_dyn_end;
+#endif
+
 extern unsigned long __init relocate_kernel(void);
 
 #endif
diff --git a/arch/loongarch/kernel/relocate.c b/arch/loongarch/kernel/relocate.c
index 69d73dc7326a..6abb9c91b255 100644
--- a/arch/loongarch/kernel/relocate.c
+++ b/arch/loongarch/kernel/relocate.c
@@ -37,6 +37,24 @@ static inline void __init relocate_relative(void)
 		relocated_addr = (Elf64_Addr)RELOCATED(relocated_addr);
 		*(Elf64_Addr *)RELOCATED(addr) = relocated_addr;
 	}
+
+#ifdef CONFIG_RELR
+	u64 *relr = (u64 *)&__relr_dyn_begin;
+	u64 *relr_end = (u64 *)&__relr_dyn_end;
+	u64 *addr = NULL;
+
+	for ( ; relr < relr_end; relr++) {
+		if ((*relr & 1) == 0) {
+			addr = (u64 *)(*relr + reloc_offset);
+			*addr++ += reloc_offset;
+		} else {
+			for (u64 *p = addr, r = *relr >> 1; r; p++, r >>= 1)
+				if (r & 1)
+					*p += reloc_offset;
+			addr += 63;
+		}
+	}
+#endif
 }
 
 static inline void __init relocate_absolute(long random_offset)
diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
index 3c7595342730..08ea921cdec1 100644
--- a/arch/loongarch/kernel/vmlinux.lds.S
+++ b/arch/loongarch/kernel/vmlinux.lds.S
@@ -113,6 +113,14 @@ SECTIONS
 		__rela_dyn_end = .;
 	}
 
+#ifdef CONFIG_RELR
+	.relr.dyn : ALIGN(8) {
+		__relr_dyn_begin = .;
+		 *(.relr.dyn)
+		__relr_dyn_end = .;
+	}
+#endif
+
 	.data.rel : { *(.data.rel*) }
 
 #ifdef CONFIG_RELOCATABLE
-- 
2.45.2


