Return-Path: <linux-kernel+bounces-510870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0263CA32305
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:01:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87D48188A5EB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FA6209F4F;
	Wed, 12 Feb 2025 10:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kzZH5fRn"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBB92080E7
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354426; cv=none; b=Pvs5VYH6YDreas9vdshrFkyU/yFQyez8Y+wTwWPdW5535kd/v+MqrVzjTY9kzyb2DoZdn6s/ISG1JJzBT3VEWIpK1HyNoC19tYm2pL5j6WIJ4ek9TPQL6Rv+r+6ZmWrL9WTzK0NqudSxFZgE8f3+xwPihUvfogN0Q52OniK158w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354426; c=relaxed/simple;
	bh=5t1pOw/RmPVLN0/9D4JVG3zITCY2l9s7W0UVjdfG4SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okyMQhPphF45hhtCkr4teYCymAXKEEDtBkCQR+JxQIvnlIly/GQxs5AmNGMieh6IkefyA+IYD5QXjwNPsNWSPR6ZL9P6Dmc7g4YzFtcr5ZqNHJ9bWWAtHn74lt/xHcq35yvRMx29165UtKjXtoG5pwmolMZprgl1u3sdt8oMY5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kzZH5fRn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739354421;
	bh=5t1pOw/RmPVLN0/9D4JVG3zITCY2l9s7W0UVjdfG4SQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kzZH5fRnZEcY/UbfOJWkpOi5EP9/KoZ5qpY9+K0h+siPziefb1DRSiana9Ji1TGB0
	 UoJ/ObmR5IFAOE7u22m8gEN9d+aeyM84XPGDV5yfSNzo1b4YGV6pH3NEs45XzI1MzH
	 Yu8tHcjmfVSwDRg4d13UWkEe9kA7RJExTGLZZxhQHBL49YWorXCxbQwNfQp5Y2GpBW
	 PZSvkgHiLGAtDcgHGaDaP5tvZMrx5QBF7c23j/cE/Xe4rlMNuY5iNGakBV8hL+6RJe
	 t9SPA+IzmUb3a1ydiW1hrSbMlomW3mz1Z4LR5jiAs6p/5Alhu5zp+w6XPzQgm7K0wu
	 JAnMN6nt6b7Rw==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 18C7517E1558;
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
Subject: [PATCH v1 5/8] soc: mediatek: mt8167-mmsys: Fix missing regval in all entries
Date: Wed, 12 Feb 2025 11:00:09 +0100
Message-ID: <20250212100012.33001-6-angelogioacchino.delregno@collabora.com>
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

The mmsys routing table for this SoC was effectively missing
initialization of the val variable of struct mtk_mmsys_routes:
this means that `val` was incorrectly initialized to zero,
hence the registers were wrongly initialized.

Add the required regval to all of the entries of the routing
table for this SoC to fix display controller functionality.

Fixes: 060f7875bd23 ("soc: mediatek: mmsys: Add support for MT8167 SoC")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mt8167-mmsys.h | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/mediatek/mt8167-mmsys.h b/drivers/soc/mediatek/mt8167-mmsys.h
index f7a35b3656bb..655ef962abe9 100644
--- a/drivers/soc/mediatek/mt8167-mmsys.h
+++ b/drivers/soc/mediatek/mt8167-mmsys.h
@@ -17,18 +17,23 @@ static const struct mtk_mmsys_routes mt8167_mmsys_routing_table[] = {
 	{
 		DDP_COMPONENT_OVL0, DDP_COMPONENT_COLOR0,
 		MT8167_DISP_REG_CONFIG_DISP_OVL0_MOUT_EN, OVL0_MOUT_EN_COLOR0,
+		OVL0_MOUT_EN_COLOR0
 	}, {
 		DDP_COMPONENT_DITHER0, DDP_COMPONENT_RDMA0,
-		MT8167_DISP_REG_CONFIG_DISP_DITHER_MOUT_EN, MT8167_DITHER_MOUT_EN_RDMA0
+		MT8167_DISP_REG_CONFIG_DISP_DITHER_MOUT_EN, MT8167_DITHER_MOUT_EN_RDMA0,
+		MT8167_DITHER_MOUT_EN_RDMA0
 	}, {
 		DDP_COMPONENT_OVL0, DDP_COMPONENT_COLOR0,
-		MT8167_DISP_REG_CONFIG_DISP_COLOR0_SEL_IN, COLOR0_SEL_IN_OVL0
+		MT8167_DISP_REG_CONFIG_DISP_COLOR0_SEL_IN, COLOR0_SEL_IN_OVL0,
+		COLOR0_SEL_IN_OVL0
 	}, {
 		DDP_COMPONENT_RDMA0, DDP_COMPONENT_DSI0,
-		MT8167_DISP_REG_CONFIG_DISP_DSI0_SEL_IN, MT8167_DSI0_SEL_IN_RDMA0
+		MT8167_DISP_REG_CONFIG_DISP_DSI0_SEL_IN, MT8167_DSI0_SEL_IN_RDMA0,
+		MT8167_DSI0_SEL_IN_RDMA0
 	}, {
 		DDP_COMPONENT_RDMA0, DDP_COMPONENT_DSI0,
-		MT8167_DISP_REG_CONFIG_DISP_RDMA0_SOUT_SEL_IN, MT8167_RDMA0_SOUT_DSI0
+		MT8167_DISP_REG_CONFIG_DISP_RDMA0_SOUT_SEL_IN, MT8167_RDMA0_SOUT_DSI0,
+		MT8167_RDMA0_SOUT_DSI0
 	},
 };
 
-- 
2.48.1


