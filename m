Return-Path: <linux-kernel+bounces-559421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AE9A5F3AA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D353B0F45
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BA5267B62;
	Thu, 13 Mar 2025 12:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2O4IuLt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8465A26739B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867241; cv=none; b=J9LKxDPi7qnKng+2tn9U/DRvhaaToq4WFfWIMoDpe1OLLPadVgXZ9gXdRvBG9jUhGzIzZ7l5V1wWha6MUR3Cw7pbPYhY0ilbnBQRhT6KBtHrfLUfNp4a4ZeXsI/VxFzZ509IlRB+BdgzxScJW37HTGKaBIZ1SPmjC1bD5oNO+T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867241; c=relaxed/simple;
	bh=QLjBmBTGFfvbamTwOqNwPh8p1mjv/71jpgSOsVZUA0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Uroe7Ukx/qAt8Sfi2dUGsyL340BSdlG0HpZu4XFySD6lO7yvOSN/KNxW3CJMFKvjL3MGGB6IIjlWDN9htRW5ZE9+PX4ChzbD2GN1Mn0xR1XcxHLx2EPfJbYCfOc+/lepMF8dFbaUtI3N6lnqZ8EDoyO3jnbLpvgTeG98SVDkNIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2O4IuLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1158AC4CEDD;
	Thu, 13 Mar 2025 12:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741867241;
	bh=QLjBmBTGFfvbamTwOqNwPh8p1mjv/71jpgSOsVZUA0U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W2O4IuLt4EI8XYUmU3AyzT4SNvo4QGX34YQf1DaVVDH5GTR618Z6uTPCfmbmTQrt5
	 T5Vhnv4gEEQDVOySY3wAa9PciJ547m/I3BjuoEojBB/QLQKzB8AY2P0f8+HdHuBgAp
	 9X3hdpfWoY/465L2rVxrmnj9ofnJeLs0qBdC501RoJy9W87+o36ihXFiIU6eTP7AQP
	 8M896NdgOMYjhCh3i5/PxPWdzpU47XSUe5TNJ3W/Uehm8BQGU6FfjjYQUx3UXNNNR9
	 hAf8S+nwymhNQow9Khef3Kn5fRGtV9vMLpAmX9oIt5Cl4L4rXqUiGnSdG270JP4wn0
	 3T9SSc0H3g+yw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 13 Mar 2025 13:00:04 +0100
Subject: [PATCH v6 10/16] drm/bridge: ti-sn65dsi83: Switch to
 drm_bridge_helper_reset_crtc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-bridge-connector-v6-10-511c54a604fb@kernel.org>
References: <20250313-bridge-connector-v6-0-511c54a604fb@kernel.org>
In-Reply-To: <20250313-bridge-connector-v6-0-511c54a604fb@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2594; i=mripard@kernel.org;
 h=from:subject:message-id; bh=QLjBmBTGFfvbamTwOqNwPh8p1mjv/71jpgSOsVZUA0U=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDOmXThz5ZsSn+yhCV1nfIkBbI2fVfheP1UvzrjIrmswye
 da/Jcmuo5SFQYyLQVZMkSVG2HxJ3KlZrzvZ+ObBzGFlAhnCwMUpABOZfJzhD2+B972lLh6PpY8u
 XXXxgE2w+ddVaht+HJ4RvWtq/+vEP7sY/hfPeX/z3mb+vOMuMve23GBUcnfOyQqflckYeuhEpX+
 xFT8A
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D

Now that we have a helper for bridge drivers to call to reset the output
pipeline, let's use it.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Herve Codina <herve.codina@bootlin.com>
Tested-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 7122a3ebd88399ed32420fcaf9f1f9384d031d2d..53cc4cfb0c884f6a410e3df2c4df4572f89c0768 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -38,11 +38,11 @@
 #include <linux/timer.h>
 #include <linux/workqueue.h>
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
-#include <drm/drm_drv.h> /* DRM_MODESET_LOCK_ALL_BEGIN() needs drm_drv_uses_atomic_modeset() */
+#include <drm/drm_bridge_helper.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_of.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 
@@ -369,11 +369,10 @@ static u8 sn65dsi83_get_dsi_div(struct sn65dsi83 *ctx)
 	return dsi_div - 1;
 }
 
 static int sn65dsi83_reset_pipe(struct sn65dsi83 *sn65dsi83)
 {
-	struct drm_device *dev = sn65dsi83->bridge.dev;
 	struct drm_modeset_acquire_ctx ctx;
 	int err;
 
 	/*
 	 * Reset active outputs of the related CRTC.
@@ -384,30 +383,25 @@ static int sn65dsi83_reset_pipe(struct sn65dsi83 *sn65dsi83)
 	 * bridge.
 	 *
 	 * Keep the lock during the whole operation to be atomic.
 	 */
 
-	DRM_MODESET_LOCK_ALL_BEGIN(dev, ctx, 0, err);
-
-	if (!sn65dsi83->bridge.encoder->crtc) {
-		/*
-		 * No CRTC attached -> No CRTC active outputs to reset
-		 * This can happen when the SN65DSI83 is reset. Simply do
-		 * nothing without returning any errors.
-		 */
-		err = 0;
-		goto end;
-	}
+	drm_modeset_acquire_init(&ctx, 0);
 
 	dev_warn(sn65dsi83->dev, "reset the pipe\n");
 
-	err = drm_atomic_helper_reset_crtc(sn65dsi83->bridge.encoder->crtc, &ctx);
+retry:
+	err = drm_bridge_helper_reset_crtc(&sn65dsi83->bridge, &ctx);
+	if (err == -EDEADLK) {
+		drm_modeset_backoff(&ctx);
+		goto retry;
+	}
 
-end:
-	DRM_MODESET_LOCK_ALL_END(dev, ctx, err);
+	drm_modeset_drop_locks(&ctx);
+	drm_modeset_acquire_fini(&ctx);
 
-	return err;
+	return 0;
 }
 
 static void sn65dsi83_reset_work(struct work_struct *ws)
 {
 	struct sn65dsi83 *ctx = container_of(ws, struct sn65dsi83, reset_work);

-- 
2.48.1


