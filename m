Return-Path: <linux-kernel+bounces-176600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D278C3216
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 17:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A36281FA6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 15:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A1456446;
	Sat, 11 May 2024 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eDfeM7Z1"
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A929E5336F
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 15:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715440955; cv=none; b=DyznvbvBvym5wHVT+fQFONdPZmbHHK3TOksxXiE2FMSvGVmQQ6nfgvMEzrViPNLi3+DhUFB9McWjlxKjXxYAzwwAaGwScpfAoZXWvlnnbJ+qKmdmZynpEZ5QQBrFcOklQW+vX4bLD52/awjMiqHArQJjQpTzdCz6zkUpAb0+XS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715440955; c=relaxed/simple;
	bh=z3sBI8ia7gDjInnl0n+PFQCHcogcgMw0G2fChr1g/A4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I7wgpsUcuuJts7VqUTdD2n7Uurt4DE8fZBOmIwXX6ddzs9BPv5z3iqj3wV44AGojirASeWHxL/ggjHDWyA53Z/iTuA0mupj83Fl29wA03Pc0IRBEcwcQawhIvd9YIB47xx+JdnicK/Pn7/VK0DHJQgXr+JRNhU3rU+5cTa6diYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eDfeM7Z1; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715440950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Zn+NlbHxeYSvVqfREiTXaRsBKPDscSLweHWMfpzNE2s=;
	b=eDfeM7Z1XlXSmGLgTTbhpV5YcWNR8K2J6fTuLToaCwIZwVFuqHtnz9zXRVTeyh9+EwdSjb
	HsTHaWWZ6CwhzmfpJq5TNmB6QJpQQ+vA/jZzNBIaHCrm2ipoNY4UJ/WE385GQjgiQRdoOf
	nw5krkp9PGBQVReHI8OdjPfwMGpZiYk=
From: Sui Jingfeng <sui.jingfeng@linux.dev>
To: Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Alicja Michalska <ahplka19@gmail.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>,
	Maxime Ripard <mripard@kernel.org>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: [PATCH] drm/bridge: analogix: Remove redundant checks on existence of bridge->encoder
Date: Sat, 11 May 2024 23:22:22 +0800
Message-ID: <20240511152222.328167-1-sui.jingfeng@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The check on the existence of bridge->encoder on the implementation layer
of drm bridge driver is not necessary, as it has already been done in the
drm_bridge_attach() function. It is guaranteed that the .encoder member
of the drm_bridge instance is not NULL when various anxxxx_bridge_attach()
function gets called. And .atomic_enable() of struct drm_bridge_funcs
shouldn't be able to called before the various is acctached.

Remove the redundant checking codes "if (!bridge->encoder) { ... }".

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


