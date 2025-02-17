Return-Path: <linux-kernel+bounces-518171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B86C2A38AF0
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 18:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797FF16E75F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 17:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF78231CB0;
	Mon, 17 Feb 2025 17:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ub8l+g/X"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0FD229B21
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 17:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739814949; cv=none; b=rNkoJII/UZKTlsxGJDAE1XNp4vb5knAL7xVd4/7efZ1OqNWFTkZiyHbGi0c4nKN84E77QLoMjch3Mnp3X+giU1kSkvCLh6Fc/Yj0F8iVh9Aw4QIYFd1wTHuj6YrbQZzJH6JcW3MOeZovRD+xlsNJFpy7WJWXQ8ZrLRmrVSuyWL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739814949; c=relaxed/simple;
	bh=5hkUoC3+amsHF1qrXInhFICP1KnhED+w7Ap95nJYZaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PVxxr2Jqy3T2Ni0RgKmCAuZlT3brAPNXp6UrFeeRU1+zTJFrp4OWBFZ7D7IwJq+Vllf9W21e+Npzw55IqdHD52NbXn2PqzDWnfA8VUCJRmCFLzmVXOhOhcU51fM7UYj8b67nbb+YetsQfyyAN3mZ/OpU50J4tLDXxAbWeZZMk6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ub8l+g/X; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4395dddb07dso48342725e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 09:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739814946; x=1740419746; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Bstxg6aAtD9jX2Uqr4kULz226chVwc5s2P7OWkQ6aI=;
        b=Ub8l+g/X26s++7qr21hrad88TzYxm5DGAGcJoaLW9i2JuoFDgNNWmYm+Bfl/uvVBNw
         aMOYtoBoLZC8gE8K5S+ErsXzRP1y0yYV+/Hlv4cZ3QHKvNuBT3oMfNy4VhWial4dz2gA
         zqP2/3NIOjb2D8rNGuEYezYFDNZjIypb9tPQ44Wf9a9764EmRSy9er+N8NfuEtXV3pFk
         0w4orMdPTqbksWv+fKIFWC1m8wFFft3WtkPowX0wTvUO/TWUpfqu+2mf4MoC8k4xca2Y
         Hndp7malX4cSUU0FT9xvEnS8JyAzO3tzvbiJuV7NnqrwA/IfLo8Zapht2vKKw0kNUuWt
         LILQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739814946; x=1740419746;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Bstxg6aAtD9jX2Uqr4kULz226chVwc5s2P7OWkQ6aI=;
        b=IZmclmxBLGajNaZq5Knl19yKT1eepsvvkwWgacfSxUGmPmIBrMU14eVY8th7kuW1nw
         6I5NSUDOJoRejUsSPnyAy7Ci/OichgWyUlkIBrU5LMOxHnXNPOLOh1Miq51S0op0Osww
         cSTitthXr6YdYW5HEW/ydGpgujfk/URLoO3ey6V29o5I/BnL96P93ZaRtTjU16TEwjuN
         kkWpgZhR1i2Bg/SDRyu6NJkQMKBSnUhshbu8qmNh15j+S6UXrd6A3D9tGsoV62hQ9lOH
         PsKoRp3TDvcUaOZXArzqzHMOOt68mi8nJULH3x9fKRp3axd8KYD7/b0nOR47fj6V14yk
         YHkg==
X-Forwarded-Encrypted: i=1; AJvYcCWSgsXltEOhe9pVfoCylk+MskfEoLIM3Mjab+zG+X/W1iA6t8HErOBKPP7Q4mmLWADQT3JnDChYjPmX3YI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+08j2MF4WEUM7UKZ7gwI0sy7IoNIlbWvOfRTaXr6NvlrA94/7
	Vqjf5meva8WY3t45+JKYqDp3BFIPw+bn6JUmvWXE3bUgCKcPK8aCThoo/TCePLg=
X-Gm-Gg: ASbGncugfPEiaKkgdPQAELoSMHYjGy7REY2K7bfGsWx+C5N56wjf/jAF60wth50jkkr
	9HFv9PUhNGargeG+NgSvLWJ3A9oejkmCfIsFEAH+NXE8ZHcO3fAKfTqr5AHe9CXdq/iN/LwXZSw
	nq05BlY5R/U7jdjjE4G6Z1zzeA3iNii7FAxcWkF9ABv+7Ga6OgidVf1AkvwJi4E/sFZHPabhJ/M
	25+b/lB1CW4ZAOY+wVI4eq0SGTsrppEQ702rHbrMukG7FfcE+3Jq75UNVFoyLrDeQwB8773GAHi
	UgDi/4jlYUuqnB13EyhTxBA8j410kQ==
