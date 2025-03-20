Return-Path: <linux-kernel+bounces-570003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2644A6AA97
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 17:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91926984CC9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 16:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D2A22A7F3;
	Thu, 20 Mar 2025 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ESQpRfnT"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B4B22A4EA
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 16:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742486463; cv=none; b=OJWJTjRtC/mt0bEDIEShEyG/PS7cI9KRGKs6i/rc9er1O482Yf/jIT3YUvzQJ4R3oT6Lo/MqNbHxX4mkB8puVngu2exxrJVg4S1e0YrVKgpX90wwMfxmSrBj6JiLLHKpSPHU0BRZXBGUdr8MHE+LvR6lr4WsYWvrtYfRD8THT8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742486463; c=relaxed/simple;
	bh=zjC+aAWjyFx4oAnilSfbgcfpfJMsawdKHCZ+xTpDXuM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LZIfT02G49xDP0GLh98pWgzWxalrY39F1qYEF1IfGjY/TU88FtCFvZF1rldDF4NINedS/rrTi4OnlAbe9Ot0dh6jKZKsxh053Il9n7zf6mduPoMSA2YwIRkzSNT7d7DOWa2thcM8exRDHyK+1BbX663Qxtw3h/4XB3VX0U5cS6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ESQpRfnT; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 64C80A98;
	Thu, 20 Mar 2025 16:59:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1742486344;
	bh=zjC+aAWjyFx4oAnilSfbgcfpfJMsawdKHCZ+xTpDXuM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ESQpRfnT59Kswtwb0IuLmQ04Hi0+GW4OcRVLyKpN/ULtYv+yIVVfCi771Byozb/hO
	 P14rC4TPtx9xl5y2fEbb37a3HFX/MIFCcH9mOzd/n7Keuz0pLbpihpM2IJrLPJEics
	 uXpyo+C0ww7MT8Tz6IWJH+q9SsWBeqK3ZrkWDCYY=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 20 Mar 2025 18:00:10 +0200
Subject: [PATCH 15/18] drm/bridge: cdns-dsi: Tune adjusted_mode->clock
 according to dsi needs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-cdns-dsi-impro-v1-15-725277c5f43b@ideasonboard.com>
References: <20250320-cdns-dsi-impro-v1-0-725277c5f43b@ideasonboard.com>
In-Reply-To: <20250320-cdns-dsi-impro-v1-0-725277c5f43b@ideasonboard.com>
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, Francesco Dolcini <francesco@dolcini.it>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3451;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=zjC+aAWjyFx4oAnilSfbgcfpfJMsawdKHCZ+xTpDXuM=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBn3Dub/VOn2xuEvX3gjVlZjlOP8jSPzMzFt2Cx7
 WE0tuq/LQqJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ9w7mwAKCRD6PaqMvJYe
 9cO3EACvoBH5BYZbDFYfQIvGMpq1QaA/UGRN6s7SNwsk+sxNH/Rap7UpdQ1nlK4p41bNdba/69q
 +2iXNEhPwpzXp2znOPcT2WTxYj6X6sHicDEsoyhP2vx89crBibks2EfBzuM/Sr7tN9eYFlbv3wO
 PmU4qjFqdhH25NIgynudSBz3qftv+P5UZBK79JKljkCcMoBPSe2SMzO5RO/NcB6mG7hraG2rxWn
 KD9RRhY7T3fCrBewWdkjobJ1HpEM71F+1tRxeHnKQ7ObTKpAHScKqdCj6Cps7T8BYR4n4M2Sp8H
 cXrmZKtdicR2NPhN5FYTdlbHIWH8KYv7AJfh2OgIkXbAjoiTxZ3vuYmWpMIMV8IZOulo/pK+/3X
 63W5O57ndWBUkfN66IQHncsB7m2ELrFyFtsbO15iYnNkUmjPCzuEWW4/ejE43oTFM7NXOvvzs0o
 vifoDZKm/TMLPsLQDBCAcmZrFT5mMXqKl7Nb4Q+mf+sQMrvWlPH3nzjrvBNSKprVdiVzatqW5Z2
 WYSA92xnATH5fTEHC7Y7SG2gSKZDrMxQXUkx9mFkrXBzTa0SgmRRxhQ90GqqW4q0U5GI85s7m/6
 WDu+neOMbjiJf/yQ13u7ZtD2k305pwisMsTFryKWg9xlhfEtHNTETKpC47lcrSCDTlV10LZ73SM
 oWtYgFOJq0M8vDQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

