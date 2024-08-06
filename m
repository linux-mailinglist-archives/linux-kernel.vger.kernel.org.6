Return-Path: <linux-kernel+bounces-276325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FF59492B8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33813B2C68F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDEB205E2E;
	Tue,  6 Aug 2024 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JsJUECnz"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9AB1EA0D0
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952270; cv=none; b=HRGOeyv/59SoP3kZc4wZgA+/GrIIQiTAKOtyqWE4ZusdRPmUTqw51CCFMho7YammJa0HhTypH1innLUMiopqPOuRgiVHUTrZBBGy31tXtM1iN7IELJ+dnXCfE1aAGcb4cHg3uEAJsUxsTjgU5xmsWnKztb+9EqJyuKPivqv+oOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952270; c=relaxed/simple;
	bh=ZjLNaR+u/G8uON1P2WcHYHGgw/Rr1V87B+mZrIVeHRk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NP9cKH27VccmKZhATbjcrkCuOIGFeyLNPNX5teFc+PPJH17uwf3iD/BncdnC1COLdpgOhgXt0o90kMfXjTEeO3t/rY4C3RBQnJyXtiKX6wEfXEly0dyUB1c1TF1gEWD4MVPEqDmK71dSCPvF4WXA/z1lG5lZjqrlLsQCSe3L4LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=JsJUECnz; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-156-87-48.elisa-laajakaista.fi [91.156.87.48])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 388B8922;
	Tue,  6 Aug 2024 15:50:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1722952209;
	bh=ZjLNaR+u/G8uON1P2WcHYHGgw/Rr1V87B+mZrIVeHRk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JsJUECnzteuFb9xN6LSOopSJG2SGhWFOQP2fRZFnatCojJHbMvE/uPX0wY5737jJ+
	 Hxt9jf2jj35i6G4ifOXvnc3trtpq6GT2kD9xSQ53fp5VTVpjw7JUcABbKIPgcpPXu9
	 qgqFL8R6kb+ppnWXAwzOahcQIjbQe0Ndfn5CYKw4=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 06 Aug 2024 16:50:27 +0300
Subject: [PATCH 1/3] drm/omap: Fix possible NULL dereference
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-omapdrm-misc-fixes-v1-1-15d31aea0831@ideasonboard.com>
References: <20240806-omapdrm-misc-fixes-v1-0-15d31aea0831@ideasonboard.com>
In-Reply-To: <20240806-omapdrm-misc-fixes-v1-0-15d31aea0831@ideasonboard.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4830;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=ZjLNaR+u/G8uON1P2WcHYHGgw/Rr1V87B+mZrIVeHRk=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBmsipDPPj1reZjT33lXW0RLkLAmOPG8g+/b7uBo
 9OMSsJrAz6JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZrIqQwAKCRD6PaqMvJYe
 9fuREACu9oLCpfzakd42DZGQyNwffex1cH3W8LhQR3ir800cIiXHbZDsrAcwe7vFUE8FJnMIUia
 ZNLSv8+bXkinIZccO4N+Kf+sgH26ew0UlOcrXOrRTtGCL3dQVLyUmYTDjofNRTquGbi2Y05KdCM
 ltmIhDJfNaZDKUOtRh97eE4mYmfcHegD0dzxCV7T8dAXFKjoMClL1iUXzfqO6wYYTppF+Zbt6cv
 bvN4btA6x4TQ0HyA87Zh65KvwhJpfoUCAL4vOlmbYkcrXCjxkPwoMqmARlbLthO9OqWtEYmuqUt
 tUR8ZbrqiyQGD+RRVp0CfzUg5Zb8h9njTNDQBcX6g+KWoOXqlgKMWUbXBrudnDaTuVP07jmzIDg
 siM0/efoujtfedgHi5abQYlJYuHIkcNvdztTqSrvlj0kbMPBGJ6Iqa9JLQgQaxrv7wKG5TGeqiL
 YYQ0M35pv9g29qq8ukr8hXp6KO+6yk+3BEB7fXaStZIAfz02NP+e/iI1IRPoy1EWpiwdc99UOZW
 BnZqu4nmrzkj5aQmbXka3Eq0PBlJaeEYsYBpveHFaVt65va3EMfn7b+Y40jJEBwK0pU/SRwnxMT
 irCv5hSLQt+GNtChArWsGVuYEpR9hrd2KWczt33nfIV7dTLiaMBMaHht6IfIfbEJGl63Jw4PB89
 655WI6TWWnnHrTA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

smatch reports:

drivers/gpu/drm/omapdrm/dss/base.c:176 omapdss_device_disconnect() error: we previously assumed 'src' could be null (see line 169)

This code is mostly from a time when omapdrm had its own display device
model. I can't honestly remember the details, and I don't think it's
worth digging in deeply into that for a legacy driver.

However, it looks like we only call omapdss_device_disconnect() and
omapdss_device_connect() with NULL as the src parameter. We can thus
drop the src parameter from both functions, and fix the smatch warning.

I don't think omapdss_device_disconnect() ever gets NULL for the dst
parameter (if it did, we'd crash soon after returning from the
function), but I have kept the !dst check, just in case, but I added a
WARN_ON() there.

