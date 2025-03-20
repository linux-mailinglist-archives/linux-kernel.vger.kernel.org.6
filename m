Return-Path: <linux-kernel+bounces-569997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B388BA6AA8A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 806A97AF008
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D18227EB4;
	Thu, 20 Mar 2025 16:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="enlhF/Nq"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30D1227E95
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486454; cv=none; b=l0BCN/25zQykCHtLd/6epPcKYdVl63rQ7HHCxiBb6LZvKEMB5XuQMahGnGWvoZJt6esi3hWt72EwdwFhBwda5k6xJ2Z5rylfB0TDaysUG1Yt2OGKhzCW4XE8tUlzHMJaUwT3/ducLfuMvUkvrftGFSb65XjyTQxynAJDxSpuPv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486454; c=relaxed/simple;
	bh=vjRuuRXkQ3UFqYx/0yC4s/4b1wMI2nCnKESmkXL4LGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TVltSdqPrXqDl6tUMlHkNY8I6WqVyrh8KHW5x64gxPYlZ0QPGqHzJwd6B3XDWO4HwKAdP/zsANjzmeL4BCyloQdJNgajhpfnxp49YE89mQrQHSzlc/5PyRcxfvdC29wnGhgQE50+mwTDXF7tAVXf3+rjJy1DzaqlrmnaGt4nLfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=enlhF/Nq; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 462FD187A;
	Thu, 20 Mar 2025 16:58:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1742486336;
	bh=vjRuuRXkQ3UFqYx/0yC4s/4b1wMI2nCnKESmkXL4LGc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=enlhF/NqhGMzrcEUR9NQg0WbYcjq4T6iDpB+oY9lYDVosjtTolygnrY6GrRixGtPR
	 WXSmO1vtV90G/lwZGlNZeaFzVODPOdcnCPQcEk9EoUWQNoL6QIlxN5ba7sZ8zN+a3H
	 RlqyyNb4jC095p1S+0eUW0o4AM3PFFKjSSBLwR6Y=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 20 Mar 2025 18:00:03 +0200
Subject: [PATCH 08/18] drm/bridge: cdns-dsi: Clean up cdns_dsi_mode2cfg()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-cdns-dsi-impro-v1-8-725277c5f43b@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2823;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=vjRuuRXkQ3UFqYx/0yC4s/4b1wMI2nCnKESmkXL4LGc=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBn3DuZPGQq04sTkb7ZrhEAn+AT67MgErOWSxydE
 Z5r3wz3whWJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ9w7mQAKCRD6PaqMvJYe
 9Zv+D/42n5tRdaljlgcPGPlDh2WjWOdGbp4GIUPHbwbed4loym7HZBm8pqdW2HupQ8OXkJVtmHI
 e0eIVDnIcA8cmAtt9Ft4ktxLHoqOcGdDQr/9j9X8irg/iumvbwDHyMQFmewpqxRylu/3PG1+r8H
 z5GbnfvDvEdfdeLpCsnr4znikkoHdaLUbHZj06VZrgUwOjs5xsjYaIrgf9eb55PxA7QdfkkKxzg
 A565Hy1eaYYGxEtbieHRLAN2PuBty8gVy23t/sUJmFmMctOXU/9NCGMNeQByL7idQ154HUbetFP
 dP/a+6j05sm3UefsqcDbmKDu6gS0TBXq974S44UQuwDwkYqo5Jscz7Dl+AmhsYci1feba18Bk+5
 PiiSOV4KRqZLNoCVzzSenznm4q4lV7C/qh6BZfkOoYxCGq25xF24Bv2ksfvgtIk8g7q6zal7UGU
 3ISLjjLfCROvRxjylwtav5T262nh9J1BU90ddUeN8/jUokzI0H77qYXLC6V9sX9Ap/GWOfHBd4E
 K+J8vURA7bLSbE5ymeA1eLNnQcxF1LYkn7Xz2n+QODAJRLwvs/k7nr4sTHH88fOrMPIdvvTsOwL
 4bD39UflbjNoX4DyH3g7GJoAtxEqMmX2nyIZKovHDOKgbgKox/4TBYd7ABQcCvMUZ8PuElbJo6y
 ta7NzdkPP7S+dtw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Clean up the function a bit, mainly by doing the mode_valid_check dance
