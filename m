Return-Path: <linux-kernel+bounces-430944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 402EC9E3773
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CCFD168835
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050EE1B3930;
	Wed,  4 Dec 2024 10:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lliecmit"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F8D1B21AB
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308198; cv=none; b=SxywyXXQUhH80DNRhwlXlQKszYQA6EqNB+MsZu0S22e/oAU5beWh1xixyTbkO7ehyGVG/ppOQYjEyhRFJjx97tHky44oXeS+ZNB/NU9o5MF8oQTUhGPNuwYS1iNJ4QF1dJ+GKC8lGxHnTaYFpnyV00RqPGundcxXN57aUnz/nZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308198; c=relaxed/simple;
	bh=8LBdUUpx/FRHg8VDxMOB3poMFcg37/aar7nw5/8IvY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UVWoFBSXnlPZVyVGp7dQs9FL0q8xce3wx8PT3he0VKgv//4myR2K5ocuI7+OP8q5AkeuOA3SuIx7KeN2JS8wQL5HiihbFLO8Zn1tDjbdNvJW6VfRVufDA9LQ8+dEKDX3wR4RbTAT1GpZKPstoBAF6ryXGkktqmnCmkWU4Dq5Jqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lliecmit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1588C4CED6;
	Wed,  4 Dec 2024 10:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733308197;
	bh=8LBdUUpx/FRHg8VDxMOB3poMFcg37/aar7nw5/8IvY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lliecmitigPo/h/BYBh44zrRAsn86P8Za2KThMCS+8Q3nk6O7p9m3s1HQullUA5QI
	 H1eFE4+ef3TyQQ/9f4RKNuxBuDWw4UvC1CRJaIySmEKHb7iAx//VdCjV4PkJ8/JtKn
	 ZRN4Ri/fE4liCTzHKzcuVIZYkC98foP4hD9XWWNndedHcoJeJIgZozhuvKv6oBJ0mU
	 2NRV2QQyFSeJcZpWpYb8tTh4iGbeNL8saXbOq9vElyV/GhiFTf0mYgS7CJolKMPTnx
	 9gv47JylwWbJv25Mad5+I1Q+mHjMIo7buuFtjWoHoy/U3SgBBb5qJkPlgOsucTxfVF
	 wYSOEeWYtN58w==
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
Subject: [PATCH 06/15] ARM: update DEPRECATED_PARAM_STRUCT removal timeline
Date: Wed,  4 Dec 2024 11:28:55 +0100
Message-Id: <20241204102904.1863796-7-arnd@kernel.org>
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

This configuration option is for the older boot method that preceeded
ATAGS. This was scheduled for removal back in 2001, but the removal
never happened, presumably because nobody cared enough to actually do it,
not because there are any users left.

Add "(DEPRECATED)' to the Kconfig line and update the timeline so we can
remove it next year along with the other options that are not scheduled
for that timeframe.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2167f71f184b..5278764162f8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1411,11 +1411,11 @@ config ATAGS
 	  it is either converted to DT or removed.
 
 config DEPRECATED_PARAM_STRUCT
-	bool "Provide old way to pass kernel parameters"
+	bool "Provide old way to pass kernel parameters (DEPRECATED)"
 	depends on ATAGS
 	help
 	  This was deprecated in 2001 and announced to live on for 5 years.
-	  Some old boot loaders still use this way.
+	  It is now scheduled for removal in early 2025.
 
 # Compressed boot loader in ROM.  Yes, we really want to ask about
 # TEXT and BSS so we preserve their values in the config files.
-- 
2.39.5


