Return-Path: <linux-kernel+bounces-210212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F9F9040DF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B8DB1C23898
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8690A3A28D;
	Tue, 11 Jun 2024 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZOnkZBxI"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE46A94C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 16:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718122084; cv=none; b=DXBWvXM8N6WGHRfva0R/PIBWCzMdZcanIwc0qnViTGjAHOsbNmCseIDEKcliEk4SuB2rfIyNplzAvBKITvA/t9dtADlW+rVfN4ksK5dZDdVBTSgpGXP9YLU1MlIfi86lyw6q2s7PUjSXssgoSruBXlh6ShnKGUrzQcAQf7LUzjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718122084; c=relaxed/simple;
	bh=OSxpykUCDOtz4FP2u13GeoHJw2xF6TOx7thtDiW8Q7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=acB0CSAgUzVQ2SDPd9XdXsaSgR9MH3XZqOSW7jU6Q9XfPPHwpgR7f3BP3Nyh7o/0Nk+8j7xM7bW0bD+nMX3BNQ9y7MgAwnLqoHBVIq/UDYYXAFnZ5cHwEH3HB8mLihJVo7tnuSoG//8WTIplW+U5tlcnz6zDTkNZap7OpGmCnmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZOnkZBxI; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57c7440876bso1720812a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718122080; x=1718726880; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Usr3iQr9P44DbTK5za8+K7ebuiDZp91g0I8Srd02vj4=;
        b=ZOnkZBxIBrIizyaYP9WQLL+f5hWy1BcBFw39Orbly/61pDYIVrcf+kp8AOXhRfVp4O
         hn1gZu30D8643v1XiKCgwD8kveLVlmNgZNwxbuC7QRr4/m2OCTDJBN6TV50DUQVkxWw4
         WogAretDDshWN1PzWgE6X/4CgLa7a9m/rAy17s1+IDG8B+wnsfNSjCH1HcLZGzjLmc4v
         ab7R83h/RAILIdajwk3gYlO+RqxjNDP5GWl1L7d7bpgeTR6Rl3kOpcATHDqkbBvhAF9N
         f81zszQGsdBU1sFxrS2bAEnHCtlZzl1mvoJ+tJkl4EqLGT5QFzArwXRZh4UEsYekL00S
         YjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718122080; x=1718726880;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Usr3iQr9P44DbTK5za8+K7ebuiDZp91g0I8Srd02vj4=;
        b=KluznQUuS5KzcBpRl7ZpdFDZPnWZQceGNG1K9j0uuzzhRovDgPpB/MTvFdRJN0WYgB
         FkVSMfq1jQJn9GVS0h/SQ4kbBW2pUoRbseG2Slk4AnYzGuwUAK1xUBphB+K/BKsPFM3O
         /hqEJeSEucG4Q9O7bdrZM4nKpUB+dOBQ8zBCvCAC35k9gl6zE/IIq31xhxXFRM+R7yPb
         Kjfld+prn17maMQuf+9ZTtHt6WtYG4SN6B4SXI8UEkl4mi974D2aJeTsGNrPulRuKQuw
         zIRWT1eTLTjJrrdpdvnpfW0qB1m4NU3ZJ94DB+5rkHRgMFXhjetpsSjtmzZH1YPVv0XK
         DsHg==
X-Forwarded-Encrypted: i=1; AJvYcCVOakchcVPwob9Hn92vtfcBv93NXIBg/hv5aRgecZGrPD6Nmis/dg0jxxiKBbYmiehRuf8MQXjO+IV0AvMHIGuz3EK2+oDlu69y4hKs
X-Gm-Message-State: AOJu0Yyhrecci/eYNcPc89bGu/QkC6eaDgewVVBbtmpk82G6YCsCy15z
	DqfphI1T3781p/jA8Y/Ig3KjGJJEe5Ibd7nKyr4/j4on1lzMgih83C8h2GZxZeQCX/OQJZoocIr
	oxhY=
X-Google-Smtp-Source: AGHT+IEowbwwQtXxbAT06y7Gg7FQMQ53Bw7eHa7p2QqiWVbkjUjQbUvUYPw++jPdElsPq62dNgJEBA==
X-Received: by 2002:a50:d5da:0:b0:57c:6d9a:914e with SMTP id 4fb4d7f45d1cf-57c6d9a9263mr9092206a12.30.1718122080489;
        Tue, 11 Jun 2024 09:08:00 -0700 (PDT)
