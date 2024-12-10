Return-Path: <linux-kernel+bounces-439784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A50569EB3ED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA6E283F06
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27251BDAA0;
	Tue, 10 Dec 2024 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmxbohrR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050211BD9FB
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842207; cv=none; b=mgw0QQprfe/u2Arf4c/R7imfePg0ZBqH2Ts4mkuqKWbAamtQt0zfAV7kb50nVIkaB2LWE/mAeCrAzjOGN5ATDLMgv7bE0uEVc40e/7XSGyhV1wDdh5IpC/dI3F0EotbV/ydKDIyHpA0tXsgywi/rE0hIFF6Hh8dJjhcOpFiTIg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842207; c=relaxed/simple;
	bh=rrTm035FMZ6jPcTCYgwd6AAGCEWqVHAjB1QvrC4DWjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dKsoNx8YCy84ATlpSmqY3VL2hoquIlKKO0GISSKpXUGu8aRMGBF+aM2182/wOTCPS4StZJryT2k+c1tbGczV1+htgTDiwnhZCCZhVOVCgIqLHreTSgUk5JiySyObLJzGq4lVSojHHhpfR2WQUuZiWZf/Nva9MO2NSPiolLhFmTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmxbohrR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B06C4CED6;
	Tue, 10 Dec 2024 14:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733842206;
	bh=rrTm035FMZ6jPcTCYgwd6AAGCEWqVHAjB1QvrC4DWjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dmxbohrRU36Taua6XH9NdIsZHDe9nVl+CcBrjgbyaUrrYLoqLC4yWqNU7GbAIQ+ep
	 MWZrtKNcJLJo2Di0csICa9L/WiV+EUjbEb/nkj1q2hiAlM0eNrL8zMpz2w1+J4pzcI
	 z2uQukAKIdAtEybeZJW5/iRt6sY3urTJ+Wmrj8IBKqos4FVpKztHY/H95zBAS3v2q9
	 ntfDHH98aGQaxunGx7WGqOFhAqjuMhjeSZZxKbbBzb/JCxDXQMR1TGOFF73Zqa/IDw
	 gvfFW9OMeqeRpsYA1q3W1cBn1RrydI2B+LhcpS9OQa99J2RpnpWwvpKGg1D7acjhbj
	 agI5tLItGnFBw==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Shevchenko <andy@kernel.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2 04/11] x86: drop configuration options for early 64-bit CPUs
Date: Tue, 10 Dec 2024 15:49:38 +0100
Message-Id: <20241210144945.2325330-5-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241210144945.2325330-1-arnd@kernel.org>
References: <20241210144945.2325330-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The x86 CPU selection menu is confusing for a number of reasons:

When configuring 32-bit kernels, it shows a small number of early 64-bit
microarchitectures (K8, Core 2) but not the regular generic 64-bit target
that is the normal default.  There is no longer a reason to run 32-bit
kernels on production 64-bit systems, so only actual 32-bit CPUs need
to be shown here.

When configuring 64-bit kernels, the options also pointless as there is
no way to pick any CPU from the past 15 years, leaving GENERIC_CPU as
the only sensible choice.

Address both of the above by removing the obsolete options and making
all 64-bit kernels run on both Intel and AMD CPUs from any generation.
Testing generic 32-bit kernels on 64-bit hardware remains possible,
just not building a 32-bit kernel that requires a 64-bit CPU.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/Kconfig.cpu            | 95 +++++----------------------------
 arch/x86/Makefile               | 16 +-----
 arch/x86/Makefile_32.cpu        |  5 +-
 arch/x86/include/asm/vermagic.h |  4 --
 drivers/misc/mei/Kconfig        |  2 +-
 5 files changed, 18 insertions(+), 104 deletions(-)

diff --git a/arch/x86/Kconfig.cpu b/arch/x86/Kconfig.cpu
index 42e6a40876ea..8fcb8ccee44b 100644
--- a/arch/x86/Kconfig.cpu
+++ b/arch/x86/Kconfig.cpu
@@ -1,9 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 # Put here option for CPU selection and depending optimization
 choice
-	prompt "Processor family"
-	default M686 if X86_32
-	default GENERIC_CPU if X86_64
+	prompt "x86-32 Processor family"
+	depends on X86_32
+	default M686
 	help
 	  This is the processor type of your CPU. This information is
 	  used for optimizing purposes. In order to compile a kernel
@@ -31,7 +31,6 @@ choice
 	  - "Pentium-4" for the Intel Pentium 4 or P4-based Celeron.
 	  - "K6" for the AMD K6, K6-II and K6-III (aka K6-3D).
 	  - "Athlon" for the AMD K7 family (Athlon/Duron/Thunderbird).
