Return-Path: <linux-kernel+bounces-169845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 636E98BCE7A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 869A91C20F23
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 12:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B775763F8;
	Mon,  6 May 2024 12:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ERfjhM58"
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B557580C
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 12:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714999949; cv=none; b=h6hFoKrUq6QE2xac5UamMPkSIxjWHR0YvY0pcJN88jrmPrNEC2cvIrfVOLWHlKcCPepm31uoEOqwjTi+yj248MY6VkUB11v+4+j44ucYEbruDsG43fX3gLqtzEOmXbA39H0UH9oSU0RSCgaCav5gkWuiMILlNkbfuNISR0euETI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714999949; c=relaxed/simple;
	bh=24DknUJFds+tNU+9ymsmJjXyLhkd8EWccwhaG7aNN8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDbQjZtioliGkon2WjyighuB5Lq1FVBQY9d9xIxvzFIIAR1NnoDmpETuIP3uul4lLnPX4GXmcn3KuEXzKTVcuczHyjYSIXll9Hc7v32wnCFller+Av1EAq6uQsD17haW4aNnJ7KpZoB3CyCTEEy5LbmbNXTTKGYauRX53EJ15ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=ERfjhM58; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1714999944;
	bh=QfcpCyyLZIA1FVRyTpwJi+Mrz6i442r8IqI/ix+CKlU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ERfjhM582nkEsWT8Ztff2sXAYcaaPXrykYr5NC55WFrnH3YDydvUoD41fgibutDqL
	 JyQPq85m6gD6RypwD6mVM+th7tJbkYH55ht3kBX5BB7CVaY/FBXlEa3wjuxQM4527n
	 Bl8YM5HhmRFqlTNrMo3/NrJAAt5//+Do2TPg51UkklE9D8udBYcHtL/hvttjttwEav
	 LCEe1G0zGt0TOWaImhsYURoK5qmpRHqTHvICtndcQScCsv7HWsqMJA20gdSzz/jb76
	 EahYZE2k1EyMQqfGSp2srVljC9dPB8/TkeIW/l7yhpqCP5htV/6D4HO8s6vqINdlu3
	 qYOL7ZsNMT59Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VY1X817kTz4x2d;
	Mon,  6 May 2024 22:52:24 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@lists.ozlabs.org>
Cc: <linux-kernel@vger.kernel.org>,
	<christophe.leroy@csgroup.eu>
Subject: [PATCH 3/7] powerpc: Remove 40x from Kconfig and defconfig
Date: Mon,  6 May 2024 22:51:48 +1000
Message-ID: <20240506125152.78174-4-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240506125152.78174-1-mpe@ellerman.id.au>
References: <20240506125152.78174-1-mpe@ellerman.id.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove 40x from Kconfig, making the code unreachable.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig                   | 12 ++++++------
 arch/powerpc/Kconfig.debug             | 13 -------------
 arch/powerpc/Makefile                  |  5 -----
 arch/powerpc/configs/40x.config        |  2 --
 arch/powerpc/platforms/Kconfig.cputype | 21 ++++-----------------
 5 files changed, 10 insertions(+), 43 deletions(-)
 delete mode 100644 arch/powerpc/configs/40x.config

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1c4be3373686..9a7d2b218516 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -148,7 +148,7 @@ config PPC
 	select ARCH_HAS_PTE_SPECIAL
 	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC_BOOK3S_64
 	select ARCH_HAS_SET_MEMORY
-	select ARCH_HAS_STRICT_KERNEL_RWX	if (PPC_BOOK3S || PPC_8xx || 40x) && !HIBERNATION
+	select ARCH_HAS_STRICT_KERNEL_RWX	if (PPC_BOOK3S || PPC_8xx) && !HIBERNATION
 	select ARCH_HAS_STRICT_KERNEL_RWX	if PPC_85xx && !HIBERNATION && !RANDOMIZE_BASE
 	select ARCH_HAS_STRICT_MODULE_RWX	if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_SYSCALL_WRAPPER		if !SPU_BASE && !COMPAT
@@ -165,7 +165,7 @@ config PPC
 	select ARCH_SPLIT_ARG64			if PPC32
 	select ARCH_STACKWALK
 	select ARCH_SUPPORTS_ATOMIC_RMW
-	select ARCH_SUPPORTS_DEBUG_PAGEALLOC	if PPC_BOOK3S || PPC_8xx || 40x
+	select ARCH_SUPPORTS_DEBUG_PAGEALLOC	if PPC_BOOK3S || PPC_8xx
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF		if PPC64
 	select ARCH_USE_MEMTEST
@@ -387,7 +387,7 @@ config ARCH_SUSPEND_POSSIBLE
 	def_bool y
 	depends on ADB_PMU || PPC_EFIKA || PPC_LITE5200 || PPC_83xx || \
 		   (PPC_85xx && !PPC_E500MC) || PPC_86xx || PPC_PSERIES \
-		   || 44x || 40x
+		   || 44x
 
 config ARCH_SUSPEND_NONZERO_CPU
 	def_bool y
