Return-Path: <linux-kernel+bounces-265730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1581A93F54B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 14:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25D002829CE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 12:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4953D147C89;
	Mon, 29 Jul 2024 12:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="p2Tr3xUN"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D1813CFA5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2024 12:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722255950; cv=none; b=mwMNcBj5cl1Pu3OKy13qmggxRq4/m/RhXsUEGyhZ4k/h8qyuTEdiasYOe7VH7VQhjChP887PXOEOA7KGzrFyEsiN+Qu0QzgSFbFjpOhH21ChmdU/xvQYxBNdWm1WIVvYie1xB6NaVwfH4wXxSKxP9Cd1uPv1edWgJGENOeDDZf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722255950; c=relaxed/simple;
	bh=Ss4a9Tumgb/hU3BQ8LLOz+BBWNeTNWFKWPUbY0WPOFg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rfWSjV2eGElc+N+oKvFmeLA4tofzymC0gFNxflaTx4M+MDXQPdlvBzXaKTgkQ2a4QdCfBQp9hzYzsp7nGC9/1laSHHko7Du3/9hrS2YekG6mqycCTNArRR9S+pWfM48gAeIIkeBk+d4GyOCU3Ay9y3moK403U2ldV4n3c1ff5tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=p2Tr3xUN; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1722255946;
	bh=Ss4a9Tumgb/hU3BQ8LLOz+BBWNeTNWFKWPUbY0WPOFg=;
	h=From:To:Cc:Subject:Date:From;
	b=p2Tr3xUNZFQfJ5q+LPjnVzvPgS7ha9IBqvC26q0HbPhQGhctFcC1wjmFsTcDQhFiT
	 xX4KYi/vxR+qgmkrckiTy5AvFOioZpU0/iKYlxEFuWyBO80iio7qZdgWdNw3Ig8Nuk
	 avVVlNVnx8tk/VA0u/DvtJO8ItzGEXWIa3SEgpOwbdC7AuMSgDA9XPH3YMKcJGkFHc
	 bCqyQBUy0TmQ2xl/qIuP5IHB4fQ1haGrEjKOttzg6IDA5xwAqh7IjFV75f68EJhwbA
	 1tihIpJgK+tzaaqs3l1dZarxflmRr9b1YORrSEASjh2Eotjjg3oQPYT+iHgBWOUpmE
	 BboGw+qjVAaaw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0239437804D4;
	Mon, 29 Jul 2024 12:25:45 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: linux-mediatek@lists.infradead.org
Cc: matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH] soc: mediatek: mtk-mutex: Reduce type size for mtk_mutex_data members
Date: Mon, 29 Jul 2024 14:25:38 +0200
Message-ID: <20240729122538.989855-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All of mutex_mod and mutex_table_mod contain an array of bit
numbers, which can go from 0 to 63, it is hence not needed to
use an unsigned 32-bits integer to store that: change them to
unsigned 8-bits instead.

As for the mutex_sof table since this directly contains the values
to write to the DISP_MUTEXn_CTL register, which has only bits [13:0]
(so this register is effectively 14 bits long), change that to use
unsigned 16-bits.

The type of mutex_{mod,sof}_reg was also changed to 16 bits, as
the maximum value that those will ever have is 0x800, because it
calculates as 0x30 + (0x20 * n) where n's maximum value is 63.

This reduces module size and brings no functional changes.

Before:
   text	   data	    bss	    dec	    hex	filename
   9929	    512	      0	  10441	   28c9	mtk-mutex.o

After:
   text	   data	    bss	    dec	    hex	filename
   7425	    512	      0	   7937	   1f01	mtk-mutex.o

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-mutex.c | 52 ++++++++++++++++----------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index 0ad8754e4361..09bf9e9f29bc 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -327,11 +327,11 @@ enum mtk_mutex_sof_id {
 };
 
 struct mtk_mutex_data {
-	const unsigned int *mutex_mod;
-	const unsigned int *mutex_sof;
-	const unsigned int mutex_mod_reg;
-	const unsigned int mutex_sof_reg;
-	const unsigned int *mutex_table_mod;
+	const u8 *mutex_mod;
+	const u8 *mutex_table_mod;
+	const u16 *mutex_sof;
+	const u16 mutex_mod_reg;
+	const u16 mutex_sof_reg;
 	const bool no_clk;
 };
 
@@ -345,7 +345,7 @@ struct mtk_mutex_ctx {
 	struct cmdq_client_reg		cmdq_reg;
 };
 
