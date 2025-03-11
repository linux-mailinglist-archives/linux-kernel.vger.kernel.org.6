Return-Path: <linux-kernel+bounces-555918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E84A5BE57
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:58:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BE0418977F5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322AD254842;
	Tue, 11 Mar 2025 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="n/tmrmDC"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50AD2517A6
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741690686; cv=none; b=qN4Lw/Ep8EAybBkgoa+hRdBU2fRuVpMg0ycv4eG3t8DGf3E2j7Tq2DwbKz/4GIe215feYrLdOLtA8E4DE+rspQjr708kZYWnWIH5dSIsab5FDTBGXY3IJkWfsAvFh5j2BUqRKxjDDwJVUFt+PjammCW0I/GElfWB6bUMxa0MoCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741690686; c=relaxed/simple;
	bh=PAAHfRJlJgPmv8TXkz6H6alfaTXfN/+n7cw+Nsu+Vno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=REyd9EJuEzhUUXeMj1NH1lvwjNfaIe0zA1QeIVpFlS3lhCjlc/F3JA/AZdofwupPQBggNxMpDjJZx9wqAGUro/pezdFO49BxEOZjFMTWZCTc+kVjC/oQWJPJblZMfjVTwPgl2iUctHPxyWP/W5SnX5rd6rZjwUglni9NayFw14U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=n/tmrmDC; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741690682;
	bh=PAAHfRJlJgPmv8TXkz6H6alfaTXfN/+n7cw+Nsu+Vno=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=n/tmrmDCrlL9taSe2Z3hmj2bFv3Gq+8rDgJuoW94kXo2PmdJCdJgbu/t/NICkFsbE
	 aFZb671L2rrVhZav+lM93unFXi3w+WIR3dklSfSjUFvcyhxesJapFYamjzLRrMVzkS
	 6/cSGNrGjDZiUlkNk77OYt373tWixF/n3whJiblCDJ6XZPRsRiExWQfd1UM/hROxDn
	 u8ZBgJHzxKwNwoGFDR5W3YbENg+HTybNUpOpuIorDQJykXbYW4760QtnAnBNQL4mhB
	 V3y1ltlAje9G4F8oYEnMwiVSuM2iGEHH4Pn0MnNJLMKxiUauAahxBp0zual8rKblBG
	 m5qG5vg/RhjDA==
Received: from localhost (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id B6C6517E1506;
	Tue, 11 Mar 2025 11:58:02 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 11 Mar 2025 12:57:36 +0200
Subject: [PATCH v2 4/7] drm/connector: hdmi: Use YUV420 output format as an
 RGB fallback
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-hdmi-conn-yuv-v2-4-fbdb94f02562@collabora.com>
References: <20250311-hdmi-conn-yuv-v2-0-fbdb94f02562@collabora.com>
In-Reply-To: <20250311-hdmi-conn-yuv-v2-0-fbdb94f02562@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

Try to make use of YUV420 when computing the best output format and
RGB cannot be supported for any of the available color depths.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 69 +++++++++++++------------
 1 file changed, 35 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index a70e204a8df3ac1c2d7318e81cde87a83267dd21..f2052781b797dd09b41127e33d98fe25408a9b23 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -287,8 +287,9 @@ hdmi_try_format_bpc(const struct drm_connector *connector,
 	struct drm_device *dev = connector->dev;
 	int ret;
 
-	drm_dbg_kms(dev, "Trying %s output format\n",
-		    drm_hdmi_connector_get_output_format_name(fmt));
+	drm_dbg_kms(dev, "Trying %s output format with %u bpc\n",
+		    drm_hdmi_connector_get_output_format_name(fmt),
+		    bpc);
 
 	if (!sink_supports_format_bpc(connector, info, mode, fmt, bpc)) {
 		drm_dbg_kms(dev, "%s output format not supported with %u bpc\n",
@@ -313,47 +314,22 @@ hdmi_try_format_bpc(const struct drm_connector *connector,
 }
 
 static int
-hdmi_compute_format(const struct drm_connector *connector,
-		    struct drm_connector_state *conn_state,
-		    const struct drm_display_mode *mode,
-		    unsigned int bpc)
-{
-	struct drm_device *dev = connector->dev;
-
-	/*
-	 * TODO: Add support for YCbCr420 output for HDMI 2.0 capable
-	 * devices, for modes that only support YCbCr420.
-	 */
-	if (hdmi_try_format_bpc(connector, conn_state, mode, bpc, HDMI_COLORSPACE_RGB)) {
-		conn_state->hdmi.output_format = HDMI_COLORSPACE_RGB;
-		return 0;
-	}
-
-	drm_dbg_kms(dev, "Failed. No Format Supported for that bpc count.\n");
-
-	return -EINVAL;
-}
-
-static int
-hdmi_compute_config(const struct drm_connector *connector,
-		    struct drm_connector_state *conn_state,
-		    const struct drm_display_mode *mode)
+hdmi_try_format(const struct drm_connector *connector,
+		struct drm_connector_state *conn_state,
+		const struct drm_display_mode *mode,
+		unsigned int max_bpc, enum hdmi_colorspace fmt)
 {
 	struct drm_device *dev = connector->dev;
-	unsigned int max_bpc = clamp_t(unsigned int,
-				       conn_state->max_bpc,
-				       8, connector->max_bpc);
 	unsigned int bpc;
 	int ret;
 
 	for (bpc = max_bpc; bpc >= 8; bpc -= 2) {
-		drm_dbg_kms(dev, "Trying with a %d bpc output\n", bpc);
-
-		ret = hdmi_compute_format(connector, conn_state, mode, bpc);
-		if (ret)
+		ret = hdmi_try_format_bpc(connector, conn_state, mode, bpc, fmt);
+		if (!ret)
 			continue;
 
 		conn_state->hdmi.output_bpc = bpc;
+		conn_state->hdmi.output_format = fmt;
 
 		drm_dbg_kms(dev,
 			    "Mode %ux%u @ %uHz: Found configuration: bpc: %u, fmt: %s, clock: %llu\n",
@@ -368,6 +344,31 @@ hdmi_compute_config(const struct drm_connector *connector,
 	return -EINVAL;
 }
 
+static int
+hdmi_compute_config(const struct drm_connector *connector,
+		    struct drm_connector_state *conn_state,
+		    const struct drm_display_mode *mode)
+{
+	unsigned int max_bpc = clamp_t(unsigned int,
+				       conn_state->max_bpc,
+				       8, connector->max_bpc);
+	int ret;
+
+	ret = hdmi_try_format(connector, conn_state, mode, max_bpc,
+			      HDMI_COLORSPACE_RGB);
+	if (!ret)
+		return 0;
+
+	if (connector->ycbcr_420_allowed)
+		ret = hdmi_try_format(connector, conn_state, mode, max_bpc,
+				      HDMI_COLORSPACE_YUV420);
+	else
+		drm_dbg_kms(connector->dev,
+			    "%s output format not allowed for connector\n",
+			    drm_hdmi_connector_get_output_format_name(HDMI_COLORSPACE_YUV420));
+	return ret;
+}
+
 static int hdmi_generate_avi_infoframe(const struct drm_connector *connector,
 				       struct drm_connector_state *conn_state)
 {

-- 
2.48.1


