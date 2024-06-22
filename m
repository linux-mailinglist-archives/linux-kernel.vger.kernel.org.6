Return-Path: <linux-kernel+bounces-225642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D611D91333B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 13:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05D051C215F8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 11:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58AAC155741;
	Sat, 22 Jun 2024 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T0REkIIs"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0116114B942
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719054610; cv=none; b=ZNXsLhBkGntXoIzgXI+m7y3WLMSeP0XqyJ7nF5YJLUIytk8mHqEUKY7V1SRCXEgttqCnpWYKm+9ZoVJho+MPdxd4D+K4ZWegY+BoWlF95hujBIWLW1SXNUdN2QoWLfyyHBVnqhepHHyQB8htVH4uvp9//v0z8GYUIFbYedKcG8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719054610; c=relaxed/simple;
	bh=Cxjc7IPKZ1Wt7qVn/n+y56BfhMGgxJQEhP6jLcA/XLU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KsbAArgRKHfwBNqWPr0ki3XHMS4Hhm7u7/p7Sy9sHDjAV9RVmUO5hm4lKu2BxS6YMvPorWWW3ZdxlNYD2CqquccBn3GGzPxNVDXt7E27WuTam/QvrIg0ZZ3pdHqIyArlBALnrtf/tBEA2iYIV82QhUzgFD7Bui5JLjK1RPxBSic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=T0REkIIs; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45MB9dwR033206;
	Sat, 22 Jun 2024 06:09:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719054579;
	bh=35gLG1NjP7yJlGkS1fIGjCceOdPnAm7+lMuzOOSnPpM=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=T0REkIIs/Ga2pDD9opqFVBH0dA8RiI1WFAADZ3LYkU0LjzXVssEgoIbR+xpzXo7fX
	 weHvpBkCvB+dnihhthTDRYD93EFP1bkrPmhD06TJBM1RD0C0pJeb1FP/PVt9ZiXDxg
	 t6PQsQUceSuME2XGmaErydk7VCa7OAxHbEgI15cQ=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45MB9dpa000438
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 22 Jun 2024 06:09:39 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 22
 Jun 2024 06:09:39 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 22 Jun 2024 06:09:39 -0500
Received: from localhost (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45MB9cdZ023189;
	Sat, 22 Jun 2024 06:09:39 -0500
From: Aradhya Bhatia <a-bhatia1@ti.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman
	<jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>, Jyri Sarha <jyri.sarha@iki.fi>,
        Thomas Zimmermann
	<tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Daniel Vetter
	<daniel@ffwll.ch>
CC: DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Kernel List
	<linux-kernel@vger.kernel.org>,
        Dominik Haller <d.haller@phytec.de>, Sam
 Ravnborg <sam@ravnborg.org>,
        Thierry Reding <treding@nvidia.com>,
        Kieran
 Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Nishanth Menon
	<nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Praneeth Bajjuri
	<praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Devarsh Thakkar
	<devarsht@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>, Jai Luthra
	<j-luthra@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH v4 06/11] drm/bridge: cdns-dsi: Wait for Clk and Data Lanes to be ready
Date: Sat, 22 Jun 2024 16:39:24 +0530
Message-ID: <20240622110929.3115714-7-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240622110929.3115714-1-a-bhatia1@ti.com>
References: <20240622110929.3115714-1-a-bhatia1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Once the DSI Link and DSI Phy are initialized, the code needs to wait
for Clk and Data Lanes to be ready, before continuing configuration.
This is in accordance with the DSI Start-up procedure, found in the
Technical Reference Manual of Texas Instrument's J721E SoC[0] which
houses this DSI TX controller.

If the previous bridge (or crtc/encoder) are configured pre-maturely,
the input signal FIFO gets corrupt. This introduces a color-shift on the
display.

Allow the driver to wait for the clk and data lanes to get ready during
DSI enable.

[0]: See section 12.6.5.7.3 "Start-up Procedure" in J721E SoC TRM
     TRM Link: http://www.ti.com/lit/pdf/spruil1

Fixes: e19233955d9e ("drm/bridge: Add Cadence DSI driver")
Tested-by: Dominik Haller <d.haller@phytec.de>
Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 426f77092341..126e4bccd868 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -764,7 +764,7 @@ static void cdns_dsi_bridge_enable(struct drm_bridge *bridge)
 	struct phy_configure_opts_mipi_dphy *phy_cfg = &output->phy_opts.mipi_dphy;
 	unsigned long tx_byte_period;
 	struct cdns_dsi_cfg dsi_cfg;
-	u32 tmp, reg_wakeup, div;
+	u32 tmp, reg_wakeup, div, status;
 	int nlanes;
 
 	if (WARN_ON(pm_runtime_get_sync(dsi->base.dev) < 0))
@@ -781,6 +781,17 @@ static void cdns_dsi_bridge_enable(struct drm_bridge *bridge)
 	cdns_dsi_init_link(dsi);
 	cdns_dsi_hs_init(dsi);
 
+	/*
+	 * Now that the DSI Link and DSI Phy are initialized,
+	 * wait for the CLK and Data Lanes to be ready.
+	 */
+	tmp = CLK_LANE_RDY;
+	for (int i = 0; i < nlanes; i++)
+		tmp |= DATA_LANE_RDY(i);
+
+	WARN_ON_ONCE(readl_poll_timeout(dsi->regs + MCTL_MAIN_STS, status,
+					status & tmp, 100, 0));
+
 	writel(HBP_LEN(dsi_cfg.hbp) | HSA_LEN(dsi_cfg.hsa),
 	       dsi->regs + VID_HSIZE1);
 	writel(HFP_LEN(dsi_cfg.hfp) | HACT_LEN(dsi_cfg.hact),
-- 
2.34.1


