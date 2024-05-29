Return-Path: <linux-kernel+bounces-193550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AB08D2DA4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 08:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 445311F249A9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 06:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36666160797;
	Wed, 29 May 2024 06:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="H3asLmz3";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Bdfeg6gH"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF0C15FA86
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 06:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716965658; cv=none; b=Ur9DQzwYOKsMHJ0kqwR2PTRxAjdSKHqyhmJ3fzSGHiMZvJCTnsPvRDUxuKYQQpUHpDljTTeKbtQ/xXNxJSMteWnQoVY0zHoi993fTLDY3BkByepctNq7gk0fXa11Za86Lylk9pe8LBAhLFspsuljeL5lyuaXtaNNIF2lUaOAYmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716965658; c=relaxed/simple;
	bh=tgDydAauTjHJcYqMVKFui/vNccmBSP8D3EDfoDldvGs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EZvs63z0gn72hD0xtUVKM3XgRhvkc6Cl48tmIPmw+fZcSJaC0HYl2fT+Oke0j+u95MekwG8gbTjXrnYxBbINGNSBJJxVoKiQ04+UQJfkeovLcoo1DX5OLaPJNFi8+0GkjnTlt4hnGHmyt4DKcDtnAjTMZsgOXuEdZ+ic6XOjOvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=H3asLmz3; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Bdfeg6gH reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1716965655; x=1748501655;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QNRzo83mZGl9G2410HmioNDgIdVNX31t5SpCkoFYr+8=;
  b=H3asLmz3YGZaRi55ERBEPIbPVy5EA+g6s7hzy5bUkQfqDQ4hp8ZbetTf
   HxHzq4QJfhwD9nHrPS9nUG25kKXvCHu8WE2ciefzhlci+yvj7OpzxrCA5
   gLi3aG/KU2l/VU4oZbkGBU58Myn7N/T/FXdoP4rs3srzJrfFhd1QdF9Ph
   LYbi24+Rs7LpmrtzyDFbJkT7hWkDmWQXRvumM++m0B9Lbp91ZCxXZAWvG
   Sa6FlIMSmS+kLO9D2l8xEJSweQWJ3+crrC7WSvutyCKH2SYCmw4Vh4mjy
   B8SSX4epra9Bfn0v3DIUOWlhEARTNmpTy2GE86MOYZc4SI1sckpQ74XoB
   g==;
X-CSE-ConnectionGUID: SJwekOs4SRqwQrXOawD0mA==
X-CSE-MsgGUID: DYZpWyxERPibBz6M9pvhCA==
X-IronPort-AV: E=Sophos;i="6.08,197,1712613600"; 
   d="scan'208";a="37117803"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 29 May 2024 08:54:12 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 78F8F165466;
	Wed, 29 May 2024 08:54:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1716965648; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=QNRzo83mZGl9G2410HmioNDgIdVNX31t5SpCkoFYr+8=;
	b=Bdfeg6gH84Vlbe+i8jRR2jAr7aux6uMweLpkeI7vw7sP3H2weCpr9L3pkQ/FQQFpXu67Z6
	n9o2+XU0DjmRnsL6E9p7DoXxSmWDyn3kGa6UDEPKITRSPMzsm6Ay3AvRpJ0juX7uGRwerf
	toYPhm4AO86z2B0O51REBXe8G2/YfuNQL1l44tNk3fPT+P6v3eBG9Eb+x6g6icv0eSkCFb
	n1mcImCbeiR+Zue9qf2KX6iO0pXvrpjuwlcyLFE8dxhBCKhEsDb6w1/YBSsBvUNlz+rwIt
	MDjtTfp7Dm/CA6SesEOfykOEgvyiWeNfD7nX6yjtkO8Iv7NRLE0YEI/0pciNhA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Liu Ying <victor.liu@nxp.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
	dri-devel@lists.freedesktop.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/1] drm/bridge: imx93-mipi-dsi: Use dev_err_probe
Date: Wed, 29 May 2024 08:53:58 +0200
Message-Id: <20240529065400.461633-1-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Although very unlike to occur (media_blk_ctrl needs 'syscon' compatible
removed), it lines up with the other error paths in probe function.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
Changes in v2:
* Removed unused variable
* Added missing \n at end of string

 drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c b/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
index 2347f8dd632f9..13025f47f3902 100644
--- a/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/imx/imx93-mipi-dsi.c
@@ -834,18 +834,15 @@ static int imx93_dsi_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	struct imx93_dsi *dsi;
-	int ret;
 
 	dsi = devm_kzalloc(dev, sizeof(*dsi), GFP_KERNEL);
 	if (!dsi)
 		return -ENOMEM;
 
 	dsi->regmap = syscon_regmap_lookup_by_phandle(np, "fsl,media-blk-ctrl");
-	if (IS_ERR(dsi->regmap)) {
-		ret = PTR_ERR(dsi->regmap);
-		dev_err(dev, "failed to get block ctrl regmap: %d\n", ret);
-		return ret;
-	}
+	if (IS_ERR(dsi->regmap))
+		return dev_err_probe(dev, PTR_ERR(dsi->regmap),
+				     "failed to get block ctrl regmap\n");
 
 	dsi->clk_pixel = devm_clk_get(dev, "pix");
 	if (IS_ERR(dsi->clk_pixel))
-- 
2.34.1


