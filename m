Return-Path: <linux-kernel+bounces-174471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F318C0F48
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 14:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22A1C1C20AF1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 12:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6F114EC56;
	Thu,  9 May 2024 12:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S4k958xo"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8E414BFAB;
	Thu,  9 May 2024 12:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715256448; cv=none; b=FROmdvKhT5pAgllUqBP3xgM8b5nPr3UvfX1mYn8jd/Hu9ed7zjn0NJkLJwTSCYF1qWehtYoumufPYT20XaF6vGVyI0CoiDQwnY0aYHj+KaHYDjaT8SbRaJ/9qxf9Uhn4Pi3qrUoOESRqCBRC7nu0zdIJA8T8I5Rsm8gszeugCuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715256448; c=relaxed/simple;
	bh=sGGeW//7ieucPKqK6xhCiFsbFbyWjbSB0+Tb1XQxe9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uz/j8+8gVVcR1qKBA2Wn5Cb6N8Mz+jzIixa/Er3UXil0ViqZldQGuCthMZuKOVexwk+/3nRFLWLwXX43X5hLis7/pstf1h2c9f9YXTkb4Hwu/w3HGaceNQ+JiuYaz20cZaEk3LCJg2Bn587+DwxbYAeXYiJcbQOsnJzj9nh1XRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S4k958xo; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51fb14816f6so1061580e87.0;
        Thu, 09 May 2024 05:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715256445; x=1715861245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q8klZW1X3Sda14Lq0eRI1WDVW4JJJl7xuMqHEZ5sEhE=;
        b=S4k958xo1qyeosNK4Mrxn8jlYFTfqdvrdl9hfJi9g3mjyiQY063BBVnUccM0fWUWz0
         X1+N17W2COTTs9EZ3/Z2YPm2fiNV89j5XCS5YXkky2RrmXD6BjGF5mZjKjXGx08R4nBp
         r2F7zWlLWLPJKGHLpAdgpKU3h6Uy7I6dn4cc/4MXKp2Eg0qkFC4LdFr/uHefq7TKBbmP
         XBkZHDiYs43QIovOdX0zTXC18cRwATW0+MAx0pfArXyC7X4+Jc/FB0SwaQpFcBHMsAEC
         yISpvz5/ulLmR3opPPSrpMJq7ki9A+DGAA21OJJCYt+lF9eM5F9PTEx8YrTWRtTZlkCF
         s86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715256445; x=1715861245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8klZW1X3Sda14Lq0eRI1WDVW4JJJl7xuMqHEZ5sEhE=;
        b=iNOigJd9PNSfghxWBNyTPQf0c62Hg99KILAzVyf1oWVWTetwHMADh077bitQ/+b2Yq
         M5DysfkzCmHXpJp3M0j03kj/92xq5bmJ0qV00zTrYLnc1l+doDVSK98O8LtfG2pA8RSC
         MIfSGLaZk17fYykAktx1UVw+bbtkDC+0y8HJxLRLlj9XL3Cx3D0iLk6bhU1opNQUKust
         2qG9NrH3dUHUSwtM8SG392ebmk9/G4URGhe+0YNztP4PlZdNB3u8ebnbZR68a8IdLuha
         6hyO9maGCLV534O9o7wFDpj9EWpt8+4pn2bFPmE+Kk3+4YYsAnwAtAN8tbNY8ic2xatr
         Ou3w==
X-Forwarded-Encrypted: i=1; AJvYcCXVMOaQwkYPMNvIUbsECNYhBj6uJyW0Az5lgABcVOcjPJ1PItHKefQ2dolznZHXguK2kejIxClZonSfHRM81WXAtzpQ3m5UK244ZOkMnUUf6awsIAryM7yXXj2EQeBmqZgEXcicZxSJG7+EzVhu+XA58LmfR25eIOM5gE1PR/4j3/a6ag==
X-Gm-Message-State: AOJu0Yx9JFL6CyX4tDcqmX5KoaFUtCsFKyff1QLyQ49Uliv3qZ8g9V8S
	9NXftgxRmr2oFIsLKEELu0qoiNHETyBgFx0aNtnA2qEcDEAYCBQ=
