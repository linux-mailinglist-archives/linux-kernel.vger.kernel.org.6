Return-Path: <linux-kernel+bounces-305343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B59E9962D39
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DBC3285734
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EB41A4F0E;
	Wed, 28 Aug 2024 16:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="amfwAyI+"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD7C1A3BD1
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 16:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724861034; cv=none; b=glIUEqSoK1XnFfQIg2Pv0ETdypfdjfwqSpcHeIRJ75WjPddtdujGOeGq7lDq16BaMhT6geE5/K6o1dr7DxuOXn6DXrGZuY9HyWRa8bwe68p20Sm2lyJ/DYouefony+2VGbYAgRvSnI0lqMGp+xgGQCX17J8jN5f4fjtrqi2JlRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724861034; c=relaxed/simple;
	bh=6lc/0TowARllWPS3Y80o0s8enD0/CNCX2NvstCPsOjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FqxmzRErUjYN30GT1ELZIVwU6FFokT1xBZmO8TcqHuyvleJGisAV5iurQxMFEw3e8iQSwg8jhw3dESRtpmrnEI0I8OrtrZg2Gjy7ScAhbe/crmWDWpej8G+BSte/sfvYrbnlTIgQZEBacXBQZtAQ2G7bA50tgZ41xskJJTmao6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=amfwAyI+; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-371a13c7c80so544514f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 09:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724861031; x=1725465831; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o2C0Ata5DnGBKpgrOPOJ9Qpj52V9oZzJPEy8talc8NA=;
        b=amfwAyI+H8asYCpTpbxBvz0x0TKxeywD6eZCjJWgmBct5gmm99vfSJq9tkRxgdHjzl
         sVdX0cQ1QyPbZHjq8oP6yEJxwBCGhPBJ0zG2Z/w/XBcFRCbV0h5rEJb9eltPeiG0Jf8B
         ptnkinZVTrBfUZJK/gFwdbVbBCKP2YaQaptPxzHp4u++QpZd5hvtHbjtXQfitQ7vUGVb
         YOGZr0+YGAoGrqlR03bdBObPIoEwc2HHrYk/Mp8W54GVEzwpuxCm1scKjGNnZ/8riwxD
         97CPcv6jYuvrpPQLtG4MpPuDOqMN8MRFJERXeq/vqSbTcR79jmH6by9XFpXsOYKgnKwt
         uRrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724861031; x=1725465831;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2C0Ata5DnGBKpgrOPOJ9Qpj52V9oZzJPEy8talc8NA=;
        b=ek82BjQgfkkqno5nSVq9bbTli1960IF/Ko1CSogX1lFPvZAWPXG8KOv3Dquyw0gYwT
         /l1iZVATtfOXCc/kFuWFrAFBZgw/7uuFh8wwHWDU0uX8Uy60aCJRUp+wFAQSmQO9U6sE
         8Lz24a2ie4ulPEVRwQklpuzAK7QQ0M4xkF9elDEH6iVMA36kwYhzCkHDteCuPxs91BXt
         GjF5ZIELZZ1S67YPZAiPTeoQu3w5c5tXP21e77z5e+mQWjtJ5WhY6nnUgQB3C7QFXP1O
         G9QYAzrIGMi3t5/MJioRYQEtNmcEBr9olpiAwLQOcIBYKUTwRIIiVXvIuXHiE1m8Ly/J
         uENQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM+iRTKi9X5VAlF6AKLUzpLlZ5+e4qpSbd42890idMgeSR7sREEOkiqFJdI7UJNb3U42B7fnXAhTrLjL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCHMfoULMRApWS9SgQ8mhaySl4+joRrIZT0EkMoHNIBzI/kG7g
	j2YNdH9mBQVCvhBVQWwUnv9GQdhsJX/pdoWi5utifBqhgjd7ZKL95iAeQCywlz8=
X-Google-Smtp-Source: AGHT+IHvuPcJW8cEF/aAGTjwURVAhubJtGabQ01KMZXeK1b8TtkqlbqetIk/BSaMtAYnDBF6QArDOw==
X-Received: by 2002:adf:9b8f:0:b0:363:ac4d:c44f with SMTP id ffacd0b85a97d-3749b54b1f8mr42849f8f.17.1724861029903;
        Wed, 28 Aug 2024 09:03:49 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749b22da51sm153232f8f.15.2024.08.28.09.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 09:03:49 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 28 Aug 2024 18:03:40 +0200
Subject: [PATCH 2/2] drm/panel: visionox-vtdr6130: switch to
 devm_regulator_bulk_get_const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-topic-sm8x50-upstream-vtdr6130-multi-v1-2-0cae20d4c55d@linaro.org>
