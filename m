Return-Path: <linux-kernel+bounces-570001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BDC2A6AA92
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11F14982C6C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434AB22A1EF;
	Thu, 20 Mar 2025 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="eTkGfef9"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1106621D3F9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486460; cv=none; b=tjg6sZXZgHCoh8t9Y9oKUyjQ6coqvQQipPjDXoXyCv3MCMRYmRhRzkPo4hoAXkiiWJ8wEAEMFSS/YE23V5wXgaWEfF8L9lM33mXzV1WImpXuKZE6MykdR3i/whNC+nRidt0z5mQM0NgXWxdYmUGzv9ua8BTe+tzLVfAoLXFiW/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486460; c=relaxed/simple;
	bh=NRiwCTHabbz+p81RY4GkrUeFRgzVyalNNk+RjRNcX5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jlHyaO1eF0Bn+8qimL4xVPM4LfionFl5oA/I8uMvlwXOREUxS3CQp4NR4eCgEm+/WwI4pO3x4JCOyagje7JYK7OlokUlP+mVYTQo6knw6ZMjjifU2xfYE8lFl4/6yEF5CBCBEuc6aN8ryZ23hRQqEDkNCXjPaUHbjwzbEL/FC5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=eTkGfef9; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 158091AF6;
	Thu, 20 Mar 2025 16:59:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1742486342;
	bh=NRiwCTHabbz+p81RY4GkrUeFRgzVyalNNk+RjRNcX5o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eTkGfef9c4eLyHnGTF57/9I38Tmd/aF81JpzOp7HKJ8/VG3HDfHDYwW3os64W3Xpy
	 mfXOMniZoprYsVQH1Uo/+JM6KZtXiAQajY2eXKTsqaIwoNuXJwMYPb2prG6pYyy1UC
	 i76idGffrPitu9uxhFQL9wg6KXjPXScOCPiC4sK0=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 20 Mar 2025 18:00:08 +0200
Subject: [PATCH 13/18] drm/bridge: cdns-dsi: Do not use crtc_* values
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-cdns-dsi-impro-v1-13-725277c5f43b@ideasonboard.com>
References: <20250320-cdns-dsi-impro-v1-0-725277c5f43b@ideasonboard.com>
In-Reply-To: <20250320-cdns-dsi-impro-v1-0-725277c5f43b@ideasonboard.com>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, Francesco Dolcini <francesco@dolcini.it>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3185;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=NRiwCTHabbz+p81RY4GkrUeFRgzVyalNNk+RjRNcX5o=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBn3DuaJBl/Bj3bIpsidbOdy0WDF+M2ekIW2h00H
 CV/5EUW1vCJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ9w7mgAKCRD6PaqMvJYe
 9WE1EACQbmVEp0iXWdv/F75eMgjtyPJQC74XIzB+5fNwrjOIyV/bxvzwg4UwrTkQeVhaGkhfxz7
 O/Tt42jR/dfCNX4AMeIsF/YeWmxn2mNWk5oDslMLZBKVzjab2acg4Lz0DVq14xsruij9Ytrg2sE
 3HWtInuu9ZpGPANhHQG4VJlF6ghkvWgZ6WPnWfH3b7YEU+s9vR0l1FmhzD0AgzWu2vXmMqG6P/F
 zTOTH8QnB0DZmdGbnkZdMQNEsmqcmnsaGrdUMO3vQzmEpVkeIlicClDcm0fagjEmaEfoDbrvTO8
 OyWO0u+hsT4wiQGlBOYb5Rxaes9yUTvaI/ug+wFAMCV3P3du4/cB3c+0b73R/isokqs41mO94wW
 zsO8s87VsiaCrqpdODfMFj/imWgH2Gns3a9WNvBfnc1eRJbbelzXZhqDxYPTa8RoXabI4iScqTH
 3nnn/ajLN5ZAy7sKk0BnPxWrmaX3p7sGw3WiUIAQ6V8e7fUtfooP2I8HO/p78rxO47wjkI+nCnr
 oNpV44QDFoDIH8Gk3G5rWFH9N6LkNng5r2402ePIgAIgUncxntg4JbJgR/w5vHpTQ+H0pQ3Oms4
 zXegaAStHwEVpSz4PIxp2PX3pR7QzbZBRbhVC8eroqWQdp4jkKVNZt/hVQvrCU2QYLTP4cgrv6/
 z0/rszyd/2WyZSw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

