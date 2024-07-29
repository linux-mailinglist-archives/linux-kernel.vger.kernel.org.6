Return-Path: <linux-kernel+bounces-265200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4D093EDEE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 09:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C91C1C21D67
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 07:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B576F12D758;
	Mon, 29 Jul 2024 07:03:12 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F72284A36
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 07:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722236592; cv=none; b=Uex+CT8nKWCpPsy3gzNqrBTd0qQ5ZRlwIGbm4gk8KDit79fawERkzmNh9OgoXJkduy/bJqBz+oNpmwbzMSAtK1+uD0VXwG8788KaXSahd5HArTJfMiirfG/8xZF/x+C+OpDO7K5mD/M7CrkWVD+C2bP1QclZQnNIhcMXwXapMwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722236592; c=relaxed/simple;
	bh=Z9X75EpJBnQUF+ecvzyLU5RTqQNhVQ+oAUONH1D66ps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ge9rz1Rk93Un/5j5MjNDE3cBkXP2JShHpYwxViV4yOSUtcIFTpfsNK6EGrt1giMe8nrclMWgGBhtVazAYxoE37Ps4BdvexYVGIASLeOT2Sd8VNJyn9OO5EbQhK0ljlYz2aaEkj/VGJc11bd3j3USUc3GZB3k9rKUOozVcsHzPKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1sYKP4-0003xR-9C; Mon, 29 Jul 2024 09:02:42 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Mon, 29 Jul 2024 09:02:39 +0200
Subject: [PATCH v2 2/2] drm/panel: simple: add Innolux G070ACE-LH3 LVDS
 display support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240729-b4-v6-10-topic-innolux-v2-2-27d32c766ce5@pengutronix.de>
References: <20240729-b4-v6-10-topic-innolux-v2-0-27d32c766ce5@pengutronix.de>
In-Reply-To: <20240729-b4-v6-10-topic-innolux-v2-0-27d32c766ce5@pengutronix.de>
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
index dcb6d0b6ced06..d3200dd035662 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2509,6 +2509,38 @@ static const struct panel_desc innolux_g070y2_l01 = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
+static const struct display_timing innolux_g070ace_lh3_timing = {
+	.pixelclock = { 25200000, 25400000, 35700000 },
+	.hactive = { 800, 800, 800 },
+	.hfront_porch = { 30, 32, 87 },
+	.hback_porch = { 29, 31, 86 },
+	.hsync_len = { 1, 1, 1 },
+	.vactive = { 480, 480, 480 },
+	.vfront_porch = { 4, 5, 65 },
+	.vback_porch = { 3, 4, 65 },
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


