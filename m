Return-Path: <linux-kernel+bounces-217156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B08B190AC41
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A38201C22E9E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABD4194A64;
	Mon, 17 Jun 2024 10:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Lk2I81kP"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2F2288BD
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718621629; cv=none; b=Fa0tGjGJP7YKbMhlaw5KZ9Jz423skM+nNznYTALR/aV3KLrukumr0QLO5cJCXsj9BxWxWfqnp0P57etkV8A8X2ZUobzrc/4nTUUhAHPkb5Rt9sEBA3fiHMSiuhc2qXpRJG7n0DTDwK4JIA+avkteDHbXLZA+BdJmxC2GzOfg4no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718621629; c=relaxed/simple;
	bh=CbO6XmQZzbFQ2J8qCmc7e+88XS2vb7+xpkH/ear6mHM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vsn2NhPfTkq/rAvS5H0L3ymdK62v5Z3xIVjxi25AHZo8TliBFlFgN7/jdmB8efrOKmhdwyBecebMHqEdE5SFG/fnt791o5V+6lF8gqjnHeg8hr8PAfDxToVLZmb4rgEUV+2oJ4nJAuBUFR+1qvzy8A2edra9IeOgZe7R6GhSxJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Lk2I81kP; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45HArMCQ061400;
	Mon, 17 Jun 2024 05:53:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718621602;
	bh=1KYYm54tymbTNJp06YFH1DJi8RZj+jpPyPwKIKxm3dU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Lk2I81kPobYFyCf0wGEMk1b0ccYIqdUbHMZCKp0uHpWQ1M3wp4w0PRbrDItAzvAXw
	 tgtmfPMG9v1+Fb+DRmIjsT1ulM0C/xg66wgN2xiTXtTr5n0dlw45YD7k+zPycNxr32
	 JQaFbP2MY1MUOr6GRFFa1UCGI87uk43PPUvYZLkY=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45HArM8O055905
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Jun 2024 05:53:22 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 17
 Jun 2024 05:53:21 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 17 Jun 2024 05:53:21 -0500
Received: from localhost (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45HArLXH106126;
	Mon, 17 Jun 2024 05:53:21 -0500
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
Subject: [PATCH v3 06/10] drm/bridge: cdns-dsi: Reset the DCS write FIFO
Date: Mon, 17 Jun 2024 16:23:07 +0530
Message-ID: <20240617105311.1587489-7-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617105311.1587489-1-a-bhatia1@ti.com>
References: <20240617105311.1587489-1-a-bhatia1@ti.com>
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

The DCS FIFO reset is optional. Not all panels require it. But at
least one of the DSI based panel that uses Ilitek ILI9881C (DSI to DPI
bridge) doesn't work with without this reset.

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


