Return-Path: <linux-kernel+bounces-217057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AFD090AB05
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 510EEB33704
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 09:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB03198A29;
	Mon, 17 Jun 2024 09:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzYRHtit"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531C4194C8A
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 09:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718617106; cv=none; b=KiaSiPTDLcCYjjeER4vjR/1mDLDu/V8D1D6p85Rbiec2RoHlt6AmBuegizCkarGfF19d8RBPe6VbJiIjb+ScxGBUUhbgwUdAuPEN0TUGYishZIjihrY7LSdKUZSoi8WgvwmaW5g7i7mYo5S/q1mL33AmzSnL+da6wK+e6JKnAF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718617106; c=relaxed/simple;
	bh=FD/OOqH3zJS8nlVwHYANth0Q9YjcU3BgLDcnnwTz1xc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XfYYMxdMr3iqKq75n3rrskYuQDZs/rDboK9IHAqel/joJeO/D8HBRWzWhLEc39s5wmMtYg/MglsyU35CKpcM+ui+k55QWxJRGXJJX35U5hMQ89XF3xNimvI5VTsC+NEQ4S3/guYwQjqA6bqcyHhY8XkyHBYINonsFccozCy40YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzYRHtit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A0BF7C4DDE5;
	Mon, 17 Jun 2024 09:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718617105;
	bh=FD/OOqH3zJS8nlVwHYANth0Q9YjcU3BgLDcnnwTz1xc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=SzYRHtitdFkVgsFbqGhoLjpJ+cfAh0X4VKjI3yBt2qZO+/aETeXZLPYYzJVrK3YSW
	 6ICLpX4Wpdg4wnbnnn8PTQW8tGJKGkji8i/ln2cCBBiL1W7YJYaeFIeYncwkFZST5d
	 QEhJswZp337C4jEkG0Go85WKyVIhuYnV+CkjcpAwn8A+NtrfsSkyAqAXMPZCBgNRiO
	 uW+viu6qXVqcekeH8vS5GcFkFR1FFF4y5KBjOhl7DJH8mmnZnWyySLhyaS7FdotAxH
	 Xdaw/s93qtaaD2ljtKniljNn/mZA7drju56xwxH85XL0jb2eWJlGc6riIB/t3nFnJ/
	 MVpE3kcZnr/hA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BBBC2BA1A;
	Mon, 17 Jun 2024 09:38:25 +0000 (UTC)
From: Nikita Shubin via B4 Relay <devnull+nikita.shubin.maquefel.me@kernel.org>
Date: Mon, 17 Jun 2024 12:37:06 +0300
Subject: [PATCH v10 32/38] ARM: ep93xx: DT for the Cirrus ep93xx SoC
 platforms
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240617-ep93xx-v10-32-662e640ed811@maquefel.me>
References: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
In-Reply-To: <20240617-ep93xx-v10-0-662e640ed811@maquefel.me>
To: Russell King <linux@armlinux.org.uk>, 
 Hartley Sweeten <hsweeten@visionengravers.com>, 
 Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
 Andrew Davis <afd@ti.com>, Arnd Bergmann <arnd@arndb.de>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Masahiro Yamada <masahiroy@kernel.org>, 
 Nikita Shubin <nikita.shubin@maquefel.me>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>
X-Mailer: b4 0.13-dev-e3e53
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718617100; l=3110;
 i=nikita.shubin@maquefel.me; s=20230718; h=from:subject:message-id;
 bh=MU0azT5lNnulLeP5AfbO0wMy6289MR0wM0qk0K+/fy8=;
 b=e+zZGNz9U1RB6nrSbfRG0wFAiA6bZMEB8O9t5bDDekR3xG4sUlz9Uj6y+zvjn/PHRFhWuKg+t+jQ
 0Rhm3GTdCZiY7Pyv33YesQCKm5ZVmi48ONEUKp97sL+8Y+sSLFjx
X-Developer-Key: i=nikita.shubin@maquefel.me; a=ed25519;
 pk=vqf5YIUJ7BJv3EJFaNNxWZgGuMgDH6rwufTLflwU9ac=
X-Endpoint-Received: by B4 Relay for nikita.shubin@maquefel.me/20230718
 with auth_id=65
