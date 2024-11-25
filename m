Return-Path: <linux-kernel+bounces-421126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A119D88A9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 16:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5EE1B2F378
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D276C1AF0A9;
	Mon, 25 Nov 2024 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="SeTmP87U"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F616192B7F;
	Mon, 25 Nov 2024 13:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732542615; cv=none; b=NTc11lK2E3C8iH2B9as1AJacmiPKb3WEjSS9R7Ph7hBNssyilnFwGpM3+EOGagOJ6gj9ydBor+3zy9q6Y16XTBZb55RJv9FkMBG9CpDOqk2CxDDBChOxQrGZwPTJAORKGyXUhcZzFXwklcUDLsB5AEjXJnp555NVc2B8p6xvjLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732542615; c=relaxed/simple;
	bh=hHFK9TjHLcIEwu6OAGQmRCGOmc214agDB/6W8FFM1NE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rgfVHSa20R4AOY7NGBtbKyoeJvUWaty0uzrLOVJvGx4WbziDHYqsS8AnTRdMzmRZ4q2OgCXWhnRzRNmgXODeX5RgEzxtb3H/6YZmGOe6sWl1Nh3xf7yYMWvjSGy8oD47ZWvP5jywE/toJCYOJ5RK+nRUmmYsbONBMMY/JZZPwWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=SeTmP87U; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Fxz5Fki1U5+hxMHiHWwSLT/o9JnSwind+K7SOw8JtPg=; b=SeTmP87Ulssn1N+zq4bzaecqeE
	a984bOYP2C3jRAFNWKGLoTtJNY/4+PoaZ2BfVzNKGNHz97YFRdA8epnhik12eWD8ImhEn0darPJsD
	tfb/Gx+nMFQjKwNiATZueHa55XOeFS2/gh44Hoya7GDzP5ZpK7ZrSUHL/cV2aJB96ZTL/hoMjUxC+
	vpKSEXzx4gGkOx3omj81UoWPf/eNR30qUeqU8W9JsgyNRMZoDB2NaYS2diNiztXNgbvP9sZSIN03b
	qqbm6aD8catHJy/wkvJ6pv3DghSMdyQr2NiW5AhTe+TTzWSYvX3dCNZP2CBn+VYpS2WAAB6qkAdUN
	bVUXNdDg==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tFZTB-000Ccj-GN; Mon, 25 Nov 2024 14:49:41 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tFZTA-000A3a-1j;
	Mon, 25 Nov 2024 14:49:40 +0100
From: Sean Nyekjaer <sean@geanix.com>
Date: Mon, 25 Nov 2024 14:49:27 +0100
Subject: [PATCH v2 2/3] drm/sun4i: use drm_mode_validate_mode() helper
 function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-dsi-relax-v2-2-9113419f4a40@geanix.com>
References: <20241125-dsi-relax-v2-0-9113419f4a40@geanix.com>
In-Reply-To: <20241125-dsi-relax-v2-0-9113419f4a40@geanix.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Yannick Fertre <yannick.fertre@foss.st.com>, 
 Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, 
 Philippe Cornu <philippe.cornu@foss.st.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-stm32@st-md-mailman.stormreply.com, Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27468/Mon Nov 25 10:36:56 2024)

Use new helper function for HDMI mode validation

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/gpu/drm/sun4i/sun4i_rgb.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index dfb6acc42f02efc40f36914e2925510cd8056d0b..4f8100e32769cf31c25f5dd849a18f5b77376090 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -51,14 +51,6 @@ static int sun4i_rgb_get_modes(struct drm_connector *connector)
 	return drm_panel_get_modes(rgb->panel, connector);
 }
 
-/*
- * VESA DMT defines a tolerance of 0.5% on the pixel clock, while the
- * CVT spec reuses that tolerance in its examples, so it looks to be a
- * good default tolerance for the EDID-based modes. Define it to 5 per
- * mille to avoid floating point operations.
- */
-#define SUN4I_RGB_DOTCLOCK_TOLERANCE_PER_MILLE	5
-
 static enum drm_mode_status sun4i_rgb_mode_valid(struct drm_encoder *crtc,
 						 const struct drm_display_mode *mode)
 {
@@ -67,8 +59,8 @@ static enum drm_mode_status sun4i_rgb_mode_valid(struct drm_encoder *crtc,
 	u32 hsync = mode->hsync_end - mode->hsync_start;
 	u32 vsync = mode->vsync_end - mode->vsync_start;
 	unsigned long long rate = mode->clock * 1000;
-	unsigned long long lowest, highest;
 	unsigned long long rounded_rate;
+	int ret;
 
 	DRM_DEBUG_DRIVER("Validating modes...\n");
 
@@ -122,15 +114,9 @@ static enum drm_mode_status sun4i_rgb_mode_valid(struct drm_encoder *crtc,
 	tcon->dclk_max_div = 127;
 	rounded_rate = clk_round_rate(tcon->dclk, rate);
 
-	lowest = rate * (1000 - SUN4I_RGB_DOTCLOCK_TOLERANCE_PER_MILLE);
-	do_div(lowest, 1000);
-	if (rounded_rate < lowest)
-		return MODE_CLOCK_LOW;
-
-	highest = rate * (1000 + SUN4I_RGB_DOTCLOCK_TOLERANCE_PER_MILLE);
-	do_div(highest, 1000);
-	if (rounded_rate > highest)
-		return MODE_CLOCK_HIGH;
+	ret = drm_mode_validate_mode(mode, rounded_rate);
+	if (ret)
+		return ret;
 
 out:
 	DRM_DEBUG_DRIVER("Clock rate OK\n");

-- 
2.46.2


