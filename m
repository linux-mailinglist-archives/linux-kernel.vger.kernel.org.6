Return-Path: <linux-kernel+bounces-179731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0CD8C6451
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 11:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7DD1F21019
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 09:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9736341B;
	Wed, 15 May 2024 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DkoCiYvF"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824F65CDD0;
	Wed, 15 May 2024 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715766723; cv=none; b=qaE9VOmHQAyefNZFGMNfb0CTPW1Uw0BVmyPxXCl27dMyX+uaiMUqG7DtquXjM3vyAKMAAp/0WfISi6Uv95Soirz1jVPCNsVGP1uPt4fSoSxqXUaOMTkShMVmTp3GMDIhp4vBULU2kIXdckxx9/b+qGKCjEBQB20/X8HWmrLlUa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715766723; c=relaxed/simple;
	bh=FqsP7HuwkMh4tdTQQe70uJSrEuVaCFV4t/iCknOg63o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FrMwqz+T//Ho1m3nUlHmiufhR5U5r5bCuplIKPgsE6Ra6DDlq0BUvlf/y23SckT8erPjOUxAI/W8Aye3inh5Dla9R9oYa8HeT4HGWEpuBFfmPgLl1IFUsgmnj8Puiiy4xeDwwLHYwl3fvqvGuNYCMhIvmfxG60HCRVqpAOLf7ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=DkoCiYvF; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44F9pja9021145;
	Wed, 15 May 2024 04:51:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715766705;
	bh=+Im48V8StjmmVMV/wSC1fpPAJfkvp4PeLDmO6kGm1C0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=DkoCiYvFrBJmSrDmcEjzUgKjr9K3T6j1ni75K7rNFbnWXtNh/JDnEYfBUmakUO6u2
	 foThoTMopqZbs8oHiiCYAAnJESxCyV9JsO3FG5CJkZlmI9TlCvFzi//NtB6Pze2Qtp
	 5WeyzPlJh+kPb9vQ3hKA5Dq0FvJbhGkU5/pXcWxM=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44F9pjVZ121595
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 15 May 2024 04:51:45 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 15
 May 2024 04:51:45 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 15 May 2024 04:51:45 -0500
Received: from localhost (uda0496377.dhcp.ti.com [172.24.227.31])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44F9piRD125507;
	Wed, 15 May 2024 04:51:45 -0500
From: Aradhya Bhatia <a-bhatia1@ti.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Jessica Zhang
	<quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>, David Airlie
	<airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Liu Ying <victor.liu@nxp.com>,
        Thierry Reding
	<thierry.reding@gmail.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Tomi Valkeinen
	<tomi.valkeinen@ideasonboard.com>,
        Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>
CC: DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List
	<devicetree@vger.kernel.org>,
        Linux Kernel List
	<linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>, Udit Kumar
	<u-kumar1@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>, Jai Luthra
	<j-luthra@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH v3 6/6] drm/panel: simple: Add Microtips Technology MF-103HIEB0GA0 panel
Date: Wed, 15 May 2024 15:21:33 +0530
Message-ID: <20240515095133.745492-7-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515095133.745492-1-a-bhatia1@ti.com>
References: <20240515095133.745492-1-a-bhatia1@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add support for Microtips Technology USA MF-103HIEB0GA0 10.25"[0],
1920x720, 8-bit TFT LCD with LVDS interface. Its a Dual-LVDS Panel and
does not support touch.

[0]: Panel Datasheet
https://simplespec.microtipsusa.com/uploads/spec/datasheetFile/2660/13-103HIEB0GA0-S_V1.0_20211206.pdf

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 3a0d8f0ff267..1b0a6b4e034c 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -3084,6 +3084,35 @@ static const struct panel_desc microtips_mf_101hiebcaf0_c = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
+static const struct drm_display_mode microtips_mf_103hieb0ga0_mode = {
+	.clock = 93301,
+	.hdisplay = 1920,
+	.hsync_start = 1920 + 72,
+	.hsync_end = 1920 + 72 + 72,
+	.htotal = 1920 + 72 + 72 + 72,
+	.vdisplay = 720,
+	.vsync_start = 720 + 3,
+	.vsync_end = 720 + 3 + 3,
+	.vtotal = 720 + 3 + 3 + 2,
+};
+
+static const struct panel_desc microtips_mf_103hieb0ga0 = {
+	.modes = &microtips_mf_103hieb0ga0_mode,
+	.bpc = 8,
+	.num_modes = 1,
+	.size = {
+		.width = 244,
+		.height = 92,
+	},
+	.delay = {
+		.prepare = 50,
+		.disable = 50,
+	},
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct drm_display_mode mitsubishi_aa070mc01_mode = {
 	.clock = 30400,
 	.hdisplay = 800,
@@ -4726,6 +4755,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "microtips,mf-101hiebcaf0",
 		.data = &microtips_mf_101hiebcaf0_c,
+	}, {
+		.compatible = "microtips,mf-103hieb0ga0",
+		.data = &microtips_mf_103hieb0ga0,
 	}, {
 		.compatible = "mitsubishi,aa070mc01-ca1",
 		.data = &mitsubishi_aa070mc01,
-- 
2.34.1