-static const unsigned int mt2701_mutex_mod[DDP_COMPONENT_ID_MAX] = {
+static const u8 mt2701_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_BLS] = MT2701_MUTEX_MOD_DISP_BLS,
 	[DDP_COMPONENT_COLOR0] = MT2701_MUTEX_MOD_DISP_COLOR,
 	[DDP_COMPONENT_OVL0] = MT2701_MUTEX_MOD_DISP_OVL,
@@ -354,7 +354,7 @@ static const unsigned int mt2701_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_WDMA0] = MT2701_MUTEX_MOD_DISP_WDMA,
 };
 
-static const unsigned int mt2712_mutex_mod[DDP_COMPONENT_ID_MAX] = {
+static const u8 mt2712_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_AAL0] = MT2712_MUTEX_MOD_DISP_AAL0,
 	[DDP_COMPONENT_AAL1] = MT2712_MUTEX_MOD2_DISP_AAL1,
 	[DDP_COMPONENT_COLOR0] = MT2712_MUTEX_MOD_DISP_COLOR0,
@@ -374,7 +374,7 @@ static const unsigned int mt2712_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_WDMA1] = MT2712_MUTEX_MOD_DISP_WDMA1,
 };
 
-static const unsigned int mt8167_mutex_mod[DDP_COMPONENT_ID_MAX] = {
+static const u8 mt8167_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_AAL0] = MT8167_MUTEX_MOD_DISP_AAL,
 	[DDP_COMPONENT_CCORR] = MT8167_MUTEX_MOD_DISP_CCORR,
 	[DDP_COMPONENT_COLOR0] = MT8167_MUTEX_MOD_DISP_COLOR,
@@ -389,7 +389,7 @@ static const unsigned int mt8167_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_WDMA0] = MT8167_MUTEX_MOD_DISP_WDMA0,
 };
 
-static const unsigned int mt8173_mutex_mod[DDP_COMPONENT_ID_MAX] = {
+static const u8 mt8173_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_AAL0] = MT8173_MUTEX_MOD_DISP_AAL,
 	[DDP_COMPONENT_COLOR0] = MT8173_MUTEX_MOD_DISP_COLOR0,
 	[DDP_COMPONENT_COLOR1] = MT8173_MUTEX_MOD_DISP_COLOR1,
@@ -407,7 +407,7 @@ static const unsigned int mt8173_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_WDMA1] = MT8173_MUTEX_MOD_DISP_WDMA1,
 };
 
-static const unsigned int mt8183_mutex_mod[DDP_COMPONENT_ID_MAX] = {
+static const u8 mt8183_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_AAL0] = MT8183_MUTEX_MOD_DISP_AAL0,
 	[DDP_COMPONENT_CCORR] = MT8183_MUTEX_MOD_DISP_CCORR0,
 	[DDP_COMPONENT_COLOR0] = MT8183_MUTEX_MOD_DISP_COLOR0,
@@ -421,7 +421,7 @@ static const unsigned int mt8183_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_WDMA0] = MT8183_MUTEX_MOD_DISP_WDMA0,
 };
 
-static const unsigned int mt8183_mutex_table_mod[MUTEX_MOD_IDX_MAX] = {
+static const u8 mt8183_mutex_table_mod[MUTEX_MOD_IDX_MAX] = {
 	[MUTEX_MOD_IDX_MDP_RDMA0] = MT8183_MUTEX_MOD_MDP_RDMA0,
 	[MUTEX_MOD_IDX_MDP_RSZ0] = MT8183_MUTEX_MOD_MDP_RSZ0,
 	[MUTEX_MOD_IDX_MDP_RSZ1] = MT8183_MUTEX_MOD_MDP_RSZ1,
@@ -432,7 +432,7 @@ static const unsigned int mt8183_mutex_table_mod[MUTEX_MOD_IDX_MAX] = {
 	[MUTEX_MOD_IDX_MDP_CCORR0] = MT8183_MUTEX_MOD_MDP_CCORR0,
 };
 
-static const unsigned int mt8186_mutex_mod[DDP_COMPONENT_ID_MAX] = {
+static const u8 mt8186_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_AAL0] = MT8186_MUTEX_MOD_DISP_AAL0,
 	[DDP_COMPONENT_CCORR] = MT8186_MUTEX_MOD_DISP_CCORR0,
 	[DDP_COMPONENT_COLOR0] = MT8186_MUTEX_MOD_DISP_COLOR0,
@@ -445,7 +445,7 @@ static const unsigned int mt8186_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_RDMA1] = MT8186_MUTEX_MOD_DISP_RDMA1,
 };
 
