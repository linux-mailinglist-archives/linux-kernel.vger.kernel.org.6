Return-Path: <linux-kernel+bounces-378506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E579AD1A2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8223D1F2444C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066961E7C10;
	Wed, 23 Oct 2024 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="rHqEfdND"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7683F1E1322
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729702226; cv=none; b=A5bGpuA8N+9pdByINJTECAFE8r5dchmxCy8qOXoWYGQl1kQhqfCDKVyQBijpmW58IFXJn3LxeTSTR/msJDYYCmKcfrUztsY00qo6UltuEUbpu0uC5oFa0j0HKwwa4CztYEclLy7qfG27fRchQ7j3U7bYCbFtMrtF8cjgRjRopqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729702226; c=relaxed/simple;
	bh=WV/UFQyvWXojwAqHvOtHxgMXrfRl7lw3BEm8g+qz5Yo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iv9dm9wMSq/4+UOcVHE1494aRhIC5i3TXVa+rMMRRsoWc2FGDXUebKjU6+OPvl+PLNKcEsDR3buaIQ3TOBtMixJ5qXXbPr/xRUnr0/kb3UFy7OO8dd37wtZOLhTbakZOaiRu/aPByl3Mbp9YWcXPh1cIvKMcU7hu3SwvDPkfmCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=rHqEfdND; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4316e9f4a40so45418265e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 09:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1729702222; x=1730307022; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZSl/F4a59d6cGzaQ8UBGb7tAkWNLG3z9Ozwy3jDhoY=;
        b=rHqEfdNDHWs8l6p1juhQDS4IGrQcuP4dgfLM/VgLcbRQMz3zDaZRT1p5RMXDpOEXpr
         UDxWLYi9h8n/HpTlwwRyX2Tlfg8k0e5lDWcsJOWr3TCYc++OBfcSmbHeg1rDjvlZLH2e
         TyLWqVNkmbp4bxSoexWNVEsRgK2CFGmmm2aTDx96nF5iIKUZojHwqPW6pvZv1OYQKoFr
         24rv5Whs1h5px3kTlL+9TN5idLSE6gV61VEmGkx9Bb/I6i3a7AaScjyCyRBKpMzVYtn4
         CGCYpX43Krw13XIraH0tu9VSoQgWv1yueZhmIKhrapl+C6qiTFLuX7xjFdrqJqGr9c8K
         NhYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729702222; x=1730307022;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZSl/F4a59d6cGzaQ8UBGb7tAkWNLG3z9Ozwy3jDhoY=;
        b=HeHkLBFQ1VD1DR1ZMJ1T9PIjU/4C7pDJIJuUzzqRTCBSkKZuu9yQGLWWn2uEjA0iGy
         4a+WmgAzvWZhQls5NEc8Jynnd8cPPjQgWPwTdD/8SWF0jQbi1GuMj+zX29NcPLhKIWgG
         nvJcFsuBeDVBgvcsqvEa5uVZeuwug+pZIO8YLZqKqbf5diPw7bxy1UHYXGt03sAySF6B
         ZxxYfDohyTmr8LFkHo0Zf6QOLjWQNQIQlRiob7Y2Gjon5u5xv91Tz5FRb4MB47WIni+V
         r74fdsOaF/sJH3dCIJVYAVenTNLeGVyUo74wV3vzLtV/ar+uOhmsQK3se7K6FvwCLjyi
         mQEg==
X-Forwarded-Encrypted: i=1; AJvYcCWiFQP+f307/uKloKn48ttyMXhEhm3VU55tSHfCQE7ooVvB0kwowYvJ3SwQFMA10UPHq25ZcwT/OQ9hxVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9z5MiFbO4OAjxL7XFQfRblSXQEomTLPPEArbNdtsYIWyKayhL
	CzUYYQcTL+tS0r5iTMqL3L0F3SRM7z8kPKCkp30IayIEcnKlM9q5vazzaNu1GFk=
X-Google-Smtp-Source: AGHT+IGVp4GJMwBRKlS9Q12L5xPs/An67Q2sllEQsQWhIVdFiJ7lcu6JT07uXS8WxSxC/y5+CBUMhw==
X-Received: by 2002:a05:600c:1c29:b0:431:5df7:b310 with SMTP id 5b1f17b1804b1-43184142c50mr24298445e9.8.1729702221727;
        Wed, 23 Oct 2024 09:50:21 -0700 (PDT)
Received: from [127.0.1.1] ([2a00:1098:3142:e::8])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43186c50445sm21642035e9.39.2024.10.23.09.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 09:50:21 -0700 (PDT)
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Wed, 23 Oct 2024 17:50:11 +0100
Subject: [PATCH 14/37] drm/vc4: txp: Introduce structure to deal with
 revision differences
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241023-drm-vc4-2712-support-v1-14-1cc2d5594907@raspberrypi.com>
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

