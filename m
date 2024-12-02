Return-Path: <linux-kernel+bounces-427508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E299E04C8
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7ECAB2D2B5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 12:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB52C204F62;
	Mon,  2 Dec 2024 12:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="ve43uN6Z"
Received: from mxout2.routing.net (mxout2.routing.net [134.0.28.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D75B2036E2;
	Mon,  2 Dec 2024 12:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733142383; cv=none; b=ogvXTW2t4FVvuX6+58FOx3M0lrNnXvmdh0cLeShcogDTUBZ47tSBC+HSILsNWEDeNzfeVQhwIq4IM0grCXiOpYfvmRd5MEJBaxFPX9/3I5bO6Ir17Em14rXRZVHnbkGuHLb/PKASHKIBooqMrSD0a7BcN/jQpJjPiPSCdkucaok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733142383; c=relaxed/simple;
	bh=v/lvT40iQkeFihnGl29We4f/Ljx2oLq5cwc5zGdZYVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CyJfxUOKK5h818X7AOvcXVAyMdf11vyp7ZveDHOQKGrj+Mpj4uKoMwpt7DLZ2fVSi1NAVHPdZw1Bef4mu4IK98E4rCXcJkjav/6v6wnqlFX/5pM6q+Zms2CTfbemOyG776HpKLbeA5Zad043/LroiFrT6QhMs355oWMun0XvBQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=ve43uN6Z; arc=none smtp.client-ip=134.0.28.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox3.masterlogin.de (unknown [192.168.10.78])
	by mxout2.routing.net (Postfix) with ESMTP id 9FE8B6046B;
	Mon,  2 Dec 2024 12:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1733142379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F+NbD+wZQ6ShmiTE1VBzMI+WZ0I6gWWrVj/25CLxM5M=;
	b=ve43uN6ZvLOqxl2lmQMnJ2uQBQ+GcRMqa7bX86qX3Rj4PskemQh4N+1kxThe4XiUI/niXd
	Pgi9K8zr/j6hiFg/Tr7qFLYke3t8Jl5TsGndIEMtlCYkIJ6KhbZx4s7xJzMZ17543iOYGd
	uWXgm58HtaO5BTDeREfkSZVidlC8rpY=
Received: from frank-u24.. (fttx-pool-217.61.149.104.bambit.de [217.61.149.104])
	by mxbox3.masterlogin.de (Postfix) with ESMTPSA id 23765360552;
	Mon,  2 Dec 2024 12:26:19 +0000 (UTC)
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
Subject: [PATCH v2 16/18] arm64: dts: mediatek: mt7988: add i2c-mux on bpi-r4
Date: Mon,  2 Dec 2024 13:25:57 +0100
Message-ID: <20241202122602.30734-17-linux@fw-web.de>
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
X-Mail-ID: e9fef51d-d790-4f4a-a033-1e5bd1d942c1

From: Frank Wunderlich <frank-w@public-files.de>

Bananapi R4 uses an i2c multiplexer for SFP slots, rtc and eeprom.
Add its node to the right i2c controller.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
---
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dts  | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
index 550c373b3d70..9ceefc990000 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
@@ -2,6 +2,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/richtek,rt5190a-regulator.h>
 
 #include "mt7988a.dtsi"
@@ -138,6 +139,45 @@ &i2c2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c2_1_pins>;
 	status = "okay";
+
+	pca9545: i2c-mux@70 {
+		reg = <0x70>;
+		compatible = "nxp,pca9545";
+		reset-gpios = <&pio 5 GPIO_ACTIVE_LOW>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		i2c@0 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0>;
+
+			pcf8563: rtc@51 {
+				compatible = "nxp,pcf8563";
+				reg = <0x51>;
+				#clock-cells = <0>;
+			};
+
+			eeprom@57 {
+				compatible = "atmel,24c02";
+				reg = <0x57>;
+				size = <256>;
+			};
+
+		};
+
+		i2c_sfp1: i2c@1 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <1>;
+		};
+
+		i2c_sfp2: i2c@2 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <2>;
+		};
+	};
 };
 
 &pio {
-- 
2.43.0


