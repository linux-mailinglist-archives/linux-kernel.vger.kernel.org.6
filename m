Return-Path: <linux-kernel+bounces-386371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE429B428F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 07:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 622042836C8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 06:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91C82010EE;
	Tue, 29 Oct 2024 06:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LioQFgSr"
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8969E20127F;
	Tue, 29 Oct 2024 06:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730184464; cv=none; b=UZdLT8M09Lp244iFswLW95KV9tMVwL/bIMub9fpqGmBG2q7FqUWh+kUbw9dQm3YNK+dkAwU/zBfc60T1+lbPaAnOQOxibTE9MUfQYRe0yUxuVhC94AATA0w603EFO6VHiUuU4/GtQnWEYZEPZIgBswMHfhYegHAbMCEEcJI2Bww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730184464; c=relaxed/simple;
	bh=YOll/96wrr9RUA21PMbMhIHf4EcPrRWMT5Cc9IxNAiU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aBAmKeFLp+m5P5rLGwwh0dYdu3n81lQLdpYwQYvhgwg+aHDE9VjqfKYmHSR89fwnhCpCt9GJYyuaA2xuh2HkRwImSMOMMoGV8SZlxyLrz2IG8KI1uE3UQxrNPtQxZh3tMrQAP1OcjXmcx9HjsoqScf/CcLUr9ZAsodrL5JZcxhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=LioQFgSr; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: aee0fd8e95c111efbd192953cf12861f-20241029
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=z9PfcigL0s6ErQW2/uQSzc8G0q1UY40BYkcQHjk4dgM=;
	b=LioQFgSrL3GOPfR9Y875WyX+S7rNSE0pJawryv4ZU91MQDKFjb0q4wkdDGuzHvZjKwumIRP9z5s4y+m3mJ66k0h9TTBMNZ12YktK2V0R0SA0+lwSlRLOCi0tdjvLpd30U4Sv+trNC/MtpLpddRnn6b/VxoiIGTsZcywCBj/ALnk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:3669efd2-ae70-4754-876e-1a8f2d701e72,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:4fdf3407-7990-429c-b1a0-768435f03014,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: aee0fd8e95c111efbd192953cf12861f-20241029
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <macpaul.lin@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 766132258; Tue, 29 Oct 2024 14:47:36 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 29 Oct 2024 14:47:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 29 Oct 2024 14:47:35 +0800
From: Macpaul Lin <macpaul.lin@mediatek.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, Hsin-Hsiung Wang
	<hsin-hsiung.wang@mediatek.com>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, Alexandre Mergnat
	<amergnat@baylibre.com>
CC: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
	Macpaul Lin <macpaul.lin@mediatek.com>, Macpaul Lin <macpaul@gmail.com>,
	<Project_Global_Chrome_Upstream_Group@mediatek.com>,
	<linux-usb@vger.kernel.org>, Chris-qj chen <chris-qj.chen@mediatek.com>
Subject: [PATCH] arm64: dts: mediatek: mt6358: fix dtbs_check error
Date: Tue, 29 Oct 2024 14:46:47 +0800
Message-ID: <20241029064647.13370-1-macpaul.lin@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

Fix DTBS check errors for 'mt6358codec' and 'mt6358regulator':

Error message is:
pmic: 'mt6358codec' and 'mt6358regulator' does not match any of the
regexes: 'pinctrl-[0-9]+'.
Rename these two device node to generic 'audio-codec' and 'regulators'.

Fixes: 9f8872221674 ("arm64: dts: mt6358: add PMIC MT6358 related nodes")
Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt6358.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6358.dtsi b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
index 641d452fbc08..e23672a2eea4 100644
--- a/arch/arm64/boot/dts/mediatek/mt6358.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6358.dtsi
@@ -15,12 +15,12 @@ pmic_adc: adc {
 			#io-channel-cells = <1>;
 		};
 
-		mt6358codec: mt6358codec {
+		mt6358codec: audio-codec {
 			compatible = "mediatek,mt6358-sound";
 			mediatek,dmic-mode = <0>; /* two-wires */
 		};
 
-		mt6358regulator: mt6358regulator {
+		mt6358regulator: regulators {
 			compatible = "mediatek,mt6358-regulator";
 
 			mt6358_vdram1_reg: buck_vdram1 {
-- 
2.45.2


