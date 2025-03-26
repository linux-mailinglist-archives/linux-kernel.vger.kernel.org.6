Return-Path: <linux-kernel+bounces-577024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3867A7176F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8183BD210
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AAD1EB5C3;
	Wed, 26 Mar 2025 13:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Nl15Xetz"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F0F1F3FD9
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742995415; cv=none; b=uL7kyckly/yTbVIf5MUmLxvzh31+zbC2ShO8uAy9VKyvXMuo5QNvhfUVCshiSUzGYOYh2t26NASo5+ryb1DwGPaFrA0BtdqfEJSXgEb5JNzxoLeRMGix8XWNORnaj4NWaM3jRP6ikk3EwdMSUJKqXPKXzDaJkVRtU7FA8a85b5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742995415; c=relaxed/simple;
	bh=PFxBeKEc/4sg8CWi+sylqvNLnUJoQ0zkdqZzj2YAfIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wlm0tKPK41RWFsZ9gWijdpenuAMdjjhQekOQKZI4b72qpLcojiq/ogEF7vhPxqXwmVTXlb5Y8OpD66w87+91Mnx0PisKZiw/KFzilxP/KiX8qRgffz1L/ZN8qnpSjjKuj1ujY2Y+nXGFBF4qvHkVvZI7SrrV9H2po9FbPXp92Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Nl15Xetz; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D37401955;
	Wed, 26 Mar 2025 14:21:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1742995297;
	bh=PFxBeKEc/4sg8CWi+sylqvNLnUJoQ0zkdqZzj2YAfIU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Nl15Xetz7GxmJI+bohIu0UUtr6O3IoWSG91nlGHoyAw6xKr392CsaZbPl/DC4z7wJ
	 7NgDeP7hxn221WyB9d+x10eRQE/aCfgJiT9aiy435rABKYJZsJVWWWCxV3gYmU0mH5
	 +5Ep/i+vHNK1jW7nAOifngY6sTwNStljh/d6jnOo=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 26 Mar 2025 15:22:52 +0200
Subject: [PATCH v4 09/11] drm: xlnx: zynqmp: Add support for Y8 and Y10_P32
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-xilinx-formats-v4-9-322a300c6d72@ideasonboard.com>
References: <20250326-xilinx-formats-v4-0-322a300c6d72@ideasonboard.com>
In-Reply-To: <20250326-xilinx-formats-v4-0-322a300c6d72@ideasonboard.com>
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
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1963;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=PFxBeKEc/4sg8CWi+sylqvNLnUJoQ0zkdqZzj2YAfIU=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBn4//DfmM4XpWvRWHABTxHtXEpM64vCUNTjpOi2
 4+zk9HJkyuJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ+P/wwAKCRD6PaqMvJYe
 9dRnEACl9IJT48S7m8oF/ytsE3AEHkSOSUimNseOUncLFVgqeOllQMMWSoYf4E+Q/U3a/bTlEWb
 IeRhXE1WQkUEmE2nw2e9n4O5VZwoPCMgiVpwL342pluX2JOLO2B4KLWF1KulAqwuBp2Pllog15X
 b7932U9CY4/dtoFb/hVy9KG0Z110qcKBqVh4MKfgD8v6OuGdrnbFiOLXVBVza7Fon/fejSH9Iza
 AxsqzRhV89Z1hkX+vaf/EeyGg0WjDeOEgtBcoFWuyYciijbxx6oPSNsuVqRitGChd6Fn8DG3xuK
 UMmuud35aqN+/kvXJYXqu77BDGfne5Xa6w0v7NS/UTsP2BFmFeHqVRATFgGTsREvGOn3w/Pehv5
 HAcHBeSlceKjwvP/RKAtjXVCGWTgnVyq+H0ne0Vkvjv4h6v1Fnl2lx7supkApD+DQfbBTlJgs3V
 X2+V1Ini0YQnPYKOR3OF7h+vgsTiyn34l7MubrBc/Hb7t/YUo3DZqlT/5rCaUJs4ulLpMfAoopJ
 smJJjaXogoyrPndu2louYpkaK0uAqvmOPlBOJJ982PPDXeRTFJl9zYBvSkKc2Yd5TSlK6tOBLcs
 fLQN2i21ApvB0xXT+6Es9pJFCW8mKfLvuJjW5+G8YJeG2OjuRPm2xzl8D7K66STezmaYISrrym2
 k2DZvQCie1V841Q==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add support for Y8 and Y10_P32 formats. We also need to add new csc
matrices for the y-only formats.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 1dc77f2e4262..ae8b4073edf6 100644
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


