Return-Path: <linux-kernel+bounces-225640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56582913334
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 13:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78E4C1C21715
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 11:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F78B154C03;
	Sat, 22 Jun 2024 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FN0IysjT"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4D114D299
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 11:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719054609; cv=none; b=N/UAtN4iaJzBH1Bzd+yJ1lpKqBjn1pQhAlH2r3JfMVO/9TrMcAkHnKShVRfGkAnoU3mAw6XyUOq9JjwD80ej9eDQqBB8sJmUwxnNYnJF0D9I+M9jLxiOxItdftk4vg0KsB3IywDs5SgKemMIScvauZ/Is14sQ8EYkWab8Vdvym8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719054609; c=relaxed/simple;
	bh=MF5GdQjzxMs2LxmmRqlz3iseriH6ILiP75ftPWM8dA4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cbt2BSY9AMs62gkA61You6XiWYbWgpQoakt4tPbZxquGBnZMcO1nJBh1Fx991bMrNCLU6BaGNDXHMSeDkKGc12GPL44J/WNFbRTRR69fkxYydEN/fan6wiFw30+BBKNC7XknVX2Jex3VyvTM1ai1NlhN1qR7PHS2bM20FZdSvhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FN0IysjT; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45MB9Ze9033198;
	Sat, 22 Jun 2024 06:09:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719054575;
	bh=chZ/pwBP4y9AUyfUU+k1msFxrL2uMwswWonPTvJY9A4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=FN0IysjTQNcMK7MwAckdNcEFUJLba6JAbgPcKfJy+zhUMh3ucOi/EtxCTMA3qX9gA
	 3ek6Lmz9TsxFsJe0KM4V/pmco7E6wPi2MaK2vLVkVHm7Y4I1f6r5R1dmExeN4kujhQ
	 A0T031/vnI0W8t5jlpp/w4nlCa5lgOq7j6bNxkOY=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45MB9ZrA112625
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 22 Jun 2024 06:09:35 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 22
 Jun 2024 06:09:34 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 22 Jun 2024 06:09:34 -0500
Received: from localhost (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45MB9YdW023126;
	Sat, 22 Jun 2024 06:09:34 -0500
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
Subject: [PATCH v4 03/11] drm/bridge: cdns-dsi: Fix Phy _init() and _exit()
Date: Sat, 22 Jun 2024 16:39:21 +0530
Message-ID: <20240622110929.3115714-4-a-bhatia1@ti.com>
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

Initialize the Phy during the cdns-dsi _resume(), and de-initialize it
during the _suspend().

Also power-off the Phy from bridge_disable.

Fixes: fced5a364dee ("drm/bridge: cdns: Convert to phy framework")
Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 5159c3f0853e..d89c32bae2b9 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -672,6 +672,10 @@ static void cdns_dsi_bridge_disable(struct drm_bridge *bridge)
 	if (dsi->platform_ops && dsi->platform_ops->disable)
 		dsi->platform_ops->disable(dsi);
 
+	phy_power_off(dsi->dphy);
+	dsi->link_initialized = false;
+	dsi->phy_initialized = false;
+
 	pm_runtime_put(dsi->base.dev);
 }
 
@@ -698,7 +702,6 @@ static void cdns_dsi_hs_init(struct cdns_dsi *dsi)
 	       DPHY_CMN_PDN | DPHY_PLL_PDN,
 	       dsi->regs + MCTL_DPHY_CFG0);
 
-	phy_init(dsi->dphy);
 	phy_set_mode(dsi->dphy, PHY_MODE_MIPI_DPHY);
 	phy_configure(dsi->dphy, &output->phy_opts);
 	phy_power_on(dsi->dphy);
@@ -1120,6 +1123,8 @@ static int __maybe_unused cdns_dsi_resume(struct device *dev)
 	clk_prepare_enable(dsi->dsi_p_clk);
 	clk_prepare_enable(dsi->dsi_sys_clk);
 
+	phy_init(dsi->dphy);
+
 	return 0;
 }
 
@@ -1127,10 +1132,11 @@ static int __maybe_unused cdns_dsi_suspend(struct device *dev)
 {
 	struct cdns_dsi *dsi = dev_get_drvdata(dev);
 
+	phy_exit(dsi->dphy);
+
 	clk_disable_unprepare(dsi->dsi_sys_clk);
 	clk_disable_unprepare(dsi->dsi_p_clk);
 	reset_control_assert(dsi->dsi_p_rst);
-	dsi->link_initialized = false;
 	return 0;
 }
 
-- 
2.34.1