The driver currently expects the pixel clock and the HS clock to be
compatible, but the DPHY PLL doesn't give very finely grained rates.
This often leads to the situation where the pipeline just fails, as the
resulting HS clock is just too off.

We could change the driver to do a better job on adjusting the DSI
blanking values, hopefully getting a working pipeline even if the pclk
and HS clocks are not exactly compatible. But that is a bigger work.

What we can do easily is to see in .atomic_check() what HS clock rate we
can get, based on the pixel clock rate, and then convert the HS clock
rate back to pixel clock rate and ask that rate from the crtc. If the
crtc has a good PLL (which is the case for TI K3 SoCs), this will fix
any issues wrt. the clock rates.

If the crtc cannot provide the requested clock, well, we're no worse off
with this patch than what we have at the moment.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 39 +++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 1a30e2f7d402..9f4f7b6c8330 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -966,6 +966,28 @@ static u32 *cdns_dsi_bridge_get_input_bus_fmts(struct drm_bridge *bridge,
 	return input_fmts;
 }
 
+static long cdns_dsi_round_pclk(struct cdns_dsi *dsi, unsigned long pclk)
+{
+	struct cdns_dsi_output *output = &dsi->output;
+	unsigned int nlanes = output->dev->lanes;
+	union phy_configure_opts phy_opts = { 0 };
+	u32 bitspp;
+	int ret;
+
+	bitspp = mipi_dsi_pixel_format_to_bpp(output->dev->format);
+
+	ret = phy_mipi_dphy_get_default_config(pclk, bitspp, nlanes,
+					       &phy_opts.mipi_dphy);
+	if (ret)
+		return ret;
+
+	ret = phy_validate(dsi->dphy, PHY_MODE_MIPI_DPHY, 0, &phy_opts);
+	if (ret)
+		return ret;
+
+	return div64_u64((u64)phy_opts.mipi_dphy.hs_clk_rate * nlanes, bitspp);
+}
+
 static int cdns_dsi_bridge_atomic_check(struct drm_bridge *bridge,
 					struct drm_bridge_state *bridge_state,
 					struct drm_crtc_state *crtc_state,
@@ -978,12 +1000,27 @@ static int cdns_dsi_bridge_atomic_check(struct drm_bridge *bridge,
 	struct cdns_dsi_cfg *dsi_cfg = &dsi_state->dsi_cfg;
 	struct drm_display_mode *adjusted_crtc_mode = &crtc_state->adjusted_mode;
 	struct videomode vm;
+	long pclk;
 
 	/* cdns-dsi requires negative syncs */
 	adjusted_crtc_mode->flags &= ~(DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC);
 	adjusted_crtc_mode->flags |= DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC;
 
-	drm_display_mode_to_videomode(mode, &vm);
+	/*
+	 * The DPHY PLL has quite a coarsely grained clock rate options. See
+	 * what hsclk rate we can achieve based on the pixel clock, convert it
+	 * back to pixel clock, set that to the adjusted_mode->clock. This is
+	 * all in hopes that the CRTC will be able to provide us the requested
+	 * clock, as otherwise the DPI and DSI clocks will be out of sync.
+	 */
+
+	pclk = cdns_dsi_round_pclk(dsi, mode->clock * 1000);
+	if (pclk < 0)
+		return (int)pclk;
+
+	adjusted_crtc_mode->clock = pclk / 1000;
+
+	drm_display_mode_to_videomode(adjusted_crtc_mode, &vm);
 
 	return cdns_dsi_check_conf(dsi, &vm, dsi_cfg);
 }

-- 
2.43.0


