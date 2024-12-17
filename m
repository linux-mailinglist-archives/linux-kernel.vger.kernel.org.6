Return-Path: <linux-kernel+bounces-449895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE67D9F5784
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 21:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C6F18900B7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 20:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C851F9411;
	Tue, 17 Dec 2024 20:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=derek.foreman@collabora.com header.b="eEweObNW"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E9B1D9A48
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 20:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734466677; cv=pass; b=TzTjReY2AH7nba8yxx4qX9NbXq/nrKbGAUiGDFziArnsO4/Llfk6gr3h4kb78SKrqTXOgycLj3PYXovNujt8D9aFfBQtw3ms0W0bYUYjeSCM9QI1+GA7zYuTun2Oxxx4Jyh6iR+alKukaVICMnIKHfuz2+m2a1runCsdtbL/WwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734466677; c=relaxed/simple;
	bh=5IIoXOdIysaeX9dtIN3IJl57s/JJzEOG++dIauQhNGY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PAlxWkGg+UXUsylKYZhJGagrrNIcaHqcJWeT1/zFibX1jip9SB1hKpBnM6JH5MX3jyyoF/d4DUXlgb69liaNhGXsi77Sg2uKVypnEc6Ptn4BsS+KdZpEP0CsApleuEIhlsqv0dmcQBvunYtQONgKGRQ+48HchjgJExx81zT61V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=derek.foreman@collabora.com header.b=eEweObNW; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1734466644; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aqDfAGDK7mX2EqvbeqXWjB7qnHyvMZcbrIj//lpApUyMlrZfxsJuFJ9DCXAKcvq/EhH1lmWLSF6/BUaCTWM8bVZLss1B8SYeCmyIemgXkV+4op3JGzFpz8Tt+W/gP3JjzL5SJJmNFPlklvXkoG5X7eiJvlsZzN9ssQTRG2f2zm8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1734466644; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jg83Q2oVU4lXu4Mv8M8jYyiHKvWW+8+1IP4WxXXIwmQ=; 
	b=Q/BC6FTAKoJpFiGhschv8pcnir7UdyhwCkf5Z6B8smOH3206ob3L9QI+z2sHgkJ2SGtrqSQAayGwsGykn8cfxGtOrzkvDSFXHRhFclH5AaDTkgO7fbyX/AprfxDn/Xyb3kiYQ7r6BhnTXVb2QfFvVGIDPS8bZIKtWvxQvotIAMs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=derek.foreman@collabora.com;
	dmarc=pass header.from=<derek.foreman@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734466644;
	s=zohomail; d=collabora.com; i=derek.foreman@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=jg83Q2oVU4lXu4Mv8M8jYyiHKvWW+8+1IP4WxXXIwmQ=;
	b=eEweObNWXybKvUEAnW484esoWsyVWo/Yf0jD/TGapY6yugdr8pz71hvJ/3efwPpE
	43m6SYZzgcpi4b6z41/mj8GCS7+71PkUNfvuKiPYVz2Bx+nKYVfRi0y2Kzvni9vBvQ9
	kue/luD9beAvOMcwervCIhNI06nPyH1vjWAwqeTQ=
Received: by mx.zohomail.com with SMTPS id 1734466642641430.9536683331079;
	Tue, 17 Dec 2024 12:17:22 -0800 (PST)
From: Derek Foreman <derek.foreman@collabora.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Algea Cao <algea.cao@rock-chips.com>,
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Derek Foreman <derek.foreman@collabora.com>,
	kernel@collabora.com,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/rockchip: Don't change hdmi reference clock rate
Date: Tue, 17 Dec 2024 14:17:07 -0600
Message-ID: <20241217201708.3320673-1-derek.foreman@collabora.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The code that changes hdmi->ref_clk was accidentally copied from
downstream code that sets a different clock. We don't actually
want to set any clock here at all.

Setting this clock incorrectly leads to incorrect timings for
DDC, CEC, and HDCP signal generation.

No Fixes listed, as the theoretical timing error in DDC appears to
still be within tolerances and harmless - and HDCP and CEC are not
yet supported.

Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index e498767a0a66..cebd72bf1ef2 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -54,7 +54,6 @@ struct rockchip_hdmi_qp {
 	struct regmap *regmap;
 	struct regmap *vo_regmap;
 	struct rockchip_encoder encoder;
-	struct clk *ref_clk;
 	struct dw_hdmi_qp *hdmi;
 	struct phy *phy;
 	struct gpio_desc *enable_gpio;
@@ -81,7 +80,6 @@ static void dw_hdmi_qp_rockchip_encoder_enable(struct drm_encoder *encoder)
 	if (crtc && crtc->state) {
 		rate = drm_hdmi_compute_mode_clock(&crtc->state->adjusted_mode,
 						   8, HDMI_COLORSPACE_RGB);
-		clk_set_rate(hdmi->ref_clk, rate);
 		/*
 		 * FIXME: Temporary workaround to pass pixel clock rate
 		 * to the PHY driver until phy_configure_opts_hdmi
@@ -330,17 +328,6 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 		return ret;
 	}
 
-	for (i = 0; i < ret; i++) {
-		if (!strcmp(clks[i].id, "ref")) {
-			hdmi->ref_clk = clks[1].clk;
-			break;
-		}
-	}
-	if (!hdmi->ref_clk) {
-		drm_err(hdmi, "Missing ref clock\n");
-		return -EINVAL;
-	}
-
 	hdmi->enable_gpio = devm_gpiod_get_optional(hdmi->dev, "enable",
 						    GPIOD_OUT_HIGH);
 	if (IS_ERR(hdmi->enable_gpio)) {
-- 
2.45.2


