Return-Path: <linux-kernel+bounces-576804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E38EA714AA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 11:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3813B7211
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 10:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D921DCB09;
	Wed, 26 Mar 2025 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bUftxO2g"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258621CCEC8
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984408; cv=none; b=O2o0BVSoKuXl73Qw8YrBpLZBN2GoD3OtZl9NWzgmGXn/7tXGHcZxFHmteXKiCr9YtKhyBu1YijpfB5K4RcXmyVn9l7UwMfekUxuWd4FoUzoY3fsoiKnAPO5P26z6RxSpwlDgYK/myHTBx8sySvREaPObh9czhMFzgy8SKZz6h3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984408; c=relaxed/simple;
	bh=rDMIZe5hN1CpqlraSPGbOSqAAdKIHU8LVaZsRBJpU/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cygPF6H3jzXvX3DXdZ0ZxqLtA8N2Vq/kYs+zTBUDGcAyHokmwzuk15X8s7WuRitre5qqTHWdZO0abDWKJA4Blm2Dnt6xAJptnisTG/taoDXxrbMngxc0T4IbTLAw2S7an4A8SmvLADRVacMXxteiNt9YnToul1aRDGVBJbh6qrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bUftxO2g; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742984404;
	bh=rDMIZe5hN1CpqlraSPGbOSqAAdKIHU8LVaZsRBJpU/8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bUftxO2giwIrp8JHsRO+iHdJjx4E5YZOdVgSNOF0rCm+HBVIfENEPJw8esr8rLiDi
	 Z5Ky2eAca+cgX4pnSlb0LGKlcC+JbApmF9KNAtcOnS9a/2ccywMvzCP82YVevd3oA8
	 0JUXm6fCk9Xjet5nIYo3Y5rZAe7J4cmq1Rac0+tNDlUshg1xxec5NuMq1qRNNwfzVa
	 bPDR0dYP88nSYQE+ngQbWqVCfr/LBl9ElgMBe0f+Tx2ZTQyTJXTWK7VSg8zgpFyji0
	 B8AOWGUFYfMS5GHtgXymioTQyCMItx/pmHS3cZfyacLdlxWbfm2Fb+6bkruxUpuf1Y
	 lPEHx4JcY6Pig==
Received: from localhost (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 387CB17E0A5D;
	Wed, 26 Mar 2025 11:20:04 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 26 Mar 2025 12:19:55 +0200
Subject: [PATCH v3 06/15] drm/connector: hdmi: Factor out bpc and format
 computation logic
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-hdmi-conn-yuv-v3-6-294d3ebbb4b2@collabora.com>
References: <20250326-hdmi-conn-yuv-v3-0-294d3ebbb4b2@collabora.com>
In-Reply-To: <20250326-hdmi-conn-yuv-v3-0-294d3ebbb4b2@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2

In preparation to support fallback to an alternative output format, e.g.
YUV420, when RGB cannot be used for any of the available color depths,
move the bpc try loop out of hdmi_compute_config() and, instead, make it
part of hdmi_compute_format_bpc().  Additionally, add a new parameter to
the latter holding the output format to be checked and eventually set.

This improves code reusability and further extensibility.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 50 ++++++++++++-------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index 160964190d82ac233fdbe34ac54024a007a19872..6de0abb15ecb36fd4eb98725e2a3835e5e0db134 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -608,42 +608,19 @@ static int
 hdmi_compute_format_bpc(const struct drm_connector *connector,
 			struct drm_connector_state *conn_state,
 			const struct drm_display_mode *mode,
-			unsigned int bpc)
+			unsigned int max_bpc, enum hdmi_colorspace fmt)
 {
 	struct drm_device *dev = connector->dev;
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
-{
-	struct drm_device *dev = connector->dev;
-	unsigned int max_bpc = clamp_t(unsigned int,
-				       conn_state->max_bpc,
-				       8, connector->max_bpc);
 	unsigned int bpc;
 	int ret;
 
 	for (bpc = max_bpc; bpc >= 8; bpc -= 2) {
-		ret = hdmi_compute_format_bpc(connector, conn_state, mode, bpc);
-		if (ret)
+		ret = hdmi_try_format_bpc(connector, conn_state, mode, bpc, fmt);
+		if (!ret)
 			continue;
 
 		conn_state->hdmi.output_bpc = bpc;
+		conn_state->hdmi.output_format = fmt;
 
 		drm_dbg_kms(dev,
 			    "Mode %ux%u @ %uHz: Found configuration: bpc: %u, fmt: %s, clock: %llu\n",
@@ -655,9 +632,28 @@ hdmi_compute_config(const struct drm_connector *connector,
 		return 0;
 	}
 
+	drm_dbg_kms(dev, "Failed. %s output format not supported for any bpc count.\n",
+		    drm_hdmi_connector_get_output_format_name(fmt));
+
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
+	ret = hdmi_compute_format_bpc(connector, conn_state, mode, max_bpc,
+				      HDMI_COLORSPACE_RGB);
+
+	return ret;
+}
+
 static int hdmi_generate_avi_infoframe(const struct drm_connector *connector,
 				       struct drm_connector_state *conn_state)
 {

-- 
2.49.0


