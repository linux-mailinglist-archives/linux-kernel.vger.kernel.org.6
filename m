Return-Path: <linux-kernel+bounces-430952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C919B9E37EA
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00278B3156F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 245731B85FD;
	Wed,  4 Dec 2024 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6AXLwr+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D5D1B21BE
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308233; cv=none; b=ndPT10QmnRa7H4gy32iVCg9syF5dgqoiLr8fpHkZ54+tN1ZxEFSqp/DVjDnJXNUS/MDF2xL01zhhmGCHxrPJTkY6R2IanHnNP5AZ+jtcPGXg80qaJ78ghBXAa/S9FsrIN1iBn0wNQ8rKapGNtxRETKG3zllc4DJn7nGsGi37CI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308233; c=relaxed/simple;
	bh=3y438iVSCRjif3uUSuYU+XZZGbL/kiock7Mz7H3Q0wI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hH7VPh5El/NUlw561DWec4KGM/++Gsywlj7T8TpU81mAPEE31KmsGHpXLV1UYaRHQOFBXZGkaWJV8jewPVmyjFA7nERfL3Cd6B+rXRJjRhKQFQabRJ2D4/lmDYwc2k4P5hwc/SiwLqzPHnzgB6HQfGiUklCSx3ZZJj1+SoXzxhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6AXLwr+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C49C4CEDD;
	Wed,  4 Dec 2024 10:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733308233;
	bh=3y438iVSCRjif3uUSuYU+XZZGbL/kiock7Mz7H3Q0wI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n6AXLwr+aR6cqrQmzWCVnAdDptc5iY1/yB5jen8P+3dCAwbIqCnJfvppJbZBbnisC
	 ItpbTbS9m9gmFjvBHneN50GdcqCA/d8fVpibyWDpp/xzKrzft+JMILbh9qnaPhTLDi
	 ynL4/VW0EnZ6amxjuqPR2tBBVLtYRM4BgncQRGLAtQEgZna5SzY9B31L5hNni6K1qZ
	 lq6AMm9F+sQiNGa2kOsQyoASXSZe4kHz5gZLUc0DD0V99DhSChRnhTIlmJvpzEMMML
	 hTkKshIN+qQoZvu3IeVjwe638xxemldqhs872nT94Fxsoj6frygyW8AEABFtF7C3qq
	 /dzBB1Su0GWGw==
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
Subject: [PATCH 14/15] ARM: mark RiscPC as deprecated
Date: Wed,  4 Dec 2024 11:29:03 +0100
Message-Id: <20241204102904.1863796-15-arnd@kernel.org>
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

This platform is the oldest still supported machine, dating back
to the original 1994 ARM610 version.  The only currently supported
configuration uses an ARMv4 StrongARM but still requires building
for ARMv3 because of the board design not supporting 16-bit
data access.

ARMv3 support has been removed in gcc-9, and the gcc-8 release
is already old but still supported for building the kernel.

The only set of machines that lacks support for 16-bit load/store
instructions (Alpha EV5 and older) was recently removed from
the kernel.

Since there is little hope of this being maintainable much
longer, plan to remove it in early 2025 while it is still expected
to mostly work.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-rpc/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rpc/Kconfig b/arch/arm/mach-rpc/Kconfig
index 55f6d829b677..90c13eaeec1f 100644
--- a/arch/arm/mach-rpc/Kconfig
+++ b/arch/arm/mach-rpc/Kconfig
@@ -1,5 +1,5 @@
 config ARCH_RPC
-	bool "RiscPC"
+	bool "RiscPC (DEPRECATED)"
 	depends on ARCH_MULTI_V4 && !(ARCH_MULTI_V4T || ARCH_MULTI_V5)
 	depends on !(ARCH_FOOTBRIDGE || ARCH_SA1100 || ARCH_MOXART || ARCH_GEMINI)
 	depends on !CC_IS_CLANG && GCC_VERSION < 90100 && GCC_VERSION >= 60000
@@ -19,3 +19,6 @@ config ARCH_RPC
 	help
 	  On the Acorn Risc-PC, Linux can support the internal IDE disk and
 	  CD-ROM interface, serial and parallel port, and the floppy drive.
+
+	  Support for these machines will go away in 2025,
+	  unless there are any remaining users that speak up.
-- 
2.39.5