Also, if the dst parameter can be NULL, we can't always get the struct
dss_device pointer from dst->dss (which is only used for a debug print).
To make sure we can't hit that issue, do it similarly to the
omapdss_device_connect() function: add 'struct dss_device *dss' as the
first parameter, so that we always have it regardless of the dst.

Fixes: 79107f274b2f ("drm/omap: Add support for drm_bridge")
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/omapdrm/dss/base.c    | 25 ++++++-------------------
 drivers/gpu/drm/omapdrm/dss/omapdss.h |  3 +--
 drivers/gpu/drm/omapdrm/omap_drv.c    |  4 ++--
 3 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/omapdrm/dss/base.c b/drivers/gpu/drm/omapdrm/dss/base.c
index 050ca7eafac5..556e0f9026be 100644
--- a/drivers/gpu/drm/omapdrm/dss/base.c
+++ b/drivers/gpu/drm/omapdrm/dss/base.c
@@ -139,21 +139,13 @@ static bool omapdss_device_is_connected(struct omap_dss_device *dssdev)
 }
 
 int omapdss_device_connect(struct dss_device *dss,
-			   struct omap_dss_device *src,
 			   struct omap_dss_device *dst)
 {
-	dev_dbg(&dss->pdev->dev, "connect(%s, %s)\n",
-		src ? dev_name(src->dev) : "NULL",
+	dev_dbg(&dss->pdev->dev, "connect(%s)\n",
 		dst ? dev_name(dst->dev) : "NULL");
 
-	if (!dst) {
-		/*
-		 * The destination is NULL when the source is connected to a
-		 * bridge instead of a DSS device. Stop here, we will attach
-		 * the bridge later when we will have a DRM encoder.
-		 */
-		return src && src->bridge ? 0 : -EINVAL;
-	}
+	if (!dst)
+		return -EINVAL;
 
 	if (omapdss_device_is_connected(dst))
 		return -EBUSY;
@@ -163,19 +155,14 @@ int omapdss_device_connect(struct dss_device *dss,
 	return 0;
 }
 
-void omapdss_device_disconnect(struct omap_dss_device *src,
+void omapdss_device_disconnect(struct dss_device *dss,
 			       struct omap_dss_device *dst)
 {
-	struct dss_device *dss = src ? src->dss : dst->dss;
-
-	dev_dbg(&dss->pdev->dev, "disconnect(%s, %s)\n",
-		src ? dev_name(src->dev) : "NULL",
+	dev_dbg(&dss->pdev->dev, "disconnect(%s)\n",
 		dst ? dev_name(dst->dev) : "NULL");
 
-	if (!dst) {
-		WARN_ON(!src->bridge);
+	if (WARN_ON(!dst))
 		return;
-	}
 
 	if (!dst->id && !omapdss_device_is_connected(dst)) {
 		WARN_ON(1);
diff --git a/drivers/gpu/drm/omapdrm/dss/omapdss.h b/drivers/gpu/drm/omapdrm/dss/omapdss.h
index 040d5a3e33d6..4c22c09c93d5 100644
--- a/drivers/gpu/drm/omapdrm/dss/omapdss.h
+++ b/drivers/gpu/drm/omapdrm/dss/omapdss.h
@@ -242,9 +242,8 @@ struct omap_dss_device *omapdss_device_get(struct omap_dss_device *dssdev);
 void omapdss_device_put(struct omap_dss_device *dssdev);
 struct omap_dss_device *omapdss_find_device_by_node(struct device_node *node);
 int omapdss_device_connect(struct dss_device *dss,
-			   struct omap_dss_device *src,
 			   struct omap_dss_device *dst);
-void omapdss_device_disconnect(struct omap_dss_device *src,
+void omapdss_device_disconnect(struct dss_device *dss,
 			       struct omap_dss_device *dst);
 
 int omap_dss_get_num_overlay_managers(void);
diff --git a/drivers/gpu/drm/omapdrm/omap_drv.c b/drivers/gpu/drm/omapdrm/omap_drv.c
index 6598c9c08ba1..d80d24fce79f 100644
--- a/drivers/gpu/drm/omapdrm/omap_drv.c
+++ b/drivers/gpu/drm/omapdrm/omap_drv.c
@@ -307,7 +307,7 @@ static void omap_disconnect_pipelines(struct drm_device *ddev)
 	for (i = 0; i < priv->num_pipes; i++) {
 		struct omap_drm_pipeline *pipe = &priv->pipes[i];
 
-		omapdss_device_disconnect(NULL, pipe->output);
+		omapdss_device_disconnect(priv->dss, pipe->output);
 
 		omapdss_device_put(pipe->output);
 		pipe->output = NULL;
@@ -325,7 +325,7 @@ static int omap_connect_pipelines(struct drm_device *ddev)
 	int r;
 
 	for_each_dss_output(output) {
-		r = omapdss_device_connect(priv->dss, NULL, output);
+		r = omapdss_device_connect(priv->dss, output);
 		if (r == -EPROBE_DEFER) {
 			omapdss_device_put(output);
 			return r;

-- 
2.43.0


