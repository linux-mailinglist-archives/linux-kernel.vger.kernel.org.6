Return-Path: <linux-kernel+bounces-511322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 060B8A3295A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 15:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62D723A7DAC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE9C253B4D;
	Wed, 12 Feb 2025 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="ZnwfX5Wc"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BDF253347
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 14:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739372232; cv=none; b=uNc52vPqApBHorcPaAr14UiJcay13l7i0RdMKvj0Z79cs5/GGQqaSVvO7JLt8DTe0FEQfwhIJ5ve/QixFl3daxYS0VlCStfnx3O1xEdtREr6L1wpOMwtQ9mryNQB14wi9RH4Y55fTi/+lUDFHTf/iBTm2DGfG06cAPBoW9ELnbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739372232; c=relaxed/simple;
	bh=DxQP+SXSvEVysld5s1g7qrAaoZ/u/BhlAP3hHBtstmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F0oH7xmEKjOHz5DDiD3WR/oyza9Q+jxjMyL8CTfObDGwa/O/U+r93bLjqkWHglHoegZJ+Ns1IgnywsbsIdfGUIGzOi09ITnC1vpjnX53PR3R1rmRlGgLzqsBc/hSyBf987QlFPrjJlSASkD3Ju+2tlGSNqioqIEKBQns0mB2EEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=ZnwfX5Wc; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5EBA81B24;
	Wed, 12 Feb 2025 15:55:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1739372138;
	bh=DxQP+SXSvEVysld5s1g7qrAaoZ/u/BhlAP3hHBtstmw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZnwfX5WcqsLoJ+3YW/8djlsrbdcLA7/HUdhLxTX5WXanXpzn/HHWxxSMhdL8CAEJb
	 cABInYb9PZUdKvq/fIBthuiURSRaFf9cCR8q9K+1BWFp84euXFaMtGRQdX2LtWcJeX
	 JIX5MfM8FH7LCuQwJBI7ZeGZzqhMecaLLzJ3cGqc=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 12 Feb 2025 16:56:15 +0200
Subject: [PATCH v3 11/11] drm: xlnx: zynqmp: Add support for XVUY2101010
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-xilinx-formats-v3-11-90d0fe106995@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=781;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=DxQP+SXSvEVysld5s1g7qrAaoZ/u/BhlAP3hHBtstmw=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBnrLasSYwlnmhIHTEWBtOZAYSzkaegMe8FZW3k3
 o3I5HHP7PmJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ6y2rAAKCRD6PaqMvJYe
 9S99D/95eYK7tFxPCEW4xkmzObP5DNZWZm76zEKvCZYWftqusZPxjG/thjpmTecXWx14oBK4c3c
 Miarmq937Cfkw8L/AJZ40HBAmAagfIG/SGqBJIvVx7KVoDk0/wGQJGA6ADq2jpymmTXL2Ovfgzn
 /3Y6fwTaIUORIR8QrobAkvRyKlLXZipGVpls0+zkeKjwTzaVV0NOy4Yv8+H2+45ZWMvCQvGlFDi
 Waszub4Vz/InKO66DQn0DdlDSUSdXr1A+fKQvRCwGv5/WwO1WMVgFMS51Nx8D+YphhO7a64+H7X
 TZj2QBFnEVicX1bo3F5KuqJIKnXhLhg1TZo/Ab80jRz9jBE6x49iXY+7WERaaqf8GWoEjdBnPX9
 d9E95wEMv29nLQf5HQbON3lmmz6YE0pcDyqo56iPoy4EMQjWDy6hSXHUkb6438glqsQ8H5MOLnb
 hrkWE2TZzS9rjiEZOkLViu00cxcm5DyPR6XlvztLrpiaOGijI7AoDcAvRVi0xDAmUvGVnV4ejs1
 AgEh+BHrL9d7Ahm9QbaZFqEVJLPccsu/QiDjYYBxISZVFcaH9MBQifYcZCXwrOEqK30xqkeYVX9
 w3ikLD96CjcyPUtPrWE0D0YcFxnLe76Sx3tEPSilowwKGx2ioG1H5xerBZ6TkDWVWBeQasXNNxd
 EvFIYhdwFnla6Tg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add support for XVUY2101010 format.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 7495e42677a6..859ee050a668 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -322,6 +322,11 @@ static const struct zynqmp_disp_format avbuf_vid_fmts[] = {
 		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YV24_10,
 		.swap		= false,
 		.sf		= scaling_factors_101010,
+	}, {
+		.drm_fmt	= DRM_FORMAT_XVUY2101010,
+		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YUV444_10,
+		.swap		= false,
+		.sf		= scaling_factors_101010,
 	},
 };
 

-- 
2.43.0


