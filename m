Return-Path: <linux-kernel+bounces-430943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D7809E3772
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182EC281334
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C110E1AF0DD;
	Wed,  4 Dec 2024 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UvpFw1HQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A840A1AF0CD
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308193; cv=none; b=L0UhE4YwKfW8FCKAuAwEF5b28UpEeIbZhkf/faCaQq8FlbAaXMY6wMDem+w1OYvaSiEjFYrp0UDc8MfZi8ebhSLas/3MmolPSQSBehzpEkykHR088Djn99iRro9Em8WvNcPSgKD9lJzKt/jp7OuuPiob4F/AOxvPJtimMWDeASw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308193; c=relaxed/simple;
	bh=odiXZF9/8boxgqFoFHh2kPhVMlXN/G/m8KmIk6qowiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ue4eVUx0ZVV95BCXNqOW4IUXFmpo3J6eLgnIl+BcQDA2+G+hiuln9qDIKAxIghbX+D7jq2rks+CnrX6tqQcVNPaOD3Z/QwMObMOjisj1br0yhqNepfOqexvmjQUXQ4x6MJ75GIAL61zKPkAgYCiK6d7PgYIFGKGdDb7XtJJB3/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UvpFw1HQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92229C4CEDD;
	Wed,  4 Dec 2024 10:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733308193;
	bh=odiXZF9/8boxgqFoFHh2kPhVMlXN/G/m8KmIk6qowiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UvpFw1HQc9yQyXfrt7ubOWtw9+ip9OG52EQ1bPkgbomqqMlEyq3EapVIgKXQcaziv
	 QDUJpT/TPtRGb+JFoN25f7HQGE75pfKbxL2yj8kwu93LE5T/nj9cpC8sKaJ9Lyxr4e
	 jTIgha7eSzhSuOAOO8orhUhPYcmec3+Mp36mayJoXKjKEHWsLWdgpGrji47OmT2kjS
	 6Vs8De0yp4a0xTiKM3XMJGXlDCN6n/EoN4KmutHmDggn4nqt2t12kZSLQ1A+730d6Q
	 jbpDBtqOVMDRsFgWH4C+XMaB6DpIWhatlK+WGfC9Of1dJuJNOInUAwJb9W/tcjDSmn
	 fN0K5RtdnayoA==
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
Subject: [PATCH 05/15] ARM: turn CONFIG_ATAGS off by default
Date: Wed,  4 Dec 2024 11:28:54 +0100
Message-Id: <20241204102904.1863796-6-arnd@kernel.org>
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

Only a very small number of machines remain that rely on
traditional board files with the ATAGS boot data instead
of devicetree, and we have not accepted new ones for
a decade.

Most of the remaining ones are on their way out of the
kernel, but the Kconfig option that controls ATAGS
is still enabled by default.

To reflect the actual status of ATAGS support and alert
the remaining users of upstream and out-of-tree platforms
with this, chanyge it to being default-disabled and
add a dependency on CONFIG_EXPERT.

