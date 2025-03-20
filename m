Return-Path: <linux-kernel+bounces-570002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B80A7A6AAB1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F270D189DB19
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D53322A7F4;
	Thu, 20 Mar 2025 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="R75OKkUe"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D55822A4E5
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486463; cv=none; b=sLOmFQpFv+bMzAZwcnCBo7KyClmXcSoSbD5N5ZBWd4xpJnC0PxZ38HhjopmNfK7fkXccoGCpcIpg54NbizFOJQL4d9Ep3xJRMGm4zlDKJIrR5jdX9h8r/+L4kwI5T+HJ4MAK9X4AB5vBZMquYPG7kx/1ECM5BKI+y8Ao1E5WMCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486463; c=relaxed/simple;
	bh=IIDKgphBR8Z+MRb90fam19Jh4edh+nhVkDzVKuQW/rY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oWSWqo2TObCCa32/qQgJsy8wNOhWxPv8l0fLASzyQsq++QqVZ9AO1gVvamrCOD0eW2Wvth8V0UtoZZU69Xy50S5ETT+N/s17sIdzIfC1Ee6/UcSO6ZMqd9UUa48XzTj7KxJ5t3F5pt/imCG+cYcMEDx8gDsp85JYWb0q2jwBOWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=R75OKkUe; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3F5B5743;
	Thu, 20 Mar 2025 16:59:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1742486343;
	bh=IIDKgphBR8Z+MRb90fam19Jh4edh+nhVkDzVKuQW/rY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=R75OKkUe3S77fCRa7Hyf99JE7idmz1QLo7ZW9JJo6ugI5ZVDcxjm/dNxRYTOVq0aT
	 FKrAmClKfJ6473OXrhsBEe4MN8NcxcZVtc1LaZl//2CS57x+UT0hSDjsjw+/st1XmE
	 ab0npDQ0fU1yIYJELJMqY2oRyPobV0w45mumYPK8=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 20 Mar 2025 18:00:09 +0200
Subject: [PATCH 14/18] drm/bridge: cdns-dsi: Use videomode internally
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-cdns-dsi-impro-v1-14-725277c5f43b@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4546;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=IIDKgphBR8Z+MRb90fam19Jh4edh+nhVkDzVKuQW/rY=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBn3DubPPPYYZaMHel9AvP+DlscBUhPpOifEIBnD
 Vxi7kUq+Z6JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ9w7mwAKCRD6PaqMvJYe
 9ZIqEACYYzWG+QcesEgv9AUYi0HpUHRDv2CAPUovtA6UnSoKk09kmF5tZW5AR+P7gjK+HbUz6Hk
 1ZJFaNR1brKDLWsjJgMgeeireYnr4IF9ZDJ7TT1hkQUyBaiQDGeKiieW1AVOWqi3h3PWagg+pok
 ovh2XgMO6QW4XfmpkNecU8O/zgbXWwE3BwIvtKdyYu6K/1XEdiE3YV8PabnZf+k4Ko5iBE87qel
 FpHzE5GAtSvh21+hItb4obn3RjcbSTfJ5ArQLUBz9mn4OkoqPeE4v1uhFCwSY5Z23Q86Lnp+DRx
 4FTt29ozUJQPPxqfl72bIjc3KV8zoOfleCusA/cf/1TAXGavwu4EgNUygzsoA2cPOWDVBtDRiTg
 5um7dlRLo72DIQVGDsnr1CVyvE4slw7E+fotSBbi9S2xSlyn30t32UGKpUyyJSqMQKlTFecqqF5
 QNK1rL2bPLJDdaQdebm5+pi1CpFFgwpkeHS1F0Ybn+EV/u847qrAgZLWwRxxyenwqL6MGxCvOhU
 E5VyCJD7AEN3YM/r+0QsOXKhr/8XA25tOquELWZ9AoT1d07S5E1TnXHySkIdJKSMUKB1/Du+SBB
 16K+LolUVA6HICshUL+w0Y3z39ELAHe72hm49FhRX9SwZE4DJcaZks4brG6ZiqhzeE2WTiax53E
 IeRZ/vYg7EWUA6A==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

The drm_display_mode is a bit difficult one to use (we need hfp, hbp,
... instead of hsync_start, hsync_end, ...) and understand (when to use
crtc_* fields).

To simplify the code, use struct videomode internally which cleans up
the code. If in the future we want to use crtc_* fields in some code
patchs, that can be easily achieved by creating a videomode from the
crtc_* fields, and no change to the functions that do the work is
needed.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 31 +++++++++++++++-----------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 220213f5cb09..1a30e2f7d402 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -9,6 +9,7 @@
 #include <drm/drm_drv.h>
 #include <drm/drm_probe_helper.h>
 #include <video/mipi_display.h>
+#include <video/videomode.h>
 
 #include <linux/clk.h>
 #include <linux/interrupt.h>
