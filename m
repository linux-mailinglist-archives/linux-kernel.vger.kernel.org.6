Return-Path: <linux-kernel+bounces-566158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F30A9A67401
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 13:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 105FE7A3EFF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 12:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F8F20C02D;
	Tue, 18 Mar 2025 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="el73fLUI"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B793B1714B2
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742301426; cv=none; b=sMtQhD6hIpgGS3Eaxw/VLGP+7C4GIU+yz8nulWMWsH3ORuknFy8Z+dABNQl4l9rLejwPl/vaH/3Ej4u62n9jdyqu0obCIAY325WJDk0XScjU5yEj3MOfTqfDtGl6o04vYtl8sDihQv2Wl9BIQraA8fdyh8ClKMJydiSzJGK1jZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742301426; c=relaxed/simple;
	bh=fxTM9jWXIqtdXeG5zNaE7jOjW6PrCbSkzsQR1cv6hCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rKDmfwzR3x1YRJSi0ywp7w0k1hCCKCn95XP4v2hD1DM0jJi6vsjLRG+c7naK5Yh+3LPYJCHyd9eWlNR9YGzJo59VVuuCt0FWXVu6HtE4PjhzmUrzmBIexXR2XKfOF0Ar/LxubvLpQaBAmT1Izc1W+epK7HeI6npQ/6UQWAmd+lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=el73fLUI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742301423;
	bh=fxTM9jWXIqtdXeG5zNaE7jOjW6PrCbSkzsQR1cv6hCY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=el73fLUIM4EsSrSxgBxJTwe33XOBY4xUeVSlZZcCqzc/xdcxVCSbYdpijhTFlPE93
	 r8gU0GcVeIKhu4ba0i1k4/+oSSyRoyMtsi+7WabdjcPRBXkFmXo0fd9gVuneiQq0PL
	 lWmanueETJ1llbE3YSFMcTm8OThiMESEa5RTWTqvw0k47ulA3hSAN6YYVHIdrL5ygi
	 News/XqSmKdloNXRcY6RfMqP7qmNW3WuKzlbFz43BfEV2W1nJPegA8EfUa3tOCTxIh
	 yMs3/oqHk/et0Fw1MHw18bpAtRHbCriExBYgiSoIgvHr7md9FqBr5HoHW/Hf8YBPim
	 DBFofWX6imFiw==
Received: from localhost (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 1B07B17E105F;
	Tue, 18 Mar 2025 13:37:03 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 18 Mar 2025 14:35:40 +0200
Subject: [PATCH v6 06/14] phy: rockchip: samsung-hdptx: Drop unused phy_cfg
 driver data
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-phy-sam-hdptx-bpc-v6-6-8cb1678e7663@collabora.com>
References: <20250318-phy-sam-hdptx-bpc-v6-0-8cb1678e7663@collabora.com>
In-Reply-To: <20250318-phy-sam-hdptx-bpc-v6-0-8cb1678e7663@collabora.com>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: Algea Cao <algea.cao@rock-chips.com>, Sandor Yu <Sandor.yu@nxp.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Maxime Ripard <mripard@kernel.org>, kernel@collabora.com, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2

There is no usage of phy_cfg in the upstream driver data, nor in the
downstream one, hence remove it.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 70621687b5eb3581a81af20b23d0be53263003bb..c9f79c4e698cef405dd2b6a8c1071e296464c36e 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -397,7 +397,6 @@ struct rk_hdptx_phy {
 	int phy_id;
 
 	struct phy *phy;
-	struct phy_config *phy_cfg;
 	struct clk_bulk_data *clks;
 	int nr_clks;
 	struct reset_control_bulk_data rsts[RST_MAX];

-- 
2.48.1


