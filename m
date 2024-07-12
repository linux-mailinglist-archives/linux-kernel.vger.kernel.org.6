Return-Path: <linux-kernel+bounces-250579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB93E92F94D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 13:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4CA2842E2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 11:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1600C15EFB6;
	Fri, 12 Jul 2024 11:06:32 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1E315B0FE
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 11:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720782391; cv=none; b=fT8qF328DFVkSVak9cEHZ3R9N159Vk3Em5+M1OAT3WBiAzbosrEY0GYzgO0qc3ZhD+oRjCZ3bNGq19MG0ZjX6mk+xpeBFdk+3qjhI06LZQ/2AzNVHW7MUIKnWSI8BGepI4W2f19ecno17KaXlpGlPXEpIym0KEj0pfwjHW9ZdBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720782391; c=relaxed/simple;
	bh=g4uP4CxsmKsMmenuSS5tDFw5yfa9qRjUkj4Fq44ze2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=of4zPj/a+q8YgkimfVEBxs5HxCjVAdR3qzPzYtDoiqw9jfixykgMwQeIOKZ6T/MvQLC1ZtGpwol/El5YRzEoUUQvKNAn3T+W7/oAB8azFzWFNNoBvJBr2E9bEfnpPW70/emBJXkRpbCFZoDFqZ116D0EOEHm9hVil1qSual9UFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1sSE6H-0001hW-0H; Fri, 12 Jul 2024 13:06:05 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Fri, 12 Jul 2024 13:05:56 +0200
Subject: [PATCH 2/2] drm/panel: simple: add Innolux G070ACE-LH3 LVDS
 display support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240712-b4-v6-10-topic-innolux-v1-2-bb0acf273d0d@pengutronix.de>
References: <20240712-b4-v6-10-topic-innolux-v1-0-bb0acf273d0d@pengutronix.de>
In-Reply-To: <20240712-b4-v6-10-topic-innolux-v1-0-bb0acf273d0d@pengutronix.de>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>, 
 kernel@pengutronix.de
X-Mailer: b4 0.14.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The G070ACE-LH3 is a 7" TFT Color LCD module with WLED backlight.

https://www.data-modul.com/sites/default/files/products/G070ACE-LH3-specification-12058417.pdf

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/gpu/drm/panel/panel-simple.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index dcb6d0b6ced06..d3ce78643fd86 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2509,6 +2509,38 @@ static const struct panel_desc innolux_g070y2_l01 = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
+static const struct display_timing innolux_g070ace_lh3_timing = {
+	.pixelclock = { 25200000, 25400000, 35700000 },
+	.hactive = { 800, 800, 800 },
+	.hfront_porch = { 32, 32, 32 },
+	.hback_porch = { 31, 31, 31 },
+	.hsync_len = { 1, 1, 1 },
+	.vactive = { 480, 480, 480 },
+	.vfront_porch = { 5, 5, 5 },
+	.vback_porch = { 4, 4, 4 },
+	.vsync_len = { 1, 1, 1 },
+	.flags = DISPLAY_FLAGS_DE_HIGH,
+};
+
+static const struct panel_desc innolux_g070ace_lh3 = {
+	.timings = &innolux_g070ace_lh3_timing,
+	.num_timings = 1,
+	.bpc = 8,
+	.size = {
+		.width = 152,
+		.height = 91,
+	},
+	.delay = {
+		.prepare = 10,
+		.enable = 450,
+		.disable = 200,
+		.unprepare = 510,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct drm_display_mode innolux_g070y2_t02_mode = {
 	.clock = 33333,
 	.hdisplay = 800,
@@ -4599,6 +4631,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "innolux,g070ace-l01",
 		.data = &innolux_g070ace_l01,
+	}, {
+		.compatible = "innolux,g070ace-lh3",
+		.data = &innolux_g070ace_lh3,
 	}, {
 		.compatible = "innolux,g070y2-l01",
 		.data = &innolux_g070y2_l01,

-- 
2.45.1


