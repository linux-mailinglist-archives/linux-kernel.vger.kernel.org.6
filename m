Return-Path: <linux-kernel+bounces-430953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34379E377A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 996B7285943
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732021AB528;
	Wed,  4 Dec 2024 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXJA2ALQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15F31A724C
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308237; cv=none; b=irjlDMJMjvuzZhkhN0sLF/JWwh246IqJE7B1MpCvbwRtYhVOZyIRWc/snAzY+n/0CFJ6RF//9QirH+CALm6Ls3hO8krqMz6cm1OiIjOPv17Hde8nzI1lfzEq3/cfRkvG2BiuOSvgNzxtIzElWdpNtnRhik9rqMchUJwJ9vuJveU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308237; c=relaxed/simple;
	bh=KA2Hh3KSr/1FPqAch6lEtAdXOaOdnfbOu1UPhcIPy5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XDlCFLKvGSpovqnGj8vRvKQ+bdMQhWYJF6PGQMBT5nLEtYlfbhSzQ8sa8JacuEK3moruWrICYRG1xcBmn9ZKGQ70ZF6GE/eavK63xW10USVOKMUb2Rlbd0wAHOnJkCfwFq33+/rFLNcsIwNicsJQ82aNjgmHwpl0Cul7wC/W29s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXJA2ALQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E67C4CEE1;
	Wed,  4 Dec 2024 10:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733308237;
	bh=KA2Hh3KSr/1FPqAch6lEtAdXOaOdnfbOu1UPhcIPy5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tXJA2ALQObCLnxkCpRx8Fb6Q8zGpOUiiKuryw7TWqFW+6kpJeFhWFvUhepN0WpjjN
	 ZXHO+X4qPpjzRAQvGdm1Pm6GT3SfbhpotPG/Aw+BQb4ILhAjbKVw76rhDUQeMz1l2I
	 ODgU/6Uz2M0V5NCnZxyWDJlleY+T0uh7d7kZ7eI9FWlrODU+xmmLRlAXSghPLCLw4B
	 gZgUKHjiEnWMooq2jkv9miADwNwQbTxxZXbkxwgtEU/CQTzJZ3FUKKewQUFERuenPF
	 pe+YP63pde18c75VhEoCWvn/mhZvmn0gxgEVTSyvYAEWExB7iaYoV2zcbtq5lckYjT
	 IIwoNtSCBGUSQ==
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
Subject: [PATCH 15/15] ARM: mark footbridge as deprecated
Date: Wed,  4 Dec 2024 11:29:04 +0100
Message-Id: <20241204102904.1863796-16-arnd@kernel.org>
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

Along with RiscPC and SA1100, these are the last remaining Intel StrongARM
machines. The Corel NetWinder used to be particular popular in the late
1990s, but was discontinued during the bankruptcy of rebel.com in 2001.
The other machine is the DEC (later Intel) EBSA285 evaluation board that
was made in small numbers in 1997 for software developers.

The footbridge/netwinder platform was the main target for the first Debian
2.0 "Hamm" release on the Arm architecture back in 1998, but was dropped
in Debian 6.0 "Squeeze" in 2011, which only supported ARMv4T and higher
with the EABI based ports as ARMv4 hardware had fallen already out of
use by that time.

Link: http://netwinder.org/
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-footbridge/Kconfig | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-footbridge/Kconfig b/arch/arm/mach-footbridge/Kconfig
index 78189997caa1..1ac37cadb201 100644
--- a/arch/arm/mach-footbridge/Kconfig
+++ b/arch/arm/mach-footbridge/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig ARCH_FOOTBRIDGE
-	bool "FootBridge Implementations"
+	bool "FootBridge Implementations (DEPRECATED)"
 	depends on ARCH_MULTI_V4 && !(ARCH_MULTI_V4T || ARCH_MULTI_V5)
 	depends on !(ARCH_MOXART || ARCH_GEMINI || ARCH_SA1100)
 	depends on ATAGS
@@ -12,7 +12,10 @@ menuconfig ARCH_FOOTBRIDGE
 	select NEED_MACH_MEMORY_H
 	help
 	  Support for systems based on the DC21285 companion chip
-	  ("FootBridge"), such as the Simtec CATS and the Rebel NetWinder.
+	  ("FootBridge"), used in the EBSA285 and the Rebel NetWinder.
+
+	  Support for these machines will go away in 2025,
+	  unless there are any remaining users that speak up.
 
 if ARCH_FOOTBRIDGE
 
-- 
2.39.5


