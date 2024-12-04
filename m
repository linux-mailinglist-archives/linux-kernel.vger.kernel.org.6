Return-Path: <linux-kernel+bounces-430939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F2F9E3770
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40BBC168891
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529681AF0D7;
	Wed,  4 Dec 2024 10:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkuegCkm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D601AF0CB
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308176; cv=none; b=KNCQgwLWVAxSbnunussuos7SBVNHlPqid92i5QL2jKJTsNGh1cIMhIlWwvzYuTqtAsROmWghbu8fv0uMsmfvPXjkzYHZ3Za2bPWoPlchL3v/hzF3TSPUe+c3QpYvSOdZZ0CryIwKt3FCXkSAp9xoLedw5FkejzuWeNDXbQT4RJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308176; c=relaxed/simple;
	bh=NjX4tMLsjz03kwbQoOwkPXcc6/3lkk7XPLNNhIqqACA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gmTQ9h9fzWORpd9rjd1wYrrJkNTnPFUTQkgCn8ngv+AWA9XzAUYUw591dFhKuMS4lPKMXqSvjgb16VCV+C8fAvMvqSK8jQ0GvrTVvBDI1TMozz7l9nzIF9N2XVXrDSTdaIFsfOrQrS6zKgLT9p7ZeDx05c0CCnJ7AXbjhpU5A7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkuegCkm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980E8C4CED6;
	Wed,  4 Dec 2024 10:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733308175;
	bh=NjX4tMLsjz03kwbQoOwkPXcc6/3lkk7XPLNNhIqqACA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fkuegCkmDWkfk7FnU4BxPay8M4/sFrAVdgTidrTLm6GNtaoT85U9ZYZ1w328grIXX
	 RBoWObcFeQ3P39qFaDHQX3rl1LqXfgoHRCmYbxOaQ0PZ4JbZN4+W8MfgRaUXe+UBlC
	 FGdKS3qLwuUQj2/xSha/ArJ2g9q7qopaH3CYRphMhBRe3AMueuhWl1Pdkjlhe0Bl/K
	 Ld509CDsgBXkdww8ljvx+haPSSJrSmD+jTKiWLzdj7v5PFN22amdpT4YDA45ttxMT2
	 i+43WbrvVo3pfAkTSvjsBrQtlkagGo68TjkeUmtSG4eOJbApxiSrefyul5XW+x3kBw
	 lzOFY8ItAqQ2w==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Aaro Koskinen <aaro.koskinen@iki.fi>,
	Andrew Lunn <andrew@lunn.ch>,
	Ard Biesheuvel <ardb@kernel.org>,
	Daniel Mack <daniel@zonque.org>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	"Jeremy J. Peper" <jeremy@jeremypeper.com>,
	Kristoffer Ericson <kristoffer.ericson@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Brown <broonie@kernel.org>,
	Ralph Siemsen <ralph.siemsen@linaro.org>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Tony Lindgren <tony@atomide.com>
Subject: [PATCH 01/15] ARM: use CONFIG_AEABI by default everywhere
Date: Wed,  4 Dec 2024 11:28:50 +0100
Message-Id: <20241204102904.1863796-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241204102904.1863796-1-arnd@kernel.org>
References: <20241204102904.1863796-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

On ARMv4 and ARMv5, the default is still to build for OABI, with
CONFIG_AEABI disabled, even though distros and toolchains no longer
support OABI as a target.