The board specific defconfig files that rely on ATAGS
are changed to turn on both EXPERT and ATAGS if they
were not doing thath already, and the ones that explicitly
turned it off before no longer need to.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig                       | 13 ++++++++-----
 arch/arm/configs/am200epdkit_defconfig |  1 +
 arch/arm/configs/aspeed_g4_defconfig   |  1 -
 arch/arm/configs/aspeed_g5_defconfig   |  1 -
 arch/arm/configs/assabet_defconfig     |  2 ++
 arch/arm/configs/at91_dt_defconfig     |  1 -
 arch/arm/configs/collie_defconfig      |  1 +
 arch/arm/configs/dove_defconfig        |  1 +
 arch/arm/configs/footbridge_defconfig  |  1 +
 arch/arm/configs/h3600_defconfig       |  2 ++
 arch/arm/configs/integrator_defconfig  |  1 -
 arch/arm/configs/jornada720_defconfig  |  2 ++
 arch/arm/configs/moxart_defconfig      |  1 -
 arch/arm/configs/mps2_defconfig        |  1 -
 arch/arm/configs/multi_v4t_defconfig   |  1 -
 arch/arm/configs/mv78xx0_defconfig     |  1 +
 arch/arm/configs/neponset_defconfig    |  2 ++
 arch/arm/configs/netwinder_defconfig   |  2 ++
 arch/arm/configs/omap1_defconfig       |  1 +
 arch/arm/configs/rpc_defconfig         |  2 ++
 arch/arm/configs/s3c6400_defconfig     |  2 ++
 arch/arm/configs/sama5_defconfig       |  1 -
 arch/arm/configs/sama7_defconfig       |  1 -
 arch/arm/configs/spitz_defconfig       |  1 +
 arch/arm/configs/stm32_defconfig       |  1 -
 arch/arm/configs/wpcm450_defconfig     |  1 -
 26 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 54f5cc12dea4..2167f71f184b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1400,12 +1400,15 @@ config ARCH_WANT_FLAT_DTB_INSTALL
 
 config ATAGS
 	bool "Support for the traditional ATAGS boot data passing"
-	default y
+	depends on EXPERT
 	help
-	  This is the traditional way of passing data to the kernel at boot
-	  time. If you are solely relying on the flattened device tree (or
-	  the ARM_ATAG_DTB_COMPAT option) then you may unselect this option
-	  to remove ATAGS support from your kernel binary.
+	  This is the traditional way of passing data to the kernel at
+	  boot but is now only used by a few of the oldest ARMv4 and
+	  ARMv5 machines.  Users that still rely on ATAGS should plan
+	  on migrating to devicetree based booting.
+
+	  Support for ATAGS will be removed when the last machine using
+	  it is either converted to DT or removed.
 
 config DEPRECATED_PARAM_STRUCT
 	bool "Provide old way to pass kernel parameters"
diff --git a/arch/arm/configs/am200epdkit_defconfig b/arch/arm/configs/am200epdkit_defconfig
index 55c5c08a5f96..7a67118f8489 100644
--- a/arch/arm/configs/am200epdkit_defconfig
+++ b/arch/arm/configs/am200epdkit_defconfig
@@ -7,6 +7,7 @@ CONFIG_EXPERT=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
 CONFIG_ARCH_GUMSTIX=y
+CONFIG_ATAGS=y
 CONFIG_CMDLINE="console=ttyS0,115200n8 root=1f01 rootfstype=jffs2"
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_g4_defconfig
index 7a73c891371d..ebbd5ad12c73 100644
--- a/arch/arm/configs/aspeed_g4_defconfig
+++ b/arch/arm/configs/aspeed_g4_defconfig
@@ -23,7 +23,6 @@ CONFIG_ARCH_ASPEED=y
 CONFIG_MACH_ASPEED_G4=y
 CONFIG_VMSPLIT_2G=y
 CONFIG_UACCESS_WITH_MEMCPY=y
-# CONFIG_ATAGS is not set
 CONFIG_JUMP_LABEL=y
 CONFIG_STRICT_KERNEL_RWX=y
 # CONFIG_BLK_DEBUG_FS is not set
diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index 61cee1e7ebea..99da4f5be25a 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -29,7 +29,6 @@ CONFIG_VMSPLIT_2G=y
 CONFIG_NR_CPUS=2
 CONFIG_HIGHMEM=y
 CONFIG_UACCESS_WITH_MEMCPY=y
-# CONFIG_ATAGS is not set
 CONFIG_VFP=y
 CONFIG_NEON=y
 CONFIG_KERNEL_MODE_NEON=y
diff --git a/arch/arm/configs/assabet_defconfig b/arch/arm/configs/assabet_defconfig
index df63889b0c4c..e4264fdac2e5 100644
--- a/arch/arm/configs/assabet_defconfig
+++ b/arch/arm/configs/assabet_defconfig
@@ -1,11 +1,13 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_EXPERT=y
 CONFIG_ARCH_MULTI_V4=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_ASSABET=y
 # CONFIG_AEABI is not set
