Return-Path: <linux-kernel+bounces-449492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AB39F4FE4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58E9416C897
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9071F942E;
	Tue, 17 Dec 2024 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Wg/vWKxo"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3201F8F16;
	Tue, 17 Dec 2024 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734450245; cv=none; b=CHsyz9wbhRAbjY9ozyYAbQJFCO194HAV6RXdfHmjX+fFcl/8FrapUCvgK93o0lXs9fREAUYeQFd8Qs7RZ4z0jpYFa/rMUos7kJjE18gufKMjKUIZinCClBZYe5vZ9sc3tMzrSzCZh7YQr/6toqValCwbuSmvdQoVYXZxq6qlH6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734450245; c=relaxed/simple;
	bh=0kQ9CG00Zs7uAg0ajb3mV7jivmOLBwDSkXLSjQR1R24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ubG/JU2brWFUUVAPrZuG152i+XHRqjWpyYpTFoFrIN+Yd/41ryxgRlSoKg+3Yp9YncLV871lLoE8GigqPISyuvg3k6GrmLbO744p54HP9/byumoJygs4kjFsrIg5AXWLs2XeAKD1z0UXSvhT3rQ+ha5u4vcd3klEuojKQITdRPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Wg/vWKxo; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734450242;
	bh=0kQ9CG00Zs7uAg0ajb3mV7jivmOLBwDSkXLSjQR1R24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wg/vWKxobEvVrOgRsCcFnQYSQ9nDiosPdo5VCMO7olRbdGvlOlHVmAEPT/2BBJSyu
	 aai4lFGWW8JZHrW/9RIwHPQShCTzZXj/jvPqNVBNvQRtaPu97rxxQBPKQ7lnu1p/71
	 UqQ4nVIgsbXHjJBlPByFLu+JtbaQ/RBLCGnRJdgW8QpWE7vdE/I0aylI9J9AH4btJS
	 dryhBc03LYIqsHUnEzn37L5hv9V+jrhmKN/4jbV56Pj1SLNNqMEkS/7djh3tnIVqsH
	 Cf8e35hPWFoz94P4RSXoIUdAoH/fy09a1pOt3IasG9/fqT3MPQaUwxiUg9KkUhHrqm
	 RtsG8KBUmyF7A==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EBC3B17E37B9;
	Tue, 17 Dec 2024 16:44:00 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	ck.hu@mediatek.com,
	jitao.shi@mediatek.com,
	jie.qiu@mediatek.com,
	junzhi.zhao@mediatek.com,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com,
	dmitry.baryshkov@linaro.org
Subject: [PATCH v3 08/33] drm/mediatek: mtk_cec: Switch to register as module_platform_driver
Date: Tue, 17 Dec 2024 16:43:20 +0100
Message-ID: <20241217154345.276919-9-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241217154345.276919-1-angelogioacchino.delregno@collabora.com>
References: <20241217154345.276919-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for splitting out the common bits from the HDMI
driver, change the mtk_cec driver from being registered from the
HDMI driver itself to be a module_platform_driver of its own.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_cec.c  | 5 ++++-
 drivers/gpu/drm/mediatek/mtk_hdmi.c | 1 -
 drivers/gpu/drm/mediatek/mtk_hdmi.h | 1 -
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_cec.c b/drivers/gpu/drm/mediatek/mtk_cec.c
index b42c0d87eba3..8dad762e24b8 100644
--- a/drivers/gpu/drm/mediatek/mtk_cec.c
+++ b/drivers/gpu/drm/mediatek/mtk_cec.c
@@ -12,7 +12,6 @@
 #include <linux/platform_device.h>
 
 #include "mtk_cec.h"
-#include "mtk_hdmi.h"
 #include "mtk_drm_drv.h"
 
 #define TR_CONFIG		0x00
@@ -247,3 +246,7 @@ struct platform_driver mtk_cec_driver = {
 		.of_match_table = mtk_cec_of_ids,
 	},
 };
+module_platform_driver(mtk_cec_driver);
+
+MODULE_DESCRIPTION("MediaTek HDMI CEC Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index 70dc1d4460ad..b389c08a371a 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -1805,7 +1805,6 @@ static struct platform_driver mtk_hdmi_driver = {
 
 static struct platform_driver * const mtk_hdmi_drivers[] = {
 	&mtk_hdmi_ddc_driver,
-	&mtk_cec_driver,
 	&mtk_hdmi_driver,
 };
 
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.h b/drivers/gpu/drm/mediatek/mtk_hdmi.h
index 472bf141c92b..e40bc4651995 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.h
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.h
@@ -8,7 +8,6 @@
 
 struct platform_driver;
 
-extern struct platform_driver mtk_cec_driver;
 extern struct platform_driver mtk_hdmi_ddc_driver;
 
 #endif /* _MTK_HDMI_CTRL_H */
-- 
2.47.0


