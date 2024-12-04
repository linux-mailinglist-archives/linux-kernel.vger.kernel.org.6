Return-Path: <linux-kernel+bounces-430869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4736D9E36C4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:38:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 51FB2B2FF1D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1D01B392E;
	Wed,  4 Dec 2024 09:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="hTxi8s/9"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9621B21B5
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733304709; cv=none; b=Ab7auEU5h8P+jRjMJZ2dISUx6qGr8ADlmtS47wg1+ecWDemI+n3JdcWSpzgDA6Oh8pXX1tk2+1KppdfJVlJ/zaksXGDSgWmjm2krMMEBN+azkgtJw+sFBURbJLRRaSlwqO43mH0TvdKxGi1CFLi6gi0nxQI57aCGsea1BB+XoCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733304709; c=relaxed/simple;
	bh=vSNfl+dk45d5cm6nnQngiziPUpAD1SE0JXcPFtyqb6E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lN+qgeVa0m33MeQcZ7S9QM1ammabvMFgEr08F4DD1163zcH2zxPI3STTJQpia70SWK1TEyjAKrXoEomno0mW9rc64iIFHJ0Juj8shpsXGEfypxlg6dNwSgwE8m5PRoGv2zPzq0QNQ7X2ID9pu9AcTx3Pih43arbnu0UdBXk5lhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=hTxi8s/9; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-157-155-49.elisa-laajakaista.fi [91.157.155.49])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D15961BAE;
	Wed,  4 Dec 2024 10:31:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1733304672;
	bh=vSNfl+dk45d5cm6nnQngiziPUpAD1SE0JXcPFtyqb6E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hTxi8s/9pGX0RXDCw/5wUmsbDZLdcqEyGbq2h2eXYvHIuwhXnetvc+UDTJlMbLi9z
	 kvO0/Sx6VpkBORWhthm/DS9KznquwO3G4hmnZ8Mp/Hk1z2OCVfS9nyKgn5J02fXpwm
	 3BwBSoRP6Q0gStzLTzQWtKtnjS9+GM8xel3UbEGw=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 04 Dec 2024 11:31:08 +0200
Subject: [PATCH 08/10] drm: xlnx: zynqmp: Add support for Y8 and Y10_LE32
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-xilinx-formats-v1-8-0bf2c5147db1@ideasonboard.com>
References: <20241204-xilinx-formats-v1-0-0bf2c5147db1@ideasonboard.com>
In-Reply-To: <20241204-xilinx-formats-v1-0-0bf2c5147db1@ideasonboard.com>
To: Vishal Sagar <vishal.sagar@amd.com>, 
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1966;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=vSNfl+dk45d5cm6nnQngiziPUpAD1SE0JXcPFtyqb6E=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBnUCFz7vKwL/JknjDOTrW3yKdDoVLc847EBOBYe
 fqlqXtBeuKJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ1AhcwAKCRD6PaqMvJYe
 9VFqEACObI98inSgLPDGEREQkqyBJlHdMI9Vu8S1Oj9irzsyK1xj6RQKZc6BzdeH8EnxxAMjQWn
 hn5ydfZYeY36La7UAH/xFjB+vQCgD/Y8aHXotS5BEFD7Rimhu3936ldJ+OH0rsIHNM+QS2FZj4n
 GnJMwRRiXqUfoVE4fS/XwCriSG5RtVUO/aQLUJtOrT1p3dM4Jh3MpHjFRV+EJrt9TjT+i2km55i
 il0V9bRmQUmTD+20wN4BcDb4aBGJF4vxPam5sGCcTwwdImsXMdtkXDw9xlbOJKoDsM7FMTnXg6T
 yZakjwN4i5ePrHhZU43VlL67jpIqvMCQsFk4o0tnAeigZ9I83LeIcxYRp6jbPjSmG++jT3wt+C0
 ktCspNfd325GPImrY0vhYvxLfkBzOSg5mC53H15zEEHmQ0KJJnxPx9FkZFsAPmOL1+JQGCjXczD
 m0vco/6XsEQcuV9yjbRIkbUZ+z24zBTsTZfzP8UQk6LAHAn493Q4tgK7hEg3MngzF2oNPyq2tc5
 5yyj9jk6V9w57i3OyhqbuvruA8X+YTVR8Z834itz0bZYOMa0hSknuGC8hvRCEdly/eK/Id19vb7
 fH9lPEHJV8NKBHcfzNPVtQ3BR3w13UUk4eKWi6THPQc1+eR1H9N6lkwAn1jUgiVGBxlG5CniiIC
 VZevhcWbSVN7OZw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add support for Y8 and Y10_LE32 formats. We also need to add new csc
matrices for the y-only formats.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 3998754e367e..44cfee6a0e32 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -309,6 +309,16 @@ static const struct zynqmp_disp_format avbuf_vid_fmts[] = {
 		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YV16CI_10,
 		.swap		= false,
 		.sf		= scaling_factors_101010,
+	}, {
+		.drm_fmt	= DRM_FORMAT_Y8,
+		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_MONO,
+		.swap		= false,
+		.sf		= scaling_factors_888,
+	}, {
+		.drm_fmt	= DRM_FORMAT_Y10_LE32,
+		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YONLY_10,
+		.swap		= false,
+		.sf		= scaling_factors_101010,
 	},
 };
 
@@ -699,6 +709,16 @@ static const u32 csc_sdtv_to_rgb_offsets[] = {
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
@@ -848,7 +868,11 @@ static void zynqmp_disp_blend_layer_enable(struct zynqmp_disp *disp,
 				ZYNQMP_DISP_V_BLEND_LAYER_CONTROL(layer->id),
 				val);
 
-	if (layer->drm_fmt->is_yuv) {
+	if (layer->drm_fmt->format == DRM_FORMAT_Y8 ||
+	    layer->drm_fmt->format == DRM_FORMAT_Y10_LE32) {
+		coeffs = csc_sdtv_to_rgb_yonly_matrix;
+		offsets = csc_sdtv_to_rgb_yonly_offsets;
+	} else if (layer->drm_fmt->is_yuv) {
 		coeffs = csc_sdtv_to_rgb_matrix;
 		offsets = csc_sdtv_to_rgb_offsets;
 	} else {

-- 
2.43.0