References: <20240828-topic-sm8x50-upstream-vtdr6130-multi-v1-0-0cae20d4c55d@linaro.org>
In-Reply-To: <20240828-topic-sm8x50-upstream-vtdr6130-multi-v1-0-0cae20d4c55d@linaro.org>
To: Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Doug Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2689;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=6lc/0TowARllWPS3Y80o0s8enD0/CNCX2NvstCPsOjQ=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmz0piSlPdFi79yS2eRARm4Yw4O94DArWL02Xvc4e0
 5xAIc+CJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZs9KYgAKCRB33NvayMhJ0f4mD/
 9T/TEyl6b35MYJ4t7Sup6k2/8ibDWGQTqsL1VG8DAV62i98cFQASpEL8UXyOe9BGdEfFbExFYqpbJ6
 TWg9p+FjpbgVEAqg+ZSb7srDuMVXLpu1Z9bJcWKEQcm68ee4mrWAdsyKrxsdyiqytLtIOq5Sy8wHcI
 RobGyJzY4ECVSkjRDeHO9T9jQbmUeqEseZ1HI0BV7r3TND6iQkASdF8YsGwQqmf9dx7keJez1dp7gj
 RKWBqzqJWjvHC8/aMC2siasLSyp/pWBLHJxlm6tl++ven7uebVJg1mgQnLdynFH5kUVdT4LKLaUusY
 wdF35FlL95y85vZ74QLiCGoOauhSanIF+pi2Qj9QQqO1C/rSNUP1OqIkAQ2FMOESupeXrxV572hpYi
 GII/A9IirtLJVFaQPWnWwlDYD1aX+rznfj7CNj2ZVYdw7YUfFKWViSeg3LCzPJKXVBE18cBAjSCiKV
 kXB83hXH8+1yEunIm1B6gKp8NoNpTWYQvLC3y+/RouvIB4vFqhsgOR6c7LxEHp5irbhMrjMg3TYrRD
 S2T/Jr8CAR/NY400y3xcO9+YrUJ9QtvRL+GUJ6Ub5BEY38d7BUO6FcoHmuvE/4O8w3EElK+BYfuxr7
 mSUPGYWitcjntN+xegNK9NttmAvFDRciE1+1jDE1rHjAU7V+VTkHHNcpEnGA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Switch to devm_regulator_bulk_get_const() to stop setting the supplies
list in probe(), and move the regulator_bulk_data struct in static const.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/gpu/drm/panel/panel-visionox-vtdr6130.c | 26 +++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
index ebe92871dbb6..17b8defe79c1 100644
--- a/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
+++ b/drivers/gpu/drm/panel/panel-visionox-vtdr6130.c
@@ -19,7 +19,13 @@ struct visionox_vtdr6130 {
 	struct drm_panel panel;
 	struct mipi_dsi_device *dsi;
 	struct gpio_desc *reset_gpio;
-	struct regulator_bulk_data supplies[3];
+	struct regulator_bulk_data *supplies;
+};
+
+static const struct regulator_bulk_data visionox_vtdr6130_supplies[] = {
+	{ .supply = "vddio" },
+	{ .supply = "vci" },
+	{ .supply = "vdd" },
 };
 
 static inline struct visionox_vtdr6130 *to_visionox_vtdr6130(struct drm_panel *panel)
@@ -139,7 +145,7 @@ static int visionox_vtdr6130_prepare(struct drm_panel *panel)
 	struct visionox_vtdr6130 *ctx = to_visionox_vtdr6130(panel);
 	int ret;
 
-	ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies),
+	ret = regulator_bulk_enable(ARRAY_SIZE(visionox_vtdr6130_supplies),
 				    ctx->supplies);
 	if (ret < 0)
 		return ret;
@@ -149,7 +155,8 @@ static int visionox_vtdr6130_prepare(struct drm_panel *panel)
 	ret = visionox_vtdr6130_on(ctx);
 	if (ret < 0) {
 		gpiod_set_value_cansleep(ctx->reset_gpio, 1);
-		regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+		regulator_bulk_disable(ARRAY_SIZE(visionox_vtdr6130_supplies),
+				       ctx->supplies);
 		return ret;
 	}
 
@@ -164,7 +171,8 @@ static int visionox_vtdr6130_unprepare(struct drm_panel *panel)
 
 	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
 
-	regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
+	regulator_bulk_disable(ARRAY_SIZE(visionox_vtdr6130_supplies),
+			       ctx->supplies);
 
 	return 0;
 }
@@ -244,12 +252,10 @@ static int visionox_vtdr6130_probe(struct mipi_dsi_device *dsi)
 	if (!ctx)
 		return -ENOMEM;
 
-	ctx->supplies[0].supply = "vddio";
-	ctx->supplies[1].supply = "vci";
-	ctx->supplies[2].supply = "vdd";
-
-	ret = devm_regulator_bulk_get(&dsi->dev, ARRAY_SIZE(ctx->supplies),
-				      ctx->supplies);
+	ret = devm_regulator_bulk_get_const(&dsi->dev,
+					    ARRAY_SIZE(visionox_vtdr6130_supplies),
+					    visionox_vtdr6130_supplies,
+					    &ctx->supplies);
 	if (ret < 0)
 		return ret;
 

-- 
2.34.1


