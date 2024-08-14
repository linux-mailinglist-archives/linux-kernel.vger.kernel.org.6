Return-Path: <linux-kernel+bounces-286317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E55A95198F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 13:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30DEA1C219FA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 11:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94141AE04A;
	Wed, 14 Aug 2024 11:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="XkJFtD1g"
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF00142E70
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 11:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723633310; cv=none; b=R6qxW5UDapt74NK1jZf8bEHOxGlWmpXv8MMHeeFRkD2c5aXdQJ8ddJeAuC5MfhCxA7P2T4VdkhZB+h9uJb7/nt7zC3huQ4RCRd/k1xzb7ArgNbTiJewzjWdmZtCyxwxbx/zYG82nW/90ILjH/4CH4QGAMhh80XstO301aGBzV3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723633310; c=relaxed/simple;
	bh=/ben4x4Lt7ar33USmuN4cvpXOjmOGf5LZVeZmW7Ul58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=iu34Mp5DQFH94nG0oaeR8h7JnFxNWyW+mIUsENBvBADJVCUP5uWFcPuEjU+BQWJdbz2A33c5mQlaG9rkjZMYfYWFWvvrZ+KpYy9thpSGaS4Yn1X6Yw9Y91BbeJBVVMhAsvyI59WXsM4B4rkUcezCcbBd4V/ifseswGQGQMw+FZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=XkJFtD1g; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
	MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References; bh=8phpuiSof5rMSznwRec8HdGorNFfCz+rTFjE5R8oajk=; b=Xk
	JFtD1gQDKI9kJuhDiD0QfQ1EG47w+G9KIji92E/YbWWBlsubmgQSRfBD/RQExMJjPvyCAaj3b7FOb
	Q566Mc0t2C2K/PbSenHCZ3rIb5jzR4PgYu/X25CQL33om9S7+ry92G7Ez/ts1/pGi/ZXtaw3VoCYv
	NAhirZ3ksgN/6gFJdA/l8Hx1JBxMMjrSbwYWPs3xiiiknEe41dFlN/JB4S7Ov+itRazGGGUkbrQKZ
	TY1aoVbITxi2X2STpxwxZ1efSPZWGobjSLmuRwnufLxv+bT6RWsCOVNsSI+wC8rzwK5+uy7ye0c99
	tQGSL3Zdo2v9OYIhRtMAx2qq3Cs938lQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <esben@geanix.com>)
	id 1seBNl-0007uf-Fu; Wed, 14 Aug 2024 12:37:33 +0200
Received: from [185.17.218.86] (helo=localhost)
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <esben@geanix.com>)
	id 1seBNk-000Ke4-2h;
	Wed, 14 Aug 2024 12:37:33 +0200
From: Esben Haabendal <esben@geanix.com>
Date: Wed, 14 Aug 2024 12:37:26 +0200
Subject: [PATCH] drm/bridge: nwl-dsi: Use vsync/hsync polarity from display
 mode
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240814-nwl-dsi-sync-polarity-v1-1-ee198e369196@geanix.com>
X-B4-Tracking: v=1; b=H4sIAOWIvGYC/x3MSQqAMAxA0atI1gYcUhCvIi5KGzVQqjTigHh3i
 8u3+P8B5SSs0BcPJD5EZY0ZdVmAW2ycGcVnQ1M1VHU1YTwDehXUOzrc1mCT7Dd670xHrbHkCHK
 7JZ7k+r/D+L4fcX8yEGcAAAA=
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Esben Haabendal <esben@geanix.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723631852; l=2368;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=/ben4x4Lt7ar33USmuN4cvpXOjmOGf5LZVeZmW7Ul58=;
 b=5lZFs/bcJBod73IHhPaK12LCIwYp19NdB2uj04v5OIa0czZT8x+qy/rqRL5P8u4gs8rxgyL0B
 RgKDLjqJOGqBIRNfMjs2jsBLwEUVcyyw3IO78v84Xg/hlvtHP6Nnj32
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
X-Authenticated-Sender: esben@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27367/Wed Aug 14 10:36:34 2024)

Using the correct bit helps. The documentation specifies bit 0 in both
registers to be controlling polarity of dpi_vsync_input and
dpi_hsync_input polarity. Bit 1 is reserved, and should therefore not be
set.

Tested with panel that requires active high vsync and hsync.

Signed-off-by: Esben Haabendal <esben@geanix.com>
---
 drivers/gpu/drm/bridge/nwl-dsi.c | 8 ++++----
 drivers/gpu/drm/bridge/nwl-dsi.h | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index 8d54091ec66e..5f05647a3bea 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -289,13 +289,13 @@ static int nwl_dsi_config_dpi(struct nwl_dsi *dsi)
 
 	nwl_dsi_write(dsi, NWL_DSI_INTERFACE_COLOR_CODING, NWL_DSI_DPI_24_BIT);
 	nwl_dsi_write(dsi, NWL_DSI_PIXEL_FORMAT, color_format);
-	/*
-	 * Adjusting input polarity based on the video mode results in
-	 * a black screen so always pick active low:
-	 */
 	nwl_dsi_write(dsi, NWL_DSI_VSYNC_POLARITY,
+		      dsi->mode.flags & DRM_MODE_FLAG_PVSYNC ?
+		      NWL_DSI_VSYNC_POLARITY_ACTIVE_HIGH :
 		      NWL_DSI_VSYNC_POLARITY_ACTIVE_LOW);
 	nwl_dsi_write(dsi, NWL_DSI_HSYNC_POLARITY,
+		      dsi->mode.flags & DRM_MODE_FLAG_PHSYNC ?
+		      NWL_DSI_HSYNC_POLARITY_ACTIVE_HIGH :
 		      NWL_DSI_HSYNC_POLARITY_ACTIVE_LOW);
 
 	burst_mode = (dsi->dsi_mode_flags & MIPI_DSI_MODE_VIDEO_BURST) &&
diff --git a/drivers/gpu/drm/bridge/nwl-dsi.h b/drivers/gpu/drm/bridge/nwl-dsi.h
index a247a8a11c7c..61e7d65cb1eb 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.h
+++ b/drivers/gpu/drm/bridge/nwl-dsi.h
@@ -30,11 +30,11 @@
 #define NWL_DSI_PIXEL_FORMAT			0x20c
 #define NWL_DSI_VSYNC_POLARITY			0x210
 #define NWL_DSI_VSYNC_POLARITY_ACTIVE_LOW	0
-#define NWL_DSI_VSYNC_POLARITY_ACTIVE_HIGH	BIT(1)
+#define NWL_DSI_VSYNC_POLARITY_ACTIVE_HIGH	BIT(0)
 
 #define NWL_DSI_HSYNC_POLARITY			0x214
 #define NWL_DSI_HSYNC_POLARITY_ACTIVE_LOW	0
-#define NWL_DSI_HSYNC_POLARITY_ACTIVE_HIGH	BIT(1)
+#define NWL_DSI_HSYNC_POLARITY_ACTIVE_HIGH	BIT(0)
 
 #define NWL_DSI_VIDEO_MODE			0x218
 #define NWL_DSI_HFP				0x21c

---
base-commit: 7c626ce4bae1ac14f60076d00eafe71af30450ba
change-id: 20240814-nwl-dsi-sync-polarity-ddc58435a4c4

Best regards,
-- 
Esben Haabendal <esben@geanix.com>


