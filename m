Return-Path: <linux-kernel+bounces-421816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133ED9D9083
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 03:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B76F167235
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 02:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E835A47F69;
	Tue, 26 Nov 2024 02:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="IpAdmxpV"
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A30282FB;
	Tue, 26 Nov 2024 02:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732589720; cv=none; b=ZwBFp0h0aE9C4zy9bOsWS8NltZ1MHn+Oq4O+mp5QXc3GPaB/jYdyFpJqxejUntyMAqH3XGquQmW7XWHQLfKSq+ry5b4eVE/UvlM/VkwenXX+rV7kLoLeXXZR9vQHr4Dc3ccZ3GpAqPlAUlFlcxdRXb+CEG+kFwjQttWve5kW7dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732589720; c=relaxed/simple;
	bh=P0pIs9k36LefOmSBpwsESYiBm6I4m6VQxidO6PeZCfQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bQ6Y3JSySrquqtWcIixdpbdeBssRJPy/84kycG+6eX5ytvvBFsB+smxz0TnTOQjqQtStRMNw+4l5zvsV7xQ+qipl3aY2rx8HaC8nwkW18V5cZWx7F95BOXpJy6Jw4eNv7SCBrkje8cBe32V4Td1c0GBunTbHzIA+wxl0CBRpQ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=IpAdmxpV; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: da79b18eaba111ef99858b75a2457dd9-20241126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=beq6o9JRWjMH1FEW5GAmG83RWWgbW79JPKohxa5dVxc=;
	b=IpAdmxpVMk3wkT1Ajrg0s3VCe7s1dThhqjljmVDUTdwxjFce38e5+Kwp2Z5bsvhUOj+fVFYSGnw4w7tRrGmrQAOaW9XDudlZAfa3C3zHJoQ1zY0zr84/gelhZcD8CpG8wG9sRVUTX7RqXZ7YSB1ijZcP9j8jXjmlXRu0baD+bqw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.44,REQID:5f20416c-82e1-4583-bbb8-898d5a336ead,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:464815b,CLOUDID:aad045e0-1fe5-4c4a-bdf3-d07f9790da32,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:81|82|102,TC:nil,Content:0,EDM:-3,IP
	:nil,URL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: da79b18eaba111ef99858b75a2457dd9-20241126
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <chunfeng.yun@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1577328838; Tue, 26 Nov 2024 10:55:11 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 26 Nov 2024 10:55:10 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 26 Nov 2024 10:55:09 +0800
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring
	<robh@kernel.org>
CC: Chunfeng Yun <chunfeng.yun@mediatek.com>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Mathias Nyman
	<mathias.nyman@intel.com>, <linux-usb@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] usb: mtk-xhci: add support remote wakeup of mt8196
Date: Tue, 26 Nov 2024 10:55:07 +0800
Message-ID: <20241126025507.29605-2-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241126025507.29605-1-chunfeng.yun@mediatek.com>
References: <20241126025507.29605-1-chunfeng.yun@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

There are 2 USB controllers on mt8196, each controller's wakeup control is
different, add some specific versions for them.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
 drivers/usb/host/xhci-mtk.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 3252e3d2d79c..31223912b0b4 100644
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -113,6 +113,12 @@
 #define WC1_IS_P_95		BIT(12)
 #define WC1_IS_EN_P0_95		BIT(6)
 
+/* mt8196 */
+#define PERI_WK_CTRL0_8196	0x08
+#define UWK_V1_7_CTRL2_MASK	0x5
+
+#define WCP1_IS_EN		BIT(7) /* port1 en bit */
+
 /* mt2712 etc */
 #define PERI_SSUSB_SPM_CTRL	0x0
 #define SSC_IP_SLEEP_EN	BIT(4)
@@ -129,6 +135,8 @@ enum ssusb_uwk_vers {
 	SSUSB_UWK_V1_4,		/* mt8195 IP1 */
 	SSUSB_UWK_V1_5,		/* mt8195 IP2 */
 	SSUSB_UWK_V1_6,		/* mt8195 IP3 */
+	SSUSB_UWK_V1_7,		/* mt8196 IP0 */
+	SSUSB_UWK_V1_8,		/* mt8196 IP1 */
 };
 
 /*
@@ -381,6 +389,16 @@ static void usb_wakeup_ip_sleep_set(struct xhci_hcd_mtk *mtk, bool enable)
 		msk = WC0_IS_EN_P3_95 | WC0_IS_C_95(0x7) | WC0_IS_P_95;
 		val = enable ? (WC0_IS_EN_P3_95 | WC0_IS_C_95(0x1)) : 0;
 		break;
+	case SSUSB_UWK_V1_7:
+		reg = mtk->uwk_reg_base + PERI_WK_CTRL0_8196;
+		msk = UWK_V1_7_CTRL2_MASK;
+		val = enable ? msk : 0;
+		break;
+	case SSUSB_UWK_V1_8:
+		reg = mtk->uwk_reg_base + PERI_WK_CTRL0_8196;
+		msk = WCP1_IS_EN;
+		val = enable ? msk : 0;
+		break;
 	case SSUSB_UWK_V2:
 		reg = mtk->uwk_reg_base + PERI_SSUSB_SPM_CTRL;
 		msk = SSC_IP_SLEEP_EN | SSC_SPM_INT_EN;
-- 
2.46.0


