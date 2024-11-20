Return-Path: <linux-kernel+bounces-415760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E25C9D3B0A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 13:47:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F97282D0A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 12:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C8441A76C6;
	Wed, 20 Nov 2024 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VJNToTZu"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB201A7AFD;
	Wed, 20 Nov 2024 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732106734; cv=none; b=n64ErXZ9qCLdI4Q3FaGNxg8P8E+TOmVybUj3wbISvL1mkUCPuLy4bGZ3WNKOEJNxVpkp2Pr2O5xQX3SbUHQlBLPwBGrXth9Cfm90ZCmj8IboCBXOkf/r1rSWdE/XGW1XTnu/7SOX1MZH7rG9JBmnvOpyR19HDZzigtuj69xrp6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732106734; c=relaxed/simple;
	bh=YvXp9iAM0sfJIO9S6Cz6CwfErEPbMQs4Cq24WKsOvIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HOLqBg3fDugOiYH6qHIEpXItjmyeAxXxLWf9ByU7hObWc8FU0BdtfoWdwXfwnEPwwXFgjrz9TKQ36oENzWM31f5924mhC+zjwFi9/Xh/qEmTb/cwYNSUWh37m3vAIbrp60lFzCei60OJOeTKM20WvR8azLcdT+4hra6TDy3nZRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VJNToTZu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1732106729;
	bh=YvXp9iAM0sfJIO9S6Cz6CwfErEPbMQs4Cq24WKsOvIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VJNToTZueYZV5ijGsCOfyQy8ojOFmLLm+5OQh/D+Dv2R5oxnCgB8DwMnUKgFMqUxi
	 Z2UNWE4xEpXdQSniVk5rpFxpjHsScHH0qkantI2SSQ1/cwlsowUUrhT1g1A1gb8XP2
	 hS2TH9XmrpL71Wgi4zcCuFC0SAyLVskvrsY7sYrCQjU+hiYJ2pBSYy22ZoGLlFPYh6
	 07W8AYfFo9PlIsQ6Zw3ydXwGkqJK7ozWytGQwvculNrFltd3RTzNiEFdRQM5NwSwlg
	 iDdLBcHKGfFkLTpj0VQiH/6MXZvXRIKGryCOYxd91nmXPTVySGoPMaCVIUbR+WFxF3
	 sPIzl/uq/Kmrg==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AEA0E17E367E;
	Wed, 20 Nov 2024 13:45:28 +0100 (CET)
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
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v1 3/7] drm/mediatek: mtk_cec: Switch to register as module_platform_driver
Date: Wed, 20 Nov 2024 13:45:08 +0100
Message-ID: <20241120124512.134278-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241120124512.134278-1-angelogioacchino.delregno@collabora.com>
References: <20241120124512.134278-1-angelogioacchino.delregno@collabora.com>
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
index 2de248443147..263ae3b4c4df 100644
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
index 7687f673964e..73ab88015d7f 100644
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