-	  - "Opteron/Athlon64/Hammer/K8" for all K8 and newer AMD CPUs.
 	  - "Crusoe" for the Transmeta Crusoe series.
 	  - "Efficeon" for the Transmeta Efficeon series.
 	  - "Winchip-C6" for original IDT Winchip.
@@ -42,13 +41,10 @@ choice
 	  - "CyrixIII/VIA C3" for VIA Cyrix III or VIA C3.
 	  - "VIA C3-2" for VIA C3-2 "Nehemiah" (model 9 and above).
 	  - "VIA C7" for VIA C7.
-	  - "Intel P4" for the Pentium 4/Netburst microarchitecture.
-	  - "Core 2/newer Xeon" for all core2 and newer Intel CPUs.
 	  - "Intel Atom" for the Atom-microarchitecture CPUs.
-	  - "Generic-x86-64" for a kernel which runs on any x86-64 CPU.
 
 	  See each option's help text for additional details. If you don't know
-	  what to do, choose "486".
+	  what to do, choose "Pentium-Pro".
 
 config M486SX
 	bool "486SX"
@@ -114,11 +110,11 @@ config MPENTIUMIII
 	  extensions.
 
 config MPENTIUMM
-	bool "Pentium M"
+	bool "Pentium M/Pentium Dual Core/Core Solo/Core Duo"
 	depends on X86_32
 	help
 	  Select this for Intel Pentium M (not Pentium-4 M)
-	  notebook chips.
+	  "Merom" Core Solo/Duo notebook chips
 
 config MPENTIUM4
 	bool "Pentium-4/Celeron(P4-based)/Pentium-4 M/older Xeon"
@@ -139,22 +135,10 @@ config MPENTIUM4
 		-Mobile Pentium 4
 		-Mobile Pentium 4 M
 		-Extreme Edition (Gallatin)
-		-Prescott
-		-Prescott 2M
-		-Cedar Mill
-		-Presler
-		-Smithfiled
 	    Xeons (Intel Xeon, Xeon MP, Xeon LV, Xeon MV) corename:
 		-Foster
 		-Prestonia
 		-Gallatin
-		-Nocona
-		-Irwindale
-		-Cranford
-		-Potomac
-		-Paxville
-		-Dempsey
-
 
 config MK6
 	bool "K6/K6-II/K6-III"
@@ -172,13 +156,6 @@ config MK7
 	  some extended instructions, and passes appropriate optimization
 	  flags to GCC.
 
-config MK8
-	bool "Opteron/Athlon64/Hammer/K8"
-	help
-	  Select this for an AMD Opteron or Athlon64 Hammer-family processor.
-	  Enables use of some extended instructions, and passes appropriate
-	  optimization flags to GCC.
-
 config MCRUSOE
 	bool "Crusoe"
 	depends on X86_32
@@ -258,42 +235,14 @@ config MVIAC7
 	  Select this for a VIA C7.  Selecting this uses the correct cache
 	  shift and tells gcc to treat the CPU as a 686.
 
-config MPSC
-	bool "Intel P4 / older Netburst based Xeon"
-	depends on X86_64
-	help
-	  Optimize for Intel Pentium 4, Pentium D and older Nocona/Dempsey
-	  Xeon CPUs with Intel 64bit which is compatible with x86-64.
-	  Note that the latest Xeons (Xeon 51xx and 53xx) are not based on the
-	  Netburst core and shouldn't use this option. You can distinguish them
-	  using the cpu family field
-	  in /proc/cpuinfo. Family 15 is an older Xeon, Family 6 a newer one.
-
-config MCORE2
-	bool "Core 2/newer Xeon"
-	help
-
-	  Select this for Intel Core 2 and newer Core 2 Xeons (Xeon 51xx and
-	  53xx) CPUs. You can distinguish newer from older Xeons by the CPU
-	  family in /proc/cpuinfo. Newer ones have 6 and older ones 15
-	  (not a typo)
-
 config MATOM
 	bool "Intel Atom"
 	help
-
 	  Select this for the Intel Atom platform. Intel Atom CPUs have an
 	  in-order pipelining architecture and thus can benefit from
 	  accordingly optimized code. Use a recent GCC with specific Atom
 	  support in order to fully benefit from selecting this option.
 
-config GENERIC_CPU
-	bool "Generic-x86-64"
-	depends on X86_64
-	help
-	  Generic x86-64 CPU.
-	  Run equally well on all x86-64 CPUs.
-
 endchoice
 
 config X86_GENERIC
