Return-Path: <linux-kernel+bounces-267533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C76394128D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8341F24BD7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 12:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92A21A01BF;
	Tue, 30 Jul 2024 12:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TtmWtFyl"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1C118E77B
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 12:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722343840; cv=none; b=LsJpfZ+f0T2Ad1AkrBWUZmiV+eATHf3LsaGY+ull0griXuP6BonpWzZgk2O2n44djJrtemOjO3kN2UbaRkiklwcB1OW6rNg9OpHl0tHXtQ2o7JcdyF7lUV6MXhdJvy5vkP+GtpSUI61dPnzIogB98fuEffnuGjmDVo7JQCSz8OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722343840; c=relaxed/simple;
	bh=qRmlXTh0lJZ9LAW465AGOONHnfyWzyrOMHm/2OYPDrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpmgzxxD7WeA1+Sq1aHppY89oyPJTOJ/w8kUIoepXgjPcLm+bmE6N8qegaH4DC3GVghGuiEO82SGlsnleQIdxH+AlRMI1kXJqblh+/uEqE/bvl3LPO3a2FEYU3GcS1DBPRGGXBAghS6Uk65nrCTEeVJzz1RpZH9udPdnqjF66t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TtmWtFyl; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-427fc97a88cso27071395e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jul 2024 05:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722343837; x=1722948637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kFGOubNsNVn1OpgYJCvY0DMJojSWylMPMeeJsgWseOI=;
        b=TtmWtFyl7HqnY/4yXeAs9bekGhovlwXkkpPJ91LZog/THUEPfg5ipuPxXCorEogBkT
         /JNu2SZeAJPHsf9atVd0jGq4LVjAWzhfsjTb1SWGA8c3Pxc/4iqtJ1Dg+32r7IUodSdH
         YsxPsvlxDjsoSub6wC5mWvQftNwhfAnOxuJCgM9LHJkl0HEX/OEu0gPMgKJuoyLAXwmC
         rnYNudWjSWAmOW1bielBvmDjv3wucbiykbasR0h50CEaa2w1mIiSBsvsM9Bo2dUK5P1M
         iI+54SJihO84D2NAroiK9KPE3MW5pt4ZAjLzr6VhZmz7Oxt1hOsJB1OQ8OTOpLtCu8E7
         YDiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722343837; x=1722948637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kFGOubNsNVn1OpgYJCvY0DMJojSWylMPMeeJsgWseOI=;
        b=wepDPIX8XXWzY0ku48OyMwtMmECDlnK0KsbE3w8Xn9No3qTy8r9P7saQ5M39rQ2b6m
         JUOZSk/jRzjFys9BvKOYJ5iDA0SngZDm7R9zRJdWCN60ls4QgOX6FWwJS4DxVbcU7c/B
         XpALI7O9/J+x/cJwRfNSaao28rrGtzHrTSRxy5wrGlMwMaB7Xzl8pLhNwHST7SHuHTjw
         ysXoKm1VqJ/BOTreIdnhRVlO7qEr/ZsqAcmtpeX33griV50RufEECjnOpqucbOILbWBT
         s8LagE511mkiDqZkIP5OpTkiJ1IL42tn3MBw6wYrUS5ct8Jl0x6HMvgDx9eaEmoOfkz2
         4/rg==
X-Forwarded-Encrypted: i=1; AJvYcCXP/OtmPH3B7jo0jwbuU49XwQ8Udcko170We9yoDHYaAmySyO0kH1wANH+3CkWI+AcHUsXJ0nAI7N9fEQlx1OHY6riq54suleFT1/o6
X-Gm-Message-State: AOJu0YzDog0hbzaDSDeOO3h35Y617+aXRpD1qRh3c429TEK+GwJQ4EA9
	H5QgaTf1HpTG4E779vb6b2FuDe0aEFBWOkN8Hykn65wIu2OyMugHA0jq3GrAG6E=
X-Google-Smtp-Source: AGHT+IFYy4B/g5w5Y3B19jbk4N8IBnPQwvEBCaNr6l0tavtJI1kbi8Yq6wQAsMTGuLdyiEwuv2pLaA==
X-Received: by 2002:a05:600c:3b07:b0:426:4978:65f0 with SMTP id 5b1f17b1804b1-42811d9e0dcmr82301025e9.18.1722343837035;
        Tue, 30 Jul 2024 05:50:37 -0700 (PDT)
Received: from toaster.lan ([2a01:e0a:3c5:5fb1:291e:4a48:358e:6f49])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42805730e68sm216521405e9.9.2024.07.30.05.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 05:50:36 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	dri-devel@lists.freedesktop.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] drm/meson: dw-hdmi: use generic clock helpers
Date: Tue, 30 Jul 2024 14:50:13 +0200
Message-ID: <20240730125023.710237-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730125023.710237-1-jbrunet@baylibre.com>
References: <20240730125023.710237-1-jbrunet@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit

The Amlogic HDMI phy driver is not doing anything with the clocks
besides enabling on probe. CCF provides generic helpers to do that.

Use the generic clock helpers rather than using a custom one to get and
enable clocks.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/gpu/drm/meson/meson_dw_hdmi.c | 36 +++------------------------
 1 file changed, 3 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/meson/meson_dw_hdmi.c b/drivers/gpu/drm/meson/meson_dw_hdmi.c
index bcf4f83582f2..2890796f9d49 100644
--- a/drivers/gpu/drm/meson/meson_dw_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_dw_hdmi.c
@@ -619,29 +619,6 @@ static void meson_dw_hdmi_init(struct meson_dw_hdmi *meson_dw_hdmi)
 
 }
 
-static void meson_disable_clk(void *data)
-{
-	clk_disable_unprepare(data);
-}
-
-static int meson_enable_clk(struct device *dev, char *name)
-{
-	struct clk *clk;
-	int ret;
-
-	clk = devm_clk_get(dev, name);
-	if (IS_ERR(clk)) {
-		dev_err(dev, "Unable to get %s pclk\n", name);
-		return PTR_ERR(clk);
-	}
-
-	ret = clk_prepare_enable(clk);
-	if (!ret)
-		ret = devm_add_action_or_reset(dev, meson_disable_clk, clk);
-
-	return ret;
-}
-
 static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 				void *data)
 {
@@ -651,6 +628,7 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 	struct drm_device *drm = data;
 	struct meson_drm *priv = drm->dev_private;
 	struct dw_hdmi_plat_data *dw_plat_data;
+	struct clk_bulk_data *clks;
 	int irq;
 	int ret;
 
@@ -701,17 +679,9 @@ static int meson_dw_hdmi_bind(struct device *dev, struct device *master,
 	if (IS_ERR(meson_dw_hdmi->hdmitx))
 		return PTR_ERR(meson_dw_hdmi->hdmitx);
 
-	ret = meson_enable_clk(dev, "isfr");
-	if (ret)
-		return ret;
-
-	ret = meson_enable_clk(dev, "iahb");
+	ret = devm_clk_bulk_get_all_enable(dev, &clks);
 	if (ret)
-		return ret;
-
-	ret = meson_enable_clk(dev, "venci");
-	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "Failed to enable all clocks\n");
 
 	dw_plat_data->regm = devm_regmap_init(dev, NULL, meson_dw_hdmi,
 					      &meson_dw_hdmi_regmap_config);
-- 
2.43.0