The BCM2712 will have several TXP with small differences. Let's add a
structure tied to the compatible to deal with those differences.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
---
 drivers/gpu/drm/vc4/tests/vc4_mock.c |  4 ++--
 drivers/gpu/drm/vc4/vc4_drv.h        |  6 +++++-
 drivers/gpu/drm/vc4/vc4_txp.c        | 23 ++++++++++++++++-------
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/vc4/tests/vc4_mock.c b/drivers/gpu/drm/vc4/tests/vc4_mock.c
index 6527fb1db71e..c7b91c87f1bc 100644
--- a/drivers/gpu/drm/vc4/tests/vc4_mock.c
+++ b/drivers/gpu/drm/vc4/tests/vc4_mock.c
@@ -51,7 +51,7 @@ struct vc4_mock_desc {
 
 static const struct vc4_mock_desc vc4_mock =
 	VC4_MOCK_DESC(
-		VC4_MOCK_CRTC_DESC(&vc4_txp_crtc_data,
+		VC4_MOCK_CRTC_DESC(&vc4_txp_data.base,
 				   VC4_MOCK_OUTPUT_DESC(VC4_ENCODER_TYPE_TXP,
 							DRM_MODE_ENCODER_VIRTUAL,
 							DRM_MODE_CONNECTOR_WRITEBACK)),
@@ -77,7 +77,7 @@ static const struct vc4_mock_desc vc4_mock =
 
 static const struct vc4_mock_desc vc5_mock =
 	VC4_MOCK_DESC(
-		VC4_MOCK_CRTC_DESC(&vc4_txp_crtc_data,
+		VC4_MOCK_CRTC_DESC(&vc4_txp_data.base,
 				   VC4_MOCK_OUTPUT_DESC(VC4_ENCODER_TYPE_TXP,
 							DRM_MODE_ENCODER_VIRTUAL,
 							DRM_MODE_CONNECTOR_WRITEBACK)),
diff --git a/drivers/gpu/drm/vc4/vc4_drv.h b/drivers/gpu/drm/vc4/vc4_drv.h
index a68cea921c11..1ed1fb5aa7e8 100644
--- a/drivers/gpu/drm/vc4/vc4_drv.h
+++ b/drivers/gpu/drm/vc4/vc4_drv.h
@@ -536,7 +536,11 @@ struct vc4_crtc_data {
 	int hvs_output;
 };
 
-extern const struct vc4_crtc_data vc4_txp_crtc_data;
+struct vc4_txp_data {
+	struct vc4_crtc_data	base;
+};
+
+extern const struct vc4_txp_data vc4_txp_data;
 
 struct vc4_pv_data {
 	struct vc4_crtc_data	base;
diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
index ffe1f7d1b911..dcb1b3fd37de 100644
--- a/drivers/gpu/drm/vc4/vc4_txp.c
+++ b/drivers/gpu/drm/vc4/vc4_txp.c
@@ -159,6 +159,7 @@
 
 struct vc4_txp {
 	struct vc4_crtc	base;
+	const struct vc4_txp_data *data;
 
 	struct platform_device *pdev;
 
@@ -484,17 +485,20 @@ static irqreturn_t vc4_txp_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-const struct vc4_crtc_data vc4_txp_crtc_data = {
-	.name = "txp",
-	.debugfs_name = "txp_regs",
-	.hvs_available_channels = BIT(2),
-	.hvs_output = 2,
+const struct vc4_txp_data vc4_txp_data = {
+	.base = {
+		.name = "txp",
+		.debugfs_name = "txp_regs",
+		.hvs_available_channels = BIT(2),
+		.hvs_output = 2,
+	},
 };
 
 static int vc4_txp_bind(struct device *dev, struct device *master, void *data)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct drm_device *drm = dev_get_drvdata(master);
+	const struct vc4_txp_data *txp_data;
 	struct vc4_encoder *vc4_encoder;
 	struct drm_encoder *encoder;
 	struct vc4_crtc *vc4_crtc;
@@ -509,6 +513,11 @@ static int vc4_txp_bind(struct device *dev, struct device *master, void *data)
 	if (!txp)
 		return -ENOMEM;
 
+	txp_data = of_device_get_match_data(dev);
+	if (!txp_data)
+		return -ENODEV;
+
+	txp->data = txp_data;
 	txp->pdev = pdev;
 	txp->regs = vc4_ioremap_regs(pdev, 0);
 	if (IS_ERR(txp->regs))
@@ -519,7 +528,7 @@ static int vc4_txp_bind(struct device *dev, struct device *master, void *data)
 	vc4_crtc->regset.regs = txp_regs;
 	vc4_crtc->regset.nregs = ARRAY_SIZE(txp_regs);
 
-	ret = vc4_crtc_init(drm, pdev, vc4_crtc, &vc4_txp_crtc_data,
+	ret = vc4_crtc_init(drm, pdev, vc4_crtc, &txp_data->base,
 			    &vc4_txp_crtc_funcs, &vc4_txp_crtc_helper_funcs, true);
 	if (ret)
 		return ret;
@@ -579,7 +588,7 @@ static void vc4_txp_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id vc4_txp_dt_match[] = {
-	{ .compatible = "brcm,bcm2835-txp" },
+	{ .compatible = "brcm,bcm2835-txp", .data = &vc4_txp_data },
 	{ /* sentinel */ },
 };
 

-- 
2.34.1


