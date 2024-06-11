Return-Path: <linux-kernel+bounces-210205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46709040CA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5F511C23F83
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02AAB64A98;
	Tue, 11 Jun 2024 16:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="vMcuuFt/"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27E23FBA4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121764; cv=none; b=hhk0BCHdTGeSzRgbgB6Vsxkl+KQd2eUOjr9ra8a5zKaMoJZyFxvDOM4ruGxw6Z2qI6UegZwziVzGQsTvp2ML1l2jAJpOm1NEo6yuyt06RGaEVIrxayNuv3E4fLY67d+HHG8VbtkTzQAPDP8rqVwH4PzuD5fDBxu07ZHCWlfwGhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121764; c=relaxed/simple;
	bh=mLkItQy6ITMzYQXoDl1EQD0hawEd4UBN77gKWr1dYhM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsAo71Z2bWIbpY/xfuvgaf13qcneIt5NdpGFJ42iwqqCBoHXnj49fgwYHedDxzdPcj71cwwW0srmfIIquBTExfkjs2+dwVk6EQ4hJe6dmPOT0Nq6pl+6KBlfbQTWs5luZ6iwiFVGeYfgmrKrxMbYszc6YyXFXNVnicDcDdxVDYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=vMcuuFt/; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1718121749; bh=0XDwfJc/IwpzEz4wRvrO6aRIQFt9tGAc7Bg1rLoc9K0=;
 b=vMcuuFt/b/z+kEgfu2zmt1+8fpY0WtPIfOYAyRfr1ZQFS/XRP/313qGHt1+D5RuiEuC7cm095
 HEr/kTQHVeRHhOJKE8xnaLWE/6w476BYT7CibECAJSRjIEVjRvTv4yY59LdZlpEbAfrr/y8lgbo
 K4uKFPpVySgBrqg6YCrPQZsfLtB8UddLQUHj1RIyXa6FWcLynsULJgqfd/TrNmUvkbtheCst98K
 JwvPvBTfnCa1YwsUxwDUgplaXueLumTbKo5rVwI6i9wLgHI21A4hpVEs3bHGIflmfySy0nDPOPG
 LMOq0qXPYf5tsRutdcSS7ohJZHQDib/zvrktMfs3BQBw==
From: Jonas Karlman <jonas@kwiboo.se>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] drm: bridge: dw_hdmi: Call poweron/poweroff from atomic enable/disable
Date: Tue, 11 Jun 2024 15:50:53 +0000
Message-ID: <20240611155108.1436502-2-jonas@kwiboo.se>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240611155108.1436502-1-jonas@kwiboo.se>
References: <20240611155108.1436502-1-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 66687277b913b04293b6dc30

Change to only call poweron/poweroff from atomic_enable/atomic_disable
ops instead of trying to keep a bridge_is_on state and poweron/off in
the hotplug irq handler.

A benefit of this is that drm mode_config mutex is always held at
poweron/off, something that may reduce the need for our own mutex.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 33 ++---------------------
 1 file changed, 2 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 9f2bc932c371..34bc6f4754b8 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -172,7 +172,6 @@ struct dw_hdmi {
 	enum drm_connector_force force;	/* mutex-protected force state */
 	struct drm_connector *curr_conn;/* current connector (only valid when !disabled) */
 	bool disabled;			/* DRM has disabled our bridge */
-	bool bridge_is_on;		/* indicates the bridge is on */
 	bool rxsense;			/* rxsense state */
 	u8 phy_mask;			/* desired phy int mask settings */
 	u8 mc_clkdis;			/* clock disable register */
@@ -2383,8 +2382,6 @@ static void initialize_hdmi_ih_mutes(struct dw_hdmi *hdmi)
 
 static void dw_hdmi_poweron(struct dw_hdmi *hdmi)
 {
-	hdmi->bridge_is_on = true;
-
 	/*
 	 * The curr_conn field is guaranteed to be valid here, as this function
 	 * is only be called when !hdmi->disabled.
@@ -2398,30 +2395,6 @@ static void dw_hdmi_poweroff(struct dw_hdmi *hdmi)
 		hdmi->phy.ops->disable(hdmi, hdmi->phy.data);
 		hdmi->phy.enabled = false;
 	}
-
-	hdmi->bridge_is_on = false;
-}
-
-static void dw_hdmi_update_power(struct dw_hdmi *hdmi)
-{
-	int force = hdmi->force;
-
-	if (hdmi->disabled) {
-		force = DRM_FORCE_OFF;
-	} else if (force == DRM_FORCE_UNSPECIFIED) {
-		if (hdmi->rxsense)
-			force = DRM_FORCE_ON;
-		else
-			force = DRM_FORCE_OFF;
-	}
-
-	if (force == DRM_FORCE_OFF) {
-		if (hdmi->bridge_is_on)
-			dw_hdmi_poweroff(hdmi);
-	} else {
-		if (!hdmi->bridge_is_on)
-			dw_hdmi_poweron(hdmi);
-	}
 }
 
 /*
@@ -2546,7 +2519,6 @@ static void dw_hdmi_connector_force(struct drm_connector *connector)
 
 	mutex_lock(&hdmi->mutex);
 	hdmi->force = connector->force;
-	dw_hdmi_update_power(hdmi);
 	dw_hdmi_update_phy_mask(hdmi);
 	mutex_unlock(&hdmi->mutex);
 }
@@ -2955,7 +2927,7 @@ static void dw_hdmi_bridge_atomic_disable(struct drm_bridge *bridge,
 	mutex_lock(&hdmi->mutex);
 	hdmi->disabled = true;
 	hdmi->curr_conn = NULL;
-	dw_hdmi_update_power(hdmi);
+	dw_hdmi_poweroff(hdmi);
 	dw_hdmi_update_phy_mask(hdmi);
 	handle_plugged_change(hdmi, false);
 	mutex_unlock(&hdmi->mutex);
@@ -2974,7 +2946,7 @@ static void dw_hdmi_bridge_atomic_enable(struct drm_bridge *bridge,
 	mutex_lock(&hdmi->mutex);
 	hdmi->disabled = false;
 	hdmi->curr_conn = connector;
-	dw_hdmi_update_power(hdmi);
+	dw_hdmi_poweron(hdmi);
 	dw_hdmi_update_phy_mask(hdmi);
 	handle_plugged_change(hdmi, true);
 	mutex_unlock(&hdmi->mutex);
@@ -3073,7 +3045,6 @@ void dw_hdmi_setup_rx_sense(struct dw_hdmi *hdmi, bool hpd, bool rx_sense)
 		if (hpd)
 			hdmi->rxsense = true;
 
-		dw_hdmi_update_power(hdmi);
 		dw_hdmi_update_phy_mask(hdmi);
 	}
 	mutex_unlock(&hdmi->mutex);
-- 
2.45.2


