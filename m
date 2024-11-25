Return-Path: <linux-kernel+bounces-421127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E2D79D8712
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 14:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B27F28651F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 13:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C23A1AF0DA;
	Mon, 25 Nov 2024 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="TSWFbGXc"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461EE1ADFFB;
	Mon, 25 Nov 2024 13:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732542616; cv=none; b=qWasG8JPqbRRmCvjRBzHAYq2BCRsA/jAEXjfs8vESxb4+oyhJHqRVbyHN95u9GzqxCSfuJezjJDwlwnbxlv8GYZZSKh3cHJ+S8a1Nuh3BJ3vSdYE9WkKOqGLWUZzXShIbyDXgIQxN5Fk/2CKOgurWEyQOA++48ZWp2pxT0idPpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732542616; c=relaxed/simple;
	bh=TlkyzW8NMaKgPvQS3pbEqj4bv6DEDuXV46KwTt4ejGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KwuEr8BYhGOeymQJeBxH4Xp9NO3wzGdjZ7gmeikTV6XURxncnSLypwf6PKc+LYCmqYt73VxPkewe0JlDDZErKLNIjq/kmGD9ERBfV3byXP5NsSoL0DrUYq7IpEIFz8ZLdxGPOcxn1W6hyjTUsopte73/9W+5UT2LVdfvqNRsQqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=TSWFbGXc; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=YX5YUSgQhjndAt0sb0ENmF6XZRCGd2awE/vIbYDp+ek=; b=TSWFbGXcMccB8NduNdu8UkSdyZ
	lDSFG2a+5IAjCK7aqlohfVijKDwMfJSBQ/MedN7pyx7L2vVaRFR3f4RxV9PgKHOiqPmEn1WPGvqPQ
	IFZ3V7qCXX8Lq+R8znPFwfnAXJBXsaXr8XNdZOxqTJMSwygLA07pSFs6FtpKMvyrpbWQL2VzQEEsv
	5ZTtce8LhmAANataDOuslRHwm4gDeG964jZGUDjfDqc8My+9kcdJUBfARDTrfoztD5C2YRPxK6m1o
	xTbviSPz2PYTzz80aBLLsLa0OHzLqrL51bwLWPAeaqtDDcWork6qOlU/4AekjO1yXphEA1+wmM0uv
	iGeFItJw==;
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tFZTB-000Ccl-Sn; Mon, 25 Nov 2024 14:49:41 +0100
Received: from [185.17.218.86] (helo=zen.localdomain)
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tFZTA-000A3a-2y;
	Mon, 25 Nov 2024 14:49:40 +0100
From: Sean Nyekjaer <sean@geanix.com>
Date: Mon, 25 Nov 2024 14:49:28 +0100
Subject: [PATCH v2 3/3] drm/stm: dsi: use drm_mode_validate_mode() helper
 function
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-dsi-relax-v2-3-9113419f4a40@geanix.com>
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

When using the DSI interface via DSI2LVDS bridge, it seems a bit harsh
to reguire the requested and the actual px clock to be within
50Hz. A typical LVDS display requires the px clock to be within +-10%.

In case for HDMI .5% tolerance is required.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/gpu/drm/stm/dw_mipi_dsi-stm.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
index b20123854c4ad7b3a2cc973a26fc10fd433e8d09..7b32abe0d4f582eea1fbbacad48c84199be3fa23 100644
--- a/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
+++ b/drivers/gpu/drm/stm/dw_mipi_dsi-stm.c
@@ -484,8 +484,6 @@ dw_mipi_dsi_phy_get_timing(void *priv_data, unsigned int lane_mbps,
 	return 0;
 }
 
-#define CLK_TOLERANCE_HZ 50
-
 static enum drm_mode_status
 dw_mipi_dsi_stm_mode_valid(void *priv_data,
 			   const struct drm_display_mode *mode,
@@ -525,7 +523,7 @@ dw_mipi_dsi_stm_mode_valid(void *priv_data,
 	}
 
 	if (!(mode_flags & MIPI_DSI_MODE_VIDEO_BURST)) {
-		unsigned int px_clock_hz, target_px_clock_hz, lane_mbps;
+		unsigned int px_clock_hz, lane_mbps;
 		int dsi_short_packet_size_px, hfp, hsync, hbp, delay_to_lp;
 		struct dw_mipi_dsi_dphy_timing dphy_timing;
 
@@ -533,14 +531,14 @@ dw_mipi_dsi_stm_mode_valid(void *priv_data,
 		pll_out_khz = dsi_pll_get_clkout_khz(pll_in_khz, idf, ndiv, odf);
 
 		px_clock_hz = DIV_ROUND_CLOSEST_ULL(1000ULL * pll_out_khz * lanes, bpp);
-		target_px_clock_hz = mode->clock * 1000;
 		/*
 		 * Filter modes according to the clock value, particularly useful for
 		 * hdmi modes that require precise pixel clocks.
 		 */
-		if (px_clock_hz < target_px_clock_hz - CLK_TOLERANCE_HZ ||
-		    px_clock_hz > target_px_clock_hz + CLK_TOLERANCE_HZ)
-			return MODE_CLOCK_RANGE;
+
+		ret = drm_mode_validate_mode(mode, px_clock_hz);
+		if (ret)
+			return ret;
 
 		/* sync packets are codes as DSI short packets (4 bytes) */
 		dsi_short_packet_size_px = DIV_ROUND_UP(4 * BITS_PER_BYTE, bpp);

-- 
2.46.2


