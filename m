Return-Path: <linux-kernel+bounces-378505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B61449AD19D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4D281C218E7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB9C1E2612;
	Wed, 23 Oct 2024 16:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="A+TmNm+N"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AA81D9684
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702223; cv=none; b=K3jy3UYXTtFkuGIYFy/CH4nkDdckMdjSflGM0pwCARwipPHGnTdYlzScFk7qsrJ+Ax1CEBwGxLzNuGkLXMYYsKwxkIMRtJvky5/M4zxHD9m6NabsD5NKhP2uO0geRM2hEU8idiaPj+DSslxs9k3AfOn4Vt0m7iG31ChKW3UCt4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702223; c=relaxed/simple;
	bh=AKaxaAWgaWZCuM+ciKXobaTSn9sWMMJz3W069vSvAMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MSry07qq3TDlVbFxj+3/wjXwSvI3AmuuTe1/f5FiT1P581dYvP+tBUO4amFlJm3a4IS65zEVx+NxoncgJbpDdsveYBqxUhVUyFz38ZDH7diNqHH7q8xtHGq7b9MTKuH+OxYGZRdqd8fbwN3KPOHXpgU3B3lfRYQ6NQIWluw5E1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=A+TmNm+N; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4315e9e9642so61814865e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1729702220; x=1730307020; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tsucG0Q0vHPFBy6lzVvgyGm98jkpqjywCenuNv6tqlM=;
        b=A+TmNm+NbgIBV6bhacgYlndPnYC2lHQRjbHDemkWH8qtuL0dnskaV+Alg/4vCsMNuG
         nTdsaxdOVEN4VCERFjS1w5PZuAToemcdKD/PMD/C+A+ChqZqGZrziKm8flevUkNfiKDF
         p+qhFz2MQgyBj29e+dWZMHyMZjUOD3+YNNZMKpfOFFf2PPMyyIHJZX/naD2aemvexLcM
         StW4Cl5v3XkiTgCYcp7TtRrnnytX8FoEWyjPVH6CmVzrTTg7SHywB1gcowxe36yxN9q4
         t+D4DER4+bU3cbGHt2/bNPlMlgi57UtjIwDhbh2ZWRcnMD7M2Wg0nnWP9RrQahJxIAd1
         W5Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729702220; x=1730307020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsucG0Q0vHPFBy6lzVvgyGm98jkpqjywCenuNv6tqlM=;
        b=cOAv+vCX3KjwBwXwXoUwJWptY85WGrldUD1yIQSOpSiyIgMxkRwCt/l/QDOrBfDnMo
         QvDdbBt4ka71eV4AWT9kfsyYzPs0RCnOVGx+qn3L/IkUnw29K3cdVLpnEy1LcRo4NAeM
         JiwzOiYw6tGVwOzPE6DIat6gTWtSFzkBInz2pWidaP50yvnzzZ2AjQZ1cdVSh3Ri25kI
         lig6Ms3T2t5CboV2AAFjwlA1RYgWygCjskIaTUYhR8kUrZNgsCgNnWW3cBJVDxOQf9HS
         XCJiRkVXH3mIUts/Eem0/AG1zB+KnnMAdJLaGDwkYdS0JODqdFVUZ5XYGtny6MyeVT/h
         5NoA==
X-Forwarded-Encrypted: i=1; AJvYcCWlfeUN8PTbuW05QV+g4ymzsxowUWA0VDPV+z5q09zfln0PqTXTEdmwBA+qMa2TfFK4pCqGPUwq/Eh10QE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzywmfEdlrWGEx62OVOAyWeiysDWu5dZPuvHkXBncIMB+5732PC
	yGvyV59tz/avt/bWj6r0Wyfequ8czIlFFB/hTnN+W7ROxX0zLK0CzUtpHMoTsYA=
X-Google-Smtp-Source: AGHT+IF+z5G2SpbBJXEoTC4AhNnyHaZc8I8tY/B+b0FqCsjD1XtrGZGyhc0Zli024GaKfZ4+HiMwEw==
X-Received: by 2002:a05:600c:4fcd:b0:431:508a:1a7b with SMTP id 5b1f17b1804b1-431841a3efbmr26173175e9.34.1729702219677;
        Wed, 23 Oct 2024 09:50:19 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43186c50445sm21642035e9.39.2024.10.23.09.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 09:50:19 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 23 Oct 2024 17:50:09 +0100
Subject: [PATCH 12/37] drm/vc4: crtc: Add support for BCM2712 PixelValves
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-drm-vc4-2712-support-v1-12-1cc2d5594907@raspberrypi.com>
References: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com>
In-Reply-To: <20241023-drm-vc4-2712-support-v1-0-1cc2d5594907@raspberrypi.com>
To: Maxime Ripard <mripard@kernel.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>
X-Mailer: b4 0.14.1