+CONFIG_ATAGS=y
 CONFIG_CMDLINE="mem=32M console=ttySA0,38400n8 initrd=0xc0800000,3M root=/dev/ram"
 CONFIG_FPE_NWFPE=y
 CONFIG_PM=y
diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
index be9e02b133e6..5950f8274646 100644
--- a/arch/arm/configs/at91_dt_defconfig
+++ b/arch/arm/configs/at91_dt_defconfig
@@ -19,7 +19,6 @@ CONFIG_SOC_SAM9X60=y
 CONFIG_SOC_SAM9X7=y
 # CONFIG_ATMEL_CLOCKSOURCE_PIT is not set
 CONFIG_UACCESS_WITH_MEMCPY=y
-# CONFIG_ATAGS is not set
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_CMDLINE="console=ttyS0,115200 initrd=0x21100000,25165824 root=/dev/ram0 rw"
diff --git a/arch/arm/configs/collie_defconfig b/arch/arm/configs/collie_defconfig
index ea95e339f51b..7a6fd164e263 100644
--- a/arch/arm/configs/collie_defconfig
+++ b/arch/arm/configs/collie_defconfig
@@ -9,6 +9,7 @@ CONFIG_ARCH_MULTI_V4=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_COLLIE=y
+CONFIG_ATAGS=y
 CONFIG_CMDLINE="noinitrd root=/dev/mtdblock2 rootfstype=jffs2 fbcon=rotate:1"
 CONFIG_PM=y
 # CONFIG_SWAP is not set
diff --git a/arch/arm/configs/dove_defconfig b/arch/arm/configs/dove_defconfig
index a0d77193ceb6..8cfeec7415b2 100644
--- a/arch/arm/configs/dove_defconfig
+++ b/arch/arm/configs/dove_defconfig
@@ -8,6 +8,7 @@ CONFIG_ARCH_MULTI_V7=y
 CONFIG_ARCH_DOVE=y
 CONFIG_MACH_CM_A510=y
 CONFIG_HIGHMEM=y
+CONFIG_ATAGS=y
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_ARM_ATAG_DTB_COMPAT=y
 CONFIG_VFP=y
diff --git a/arch/arm/configs/footbridge_defconfig b/arch/arm/configs/footbridge_defconfig
index e8bf9847d35d..0872dba5de79 100644
--- a/arch/arm/configs/footbridge_defconfig
+++ b/arch/arm/configs/footbridge_defconfig
@@ -10,6 +10,7 @@ CONFIG_ARCH_FOOTBRIDGE=y
 CONFIG_ARCH_EBSA285_HOST=y
 CONFIG_ARCH_NETWINDER=y
 # CONFIG_AEABI is not set
+CONFIG_ATAGS=y
 CONFIG_FPE_NWFPE=y
 CONFIG_FPE_NWFPE_XP=y
 CONFIG_MODULES=y
diff --git a/arch/arm/configs/h3600_defconfig b/arch/arm/configs/h3600_defconfig
index 0923d331190a..3e8da62d959d 100644
--- a/arch/arm/configs/h3600_defconfig
+++ b/arch/arm/configs/h3600_defconfig
@@ -4,11 +4,13 @@ CONFIG_HIGH_RES_TIMERS=y
 CONFIG_PREEMPT=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_EXPERT=y
 CONFIG_ARCH_MULTI_V4=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_H3600=y
 # CONFIG_CPU_FREQ_STAT is not set
+CONFIG_ATAGS=y
 CONFIG_MODULES=y
 CONFIG_NET=y
 CONFIG_UNIX=y
