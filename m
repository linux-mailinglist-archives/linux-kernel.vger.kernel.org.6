Return-Path: <linux-kernel+bounces-218839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8294F90C6E8
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93A6B1C21B04
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B2D1741CF;
	Tue, 18 Jun 2024 08:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Cai9OYMN"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAAF182A6
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 08:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718698510; cv=none; b=hM9HHeb4omAKlUpl/7do8+naaUCaNkTL7juLuf0Vopf6kCBf63iLClE00zlM+eYfxUmRP62AsMYvrriDhXqH/sgpuPp4IhLL4lbALVQ+UMSMitjq2N9ifrorKAOSPySjWEIWLRrH7ciy6hEKrMipKGmj9i6MHt5w9n6s9U1K6ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718698510; c=relaxed/simple;
	bh=3q/F3MVm0T7bYYgpP9cw4DOopoOMxFrZx9pkTubrS7Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o1vZ8iM0TgMAn4ryfH4iJ2fh/nuOgiCiJ4S8vaOP2SwzQ9dE8uqWFBoAAoNMIu3Q1YjVPiZJ92PGxP0kxXNqLtP8m15sfWLiINbOY+peq4tmpXucvOWn3az5o1E1+Bf/973RhQqXxc3NO8hqAr9/rQ7Pjf9vHftlbWALehwvl5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Cai9OYMN; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45I8EM53022994;
	Tue, 18 Jun 2024 03:14:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718698462;
	bh=InxwNCbAgTFgl5F/JHeHsZPtxbn/61wBZDbAEWeX2GI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Cai9OYMNdHsRnrmZb98cjC2ECjSsSF3xayKgpM3vVwdclvfrk/KoPNvUMe8ZmQ69p
	 qL7buI3bzFWtv2rDutPB91tgLKphCPhwB6mgVCkqTItJKkg8xHtgik6Ea6Jy+szfeM
	 eq+tgDsyjBSs5/QsRHdG2mNUnvFu2bz4DgdWxkws=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45I8EMIc128612
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 18 Jun 2024 03:14:22 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 18
 Jun 2024 03:14:22 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 18 Jun 2024 03:14:22 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.55])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45I8ELeX116990;
	Tue, 18 Jun 2024 03:14:22 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <dianders@chromium.org>, <andrzej.hajda@intel.com>,
        <neil.armstrong@linaro.org>, <rfoss@kernel.org>,
        <Laurent.pinchart@ideasonboard.com>, <mripard@kernel.org>,
        <j-choudhary@ti.com>
CC: <linux-kernel@vger.kernel.org>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <maarten.lankhorst@linux.intel.com>,
        <tzimmermann@suse.de>, <airlied@gmail.com>, <daniel@ffwll.ch>,
        <spanda@codeaurora.org>, <a-bhatia1@ti.com>,
        <dri-devel@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/bridge: ti-sn65dsi86: Fix ti_sn_bridge_set_dsi_rate function
Date: Tue, 18 Jun 2024 13:44:18 +0530
Message-ID: <20240618081418.250953-3-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240618081418.250953-1-j-choudhary@ti.com>
References: <20240618081418.250953-1-j-choudhary@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

During code inspection, it was found that due to integer calculations,
the rounding off can cause errors in the final value propagated in the
registers.
Considering the example of 1080p (very common resolution), the mode->clock
is 148500, dsi->lanes = 4, and bpp = 24, with the previous logic, the DSI
clock frequency would come as 444 when we are expecting the value 445.5
which would reflect in SN_DSIA_CLK_FREQ_REG.
So move the division to be the last operation where rounding off will not
impact the register value.

Fixes: a095f15c00e2 ("drm/bridge: add support for sn65dsi86 bridge driver")
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index d13b42d7c512..5bf12af6b657 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -111,8 +111,6 @@
 #define  AUX_IRQ_STATUS_AUX_SHORT		BIT(5)
 #define  AUX_IRQ_STATUS_NAT_I2C_FAIL		BIT(6)
 
-#define MIN_DSI_CLK_FREQ_MHZ	40
-
 /*
  * NOTE: DSI clock frequency range: [40MHz,755MHz)
  * DSI clock frequency range is in 5-MHz increments
@@ -1219,19 +1217,21 @@ static int ti_sn_bridge_atomic_check(struct drm_bridge *bridge,
 {
 	struct ti_sn65dsi86 *pdata = bridge_to_ti_sn65dsi86(bridge);
 	struct drm_display_mode *mode = &crtc_state->mode;
-	unsigned int bit_rate_mhz, clk_freq_mhz;
+	unsigned int bit_rate_khz;
 
 	/* Pixel clock check */
 	if (mode->clock > SN65DSI86_MAX_PIXEL_CLOCK_KHZ)
 		return -EINVAL;
 
-	bit_rate_mhz = (mode->clock / 1000) *
+	bit_rate_khz = mode->clock *
 			mipi_dsi_pixel_format_to_bpp(pdata->dsi->format);
-	clk_freq_mhz = bit_rate_mhz / (pdata->dsi->lanes * 2);
 
-	/* for each increment in dsi_clk_range, frequency increases by 5MHz */
-	pdata->dsi_clk_range = (MIN_DSI_CLK_FREQ_MHZ / 5) +
-		(((clk_freq_mhz - MIN_DSI_CLK_FREQ_MHZ) / 5) & 0xFF);
+	/*
+	 * For each increment in dsi_clk_range, frequency increases by 5MHz
+	 * and the factor of 1000 comes from kHz to MHz conversion
+	 */
+	pdata->dsi_clk_range = (bit_rate_khz /
+				(pdata->dsi->lanes * 2 * 1000 * 5)) & 0xFF;
 
 	/* SN_DSIA_CLK_FREQ_REG check */
 	if (pdata->dsi_clk_range > MAX_DSI_CLK_RANGE ||
-- 
2.25.1