From: Maxime Ripard <mripard@kernel.org>

The PixelValves found on the BCM2712 are similar to the ones found in
the previous generation.

Compared to BCM2711:
- the pixelvalves only drive one HDMI controller each
- HDMI1 PixelValve has a FIFO long enough to support 4k at 60Hz
- support has been added for odd horizontal timings whilst at 2pixels/clock

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/gpu/drm/vc4/vc4_crtc.c | 49 ++++++++++++++++++++++++++++++++++++++++--
 drivers/gpu/drm/vc4/vc4_drv.h  |  2 ++
 drivers/gpu/drm/vc4/vc4_regs.h |  6 ++++++
 3 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_crtc.c b/drivers/gpu/drm/vc4/vc4_crtc.c
index 53bca104d0d5..bfa25efa5db2 100644
--- a/drivers/gpu/drm/vc4/vc4_crtc.c
+++ b/drivers/gpu/drm/vc4/vc4_crtc.c
@@ -240,6 +240,11 @@ static u32 vc4_get_fifo_full_level(struct vc4_crtc *vc4_crtc, u32 format)
 	const struct vc4_crtc_data *crtc_data = vc4_crtc_to_vc4_crtc_data(vc4_crtc);
 	const struct vc4_pv_data *pv_data = vc4_crtc_to_vc4_pv_data(vc4_crtc);
 	struct vc4_dev *vc4 = to_vc4_dev(vc4_crtc->base.dev);
+
+	/*
+	 * NOTE: Could we use register 0x68 (PV_HW_CFG1) to get the FIFO
+	 * size?
+	 */
 	u32 fifo_len_bytes = pv_data->fifo_depth;
 
 	/*
@@ -421,6 +426,7 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc, struct drm_encoder *encode
 		 */
 		CRTC_WRITE(PV_V_CONTROL,
 			   PV_VCONTROL_CONTINUOUS |
+			   (vc4->gen >= VC4_GEN_6_C ? PV_VCONTROL_ODD_TIMING : 0) |
 			   (is_dsi ? PV_VCONTROL_DSI : 0) |
 			   PV_VCONTROL_INTERLACE |
 			   (odd_field_first
@@ -432,6 +438,7 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc, struct drm_encoder *encode
 	} else {
 		CRTC_WRITE(PV_V_CONTROL,
 			   PV_VCONTROL_CONTINUOUS |
+			   (vc4->gen >= VC4_GEN_6_C ? PV_VCONTROL_ODD_TIMING : 0) |
 			   (is_dsi ? PV_VCONTROL_DSI : 0));
 		CRTC_WRITE(PV_VSYNCD_EVEN, 0);
 	}
@@ -446,11 +453,17 @@ static void vc4_crtc_config_pv(struct drm_crtc *crtc, struct drm_encoder *encode
 	if (is_dsi)
 		CRTC_WRITE(PV_HACT_ACT, mode->hdisplay * pixel_rep);
 
-	if (vc4->gen == VC4_GEN_5)
+	if (vc4->gen >= VC4_GEN_5)
 		CRTC_WRITE(PV_MUX_CFG,
 			   VC4_SET_FIELD(PV_MUX_CFG_RGB_PIXEL_MUX_MODE_NO_SWAP,
 					 PV_MUX_CFG_RGB_PIXEL_MUX_MODE));
 
+	if (vc4->gen >= VC4_GEN_6_C)
+		CRTC_WRITE(PV_PIPE_INIT_CTRL,
+			   VC4_SET_FIELD(1, PV_PIPE_INIT_CTRL_PV_INIT_WIDTH) |
+			   VC4_SET_FIELD(1, PV_PIPE_INIT_CTRL_PV_INIT_IDLE) |
+			   PV_PIPE_INIT_CTRL_PV_INIT_EN);
+
 	CRTC_WRITE(PV_CONTROL, PV_CONTROL_FIFO_CLR |
 		   vc4_crtc_get_fifo_full_level_bits(vc4_crtc, format) |
 		   VC4_SET_FIELD(format, PV_CONTROL_FORMAT) |
@@ -549,7 +562,11 @@ int vc4_crtc_disable_at_boot(struct drm_crtc *crtc)
 	if (!(of_device_is_compatible(vc4_crtc->pdev->dev.of_node,
 				      "brcm,bcm2711-pixelvalve2") ||
 	      of_device_is_compatible(vc4_crtc->pdev->dev.of_node,
-				      "brcm,bcm2711-pixelvalve4")))
+				      "brcm,bcm2711-pixelvalve4") ||
+	      of_device_is_compatible(vc4_crtc->pdev->dev.of_node,
+				      "brcm,bcm2712-pixelvalve0") ||
+	      of_device_is_compatible(vc4_crtc->pdev->dev.of_node,
+				      "brcm,bcm2712-pixelvalve1")))
 		return 0;
 
 	if (!(CRTC_READ(PV_CONTROL) & PV_CONTROL_EN))
