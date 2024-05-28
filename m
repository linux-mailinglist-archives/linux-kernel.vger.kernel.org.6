Return-Path: <linux-kernel+bounces-192420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD4A8D1D0A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 15:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33D4E1C22AE4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3921216F297;
	Tue, 28 May 2024 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJcfJq+T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5E316F283;
	Tue, 28 May 2024 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716903143; cv=none; b=ZOgs7yQCMf0IUsq188NXEI4X7UZaVSJOtpi0XeKnI2jESJQ1FB2ob5LgM2pdVmAlvBx2uVRwegTH9mDU+6zzFkV0apBJSidJ5dh82j02zC4T31nVkLcxFqnctRPJs+RKxwtA4FwZSTFLQOrrly6foH+CN2ohL3kww4GvJPouUEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716903143; c=relaxed/simple;
	bh=ct9g6aL365D3+hInh1Gk/WqHw7JZf/efL1FKIUE7YWs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VEM3m78WGws2DXrddYhjSmSOElQ9T5QK9lwl2i1X5BXv01pXeiYq9iLXQnW+kx9s9WADjcPB81ou4r6+3Lc3oXpW8utdfQMc++FochTyhSMIlBmQarqw//FH3ec4zDI9paQnFXB0C60YotQOFvYhPVEsYPI2UtTm3NgYwLPN9Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJcfJq+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BC05C32782;
	Tue, 28 May 2024 13:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716903143;
	bh=ct9g6aL365D3+hInh1Gk/WqHw7JZf/efL1FKIUE7YWs=;
	h=From:To:Cc:Subject:Date:From;
	b=XJcfJq+T4o5G6EHYfseBLctsXxdk7SSpPxJtfFNMYmPfcbJeYkP5elcEBSsm82qMl
	 ujzsjfAMuoxivWv5xW+wy/rKlKtDGY4EL3B8inoBnbcqtbZjH+zBik4toSlSglIQxL
	 kwJqHgWm4H1TLBq7VlSkxfo3gI4JlDt3HBhb5rKucBt2TYrXBP8s2pYq6FJP6AoMZJ
	 ZDNxoAkzNIwMWy9zkeRlDIC5rU3XL4EDQLWx18HwBUhrSU89DxOS5MMOwt+qc64jUs
	 JN5vI56LPQKK8P/AuHPgdOwyE+xM780R53jOVJBC6/BcdJTed5ARFcOjZoCxulu1xk
	 r+j603nExc4qw==
From: Arnd Bergmann <arnd@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Dmitry Rokosov <ddrokosov@salutedevices.com>,
	Igor Prusov <ivprusov@salutedevices.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: amlogic: ad402: move thermal-zones to top node
Date: Tue, 28 May 2024 15:31:59 +0200
Message-Id: <20240528133215.2266419-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

It appears that this accidentally got added into the spi node, causing
a warning.

arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts:119.16-161.4: Warning (spi_bus_reg): /soc/spi@fd000400/thermal-zones: missing or empty reg property

Fixes: 593ab951232b ("arm64: dts: amlogic: ad402: setup thermal-zones")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../arm64/boot/dts/amlogic/meson-a1-ad402.dts | 62 +++++++++----------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts b/arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts
index c8579b6e67cf..6883471a93b4 100644
--- a/arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-a1-ad402.dts
@@ -84,37 +84,6 @@ vddio_1v8: regulator-vddio-1v8 {
 		vin-supply = <&vddao_3v3>;
 		regulator-always-on;
 	};
-};
-
-/* Bluetooth HCI H4 */
-&uart_AO {
-	status = "okay";
-	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
-	pinctrl-names = "default";
-};
-
-&uart_AO_B {
-	status = "okay";
-};
-
-&saradc {
-	status = "okay";
-	vref-supply = <&vddio_1v8>;
-};
-
-&spifc {
-	status = "okay";
-	pinctrl-0 = <&spifc_pins>;
-	pinctrl-names = "default";
-
-	flash@0 {
-		compatible = "spi-nand";
-		status = "okay";
-		reg = <0>;
-		spi-max-frequency = <96000000>;
-		spi-tx-bus-width = <4>;
-		spi-rx-bus-width = <4>;
-	};
 
 	thermal-zones {
 		soc_thermal: soc_thermal {
@@ -161,6 +130,37 @@ map1 {
 	};
 };
 
+/* Bluetooth HCI H4 */
+&uart_AO {
+	status = "okay";
+	pinctrl-0 = <&uart_a_pins>, <&uart_a_cts_rts_pins>;
+	pinctrl-names = "default";
+};
+
+&uart_AO_B {
+	status = "okay";
+};
+
+&saradc {
+	status = "okay";
+	vref-supply = <&vddio_1v8>;
+};
+
+&spifc {
+	status = "okay";
+	pinctrl-0 = <&spifc_pins>;
+	pinctrl-names = "default";
+
+	flash@0 {
+		compatible = "spi-nand";
+		status = "okay";
+		reg = <0>;
+		spi-max-frequency = <96000000>;
+		spi-tx-bus-width = <4>;
+		spi-rx-bus-width = <4>;
+	};
+};
+
 &usb2_phy1 {
 	phy-supply = <&vcc_3v3>;
 };
-- 
2.39.2