once in the beginning of the function, and grouping the calculations
wrt. sync/event mode a bit better.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 48 ++++++++++++--------------
 1 file changed, 22 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 9238acf69823..0aaa1d06b21c 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -481,42 +481,38 @@ static int cdns_dsi_mode2cfg(struct cdns_dsi *dsi,
 			     bool mode_valid_check)
 {
 	struct cdns_dsi_output *output = &dsi->output;
-	unsigned int tmp;
-	bool sync_pulse = false;
+	u32 dpi_hsa, dpi_hbp, dpi_hfp, dpi_hact;
+	bool sync_pulse;
 	int bpp;
 
+	if (mode_valid_check) {
+		dpi_hsa = mode->hsync_end - mode->hsync_start;
+		dpi_hbp = mode->htotal - mode->hsync_end;
+		dpi_hfp = mode->hsync_start - mode->hdisplay;
+		dpi_hact = mode->hdisplay;
+	} else {
+		dpi_hsa = mode->crtc_hsync_end - mode->crtc_hsync_start;
+		dpi_hbp = mode->crtc_htotal - mode->crtc_hsync_end;
+		dpi_hfp =  mode->crtc_hsync_start - mode->crtc_hdisplay;
+		dpi_hact = mode->crtc_hdisplay;
+	}
+
 	memset(dsi_cfg, 0, sizeof(*dsi_cfg));
 
-	if (output->dev->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
-		sync_pulse = true;
+	sync_pulse = output->dev->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE;
 
 	bpp = mipi_dsi_pixel_format_to_bpp(output->dev->format);
 
-	if (mode_valid_check)
-		tmp = mode->htotal -
-		      (sync_pulse ? mode->hsync_end : mode->hsync_start);
-	else
-		tmp = mode->crtc_htotal -
-		      (sync_pulse ?
-		       mode->crtc_hsync_end : mode->crtc_hsync_start);
-
-	dsi_cfg->hbp = dpi_to_dsi_timing(tmp, bpp, DSI_HBP_FRAME_OVERHEAD);
+	dsi_cfg->hbp = dpi_to_dsi_timing(dpi_hbp + (sync_pulse ? 0 : dpi_hsa),
+					 bpp, DSI_HBP_FRAME_OVERHEAD);
 
-	if (sync_pulse) {
-		if (mode_valid_check)
-			tmp = mode->hsync_end - mode->hsync_start;
-		else
-			tmp = mode->crtc_hsync_end - mode->crtc_hsync_start;
+	if (sync_pulse)
+		dsi_cfg->hsa =
+			dpi_to_dsi_timing(dpi_hsa, bpp, DSI_HSA_FRAME_OVERHEAD);
 
-		dsi_cfg->hsa = dpi_to_dsi_timing(tmp, bpp,
-						 DSI_HSA_FRAME_OVERHEAD);
-	}
+	dsi_cfg->hact = dpi_to_dsi_timing(dpi_hact, bpp, 0);
 
-	dsi_cfg->hact = dpi_to_dsi_timing(mode_valid_check ?
-					  mode->hdisplay : mode->crtc_hdisplay,
-					  bpp, 0);
-	dsi_cfg->hfp = dpi_to_dsi_timing(mode_to_dpi_hfp(mode, mode_valid_check),
-					 bpp, DSI_HFP_FRAME_OVERHEAD);
+	dsi_cfg->hfp = dpi_to_dsi_timing(dpi_hfp, bpp, DSI_HFP_FRAME_OVERHEAD);
 
 	return 0;
 }

-- 
2.43.0