diff --git a/arch/arm/configs/integrator_defconfig b/arch/arm/configs/integrator_defconfig
index ba38ec810a61..82180381bf3c 100644
--- a/arch/arm/configs/integrator_defconfig
+++ b/arch/arm/configs/integrator_defconfig
@@ -13,7 +13,6 @@ CONFIG_ARCH_INTEGRATOR=y
 CONFIG_ARCH_INTEGRATOR_AP=y
 CONFIG_INTEGRATOR_IMPD1=y
 CONFIG_ARCH_INTEGRATOR_CP=y
-# CONFIG_ATAGS is not set
 CONFIG_CMDLINE="console=ttyAM0,38400n8 root=/dev/nfs ip=bootp"
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_GOV_POWERSAVE=y
diff --git a/arch/arm/configs/jornada720_defconfig b/arch/arm/configs/jornada720_defconfig
index 46f0d8eed82d..036a96d2b72a 100644
--- a/arch/arm/configs/jornada720_defconfig
+++ b/arch/arm/configs/jornada720_defconfig
@@ -1,11 +1,13 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
+CONFIG_EXPERT=y
 CONFIG_ARCH_MULTI_V4=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_JORNADA720=y
 CONFIG_SA1100_JORNADA720_SSP=y
 CONFIG_PM=y
+CONFIG_ATAGS=y
 CONFIG_MODULES=y
 CONFIG_NET=y
 CONFIG_PACKET=y
diff --git a/arch/arm/configs/moxart_defconfig b/arch/arm/configs/moxart_defconfig
index 86a6edb50df0..32e3c8692cb2 100644
--- a/arch/arm/configs/moxart_defconfig
+++ b/arch/arm/configs/moxart_defconfig
@@ -16,7 +16,6 @@ CONFIG_ARCH_MULTI_V4=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_MOXART=y
 CONFIG_MACH_UC7112LX=y
-# CONFIG_ATAGS is not set
 CONFIG_ARM_APPENDED_DTB=y
 # CONFIG_SWAP is not set
 # CONFIG_COMPAT_BRK is not set
diff --git a/arch/arm/configs/mps2_defconfig b/arch/arm/configs/mps2_defconfig
index e995e50537ef..cacf3876f6e4 100644
--- a/arch/arm/configs/mps2_defconfig
+++ b/arch/arm/configs/mps2_defconfig
@@ -16,7 +16,6 @@ CONFIG_ARCH_MPS2=y
 CONFIG_SET_MEM_PARAM=y
 CONFIG_DRAM_BASE=0x21000000
 CONFIG_DRAM_SIZE=0x1000000
-# CONFIG_ATAGS is not set
 # CONFIG_SUSPEND is not set
 # CONFIG_BLOCK is not set
 CONFIG_BINFMT_FLAT=y
diff --git a/arch/arm/configs/multi_v4t_defconfig b/arch/arm/configs/multi_v4t_defconfig
index 84811b78cc59..0704358e6c39 100644
--- a/arch/arm/configs/multi_v4t_defconfig
+++ b/arch/arm/configs/multi_v4t_defconfig
@@ -17,7 +17,6 @@ CONFIG_INTEGRATOR_IMPD1=y
 CONFIG_INTEGRATOR_CM720T=y
 CONFIG_INTEGRATOR_CM920T=y
 CONFIG_INTEGRATOR_CM922T_XA10=y
-# CONFIG_ATAGS is not set
 CONFIG_CPU_IDLE=y
 CONFIG_ARM_CPUIDLE=y
 CONFIG_ARM_CLPS711X_CPUIDLE=y
diff --git a/arch/arm/configs/mv78xx0_defconfig b/arch/arm/configs/mv78xx0_defconfig
index 512445c755da..68ea1fabc00c 100644
--- a/arch/arm/configs/mv78xx0_defconfig
+++ b/arch/arm/configs/mv78xx0_defconfig
@@ -12,6 +12,7 @@ CONFIG_ARCH_MULTI_V5=y
 CONFIG_ARCH_MV78XX0=y
 CONFIG_MACH_TERASTATION_WXL=y
 CONFIG_HIGHMEM=y
