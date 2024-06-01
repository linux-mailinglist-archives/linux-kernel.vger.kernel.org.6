Return-Path: <linux-kernel+bounces-197856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E85B58D7018
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 15:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E5F7B22453
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jun 2024 13:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E9A153567;
	Sat,  1 Jun 2024 13:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QIGTIiy3"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A19F1514ED;
	Sat,  1 Jun 2024 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717247592; cv=none; b=XQ1ycELNMxbqkEjxT6pCoPU3KTFqJx3c4Puu1UKBPywUZcos2n6mW0pi+uqzUv6qQRUh8fECABZfyEdPP+JwnJZXNRMZs1/XMVNf+DqlXay8Cv4QZp5ZGKEw9Tero9qPgjT+OZTcm7okTYQeYW/9dSxoivzwDf+Ct+MCWITNOS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717247592; c=relaxed/simple;
	bh=b/8Z0IbvDFW+qeJDNTjrqHUhEf0nvgproXHjL4e1WRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kl9ZTZ19F/n3XnTCAtoG1xssFW/Gr0ETcvRiXovPnEx3Nl7GSngDBKfUv+lOCsuch8itDVh4LRR1alXXRjZcnJiA6o//+iXqE6q7GFO0NL91S5rr0rqGisD9IutJ9S+Yq9Rm0AB0M+JUC4jJm3w6oXiQK/Osa7Al1Ph5pRJBSvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QIGTIiy3; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1717247585;
	bh=b/8Z0IbvDFW+qeJDNTjrqHUhEf0nvgproXHjL4e1WRI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QIGTIiy3XZLCetWY1vfuTkHYAicPqxVBwLZGMg4+CVqjnLOC9tVhCw8R+as9Q8mpt
	 izg3Y3PL//M+kLZBoLm5q2NiuEGOhdrcUH5G1m8Yb3IZD+OXdGcbRoiXPNTD5iVrCF
	 f4TMtFd+cnIcFs0qm+q2RlEMQtO6Zj2geWLnd6qiQdXz639OJRyA3w5c0opQY49IJ9
	 GZrCgrExzVOjmvpVQ/pNxy/W5u8qWn0lKYaBMJtGt/AHUu0WKr1dfxKMGR7JpygMMZ
	 vjtR8jKpjdKgTN3Ps8fpm5PsQNlpjaLn2fMcr1ksajJEE7AbbXY7O4eNdDkH6bUyIw
	 yCzEhq/KCgvyg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A257E37821ED;
	Sat,  1 Jun 2024 13:13:05 +0000 (UTC)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 01 Jun 2024 16:12:28 +0300
Subject: [PATCH 06/14] drm/bridge: dw-hdmi: Factor out hdmi_data_info setup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240601-b4-rk3588-bridge-upstream-v1-6-f6203753232b@collabora.com>
References: <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
In-Reply-To: <20240601-b4-rk3588-bridge-upstream-v1-0-f6203753232b@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Mark Yao <markyao0591@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 devicetree@vger.kernel.org, kernel@collabora.com, 
 Alexandre ARNOUD <aarnoud@me.com>, Luis de Arquer <ldearquer@gmail.com>
X-Mailer: b4 0.14-dev-f7c49

In preparation to add support for the HDMI 2.1 Quad-Pixel TX Controller
and minimize code duplication, factor out the hdmi_data_info setup from
dw_hdmi_setup() into a common dw_hdmi_prep_data() helper.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-common.h |  2 ++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c        | 21 ++++++++++++++-------
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-common.h b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-common.h
index e73b8eb7528b..5fb65db4aaea 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-common.h
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-common.h
@@ -156,6 +156,8 @@ void dw_hdmi_prep_avi_infoframe(struct hdmi_avi_infoframe *frame,
 				const struct drm_display_mode *mode);
 struct hdmi_vmode *dw_hdmi_prep_vmode(struct dw_hdmi *hdmi,
 				      const struct drm_display_mode *mode);
+void dw_hdmi_prep_data(struct dw_hdmi *hdmi,
+		       const struct drm_display_mode *mode);
 
 enum drm_connector_status
 dw_hdmi_connector_detect(struct drm_connector *connector, bool force);
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 5cf929f68ae9..d124c781da20 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2133,14 +2133,9 @@ static void hdmi_disable_overflow_interrupts(struct dw_hdmi *hdmi)
 		    HDMI_IH_MUTE_FC_STAT2);
 }
 
-static int dw_hdmi_setup(struct dw_hdmi *hdmi,
-			 const struct drm_connector *connector,
-			 const struct drm_display_mode *mode)
+void dw_hdmi_prep_data(struct dw_hdmi *hdmi,
+		       const struct drm_display_mode *mode)
 {
-	int ret;
-
-	hdmi_disable_overflow_interrupts(hdmi);
-
 	hdmi->vic = drm_match_cea_mode(mode);
 
 	if (!hdmi->vic) {
@@ -2180,6 +2175,18 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi,
 	hdmi->hdmi_data.pix_repet_factor = 0;
 	hdmi->hdmi_data.hdcp_enable = 0;
 	hdmi->hdmi_data.video_mode.mdataenablepolarity = true;
+}
+EXPORT_SYMBOL_GPL(dw_hdmi_prep_data);
+
+static int dw_hdmi_setup(struct dw_hdmi *hdmi,
+			 const struct drm_connector *connector,
+			 const struct drm_display_mode *mode)
+{
+	int ret;
+
+	hdmi_disable_overflow_interrupts(hdmi);
+
+	dw_hdmi_prep_data(hdmi, mode);
 
 	/* HDMI Initialization Step B.1 */
 	hdmi_av_composer(hdmi, &connector->display_info, mode);

-- 
2.45.0


