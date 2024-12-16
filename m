Return-Path: <linux-kernel+bounces-447672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B40BB9F35E4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 17:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F63188A9C7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD451205E17;
	Mon, 16 Dec 2024 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JsVM0aIc"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7224C1494CF;
	Mon, 16 Dec 2024 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734366115; cv=none; b=k4A7Sv2sssRg33ggYqe9kMemEZhCOK9VKB/H+PXDUiP6gYFa2DUPraYfbbV0fBboSewY1Lg38qCDZzWPIEK8OTgUMOIaGEtC/ic1jOJPkCubqHL+Xn/zr6Rc64p7KYYpsRoO3urnYizlVa/YCgB+jPGo453/ozPFCrP37TvRP6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734366115; c=relaxed/simple;
	bh=3FlCXp4lxP2Gj55aIenXQLh+dtggLm/4wu14wcnGp9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jp+lIkVN5MAL41JO7m99RrsQtOKxyT88Q7DNx7V3Nv+8zcqY/hDBK46gkF0Iv9ZEcouoBnSsuGi6Wkl+SYqOzRQoSH3GIhNuO0D7xjmnuWBzmcIw0UB5N+zZUbGlOh5bzIJpLcdphrWAhPw1RkQRdycPTksaTFq0DB+u2YnXqhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JsVM0aIc; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 31C2C60004;
	Mon, 16 Dec 2024 16:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734366104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HP3KIxC0BzAJe0M2V69r1CiMwNsA30W8P/3ypWBRsIE=;
	b=JsVM0aIcvnx8adHzky5JwSnplWf0YxFoE71Y7kQniaqnRXh3cl6+dkeMtXQFpeWeZ1cQR3
	MJI0Vxr22cB5CYs4LCOS50XF8W9hDKINfduJ2DoN+QwUsfqXlksRGuAU9y0JLecNZEszqL
	JPoeWiAAZ7wniXP2Aq7jqNGD0mEbVysIuyCNpGDsol2ScfQj/N37X1Bkp5dUVtEN5JZ+r/
	WA0n96vm+KF8dTv6nbfESVwTJPVHFlRrv3Iri0QCg8sXbpoJkbj19cMrnzdGwgohIqgFOG
	I06jr+DUFITZetF1uEM2vIITdgDINhGDc3m6L+2yPzvRRE9+d10/olxajVWe8A==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Mon, 16 Dec 2024 17:21:35 +0100
Subject: [PATCH v2 2/2] drm/panel: simple: Add Tianma TM070JDHG34-00 panel
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-tianma_tm070jdhg34-v2-2-0b319a0bac39@bootlin.com>
References: <20241216-tianma_tm070jdhg34-v2-0-0b319a0bac39@bootlin.com>
In-Reply-To: <20241216-tianma_tm070jdhg34-v2-0-0b319a0bac39@bootlin.com>
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---

Changes in v2: none
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