Change the default to EABI for all architecture levels and change
the defconfig entries as follows:

 - All machines that used to explicitly enable EABI can drop that line now
 - Machines that are likely to actually use old distros and had NWFPE
   enabled in combination with OABI (rpc, footrbridge, netwinder,
   assabet, neponset) explicitly turn it on now.
 - Machines that already had both EABI and NWFPE disabled in defconfig
   (at91_dt, collie, ep93xx, gemini, h3600, imx_v4_v5, integrator, jornada,
   moxart, multi_v4t, omap1) were likely not usable with either OABI or
   EABI and now use EABI instead implicitly, making it more likely that
   they could work.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                        | 17 ++++++-----------
 arch/arm/configs/am200epdkit_defconfig  |  1 -
 arch/arm/configs/aspeed_g4_defconfig    |  1 -
 arch/arm/configs/assabet_defconfig      |  1 +
 arch/arm/configs/at91_dt_defconfig      |  1 -
 arch/arm/configs/axm55xx_defconfig      |  1 -
 arch/arm/configs/bcm2835_defconfig      |  1 -
 arch/arm/configs/clps711x_defconfig     |  1 -
 arch/arm/configs/collie_defconfig       |  1 -
 arch/arm/configs/davinci_all_defconfig  |  1 -
 arch/arm/configs/dove_defconfig         |  1 -
 arch/arm/configs/ep93xx_defconfig       |  1 -
 arch/arm/configs/footbridge_defconfig   |  1 +
 arch/arm/configs/gemini_defconfig       |  1 -
 arch/arm/configs/h3600_defconfig        |  1 -
 arch/arm/configs/hisi_defconfig         |  1 -
 arch/arm/configs/imx_v4_v5_defconfig    |  1 -
 arch/arm/configs/integrator_defconfig   |  1 -
 arch/arm/configs/ixp4xx_defconfig       |  1 -
 arch/arm/configs/jornada720_defconfig   |  1 -
 arch/arm/configs/keystone_defconfig     |  1 -
 arch/arm/configs/lpc32xx_defconfig      |  1 -
 arch/arm/configs/mmp2_defconfig         |  1 -
 arch/arm/configs/moxart_defconfig       |  1 -
 arch/arm/configs/multi_v4t_defconfig    |  1 -
 arch/arm/configs/multi_v5_defconfig     |  1 -
 arch/arm/configs/mv78xx0_defconfig      |  2 --
 arch/arm/configs/mvebu_v5_defconfig     |  1 -
 arch/arm/configs/mxs_defconfig          |  1 -
 arch/arm/configs/neponset_defconfig     |  1 +
 arch/arm/configs/netwinder_defconfig    |  1 +
 arch/arm/configs/nhk8815_defconfig      |  1 -
 arch/arm/configs/omap1_defconfig        |  2 --
 arch/arm/configs/orion5x_defconfig      |  2 --
 arch/arm/configs/pxa168_defconfig       |  2 --
 arch/arm/configs/pxa3xx_defconfig       |  2 --
 arch/arm/configs/pxa910_defconfig       |  2 --
 arch/arm/configs/pxa_defconfig          |  1 -
 arch/arm/configs/rpc_defconfig          |  1 +
 arch/arm/configs/spear13xx_defconfig    |  1 -
 arch/arm/configs/spitz_defconfig        |  1 -
 arch/arm/configs/versatile_defconfig    |  1 -
 arch/arm/configs/vt8500_v6_v7_defconfig |  1 -
 arch/arm/configs/wpcm450_defconfig      |  1 -
 44 files changed, 11 insertions(+), 55 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 202397be76d8..f8f127650ace 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1163,19 +1163,14 @@ config ARM_PATCH_IDIV
 config AEABI
 	bool "Use the ARM EABI to compile the kernel" if !CPU_V7 && \
 		!CPU_V7M && !CPU_V6 && !CPU_V6K && !CC_IS_CLANG
-	default CPU_V7 || CPU_V7M || CPU_V6 || CPU_V6K || CC_IS_CLANG
+	default y
 	help
-	  This option allows for the kernel to be compiled using the latest
-	  ARM ABI (aka EABI).  This is only useful if you are using a user
-	  space environment that is also compiled with EABI.
-
-	  Since there are major incompatibilities between the legacy ABI and
-	  EABI, especially with regard to structure member alignment, this
-	  option also changes the kernel syscall calling convention to
-	  disambiguate both ABIs and allow for backward compatibility support
-	  (selected with CONFIG_OABI_COMPAT).
+	  The Arm EABI is the default ABI on all modern Linux
+	  distributions, replacing the obsolete and "OABI" that was
+	  commonly used on ARMv4 distributions before ca. 2013.
 
-	  To use this you need GCC version 4.0.0 or later.
+	  Everyone should enable this, as support for OABI user space
+	  was dropped in gcc-4.8 and most distributions after ca. 2013.
 
 config OABI_COMPAT
 	bool "Allow old ABI binaries to run with this kernel (EXPERIMENTAL)"
