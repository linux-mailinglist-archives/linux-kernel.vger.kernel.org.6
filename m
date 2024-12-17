Return-Path: <linux-kernel+bounces-448910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C00429F4714
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37E2B16EB31
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F0A1F2364;
	Tue, 17 Dec 2024 09:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="P9TokCBb"
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42791F03DF;
	Tue, 17 Dec 2024 09:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426787; cv=none; b=mA5LUo4EaLOxysEHYDHGtspQCE+yVrxwv9WjpfqeBVHg5yJowMIDAofQxtuUc+1FumFeZbnot86HB8ZdW6Arw+PPPz+RZgR0uq9U/ReXRdoaaNMsY4+AZUBVu88LOesrWgzav1BU7alKVPu5DscEsvHXUauhEmLFzsHOM5WMBuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426787; c=relaxed/simple;
	bh=oVzDK9MklzrVreTEGo/z53jknpRwXk4E3nnOa9C+KZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p490zLcVmgnnSiPnFMWGKwz79bpo1/D9b45iv2ofhV+Yhl/kNnHOfmLPfClZln4/e6nXVnGtgvXS1enX9CauI9PxoogtJQAQEaw7JAaWTmt1UWHatuABlipH9yqBlh/MqxrgTQOHGiEI1aNWE6rrpnGm98SrSuXwrpEiFRfTCOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=P9TokCBb; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout4.routing.net (Postfix) with ESMTP id 0716A100827;
	Tue, 17 Dec 2024 09:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1734426784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j6c2IQgbWZeXHk2AalPRG/fxcIHxPLwl5ZLVZv2d+IE=;
	b=P9TokCBbp4uRAZ1XeKygG+zzcqxrku+X0ho5p/4gFG0RG5VopAN/iuUka65wzpu+gFn0fa
	L41Wl9vmFkI/HXCdkzH1f5PtalL6Yf6DhfboE0aQb0UP4kKwOgS4MbLDcRm0pfa+s+ZX4V
	tZxLxtE0+xfgb0VWCa51rXYXMzCOv5I=
Received: from frank-u24.. (fttx-pool-217.61.150.187.bambit.de [217.61.150.187])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 4E08F100532;
	Tue, 17 Dec 2024 09:13:03 +0000 (UTC)
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
Subject: [PATCH v3 17/22] arm64: dts: mediatek: mt7988a-bpi-r4: Enable I2C controllers
Date: Tue, 17 Dec 2024 10:12:31 +0100
Message-ID: <20241217091238.16032-18-linux@fw-web.de>
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
X-Mail-ID: 05423bc4-294c-4d3d-ba3f-73ea92395c6c

From: Frank Wunderlich <frank-w@public-files.de>

Enable the I2C0, I2C2 controllers found on the BananaPi R4 board.
Both controllers are not accessible from user and having fixed spare
devices. I2C0 have a pmic connected, I2C2 is used with I2C-multiplexer
for e.g. SFP cages.
The missing I2C1 is connected to GPIO header which can have either GPIO
mode or I2C mode.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts    | 12 ++++++++++++
 arch/arm64/boot/dts/mediatek/mt7988a.dtsi            |  6 +++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
index 46117df7d44c..3d165f7b29dc 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
@@ -60,6 +60,18 @@ cpu_trip_active_low: active-low {
 	};
 };
 
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_1_pins>;
+	status = "okay";
+};
+
 &pio {
 	mdio0_pins: mdio0-pins {
 		mux {
diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
index 59a1ffc2edfc..c0a49f68834a 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
@@ -269,7 +269,7 @@ serial@11000200 {
 			status = "disabled";
 		};
 
-		i2c@11003000 {
+		i2c0: i2c@11003000 {
 			compatible = "mediatek,mt7981-i2c";
 			reg = <0 0x11003000 0 0x1000>,
 			      <0 0x10217080 0 0x80>;
@@ -283,7 +283,7 @@ i2c@11003000 {
 			status = "disabled";
 		};
 
-		i2c@11004000 {
+		i2c1: i2c@11004000 {
 			compatible = "mediatek,mt7981-i2c";
 			reg = <0 0x11004000 0 0x1000>,
 			      <0 0x10217100 0 0x80>;
@@ -297,7 +297,7 @@ i2c@11004000 {
 			status = "disabled";
 		};
 
-		i2c@11005000 {
+		i2c2: i2c@11005000 {
 			compatible = "mediatek,mt7981-i2c";
 			reg = <0 0x11005000 0 0x1000>,
 			      <0 0x10217180 0 0x80>;
-- 
2.43.0


