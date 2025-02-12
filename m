Return-Path: <linux-kernel+bounces-510865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1A2A322FF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 11:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA1AB161EC3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 10:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35ACA207A20;
	Wed, 12 Feb 2025 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qBSUKoHN"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFBB1FC102
	for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2025 10:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354422; cv=none; b=D+HF+IFfaFPVsuj9OnSWCiO2GepMNvbt3y9S5Txff3jzRrPyAKxXTz4dSu4MyvMSAtJMvibkaKCH3QHhif7wuE7uHWar5cmw1dedxCBQA6Lr9iSCAuT9IZEM3S5oliwVAiO2dlpLkfm5gd2n4SIl039PyGVbE1tMjcLHJ/zekWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354422; c=relaxed/simple;
	bh=qynKhi81CSVOJ9xLgAOiLR+1L935dUl3dgyGcUiHllI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCV0iyVUN8NpGZcnbTRSRGlkYnHUJP+FZOIWcuqDdomw6QclmnmnoJs/QYAWOHDKjDNSp9u5tNwDkk93Geo90TJFi6LkMPOm67zvptr9BvNhfsMqwug2mhwijdRNlTo24W00sQfFRpOmClXZPdfJd8JIAjTkU0bYfFREhEVQDmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qBSUKoHN; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739354418;
	bh=qynKhi81CSVOJ9xLgAOiLR+1L935dUl3dgyGcUiHllI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qBSUKoHNjJzWnnwXt1RNx3wGeoi/fx/4c4XIERCcMcR4PXxNDbY0dcT3geIG3d+P5
	 D14p8VN97La6g4MK+kaZ5Oygz+g+jzaaTLVzW4kKuiMPekhEzld0PFETyDQgH7FG5h
	 TES+74apyKdZwk+UgCEQBPh2tfBp/8ZYuMWPOVKDr/Arw9jE1mFCHJfWgl/LYFjXYW
	 SnafCHLVgYI77CqXtd+Y/4xjn3sSPfSYqtDNq0VwMX48OOA/BkHVAw9KTzeM+m4UcU
	 6Z7LXHYcWKNBNbo6l6U49bhx9YFHZSXhfZvni+Lph8FZLfJOxRX5/P5Xehruu1A0Ug
	 yVNnGejtO5s5g==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3F7ED17E0F68;
	Wed, 12 Feb 2025 11:00:18 +0100 (CET)
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
Subject: [PATCH v1 1/8] soc: mediatek: mtk-mutex: Add DPI1 SOF/EOF to MT8188 mutex tables
Date: Wed, 12 Feb 2025 11:00:05 +0100
Message-ID: <20250212100012.33001-2-angelogioacchino.delregno@collabora.com>
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

MT8188 uses DPI1 to output to the HDMI controller: add the
Start of Frame and End of Frame configuration for the DPI1
IP to the tables to unblock generation and sending of these
signals to the GCE.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-mutex.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
index 5250c1d702eb..aaa965d4b050 100644
--- a/drivers/soc/mediatek/mtk-mutex.c
+++ b/drivers/soc/mediatek/mtk-mutex.c
@@ -155,6 +155,7 @@
 #define MT8188_MUTEX_MOD_DISP1_VPP_MERGE3	23
 #define MT8188_MUTEX_MOD_DISP1_VPP_MERGE4	24
 #define MT8188_MUTEX_MOD_DISP1_DISP_MIXER	30
+#define MT8188_MUTEX_MOD_DISP1_DPI1		38
 #define MT8188_MUTEX_MOD_DISP1_DP_INTF1		39
 
 #define MT8195_MUTEX_MOD_DISP_OVL0		0
@@ -289,6 +290,7 @@
 #define MT8188_MUTEX_SOF_DSI0			1
 #define MT8188_MUTEX_SOF_DP_INTF0		3
 #define MT8188_MUTEX_SOF_DP_INTF1		4
+#define MT8188_MUTEX_SOF_DPI1			5
 #define MT8195_MUTEX_SOF_DSI0			1
 #define MT8195_MUTEX_SOF_DSI1			2
 #define MT8195_MUTEX_SOF_DP_INTF0		3
@@ -301,6 +303,7 @@
 #define MT8188_MUTEX_EOF_DSI0			(MT8188_MUTEX_SOF_DSI0 << 7)
 #define MT8188_MUTEX_EOF_DP_INTF0		(MT8188_MUTEX_SOF_DP_INTF0 << 7)
 #define MT8188_MUTEX_EOF_DP_INTF1		(MT8188_MUTEX_SOF_DP_INTF1 << 7)
+#define MT8188_MUTEX_EOF_DPI1			(MT8188_MUTEX_SOF_DPI1 << 7)
 #define MT8195_MUTEX_EOF_DSI0			(MT8195_MUTEX_SOF_DSI0 << 7)
 #define MT8195_MUTEX_EOF_DSI1			(MT8195_MUTEX_SOF_DSI1 << 7)
 #define MT8195_MUTEX_EOF_DP_INTF0		(MT8195_MUTEX_SOF_DP_INTF0 << 7)
@@ -472,6 +475,7 @@ static const u8 mt8188_mutex_mod[DDP_COMPONENT_ID_MAX] = {
 	[DDP_COMPONENT_PWM0] = MT8188_MUTEX_MOD2_DISP_PWM0,
 	[DDP_COMPONENT_DP_INTF0] = MT8188_MUTEX_MOD_DISP_DP_INTF0,
 	[DDP_COMPONENT_DP_INTF1] = MT8188_MUTEX_MOD_DISP1_DP_INTF1,
+	[DDP_COMPONENT_DPI1] = MT8188_MUTEX_MOD_DISP1_DPI1,
 	[DDP_COMPONENT_ETHDR_MIXER] = MT8188_MUTEX_MOD_DISP1_DISP_MIXER,
 	[DDP_COMPONENT_MDP_RDMA0] = MT8188_MUTEX_MOD_DISP1_MDP_RDMA0,
 	[DDP_COMPONENT_MDP_RDMA1] = MT8188_MUTEX_MOD_DISP1_MDP_RDMA1,
@@ -686,6 +690,8 @@ static const u16 mt8188_mutex_sof[DDP_MUTEX_SOF_MAX] = {
 	[MUTEX_SOF_SINGLE_MODE] = MUTEX_SOF_SINGLE_MODE,
 	[MUTEX_SOF_DSI0] =
 		MT8188_MUTEX_SOF_DSI0 | MT8188_MUTEX_EOF_DSI0,
+	[MUTEX_SOF_DPI1] =
+		MT8188_MUTEX_SOF_DPI1 | MT8188_MUTEX_EOF_DPI1,
 	[MUTEX_SOF_DP_INTF0] =
 		MT8188_MUTEX_SOF_DP_INTF0 | MT8188_MUTEX_EOF_DP_INTF0,
 	[MUTEX_SOF_DP_INTF1] =
-- 
2.48.1


