Return-Path: <linux-kernel+bounces-169899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75578BCF26
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2316B2749E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8EF7EF06;
	Mon,  6 May 2024 13:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aoVRIpuM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF287C6C6
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002523; cv=none; b=PKqzuaiFwHtIByUpzd0V7r40jMzHnGD1r2yvLiTrNOABMWk6o3MJdtBdoriVCSy1ZvarfXbKXFUVWMD+PwGHxDl6cHC7+sSOh86uaic9GERj/00Yh9zTmka4lz2XomPMl1B7HGOyFSciLxNykp0HCWtsq3yZgx3cOTd4TFhugXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002523; c=relaxed/simple;
	bh=yYJipGADf8UJHcchwZluJd8e0AxButwRdoUdpxl7l5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JTZMZ2POU6KLwCC1b4alZ83zq/LCK0+gattgim2aUCgTZqGoe4gdJ1CDESfW67Xh+L9+7Bdpjcogn9vOXLZPHz23yo4ARKChnba2KjeRnHo+Q+yD6SyZTyUsXlOdSpBn+GPrB9cL30O1quDF7xNQgVilDZDf1aVXBAvj84pWULE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aoVRIpuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775B7C116B1;
	Mon,  6 May 2024 13:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715002522;
	bh=yYJipGADf8UJHcchwZluJd8e0AxButwRdoUdpxl7l5Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aoVRIpuMXfmKxTrrGGCBOz/nNDclfDeb3r8oq/8cGNaMUauqFc6TvCTxMWYoqLp/E
	 a4nWfgjh6HayGaegeyZ98S6GpU4KldaRIloHqEfuIt7hKnaxXCQh1qF4/D8cXGg+Nd
	 Zd4DBbnx2msAtHLmPP0jQB3wgtHs6Ox0ln9bE9ibwLUWM0UzkJxM92q+7yF9jvUCDu
	 14WOuZ6O5oGE3ga71J92BHv509CN80KR2qf/qAxWygZ1xZAe8PEigeFxBGBMDIn8vw
	 IMaTlAZq0ZF6YXWfO0SFI/u0PvUIQ9a3VQyzwALosJthO29zjoAQG3sSUnGVnbQ/7J
	 awDu2v5DOzH3A==
From: Michael Walle <mwalle@kernel.org>
Date: Mon, 06 May 2024 15:34:33 +0200
Subject: [PATCH 04/20] drm/bridge: tc358775: fix regulator supply id
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-tc358775-fix-powerup-v1-4-545dcf00b8dd@kernel.org>
References: <20240506-tc358775-fix-powerup-v1-0-545dcf00b8dd@kernel.org>
In-Reply-To: <20240506-tc358775-fix-powerup-v1-0-545dcf00b8dd@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sam Ravnborg <sam@ravnborg.org>, Vinay Simha BN <simhavcs@gmail.com>, 
 Tony Lindgren <tony@atomide.com>
Cc: Daniel Semkowicz <dse@thaumatec.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.4

The regulator id is given without the "-supply" postfix. With that
fixed, the driver will look up the correct regulator from the device
tree.

Fixes: b26975593b17 ("display/drm/bridge: TC358775 DSI/LVDS driver")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/gpu/drm/bridge/tc358775.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index 3b7cc3be2ccd..980f71ea5a6a 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -680,14 +680,14 @@ static int tc_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	tc->vddio = devm_regulator_get(dev, "vddio-supply");
+	tc->vddio = devm_regulator_get(dev, "vddio");
 	if (IS_ERR(tc->vddio)) {
 		ret = PTR_ERR(tc->vddio);
 		dev_err(dev, "vddio-supply not found\n");
 		return ret;
 	}
 
-	tc->vdd = devm_regulator_get(dev, "vdd-supply");
+	tc->vdd = devm_regulator_get(dev, "vdd");
 	if (IS_ERR(tc->vdd)) {
 		ret = PTR_ERR(tc->vdd);
 		dev_err(dev, "vdd-supply not found\n");

-- 
2.39.2


