Return-Path: <linux-kernel+bounces-512819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8505A33E12
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 12:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5635D188D4F5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 11:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFFD227E97;
	Thu, 13 Feb 2025 11:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="UqyeZ25X"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47ADE227E90
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 11:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739446091; cv=none; b=K+y0Ff9JwN5j/mq9l8jMaQrPOKUGhFr3cDoAIaOPAPagfEmrn0o7Px/m3eqLCuCOTsq2lj6i3xA563n/wdTd6x2RX6W5t8gZrcRFfgGzcEFsXUCzxV8Cs8PWKUU/HdNRYRSoUt/eS9W1sF2BEVU+SIBVFnH0VeVyFARE/ZpfmyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739446091; c=relaxed/simple;
	bh=X2bmPGoKkHuDg8cYWq8SnBf/6/7pmLUfnDFqPHvOZ0g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BDTN6ttImAUFQpHEfzIp9AB1tO8xwsuR7hcLol7sTaipY+L/17Ghem6e02j5xwaNQyIo7VEzHTMJ+y99EadEsaqCOzdxnRrZpH9m9fnYPDbNWpoQldyn19dJuxzNEizlm2Y7FK1D5WCRLiqqLyWXtXM3+OVJRsQG4qSZodeXNQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=UqyeZ25X; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from ldvnode.intra.ispras.ru (unknown [10.10.2.153])
	by mail.ispras.ru (Postfix) with ESMTPSA id 6F2844226E07;
	Thu, 13 Feb 2025 11:28:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 6F2844226E07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1739446086;
	bh=NBjVF3pUP7QFgRHJmaW5T9LW35eN83jOLIfzLRGqYek=;
	h=From:To:Cc:Subject:Date:From;
	b=UqyeZ25XgLnLDnU5lA+jWmuz+QkDotd96ydS7w70fCrpO/g+S12Xa9WCDAYTGQesA
	 tYVmO3BlIuIIDN8KBWLT+6gwiiB4rA7MHRldSmA67QOjJJg6hYg8J2zwJAfxb6/VAy
	 GsBKn00KMHboRsy4ofbrv7A9RhbIGZYc4gCbKgSU=
From: Vitalii Mordan <mordan@ispras.ru>
To: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Vitalii Mordan <mordan@ispras.ru>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Aleksandr Mishin <amishin@t-argos.ru>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	Jyri Sarha <jsarha@ti.com>,
	Quentin Schulz <quentin.schulz@free-electrons.com>,
	Swapnil Jakhade <sjakhade@cadence.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Vadim Mutilin <mutilin@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: [PATCH v2] gpu: cdns-mhdp8546: fix call balance of mhdp->clk handling routines
Date: Thu, 13 Feb 2025 14:28:01 +0300
Message-Id: <20250213112801.1611525-1-mordan@ispras.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the clock mhdp->clk was not enabled in cdns_mhdp_probe(), it should not
be disabled in any path.

Use the devm_clk_get_enabled() helper function to ensure proper call
balance for mhdp->clk.

Found by Linux Verification Center (linuxtesting.org) with Klever.

Fixes: fb43aa0acdfd ("drm: bridge: Add support for Cadence MHDP8546 DPI/DP bridge")
Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
---
v2: Use devm_clk_get_enabled() helper function, as per Dmitry Baryshkov's
request.

 drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
index d081850e3c03..d4e4f484cbe5 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
@@ -2463,9 +2463,9 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
 	if (!mhdp)
 		return -ENOMEM;
 
-	clk = devm_clk_get(dev, NULL);
+	clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(clk)) {
-		dev_err(dev, "couldn't get clk: %ld\n", PTR_ERR(clk));
+		dev_err(dev, "couldn't get and enable clk: %ld\n", PTR_ERR(clk));
 		return PTR_ERR(clk);
 	}
 
@@ -2504,14 +2504,12 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
 
 	mhdp->info = of_device_get_match_data(dev);
 
-	clk_prepare_enable(clk);
-
 	pm_runtime_enable(dev);
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
 		dev_err(dev, "pm_runtime_resume_and_get failed\n");
 		pm_runtime_disable(dev);
-		goto clk_disable;
+		return ret;
 	}
 
 	if (mhdp->info && mhdp->info->ops && mhdp->info->ops->init) {
@@ -2590,8 +2588,6 @@ static int cdns_mhdp_probe(struct platform_device *pdev)
 runtime_put:
 	pm_runtime_put_sync(dev);
 	pm_runtime_disable(dev);
-clk_disable:
-	clk_disable_unprepare(mhdp->clk);
 
 	return ret;
 }
@@ -2632,8 +2628,6 @@ static void cdns_mhdp_remove(struct platform_device *pdev)
 	cancel_work_sync(&mhdp->modeset_retry_work);
 	flush_work(&mhdp->hpd_work);
 	/* Ignoring mhdp->hdcp.check_work and mhdp->hdcp.prop_work here. */
-
-	clk_disable_unprepare(mhdp->clk);
 }
 
 static const struct of_device_id mhdp_ids[] = {
-- 
2.25.1