Received: from puffmais.c.googlers.com (94.189.141.34.bc.googleusercontent.com. [34.141.189.94])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57c8492fb96sm3503740a12.11.2024.06.11.09.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 09:08:00 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Tue, 11 Jun 2024 17:07:59 +0100
Subject: [PATCH] arm64: dts: exynos: gs101: reorder properties as per
 guidelines
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240611-gs101-dts-cleanup-v1-1-877358cd6536@linaro.org>
X-B4-Tracking: v=1; b=H4sIAF52aGYC/x2MQQqAIBAAvxJ7TlDJpL4SHUS3WggTtyII/550G
 ZjDzAuMmZBhbF7IeBPTEauotgG/ubiioFAdtNSdNFKJlVVlOFn4HV28kpDaLn2waui9gdqljAs
 9/3OaS/kABH6ev2MAAAA=
To: Peter Griffin <peter.griffin@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

* 'interrupts' & 'cpus' & 'clocks' are standard/common properties as
  per the Devicetree Sources (DTS) Coding Style and therefore should be
  sorted alphabetically within the standard/common section
* vendor properties should be last
* reg / ranges should be 2nd/3rd (after compatible)
* status should be last

Do so.

Note: I've left the cpus{} node untouched to keep the grouping of
relatedd properties.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101-oriole.dts |  2 +-
 arch/arm64/boot/dts/exynos/google/gs101.dtsi       | 22 +++++++++++-----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
