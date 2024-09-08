Return-Path: <linux-kernel+bounces-320226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE809707CE
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 15:29:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 485BBB21718
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 13:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D5116B754;
	Sun,  8 Sep 2024 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="RFreiCMw"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A7616A924
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725802156; cv=none; b=nBwRbSq7fYH9iLbPWhA0ikFs15BqashsamolZFGymILNGfVkAYrH+urmU1RHnigqU7d14MG0xRzq4fHCICeI8XbK5nDLKVrRNsKlcOt4qG0J4oulZ6IBIqSz+Mh7R3hUwNjHp0NQqQ/v76F101C0pibCwswimH9GmU5eqiUeEY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725802156; c=relaxed/simple;
	bh=Mhs6wZix2bP21g1CDNYMsdZZqlfok+FeZX4AEp59FSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SLNTLevCdsfMBYSFPwko3J5TbxZ3rmij3TZ/BUlgrz/7oxGCPfe316Szb6tpr6YRwh+9ZbHtf/4Gg0l8J9Q6bqi0asD7HYuovsIP8660yv831Z7jwkeMgFIxGM2BbgJJ7wC+qkm8oS+lClbtyJPf6HH5ytem6LjCg3JWQ7pxRpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=RFreiCMw; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1725802140; bh=PMtF2O6gt4k2B52zCrqb9+HqSYyBlwLm0yxYoXiBs0M=;
 b=RFreiCMwTU2X8JQ9IGlVoSEMYHgeMxWmIs0eUknjGi6shdywHEYXMRf9ATeTndJgTTYh7M1Fd
 TxIzNrCv2jbE63YLjz7OMBiHIrgA/x6+EOVHyJJOpA4t6cXOYs8mX6G9V7rPQGTU8gHmlB2ExLu
 PwUQciIryPldt8ArfjdlMRsRJT0N/oL4MjyVSlngdGPUomlENBB8m3HD4r+bF45YcDelaIy9Mi6
 qKIvwNpAQhGivX3EiwMtyybE1vi9OWs7ZreZEev+A7E6gs9WAWrvkmAnhB1ct+La72Zm9zU5lVX
 xDW6iaVKjFUb5mF8Mwmj9reFGnsulP6qtUOxdTVVh2/g==
From: Jonas Karlman <jonas@kwiboo.se>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Christian Hewitt <christianshewitt@gmail.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Christopher Obbard <chris.obbard@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/10] drm: bridge: dw_hdmi: Remove previous_mode and mode_set
Date: Sun,  8 Sep 2024 13:28:08 +0000
Message-ID: <20240908132823.3308029-7-jonas@kwiboo.se>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240908132823.3308029-1-jonas@kwiboo.se>
References: <20240908132823.3308029-1-jonas@kwiboo.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 66dda6993c9877b459587968

With the use of adjusted_mode directly from the crtc_state there is no
longer a need to store a copy in previous_mode, remove it and the now
unneeded mode_set ops.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 19 +------------------
 1 file changed, 1 insertion(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 1eefa633ff78..6a94376a3da3 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -154,8 +154,6 @@ struct dw_hdmi {
 		bool enabled;
 	} phy;
 
-	struct drm_display_mode previous_mode;
-
 	struct i2c_adapter *ddc;
 	void __iomem *regs;
 	bool sink_is_hdmi;
@@ -165,7 +163,7 @@ struct dw_hdmi {
 	struct pinctrl_state *default_state;
 	struct pinctrl_state *unwedge_state;
 
-	struct mutex mutex;		/* for state below and previous_mode */
+	struct mutex mutex;		/* for state below */
 	enum drm_connector_force force;	/* mutex-protected force state */
 	struct drm_connector *curr_conn;/* current connector (only valid when !disabled) */
 	bool disabled;			/* DRM has disabled our bridge */
@@ -2894,20 +2892,6 @@ dw_hdmi_bridge_mode_valid(struct drm_bridge *bridge,
 	return mode_status;
 }
 
-static void dw_hdmi_bridge_mode_set(struct drm_bridge *bridge,
-				    const struct drm_display_mode *orig_mode,
-				    const struct drm_display_mode *mode)
-{
-	struct dw_hdmi *hdmi = bridge->driver_private;
-
-	mutex_lock(&hdmi->mutex);
-
-	/* Store the display mode for plugin/DKMS poweron events */
-	drm_mode_copy(&hdmi->previous_mode, mode);
-
-	mutex_unlock(&hdmi->mutex);
-}
-
 static void dw_hdmi_bridge_atomic_disable(struct drm_bridge *bridge,
 					  struct drm_bridge_state *old_state)
 {
@@ -2971,7 +2955,6 @@ static const struct drm_bridge_funcs dw_hdmi_bridge_funcs = {
 	.atomic_get_input_bus_fmts = dw_hdmi_bridge_atomic_get_input_bus_fmts,
 	.atomic_enable = dw_hdmi_bridge_atomic_enable,
 	.atomic_disable = dw_hdmi_bridge_atomic_disable,
-	.mode_set = dw_hdmi_bridge_mode_set,
 	.mode_valid = dw_hdmi_bridge_mode_valid,
 	.detect = dw_hdmi_bridge_detect,
 	.edid_read = dw_hdmi_bridge_edid_read,
-- 
2.46.0


