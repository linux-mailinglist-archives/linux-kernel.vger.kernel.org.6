Return-Path: <linux-kernel+bounces-273498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2729469F6
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 16:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 805FC281AFE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 14:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042BD139D03;
	Sat,  3 Aug 2024 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMr7CzzY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C8D1ABEB3
	for <linux-kernel@vger.kernel.org>; Sat,  3 Aug 2024 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722693683; cv=none; b=J8YFkM1MnGBEJOW5ND0CenjwjZzuFtng0u+QlnfNRZP4f/5LLfAZNq5tHXmpZPQhWAQZOis7IVzpE7Jce9UCImiL/hutEPMzlDnZQrqSAI0f1AuPMixWJktrc3mXHi7OE9+CXAqxBUv3sjRo5aNgASqiGIAg9aXqgll56rtyxQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722693683; c=relaxed/simple;
	bh=rP2UZRpPcr32Vo1X6UBkLA30Rc1YQdFaV5IlXUUTwf8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JkRYDncQIqlrs3+X28WibjIX2t0Nt7qrbnk7v8zdeGKumoLYOGBbHXMUGhI6VpVs+bMoNcjvTg7YzoTgjB66bsBUzD6fDXhRPWuLAojyfu6O1kX+yJ0zI1Dg0al0D6Hl2hGSX08yRC1xFwujjp342e4/4pSI9zolLLavuzxxDJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMr7CzzY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D1CAC116B1;
	Sat,  3 Aug 2024 14:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722693682;
	bh=rP2UZRpPcr32Vo1X6UBkLA30Rc1YQdFaV5IlXUUTwf8=;
	h=From:To:Cc:Subject:Date:From;
	b=eMr7CzzYS/boccNWjj7LAkxNZxWxuC+/hz8ERh/JB5rE+eD9RWlDKFa6ngKl7XMhv
	 tjfrDu4IMcMahQLXvBdu7N777912Sc4OseeqMcYZNq8zISfZMxzyo5MLaC9Sza0RPV
	 UbTgdYr/3cd6cLpNtbSFI2iI8fhnLa0jBxJ+PTU9QNSRVzn+FXM1W0fFstn4238w+l
	 BWtOlKSKgj18pMeEwBd4v4SIVLilFDNJ5NPN58xMFJdKl7gLOW/wGQ4SNDLDaUa8Ky
	 8E/ec7A1f+anccrD191y42F720qqVR+RHc7SBJPPm5Bt4Qr6XyCe8c4p9XTfUCMdpX
	 vkV5+qaaqNdfg==
From: Arnd Bergmann <arnd@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	kernel test robot <lkp@intel.com>,
	Greg Ungerer <gerg@linux-m68k.org>,
	linux-m68k@lists.linux-m68k.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] m68k: move sun3 into a top-level platform option
Date: Sat,  3 Aug 2024 16:00:57 +0200
Message-Id: <20240803140115.3305547-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

It is possible to select an m68k MMU build but not actually
enable any of the three MMU options, which then results in a
build failure:

 arch/m68k/include/asm/page.h:10:25: error: 'CONFIG_PAGE_SHIFT' undeclared here (not in a function); did you mean 'CONFIG_LOG_BUF_SHIFT'?

Change the Kconfig selection to ensure that exactly one of the
three options is always enabled whenever an MMU-enabled kernel
is built, but moving CONFIG_SUN3 into a top-level option next
to M68KCLASSIC and COLDFIRE.

All defconfig files should keep working without changes,
but alldefconfig now builds support for the classic MMU.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408032138.P7sBvIns-lkp@intel.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I saw another copy of the bug report today.

Geert, any opinions on this approach? I posted this before but
it looks like you missed it.
---
 arch/m68k/Kconfig         | 11 +++++------
 arch/m68k/Kconfig.cpu     | 30 ++++++++++++++++++++----------
 arch/m68k/Kconfig.machine | 25 -------------------------
 arch/m68k/kernel/Makefile | 12 ++----------
 arch/m68k/kernel/time.c   |  4 ++--
 5 files changed, 29 insertions(+), 53 deletions(-)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index cc26df907bfe..7c4f7bcc89d7 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -84,24 +84,23 @@ config MMU
 	  support by paged memory management. If unsure, say 'Y'.
 
 config MMU_MOTOROLA
-	bool
+	def_bool MMU && M68KCLASSIC
 	select HAVE_PAGE_SIZE_4KB
 
 config MMU_COLDFIRE
+	def_bool MMU && COLDFIRE
 	select HAVE_PAGE_SIZE_8KB
-	bool
 
 config MMU_SUN3
-	bool
+	def_bool MMU && SUN3
 	select HAVE_PAGE_SIZE_8KB
