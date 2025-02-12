Return-Path: <linux-kernel+bounces-510869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BBFA32304
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D9D87A46F4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 733F4209681;
	Wed, 12 Feb 2025 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="n8Y9Oj+s"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D102080D9
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354425; cv=none; b=HpYk50dqcq7rx7mhUwBt0eufhvio5Ggzp3C4XeynUGsfB1n17siNzS4haSRXhB9bFvypGNrfgcQW23zAc4iKAbdGyix6CKo7xVcDiEhxYk97gs7BWo1ZD8bgAaP/5vlQakWigNEJsLwB1X5P7N32afs6vn7bCDfLIjbJieY/Rd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354425; c=relaxed/simple;
	bh=0oCn2xELjVZlzCfZ6/7zjfuG4e61sBTLWv99cxlg43w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OoJXUiC8ceMXRws8fj/fcJkvKCJ3gACYuC/J59Z5bSwep1UMK0nhHrC5Ne55X+e5x0dnXFeE0YaQPc6AexucUgaxGXMEe1hYkSAGt5DbjbXjJuZc2p+JL5TDS23dC+oVWxfAjWU+mbBm5914qR3LJ+fdv5WRQFJCsAWhbrbLWqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=n8Y9Oj+s; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739354422;
	bh=0oCn2xELjVZlzCfZ6/7zjfuG4e61sBTLWv99cxlg43w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n8Y9Oj+sD5RPCq9diQsvFAhZ1kHJpBPrfyxShRxuzIbncDL1opgMkcmcATh6KQk95
	 AE8/iIm9qnP73psINNACJZcHjt9yFT4Qc+V5zhTAgNhNGk6DZ1q6VsUrqZNmS9/OPg
	 3ppqZcXdVminOKu53Ls7lJ4ubWLP4t8+HO7GxWflnKlfvHMwTr0U0d/jEG2zWtM5Wt
	 Jvirn/UI9WX5JVuvTDE5NqbFxlXEPFOMzsZYF1tUYsp3bEodylTx74GC3EZYksfNWn
	 rMeT8699DuAneG3+WuaDVq2tMcsr6oCscYXxfoFOh+TFHo0N/6ueN/jJGHGxqgcaRf
	 idzrBPoHu5eVw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id BCD9117E155A;
	Wed, 12 Feb 2025 11:00:21 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: matthias.bgg@gmail.com
Cc: angelogioacchino.delregno@collabora.com,
	shawn.sung@mediatek.com,
	fparent@baylibre.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	pablo.sun@mediatek.com,
	kernel@collabora.com
Subject: [PATCH v1 6/8] soc: mediatek: mt8365-mmsys: Fix routing table masks and values
Date: Wed, 12 Feb 2025 11:00:10 +0100
Message-ID: <20250212100012.33001-7-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212100012.33001-1-angelogioacchino.delregno@collabora.com>
References: <20250212100012.33001-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mmsys driver reads the routing table and writes to the
hardware `val & mask`, but multiple entries in the mmsys
routing table for the MT8365 SoC are setting a 0x0 mask:
this effectively writes .. nothing .. to the hardware.

That would never work, and if the display controller was
actually working with the mmsys doing no routing at all,
that was only because the bootloader was correctly setting
the display controller routing registers before booting the
kernel, and the mmsys was never reset.

Make this table to actually set the routing by adding the
correct register masks to it.

While at it, also change MOUT val definitions to BIT(x), as
the MOUT registers are effectively checking for each bit to
enable output to the corresponding HW.
Please note that, for this SoC, only the MOUT registers are
checking bits (as those can enable multiple outputs), while
the others are purely reading a number to select an input.

Fixes: bc3fc5c05100 ("soc: mediatek: mmsys: add MT8365 support")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mt8365-mmsys.h | 48 ++++++++++++-----------------
 1 file changed, 20 insertions(+), 28 deletions(-)

diff --git a/drivers/soc/mediatek/mt8365-mmsys.h b/drivers/soc/mediatek/mt8365-mmsys.h
index 7abaf048d91e..ae37945e6c67 100644
--- a/drivers/soc/mediatek/mt8365-mmsys.h
+++ b/drivers/soc/mediatek/mt8365-mmsys.h
@@ -14,8 +14,9 @@
 #define MT8365_DISP_REG_CONFIG_DISP_DPI0_SEL_IN		0xfd8
 #define MT8365_DISP_REG_CONFIG_DISP_LVDS_SYS_CFG_00	0xfdc
 
+#define MT8365_DISP_MS_IN_OUT_MASK			GENMASK(3, 0)
 #define MT8365_RDMA0_SOUT_COLOR0			0x1
-#define MT8365_DITHER_MOUT_EN_DSI0			0x1
+#define MT8365_DITHER_MOUT_EN_DSI0			BIT(0)
 #define MT8365_DSI0_SEL_IN_DITHER			0x1
 #define MT8365_RDMA0_SEL_IN_OVL0			0x0
 #define MT8365_RDMA0_RSZ0_SEL_IN_RDMA0			0x0
