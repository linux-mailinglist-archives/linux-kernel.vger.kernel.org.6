Return-Path: <linux-kernel+bounces-221906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A85BC90FA5D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 02:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C177F1C212F1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 00:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50A3BA34;
	Thu, 20 Jun 2024 00:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KVwhvj1w"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653601C36;
	Thu, 20 Jun 2024 00:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718843911; cv=none; b=KQ0Xh1SQwuc/+z+w7tQkhqgZarNkOkjSkiAcfnYv40oPEixMN0ezSwzVoImL4dJAYv/8KHU8CHA/v1joXg7RDWL27nqRSDvXx86pT+2o3WLSTScVcOy9dhL1R2bvw8z24g+sJvgoERI9mY0E/c2RgxnjuYYUjahgCxIJcI+lK3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718843911; c=relaxed/simple;
	bh=QI8oLnBKRdVBxplRPUjRHnwbLIWBkQTRxexqV3uq0kg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qVJ7KC263rjmcp5GXLyAmCMUtlLtNy6UN8xIl3TPkuqdzZ89l9m2VilKeLAfqsWK1OaNH3i5Z5ZkQet9N1hVljSPaCM1/eBdnxJ0vBuabr2Wyo4IFB4B/4pceCh6u7bwUOJqBiN6NtDQOfk+J0TmAwfVxGsnN9p6ehqLcLrZ2Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KVwhvj1w; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1718843907;
	bh=QI8oLnBKRdVBxplRPUjRHnwbLIWBkQTRxexqV3uq0kg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KVwhvj1wOtH/PH+upURaF2rw1Za+iMke+XA0xYsUIKkReIH73u0XYhGWuyHeoZIaB
	 dUggqrF4a2sbMHaiDs/cwTV7N/hqZ/jC9G9NmWBBwxVy/bcx30AvJxtG3sANwgL7l0
	 jIo1oSlkGi4YjQXVNcQeY8Z84x0EippYH3Upqp1Ii25ege213NGaOC89TEYVJdkFNr
	 cD4mZeMJx6WD9qC7guWfvcN7HyZgb1F3A51tEBgZ893hw1s39vlHPJSgj3lgbEYhh8
	 0URMGifTsc6to9nYqa4TsKzJb+se/gxt98Juh+ZATPQPPdGSApyarkWpqaHl3rcpzV
	 iggdK1tLVIDmA==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 79AE337821AA;
	Thu, 20 Jun 2024 00:38:27 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Thu, 20 Jun 2024 03:36:23 +0300
Subject: [PATCH v2 2/4] phy: phy-rockchip-samsung-hdptx: Enable runtime PM
 at PHY core level
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240620-rk3588-hdmiphy-clkprov-v2-2-6a2d2164e508@collabora.com>
References: <20240620-rk3588-hdmiphy-clkprov-v2-0-6a2d2164e508@collabora.com>
In-Reply-To: <20240620-rk3588-hdmiphy-clkprov-v2-0-6a2d2164e508@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>, Algea Cao <algea.cao@rock-chips.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: kernel@collabora.com, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.0

When a new PHY is created via [devm_]phy_create(), the runtime PM for it
is not enabled unless the parent device (which creates the PHY) has its
own runtime PM already enabled.

Move the call to devm_pm_runtime_enable() before devm_phy_create() to
enable runtime PM at PHY core level.

With this change the ->power_on() and ->power_off() callbacks do not
require explicit runtime PM management anymore, since the PHY core
handles that via phy_pm_runtime_{get,put}_sync() when phy_power_on() and
phy_power_off() are invoked.

Hence drop the now unnecessary calls to pm_runtime_resume_and_get() and
pm_runtime_put() helpers.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 24 ++++++-----------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 3bd9b62b23dc..72de287282eb 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -860,7 +860,7 @@ static int rk_hdptx_ropll_tmds_mode_config(struct rk_hdptx_phy *hdptx,
 static int rk_hdptx_phy_power_on(struct phy *phy)
 {
 	struct rk_hdptx_phy *hdptx = phy_get_drvdata(phy);
-	int ret, bus_width = phy_get_bus_width(hdptx->phy);
+	int bus_width = phy_get_bus_width(hdptx->phy);
 	/*
 	 * FIXME: Temporary workaround to pass pixel_clk_rate
 	 * from the HDMI bridge driver until phy_configure_opts_hdmi
@@ -871,17 +871,7 @@ static int rk_hdptx_phy_power_on(struct phy *phy)
 	dev_dbg(hdptx->dev, "%s bus_width=%x rate=%u\n",
 		__func__, bus_width, rate);
 
-	ret = pm_runtime_resume_and_get(hdptx->dev);
-	if (ret) {
-		dev_err(hdptx->dev, "Failed to resume phy: %d\n", ret);
-		return ret;
-	}
-
-	ret = rk_hdptx_ropll_tmds_mode_config(hdptx, rate);
-	if (ret)
-		pm_runtime_put(hdptx->dev);
-
-	return ret;
+	return rk_hdptx_ropll_tmds_mode_config(hdptx, rate);
 }
 
 static int rk_hdptx_phy_power_off(struct phy *phy)
@@ -894,8 +884,6 @@ static int rk_hdptx_phy_power_off(struct phy *phy)
 	if (ret == 0 && (val & HDPTX_O_PLL_LOCK_DONE))
 		rk_hdptx_phy_disable(hdptx);
 
-	pm_runtime_put(hdptx->dev);
-
 	return ret;
 }
 
@@ -977,6 +965,10 @@ static int rk_hdptx_phy_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(hdptx->grf),
 				     "Could not get GRF syscon\n");
 
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
+
 	hdptx->phy = devm_phy_create(dev, NULL, &rk_hdptx_phy_ops);
 	if (IS_ERR(hdptx->phy))
 		return dev_err_probe(dev, PTR_ERR(hdptx->phy),
@@ -986,10 +978,6 @@ static int rk_hdptx_phy_probe(struct platform_device *pdev)
 	phy_set_drvdata(hdptx->phy, hdptx);
 	phy_set_bus_width(hdptx->phy, 8);
 
-	ret = devm_pm_runtime_enable(dev);
-	if (ret)
-		return dev_err_probe(dev, ret, "Failed to enable runtime PM\n");
-
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 	if (IS_ERR(phy_provider))
 		return dev_err_probe(dev, PTR_ERR(phy_provider),

-- 
2.45.2


