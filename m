Return-Path: <linux-kernel+bounces-271238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B515E944B69
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E55B91C24B03
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA8B1A01C6;
	Thu,  1 Aug 2024 12:34:11 +0000 (UTC)
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34E01A00FF;
	Thu,  1 Aug 2024 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515651; cv=none; b=Zc0d8vxSiQz0Ch9LPXCgWnuCVA709QP/xJ7uydkQAO+BB2egH6fHBTXw9gVnN5jql/Lw9ZphncmAdiyidWPtX4LvJDaVl34OaQqqoxGHwnI5S67W+xaHW/4Fr6ddlD2JR/v3uBtkXxAuU0KWrz2HMisnwvg0VXhhzhvgR2hJOXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515651; c=relaxed/simple;
	bh=GO1DNXLAxTGpiXqICxbOvHwvsT/RQZKA4vGlrgQvLvI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HhFRS75Tzv/d8LpAT2lhpSuYSjMuR9HGtH1O4nJfkwpzYdq4rteEzd0THyfsDR5xSMkhqm9/JmSeJ6kJL/2DPxBGwHH8cZwVwUiL1ZZmzXW+oAvCw8tR6wd+jlZKjsEol7MzAFJQyVdkmeg784Dvn6mrJbZHqDP8c4cJDDrisxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from W388ANL.actianordic.se (10.12.12.26) by S035ANL.actianordic.se
 (10.12.31.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 Aug
 2024 14:18:56 +0200
From: Jonas Blixt <jonas.blixt@actia.se>
To: <wim@linux-watchdog.org>, <linux@roeck-us.net>, <shawnguo@kernel.org>,
	<s.hauer@pengutronix.de>, <kernel@pengutronix.de>, <festevam@gmail.com>,
	<linux-watchdog@vger.kernel.org>, <imx@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: <john.ernberg@actia.se>, Jonas Blixt <jonas.blixt@actia.se>, Anson Huang
	<anson.huang@nxp.com>
Subject: [PATCH] watchdog: imx_sc_wdt: Don't disable WDT in suspend
Date: Thu, 1 Aug 2024 14:18:45 +0200
Message-ID: <20240801121845.1465765-1-jonas.blixt@actia.se>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EsetResult: clean, is OK
X-EsetId: 37303A2956B14454667063

Parts of the suspend and resume chain is left unprotected if we disable
the WDT here.

From experiments we can see that the SCU disables and re-enables the WDT
when we enter and leave suspend to ram. By not touching the WDT here we
are protected by the WDT all the way to the SCU.

CC: Anson Huang <anson.huang@nxp.com>
Fixes: 986857acbc9a ("watchdog: imx_sc: Add i.MX system controller watchdog support")
Signed-off-by: Jonas Blixt <jonas.blixt@actia.se>
---
 drivers/watchdog/imx_sc_wdt.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/watchdog/imx_sc_wdt.c b/drivers/watchdog/imx_sc_wdt.c
index e51fe1b78518..d73076b686d8 100644
--- a/drivers/watchdog/imx_sc_wdt.c
+++ b/drivers/watchdog/imx_sc_wdt.c
@@ -216,29 +216,6 @@ static int imx_sc_wdt_probe(struct platform_device *pdev)
 	return devm_watchdog_register_device(dev, wdog);
 }
 
-static int __maybe_unused imx_sc_wdt_suspend(struct device *dev)
-{
-	struct imx_sc_wdt_device *imx_sc_wdd = dev_get_drvdata(dev);
-
-	if (watchdog_active(&imx_sc_wdd->wdd))
-		imx_sc_wdt_stop(&imx_sc_wdd->wdd);
-
-	return 0;
-}
-
-static int __maybe_unused imx_sc_wdt_resume(struct device *dev)
-{
-	struct imx_sc_wdt_device *imx_sc_wdd = dev_get_drvdata(dev);
-
-	if (watchdog_active(&imx_sc_wdd->wdd))
-		imx_sc_wdt_start(&imx_sc_wdd->wdd);
-
-	return 0;
-}
-
-static SIMPLE_DEV_PM_OPS(imx_sc_wdt_pm_ops,
-			 imx_sc_wdt_suspend, imx_sc_wdt_resume);
-
 static const struct of_device_id imx_sc_wdt_dt_ids[] = {
 	{ .compatible = "fsl,imx-sc-wdt", },
 	{ /* sentinel */ }
@@ -250,7 +227,6 @@ static struct platform_driver imx_sc_wdt_driver = {
 	.driver		= {
 		.name	= "imx-sc-wdt",
 		.of_match_table = imx_sc_wdt_dt_ids,
-		.pm	= &imx_sc_wdt_pm_ops,
 	},
 };
 module_platform_driver(imx_sc_wdt_driver);
-- 
2.34.1