diff --git a/arch/arm/configs/am200epdkit_defconfig b/arch/arm/configs/am200epdkit_defconfig
index 134a559aba3d..22397d45f4a0 100644
--- a/arch/arm/configs/am200epdkit_defconfig
+++ b/arch/arm/configs/am200epdkit_defconfig
@@ -7,7 +7,6 @@ CONFIG_EXPERT=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_ARCH_GUMSTIX=y
-CONFIG_AEABI=y
 # CONFIG_OABI_COMPAT is not set
 CONFIG_CMDLINE="console=ttyS0,115200n8 root=1f01 rootfstype=jffs2"
 CONFIG_MODULES=y
diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_g4_defconfig
index 28b724d59e7e..7a73c891371d 100644
--- a/arch/arm/configs/aspeed_g4_defconfig
+++ b/arch/arm/configs/aspeed_g4_defconfig
@@ -22,7 +22,6 @@ CONFIG_KEXEC=y
 CONFIG_ARCH_ASPEED=y
 CONFIG_MACH_ASPEED_G4=y
 CONFIG_VMSPLIT_2G=y
-CONFIG_AEABI=y
 CONFIG_UACCESS_WITH_MEMCPY=y
 # CONFIG_ATAGS is not set
 CONFIG_JUMP_LABEL=y
diff --git a/arch/arm/configs/assabet_defconfig b/arch/arm/configs/assabet_defconfig
index 07ab9eaac4af..df63889b0c4c 100644
--- a/arch/arm/configs/assabet_defconfig
+++ b/arch/arm/configs/assabet_defconfig
@@ -5,6 +5,7 @@ CONFIG_ARCH_MULTI_V4=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_ASSABET=y
+# CONFIG_AEABI is not set
 CONFIG_CMDLINE="mem=32M console=ttySA0,38400n8 initrd=0xc0800000,3M root=/dev/ram"
 CONFIG_FPE_NWFPE=y
 CONFIG_PM=y
diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index f2596a1b2f7d..be9e02b133e6 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -18,7 +18,6 @@ CONFIG_SOC_AT91SAM9=y
 CONFIG_SOC_SAM9X60=y
 CONFIG_SOC_SAM9X7=y
 # CONFIG_ATMEL_CLOCKSOURCE_PIT is not set
-CONFIG_AEABI=y
 CONFIG_UACCESS_WITH_MEMCPY=y
 # CONFIG_ATAGS is not set
 CONFIG_ARM_APPENDED_DTB=y
diff --git a/arch/arm/configs/axm55xx_defconfig b/arch/arm/configs/axm55xx_defconfig
index 516689dc6cf1..39b06d59d87a 100644
--- a/arch/arm/configs/axm55xx_defconfig
+++ b/arch/arm/configs/axm55xx_defconfig
@@ -38,7 +38,6 @@ CONFIG_PCIE_AXXIA=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=16
 CONFIG_HOTPLUG_CPU=y
-CONFIG_AEABI=y
 CONFIG_OABI_COMPAT=y
 CONFIG_HIGHMEM=y
 CONFIG_ARM_APPENDED_DTB=y
diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index b5f0bd8dd536..1a9af028635a 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -26,7 +26,6 @@ CONFIG_CRASH_DUMP=y
 CONFIG_ARCH_MULTI_V6=y
 CONFIG_ARCH_BCM=y
 CONFIG_ARCH_BCM2835=y
-CONFIG_AEABI=y
 CONFIG_SECCOMP=y
 CONFIG_KEXEC=y
 CONFIG_CPU_FREQ=y
diff --git a/arch/arm/configs/clps711x_defconfig b/arch/arm/configs/clps711x_defconfig
index 6fa3477e6b02..2e993845b5a8 100644
--- a/arch/arm/configs/clps711x_defconfig
+++ b/arch/arm/configs/clps711x_defconfig
@@ -6,7 +6,6 @@ CONFIG_RD_LZMA=y
 CONFIG_EXPERT=y
 CONFIG_JUMP_LABEL=y
 CONFIG_PARTITION_ADVANCED=y
-CONFIG_AEABI=y
 # CONFIG_COREDUMP is not set
 CONFIG_SLUB_TINY=y
 CONFIG_NET=y
diff --git a/arch/arm/configs/collie_defconfig b/arch/arm/configs/collie_defconfig
index 42cb1c854118..ea95e339f51b 100644
--- a/arch/arm/configs/collie_defconfig
+++ b/arch/arm/configs/collie_defconfig
@@ -10,7 +10,6 @@ CONFIG_ARCH_MULTI_V4=y
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_COLLIE=y
 CONFIG_CMDLINE="noinitrd root=/dev/mtdblock2 rootfstype=jffs2 fbcon=rotate:1"
