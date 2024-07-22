Return-Path: <linux-kernel+bounces-258708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D23B2938BF4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BD3E1F21B34
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEB116A37C;
	Mon, 22 Jul 2024 09:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="F+0jZ2IQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dwka9Wza"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF5D168A9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721640184; cv=none; b=JctRlY8J60dpQjyuiDIjNBy/rBZJrkck7uB0PHjhjTKmNUN70FJSzD4EHW5LQ+KtUBkNic9BK7+2Dy6+JJ3P6sWvq4ny4WE9+u3Ve1BkQDj6YcFf+D21GqcbnPAYgfH2v2ih0T8LgKwY+ykEPR4dMNZDlQCwPzC6gqNpv7nW2I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721640184; c=relaxed/simple;
	bh=VJHp/FFicRu0g7JqU01qEGGop1Rcofyj2WydQ8zyNQ4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=aGrFMb+ZptPNR7w+9pVNl3YdhlCneK0jMudELdBqyi2b0+ZnGqvLQYYKNOpnzDyG2eVGuZQbRvo8u6dm0woUk3V28AvDbiqT892QV8QlECy+X+eSvRTsyZkYkzgCafPO/ypqdlDojlZv4Qy4nRCCi24GwJOYomtJcZ0xxsi8Hz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=F+0jZ2IQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dwka9Wza; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 125B1138029E;
	Mon, 22 Jul 2024 05:23:00 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute4.internal (MEProxy); Mon, 22 Jul 2024 05:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1721640180;
	 x=1721726580; bh=bR8ieAnqFBM1DJcNSSbbe1kCeFWemjbad8WKXACoKbg=; b=
	F+0jZ2IQoERbzVEs3eBTL04GcWXCT11IMaqept87U5iIsW/DUgbGnjgRAEInLu5L
	sXLMb6OozuRT/N7O+bTDaH/ipsnVSULPelx4QLFr3JrPSp1pTtL2RwPvFGl4cB8C
	0Vs1qgarqbHyPOAmEwqWFC64oSNEEAXtQ2HtAu926FBu2rVZYTsYYBPzLjO7CBR6
	1WhLqMFIp6iFg0KbdiAgGZ4LfF1lk6MNoqGlc1/ONtVyQC/DobGrKBBQqNhW4tfU
	Ewo5qDyYnMwjGnDHm4yXBE4cHMpbGbqFG6dl9ZB+7YNwDE3pZVv9XtjpREzdg2Gr
	wAobH1p5MOPkq/0Lh9hOVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1721640180; x=
	1721726580; bh=bR8ieAnqFBM1DJcNSSbbe1kCeFWemjbad8WKXACoKbg=; b=D
	wka9WzakkcXvu42f42FLEPeur426IfkaYO+IJ1jy1FtfpT3DNAdpBrlxtRPu3uiS
	Ps9QOSwmem9ScBUesnACtLwhv2j2s9UE+ygf6K7ph69pJ65tyx7BIbXI1x2GfXwE
	/b+pl8ofX5dg4tX1kysArcd075eLxio3QaTyo1C2Coh2P6owfAKncS/KIIrnbgr6
	oOIm8s8A133w9ClPlK/veA7hO2bMZA7euxCPWmyw9DHlr+vbuoMMqdYxJ+mVxvap
	1GDVSrhrPHCrloQU3RXovjLdyKdYWRD++fN0pivoDfVjDYveDpteVl9hv7qkA2VW
	0BlvI2sx+vfR1vg1eas8w==
X-ME-Sender: <xms:8ySeZt9crmWIEu9ONjZkHYZDbCUCl6fdsTL4e4vxCFpa_ZCm8baKzg>
    <xme:8ySeZhsBODq4gOSeas7MLtYDzAvtek8H9RGpSZkb1yqL05Y9vtGfKDKuYC25oVvbv
    ZzcJaPcUtBUwXlVdCk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheejgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:8ySeZrASG4FxqJ99JJiL2DJNz_rptHWPljW3Y8bznzquIHBHjs6Jbw>
    <xmx:8ySeZheBdGorKbtiDPZ4xd0oB2Ux6ew2PBfAPBO5DtSar3RHAlo8fQ>
    <xmx:8ySeZiNlDS-gKlprGtADSaIhlUBwPkDb7f5oXpyhTkQ5Zh-6sJ7aTw>
    <xmx:8ySeZjkevCjhspPgLdZSVAy8hNOtb60mohZvFWifwBaOusy3fbBppA>
    <xmx:9CSeZp3Wzkd-4LwEnxqWx80Fm7FJ5jkdqFFKcFSfigTi0jpL21tCbdYj>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 85804B6008F; Mon, 22 Jul 2024 05:22:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-568-g843fbadbe-fm-20240701.003-g843fbadb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <85bb8bbc-f48d-46fd-aebb-03b2f7d3980a@app.fastmail.com>
