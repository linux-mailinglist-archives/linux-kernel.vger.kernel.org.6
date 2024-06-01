Return-Path: <linux-kernel+bounces-197858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9988D701B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 15:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9888428212D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 13:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE831153838;
	Sat,  1 Jun 2024 13:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="agtYFt5D"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE891527A0;
	Sat,  1 Jun 2024 13:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717247594; cv=none; b=Ku3AaHhzjPfHH8CcaKHmjUVpSnjqG6m4xtDWB9GmoX17fUyXfYFoayJ/dEcx6Xc78cgAdgZgFg2KheReZOp8SP/WP4icVKA+Bh0Lpt/EST77/FRKId9h+p8hfl5k7oC+rL83abNUQJ0TZSlna1QiilnR0XB3VeW9KlZQkEIWLFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717247594; c=relaxed/simple;
	bh=HWApbGy8pFS7Vsa2ZQei9h62S5jglttPFVuJl0Mc/wg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gw6CVxXL7pTd6mY3JLU2jLm+nTm/Oq/aKRqETO5MjNOfvpN1oKCPIX0RLR52vjOpWKDQY5NrNcnfJtfZf8+2+h7yQAqHrCKnJpp0alPh4ttTzpTyoSCjAmG6I+nCy3TXLe/cN7U6g3ZQLZdQIU9tl+Tc2VBveX3w4yCvY1napMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=agtYFt5D; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717247591;
	bh=HWApbGy8pFS7Vsa2ZQei9h62S5jglttPFVuJl0Mc/wg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=agtYFt5DDg3nO7lz5aQBZfcHt7ybFymt5RNZ8V7F1OQviNjofhYujBm8El3xXarUR
	 nnoJjhRiL9BbHth0ks5MQStvyNpG1cSJ5aHsYfHHdRSHRO1lvwHniruBA1LQVAtS4t
	 B6U+BiF9dkmsrjN280u+545b2oeL5BWEuuJdvVJslEW31t5FPUuDMfDERbJCmK+cDv
	 ph6OW9gH/fz0eb/Ev2lkmqwLNsIqgpS9Kyg/ErRyg3/oRWuzZ8xcnA1pduFCW4Cf7q
	 FO3qTzNfU5mxfT3X/ijTSFBbavcSXKmB80T4D2U+KuNLB/+rGBT/B3pl3inSXp2pXG
	 l34MxYSQ8dW1w==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B37BB37821AE;
	Sat,  1 Jun 2024 13:13:10 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 01 Jun 2024 16:12:32 +0300
Subject: [PATCH 10/14] drm/rockchip: dw_hdmi: Use
 devm_regulator_get_enable()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240601-b4-rk3588-bridge-upstream-v1-10-f6203753232b@collabora.com>
References: <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
In-Reply-To: <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 Alexandre ARNOUD <aarnoud@me.com>, Luis de Arquer <ldearquer@gmail.com>
X-Mailer: b4 0.14-dev-f7c49

The regulators are only enabled at bind() and disabled at unbind(),
hence replace the boilerplate code by making use of
devm_regulator_get_enable() helper.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 34 +++++------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 7d07039ef096..edfd877c98fc 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -77,8 +77,6 @@ struct rockchip_hdmi {
 	struct clk *ref_clk;
 	struct clk *grf_clk;
 	struct dw_hdmi *hdmi;
-	struct regulator *avdd_0v9;
-	struct regulator *avdd_1v8;
 	struct phy *phy;
 };
 
@@ -236,15 +234,13 @@ static int rockchip_hdmi_parse_dt(struct rockchip_hdmi *hdmi)
 		return ret;
 	}
 
-	hdmi->avdd_0v9 = devm_regulator_get(hdmi->dev, "avdd-0v9");
-	if (IS_ERR(hdmi->avdd_0v9))
-		return PTR_ERR(hdmi->avdd_0v9);
+	ret = devm_regulator_get_enable(hdmi->dev, "avdd-0v9");
+	if (ret)
+		return ret;
 
-	hdmi->avdd_1v8 = devm_regulator_get(hdmi->dev, "avdd-1v8");
-	if (IS_ERR(hdmi->avdd_1v8))
-		return PTR_ERR(hdmi->avdd_1v8);
+	ret = devm_regulator_get_enable(hdmi->dev, "avdd-1v8");
 
-	return 0;
+	return ret;
 }
 
 static enum drm_mode_status
@@ -602,18 +598,6 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 		return ret;
 	}
 
-	ret = regulator_enable(hdmi->avdd_0v9);
-	if (ret) {
-		drm_err(hdmi, "failed to enable avdd0v9: %d\n", ret);
-		goto err_avdd_0v9;
-	}
-
-	ret = regulator_enable(hdmi->avdd_1v8);
-	if (ret) {
-		drm_err(hdmi, "failed to enable avdd1v8: %d\n", ret);
-		goto err_avdd_1v8;
-	}
-
 	if (hdmi->chip_data == &rk3568_chip_data) {
 		regmap_write(hdmi->regmap, RK3568_GRF_VO_CON1,
 			     HIWORD_UPDATE(RK3568_HDMI_SDAIN_MSK |
@@ -642,10 +626,7 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 
 err_bind:
 	drm_encoder_cleanup(encoder);
-	regulator_disable(hdmi->avdd_1v8);
-err_avdd_1v8:
-	regulator_disable(hdmi->avdd_0v9);
-err_avdd_0v9:
+
 	return ret;
 }
 
@@ -656,9 +637,6 @@ static void dw_hdmi_rockchip_unbind(struct device *dev, struct device *master,
 
 	dw_hdmi_unbind(hdmi->hdmi);
 	drm_encoder_cleanup(&hdmi->encoder.encoder);
-
-	regulator_disable(hdmi->avdd_1v8);
-	regulator_disable(hdmi->avdd_0v9);
 }
 
 static const struct component_ops dw_hdmi_rockchip_ops = {

-- 
2.45.0