-CONFIG_FPE_NWFPE=y
 CONFIG_PM=y
 # CONFIG_SWAP is not set
 CONFIG_SLUB_TINY=y
diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 3474e475373a..604ec294913d 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -18,7 +18,6 @@ CONFIG_ARCH_DAVINCI_DA830=y
 CONFIG_ARCH_DAVINCI_DA850=y
 CONFIG_DAVINCI_MUX_DEBUG=y
 CONFIG_DAVINCI_MUX_WARNINGS=y
-CONFIG_AEABI=y
 CONFIG_SECCOMP=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
index 2849d17f5856..a0d77193ceb6 100644
--- a/arch/arm/configs/dove_defconfig
+++ b/arch/arm/configs/dove_defconfig
@@ -7,7 +7,6 @@ CONFIG_EXPERT=y
 CONFIG_ARCH_MULTI_V7=y
 CONFIG_ARCH_DOVE=y
 CONFIG_MACH_CM_A510=y
-CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
diff --git a/arch/arm/configs/ep93xx_defconfig b/arch/arm/configs/ep93xx_defconfig
index 7dece9d98828..f68de8de1885 100644
--- a/arch/arm/configs/ep93xx_defconfig
+++ b/arch/arm/configs/ep93xx_defconfig
@@ -18,7 +18,6 @@ CONFIG_MACH_EDB9315=y
 CONFIG_MACH_EDB9315A=y
 CONFIG_MACH_TS72XX=y
 CONFIG_MACH_VISION_EP9307=y
-CONFIG_AEABI=y
 CONFIG_CMDLINE="console=ttyAM0,115200 root=/dev/nfs ip=bootp"
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/arm/configs/footbridge_defconfig b/arch/arm/configs/footbridge_defconfig
index 5f6963687ee4..589b7b1df8c6 100644
--- a/arch/arm/configs/footbridge_defconfig
+++ b/arch/arm/configs/footbridge_defconfig
@@ -11,6 +11,7 @@ CONFIG_ARCH_EBSA285_HOST=y
 CONFIG_ARCH_NETWINDER=y
 CONFIG_FPE_NWFPE=y
 CONFIG_FPE_NWFPE_XP=y
+# CONFIG_AEABI is not set
 CONFIG_MODULES=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_ACORN_PARTITION=y
diff --git a/arch/arm/configs/gemini_defconfig b/arch/arm/configs/gemini_defconfig
index 7b1daec630cb..5860b2fe7d1f 100644
--- a/arch/arm/configs/gemini_defconfig
+++ b/arch/arm/configs/gemini_defconfig
@@ -11,7 +11,6 @@ CONFIG_KEXEC=y
 CONFIG_ARCH_MULTI_V4=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_GEMINI=y
-CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_CMDLINE="console=ttyS0,115200n8"
 CONFIG_PM=y
diff --git a/arch/arm/configs/h3600_defconfig b/arch/arm/configs/h3600_defconfig
index 4e272875c797..0923d331190a 100644
--- a/arch/arm/configs/h3600_defconfig
+++ b/arch/arm/configs/h3600_defconfig
@@ -9,7 +9,6 @@ CONFIG_ARCH_MULTI_V4=y
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_H3600=y
 # CONFIG_CPU_FREQ_STAT is not set
-CONFIG_FPE_NWFPE=y
 CONFIG_MODULES=y
 CONFIG_NET=y
 CONFIG_UNIX=y
diff --git a/arch/arm/configs/hisi_defconfig b/arch/arm/configs/hisi_defconfig
index e19c1039fb93..d91975e95f3d 100644
--- a/arch/arm/configs/hisi_defconfig
+++ b/arch/arm/configs/hisi_defconfig
@@ -10,7 +10,6 @@ CONFIG_ARCH_HIP04=y
 CONFIG_ARCH_HIX5HD2=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=16
-CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index 875c8cdbada7..15c588649378 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -15,7 +15,6 @@ CONFIG_ARCH_MXC=y
 CONFIG_SOC_IMX1=y
 CONFIG_SOC_IMX25=y
 CONFIG_SOC_IMX27=y
