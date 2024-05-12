Return-Path: <linux-kernel+bounces-176920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDEF8C370A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 17:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B37E51F2163F
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 15:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636B547A76;
	Sun, 12 May 2024 15:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFGSdjJq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAC83FB8B;
	Sun, 12 May 2024 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715527547; cv=none; b=EYp1wo6icF7tdNVZcmV1pAgUVivzlHUMKdvIAs+VN/CpfImq8Xdk2ahp9XPjyQRb0uuy4EYECbjZ4iWhwDhwT5nTOgqSi2bBOof5zCaUANaNDoZQZ+B1lK7+HkHSXxTK9rvmWBoVhMA9VFrKPSIJIQA5TbwYPhz6UAQB5ZpYQO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715527547; c=relaxed/simple;
	bh=VxXd1pVTHgFPYpuyHPxoomX3P5xw2HYOOi9eD32Pv50=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T0A3a9AxKmEwlhrTUVNtqwGddNRvHV4kq3+Y8uORpfYsW4c3j8ebX3acTy/BizteEk4NmBWKXRgF63tMDn3jMthhFizDp8EAa8tqdcYocl7EMj4Bhl9185VE6edt9OdLG1I+v8kRW2ddveEIih0nmkz8UAe/DE77Qe5s9NvuPNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFGSdjJq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4641EC4AF11;
	Sun, 12 May 2024 15:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715527547;
	bh=VxXd1pVTHgFPYpuyHPxoomX3P5xw2HYOOi9eD32Pv50=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=dFGSdjJq05nFpLJHZFgRinsGoYsV2u3q13UBxbSAsOiq2/ZgzBP8K2sWH+0vZF4Xl
	 am9Knl/KwBIXy+9nd/G2246osRwrqqglllTWXMKxE6o+f1pQIseHMB8TefxIwaCsuX
	 Vtgctp1nSmeQNaShThpVsLJnxZ1p0T77g+tWDLa8wNmnjSEepkZcp2nAq1MOmc94fK
	 x+0AVRU5BmSE+TnQ5bONeqV49VnJFZjxmtxvU5gtvU94E5QueVdTUrJblBBySlcaWQ
	 TnXVMZuiNBZ3Xqt9RWGKIuXvj1tCxTL35MhHnNSHyuNI0aGQBhl1Qi6YMcH+qrsMDL
	 JxA+yrMeIWZzw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED1CC25B77;
	Sun, 12 May 2024 15:25:47 +0000 (UTC)
From: =?utf-8?q?Noralf_Tr=C3=B8nnes_via_B4_Relay?= <devnull+noralf.tronnes.org@kernel.org>
Date: Sun, 12 May 2024 17:25:42 +0200
Subject: [PATCH v2 5/5] drm/tiny: panel-mipi-dbi: Support the pixel format
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240512-panel-mipi-dbi-rgb666-v2-5-49dd266328a0@tronnes.org>
References: <20240512-panel-mipi-dbi-rgb666-v2-0-49dd266328a0@tronnes.org>
In-Reply-To: <20240512-panel-mipi-dbi-rgb666-v2-0-49dd266328a0@tronnes.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>, 
 Tommaso Merciai <tommaso.merciai@amarulasolutions.com>, 
 =?utf-8?q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715527545; l=2926;
 i=noralf@tronnes.org; s=20221122; h=from:subject:message-id;
 bh=VkhLn8bg4+tzwHP3nVSjku8IqF1KyX0WKDV/6VouitQ=;
 b=mRfFsOMoujbyBk79qJfPAYkXoDM5n4PyHaR8rUjCDEPPG5JsOo7woURRkpWcj+AhydkSnYnPg
 Q3tSS1zKHKJBCrPfqE63WCQjLOTR5Zc+zsvRWMkX1iIbnJhM7xkURAo
X-Developer-Key: i=noralf@tronnes.org; a=ed25519;
 pk=0o9is4iddvvlrY3yON5SVtAbgPnVs0LfQsjfqR2Hvz8=
