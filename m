Return-Path: <linux-kernel+bounces-264126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4AC93DF32
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 13:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9058B22A7B
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jul 2024 11:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5F85D8F0;
	Sat, 27 Jul 2024 11:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="TXcxHm0d"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957BF4653A
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722081036; cv=none; b=kWNMrSeT9jkDm71afy2DY1JvOG/il3ICNa6e+wdJIdpXt4v9kvUAbvdqHqYyyewcFnYKghApKUlCFGd8WcvM4Kap6hOyfAOhPjthFq+UiXpXfgUVJzMdxYCzwxOfu7s+Eg+3oKSrSXhX9yhOkaHnywcBZxvUdwmNnB7KjCUJ6Xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722081036; c=relaxed/simple;
	bh=3xxq0uRE/TYYRpxSPdCc/u36vIuLVeV/XR7RE9mHUik=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q/m4m1bVPrE8fFuuQlSc/KL8rcEwlUH0aQFbwZqsanCz1SlR2JU0h4MKtZZ4OeY+YyaOUtAgcU8DnI8uLoBbrqYkxM3VH7ZrWFVj6FiRBu+LVKgbEA3Y7ajFx0y+06JxxaCny2ZIfjnLUFjQD5cMIAnmOwac2WyoYomwzWQ/uu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=TXcxHm0d; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7B2863F4E0
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 11:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1722081026;
	bh=8JdHSCk1TXD1rDArBPNNtadzpjUExOiwwzc15+VV1S8=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=TXcxHm0dd8w8U7Zs5cj0SdadNNqVO1usPmWgHzR97MLWjWGIpCeAEmNn4yHB5AgKC
	 AGTanF7XXDK56uO9h1OLjW+UyIc56uyeQk5xegEf+AcDs7tYs4wGgmncElxyLGgEw5
	 Rfj+MrrmXDTzIEN5ZMonu9LDNn54eQQeXQKoeOLbouFnRrMPeUo1KEw1PlkEfVK+Rn
	 yLgsjJpIpL1a6ndW7KxfgT3Znbh2bzN081jQV33Y1vOBJcEXIsfEqCFMM8nWxSFoHH
	 FFHCAcJ5V+bcqD5b15ZPhpu6Efmcdq/A1toTq87QxWQ/Lf++RzI12FES5bC6HKFstS
	 TKoj4M1uoA58w==
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e0b365efb6cso1085799276.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jul 2024 04:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722081025; x=1722685825;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8JdHSCk1TXD1rDArBPNNtadzpjUExOiwwzc15+VV1S8=;
        b=p3VaWs6XLPueGFY6AUEVEA+sjsT9yBh2/DQK4JTgJZGa7bA55ydMDqv1yQ4hCPW1ob
         lrADWikcSQ8B7K9iO9Nm/hHvsO51o2afX+lMqZGGHLJhzzGMIe0btbx6iokULPa/gDUw
         IXDzYo3f46IvHLjcGq0c8uy1cC0vVZZGGq3inUSzCMUMPfaJmaZcbmp3E5kuhee2DtoS
         oxf7XZyi46f3XDWc66oESDF1EUo8+ihI89KGVdLWfaZmfJ9gWQNrdXKx2MOH2lqSI/XK
         uCPeFBvR9VtSOh49gwzGzT5j14s0uopdwdz52nu4IBQSm7lkdqPD1iz+WqAwmC2ly39O
         wbSw==
X-Forwarded-Encrypted: i=1; AJvYcCU3LoZK+uPJLWLWPbLHE/HFDS+xdJf6BRnvX2LL8VaigFWi1O3zqY8vzybMcLT49jvIdcfrbIr2bni4hCGISKWG5WCyKhud/X4gXKyW
X-Gm-Message-State: AOJu0YxJSf+d9XggCPv4gj572lnxNsuOWZbYaElW7HN+9ZJIUja/dg+F
	u1eIzJN8053WWOroad4Q8Di5ssQi6aXgEEeDmWFV0RqE/ashtdXQKXR8T2Hh8wCr+9eNetCW8Ok
	WXQ3yVEaltUNvrW9jHEJUgn5N5qtg4nHyUZ9GjZuOOr216w02Hl70BIdwTvqI0O6rpmgGy+QyBt
	udKThRadRtQ/cHizm/xYfHbm9yhDn9SnnnI2U83XJF+3er2iNM78L7
