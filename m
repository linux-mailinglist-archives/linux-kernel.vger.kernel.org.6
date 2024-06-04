Return-Path: <linux-kernel+bounces-200696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 040B98FB373
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 15:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983041F21BA5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 13:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50481487D5;
	Tue,  4 Jun 2024 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3/2MSNl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129DA146A74;
	Tue,  4 Jun 2024 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717507240; cv=none; b=Nnr7WOKR4MXuUSfeTwqrQEQFmKv+VeylW4487hP5DSB6gbWCbgckuf+PHadDj2O1oBgWG25ZcDJp651fgq6tGrfmcgfaEd8wZA52D4KGROrkJ+SbM3WznyjT+S6oCrie/nUuvoGuVjp2I+HEsAqqHecGQpKML42T9QXpQ7Pt1NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717507240; c=relaxed/simple;
	bh=DC5EZsEx+rBT/MPOOSxJY0nl4J0fot6cQcgzpc29Qek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s90VdS5U3XPP4Mx2UIaazgcjlzrTkgfctKeSxD1GNZekaN8+KOA2ZfeZZBgvX+z2wlKqL+DgKOVQh8NUky+x6vLDQNYpl88TRn+/+dd1djwTxwnIAK7kJGeMwE7oD1i8EHL/MRWVtnwJNxcW6nqxt6CniUX+SV9Pxmct/+LYXQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3/2MSNl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94F3EC4AF14;
	Tue,  4 Jun 2024 13:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717507239;
	bh=DC5EZsEx+rBT/MPOOSxJY0nl4J0fot6cQcgzpc29Qek=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=b3/2MSNllqyZt/ndR9uLIfWcxQ8T0TOWCiiRcdfxwn5B8TRzecc3bGGUcrOHw1Q1P
	 gQg9WfEQqHxJ5leWGZ52rFz3OVyOwe3095J7ohU0QqJZs6Ec08wiHctp1KnAH/3OCa
	 EA0Z9Nhy5DaeDq5cMV3qNTNDa/nHs177Augg+MMbvpM/tac/rY54O2S1qePc+tPx7V
	 UE7zdbelk1KpcFgVbQiRzVIdVlqXAFJiozPP72eHbn/wxjoWENwPmcBFc4C7MVJBWa
	 OmVUv2JsodaRlVg0lCus039+SCBYmWV95TVSiCDm1JyuY7kXZo2RMa3S0DJHMqNNUn
	 cRNTezlxMchcg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C89EC25B78;
	Tue,  4 Jun 2024 13:20:39 +0000 (UTC)
From: =?utf-8?q?Noralf_Tr=C3=B8nnes_via_B4_Relay?= <devnull+noralf.tronnes.org@kernel.org>
Date: Tue, 04 Jun 2024 15:20:32 +0200
Subject: [PATCH v4 5/5] drm/tiny: panel-mipi-dbi: Support the pixel format
 property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240604-panel-mipi-dbi-rgb666-v4-5-d7c2bcb9b78d@tronnes.org>
References: <20240604-panel-mipi-dbi-rgb666-v4-0-d7c2bcb9b78d@tronnes.org>
In-Reply-To: <20240604-panel-mipi-dbi-rgb666-v4-0-d7c2bcb9b78d@tronnes.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <david@lechnology.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>, 
 Tommaso Merciai <tommaso.merciai@amarulasolutions.com>, 
 =?utf-8?q?Noralf_Tr=C3=B8nnes?= <noralf@tronnes.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717507238; l=2983;
 i=noralf@tronnes.org; s=20221122; h=from:subject:message-id;
 bh=NSd8WCcz3mEyAmd3gnS4mEuzeD9kKvKEnfrPdQSMiME=;
 b=QvW48LB0GjDH9HPC/0Wul41Y4uUWFArhOzcr2VcGbC9AKxHRLwJohaihMp/Uj0HpB3kw71GIh
 b+h1Tzn7380CdwyT3RcIDhiVoGjvR+At1vUxRDodcKEtokdw7R/1GiT
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
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
2.45.1