X-Original-From: Nikita Shubin <nikita.shubin@maquefel.me>
Reply-To: nikita.shubin@maquefel.me

From: Nikita Shubin <nikita.shubin@maquefel.me>

Add compulsory device tree support to the Cirrus ep93xx ARMv4 platform.

- select PINCTRL_EP93xx
- select COMMON_CLK_EP93XX, as clock driver moved out of platform code
- select ARCH_HAS_RESET_CONTROLLER

Select ARM_ATAG_DTB_COMPAT to update device tree with information
about memory passed from bootloader.

We have to leave all MACH options as they are used for board checking
before decomp, to turn off watchdog and ethernet DMA.

Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
---
 arch/arm/Makefile             |  1 -
 arch/arm/mach-ep93xx/Kconfig  | 20 ++++++++++----------
 arch/arm/mach-ep93xx/Makefile | 11 -----------
 3 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 71afdd98ddf2..aafebf145738 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -183,7 +183,6 @@ machine-$(CONFIG_ARCH_CLPS711X)		+= clps711x
 machine-$(CONFIG_ARCH_DAVINCI)		+= davinci
 machine-$(CONFIG_ARCH_DIGICOLOR)	+= digicolor
 machine-$(CONFIG_ARCH_DOVE)		+= dove
-machine-$(CONFIG_ARCH_EP93XX)		+= ep93xx
 machine-$(CONFIG_ARCH_EXYNOS)		+= exynos
 machine-$(CONFIG_ARCH_FOOTBRIDGE)	+= footbridge
 machine-$(CONFIG_ARCH_GEMINI)		+= gemini
diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
index 703f3d232a60..812b71dcf60e 100644
--- a/arch/arm/mach-ep93xx/Kconfig
+++ b/arch/arm/mach-ep93xx/Kconfig
@@ -3,27 +3,27 @@ menuconfig ARCH_EP93XX
 	bool "EP93xx-based"
 	depends on ATAGS
 	depends on ARCH_MULTI_V4T
+	# CONFIG_ARCH_MULTI_V7 is not set
 	depends on CPU_LITTLE_ENDIAN
+	select ARCH_HAS_RESET_CONTROLLER
 	select ARCH_SPARSEMEM_ENABLE
 	select ARM_AMBA
 	select ARM_VIC
+	select ARM_APPENDED_DTB # Old Redboot bootloaders deployed
+	select ARM_ATAG_DTB_COMPAT # we need this to update dt memory node
+	select COMMON_CLK_EP93XX
+	select EP93XX_TIMER
 	select CLKSRC_MMIO
 	select CPU_ARM920T
 	select GPIOLIB
+	select PINCTRL
+	select PINCTRL_EP93XX
 	help
 	  This enables support for the Cirrus EP93xx series of CPUs.
 
 if ARCH_EP93XX
 
-menu "Cirrus EP93xx Implementation Options"
-
-config EP93XX_SOC_COMMON
-	bool
-	default y
-	select SOC_BUS
-	select LEDS_GPIO_REGISTER
-
-comment "EP93xx Platforms"
+# menu "EP93xx Platforms"
 
 config MACH_BK3
 	bool "Support Liebherr BK3.1"
@@ -103,6 +103,6 @@ config MACH_VISION_EP9307
 	  Say 'Y' here if you want your kernel to support the
 	  Vision Engraving Systems EP9307 SoM.
 
-endmenu
+# endmenu
 
 endif
diff --git a/arch/arm/mach-ep93xx/Makefile b/arch/arm/mach-ep93xx/Makefile
deleted file mode 100644
index 62e37403df14..000000000000
--- a/arch/arm/mach-ep93xx/Makefile
+++ /dev/null
@@ -1,11 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# Makefile for the linux kernel.
-#
-obj-y			:= core.o clock.o timer-ep93xx.o
-
-obj-$(CONFIG_EP93XX_DMA)	+= dma.o
-
-obj-$(CONFIG_MACH_EDB93XX)	+= edb93xx.o
-obj-$(CONFIG_MACH_TS72XX)	+= ts72xx.o
-obj-$(CONFIG_MACH_VISION_EP9307)+= vision_ep9307.o

-- 
2.43.2



