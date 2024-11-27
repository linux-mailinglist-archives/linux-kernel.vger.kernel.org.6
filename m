Return-Path: <linux-kernel+bounces-423374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A67C9DA688
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 12:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2BE88B27615
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 11:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E3F1F130A;
	Wed, 27 Nov 2024 11:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q9rQRz9L"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CE41EE035
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732705308; cv=none; b=jpzYJz1uHDkkl6X60NBYKV0dlVthl0UpJuWI6swDzcuQugUFBp6pRoFGdy+wB8mmd389FXYebXIjwoBo1I5kTMF2eNsWiOhE+A4FBhs96eBdr4cLcUOnAKistRE5j+eTnjODMtEHeP7uOZUZoVAC6Q+8Hnw3/mVAkJ9GclFRJ60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732705308; c=relaxed/simple;
	bh=kck+d2QOFZ1QTUsEEtVgD4V3qv1m6CMUYhFTMP5YqAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GuG7mS5bcAqnEJBDFlIk9wZf09EJ6o501VF20jbyf3QUYwwYpzphAIXQQYfUxmANyqD+trb0tW/jymV+JgC9qT7SaINmXeQmRe4+Qh+p6jxfv4+MOYNAb/DZSuBiUyy6I8j2Anvgov8+nWJzURATQyL3arW8NW6vgNIS+jyqMgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q9rQRz9L; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa545dc7105so564569766b.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 03:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732705304; x=1733310104; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lE4wmixBBgayLXBCtLCcMeypgTnpcFbWaBYeAtvt70Q=;
        b=q9rQRz9LMmRiOkxpsDiUxa6F76ChZFOH+HPoGkGkGMCPSrAxQANlE6hLz/oRH0vEVn
         wyt8hCNUmyklQpNRqkjlVgktGCWbtbalfyAQnbn4auXWAxzTrpukRyD0fvEiH4iGyndw
         gpKZxhgT1C54Wfrd0LR38xkNIHA+4IAtR64OK5y4xE6MDoSW2584lvSp3r9yEXN3H+3A
         t7/ATUoMToFvw801jVIVPhS8AkVkKrLIvJTdLq5dv+jMZIB77ygKAI4qbGvI328R0bOT
         hYmkiOqisgemTYUwO66KxfqbD1H58SW9n53HDyVUEUQS1XNC58SHMeU5+Vv32/rpE5gn
         ioyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732705304; x=1733310104;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lE4wmixBBgayLXBCtLCcMeypgTnpcFbWaBYeAtvt70Q=;
        b=PIcP0jYegQVKOVY4LHdM1KCx3GnL8U3go5UJ+RrETtoH+lXygWcAXGx93LzoGNoBF8
         6wtqzNe9okvDi3qL8kHFKagEwgRvMFY0KecROA17jFTI7n+Yz2qmfJLFoD77y3ZQ3oRG
         6NqIvev8xbnbMpOo2k2NAdafiOVBfZ4+0+4X+pJ7G3XCEd/tid1WhcoxQDjwnXbFOEHU
         mtmDd6FTdFAsLm+tdjx3vmVUkXAfzKY8DFVt7FVv/8TSTNY2bwSggj2qTyTIRPtjQHlv
         gFeJ8jv4/kBRqY3NXU3P6rc2ziXkk7A+a7RKi3PnKJFwdmoelYMeyqqr1HtNm7259VR/
         1QjA==
X-Forwarded-Encrypted: i=1; AJvYcCVqp3FxR1DtcGPaK7gpiO34tdjNPxKcpCCguDzCBnAwlzJNfQw1gffj7Lse8a4VQWbRjZyHhzx+fHv+h9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YynIkfnYhV/Gvv/qHdbDNWFw+CiO+wxWFnOR6gcmqkutdRfEki7
	O/LTljPcktNd8nVcic4NlzRRCt7kxcy9cYem6breIaOJeWrDfuemUlGRu8+nP2APwnl0aMDF/W1
	Ngx4=
