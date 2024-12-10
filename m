Return-Path: <linux-kernel+bounces-439789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 892949EB3F2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 15:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF2C22864CC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286361C1AB4;
	Tue, 10 Dec 2024 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOCukELC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7162E1B85F8
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733842221; cv=none; b=bTg3lOVbfKrZiPuI+66gOGHInyqDPaebds8mEYMz/ZBG6PY2uoSVIrwMB8bSjqw9SLVWbqo4s1NhcVg2hfzdUyXiVm4h41RHwW2HT/Rw9/H9g8qIgKXwJySAhWRSYTB6vU411pE5urDoNlvilx2kI3Z6MZb+fgeqAEnVpGVXdNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733842221; c=relaxed/simple;
	bh=3SqhlieE4vNx9JonADEtTYk2B8rHIAfs7BIKa0g6a4w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kH2eKQJHMce1uaRfGjcYs6HO7jhFyzeBqkBDRcWZJ3O6eTG0XOy/kDV+IfZtzJ4BnKg69o0Kt9JbLgKMXlo7ESckprGHhvbCwZjuSTsWZXbocsoa6NoEVHTS898XXLmuSyZwzYCHqqn9yxFcXMjRatI12dbZR1GwgHjqgW0YFTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOCukELC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F06C4CEE4;
	Tue, 10 Dec 2024 14:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733842221;
	bh=3SqhlieE4vNx9JonADEtTYk2B8rHIAfs7BIKa0g6a4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FOCukELCMhDoJgoByOw2y2+84jzqroeGXEeIDgU3lDAq42msXuUItmlbZKAIRWpTf
	 1TMw/nrav0ErdnR+uNNIQYNbvY9I1tHI2us9KL+0SV/7hmKue/o/kRXYQwwidIXayf
	 9FqOdeNHYKCu3/1J9XgbTPH5PxhmnIInKArSVvlN/te6V9XbVZ4hryaTY8L92JfO1R
	 hrzkfOiQNjvRxtIaGL7OnqzkyuDNVTtz4MHZEK5xvGyr61mCwJXCyW+jA67WsgH840
	 oJWcIfOV6xbvHUlLar0wm+ujI2GCXE+xYhZNsl3F2RfqwQrLbSNbfpMlonaLMOfYdu
	 nn+hIWc0l+U7Q==
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
Subject: [PATCH v2 09/11] x86: document X86_INTEL_MID as 64-bit-only
Date: Tue, 10 Dec 2024 15:49:43 +0100
Message-Id: <20241210144945.2325330-10-arnd@kernel.org>
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
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/Kconfig | 50 ++++++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index d8a8bf9ea9b9..5ca8049004cb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -544,12 +544,12 @@ config X86_EXTENDED_PLATFORM
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
@@ -594,8 +594,31 @@ config X86_UV
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
@@ -605,6 +628,9 @@ config X86_GOLDFISH
 	  for Android development. Unless you are building for the Android
 	  Goldfish emulator say N here.
 
+# Following is an alphabetically sorted list of 32 bit extended platforms
+# Please maintain the alphabetic order if and when there are additions
+
 config X86_INTEL_CE
 	bool "CE4100 TV platform"
 	depends on PCI
@@ -620,24 +646,6 @@ config X86_INTEL_CE
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