@@ -468,7 +469,7 @@ static unsigned int dpi_to_dsi_timing(unsigned int dpi_timing,
 }
 
 static int cdns_dsi_mode2cfg(struct cdns_dsi *dsi,
-			     const struct drm_display_mode *mode,
+			     const struct videomode *vm,
 			     struct cdns_dsi_cfg *dsi_cfg)
 {
 	struct cdns_dsi_output *output = &dsi->output;
@@ -476,10 +477,10 @@ static int cdns_dsi_mode2cfg(struct cdns_dsi *dsi,
 	bool sync_pulse;
 	int bpp;
 
-	dpi_hsa = mode->hsync_end - mode->hsync_start;
-	dpi_hbp = mode->htotal - mode->hsync_end;
-	dpi_hfp =  mode->hsync_start - mode->hdisplay;
-	dpi_hact = mode->hdisplay;
+	dpi_hsa = vm->hsync_len;
+	dpi_hbp = vm->hback_porch;
+	dpi_hfp = vm->hfront_porch;
+	dpi_hact = vm->hactive;
 
 	memset(dsi_cfg, 0, sizeof(*dsi_cfg));
 
@@ -510,7 +511,7 @@ static int cdns_dsi_mode2cfg(struct cdns_dsi *dsi,
 static int cdns_dsi_adjust_phy_config(struct cdns_dsi *dsi,
 			      struct cdns_dsi_cfg *dsi_cfg,
 			      struct phy_configure_opts_mipi_dphy *phy_cfg,
-			      const struct drm_display_mode *mode)
+			      const struct videomode *vm)
 {
 	struct cdns_dsi_output *output = &dsi->output;
 	unsigned long long dlane_bps;
@@ -540,11 +541,12 @@ static int cdns_dsi_adjust_phy_config(struct cdns_dsi *dsi,
 	if (dsi_htotal % lanes)
 		adj_dsi_htotal += lanes - (dsi_htotal % lanes);
 
-	dpi_hz = mode->clock * 1000;
+	dpi_hz = vm->pixelclock;
 	dlane_bps = (unsigned long long)dpi_hz * adj_dsi_htotal;
 
 	/* data rate in bytes/sec is not an integer, refuse the mode. */
-	dpi_htotal = mode->htotal;
+	dpi_htotal = vm->hactive + vm->hfront_porch + vm->hback_porch +
+		     vm->hsync_len;
 	if (do_div(dlane_bps, lanes * dpi_htotal))
 		return -EINVAL;
 
@@ -559,7 +561,7 @@ static int cdns_dsi_adjust_phy_config(struct cdns_dsi *dsi,
 }
 
 static int cdns_dsi_check_conf(struct cdns_dsi *dsi,
-			       const struct drm_display_mode *mode,
+			       const struct videomode *vm,
 			       struct cdns_dsi_cfg *dsi_cfg)
 {
 	struct cdns_dsi_output *output = &dsi->output;
@@ -568,17 +570,17 @@ static int cdns_dsi_check_conf(struct cdns_dsi *dsi,
 	unsigned long req_hs_clk_rate;
 	int ret;
 
-	ret = cdns_dsi_mode2cfg(dsi, mode, dsi_cfg);
+	ret = cdns_dsi_mode2cfg(dsi, vm, dsi_cfg);
 	if (ret)
 		return ret;
 
-	ret = phy_mipi_dphy_get_default_config(mode->clock * 1000,
+	ret = phy_mipi_dphy_get_default_config(vm->pixelclock,
 					       mipi_dsi_pixel_format_to_bpp(output->dev->format),
 					       nlanes, phy_cfg);
 	if (ret)
 		return ret;
 
-	ret = cdns_dsi_adjust_phy_config(dsi, dsi_cfg, phy_cfg, mode);
+	ret = cdns_dsi_adjust_phy_config(dsi, dsi_cfg, phy_cfg, vm);
 	if (ret)
 		return ret;
 
@@ -975,12 +977,15 @@ static int cdns_dsi_bridge_atomic_check(struct drm_bridge *bridge,
 	const struct drm_display_mode *mode = &crtc_state->mode;
 	struct cdns_dsi_cfg *dsi_cfg = &dsi_state->dsi_cfg;
 	struct drm_display_mode *adjusted_crtc_mode = &crtc_state->adjusted_mode;
+	struct videomode vm;
 
 	/* cdns-dsi requires negative syncs */
 	adjusted_crtc_mode->flags &= ~(DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
 	adjusted_crtc_mode->flags |= DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC;
 
-	return cdns_dsi_check_conf(dsi, mode, dsi_cfg);
+	drm_display_mode_to_videomode(mode, &vm);
+
+	return cdns_dsi_check_conf(dsi, &vm, dsi_cfg);
 }
 
 static struct drm_bridge_state *

-- 
2.43.0