-	depends on MMU && !MMU_MOTOROLA && !MMU_COLDFIRE
 
 config ARCH_SUPPORTS_KEXEC
-	def_bool M68KCLASSIC && MMU
+	def_bool (M68KCLASSIC || SUN3) && MMU
 
 config BOOTINFO_PROC
 	bool "Export bootinfo in procfs"
-	depends on KEXEC && M68KCLASSIC
+	depends on KEXEC && (M68KCLASSIC || SUN3)
 	help
 	  Say Y to export the bootinfo used to boot the kernel in a
 	  "bootinfo" file in procfs.  This is useful with kexec.
diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
index c777a129768a..a1b9e5f09e18 100644
--- a/arch/m68k/Kconfig.cpu
+++ b/arch/m68k/Kconfig.cpu
@@ -32,13 +32,23 @@ config COLDFIRE
 	select HAVE_LEGACY_CLK
 	select HAVE_PAGE_SIZE_8KB if !MMU
 
-endchoice
+config SUN3
+	bool "Sun3 support"
+	depends on MMU
+	select HAVE_ARCH_PFN_VALID
+	select LEGACY_TIMER_TICK
+	select NO_DMA
+	select M68020
+	help
+	  This option enables support for the Sun 3 series of workstations
+	  (3/50, 3/60, 3/1xx, 3/2xx systems). These use a classic 68020 CPU
+	  but the custom memory management unit makes them incompatible with
+	  all other classic m68k machines, including Sun 3x.
 
-if M68KCLASSIC
+endchoice
 
 config M68000
-	def_bool y
-	depends on !MMU
+	def_bool M68KCLASSIC && !MMU
 	select CPU_HAS_NO_BITFIELDS
 	select CPU_HAS_NO_CAS
 	select CPU_HAS_NO_MULDIV64
@@ -56,7 +66,8 @@ config M68000
 	  a paging MMU.
 
 config M68020
-	bool "68020 support"
+	bool "68020 support" if M68KCLASSIC
+	default !(M68030 || M68040 || M68060)
 	depends on MMU
 	select FPU
 	select CPU_HAS_ADDRESS_SPACES
@@ -66,9 +77,10 @@ config M68020
 	  68851 MMU (Memory Management Unit) to run Linux/m68k, except on the
 	  Sun 3, which provides its own version.
 
+if M68KCLASSIC && MMU
+
 config M68030
 	bool "68030 support"
-	depends on MMU && !MMU_SUN3
 	select FPU
 	select CPU_HAS_ADDRESS_SPACES
 	help
@@ -78,7 +90,6 @@ config M68030
 
 config M68040
 	bool "68040 support"
-	depends on MMU && !MMU_SUN3
 	select FPU
 	select CPU_HAS_ADDRESS_SPACES
 	help
@@ -89,13 +100,14 @@ config M68040
 
 config M68060
 	bool "68060 support"
-	depends on MMU && !MMU_SUN3
 	select FPU
 	select CPU_HAS_ADDRESS_SPACES
 	help
 	  If you anticipate running this kernel on a computer with a MC68060
 	  processor, say Y. Otherwise, say N.
 
+endif # M68KCLASSIC
+
 config M68328
 	bool
 	depends on !MMU
@@ -117,8 +129,6 @@ config M68VZ328
 	help
 	  Motorola 68VZ328 processor support.
 
-endif # M68KCLASSIC
-
 if COLDFIRE
 
 choice
diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
index d06b1c5d9b0c..de39f23b180e 100644
--- a/arch/m68k/Kconfig.machine
+++ b/arch/m68k/Kconfig.machine
@@ -6,7 +6,6 @@ if M68KCLASSIC
 config AMIGA
 	bool "Amiga support"
 	depends on MMU
-	select MMU_MOTOROLA if MMU
 	select LEGACY_TIMER_TICK
 	help
 	  This option enables support for the Amiga series of computers. If
@@ -16,7 +15,6 @@ config AMIGA
 config ATARI
 	bool "Atari support"
 	depends on MMU
-	select MMU_MOTOROLA if MMU
 	select HAVE_ARCH_NVRAM_OPS
 	select LEGACY_TIMER_TICK
 	help
@@ -31,7 +29,6 @@ config ATARI_KBD_CORE
 config MAC
 	bool "Macintosh support"
 	depends on MMU
-	select MMU_MOTOROLA if MMU
 	select HAVE_ARCH_NVRAM_OPS
 	select HAVE_PATA_PLATFORM
 	select LEGACY_TIMER_TICK
@@ -44,7 +41,6 @@ config MAC
 config APOLLO
 	bool "Apollo support"
 	depends on MMU
-	select MMU_MOTOROLA if MMU
 	select LEGACY_TIMER_TICK
 	help
 	  Say Y here if you want to run Linux on an MC680x0-based Apollo
