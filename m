Return-Path: <linux-kernel+bounces-414450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7AE9D282B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 15:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F561F2229D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 14:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E41E1CEAC0;
	Tue, 19 Nov 2024 14:29:51 +0000 (UTC)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B7E1CCB37
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 14:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.101.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732026591; cv=none; b=kNyxc1h4+e7+BSbLN5VOaxTqcXYu5W3OPd7DQxlZJwHn7vRhcBKYHXEHilUj3fb6SJQY0Tnxkp7T3tfHTyJ2Zp88BrKmX0XHHa8DHcGKIJOF01buRARahGBPQeFOOmJeSVpH9vG6VmZeu1FYL8h5yvTWW1aMZgYEEnP3ZENdU1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732026591; c=relaxed/simple;
	bh=Xc33Op179Wdt4ld76d8fpmfb6NVFfpXurSoopZYeMQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZrcTBgzfQw+01vh5lAtHC7ye9CISrBPlzadvt891vTE552IE6zI/h+Ad0rwGspCaTCnQfvdm+/qcKFTpgncgEFyPxcErAdbjgwcTqucwRK452DBoltmMaj8GYaVxi0wDnp0kkfxGSQlhxc8S1vKrUweXEYoGjh69k13iSj62Dhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io; spf=pass smtp.mailfrom=sys-base.io; arc=none smtp.client-ip=185.233.101.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
	by leonov.paulk.fr (Postfix) with ESMTPS id B5DA41F00053
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 14:20:00 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
	id C89E1A4700C; Tue, 19 Nov 2024 14:08:12 +0000 (UTC)
X-Spam-Level: *
Received: from localhost.localdomain (unknown [192.168.1.64])
	by laika.paulk.fr (Postfix) with ESMTP id 78E00A47001;
	Tue, 19 Nov 2024 14:08:06 +0000 (UTC)
From: Paul Kocialkowski <paulk@sys-base.io>
To: linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH] pinctrl: sunxi: Use minimal debouncing period as default
Date: Tue, 19 Nov 2024 15:08:05 +0100
Message-ID: <20241119140805.3345412-1-paulk@sys-base.io>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Kocialkowski <contact@paulk.fr>

The sunxi external interrupts (available from GPIO pins) come with a
built-in debouncing mechanism that cannot be disabled. It can be
configured to use either the low-frequency oscillator (32 KHz) or the
high-frequency oscillator (24 MHz), with a pre-scaler.

The pinctrl code supports an input-debounce device-tree property to set
a specific debouncing period and choose which clock source is most
relevant. However the property is specified in microseconds, which is
longer than the minimal period achievable from the high-frequency
oscillator without a pre-scaler.

When the property is missing, the reset configuration is kept, which
selects the low-frequency oscillator without pre-scaling. This severely
limits the possible interrupt periods that can be detected.

Instead of keeping this default, use the minimal debouncing period from
the high-frequency oscillator without a pre-scaler to allow the largest
possible range of interrupt periods.

This issue was encountered with a peripheral that generates active-low
interrupts for 1 us. No interrupt was detected with the default setup,
while it is now correctly detected with this change.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 drivers/pinctrl/sunxi/pinctrl-sunxi.c | 49 ++++++++++++++++-----------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index 73bcf806af0e..06c650d97645 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -1416,6 +1416,7 @@ static int sunxi_pinctrl_setup_debounce(struct sunxi_pinctrl *pctl,
 	unsigned int hosc_diff, losc_diff;
 	unsigned int hosc_div, losc_div;
 	struct clk *hosc, *losc;
+	bool debounce_minimal = false;
 	u8 div, src;
 	int i, ret;
 
@@ -1423,9 +1424,9 @@ static int sunxi_pinctrl_setup_debounce(struct sunxi_pinctrl *pctl,
 	if (of_clk_get_parent_count(node) != 3)
 		return 0;
 
-	/* If we don't have any setup, bail out */
+	/* If we don't have any setup, use minimal debouncing. */
 	if (!of_property_present(node, "input-debounce"))
-		return 0;
+		debounce_minimal = true;
 
 	losc = devm_clk_get(pctl->dev, "losc");
 	if (IS_ERR(losc))
@@ -1439,29 +1440,37 @@ static int sunxi_pinctrl_setup_debounce(struct sunxi_pinctrl *pctl,
 		unsigned long debounce_freq;
 		u32 debounce;
 
-		ret = of_property_read_u32_index(node, "input-debounce",
-						 i, &debounce);
-		if (ret)
-			return ret;
+		if (!debounce_minimal) {
+			ret = of_property_read_u32_index(node, "input-debounce",
+							 i, &debounce);
+			if (ret)
+				return ret;
 
-		if (!debounce)
-			continue;
+			if (!debounce)
+				continue;
 
-		debounce_freq = DIV_ROUND_CLOSEST(USEC_PER_SEC, debounce);
-		losc_div = sunxi_pinctrl_get_debounce_div(losc,
-							  debounce_freq,
-							  &losc_diff);
+			debounce_freq = DIV_ROUND_CLOSEST(USEC_PER_SEC,
+							  debounce);
 
-		hosc_div = sunxi_pinctrl_get_debounce_div(hosc,
-							  debounce_freq,
-							  &hosc_diff);
+			losc_div = sunxi_pinctrl_get_debounce_div(losc,
+								  debounce_freq,
+								  &losc_diff);
 
-		if (hosc_diff < losc_diff) {
-			div = hosc_div;
-			src = 1;
+			hosc_div = sunxi_pinctrl_get_debounce_div(hosc,
+								  debounce_freq,
+								  &hosc_diff);
+
+			if (hosc_diff < losc_diff) {
+				div = hosc_div;
+				src = 1;
+			} else {
+				div = losc_div;
+				src = 0;
+			}
 		} else {
-			div = losc_div;
-			src = 0;
+			/* Achieve minimal debouncing using undivided hosc. */
+			div = 0;
+			src = 1;
 		}
 
 		writel(src | div << 4,
-- 
2.47.0