X-Gm-Gg: ASbGncvLk0OeYN97nhssToNvGupLEzUxHU6wN3CbXEUoVLC6sLQYMeDIVayvAVynRhD
	iBxAAX90yA2UxjR8hEBnDQklR/0FM3kzcWfx8vcAMpDhOOssZM3DzIEnKXZPM3lGe+W3aLPNcod
	ctYgVHUZUTJOF1FOMV77RxZjkt4McXLlE/Qr/Caqy1e1zqdgDKRTO7O+pSVf/lu9wyMUqxb7n1o
	2zlJ//JdMtq87rBxMvXT2/dcuuw4xHiVlK8fMUOJXdCtoSVwA91fHC4BcLO5RhQYTTuiVCg4g08
	3i66BromDJRpOcBMQ9I1USAMjVhJb3akIA==
X-Google-Smtp-Source: AGHT+IEjfWpzgWvuf2PuWauL4irDzBBYokZtNaKPDwP8hTNSrJiLJvviKNCQ2xOU0CW7rCVG+Drreg==
X-Received: by 2002:a17:906:2192:b0:aa5:e01:1471 with SMTP id a640c23a62f3a-aa5810330a4mr150052566b.37.1732705303655;
        Wed, 27 Nov 2024 03:01:43 -0800 (PST)
Received: from puffmais.c.googlers.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b339612sm693762966b.84.2024.11.27.03.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 03:01:43 -0800 (PST)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Wed, 27 Nov 2024 11:01:43 +0000
Subject: [PATCH 5/6] arm64: dts: exynos: gs101-oriole: enable Maxim
 max77759 TCPCi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241127-gs101-phy-lanes-orientation-dts-v1-5-5222d8508b71@linaro.org>
References: <20241127-gs101-phy-lanes-orientation-dts-v1-0-5222d8508b71@linaro.org>
In-Reply-To: <20241127-gs101-phy-lanes-orientation-dts-v1-0-5222d8508b71@linaro.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jagan Sridharan <badhri@google.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, Roy Luo <royluo@google.com>, 
 kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.13.0

On Pixel 6 (and Pro), a max77759 companion PMIC for USB Type-C
applications is used, which contains five functional blocks (at
distinct I2C addresses):
  * top
  * charger
  * fuel gauge
  * TCPCi
  * GPIO

The TCPCi is required to detect and handle connector orientation in
Pixel's USB PHY driver, and to configure the USB controller's role
(host vs device).

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101-oriole.dts | 99 ++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
index 387fb779bd29..5f7be0cb7418 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
+++ b/arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
@@ -10,6 +10,7 @@
 
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/usb/pd.h>
 #include "gs101-pinctrl.h"
 #include "gs101.dtsi"
 
