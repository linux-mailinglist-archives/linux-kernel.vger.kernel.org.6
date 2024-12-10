Return-Path: <linux-kernel+bounces-439791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7571B9EB3F9
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65D3188B4FA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED821A01D4;
	Tue, 10 Dec 2024 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFJ2wEdd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A401C1F25
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842227; cv=none; b=l3ncuOiBRcBdlQjNXWcrY50hso1IzRIcTrNj7+KqM+qdjpDZ0FetK9+LpKZRnnPYWMtuIUjxMACi1whE6EZzmH+4iyfN1VTjJO+Ut/mP2HbsShSjdJnso8kiiDfRMRfpZQN3KFvDH9BkxqLuQerD8KoGfJp99nEUwBd9QS/24Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842227; c=relaxed/simple;
	bh=00nw3SlffvP/c1d9ovm9ZcoFK1ptqaK8lm0cPmWJ9jU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=shkRffbPa7WMJEoDemsaf2PhkYOCIJl03cuv2PiafpoYY/fDPHuoSalmkCy/3D9sa5vAgd/IjUNhVv5nkYuxD7+1czkc4VKvqOHZP0lg5PXs3VbpHB8LhEIMB9hz1cEpSjFJQr2LnVn50lF1U/ymlBa4ry4CM4sNbR/f1d0oRmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFJ2wEdd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B042C4CEDF;
	Tue, 10 Dec 2024 14:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733842226;
	bh=00nw3SlffvP/c1d9ovm9ZcoFK1ptqaK8lm0cPmWJ9jU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GFJ2wEddeluEfYA4qnI9ZlK3eIF6l4mBzT4SboBFnFfiDEerO3kC63NJHVVJtVqWq
	 A7ERBw24/92rHCk2KRoTmj7+YREK+RPt245yDIP/FDOtFHC24JRUcJM2PDMZ+oLlhz
	 Jl+zW0if9IU2tLlr389pUuXjyIY/cVvkUg+MykygxqenfeH+6MdMV+4sza104XO6OZ
	 QRc7SMeALmqN4Zp5Fpszoi1V4mMmlKjCIzYVCVxAyJJ7bAz3kzdOPXQORbVQJmlrrz
	 kl7ktticwrC/j62rXSPvq+0Tiqj2LZOkV0gOW1EqC4AyRtxkNvKN1xHeA8x+vg7xYJ
	 i3f1J/0M1wENw==
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
Subject: [PATCH v2 11/11] x86: Move platforms to Kconfig.platforms
Date: Tue, 10 Dec 2024 15:49:45 +0100
Message-Id: <20241210144945.2325330-12-arnd@kernel.org>
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

The x86 platform options in Kconfig are rather confusing, as they are a
mix of options that just control visibility of drivers and those that are
fundamental to the operation, with some of the code in arch/x86/platforms
and other code in drivers/platform/x86, and the options listed in various
places in arch/x86/Kconfig.

Make this a little more consistent by moving all options that control a
platform from arch/x86/Kconfig to arch/x86/Kconfig.platforms and put them
into a submenu.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/Kconfig           | 363 +------------------------------------
 arch/x86/Kconfig.platforms | 361 ++++++++++++++++++++++++++++++++++++
 2 files changed, 363 insertions(+), 361 deletions(-)
 create mode 100644 arch/x86/Kconfig.platforms

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fb071548bc1e..98530ce14eab 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -526,205 +526,7 @@ config X86_FRED
 	  ring transitions and exception/interrupt handling if the
 	  system supports it.
 