@@ -317,8 +266,8 @@ config X86_INTERNODE_CACHE_SHIFT
 
 config X86_L1_CACHE_SHIFT
 	int
-	default "7" if MPENTIUM4 || MPSC
-	default "6" if MK7 || MK8 || MPENTIUMM || MCORE2 || MATOM || MVIAC7 || X86_GENERIC || GENERIC_CPU
+	default "7" if MPENTIUM4
+	default "6" if MK7 || MPENTIUMM || MATOM || MVIAC7 || X86_GENERIC || X86_64
 	default "4" if MELAN || M486SX || M486 || MGEODEGX1
 	default "5" if MWINCHIP3D || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2 || MGEODE_LX
 
@@ -336,35 +285,19 @@ config X86_ALIGNMENT_16
 
 config X86_INTEL_USERCOPY
 	def_bool y
-	depends on MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M586MMX || X86_GENERIC || MK8 || MK7 || MEFFICEON || MCORE2
+	depends on MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M586MMX || X86_GENERIC || MK7 || MEFFICEON
 
 config X86_USE_PPRO_CHECKSUM
 	def_bool y
-	depends on MWINCHIP3D || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2 || MVIAC7 || MEFFICEON || MGEODE_LX || MCORE2 || MATOM
-
-#
-# P6_NOPs are a relatively minor optimization that require a family >=
-# 6 processor, except that it is broken on certain VIA chips.
-# Furthermore, AMD chips prefer a totally different sequence of NOPs
-# (which work on all CPUs).  In addition, it looks like Virtual PC
-# does not understand them.
-#
-# As a result, disallow these if we're not compiling for X86_64 (these
-# NOPs do work on all x86-64 capable chips); the list of processors in
-# the right-hand clause are the cores that benefit from this optimization.
-#
-config X86_P6_NOP
-	def_bool y
-	depends on X86_64
-	depends on (MCORE2 || MPENTIUM4 || MPSC)
+	depends on MWINCHIP3D || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MGEODE_LX || MATOM
 
 config X86_TSC
 	def_bool y
-	depends on (MWINCHIP3D || MCRUSOE || MEFFICEON || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2 || MVIAC7 || MGEODEGX1 || MGEODE_LX || MCORE2 || MATOM) || X86_64
+	depends on (MWINCHIP3D || MCRUSOE || MEFFICEON || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MVIAC3_2 || MVIAC7 || MGEODEGX1 || MGEODE_LX || MATOM) || X86_64
 
 config X86_HAVE_PAE
 	def_bool y
-	depends on MCRUSOE || MEFFICEON || MCYRIXIII || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC7 || MCORE2 || MATOM || X86_64
+	depends on MCRUSOE || MEFFICEON || MCYRIXIII || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC7 || MATOM || X86_64
 
 config X86_CMPXCHG64
 	def_bool y
@@ -374,12 +307,12 @@ config X86_CMPXCHG64
 # generates cmov.
 config X86_CMOV
 	def_bool y
-	depends on (MK8 || MK7 || MCORE2 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MCRUSOE || MEFFICEON || X86_64 || MATOM || MGEODE_LX)
+	depends on (MK7 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MCRUSOE || MEFFICEON || MATOM || MGEODE_LX || X86_64)
 
 config X86_MINIMUM_CPU_FAMILY
 	int
 	default "64" if X86_64
-	default "6" if X86_32 && (MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MATOM || MCORE2 || MK7 || MK8)
+	default "6" if X86_32 && (MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MATOM || MK7)
 	default "5" if X86_32 && X86_CMPXCHG64
 	default "4"
 
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 5af3172fd51c..8120085b00a4 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -178,20 +178,8 @@ else
 	# Use -mskip-rax-setup if supported.
 	KBUILD_CFLAGS += $(call cc-option,-mskip-rax-setup)
 
