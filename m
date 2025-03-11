Return-Path: <linux-kernel+bounces-555916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31FA6A5BE56
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 944517A5F42
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 10:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2042528F5;
	Tue, 11 Mar 2025 10:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bg2PhIEG"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE5B250BF5
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 10:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741690684; cv=none; b=mpYNG5XPIHMVVvXYTlPb3YnuLXkDwGzJuBIabGW779GUKYKEMYCdsofsC4Fj1pguoC67c6OZdbITDP49uov97VEWpw2i8gXVzTvwkzpn34aA5i8kljAiRM93QD+Zj9MDAiP3pkx35vV/pKilZwR4Z4efGP4QyG0YDXStet0nZzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741690684; c=relaxed/simple;
	bh=wxU0vpazAHKIZ5XkXkiKNjCJEGjpsbcsO2bmaGXOPUM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HRWz11hIYvSf4HuxeclSOlaJcqjjlV/28LXGWQugXmW0XcmWdyGbjEO+L5fbEoKSb2UFsI4bOz8bdJjFIECeNIPTM1kiMs4ZzjrwxB2+GlSV9AGG6Dl6S+C5ACW4d9oqx3uZlG2PPM17LUs1ciUEKc4HlaHDI9lRQ6XRLew495Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bg2PhIEG; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1741690681;
	bh=wxU0vpazAHKIZ5XkXkiKNjCJEGjpsbcsO2bmaGXOPUM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bg2PhIEGZRW1d3Vo9qhEreMy/ofnxiCWlaBFsTwQDkO0UkfxEiaWAOhORhaYAr2Ku
	 Ya52LWvnVh28FxOlUcoSyoH8Qn+kDeM0/VG46K+avnqURkdXElW8Jj00wL877ALyq0
	 t56E8cUTqv6c50IYnvAgQVuKNgCsOsAFgFd36mmFsK5ujRy3nYJiulOS6taTz62daQ
	 FGIJYfJSWW0s3gzGPg9s3pFP6zZXLMqdPS85/Y3yX08XMw7iLpocYNU4nAD8J5TxRb
	 r/Wl84zTEmJ5oQ/Zu1DOzd5HvTWdlX1xqSP+Id+Efao887+3jGGLfVWWZV9elJ0KEV
	 869JcZG1h4E5Q==
Received: from localhost (unknown [84.232.140.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with UTF8SMTPSA id 1C17917E14EF;
	Tue, 11 Mar 2025 11:58:01 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 11 Mar 2025 12:57:34 +0200
Subject: [PATCH v2 2/7] drm/connector: hdmi: Add support for YUV420 format
 verification
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-hdmi-conn-yuv-v2-2-fbdb94f02562@collabora.com>
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

Provide the necessary constraints verification in
sink_supports_format_bpc() in order to support handling of YUV420
output format.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 40 +++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index 6bc96d5d1ab9115989e208d9899e16cd22254fb6..e99d868edc1854eddc5ebf8692ccffb9e2338268 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -3,6 +3,7 @@
 #include <drm/drm_atomic.h>
 #include <drm/drm_connector.h>
 #include <drm/drm_edid.h>
+#include <drm/drm_modes.h>
 #include <drm/drm_print.h>
 
 #include <drm/display/drm_hdmi_audio_helper.h>
@@ -115,6 +116,12 @@ sink_supports_format_bpc(const struct drm_connector *connector,
 		return false;
 	}
 
+	if (drm_mode_is_420_only(info, mode) && format != HDMI_COLORSPACE_YUV420) {
+		drm_dbg_kms(dev, "%s format unsupported by the sink for VIC%u.\n",
+			    drm_hdmi_connector_get_output_format_name(format), vic);
+		return false;
+	}
+
 	switch (format) {
 	case HDMI_COLORSPACE_RGB:
 		drm_dbg_kms(dev, "RGB Format, checking the constraints.\n");
@@ -145,9 +152,36 @@ sink_supports_format_bpc(const struct drm_connector *connector,
 		return true;
 
 	case HDMI_COLORSPACE_YUV420:
-		/* TODO: YUV420 is unsupported at the moment. */
-		drm_dbg_kms(dev, "YUV420 format isn't supported yet.\n");
-		return false;
+		drm_dbg_kms(dev, "YUV420 format, checking the constraints.\n");
+
+		if (!(info->color_formats & DRM_COLOR_FORMAT_YCBCR420)) {
+			drm_dbg_kms(dev, "Sink doesn't support YUV420.\n");
+			return false;
+		}
+
+		if (!drm_mode_is_420(info, mode)) {
+			drm_dbg_kms(dev, "Sink doesn't support YUV420 for VIC%u.\n", vic);
+			return false;
+		}
+
+		if (bpc == 10 && !(info->hdmi.y420_dc_modes & DRM_EDID_YCBCR420_DC_30)) {
+			drm_dbg_kms(dev, "10 BPC but sink doesn't support Deep Color 30.\n");
+			return false;
+		}
+
+		if (bpc == 12 && !(info->hdmi.y420_dc_modes & DRM_EDID_YCBCR420_DC_36)) {
+			drm_dbg_kms(dev, "12 BPC but sink doesn't support Deep Color 36.\n");
+			return false;
+		}
+
+		if (bpc == 16 && !(info->hdmi.y420_dc_modes & DRM_EDID_YCBCR420_DC_48)) {
+			drm_dbg_kms(dev, "16 BPC but sink doesn't support Deep Color 48.\n");
+			return false;
+		}
+
+		drm_dbg_kms(dev, "YUV420 format supported in that configuration.\n");
+
+		return true;
 
 	case HDMI_COLORSPACE_YUV422:
 		drm_dbg_kms(dev, "YUV422 format, checking the constraints.\n");

-- 
2.48.1


