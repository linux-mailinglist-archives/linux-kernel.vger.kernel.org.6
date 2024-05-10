Return-Path: <linux-kernel+bounces-175311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3318C1DF6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 08:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A38A283455
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 06:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6489115B152;
	Fri, 10 May 2024 06:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="pS73xYb6"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2ED1494DE
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 06:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715321851; cv=none; b=Attp1DDTPUbnbUxrXAttQHbRfWITUr22yKnMm/ca7W0ZcrSpqr47dPNy7V+Szynb3Kza8aJ+i4UkG7MRSkiCbmULz8ByJYB+pyYnBxX59kUSVhQkSrcbF+agG3a6/MYZBcx5o0wTqRGb5SM/52dVdkHim6Wo2q6fik/rg0C/HRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715321851; c=relaxed/simple;
	bh=PqWwMhX4dWLjs4sg1qmjRm6shA3EYN7mFwupVDXL9bo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rcBY8v3iGRiSrttLtf6tmYrSHnpWqsT88f/Gc8oTlAtTztfVPW/vUY4n6Ny2+RpLSoZ6KHWp2FxO1xr656oZ21DlqYcH/twL5donaD8EuS2QaohwSISqeAPaVj5mX6W8cMnpBIvG7K97YeQnIr1vB0w1ONawosnkxhQnwFAOQZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=pS73xYb6; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: f6f19e1c0e9411efb92737409a0e9459-20240510
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=puTXK9xgqDgUnsxXNMU30peMYkT6Y/1bWHM3NEeCpa8=;
	b=pS73xYb6hWbILobQQNhJ5Oidfng9mKHqYvKZy62QXbwbQD8XfjWJD6uSckuyAPdaCZS0ONCIWg/INO1QKy7Z35Cn7lcD4/CgpRblLQfDlgLSVsquBm6cZZPSFXup0KMOvxMnHODe7zfwqDwy6Umrq0Qj3sIlok7jgyPMTAGpo3g=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:2dc44579-df8a-481f-9aaf-650356b23347,IP:0,U
	RL:0,TC:0,Content:0,EDM:-30,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-30
X-CID-META: VersionHash:82c5f88,CLOUDID:7a13af83-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:2,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f6f19e1c0e9411efb92737409a0e9459-20240510
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <liankun.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1872033711; Fri, 10 May 2024 14:17:23 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 10 May 2024 14:17:19 +0800
Received: from mszsdhlt06.gcn.mediatek.inc (10.16.6.206) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 10 May 2024 14:17:18 +0800
From: Liankun Yang <liankun.yang@mediatek.com>
To: <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>, <airlied@gmail.com>,
	<daniel@ffwll.ch>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <jitao.shi@mediatek.com>,
	<mac.shen@mediatek.com>, <liankun.yang@mediatek.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1] Fix get efuse issue for MT8188 DPTX
Date: Fri, 10 May 2024 14:16:57 +0800
Message-ID: <20240510061716.31103-1-liankun.yang@mediatek.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--3.274600-8.000000
X-TMASE-MatchedRID: HyBr+9HIEazPvAv72Y9dJYzb2GR6Ttd3nhD9A3Sa7pZcU0dNErOD+vlY
	oV6p/cSxhVmF9kz2wxKE+/1bNiTZfFqxshHHoiYzbT3mGmWPpNdaNaxZBRbNWmlUUOdVs6yao8W
	MkQWv6iXBcIE78YqRWvcUt5lc1lLgKIzdZS3ou0WbFewbmqprKsJKuC5FVjYYlFxPBKXM9hY3vL
	qlRqyqyx2YKru/07rb6P6EiJbjbgHVW6hawn5RRbnypOu9sm/kLl13mrjijIwc/j4aI5S1Lnr9G
	D0zfOvEAaqvv/mhgrFLtG3H3wC1xA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.274600-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	6A4A9F5F72FA535015BBD4F07CE0894FCBC069D93143B8DE1EEA6D1714DD3D332000:8
X-MTK: N

Fix get efuse issue for MT8188 DPTX.

