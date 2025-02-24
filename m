Return-Path: <linux-kernel+bounces-529235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4171A42219
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5A9A16EE5E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B2925A2AF;
	Mon, 24 Feb 2025 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwGk/4lF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E3624EF63;
	Mon, 24 Feb 2025 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405065; cv=none; b=HlmsZyuqn8FwQnxItI9Jk0lkFGkuhz2cAy40aEtoLxs+cjB3NcDgrRNuEo8ZrhZRzrkx4/XniuawTMxKuSdecX2w3Qbh3Jv0UIG5A33Hzrekmli4YwyULQyZ7T6ue/iacvumCPyOGd3ECYLhmSnkpKolprwBCoMJpbNzSqu78tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405065; c=relaxed/simple;
	bh=9rsK2DyiLn0rGQVW5aqBw0QCdbVsaOqhBOHIuUKMsyw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SvYp8PbWEaG2bO00vPdKf0q74CbdYLe7Mz1025lKJg8+piY0qCPqkavKUALD/2t7+Sqqpdamj9nv8xOS0iwOoNJ2eFg3ONU55YLm1VZFRwlodcs9jzCQi33zQpl22fmDE1wdhCDZGgf3jco17xE0NL6x0MfhR12dlAMEkzWO2Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwGk/4lF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A68A9C4CEF9;
	Mon, 24 Feb 2025 13:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405064;
	bh=9rsK2DyiLn0rGQVW5aqBw0QCdbVsaOqhBOHIuUKMsyw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cwGk/4lFw/RV2zrHR2vk91lDkKP5hvOnqTQdpmGo2xFPdw3nxcVg9FD0E3a5RHR5Y
	 JamEKWh9/tTYr8GO9eETAoDXd5uJQk1xuRB1/nHviJMWUq6ogD5QbqAIIwcR/oSu1h
	 Gy+a4iFYyE5iIPNDLc8iy1bDbd8Wil95t9NKUB7wJxita3AiR9pOUd9rq2bTBlCDVH
	 kyHn+4o3EW3J5L8281qM4nE4m/c66qnhus0e0fAopXmp2RPjpbK4/bLH1j1AiHdgaF
	 8Z4XqC6BPMleA+iSBu7Bf8LQ8nX5fqJw0qCF16OWfrlk3XCAcq4c976SPGAM0LEYHR
	 2zamrqgVtKikQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B318C021BB;
	Mon, 24 Feb 2025 13:51:04 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Mon, 24 Feb 2025 14:50:58 +0100
Subject: [PATCH 08/14] drm/panel: simple: Add BOE AV123Z7M-N17 panel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-initial_display-v1-8-5ccbbf613543@gocontroll.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740405062; l=1908;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=vOVkRssMq+0b54M++/GbRnRh45tiCsN1h3cNEf5At7g=;
 b=mIAf7wLfiBaXHgCEU4/8qvWOFXgtpexk2cgZKBPGdS9xQHEzRlSLaQGkNSxpz1dAA+cZucueh
 uDLvxXs5uZfBwENboFcPxubRl6D9NJ9o9TOrax33cAGbmns59TckZj6
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

Add support for the BOE AV123Z7M-N17 12.3" LVDS panel.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index a52977ab73dc2edab0d1954c702fd797d6a5b969..232b03c1a259eb15e423b9d452d28e2ff95c70f8 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1403,6 +1403,35 @@ static const struct panel_desc boe_av101hdt_a10 = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
+static const struct display_timing boe_av123z7m_n17_timing = {
+	.pixelclock = { 86600000, 88000000, 90800000, },
+	.hactive = { 1920, 1920, 1920, },
+	.hfront_porch = { 10, 10, 10, },
+	.hback_porch = { 10, 10, 10, },
+	.hsync_len = { 9, 12, 25, },
+	.vactive = { 720, 720, 720, },
+	.vfront_porch = { 7, 10, 13, },
+	.vback_porch = { 7, 10, 13, },
+	.vsync_len = { 7, 11, 14, },
+	.flags = DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW,
+};
+
+static const struct panel_desc boe_av123z7m_n17 = {
+	.timings = &boe_av123z7m_n17_timing,
+	.bpc = 8,
+	.num_timings = 1,
+	.size = {
+		.width = 292,
+		.height = 110,
+	},
+	.delay = {
+		.prepare = 50,
+		.disable = 50,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct drm_display_mode boe_bp101wx1_100_mode = {
 	.clock = 78945,
 	.hdisplay = 1280,
@@ -4845,6 +4874,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "boe,av101hdt-a10",
 		.data = &boe_av101hdt_a10,
+	}, {
+		.compatible = "boe,av123z7m-n17",
+		.data = &boe_av123z7m_n17,
 	}, {
 		.compatible = "boe,bp082wx1-100",
 		.data = &boe_bp082wx1_100,

-- 
2.48.1