index 5e8ffe065081..b10bde2ec716 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
+++ b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
@@ -131,9 +131,9 @@ &ufs_0_phy {
 };
 
 &usbdrd31 {
-	status = "okay";
 	vdd10-supply = <&reg_placeholder>;
 	vdd33-supply = <&reg_placeholder>;
+	status = "okay";
 };
 
 &usbdrd31_dwc3 {
diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index a66e996666b8..eadb8822e6d4 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -213,9 +213,9 @@ pmu-2 {
 
 	pmu-3 {
 		compatible = "arm,dsu-pmu";
-		interrupts = <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH 0>;
 		cpus = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>,
 		       <&cpu4>, <&cpu5>, <&cpu6>, <&cpu7>;
+		interrupts = <GIC_SPI 257 IRQ_TYPE_LEVEL_HIGH 0>;
 	};
 
 	psci {
@@ -288,6 +288,8 @@ timer@10050000 {
 			compatible = "google,gs101-mct",
 				     "samsung,exynos4210-mct";
 			reg = <0x10050000 0x800>;
+			clocks = <&ext_24_5m>, <&cmu_misc CLK_GOUT_MISC_MCT_PCLK>;
+			clock-names = "fin_pll", "mct";
 			interrupts = <GIC_SPI 753 IRQ_TYPE_LEVEL_HIGH 0>,
 				     <GIC_SPI 754 IRQ_TYPE_LEVEL_HIGH 0>,
 				     <GIC_SPI 755 IRQ_TYPE_LEVEL_HIGH 0>,
@@ -300,17 +302,15 @@ timer@10050000 {
 				     <GIC_SPI 762 IRQ_TYPE_LEVEL_HIGH 0>,
 				     <GIC_SPI 763 IRQ_TYPE_LEVEL_HIGH 0>,
 				     <GIC_SPI 764 IRQ_TYPE_LEVEL_HIGH 0>;
-			clocks = <&ext_24_5m>, <&cmu_misc CLK_GOUT_MISC_MCT_PCLK>;
-			clock-names = "fin_pll", "mct";
 		};
 
 		watchdog_cl0: watchdog@10060000 {
 			compatible = "google,gs101-wdt";
 			reg = <0x10060000 0x100>;
-			interrupts = <GIC_SPI 765 IRQ_TYPE_LEVEL_HIGH 0>;
 			clocks = <&cmu_misc CLK_GOUT_MISC_WDT_CLUSTER0_PCLK>,
 				 <&ext_24_5m>;
 			clock-names = "watchdog", "watchdog_src";
+			interrupts = <GIC_SPI 765 IRQ_TYPE_LEVEL_HIGH 0>;
 			samsung,syscon-phandle = <&pmu_system_controller>;
 			samsung,cluster-index = <0>;
 			status = "disabled";
@@ -319,10 +319,10 @@ watchdog_cl0: watchdog@10060000 {
 		watchdog_cl1: watchdog@10070000 {
 			compatible = "google,gs101-wdt";
 			reg = <0x10070000 0x100>;
-			interrupts = <GIC_SPI 766 IRQ_TYPE_LEVEL_HIGH 0>;
 			clocks = <&cmu_misc CLK_GOUT_MISC_WDT_CLUSTER1_PCLK>,
 				 <&ext_24_5m>;
 			clock-names = "watchdog", "watchdog_src";
+			interrupts = <GIC_SPI 766 IRQ_TYPE_LEVEL_HIGH 0>;
 			samsung,syscon-phandle = <&pmu_system_controller>;
 			samsung,cluster-index = <1>;
 			status = "disabled";
@@ -776,12 +776,12 @@ hsi2c_8: i2c@10970000 {
 				compatible = "google,gs101-hsi2c",
 					     "samsung,exynosautov9-hsi2c";
 				reg = <0x10970000 0xc0>;
-				interrupts = <GIC_SPI 642 IRQ_TYPE_LEVEL_HIGH 0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_IPCLK_7>,
 					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP0_PCLK_7>;
 				clock-names = "hsi2c", "hsi2c_pclk";
+				interrupts = <GIC_SPI 642 IRQ_TYPE_LEVEL_HIGH 0>;
 				pinctrl-0 = <&hsi2c8_bus>;
 				pinctrl-names = "default";
 				status = "disabled";
@@ -831,10 +831,10 @@ usi_uart: usi@10a000c0 {
 			serial_0: serial@10a00000 {
 				compatible = "google,gs101-uart";
 				reg = <0x10a00000 0xc0>;
-				interrupts = <GIC_SPI 634 IRQ_TYPE_LEVEL_HIGH 0>;
 				clocks = <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP1_PCLK_0>,
 					 <&cmu_peric0 CLK_GOUT_PERIC0_PERIC0_TOP1_IPCLK_0>;
 				clock-names = "uart", "clk_uart_baud0";
+				interrupts = <GIC_SPI 634 IRQ_TYPE_LEVEL_HIGH 0>;
 				pinctrl-0 = <&uart0_bus>;
 				pinctrl-names = "default";
 				samsung,uart-fifosize = <256>;
@@ -1157,12 +1157,12 @@ hsi2c_12: i2c@10d50000 {
 				compatible = "google,gs101-hsi2c",
 					     "samsung,exynosautov9-hsi2c";
 				reg = <0x10d50000 0xc0>;
-				interrupts = <GIC_SPI 655 IRQ_TYPE_LEVEL_HIGH 0>;
 				#address-cells = <1>;
 				#size-cells = <0>;
 				clocks = <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_IPCLK_5>,
 					 <&cmu_peric1 CLK_GOUT_PERIC1_PERIC1_TOP0_PCLK_5>;
 				clock-names = "hsi2c", "hsi2c_pclk";
+				interrupts = <GIC_SPI 655 IRQ_TYPE_LEVEL_HIGH 0>;
 				pinctrl-0 = <&hsi2c12_bus>;
 				pinctrl-names = "default";
 				status = "disabled";
@@ -1277,13 +1277,14 @@ usbdrd31_phy: phy@11100000 {
 				 <&cmu_hsi0 CLK_GOUT_HSI0_UASC_HSI0_CTRL_PCLK>,
 				 <&cmu_hsi0 CLK_GOUT_HSI0_USB31DRD_I_USBDPPHY_SCL_APB_PCLK>;
 			clock-names = "phy", "ref", "ctrl_aclk", "ctrl_pclk", "scl_pclk";
-			samsung,pmu-syscon = <&pmu_system_controller>;
 			#phy-cells = <1>;
+			samsung,pmu-syscon = <&pmu_system_controller>;
 			status = "disabled";
 		};
 
 		usbdrd31: usb@11110000 {
 			compatible = "google,gs101-dwusb3";
+			ranges = <0x0 0x11110000 0x10000>;
 			clocks = <&cmu_hsi0 CLK_GOUT_HSI0_USB31DRD_BUS_CLK_EARLY>,
 				<&cmu_hsi0 CLK_GOUT_HSI0_USB31DRD_I_USB31DRD_SUSPEND_CLK_26>,
 				<&cmu_hsi0 CLK_GOUT_HSI0_UASC_HSI0_LINK_ACLK>,
@@ -1291,14 +1292,13 @@ usbdrd31: usb@11110000 {
 			clock-names = "bus_early", "susp_clk", "link_aclk", "link_pclk";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x0 0x11110000 0x10000>;
 			status = "disabled";
 
 			usbdrd31_dwc3: usb@0 {
 				compatible = "snps,dwc3";
+				reg = <0x0 0x10000>;
 				clocks = <&cmu_hsi0 CLK_GOUT_HSI0_USB31DRD_I_USB31DRD_REF_CLK_40>;
 				clock-names = "ref";
-				reg = <0x0 0x10000>;
 				interrupts = <GIC_SPI 463 IRQ_TYPE_LEVEL_HIGH 0>;
 				phys = <&usbdrd31_phy 0>, <&usbdrd31_phy 1>;
 				phy-names = "usb2-phy", "usb3-phy";

---
base-commit: d35b2284e966c0bef3e2182a5c5ea02177dd32e4
change-id: 20240501-gs101-dts-cleanup-027f6d7196c5

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


