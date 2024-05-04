Return-Path: <linux-kernel+bounces-168805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 510698BBDD9
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 21:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09022282404
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 19:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1450384D29;
	Sat,  4 May 2024 19:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="qul2u+eU"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4EFB1EF01
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 19:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714851297; cv=none; b=RLNuQVimqs7pU5VQh+04F9u+KmfXmi9FpVhPG2siAFFOsEtcdLgywxIJ054djZJ9V40qNO4d1xDo9x887b8+kn3/lJQCdVzoMXnX6ugbiUgffeF/oP6vKd6Qx/bGYk24hM5z8cm3q8kflVHJ1wBsK34qcLzdjJSyfXPQaxjVbOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714851297; c=relaxed/simple;
	bh=dRGAKcxr2q5NSUlclEu4yws4rka1HJIpJd2sl/fEVEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CzJsO59RjrZ9sw2pDT2kopWHNv4S5EGfg9+Ls+zbt823iaQcUE2Q5p6tc8xtvqKK/hJdj7oXHvJjOFJhLG7eBqaGUe3JyK17B6vYrTBag59oMY+l1WLMYuoDIeL2dtvWk8xia95c4EfBakV+ucozMgYfsmsMIWkG5aEAmQYAhR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=qul2u+eU; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CF99E3FE5D
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 19:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714851290;
	bh=XYcyH30Tdg0L1XT/KhSL5KHFpF2lXtDsTt+QyOMRfmk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type;
	b=qul2u+eU9WchgadwQaM5BqT3lD4UWi5hcPIgb56Wgyle0AV/DEaOvCG4Xyv0T+wCF
	 BT7VxDcbg20i5XE5gNR33TLCgksARSe2npsHQCZBvF4014Pw4Cdq5PQKsYUUdRO+EA
	 xVvKOKluFiR2vBwJsZfLq5qZ0zS2pPFaAWIpAnjtDzutzDq6is/jmzat5Qi/8UJRXr
	 74pk+LdHZ4fH3EqL7AN5nCxxKgZnm+Yyw+I05Yu41ghFHjPrwKplhiolPfmsPnx0sy
	 qX1mpfAOEoqnUKSF/peQcieziqmKPcwo0uZ+fgwzqFp0h3msmHjY7Z22/GeCnGdmJj
	 mcijQbn9XciJQ==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5729d8798a4so358524a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 12:34:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714851290; x=1715456090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYcyH30Tdg0L1XT/KhSL5KHFpF2lXtDsTt+QyOMRfmk=;
        b=gELayRNW3qvkckvmMjW/g3/6E1QGjn511FQXSxZONs0e1BTHP3kpdO/bCGNfGk9PCQ
         DGYvTju//EOGCPYk4rfFmHLe3Q6o3roto/gFuF4aCRnX63ORw4VQ2qwl/UdJizL0LoQ2
         WIFXuAQ/JsirvoBUuSv8TETB7WhmQLnXQPGAjwEVl0apqXIr90yZ3AfA7qmqCCYAgVY/
         KeAZEyAHJakc9Fz2bzr3+XdLEL+VksbHrL6Ix02gn02vJ7b4qsidNGB8jGbWqmphRT7x
         0gI6kL8mmoJZV4ZZHQns78QhO09GmjyTBRDANqagN1HlaVRFu6FxwGJvWXhofINKVAnI
         R0Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWU4iYqhxnVTz6PWaao+sgD+Zqm9jxrPdmR/I8sue6hAnGf2xCal271y4MTW4bLRDMyRi7vyXotJFoYFrDbAkQgDA3fi9KjZWLRUut7
X-Gm-Message-State: AOJu0Yy2773x+8nktoWF6HVegMGhS+SxWCDuCTh7xz2hJFmHsm3o8FwT
	qfAdBjSuuYVega842ty/l+8EewIlzArdaA9Kd3PEDmbR2FxzUbgtTKOVWOcmtO53tRfCli1bMuH
	3Mjn9xT1YS7MfFtHy34apdOkDfNsqU3hHJ7NPzYc/jKyZA99feVKsvtWI7H6H34zi5+bq2bHT6X
	gREg==
X-Received: by 2002:a50:d5d8:0:b0:572:4fc3:3a28 with SMTP id g24-20020a50d5d8000000b005724fc33a28mr3895880edj.23.1714851290382;
        Sat, 04 May 2024 12:34:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnRJR1GyEL9wACd0QWSYElWiR8PckNNzcjss6a2GKF18p7Qs7LRVI0kBoEyI6PAN3xCIefKQ==
X-Received: by 2002:a50:d5d8:0:b0:572:4fc3:3a28 with SMTP id g24-20020a50d5d8000000b005724fc33a28mr3895868edj.23.1714851290043;
        Sat, 04 May 2024 12:34:50 -0700 (PDT)
Received: from stitch.. ([80.71.142.166])
        by smtp.gmail.com with ESMTPSA id et4-20020a056402378400b00572d255e342sm2227021edb.10.2024.05.04.12.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 12:34:49 -0700 (PDT)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kbuild@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Nick Terrell <terrelln@fb.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH v2 1/2] riscv: make image compression configurable
Date: Sat,  4 May 2024 21:34:38 +0200
Message-ID: <20240504193446.196886-2-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240504193446.196886-1-emil.renner.berthing@canonical.com>
References: <20240504193446.196886-1-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Previously the build process would always set KBUILD_IMAGE to the
uncompressed Image file (unless XIP_KERNEL or EFI_ZBOOT was enabled) and
unconditionally compress it into Image.gz. However there are already
build targets for Image.bz2, Image.lz4, Image.lzma, Image.lzo and
Image.zstd, so let's make use of those, make the compression method
configurable and set KBUILD_IMAGE accordingly so that targets like
'make install' and 'make bindeb-pkg' will use the chosen image.

