Return-Path: <linux-kernel+bounces-339429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E5C9864F7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 18:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0190F285625
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 16:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FCA446DC;
	Wed, 25 Sep 2024 16:40:24 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8B0D520
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 16:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727282424; cv=none; b=jaNdK8JOgw8f5Ko5nNl/iyEW8skgXzndmk2RVK4+PSI/U1fZiz/vCmNL6GTNCGziy2/uk5/zeSjo3sLym/715azZdeVwiLw+hpUnxTFOxcHHa+jHoNZBQrOfYS/z7YQj4OejJk509neZC4d9ywLfhxHgqToi77Ih7z5AD2ZalV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727282424; c=relaxed/simple;
	bh=XJLI1q11MCzwrfN28X1pUSiRSb6Pv4ZsimpDyNVdQMo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jqqVupcK/7zMPEEbL99BYN5sCEaCQRhUi2lAmSILf1zf2+1lp39yVnhLVLUrNwDnrnpyQYg2TPSk8CV0zfeVSis6J1J4gajaF7huVC9kGKf7ZZ/EKcPvVx7KWymPYbnzJ5unk3GznL77eJWNg+OfLi26iJJYNSJV5WLM1SZ09hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude05.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::54])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1stV3r-00046t-NX; Wed, 25 Sep 2024 18:40:19 +0200
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Wed, 25 Sep 2024 18:40:11 +0200
Subject: [PATCH v2 3/3] reset: uniphier-glue: Use
 devm_reset_control_bulk_get_shared_deasserted()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240925-reset-get-deasserted-v2-3-b3601bbd0458@pengutronix.de>
References: <20240925-reset-get-deasserted-v2-0-b3601bbd0458@pengutronix.de>
In-Reply-To: <20240925-reset-get-deasserted-v2-0-b3601bbd0458@pengutronix.de>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 kernel@pengutronix.de, Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.15-dev-13183
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::54
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Replace the pattern devm_reset_control_bulk_get_shared() /
reset_control_bulk_deassert() / devm_add_action_or_reset()
with devm_reset_control_bulk_get_shared_deasserted() for
some reduction in boilerplate.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/reset/reset-uniphier-glue.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/reset/reset-uniphier-glue.c b/drivers/reset/reset-uniphier-glue.c
index 5f9f2f7994c0..a2a262bf6bfc 100644
--- a/drivers/reset/reset-uniphier-glue.c
+++ b/drivers/reset/reset-uniphier-glue.c
@@ -35,13 +35,6 @@ static void uniphier_clk_disable(void *_priv)
 	clk_bulk_disable_unprepare(priv->data->nclks, priv->clk);
 }
 
-static void uniphier_rst_assert(void *_priv)
-{
-	struct uniphier_glue_reset_priv *priv = _priv;
-
-	reset_control_bulk_assert(priv->data->nrsts, priv->rst);
-}
-
 static int uniphier_glue_reset_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -68,13 +61,6 @@ static int uniphier_glue_reset_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	for (i = 0; i < priv->data->nrsts; i++)
-		priv->rst[i].id = priv->data->reset_names[i];
-	ret = devm_reset_control_bulk_get_shared(dev, priv->data->nrsts,
-						 priv->rst);
-	if (ret)
-		return ret;
-
 	ret = clk_bulk_prepare_enable(priv->data->nclks, priv->clk);
 	if (ret)
 		return ret;
@@ -83,11 +69,11 @@ static int uniphier_glue_reset_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = reset_control_bulk_deassert(priv->data->nrsts, priv->rst);
-	if (ret)
-		return ret;
-
-	ret = devm_add_action_or_reset(dev, uniphier_rst_assert, priv);
+	for (i = 0; i < priv->data->nrsts; i++)
+		priv->rst[i].id = priv->data->reset_names[i];
+	ret = devm_reset_control_bulk_get_shared_deasserted(dev,
+							    priv->data->nrsts,
+							    priv->rst);
 	if (ret)
 		return ret;
 

-- 
2.39.5