X-Google-Smtp-Source: AGHT+IFecuxCJWM/nUWDhGJ7gBSfItZDqcg8FMCaOxeHy6FMY+wOyJdPzB48iweW2PiFVOX6Z6J58A==
X-Received: by 2002:a05:6512:210a:b0:51d:9921:20f7 with SMTP id 2adb3069b0e04-5217c56f496mr3116279e87.40.1715256445211;
        Thu, 09 May 2024 05:07:25 -0700 (PDT)
Received: from U4.lan ([2a02:810b:f40:4600:b44:d8c3:6fa8:c46f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce1912sm24112005e9.11.2024.05.09.05.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 05:07:24 -0700 (PDT)
From: Alex Bee <knaerzche@gmail.com>
To: Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 4/7] drm/rockchip: dsi: Support optional AHB clock
Date: Thu,  9 May 2024 14:07:12 +0200
Message-ID: <20240509120715.86694-5-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240509120715.86694-1-knaerzche@gmail.com>
References: <20240509120715.86694-1-knaerzche@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some integrations of the IP additionally have an AHB clock which has to be
enabled before accessing the registers is possible.

Add support for it as an optional clock.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
changes since v1:
 - new patch

 .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
index 4cc8ed8f4fbd..6ed64cc35275 100644
--- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
@@ -265,6 +265,7 @@ struct dw_mipi_dsi_rockchip {
 	struct clk *pllref_clk;
 	struct clk *grf_clk;
 	struct clk *phy_cfg_clk;
+	struct clk *ahb_clk;
 
 	/* dual-channel */
 	bool is_slave;
@@ -1153,7 +1154,15 @@ static int dw_mipi_dsi_dphy_init(struct phy *phy)
 			goto err_init;
 		}
 
+		ret = clk_prepare_enable(dsi->ahb_clk);
+		if (ret) {
+			clk_disable_unprepare(dsi->grf_clk);
+			clk_disable_unprepare(dsi->pclk);
+			goto err_init;
+		}
+
 		ret = dsi->cdata->dphy_rx_init(phy);
+		clk_disable_unprepare(dsi->ahb_clk);
 		clk_disable_unprepare(dsi->grf_clk);
 		clk_disable_unprepare(dsi->pclk);
 		if (ret < 0)
@@ -1240,6 +1249,12 @@ static int dw_mipi_dsi_dphy_power_on(struct phy *phy)
 		goto err_phy_cfg_clk;
 	}
 
+	ret = clk_prepare_enable(dsi->ahb_clk);
+	if (ret) {
+		DRM_DEV_ERROR(dsi->dev, "Failed to enable ahb_clk: %d\n", ret);
+		goto err_ahb_clk;
+	}
+
 	/* do soc-variant specific init */
 	if (dsi->cdata->dphy_rx_power_on) {
 		ret = dsi->cdata->dphy_rx_power_on(phy);
@@ -1269,6 +1284,8 @@ static int dw_mipi_dsi_dphy_power_on(struct phy *phy)
 	return ret;
 
 err_pwr_on:
+	clk_disable_unprepare(dsi->ahb_clk);
+err_ahb_clk:
 	clk_disable_unprepare(dsi->phy_cfg_clk);
 err_phy_cfg_clk:
 	clk_disable_unprepare(dsi->grf_clk);
@@ -1296,6 +1313,7 @@ static int dw_mipi_dsi_dphy_power_off(struct phy *phy)
 			DRM_DEV_ERROR(dsi->dev, "hardware-specific phy shutdown failed: %d\n", ret);
 	}
 
+	clk_disable_unprepare(dsi->ahb_clk);
 	clk_disable_unprepare(dsi->grf_clk);
 	clk_disable_unprepare(dsi->pclk);
 
@@ -1429,6 +1447,13 @@ static int dw_mipi_dsi_rockchip_probe(struct platform_device *pdev)
 		}
 	}
 
+	dsi->ahb_clk = devm_clk_get_optional(dev, "ahb");
+	if (IS_ERR(dsi->ahb_clk)) {
+		ret = PTR_ERR(dsi->ahb_clk);
+		DRM_DEV_ERROR(dev, "Unable to get ahb_clk: %d\n", ret);
+		return ret;
+	}
+
 	dsi->grf_regmap = syscon_regmap_lookup_by_phandle(np, "rockchip,grf");
 	if (IS_ERR(dsi->grf_regmap)) {
 		DRM_DEV_ERROR(dev, "Unable to get rockchip,grf\n");
-- 
2.43.2


