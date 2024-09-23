Return-Path: <linux-kernel+bounces-335896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B1597EC38
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 298CF281979
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97C81993B2;
	Mon, 23 Sep 2024 13:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="s9jmTJ7t"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA6D195F17
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 13:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727097935; cv=none; b=L7GFC262MU1f8GOtv2xXEFMvOj0q/XMpdxnmJIGHCrXKY5G2x2BltiTighSETz3Rpb7aLUngtM0C98Kkecc5+rmh7S3JB4UCuVeAmJbWEPro6CFkKH1cRgrljsd199f5bhx8e3sn84fgpoDsgreexCo0kTWOcKFxaUOUdN7wZ8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727097935; c=relaxed/simple;
	bh=z4gchin7V0pOCT6gxZ/eDoJy/herhNI6dHRjvfcNv0s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=os8AY4reQXS26lvFN9vSy3vmtikytbUL3MHCc08t33ZEsHyJWM6UkThtspaP34Q0TGXeY4p2mo0oVXxQxXkgR87ihcokEdY+YoJI1QiG12qUSiJF3Vee2h5Rd/S8wRx6mEEMj40xn70/6bKAA1F2YMJtL9dnUU0fgDiBv6iFIM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=s9jmTJ7t; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 4c349e6279af11ef8b96093e013ec31c-20240923
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=A6BaHayr+oQhXl7jhR7Os79bzwszR1kCwTLrefo5/N4=;
	b=s9jmTJ7tPG/Ohj0t5SYn/fNMD1BShDiObS4h2v5VeAz2obwYokQ2M7x80X5gqxF592CRGy6zLy8yCEpBlyX5PFIKly5IpGO3EScYUjwXwYklVvVjhYuP5AII9xhSn5FMGjTUZOjCqKscCa+jV/rCQ/Q9WImvaUbMXC+1nj5nO7s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.41,REQID:d03fa476-2929-4f92-b603-4a5c47774e13,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6dc6a47,CLOUDID:bce71d18-b42d-49a6-94d2-a75fa0df01d2,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 4c349e6279af11ef8b96093e013ec31c-20240923
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
	(envelope-from <liankun.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1410717539; Mon, 23 Sep 2024 21:25:27 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 23 Sep 2024 21:25:24 +0800
Received: from mszsdhlt06.gcn.mediatek.inc (10.16.6.206) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 23 Sep 2024 21:25:24 +0800
From: Liankun Yang <liankun.yang@mediatek.com>
To: <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <ck.hu@mediatek.com>,
	<shuijing.li@mediatek.com>, <jitao.shi@mediatek.com>,
	<mac.shen@mediatek.com>, <peng.liu@mediatek.com>, <liankun.yang@mediatek.com>
CC: <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 1/1] drm/mediatek: Fix get efuse issue for MT8188 DPTX
Date: Mon, 23 Sep 2024 21:24:15 +0800
Message-ID: <20240923132521.22785-1-liankun.yang@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--1.792900-8.000000
X-TMASE-MatchedRID: Hqz/XgqfLNoQkelDZj2VREKcYi5Qw/RVxBgaBynd2vlcKZwALwMGs0NF
	JC6C2PHmLYexjI/F2s4ehelkT7MKoZkroZMnoDefGVyS87Wb4lzSv+oK79xjnYthgXQA034U0Bh
	ZSjgdIiS6Cb1NfpE0Wim8//AkdhrKJkzQY65fggEpoxDq3DugMkyQ5fRSh265CqIJhrrDy28ZK8
	lV1bfEyVFk8Z6FPGGi3/0OX7sbFJrPbX0hGZSk0WivjLE8DPtZfS0Ip2eEHnyFh/DzryTTlsBru
	def+SZcjoczmuoPCq3o++AbH5LaSwqj55Mn5ETqnnM7UpC4U94WO6aMOdG0fs0+qcmwM8eYSSMT
	gKYUDbnSSW8J8zdCApCNacyhLcbKiZUvryb1677iw6uxviJP8r9tsSiUciBlQ5zsaM5qada/lr1
	yYih0SylGctXaTCsu
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--1.792900-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: 913AB09A28BB879B32D5FBE07AC23E3E90CA9D5A6311400AB10947FD2EA6482B2000:8
X-MTK: N

Update efuse data for MT8188 displayport.

The DP monitor can not display when DUT connected to USB-c to DP dongle.
Analysis view is invalid DP efuse data.

Fixes: 350c3fe907fb ("drm/mediatek: dp: Add support MT8188 dp/edp function")
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Liankun Yang <liankun.yang@mediatek.com>
---
Changes in V5:
- No change.
Per suggestion from the previous thread:
https://patchwork.kernel.org/project/linux-mediatek/patch/20240905124041.3658-1-liankun.yang@mediatek.com/

Changes in V4:
- Remove excess newlines.
Per suggestion from the previous thread:
https://patchwork.kernel.org/project/linux-mediatek/patch/20240903121028.20689-1-liankun.yang@mediatek.com/

Changes in V3
- Update change log position in commit message.
Per suggestion from the previous thread:
https://patchwork.kernel.org/project/linux-mediatek/patch/20240902133736.16461-1-liankun.yang@mediatek.com/

Changes in V2
- Add Fixes tag.
- Update the commit title.
- Update the commit description.
Per suggestion from the previous thread:
https://patchwork.kernel.org/project/linux-mediatek/patch/20240510061716.31103-1-liankun.yang@mediatek.com/
---
 drivers/gpu/drm/mediatek/mtk_dp.c | 85 ++++++++++++++++++++++++++++++-
 1 file changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index d8796a904eca..f2bee617f063 100644
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
@@ -2771,7 +2854,7 @@ static SIMPLE_DEV_PM_OPS(mtk_dp_pm_ops, mtk_dp_suspend, mtk_dp_resume);
 static const struct mtk_dp_data mt8188_dp_data = {
 	.bridge_type = DRM_MODE_CONNECTOR_DisplayPort,
 	.smc_cmd = MTK_DP_SIP_ATF_VIDEO_UNMUTE,
-	.efuse_fmt = mt8195_dp_efuse_fmt,
+	.efuse_fmt = mt8188_dp_efuse_fmt,
 	.audio_supported = true,
 	.audio_pkt_in_hblank_area = true,
 	.audio_m_div2_bit = MT8188_AUDIO_M_CODE_MULT_DIV_SEL_DP_ENC0_P0_DIV_2,
-- 
2.45.2


