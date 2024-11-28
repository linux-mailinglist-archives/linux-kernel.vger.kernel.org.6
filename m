Return-Path: <linux-kernel+bounces-424196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F7A9DB184
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 03:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD128166569
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 02:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D4954670;
	Thu, 28 Nov 2024 02:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ciVsT9Nk"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535D045005
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 02:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732761469; cv=none; b=AoZhCDoY4MHCnPWJ8qTkML+J9O5JmAd3r/NapbFY9iP1fjVL+zvauPkYhB0hUngT+2WmzvB3XJc4kOHXyUtJY403jQ+bj4VG59Oe6aTumBsh5kv7NX+h6jU8IQq3Kuu9iSJLZJVOuNuBzcvzgbq8mG6OGvmAxHrBK62Qzuk4EAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732761469; c=relaxed/simple;
	bh=bFd/xrhHo6DDYyFI1slx3+C8FHGxAq6JpsfjxqB+6Iw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hO+LQtgUncoI8NN1JOA8fZxJV0SarrkQ/MYLGHjnOHZfmbrAg38rFf8cvhZyQG2ESPkSYWgFPS4s6Lv8uSNeiCuBS6C2QRN9/0OUYKbyHILKwVgh/lO3r7Njg3RfAwbtRH/lMie9itFVIYkcKkHvFl7IIAr1DhfXt2qnJECVDZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ciVsT9Nk; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: bda3737ead3111efbd192953cf12861f-20241128
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ihUogkJ3FW2Gqhs9h36UD6fhHJRJ+i0c245MwkyAcrU=;
	b=ciVsT9Nky5WFa9owOX9jUHEjm4Z1jP+lRk0pV8a4JuPcNZIIRS2wnPUuptwsh16p3H/55jRm2BzXaH0ifEsV3c34F6Q6UQxBmnW93hOMmrzZ4cBiqgcItHlvv2clCgIBc4/7E6X30bibhqHH+zqi73jDQ6Kvob2mriUkC3I0Ibs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:b6ecde63-fd05-4b9e-ac81-1e4d3b93f993,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:464815b,CLOUDID:b7749e23-634f-4016-85ba-2d63e55c9400,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: bda3737ead3111efbd192953cf12861f-20241128
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <liankun.yang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2133131880; Thu, 28 Nov 2024 10:37:41 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 28 Nov 2024 10:37:38 +0800
Received: from mszsdclx1211.gcn.mediatek.inc (10.16.7.31) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 28 Nov 2024 10:37:38 +0800
From: Liankun Yang <liankun.yang@mediatek.com>
To: <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>, <airlied@gmail.com>,
	<simona@ffwll.ch>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <jitao.shi@mediatek.com>,
	<mac.shen@mediatek.com>, <peng.liu@mediatek.com>,
	<liankun.yang@mediatek.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-mediatek@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 1/1] drm/mediatek: dp: Add sdp path reset
Date: Thu, 28 Nov 2024 10:37:21 +0800
Message-ID: <20241128023733.16294-1-liankun.yang@mediatek.com>
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
X-TM-AS-Result: No-10--3.187400-8.000000
X-TMASE-MatchedRID: d+BGjaEADBWvhOOX3csmVw0QY5VnQyAN6SXuwUgGH0iyrCkM9r1bWpVD
	ZsT0rYWC8MF78pseROBIT4SOZxkibrGaAH5r9EhkhK8o4aoss8pZT2gl0gqGyo5RXzY0MfgCcHj
	giTON9jJOFu8ssjxG8xp0MHP646G7Xcx4M+DrsF7huXUWQoMQt63iVpZ0luwMXaZ/Rba9vHG9E+
	yWHMdHvIJcsHHt88vbfjWeJX0rKbMfE8yM4pjsD7fIDYp/ogjHxEHRux+uk8jfhP1xgyx3DI9Iw
	OwJvhdTjFYSmlsXcFYbKWuoGkRlU90Y22Zk8+IQQiUfzB96MHWijOQaxDKu8qPapq2aFl88gSb5
	10g5A6p+YIbiC0qUfG1Rjoup2VCcWve+eVz4Pp5Vk5utmQ1VlGVF3+d9rnoxpI8EFEZVbig=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--3.187400-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	43089957CAFD153865D27ECE052C0FF448EEC90AA7150D7E68B797BFEA6F72A52000:8