@@ -53,7 +49,6 @@ config APOLLO
 config VME
 	bool "VME (Motorola and BVM) support"
 	depends on MMU
-	select MMU_MOTOROLA if MMU
 	help
 	  Say Y here if you want to build a kernel for a 680x0 based VME
 	  board.  Boards currently supported include Motorola boards MVME147,
@@ -97,7 +92,6 @@ config BVME6000
 config HP300
 	bool "HP9000/300 and HP9000/400 support"
 	depends on MMU
-	select MMU_MOTOROLA if MMU
 	select LEGACY_TIMER_TICK
 	help
 	  This option enables support for the HP9000/300 and HP9000/400 series
@@ -110,7 +104,6 @@ config SUN3X
 	bool "Sun3x support"
 	depends on MMU
 	select LEGACY_TIMER_TICK
-	select MMU_MOTOROLA if MMU
 	select M68030
 	help
 	  This option enables support for the Sun 3x series of workstations.
@@ -124,7 +117,6 @@ config SUN3X
 config Q40
 	bool "Q40/Q60 support"
 	depends on MMU
-	select MMU_MOTOROLA if MMU
 	select LEGACY_TIMER_TICK
 	help
 	  The Q40 is a Motorola 68040-based successor to the Sinclair QL
@@ -133,22 +125,6 @@ config Q40
 	  Q60. Select your CPU below.  For 68LC060 don't forget to enable FPU
 	  emulation.
 
-config SUN3
-	bool "Sun3 support"
-	depends on MMU
-	depends on !MMU_MOTOROLA
-	select MMU_SUN3 if MMU
-	select LEGACY_TIMER_TICK
-	select NO_DMA
-	select M68020
-	help
-	  This option enables support for the Sun 3 series of workstations
-	  (3/50, 3/60, 3/1xx, 3/2xx systems). Enabling this option requires
-	  that all other hardware types must be disabled, as Sun 3 kernels
-	  are incompatible with all other m68k targets (including Sun 3x!).
-
-	  If you don't want to compile a kernel exclusively for a Sun 3, say N.
-
 config VIRT
 	bool "Virtual M68k Machine support"
 	depends on MMU
@@ -157,7 +133,6 @@ config VIRT
 	select GOLDFISH_TIMER
 	select GOLDFISH_TTY
 	select M68040
-	select MMU_MOTOROLA if MMU
 	select RTC_CLASS
 	select RTC_DRV_GOLDFISH
 	select TTY
diff --git a/arch/m68k/kernel/Makefile b/arch/m68k/kernel/Makefile
index f335bf3268a1..5d1af676b508 100644
--- a/arch/m68k/kernel/Makefile
+++ b/arch/m68k/kernel/Makefile
@@ -5,16 +5,8 @@
 
 extra-y			+= vmlinux.lds
 
-obj-$(CONFIG_AMIGA)	:= head.o
-obj-$(CONFIG_ATARI)	:= head.o
-obj-$(CONFIG_MAC)	:= head.o
-obj-$(CONFIG_APOLLO)	:= head.o
-obj-$(CONFIG_VME)	:= head.o
-obj-$(CONFIG_HP300)	:= head.o
-obj-$(CONFIG_Q40)	:= head.o
-obj-$(CONFIG_SUN3X)	:= head.o
-obj-$(CONFIG_VIRT)	:= head.o
-obj-$(CONFIG_SUN3)	:= sun3-head.o
+obj-$(CONFIG_M68KCLASSIC)	:= head.o
+obj-$(CONFIG_SUN3)		:= sun3-head.o
 
 obj-y	+= entry.o irq.o module.o process.o ptrace.o
 obj-y	+= setup.o signal.o sys_m68k.o syscalltable.o time.o traps.o
diff --git a/arch/m68k/kernel/time.c b/arch/m68k/kernel/time.c
index a97600b2af50..108debb87cfb 100644
--- a/arch/m68k/kernel/time.c
+++ b/arch/m68k/kernel/time.c
@@ -62,7 +62,7 @@ void timer_heartbeat(void)
 }
 #endif /* CONFIG_HEARTBEAT */
 
-#ifdef CONFIG_M68KCLASSIC
+#if defined(CONFIG_M68KCLASSIC) || defined(CONFIG_SUN3)
 /* machine dependent timer functions */
 int (*mach_hwclk) (int, struct rtc_time*);
 EXPORT_SYMBOL(mach_hwclk);
@@ -149,7 +149,7 @@ static int __init rtc_init(void)
 
 module_init(rtc_init);
 #endif /* CONFIG_RTC_DRV_GENERIC */
-#endif /* CONFIG M68KCLASSIC */
+#endif /* CONFIG M68KCLASSIC || SUN3 */
 
 void __init time_init(void)
 {
-- 
2.39.2


