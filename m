Return-Path: <linux-kernel+bounces-577023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E75BBA7176E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00E4C3BCF54
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:24:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9551F37C3;
	Wed, 26 Mar 2025 13:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="aNzM1Vtg"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FB11F3D3E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742995414; cv=none; b=AepomnZYbJy83tZUCeCqAwAJ0kXZMamIDxvlfr0DxvnohhqIPcbOv50MlMzoZydKNcPNYVJ1Pb2JgXWEZh495LhOOP7I1CiudcOlZrm/w/YSOBxgeWxW2hwq4N9Ed39+swHW3QushadzijfWMmPfaSQ2hJiekvwc5TJziP1ZBpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742995414; c=relaxed/simple;
	bh=n4H1G7bDwVSyN9af32Phxvop+mYwINBt64VvrVEfgwI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=npVVksKOj3X3zvuFvzdgFrVmx/pdJC9ntCu41HgCuQpMXP5/hxu8zB31Zfxk3dBMpRJJbUFCH8onssIm+IiD1ifMLXBtu2/rOUINdkpXkEdRgHoqPeAAwgIoSNstpcVjnCs/j8eg9mq0We8besSXzvJLh2GgoZwV28eoDDEganQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=aNzM1Vtg; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id EF1871934;
	Wed, 26 Mar 2025 14:21:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1742995296;
	bh=n4H1G7bDwVSyN9af32Phxvop+mYwINBt64VvrVEfgwI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aNzM1Vtg24SjQ2sJTEyhHj0fPi9/oUHgRzhotAuQ2FagHu6244HzQzebUuZq5N7NI
	 NmqPngMcW2GtVzQClTBLA31x1Yy58zq1Vmi8BM1THzWTHDWrH939P+KKfKGUdOQHae
	 lvu9BKIavW/dEc6P6Hf5+OhFqY7vtfhHzgBEX7UI=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 26 Mar 2025 15:22:51 +0200
Subject: [PATCH v4 08/11] drm: xlnx: zynqmp: Add support for XV15 & XV20
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250326-xilinx-formats-v4-8-322a300c6d72@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=936;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=n4H1G7bDwVSyN9af32Phxvop+mYwINBt64VvrVEfgwI=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBn4//C9nW48zLc5yoHs96DcP2KozatkETh+iI3k
 sHsf2q7YkWJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ+P/wgAKCRD6PaqMvJYe
 9QzSEACFG1eIBhJcW2WERjhx9t+sclrPU9jrPsfmW6Hy3GMW1qy2+p/m6DWqfyix6UPo/bSOhw8
 dIeqvx5BY7SbB9DSbkkQin9yDIbWi9XTwWpRDOkyZtM7Ufw78bchBZlTXu/F2tfQqpA/IgmDpTz
 1fBrPJUxBfDk3xI0LrH/3wlrKYmusg1arVlQt6LjQ7+TR0F+mvKSmMK1uDbq+K54RzexzdBQ+R/
 6dQI0LxArQ6HK4dLRJamSLHXTcbv/ahLCWHH8lAPjw6MVunRe7WOMLFEx0298F+b0Yddb1BrX1l
 4cx254ObM35yYoV3wvSq0RSZWPx1WHD1PKV9ObBF/nTy9DtleV0yr765ce8DXIXej+jOQxp+TOX
 IayCsjWO9S11EsA+Jh/4qUd4fR5kaUaP2oolZgmt28qbdI+iFP91XAxMAhDftDsXWwgnMALTyIW
 IZtr2WKiAKiNEwPiZgC5rkHpoYZeLfzkJbjzYciWJH6zrP4IgE0sgTeGAlfvQ9z0UfuUlHoVGRC
 9fkpu7oSFcwgNSE8FjmG9qsRTlyAP6Epi8WD/NBXtfYWNPYZjzPAFLcHAR58dh005VzGFee/dPW
 7fjdcIhOeipupxtoSYPPsVnsmJ8F2mWRqNKWVX5DMunOhNWe1vjePWEspTrr8vebH02qnpXudto
 TRzs8OZGqR/DGjw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add support for XV15 & XV20 formats.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index b9883ea2d03e..1dc77f2e4262 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -297,6 +297,16 @@ static const struct zynqmp_disp_format avbuf_vid_fmts[] = {
 		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YV16CI_420,
 		.swap		= true,
 		.sf		= scaling_factors_888,
+	}, {
+		.drm_fmt	= DRM_FORMAT_XV15,
+		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YV16CI_420_10,
+		.swap		= false,
+		.sf		= scaling_factors_101010,
+	}, {
+		.drm_fmt	= DRM_FORMAT_XV20,
+		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YV16CI_10,
+		.swap		= false,
+		.sf		= scaling_factors_101010,
 	},
 };
 

-- 
2.43.0


