Return-Path: <linux-kernel+bounces-510838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6022FA322AD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3555188494A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C83206F0B;
	Wed, 12 Feb 2025 09:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wozjY8AU"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA741E282D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739353558; cv=none; b=QGvvuDrcxVmcxKFPmzNJUW1cgU2JawrbQq1dubJ1qM5hFOLNJ2JaahQZ+bdUaPYhhO9TemrKxL8L72su92//0mO2EWQw7pKygyiLdHT5QQKF+8/esKzARiIaTR6HHw5C4I3izrrA6Omr1ybGTMwfeu4+Vy+CK90zDET4G9dzqKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739353558; c=relaxed/simple;
	bh=vnx2AdOW50HMFVLSHH43ey2HhNMvsX6+y6C07WIJ1a8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rqP3pwR8HGUgtc9/txEU8DHqzGixT5Am4eHMB2B0d4ajzfc+oyOpUbqt1tPm3JtS6SAgYXnWNn//g290zk+kexyOcJuupibCX6hmr2z+0A8Iwx7NjEv4RrelB36yVr4J2rO6uq/m3nsVfebkinOvuxaZTS94yVl9V4CVyTvBnls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wozjY8AU; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1739353556; x=1770889556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vnx2AdOW50HMFVLSHH43ey2HhNMvsX6+y6C07WIJ1a8=;
  b=wozjY8AUp4C4ji5MH/LD3W6zvdyRYXd2Imbv9kcdypHDv9rxqqAQQvqk
   8GHSLsJVyqA3wT3T+V1Z/OR/cyEG0VkXNvTIT1WowSi85Wg4PPM+125cY
   BDqypNOT0B6VtvEjth8gBQi2O9gj0yfHKnHSOTNpZ+M6t1WwtwqEwYVtS
   XgGj2c52fmwX1+WFxLy/6k+87smUIAWjdnuwcxCQ7TyJWiYF8sfFOgXzk
   jOy6cM0ZkfBg37kdxj7S2D/TqhB8TH+0iAsb0JvPEtLDA4p6tM0zXd9Es
   njmr6J3YrsWCjck7u3Bo6crzYTXMKMKrflm5B09xORbkzjszutt+GP2ZV
   g==;
X-CSE-ConnectionGUID: 8MuVtLdRQ2uCYR3xxsN4MA==
X-CSE-MsgGUID: poXRycaeTVyvkAHRJFv8uw==
X-IronPort-AV: E=Sophos;i="6.13,279,1732604400"; 
   d="scan'208";a="37585559"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2025 02:45:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 12 Feb 2025 02:45:14 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 12 Feb 2025 02:45:08 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <sam@ravnborg.org>, <bbrezillon@kernel.org>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <lee@kernel.org>,
	<dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Dharma Balasubiramani <dharma.b@microchip.com>, Manikandan Muralidharan
	<manikandan.m@microchip.com>
Subject: [PATCH v2 3/3] drm: atmel-hlcdc: set LVDS PLL clock rate for LVDS Displays
Date: Wed, 12 Feb 2025 15:14:49 +0530
Message-ID: <20250212094449.109622-3-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250212094449.109622-1-manikandan.m@microchip.com>
References: <20250212094449.109622-1-manikandan.m@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Dharma Balasubiramani <dharma.b@microchip.com>

The LVDS PLL clock runs at 7 times the panel pixel clock.
For LVDS displays, the PLL clock rate is set based on the
panel pixel clock, eliminating the need for the assigned-clock-rates
Device Tree property for lvds_pll_clk in the LCD node.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
Changes in v2:
- Rephrase commit message and comment block
---
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 48 ++++++++++++++++---
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 0e709047369a..cf4f9ccd81a4 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -99,9 +99,15 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 		drm_connector_list_iter_end(&iter);
 	}
 
-	ret = clk_prepare_enable(crtc->dc->hlcdc->sys_clk);
-	if (ret)
-		return;
+	if (crtc->dc->hlcdc->lvds_pll_clk) {
+		ret = clk_prepare_enable(crtc->dc->hlcdc->lvds_pll_clk);
+		if (ret)
+			return;
+	} else {
+		ret = clk_prepare_enable(crtc->dc->hlcdc->sys_clk);
+		if (ret)
+			return;
+	}
 
 	vm.vfront_porch = adj->crtc_vsync_start - adj->crtc_vdisplay;
 	vm.vback_porch = adj->crtc_vtotal - adj->crtc_vsync_end;
@@ -186,7 +192,10 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 			   ATMEL_XLCDC_DPI : ATMEL_HLCDC_MODE_MASK),
 			   cfg);
 
-	clk_disable_unprepare(crtc->dc->hlcdc->sys_clk);
+	if (crtc->dc->hlcdc->lvds_pll_clk)
+		clk_disable_unprepare(crtc->dc->hlcdc->lvds_pll_clk);
+	else
+		clk_disable_unprepare(crtc->dc->hlcdc->sys_clk);
 }
 
 static enum drm_mode_status
@@ -242,7 +251,11 @@ static void atmel_hlcdc_crtc_atomic_disable(struct drm_crtc *c,
 				    10, 1000))
 		dev_warn(dev->dev, "Atmel LCDC status register CLKSTS timeout\n");
 
-	clk_disable_unprepare(crtc->dc->hlcdc->sys_clk);
+	if (crtc->dc->hlcdc->lvds_pll_clk)
+		clk_disable_unprepare(crtc->dc->hlcdc->lvds_pll_clk);
+	else
+		clk_disable_unprepare(crtc->dc->hlcdc->sys_clk);
+
 	pinctrl_pm_select_sleep_state(dev->dev);
 
 	pm_runtime_allow(dev->dev);
@@ -255,15 +268,38 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
 {
 	struct drm_device *dev = c->dev;
 	struct atmel_hlcdc_crtc *crtc = drm_crtc_to_atmel_hlcdc_crtc(c);
+	struct drm_display_mode *adj = &c->state->adjusted_mode;
 	struct regmap *regmap = crtc->dc->hlcdc->regmap;
 	unsigned int status;
+	int ret;
 
 	pm_runtime_get_sync(dev->dev);
 
 	pm_runtime_forbid(dev->dev);
 
 	pinctrl_pm_select_default_state(dev->dev);
-	clk_prepare_enable(crtc->dc->hlcdc->sys_clk);
+
+	if (crtc->dc->hlcdc->lvds_pll_clk) {
+		/*
+		 * For LVDS displays, retrieve the pixel clock from the panel
+		 * and set the LVDS PLL clock rate accordingly.
+		 * According to the datasheet,the LVDS PLL clock is 7 times the pixel clock.
+		 */
+		ret = clk_set_rate(crtc->dc->hlcdc->lvds_pll_clk,
+				   (adj->clock * 7 * 1000));
+		if (ret) {
+			dev_err(dev->dev, "Failed to set LVDS PLL clk rate: %d\n", ret);
+			return;
+		}
+
+		ret = clk_prepare_enable(crtc->dc->hlcdc->lvds_pll_clk);
+		if (ret)
+			return;
+	} else {
+		ret = clk_prepare_enable(crtc->dc->hlcdc->sys_clk);
+		if (ret)
+			return;
+	}
 
 	regmap_write(regmap, ATMEL_HLCDC_EN, ATMEL_HLCDC_PIXEL_CLK);
 	if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
-- 
2.25.1


