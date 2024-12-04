Return-Path: <linux-kernel+bounces-430949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C6F9E3775
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5A328516F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD391B218A;
	Wed,  4 Dec 2024 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/0ypPQH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5C41B2188
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308220; cv=none; b=CupKTVWQAZCRcc1JPeNKiFvp6lwKjsQ8vSP95O1g0ewLUA6fprYp69lvpbob+B7b0lNdTklNM7UjDcYbrMGk20+9ByWwBmSfHrWvABpFT0pvYqmdfu04am+HacKWAX5zy24FycOiyJZyQFi1vKCA2ndE0/9318B335BfhcYFNXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308220; c=relaxed/simple;
	bh=eRwTJcvOcBqsfk9RyLjladsqQIYfI5C2P8yvjI+Gx9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pay/s+qaQyw5M+aY4UmuxUD+Nr1fTv2QvAs4UBIU8aycNAyB18EFjWPzMAQvMxXIOeCP92aiA+TjqT+T3F9MyGg2S3ZYLtdOgCXaRN2pKa+2PBYveZ7Seewe/pg8zriYLEdhnzuuPesgWNJ+8m2VVEyYh5kd/A6eOypdkRBZZrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/0ypPQH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED752C4CEDD;
	Wed,  4 Dec 2024 10:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733308219;
	bh=eRwTJcvOcBqsfk9RyLjladsqQIYfI5C2P8yvjI+Gx9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C/0ypPQHv+d2jQnT4vdgXOJNqtZHM0ljsbE2j2WV0KOPE/FHAUmBkh01/WGiayGoK
	 +LfgJfSLQ9lCz2wwxgK/FaEVVxlsmTdqjedoZGi85iTK5rjvPPwl//ACBARKX8eVWH
	 YqsbfyTDh7ythCMywUvXqVEqeZpxd9J3/LSz9vUI+ueEuBXOfeAyt5ZqJbOjRdFR8q
	 ttqaf8EpEeSuURf+8V1NKM8XDMRtUIqPEa9BQfsvzUzo1Wx6kczSSQ/1sp57c0NWDh
	 khFErVCgfprDp8IERcIcFadxh2V+YOwqymPGCdgKuPEycgWekSRUSggjEZwVcJesna
	 3B+CgfCD9UFfA==
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
Subject: [PATCH 11/15] ARM: PXA: deprecate remaining board file support
Date: Wed,  4 Dec 2024 11:29:00 +0100
Message-Id: <20241204102904.1863796-12-arnd@kernel.org>
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

In the 2021 board file removal, the gumstix and sharpsl
support was left around in order to make it easier to convert
more of the PXA platform to device tree, given that both
platforms had some level of support in qemu.

As far as I can tell, nobody has worked on additional DT
conversion in that time, and qemu has in turn deprecated
the entire PXA platform.

Schedule the remaining board files for removal now, as they
are unlikely to be of any help in the future. If anyone
wants to revive support for these machines, they can
obviously still contribute device tree based code and
work on updating the corresponding drivers.

Any drivers that are only usable on legacy PXA board files
can also get removed along with the boards, or saved by
adding devicetree support.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/configs/pxa_defconfig |  4 ----
 arch/arm/mach-pxa/Kconfig      | 10 ++++++++--
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index 3b9e67546f8c..96cef84dbb8e 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -16,10 +16,6 @@ CONFIG_PROFILING=y
 CONFIG_KEXEC=y
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_PXA=y
-CONFIG_ARCH_GUMSTIX=y
-CONFIG_PXA_SHARPSL=y
-CONFIG_MACH_AKITA=y
-CONFIG_MACH_BORZOI=y
 CONFIG_ARCH_FORCE_MAX_ORDER=8
 CONFIG_CMDLINE="root=/dev/ram0 ro"
 CONFIG_CPU_FREQ=y
diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 10e472f4fa43..79d9785453c9 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -57,12 +57,15 @@ if ATAGS
 comment "Legacy board files"
 
 config ARCH_GUMSTIX
-	bool "Gumstix XScale 255 boards"
+	bool "Gumstix XScale 255 boards (DEPRECATED)"
 	select PXA25x
 	help
 	  Say Y here if you intend to run this kernel on
 	  Basix, Connex, ws-200ax, ws-400ax systems
 
+	  Support for this machine will go away in early 2025,
+	  unless it gets converted to device tree.
+
 choice
 	prompt "Gumstix Carrier/Expansion Board"
 	depends on ARCH_GUMSTIX
@@ -76,7 +79,7 @@ config GUMSTIX_AM300EPD
 endchoice
 
 config PXA_SHARPSL
-	bool "SHARP Zaurus SL-5600, SL-C7xx and SL-Cxx00 Models"
+	bool "SHARP Zaurus SL-5600, SL-C7xx and SL-Cxx00 Models (DEPRECATED)"
 	select SHARP_PARAM
 	select SHARP_SCOOP
 	help
@@ -86,6 +89,9 @@ config PXA_SHARPSL
 	  SL-C3000 (Spitz), SL-C3100 (Borzoi) or SL-C6000x (Tosa)
 	  handheld computer.
 
+	  Support for these machines will go away in early 2025,
+	  unless they get converted to device tree.
+
 config PXA_SHARPSL_DETECT_MACH_ID
 	bool "Detect machine ID at run-time in the decompressor"
 	depends on PXA_SHARPSL
-- 
2.39.5