+CONFIG_ATAGS=y
 CONFIG_VFP=y
 CONFIG_KPROBES=y
 CONFIG_MODULES=y
diff --git a/arch/arm/configs/neponset_defconfig b/arch/arm/configs/neponset_defconfig
index 7a7b6a896f85..6d35eae8311b 100644
--- a/arch/arm/configs/neponset_defconfig
+++ b/arch/arm/configs/neponset_defconfig
@@ -1,12 +1,14 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_EXPERT=y
 CONFIG_ARCH_MULTI_V4=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_SA1100=y
 CONFIG_SA1100_ASSABET=y
 CONFIG_ASSABET_NEPONSET=y
 # CONFIG_AEABI is not set
+CONFIG_ATAGS=y
 CONFIG_ZBOOT_ROM_TEXT=0x80000
 CONFIG_ZBOOT_ROM_BSS=0xc1000000
 CONFIG_ZBOOT_ROM=y
diff --git a/arch/arm/configs/netwinder_defconfig b/arch/arm/configs/netwinder_defconfig
index 7ff70439458d..77d4a2b5916b 100644
--- a/arch/arm/configs/netwinder_defconfig
+++ b/arch/arm/configs/netwinder_defconfig
@@ -1,10 +1,12 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
+CONFIG_EXPERT=y
 CONFIG_ARCH_MULTI_V4=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_FOOTBRIDGE=y
 CONFIG_ARCH_NETWINDER=y
 # CONFIG_AEABI is not set
+CONFIG_ATAGS=y
 CONFIG_DEPRECATED_PARAM_STRUCT=y
 CONFIG_CMDLINE="root=0x801"
 CONFIG_FPE_NWFPE=y
diff --git a/arch/arm/configs/omap1_defconfig b/arch/arm/configs/omap1_defconfig
index 589ee6b68e08..3b487a25c8b7 100644
--- a/arch/arm/configs/omap1_defconfig
+++ b/arch/arm/configs/omap1_defconfig
@@ -28,6 +28,7 @@ CONFIG_MACH_OMAP_PALMTE=y
 CONFIG_MACH_SX1=y
 CONFIG_MACH_NOKIA770=y
 CONFIG_MACH_AMS_DELTA=y
+CONFIG_ATAGS=y
 CONFIG_CMDLINE="root=1f03 rootfstype=jffs2"
 # CONFIG_SUSPEND is not set
 CONFIG_PM=y
diff --git a/arch/arm/configs/rpc_defconfig b/arch/arm/configs/rpc_defconfig
index 23f10216c615..b75fc8570348 100644
--- a/arch/arm/configs/rpc_defconfig
+++ b/arch/arm/configs/rpc_defconfig
@@ -2,12 +2,14 @@
 CONFIG_SYSVIPC=y
 CONFIG_LOG_BUF_SHIFT=14
 CONFIG_BLK_DEV_INITRD=y
+CONFIG_EXPERT=y
 CONFIG_ARCH_MULTI_V4=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_RPC=y
 CONFIG_CPU_SA110=y
 CONFIG_FPE_NWFPE=y
 # CONFIG_AEABI is not set
+CONFIG_ATAGS=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
 CONFIG_PARTITION_ADVANCED=y
diff --git a/arch/arm/configs/s3c6400_defconfig b/arch/arm/configs/s3c6400_defconfig
index a37e6ac40825..64378bb55be5 100644
--- a/arch/arm/configs/s3c6400_defconfig
+++ b/arch/arm/configs/s3c6400_defconfig
@@ -2,8 +2,10 @@ CONFIG_BLK_DEV_INITRD=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_ARCH_MULTI_V6=y
 # CONFIG_ARCH_MULTI_V7 is not set
+CONFIG_EXPERT=y
 CONFIG_ARCH_S3C64XX=y
 CONFIG_MACH_WLF_CRAGG_6410=y
