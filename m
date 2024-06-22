Return-Path: <linux-kernel+bounces-225650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 179A8913344
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 13:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E5E4B23C2A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 11:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB0416EBE1;
	Sat, 22 Jun 2024 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OCoWci0e"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB01F2119
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719054626; cv=none; b=dUOHWh2Hyk/4w+3LEQqiEo2Jwyh8sP0Wqg5wYZ0BlL9Lg2o3vhUwpFbWnCKGzG3ejkUFTVGAx/0voGHJu40NyoUoAuqDomt5bSifxScblyJTF5ZlU7kMNir5S7v6m9C5Uo89jLgmtgLID7WX7us7oAMQocfbTX0ljQFjCukR4c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719054626; c=relaxed/simple;
	bh=6rENcTSmGmEXSupvbVaeL5sPbPyfN+nJ31qoig5Cj/M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u5JBnBHOHuIl8ToCUSKUYBn76dyIDpCQ8xF3qzaKdTqRFKq/6aL5DH8qR7fsB9PDvGWQjq3gk+O5waDZhjZ3KbiAHEb/20RUaluwYnY2LyvtQFxLjCBIsXQkNZERxRgLza54hN0Kw7hguLOOhpVPTh43jRuvzwNosB6VyQj5or4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OCoWci0e; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45MB9a1R028067;
	Sat, 22 Jun 2024 06:09:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719054576;
	bh=gMgcDFL8G0Ohc9Yh3qncz4RpaAMQ1qLRcafb0CPf0DI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=OCoWci0eRd16V6a4VyTfBUsCBLpeQQ9fnh/Fxy5BCAU0QeIdpmfp779SXlomrr6I3
	 yte+oDZHbxxjMIJmajPtywJOfHXqQALFISLwpp6MAe9GbUsJCbBAs9lUuUWu1TYR9v
	 QF5LqBT3JDqnaBuJcW/3MD1iyAC5i8F9CyyeCY/I=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45MB9afq000396
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 22 Jun 2024 06:09:36 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 22
 Jun 2024 06:09:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 22 Jun 2024 06:09:36 -0500
Received: from localhost (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45MB9ZIL023153;
	Sat, 22 Jun 2024 06:09:36 -0500
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
Subject: [PATCH v4 04/11] drm/bridge: cdns-dsi: Fix the link and phy init order
Date: Sat, 22 Jun 2024 16:39:22 +0530
Message-ID: <20240622110929.3115714-5-a-bhatia1@ti.com>
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

The order of init of DSI link and DSI phy is wrong. The DSI link needs
to be configured before the DSI phy is getting configured. Otherwise,
the D-Phy is unable to lock in on the incoming PLL Reference clock[0].

Fix the order of inits.

[0]: See section 12.6.5.7.3 "Start-up Procedure" in J721E SoC TRM
     TRM Link: http://www.ti.com/lit/pdf/spruil1

Fixes: fced5a364dee ("drm/bridge: cdns: Convert to phy framework")
Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index d89c32bae2b9..03a5af52ec0b 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -778,8 +778,8 @@ static void cdns_dsi_bridge_enable(struct drm_bridge *bridge)
 
 	WARN_ON_ONCE(cdns_dsi_check_conf(dsi, mode, &dsi_cfg, false));
 
-	cdns_dsi_hs_init(dsi);
 	cdns_dsi_init_link(dsi);
+	cdns_dsi_hs_init(dsi);
 
 	writel(HBP_LEN(dsi_cfg.hbp) | HSA_LEN(dsi_cfg.hsa),
 	       dsi->regs + VID_HSIZE1);
-- 
2.34.1