X-Received: by 2002:a05:6902:1881:b0:e03:530d:3a1a with SMTP id 3f1490d57ef6-e0b545427c6mr2865498276.25.1722081025104;
        Sat, 27 Jul 2024 04:50:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3f7Cohl+U3pUSCtdrfmw46MeGQOG0+JmN4t93TMxeEXj+mHvV5dSlJkVcfLWn19McS5jKUW+7u5/86o9rxCc=
X-Received: by 2002:a05:6902:1881:b0:e03:530d:3a1a with SMTP id
 3f1490d57ef6-e0b545427c6mr2865475276.25.1722081024566; Sat, 27 Jul 2024
 04:50:24 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 27 Jul 2024 06:50:24 -0500
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <CAHk-=wiruM9sWeOM8FKvGTetiWgSaGZF31YmdzS3_s=0bw0Ekg@mail.gmail.com>
References: <20240726195044.18004-1-sedat.dilek@gmail.com> <CAHk-=wgEhoxDM7T+Ko-NgAC5X8etF0aL3fGsUXFeqnwggNXgCA@mail.gmail.com>
 <CA+icZUWUdq-xR9nOB_c_8=pfwn8J062hiurFXcrF7zvmaNg8PA@mail.gmail.com> <CAHk-=wiruM9sWeOM8FKvGTetiWgSaGZF31YmdzS3_s=0bw0Ekg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Sat, 27 Jul 2024 06:50:24 -0500
Message-ID: <CAJM55Z82yardOi-x59TbdrXb834xq6_Nt=1DPqJC77MfM9vvHA@mail.gmail.com>
Subject: Re: [v2] arm64: Rename to KERNEL_IMAGE_COMPRESSED_INSTALL kconfig for
 compressed kernel image
To: Linus Torvalds <torvalds@linux-foundation.org>, sedat.dilek@gmail.com
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Linus Torvalds wrote:
> On Fri, 26 Jul 2024 at 13:54, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > And when you check a diff of two of your ARM64 .config?
> > What says COMPRESSED_INSTALL to other than the author w/o context :-)?
>
> Even without any context, I think it says "compressed install".
>
> Which seems sensible. Because THAT'S EXACTLY WHAT IT IS.
>
> Now, admittedly I would have preferred not having a config option for
> this at all, but we have a sad historical situation of doing something
> odd on arm (and parisc).
>
> The RISC-V people used to do the same, but they decided to just make
> 'install' do whatever image was built, so they base it on a
> combination of different config variables: CONFIG_XIP_KERNEL,
> CONFIG_RISCV_M_MODE, CONFIG_SOC_CANAAN_K210, and CONFIG_EFI_ZBOOT.

With the approach taken by RISC-V you can choose which compression you want
(including uncompressed) and not just gzip. For arm64 it would look something
like this:

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ae527d1d409f..a99864491703 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -234,6 +234,13 @@ config ARM64
 	select HAVE_RUST if CPU_LITTLE_ENDIAN
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_KERNEL_BZIP2 if !EFI_ZBOOT
+	select HAVE_KERNEL_GZIP if !EFI_ZBOOT
+	select HAVE_KERNEL_LZ4 if !EFI_ZBOOT
+	select HAVE_KERNEL_LZMA if !EFI_ZBOOT
+	select HAVE_KERNEL_LZO if !EFI_ZBOOT
+	select HAVE_KERNEL_UNCOMPRESSED if !EFI_ZBOOT
+	select HAVE_KERNEL_ZSTD if !EFI_ZBOOT
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
 	select HAVE_GENERIC_VDSO
@@ -2337,17 +2344,6 @@ config EFI
 	  allow the kernel to be booted as an EFI application. This
 	  is only useful on systems that have UEFI firmware.

