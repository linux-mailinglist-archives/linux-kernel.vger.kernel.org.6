Return-Path: <linux-kernel+bounces-332252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5C297B747
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 06:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C6671F2402A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 04:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD47513A3F2;
	Wed, 18 Sep 2024 04:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o9Ta53eV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406CC22EED
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 04:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726635276; cv=none; b=n0O8tShx5NhLFn3IxrM3wLuSRK8wdwOiUeyZ/82funOTJUjpFTZ60lpUB3c9WQi4UoqX0Z/O/jheOXIqyEDKGBzk35j9lgtwvNdgIKMsFbcgBR5NaxbUxoXCdPpTwyslgIuxEtWYxVosWE12tUaBVbLogif0ytMLsS3ZNBn378o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726635276; c=relaxed/simple;
	bh=zkI3MphARaozn8NdrN54ydRhmNyndHd93oD0qNgaZQk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iilaq3zz09hKU5RbYSJ3fDwcRKAqmXPQf+RCyvSeFGp4JHsHGaSSwVbgQsW01CHorhtkxM3rQpbIsjHf7I16CqbSGR4/Isev1mOu1p5aMsthe8C09tRpy6eFiyRCxJQ9VeqoyPkfyTvYoWIYVtORoX1M+MxmUDms+UqnoSPgqJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o9Ta53eV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15EECC4CEC3;
	Wed, 18 Sep 2024 04:54:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726635275;
	bh=zkI3MphARaozn8NdrN54ydRhmNyndHd93oD0qNgaZQk=;
	h=From:To:Cc:Subject:Date:From;
	b=o9Ta53eV++98pykwR8v3XLSwpZpt9PVEkE/Jo27kHMo2PanFiVoLhFFU0fb10fYG9
	 cXnYOWY/QLWUmB78RNVqyT8BdkTt5EwPgRnsLNWxbjSsnDQ328A5hBWUiJ8Q1+f6w0
	 Vnj0sF9DqVfS71Qp62bHf6iO1ZR7g7Ae0Irwd+qyvbqCor1tP5TznXVERRp2J5qqry
	 /zsVc49mS56pBfFhg0VCA8/Bg0LNql4vxhT0YYHfjDvT1R3PVMltm52wZb668tTSyE
	 2iTLv/8ZMuxmhwAAXKZ4/ARJkVuqsLe+7DoXeyhV2Vhq72F4iLArwesO6/ovinaf0o
	 h0JSXgPUGysnA==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Michal Simek <monstr@monstr.eu>,
	linux-kernel@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] microblaze: use the common infrastructure to support built-in DTB
Date: Wed, 18 Sep 2024 13:52:43 +0900
Message-ID: <20240918045431.607826-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MicroBlaze is the only architecture that supports a built-in DTB in
its own way.