-CONFIG_AEABI=y
 CONFIG_PM_DEBUG=y
 CONFIG_KPROBES=y
 CONFIG_MODULES=y
diff --git a/arch/arm/configs/integrator_defconfig b/arch/arm/configs/integrator_defconfig
index 61711d4bbf74..ba38ec810a61 100644
--- a/arch/arm/configs/integrator_defconfig
+++ b/arch/arm/configs/integrator_defconfig
@@ -13,7 +13,6 @@ CONFIG_ARCH_INTEGRATOR=y
 CONFIG_ARCH_INTEGRATOR_AP=y
 CONFIG_INTEGRATOR_IMPD1=y
 CONFIG_ARCH_INTEGRATOR_CP=y
-CONFIG_AEABI=y
 # CONFIG_ATAGS is not set
 CONFIG_CMDLINE="console=ttyAM0,38400n8 root=/dev/nfs ip=bootp"
 CONFIG_CPU_FREQ=y
diff --git a/arch/arm/configs/ixp4xx_defconfig b/arch/arm/configs/ixp4xx_defconfig
index 3cb995b9616a..908edafd6d4a 100644
--- a/arch/arm/configs/ixp4xx_defconfig
+++ b/arch/arm/configs/ixp4xx_defconfig
@@ -9,7 +9,6 @@ CONFIG_EXPERT=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_IXP4XX=y
 CONFIG_CPU_BIG_ENDIAN=y
-CONFIG_AEABI=y
 CONFIG_CMDLINE="console=ttyS0,115200"
 CONFIG_STRICT_KERNEL_RWX=y
 CONFIG_STRICT_MODULE_RWX=y
diff --git a/arch/arm/configs/jornada720_defconfig b/arch/arm/configs/jornada720_defconfig
index e6ec768f42e2..46f0d8eed82d 100644
--- a/arch/arm/configs/jornada720_defconfig
+++ b/arch/arm/configs/jornada720_defconfig
@@ -5,7 +5,6 @@ CONFIG_ARCH_MULTI_V4=y
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_JORNADA720=y
 CONFIG_SA1100_JORNADA720_SSP=y
-CONFIG_FPE_NWFPE=y
 CONFIG_PM=y
 CONFIG_MODULES=y
 CONFIG_NET=y
diff --git a/arch/arm/configs/keystone_defconfig b/arch/arm/configs/keystone_defconfig
index c1291ca290b2..abf542e37e43 100644
--- a/arch/arm/configs/keystone_defconfig
+++ b/arch/arm/configs/keystone_defconfig
@@ -22,7 +22,6 @@ CONFIG_PCI_KEYSTONE=y
 CONFIG_SMP=y
 CONFIG_HOTPLUG_CPU=y
 CONFIG_ARM_PSCI=y
-CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_VFP=y
 CONFIG_NEON=y
diff --git a/arch/arm/configs/lpc32xx_defconfig b/arch/arm/configs/lpc32xx_defconfig
index 98e267213b21..7ef893f05f34 100644
--- a/arch/arm/configs/lpc32xx_defconfig
+++ b/arch/arm/configs/lpc32xx_defconfig
@@ -10,7 +10,6 @@ CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EXPERT=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_LPC32XX=y
-CONFIG_AEABI=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CMDLINE="console=ttyS0,115200n81 root=/dev/ram0"
diff --git a/arch/arm/configs/mmp2_defconfig b/arch/arm/configs/mmp2_defconfig
index f6f9e135353e..61fbedf55fe9 100644
--- a/arch/arm/configs/mmp2_defconfig
+++ b/arch/arm/configs/mmp2_defconfig
@@ -4,7 +4,6 @@ CONFIG_PREEMPT=y
 CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_ARCH_MMP=y
-CONFIG_AEABI=y
 CONFIG_MACH_MMP2_DT=y
 CONFIG_CMDLINE="root=/dev/nfs rootfstype=nfs nfsroot=192.168.1.100:/nfsroot/ ip=192.168.1.101:192.168.1.100::255.255.255.0::eth0:on console=ttyS2,38400 mem=128M user_debug=255 earlyprintk"
 CONFIG_VFP=y
diff --git a/arch/arm/configs/moxart_defconfig b/arch/arm/configs/moxart_defconfig
index 34d079e03b3c..86a6edb50df0 100644
--- a/arch/arm/configs/moxart_defconfig
+++ b/arch/arm/configs/moxart_defconfig
@@ -16,7 +16,6 @@ CONFIG_ARCH_MULTI_V4=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_MOXART=y
 CONFIG_MACH_UC7112LX=y
