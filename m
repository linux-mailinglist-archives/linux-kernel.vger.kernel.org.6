Return-Path: <linux-kernel+bounces-195193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA618D48B6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 11:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7342C284594
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 09:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD181598E2;
	Thu, 30 May 2024 09:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bBc7W6pf"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED8418396C
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717061812; cv=none; b=jj20xR+hf/FNXzvw5gWTnhlBlvsD8qqHdkYJLU23ONgVAij5jiR2dsHMv38h391zTxZgwLFD3sMaUtvP7qh8D147lWeBIHtI4kNGRfm3JKmcE0DLPtK3lxuos6wgO7MookbnvohUOydRZL1p5YCPPjKldZWX4tTJWaHMczFvDKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717061812; c=relaxed/simple;
	bh=q72P490XSvjhQqt0/MTc0V24jaUtaSI3r2eQjIKRVo0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BnW5CpZEemX/OshmnMQYrrVh8fGu8+1uQlDc6F1+5wdIWMmwfZcy1ZKxUYzyjBUeHnGILzwYGoTzUXE7zz5A560R3yNncf2gPKWhQJVY1pv6WnYi0JlN/eoa57wCNslGm5VIG/l8IxQP2bvABG2oLM2qByqumWTpaK7sVdMT9Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bBc7W6pf; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44U9aSMb128511;
	Thu, 30 May 2024 04:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717061788;
	bh=o5wG54oHAcp8t7FU4H5j+XKlq4EeECM+G2XW18HGS7I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=bBc7W6pf9IWPDYomeMsFhwqjeRCOOLESv4pEnBtGFqtKDyMPT+7i/1xJqgTARUY4b
	 9i+NROn03wtaT4qR5mtOZ3JOyGceCDUf8rs1z0+u1iLVRYWGey1CoTG+YFsqDlCvnQ
	 qBpOwlke25sRgwwfyi2PMkl/gvbySsiXXBVJJs3s=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44U9aSeG055280
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 30 May 2024 04:36:28 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 May 2024 04:36:28 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 May 2024 04:36:27 -0500
Received: from localhost (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44U9aR91086311;
	Thu, 30 May 2024 04:36:27 -0500
From: Aradhya Bhatia <a-bhatia1@ti.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Andrzej Hajda
	<andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert
 Foss <rfoss@kernel.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej
 Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, Jyri
 Sarha <jyri.sarha@iki.fi>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Kernel List
	<linux-kernel@vger.kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>, Thierry
 Reding <treding@nvidia.com>,
        Kieran Bingham
	<kieran.bingham+renesas@ideasonboard.com>,
        Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar <u-kumar1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh
 Choudhary <j-choudhary@ti.com>, Jai Luthra <j-luthra@ti.com>,
        Aradhya Bhatia
	<a-bhatia1@ti.com>
Subject: [PATCH v2 3/9] drm/bridge: cdns-dsi: Fix the link and phy init order
Date: Thu, 30 May 2024 15:06:15 +0530
Message-ID: <20240530093621.1925863-4-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240530093621.1925863-1-a-bhatia1@ti.com>
References: <20240530093621.1925863-1-a-bhatia1@ti.com>
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
index 42565e253b2d..371a3453970c 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -775,8 +775,8 @@ static void cdns_dsi_bridge_enable(struct drm_bridge *bridge)
 
 	WARN_ON_ONCE(cdns_dsi_check_conf(dsi, mode, &dsi_cfg, false));
 
-	cdns_dsi_hs_init(dsi);
 	cdns_dsi_init_link(dsi);
+	cdns_dsi_hs_init(dsi);
 
 	writel(HBP_LEN(dsi_cfg.hbp) | HSA_LEN(dsi_cfg.hsa),
 	       dsi->regs + VID_HSIZE1);
-- 
2.34.1