-static const unsigned int mt8186_mdp_mutex_table_mod[MUTEX_MOD_IDX_MAX] = {
+static const u8 mt8186_mdp_mutex_table_mod[MUTEX_MOD_IDX_MAX] = {
 	[MUTEX_MOD_IDX_MDP_RDMA0] = MT8186_MUTEX_MOD_MDP_RDMA0,
 	[MUTEX_MOD_IDX_MDP_RSZ0] = MT8186_MUTEX_MOD_MDP_RSZ0,
 	[MUTEX_MOD_IDX_MDP_RSZ1] = MT8186_MUTEX_MOD_MDP_RSZ1,
@@ -456,7 +456,7 @@ static const unsigned int mt8186_mdp_mutex_table_mod[MUTEX_MOD_IDX_MAX] = {
 	[MUTEX_MOD_IDX_MDP_COLOR0] = MT8186_MUTEX_MOD_MDP_COLOR0,
 };
 
-static const unsigned int mt8188_mutex_mod[DDP_COMPONENT_ID_MAX] = {
+static const u8 mt8188_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_OVL0] = MT8188_MUTEX_MOD_DISP_OVL0,
 	[DDP_COMPONENT_WDMA0] = MT8188_MUTEX_MOD_DISP_WDMA0,
 	[DDP_COMPONENT_RDMA0] = MT8188_MUTEX_MOD_DISP_RDMA0,
@@ -496,7 +496,7 @@ static const unsigned int mt8188_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_MERGE5] = MT8188_MUTEX_MOD_DISP1_VPP_MERGE4,
 };
 
-static const unsigned int mt8188_mdp_mutex_table_mod[MUTEX_MOD_IDX_MAX] = {
+static const u8 mt8188_mdp_mutex_table_mod[MUTEX_MOD_IDX_MAX] = {
 	[MUTEX_MOD_IDX_MDP_RDMA0] = MT8195_MUTEX_MOD_MDP_RDMA0,
 	[MUTEX_MOD_IDX_MDP_RDMA2] = MT8195_MUTEX_MOD_MDP_RDMA2,
 	[MUTEX_MOD_IDX_MDP_RDMA3] = MT8195_MUTEX_MOD_MDP_RDMA3,
@@ -530,7 +530,7 @@ static const unsigned int mt8188_mdp_mutex_table_mod[MUTEX_MOD_IDX_MAX] = {
 	[MUTEX_MOD_IDX_MDP_WROT3] = MT8195_MUTEX_MOD_MDP_WROT3,
 };
 
-static const unsigned int mt8192_mutex_mod[DDP_COMPONENT_ID_MAX] = {
+static const u8 mt8192_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_AAL0] = MT8192_MUTEX_MOD_DISP_AAL0,
 	[DDP_COMPONENT_CCORR] = MT8192_MUTEX_MOD_DISP_CCORR0,
 	[DDP_COMPONENT_COLOR0] = MT8192_MUTEX_MOD_DISP_COLOR0,
@@ -544,7 +544,7 @@ static const unsigned int mt8192_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_RDMA4] = MT8192_MUTEX_MOD_DISP_RDMA4,
 };
 
-static const unsigned int mt8195_mutex_mod[DDP_COMPONENT_ID_MAX] = {
+static const u8 mt8195_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_OVL0] = MT8195_MUTEX_MOD_DISP_OVL0,
 	[DDP_COMPONENT_WDMA0] = MT8195_MUTEX_MOD_DISP_WDMA0,
 	[DDP_COMPONENT_RDMA0] = MT8195_MUTEX_MOD_DISP_RDMA0,
@@ -575,7 +575,7 @@ static const unsigned int mt8195_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_DP_INTF1] = MT8195_MUTEX_MOD_DISP1_DP_INTF0,
 };
 
-static const unsigned int mt8195_mutex_table_mod[MUTEX_MOD_IDX_MAX] = {
+static const u8 mt8195_mutex_table_mod[MUTEX_MOD_IDX_MAX] = {
 	[MUTEX_MOD_IDX_MDP_RDMA0] = MT8195_MUTEX_MOD_MDP_RDMA0,
 	[MUTEX_MOD_IDX_MDP_RDMA1] = MT8195_MUTEX_MOD_MDP_RDMA1,
 	[MUTEX_MOD_IDX_MDP_RDMA2] = MT8195_MUTEX_MOD_MDP_RDMA2,
@@ -621,7 +621,7 @@ static const unsigned int mt8195_mutex_table_mod[MUTEX_MOD_IDX_MAX] = {
 	[MUTEX_MOD_IDX_MDP_WROT3] = MT8195_MUTEX_MOD_MDP_WROT3,
 };
 
-static const unsigned int mt8365_mutex_mod[DDP_COMPONENT_ID_MAX] = {
+static const u8 mt8365_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_AAL0] = MT8365_MUTEX_MOD_DISP_AAL,
 	[DDP_COMPONENT_CCORR] = MT8365_MUTEX_MOD_DISP_CCORR,
 	[DDP_COMPONENT_COLOR0] = MT8365_MUTEX_MOD_DISP_COLOR0,
@@ -637,7 +637,7 @@ static const unsigned int mt8365_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_WDMA0] = MT8365_MUTEX_MOD_DISP_WDMA0,
 };
 
