Return-Path: <linux-kernel+bounces-236312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFA691E04E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C3431C222AB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 13:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185E815E5CA;
	Mon,  1 Jul 2024 13:10:58 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452DA15A87F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 13:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719839457; cv=none; b=G7+rpXfx87niWi8udNGDcTJLsN99m7pHgsq7ZzZgyR69cQ9WXHUMIYaDP+xgXo81LWlgHuwohWcaO2EzXX6ysZ1RUG43SR3uJJnalBQWIW5ZabpIwhMlPL2VQWmrRegaXF09OTV4l4zPKpYAOsgTHOzxHCh3yGY8UzX+YIcJ4E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719839457; c=relaxed/simple;
	bh=iskkNq6E6ot5mUfN86qp2Up0IGT2AaR+xVM++jdVpjs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MMOIRy1GFjb16MdDqhxDM93IpyH7+v4bvR+IJE05zpsD7z8okUe6i1rkS20W6spBKkSaPxw5fMUt4Ell+yKyaItUvi37F6mtjPlfwR5xcK6xVhgkzeMWUXYZW7lvn4MOQ1vA8B7EIs8+QLns5t/eTh9F+ODwOXSyI0ehARxMGiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <m.felsch@pengutronix.de>)
	id 1sOGnu-0006DR-D3; Mon, 01 Jul 2024 15:10:46 +0200
From: Marco Felsch <m.felsch@pengutronix.de>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch
Cc: kernel@pengutronix.de,
	Rouven Czerwinski <r.czerwinski@pengutronix.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drm/panel: simple: Add Jiangsu Smartwin SMMT043480272A-A19 panel
Date: Mon,  1 Jul 2024 15:10:40 +0200
Message-Id: <20240701131041.2816856-2-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240701131041.2816856-1-m.felsch@pengutronix.de>
References: <20240701131041.2816856-1-m.felsch@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

From: Rouven Czerwinski <r.czerwinski@pengutronix.de>

Add support for the Jiangsu Smartwin SMMT043480272A-A19 4.3" 480x272
TFT-LCD panel. The timings are based on the ILI6485 controller IC
datasheet.

Signed-off-by: Rouven Czerwinski <r.czerwinski@pengutronix.de>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
Changelog:
v2:
- rebased ontop of drm-misc-next
- added Neil's reviewed-by

 drivers/gpu/drm/panel/panel-simple.c | 32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 4a3264130ddc..ee4b29077975 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2729,6 +2729,35 @@ static const struct panel_desc innolux_zj070na_01p = {
 	},
 };
 
+static const struct display_timing jiangsu_smartwin_smmt043480272a_a19_timing = {
+	.pixelclock = { 8000000, 9000000, 12000000 },
+	.hactive = { 480, 480, 480 },
+	.hback_porch = { 1, 43, 43 },
+	.hfront_porch = { 4, 8, 75 },
+	.hsync_len = { 2, 4, 75 },
+	.vactive = { 272, 272, 272 },
+	.vback_porch = { 2, 12, 12 },
+	.vfront_porch = { 2, 8, 37 },
+	.vsync_len = { 2, 4, 37 },
+	.flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
+		 DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_POSEDGE |
+		 DISPLAY_FLAGS_SYNC_POSEDGE,
+};
+
+static const struct panel_desc jiangsu_smartwin_smmt043480272a_a19 = {
+	.timings = &jiangsu_smartwin_smmt043480272a_a19_timing,
+	.num_timings = 1,
+	.bpc = 8,
+	.size = {
+		.width = 95,
+		.height = 54,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH |
+		     DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE |
+		     DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE,
+};
+
 static const struct display_timing koe_tx14d24vm1bpa_timing = {
 	.pixelclock = { 5580000, 5850000, 6200000 },
 	.hactive = { 320, 320, 320 },
@@ -4752,6 +4781,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "innolux,zj070na-01p",
 		.data = &innolux_zj070na_01p,
+	}, {
+		.compatible = "jianda,smmt043480272a-a19",
+		.data = &jiangsu_smartwin_smmt043480272a_a19,
 	}, {
 		.compatible = "koe,tx14d24vm1bpa",
 		.data = &koe_tx14d24vm1bpa,
-- 
2.39.2


