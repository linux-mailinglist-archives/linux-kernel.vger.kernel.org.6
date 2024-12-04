Return-Path: <linux-kernel+bounces-430948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 494399E37D3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF07EB2FBA2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D841B4F21;
	Wed,  4 Dec 2024 10:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7yp1Q6K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9907E1AF0BC
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308215; cv=none; b=mV2ikej5fd0COnyjm5ZBYfs3yaPQd4yUQJ7pCwANfTAbWZt+zKB967iLhx6z/OiQcMCvKts5JwzIxQuGnaKgqd206vD0GyuhDf2MUoF/zWsvTT17zDES9ROGY07BIeR7cqIkW+ov+mr5aHl2koaNigb4IL9F4e6DQCwe34DcEMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308215; c=relaxed/simple;
	bh=xv+CbtFY6FV5HX6gbusMtIex1IYQRXtvcNJL6BglegI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UBNF3FnumdrWRZNUY6bAm4hMdRo1GaECYnRE0ugVNpZc0Qlzm/+rAbqxDC8OXQxdLPem8I++FvITfoOkPV60FLWe4mLYAzjadPbXhqsXij9V5E0yKh6bJBvV+1sfYW20yIscdKS8L5V0pi+h1tUuH0JXHvkUzj1TldfsoIqrl4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7yp1Q6K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5A2C4CEE1;
	Wed,  4 Dec 2024 10:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733308215;
	bh=xv+CbtFY6FV5HX6gbusMtIex1IYQRXtvcNJL6BglegI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u7yp1Q6KjWYvaNXJ07IKlmh280G5wsLKn6OymxGGCsLotzIeJWCHziEHu0WRc6mDP
	 JTktFm72evtDu80EM4IWwL5KvxNVcbd2PMN5u3MsHeDFj28siCI7ZQm3LVakQRuFOw
	 ToBnkFJ7cfpy2LJZs+T2ljZL9Z4n2hDlkk6Uyt3uMFPxkgTQXpFCmJLVLGi4k3pMCT
	 eZ+X8VgmfigvfvXUzK1X7igm33SR9F8+ecZicqG5yXDaUYLDfg9tfqwuUrehqEIQ88
	 lLVbgUk+K6lISv+rpL3Q9U9lNbWQyFf11LmUtLUTCj9JoKWuCX+/Oj0z9Ko7qPWoy2
	 GIH4PN4xyaM4A==
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
Subject: [PATCH 10/15] ARM: deprecate ARCH_DOVE
Date: Wed,  4 Dec 2024 11:28:59 +0100
Message-Id: <20241204102904.1863796-11-arnd@kernel.org>
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

The Marvell Armada 510 (Dove) platform is supported both as devicetree
and atags/boardfile variants, with varying degrees of hardware support.

Russell was the last known user of the board file version, and there
are very few users overall. Unless Russell still needs this variant,
let's remove it soon, in order to simplify the DT conversion of the
remaining plat-orion machines (mv78xx0 and orion5x).

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-dove/Kconfig | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-dove/Kconfig b/arch/arm/mach-dove/Kconfig
index 996888ffcfe7..01e79945ddcf 100644
--- a/arch/arm/mach-dove/Kconfig
+++ b/arch/arm/mach-dove/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 menuconfig ARCH_DOVE
-	bool "Marvell Dove" if ARCH_MULTI_V7
+	bool "Marvell Dove (DEPRECATED)" if ARCH_MULTI_V7
 	depends on ATAGS
 	select CPU_PJ4
 	select GPIOLIB
@@ -11,7 +11,11 @@ menuconfig ARCH_DOVE
 	select PM_GENERIC_DOMAINS if PM
 	select PCI_QUIRKS if PCI
 	help
-	  Support for the Marvell Dove SoC 88AP510
+	  Support for the Marvell Dove SoC 88AP510 using board files.
+
+	  Support for this machine will be removed in early 2025, unless
+	  there is a strong reason to keep it. Users should migrate to
+	  the devicetree-enabled version (CONFIG_MACH_DOVE) instead.
 
 if ARCH_DOVE
 
-- 
2.39.5


