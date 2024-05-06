Return-Path: <linux-kernel+bounces-169900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D06298BCF27
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 862581F249E8
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6D38061F;
	Mon,  6 May 2024 13:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHNFPtEn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4D978C68
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002528; cv=none; b=hOpuzKTUXwGUxhGto3ixCU6p4xKvq2VawLp5HnWXkhTTESFGF+Taj74aZCGp2sQ9mgwAnoaUxQAAdhbd/SvxbPmhUId+00wKYwkpHOtcSwtKZ4UtmIRPRZwlXXm3eF6e4cD0p9LXSOd0QQReG9+s5tnA0hF5Lw1s5cce00Qufsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002528; c=relaxed/simple;
	bh=VjxeNKYDFVNa7bVWlPBb3FkbK1nSMTj0nhXJcYaVwIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HSDEk4aveJpiKHTSRXVJ4XuQAXumdh08wQIyIqfsTnWOpahyui76UpPrmLUOLkv6gGGvplR4FIteUUiqLuLWqxscYgsL41/7GhplwvuimdCbma4V6CLMGtzCsM3ZeN1Y82NXIVrCLMrWwNs2ViOFmGkrHv++LbKOCC4Vb7/DQck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHNFPtEn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D7EC3277B;
	Mon,  6 May 2024 13:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715002527;
	bh=VjxeNKYDFVNa7bVWlPBb3FkbK1nSMTj0nhXJcYaVwIc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nHNFPtEnN3DVovJIBZ8EXSpxncOzcTVLRw3OInR2qD9SW4Pm67duBMCPv7Q3Q6QWH
	 juRnQIPbSSpg8gldlPDW4Odb4mDx/13lvV8Ysvk0EOk2HZl4JGJH9w5GKTfgmSXPWU
	 LvpWVIGdEYLk+OcBURS1Vk9s+E5wLWsNogrkMppg9wsqrARmRiRISdmUFWb3AyWRYj
	 2A5nZTil8CCd/WMzeVVgBMLd21jL64TBKx0F1K6mewxMxjSS0TPtuSocvJobJR+ifn
	 Qwr9NYW28ddIPfCNlIHS02bMPknXUFNqc+e8YaNLqdtHx9fOrZ8snWCEkl9Gd43rEG
	 PTABT1wdl9rvQ==
From: Michael Walle <mwalle@kernel.org>
Date: Mon, 06 May 2024 15:34:34 +0200
Subject: [PATCH 05/20] drm/bridge: tc358775: add crtc modes fixup
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-tc358775-fix-powerup-v1-5-545dcf00b8dd@kernel.org>
References: <20240506-tc358775-fix-powerup-v1-0-545dcf00b8dd@kernel.org>
In-Reply-To: <20240506-tc358775-fix-powerup-v1-0-545dcf00b8dd@kernel.org>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sam Ravnborg <sam@ravnborg.org>, Vinay Simha BN <simhavcs@gmail.com>, 
 Tony Lindgren <tony@atomide.com>
Cc: Daniel Semkowicz <dse@thaumatec.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.4

The bridge has some limitations regarding the horizontal display
timings. In particular, the pulse width has to be at least 8 pixels
and all horizontal timings have to be a multiple of two pixels, except
for the front porch which is ignored by the bridge anyway.

To accommodate that, add pixels to the pulse width and the back porch
until these requirements are satisfied. The added pixels are then
substracted from the front porch so we don't actually change the pixel
clock (or framerate).

Fixes: b26975593b17 ("display/drm/bridge: TC358775 DSI/LVDS driver")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/gpu/drm/bridge/tc358775.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index 980f71ea5a6a..720c0d63fd6a 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -502,6 +502,37 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
 	d2l_write(tc->i2c, LVCFG, val);
 }
 
+/*
+ * According to the datasheet, the horizontal back porch, front porch and sync
+ * length must be a multiple of 2 and the minimal horizontal pulse width is 8.
+ * To workaround this, we modify the back porch and the sync pulse width by
+ * adding enough pixels. These pixels will then be substracted from the front
+ * porch which is ignored by the bridge.  Hopefully, this marginal modified
+ * timing is tolerated by the panel. The alternative is either a black screen
+ * (if the sync pulse width is too short or a shifted picture if the lengths
+ * are not even).
+ */
+static bool tc_mode_fixup(struct drm_bridge *bridge,
+			  const struct drm_display_mode *mode,
+			  struct drm_display_mode *adj)
+{
+	u16 hsync_len, hback_porch;
+
+	hback_porch = adj->htotal - adj->hsync_end;
+	if (hback_porch & 1) {
+		adj->hsync_end -= 1;
+		adj->hsync_start -= 1;
+	}
+
+	hsync_len = adj->hsync_end - adj->hsync_start;
+	if (hsync_len < 8)
+		adj->hsync_start -= 8 - hsync_len;
+	else if (hsync_len & 1)
+		adj->hsync_start -= 1;
+
+	return adj->hsync_start >= adj->hdisplay;
+}
+
 static enum drm_mode_status
 tc_mode_valid(struct drm_bridge *bridge,
 	      const struct drm_display_info *info,
@@ -603,6 +634,7 @@ static const struct drm_bridge_funcs tc_bridge_funcs = {
 	.attach = tc_bridge_attach,
 	.pre_enable = tc_bridge_pre_enable,
 	.enable = tc_bridge_enable,
+	.mode_fixup = tc_mode_fixup,
 	.mode_valid = tc_mode_valid,
 	.post_disable = tc_bridge_post_disable,
 };

-- 
2.39.2


