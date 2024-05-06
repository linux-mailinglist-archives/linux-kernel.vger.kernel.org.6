Return-Path: <linux-kernel+bounces-169896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4988BCF20
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 15:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8711C22804
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 13:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9699D7F7D1;
	Mon,  6 May 2024 13:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVbJ0rfY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ECA7E56B
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715002508; cv=none; b=daLMWCCLloaWHTVIw9RsegGhn4qdFF6Dk75ZzPQBBho/n0/FxZ05nwi87OsqTg9JrF0y8kBs8oUVhDrsczwezN9UMmOwb8VpCLQWeaT11lNTczywt9DT+cbO5p7rPvZQ7zpVYJvOHflki6+fsXraZvAcgU7i3yPWSqD1J8kwtUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715002508; c=relaxed/simple;
	bh=2gxAViJr9NJSI0wyF8/7Q/WmZNqJmwnGrC0yrjFayzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QRTrqI+mnpBU1n7QuyLCgF6DTRB88aV0xqTJxT4LgCGRkm1RreDcPoPETZoplriOm+8uq9lMWMp9qRwszxOC3ZPKyJIO4k1qTS9KiSnnKdpXk5Kg5g85UZqd5B90i4mXUYJFxEEBQaMVIbh+guwUOek5a1U9+4eIRGCapHkwky0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVbJ0rfY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B95C3277B;
	Mon,  6 May 2024 13:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715002508;
	bh=2gxAViJr9NJSI0wyF8/7Q/WmZNqJmwnGrC0yrjFayzk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GVbJ0rfY3xs6Ux0UxSoIfjcF29PmoHxtN3SrZJzOiF4gjY6sEQ5ignodSdmCheGi1
	 CXDdWHGpV7NtdHJeEuDVvMHAFb8xiVlY30Y7lruDFe37+n9bE4e+JYRLJ9xz88nIsR
	 DfumMVuId5PtRdGCcKxv+PGuiZ5jtcqEPjiVb+GeyoIDjefa43RHYbpMHWOHi8kb6s
	 jDu75XS7G6pLuFk+SwyxyqJCxneAM/tiialtVN+aX1fFhLp6Wm4qL+A33iJjFMeyGA
	 VH685LOmQKsjuF3229lcd00iPmIurLhYWyMnC54vhk5wlRCgM8SXUijj5zb1BXX7sg
	 5DE/nd2ifTc/Q==
From: Michael Walle <mwalle@kernel.org>
Date: Mon, 06 May 2024 15:34:30 +0200
Subject: [PATCH 01/20] drm/bridge: add dsi_lp11_notify mechanism
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-tc358775-fix-powerup-v1-1-545dcf00b8dd@kernel.org>
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

Some bridges have very strict power-up reqirements. In this case, the
Toshiba TC358775. The reset has to be deasserted while *both* the DSI
clock and DSI data lanes are in LP-11 mode. After the reset is relased,
the bridge needs the DSI clock to actually be able to process I2C
access. This access will configure the DSI side of the bridge during
which the DSI data lanes have to be in LP-11 mode. After everything is
configured the video stream can finally be enabled.

This means:
 (1) The bridge has to be configured completely in .pre_enable() op
     (with the clock turned on and data lanes in LP-11 mode, thus
     .pre_enable_prev_first has to be set).
 (2) The bridge will enable its output in the .enable() op
 (3) There must be some mechanism before (1) where the bridge can
     release its reset while the clock lane is still in LP-11 mode.

Unfortunately, (3) is crucial for a correct operation of the bridge.
To satisfy this requriment, introduce a new callback .dsi_lp11_notify()
which will be called by the DSI host driver.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/gpu/drm/drm_bridge.c | 16 ++++++++++++++++
 include/drm/drm_bridge.h     | 12 ++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 28abe9aa99ca..98cd6558aecb 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -1339,6 +1339,22 @@ void drm_bridge_hpd_notify(struct drm_bridge *bridge,
 }
 EXPORT_SYMBOL_GPL(drm_bridge_hpd_notify);
 
+/**
+ * drm_bridge_dsi_lp11_notify - notify clock/data lanes LP-11 mode
+ * @bridge: bridge control structure
+ *
+ * DSI host drivers shall call this function while the clock and data lanes
+ * are still in LP-11 mode.
+ *
+ * This function shall be called in a context that can sleep.
+ */
+void drm_bridge_dsi_lp11_notify(struct drm_bridge *bridge)
+{
+	if (bridge->funcs->dsi_lp11_notify)
+		bridge->funcs->dsi_lp11_notify(bridge);
+}
+EXPORT_SYMBOL_GPL(drm_bridge_dsi_lp11_notify);
+
 #ifdef CONFIG_OF
 /**
  * of_drm_find_bridge - find the bridge corresponding to the device node in
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 4baca0d9107b..4ef61274e0a8 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -630,6 +630,17 @@ struct drm_bridge_funcs {
 	 */
 	void (*hpd_disable)(struct drm_bridge *bridge);
 
+	/**
+	 * dsi_lp11_notify:
+	 *
+	 * Will be called by the DSI host driver while both the DSI clock
+	 * lane as well as the DSI data lanes are in LP-11 mode. Some bridges
+	 * need this state while releasing the reset, for example.
+	 * Not all DSI host drivers will support this. Therefore, the DSI
+	 * bridge driver must not rely on this op to be called.
+	 */
+	void (*dsi_lp11_notify)(struct drm_bridge *bridge);
+
 	/**
 	 * @debugfs_init:
 	 *
@@ -898,6 +909,7 @@ void drm_bridge_hpd_enable(struct drm_bridge *bridge,
 void drm_bridge_hpd_disable(struct drm_bridge *bridge);
 void drm_bridge_hpd_notify(struct drm_bridge *bridge,
 			   enum drm_connector_status status);
+void drm_bridge_dsi_lp11_notify(struct drm_bridge *bridge);
 
 #ifdef CONFIG_DRM_PANEL_BRIDGE
 bool drm_bridge_is_panel(const struct drm_bridge *bridge);

-- 
2.39.2


