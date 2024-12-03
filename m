Return-Path: <linux-kernel+bounces-435915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 518669E7E8B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 07:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86C8D282D07
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 06:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23BA839F4;
	Sat,  7 Dec 2024 06:23:21 +0000 (UTC)
Received: from mail.steuer-voss.de (mail.steuer-voss.de [85.183.69.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C084A1C
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 06:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.183.69.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733552601; cv=none; b=kB3eD9uLHjiq0gmmNO4zGDCLj51aIdI0LY2dkC5Cu4bEEA/Dtz/CjG/+8NrMxtSG4VZlieRDh8HsrkML121YQdA7ltRYn4PAoM5as0zx4dlQeJSs3xxokDkVZSVacQZ4+yzSejVkO50WCs2ho1w8mUAxEf7OAejbMAIasQEOO70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733552601; c=relaxed/simple;
	bh=MFrOu9NSwS3eKPUIdmyAKIHaEYcC1MJCt8qtgvdlUuM=;
	h=From:Date:Subject:To:Cc:Message-Id; b=DT5f4J8XdgRDJ7Wter1JFabeXBGeeII2lLcTg1T3O9/MvD8zwb1JEF8CdKNB4xiOzRWg0dGabKLEorrqeirT8C+yzo6mPomMtQ6YOw5Ao6F9PYNHn3nQySMLQErLas1E/qO8Upx1GEoLqz5K8QWqhYLOcgQgWvao1n/W3jxhvQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vosn.de; spf=pass smtp.mailfrom=vosn.de; arc=none smtp.client-ip=85.183.69.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vosn.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vosn.de
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
	id 11BC72277; Sat,  7 Dec 2024 07:23:07 +0100 (CET)
From: Nikolaus Voss <nv@vosn.de>
Date: Tue, 3 Dec 2024 10:40:52 +0100
Subject: [PATCH v3] drm: bridge: fsl-ldb: fixup mode on freq mismatch
To: Alexander Stein <alexander.stein@ew.tq-group.com>, Liu Ying <victor.liu@nxp.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Fabio Estevam <festevam@denx.de>, Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, miquel.raynal@bootlin.com, nikolaus.voss@haag-streit.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Message-Id: <20241207062307.11BC72277@mail.steuer-voss.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

LDB clock has to be a fixed multiple of the pixel clock.
Although LDB and pixel clock have a common source, this
constraint cannot be satisfied for any pixel clock at a
fixed source clock.

Violating this constraint leads to flickering and distorted
lines on the attached display.

To overcome this, there are these approches:

1. Modify the base PLL clock statically by changing the
   device tree, implies calculating the PLL clock by
   hand, e.g. commit 4fbb73416b10 ("arm64: dts:
   imx8mp-phyboard-pollux: Set Video PLL1 frequency to 506.8 MHz")

2. Walk down the clock tree and modify the source clock.
   Proposed patch series by Miquel Raynal:
   [PATCH 0/5] clk: Fix simple video pipelines on i.MX8

3. This patch: check constraint violation in
   drm_bridge_funcs.atomic_check() and adapt the pixel
   clock in drm_display_mode.adjusted_mode accordingly.

Fixes: 463db5c2ed4a ("drm: bridge: ldb: Implement simple Freescale i.MX8MP LDB bridge")
Cc: <stable@vger.kernel.org>
Signed-off-by: Nikolaus Voss <nv@vosn.de>

---
v2:
- use .atomic_check() instead of .mode_fixup() (Dmitry Baryshkov)
- add Fixes tag (Liu Ying)
- use fsl_ldb_link_frequency() and drop const qualifier for
  struct fsl_ldb* (Liu Ying)

v3:
- fix kernel test robot warning: fsl-ldb.c:125:30:
  warning: omitting the parameter name in a function definition
  is a C23 extension [-Wc23-extensions]
- fix/rephrase commit text due to discussion with Marek Vasut,
  Liu Ying and Miquel Raynal
- only calculate and set pixel clock if ldb is not already
  configured to the matching frequency
---
 drivers/gpu/drm/bridge/fsl-ldb.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
index 0e4bac7dd04ff..b8e3629e4df4d 100644
--- a/drivers/gpu/drm/bridge/fsl-ldb.c
+++ b/drivers/gpu/drm/bridge/fsl-ldb.c
@@ -121,6 +121,37 @@ static int fsl_ldb_attach(struct drm_bridge *bridge,
 				 bridge, flags);
 }
 
+static int fsl_ldb_atomic_check(struct drm_bridge *bridge,
+				struct drm_bridge_state *bridge_state,
+				struct drm_crtc_state *crtc_state,
+				struct drm_connector_state *connector_state)
+{
+	struct fsl_ldb *fsl_ldb = to_fsl_ldb(bridge);
+	const struct drm_display_mode *mode = &crtc_state->mode;
+	unsigned long requested_freq =
+		fsl_ldb_link_frequency(fsl_ldb, mode->clock);
+	unsigned long freq = clk_round_rate(fsl_ldb->clk, requested_freq);
+	unsigned long configured_freq = clk_get_rate(fsl_ldb->clk);
+
+	if ((freq != configured_freq) && (freq != requested_freq)) {
+		/*
+		 * this will lead to flicker and incomplete lines on
+		 * the attached display, adjust the CRTC clock
+		 * accordingly.
+		 */
+		struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
+		int pclk = freq / fsl_ldb_link_frequency(fsl_ldb, 1);
+
+		dev_warn(fsl_ldb->dev, "Adjusted pixel clk to match LDB clk (%d kHz -> %d kHz)!\n",
+			 adjusted_mode->clock, pclk);
+
+		adjusted_mode->clock = pclk;
+		adjusted_mode->crtc_clock = pclk;
+	}
+
+	return 0;
+}
+
 static void fsl_ldb_atomic_enable(struct drm_bridge *bridge,
 				  struct drm_bridge_state *old_bridge_state)
 {
@@ -280,6 +311,7 @@ fsl_ldb_mode_valid(struct drm_bridge *bridge,
 
 static const struct drm_bridge_funcs funcs = {
 	.attach = fsl_ldb_attach,
+	.atomic_check = fsl_ldb_atomic_check,
 	.atomic_enable = fsl_ldb_atomic_enable,
 	.atomic_disable = fsl_ldb_atomic_disable,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
-- 
2.43.0


