Return-Path: <linux-kernel+bounces-430946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2159E3774
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B218168BB0
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B641D1B3931;
	Wed,  4 Dec 2024 10:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQfnRHb0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CAC11B4126
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308207; cv=none; b=DxdLQCDNCogqBk0csUsVTKXIydVtnBAznnJRBwNT5W3QB6UGGOkTzvSbjih7WTsVD0KPWXUPwZzgTEG0wae4VhIHag8FI11T/TRd6zRhF1OhA1OQqlwIjE+B1KxcQ9WAYlOrGZrv+X9ogqlM6e7pV5rPj36CKeqHlZB6VEndneQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308207; c=relaxed/simple;
	bh=YkbOGSzICrZiR+4fHhpecKjehdpXOnctJBrLxxFsimY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C2H4ZWFOHKt7Kzmh09PBRjpQDzqUAEKfGyPQaNoWdmWVnUVPHWUO30UzUpi+hUQis2FKmCPM5Rf5AvXXNFBH8DaqrU3A4hURxQduTZElSnpbnfZVzlKnlhM5e6TNhfgx0MkMfhgkYXZFBNfUXMBTYofaqwbfe2Eb3yvzfGbGEuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQfnRHb0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB04C4CED6;
	Wed,  4 Dec 2024 10:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733308206;
	bh=YkbOGSzICrZiR+4fHhpecKjehdpXOnctJBrLxxFsimY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CQfnRHb0g7Q2z22aBdhfz3xK93jft7nmq9SDrBId79yDhfUqGwMCXaI/TGjS2kNOf
	 yIiDq36ob2rdhpFtENjXW3Olkirzz8fweFp/Th0sYvnVK5DRXZLEZeg5FD/ygz7Ax7
	 /+oGcbhuqg5clF7nPmWzkLG0jzX/Me7FRjPE30dRHnv84lnrKngwuuslGF8oXFFo7F
	 irTLNhwvAHOmiNMbZp/MUEbWLu+tzd4kQxjwshqqfY46uNG6O9USGb+k/xAqm5fOmY
	 9t9l2/2B6yhLs4BIASw7ysz2MMfJuBNM5FMWHV7Fn7lJGAUjsIndY+M7xF7ZkTN/gg
	 U8vOFUCBQDVvQ==
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
Subject: [PATCH 08/15] ARM: update FPE_NWFPE help text
Date: Wed,  4 Dec 2024 11:28:57 +0100
Message-Id: <20241204102904.1863796-9-arnd@kernel.org>
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

The help text is seriously outdated and predates the introduction of
VFP floating point units that were available as early as some ARM926
based systems.

Change the help text to reflect that this is now a legacy feature
and that it will go away along with OABI support in the future.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5278764162f8..d92531c3f982 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1661,16 +1661,16 @@ menu "Floating point emulation"
 comment "At least one emulation must be selected"
 
 config FPE_NWFPE
-	bool "NWFPE math emulation"
+	bool "NWFPE math emulation (DEPRECATED)"
 	depends on (!AEABI || OABI_COMPAT) && !THUMB2_KERNEL
 	help
 	  Say Y to include the NWFPE floating point emulator in the kernel.
-	  This is necessary to run most binaries. Linux does not currently
-	  support floating point hardware so you need to say Y here even if
-	  your machine has an FPA or floating point co-processor podule.
 
-	  You may say N here if you are going to load the Acorn FPEmulator
-	  early in the bootup.
+	  This is only used on OABI userspace binaries, either using a
+	  pure OABI (!CONFIG_AEABI) kernel, or the OABI emulation.
+
+	  Support for NWFPE will be removed in the future when OABI
+	  support is removed.
 
 config FPE_NWFPE_XP
 	bool "Support extended precision"
-- 
2.39.5


