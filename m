Return-Path: <linux-kernel+bounces-510835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B30AA322A7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB5A3A34B4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 09:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBDA206F02;
	Wed, 12 Feb 2025 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tT16+Yui"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9A32063D6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 09:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739353505; cv=none; b=fKenogqcXVWOfJYgtzvSmyWLVgOX1Ifsr8k/M5ts4/GPGBmni0Lh0xBTBC/aT0jUcCbwO+4KaEJ7heua0HUFIYiiLW703Zqw6SDlF2Fl6NdX0gp5xC8KxMLEgzMVLx7RW2zhmRfHhNO6tSwTvurcJ7Z4J8e5gm0E5DlAvwXoNgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739353505; c=relaxed/simple;
	bh=Sa8bPFHTaj9aW+dktFBUNt2YyId16vwK369IXtQxnwo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IZEWjq7aswuZmp+0b2z+bTGgMSoq9kiA1hx7+Kxl6ItuNyY5G36fEogGRwbAxlAnKnNz63bE10ifNRNhqUrhm7mutco2Cg6N86uEjh/vsKvhH1VMC0zazPtxYJ6klq/KJLUusVpbGhCmm3WILHBVe/l1fn7m006tv9bkg2+OEyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tT16+Yui; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1739353504; x=1770889504;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Sa8bPFHTaj9aW+dktFBUNt2YyId16vwK369IXtQxnwo=;
  b=tT16+YuiFYjNEgtSRGy4URKPusCEq2iZzb/lUjIzVuwLhKONAL3CLWMk
   eF+7u64aPn5F8JCOzU98yAIQ3lJx3Uj6NYRY7eqPEMnOnhokKiWicpX+A
   qGYgrzrPwWRvaAMweTDBH2xpLFdAy5HX1BCEDYlU4SkEjE67bB0qaAYRv
   MPtFqqZiau9KIhTvHbo7YZfqK9SLe2UECAnUTKtZ+JH/O1juUScX9nqjD
   aOImANhO13+aXLd0Yand4LokxsigXalLS37/z2kGiltsdzmBTplxRJlH7
   l1/7iOEmZE5QQQoAu9j8GUhLyB8on/vqDm2pA9YCgokEOAfcdA/cUDGLX
   g==;
X-CSE-ConnectionGUID: hX8HeKjRTlCEQQ9RkVLg4A==
X-CSE-MsgGUID: BJci5WDbS2KJ5oBT4WqMpQ==
X-IronPort-AV: E=Sophos;i="6.13,279,1732604400"; 
   d="scan'208";a="38002164"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2025 02:45:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 12 Feb 2025 02:45:01 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Wed, 12 Feb 2025 02:44:55 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <sam@ravnborg.org>, <bbrezillon@kernel.org>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <lee@kernel.org>,
	<dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Dharma Balasubiramani <dharma.b@microchip.com>, Manikandan Muralidharan
	<manikandan.m@microchip.com>
Subject: [PATCH v2 1/3] drm: atmel-hlcdc: add support for LVDS encoder type
Date: Wed, 12 Feb 2025 15:14:47 +0530
Message-ID: <20250212094449.109622-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Dharma Balasubiramani <dharma.b@microchip.com>

Add support for encoder type "DRM_MODE_ENCODER_LVDS" with the following
bus formats:
	- RGB888_1X7X4_SPWG
	- RGB888_1X7X4_JEIDA
	- RGB666_1X7X3_SPWG
	- RGB666_1X18

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
[manikandan.m@microchip.com: move modifications inside the
atmel_xlcdc_connector_output_lvds fn]
Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 0f7ffb3ced20..0e709047369a 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -356,6 +356,42 @@ static int atmel_xlcdc_connector_output_dsi(struct drm_encoder *encoder,
 	return supported_fmts;
 }
 
+static int atmel_xlcdc_connector_output_lvds(struct drm_encoder *encoder,
+					     struct drm_display_info *info)
+{
+	int j;
+	unsigned int supported_fmts = 0;
+
+	switch (atmel_hlcdc_encoder_get_bus_fmt(encoder)) {
+	case 0:
+		break;
+	case MEDIA_BUS_FMT_RGB666_1X7X3_SPWG:
+	case MEDIA_BUS_FMT_RGB666_1X18:
+		return ATMEL_HLCDC_RGB666_OUTPUT;
+	case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG:
+	case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA:
+		return ATMEL_HLCDC_RGB888_OUTPUT;
+	default:
+		return -EINVAL;
+	}
+
+	for (j = 0; j < info->num_bus_formats; j++) {
+		switch (info->bus_formats[j]) {
+		case MEDIA_BUS_FMT_RGB666_1X7X3_SPWG:
+		case MEDIA_BUS_FMT_RGB666_1X18:
+			supported_fmts |= ATMEL_HLCDC_RGB666_OUTPUT;
+			break;
+		case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG:
+		case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA:
+			supported_fmts |= ATMEL_HLCDC_RGB888_OUTPUT;
+			break;
+		default:
+			break;
+		}
+	}
+	return supported_fmts;
+}
+
 static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
 {
 	struct drm_connector *connector = state->connector;
@@ -374,6 +410,8 @@ static int atmel_hlcdc_connector_output_mode(struct drm_connector_state *state)
 	 */
 	if (encoder->encoder_type == DRM_MODE_ENCODER_DSI)
 		return atmel_xlcdc_connector_output_dsi(encoder, info);
+	else if (encoder->encoder_type == DRM_MODE_ENCODER_LVDS)
+		return atmel_xlcdc_connector_output_lvds(encoder, info);
 
 	switch (atmel_hlcdc_encoder_get_bus_fmt(encoder)) {
 	case 0:
-- 
2.25.1


