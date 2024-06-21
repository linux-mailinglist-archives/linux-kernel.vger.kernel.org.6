Return-Path: <linux-kernel+bounces-224988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 631BA91299F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 955371C20757
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 15:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296E17404F;
	Fri, 21 Jun 2024 15:28:19 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25D42C859
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 15:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718983698; cv=none; b=qTl5hGJZra1J6J7cwO54n6VbSiYVYc8tnnJDvk9iEvGBni+7yIjuS17YHpx/+L6SFarqX4gN9vPBw7llcL0jwR/iKrYOHiSk+an1m6sDpViKkZhss815XMJgiVJJMbaMKV2jjJbL7XsDXBX20tvAZ7/G05ndkXs7FrzZxdvmaD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718983698; c=relaxed/simple;
	bh=sWRhhbzQS+Ugekl85FoGF938kGaJ7/ujk4zT/j7CXng=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=h2cQtAmIWYpiIIArJfeYSKI2O6j0J/u1Y2ApAZl31DhtGVYy5uOVEOFpisPobNeyizAtD0GoJYsOfkH8F8OohiJd5RoqA3mBHl+h3zge9dlOaCRtbEBUexh6zv9U3AVXP7UTkjxzT+yqQBM7NpXocjJr/1Yn6V2+bAM7Lpb+hFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sKgBR-0000A9-Ek; Fri, 21 Jun 2024 17:28:13 +0200
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Fri, 21 Jun 2024 17:28:12 +0200
Subject: [PATCH] reset: meson-audio-arb: Use devm_clk_get_enabled()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-reset-devm-clk-get-enabled-v1-1-8408c7962b6c@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAAucdWYC/x3MQQqDMBAF0KvIrDtgpuKiV5EuNPOjgzaWpARBv
 HuDy7d5J2UkQ6ZXc1JCsWx7rHCPhvwyxhlsWk3SStf24jgh48eK8mG/rTxXII7TBmXV8Jx6FyB
 eqAbfhGDHnQ/v6/oD0qZ/zWwAAAA=
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, kernel@pengutronix.de, 
 Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.14-dev
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Use devm_clk_get_enabled() to reduce a bit of boilerplate and to
disable the clock in case devm_reset_controller_register() fails.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/reset-meson-audio-arb.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/reset/reset-meson-audio-arb.c b/drivers/reset/reset-meson-audio-arb.c
index 7891d52fa899..894ad9d37a66 100644
--- a/drivers/reset/reset-meson-audio-arb.c
+++ b/drivers/reset/reset-meson-audio-arb.c
@@ -129,8 +129,6 @@ static int meson_audio_arb_remove(struct platform_device *pdev)
 	writel(0, arb->regs);
 	spin_unlock(&arb->lock);
 
-	clk_disable_unprepare(arb->clk);
-
 	return 0;
 }
 
@@ -150,7 +148,7 @@ static int meson_audio_arb_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, arb);
 
-	arb->clk = devm_clk_get(dev, NULL);
+	arb->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(arb->clk))
 		return dev_err_probe(dev, PTR_ERR(arb->clk), "failed to get clock\n");
 
@@ -170,11 +168,6 @@ static int meson_audio_arb_probe(struct platform_device *pdev)
 	 * In the initial state, all memory interfaces are disabled
 	 * and the general bit is on
 	 */
-	ret = clk_prepare_enable(arb->clk);
-	if (ret) {
-		dev_err(dev, "failed to enable arb clock\n");
-		return ret;
-	}
 	writel(BIT(ARB_GENERAL_BIT), arb->regs);
 
 	/* Register reset controller */

---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240621-reset-devm-clk-get-enabled-ddf3b61fe2c2

Best regards,
-- 
Philipp Zabel <p.zabel@pengutronix.de>


