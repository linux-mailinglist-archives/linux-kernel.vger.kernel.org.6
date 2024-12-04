Return-Path: <linux-kernel+bounces-430945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B88689E37BF
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F08CB2F324
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E92C1B412E;
	Wed,  4 Dec 2024 10:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URqp8wVv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6BE1B3945
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308202; cv=none; b=H4k3aV+ywAdyFlKmmP85v3+IECX+ovqdMLXPJdFLjoEbaWdSasSA6bu3x2wP74wHnuhRQ8z17IZuQdsYoHRd+2Wg2XrqKqWABD0bwkE0bA7SOBmw8/Ow/F3/f58Omy4ZCwlh3V6bBD9qJjLVG62aTXh4CvNFb3DPa6Hv5sNdE1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308202; c=relaxed/simple;
	bh=Ig2MTPjDp9GtEzGfz9dtsom3kAntHGBlM9IrrVuvXdc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P6uJoHXHOPywYV1J+BA5jzO0EsMH/vEEBTWs+tyZbuUudAlJpUli0h1G2vVQmRwS9cFExHUVngV9vZER3M5JqjrclE0KHtphxrxRGZzauRnwWjLWCkVqVr2Uvgqcb/vPgDFX7+CGriMQ9mb/1ivlzdFOE5dOPSCc9yaZ6Zf88ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URqp8wVv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF21C4CEE0;
	Wed,  4 Dec 2024 10:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733308202;
	bh=Ig2MTPjDp9GtEzGfz9dtsom3kAntHGBlM9IrrVuvXdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=URqp8wVvZcoXJOlb/brM0MYh2hDT0FQYKcI+tyDyEkX7B5AEVaUhkpxyxUH8PjAsU
	 R+BvTnMECQZx+QrYvVo0GaJYlbAYilUNZyLDbYbFTbvuQifMkHQpEWhc9lO2mXuz4X
	 DqEtNOsZFbrHZZTt5s2ulDbYLr6qcUxUjr8RyzSzzMBBH8Bx/3/s+wJKonYvYwlrym
	 Mb3O43atYmd0f9TswTPfSd2L4aGiyG78Ji3rJ3aNOGThevGlecIpjyHB+FBYSq3qgx
	 /x96F1ZCFwgJbF1cTzk8dcFLx4cwUySoK0ffkfWEFy2MzqHw+wVOWb2rpp9KI0I7bw
	 C2sY3lnRm0OfQ==
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
Subject: [PATCH 07/15] ARM: s3c64xx: extend deprecation schedule
Date: Wed,  4 Dec 2024 11:28:56 +0100
Message-Id: <20241204102904.1863796-8-arnd@kernel.org>
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

Mark Brown is still using this machine for regular work, so it should
not be removed as originally scheduled.

Give the platform another year, with the option to extend it further
based on the state of ATAGS support next year.

I expect that we end up removing all of s3c64xx when either Mark has
moved his test setup to other hardware, or when all other ATAGS based
machines are getting removed.

Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s3c/Kconfig.s3c64xx | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s3c/Kconfig.s3c64xx b/arch/arm/mach-s3c/Kconfig.s3c64xx
index 8f40af063ad6..3120a40ef102 100644
--- a/arch/arm/mach-s3c/Kconfig.s3c64xx
+++ b/arch/arm/mach-s3c/Kconfig.s3c64xx
@@ -23,10 +23,17 @@ menuconfig ARCH_S3C64XX
 	help
 	  Samsung S3C64XX series based systems
 
-	  The platform is deprecated and scheduled for removal. Please reach to
-	  the maintainers of the platform and linux-samsung-soc@vger.kernel.org if
-	  you still use it.
-	  Without such feedback, the platform will be removed after 2024.
+	  The use of ATAGS based board files is on its way out, and
+	  the only remaining S3C64xx machine in the kernel (Wolfson
+	  Cragganmore 6410) relies on this, without any realistic way
+	  to migrate it to devicetree.
+
+	  Support for S3C64XX will be kept until the 2025 LTS kernel
+	  release and may be removed in early 2026.
+
+	  Please reach out to the maintainers of the platform and
+	  linux-samsung-soc@vger.kernel.org if you use any additional
+	  s3c64xx machines based on devicetree.
 
 if ARCH_S3C64XX
 
-- 
2.39.5


