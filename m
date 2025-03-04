Return-Path: <linux-kernel+bounces-543985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F97DA4DC2C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E5081892062
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A5732045A6;
	Tue,  4 Mar 2025 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNGORDCW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8744D204680
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 11:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741086703; cv=none; b=C+YRHJkPQp+Rzlvido2Eq4M0zZTdB6m1wNObkg3x4wtG6FgLZz6K7hqrCRVMfLJBp8b3JJH04WGqAQz/pUiVWBpESLKpTt3MEloMrryFwVTggjftaYxBtNlw09dH9LV22STMtYu+56kzMgbhD6xqqLhHb9OlFzMUNeE+N0U1oDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741086703; c=relaxed/simple;
	bh=KzJc5TiXnjvtl+zcWu9wp4j+B7/vu4hUfNVTpT0Z+HQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O/yFlw1YscEJibhAmjV+OsnsfgvlNAZBIK2h6w9saAnPV4NqtlKy3dhbYWOIdW9pm2xNnxcFXteH0xoxGIZA1qiYQNU2cAQtu2Op52JgkifLuOG78b/QMlHJu4aanxvesOChs1siwz8A3ciPTu2OyDt48wBOt2ihK3M6in/uBRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNGORDCW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23DEC4CEE5;
	Tue,  4 Mar 2025 11:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741086701;
	bh=KzJc5TiXnjvtl+zcWu9wp4j+B7/vu4hUfNVTpT0Z+HQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tNGORDCW3CLB+gpz9JpOjgBbaI+rVJl5Vwf1O4D0o3272DhAVUCnqu3C1j4cvjpCL
	 nV1GMy6AwT/rDi8a5HSDRznRC1tQkwqI0VhYl0NaTChNu/1rg0W8wYVvz6B/fQDbaO
	 lqbnqMEbVYAZP2VpA/rT/MgcyFyp4cV5iixz3pPeUdh1utBeoyjPgLEV3NYz6M2f6j
	 V6uF2AixtrzKMwonoyj2FrRF1w5xfxXaneCoIDoP3tjpxwH4bkYV3DnPXJZw2+xtK1
	 avYhwflaKVK4cxZ05nGfmb4SdTFe3q7Wb1WFKMNRkGHs7Dmpq4yYAmepau2hcybEZk
	 VLnz8/faYvBuw==
From: Maxime Ripard <mripard@kernel.org>
Date: Tue, 04 Mar 2025 12:10:57 +0100
Subject: [PATCH v5 14/16] drm/bridge: tc358768: Stop disabling when failing
 to enable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-bridge-connector-v5-14-aacf461d2157@kernel.org>
References: <20250304-bridge-connector-v5-0-aacf461d2157@kernel.org>
In-Reply-To: <20250304-bridge-connector-v5-0-aacf461d2157@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Douglas Anderson <dianders@chromium.org>
Cc: Herve Codina <herve.codina@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2183; i=mripard@kernel.org;
 h=from:subject:message-id; bh=KzJc5TiXnjvtl+zcWu9wp4j+B7/vu4hUfNVTpT0Z+HQ=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDOnH7h/KeuvdEVSScopxlcgFyT69hvjsb1kLj1/yvCluW
 pxVJLuyYyoLgzAng6yYIssTmbDTy9sXVznYr/wBM4eVCWQIAxenAEzExpWxoWtH+ux50fY1GTK6
 R7e8Cedf0BLZ8I5N+cyJxtlneDNtHt79GLXlR3bc740us2/2yjUuZmz4LSB2PV7O/OWq71GBn8T
 fRzQ97dGw/av5LNYww2zrcsuOn72zr3qvEb/xJDgi46qMzSYA
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

The tc358768 bridge driver, if enabling it fails, tries to disable it.
This is pretty uncommon in bridge drivers, and also stands in the way
for further reworks.

Worse, since pre_enable and enable aren't expected to fail, disable and
post_disable might be called twice: once to handle the failure, and once
to actually disable the bridge.

Since post_disable uses regulators and clocks, this would lead to enable
count imbalances.

In order to prevent that imbalance, and to allow further reworks, let's
drop the calls to disable and post_disable, but keep the warning to let
users know about what's going on.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/tc358768.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 6db18d1e8824dd7d387211d6d1e668645cf88bbe..6b65ba8aed86012bc0f464bd5ee44325dae677c6 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -1075,15 +1075,12 @@ static void tc358768_bridge_pre_enable(struct drm_bridge *bridge)
 	val = TC358768_DSI_CONFW_MODE_CLR | TC358768_DSI_CONFW_ADDR_DSI_CONTROL;
 	val |= TC358768_DSI_CONTROL_DIS_MODE; /* DSI mode */
 	tc358768_write(priv, TC358768_DSI_CONFW, val);
 
 	ret = tc358768_clear_error(priv);
-	if (ret) {
+	if (ret)
 		dev_err(dev, "Bridge pre_enable failed: %d\n", ret);
-		tc358768_bridge_disable(bridge);
-		tc358768_bridge_post_disable(bridge);
-	}
 }
 
 static void tc358768_bridge_enable(struct drm_bridge *bridge)
 {
 	struct tc358768_priv *priv = bridge_to_tc358768(bridge);
@@ -1099,15 +1096,12 @@ static void tc358768_bridge_enable(struct drm_bridge *bridge)
 
 	/* set PP_en */
 	tc358768_update_bits(priv, TC358768_CONFCTL, BIT(6), BIT(6));
 
 	ret = tc358768_clear_error(priv);
-	if (ret) {
+	if (ret)
 		dev_err(priv->dev, "Bridge enable failed: %d\n", ret);
-		tc358768_bridge_disable(bridge);
-		tc358768_bridge_post_disable(bridge);
-	}
 }
 
 #define MAX_INPUT_SEL_FORMATS	1
 
 static u32 *

-- 
2.48.1