In-Reply-To: 
 <CAMuHMdWMSpv1BbvCqf0Abfxf0sGp+5it-m1GtFR2nGuQ5-ZCAg@mail.gmail.com>
References: <202407200330.Mgxnq2Dq-lkp@intel.com>
 <420e09ad-f43f-4734-bc06-fee7a54f2eda@suse.cz>
 <CAMuHMdWMSpv1BbvCqf0Abfxf0sGp+5it-m1GtFR2nGuQ5-ZCAg@mail.gmail.com>
Date: Mon, 22 Jul 2024 11:22:38 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Vlastimil Babka" <vbabka@suse.cz>
Cc: "kernel test robot" <lkp@intel.com>, "Kees Cook" <kees@kernel.org>,
 oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: include/linux/slab.h:663:78: error: subscripted value is neither array nor
 pointer nor vector
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024, at 09:48, Geert Uytterhoeven wrote:
> On Mon, Jul 22, 2024 at 9:15=E2=80=AFAM Vlastimil Babka <vbabka@suse.c=
z> wrote:
>> On 7/19/24 10:02 PM, kernel test robot wrote:
>>
>> Hm the new error ettributed to slab seems just a consequence of the b=
roken
>> PAGE_SHIFT? Although it's not listed here in the errors for some reas=
on, I
>> assume without PAGE_SHIFT we don't have KMALLOC_SHIFT_HIGH thus we do=
n't
>> have kmem_buckets typedef and thus kmalloc_caches is who knows what a=
nd thus
>> doesn't look like an array? And the broken PAGE_SHIFT has to be cause=
 by
>> something else.
>>
>> >    arch/m68k/include/asm/page.h:10:25: error: 'CONFIG_PAGE_SHIFT' u=
ndeclared here (not in a function); did you mean 'CONFIG_LOG_BUF_SHIFT'?
>> >       10 | #define PAGE_SHIFT      CONFIG_PAGE_SHIFT
>> >          |                         ^~~~~~~~~~~~~~~~~
>
> It's a known issue since commit 5394f1e9b687bcf2 ("arch: define
> CONFIG_PAGE_SIZE_*KB on all architectures"): m68k-alldefconfig does
> not select any CPU types, hence no MMU type, and as a consequence no
> page size is selected.
>
> Arnd and I couldn't come up with a good solution to enforce a valid co=
nfig,
> so this is still broken...

I've tried again as this keeps coming up. Not sure if this
is a variant we have discussed before, but this way should
fix the issue. There are still two unrelated build failures
with 'alldefconfig' though:

arch/m68k/kernel/setup_mm.c:54:2: error: #warning No CPU/platform type s=
elected, your kernel will not work! [-Werror=3Dcpp]
   54 | #warning No CPU/platform type selected, your kernel will not wor=