+CONFIG_ATAGS=y
 CONFIG_CMDLINE="console=ttySAC0,115200 root=/dev/ram init=/linuxrc initrd=0x51000000,6M ramdisk_size=6144"
 CONFIG_VFP=y
 CONFIG_MODULES=y
diff --git a/arch/arm/configs/sama5_defconfig b/arch/arm/configs/sama5_defconfig
index e447329398d5..84cfc5c3584e 100644
--- a/arch/arm/configs/sama5_defconfig
+++ b/arch/arm/configs/sama5_defconfig
@@ -13,7 +13,6 @@ CONFIG_SOC_SAMA5D3=y
 CONFIG_SOC_SAMA5D4=y
 # CONFIG_ATMEL_CLOCKSOURCE_PIT is not set
 CONFIG_UACCESS_WITH_MEMCPY=y
-# CONFIG_ATAGS is not set
 CONFIG_CMDLINE="console=ttyS0,115200 initrd=0x21100000,25165824 root=/dev/ram0 rw"
 CONFIG_VFP=y
 CONFIG_NEON=y
diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
index 1a2e93c8ee71..650bced07bc4 100644
--- a/arch/arm/configs/sama7_defconfig
+++ b/arch/arm/configs/sama7_defconfig
@@ -19,7 +19,6 @@ CONFIG_ATMEL_CLOCKSOURCE_TCB=y
 # CONFIG_CPU_SW_DOMAIN_PAN is not set
 CONFIG_ARCH_FORCE_MAX_ORDER=14
 CONFIG_UACCESS_WITH_MEMCPY=y
-# CONFIG_ATAGS is not set
 CONFIG_CMDLINE="console=ttyS0,115200 earlyprintk ignore_loglevel"
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE=y
diff --git a/arch/arm/configs/spitz_defconfig b/arch/arm/configs/spitz_defconfig
index adf3422e0836..bffd4fe566ea 100644
--- a/arch/arm/configs/spitz_defconfig
+++ b/arch/arm/configs/spitz_defconfig
@@ -10,6 +10,7 @@ CONFIG_ARCH_PXA=y
 CONFIG_PXA_SHARPSL=y
 CONFIG_MACH_AKITA=y
 CONFIG_MACH_BORZOI=y
+CONFIG_ATAGS=y
 CONFIG_CMDLINE="console=ttyS0,115200n8 console=tty1 noinitrd root=/dev/mtdblock2 rootfstype=jffs2   debug"
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
diff --git a/arch/arm/configs/stm32_defconfig b/arch/arm/configs/stm32_defconfig
index 3baec075d1ef..2fc1eee042d2 100644
--- a/arch/arm/configs/stm32_defconfig
+++ b/arch/arm/configs/stm32_defconfig
@@ -20,7 +20,6 @@ CONFIG_SET_MEM_PARAM=y
 CONFIG_DRAM_BASE=0x90000000
 CONFIG_FLASH_MEM_BASE=0x08000000
 CONFIG_FLASH_SIZE=0x00200000
-# CONFIG_ATAGS is not set
 CONFIG_XIP_KERNEL=y
 CONFIG_XIP_PHYS_ADDR=0x08008000
 CONFIG_BINFMT_FLAT=y
diff --git a/arch/arm/configs/wpcm450_defconfig b/arch/arm/configs/wpcm450_defconfig
index 2edcf5f1a826..b4194afeb209 100644
--- a/arch/arm/configs/wpcm450_defconfig
+++ b/arch/arm/configs/wpcm450_defconfig
@@ -14,7 +14,6 @@ CONFIG_ARCH_NPCM=y
 CONFIG_ARCH_WPCM450=y
 CONFIG_CPU_DCACHE_WRITETHROUGH=y
 CONFIG_UACCESS_WITH_MEMCPY=y
-# CONFIG_ATAGS is not set
 CONFIG_ARM_APPENDED_DTB=y
 CONFIG_CPU_IDLE=y
 CONFIG_KPROBES=y
-- 
2.39.5


