Return-Path: <linux-kernel+bounces-320229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35FA9707D1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 15:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B29FF2826AC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 13:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9CD16938C;
	Sun,  8 Sep 2024 13:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="irIJXzKj"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DCF116BE3F
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.28.215.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725802166; cv=none; b=dpHbHzfOlUmgJ7iyi8Zx/sAoxcb1HSeDKxNLk3GA34q6bAy0puI62hiF/ttm9MMhVzdy1gdz2YtQc9Ona/0CPcozqKakrxyV40Q/mU7MwwcbfbjSbIvXTMlww6YCgRnRH5Ued941VdtLV8tZURZnng8k21HJh/WSLvcj7qrbeFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725802166; c=relaxed/simple;
	bh=yjxwFeT+ax2YQbYDL/znuQXIisIA+xYp2KdtH3aXyC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A1kqFs/p/9tRE0/ArdN7mwtv4ibhnjZWXl0o4y0hfH2dQyUK6BbPIlXxfEaTtLthhAI+xG8VC1Xpz+x1fJyMGV4+nibPVn7ue1iDca/7PwN2arPPktANHdQz5h14IPHnpIu36c3CFG8CGtFEPBcLznOjmASH/hD+6PRXFXdb53E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=irIJXzKj; arc=none smtp.client-ip=149.28.215.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1725802145; bh=bw7hUA9+T9ojuBGzAwclXIncQiP3YNb92ShoyGh/flo=;
 b=irIJXzKjfxQDHQuGOAJzKUxX4mvjCB4XMUrvWnyX9XcNVS0WkpkPBwmf4okaWaixE6WIcKRzQ
 YqgkSQBE/yZrD5XcgwidI1wV2I8ZRndbkzgsW92FzCfUqf4NWU0SLve6yaF/bAVSGO83SDjAKsM
 EUyBayPFiykG3+5NBN5NGz7q0+JTVHkeiX4FF6qvh+nEnLF670zgk2nhuJA1pxnosZi6TMRw48u
 t89YR5ikSMgw6rLnRq/AjR37QCLvMVmGC5KAMeFQHif4kF60Eq7AYbUWJbfxmKK0ENFwLDmCMB/
 vwjGHB7aiXCv7qC2t030xXkw+AcEir6354uHB2habKtQ==
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
Subject: [PATCH v2 07/10] drm: bridge: dw_hdmi: Invalidate CEC phys addr from connector detect
Date: Sun,  8 Sep 2024 13:28:09 +0000
Message-ID: <20240908132823.3308029-8-jonas@kwiboo.se>
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
X-ForwardEmail-ID: 66dda69d3c9877b45958797c

Wait until the connector detect ops is called to invalidate CEC phys
addr instead of doing it directly from the irq handler.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Collect r-b tag
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 6a94376a3da3..8ec97babd334 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2454,7 +2454,17 @@ dw_hdmi_connector_detect(struct drm_connector *connector, bool force)
 {
 	struct dw_hdmi *hdmi = container_of(connector, struct dw_hdmi,
 					     connector);
-	return dw_hdmi_detect(hdmi);
+	enum drm_connector_status status;
+
+	status = dw_hdmi_detect(hdmi);
+
+	if (status == connector_status_disconnected) {
+		mutex_lock(&hdmi->cec_notifier_mutex);
+		cec_notifier_phys_addr_invalidate(hdmi->cec_notifier);
+		mutex_unlock(&hdmi->cec_notifier_mutex);
+	}
+
+	return status;
 }
 
 static int dw_hdmi_connector_get_modes(struct drm_connector *connector)
@@ -3065,12 +3075,6 @@ static irqreturn_t dw_hdmi_irq(int irq, void *dev_id)
 				       phy_stat & HDMI_PHY_HPD,
 				       phy_stat & HDMI_PHY_RX_SENSE);
 
-		if ((phy_stat & (HDMI_PHY_RX_SENSE | HDMI_PHY_HPD)) == 0) {
-			mutex_lock(&hdmi->cec_notifier_mutex);
-			cec_notifier_phys_addr_invalidate(hdmi->cec_notifier);
-			mutex_unlock(&hdmi->cec_notifier_mutex);
-		}
-
 		if ((intr_stat & HDMI_IH_PHY_STAT0_HPD) &&
 		    (phy_stat & HDMI_PHY_HPD))
 			status = connector_status_connected;
-- 
2.46.0