-config X86_EXTENDED_PLATFORM
-	bool "Support for extended (non-PC) x86 platforms"
-	default y
-	help
-	  If you disable this option then the kernel will only support
-	  standard PC platforms. (which covers the vast majority of
-	  systems out there.)
-
-	  If you enable this option then you'll be able to select support
-	  for the following non-PC x86 platforms, depending on the value of
-	  CONFIG_64BIT.
-
-	  32-bit platforms (CONFIG_64BIT=n):
-		Goldfish (Android emulator)
-		AMD Elan
-		RDC R-321x SoC
-		SGI 320/540 (Visual Workstation)
-
-	  64-bit platforms (CONFIG_64BIT=y):
-		Numascale NumaChip
-		ScaleMP vSMP
-		SGI Ultraviolet
-		Merrifield/Moorefield MID devices
-
-	  If you have one of these systems, or if you want to build a
-	  generic distribution kernel, say Y here - otherwise say N.
-
-# This is an alphabetically sorted list of 64 bit extended platforms
-# Please maintain the alphabetic order if and when there are additions
-config X86_NUMACHIP
-	bool "Numascale NumaChip"
-	depends on X86_64
-	depends on X86_EXTENDED_PLATFORM
-	depends on NUMA
-	depends on SMP
-	depends on X86_X2APIC
-	depends on PCI_MMCONFIG
-	help
-	  Adds support for Numascale NumaChip large-SMP systems. Needed to
-	  enable more than ~168 cores.
-	  If you don't have one of these, you should say N here.
-
-config X86_VSMP
-	bool "ScaleMP vSMP"
-	select HYPERVISOR_GUEST
-	select PARAVIRT
-	depends on X86_64 && PCI
-	depends on X86_EXTENDED_PLATFORM
-	depends on SMP
-	help
-	  Support for ScaleMP vSMP systems.  Say 'Y' here if this kernel is
-	  supposed to run on these EM64T-based machines.  Only choose this option
-	  if you have one of these machines.
-
-config X86_UV
-	bool "SGI Ultraviolet"
-	depends on X86_64
-	depends on X86_EXTENDED_PLATFORM
-	depends on NUMA
-	depends on EFI
-	depends on KEXEC_CORE
-	depends on X86_X2APIC
-	depends on PCI
-	help
-	  This option is needed in order to support SGI Ultraviolet systems.
-	  If you don't have one of these, you should say N here.
-
-config X86_INTEL_MID
-	bool "Intel Z34xx/Z35xx MID platform support"
-	depends on X86_EXTENDED_PLATFORM
-	depends on X86_PLATFORM_DEVICES
-	depends on PCI
-	depends on X86_64 || (EXPERT && PCI_GOANY)
-	depends on X86_IO_APIC
-	select I2C
-	select DW_APB_TIMER
-	select INTEL_SCU_PCI
-	help
-	  Select to build a kernel capable of supporting 64-bit Intel MID
-	  (Mobile Internet Device) platform systems which do not have
-	  the PCI legacy interfaces.
-
-	  The only supported devices are the 22nm Merrified (Z34xx)
-	  and Moorefield (Z35xx) SoC used in the Intel Edison board and
-	  a small number of Android devices such as the Asus Zenfone 2,
-	  Asus FonePad 8 and Dell Venue 7.
-
-	  If you are building for a PC class system or non-MID tablet
-	  SoCs like Bay Trail (Z36xx/Z37xx), say N here.
-
-	  Intel MID platforms are based on an Intel processor and chipset which
-	  consume less power than most of the x86 derivatives.
-
-config X86_GOLDFISH
-	bool "Goldfish (Virtual Platform)"
-	depends on X86_EXTENDED_PLATFORM
-	help
-	  Enable support for the Goldfish virtual platform used primarily
-	  for Android development. Unless you are building for the Android
-	  Goldfish emulator say N here.
-
-# Following is an alphabetically sorted list of 32 bit extended platforms
-# Please maintain the alphabetic order if and when there are additions
-
-config X86_INTEL_CE
-	bool "CE4100 TV platform"
-	depends on PCI
-	depends on PCI_GODIRECT
-	depends on X86_IO_APIC
-	depends on X86_32
-	depends on X86_EXTENDED_PLATFORM
-	select X86_REBOOTFIXUPS
-	select OF
-	select OF_EARLY_FLATTREE
-	help
-	  Select for the Intel CE media processor (CE4100) SOC.
-	  This option compiles in support for the CE4100 SOC for settop
-	  boxes and media devices.
-
-config X86_INTEL_QUARK
-	bool "Intel Quark platform support"
-	depends on X86_32
-	depends on X86_EXTENDED_PLATFORM
-	depends on X86_PLATFORM_DEVICES
-	depends on X86_TSC
-	depends on PCI
-	depends on PCI_GOANY
-	depends on X86_IO_APIC
-	select IOSF_MBI
-	select INTEL_IMR
-	select COMMON_CLK
-	help
-	  Select to include support for Quark X1000 SoC.
-	  Say Y here if you have a Quark based system such as the Arduino
-	  compatible Intel Galileo.
-
-config X86_INTEL_LPSS
-	bool "Intel Low Power Subsystem Support"
-	depends on X86 && ACPI && PCI
-	select COMMON_CLK
-	select PINCTRL
-	select IOSF_MBI
-	help
-	  Select to build support for Intel Low Power Subsystem such as
-	  found on Intel Lynxpoint PCH. Selecting this option enables
-	  things like clock tree (common clock framework) and pincontrol
-	  which are needed by the LPSS peripheral drivers.
-
-config X86_AMD_PLATFORM_DEVICE
-	bool "AMD ACPI2Platform devices support"
-	depends on ACPI
-	select COMMON_CLK
-	select PINCTRL
-	help
-	  Select to interpret AMD specific ACPI device to platform device
-	  such as I2C, UART, GPIO found on AMD Carrizo and later chipsets.
-	  I2C and UART depend on COMMON_CLK to set clock. GPIO driver is
-	  implemented under PINCTRL subsystem.
-
-config IOSF_MBI
-	tristate "Intel SoC IOSF Sideband support for SoC platforms"
-	depends on PCI
-	help
-	  This option enables sideband register access support for Intel SoC
-	  platforms. On these platforms the IOSF sideband is used in lieu of
-	  MSR's for some register accesses, mostly but not limited to thermal
-	  and power. Drivers may query the availability of this device to
-	  determine if they need the sideband in order to work on these
-	  platforms. The sideband is available on the following SoC products.
-	  This list is not meant to be exclusive.
-	   - BayTrail
-	   - Braswell
-	   - Quark
-
-	  You should say Y if you are running a kernel on one of these SoC's.
-
-config IOSF_MBI_DEBUG
-	bool "Enable IOSF sideband access through debugfs"
-	depends on IOSF_MBI && DEBUG_FS
-	help
-	  Select this option to expose the IOSF sideband access registers (MCR,
-	  MDR, MCRX) through debugfs to write and read register information from
-	  different units on the SoC. This is most useful for obtaining device
-	  state information for debug and analysis. As this is a general access
-	  mechanism, users of this option would have specific knowledge of the
-	  device they want to access.
-
-	  If you don't require the option or are in doubt, say N.
-
-config X86_RDC321X
-	bool "RDC R-321x SoC"
-	depends on X86_32
-	depends on X86_EXTENDED_PLATFORM
-	select M486
-	select X86_REBOOTFIXUPS
-	help
-	  This option is needed for RDC R-321x system-on-chip, also known
-	  as R-8610-(G).
-	  If you don't have one of these chips, you should say N here.
+source "arch/x86/Kconfig.platforms"
 
 config X86_SUPPORTS_MEMORY_FAILURE
 	def_bool y
