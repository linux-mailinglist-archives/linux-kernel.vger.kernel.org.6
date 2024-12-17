Return-Path: <linux-kernel+bounces-448917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C179F4724
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520DC189122F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8521F4E22;
	Tue, 17 Dec 2024 09:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="mPfvDYcZ"
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624741F3D41;
	Tue, 17 Dec 2024 09:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426791; cv=none; b=TJN67QgtLqMecuIJh1J0cYdwOrOwsufJUwnDtbFHU6wMso1nxq8HRr4r155LfGf1t3V0BOdiGSdnm/f8lS4ZgocIbS9CvUCOaCzNryU8E/4bnnmNX8+iTrzn0LaQr+I/vyB23rqmUSn/ktyCCIl2RtnYKvAsnjcMV1Ne+KzvV8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426791; c=relaxed/simple;
	bh=A8ls5ht7Teou8Dbp/MTlg2hXbXK99levatE0ctDiWlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUravNqe2/TCjYDial4Dmzb3MurGlUUc8KcW/X+W1xkM2fi3UK2AWFvI/54l2Xj9qq5GiT3CcZkYXFsiMEv9N5Vm1lq0L/ernzd86XV8cVMjWm2vOvVZCslYi2symKCZ8T4cga/PCsjd0jD/0FXOAiQLj3CgILH3c/2jiFoz68o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=mPfvDYcZ; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout4.routing.net (Postfix) with ESMTP id 75177100827;
	Tue, 17 Dec 2024 09:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1734426787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PcFZcjlJOep/8l7LtjklgvNKC15bse6OW+TbhR/p1x0=;
	b=mPfvDYcZMx2zZoxTK+XTVluWS0dIdC4zAE0M2MWyQWHEvelPbVkphCaiHTRfeqvm2dicfm
	ATESWCWhZcyfq8CDuP49/MyOi6JUt4GpmdFuQ/DVEHii2ZwXmRyHVZ4REWmZvqi9xg/DY1
	2gRc6eyzhrOHCAvfIFIq1VCCgg0paDc=
Received: from frank-u24.. (fttx-pool-217.61.150.187.bambit.de [217.61.150.187])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id B14FC10052A;
	Tue, 17 Dec 2024 09:13:06 +0000 (UTC)
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
Subject: [PATCH v3 22/22] arm64: dts: mediatek: mt7988a-bpi-r4: Enable pcie
Date: Tue, 17 Dec 2024 10:12:36 +0100
Message-ID: <20241217091238.16032-23-linux@fw-web.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241217091238.16032-1-linux@fw-web.de>
References: <20241217091238.16032-1-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: ef1f3959-efcf-4e62-9204-a040f3477067

From: Frank Wunderlich <frank-w@public-files.de>

Enable the pci controllers on BPI-R4.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dts  | 20 +++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi     |  8 ++++----
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
index 4b1eaf818b66..d6f1fca3323c 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
@@ -113,6 +113,26 @@ i2c_sfp2: i2c@2 {
 	};
 };
 
+/* mPCIe SIM2 */
+&pcie0 {
+	status = "okay";
+};
+
+/* mPCIe SIM3 */
+&pcie1 {
+	status = "okay";
+};
+
+/* M.2 key-B SIM1 */
+&pcie2 {
+	status = "okay";
+};
+
+/* M.2 key-M SSD */
+&pcie3 {
+	status = "okay";
+};
+
 &pio {
 	mdio0_pins: mdio0-pins {
 		mux {
diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 6f6a1a1c1d78..7a5e16a97476 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -373,7 +373,7 @@ mmc0: mmc@11230000 {
 			status = "disabled";
 		};
 
-		pcie@11280000 {
+		pcie2: pcie@11280000 {
 			compatible = "mediatek,mt7986-pcie",
 				     "mediatek,mt8192-pcie";
 			device_type = "pci";
@@ -411,7 +411,7 @@ pcie_intc2: interrupt-controller {
 			};
 		};
 
-		pcie@11290000 {
+		pcie3: pcie@11290000 {
 			compatible = "mediatek,mt7986-pcie",
 				     "mediatek,mt8192-pcie";
 			device_type = "pci";
@@ -449,7 +449,7 @@ pcie_intc3: interrupt-controller {
 			};
 		};
 
-		pcie@11300000 {
+		pcie0: pcie@11300000 {
 			compatible = "mediatek,mt7986-pcie",
 				     "mediatek,mt8192-pcie";
 			device_type = "pci";
@@ -487,7 +487,7 @@ pcie_intc0: interrupt-controller {
 			};
 		};
 
-		pcie@11310000 {
+		pcie1: pcie@11310000 {
 			compatible = "mediatek,mt7986-pcie",
 				     "mediatek,mt8192-pcie";
 			device_type = "pci";
-- 
2.43.0