@@ -90,6 +91,84 @@ eeprom: eeprom@50 {
 &hsi2c_12 {
 	status = "okay";
 	/* TODO: add the devices once drivers exist */
+
+	usb-typec@25 {
+		compatible = "maxim,max77759", "maxim,max33359";
+		reg = <0x25>;
+		interrupts-extended = <&gpa8 2 IRQ_TYPE_LEVEL_LOW>;
+		pinctrl-0 = <&typec_int>;
+		pinctrl-names = "default";
+
+		connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			data-role = "dual";
+			power-role = "dual";
+			self-powered;
+			try-power-role = "sink";
+			op-sink-microwatt = <2600000>;
+			new-source-frs-typec-current = <FRS_5V_1P5A>;
+			slow-charger-loop;
+			/*
+			 * max77759 operating in reverse boost mode (0xA) can
+			 * source up to 1.5A while extboost can only do ~1A.
+			 * Since extboost is the primary path, advertise 900mA.
+			 */
+			source-pdos = <PDO_FIXED(5000, 900,
+						 (PDO_FIXED_SUSPEND
+						  | PDO_FIXED_USB_COMM
+						  | PDO_FIXED_DATA_SWAP
+						  | PDO_FIXED_DUAL_ROLE))>;
+			sink-pdos = <PDO_FIXED(5000, 3000,
+					       (PDO_FIXED_DATA_SWAP
+						| PDO_FIXED_USB_COMM
+						| PDO_FIXED_HIGHER_CAP
+						| PDO_FIXED_DUAL_ROLE))
+				     PDO_FIXED(9000, 2200, 0)
+				     PDO_PPS_APDO(5000, 11000, 3000)>;
+			sink-vdos = <VDO_IDH(1, 1, IDH_PTYPE_PERIPH, 0,
+					     IDH_PTYPE_DFP_HOST, 2, 0x18d1)
+				     VDO_CERT(0x0)
+				     VDO_PRODUCT(0x4ee1, 0x0)
+				     VDO_UFP(UFP_VDO_VER1_2,
+					     (DEV_USB2_CAPABLE
+					      | DEV_USB3_CAPABLE),
+					     UFP_RECEPTACLE, 0,
+					     AMA_VCONN_NOT_REQ, 0,
+					     UFP_ALTMODE_NOT_SUPP,
+					     UFP_USB32_GEN1)
+				     /* padding */ 0
+				     VDO_DFP(DFP_VDO_VER1_1,
+					     (HOST_USB2_CAPABLE
+					      | HOST_USB3_CAPABLE),
+					     DFP_RECEPTACLE, 0)>;
+			sink-vdos-v1 = <VDO_IDH(1, 1, IDH_PTYPE_PERIPH, 0,
+						0, 0, 0x18d1)
+					VDO_CERT(0x0)
+					VDO_PRODUCT(0x4ee1, 0x0)>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usbc0_orien_sw: endpoint {
+						remote-endpoint = <&usbdrd31_phy_orien_switch>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					usbc0_role_sw: endpoint {
+						remote-endpoint = <&usbdrd31_dwc3_role_switch>;
+					};
+				};
+			};
+		};
+	};
 };
 
 &pinctrl_far_alive {
@@ -106,6 +185,13 @@ key_volup: key-volup-pins {
 		samsung,pin-pud = <GS101_PIN_PULL_NONE>;
 		samsung,pin-drv = <GS101_PIN_DRV_2_5_MA>;
 	};
+
+	typec_int: typec-int-pins {
+		samsung,pins = "gpa8-2";
+		samsung,pin-function = <GS101_PIN_FUNC_EINT>;
+		samsung,pin-pud = <GS101_PIN_PULL_UP>;
+		samsung,pin-drv = <GS101_PIN_DRV_2_5_MA>;
+	};
 };
 
 &pinctrl_gpio_alive {
@@ -142,9 +228,16 @@ &usbdrd31_dwc3 {
 	role-switch-default-mode = "peripheral";
 	maximum-speed = "super-speed-plus";
 	status = "okay";
+
+	port {
+		usbdrd31_dwc3_role_switch: endpoint {
+			remote-endpoint = <&usbc0_role_sw>;
+		};
+	};
 };
 
 &usbdrd31_phy {
+	orientation-switch;
 	/* TODO: Update these once PMIC is implemented */
 	pll-supply = <&reg_placeholder>;
 	dvdd-usb20-supply = <&reg_placeholder>;
@@ -153,6 +246,12 @@ &usbdrd31_phy {
 	vdda-usbdp-supply = <&reg_placeholder>;
 	vddh-usbdp-supply = <&reg_placeholder>;
 	status = "okay";
+
+	port {
+		usbdrd31_phy_orien_switch: endpoint {
+			remote-endpoint = <&usbc0_orien_sw>;
+		};
+	};
 };
 
 &usi_uart {

-- 
2.47.0.338.g60cca15819-goog


