Return-Path: <linux-kernel+bounces-210184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1EF904084
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 17:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E62AB281DC5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 15:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3233B2A2;
	Tue, 11 Jun 2024 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b="KMcCShrj"
Received: from smtp.forwardemail.net (smtp.forwardemail.net [167.172.40.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08B03FB83
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 15:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.172.40.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121135; cv=none; b=dTsfxtHLq0TLAHEomRgSh/Rsn9s3J0V0MAjYqv31uqTJ9LC/nFYdAVtW9JDXSzkwpr5uUIBwb4aN2H9T4iQU+ojGWnCyMt7C6+Apx4NzJMIFCYUzy5PyttOdzqFcWummulWMOrHmnXezhI6IKEhdu4i2z+ZZTYz2grRBRZTIFsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121135; c=relaxed/simple;
	bh=mTH7O8SoMceV83GJW8Kvwdx4Xu7+K6crQrZP50zx1Wc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQHb5P4z2ihIJ6xcxtjXRoqbsfdqd/6qxW5EziBfCSzxNIUMd4nNpGYfB1bdPUMhKVf7tbVIHYRgEyLzc1u4sFD/BpAYcHiTZqRkHsId2r5xfq/9fGSHS05RqIPPxuz4Rzum62t3WvHIH/LnhNVSdC+88QW5On18z4raXChJyPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se; dkim=pass (2048-bit key) header.d=kwiboo.se header.i=@kwiboo.se header.b=KMcCShrj; arc=none smtp.client-ip=167.172.40.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1718121117; bh=EkSsGxXsV4hgJZkNTSQ1UhXjCwhQtYShQRypQ33Ng4Q=;
 b=KMcCShrjgrH3qHS9P/uAK6eRYbaKJdS18XeGPrOz3XFNtD7wWOfNnhDjnD0XX4Z2OSbbiv/a9
 jwZR9HYb38xeW6BPYjuHdHEqOgNNFh8/EZRt8DVarXhH0jfT7fdZKH+8tyu4SfKgURxdJoQDJu+
 mo3ZBMOcsb9NJrjB9/bGcXGUTNg+gTp/XqR6reSZAzvPAp8X98jrHUfSBU4vZUit39evXwK1Dm8
 fPIiGL0O0AaYXIwbXtSiaOy7z4Og9wCDSts5BI5Qp9ePwjow2vn+pBR2dQHp6wzgIldT4Z+uB7R
 imR7oMhVg19OW6Hbs2ps/KETi6zhSTw8d2Eyo1sInxng==
From: Jonas Karlman <jonas@kwiboo.se>
To: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Laurent
 Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] drm: bridge: dw_hdmi: Use display_info is_hdmi and has_audio
Date: Tue, 11 Jun 2024 15:51:00 +0000
Message-ID: <20240611155108.1436502-9-jonas@kwiboo.se>
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
 167.172.40.54
X-ForwardEmail-ID: 66687298b913b04293b6dcb2

drm_edid_connector_update() is being called from bridge connector ops
and from detect and get_modes ops for dw-hdmi connector.

Change to use is_hdmi and has_audio from display_info directly instead
of keeping our own state in sink_is_hdmi and sink_has_audio.

Also remove the old and unused edid struct member and related define.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 32 ++++-------------------
 1 file changed, 5 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index a9c39584d31b..e162c2786178 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -43,8 +43,6 @@
 #define DDC_CI_ADDR		0x37
 #define DDC_SEGMENT_ADDR	0x30
 
-#define HDMI_EDID_LEN		512
-
 /* DW-HDMI Controller >= 0x200a are at least compliant with SCDC version 1 */
 #define SCDC_MIN_SOURCE_VERSION	0x1
 
@@ -148,8 +146,6 @@ struct dw_hdmi {
 
 	int vic;
 
-	u8 edid[HDMI_EDID_LEN];
-
 	struct {
 		const struct dw_hdmi_phy_ops *ops;
 		const char *name;
@@ -159,8 +155,6 @@ struct dw_hdmi {
 
 	struct i2c_adapter *ddc;
 	void __iomem *regs;
-	bool sink_is_hdmi;
-	bool sink_has_audio;
 
 	struct pinctrl *pinctrl;
 	struct pinctrl_state *default_state;
@@ -2041,7 +2035,7 @@ static void hdmi_av_composer(struct dw_hdmi *hdmi,
 		HDMI_FC_INVIDCONF_IN_I_P_INTERLACED :
 		HDMI_FC_INVIDCONF_IN_I_P_PROGRESSIVE;
 
-	inv_val |= hdmi->sink_is_hdmi ?
+	inv_val |= display->is_hdmi ?
 		HDMI_FC_INVIDCONF_DVI_MODEZ_HDMI_MODE :
 		HDMI_FC_INVIDCONF_DVI_MODEZ_DVI_MODE;
 
@@ -2275,7 +2269,7 @@ static int dw_hdmi_poweron(struct dw_hdmi *hdmi,
 	if (hdmi->hdmi_data.enc_out_bus_format == MEDIA_BUS_FMT_FIXED)
 		hdmi->hdmi_data.enc_out_bus_format = MEDIA_BUS_FMT_RGB888_1X24;
 
-	hdmi->hdmi_data.rgb_limited_range = hdmi->sink_is_hdmi &&
+	hdmi->hdmi_data.rgb_limited_range = display->is_hdmi &&
 		drm_default_rgb_quant_range(mode) ==
 		HDMI_QUANTIZATION_RANGE_LIMITED;
 
@@ -2295,7 +2289,7 @@ static int dw_hdmi_poweron(struct dw_hdmi *hdmi,
 	/* HDMI Initialization Step B.3 */
 	dw_hdmi_enable_video_path(hdmi);
 
-	if (hdmi->sink_has_audio) {
+	if (display->has_audio) {
 		dev_dbg(hdmi->dev, "sink has audio support\n");
 
 		/* HDMI Initialization Step E - Configure audio */
@@ -2304,7 +2298,7 @@ static int dw_hdmi_poweron(struct dw_hdmi *hdmi,
 	}
 
 	/* not for DVI mode */
-	if (hdmi->sink_is_hdmi) {
+	if (display->is_hdmi) {
 		dev_dbg(hdmi->dev, "%s HDMI mode\n", __func__);
 
 		/* HDMI Initialization Step F - Configure AVI InfoFrame */
@@ -2418,29 +2412,13 @@ static const struct drm_edid *dw_hdmi_edid_read(struct dw_hdmi *hdmi,
 						struct drm_connector *connector)
 {
 	const struct drm_edid *drm_edid;
-	const struct edid *edid;
 
 	if (!hdmi->ddc)
 		return NULL;
 
 	drm_edid = drm_edid_read_ddc(connector, hdmi->ddc);
-	if (!drm_edid) {
+	if (!drm_edid)
 		dev_dbg(hdmi->dev, "failed to get edid\n");
-		return NULL;
-	}
-
-	/*
-	 * FIXME: This should use connector->display_info.is_hdmi and
-	 * connector->display_info.has_audio from a path that has read the EDID
-	 * and called drm_edid_connector_update().
-	 */
-	edid = drm_edid_raw(drm_edid);
-
-	dev_dbg(hdmi->dev, "got edid: width[%d] x height[%d]\n",
-		edid->width_cm, edid->height_cm);
-
-	hdmi->sink_is_hdmi = drm_detect_hdmi_monitor(edid);
-	hdmi->sink_has_audio = drm_detect_monitor_audio(edid);
 
 	return drm_edid;
 }
-- 
2.45.2


