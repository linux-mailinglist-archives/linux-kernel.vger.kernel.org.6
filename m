Return-Path: <linux-kernel+bounces-225647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFE1913340
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 13:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39232284AC4
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 11:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62219152503;
	Sat, 22 Jun 2024 11:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BeHbcD0B"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B50D15749B
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 11:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719054614; cv=none; b=KnW52Mp5r2nWnBvsWSo7lCNrhFLz7YgV4YZ6pyzi5jXr+DFf6ZT+e0HE7F/OjDAJAhgZE4RIgnGLT8BWqMUABJHw6kQ8aW1wFuKVC4gY91MSsshiuycYPlpdJflDpvmKKHV3o7wh2lIuKnkS1cDcM3YIMIkoqLZK++rkGyeFJz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719054614; c=relaxed/simple;
	bh=CKpcsh7XQQKtxwbT/CEg6fEtliHWmKAW/zDuaMCyHMQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Me0EAD7sHZ+vRTSbFN0DsasNZt+mbQvL46C+CbP1x27YXV3mLoTMrlZEIVYjkH+5tAPXNtsWk0lty4SLMhsTUCTqaxVdT2Wq3TQRq6RU4ZDg+Pi+q40mi0lW+Po/CwWARDqTE6MHvH+EzY7prxPrwaSb7yind8QPdtPHdHxDVZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BeHbcD0B; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45MB9fca009935;
	Sat, 22 Jun 2024 06:09:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1719054581;
	bh=auRAY/2opSSmXw0e6TrhwqHJ0gLawrSaGDO7eL3toV0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=BeHbcD0BcRVXIaBNubmJEarChxKGqQ61w8UJFs8PsKhPQ9u636NoZbOhP1kYbCKJo
	 LOnNPiEjeKhB3LWkiBzpigREHK9HXhgm8hCef+TXopLJFO3EmWOiQOf0tYPxpXuvH5
	 G7bDOwjiRBmVrQYBExpqy2benRsjrmWw1J1DxpMc=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45MB9fgZ000445
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 22 Jun 2024 06:09:41 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 22
 Jun 2024 06:09:41 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 22 Jun 2024 06:09:40 -0500
Received: from localhost (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45MB9eNh118746;
	Sat, 22 Jun 2024 06:09:40 -0500
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
Subject: [PATCH v4 07/11] drm/bridge: cdns-dsi: Reset the DCS write FIFO
Date: Sat, 22 Jun 2024 16:39:25 +0530
Message-ID: <20240622110929.3115714-8-a-bhatia1@ti.com>
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

If any normal DCS write command has already been transmitted prior to
transmitting any Zero-Parameter DCS command, then it is necessary to
clear the TX FIFO by resetting it. Otherwise, the FIFO points to another
location, and the DCS command transmits unnecessary data causing the
panel to not work[0].

Allow the DCS Write FIFO in the cdns-dsi controller to reset as a rule,
before any DCS packet is transmitted to the DSI peripheral.

[0]: Section 12.6.5.7.5.2: "Command Mode Settings" in TDA4VM Technical
     Reference Manual: https://www.ti.com/lit/zip/spruil1

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 126e4bccd868..cad0c1478ef0 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -1018,6 +1018,9 @@ static ssize_t cdns_dsi_transfer(struct mipi_dsi_host *host,
 
 	cdns_dsi_init_link(dsi);
 
+	/* Reset the DCS Write FIFO */
+	writel(0x00, dsi->regs + DIRECT_CMD_FIFO_RST);
+
 	ret = mipi_dsi_create_packet(&packet, msg);
 	if (ret)
 		goto out;
-- 
2.34.1


