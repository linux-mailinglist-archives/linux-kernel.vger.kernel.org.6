Return-Path: <linux-kernel+bounces-320227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2289707CF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 15:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A24792825AF
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 13:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF3316BE18;
	Sun,  8 Sep 2024 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="eXg+J6yY"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [207.246.76.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4B116B396
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 13:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.246.76.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725802158; cv=none; b=CQA+MzKQlG7JcU4kF0VKvmMLHA4kKb+eGJwaAQWxi/naK7wDaC0/fA4GEC8lvGzFZcIS70d5ZlkIR0h1JJ1fBlNshEvNc/nagYekFp+w5h3mhlmShyrJrfbDezcFLq4/vqby4izH03KK7PEgC+M1ZJmKe1aXVIMcbkq6CsvlsCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725802158; c=relaxed/simple;
	bh=2oOtJBX+NrccfHTcufrs6z0wriZKAF9lH7s08bQrrQs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AxkJ4uJh/QDWeCAbfh8Ip+OW8Kq+9Y736ZJBBMjyvyulkCzA+Bj1mtagyL8yEGSbdG1TJkCr0otMNirCks1sNXAIky5TXVmreSqZKYoJylhUUa13USm6tbYev+YfdAzYzi8MJQ0xnj22pBGS0lVju1fZWzibWcH5P7QKfxXBcAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=eXg+J6yY; arc=none smtp.client-ip=207.246.76.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1725802135; bh=dbyT3VAtgqFNJh28eDMPmAIkHE6wApqXiwyZdxlGJ50=;
 b=eXg+J6yY2ho68gZxczDf9ptPgVNEqKCgFIUF1ABOkk9V+8oRlByp15AaaIdvk2/wpE9Skwwmt
 bU4CQR4DApmyxK31xVIODvcSmhATVv/xe0wA+1LHjkTCXVuz5bo/Vo/zDuEryHi/0RytbMowC3E
 PLS3iOrlix/1uMLfUqph2TtBso8mSJi9Hu97+PkSNdkXu42L+sXgPlVT/j8775S/Z/3xNS45raR
 wf/R9KthxXUnPwtsuAJ/uL5/vk8v7VYpIL7ylra9Kd+M8vXFwGPJWsRc3XnWYUiMXRwx+oNmr2N
 sbIOrjlhI/4lBzOlSq9O3+4K4AQguMSxUc+02sN8fbxQ==
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
Subject: [PATCH v2 05/10] drm: bridge: dw_hdmi: Fold poweron and setup functions
Date: Sun,  8 Sep 2024 13:28:07 +0000
Message-ID: <20240908132823.3308029-6-jonas@kwiboo.se>
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
 207.246.76.47
X-ForwardEmail-ID: 66dda6943c9877b459587956

Fold the poweron and setup functions into one function and use the
adjusted_mode directly from the new crtc_state to remove the need of
storing previous_mode.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: No change
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 87fb6fd5cffd..1eefa633ff78 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2236,9 +2236,9 @@ static void hdmi_disable_overflow_interrupts(struct dw_hdmi *hdmi)
 		    HDMI_IH_MUTE_FC_STAT2);
 }
 
-static int dw_hdmi_setup(struct dw_hdmi *hdmi,
-			 const struct drm_connector *connector,
-			 const struct drm_display_mode *mode)
+static int dw_hdmi_poweron(struct dw_hdmi *hdmi,
+			   const struct drm_connector *connector,
+			   const struct drm_display_mode *mode)
 {
 	const struct drm_display_info *display = &connector->display_info;
 	int ret;
@@ -2378,15 +2378,6 @@ static void initialize_hdmi_ih_mutes(struct dw_hdmi *hdmi)
 	hdmi_writeb(hdmi, ih_mute, HDMI_IH_MUTE);
 }
 
-static void dw_hdmi_poweron(struct dw_hdmi *hdmi)
-{
-	/*
-	 * The curr_conn field is guaranteed to be valid here, as this function
-	 * is only be called when !hdmi->disabled.
-	 */
-	dw_hdmi_setup(hdmi, hdmi->curr_conn, &hdmi->previous_mode);
-}
-
 static void dw_hdmi_poweroff(struct dw_hdmi *hdmi)
 {
 	if (hdmi->phy.enabled) {
@@ -2936,15 +2927,19 @@ static void dw_hdmi_bridge_atomic_enable(struct drm_bridge *bridge,
 {
 	struct dw_hdmi *hdmi = bridge->driver_private;
 	struct drm_atomic_state *state = old_state->base.state;
+	const struct drm_display_mode *mode;
 	struct drm_connector *connector;
+	struct drm_crtc *crtc;
 
 	connector = drm_atomic_get_new_connector_for_encoder(state,
 							     bridge->encoder);
+	crtc = drm_atomic_get_new_connector_state(state, connector)->crtc;
+	mode = &drm_atomic_get_new_crtc_state(state, crtc)->adjusted_mode;
 
 	mutex_lock(&hdmi->mutex);
 	hdmi->disabled = false;
 	hdmi->curr_conn = connector;
-	dw_hdmi_poweron(hdmi);
+	dw_hdmi_poweron(hdmi, connector, mode);
 	dw_hdmi_update_phy_mask(hdmi);
 	handle_plugged_change(hdmi, true);
 	mutex_unlock(&hdmi->mutex);
-- 
2.46.0


