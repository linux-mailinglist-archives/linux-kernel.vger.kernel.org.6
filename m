Return-Path: <linux-kernel+bounces-427510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CFE9E0234
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 13:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3DD016B238
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0365D204F79;
	Mon,  2 Dec 2024 12:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="a2VkVkj4"
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78EF202F8D;
	Mon,  2 Dec 2024 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733142383; cv=none; b=UwLYgGyO+wfjOUmbQ3l9KhJtrQ0Zwlc9XGZ8z91+kdsBAaFXxKHUfHJsbXqi4Ruev7SjwcY6+F/7voSGE4MK8ftz1+wmmKMbwScnq8kqtiIIcUpTSJBEvBe9veKuGFZw9t5750aPp7rtb4mXfkc9JuRbPZDwV8+AWrSDtqUegeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733142383; c=relaxed/simple;
	bh=zhTVsD1iQxbOSl4zZ5cRk3kOrDA7QHDK5JgFIkS+U9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKce1ICvpA7dt2klHnqGtA/Q7uZx6ZIUexyzaBiRHKGGYOga2ni45ycdU0XKJ4LYi3LOaMGQC9gwuUV9cecfgWqcTeB6pShrUA63z6ZC0h3OgdR41DJgD67HWIdETLUVs/XSkkJcnfCL0t1u1k+/gwb/w8t90cSd5M01ZfK16Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=a2VkVkj4; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout4.routing.net (Postfix) with ESMTP id 99D36100DA9;
	Mon,  2 Dec 2024 12:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1733142378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fWj2a6iJgEyx4JBOUG2+QMrMaM92E+beVv/wDZbE/NU=;
	b=a2VkVkj4A85DEa8J6HR25NO8kKWoz2UXxkil76wfkvBqho00n02Y+ku6AW5ukKXrA84G9e
	kkSquaLw2jymNg0Bd53INy4leLM3jT1Dru6SPzbcyfa6Lx1/KvsJVKB2zqPynPEFv1wm3G
	6KFdVnaMqmEPZ0Rst03iT8IDciF5V/4=
Received: from frank-u24.. (fttx-pool-217.61.149.104.bambit.de [217.61.149.104])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 159983600C0;
	Mon,  2 Dec 2024 12:26:18 +0000 (UTC)
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
Subject: [PATCH v2 14/18] arm64: dts: mediatek: mt7988: add pmic on bpi-r4
Date: Mon,  2 Dec 2024 13:25:55 +0100
Message-ID: <20241202122602.30734-15-linux@fw-web.de>
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
X-Mail-ID: f2d1cb1f-9525-4d8c-b392-7f5c855564c5

From: Frank Wunderlich <frank-w@public-files.de>

Bananapi R4 Board contains a MT6682A pmic which is compatible to rt5190a.
Add its node to the i2 controller.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dts  | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
index 13ca016d6a67..bc1ec73b8ddd 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
@@ -2,6 +2,8 @@
 
 /dts-v1/;
 
+#include <dt-bindings/regulator/richtek,rt5190a-regulator.h>
+
 #include "mt7988a.dtsi"
 
 / {
@@ -65,6 +67,55 @@ &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins>;
 	status = "okay";
+
+	rt5190a_64: rt5190a@64 {
+		compatible = "richtek,rt5190a";
+		reg = <0x64>;
+		vin2-supply = <&rt5190_buck1>;
+		vin3-supply = <&rt5190_buck1>;
+		vin4-supply = <&rt5190_buck1>;
+
+		regulators {
+			rt5190_buck1: buck1 {
+				regulator-name = "rt5190a-buck1";
+				regulator-min-microvolt = <5090000>;
+				regulator-max-microvolt = <5090000>;
+				regulator-allowed-modes =
+				<RT5190A_OPMODE_AUTO RT5190A_OPMODE_FPWM>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			buck2 {
+				regulator-name = "vcore";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <1400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			rt5190_buck3: buck3 {
+				regulator-name = "vproc";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <1400000>;
+				regulator-boot-on;
+			};
+			buck4 {
+				regulator-name = "rt5190a-buck4";
+				regulator-min-microvolt = <850000>;
+				regulator-max-microvolt = <850000>;
+				regulator-allowed-modes =
+				<RT5190A_OPMODE_AUTO RT5190A_OPMODE_FPWM>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+			ldo {
+				regulator-name = "rt5190a-ldo";
+				regulator-min-microvolt = <1200000>;
+				regulator-max-microvolt = <1200000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
 };
 
 &i2c2 {
-- 
2.43.0