-CONFIG_AEABI=y
 # CONFIG_ATAGS is not set
 CONFIG_ARM_APPENDED_DTB=y
 # CONFIG_SWAP is not set
diff --git a/arch/arm/configs/multi_v4t_defconfig b/arch/arm/configs/multi_v4t_defconfig
index 27d650635d9b..84811b78cc59 100644
--- a/arch/arm/configs/multi_v4t_defconfig
+++ b/arch/arm/configs/multi_v4t_defconfig
@@ -17,7 +17,6 @@ CONFIG_INTEGRATOR_IMPD1=y
 CONFIG_INTEGRATOR_CM720T=y
 CONFIG_INTEGRATOR_CM920T=y
 CONFIG_INTEGRATOR_CM922T_XA10=y
-CONFIG_AEABI=y
 # CONFIG_ATAGS is not set
 CONFIG_CPU_IDLE=y
 CONFIG_ARM_CPUIDLE=y
diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index 3f4ddcf49ec7..e40276a28760 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -37,7 +37,6 @@ CONFIG_MACH_NET2BIG=y
 CONFIG_MACH_MSS2_DT=y
 CONFIG_ARCH_SUNXI=y
 CONFIG_ARCH_VERSATILE=y
-CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
diff --git a/arch/arm/configs/mv78xx0_defconfig b/arch/arm/configs/mv78xx0_defconfig
index 3343f72de7ea..512445c755da 100644
--- a/arch/arm/configs/mv78xx0_defconfig
+++ b/arch/arm/configs/mv78xx0_defconfig
@@ -11,9 +11,7 @@ CONFIG_ARCH_MULTI_V5=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_MV78XX0=y
 CONFIG_MACH_TERASTATION_WXL=y
-CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
-CONFIG_FPE_NWFPE=y
 CONFIG_VFP=y
 CONFIG_KPROBES=y
 CONFIG_MODULES=y
diff --git a/arch/arm/configs/mvebu_v5_defconfig b/arch/arm/configs/mvebu_v5_defconfig
index 2467afd32146..b8d20e1d9c5d 100644
--- a/arch/arm/configs/mvebu_v5_defconfig
+++ b/arch/arm/configs/mvebu_v5_defconfig
@@ -23,7 +23,6 @@ CONFIG_MACH_MV2120=y
 CONFIG_MACH_D2NET_DT=y
 CONFIG_MACH_NET2BIG=y
 CONFIG_MACH_MSS2_DT=y
-CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index 43bc1255a5db..24dae023a491 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -17,7 +17,6 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_MXS=y
-CONFIG_AEABI=y
 CONFIG_MODULES=y
 CONFIG_MODULE_FORCE_LOAD=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/arm/configs/neponset_defconfig b/arch/arm/configs/neponset_defconfig
index 2227f86100ad..a8833b2ce335 100644
--- a/arch/arm/configs/neponset_defconfig
+++ b/arch/arm/configs/neponset_defconfig
@@ -11,6 +11,7 @@ CONFIG_ZBOOT_ROM_BSS=0xc1000000
 CONFIG_ZBOOT_ROM=y
 CONFIG_CMDLINE="console=ttySA0,38400n8 cpufreq=221200 rw root=/dev/mtdblock2 mtdparts=sa1100:512K(boot),1M(kernel),2560K(initrd),4M(root) load_ramdisk=1 prompt_ramdisk=0 mem=32M noinitrd initrd=0xc0800000,3M"
 CONFIG_FPE_NWFPE=y
+# CONFIG_AEABI is not set
 CONFIG_PM=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/arm/configs/netwinder_defconfig b/arch/arm/configs/netwinder_defconfig
index e639e6ad02cb..7ff70439458d 100644
--- a/arch/arm/configs/netwinder_defconfig
+++ b/arch/arm/configs/netwinder_defconfig
@@ -4,6 +4,7 @@ CONFIG_ARCH_MULTI_V4=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_FOOTBRIDGE=y
 CONFIG_ARCH_NETWINDER=y
+# CONFIG_AEABI is not set
 CONFIG_DEPRECATED_PARAM_STRUCT=y
 CONFIG_CMDLINE="root=0x801"
 CONFIG_FPE_NWFPE=y
