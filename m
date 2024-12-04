Return-Path: <linux-kernel+bounces-430947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE729E37B3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC272B30A82
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB351B0F36;
	Wed,  4 Dec 2024 10:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSHuERQ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E45C1AA7A5
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308211; cv=none; b=fyqoruroL+dPZJxS3GV6jRa6ppr72zZdi8qqGhTBnK2gKeugpvTmqXKr78O56TGf1QCWBcBlkiXy+7+aClBs4IW9+bBHhLC9Mf08XHZPiOGAc1tUC8BzntC5k3S4lAwbUZYs3mWaMf1WjitxIccpnXh3rDX6L1RZvrKPvg2wLPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308211; c=relaxed/simple;
	bh=o9i3NEXM3yLAVapt19Pwv61KGYVGmrYSEnA6hPSma3w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MWyC6hjbga89E1qTAN43lXn7q7v8E3zPEzvtseINU8/GdIXxDueBMrRnee+c5EFHV2m9Y1WMxkkICVuPG4CVSPz1xekiYD8/cIacNhun9vIJmDCA2bAsiIk+cudEySzhTsKaOpP30+gQG02VpIGgXuvb6foFc3Hdz1FzWhiapn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSHuERQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC64C4CEDD;
	Wed,  4 Dec 2024 10:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733308211;
	bh=o9i3NEXM3yLAVapt19Pwv61KGYVGmrYSEnA6hPSma3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SSHuERQ6p80T31BEClJXEmzgpjbOckqnLeLun2JcXJU70vqNaC45bCedi4UdlTHUj
	 j82sWIqRY1MM/ffnuW+p01oSwbjwFPreC9cf9KNvk2+wMqkpFxNk0HuoaHglg3wAME
	 TcVt2f8hWdiShQwwusUpC8O+CosWmgp3sjGpCWHSxCnisho+ztx+gvHK9p/K+eMiU4
	 Dh7SL6G4B5mSIuzqsVmGozUuLiuqxz9da1r1XdlpqtLxgxFM4pUug5o07C1iIPGGn+
	 RBsaQsZUs9dZtC3v76XDLNOgLWfHZV08PcIAMzj1/hbQ9stenMWGocxZB92IS/kBPM
	 x5JPYUaXHNMEA==
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
Subject: [PATCH 09/15] ARM: mark IWMMXT as deprecated
Date: Wed,  4 Dec 2024 11:28:58 +0100
Message-Id: <20241204102904.1863796-10-arnd@kernel.org>
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

With no remaining users and support getting removed from future compilers,
there seems little point in keeping iwmmxt around much longer.

On the other hand, the iwmmxt support in the kernel rarely gets in the
way, so there is little cost, so set a removal date of early 2026 for
the moment. If anyone is still using this, it can be extended as long
there is binutils support.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d92531c3f982..9e8f100ad514 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -509,13 +509,21 @@ config PLAT_VERSATILE
 source "arch/arm/mm/Kconfig"
 
 config IWMMXT
-	bool "Enable iWMMXt support"
-	depends on CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK
-	default y if PXA27x || PXA3xx || ARCH_MMP
+	bool "Enable iWMMXt support (DEPRECATED)"
+	depends on PXA27x || PXA3xx || ARCH_MMP
 	help
 	  Enable support for iWMMXt context switching at run time if
 	  running on a CPU that supports it.
 
+	  Machines that actually support this feature are very rare,
+	  and support is deprecated in new gcc-14.  While there were a
+	  few applications that used this in the past, none are known
+	  to still do so.
+
+	  If you use this, please send a patch to remove the
+	  deprecation, otherwise this will be removed in early
+	  2026.
+
 if !MMU
 source "arch/arm/Kconfig-nommu"
 endif
-- 
2.39.5


