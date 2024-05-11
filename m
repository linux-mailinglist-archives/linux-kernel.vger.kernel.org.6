Return-Path: <linux-kernel+bounces-176610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE968C3226
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 17:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16D4FB216CF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 15:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500F65A0F8;
	Sat, 11 May 2024 15:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="t0l2IUfB"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A1356459
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 15:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715441500; cv=none; b=TP7UW3AAuguE5CgU8d/wa2UCGYxSWXqogTXRbShOpzUnB2le85D5Ph8jR3OByLIA0xj7V4eoOYu/hzXge0o2fp64jZ6ycNmgGL+AXyy4kG9wM7A6ZYn0UnBl4DqEve/RH26fb7PkhalRXb+MuikmeB4if0O+XZReetU/4fNX4A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715441500; c=relaxed/simple;
	bh=ANNJ+TVvg4TDhFapBZYAsag/dWLIk8v766MtEkXddO0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RqUT+e6CYQBxjwDC3Hx7DQpq0KR6hJUtfW0v+Ga+DTR5dVGt5rMtPO3VJmUVXAidCrJLqZyNYbGr8r49f+gxRqaJhT9DZNizW6FCw9qD4+mpv7zvGIygUgPiX3fEimcUeRAQh5m9qm1Y6mPclwDHdUdfycQibx5jN1T/IW+B/lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=t0l2IUfB; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44BFUxEG005131;
	Sat, 11 May 2024 10:30:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715441459;
	bh=iqKPnZHcrXnOzmcUUtsWU9g7YNd8v7CH9OIa+I/fqO0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=t0l2IUfB4CpVkig3jZHV8cfHL2jgW6bUN07feBBjyPeSnPJUQdNBLZ3icOGybYY6q
	 G2OqSqHRvGvIZmK2ATRC0QYlFTKFuXHRFNvgoiMnX3MuU/3T2W81AEDmtN+cS6MaEg
	 /cWhH0Kmn96ATweQ2eUaPKELmROl2CcCIh4OeHwg=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44BFUxS0098501
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 11 May 2024 10:30:59 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 11
 May 2024 10:30:58 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 11 May 2024 10:30:58 -0500
Received: from localhost (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44BFUw2S043270;
	Sat, 11 May 2024 10:30:58 -0500
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
        Boris Brezillon
	<boris.brezillon@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar
	<u-kumar1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jayesh Choudhary
	<j-choudhary@ti.com>, Jai Luthra <j-luthra@ti.com>,
        Aradhya Bhatia
	<a-bhatia1@ti.com>
Subject: [PATCH 4/7] drm/bridge: cdns-dsi: Reset the DCS write FIFO
Date: Sat, 11 May 2024 21:00:48 +0530
Message-ID: <20240511153051.1355825-5-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240511153051.1355825-1-a-bhatia1@ti.com>
References: <20240511153051.1355825-1-a-bhatia1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Allow the DCS Write FIFO in the cdns-dsi controller to reset before any
DCS packet is transmitted to the DSI sink device.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index 05d2f4cc50da..87fdd07ca0bc 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -1037,6 +1037,9 @@ static ssize_t cdns_dsi_transfer(struct mipi_dsi_host *host,
 
 	cdns_dsi_init_link(dsi);
 
+	/* Reset the DCS Write FIFO */
+	writel(0x00, dsi->regs + DIRECT_CMD_FIFO_RST);
+
 	ret = mipi_dsi_create_packet(&packet, msg);
 	if (ret)
 		goto out;
-- 
2.34.1