@@ -735,19 +537,6 @@ config X86_SUPPORTS_MEMORY_FAILURE
 	depends on X86_64 || !SPARSEMEM
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 
-config X86_32_IRIS
-	tristate "Eurobraille/Iris poweroff module"
-	depends on X86_32
-	help
-	  The Iris machines from EuroBraille do not have APM or ACPI support
-	  to shut themselves down properly.  A special I/O sequence is
-	  needed to do so, which is what this module does at
-	  kernel shutdown.
-
-	  This is only for Iris machines from EuroBraille.
-
-	  If unused, say N.
-
 config SCHED_OMIT_FRAME_POINTER
 	def_bool y
 	prompt "Single-depth WCHAN output"
@@ -1275,39 +1064,6 @@ config X86_IOPL_IOPERM
 	  ability to disable interrupts from user space which would be
 	  granted if the hardware IOPL mechanism would be used.
 
-config TOSHIBA
-	tristate "Toshiba Laptop support"
-	depends on X86_32
-	help
-	  This adds a driver to safely access the System Management Mode of
-	  the CPU on Toshiba portables with a genuine Toshiba BIOS. It does
-	  not work on models with a Phoenix BIOS. The System Management Mode
-	  is used to set the BIOS and power saving options on Toshiba portables.
-
-	  For information on utilities to make use of this driver see the
-	  Toshiba Linux utilities web site at:
-	  <http://www.buzzard.org.uk/toshiba/>.
-
-	  Say Y if you intend to run this kernel on a Toshiba portable.
-	  Say N otherwise.
-
-config X86_REBOOTFIXUPS
-	bool "Enable X86 board specific fixups for reboot"
-	depends on X86_32
-	help
-	  This enables chipset and/or board specific fixups to be done
-	  in order to get reboot to work correctly. This is only needed on
-	  some combinations of hardware and BIOS. The symptom, for which
-	  this config is intended, is when reboot ends with a stalled/hung
-	  system.
-
-	  Currently, the only fixup is for the Geode machines using
-	  CS5530A and CS5536 chipsets and the RDC R-321x SoC.
-
-	  Say Y if you want to enable the fixup. Currently, it's safe to
-	  enable this option even if you don't need it.
-	  Say N otherwise.
-
 config MICROCODE
 	def_bool y
 	depends on CPU_SUP_AMD || CPU_SUP_INTEL
