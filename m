Return-Path: <linux-kernel+bounces-427520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFD49E0240
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A4A284849
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC8A1FECBC;
	Mon,  2 Dec 2024 12:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="Sko1E2wB"
Received: from mxout1.routing.net (mxout1.routing.net [134.0.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38A71FC7FB;
	Mon,  2 Dec 2024 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733142745; cv=none; b=rPhbYfqxZR2JKocFCT40fAhcnBoiLPV3+0N3Rrdw3xYniAokYANDsvBwFoE3qnXoE48S4Z1GcdGf8N/rZ21Z4FanPVlcZfHrcrrWRbueFalNyDTJ9jA3vAZ0sGPMZzA84xBJ8nGfrzS2mr3DClJdFb19UqW2lJcyNS7cbgDLJWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733142745; c=relaxed/simple;
	bh=Xet7oftb//1f0ehmHvCIeJYrD+l7XkvYk7VP79q4+Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rt7kGnBIsUXyvWrW5AIwzCHWNUKUJsSIjusoj87KRDXBxqlL8tvdpvhe19e7A5CAy3kDKbrWCVTUm82uzbVRLeWo2nHoL93BQywy2cUDcGU3IhBwxul8H8c1FV0L6gaobZzH5Yrq5VJE/bSGcMaNAXMagoQG4TlChheh6zv8Dbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=Sko1E2wB; arc=none smtp.client-ip=134.0.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout1.routing.net (Postfix) with ESMTP id B0CCE4119B;
	Mon,  2 Dec 2024 12:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1733142371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EZod1ka4k4PMMYK+yDubLbP92ZqquD7GvgNYdPg+tk0=;
	b=Sko1E2wBc7Hnyx8S5jmJPLkOGvZPTJpZTniQ96szAY/taXrSnss3LCOwvxdLJn/BDF/6Uj
	KB8ptKHuJz4ltDDHof0yLUFd79wQaR97z9E9QXB653KSRy6aDRw8kY5tFQVG8UAcFslm/P
	vlQRUtJTGUc666z2G7pIhDUA2zYUpqw=
Received: from frank-u24.. (fttx-pool-217.61.149.104.bambit.de [217.61.149.104])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 211CE3600C0;
	Mon,  2 Dec 2024 12:26:11 +0000 (UTC)
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
Subject: [PATCH v2 02/18] arm64: dts: mediatek: mt7988: add mmc support
Date: Mon,  2 Dec 2024 13:25:43 +0100
Message-ID: <20241202122602.30734-3-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241202122602.30734-1-linux@fw-web.de>
References: <20241202122602.30734-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: fe7dd4f1-c909-412b-8423-4600a8939fcd

From: Frank Wunderlich <frank-w@public-files.de>

Add devicetree node for MMC controller.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
changes:
v2:
squash "add missing label for apmixedsys"
---
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 24 ++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 46969577c87a..5e40446cb7b3 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -100,7 +100,7 @@ watchdog: watchdog@1001c000 {
 			#reset-cells = <1>;
 		};
 
-		clock-controller@1001e000 {
+		apmixedsys: clock-controller@1001e000 {
 			compatible = "mediatek,mt7988-apmixedsys";
 			reg = <0 0x1001e000 0 0x1000>;
 			#clock-cells = <1>;
@@ -278,6 +278,28 @@ usb@11200000 {
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


