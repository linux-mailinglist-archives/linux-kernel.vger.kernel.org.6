Return-Path: <linux-kernel+bounces-177758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DDF8C4448
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01D4C281E0E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A95C154449;
	Mon, 13 May 2024 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nhcZDRYN"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4172715664C
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614321; cv=none; b=M/VnLsfwPt2zSPv6KvOygyOXOrk2rK0FIwKx68wRcMU3dHkXFORPyJ746MTO8ULkX1H2hRVderGBo1kWZvxAi3ZGkSWE3cTwIsw9i+Gb2Ut/HFt96Tu1MC7m5B3y5cylL9xD9+ysZ5Kp70LRXgKWSGd1YTNovbbqoC07uA4zD6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614321; c=relaxed/simple;
	bh=+RwW506SglCqz4XSZa/oNMNKUKVLp9KPIi06iPs5tuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o43kvSLeNa2ntMj+5OfMNwf0wqZ6yvvSXrXFffEAuzx38exk+iQ0fqJ6W2K1+irJyYskzHeyioJhcqA2cL5xSgf5GAEdROJj9aM7C3SkVyCGczeZ5R4UNVJ4Q0JP/6m6ooZVByMt22z9OSbfEynhm0ACUP9OzxZ3uX7Ac8Tl39w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nhcZDRYN; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715614318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J5+V1S9388YXGse4Sl78OBq2S/qOMf7C/8WKdb7RqiQ=;
	b=nhcZDRYN54cD/TsvPcSD91AHbbllmZLhrQztxz4D3HC29SFhukyJHM4ObtTd2TA6d0n4jg
	7CTKFvBjuPxckIOdORe8mBHDJFRR8+yjhwa5Fu40wh7QZBnGn60j4aZNoGYDGl1ZPPDXEK
	0p1FrwK/5A7PS0MyRv30nx/3Hk8ss0g=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Douglas Anderson <dianders@chromium.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Liu Ying <victor.liu@nxp.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [PATCH v2 12/12] drm/bridge: analogix: Remove redundant checks on existence of bridge->encoder
Date: Mon, 13 May 2024 23:31:09 +0800
Message-ID: <20240513153109.46786-13-sui.jingfeng@linux.dev>
In-Reply-To: <20240513153109.46786-1-sui.jingfeng@linux.dev>
References: <20240513153109.46786-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The checks on the existence of bridge->encoder in the implementation of
drm_bridge_funcs::attach() is not necessary, as it has already been checked
in the drm_bridge_attach() function call by previous bridge or KMS driver.
The drm_bridge_attach() will quit with a negative error code returned if
it fails for some reasons, hence, it is guaranteed that the .encoder member
of the drm_bridge instance is not NULL when various bridge attach functions
are called.

Remove the redundant checking codes "if (!bridge->encoder) { ... }".

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c |  5 -----
 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c |  5 -----
 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c |  5 -----
 drivers/gpu/drm/bridge/analogix/anx7625.c          | 10 ----------
 4 files changed, 25 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
index c9e35731e6a1..cfe43d2ca3be 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
@@ -528,11 +528,6 @@ static int anx6345_bridge_attach(struct drm_bridge *bridge,
 		return -EINVAL;
 	}
 
-	if (!bridge->encoder) {
-		DRM_ERROR("Parent encoder object not found");
-		return -ENODEV;
-	}
-
 	/* Register aux channel */
 	anx6345->aux.name = "DP-AUX";
 	anx6345->aux.dev = &anx6345->client->dev;
diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
index 5748a8581af4..58875dde496f 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
@@ -897,11 +897,6 @@ static int anx78xx_bridge_attach(struct drm_bridge *bridge,
 		return -EINVAL;
 	}
 
-	if (!bridge->encoder) {
-		DRM_ERROR("Parent encoder object not found");
-		return -ENODEV;
-	}
-
 	/* Register aux channel */
 	anx78xx->aux.name = "DP-AUX";
 	anx78xx->aux.dev = &anx78xx->client->dev;
diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
index df9370e0ff23..7b841232321f 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
@@ -1228,11 +1228,6 @@ static int analogix_dp_bridge_attach(struct drm_bridge *bridge,
 		return -EINVAL;
 	}
 
-	if (!bridge->encoder) {
-		DRM_ERROR("Parent encoder object not found");
-		return -ENODEV;
-	}
-
 	if (!dp->plat_data->skip_connector) {
 		connector = &dp->connector;
 		connector->polled = DRM_CONNECTOR_POLL_HPD;
diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 59e9ad349969..3d09efa4199c 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2193,11 +2193,6 @@ static int anx7625_bridge_attach(struct drm_bridge *bridge,
 	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
 		return -EINVAL;
 
-	if (!bridge->encoder) {
-		DRM_DEV_ERROR(dev, "Parent encoder object not found");
-		return -ENODEV;
-	}
-
 	ctx->aux.drm_dev = bridge->dev;
 	err = drm_dp_aux_register(&ctx->aux);
 	if (err) {
@@ -2435,11 +2430,6 @@ static void anx7625_bridge_atomic_enable(struct drm_bridge *bridge,
 
 	dev_dbg(dev, "drm atomic enable\n");
 
-	if (!bridge->encoder) {
-		dev_err(dev, "Parent encoder object not found");
-		return;
-	}
-
 	connector = drm_atomic_get_new_connector_for_encoder(state->base.state,
 							     bridge->encoder);
 	if (!connector)
-- 
2.43.0


