Return-Path: <linux-kernel+bounces-363741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A43099C66F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 11:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6B428573C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9CB158DD1;
	Mon, 14 Oct 2024 09:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="V3CJq7RF"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD222158DC4
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728899430; cv=none; b=h0W5KX+JkC7TrcVQfykWpC+J0qksJjuKgQhBVZUKHaK6F/sR0b56VPCf5x1GUhNgsQM+Dql1peFEYbbttRcMPc3IRF35L7wZ20rC/4f68V8gmFfqofnhez+qN2asqqAwdbqN0rm/L+8dTsqtVyhpX+D7g0eIeibXuklU/tU6spI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728899430; c=relaxed/simple;
	bh=NkBDkiht3me8b2RWwXoEEEEvGTjmDHBukmLCCQGzqkI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tArEDWaFYBQZNA1s9/Bh8oduXBcXB7US42qZCZ5ZmKI4cll2IDT594w0kTgBz2A8RuaDSqWrrIOBkUAnovTu/9uyFuNLdSFCXB7JkFdkPcWE8ceDA+UqfTr3MauwiAZ3mgP8aLoI1R5Fdla8t/OFW7RONrnpXS2YwGRbEUMpSKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=V3CJq7RF; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1728899428; x=1760435428;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NkBDkiht3me8b2RWwXoEEEEvGTjmDHBukmLCCQGzqkI=;
  b=V3CJq7RFxxkvYl2yd5fW/Nse+gUiOcinvYdkyEXIdWWfUk4CybiqIJAZ
   MpCZSuRMXf9TE9gLCNSqLnEez2HAepGu846uLzDX5ErGvf+KNVuWJx4eS
   7PUkiaq4lb7ksgbZMIVW4YhTxVHYxNZbD/5bqTzK1L8cbdVaeukr1iOFl
   aM02BQemGp+SWZy+e3QMrq5iw/BOth6JYCMW1LcKL1FDkMJdowlSd01sz
   /TTlL/Vj29o/AOqLwJUuZ8uXI5lgOXzXgMI13qGrCPfoGrEx0ZmdAYjNP
   H/OlFmYY+TiJFM9t6Cwge5ckD/KTJoMTkj1Z3hC6LBoSsILW4exfRJVeO
   w==;
X-CSE-ConnectionGUID: 6GkUoRpBTjazw9ZDotKAkg==
X-CSE-MsgGUID: TPW6ZCp2TmCpx0urBWje2w==
X-IronPort-AV: E=Sophos;i="6.11,202,1725346800"; 
   d="scan'208";a="36319939"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Oct 2024 02:50:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 14 Oct 2024 02:50:02 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 14 Oct 2024 02:49:56 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <sam@ravnborg.org>, <bbrezillon@kernel.org>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <Hari.PrasathGE@microchip.com>,
	<durai.manickamkr@microchip.com>, <manikandan.m@microchip.com>,
	<dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: Cyrille Pitchen <cyrille.pitchen@microchip.com>
Subject: [PATCH] drm: atmel-hlcdc: fix atmel_xlcdc_plane_setup_scaler()
Date: Mon, 14 Oct 2024 15:19:42 +0530
Message-ID: <20241014094942.325211-1-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Cyrille Pitchen <cyrille.pitchen@microchip.com>

On SoCs, like the SAM9X75, which embed the XLCDC ip, the registers that
configure the unified scaling engine were not filled with proper values.

Indeed, for YCbCr formats, the VXSCFACT bitfield of the HEOCFG25
register and the HXSCFACT bitfield of the HEOCFG27 register were
incorrect.

For 4:2:0 formats, both vertical and horizontal factors for
chroma chanels should be divided by 2 from the factors for the luma
channel. Hence:

HEOCFG24.VXSYFACT = VFACTOR
HEOCFG25.VSXCFACT = VFACTOR / 2
HEOCFG26.HXSYFACT = HFACTOR
HEOCFG27.HXSCFACT = HFACTOR / 2

However, for 4:2:2 formats, only the horizontal factor for chroma
chanels should be divided by 2 from the factor for the luma channel;
the vertical factor is the same for all the luma and chroma channels.
Hence:

HEOCFG24.VXSYFACT = VFACTOR
HEOCFG25.VXSCFACT = VFACTOR
HEOCFG26.HXSYFACT = HFACTOR
HEOCFG27.HXSCFACT = HFACTOR / 2

Fixes: d498771b0b83 ("drm: atmel_hlcdc: Add support for XLCDC using IP specific driver ops")
Signed-off-by: Cyrille Pitchen <cyrille.pitchen@microchip.com>
---
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   | 27 ++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
index 4bcaf2cd7672..41c7351ae811 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c
@@ -365,13 +365,34 @@ void atmel_xlcdc_plane_setup_scaler(struct atmel_hlcdc_plane *plane,
 				    xfactor);
 
 	/*
-	 * With YCbCr 4:2:2 and YCbYcr 4:2:0 window resampling, configuration
-	 * register LCDC_HEOCFG25.VXSCFACT and LCDC_HEOCFG27.HXSCFACT is half
+	 * With YCbCr 4:2:0 window resampling, configuration register
+	 * LCDC_HEOCFG25.VXSCFACT and LCDC_HEOCFG27.HXSCFACT values are half
 	 * the value of yfactor and xfactor.
+	 *
+	 * On the other hand, with YCbCr 4:2:2 window resampling, only the
+	 * configuration register LCDC_HEOCFG27.HXSCFACT value is half the value
+	 * of the xfactor; the value of LCDC_HEOCFG25.VXSCFACT is yfactor (no
+	 * division by 2).
 	 */
-	if (state->base.fb->format->format == DRM_FORMAT_YUV420) {
+	switch (state->base.fb->format->format) {
+	/* YCbCr 4:2:2 */
+	case DRM_FORMAT_YUYV:
+	case DRM_FORMAT_UYVY:
+	case DRM_FORMAT_YVYU:
+	case DRM_FORMAT_VYUY:
+	case DRM_FORMAT_YUV422:
+	case DRM_FORMAT_NV61:
+		xfactor /= 2;
+		break;
+
+	/* YCbCr 4:2:0 */
+	case DRM_FORMAT_YUV420:
+	case DRM_FORMAT_NV21:
 		yfactor /= 2;
 		xfactor /= 2;
+		break;
+	default:
+		break;
 	}
 
 	atmel_hlcdc_layer_write_cfg(&plane->layer, desc->layout.scaler_config + 2,
-- 
2.25.1


