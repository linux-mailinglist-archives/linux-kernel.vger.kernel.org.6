Return-Path: <linux-kernel+bounces-230326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4591917B48
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 10:48:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11CF71C219A5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 08:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E99516848F;
	Wed, 26 Jun 2024 08:48:39 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D271D3B1A1
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 08:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719391719; cv=none; b=ETUaD7J/+iMJloDedXR2o3X3uPdW2sLf+Epbh1vO+rdh09HKbj1Z6wAV9dwqo2m01zAvONGHfeWYGKlhvLfn8WOdPO1W3G6LNuIWL8LShi02s/zpaGWB+bbIECDFt2oHTwjYFPglt/H2TxMXBPvGW5se4RPvPaN+ngrjpTjUpTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719391719; c=relaxed/simple;
	bh=51mXIHmEmsttyOopkteiJ918HLyzBaY8B/B/PTB4fcM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K5RyfgstiDxd/a0xzicld6goJwijzNnd7sEbVkpQVa5pOcGlwoQm6Xzxhui59G1EyHlgiYrMXote+qSMUc4hqEZe+KpudY+0TARzo3wuEyIX9hGiNvQ+b3TThrNtS0VQqMfn3Qv7VmsX3AByGLY4OdDKA74Zyfg7sx8fu23oujc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b6a.versanet.de ([83.135.91.106] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1sMOJf-0000RH-21; Wed, 26 Jun 2024 10:47:47 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	victor.liu@nxp.com,
	quentin.schulz@cherry.de,
	heiko@sntech.de,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: [PATCH RESEND] drm: bridge: dw-mipi-dsi: Allow sync-pulses to override the burst vid-mode
Date: Wed, 26 Jun 2024 10:47:22 +0200
Message-Id: <20240626084722.832763-1-heiko@sntech.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko.stuebner@cherry.de>

The state right now is that if the panel has the burst-mode flag it
will take precedence over the sync-pulses mode.

While sync-pulses are only relevant for the video-mode, the burst-mode
flag affects both the video-mode as well as the calculated lane_mbps.

Looking at drivers like the nwl-dsi [0] it only enables burst mode when
the panel's flags do not contain the sync_pulse flag.

So handle things similar for dw-dsi in that it selects the video-mode
with sync-pulses if that flag is set and only after that, checks for
the burst-mode. So panels selecting a combination of both burst and
sync-pulses get the sync-pulse mode.

The case this fixes can be found on the ltk050h3148w . It does need the
lane-rate to be calculated according to burst formulas [1], but without
sync-pulses we see the output shifted around 20 pixels to the right,
meaning that the last 20 pixels from each line appear at the start of
the next display line.

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/bridge/nwl-dsi.c#n301
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6c9dbee84cd005bed5f9d07b3a2797ae6414b435

Fixes: 93e82bb4de01 ("drm/bridge: synopsys: dw-mipi-dsi: Fix hcomponent lbcc for burst mode")
Signed-off-by: Heiko Stuebner <heiko.stuebner@cherry.de>
---
resend, because I messed up and somehow forgot to include _all_
mailing lists.

 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index 824fb3c65742e..28dd858a751bd 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -605,10 +605,10 @@ static void dw_mipi_dsi_video_mode_config(struct dw_mipi_dsi *dsi)
 	 */
 	val = ENABLE_LOW_POWER;
 
-	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
-		val |= VID_MODE_TYPE_BURST;
-	else if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
+	if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_SYNC_PULSE)
 		val |= VID_MODE_TYPE_NON_BURST_SYNC_PULSES;
+	else if (dsi->mode_flags & MIPI_DSI_MODE_VIDEO_BURST)
+		val |= VID_MODE_TYPE_BURST;
 	else
 		val |= VID_MODE_TYPE_NON_BURST_SYNC_EVENTS;
 
-- 
2.39.2