@@ -30,52 +31,43 @@ static const struct mtk_mmsys_routes mt8365_mmsys_routing_table[] = {
 	{
 		DDP_COMPONENT_OVL0, DDP_COMPONENT_RDMA0,
 		MT8365_DISP_REG_CONFIG_DISP_OVL0_MOUT_EN,
-		MT8365_OVL0_MOUT_PATH0_SEL, MT8365_OVL0_MOUT_PATH0_SEL
-	},
-	{
+		MT8365_DISP_MS_IN_OUT_MASK, MT8365_OVL0_MOUT_PATH0_SEL
+	}, {
 		DDP_COMPONENT_OVL0, DDP_COMPONENT_RDMA0,
 		MT8365_DISP_REG_CONFIG_DISP_RDMA0_SEL_IN,
-		MT8365_RDMA0_SEL_IN_OVL0, MT8365_RDMA0_SEL_IN_OVL0
-	},
-	{
+		MT8365_DISP_MS_IN_OUT_MASK, MT8365_RDMA0_SEL_IN_OVL0
+	}, {
 		DDP_COMPONENT_RDMA0, DDP_COMPONENT_COLOR0,
 		MT8365_DISP_REG_CONFIG_DISP_RDMA0_SOUT_SEL,
-		MT8365_RDMA0_SOUT_COLOR0, MT8365_RDMA0_SOUT_COLOR0
-	},
-	{
+		MT8365_DISP_MS_IN_OUT_MASK, MT8365_RDMA0_SOUT_COLOR0
+	}, {
 		DDP_COMPONENT_COLOR0, DDP_COMPONENT_CCORR,
 		MT8365_DISP_REG_CONFIG_DISP_COLOR0_SEL_IN,
-		MT8365_DISP_COLOR_SEL_IN_COLOR0,MT8365_DISP_COLOR_SEL_IN_COLOR0
-	},
-	{
+		MT8365_DISP_MS_IN_OUT_MASK, MT8365_DISP_COLOR_SEL_IN_COLOR0
+	}, {
 		DDP_COMPONENT_DITHER0, DDP_COMPONENT_DSI0,
 		MT8365_DISP_REG_CONFIG_DISP_DITHER0_MOUT_EN,
-		MT8365_DITHER_MOUT_EN_DSI0, MT8365_DITHER_MOUT_EN_DSI0
-	},
-	{
+		MT8365_DISP_MS_IN_OUT_MASK, MT8365_DITHER_MOUT_EN_DSI0
+	}, {
 		DDP_COMPONENT_DITHER0, DDP_COMPONENT_DSI0,
 		MT8365_DISP_REG_CONFIG_DISP_DSI0_SEL_IN,
-		MT8365_DSI0_SEL_IN_DITHER, MT8365_DSI0_SEL_IN_DITHER
-	},
-	{
+		MT8365_DISP_MS_IN_OUT_MASK, MT8365_DSI0_SEL_IN_DITHER
+	}, {
 		DDP_COMPONENT_RDMA0, DDP_COMPONENT_COLOR0,
 		MT8365_DISP_REG_CONFIG_DISP_RDMA0_RSZ0_SEL_IN,
-		MT8365_RDMA0_RSZ0_SEL_IN_RDMA0, MT8365_RDMA0_RSZ0_SEL_IN_RDMA0
-	},
-	{
+		MT8365_DISP_MS_IN_OUT_MASK, MT8365_RDMA0_RSZ0_SEL_IN_RDMA0
+	}, {
 		DDP_COMPONENT_RDMA1, DDP_COMPONENT_DPI0,
 		MT8365_DISP_REG_CONFIG_DISP_LVDS_SYS_CFG_00,
 		MT8365_LVDS_SYS_CFG_00_SEL_LVDS_PXL_CLK, MT8365_LVDS_SYS_CFG_00_SEL_LVDS_PXL_CLK
-	},
-	{
+	}, {
 		DDP_COMPONENT_RDMA1, DDP_COMPONENT_DPI0,
 		MT8365_DISP_REG_CONFIG_DISP_DPI0_SEL_IN,
-		MT8365_DPI0_SEL_IN_RDMA1, MT8365_DPI0_SEL_IN_RDMA1
-	},
-	{
+		MT8365_DISP_MS_IN_OUT_MASK, MT8365_DPI0_SEL_IN_RDMA1
+	}, {
 		DDP_COMPONENT_RDMA1, DDP_COMPONENT_DPI0,
 		MT8365_DISP_REG_CONFIG_DISP_RDMA1_SOUT_SEL,
-		MT8365_RDMA1_SOUT_DPI0, MT8365_RDMA1_SOUT_DPI0
+		MT8365_DISP_MS_IN_OUT_MASK, MT8365_RDMA1_SOUT_DPI0
 	},
 };
 
-- 
2.48.1


