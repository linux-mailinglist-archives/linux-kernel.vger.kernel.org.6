Return-Path: <linux-kernel+bounces-217162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 953DF90AC4F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 12:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C76D1F2733B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 10:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F53719599E;
	Mon, 17 Jun 2024 10:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O3nXBhtJ"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5681957E5
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 10:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718621637; cv=none; b=GzQM7rLBNJqDjFCTu3r7pONJZ+4v+b4XxBLlIjK/oZJbpgq8D/583VDCytvtEUHUQFsn9toQmAMc8HP1RFefvMAVAWHsQp5XZqQ3mntnHSoVLYObBmRDsutoq3QMBFv1ejwOqiikTI58K4TbpxiHXb1r7XWZ28dEWuc98fBIMdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718621637; c=relaxed/simple;
	bh=+1etStwj2LnG8btWl7MUHbuboqM2MbJUjcUPCUuD99U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LTbKjQstd7dyNuKoLpXPRFD2cYI0Nta44BCKTYnCQnZhBEU63IRmUz7Gzh1TQ1rx7JkK8iWzXmhYWMGy248ZR2dUobSSEIE1P5Tgm4jD1dvFuvAsrRL37WIOxgWhz+Ah8p1aIjW0l0KdsUUQuSKmABtbloxcyFYj5Ef3AcvperA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=O3nXBhtJ; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45HArNLi082690;
	Mon, 17 Jun 2024 05:53:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1718621603;
	bh=dc7TxmFPCYZ79Oy7PYGSPwywwhuj2Co/uOrhToLtDo4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=O3nXBhtJ/Az41LRq1iGoNQqKUfkWQV/8DSgxhc/2XM7yXL+EN45XbZs/CpeHxTH91
	 krrbkD82t7cEENIeVYUrqyxxMyjB+ZgKWaSqjwF7EXn99umIKdphPg24CKAVIr3DNj
	 eoppglxIacs7KCa4UP+0sufB852CJ5o7nSR2Bt6U=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45HArN0S065314
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 17 Jun 2024 05:53:23 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 17
 Jun 2024 05:53:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 17 Jun 2024 05:53:23 -0500
Received: from localhost (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45HArMAL106160;
	Mon, 17 Jun 2024 05:53:23 -0500
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
Subject: [PATCH v3 07/10] drm/mipi-dsi: Add helper to find input format
Date: Mon, 17 Jun 2024 16:23:08 +0530
Message-ID: <20240617105311.1587489-8-a-bhatia1@ti.com>
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

Add a helper API that can be used by the DSI hosts to find the required
input bus format for the given output dsi pixel format.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 drivers/gpu/drm/drm_mipi_dsi.c | 37 ++++++++++++++++++++++++++++++++++
 include/drm/drm_mipi_dsi.h     |  1 +
 2 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/drm_mipi_dsi.c b/drivers/gpu/drm/drm_mipi_dsi.c
index 795001bb7ff1..70ca6678fec2 100644
--- a/drivers/gpu/drm/drm_mipi_dsi.c
+++ b/drivers/gpu/drm/drm_mipi_dsi.c
@@ -36,6 +36,8 @@
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_print.h>
 
+#include <linux/media-bus-format.h>
+
 #include <video/mipi_display.h>
 
 /**
@@ -810,6 +812,41 @@ ssize_t mipi_dsi_generic_read(struct mipi_dsi_device *dsi, const void *params,
 }
 EXPORT_SYMBOL(mipi_dsi_generic_read);
 
+/**
+ * drm_mipi_dsi_get_input_bus_fmt() - Get the required MEDIA_BUS_FMT_* based
+ *				      input pixel format for a given DSI output
+ *				      pixel format
+ * @dsi_format: pixel format that a DSI host needs to output
+ *
+ * Various DSI hosts can use this function during their
+ * &drm_bridge_funcs.atomic_get_input_bus_fmts operation to ascertain
+ * the MEDIA_BUS_FMT_* pixel format required as input.
+ *
+ * RETURNS:
+ * a 32-bit MEDIA_BUS_FMT_* value on success or 0 in case of failure.
+ */
+u32 drm_mipi_dsi_get_input_bus_fmt(enum mipi_dsi_pixel_format dsi_format)
+{
+	switch (dsi_format) {
+	case MIPI_DSI_FMT_RGB888:
+		return MEDIA_BUS_FMT_RGB888_1X24;
+
+	case MIPI_DSI_FMT_RGB666:
+		return MEDIA_BUS_FMT_RGB666_1X24_CPADHI;
+
+	case MIPI_DSI_FMT_RGB666_PACKED:
+		return MEDIA_BUS_FMT_RGB666_1X18;
+
+	case MIPI_DSI_FMT_RGB565:
+		return MEDIA_BUS_FMT_RGB565_1X16;
+
+	default:
+		/* Unsupported DSI Format */
+		return 0;
+	}
+}
+EXPORT_SYMBOL(drm_mipi_dsi_get_input_bus_fmt);
+
 /**
  * mipi_dsi_dcs_write_buffer() - transmit a DCS command with payload
  * @dsi: DSI peripheral device
diff --git a/include/drm/drm_mipi_dsi.h b/include/drm/drm_mipi_dsi.h
index 82b1cc434ea3..12ed7f51fe69 100644
--- a/include/drm/drm_mipi_dsi.h
+++ b/include/drm/drm_mipi_dsi.h
@@ -258,6 +258,7 @@ ssize_t mipi_dsi_generic_write(struct mipi_dsi_device *dsi, const void *payload,
 			       size_t size);
 ssize_t mipi_dsi_generic_read(struct mipi_dsi_device *dsi, const void *params,
 			      size_t num_params, void *data, size_t size);
+u32 drm_mipi_dsi_get_input_bus_fmt(enum mipi_dsi_pixel_format dsi_format);
 
 /**
  * enum mipi_dsi_dcs_tear_mode - Tearing Effect Output Line mode
-- 
2.34.1


