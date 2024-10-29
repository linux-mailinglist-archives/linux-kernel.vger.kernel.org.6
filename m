Return-Path: <linux-kernel+bounces-386695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 393AE9B470F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 11:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F24F0283889
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 10:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1038205138;
	Tue, 29 Oct 2024 10:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="p8ODP3Dh"
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3C1204958;
	Tue, 29 Oct 2024 10:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730198396; cv=none; b=LKK6/VPpH6ZLxCs1l9SWtkZgPt0nr/kPv+Q45K30qPFWjKeEds7xQ1CvNPdoG6ru+MzCRWHHmqZ8/oHCq2ELikhUSGhDialLx7DyBkJk25D1jWAUaBnJRIItqtAzV/MME/Eu2FiVz6MYR2aiz/tM+SXpPf2ftLJv/u9/ojpLFgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730198396; c=relaxed/simple;
	bh=QQ2H6ztJ+r2aGUEfhHTxHwhSpBK9CIJBsRe4jWPOxDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j167IDQy9uuOpLw2chEJEddjmtT9SkHQUsf1L/pAdwRRBMhsBXjTem+kkBViH+qIOJZ4dqn9DSewYxGqUn9gGmdXRira3yAKr1kA6ukbmRBXh3TprfMqR2rx36ORCSmpeuHrB7/TX4j3sMK7Zw/Kk3ZvzmRVpJrSh0g+KjLR/so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=p8ODP3Dh; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout4.routing.net (Postfix) with ESMTP id 87C271014E7;
	Tue, 29 Oct 2024 10:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1730198387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/I+n4zk0HprnXJxl1E8/AMoicAPVbZXERfZKvFjQfOo=;
	b=p8ODP3DhUBjIU4148EQGvGksboZwH87pbNhDCIoGrwDjRk/90VbNWMXSKltBFKYvxXGmWF
	ryzsf5j4SFqE8DYLaxHo0rbIIvTL1EZQBNo0ddg9qVTQ+KmWPG376+Y5Dtxml/I0/UEb+O
	FF9fyWPoAz2nuUsx326bR+w6eL9rkUA=
Received: from frank-u24.. (fttx-pool-80.245.73.173.bambit.de [80.245.73.173])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id F3F1B3600D8;
	Tue, 29 Oct 2024 10:39:46 +0000 (UTC)
From: Frank Wunderlich <linux@fw-web.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Frank Wunderlich <frank-w@public-files.de>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [RFC v1 07/14] arm64: dts: mediatek: mt7988: add mmc support
Date: Tue, 29 Oct 2024 11:39:26 +0100
Message-ID: <20241029103937.45852-8-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241029103937.45852-1-linux@fw-web.de>
References: <20241029103937.45852-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: b606b4ef-e6a3-4657-86e5-a5b31fbcf146

From: Frank Wunderlich <frank-w@public-files.de>

Add devicetree node for MMC controller.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 777067b326b2..639c307b9984 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -278,6 +278,28 @@ ssusb1: usb@11200000 {
 			clock-names = "sys_ck", "ref_ck", "mcu_ck", "dma_ck", "xhci_ck";
 		};
 
+		mmc0: mmc@11230000 {
+			compatible = "mediatek,mt7988-mmc";
+			reg = <0 0x11230000 0 0x1000>,
+			      <0 0x11D60000 0 0x1000>;
+			interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&infracfg CLK_INFRA_MSDC400>,
+				 <&infracfg CLK_INFRA_MSDC2_HCK>,
+				 <&infracfg CLK_INFRA_66M_MSDC_0_HCK>,
+				 <&infracfg CLK_INFRA_133M_MSDC_0_HCK>;
+			assigned-clocks = <&topckgen CLK_TOP_EMMC_250M_SEL>,
+					  <&topckgen CLK_TOP_EMMC_400M_SEL>;
+			assigned-clock-parents = <&topckgen CLK_TOP_NET1PLL_D5_D2>,
+						 <&apmixedsys CLK_APMIXED_MSDCPLL>;
+			clock-names = "source",
+				      "hclk",
+				      "axi_cg",
+				      "ahb_cg";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
 		clock-controller@11f40000 {
 			compatible = "mediatek,mt7988-xfi-pll";
 			reg = <0 0x11f40000 0 0x1000>;
-- 
2.43.0