@@ -441,7 +441,7 @@ config ARCH_SUPPORTS_UPROBES
 
 config PPC_ADV_DEBUG_REGS
 	bool
-	depends on 40x || BOOKE
+	depends on BOOKE
 	default y
 
 config PPC_ADV_DEBUG_IACS
@@ -1071,7 +1071,7 @@ config GENERIC_ISA_DMA
 config PPC_INDIRECT_PCI
 	bool
 	depends on PCI
-	default y if 40x || 44x
+	default y if 44x
 
 config SBUS
 	bool
@@ -1096,7 +1096,7 @@ config FSL_PMC
 config PPC4xx_CPM
 	bool
 	default y
-	depends on SUSPEND && (44x || 40x)
+	depends on SUSPEND && 44x
 	help
 	  PPC4xx Clock Power Management (CPM) support (suspend/resume).
 	  It also enables support for two different idle states (idle-wait
diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index 8c80b154e814..3799ceceb04a 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -244,14 +244,6 @@ config PPC_EARLY_DEBUG_44x
 	  inbuilt serial port.  If you enable this, ensure you set
 	  PPC_EARLY_DEBUG_44x_PHYSLOW below to suit your target board.
 
-config PPC_EARLY_DEBUG_40x
-	bool "Early serial debugging for IBM/AMCC 40x CPUs"
-	depends on 40x
-	help
-	  Select this to enable early debugging for IBM 40x chips via the
-	  inbuilt serial port. This works on chips with a 16550 compatible
-	  UART.
-
 config PPC_EARLY_DEBUG_CPM
 	bool "Early serial debugging for Freescale CPM-based serial ports"
 	depends on SERIAL_CPM=y
@@ -356,11 +348,6 @@ config PPC_EARLY_DEBUG_44x_PHYSHIGH
 	depends on PPC_EARLY_DEBUG_44x
 	default "0x1"
 
-config PPC_EARLY_DEBUG_40x_PHYSADDR
-	hex "Early debug UART physical address"
-	depends on PPC_EARLY_DEBUG_40x
-	default "0xef600300"
-
 config PPC_EARLY_DEBUG_CPM_ADDR
 	hex "CPM UART early debug transmit descriptor address"
 	depends on PPC_EARLY_DEBUG_CPM
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 65261cbe5bfd..a59563e1550b 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -302,11 +302,6 @@ ppc32_allmodconfig:
 	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/book3s_32.config \
 		-f $(srctree)/Makefile allmodconfig
 
-generated_configs += ppc40x_allmodconfig
-ppc40x_allmodconfig:
-	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/40x.config \
-		-f $(srctree)/Makefile allmodconfig
-
 generated_configs += ppc44x_allmodconfig
 ppc44x_allmodconfig:
 	$(Q)$(MAKE) KCONFIG_ALLCONFIG=$(srctree)/arch/powerpc/configs/44x.config \
diff --git a/arch/powerpc/configs/40x.config b/arch/powerpc/configs/40x.config
deleted file mode 100644
index 82a9d58ddb81..000000000000
--- a/arch/powerpc/configs/40x.config
+++ /dev/null
@@ -1,2 +0,0 @@
-CONFIG_PPC64=n
-CONFIG_40x=y
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index b2d8c0da2ad9..2b686ee2dd2b 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -43,14 +43,6 @@ config PPC_8xx
 	select HAVE_ARCH_VMAP_STACK
 	select HUGETLBFS
 
-config 40x
-	bool "AMCC 40x"
-	select PPC_DCR_NATIVE
-	select PPC_UDBG_16550
-	select 4xx_SOC
-	select HAVE_PCI
-	select PPC_KUEP if PPC_KUAP
-
 config 44x
 	bool "AMCC 44x, 46x or 47x"
 	select PPC_DCR_NATIVE
@@ -194,11 +186,6 @@ config E6500_CPU
 	depends on !CC_IS_CLANG
 	select PPC_HAS_LBARX_LHARX
 
-config 405_CPU
-	bool "40x family"
-	depends on 40x
-	depends on !CC_IS_CLANG
-
 config 440_CPU
 	bool "440 (44x family)"
 	depends on 44x
@@ -340,7 +327,7 @@ config FSL_EMB_PERF_EVENT_E500
 
 config 4xx
 	bool
-	depends on 40x || 44x
+	depends on 44x
 	default y
 
 config BOOKE
@@ -350,7 +337,7 @@ config BOOKE
 
 config BOOKE_OR_40x
 	bool
-	depends on BOOKE || 40x
+	depends on BOOKE
 	default y
 
 config PTE_64BIT
@@ -495,8 +482,8 @@ config PPC_KERNEL_PCREL
 	  This option builds the kernel with the pc relative ABI model.
 
 config PPC_KUEP
-	bool "Kernel Userspace Execution Prevention" if !40x
-	default y if !40x
+	bool "Kernel Userspace Execution Prevention"
+	default y
 	help
 	  Enable support for Kernel Userspace Execution Prevention (KUEP)
 
-- 
2.45.0