X-MTK: N

When using type-c to type-c to connect to the monitor,
the sound plays normally. If you unplug the type-c and
connect the type-c to hdmi dongle to the monitor, there will be noise.

By capturing the audio data, it is found that
the data position is messy, and there is no error in the data.

Through experiments, it can be restored by resetting the SDP path
when unplugging it.

Signed-off-by: Liankun Yang <liankun.yang@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
Changes in V4:
- Fix align to the right of '('.
Per suggestion from the previous thread:
https://patchwork.kernel.org/project/linux-mediatek/patch/20240925064854.23065-1-liankun.yang@mediatek.com/

Changes in V3:
- No change.
Per suggestion from the previous thread:
https://patchwork.kernel.org/project/linux-mediatek/patch/20240923132521.22785-1-liankun.yang@mediatek.com/

Changes in V2:
- Fix build error.
Per suggestion from the previous thread:
https://patchwork.kernel.org/project/linux-mediatek/patch/20240923133610.23728-1-liankun.yang@mediatek.com/
---
 drivers/gpu/drm/mediatek/mtk_dp.c     | 15 +++++++++++++++
 drivers/gpu/drm/mediatek/mtk_dp_reg.h |  1 +
 2 files changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
index 1cc916b16471..4f4233bd83f7 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp.c
+++ b/drivers/gpu/drm/mediatek/mtk_dp.c
@@ -1135,6 +1135,18 @@ static void mtk_dp_digital_sw_reset(struct mtk_dp *mtk_dp)
 			   0, DP_TX_TRANSMITTER_4P_RESET_SW_DP_TRANS_P0);
 }
 
+static void mtk_dp_sdp_path_reset(struct mtk_dp *mtk_dp)
+{
+	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3004,
+			   SDP_RESET_SW_DP_ENC0_P0,
+			   SDP_RESET_SW_DP_ENC0_P0);
+
+	/* Wait for sdp path reset to complete */
+	usleep_range(1000, 5000);
+	mtk_dp_update_bits(mtk_dp, MTK_DP_ENC0_P0_3004,
+			   0, SDP_RESET_SW_DP_ENC0_P0);
+}
+
 static void mtk_dp_set_lanes(struct mtk_dp *mtk_dp, int lanes)
 {
 	mtk_dp_update_bits(mtk_dp, MTK_DP_TRANS_P0_35F0,
@@ -2397,6 +2409,9 @@ static void mtk_dp_bridge_atomic_disable(struct drm_bridge *bridge,
 			   DP_PWR_STATE_BANDGAP_TPLL,
 			   DP_PWR_STATE_MASK);
 
+	/* SDP path reset sw*/
+	mtk_dp_sdp_path_reset(mtk_dp);
+
 	/* Ensure the sink is muted */
 	msleep(20);
 }
diff --git a/drivers/gpu/drm/mediatek/mtk_dp_reg.h b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
index 709b79480693..8ad7a9cc259e 100644
--- a/drivers/gpu/drm/mediatek/mtk_dp_reg.h
+++ b/drivers/gpu/drm/mediatek/mtk_dp_reg.h
@@ -86,6 +86,7 @@
 #define MTK_DP_ENC0_P0_3004			0x3004
 #define VIDEO_M_CODE_SEL_DP_ENC0_P0_MASK		BIT(8)
 #define DP_TX_ENCODER_4P_RESET_SW_DP_ENC0_P0		BIT(9)
+#define SDP_RESET_SW_DP_ENC0_P0				BIT(13)
 #define MTK_DP_ENC0_P0_3010			0x3010
 #define HTOTAL_SW_DP_ENC0_P0_MASK			GENMASK(15, 0)
 #define MTK_DP_ENC0_P0_3014			0x3014
-- 
2.45.2


