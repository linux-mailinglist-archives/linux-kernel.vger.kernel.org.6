Return-Path: <linux-kernel+bounces-449493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A894D9F4FE6
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2D5188D689
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 15:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341161F75A3;
	Tue, 17 Dec 2024 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qvqzG+fv"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AFC1F941C;
	Tue, 17 Dec 2024 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734450247; cv=none; b=o4I/mcpxs03mDAeGz8NB10C7d+/OzVuPBfiNselRTSWL8cH7soCT/ibu8zFkcPi4i/9bZ6f9v1C4XwT0nag43SoeNdsChts/tuY8Yd4gvzDwV/oWdCev8l+OfTIdJfkUzJ+e44MAMPsFqu1j+tmYD+y7RSL4DwG5GdHI21XpCyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734450247; c=relaxed/simple;
	bh=Rq1RTaTFd4UgO47Mwy8E30aEASrJfOiNULbmRWKiQEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eFAKBBldyWqlOekJYalStw7fr6/cIQpEsxjVXc/NZWGigRmxMKE7i7Bl/t743OJ7HuRyTl3OB2R689AmF9yT0h1KhvOj1UVSI4LIE2aRYZjXGjre8yLxlNvF/gtbScDT4dRQGfAqMu2rxY4htwR9giFfvnsn+INvPLgIAO62kAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qvqzG+fv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734450243;
	bh=Rq1RTaTFd4UgO47Mwy8E30aEASrJfOiNULbmRWKiQEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qvqzG+fvHrQATR5nSe77xxGyw/VUM1BpY0/NFZz8C0Fy24BaYWX2KXlFw9A3rE0ge
	 eojvzeykpPF3nywpHgb4Hokzt0IApQyM8CMxxWQ2wqhETL2RsetoVLJpFOWD0KmchJ
	 e4mmTWv2j+2HMBqGh3MX14B90ht2o1tfLZTPb6YdMt3SStb2kauOkagAFJtg/yuLoa
	 BLJBz+dldXcQYEHk3urfIG26qPJo+/EC9hVsKald7ez+kP86qM3yhSnDNg17KDJHWV
	 5kaGJ+NN9/vRBnwdAfW9RqTiYZtyzh4ziSiopzniBWpSLO9G1RzPPgeKW0XVwxgHDj
	 76rU8SVvazQmw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 630D817E37BB;
	Tue, 17 Dec 2024 16:44:02 +0100 (CET)
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
Subject: [PATCH v3 09/33] drm/mediatek: mtk_hdmi_ddc: Switch to register as module_platform_driver
Date: Tue, 17 Dec 2024 16:43:21 +0100
Message-ID: <20241217154345.276919-10-angelogioacchino.delregno@collabora.com>
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

With this change, there are no more users of the mtk_hdmi.h header
so, while at it, also remove it.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/gpu/drm/mediatek/mtk_hdmi.c     |  2 --
 drivers/gpu/drm/mediatek/mtk_hdmi.h     | 13 -------------
 drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c |  2 +-
 3 files changed, 1 insertion(+), 16 deletions(-)
 delete mode 100644 drivers/gpu/drm/mediatek/mtk_hdmi.h

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.c b/drivers/gpu/drm/mediatek/mtk_hdmi.c
index b389c08a371a..f620a61db2e0 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi.c
@@ -31,7 +31,6 @@
 #include <drm/drm_probe_helper.h>
 
 #include "mtk_cec.h"
-#include "mtk_hdmi.h"
 #include "mtk_hdmi_regs.h"
 
 #define NCTS_BYTES	7
@@ -1804,7 +1803,6 @@ static struct platform_driver mtk_hdmi_driver = {
 };
 
 static struct platform_driver * const mtk_hdmi_drivers[] = {
-	&mtk_hdmi_ddc_driver,
 	&mtk_hdmi_driver,
 };
 
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi.h b/drivers/gpu/drm/mediatek/mtk_hdmi.h
deleted file mode 100644
index e40bc4651995..000000000000
--- a/drivers/gpu/drm/mediatek/mtk_hdmi.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2014 MediaTek Inc.
- * Author: Jie Qiu <jie.qiu@mediatek.com>
- */
-#ifndef _MTK_HDMI_CTRL_H
-#define _MTK_HDMI_CTRL_H
-
-struct platform_driver;
-
-extern struct platform_driver mtk_hdmi_ddc_driver;
-
-#endif /* _MTK_HDMI_CTRL_H */
diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c b/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
index 07db68067844..6358e1af69b4 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_ddc.c
@@ -20,7 +20,6 @@
 #include <linux/of_platform.h>
 
 #include "mtk_drm_drv.h"
-#include "mtk_hdmi.h"
 
 #define SIF1_CLOK		(288)
 #define DDC_DDCMCTL0		(0x0)
@@ -337,6 +336,7 @@ struct platform_driver mtk_hdmi_ddc_driver = {
 		.of_match_table = mtk_hdmi_ddc_match,
 	},
 };
+module_platform_driver(mtk_hdmi_ddc_driver);
 
 MODULE_AUTHOR("Jie Qiu <jie.qiu@mediatek.com>");
 MODULE_DESCRIPTION("MediaTek HDMI DDC Driver");
-- 
2.47.0


