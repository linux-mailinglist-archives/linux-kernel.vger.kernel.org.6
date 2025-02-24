Return-Path: <linux-kernel+bounces-529232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E33B0A421FB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 506F57A530C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8521D25A2AD;
	Mon, 24 Feb 2025 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sB6/ir7j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A2124E4CF;
	Mon, 24 Feb 2025 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405065; cv=none; b=Ef4Yfhc1obSmWGi7yLvKPNxPrXSrh5KubgagpeZeRoUQA5SA+KPnOdouVVJv4BZaKl1IpYp9MEvJo8sBPVrxKHiVRKSLVQs6ZdJUdQdTqNu3W8m7tR/BAxn/3gEv1uXKoSGkTdHQK7ht7K3OzEekcRvnx24ERSVZjJHMYvW54I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405065; c=relaxed/simple;
	bh=5ZnKgIAuKnEFK7Y8NZ5mOCc85+F4VvfoYmgu9iVxDVY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=segrQoaccusWfUoaSqgYyZ64+wD66QFdgfGry2E0Amyg7YN8K8YtNvwpUzfjY0TkbjeAtZu3yVah8MMC3uvEzwbUxLFtmp048lfWiBlOUSDXiHx5rMFK/7EmVDi/52QvKOShDyZcwkDqXhm6KkXIcO9lIENtr/KAdopJToBLqRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sB6/ir7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8FC2FC4CEF8;
	Mon, 24 Feb 2025 13:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405064;
	bh=5ZnKgIAuKnEFK7Y8NZ5mOCc85+F4VvfoYmgu9iVxDVY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=sB6/ir7j88IjurwQACHCenKq6ObU4ymiotnN4cEBDRMunvAS3UYTy1hF7nwYj1m8x
	 UucFkvX65qjTbXCdEQt+A1J9zzOhrJZGVUHLCNFmQrbcJHdxbli8VhcJuZuwOy848l
	 /xWU3nyEe/K80/qkA6kNHMkFePLb/59zh520fHZvxsV8cHXd+dBwX3To0lorryJstD
	 jBvaPdEy9ds7MaT1ixJ+p/Bu42ypv4DlH7jaSIjiqYd7BhTpvcWE/bC1HYBVkwp1pP
	 QvQTo7w8Xd9vD6jLOVGtMn/7ZmJbu7DWhhRlXv8u69ZPgfvJG/LNSpatRUU1kTz0xT
	 YVYnlvtXVEm0w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F28C021A4;
	Mon, 24 Feb 2025 13:51:04 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Mon, 24 Feb 2025 14:50:57 +0100
Subject: [PATCH 07/14] drm/panel: simple: add BOE AV101HDT-A10 panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-initial_display-v1-7-5ccbbf613543@gocontroll.com>
References: <20250224-initial_display-v1-0-5ccbbf613543@gocontroll.com>
In-Reply-To: <20250224-initial_display-v1-0-5ccbbf613543@gocontroll.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Liu Ying <victor.liu@nxp.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, 
 Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740405062; l=1886;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=Cju7ma2SUhb+XLBd5DK6cBkjDfg4PKWYSUHWwciFPIU=;
 b=bnH85hLfjsMGDvGh+rvH0i7I1VxeDU9NSzTxo6hasSyf3NS+u/TjBLlkfwYzsKWsGujdRxJn+
 ZguaQGB1uQ8DSaVG5Bz4YOVYBI/PzV5ax7G8i3Wf5la1xd/tWSAKp1R
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

add support for the BOE AV101HDT-A10 10.1" LVDS panel

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 9b2f128fd3094bfb6731fc348b91cc101f495a86..a52977ab73dc2edab0d1954c702fd797d6a5b969 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1374,6 +1374,35 @@ static const struct panel_desc bananapi_s070wv20_ct16 = {
 	},
 };
 
+static const struct display_timing boe_av101hdt_a10_timing = {
+	.pixelclock = { 74210000, 75330000, 76780000, },
+	.hactive = { 1280, 1280, 1280, },
+	.hfront_porch = { 10, 42, 33, },
+	.hback_porch = { 10, 18, 33, },
+	.hsync_len = { 30, 10, 30, },
+	.vactive = { 720, 720, 720, },
+	.vfront_porch = { 200, 183, 200, },
+	.vback_porch = { 8, 8, 8, },
+	.vsync_len = { 2, 19, 2, },
+	.flags = DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW,
+};
+
+static const struct panel_desc boe_av101hdt_a10 = {
+	.timings = &boe_av101hdt_a10_timing,
+	.num_timings = 1,
+	.bpc = 8,
+	.size = {
+		.width = 224,
+		.height = 126,
+	},
+	.delay = {
+		.enable = 50,
+		.disable = 50,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct drm_display_mode boe_bp101wx1_100_mode = {
 	.clock = 78945,
 	.hdisplay = 1280,
@@ -4813,6 +4842,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "bananapi,s070wv20-ct16",
 		.data = &bananapi_s070wv20_ct16,
+	}, {
+		.compatible = "boe,av101hdt-a10",
+		.data = &boe_av101hdt_a10,
 	}, {
 		.compatible = "boe,bp082wx1-100",
 		.data = &boe_bp082wx1_100,

-- 
2.48.1