Tested-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
Changes in v2:
- Rebase on riscv/for-next
- Use boot-image-$(CONFIG_..) := assignments rather than ifeq train
---
 arch/riscv/Kconfig         |  7 +++++++
 arch/riscv/Makefile        | 38 ++++++++++++++++++--------------------
 arch/riscv/boot/install.sh |  9 ++++++---
 3 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 6bec1bce6586..79e558397f41 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -140,6 +140,13 @@ config RISCV
 	select HAVE_GCC_PLUGINS
 	select HAVE_GENERIC_VDSO if MMU && 64BIT
 	select HAVE_IRQ_TIME_ACCOUNTING
+	select HAVE_KERNEL_BZIP2 if !XIP_KERNEL && !EFI_ZBOOT
+	select HAVE_KERNEL_GZIP if !XIP_KERNEL && !EFI_ZBOOT
+	select HAVE_KERNEL_LZ4 if !XIP_KERNEL && !EFI_ZBOOT
+	select HAVE_KERNEL_LZMA if !XIP_KERNEL && !EFI_ZBOOT
+	select HAVE_KERNEL_LZO if !XIP_KERNEL && !EFI_ZBOOT
+	select HAVE_KERNEL_UNCOMPRESSED if !XIP_KERNEL && !EFI_ZBOOT
+	select HAVE_KERNEL_ZSTD if !XIP_KERNEL && !EFI_ZBOOT
 	select HAVE_KPROBES if !XIP_KERNEL
 	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
 	select HAVE_KRETPROBES if !XIP_KERNEL
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 8b2ae27f1d98..07ff2f34f0dc 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -136,20 +136,20 @@ endif
 CHECKFLAGS += -D__riscv -D__riscv_xlen=$(BITS)
 
 # Default target when executing plain make
-boot		:= arch/riscv/boot
-ifeq ($(CONFIG_XIP_KERNEL),y)
-KBUILD_IMAGE := $(boot)/xipImage
-else
-ifeq ($(CONFIG_RISCV_M_MODE)$(CONFIG_ARCH_CANAAN),yy)
-KBUILD_IMAGE := $(boot)/loader.bin
-else
-ifeq ($(CONFIG_EFI_ZBOOT),)
-KBUILD_IMAGE	:= $(boot)/Image.gz
-else
-KBUILD_IMAGE := $(boot)/vmlinuz.efi
-endif
-endif
+boot					:= arch/riscv/boot
+boot-image-y				:= Image
+boot-image-$(CONFIG_KERNEL_BZIP2)	:= Image.bz2
+boot-image-$(CONFIG_KERNEL_GZIP)	:= Image.gz
+boot-image-$(CONFIG_KERNEL_LZ4)		:= Image.lz4
+boot-image-$(CONFIG_KERNEL_LZMA)	:= Image.lzma
+boot-image-$(CONFIG_KERNEL_LZO)		:= Image.lzo
+boot-image-$(CONFIG_KERNEL_ZSTD)	:= Image.zst
+ifdef CONFIG_RISCV_M_MODE
+boot-image-$(CONFIG_ARCH_CANAAN)	:= loader.bin
 endif
+boot-image-$(CONFIG_EFI_ZBOOT)		:= vmlinuz.efi
+boot-image-$(CONFIG_XIP_KERNEL)		:= xipImage
+KBUILD_IMAGE				:= $(boot)/$(boot-image-y)
 
 libs-y += arch/riscv/lib/
 libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
@@ -168,21 +168,19 @@ endif
 vdso-install-y			+= arch/riscv/kernel/vdso/vdso.so.dbg
 vdso-install-$(CONFIG_COMPAT)	+= arch/riscv/kernel/compat_vdso/compat_vdso.so.dbg
 
-BOOT_TARGETS := Image Image.gz loader loader.bin xipImage vmlinuz.efi
+BOOT_TARGETS := Image Image.gz Image.bz2 Image.lz4 Image.lzma Image.lzo Image.zst loader loader.bin xipImage vmlinuz.efi
 
 all:	$(notdir $(KBUILD_IMAGE))
 
 loader.bin: loader
-Image.gz loader vmlinuz.efi: Image
+Image.gz Image.bz2 Image.lz4 Image.lzma Image.lzo Image.zst loader xipImage vmlinuz.efi: Image
+
 $(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 	@$(kecho) '  Kernel: $(boot)/$@ is ready'
 
-Image.%: Image
-	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
-
-install: KBUILD_IMAGE := $(boot)/Image
-zinstall: KBUILD_IMAGE := $(boot)/Image.gz
+# the install target always installs KBUILD_IMAGE (which may be compressed)
+# but keep the zinstall target for compatibility with older releases
 install zinstall:
 	$(call cmd,install)
 
diff --git a/arch/riscv/boot/install.sh b/arch/riscv/boot/install.sh
index 4c63f3f0643d..a8df7591513a 100755
--- a/arch/riscv/boot/install.sh
+++ b/arch/riscv/boot/install.sh
@@ -17,15 +17,18 @@
 #   $3 - kernel map file
 #   $4 - default install path (blank if root directory)
 
-if [ "$(basename $2)" = "Image.gz" ]; then
+case "${2##*/}" in
 # Compressed install
+Image.*|vmlinuz.efi)
   echo "Installing compressed kernel"
   base=vmlinuz
-else
+  ;;
 # Normal install
+*)
   echo "Installing normal kernel"
   base=vmlinux
-fi
+  ;;
+esac
 
 if [ -f $4/$base-$1 ]; then
   mv $4/$base-$1 $4/$base-$1.old
-- 
2.43.0