The driver uses crtc_* fields from the mode. While I think in the
enable-path this would be correct, I do not think it's correct in the
check phase, as the crtc hasn't had a chance to update the crtc_* fields
yet.

Overall, my understanding is that the crtc_* fields are relevant only in
cases where we have things like interlace or double pixel mode, where we
have a logical and real timings. We never use those with DSI, so the
crtc_* fields should just always match the normal values.

So, drop the use of crtc_* values.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index cf783680b1b4..220213f5cb09 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -476,10 +476,10 @@ static int cdns_dsi_mode2cfg(struct cdns_dsi *dsi,
 	bool sync_pulse;
 	int bpp;
 
-	dpi_hsa = mode->crtc_hsync_end - mode->crtc_hsync_start;
-	dpi_hbp = mode->crtc_htotal - mode->crtc_hsync_end;
-	dpi_hfp =  mode->crtc_hsync_start - mode->crtc_hdisplay;
-	dpi_hact = mode->crtc_hdisplay;
+	dpi_hsa = mode->hsync_end - mode->hsync_start;
+	dpi_hbp = mode->htotal - mode->hsync_end;
+	dpi_hfp =  mode->hsync_start - mode->hdisplay;
+	dpi_hact = mode->hdisplay;
 
 	memset(dsi_cfg, 0, sizeof(*dsi_cfg));
 
@@ -540,11 +540,11 @@ static int cdns_dsi_adjust_phy_config(struct cdns_dsi *dsi,
 	if (dsi_htotal % lanes)
 		adj_dsi_htotal += lanes - (dsi_htotal % lanes);
 
-	dpi_hz = mode->crtc_clock * 1000;
+	dpi_hz = mode->clock * 1000;
 	dlane_bps = (unsigned long long)dpi_hz * adj_dsi_htotal;
 
 	/* data rate in bytes/sec is not an integer, refuse the mode. */
-	dpi_htotal = mode->crtc_htotal;
+	dpi_htotal = mode->htotal;
 	if (do_div(dlane_bps, lanes * dpi_htotal))
 		return -EINVAL;
 
@@ -572,7 +572,7 @@ static int cdns_dsi_check_conf(struct cdns_dsi *dsi,
 	if (ret)
 		return ret;
 
-	ret = phy_mipi_dphy_get_default_config(mode->crtc_clock * 1000,
+	ret = phy_mipi_dphy_get_default_config(mode->clock * 1000,
 					       mipi_dsi_pixel_format_to_bpp(output->dev->format),
 					       nlanes, phy_cfg);
 	if (ret)
@@ -822,11 +822,11 @@ static void cdns_dsi_bridge_atomic_pre_enable(struct drm_bridge *bridge,
 	writel(HFP_LEN(dsi_cfg.hfp) | HACT_LEN(dsi_cfg.hact),
 	       dsi->regs + VID_HSIZE2);
 
-	writel(VBP_LEN(mode->crtc_vtotal - mode->crtc_vsync_end - 1) |
-	       VFP_LEN(mode->crtc_vsync_start - mode->crtc_vdisplay) |
-	       VSA_LEN(mode->crtc_vsync_end - mode->crtc_vsync_start + 1),
+	writel(VBP_LEN(mode->vtotal - mode->vsync_end - 1) |
+	       VFP_LEN(mode->vsync_start - mode->vdisplay) |
+	       VSA_LEN(mode->vsync_end - mode->vsync_start + 1),
 	       dsi->regs + VID_VSIZE1);
-	writel(mode->crtc_vdisplay, dsi->regs + VID_VSIZE2);
+	writel(mode->vdisplay, dsi->regs + VID_VSIZE2);
 
 	tmp = dsi_cfg.htotal -
 	      (dsi_cfg.hsa + DSI_BLANKING_FRAME_OVERHEAD +

-- 
2.43.0


