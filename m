Return-Path: <linux-kernel+bounces-230040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8433991779E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 06:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC8371C20EF9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 04:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A523E13D255;
	Wed, 26 Jun 2024 04:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="K60Nj6PU";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="HATLGglR"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC89A31;
	Wed, 26 Jun 2024 04:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719377492; cv=none; b=geATMmeM23/aygCyz9I8ontap84utaWwWt4vtiLWNR0XnZO7XwKvKFBJHTjNK/DUygHcYSfyvupTI27BK3FOGd4wEPSyPzadqwAO4CQXzoqfETnvXMHQ2iY+1WLHF8dZbRuGhTS8Km18DOEhE+t931maLiLaXqrB5zNGHGu13Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719377492; c=relaxed/simple;
	bh=Zh3rJyajdE7v5l10STmndy5NoWirRdPuNluCDCkraDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkHSJ2VsBsc8/2zWc8bz5osNtPqr+0i2doI/IfLwenbVw+auoehLfiQTaII/2zGwuykqBU/CZEArpLT/D5jFI/sN4tkFt4rqD1bmF04LLYRzgJTReicnCKmzf9FvnPiZhJtaXc9jJ5UiS6wuCmJAzvExfX5mj51MgkBl1elmNKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=K60Nj6PU; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=HATLGglR reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1719377489; x=1750913489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vG2Rc4xkGFImIioZv6ZRCJMBuYbFRtMECaHSkdBskOE=;
  b=K60Nj6PU65/sCs/OWIl7tvec+DHjPEXSHsz7+C5fFMcZph+wlvpGCPYC
   Ls2Mh7CRuYujLN6u2ZKnSjs+625gtb2l7QqZ7Xd5G2vBDr09fmA3U6/d1
   lNAXb5JQY0T+grs3hkebikV5LpyjnNYNA33OPDsUH6HhLHeCe3uf2CICu
   6FhzfWw2DqKIVh0Q87FmG+AvkTG0jmCvsrZ+AgqlqrnPW0D+RuehjO/3Q
   G8UmJrYSbnGjwX6voMfi3giSs8JvRV9Lafq9lIGiG1fvf5Lb2WQsAAQaT
   K7ZpMGmKkmdFW2wKUzkNLROdGVOZpqSBP3iJD+WnEP+eZdxv0K85YJIhA
   A==;
X-CSE-ConnectionGUID: 7E+dOCUBTiS18j49G/35uQ==
X-CSE-MsgGUID: xt2H0tgQQHiCJZdsUyj98A==
X-IronPort-AV: E=Sophos;i="6.08,265,1712613600"; 
   d="scan'208";a="37587119"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 26 Jun 2024 06:51:27 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CB1781639F7;
	Wed, 26 Jun 2024 06:51:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1719377483; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=vG2Rc4xkGFImIioZv6ZRCJMBuYbFRtMECaHSkdBskOE=;
	b=HATLGglRbaAsM8WFN40WYfLHukhc5KL6OXmy7n5yO/quND9gKiD3nT55P51mvfqCzh4YrT
	6vHnPBQWKI3ZZAAbpus8PK+oPjCVTe/QlWvjWPUHCzGkZ49fafNCHN+KfTxzrSJzUpkuVF
	I1exw/VWEU++748D202jtaqKy7alrmLojhHwCdGhrlsI0DYwAyFit2RnIpClo67X/2dQTf
	goAXwAcDdNKreA4aBRehAauezj9W9Oh6qersDCL8ODyzLupLsbRMKYXLxmEew42W26DcoY
	t1RqAXJXUo+yhirXnS/TTPN+eDBJyc/0elrQvO9nZzTkNCW5R3V4CXdSsO2/Vg==
From: Paul Gerber <paul.gerber@ew.tq-group.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>
Cc: Paul Gerber <paul.gerber@ew.tq-group.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/panel: simple: Add AUO G104STN01 panel entry
Date: Wed, 26 Jun 2024 06:36:29 +0200
Message-ID: <20240626044727.2330191-3-paul.gerber@ew.tq-group.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240626044727.2330191-1-paul.gerber@ew.tq-group.com>
References: <20240626044727.2330191-1-paul.gerber@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Add support for the AUO G104STN01 10.4" (800x600) LCD-TFT panel.

Signed-off-by: Paul Gerber <paul.gerber@ew.tq-group.com>
---
Tested on TQ MBa8MPxL with TQMa8MPxL.

 drivers/gpu/drm/panel/panel-simple.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index dcb6d0b6ced0..5eacd2085a53 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1081,6 +1081,30 @@ static const struct panel_desc auo_g104sn02 = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
+static const struct drm_display_mode auo_g104stn01_mode = {
+	.clock = 40000,
+	.hdisplay = 800,
+	.hsync_start = 800 + 40,
+	.hsync_end = 800 + 40 + 88,
+	.htotal = 800 + 40 + 88 + 128,
+	.vdisplay = 600,
+	.vsync_start = 600 + 1,
+	.vsync_end = 600 + 1 + 23,
+	.vtotal = 600 + 1 + 23 + 4,
+};
+
+static const struct panel_desc auo_g104stn01 = {
+	.modes = &auo_g104stn01_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 211,
+		.height = 158,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct display_timing auo_g121ean01_timing = {
 	.pixelclock = { 60000000, 74400000, 90000000 },
 	.hactive = { 1280, 1280, 1280 },
@@ -4434,6 +4458,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "auo,g104sn02",
 		.data = &auo_g104sn02,
+	}, {
+		.compatible = "auo,g104stn01",
+		.data = &auo_g104stn01,
 	}, {
 		.compatible = "auo,g121ean01",
 		.data = &auo_g121ean01,
-- 
2.44.1