X-Endpoint-Received: by B4 Relay for noralf@tronnes.org/20221122 with
 auth_id=8
X-Original-From: =?utf-8?q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
Reply-To: noralf@tronnes.org

From: Noralf Trønnes <noralf@tronnes.org>

Add support for these pixel format property values:
- r5g6b5, RGB565
- b6x2g6x2r6x2, BGR666

BGR666 is presented to userspace as RGB888. The 2 LSB in each color
are discarded by the controller. The pixel is sent on the wire using
8 bits per word (little endian) so the controller sees it as BGR.

RGB565 is the default if the property is not present.

Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
---
 drivers/gpu/drm/tiny/panel-mipi-dbi.c | 55 ++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tiny/panel-mipi-dbi.c b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
index f80a141fcf36..f3aa2abce314 100644
--- a/drivers/gpu/drm/tiny/panel-mipi-dbi.c
+++ b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
@@ -26,6 +26,49 @@
 
 #include <video/mipi_display.h>
 
+struct panel_mipi_dbi_format {
+	const char *name;
+	u32 fourcc;
+	unsigned int bpp;
+};
+
+static const struct panel_mipi_dbi_format panel_mipi_dbi_formats[] = {
+	{ "r5g6b5", DRM_FORMAT_RGB565, 16 },
+	{ "b6x2g6x2r6x2", DRM_FORMAT_RGB888, 24 },
+};
+
+static int panel_mipi_dbi_get_format(struct device *dev, u32 *formats, unsigned int *bpp)
+{
+	const char *format_name;
+	unsigned int i;
+	int ret;
+
+	formats[1] = DRM_FORMAT_XRGB8888;
+
+	ret = device_property_read_string(dev, "format", &format_name);
+	if (ret) {
+		/* Old Device Trees don't have this property */
+		formats[0] = DRM_FORMAT_RGB565;
+		*bpp = 16;
+		return 0;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(panel_mipi_dbi_formats); i++) {
+		const struct panel_mipi_dbi_format *format = &panel_mipi_dbi_formats[i];
+
+		if (strcmp(format_name, format->name))
+			continue;
+
+		formats[0] = format->fourcc;
+		*bpp = format->bpp;
+		return 0;
+	}
+
+	dev_err(dev, "Pixel format is not supported: '%s'\n", format_name);
+
+	return -EINVAL;
+}
+
 static const u8 panel_mipi_dbi_magic[15] = { 'M', 'I', 'P', 'I', ' ', 'D', 'B', 'I',
 					     0, 0, 0, 0, 0, 0, 0 };
 
@@ -276,6 +319,9 @@ static int panel_mipi_dbi_spi_probe(struct spi_device *spi)
 	struct drm_device *drm;
 	struct mipi_dbi *dbi;
 	struct gpio_desc *dc;
+	unsigned int bpp;
+	size_t buf_size;
+	u32 formats[2];
 	int ret;
 
 	dbidev = devm_drm_dev_alloc(dev, &panel_mipi_dbi_driver, struct mipi_dbi_dev, drm);
@@ -323,7 +369,14 @@ static int panel_mipi_dbi_spi_probe(struct spi_device *spi)
 	if (IS_ERR(dbidev->driver_private))
 		return PTR_ERR(dbidev->driver_private);
 
-	ret = mipi_dbi_dev_init(dbidev, &panel_mipi_dbi_pipe_funcs, &mode, 0);
+	ret = panel_mipi_dbi_get_format(dev, formats, &bpp);
+	if (ret)
+		return ret;
+
+	buf_size = DIV_ROUND_UP(mode.hdisplay * mode.vdisplay * bpp, 8);
+	ret = mipi_dbi_dev_init_with_formats(dbidev, &panel_mipi_dbi_pipe_funcs,
+					     formats, ARRAY_SIZE(formats),
+					     &mode, 0, buf_size);
 	if (ret)
 		return ret;
 

-- 
2.45.0