@@ -1292,6 +1309,32 @@ const struct vc4_pv_data bcm2711_pv4_data = {
 	},
 };
 
+const struct vc4_pv_data bcm2712_pv0_data = {
+	.base = {
+		.debugfs_name = "crtc0_regs",
+		.hvs_available_channels = BIT(0),
+		.hvs_output = 0,
+	},
+	.fifo_depth = 64,
+	.pixels_per_clock = 1,
+	.encoder_types = {
+		[0] = VC4_ENCODER_TYPE_HDMI0,
+	},
+};
+
+const struct vc4_pv_data bcm2712_pv1_data = {
+	.base = {
+		.debugfs_name = "crtc1_regs",
+		.hvs_available_channels = BIT(1),
+		.hvs_output = 1,
+	},
+	.fifo_depth = 64,
+	.pixels_per_clock = 1,
+	.encoder_types = {
+		[0] = VC4_ENCODER_TYPE_HDMI1,
+	},
+};
+
 static const struct of_device_id vc4_crtc_dt_match[] = {
 	{ .compatible = "brcm,bcm2835-pixelvalve0", .data = &bcm2835_pv0_data },
 	{ .compatible = "brcm,bcm2835-pixelvalve1", .data = &bcm2835_pv1_data },
@@ -1301,6 +1344,8 @@ static const struct of_device_id vc4_crtc_dt_match[] = {
 	{ .compatible = "brcm,bcm2711-pixelvalve2", .data = &bcm2711_pv2_data },
 	{ .compatible = "brcm,bcm2711-pixelvalve3", .data = &bcm2711_pv3_data },
 	{ .compatible = "brcm,bcm2711-pixelvalve4", .data = &bcm2711_pv4_data },
+	{ .compatible = "brcm,bcm2712-pixelvalve0", .data = &bcm2712_pv0_data },
+	{ .compatible = "brcm,bcm2712-pixelvalve1", .data = &bcm2712_pv1_data },
 	{}
 };
 
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index aea585bf83eb..a68cea921c11 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -558,6 +558,8 @@ extern const struct vc4_pv_data bcm2711_pv1_data;
 extern const struct vc4_pv_data bcm2711_pv2_data;
 extern const struct vc4_pv_data bcm2711_pv3_data;
 extern const struct vc4_pv_data bcm2711_pv4_data;
+extern const struct vc4_pv_data bcm2712_pv0_data;
+extern const struct vc4_pv_data bcm2712_pv1_data;
 
 struct vc4_crtc {
 	struct drm_crtc base;
diff --git a/drivers/gpu/drm/vc4/vc4_regs.h b/drivers/gpu/drm/vc4/vc4_regs.h
index 9226429539cf..731b13742ef5 100644
--- a/drivers/gpu/drm/vc4/vc4_regs.h
+++ b/drivers/gpu/drm/vc4/vc4_regs.h
@@ -155,6 +155,7 @@
 # define PV_CONTROL_EN				BIT(0)
 
 #define PV_V_CONTROL				0x04
+# define PV_VCONTROL_ODD_TIMING			BIT(29)
 # define PV_VCONTROL_ODD_DELAY_MASK		VC4_MASK(22, 6)
 # define PV_VCONTROL_ODD_DELAY_SHIFT		6
 # define PV_VCONTROL_ODD_FIRST			BIT(5)
@@ -215,6 +216,11 @@
 # define PV_MUX_CFG_RGB_PIXEL_MUX_MODE_SHIFT	2
 # define PV_MUX_CFG_RGB_PIXEL_MUX_MODE_NO_SWAP	8
 
+#define PV_PIPE_INIT_CTRL			0x94
+# define PV_PIPE_INIT_CTRL_PV_INIT_WIDTH_MASK	VC4_MASK(11, 8)
+# define PV_PIPE_INIT_CTRL_PV_INIT_IDLE_MASK	VC4_MASK(7, 4)
+# define PV_PIPE_INIT_CTRL_PV_INIT_EN		BIT(0)
+
 #define SCALER_CHANNELS_COUNT			3
 
 #define SCALER_DISPCTRL                         0x00000000

-- 
2.34.1


