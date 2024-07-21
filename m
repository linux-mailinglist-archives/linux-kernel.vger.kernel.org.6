Return-Path: <linux-kernel+bounces-258186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EF19384CE
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 15:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7533A1C20D2C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 13:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA031662E5;
	Sun, 21 Jul 2024 13:37:26 +0000 (UTC)
Received: from mailscanner10.zoner.fi (mailscanner10.zoner.fi [5.44.246.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D2A16B3BC
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.44.246.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721569045; cv=none; b=ggZYDsweTGd6VUJeVWbdKPOtmO3pQ7Vd+tU62BkB1veucyJuOIzp4ljrzwS+OEUbpCWXs2FvA5pCiYJn84Wax6Yy1liUJJ1WeIli5Yxox4UON7V7q0gQ/jHyFRQvJ5UTZ562kWzpw/pCEVFd2qFx1sAT2zp1kbG72yW1bHIUGNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721569045; c=relaxed/simple;
	bh=TQFB4eP5J2kKT8PWOjT9n1wQf5OwwyCV9CA/DS4mb0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qV61La2LFucLPJcZ/N+6vo7bH6nRc6ClfZe0UnY8dVFAMQNzAf9Hd0S+I4PrSXETMjlsAH3s6d7rhxnZV9IeqWyPhAUYU6UbrXcE+u9vVdBeq3qeIfGHqUWX3XyrxTBghq6sMlxx2Du2H0Pa6tCQnJCs0y+B/uRJdooxDLLznN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org; spf=pass smtp.mailfrom=tukaani.org; arc=none smtp.client-ip=5.44.246.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tukaani.org
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
	by mailscanner10.zoner.fi (Postfix) with ESMTPS id 611A92131F;
	Sun, 21 Jul 2024 16:37:22 +0300 (EEST)
Received: from mail.zoner.fi ([84.34.147.244])
	by www25.zoner.fi with esmtp (Exim 4.97.1)
	(envelope-from <lasse.collin@tukaani.org>)
	id 1sVWkY-00000001SpP-3xpw;
	Sun, 21 Jul 2024 16:37:22 +0300
From: Lasse Collin <lasse.collin@tukaani.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lasse Collin <lasse.collin@tukaani.org>,
	Sam James <sam@gentoo.org>,
	linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Jules Maselbas <jmaselbas@zdiv.net>,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 16/16] riscv: boot: add Image.xz support
Date: Sun, 21 Jul 2024 16:36:31 +0300
Message-ID: <20240721133633.47721-17-lasse.collin@tukaani.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240721133633.47721-1-lasse.collin@tukaani.org>
References: <20240721133633.47721-1-lasse.collin@tukaani.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Image.* targets existed for other compressors already. Bootloader
support is needed for decompression.

This is for CONFIG_EFI_ZBOOT=n. With CONFIG_EFI_ZBOOT=y, XZ was already
available.

Comparision with Linux 6.10 RV64GC tinyconfig (in KiB):

    1027 Image
     594 Image.gz
     541 Image.zst
     510 Image.lzma
     474 Image.xz

Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Jules Maselbas <jmaselbas@zdiv.net>
Cc: linux-riscv@lists.infradead.org
Signed-off-by: Lasse Collin <lasse.collin@tukaani.org>
---
 arch/riscv/Kconfig       | 1 +
 arch/riscv/Makefile      | 6 ++++--
 arch/riscv/boot/Makefile | 3 +++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 736457a5898a..ef6a603b80c5 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -153,6 +153,7 @@ config RISCV
 	select HAVE_KERNEL_LZO if !XIP_KERNEL && !EFI_ZBOOT
 	select HAVE_KERNEL_UNCOMPRESSED if !XIP_KERNEL && !EFI_ZBOOT
 	select HAVE_KERNEL_ZSTD if !XIP_KERNEL && !EFI_ZBOOT
+	select HAVE_KERNEL_XZ if !XIP_KERNEL && !EFI_ZBOOT
 	select HAVE_KPROBES if !XIP_KERNEL
 	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
 	select HAVE_KRETPROBES if !XIP_KERNEL
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 6fe682139d2e..d469db9f46f4 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -159,6 +159,7 @@ boot-image-$(CONFIG_KERNEL_LZ4)		:= Image.lz4
 boot-image-$(CONFIG_KERNEL_LZMA)	:= Image.lzma
 boot-image-$(CONFIG_KERNEL_LZO)		:= Image.lzo
 boot-image-$(CONFIG_KERNEL_ZSTD)	:= Image.zst
+boot-image-$(CONFIG_KERNEL_XZ)		:= Image.xz
 ifdef CONFIG_RISCV_M_MODE
 boot-image-$(CONFIG_ARCH_CANAAN)	:= loader.bin
 endif
@@ -183,12 +184,12 @@ endif
 vdso-install-y			+= arch/riscv/kernel/vdso/vdso.so.dbg
 vdso-install-$(CONFIG_COMPAT)	+= arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg
 
-BOOT_TARGETS := Image Image.gz Image.bz2 Image.lz4 Image.lzma Image.lzo Image.zst loader loader.bin xipImage vmlinuz.efi
+BOOT_TARGETS := Image Image.gz Image.bz2 Image.lz4 Image.lzma Image.lzo Image.zst Image.xz loader loader.bin xipImage vmlinuz.efi
 
 all:	$(notdir $(KBUILD_IMAGE))
 
 loader.bin: loader
-Image.gz Image.bz2 Image.lz4 Image.lzma Image.lzo Image.zst loader xipImage vmlinuz.efi: Image
+Image.gz Image.bz2 Image.lz4 Image.lzma Image.lzo Image.zst Image.xz loader xipImage vmlinuz.efi: Image
 
 $(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
@@ -225,6 +226,7 @@ define archhelp
   echo  '  Image.lzma	- Compressed kernel image (arch/riscv/boot/Image.lzma)'
   echo  '  Image.lzo	- Compressed kernel image (arch/riscv/boot/Image.lzo)'
   echo  '  Image.zst	- Compressed kernel image (arch/riscv/boot/Image.zst)'
+  echo  '  Image.xz	- Compressed kernel image (arch/riscv/boot/Image.xz)'
   echo  '  vmlinuz.efi	- Compressed EFI kernel image (arch/riscv/boot/vmlinuz.efi)'
   echo  '		  Default when CONFIG_EFI_ZBOOT=y'
   echo  '  xipImage	- Execute-in-place kernel image (arch/riscv/boot/xipImage)'
diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
index 869c0345b908..710a5f6caf96 100644
--- a/arch/riscv/boot/Makefile
+++ b/arch/riscv/boot/Makefile
@@ -65,6 +65,9 @@ $(obj)/Image.lzo: $(obj)/Image FORCE
 $(obj)/Image.zst: $(obj)/Image FORCE
 	$(call if_changed,zstd)
 
+$(obj)/Image.xz: $(obj)/Image FORCE
+	$(call if_changed,xzkern)
+
 $(obj)/loader.bin: $(obj)/loader FORCE
 	$(call if_changed,objcopy)
 
-- 
2.45.2


