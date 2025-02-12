Return-Path: <linux-kernel+bounces-511321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72918A32956
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4ECEC7A2DED
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718BE250BF1;
	Wed, 12 Feb 2025 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="wUVJvYpb"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65595230D0E
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739372228; cv=none; b=VX1n+T+8RVKH/003OEdO2lL4IKim4QaSvPJiU7iPSiHNMG/eoKsMIf2m0qZ4PF/ge1CSnZylRs35z/+hUGpFJF1T7sfTIP6dn0/sstWy9+3qDR08S+QTsMSRv9aLyZTDXDi+olxOPs6sxj4QS6+IiQbcpIrfvzQ7n/R4eW65tWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739372228; c=relaxed/simple;
	bh=rZ+iMADIBNdMO0mVy7oobeXfg2lKZKrn5V9QH3VTLRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N4myjiOwP/4EY5ceKnuSEhQe54oYGebEgqIYx33J8p5uDYfbia0UgtZudUAx0++NYRGsi2DXx3/nhMrFnzi5xJ7CZ0SddXkemEDnP45lADCn7UMTh8T4FtolICYl9B8P9rGQRDSHSRIHCz49fS7eC1TgoI0yse5cLhFrNQvtjsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=wUVJvYpb; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 85FF51AB3;
	Wed, 12 Feb 2025 15:55:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1739372136;
	bh=rZ+iMADIBNdMO0mVy7oobeXfg2lKZKrn5V9QH3VTLRw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=wUVJvYpbm6RHZwXxY71g3mkHaZjgji+traGy6PPKiXGJy6WS3OOHJiEV/k+HgMqaU
	 tcIlrhq5Bnluij+M470c45N5oeU2cpINx+9M5Yi7RGq/OTBarJh0QeOx0fPFMNjrRO
	 RNtEZmwbmE0M2D/1gFrAPQOML+guI24FkCMPnBIo=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 12 Feb 2025 16:56:13 +0200
Subject: [PATCH v3 09/11] drm: xlnx: zynqmp: Add support for Y8 and
 Y10_LE32
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-xilinx-formats-v3-9-90d0fe106995@ideasonboard.com>
References: <20250212-xilinx-formats-v3-0-90d0fe106995@ideasonboard.com>
In-Reply-To: <20250212-xilinx-formats-v3-0-90d0fe106995@ideasonboard.com>
To: Vishal Sagar <vishal.sagar@amd.com>, 
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1964;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=rZ+iMADIBNdMO0mVy7oobeXfg2lKZKrn5V9QH3VTLRw=;
 b=kA0DAAgB+j2qjLyWHvUByyZiAGestquh7IET5CXQqVbouRNgLjXdlQkfpTxWV+ns75w+6eyML
 YkCMwQAAQgAHRYhBMQ4DD6WXv2BB5/zp/o9qoy8lh71BQJnrLarAAoJEPo9qoy8lh71948P/1bF
 ay+8vlWNZUKEsEZRBwwWgcYhW/6Qj81AdLt3rWChxCZmVxY2ZEfXbd515YFUfJtopKBd0jEp4Kw
 xEMLhxn1H29FJdQhO9IK8oZG7BrhQcGBKKi413L4Q2/Qzluorr6JmpeRtI7on66m5GvM9icsTJ+
 C7B27jAGblyP4SaFeDcU4ReURcozb6p5V1PVI/UaeBGT18+hJnSO5ebaoijo2cp7LjhTKc5l2Lf
 5wi9Ae2Pr1Z4Rp05ByT8MrHGT3rcG2CtNwhLW/77KNSY1EoQmpzJ5YFPCPRuQQ9Z9o/CD3sAGO6
 NFMUJBiD6PnNDEyc5adOSD7VzKxwnmufrfte956JU1SQazRTc8ams5i97b10AafOoI/yX8JxMgx
 78QmLl0sqj4SGJSybyEyI6wu78xrNyUug+oMV3f68SHTuH0Oe//C43l5vRoSi1xmWkIcpzXJD2A
 vHLsf5fF/5Y10CmW2x4W9fXgoYhJiv/GCO+x7DRo8u0nE7UxrM55vv+TvsYnVNXJ/Kb0lR4ZoOe
 jj3dl/T4DUgrYDnse8yPwjnmARvLZ/frLtnOkPN1eBdERLdgZDOJgtKnY49QjnlUQDehegb27jl
 i74s19z84qRUg/H11OT54FlngyeXLlgp8ZJ0MKawezEy+29S09w3zXCb2dTN6wJkMl0p7nFRQtJ
 szJRi
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add support for Y8 and Y10_LE32 formats. We also need to add new csc
matrices for the y-only formats.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 32031f52e114..c820df97aa28 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -307,6 +307,16 @@ static const struct zynqmp_disp_format avbuf_vid_fmts[] = {
 		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YV16CI_10,
 		.swap		= false,
 		.sf		= scaling_factors_101010,
+	}, {
+		.drm_fmt	= DRM_FORMAT_Y8,
+		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_MONO,
+		.swap		= false,
+		.sf		= scaling_factors_888,
+	}, {
+		.drm_fmt	= DRM_FORMAT_Y10_P32,
+		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YONLY_10,
+		.swap		= false,
+		.sf		= scaling_factors_101010,
 	},
 };
 
@@ -697,6 +707,16 @@ static const u32 csc_sdtv_to_rgb_offsets[] = {
 	0x0, 0x1800, 0x1800
 };
 
+static const u16 csc_sdtv_to_rgb_yonly_matrix[] = {
+	0x0, 0x0, 0x1000,
+	0x0, 0x0, 0x1000,
+	0x0, 0x0, 0x1000,
+};
+
+static const u32 csc_sdtv_to_rgb_yonly_offsets[] = {
+	0x1800, 0x1800, 0x0
+};
+
 /**
  * zynqmp_disp_blend_set_output_format - Set the output format of the blender
  * @disp: Display controller
@@ -846,7 +866,11 @@ static void zynqmp_disp_blend_layer_enable(struct zynqmp_disp *disp,
 				ZYNQMP_DISP_V_BLEND_LAYER_CONTROL(layer->id),
 				val);
 
-	if (layer->drm_fmt->is_yuv) {
+	if (layer->drm_fmt->format == DRM_FORMAT_Y8 ||
+	    layer->drm_fmt->format == DRM_FORMAT_Y10_P32) {
+		coeffs = csc_sdtv_to_rgb_yonly_matrix;
+		offsets = csc_sdtv_to_rgb_yonly_offsets;
+	} else if (layer->drm_fmt->is_yuv) {
 		coeffs = csc_sdtv_to_rgb_matrix;
 		offsets = csc_sdtv_to_rgb_offsets;
 	} else {

-- 
2.43.0