-        # FIXME - should be integrated in Makefile.cpu (Makefile_32.cpu)
-        cflags-$(CONFIG_MK8)		+= -march=k8
-        cflags-$(CONFIG_MPSC)		+= -march=nocona
-        cflags-$(CONFIG_MCORE2)		+= -march=core2
-        cflags-$(CONFIG_MATOM)		+= -march=atom
-        cflags-$(CONFIG_GENERIC_CPU)	+= -march=x86-64 -mtune=generic
-        KBUILD_CFLAGS += $(cflags-y)
-
-        rustflags-$(CONFIG_MK8)		+= -Ctarget-cpu=k8
-        rustflags-$(CONFIG_MPSC)	+= -Ctarget-cpu=nocona
-        rustflags-$(CONFIG_MCORE2)	+= -Ctarget-cpu=core2
-        rustflags-$(CONFIG_MATOM)	+= -Ctarget-cpu=atom
-        rustflags-$(CONFIG_GENERIC_CPU)	+= -Ctarget-cpu=x86-64 -Ztune-cpu=generic
-        KBUILD_RUSTFLAGS += $(rustflags-y)
+        KBUILD_CFLAGS += -march=x86-64 -mtune=generic
+        KBUILD_RUSTFLAGS += -Ctarget-cpu=x86-64 -Ztune-cpu=generic
 
         KBUILD_CFLAGS += -mno-red-zone
         KBUILD_CFLAGS += -mcmodel=kernel
diff --git a/arch/x86/Makefile_32.cpu b/arch/x86/Makefile_32.cpu
index 94834c4b5e5e..af7de9a42752 100644
--- a/arch/x86/Makefile_32.cpu
+++ b/arch/x86/Makefile_32.cpu
@@ -24,7 +24,6 @@ cflags-$(CONFIG_MK6)		+= -march=k6
 # Please note, that patches that add -march=athlon-xp and friends are pointless.
 # They make zero difference whatsosever to performance at this time.
 cflags-$(CONFIG_MK7)		+= -march=athlon
-cflags-$(CONFIG_MK8)		+= $(call cc-option,-march=k8,-march=athlon)
 cflags-$(CONFIG_MCRUSOE)	+= -march=i686 $(align)
 cflags-$(CONFIG_MEFFICEON)	+= -march=i686 $(call tune,pentium3) $(align)
 cflags-$(CONFIG_MWINCHIPC6)	+= $(call cc-option,-march=winchip-c6,-march=i586)
@@ -32,9 +31,7 @@ cflags-$(CONFIG_MWINCHIP3D)	+= $(call cc-option,-march=winchip2,-march=i586)
 cflags-$(CONFIG_MCYRIXIII)	+= $(call cc-option,-march=c3,-march=i486) $(align)
 cflags-$(CONFIG_MVIAC3_2)	+= $(call cc-option,-march=c3-2,-march=i686)
 cflags-$(CONFIG_MVIAC7)		+= -march=i686
-cflags-$(CONFIG_MCORE2)		+= -march=i686 $(call tune,core2)
-cflags-$(CONFIG_MATOM)		+= $(call cc-option,-march=atom,$(call cc-option,-march=core2,-march=i686)) \
-	$(call cc-option,-mtune=atom,$(call cc-option,-mtune=generic))
+cflags-$(CONFIG_MATOM)		+= -march=atom
 
 # AMD Elan support
 cflags-$(CONFIG_MELAN)		+= -march=i486
diff --git a/arch/x86/include/asm/vermagic.h b/arch/x86/include/asm/vermagic.h
index 75884d2cdec3..5d471253c755 100644
--- a/arch/x86/include/asm/vermagic.h
+++ b/arch/x86/include/asm/vermagic.h
@@ -15,8 +15,6 @@
 #define MODULE_PROC_FAMILY "586TSC "
 #elif defined CONFIG_M586MMX
 #define MODULE_PROC_FAMILY "586MMX "
-#elif defined CONFIG_MCORE2
-#define MODULE_PROC_FAMILY "CORE2 "
 #elif defined CONFIG_MATOM
 #define MODULE_PROC_FAMILY "ATOM "
 #elif defined CONFIG_M686
@@ -33,8 +31,6 @@
 #define MODULE_PROC_FAMILY "K6 "
 #elif defined CONFIG_MK7
 #define MODULE_PROC_FAMILY "K7 "
-#elif defined CONFIG_MK8
-#define MODULE_PROC_FAMILY "K8 "
 #elif defined CONFIG_MELAN
 #define MODULE_PROC_FAMILY "ELAN "
 #elif defined CONFIG_MCRUSOE
diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig
index 67d9391f1855..7575fee96cc6 100644
--- a/drivers/misc/mei/Kconfig
+++ b/drivers/misc/mei/Kconfig
@@ -3,7 +3,7 @@
 config INTEL_MEI
 	tristate "Intel Management Engine Interface"
 	depends on X86 && PCI
-	default GENERIC_CPU || MCORE2 || MATOM || X86_GENERIC
+	default X86_64 || MATOM
 	help
 	  The Intel Management Engine (Intel ME) provides Manageability,
 	  Security and Media services for system containing Intel chipsets.
-- 
2.39.5


