Return-Path: <linux-kernel+bounces-303509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 436B7960D1F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 16:08:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF0BA284109
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 14:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A416C1C9EC9;
	Tue, 27 Aug 2024 14:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="MqxKSR+p"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C511C6F57;
	Tue, 27 Aug 2024 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767569; cv=none; b=NuZMHYlVGkvwE6BKfbfg8RGznCvVU+NQOJvcGNuXzVKH1b+pSqDSgwYJwsOIC2ksPnVY46cZogokekU+FezGBua73xqxGXVV+VzSSatfJpfxaPpH8ckvLqtesVEPACj4GRRHA1Oh6RSmycFUMenitJ3+becu2yb1rIqrLjn6eCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767569; c=relaxed/simple;
	bh=d2POF/9oZKypUIUgueFvXnNPKLfuspbfE5JXi6AuUxw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NB9FcjUTlmCSzwDtm/AEHh+qSMduqKsDfzSEL1qWDnUQSpdMLbJnMtgpY/qpIPVsPI8MVrqsLldpibNdzXspdS5oHHi2l72rukU2r/Iyy9ALhhdekr8qlos9p5WPBdEe0Jbg5nigFy4X5Eh48a6QSt586bEhNAEBU0PE+9BoqT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=MqxKSR+p; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47RBUMZg022307;
	Tue, 27 Aug 2024 16:06:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	JPuWythXlb2aVY0RmOdTDjEvW63AoOtJU+vMJ9SxB/M=; b=MqxKSR+pBAirOdE+
	oZ9E/nB499gvXdxFNx1SY5sBjIhwie9+Ea0MPjr5KSIcyaLYbKr9MA744KQ01fIL
	SOGTE+LTXD6vd5YtdaONDLBd5p5efX3a0Q++rYqXAyHutXgBc9qJ+fdrz804NIsb
	OwRaMro4pDWMo9O+HvyLiq+MkilQIwWgFxoagofFOAe8+Y7pGerRLH8kQLYYuZpZ
	is1tbhAYdqAZthuXpdBdUTYTJZZpriXl3Boz3zPjDiUAIxM2wqdF8QdnnaYudrf6
	ODoBq1Kgf6oKxEqPWwIzWj+/r3oQfzwdnuisKmCNkiNJvqf3/Zyv0tRBg6w+2+dW
	XAJ6XQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 419e00rmp4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Aug 2024 16:06:00 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C1B0F40050;
	Tue, 27 Aug 2024 16:05:44 +0200 (CEST)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7462426C461;
	Tue, 27 Aug 2024 16:05:15 +0200 (CEST)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 27 Aug
 2024 16:05:15 +0200
Received: from localhost (10.48.86.111) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 27 Aug
 2024 16:05:15 +0200
From: Valentin Caron <valentin.caron@foss.st.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Christophe Roullier <christophe.roullier@foss.st.com>,
        Valentin Caron
	<valentin.caron@foss.st.com>
Subject: [PATCH 6/9] ARM: dts: stm32: add support of WLAN/BT on stm32mp135f-dk
Date: Tue, 27 Aug 2024 16:04:52 +0200
Message-ID: <20240827140455.345086-7-valentin.caron@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240827140455.345086-1-valentin.caron@foss.st.com>
References: <20240827140455.345086-1-valentin.caron@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SAFCAS1NODE2.st.com (10.75.90.13) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-27_08,2024-08-27_01,2024-05-17_01

From: Christophe Roullier <christophe.roullier@foss.st.com>

Add support of WLAN/BT Murata Type 1DX module:
- usart2 is used for Bluetooth interface
- sdmmc2 is used for WLAN (sdio) interface

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
Signed-off-by: Valentin Caron <valentin.caron@foss.st.com>
---
 arch/arm/boot/dts/st/stm32mp135f-dk.dts | 45 +++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/st/stm32mp135f-dk.dts b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
index ef33cbf3e601c..3a276589fef79 100644
--- a/arch/arm/boot/dts/st/stm32mp135f-dk.dts
+++ b/arch/arm/boot/dts/st/stm32mp135f-dk.dts
@@ -121,6 +121,19 @@ panel_in_rgb: endpoint {
 			};
 		};
 	};
+
+	v3v3_ao: v3v3-ao {
+		compatible = "regulator-fixed";
+		regulator-name = "v3v3_ao";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&mcp23017 11 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &adc_1 {
@@ -392,6 +405,30 @@ &sdmmc1 {
 	status = "okay";
 };
 
+/* Wifi */
+&sdmmc2 {
+	pinctrl-names = "default", "opendrain", "sleep";
+	pinctrl-0 = <&sdmmc2_b4_pins_a &sdmmc2_clk_pins_a>;
+	pinctrl-1 = <&sdmmc2_b4_od_pins_a &sdmmc2_clk_pins_a>;
+	pinctrl-2 = <&sdmmc2_b4_sleep_pins_a>;
+	non-removable;
+	cap-sdio-irq;
+	st,neg-edge;
+	bus-width = <4>;
+	vmmc-supply = <&v3v3_ao>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	brcmf: bcrmf@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		pinctrl-names = "default";
+		pinctrl-0 = <&rtc_lsco_pins_a>;
+	};
+};
+
 &spi5 {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&spi5_pins_a>;
@@ -498,6 +535,14 @@ &usart2 {
 	pinctrl-2 = <&usart2_idle_pins_a>;
 	uart-has-rtscts;
 	status = "okay";
+
+	bluetooth {
+		shutdown-gpios = <&mcp23017 13 GPIO_ACTIVE_HIGH>;
+		compatible = "brcm,bcm43438-bt";
+		max-speed = <3000000>;
+		vbat-supply = <&v3v3_ao>;
+		vddio-supply = <&v3v3_ao>;
+	};
 };
 
 &usbh_ehci {
-- 
2.25.1