@@ -2927,10 +2683,9 @@ config ISA_DMA_API
 	  Enables ISA-style DMA support for devices requiring such controllers.
 	  If unsure, say Y.
 
-if X86_32
-
 config ISA
 	bool "ISA support"
+	depends on X86_32
 	help
 	  Find out whether you have ISA slots on your motherboard.  ISA is the
 	  name of a bus system, i.e. the way the CPU talks to the other stuff
@@ -2938,120 +2693,6 @@ config ISA
 	  (MCA) or VESA.  ISA is an older system, now being displaced by PCI;
 	  newer boards don't support it.  If you have ISA, say Y, otherwise N.
 
-config SCx200
-	tristate "NatSemi SCx200 support"
-	help
-	  This provides basic support for National Semiconductor's
-	  (now AMD's) Geode processors.  The driver probes for the
-	  PCI-IDs of several on-chip devices, so its a good dependency
-	  for other scx200_* drivers.
-
-	  If compiled as a module, the driver is named scx200.
-
-config SCx200HR_TIMER
-	tristate "NatSemi SCx200 27MHz High-Resolution Timer Support"
-	depends on SCx200
-	default y
-	help
-	  This driver provides a clocksource built upon the on-chip
-	  27MHz high-resolution timer.  Its also a workaround for
-	  NSC Geode SC-1100's buggy TSC, which loses time when the
-	  processor goes idle (as is done by the scheduler).  The
-	  other workaround is idle=poll boot option.
-
-config OLPC
-	bool "One Laptop Per Child support"
-	depends on !X86_PAE
-	select GPIOLIB
-	select OF
-	select OF_PROMTREE
-	select IRQ_DOMAIN
-	select OLPC_EC
-	help
-	  Add support for detecting the unique features of the OLPC
-	  XO hardware.
-
-config OLPC_XO1_PM
-	bool "OLPC XO-1 Power Management"
-	depends on OLPC && MFD_CS5535=y && PM_SLEEP
-	help
-	  Add support for poweroff and suspend of the OLPC XO-1 laptop.
-
-config OLPC_XO1_RTC
-	bool "OLPC XO-1 Real Time Clock"
-	depends on OLPC_XO1_PM && RTC_DRV_CMOS
-	help
-	  Add support for the XO-1 real time clock, which can be used as a
-	  programmable wakeup source.
-
-config OLPC_XO1_SCI
-	bool "OLPC XO-1 SCI extras"
-	depends on OLPC && OLPC_XO1_PM && GPIO_CS5535=y
-	depends on INPUT=y
-	select POWER_SUPPLY
-	help
-	  Add support for SCI-based features of the OLPC XO-1 laptop:
-	   - EC-driven system wakeups
-	   - Power button
-	   - Ebook switch
-	   - Lid switch
-	   - AC adapter status updates
-	   - Battery status updates
-
-config OLPC_XO15_SCI
-	bool "OLPC XO-1.5 SCI extras"
-	depends on OLPC && ACPI
-	select POWER_SUPPLY
-	help
-	  Add support for SCI-based features of the OLPC XO-1.5 laptop:
-	   - EC-driven system wakeups
-	   - AC adapter status updates
-	   - Battery status updates
-
-config GEODE_COMMON
-	bool
-
-config ALIX
-	bool "PCEngines ALIX System Support (LED setup)"
-	select GPIOLIB
-	select GEODE_COMMON
-	help
-	  This option enables system support for the PCEngines ALIX.
-	  At present this just sets up LEDs for GPIO control on
-	  ALIX2/3/6 boards.  However, other system specific setup should
-	  get added here.
-
-	  Note: You must still enable the drivers for GPIO and LED support
-	  (GPIO_CS5535 & LEDS_GPIO) to actually use the LEDs
-
-	  Note: You have to set alix.force=1 for boards with Award BIOS.
-
-config NET5501
-	bool "Soekris Engineering net5501 System Support (LEDS, GPIO, etc)"
-	select GPIOLIB
-	select GEODE_COMMON
-	help
-	  This option enables system support for the Soekris Engineering net5501.
-
-config GEOS
-	bool "Traverse Technologies GEOS System Support (LEDS, GPIO, etc)"
-	select GPIOLIB
-	select GEODE_COMMON
-	depends on DMI
-	help
-	  This option enables system support for the Traverse Technologies GEOS.
-
-config TS5500
-	bool "Technologic Systems TS-5500 platform support"
-	depends on MELAN
-	select CHECK_SIGNATURE
-	select NEW_LEDS
-	select LEDS_CLASS
-	help
-	  This option enables system support for the Technologic Systems TS-5500.
-
-endif # X86_32
-
 config AMD_NB
 	def_bool y
 	depends on CPU_SUP_AMD && PCI
diff --git a/arch/x86/Kconfig.platforms b/arch/x86/Kconfig.platforms
new file mode 100644
index 000000000000..cac6753bacea
--- /dev/null
+++ b/arch/x86/Kconfig.platforms
@@ -0,0 +1,361 @@
+menu "Platform selection"
+
+config X86_EXTENDED_PLATFORM
+	bool "Support for extended (non-PC) x86 platforms"
+	default y
+	help
+	  If you disable this option then the kernel will only support
+	  standard PC platforms. (which covers the vast majority of
+	  systems out there.)
+
+	  If you enable this option then you'll be able to select support
+	  for the following non-PC x86 platforms, depending on the value of
+	  CONFIG_64BIT.
+
+	  32-bit platforms (CONFIG_64BIT=n):
+		Intel CE4100
+		Intel Quark
+		AMD Geode
+		AMD Elan
+		RDC R-321x
+
+	  64-bit platforms (CONFIG_64BIT=y):
+		Numascale NumaChip
+		ScaleMP vSMP
+		SGI Ultraviolet
+		Merrifield/Moorefield MID devices
+		Goldfish (Android emulator)
+
+	  If you have one of these systems, or if you want to build a
+	  generic distribution kernel, say Y here - otherwise say N.
+
+# This is an alphabetically sorted list of 64 bit extended platforms
+# Please maintain the alphabetic order if and when there are additions
+config X86_NUMACHIP
+	bool "Numascale NumaChip"
+	depends on X86_64
+	depends on X86_EXTENDED_PLATFORM
+	depends on NUMA
+	depends on SMP
+	depends on X86_X2APIC
+	depends on PCI_MMCONFIG
+	help
+	  Adds support for Numascale NumaChip large-SMP systems. Needed to
+	  enable more than ~168 cores.
+	  If you don't have one of these, you should say N here.
+
+config X86_VSMP
+	bool "ScaleMP vSMP"
+	select HYPERVISOR_GUEST
+	select PARAVIRT
+	depends on X86_64 && PCI
+	depends on X86_EXTENDED_PLATFORM
+	depends on SMP
+	help
+	  Support for ScaleMP vSMP systems.  Say 'Y' here if this kernel is
+	  supposed to run on these EM64T-based machines.  Only choose this option
+	  if you have one of these machines.
+
+config X86_UV
+	bool "SGI Ultraviolet"
+	depends on X86_64
+	depends on X86_EXTENDED_PLATFORM
+	depends on NUMA
+	depends on EFI
+	depends on KEXEC_CORE
+	depends on X86_X2APIC
+	depends on PCI
+	help
+	  This option is needed in order to support SGI Ultraviolet systems.
+	  If you don't have one of these, you should say N here.
+
+config X86_INTEL_MID
+	bool "Intel Z34xx/Z35xx MID platform support"
+	depends on X86_EXTENDED_PLATFORM
+	depends on X86_PLATFORM_DEVICES
+	depends on PCI
+	depends on X86_64 || (EXPERT && PCI_GOANY)
+	depends on X86_IO_APIC
+	select I2C
+	select DW_APB_TIMER
+	select INTEL_SCU_PCI
+	help
+	  Select to build a kernel capable of supporting 64-bit Intel MID
+	  (Mobile Internet Device) platform systems which do not have
+	  the PCI legacy interfaces.
+
+	  The only supported devices are the 22nm Merrified (Z34xx)
+	  and Moorefield (Z35xx) SoC used in the Intel Edison board and
+	  a small number of Android devices such as the Asus Zenfone 2,
+	  Asus FonePad 8 and Dell Venue 7.
+
+	  If you are building for a PC class system or non-MID tablet
+	  SoCs like Bay Trail (Z36xx/Z37xx), say N here.
+
+	  Intel MID platforms are based on an Intel processor and chipset which
+	  consume less power than most of the x86 derivatives.
+
+config X86_GOLDFISH
+	bool "Goldfish (Virtual Platform)"
+	depends on X86_EXTENDED_PLATFORM
+	help
+	  Enable support for the Goldfish virtual platform used primarily
+	  for Android development. Unless you are building for the Android
+	  Goldfish emulator say N here.
+
+# Following is an alphabetically sorted list of 32 bit extended platforms
+# Please maintain the alphabetic order if and when there are additions
+
+if X86_32 && X86_EXTENDED_PLATFORM
+
+config X86_INTEL_CE
+	bool "CE4100 TV platform"
+	depends on PCI
+	depends on PCI_GODIRECT
+	depends on X86_IO_APIC
+	select X86_REBOOTFIXUPS
+	select OF
+	select OF_EARLY_FLATTREE
+	help
+	  Select for the Intel CE media processor (CE4100) SOC.
+	  This option compiles in support for the CE4100 SOC for settop
+	  boxes and media devices.
+
+config X86_INTEL_QUARK
+	bool "Intel Quark platform support"
+	depends on X86_PLATFORM_DEVICES
+	depends on X86_TSC
+	depends on PCI
+	depends on PCI_GOANY
+	depends on X86_IO_APIC
+	select IOSF_MBI
+	select INTEL_IMR
+	select COMMON_CLK
+	help
+	  Select to include support for Quark X1000 SoC.
+	  Say Y here if you have a Quark based system such as the Arduino
+	  compatible Intel Galileo.
+
+config SCx200
+	tristate "NatSemi SCx200 support"
+	help
+	  This provides basic support for National Semiconductor's
+	  (now AMD's) Geode processors.  The driver probes for the
+	  PCI-IDs of several on-chip devices, so its a good dependency
+	  for other scx200_* drivers.
+
+	  If compiled as a module, the driver is named scx200.
+
+config SCx200HR_TIMER
+	tristate "NatSemi SCx200 27MHz High-Resolution Timer Support"
+	depends on SCx200
+	default y
+	help
+	  This driver provides a clocksource built upon the on-chip
+	  27MHz high-resolution timer.  Its also a workaround for
+	  NSC Geode SC-1100's buggy TSC, which loses time when the
+	  processor goes idle (as is done by the scheduler).  The
+	  other workaround is idle=poll boot option.
+
+config OLPC
+	bool "One Laptop Per Child support"
+	depends on !X86_PAE
+	select GPIOLIB
+	select OF
+	select OF_PROMTREE
+	select IRQ_DOMAIN
+	select OLPC_EC
+	help
+	  Add support for detecting the unique features of the OLPC
+	  XO hardware.
+
+config OLPC_XO1_PM
+	bool "OLPC XO-1 Power Management"
+	depends on OLPC && MFD_CS5535=y && PM_SLEEP
+	help
+	  Add support for poweroff and suspend of the OLPC XO-1 laptop.
+
+config OLPC_XO1_RTC
+	bool "OLPC XO-1 Real Time Clock"
+	depends on OLPC_XO1_PM && RTC_DRV_CMOS
+	help
+	  Add support for the XO-1 real time clock, which can be used as a
+	  programmable wakeup source.
+
+config OLPC_XO1_SCI
+	bool "OLPC XO-1 SCI extras"
+	depends on OLPC && OLPC_XO1_PM && GPIO_CS5535=y
+	depends on INPUT=y
+	select POWER_SUPPLY
+	help
+	  Add support for SCI-based features of the OLPC XO-1 laptop:
+	   - EC-driven system wakeups
+	   - Power button
+	   - Ebook switch
+	   - Lid switch
+	   - AC adapter status updates
+	   - Battery status updates
+
+config OLPC_XO15_SCI
+	bool "OLPC XO-1.5 SCI extras"
+	depends on OLPC && ACPI
+	select POWER_SUPPLY
+	help
+	  Add support for SCI-based features of the OLPC XO-1.5 laptop:
+	   - EC-driven system wakeups
+	   - AC adapter status updates
+	   - Battery status updates
+
+config GEODE_COMMON
+	bool
+
+config ALIX
+	bool "PCEngines ALIX System Support (LED setup)"
+	select GPIOLIB
+	select GEODE_COMMON
+	help
+	  This option enables system support for the PCEngines ALIX.
+	  At present this just sets up LEDs for GPIO control on
+	  ALIX2/3/6 boards.  However, other system specific setup should
+	  get added here.
+
+	  Note: You must still enable the drivers for GPIO and LED support
+	  (GPIO_CS5535 & LEDS_GPIO) to actually use the LEDs
+
+	  Note: You have to set alix.force=1 for boards with Award BIOS.
+
+config NET5501
+	bool "Soekris Engineering net5501 System Support (LEDS, GPIO, etc)"
+	select GPIOLIB
+	select GEODE_COMMON
+	help
+	  This option enables system support for the Soekris Engineering net5501.
+
+config GEOS
+	bool "Traverse Technologies GEOS System Support (LEDS, GPIO, etc)"
+	select GPIOLIB
+	select GEODE_COMMON
+	depends on DMI
+	help
+	  This option enables system support for the Traverse Technologies GEOS.
+
+config TS5500
+	bool "Technologic Systems TS-5500 platform support"
+	depends on MELAN
+	select CHECK_SIGNATURE
+	select NEW_LEDS
+	select LEDS_CLASS
+	help
+	  This option enables system support for the Technologic Systems TS-5500.
+
+config X86_RDC321X
+	bool "RDC R-321x SoC"
+	select M486
+	select X86_REBOOTFIXUPS
+	help
+	  This option is needed for RDC R-321x system-on-chip, also known
+	  as R-8610-(G).
+	  If you don't have one of these chips, you should say N here.
+
+config X86_REBOOTFIXUPS
+	bool "Enable X86 board specific fixups for reboot"
+	depends on X86_32
+	help
+	  This enables chipset and/or board specific fixups to be done
+	  in order to get reboot to work correctly. This is only needed on
+	  some combinations of hardware and BIOS. The symptom, for which
+	  this config is intended, is when reboot ends with a stalled/hung
+	  system.
+
+	  Currently, the only fixup is for the Geode machines using
+	  CS5530A and CS5536 chipsets and the RDC R-321x SoC.
+
+	  Say Y if you want to enable the fixup. Currently, it's safe to
+	  enable this option even if you don't need it.
+	  Say N otherwise.
+
+endif # X86_32 extended platform
+
+config TOSHIBA
+	tristate "Toshiba Laptop support"
+	depends on X86_32
+	help
+	  This adds a driver to safely access the System Management Mode of
+	  the CPU on Toshiba portables with a genuine Toshiba BIOS. It does
+	  not work on models with a Phoenix BIOS. The System Management Mode
+	  is used to set the BIOS and power saving options on Toshiba portables.
+
+	  For information on utilities to make use of this driver see the
+	  Toshiba Linux utilities web site at:
+	  <http://www.buzzard.org.uk/toshiba/>.
+
+	  Say Y if you intend to run this kernel on a Toshiba portable.
+	  Say N otherwise.
+
+config X86_32_IRIS
+	tristate "Eurobraille/Iris poweroff module"
+	depends on X86_32
+	help
+	  The Iris machines from EuroBraille do not have APM or ACPI support
+	  to shut themselves down properly.  A special I/O sequence is
+	  needed to do so, which is what this module does at
+	  kernel shutdown.
+
+	  This is only for Iris machines from EuroBraille.
+
+	  If unused, say N.
+
+config X86_INTEL_LPSS
+	bool "Intel Low Power Subsystem Support"
+	depends on X86 && ACPI && PCI
+	select COMMON_CLK
+	select PINCTRL
+	select IOSF_MBI
+	help
+	  Select to build support for Intel Low Power Subsystem such as
+	  found on Intel Lynxpoint PCH. Selecting this option enables
+	  things like clock tree (common clock framework) and pincontrol
+	  which are needed by the LPSS peripheral drivers.
+
+config X86_AMD_PLATFORM_DEVICE
+	bool "AMD ACPI2Platform devices support"
+	depends on ACPI
+	select COMMON_CLK
+	select PINCTRL
+	help
+	  Select to interpret AMD specific ACPI device to platform device
+	  such as I2C, UART, GPIO found on AMD Carrizo and later chipsets.
+	  I2C and UART depend on COMMON_CLK to set clock. GPIO driver is
+	  implemented under PINCTRL subsystem.
+
+config IOSF_MBI
+	tristate "Intel SoC IOSF Sideband support for SoC platforms"
+	depends on PCI
+	help
+	  This option enables sideband register access support for Intel SoC
+	  platforms. On these platforms the IOSF sideband is used in lieu of
+	  MSR's for some register accesses, mostly but not limited to thermal
+	  and power. Drivers may query the availability of this device to
+	  determine if they need the sideband in order to work on these
+	  platforms. The sideband is available on the following SoC products.
+	  This list is not meant to be exclusive.
+	   - BayTrail
+	   - Braswell
+	   - Quark
+
+	  You should say Y if you are running a kernel on one of these SoC's.
+
+config IOSF_MBI_DEBUG
+	bool "Enable IOSF sideband access through debugfs"
+	depends on IOSF_MBI && DEBUG_FS
+	help
+	  Select this option to expose the IOSF sideband access registers (MCR,
+	  MDR, MCRX) through debugfs to write and read register information from
+	  different units on the SoC. This is most useful for obtaining device
+	  state information for debug and analysis. As this is a general access
+	  mechanism, users of this option would have specific knowledge of the
+	  device they want to access.
+
+	  If you don't require the option or are in doubt, say N.
+
+endmenu
-- 
2.39.5