-config COMPRESSED_INSTALL
-	bool "Install compressed image by default"
-	help
-	  This makes the regular "make install" install the compressed
-	  image we built, not the legacy uncompressed one.
-
-	  You can check that a compressed image works for you by doing
-	  "make zinstall" first, and verifying that everything is fine
-	  in your environment before making "make install" do this for
-	  you.
-
 config DMI
 	bool "Enable support for SMBIOS (DMI) tables"
 	depends on EFI
diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index f6bc3da1ef11..b798875311aa 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -159,18 +159,21 @@ libs-y		:= arch/arm64/lib/ $(libs-y)
 libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a

 # Default target when executing plain make
-boot		:= arch/arm64/boot
+boot					:= arch/arm64/boot
+boot-image-y				:= Image
+boot-image-$(CONFIG_KERNEL_BZIP2)	:= Image.bz2
+boot-image-$(CONFIG_KERNEL_GZIP)	:= Image.gz
+boot-image-$(CONFIG_KERNEL_LZ4)		:= Image.lz4
+boot-image-$(CONFIG_KERNEL_LZMA)	:= Image.lzma
+boot-image-$(CONFIG_KERNEL_LZO)		:= Image.lzo
+boot-image-$(CONFIG_KERNEL_ZSTD)	:= Image.zst
+boot-image-$(CONFIG_EFI_ZBOOT)		:= vmlinuz.efi

-BOOT_TARGETS	:= Image vmlinuz.efi image.fit
+KBUILD_IMAGE := $(boot)/$(boot-image-y)
+BOOT_TARGETS := Image Image.bz2 Image.gz Image.lz4 Image.lzma
Image.lzo Image.zst vmlinuz.efi image.fit

 PHONY += $(BOOT_TARGETS)

-ifeq ($(CONFIG_EFI_ZBOOT),)
-KBUILD_IMAGE	:= $(boot)/Image.gz
-else
-KBUILD_IMAGE	:= $(boot)/vmlinuz.efi
-endif
-
 all:	$(notdir $(KBUILD_IMAGE))

 image.fit: dtbs
@@ -182,13 +185,8 @@ $(BOOT_TARGETS): vmlinux
 Image.%: Image
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@

-ifeq ($(CONFIG_COMPRESSED_INSTALL),y)
- DEFAULT_KBUILD_IMAGE = $(KBUILD_IMAGE)
-else
- DEFAULT_KBUILD_IMAGE = $(boot)/Image
-endif
-
-install: KBUILD_IMAGE := $(DEFAULT_KBUILD_IMAGE)
+# the install target always installs KBUILD_IMAGE (which may be compressed)
+# but keep the zinstall target for compatibility with older releases
 install zinstall:
 	$(call cmd,install)

@@ -232,11 +230,15 @@ virtconfig:
 	$(call merge_into_defconfig_override,defconfig,virt)

 define archhelp
-  echo  '* Image.gz      - Compressed kernel image
(arch/$(ARCH)/boot/Image.gz)'
   echo  '  Image         - Uncompressed kernel image (arch/$(ARCH)/boot/Image)'
+  echo  '  Image.bz2     - Compressed kernel image
(arch/$(ARCH)/boot/Image.bz2)'
+  echo  '* Image.gz      - Compressed kernel image
(arch/$(ARCH)/boot/Image.gz)'
+  echo  '  Image.lz4     - Compressed kernel image
(arch/$(ARCH)/boot/Image.lz4)'
+  echo  '  Image.lzma    - Compressed kernel image
(arch/$(ARCH)/boot/Image.lzma)'
+  echo  '  Image.lzo     - Compressed kernel image
(arch/$(ARCH)/boot/Image.lzo)'
+  echo  '  Image.zst     - Compressed kernel image
(arch/$(ARCH)/boot/Image.zst)'
   echo  '  image.fit     - Flat Image Tree (arch/$(ARCH)/boot/image.fit)'
-  echo  '  install       - Install kernel (compressed if
COMPRESSED_INSTALL set)'
-  echo  '  zinstall      - Install compressed kernel'
+  echo  '  install       - Install kernel'
   echo  '                  Install using (your) ~/bin/installkernel or'
   echo  '                  (distribution) /sbin/installkernel or'
   echo  '                  install to $$(INSTALL_PATH) and run lilo'