X-Google-Smtp-Source: AGHT+IFTLcWChe/TpfcRU31PaZWkMA3HiydKUWofMaadNMzdOJpsLlbL3BnV3RVInRO37VebIyUiLA==
X-Received: by 2002:a05:6000:1a88:b0:38f:3471:71c8 with SMTP id ffacd0b85a97d-38f34717a8cmr10251107f8f.3.1739814945937;
        Mon, 17 Feb 2025 09:55:45 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:70ff:3068:45e8:b844])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258dcc50sm13090095f8f.34.2025.02.17.09.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 09:55:45 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Mon, 17 Feb 2025 18:55:23 +0100
Subject: [PATCH v3] arm64: dts: qcom: x1e80100-qcp: Add WiFi/BT pwrseq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-x1e80100-pwrseq-qcp-v3-1-a0525cc01666@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAp4s2cC/33NzQrCMAzA8VcZPRtJ2m7dPPke4qGr3VaQfbRSJ
 2PvbjfwIIi3/AP5ZWHBemcDO2UL8za64IY+hThkzHS6by24W2rGkUtCVDCTLTFNMD59sBNMZgR
 eN2VVmgJFLli6HL1t3Lyrl2vqzoXH4F/7k0jb9r8XCRAaRUWRE+qa1Pnueu2H4+BbtoGRf5AcO
 dFvhAOBkUJWRldK6voLWdf1DSWeJrz8AAAA
X-Change-ID: 20241007-x1e80100-pwrseq-qcp-2bf898c60353
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, Johan Hovold <johan@kernel.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
X-Mailer: b4 0.14.2

Add the WiFi/BT nodes for QCP and describe the regulators for the WCN7850
combo chip using the new power sequencing bindings. All voltages are
derived from chained fixed regulators controlled using a single GPIO.

The same setup also works for CRD (and likely most of the other X1E80100
laptops). However, unlike the QCP they use soldered or removable M.2 cards
supplied by a single 3.3V fixed regulator. The other necessary voltages are
then derived inside the M.2 card. Describing this properly requires
new bindings, so this commit only adds QCP for now.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
Changes in v3:
- Fix node ordering (Johan)
- Link to v2: https://lore.kernel.org/r/20250211-x1e80100-pwrseq-qcp-v2-1-c4349ca974ab@linaro.org

Changes in v2:
- Rebase on qcom for-next, patch 1-2 were applied already
- Mention dummy regulator warning
- Link to v1: https://lore.kernel.org/r/20241007-x1e80100-pwrseq-qcp-v1-0-f7166510ab17@linaro.org
---
The Linux driver currently warns about a missing regulator supply:

  pwrseq-qcom_wcn wcn7850-pmu: supply vddio1p2 not found, using dummy regulator

This supply exists on the WCN7850 chip, but nothing is connected there on
the QCP. Bartosz is working on hiding this warning in the driver. Since the
DT is correct and the same setup is already used on SM8550 upstream, this
doesn't block this patch.
---
 arch/arm64/boot/dts/qcom/x1e80100-qcp.dts | 144 ++++++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
index ec594628304a9ab9fe2dd7cdc0467953cd82dc1f..4254e9a364001f076eb066651bae8743bd1e31ec 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-qcp.dts
@@ -17,6 +17,7 @@ / {
 
 	aliases {
 		serial0 = &uart21;
+		serial1 = &uart14;
 	};
 
 	wcd938x: audio-codec {
@@ -281,6 +282,42 @@ vreg_nvme: regulator-nvme {
 		regulator-boot-on;
 	};
 
+	vreg_wcn_0p95: regulator-wcn-0p95 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_WCN_0P95";
+		regulator-min-microvolt = <950000>;
+		regulator-max-microvolt = <950000>;
+
+		vin-supply = <&vreg_wcn_3p3>;
+	};
+
+	vreg_wcn_1p9: regulator-wcn-1p9 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_WCN_1P9";
+		regulator-min-microvolt = <1900000>;
+		regulator-max-microvolt = <1900000>;
+
+		vin-supply = <&vreg_wcn_3p3>;
+	};
+
+	vreg_wcn_3p3: regulator-wcn-3p3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_WCN_3P3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 214 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&wcn_sw_en>;
+		pinctrl-names = "default";
+
+		regulator-boot-on;
+	};
+
 	usb-1-ss0-sbu-mux {
 		compatible = "onnn,fsusb42", "gpio-sbu-mux";
 
@@ -337,6 +374,65 @@ usb_1_ss2_sbu_mux: endpoint {
 			};
 		};
 	};
