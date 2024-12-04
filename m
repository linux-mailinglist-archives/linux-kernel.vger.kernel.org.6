Return-Path: <linux-kernel+bounces-430951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CE49E3778
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201C01659AE
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC72C1B81DC;
	Wed,  4 Dec 2024 10:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CG6/GR73"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177A91B21BE
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308229; cv=none; b=BkLsgO2KjHqzYRhiF9Nvs35BJSt6Ll7qDgB+Do6xP2Sx5FPH6Hnc3m1EHGtfoKynNJDlPhaKWhHJtauuHF6WzKIPrWxW+jF6Q8n/hJJnkC4T5BL09mSNYrALYqyg8b2WacVffBRwPCM9HUR8lBFnCkfCrQ08gkzWgj9h9vEqSH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308229; c=relaxed/simple;
	bh=2usRHJwXPLxCLKp3Cp+X+mvu8EQwaVbHBk6s3Pt0UDI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AuxqchGslSglV1mFcTAh4zx9zEkYs9wB7zO+Dty5Z++WYqjMTt0BMHIIztKRwZLBahN4V9GCdoM68hleH4nBCnmcfxu7ZsOz8Q0+l2/gc2sUMWRRKI7lOIa+MFBmRzg92nBwBNGkx/C1Chvsucgs0kuZgt9tSB2A9qbLfQ0PIWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CG6/GR73; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9B3EC4CEE1;
	Wed,  4 Dec 2024 10:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733308228;
	bh=2usRHJwXPLxCLKp3Cp+X+mvu8EQwaVbHBk6s3Pt0UDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CG6/GR7382ltvgUUHANIq2MKmi0iiW8nL8dTyvAGLo3tnhPGgO1Py9ZpFEbnCATjw
	 52xSTYGEiHHQl3rqH1yHCF2rl2XokGyBh2Nu+3DC87HdRaQFjgySYWywV/PXIhFl3S
	 Du84oXm7xS6kP3hef7e6epH4mOeSqM4/1V1wn2axFfTXWUimZYxNSRE9h3T91i3FfF
	 CMzgrI+r4QeP1z+aeG3Riteq09Ykohv1qJrZAjZMayem9mWhnzvkQjHnyofDIkdeGl
	 xuAccf6C6DvzsswTvHAM5Br8O/Lo1CsnmIMlIGus/Dmjk7bpC7FyzNLLcTfpZq5b7I
	 tnm2IeJF0Dcqg==
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
Subject: [PATCH 13/15] ARM: mark mach-sa1100 as deprecated
Date: Wed,  4 Dec 2024 11:29:02 +0100
Message-Id: <20241204102904.1863796-14-arnd@kernel.org>
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

Most of the old StrongARM1100 machines were removed two years ago as part
of a wider cleanup, the remaining four were left either because someone
showed interest in converting them to devicetree, or because they were
still supported by qemu and therefore useful to keep the platform alive.

None of the devicetree conversion actually happened, and qemu has
marked the platform as deprecated, so do the same in the kernel now.

If anyone is still running one of these four machines and planning
to keep updating their kernels, please speak up now so we can adapt
the plans as needed.

If nobody is found using StrongARM1100 any more, it can be removing
during 2025, leaving 6.12-LTS as the last longterm support kernel
for it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-sa1100/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-sa1100/Kconfig b/arch/arm/mach-sa1100/Kconfig
index 0fb4c24cfad5..f3fa215fd254 100644
--- a/arch/arm/mach-sa1100/Kconfig
+++ b/arch/arm/mach-sa1100/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 menuconfig ARCH_SA1100
-	bool "SA11x0 Implementations"
+	bool "SA11x0 Implementations (DEPRECATED)"
 	depends on ARCH_MULTI_V4 && !(ARCH_MULTI_V4T || ARCH_MULTI_V5)
 	depends on !(ARCH_MOXART || ARCH_GEMINI)
 	depends on ATAGS
@@ -19,6 +19,9 @@ menuconfig ARCH_SA1100
 	help
 	  Support for StrongARM 11x0 based boards.
 
+	  Support for these machines will go away in 2025,
+	  unless there are any remaining users that speak up.
+
 if ARCH_SA1100
 
 config SA1100_ASSABET
-- 
2.39.5