Other architectures (e.g., ARC, NIOS2, RISC-V, etc.) use the common
infrastructure introduced by commit aab94339cd85 ("of: Add support for
linking device tree blobs into vmlinux").

This commit migrates MicroBlaze to this common infrastructure.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

I do not know why MicroBlaze still adopts its own way.
Perhaps, because MicroBlaze supports the built-in DTB
before aab94339cd85 and nobody attempted migration.
Anyway, I only compile-tested this patch.
I hope the maintainer can do boot-testing.

 arch/microblaze/boot/Makefile          | 3 +--
 arch/microblaze/boot/dts/Makefile      | 5 +----
 arch/microblaze/boot/dts/linked_dtb.S  | 2 --
 arch/microblaze/include/asm/sections.h | 2 --
 arch/microblaze/kernel/head.S          | 2 +-
 arch/microblaze/kernel/setup.c         | 4 ++--
 arch/microblaze/kernel/vmlinux.lds.S   | 8 --------
 7 files changed, 5 insertions(+), 21 deletions(-)
 delete mode 100644 arch/microblaze/boot/dts/linked_dtb.S

diff --git a/arch/microblaze/boot/Makefile b/arch/microblaze/boot/Makefile
index 2b42c370d574..23a48e090f93 100644
--- a/arch/microblaze/boot/Makefile
+++ b/arch/microblaze/boot/Makefile
@@ -17,8 +17,7 @@ $(obj)/linux.bin.gz: $(obj)/linux.bin FORCE
 	$(call if_changed,gzip)
 
 quiet_cmd_strip = STRIP   $< $@$2
-	cmd_strip = $(STRIP) -K microblaze_start -K _end -K __log_buf \
-				-K _fdt_start $< -o $@$2
+	cmd_strip = $(STRIP) -K microblaze_start -K _end -K __log_buf $< -o $@$2
 
 UIMAGE_LOADADDR = $(CONFIG_KERNEL_BASE_ADDR)
 
diff --git a/arch/microblaze/boot/dts/Makefile b/arch/microblaze/boot/dts/Makefile
index b84e2cbb20ee..f168a127bf94 100644
--- a/arch/microblaze/boot/dts/Makefile
+++ b/arch/microblaze/boot/dts/Makefile
@@ -4,10 +4,7 @@
 dtb-y := system.dtb
 
 ifneq ($(DTB),)
-obj-y += linked_dtb.o
-
-# Ensure system.dtb exists
-$(obj)/linked_dtb.o: $(obj)/system.dtb
+obj-y += system.dtb.o
 
 # Generate system.dtb from $(DTB).dtb
 ifneq ($(DTB),system)
diff --git a/arch/microblaze/boot/dts/linked_dtb.S b/arch/microblaze/boot/dts/linked_dtb.S
deleted file mode 100644
index 23345af3721f..000000000000
--- a/arch/microblaze/boot/dts/linked_dtb.S
+++ /dev/null
@@ -1,2 +0,0 @@
-.section __fdt_blob,"a"
-.incbin "arch/microblaze/boot/dts/system.dtb"
diff --git a/arch/microblaze/include/asm/sections.h b/arch/microblaze/include/asm/sections.h
index a9311ad84a67..6bc4855757c3 100644
--- a/arch/microblaze/include/asm/sections.h
+++ b/arch/microblaze/include/asm/sections.h
@@ -14,7 +14,5 @@
 extern char _ssbss[], _esbss[];
 extern unsigned long __ivt_start[], __ivt_end[];
 
-extern u32 _fdt_start[], _fdt_end[];
-
 # endif /* !__ASSEMBLY__ */
 #endif /* _ASM_MICROBLAZE_SECTIONS_H */
diff --git a/arch/microblaze/kernel/head.S b/arch/microblaze/kernel/head.S
index ec2fcb545e64..9727aa1934df 100644
--- a/arch/microblaze/kernel/head.S
+++ b/arch/microblaze/kernel/head.S
@@ -95,7 +95,7 @@ big_endian:
 	bnei	r11, no_fdt_arg			/* No - get out of here */
 _prepare_copy_fdt:
 	or	r11, r0, r0 /* incremment */
-	ori	r4, r0, TOPHYS(_fdt_start)
+	ori	r4, r0, TOPHYS(__dtb_start)
 	ori	r3, r0, (0x10000 - 4)
 _copy_fdt:
 	lw	r12, r7, r11 /* r12 = r7 + r11 */
diff --git a/arch/microblaze/kernel/setup.c b/arch/microblaze/kernel/setup.c
index f417333eccae..8e57b490ca9c 100644
--- a/arch/microblaze/kernel/setup.c
+++ b/arch/microblaze/kernel/setup.c
@@ -120,7 +120,7 @@ void __init machine_early_init(const char *cmdline, unsigned int ram,
 	memset(_ssbss, 0, _esbss-_ssbss);
 
 /* initialize device tree for usage in early_printk */
-	early_init_devtree(_fdt_start);
+	early_init_devtree(__dtb_start);
 
 	/* setup kernel_tlb after BSS cleaning
 	 * Maybe worth to move to asm code */
@@ -132,7 +132,7 @@ void __init machine_early_init(const char *cmdline, unsigned int ram,
 	if (fdt)
 		pr_info("FDT at 0x%08x\n", fdt);
 	else
-		pr_info("Compiled-in FDT at %p\n", _fdt_start);
+		pr_info("Compiled-in FDT at %p\n", __dtb_start);
 
 #ifdef CONFIG_MTD_UCLINUX
 	pr_info("Found romfs @ 0x%08x (0x%08x)\n",
diff --git a/arch/microblaze/kernel/vmlinux.lds.S b/arch/microblaze/kernel/vmlinux.lds.S
index ae50d3d04a7d..3d4a78aa9ab4 100644
--- a/arch/microblaze/kernel/vmlinux.lds.S
+++ b/arch/microblaze/kernel/vmlinux.lds.S
@@ -44,14 +44,6 @@ SECTIONS {
 		_etext = . ;
 	}
 
-	. = ALIGN (8) ;
-	__fdt_blob : AT(ADDR(__fdt_blob) - LOAD_OFFSET) {
-		_fdt_start = . ;		/* place for fdt blob */
-		*(__fdt_blob) ;			/* Any link-placed DTB */
-	        . = _fdt_start + 0x10000;	/* Pad up to 64kbyte */
-		_fdt_end = . ;
-	}
-
 	. = ALIGN(16);
 	RO_DATA(4096)
 
-- 
2.43.0


