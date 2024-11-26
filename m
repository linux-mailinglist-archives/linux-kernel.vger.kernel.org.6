Return-Path: <linux-kernel+bounces-422662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DC79D9C98
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 18:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF5EE1679F9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 17:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1F21DAC92;
	Tue, 26 Nov 2024 17:32:25 +0000 (UTC)
Received: from mail.steuer-voss.de (mail.steuer-voss.de [85.183.69.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ADE1CEE9B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 17:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.183.69.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732642345; cv=none; b=c/zj+r2gu6JCpZGPBY1uvWAdfEIC5UNtPYxkG2S8GzUrZ5Wg65NtU3esbRdOsheFpZWGn4OrEupNZBzpwjvkSrCQ0BiKAY4wQndZ7SMdUrtLFJ4AOrVPzIN4S9MQC/hFtZYWxUry8u6CMkVW8EGGCsleCyNkU/4FUymNYctDq54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732642345; c=relaxed/simple;
	bh=aWGUioyBdDVmDz4hVyW9bnKkVDvJDYVi2ZmD6ZbuumM=;
	h=From:Date:Subject:To:Cc:Message-Id; b=jG+yV+l39EgqbNs4ZZmPO4in9TpIrJdI7uc9nc5S7+sS1DPVojntGyboOTyt4ChUs5Cejcj8OQUZITQo7N7qvMjK74JqBRzqZ2RopTG4R3pmXAbM7i9T74Vn8xMmQKQyrXxsYswWkbetnAtqpQL1BdOKFdwdBvoEG2RUm0md34s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vosn.de; spf=pass smtp.mailfrom=vosn.de; arc=none smtp.client-ip=85.183.69.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vosn.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vosn.de
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
	id AD8B51622C; Tue, 26 Nov 2024 18:26:10 +0100 (CET)
From: Nikolaus Voss <nv@vosn.de>
Date: Tue, 26 Nov 2024 16:45:54 +0100
Subject: [PATCH] drm: bridge: fsl-ldb: fixup mode on freq mismatch
To: Alexander Stein <alexander.stein@ew.tq-group.com>, Liu Ying <victor.liu@nxp.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, Fabio Estevam <festevam@denx.de>, Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, nikolaus.voss@haag-streit.com
Message-Id: <20241126172610.AD8B51622C@mail.steuer-voss.de>
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

To overcome this, check this condition in mode_fixup() and
adapt the pixel clock accordingly.

Cc: <stable@vger.kernel.org>

Signed-off-by: Nikolaus Voss <nv@vosn.de>
---
 drivers/gpu/drm/bridge/fsl-ldb.c | 40 ++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fsl-ldb.c
index 0e4bac7dd04ff..e341341b8c600 100644
--- a/drivers/gpu/drm/bridge/fsl-ldb.c
+++ b/drivers/gpu/drm/bridge/fsl-ldb.c
@@ -104,12 +104,14 @@ static inline struct fsl_ldb *to_fsl_ldb(struct drm_bridge *bridge)
 	return container_of(bridge, struct fsl_ldb, bridge);
 }
 
+static unsigned int fsl_ldb_link_freq_factor(const struct fsl_ldb *fsl_ldb)
+{
+	return fsl_ldb_is_dual(fsl_ldb) ? 3500 : 7000;
+}
+
 static unsigned long fsl_ldb_link_frequency(struct fsl_ldb *fsl_ldb, int clock)
 {
-	if (fsl_ldb_is_dual(fsl_ldb))
-		return clock * 3500;
-	else
-		return clock * 7000;
+	return clock * fsl_ldb_link_freq_factor(fsl_ldb);
 }
 
 static int fsl_ldb_attach(struct drm_bridge *bridge,
@@ -121,6 +123,35 @@ static int fsl_ldb_attach(struct drm_bridge *bridge,
 				 bridge, flags);
 }
 
+static bool fsl_ldb_mode_fixup(struct drm_bridge *bridge,
+				const struct drm_display_mode *mode,
+				struct drm_display_mode *adjusted_mode)
+{
+	const struct fsl_ldb *fsl_ldb = to_fsl_ldb(bridge);
+	unsigned long requested_link_freq =
+		mode->clock * fsl_ldb_link_freq_factor(fsl_ldb);
+	unsigned long freq = clk_round_rate(fsl_ldb->clk, requested_link_freq);
+
+	if (freq != requested_link_freq) {
+		/*
+		 * this will lead to flicker and incomplete lines on
+		 * the attached display, adjust the CRTC clock
+		 * accordingly.
+		 */
+		int pclk = freq / fsl_ldb_link_freq_factor(fsl_ldb);
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
+	return true;
+}
+
 static void fsl_ldb_atomic_enable(struct drm_bridge *bridge,
 				  struct drm_bridge_state *old_bridge_state)
 {
@@ -280,6 +311,7 @@ fsl_ldb_mode_valid(struct drm_bridge *bridge,
 
 static const struct drm_bridge_funcs funcs = {
 	.attach = fsl_ldb_attach,
+	.mode_fixup = fsl_ldb_mode_fixup,
 	.atomic_enable = fsl_ldb_atomic_enable,
 	.atomic_disable = fsl_ldb_atomic_disable,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
-- 
2.43.0