-static const unsigned int mt2712_mutex_sof[DDP_MUTEX_SOF_MAX] = {
+static const u16 mt2712_mutex_sof[DDP_MUTEX_SOF_MAX] = {
 	[MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
 	[MUTEX_SOF_DSI0] = MUTEX_SOF_DSI0,
 	[MUTEX_SOF_DSI1] = MUTEX_SOF_DSI1,
@@ -647,14 +647,14 @@ static const unsigned int mt2712_mutex_sof[DDP_MUTEX_SOF_MAX] = {
 	[MUTEX_SOF_DSI3] = MUTEX_SOF_DSI3,
 };
 
-static const unsigned int mt6795_mutex_sof[DDP_MUTEX_SOF_MAX] = {
+static const u16 mt6795_mutex_sof[DDP_MUTEX_SOF_MAX] = {
 	[MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
 	[MUTEX_SOF_DSI0] = MUTEX_SOF_DSI0,
 	[MUTEX_SOF_DSI1] = MUTEX_SOF_DSI1,
 	[MUTEX_SOF_DPI0] = MUTEX_SOF_DPI0,
 };
 
-static const unsigned int mt8167_mutex_sof[DDP_MUTEX_SOF_MAX] = {
+static const u16 mt8167_mutex_sof[DDP_MUTEX_SOF_MAX] = {
 	[MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
 	[MUTEX_SOF_DSI0] = MUTEX_SOF_DSI0,
 	[MUTEX_SOF_DPI0] = MT8167_MUTEX_SOF_DPI0,
@@ -662,13 +662,13 @@ static const unsigned int mt8167_mutex_sof[DDP_MUTEX_SOF_MAX] = {
 };
 
 /* Add EOF setting so overlay hardware can receive frame done irq */
-static const unsigned int mt8183_mutex_sof[DDP_MUTEX_SOF_MAX] = {
+static const u16 mt8183_mutex_sof[DDP_MUTEX_SOF_MAX] = {
 	[MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
 	[MUTEX_SOF_DSI0] = MUTEX_SOF_DSI0 | MT8183_MUTEX_EOF_DSI0,
 	[MUTEX_SOF_DPI0] = MT8183_MUTEX_SOF_DPI0 | MT8183_MUTEX_EOF_DPI0,
 };
 
-static const unsigned int mt8186_mutex_sof[MUTEX_SOF_DSI3 + 1] = {
+static const u16 mt8186_mutex_sof[MUTEX_SOF_DSI3 + 1] = {
 	[MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
 	[MUTEX_SOF_DSI0] = MT8186_MUTEX_SOF_DSI0 | MT8186_MUTEX_EOF_DSI0,
 	[MUTEX_SOF_DPI0] = MT8186_MUTEX_SOF_DPI0 | MT8186_MUTEX_EOF_DPI0,
@@ -682,7 +682,7 @@ static const unsigned int mt8186_mutex_sof[MUTEX_SOF_DSI3 + 1] = {
  * but also detect the error at end of frame(EAEOF) when EOF signal
  * arrives.
  */
-static const unsigned int mt8188_mutex_sof[DDP_MUTEX_SOF_MAX] = {
+static const u16 mt8188_mutex_sof[DDP_MUTEX_SOF_MAX] = {
 	[MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
 	[MUTEX_SOF_DSI0] =
 		MT8188_MUTEX_SOF_DSI0 | MT8188_MUTEX_EOF_DSI0,
@@ -692,7 +692,7 @@ static const unsigned int mt8188_mutex_sof[DDP_MUTEX_SOF_MAX] = {
 		MT8188_MUTEX_SOF_DP_INTF1 | MT8188_MUTEX_EOF_DP_INTF1,
 };
 
-static const unsigned int mt8195_mutex_sof[DDP_MUTEX_SOF_MAX] = {
+static const u16 mt8195_mutex_sof[DDP_MUTEX_SOF_MAX] = {
 	[MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
 	[MUTEX_SOF_DSI0] = MT8195_MUTEX_SOF_DSI0 | MT8195_MUTEX_EOF_DSI0,
 	[MUTEX_SOF_DSI1] = MT8195_MUTEX_SOF_DSI1 | MT8195_MUTEX_EOF_DSI1,
-- 
2.45.2


