Return-Path: <linux-kernel+bounces-430942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEC29E3798
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02277B2FB5D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8CF1B3725;
	Wed,  4 Dec 2024 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lDMW2LjY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F94E1B21BA
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308189; cv=none; b=oG2F8RWoeA8QYxg/ch/cqOB7tHI30Sq24ZJlc7GzTAOmjW76PkVhdUfYll0i+OtbQ257iHG6hFJTFvNz9MeZS1b1erI0VFs6Kw91XkfSk9oYMTAIcEgqBxllkzb4AvbOnHROXWcMp5m74bYcGSFv4YPrFAV7h3neaB4pHpfnJm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308189; c=relaxed/simple;
	bh=S2FjuuAJSpqyjxAEkoVpg7C+YRRR25+pprm6Y8jiNRA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QuEB4StrIj+/f34PL08Y0JjPK87F7Tn50pYfAXOJNHlnTYmU1NIDwVU/6zaeN+V9IyJ6xQerDyYGQTIVp8JN61skaSXkhTbBbLAKuqk24TilumwrHiMkTsEuYFyxAI8pLY89VVbCwwsuYRiM4xkjVYAHHxWVqfUHlLiBW+OHWYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lDMW2LjY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3203CC4CEE0;
	Wed,  4 Dec 2024 10:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733308189;
	bh=S2FjuuAJSpqyjxAEkoVpg7C+YRRR25+pprm6Y8jiNRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lDMW2LjYbGbaIV76L9vWIgeJ4wImXAyHMB0omokkcDyVb7soo3VZDUfNcAy1zhQpE
	 LcfKEM6mUjP+ewIHTfp7w9GW+q8fScb8OYRlZeITUGTLUNkx6oXjKVre1OQOEDd9Jw
	 lY//Z8c2ABcCAIKoV16iRM5pv6/+8ciD1OOzI1T0VuRVzfDvsTxEHeVlgJ9FjfoRXj
	 NdTxXMrzZSUngS1RTBwFHTV7FIMsZyp+LYm0/HYuudoDxbTcGe6Mcz5frUl93StdtC
	 RDsnfdz4iKPhXzRT0xx+6p+xWhlksbjTh8WhK9rWH/ECoS/6zHlau3oOf62FL8X2XW
	 yyl2mztRpH4QA==
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
Subject: [PATCH 04/15] ARM: deprecate support for ARM1136r0
Date: Wed,  4 Dec 2024 11:28:53 +0100
Message-Id: <20241204102904.1863796-5-arnd@kernel.org>
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

This CPU revision remains a special case as it is now incompatible
with CONFIG_SMP. Only the Nokia N8x0 is used in practice, and even
that one is fairly rare these days, so let's plan to remove all of
them after the 2025 LTS kernel release.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-imx/Kconfig       |  5 ++++-
 arch/arm/mach-omap2/Kconfig     | 15 ++++++++++++---
 arch/arm/mach-versatile/Kconfig |  5 ++++-
 arch/arm/mm/Kconfig             |  2 ++
 4 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index dce9cfc510b7..de9da57f0db4 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -39,12 +39,15 @@ if ARCH_MULTI_V6
 comment "ARM1136 platforms"
 
 config SOC_IMX31
-	bool "i.MX31 support"
+	bool "i.MX31 support (DEPRECATED)"
 	select CPU_ARM1136R0
 	select MXC_AVIC
 	help
 	  This enables support for Freescale i.MX31 processor
 
+	  This SoC is scheduled for removal in early 2026,
+	  since it uses the ARM1136r0 CPU revision.
+
 config SOC_IMX35
 	bool "i.MX35 support"
 	select CPU_ARM1136R1
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index c2b379850f59..3c4e55eb9d1d 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -207,18 +207,24 @@ comment "OMAP Core Type"
 	depends on ARCH_OMAP2
 
 config SOC_OMAP2420
-	bool "OMAP2420 support"
+	bool "OMAP2420 support (DEPRECATED)"
 	depends on ARCH_OMAP2
 	default y
 	select OMAP_DM_SYSTIMER
 	select OMAP_DM_TIMER
 	select SOC_HAS_OMAP2_SDRC
+	help
+	  This SoC is scheduled for removal in early 2026,
+	  since it uses the ARM1136r0 CPU revision.
 
 config SOC_OMAP2430
-	bool "OMAP2430 support"
+	bool "OMAP2430 support (DEPRECATED)"
 	depends on ARCH_OMAP2
 	default y
 	select SOC_HAS_OMAP2_SDRC
+	help
+	  This SoC is scheduled for removal in early 2026,
+	  since it uses the ARM1136r0 CPU revision.
 
 config SOC_OMAP3430
 	bool "OMAP3430 support"
@@ -249,11 +255,14 @@ config MACH_NOKIA_N810_WIMAX
 	bool
 
 config MACH_NOKIA_N8X0
-	bool "Nokia N800/N810"
+	bool "Nokia N800/N810 (DEPRECATED)"
 	depends on SOC_OMAP2420
 	default y
 	select MACH_NOKIA_N810
 	select MACH_NOKIA_N810_WIMAX
+	help
+	  This machine is scheduled for removal in early 2026,
+	  since it uses the ARM1136r0 CPU revision.
 
 endmenu
 
diff --git a/arch/arm/mach-versatile/Kconfig b/arch/arm/mach-versatile/Kconfig
index de42da7de8c8..ef7c02dd0d8e 100644
--- a/arch/arm/mach-versatile/Kconfig
+++ b/arch/arm/mach-versatile/Kconfig
@@ -110,11 +110,14 @@ config INTEGRATOR_CM1026EJS
 	select CPU_ARM1026
 
 config INTEGRATOR_CM1136JFS
-	bool "Integrator/CM1136JF-S core module"
+	bool "Integrator/CM1136JF-S core module (DEPRECATED)"
 	depends on ARCH_INTEGRATOR_AP
 	depends on ARCH_MULTI_V6
 	depends on !SMP
 	select CPU_ARM1136R0
+	help
+	  This machine is scheduled for removal in early 2026,
+	  since it uses the ARM1136r0 CPU revision.
 
 config ARCH_INTEGRATOR_CP
 	bool "Support Integrator/CP platform"
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index f5c1c6f82892..6c970c81d079 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -410,6 +410,8 @@ config CPU_ARM1136R0
 	help
 	  These early revisions of ARM1136 lack support for the
 	  ARMv6k extensions for multiprocessing.
+	  Support for this revision is scheduled for removal
+	  from the kernel in early 2026.
 
 config CPU_ARM1136R1
 	bool
-- 
2.39.5