+
+	wcn7850-pmu {
+		compatible = "qcom,wcn7850-pmu";
+
+		vdd-supply = <&vreg_wcn_0p95>;
+		vddio-supply = <&vreg_l15b_1p8>;
+		vddaon-supply = <&vreg_wcn_0p95>;
+		vdddig-supply = <&vreg_wcn_0p95>;
+		vddrfa1p2-supply = <&vreg_wcn_1p9>;
+		vddrfa1p8-supply = <&vreg_wcn_1p9>;
+
+		wlan-enable-gpios = <&tlmm 117 GPIO_ACTIVE_HIGH>;
+		bt-enable-gpios = <&tlmm 116 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-0 = <&wcn_wlan_bt_en>;
+		pinctrl-names = "default";
+
+		regulators {
+			vreg_pmu_rfa_cmn: ldo0 {
+				regulator-name = "vreg_pmu_rfa_cmn";
+			};
+
+			vreg_pmu_aon_0p59: ldo1 {
+				regulator-name = "vreg_pmu_aon_0p59";
+			};
+
+			vreg_pmu_wlcx_0p8: ldo2 {
+				regulator-name = "vreg_pmu_wlcx_0p8";
+			};
+
+			vreg_pmu_wlmx_0p85: ldo3 {
+				regulator-name = "vreg_pmu_wlmx_0p85";
+			};
+
+			vreg_pmu_btcmx_0p85: ldo4 {
+				regulator-name = "vreg_pmu_btcmx_0p85";
+			};
+
+			vreg_pmu_rfa_0p8: ldo5 {
+				regulator-name = "vreg_pmu_rfa_0p8";
+			};
+
+			vreg_pmu_rfa_1p2: ldo6 {
+				regulator-name = "vreg_pmu_rfa_1p2";
+			};
+
+			vreg_pmu_rfa_1p8: ldo7 {
+				regulator-name = "vreg_pmu_rfa_1p8";
+			};
+
+			vreg_pmu_pcie_0p9: ldo8 {
+				regulator-name = "vreg_pmu_pcie_0p9";
+			};
+
+			vreg_pmu_pcie_1p8: ldo9 {
+				regulator-name = "vreg_pmu_pcie_1p8";
+			};
+		};
+	};
 };
 
 &apps_rsc {
@@ -825,6 +921,23 @@ &pcie4_phy {
 	status = "okay";
 };
 
+&pcie4_port0 {
+	wifi@0 {
+		compatible = "pci17cb,1107";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+
+		vddaon-supply = <&vreg_pmu_aon_0p59>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p8-supply = <&vreg_pmu_rfa_1p8>;
+		vddpcie0p9-supply = <&vreg_pmu_pcie_0p9>;
+		vddpcie1p8-supply = <&vreg_pmu_pcie_1p8>;
+	};
+};
+
 &pcie6a {
 	perst-gpios = <&tlmm 152 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 154 GPIO_ACTIVE_LOW>;
@@ -1135,6 +1248,37 @@ wcd_default: wcd-reset-n-active-state {
 		bias-disable;
 		output-low;
 	};
+
+	wcn_wlan_bt_en: wcn-wlan-bt-en-state {
+		pins = "gpio116", "gpio117";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	wcn_sw_en: wcn-sw-en-state {
+		pins = "gpio214";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+};
+
+&uart14 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn7850-bt";
+		max-speed = <3200000>;
+
+		vddaon-supply = <&vreg_pmu_aon_0p59>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p8-supply = <&vreg_pmu_rfa_1p8>;
+	};
 };
 
 &uart21 {

---
base-commit: c177fed7617d6306541305e93e575c0c01600ff0
change-id: 20241007-x1e80100-pwrseq-qcp-2bf898c60353

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>


