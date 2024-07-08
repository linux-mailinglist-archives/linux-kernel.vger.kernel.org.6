Return-Path: <linux-kernel+bounces-244524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F2392A57D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 17:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9957D1C21189
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 15:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C2213D2BB;
	Mon,  8 Jul 2024 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKCXQuhR"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FC39461
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 15:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720451904; cv=none; b=Yzc2GYWAOddP+cQExRGDwJ/VIkESwzPXLtSMTyX/Cb9Yj3U/LFInCcPhFwcCIQfQxQPc2Dl6X0vDRNWPVN7pE/QbwdJ1ON72Q5kaXDq2PLOLz0a0DljSESgoRn7mKR8GR1uCSqA41jgkAHqzdNu/KnDrWXTRE674xhzmVapNT+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720451904; c=relaxed/simple;
	bh=m1CbKS6sjooBIqxjkSHZJlp9SunXGeoor/qdb8eDVgo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hQLYDC77CMM9zpG7ApQefY4Oyxsnj46DRsiBU8jCrmKAi76Z7an3ivdJLu4cAZwj3inY/QsHCMQXYXTIv67OsUpTtrZ5HXUGPFawqYPynLXz7pj+oAh3wyRDa8terzRa4YbcXI5QlxV8GPlPGLf3qhcoBL8dccr7Eak4TVTOBTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKCXQuhR; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a77c25beae1so432152666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 08:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720451901; x=1721056701; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oGCrVrBGIrx7MPLgB/KlykXRMIJJJRJ81UrBbePvOHg=;
        b=WKCXQuhR7DirFIu7WO06Z/JtF9pLYyMYYwtqFZXuaC79p/dNNdnIN2a4hEGHjVktnq
         OESoMiuYvueJJ+1AQtbOdSdpeItIFsI4BS/j37riIiEW4hX0U7UAUiXAdEpqs1teEZBC
         DqynlMz29mvbX0pkqCk0l827eVpXi/+Fzpv2TIJ5Jrkoo/USqRTnkv2O/JES/JeoCoIw
         gGa67eiXRDI5GTEg+2YLpCnpwGVfKfHxMzfbY8muqBKTO58ozgz6zmjll7//4JR/JnP2
         bngBOTH1VJU2daLePElKV36B7Nvz8Np2pL5K3z+brboCOq9OWJ1vCRjdnp7bRmRwluRm
         CwOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720451901; x=1721056701;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oGCrVrBGIrx7MPLgB/KlykXRMIJJJRJ81UrBbePvOHg=;
        b=aoED+ss3+qqBEMxiqtATWJFStLq+NovXO7ufoLsNdawvnWTSz93BbaI6YzVXl9nk9f
         u+eTkD+a0Uudx086MxhMaupVn+zh/MImjraO5OR3pVHBmnaLqsmzEOqLMPqRLqYMKkzT
         qdrsQ4YyuLTcvPNWFt71j9wANHKL5nX8hBHsFTwOcdXRWwJa6WX+fMHxVS1UGRGIlXqt
         mbqH0NhdNQVGs2FfYx6J1FpCgFmFNkIjc9CrvlhEmab1przQNybGfrqWDTX7HILB12s3
         ryfCoxfL8SJwQlv+79kjgUu6d5Ojm6GxtwPYdcJEhmitBtDluHDSKG9Hc4xw4p2sLrAn
         fVAg==
X-Forwarded-Encrypted: i=1; AJvYcCVPuOsWZfQrOiq5Os9MY5jnWU/uI8J9RLRetSyIvJfn02YabYhp10JVwNmNTYt/hC72n3tcDUZQglEQzdSPQfwJItYlNt5VvCmohrzz
X-Gm-Message-State: AOJu0YxFIeyBKWD370dEoOC+INhKdAxftdI69uKfYl3dULLe4V/Thuib
	sOTNTlW/PZ2aGbKtmN+1dbaBJieQw1V1Of/YfxSxIUvH2M7DHk+D
X-Google-Smtp-Source: AGHT+IHDkYDqBWV7jiUx3ikaGrYl0qJ1VuVd0nwfS410p0DwAQ9ZE96/NVk3RbpvQFL4gy7OZyyFHA==
X-Received: by 2002:a17:906:ccd2:b0:a77:dd1c:6274 with SMTP id a640c23a62f3a-a77dd1c6efamr481461566b.69.1720451901111;
        Mon, 08 Jul 2024 08:18:21 -0700 (PDT)
Received: from GLaDOS.tastitalia.local ([37.77.97.75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6dc721sm3142766b.53.2024.07.08.08.18.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 08:18:20 -0700 (PDT)
From: stefano.radaelli21@gmail.com
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Stefano Radaelli <stefano.radaelli21@gmail.com>,
	"Noah J . Rosa" <noahj.rosa@gmail.com>
Subject: [PATCH] drm/bridge: ti-sn65dsi83: Add Non-Burst mode property
Date: Mon,  8 Jul 2024 17:18:19 +0200
Message-Id: <20240708151819.40457-1-stefano.radaelli21@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

From: Stefano Radaelli <stefano.radaelli21@gmail.com>

The video mode can be divided into two methods for sending packet data:
burst mode and non-burst mode.
In burst mode, pixel data is compressed to save time for the interface
to return to low power.
Non-burst modes transmit pixel data in a stream controlled by sync
pulses or sync events.

Adding this property in the DTS gives the programmer the ability to
disable Burst Mode, depending on how the MIPI controller is configured.

Co-developed-by: Noah J. Rosa <noahj.rosa@gmail.com>
Signed-off-by: Noah J. Rosa <noahj.rosa@gmail.com>
Signed-off-by: Stefano Radaelli <stefano.radaelli21@gmail.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 57a7ed13f996..6314c03ce1e6 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -145,6 +145,7 @@ struct sn65dsi83 {
 	struct drm_bridge		*panel_bridge;
 	struct gpio_desc		*enable_gpio;
 	struct regulator		*vcc;
+	bool				burst_mode;
 	bool				lvds_dual_link;
 	bool				lvds_dual_link_even_odd_swap;
 };
@@ -581,6 +582,7 @@ static int sn65dsi83_parse_dt(struct sn65dsi83 *ctx, enum sn65dsi83_model model)
 	struct drm_bridge *panel_bridge;
 	struct device *dev = ctx->dev;
 
+	ctx->burst_mode = !(of_property_read_bool(dev->of_node, "burst-mode-disabled"));
 	ctx->lvds_dual_link = false;
 	ctx->lvds_dual_link_even_odd_swap = false;
 	if (model != MODEL_SN65DSI83) {
@@ -654,10 +656,15 @@ static int sn65dsi83_host_attach(struct sn65dsi83 *ctx)
 
 	dsi->lanes = dsi_lanes;
 	dsi->format = MIPI_DSI_FMT_RGB888;
-	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
+	dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
 			  MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
 			  MIPI_DSI_MODE_VIDEO_NO_HSA | MIPI_DSI_MODE_NO_EOT_PACKET;
 
+	if (ctx->burst_mode)
+		dsi->mode_flags |= MIPI_DSI_MODE_VIDEO_BURST;
+	else
+		dsi->mode_flags |= MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
+
 	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "failed to attach dsi to host: %d\n", ret);
-- 
2.34.1


