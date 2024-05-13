Return-Path: <linux-kernel+bounces-177757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BADFE8C4447
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 17:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B181F223FB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 15:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649DC156245;
	Mon, 13 May 2024 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rOpSbqL4"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30929155A46
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715614318; cv=none; b=FKGQTb7C+s7wgxO4Amq9pJ+96KQJI9iYqYZvZiBLkune9dG01xXRBWtX2DglJcTmEGNcRO4QOWM+CTmJaK7jTRActzp4SNwLB8e1vuHzBnDf5qBaV93mFdDp3KIIXbz5+VGD0Ch5vGpFQdWY+AuK+K3BnKkXKdbAP3GDAg0wxDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715614318; c=relaxed/simple;
	bh=jAQ3gxGgmSg0OZc8kwMr+0RUUAVho3esOxGSt9gFKzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cganxze+fpT5vNbmJUwc08rnMdm3MVvWRvmo9rl3n1cMJYcelmDbTcGezT6kDKeCR5z3RCZpDiAsDGDZSxTD8pM3q8aq1/1OIPYJAsgrN1/4QBkKeJVBS1njrpw0Ub88b3Iy0m6CWZPo9Tpy2/i0hhvYQxw4UlW9Bbm3lKI5OZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rOpSbqL4; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715614315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DJD65cDkBGq+4KCHhX+gz6i6UVlK6CB2GRuKzloyONE=;
	b=rOpSbqL4dMh9y8dqICIcFR6YBE2NzkpmEIsI0+MoDxOUpT74bJID04JhgbWWs+NgYL6zaO
	RU3hOwZmp6gmy9bO1yitBWm+gRJ4Hg8fX7/ltRZD1OiCsevJcoAKX3pKahTvb4jOXE5qjD
	ZbxzSw93+CXlVuCt9yCJlLC4J6Rg4j4=
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
Subject: [PATCH v2 11/12] drm/bridge: imx: Remove redundant checks on existence of bridge->encoder
Date: Mon, 13 May 2024 23:31:08 +0800
Message-ID: <20240513153109.46786-12-sui.jingfeng@linux.dev>
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
of the drm_bridge instance is not NULL when various i.MX specific bridge
attach functions are called.

Remove the redundant checking codes "if (!bridge->encoder) { ... }".

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/imx/imx-ldb-helper.c         | 5 -----
 drivers/gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c | 5 -----
 drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c     | 5 -----
 drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c        | 5 -----
 4 files changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/bridge/imx/imx-ldb-helper.c b/drivers/gpu/drm/bridge/imx/imx-ldb-helper.c
index 6967325cd8ee..9b5bebbe357d 100644
--- a/drivers/gpu/drm/bridge/imx/imx-ldb-helper.c
+++ b/drivers/gpu/drm/bridge/imx/imx-ldb-helper.c
@@ -116,11 +116,6 @@ int ldb_bridge_attach_helper(struct drm_bridge *bridge,
 		return -EINVAL;
 	}
 
-	if (!bridge->encoder) {
-		DRM_DEV_ERROR(ldb->dev, "missing encoder\n");
-		return -ENODEV;
-	}
-
 	return drm_bridge_attach(bridge->encoder,
 				ldb_ch->next_bridge, bridge,
 				DRM_BRIDGE_ATTACH_NO_CONNECTOR);
diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c b/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c
index d0868a6ac6c9..e6dbbdc87ce2 100644
--- a/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c
+++ b/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-combiner.c
@@ -119,11 +119,6 @@ static int imx8qxp_pc_bridge_attach(struct drm_bridge *bridge,
 		return -EINVAL;
 	}
 
-	if (!bridge->encoder) {
-		DRM_DEV_ERROR(pc->dev, "missing encoder\n");
-		return -ENODEV;
-	}
-
 	return drm_bridge_attach(bridge->encoder,
 				 ch->next_bridge, bridge,
 				 DRM_BRIDGE_ATTACH_NO_CONNECTOR);
diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c b/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c
index ed8b7a4e0e11..1d11cc1df43c 100644
--- a/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c
+++ b/drivers/gpu/drm/bridge/imx/imx8qxp-pixel-link.c
@@ -138,11 +138,6 @@ static int imx8qxp_pixel_link_bridge_attach(struct drm_bridge *bridge,
 		return -EINVAL;
 	}
 
-	if (!bridge->encoder) {
-		DRM_DEV_ERROR(pl->dev, "missing encoder\n");
-		return -ENODEV;
-	}
-
 	return drm_bridge_attach(bridge->encoder,
 				 pl->next_bridge, bridge,
 				 DRM_BRIDGE_ATTACH_NO_CONNECTOR);
diff --git a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
index 4a886cb808ca..fb7cf4369bb8 100644
--- a/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
+++ b/drivers/gpu/drm/bridge/imx/imx8qxp-pxl2dpi.c
@@ -58,11 +58,6 @@ static int imx8qxp_pxl2dpi_bridge_attach(struct drm_bridge *bridge,
 		return -EINVAL;
 	}
 
-	if (!bridge->encoder) {
-		DRM_DEV_ERROR(p2d->dev, "missing encoder\n");
-		return -ENODEV;
-	}
-
 	return drm_bridge_attach(bridge->encoder,
 				 p2d->next_bridge, bridge,
 				 DRM_BRIDGE_ATTACH_NO_CONNECTOR);
-- 
2.43.0


