Return-Path: <linux-kernel+bounces-430040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE079E2BBA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 20:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80C02847D9
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B851FECCC;
	Tue,  3 Dec 2024 19:11:28 +0000 (UTC)
Received: from mail.steuer-voss.de (mail.steuer-voss.de [85.183.69.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F741F9407
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 19:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.183.69.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733253087; cv=none; b=UjTZmGKUCzmd6IWyUy7aNnee4MBjajzXU8HRyGFtlPEpRrMwzd1SUyTtQouUMvk6WfiBHRRDoYORgtPbbVKlhBFCOGmNgoJnQeaJbIjePflkyOPy3Fk33T+SZc0qZOe9uayFwvR+tRBVjhuztLgVRhaZhsJuoslvm5zyeOdqBkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733253087; c=relaxed/simple;
	bh=Jnjj7vU+uMzKr6QUhfR2hjgDnzgmd93qAiccXLvATws=;
	h=From:Date:Subject:To:Cc:Message-Id; b=JLE0YwwRB9ziveboBC1XNy8MuKrtAV9y/IyAUJpQUx+h+1js++KBkOy8kRVC/WgQho+H4j+8i22TKqHgEgaQC2wRIMg8sH5d8hk6f9iU3IdX0OoAg8ha6g/8NkG5chy6kr2zc4tM5/pV0qgMTqEw/sosaf+SCpgvu/4ndG7063Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vosn.de; spf=pass smtp.mailfrom=vosn.de; arc=none smtp.client-ip=85.183.69.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vosn.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vosn.de
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
	id 47B56F7; Tue,  3 Dec 2024 20:11:11 +0100 (CET)
From: Nikolaus Voss <nv@vosn.de>
Date: Tue, 3 Dec 2024 20:09:52 +0100
Subject: [PATCH v2] drm: bridge: fsl-ldb: fixup mode on freq mismatch
To: Alexander Stein <alexander.stein@ew.tq-group.com>, Liu Ying <victor.liu@nxp.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Fabio Estevam <festevam@denx.de>, Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, miquel.raynal@bootlin.com, nikolaus.voss@haag-streit.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-Id: <20241203191111.47B56F7@mail.steuer-voss.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

LDB clock has to be a fixed multiple of the pixel clock.
As LDB and pixel clock are derived from different clock sources
(at least on imx8mp), this constraint cannot be satisfied for
any pixel clock, which leads to flickering and incomplete
lines on the attached display.

To overcome this, check this condition in .atomic_check() and
adapt the pixel clock accordingly.

Cc: <stable@vger.kernel.org>
Fixes: 463db5c2ed4a ("drm: bridge: ldb: Implement simple Freescale i.MX8MP LDB bridge")

Signed-off-by: Nikolaus Voss <nv@vosn.de>

---
v2:
- use .atomic_check() instead of .mode_fixup() (Dmitry Baryshkov)
- add Fixes tag (Liu Ying)
- use fsl_ldb_link_frequency() and drop const qualifier for
  struct fsl_ldb* (Liu Ying)

 drivers/gpu/drm/bridge/fsl-ldb.c | 33 ++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
index 0e4bac7dd04ff..5b09529564609 100644
--- a/drivers/gpu/drm/bridge/fsl-ldb.c
+++ b/drivers/gpu/drm/bridge/fsl-ldb.c
@@ -121,6 +121,38 @@ static int fsl_ldb_attach(struct drm_bridge *bridge,
 				 bridge, flags);
 }
 
+static int fsl_ldb_atomic_check(struct drm_bridge *bridge,
+				struct drm_bridge_state *,
+				struct drm_crtc_state *crtc_state,
+				struct drm_connector_state *)
+{
+	struct fsl_ldb *fsl_ldb = to_fsl_ldb(bridge);
+	const struct drm_display_mode *mode = &crtc_state->mode;
+	unsigned long requested_link_freq =
+		fsl_ldb_link_frequency(fsl_ldb, mode->clock);
+	unsigned long freq = clk_round_rate(fsl_ldb->clk, requested_link_freq);
+
+	if (freq != requested_link_freq) {
+		/*
+		 * this will lead to flicker and incomplete lines on
+		 * the attached display, adjust the CRTC clock
+		 * accordingly.
+		 */
+		struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
+		int pclk = freq / fsl_ldb_link_frequency(fsl_ldb, 1);
+
+		if (adjusted_mode->clock != pclk) {
+			dev_warn(fsl_ldb->dev, "Adjusted pixel clk to match LDB clk (%d kHz -> %d kHz)!\n",
+				 adjusted_mode->clock, pclk);
+
+			adjusted_mode->clock = pclk;
+			adjusted_mode->crtc_clock = pclk;
+		}
+	}
+
+	return 0;
+}
+
 static void fsl_ldb_atomic_enable(struct drm_bridge *bridge,
 				  struct drm_bridge_state *old_bridge_state)
 {
@@ -280,6 +312,7 @@ fsl_ldb_mode_valid(struct drm_bridge *bridge,
 
 static const struct drm_bridge_funcs funcs = {
 	.attach = fsl_ldb_attach,
+	.atomic_check = fsl_ldb_atomic_check,
 	.atomic_enable = fsl_ldb_atomic_enable,
 	.atomic_disable = fsl_ldb_atomic_disable,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
-- 
2.43.0


