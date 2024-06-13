Return-Path: <linux-kernel+bounces-212843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BFB90672D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA03C1C224A2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A21A140E5C;
	Thu, 13 Jun 2024 08:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qvf10RLS"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741D613D608
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 08:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718267932; cv=none; b=ZvHQWhwRw/A5W7fMlBoaU4ftiwwycsCXP9P0D1RLiA4lSLko45R9wIuYTRvFbDBs8nrMpIjn4a5B3CEsaL+Szrsmo/4efythSrJobpZkL9Qev9kwIvn7ynwmDLS7rut+faFbwjgkjje5i6B3fR2P5FNHFRTHhJYNa5DtMP+jTes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718267932; c=relaxed/simple;
	bh=Yt1zy1XfRzHpQQLlgxa42nzh9qUkh5kQNqod7piTvQQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m2oi4cgQQMz67hS1SN8LeCZnknbzCnvYHTjSOLnkkFZfaGOAzFBgJ1tpmKEKCeDK/6k7U9h/n9MBIz9s4rOw1OLwE64ukBkr+9qZCGjxNXv0tbPTRgYXak2bNsEl+AonbPrQSZ9bWjgUqug0iOClaIrKS52EY5DfBjjLRrzbbHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qvf10RLS; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45D8c8QB023308;
	Thu, 13 Jun 2024 03:38:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718267888;
	bh=BY7OHhQbmNI82hBMi2BWuhYz45KvvtmVf4whs4ZENdk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=qvf10RLSnFcdwKeYKVzZRExDu9dUzzQ3KYQJpYFBTpQoYt6xpMo2K2jQrbf/38Hv4
	 byAQXvufKZwco6v39JUkP4DBhaBBgWNpwz44xtjbE4zgfFm1YpZFZuhKqe0CkfpN3T
	 4bdRVuKjL5k3pOE+JJ2bjAqBcyeumsEsvbQmgdpY=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45D8c8N6068476
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Jun 2024 03:38:08 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jun 2024 03:38:07 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jun 2024 03:38:07 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.55])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45D8c7f9070256;
	Thu, 13 Jun 2024 03:38:07 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <linux-kernel@vger.kernel.org>, <dmitry.baryshkov@linaro.org>,
        <sui.jingfeng@linux.dev>, <andrzej.hajda@intel.com>,
        <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <mripard@kernel.org>,
        <sam@ravnborg.org>, <j-choudhary@ti.com>
CC: <jonas@kwiboo.se>, <jernej.skrabec@gmail.com>,
        <maarten.lankhorst@linux.intel.com>, <tzimmermann@suse.de>,
        <airlied@gmail.com>, <daniel@ffwll.ch>, <a-bhatia1@ti.com>,
        <dri-devel@lists.freedesktop.org>
Subject: [PATCH v5 1/3] drm/bridge: sii902x: Fix mode_valid hook
Date: Thu, 13 Jun 2024 14:08:03 +0530
Message-ID: <20240613083805.439337-2-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240613083805.439337-1-j-choudhary@ti.com>
References: <20240613083805.439337-1-j-choudhary@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Currently, mode_valid is defined only in drm_connector_helper_funcs.
When the bridge is attached with the 'DRM_BRIDGE_ATTACH_NO_CONNECTOR'
flag, the connector is not initialized, and so is the mode_valid
hook under connector helper funcs.
It also returns MODE_OK for all modes without actually checking the
modes.
So move the mode_valid hook to drm_bridge_funcs with proper clock
checks for maximum and minimum pixel clock supported by the bridge.

Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Acked-by: Sui Jingfeng <sui.jingfeng@linux.dev>
---
 drivers/gpu/drm/bridge/sii902x.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 2fbeda9025bf..6a6055a4ccf9 100644
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
@@ -310,17 +318,8 @@ static int sii902x_get_modes(struct drm_connector *connector)
 	return num;
 }
 
-static enum drm_mode_status sii902x_mode_valid(struct drm_connector *connector,
-					       struct drm_display_mode *mode)
-{
-	/* TODO: check mode */
-
-	return MODE_OK;
-}
-
 static const struct drm_connector_helper_funcs sii902x_connector_helper_funcs = {
 	.get_modes = sii902x_get_modes,
-	.mode_valid = sii902x_mode_valid,
 };
 
 static void sii902x_bridge_disable(struct drm_bridge *bridge)
@@ -504,6 +503,20 @@ static int sii902x_bridge_atomic_check(struct drm_bridge *bridge,
 	return 0;
 }
 
+static enum drm_mode_status
+sii902x_bridge_mode_valid(struct drm_bridge *bridge,
+			  const struct drm_display_info *info,
+			  const struct drm_display_mode *mode)
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
 static const struct drm_bridge_funcs sii902x_bridge_funcs = {
 	.attach = sii902x_bridge_attach,
 	.mode_set = sii902x_bridge_mode_set,
@@ -516,6 +529,7 @@ static const struct drm_bridge_funcs sii902x_bridge_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_get_input_bus_fmts = sii902x_bridge_atomic_get_input_bus_fmts,
 	.atomic_check = sii902x_bridge_atomic_check,
+	.mode_valid = sii902x_bridge_mode_valid,
 };
 
 static int sii902x_mute(struct sii902x *sii902x, bool mute)
-- 
2.25.1


