Return-Path: <linux-kernel+bounces-169897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 741F58BCF24
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5E56B27220
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB4D7FBAC;
	Mon,  6 May 2024 13:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kD47ngL8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1207FBA5
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002513; cv=none; b=Hg/hZYgCEFXwxRGT+/UKjC6ZO54bGCB1WYnMsEtxVSR6DwA1NX8tAhaBjZUX6qDqgDJ1y+hAXb4KlYxsIqRrfg/81sHyVAWN0GEMNmtYIwH4OczQWrPXCjkU8uIEsLe4UEkvzDF5QL6ashI19iHQLRF46YfVAfgF6TTw9liQYkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002513; c=relaxed/simple;
	bh=pK9ICrlhU4yI7C8UmfAMhDpOxq05RC8K7IM/L/yquWw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YFI9qaZZjflupaqsNyj0sAPV8fdJqm7KGrnvr0fykmfOZUwpf6EuAGbmlahyh3Vz062NeSbEBWSBOiiKkPmuXmdnlWPG1EKBfpnwyEXUlyH6hCgo/dp/L3lblMIOSsLhDtbTrZ0yPfmOxqz93gjcfJD2X6WRGdVDdb7lSG3rOSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kD47ngL8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DC2C116B1;
	Mon,  6 May 2024 13:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715002513;
	bh=pK9ICrlhU4yI7C8UmfAMhDpOxq05RC8K7IM/L/yquWw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kD47ngL8uom7ANO5DcjrAAVmsG/a74GHNet69KvrccOpmOl+iw4znkaN5ZTvBBOtn
	 KEH5rlnCJbms83AhqwyyASbLLAekbP61TQQsLpg/hpD69G2D/8T7Q3/yZCZcFl2u4p
	 37nfSL+WDB9rMSWujjU2hcXW+NTJg6iCGrCfJgpD9IhRCwOGBs3scufG5lSUnzc0d7
	 UHyOzgfIBNcGd9vWR4YkB9oygn2/2iHBfxxD8jxluCoVhezMvA40NmN2UXBv2AHJy+
	 ZcrDgHDdbvzWruLtC2LRRrq3NZv/Alc3WV4Ypbjt2ACSPWr1CdSKLaBNlnLqi1F0Ke
	 eEKv2/eLNYJZA==
From: Michael Walle <mwalle@kernel.org>
Date: Mon, 06 May 2024 15:34:31 +0200
Subject: [PATCH 02/20] drm/mediatek: dsi: provide LP-11 mode during
 .pre_enable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-tc358775-fix-powerup-v1-2-545dcf00b8dd@kernel.org>
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

As per specification in drivers/gpu/drm/drm_bridge.c the data lanes
should be in LP-11 mode after .pre_enable() has been run. HS mode of the
data lanes are enabled with mtk_dsi_start(). Therefore, move that call
to the .enable() callback.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index c255559cc56e..ed45c9cc3137 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -711,8 +711,6 @@ static void mtk_output_dsi_enable(struct mtk_dsi *dsi)
 	mtk_dsi_set_mode(dsi);
 	mtk_dsi_clk_hs_mode(dsi, 1);
 
-	mtk_dsi_start(dsi);
-
 	dsi->enabled = true;
 }
 
@@ -759,7 +757,7 @@ static void mtk_dsi_bridge_atomic_enable(struct drm_bridge *bridge,
 	if (dsi->refcount == 0)
 		return;
 
-	mtk_output_dsi_enable(dsi);
+	mtk_dsi_start(dsi);
 }
 
 static void mtk_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
@@ -771,6 +769,9 @@ static void mtk_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 	ret = mtk_dsi_poweron(dsi);
 	if (ret < 0)
 		DRM_ERROR("failed to power on dsi\n");
+
+	/* Enter LP-11 state */
+	mtk_output_dsi_enable(dsi);
 }
 
 static void mtk_dsi_bridge_atomic_post_disable(struct drm_bridge *bridge,

-- 
2.39.2


