Return-Path: <linux-kernel+bounces-188401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 284AE8CE18A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 09:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7CF1C20D2D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 07:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83E412882C;
	Fri, 24 May 2024 07:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QYoe6SFu"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CFC3307B
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 07:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716536017; cv=none; b=jA4Ssa7PYqYfe34b5NHKLZrikiY2IjPf6zYCJ0teiFUWB0PlKS9Ll7yqZdRnBxCGJL2lIOL6RUXFsxO3Y19J0sV7tD+INArNhy0J0TaYpE15XX/geb2k6C8fRwhn5csTVNC/PRucqgxgFyBI+3zZYRX4k0as30ENRaYGyWmQf/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716536017; c=relaxed/simple;
	bh=oBDD27/wc3Qh6izyVp1QkEtwFWUBXhZoKUZXxhsVEZI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kHUts7Y4PYlitAk40//K01FMApcBCHrAKIjY/ZCCX/3ECAaME3VmYIqRrGKkkEJpPZQ8kfDp8DpJTeWezkKINPC0XD/aPnU8kGMlhDD6WvgZwLpvARH80OpFBdWXjCC37E3vLukY3eil/vfCDzchyuIAPRYH82q3pdZ8JdoI5Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=QYoe6SFu; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44O7X87S023859;
	Fri, 24 May 2024 02:33:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716535988;
	bh=7/O/ELBpsYqwHGgCUNWJaaXNiO3H0Vnv3in42Ax11vQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=QYoe6SFub1yaZPe5F3FIrm/TtcT4ZPdEOb6wGUKH2TPMRLoQbgDgIv+u/ZO4XewhP
	 XD4J9OZO8ag/adYi5scW/yw6+9QANeLZPA62xnqkPH3IGBntAcG8Z2B9jRTihOSjbP
	 In9J7CkyE/bODUG2l4Z2Q1CMAcn8cki5LCntDFpE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44O7X8K2097755
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 May 2024 02:33:08 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 24
 May 2024 02:33:08 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 24 May 2024 02:33:08 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.102] (may be forged))
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44O7X7Is121697;
	Fri, 24 May 2024 02:33:07 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <linux-kernel@vger.kernel.org>, <andrzej.hajda@intel.com>,
        <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <mripard@kernel.org>,
        <dri-devel@lists.freedesktop.org>, <j-choudhary@ti.com>
CC: <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>,
        <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
        <airlied@gmail.com>, <daniel@ffwll.ch>, <a-bhatia1@ti.com>
Subject: [PATCH v2 1/2] drm/bridge: sii902x: Fix mode_valid hook
Date: Fri, 24 May 2024 13:03:04 +0530
Message-ID: <20240524073305.107293-2-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240524073305.107293-1-j-choudhary@ti.com>
References: <20240524073305.107293-1-j-choudhary@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Currently, mode_valid hook returns all mode as valid and it is
defined only in drm_connector_helper_funcs. With the introduction of
'DRM_BRIDGE_ATTACH_NO_CONNECTOR', connector is not initialized in
bridge_attach call for cases when the encoder has this flag enabled.
So add the mode_valid hook in drm_bridge_funcs as well with proper
clock checks for maximum and minimum pixel clock supported by the
bridge.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 drivers/gpu/drm/bridge/sii902x.c | 38 ++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 2fbeda9025bf..ef7c3ab3386c 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -163,6 +163,14 @@
 
 #define SII902X_AUDIO_PORT_INDEX		3
 
+/*
+ * The maximum resolution supported by the HDMI bridge is 1080p@60Hz
+ * and 1920x1200 requiring a pixel clock of 165MHz and the minimum
+ * resolution supported is 480p@60Hz requiring a pixel clock of 25MHz
+ */
+#define SII902X_MIN_PIXEL_CLOCK_KHZ		25000
+#define SII902X_MAX_PIXEL_CLOCK_KHZ		165000
+
 struct sii902x {
 	struct i2c_client *i2c;
 	struct regmap *regmap;
@@ -310,12 +318,26 @@ static int sii902x_get_modes(struct drm_connector *connector)
 	return num;
 }
 
+static enum
+drm_mode_status sii902x_validate(struct sii902x *sii902x,
+				 const struct drm_display_mode *mode)
+{
+	if (mode->clock < SII902X_MIN_PIXEL_CLOCK_KHZ)
+		return MODE_CLOCK_LOW;
+
+	if (mode->clock > SII902X_MAX_PIXEL_CLOCK_KHZ)
+		return MODE_CLOCK_HIGH;
+
+	return MODE_OK;
+}
+
 static enum drm_mode_status sii902x_mode_valid(struct drm_connector *connector,
 					       struct drm_display_mode *mode)
 {
-	/* TODO: check mode */
+	struct sii902x *sii902x = connector_to_sii902x(connector);
+	const struct drm_display_mode *mod = mode;
 
-	return MODE_OK;
+	return sii902x_validate(sii902x, mod);
 }
 
 static const struct drm_connector_helper_funcs sii902x_connector_helper_funcs = {
@@ -499,11 +521,22 @@ static int sii902x_bridge_atomic_check(struct drm_bridge *bridge,
 	 * There might be flags negotiation supported in future but
 	 * set the bus flags in atomic_check statically for now.
 	 */
+
 	bridge_state->input_bus_cfg.flags = bridge->timings->input_bus_flags;
 
 	return 0;
 }
 
+static enum drm_mode_status
+sii902x_bridge_mode_valid(struct drm_bridge *bridge,
+			  const struct drm_display_info *info,
+			  const struct drm_display_mode *mode)
+{
+	struct sii902x *sii902x = bridge_to_sii902x(bridge);
+
+	return sii902x_validate(sii902x, mode);
+}
+
 static const struct drm_bridge_funcs sii902x_bridge_funcs = {
 	.attach = sii902x_bridge_attach,
 	.mode_set = sii902x_bridge_mode_set,
@@ -516,6 +549,7 @@ static const struct drm_bridge_funcs sii902x_bridge_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_get_input_bus_fmts = sii902x_bridge_atomic_get_input_bus_fmts,
 	.atomic_check = sii902x_bridge_atomic_check,
+	.mode_valid = sii902x_bridge_mode_valid,
 };
 
 static int sii902x_mute(struct sii902x *sii902x, bool mute)
-- 
2.25.1


