Return-Path: <linux-kernel+bounces-569988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D9FA6AA85
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B162617340C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F75E1922C0;
	Thu, 20 Mar 2025 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="T5Vls0GF"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924BA2144C9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486444; cv=none; b=CnGjVDKXIVkELpBR06zpfzwVPc5/e6LWV/rKR0V848MtVjIdIYZJHqrIYQtIVtx7/DXC8VSfay4dJE8+s9QIeeh3acAvC8/LthkhjD6L8FpC5oLK+i1KliNGCIVy/5PUi2W0k2cLR9sqgmBThbqF94ZVgNc5ZjoLzoFBQ3prC1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486444; c=relaxed/simple;
	bh=lEa3BxN/6LhqthWXir58vTyZRT4d8BUmsi3iv05b4SI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CCsdj5vzlx0xdujRo1ZBHbCSCQcOphL/kODo6FHlIImlL3wD/Sns6uck2JOm+TNKuh1wIQBvVweVVuivUIEliZ/JD9vvKJ6OuKe5B+fQ+Ct9vuSE2gICbkFOqtvYCOSghMz8FSfmbPRCkMljQcTi8DdwtpnzVEiOXdB/ba1gVr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=T5Vls0GF; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5633BA98;
	Thu, 20 Mar 2025 16:58:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1742486329;
	bh=lEa3BxN/6LhqthWXir58vTyZRT4d8BUmsi3iv05b4SI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=T5Vls0GFxnPD5hn1unW34oSBxrMO4OhNp9j7+A6Cd/7trv98Dlxt18y3spIQ/h0i7
	 OrNwM13+SUvs/qwg4Bu91rsBZ6ltlm6QJ3rLP7Q8en7StCMqAq22FDMzAExbVc4o/6
	 RfqhiV1GJzDDtv4TQHxhYOohXdZeXjMira+mO67c=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 20 Mar 2025 17:59:57 +0200
Subject: [PATCH 02/18] drm/tidss: Use the crtc_* timings when programming
 the HW
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-cdns-dsi-impro-v1-2-725277c5f43b@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2447;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=lEa3BxN/6LhqthWXir58vTyZRT4d8BUmsi3iv05b4SI=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBn3DuWAhb6U3BLt5lLhsPChcq8E4oZSETUJXSx5
 z12mq0p56KJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ9w7lgAKCRD6PaqMvJYe
 9Th3EACjcrw6JZ9VPnH9olNkIpUQhmsh0DkbdGgOZ2y8ivDMJb390ebjUjcycXeJzVAwa11yzjv
 ARnz9GkQYtX1PSm6EMaxo6GvwryU4NcgJYUbeQvL8ZIRcYhggMFmIFOih5Xwor3BjRPg5tn2oMG
 67zYVSK9YdQ3JnTmEWXyzSo164E8/nhJRoWz4/28U8ywqbeAWrBImTxgsPcP4D95I74h+bmdMe3
 qov6INwon7Bgg85T+1DEyXjcjZWjGenn7gXSJIqgjr6x8KX2KIC3ObutCIMuKXq4KuZdBvB4KFn
 tBlgqVWeJYXXaxTfRLgKvYVF5QE8HcOA3QJO1IdjNVAkJ7kdpWOxt0G6w/JdI5XFP5gLusf4eA4
 fP6bDH7iGRh4FLnzzYBC2CN6hVo1I2SQeygB8ZXJiTCa1ULxtJMwUpan/MlqfnmBaSZeRFqsjtU
 1X1C+hZE/HKKon9Mx/GXPb64iHJfvAc1Nc+bX/9+baLDDjdAtOGoyXBcDRwBseUV8e+v1+0cmjw
 E6Et+9k44cpM9Dj9G2ppuF3lNjMtyYhCuceqzmu2DUrCF51U1ZPMdhz3YX6LG0bUlsiHwC6UfFc
 8uIdeiCbMnT6+m/B8SdTag2o0UoMxWtT7+7MSTLAH0DAZv/0L9/plFbDBbXQ+om+MdZNwy4lD+f
 DhEeFcQOT4L1Jkw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Use the crtc_* fields from drm_display_mode, instead of the "logical"
fields. This shouldn't change anything in practice, but afaiu the crtc_*
fields are the correct ones to use here.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_crtc.c  |  2 +-
 drivers/gpu/drm/tidss/tidss_dispc.c | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_crtc.c b/drivers/gpu/drm/tidss/tidss_crtc.c
index 94f8e3178df5..1604eca265ef 100644
--- a/drivers/gpu/drm/tidss/tidss_crtc.c
+++ b/drivers/gpu/drm/tidss/tidss_crtc.c
@@ -225,7 +225,7 @@ static void tidss_crtc_atomic_enable(struct drm_crtc *crtc,
 	tidss_runtime_get(tidss);
 
 	r = dispc_vp_set_clk_rate(tidss->dispc, tcrtc->hw_videoport,
-				  mode->clock * 1000);
+				  mode->crtc_clock * 1000);
 	if (r != 0)
 		return;
 
diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index cacb5f3d8085..a5107f2732b1 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -1084,13 +1084,13 @@ void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport,
 
 	dispc_set_num_datalines(dispc, hw_videoport, fmt->data_width);
 
-	hfp = mode->hsync_start - mode->hdisplay;
-	hsw = mode->hsync_end - mode->hsync_start;
-	hbp = mode->htotal - mode->hsync_end;
+	hfp = mode->crtc_hsync_start - mode->crtc_hdisplay;
+	hsw = mode->crtc_hsync_end - mode->crtc_hsync_start;
+	hbp = mode->crtc_htotal - mode->crtc_hsync_end;
 
-	vfp = mode->vsync_start - mode->vdisplay;
-	vsw = mode->vsync_end - mode->vsync_start;
-	vbp = mode->vtotal - mode->vsync_end;
+	vfp = mode->crtc_vsync_start - mode->crtc_vdisplay;
+	vsw = mode->crtc_vsync_end - mode->crtc_vsync_start;
+	vbp = mode->crtc_vtotal - mode->crtc_vsync_end;
 
 	dispc_vp_write(dispc, hw_videoport, DISPC_VP_TIMING_H,
 		       FLD_VAL(hsw - 1, 7, 0) |
@@ -1132,8 +1132,8 @@ void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport,
 		       FLD_VAL(ivs, 12, 12));
 
 	dispc_vp_write(dispc, hw_videoport, DISPC_VP_SIZE_SCREEN,
-		       FLD_VAL(mode->hdisplay - 1, 11, 0) |
-		       FLD_VAL(mode->vdisplay - 1, 27, 16));
+		       FLD_VAL(mode->crtc_hdisplay - 1, 11, 0) |
+		       FLD_VAL(mode->crtc_vdisplay - 1, 27, 16));
 
 	VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 1, 0, 0);
 }

-- 
2.43.0