diff --git a/arch/arm/configs/nhk8815_defconfig b/arch/arm/configs/nhk8815_defconfig
index ea28ed8991b4..c0b7bfbe2e23 100644
--- a/arch/arm/configs/nhk8815_defconfig
+++ b/arch/arm/configs/nhk8815_defconfig
@@ -12,7 +12,6 @@ CONFIG_KALLSYMS_ALL=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_NOMADIK=y
 CONFIG_MACH_NOMADIK_8815NHK=y
-CONFIG_AEABI=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 # CONFIG_SWAP is not set
diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/omap1_defconfig
index 025b595dd837..589ee6b68e08 100644
--- a/arch/arm/configs/omap1_defconfig
+++ b/arch/arm/configs/omap1_defconfig
@@ -28,9 +28,7 @@ CONFIG_MACH_OMAP_PALMTE=y
 CONFIG_MACH_SX1=y
 CONFIG_MACH_NOKIA770=y
 CONFIG_MACH_AMS_DELTA=y
-CONFIG_AEABI=y
 CONFIG_CMDLINE="root=1f03 rootfstype=jffs2"
-CONFIG_FPE_NWFPE=y
 # CONFIG_SUSPEND is not set
 CONFIG_PM=y
 CONFIG_MODULES=y
diff --git a/arch/arm/configs/orion5x_defconfig b/arch/arm/configs/orion5x_defconfig
index 0629b088a584..8e10c53818a3 100644
--- a/arch/arm/configs/orion5x_defconfig
+++ b/arch/arm/configs/orion5x_defconfig
@@ -20,10 +20,8 @@ CONFIG_MACH_TS409=y
 CONFIG_MACH_TS78XX=y
 CONFIG_MACH_MV2120=y
 CONFIG_MACH_NET2BIG=y
-CONFIG_AEABI=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
-CONFIG_FPE_NWFPE=y
 CONFIG_VFP=y
 CONFIG_KPROBES=y
 CONFIG_MODULES=y
diff --git a/arch/arm/configs/pxa168_defconfig b/arch/arm/configs/pxa168_defconfig
index ce10fe2104bf..65513b313e88 100644
--- a/arch/arm/configs/pxa168_defconfig
+++ b/arch/arm/configs/pxa168_defconfig
@@ -3,11 +3,9 @@ CONFIG_SYSVIPC=y
 CONFIG_NO_HZ_IDLE=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT=y
-CONFIG_AEABI=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_ARCH_MMP=y
 CONFIG_CMDLINE="root=/dev/nfs rootfstype=nfs nfsroot=192.168.2.100:/nfsroot/ ip=192.168.2.101:192.168.2.100::255.255.255.0::eth0:on console=ttyS0,115200 mem=128M"
-CONFIG_FPE_NWFPE=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
diff --git a/arch/arm/configs/pxa3xx_defconfig b/arch/arm/configs/pxa3xx_defconfig
index 381356faf382..42e31ee8e5e2 100644
--- a/arch/arm/configs/pxa3xx_defconfig
+++ b/arch/arm/configs/pxa3xx_defconfig
@@ -7,9 +7,7 @@ CONFIG_KALLSYMS_ALL=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_MACH_PXA3XX_DT=y
-CONFIG_AEABI=y
 CONFIG_CMDLINE="root=/dev/nfs rootfstype=nfs nfsroot=192.168.1.100:/nfsroot/ ip=192.168.1.101:192.168.1.100::255.255.255.0::eth0:on console=ttyS0,115200 mem=64M debug"
-CONFIG_FPE_NWFPE=y
 CONFIG_MODULES=y
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/arm/configs/pxa910_defconfig b/arch/arm/configs/pxa910_defconfig
index 1f28aea86014..d8eaf6c42159 100644
--- a/arch/arm/configs/pxa910_defconfig
+++ b/arch/arm/configs/pxa910_defconfig
@@ -10,8 +10,6 @@ CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
 # CONFIG_BLK_DEV_BSG is not set
-CONFIG_AEABI=y
-CONFIG_FPE_NWFPE=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index 38916ac4bce4..3b9e67546f8c 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -20,7 +20,6 @@ CONFIG_ARCH_GUMSTIX=y
 CONFIG_PXA_SHARPSL=y
 CONFIG_MACH_AKITA=y
 CONFIG_MACH_BORZOI=y
