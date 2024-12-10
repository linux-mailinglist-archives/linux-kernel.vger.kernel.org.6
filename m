Return-Path: <linux-kernel+bounces-440068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3779EB83C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 18:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A55D284B42
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 17:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E9986342;
	Tue, 10 Dec 2024 17:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JODId8yg"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937EB23ED53;
	Tue, 10 Dec 2024 17:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733851707; cv=none; b=fZ7nNpLdW8i67pcdJlmApdOS4WDrBj2ksoSvvV9PYXFYD+bLhQSuE6tbrRBhk7JzW81d2ge4ovtrRNv+y2v2tbr0RYYMwlRdaNCl906r8YR7ucUiWiJhfCIt/uJrRd4GUik9QLFTuqTQsvjrTB0feUoqk2uOFOZVIe2ULm74eL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733851707; c=relaxed/simple;
	bh=IOTwGN12204EbV/R27nEFzhkz6gEAdVugRI9kU6OdK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=khaOr7j1s1SN8QCA8H48DRYchW2Owf645qUy3J0Z0TmJ4l+NHQjecth6mqtqD3NrYolzaS2LDYrazozKy47lsAOjL16/TRfuRtSVPXYmV0wiqkmMHPDuU1+U9MoPnkRskV1KPkLARaCcHCvG4w+2hgzzGT/ojfL9T2ZvI2NvFHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JODId8yg; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 97D481C0008;
	Tue, 10 Dec 2024 17:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733851703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sppw2oR439agUMdzcxsUIW3PHbZCDRpDXz1PWFEDZqg=;
	b=JODId8ygzBFYH024S/pNXn2rUaT8mzt5tAybIlLQbhqr1gB22kOZzjiWpPWZVFQpqzsj38
	DbzZfLvlN9hpDyxtIEx5gShUKCbVTnm+gXpkfL+pZY0gIlyA3PilqwSKnMsX/BFAAUsUng
	AIUikuKqJ/wWvI3m1Y2032Vctsr8+MEXEJ/hH6exVnnesJQy2Xe5myx+u88eetEZMTx8nD
	PKXFN8usE6kIdelNqSHJsYz3KomKVxxBwWjr0CRGte8L5P5mamKXKCeETdJ4QL81r5To/l
	JN2SK+8ZkRveONqQxjagoT09OuNc+e+xRMSMW5/UrGk4fHligNUVoVPFsIo7ng==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Tue, 10 Dec 2024 18:28:04 +0100
Subject: [PATCH 2/2] drm/panel: simple: Add Tianma TM070JDHG34-00 panel
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-tianma_tm070jdhg34-v1-2-9fb7fe6b6cf0@bootlin.com>
References: <20241210-tianma_tm070jdhg34-v1-0-9fb7fe6b6cf0@bootlin.com>
In-Reply-To: <20241210-tianma_tm070jdhg34-v1-0-9fb7fe6b6cf0@bootlin.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-Sasl: luca.ceresoli@bootlin.com

Add Tianma TM070JDHG34-00 7.0" 1280x800 LVDS RGB TFT LCD panel.

Panel info and datasheet: https://fortec.us/products/tm070jdhg34-00/

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 42 ++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 1562f122724137dec37eb11443eafc896ef2f2e8..b3c931a4e46a2568b3678d664f11b189873fa1e2 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -4286,6 +4286,45 @@ static const struct panel_desc tianma_tm070jvhg33 = {
 	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
 };
 
+/*
+ * The datasheet computes total blanking as back porch + front porch, not
+ * including sync pulse width. This is for both H and V. To make the total
+ * blanking and period correct, subtract the pulse width from the front
+ * porch.
+ *
+ * This works well for the Min and Typ values, but for Max values the sync
+ * pulse width is higher than back porch + front porch, so work around that
+ * by reducing the Max sync length value to 1 and then treating the Max
+ * porches as in the Min and Typ cases.
+ *
+ * Exact datasheet values are added as a comment where they differ from the
+ * ones implemented for the above reason.
+ */
+static const struct display_timing tianma_tm070jdhg34_00_timing = {
+	.pixelclock = { 68400000, 71900000, 78100000 },
+	.hactive = { 1280, 1280, 1280 },
+	.hfront_porch = { 130, 138, 158 }, /* 131, 139, 159 */
+	.hback_porch = { 5, 5, 5 },
+	.hsync_len = { 1, 1, 1 }, /* 1, 1, 256 */
+	.vactive = { 800, 800, 800 },
+	.vfront_porch = { 2, 39, 98 }, /* 3, 40, 99 */
+	.vback_porch = { 2, 2, 2 },
+	.vsync_len = { 1, 1, 1 }, /* 1, 1, 128 */
+	.flags = DISPLAY_FLAGS_DE_HIGH,
+};
+
+static const struct panel_desc tianma_tm070jdhg34_00 = {
+	.timings = &tianma_tm070jdhg34_00_timing,
+	.num_timings = 1,
+	.bpc = 8,
+	.size = {
+		.width = 150, /* 149.76 */
+		.height = 94, /* 93.60 */
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct display_timing tianma_tm070rvhg71_timing = {
 	.pixelclock = { 27700000, 29200000, 39600000 },
 	.hactive = { 800, 800, 800 },
@@ -5028,6 +5067,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "tianma,tm070jdhg30",
 		.data = &tianma_tm070jdhg30,
+	}, {
+		.compatible = "tianma,tm070jdhg34-00",
+		.data = &tianma_tm070jdhg34_00,
 	}, {
 		.compatible = "tianma,tm070jvhg33",
 		.data = &tianma_tm070jvhg33,

-- 
2.34.1