Signed-off-by: Liankun Yang <liankun.yang@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 85 ++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 2136a596efa1..32b36b63a4e1 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -145,6 +145,89 @@ struct mtk_dp_data {
 	u16 audio_m_div2_bit;
 };
 
+static const struct mtk_dp_efuse_fmt mt8188_dp_efuse_fmt[MTK_DP_CAL_MAX] = {
+	[MTK_DP_CAL_GLB_BIAS_TRIM] = {
+		.idx = 0,
+		.shift = 10,
+		.mask = 0x1f,
+		.min_val = 1,
+		.max_val = 0x1e,
+		.default_val = 0xf,
+	},
+	[MTK_DP_CAL_CLKTX_IMPSE] = {
+		.idx = 0,
+		.shift = 15,
+		.mask = 0xf,
+		.min_val = 1,
+		.max_val = 0xe,
+		.default_val = 0x8,
+	},
+	[MTK_DP_CAL_LN_TX_IMPSEL_PMOS_0] = {
+		.idx = 1,
+		.shift = 0,
+		.mask = 0xf,
+		.min_val = 1,
+		.max_val = 0xe,
+		.default_val = 0x8,
+	},
+	[MTK_DP_CAL_LN_TX_IMPSEL_PMOS_1] = {
+		.idx = 1,
+		.shift = 8,
+		.mask = 0xf,
+		.min_val = 1,
+		.max_val = 0xe,
+		.default_val = 0x8,
+	},
+	[MTK_DP_CAL_LN_TX_IMPSEL_PMOS_2] = {
+		.idx = 1,
+		.shift = 16,
+		.mask = 0xf,
+		.min_val = 1,
+		.max_val = 0xe,
+		.default_val = 0x8,
+	},
+	[MTK_DP_CAL_LN_TX_IMPSEL_PMOS_3] = {
+		.idx = 1,
+		.shift = 24,
+		.mask = 0xf,
+		.min_val = 1,
+		.max_val = 0xe,
+		.default_val = 0x8,
+	},
+	[MTK_DP_CAL_LN_TX_IMPSEL_NMOS_0] = {
+		.idx = 1,
+		.shift = 4,
+		.mask = 0xf,
+		.min_val = 1,
+		.max_val = 0xe,
+		.default_val = 0x8,
+	},
+	[MTK_DP_CAL_LN_TX_IMPSEL_NMOS_1] = {
+		.idx = 1,
+		.shift = 12,
+		.mask = 0xf,
+		.min_val = 1,
+		.max_val = 0xe,
+		.default_val = 0x8,
+	},
+	[MTK_DP_CAL_LN_TX_IMPSEL_NMOS_2] = {
+		.idx = 1,
+		.shift = 20,
+		.mask = 0xf,
+		.min_val = 1,
+		.max_val = 0xe,
+		.default_val = 0x8,
+	},
+	[MTK_DP_CAL_LN_TX_IMPSEL_NMOS_3] = {
+		.idx = 1,
+		.shift = 28,
+		.mask = 0xf,
+		.min_val = 1,
+		.max_val = 0xe,
+		.default_val = 0x8,
+	},
+};
+
 static const struct mtk_dp_efuse_fmt mt8195_edp_efuse_fmt[MTK_DP_CAL_MAX] = {
 	[MTK_DP_CAL_GLB_BIAS_TRIM] = {
 		.idx = 3,
@@ -2758,7 +2841,7 @@ static SIMPLE_DEV_PM_OPS(mtk_dp_pm_ops, mtk_dp_suspend, mtk_dp_resume);
 static const struct mtk_dp_data mt8188_dp_data = {
 	.bridge_type = DRM_MODE_CONNECTOR_DisplayPort,
 	.smc_cmd = MTK_DP_SIP_ATF_VIDEO_UNMUTE,
-	.efuse_fmt = mt8195_dp_efuse_fmt,
+	.efuse_fmt = mt8188_dp_efuse_fmt,
 	.audio_supported = true,
 	.audio_pkt_in_hblank_area = true,
 	.audio_m_div2_bit = MT8188_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_2,
-- 
2.18.0