-CONFIG_AEABI=y
 CONFIG_ARCH_FORCE_MAX_ORDER=8
 CONFIG_CMDLINE="root=/dev/ram0 ro"
 CONFIG_CPU_FREQ=y
diff --git a/arch/arm/configs/rpc_defconfig b/arch/arm/configs/rpc_defconfig
index 24f1fa868230..23f10216c615 100644
--- a/arch/arm/configs/rpc_defconfig
+++ b/arch/arm/configs/rpc_defconfig
@@ -7,6 +7,7 @@ CONFIG_ARCH_MULTI_V4=y
 CONFIG_ARCH_RPC=y
 CONFIG_CPU_SA110=y
 CONFIG_FPE_NWFPE=y
+# CONFIG_AEABI is not set
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
diff --git a/arch/arm/configs/spear13xx_defconfig b/arch/arm/configs/spear13xx_defconfig
index a8f992fdb30d..7c7eef615924 100644
--- a/arch/arm/configs/spear13xx_defconfig
+++ b/arch/arm/configs/spear13xx_defconfig
@@ -9,7 +9,6 @@ CONFIG_MACH_SPEAR1340=y
 CONFIG_SMP=y
 # CONFIG_SMP_ON_UP is not set
 # CONFIG_ARM_CPU_TOPOLOGY is not set
-CONFIG_AEABI=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_VFP=y
diff --git a/arch/arm/configs/spitz_defconfig b/arch/arm/configs/spitz_defconfig
index 294d16ddeb18..adf3422e0836 100644
--- a/arch/arm/configs/spitz_defconfig
+++ b/arch/arm/configs/spitz_defconfig
@@ -11,7 +11,6 @@ CONFIG_PXA_SHARPSL=y
 CONFIG_MACH_AKITA=y
 CONFIG_MACH_BORZOI=y
 CONFIG_CMDLINE="console=ttyS0,115200n8 console=tty1 noinitrd root=/dev/mtdblock2 rootfstype=jffs2   debug"
-CONFIG_FPE_NWFPE=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_MODULE_FORCE_UNLOAD=y
diff --git a/arch/arm/configs/versatile_defconfig b/arch/arm/configs/versatile_defconfig
index 849118cbbb44..8e89debb5a5b 100644
--- a/arch/arm/configs/versatile_defconfig
+++ b/arch/arm/configs/versatile_defconfig
@@ -6,7 +6,6 @@ CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_VERSATILE=y
-CONFIG_AEABI=y
 CONFIG_OABI_COMPAT=y
 CONFIG_CMDLINE="root=1f03 mem=32M"
 CONFIG_FPE_NWFPE=y
diff --git a/arch/arm/configs/vt8500_v6_v7_defconfig b/arch/arm/configs/vt8500_v6_v7_defconfig
index 41607a84abc8..2925a1f1dbb6 100644
--- a/arch/arm/configs/vt8500_v6_v7_defconfig
+++ b/arch/arm/configs/vt8500_v6_v7_defconfig
@@ -8,7 +8,6 @@ CONFIG_ARM_ERRATA_720789=y
 CONFIG_ARM_ERRATA_754322=y
 CONFIG_ARM_ERRATA_775420=y
 CONFIG_HAVE_ARM_ARCH_TIMER=y
-CONFIG_AEABI=y
 CONFIG_HIGHMEM=y
 CONFIG_HIGHPTE=y
 CONFIG_ARM_APPENDED_DTB=y
diff --git a/arch/arm/configs/wpcm450_defconfig b/arch/arm/configs/wpcm450_defconfig
index 45483deab034..2edcf5f1a826 100644
--- a/arch/arm/configs/wpcm450_defconfig
+++ b/arch/arm/configs/wpcm450_defconfig
@@ -13,7 +13,6 @@ CONFIG_PROFILING=y
 CONFIG_ARCH_NPCM=y
 CONFIG_ARCH_WPCM450=y
 CONFIG_CPU_DCACHE_WRITETHROUGH=y
-CONFIG_AEABI=y
 CONFIG_UACCESS_WITH_MEMCPY=y
 # CONFIG_ATAGS is not set
 CONFIG_ARM_APPENDED_DTB=y
-- 
2.39.5


