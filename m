Return-Path: <linux-kernel+bounces-448911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 619DB9F4719
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FCE8169D6B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 09:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E5F1F37BF;
	Tue, 17 Dec 2024 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b="Rzf9aAxb"
Received: from mxout4.routing.net (mxout4.routing.net [134.0.28.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505F31D63DB;
	Tue, 17 Dec 2024 09:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.0.28.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734426787; cv=none; b=byoJbiMBFw9wuQYeDeo9l9S9xOHNTAIb4hm9B5pRnyUPatTkdDmqiL67HEwnBLMU06mvUDIStjpFSMksi+2hPxDP/VckXf9SCbEi3ElHkRjQsB7IB3HNA3l87uhSnzOshKSdqnEAGHxRRDgv4VEo4vjxdH9vsrCwHg54YckKjnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734426787; c=relaxed/simple;
	bh=w2i0g21k3LzNx4vq65KmMw4oqYSSDQJKmKlJ573rYDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OtcAlyTG3fD/sunkjCKVd49uZR8BTv0jeTQWufd7BMZ/7v+b8pHIjhTnj4cqP91TLENriZk15o2ua94sEvG2G6SI7TxN+eEutvuznTw9usM1l8Nl5hDulFYfpmOC1H7CuX/XvNxl6QuvxQIP2m2CdXOtX9LR2QnO0mtljq9r2BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de; spf=pass smtp.mailfrom=fw-web.de; dkim=pass (1024-bit key) header.d=mailerdienst.de header.i=@mailerdienst.de header.b=Rzf9aAxb; arc=none smtp.client-ip=134.0.28.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fw-web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fw-web.de
Received: from mxbox2.masterlogin.de (unknown [192.168.10.89])
	by mxout4.routing.net (Postfix) with ESMTP id B4531100875;
	Tue, 17 Dec 2024 09:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
	s=20200217; t=1734426784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uixtMCsS/wv+j4qweODMlsl1da3nZrt3WSC8+Wqjz3k=;
	b=Rzf9aAxbk7a04+a9D5R+CFzQaYARXYdLWGoxsYNOCKHvy79X5VXTjNcZT+nG2WddOneyDp
	9qIyIIQjHiZGqjGZv4p1iExys44JIe8+aE4z+S1MFFM1ZCtiAjhT9PVaXdmhPcJIqu9K3w
	Uj5t4+OzEL9gGjDxYGctG+CQA3NAzm0=
Received: from frank-u24.. (fttx-pool-217.61.150.187.bambit.de [217.61.150.187])
	by mxbox2.masterlogin.de (Postfix) with ESMTPSA id 0667610030F;
	Tue, 17 Dec 2024 09:13:04 +0000 (UTC)
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
Subject: [PATCH v3 18/22] arm64: dts: mediatek: mt7988a-bpi-r4: Add PCA9545 I2C Mux
Date: Tue, 17 Dec 2024 10:12:32 +0100
Message-ID: <20241217091238.16032-19-linux@fw-web.de>
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
X-Mail-ID: 3a0deb92-ae26-450f-ba17-960f73ac9588

From: Frank Wunderlich <frank-w@public-files.de>

Bananapi R4 uses an i2c multiplexer for SFP slots, rtc and eeprom.
Add its node to the right i2c controller.

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
changes:
v3:
- move reg after compatible
- change commit title
---
 .../dts/mediatek/mt7988a-bananapi-bpi-r4.dts  | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
index 3d165f7b29dc..0dc1fd9265c6 100644
--- a/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7988a-bananapi-bpi-r4.dts
@@ -2,6 +2,8 @@
 
 /dts-v1/;
 
+#include <dt-bindings/gpio/gpio.h>
+
 #include "mt7988a.dtsi"
 
 / {
@@ -70,6 +72,45 @@ &i2c2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c2_1_pins>;
 	status = "okay";
+
+	pca9545: i2c-mux@70 {
+		compatible = "nxp,pca9545";
+		reg = <0x70>;
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