k!
arm-soc/kernel/irq/irqdesc.c:592:3: error: array index in initializer ex=
ceeds array bounds
  592 |  [0 ... NR_IRQS-1] =3D {

       Arnd

8<---
From 4579e30445643f1def7b9a8ae2f8720ca963b973 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 22 Jul 2024 10:55:57 +0200
Subject: [PATCH] m68k: move sun3 into a top-level platform option

It is possible to select an m68k MMU build but not actually
enable any of the three MMU options, which then results in a
build failure:

 arch/m68k/include/asm/page.h:10:25: error: 'CONFIG_PAGE_SHIFT' undeclar=
ed here (not in a function); did you mean 'CONFIG_LOG_BUF_SHIFT'?

Change the Kconfig selection to ensure that exactly one of the
three options is always enabled whenever an MMU-enabled kernel
is built, but moving CONFIG_SUN3 into a top-level option next
to M68KCLASSIC and COLDFIRE.

All defconfig files should keep working without changes,
but alldefconfig now builds support for the classic MMU.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index cc26df907bfe..7c4f7bcc89d7 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -84,24 +84,23 @@ config MMU
 	  support by paged memory management. If unsure, say 'Y'.
=20
 config MMU_MOTOROLA
-	bool
+	def_bool MMU && M68KCLASSIC
 	select HAVE_PAGE_SIZE_4KB
=20
 config MMU_COLDFIRE
+	def_bool MMU && COLDFIRE
 	select HAVE_PAGE_SIZE_8KB
-	bool
=20
 config MMU_SUN3
-	bool
+	def_bool MMU && SUN3
 	select HAVE_PAGE_SIZE_8KB
-	depends on MMU && !MMU_MOTOROLA && !MMU_COLDFIRE
=20
 config ARCH_SUPPORTS_KEXEC
-	def_bool M68KCLASSIC && MMU
+	def_bool (M68KCLASSIC || SUN3) && MMU
=20
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
=20
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
=20
-if M68KCLASSIC
+endchoice
=20
 config M68000
-	def_bool y
-	depends on !MMU
+	def_bool M68KCLASSIC && !MMU
 	select CPU_HAS_NO_BITFIELDS
 	select CPU_HAS_NO_CAS
 	select CPU_HAS_NO_MULDIV64
@@ -56,7 +66,8 @@ config M68000
 	  a paging MMU.
=20
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
=20
+if M68KCLASSIC && MMU
+
 config M68030
 	bool "68030 support"
-	depends on MMU && !MMU_SUN3
 	select FPU
 	select CPU_HAS_ADDRESS_SPACES
 	help
@@ -78,7 +90,6 @@ config M68030
=20
 config M68040
 	bool "68040 support"
-	depends on MMU && !MMU_SUN3
 	select FPU
 	select CPU_HAS_ADDRESS_SPACES
 	help
@@ -89,13 +100,14 @@ config M68040
=20
 config M68060
 	bool "68060 support"
-	depends on MMU && !MMU_SUN3
 	select FPU
 	select CPU_HAS_ADDRESS_SPACES
 	help
 	  If you anticipate running this kernel on a computer with a MC68060
 	  processor, say Y. Otherwise, say N.
=20
+endif # M68KCLASSIC
+
 config M68328
 	bool
 	depends on !MMU
@@ -117,8 +129,6 @@ config M68VZ328
 	help
 	  Motorola 68VZ328 processor support.
=20
-endif # M68KCLASSIC
-
 if COLDFIRE
=20
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
=20
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
=20
 extra-y			+=3D vmlinux.lds
=20
-obj-$(CONFIG_AMIGA)	:=3D head.o
-obj-$(CONFIG_ATARI)	:=3D head.o
-obj-$(CONFIG_MAC)	:=3D head.o
-obj-$(CONFIG_APOLLO)	:=3D head.o
-obj-$(CONFIG_VME)	:=3D head.o
-obj-$(CONFIG_HP300)	:=3D head.o
-obj-$(CONFIG_Q40)	:=3D head.o
-obj-$(CONFIG_SUN3X)	:=3D head.o
-obj-$(CONFIG_VIRT)	:=3D head.o
-obj-$(CONFIG_SUN3)	:=3D sun3-head.o
+obj-$(CONFIG_M68KCLASSIC)	:=3D head.o
+obj-$(CONFIG_SUN3)		:=3D sun3-head.o
=20
 obj-y	+=3D entry.o irq.o module.o process.o ptrace.o
 obj-y	+=3D setup.o signal.o sys_m68k.o syscalltable.o time.o traps.o
diff --git a/arch/m68k/kernel/time.c b/arch/m68k/kernel/time.c
index a97600b2af50..108debb87cfb 100644
--- a/arch/m68k/kernel/time.c
+++ b/arch/m68k/kernel/time.c
@@ -62,7 +62,7 @@ void timer_heartbeat(void)
 }
 #endif /* CONFIG_HEARTBEAT */
=20
-#ifdef CONFIG_M68KCLASSIC
+#if defined(CONFIG_M68KCLASSIC) || defined(CONFIG_SUN3)
 /* machine dependent timer functions */
 int (*mach_hwclk) (int, struct rtc_time*);
 EXPORT_SYMBOL(mach_hwclk);
@@ -149,7 +149,7 @@ static int __init rtc_init(void)
=20
 module_init(rtc_init);
 #endif /* CONFIG_RTC_DRV_GENERIC */
-#endif /* CONFIG M68KCLASSIC */
+#endif /* CONFIG M68KCLASSIC || SUN3 */
=20
 void __init time_init(void)
 {

