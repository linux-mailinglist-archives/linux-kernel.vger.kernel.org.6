Return-Path: <linux-kernel+bounces-448262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BF49F3DCD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 23:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89C37188967C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 22:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2B51D90A9;
	Mon, 16 Dec 2024 22:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="W8Kd9QKZ"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580841D5CD1
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 22:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734389687; cv=none; b=UNi7FOXFMg8O9Wy5jhVWoZBbn/Lhp49FOfmjPjecLecrOUY3BFMnAtldShkjIlNLXA8fnL/dxEOD4uFDCWtc+2gr0gJi3sPKK+6l7/dtvpdoUGakXBObVtaauZDKO2qCjf5BAUM1wkedh9LmatRTwgQwLUt9RGi4kPZz0HsIeM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734389687; c=relaxed/simple;
	bh=8KCcfXAcnrbBrAylr/pecwYM1mZvQEg1BZbBmlSGq7U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kC5HEWBfyTGcf4U4sM0+oq1XnofOGA8RVQjC7QKwktP+UdkKtmxhHNMDffE+/e3vOrU9pZOsycNMxvn/RtE/5rKoMg039TUVaAv+hul6on6tiP4V3dsMSm/1vx2MOu0hxXZhNNqqbvNfuOwCPoW8TWjAgcLyiJ3hzA58JsMp4/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=W8Kd9QKZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734389683;
	bh=8KCcfXAcnrbBrAylr/pecwYM1mZvQEg1BZbBmlSGq7U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=W8Kd9QKZiVWBcdl6rqQn3oscAs6jehydIya4lzzUuEI3EJD8ojlV7cvC8JBvQea2Y
	 rfeWy/0H9sxpLQDW0RWj2ImgSeEsFTgTp8fxe36rcb+LQaxno5InK1j/uTGB3xa1m3
	 a9epkpomoIPijzdW2zgeNVC1gOvuiseElfAMSWjmyGc/ZXIPwrwfK0U+8M5YANhCVn
	 m+rsBqtfCxyZ49/aJ1ys5fqAFE/emcVFnJbxJ7cnqLH2OHYr59stRV5x7oyUkgZggX
	 8F3Ym0oyWZRm9ryIms4v8u7QjKJZB76ryYweaTxVVK6wNFE3eU6W0eNFtMGL09xlcj
	 7JkVzhTi0M5qg==
Received: from localhost (unknown [188.27.48.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6BFD117E3832;
	Mon, 16 Dec 2024 23:54:43 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 17 Dec 2024 00:54:07 +0200
Subject: [PATCH v3 1/2] drm/bridge-connector: Prioritize supported_formats
 over ycbcr_420_allowed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241217-bridge-conn-fmt-prio-v3-1-3ecb3c8fc06f@collabora.com>
References: <20241217-bridge-conn-fmt-prio-v3-0-3ecb3c8fc06f@collabora.com>
In-Reply-To: <20241217-bridge-conn-fmt-prio-v3-0-3ecb3c8fc06f@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Bridges having the DRM_BRIDGE_OP_HDMI flag set in drm_bridge->ops are
supposed to rely on drm_bridge->supported_formats bitmask to advertise
the supported colorspaces, including HDMI_COLORSPACE_YUV420.  Therefore,
the newly introduced drm_bridge->ycbcr_420_allowed flag becomes
redundant in this particular context.

Moreover, when drm_bridge_connector gets initialised, only
drm_bridge->ycbcr_420_allowed is considered in the process of adjusting
the equivalent property of the base drm_connector, which effectively
discards the formats advertised by the HDMI bridge.

Handle the inconsistency by overwriting drm_bridge->ycbcr_420_allowed
for HDMI bridges according to drm_bridge->supported_formats, before
adding them to the global bridge list.

Additionally, ensure the YUV420 related bit is removed from the bitmask
passed to drmm_connector_hdmi_init() when the final ycbcr_420_allowed
flag for the connector ends up not being set (i.e. the case of having at
least one non-HDMI bridge in the pipeline that didn't enable it).

Fixes: 3ced1c687512 ("drm/display: bridge_connector: handle ycbcr_420_allowed")
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 8 ++++++--
 drivers/gpu/drm/drm_bridge.c                   | 4 ++++
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 320c297008aaa8b6ef5b1f4c71928849b202e8ac..3a5a4f92c979accaa2a8f79ca0f15396dd579429 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -459,7 +459,10 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	if (connector_type == DRM_MODE_CONNECTOR_Unknown)
 		return ERR_PTR(-EINVAL);
 
-	if (bridge_connector->bridge_hdmi)
+	if (bridge_connector->bridge_hdmi) {
+		if (!connector->ycbcr_420_allowed)
+			supported_formats &= ~BIT(HDMI_COLORSPACE_YUV420);
+
 		ret = drmm_connector_hdmi_init(drm, connector,
 					       bridge_connector->bridge_hdmi->vendor,
 					       bridge_connector->bridge_hdmi->product,
@@ -468,10 +471,11 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 					       connector_type, ddc,
 					       supported_formats,
 					       max_bpc);
-	else
+	} else {
 		ret = drmm_connector_init(drm, connector,
 					  &drm_bridge_connector_funcs,
 					  connector_type, ddc);
+	}
 	if (ret)
 		return ERR_PTR(ret);
 
diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index c6af46dd02bfa9e15b59e4c460debdd7fd84be44..241a384ebce39b4a3db58c208af27960904fc662 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -207,6 +207,10 @@ void drm_bridge_add(struct drm_bridge *bridge)
 {
 	mutex_init(&bridge->hpd_mutex);
 
+	if (bridge->ops & DRM_BRIDGE_OP_HDMI)
+		bridge->ycbcr_420_allowed = !!(bridge->supported_formats &
+					       BIT(HDMI_COLORSPACE_YUV420));
+
 	mutex_lock(&bridge_lock);
 	list_add_tail(&bridge->list, &bridge_list);
 	mutex_unlock(&bridge_lock);

-- 
2.47.0


