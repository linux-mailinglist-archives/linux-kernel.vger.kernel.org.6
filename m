Return-Path: <linux-kernel+bounces-534994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08718A46DA3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBEF53ADE89
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 21:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78E225D539;
	Wed, 26 Feb 2025 21:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nFN2OZSN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9122661B5
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 21:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740605875; cv=none; b=LsSdoTB+BVmE6z9bTbc0IGe6STkDenQ3NF3/cPq33QH2Q9nTpwg475Wn60xKcrl1xfBDrbN/Sd4EDodSDNODxJAWDJeN5ftm2O2cZeAbUas1PKcXyFrf1nAYRzVLeIFQ+pn0vshygrvVGPeW+ID1hG9kuaxwd49SNZptZNRkDqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740605875; c=relaxed/simple;
	bh=zFHhKHiqgU3FhAAL2PwPWvWsa0XESYEOYyIQF5YlQzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bLQmZxwbTFNUa5w53hwsfAnFEoVNGRbXL+5MHDhh9nojLkbLMyQNB3NgBAWeyumOlZ7sgMQldR5+D6xnyz4PF4ZEmERVHcmSrR0bVSk+T+QrRmW9kBYFhPrX2bAW/o6VB05QfQnHtvcJCp6EbxsldxLMuG3uHOk86vbDHNviPjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nFN2OZSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93F4C4CED6;
	Wed, 26 Feb 2025 21:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740605875;
	bh=zFHhKHiqgU3FhAAL2PwPWvWsa0XESYEOYyIQF5YlQzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nFN2OZSNJ2KW6Q7Ls3iiQ+ZGPTcAv3lJXsm6H1tDXiRGXqUTrxoi3zwcNmAgw7RuV
	 MB6NkIQgW0l8Ltpn8qty5UDH5aEGLeglAC7PyWUacAoBk5DojKLYJBg38zqd4Pz8wb
	 z9CoW/e/hgivu4oULpn+MiLaPMnekTcpc2x6Jteo0Q8l6DsIIjMHlhhZxZFrmFT+M9
	 kZqUBbrCR1LfOopgpuCAk/DLMsYsbmbZNbM3oy5UVRzdEs7GuFn+4flPXeFSxTUD9N
	 TW2nwnZ32PeWlwZdUXl+cWKXluAUcwkJOExiubD2igezv0MGzPe6Yey3g7K0b6RIom
	 WrJJEOmeszTlA==
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
	Matthew Wilcox <willy@infradead.org>,
	Ferry Toth <fntoth@gmail.com>
Subject: [PATCH v3 08/10] x86: document X86_INTEL_MID as 64-bit-only
Date: Wed, 26 Feb 2025 22:37:12 +0100
Message-Id: <20250226213714.4040853-9-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250226213714.4040853-1-arnd@kernel.org>
References: <20250226213714.4040853-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The X86_INTEL_MID code was originally introduced for the 32-bit
Moorestown/Medfield/Clovertrail platform, later the 64-bit
Merrifield/Moorefield variants were added, but the final Morganfield
14nm platform was canceled before it hit the market.

To help users understand what the option actually refers to, update the
help text, and add a dependency on 64-bit kernels.

Ferry confirmed that all the hardware can run 64-bit kernels these days,
but is still testing 32-bit kernels on the Intel Edison board, so this
remains possible, but is guarded by a CONFIG_EXPERT dependency now,
to gently push remaining users towards using CONFIG_64BIT.

Cc: Ferry Toth <fntoth@gmail.com>
Link: https://lore.kernel.org/lkml/d890eecc-97de-4abf-8e0e-b881d5db5c1d@gmail.com/
Acked-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/Kconfig | 50 ++++++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index aba32f88870d..42dd3c58abfb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -548,12 +548,12 @@ config X86_EXTENDED_PLATFORM
 		RDC R-321x SoC
 		SGI 320/540 (Visual Workstation)
 		STA2X11-based (e.g. Northville)
-		Moorestown MID devices
 
 	  64-bit platforms (CONFIG_64BIT=y):
 		Numascale NumaChip
 		ScaleMP vSMP
 		SGI Ultraviolet
+		Merrifield/Moorefield MID devices
 
 	  If you have one of these systems, or if you want to build a
 	  generic distribution kernel, say Y here - otherwise say N.
@@ -598,8 +598,31 @@ config X86_UV
 	  This option is needed in order to support SGI Ultraviolet systems.
 	  If you don't have one of these, you should say N here.
 
-# Following is an alphabetically sorted list of 32 bit extended platforms
-# Please maintain the alphabetic order if and when there are additions
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
 
 config X86_GOLDFISH
 	bool "Goldfish (Virtual Platform)"
@@ -609,6 +632,9 @@ config X86_GOLDFISH
 	  for Android development. Unless you are building for the Android
 	  Goldfish emulator say N here.
 
+# Following is an alphabetically sorted list of 32 bit extended platforms
+# Please maintain the alphabetic order if and when there are additions
+
 config X86_INTEL_CE
 	bool "CE4100 TV platform"
 	depends on PCI
@@ -624,24 +650,6 @@ config X86_INTEL_CE
 	  This option compiles in support for the CE4100 SOC for settop
 	  boxes and media devices.
 
-config X86_INTEL_MID
-	bool "Intel MID platform support"
-	depends on X86_EXTENDED_PLATFORM
-	depends on X86_PLATFORM_DEVICES
-	depends on PCI
-	depends on X86_64 || (PCI_GOANY && X86_32)
-	depends on X86_IO_APIC
-	select I2C
-	select DW_APB_TIMER
-	select INTEL_SCU_PCI
-	help
-	  Select to build a kernel capable of supporting Intel MID (Mobile
-	  Internet Device) platform systems which do not have the PCI legacy
-	  interfaces. If you are building for a PC class system say N here.
-
-	  Intel MID platforms are based on an Intel processor and chipset which
-	  consume less power than most of the x86 derivatives.
-
 config X86_INTEL_QUARK
 	bool "Intel Quark platform support"
 	depends on X86_32
-- 
2.39.5


