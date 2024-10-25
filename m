Return-Path: <linux-kernel+bounces-382227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 801AC9B0B35
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECD71B2124E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 17:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D86224DAC;
	Fri, 25 Oct 2024 17:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="ZvUp+tuY"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993C2224403
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729876576; cv=none; b=sZbJlEMzpzesnf2trMvaK5E8k5qL9yy76QSvpdJ2v1Jz/TauTq9HKXumYR5VDXd5wvzb2O9w/M37gbdd+y/VsDSGQGeawfpkyncVOHUG2la30h0SVGnKNjs75gAhEaw9Fv4nASRMEDHuIiuW2nusR5+iCD+gJ4IDCJ+8CN0CC0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729876576; c=relaxed/simple;
	bh=AKaxaAWgaWZCuM+ciKXobaTSn9sWMMJz3W069vSvAMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ih3oT2lq9DL98chm4yCGlIh/1EAwSw0STS19AWgSUWxGVoUJ/YYk5vd4YdRjKOGu2sqVJKJKhPCZbrUYNQ+u1dsfSJR70DPVUVgUuJI/AX0Fq73KfrC61TBd1zweC/YvAfKHXuDHWE/q/VQy42dvp+spi8+zRKoPjDfA9+DbLQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=ZvUp+tuY; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43155afca99so22976965e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 10:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1729876572; x=1730481372; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tsucG0Q0vHPFBy6lzVvgyGm98jkpqjywCenuNv6tqlM=;
        b=ZvUp+tuYUZYJqY8toc6lmCoT0D06y9gmObug6jz24i5znlBvczxvgxGD7LvkxZKhrl
         Hq56NCjPxMM9gQG7G2+9VKbC4VNSiRjDgcPsDRP5vlJG98vFBdQ4RY6ZDs4l9xMEUTh+
         lqa1dbKGCTJzJ6pVeWCBLx/quLBS+rGFACqNaekeFLQx1BZ4PBmkPP9z67smn8OFbe68
         EuaTlNt+ovkkA+soAjBjYqRfty4ZZFrM2vuhGygtu30GRbgSZc3U/S0QW/XUlXg4s8Fr
         TbttVINMS8tNVNbiBfn+I8Q/ifbV0ieb0ewRccGA2J33CHLEymBbb2HZCwKH0x5pL1UK
         QuFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729876572; x=1730481372;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsucG0Q0vHPFBy6lzVvgyGm98jkpqjywCenuNv6tqlM=;
        b=hZ8RzBVBaDkhba5OCik7GEPxxpZiz9ZjLHLTK1XTRW4py0LGTpglyN/N21C1KzdsqO
         NKj6oVgO7bYQ/ZhB5gnamyJmOYNo+bI1CWTgES4nfZh9+Wk4g7o5OuPDeK749W51A67j
         gPH85MLQXsYcF9yOI15Rz3kXjs3cHcqYWM1qRyDqANNAWY/cj5z9DI2POgUPUeAisyVk
         SrJj6s60z+2TmDQpqa19DBMb6OuGDL12P7YmunfoA2Adh3TboFIHJD/QWTcwOtYm+vmJ
         ecHLWfzqpcKXqrlnDDlfv1qpZJqXw3otaCA1aLznW56y94dFMRc6iPWyWFY95lon7B4S
         ymrw==
X-Forwarded-Encrypted: i=1; AJvYcCWEiDoEOU6qIpQmQ3nFWojFc/l4PvMdxNHRAIGHI/7BC5ZpdyRc6th+J8GirzDw7LFki20XU2uEWDIBNyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YySBuzYFZHczQNV140/jEA9DYSOxwZo3F36a4J9hcaTQt5FcrF+
	WobfjCybQssDkMQxnKLvBwNO11trd590kZJERnFY/ED5WFK25agsnqCBJaNirqI=
X-Google-Smtp-Source: AGHT+IGUqMQQsp99SP+bQHGGlASJ4CwqsEZ+AnxXoU5Dx0q1aLWp3syCMzhCcHZAUhr5TKhw7gxREg==
X-Received: by 2002:a05:600c:3b1d:b0:42c:b8c9:16c8 with SMTP id 5b1f17b1804b1-4319a58a309mr2507395e9.10.1729876571991;
        Fri, 25 Oct 2024 10:16:11 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-38058b91f50sm2013649f8f.94.2024.10.25.10.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 10:16:11 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Fri, 25 Oct 2024 18:15:42 +0100
Subject: [PATCH v2 11/36] drm/vc4: crtc: Add support for BCM2712
 PixelValves
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-drm-vc4-2712-support-v2-11-35efa83c8fc0@raspberrypi.com>
References: <20241025-drm-vc4-2712-support-v2-0-35efa83c8fc0@raspberrypi.com>
In-Reply-To: <20241025-drm-vc4-2712-support-v2-0-35efa83c8fc0@raspberrypi.com>
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


