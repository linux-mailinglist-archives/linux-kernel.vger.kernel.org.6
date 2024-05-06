Return-Path: <linux-kernel+bounces-170024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E96D58BD0BC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 16:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5B8E28D84B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 14:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C452B153812;
	Mon,  6 May 2024 14:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="IsOaV9WQ"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF4013BAC7;
	Mon,  6 May 2024 14:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715007062; cv=none; b=d8mapL4F0EliFh0adbWwwPTlaI7Z1fWrfKnKPF2cW4mPohHVH32iOYZVBzYTSkkhRJtokOiGTdrm8+caDjaIOeW4dmD1yHHuWL4i1S1gkhK4rmqn7Rh2HD8fRRKGHgyLeBg7fOoORErpgrbZzXH/19v+PSGdZg7c/QT/qnHMEhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715007062; c=relaxed/simple;
	bh=eSfAG7eRcrkhY+Qr5HX1zI27MCV8+YfsRo1rrRm29Ls=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nuVcX+SPkxBg9rDXsEkjLqpzRR9UbCJ0SO522727EdRN2qUxgRuFOwIoMYIXSChFyyoUIxkfu1e9eD+2zosn7AgioVPlX7Jebl0kHy5e1BCP31yZ2ndFhq6jlTxOmpa/AE3XuAXXuhLCxsT9Np8q/1U8IwN4OeAgeUyoPVX6BHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=IsOaV9WQ; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 446Bbcmp010927;
	Mon, 6 May 2024 16:50:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=lFFdRBl
	/abKwjIsFck+7iM64lIxYS3/Znv6CkxEJjqA=; b=IsOaV9WQBb4PNmAamgQO6Pm
	UsI6cuhN67SNpPbgtJ4Wq+PeizHv3jG5aBChR2vvDjinzQr8Lj4ydQMlrk0hjqO3
	gr0mmxIvCNJrZdQOIBjjnqbZfCVghd6dbBGXYYVvxJAnSjiW7QOASZauCCe0oOWG
	IC9gyJCDKsAmiL9NqDXCICrP75gQ1T7yP+lHzspiJKIJGTpU2C0IVMziTU3WsD6x
	cFgC2cAyxFrKrPhQnGRBJ1wPz6kRxTiIoFir1EelJLG+InMfUgaLWsVE33UkcWrT
	G6KUt6u+EmO/1ZUfl18EOpBqjRS+0Wh3EukYygOxDB/n95QUK3++tLdrQXCLiNQ=
	=
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3xwcbx7j8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 May 2024 16:50:27 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A641D4002D;
	Mon,  6 May 2024 16:50:22 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D753D2248BB;
	Mon,  6 May 2024 16:49:47 +0200 (CEST)
Received: from localhost (10.48.87.177) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 6 May
 2024 16:49:47 +0200
From: Yannick Fertre <yannick.fertre@foss.st.com>
To: Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ARM: dts: stm32: add goodix touchscreen on stm32mp135f-dk
Date: Mon, 6 May 2024 16:49:45 +0200
Message-ID: <20240506144945.293966-1-yannick.fertre@foss.st.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_09,2024-05-06_02,2023-05-22_02

Touchscreen reset needs to be configured
via the pinctrl not the driver (a pull-down resistor
has been soldered onto the reset line which forces
the touchscreen to reset state).
Interrupt line must have a pull-down resistor
in order to freeze the i2c address at 0x5D.

Signed-off-by: Yannick Fertre <yannick.fertre@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi | 22 +++++++++++++++++++++
 arch/arm/boot/dts/st/stm32mp135f-dk.dts     | 14 +++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi b/arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi
index 32c5d8a1e06a..21861cae21d9 100644
--- a/arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi
+++ b/arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi
@@ -13,6 +13,28 @@ pins {
 		};
 	};
 
+	goodix_pins_a: goodix-0 {
+		/*
+		 * touchscreen reset needs to be configured
+		 * via the pinctrl not the driver (a pull-down resistor
+		 * has been soldered onto the reset line which forces
+		 * the touchscreen to reset state).
+		 */
+		pins1 {
+			pinmux = <STM32_PINMUX('H', 2, GPIO)>;
+			output-high;
+			bias-pull-up;
+		};
+		/*
+		 * Interrupt line must have a pull-down resistor
+		 * in order to freeze the i2c address at 0x5D
+		 */
+		pins2 {
+			pinmux = <STM32_PINMUX('F', 5, GPIO)>;
+			bias-pull-down;
+		};
+	};
+
 	i2c1_pins_a: i2c1-0 {
 		pins {
 			pinmux = <STM32_PINMUX('D', 12, AF5)>, /* I2C1_SCL */
diff --git a/arch/arm/boot/dts/st/stm32mp135f-dk.dts b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
index 567e53ad285f..5e8ee2d4648a 100644
--- a/arch/arm/boot/dts/st/stm32mp135f-dk.dts
+++ b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
@@ -201,6 +201,20 @@ &i2c5 {
 	/* spare dmas for other usage */
 	/delete-property/dmas;
 	/delete-property/dma-names;
+
+	goodix: goodix-ts@5d {
+		compatible = "goodix,gt911";
+		reg = <0x5d>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&goodix_pins_a>;
+		interrupt-parent = <&gpiof>;
+		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+		AVDD28-supply = <&scmi_v3v3_sw>;
+		VDDIO-supply = <&scmi_v3v3_sw>;
+		touchscreen-size-x = <480>;
+		touchscreen-size-y = <272>;
+		status = "okay" ;
+	};
 };
 
 &iwdg2 {
-- 
2.34.1


