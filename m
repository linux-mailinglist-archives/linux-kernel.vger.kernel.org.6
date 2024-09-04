Return-Path: <linux-kernel+bounces-313924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE9F96AC6F
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 00:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934E51F25C05
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 22:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20251D58AF;
	Tue,  3 Sep 2024 22:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhM9d89v"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0711D79B7;
	Tue,  3 Sep 2024 22:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725403398; cv=none; b=TDfoeg0Xx0dHgM8EbTaRel+PnVOyIXQF79YBJ7k1Yx3hcuMFrQKiOR8RDWnGmvMqqkAbzPodv8vwPVzqOaPBtqEA6Fs36AXdrTttGa3j0mn6q+f08nGjR4gfwglIEjk6zNJ7FQlCtw2I0k9smtxRTEKCZxn3Fk2BqRe6nr4yxkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725403398; c=relaxed/simple;
	bh=YVHfU0AghXMrqavcHsrzvSGUVAxDUUq9yB0K8t4B+G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rUH6O0kMw9Bwoo9hz0L2b2pT1XiAAJJYalABiCeGk2sRfQTFzZvudlC8Z2lR9+D7Dukr3FInkqm8wwzDsDxHbsOIT//eUl3J/BefmSH9WP9r3ZD5UWSg+2qgMbRF1IrLeOrwospNaHzsVRQlIlrzobo4nl3K8DDdg7mcuo1gXKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhM9d89v; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3770320574aso349723f8f.2;
        Tue, 03 Sep 2024 15:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725403394; x=1726008194; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bJofrhVVuNX7yPUGuUnS0XLKF6s3xFsCiCz5UBpxgIg=;
        b=KhM9d89v3dfH9UueU+Nq00+jhCMoNEuwTpaEblqJiR/C1YoJDQTPApmOo5YyXSTvgt
         mU5Kyr1Qv9pqX9NJUaZQq/6kMQTVOuUaNJp4QOkRuQLyXgmr3KWas2wEdUdfK/fBLaRD
         XJ7PY4Z4pzYJ9UKBI5PAGF6g32rj5BZ4z2qCywZNOWnY8rT968sFd4Bu9yQqWYzMIQWo
         WN9HHA3fJhlpctK7lEUnQnMcke6NujkKteiSeAen8WkWGtOju5mPMEC59uYG4ysFd0vc
         9nS0YWvGC9NyJNNme3awHwSRIkBkmLC6IUkwa5A9XPvKJppSoqHmv7k5TqLRQrH2dP7P
         SCzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725403394; x=1726008194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bJofrhVVuNX7yPUGuUnS0XLKF6s3xFsCiCz5UBpxgIg=;
        b=r4kI80Lak0RKycN0T3j/wZphpCuhUAEG25VQVoGOKnhQ4hWxsDDAkXw/+eDmTvEEnG
         2F/rtnMBlts9n1S0zVxUAfYchyXkO4GfFanZJTnIqyGiF/KgitAw9zdVU+dPkSQkTwSa
         uc6CFxC8YSmEcErXuAzgylvFn3IQD2Ntxk9utdjkZvT5O7cKzuIFblWv8KoganxyAxFv
         Pj85X70qMMqafXoU4MVNGra8P2i/SyF5tdakWVMTRqv1It65jm4+5AOzzAxNuvwVgwtC
         zzrGCjI23yUhMdbpzQ4VRmYSpxuSzwY6BKiOhe0C6BDLwQBAfRPBCj9VmGuefoOhYMof
         bkOw==
X-Forwarded-Encrypted: i=1; AJvYcCU310TlNc/ePtDp6K1p28tnryXnP+yknOG0fT4OerQE+fc++28UmMKmnbKLqy8/ViWgHdneKQn9MJba@vger.kernel.org, AJvYcCX82jV0qYRU+W4vZJUQVAeX1+bmMxv8TQ15PQq9qHJ41PVd6W+/lrh2B/Ci/Cixco9dkEc9j6QRn2eCVFoJBQ==@vger.kernel.org, AJvYcCX8zsm8Is5OdnrpVm/QxWRqqTFku+9KY6m9xZdpvNNfZenww/s/g3QoAtnKCoer6IIPMop543BeeYlEJD6M@vger.kernel.org
X-Gm-Message-State: AOJu0YxDsw1tk4fcKcpG0BXsVibEU0+yI4BUMiwaW89xMim+Mt5Ztbrf
	J5aSCNcp3c3nX8FOEds9LVuUq+QUzrowEa6P3Z6xNiajAleiscwQKu3c5g0=
X-Google-Smtp-Source: AGHT+IHmqwXfMBAjKto07gL0X8tQckGKOLPa44I+UUKqQOEJghPRhSVMp1Sspp6iZX1OeCoOPs20Bg==
X-Received: by 2002:adf:f487:0:b0:374:c3a2:2b5e with SMTP id ffacd0b85a97d-374c3a22c2emr6674209f8f.37.1725403393950;
        Tue, 03 Sep 2024 15:43:13 -0700 (PDT)
Received: from surface.home (2a01cb080508df00ca9665fffed23409.ipv6.abo.wanadoo.fr. [2a01:cb08:508:df00:ca96:65ff:fed2:3409])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba6396516sm222955115e9.4.2024.09.03.15.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 15:43:12 -0700 (PDT)
From: =?UTF-8?q?J=C3=A9r=C3=B4me=20de=20Bretagne?= <jerome.debretagne@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] arm64: dts: qcom: sc8280xp: Add Microsoft Surface Pro 9 5G
Date: Wed,  4 Sep 2024 00:42:52 +0200
Message-ID: <20240903224252.6207-5-jerome.debretagne@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240903224252.6207-1-jerome.debretagne@gmail.com>
References: <20240903224252.6207-1-jerome.debretagne@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add an initial devicetree for the Microsoft Surface Pro 9 5G, based
on SC8280XP.

It enables the support for Wi-Fi, NVMe, the two USB Type-C ports,
Bluetooth, 5G cellular modem, audio output (via Bluetooth headsets),
external display via DisplayPort over Type-C (only the bottom USB
Type-C port is working so far, corresponding to the usb1 / dp1 nodes),
charging, the Surface Aggregator Module (SAM) to get keyboard and
touchpad working with the Surface Type Cover accessories.

Some key features not supported yet:
- built-in display (but software fallback is working with efifb
  when blacklisting the msm module)
- built-in display touchscreen
- external display with the top USB Type-C port
- speakers and microphones
- physical volume up and down keys
- LID switch detection

This devicetree is based on the other SC8280XP ones, for the Lenovo
ThinkPad X13s and the Qualcomm CRD.

Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
---
 arch/arm64/boot/dts/qcom/Makefile             |    1 +
 .../sc8280xp-microsoft-surface-pro-9-5G.dts   | 1099 +++++++++++++++++
 2 files changed, 1100 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc8280xp-microsoft-surface-pro-9-5G.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 0e5c810304fb..5eb67dc270c6 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -184,6 +184,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sc8180x-lenovo-flex-5g.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc8180x-primus.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-crd.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-lenovo-thinkpad-x13s.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sc8280xp-microsoft-surface-pro-9-5G.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sda660-inforce-ifc6560.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm450-lenovo-tbx605f.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sdm450-motorola-ali.dtb
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-surface-pro-9-5G.dts b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-surface-pro-9-5G.dts
new file mode 100644
index 000000000000..476932e8a9c5
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-surface-pro-9-5G.dts
@@ -0,0 +1,1099 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2024, Jérôme de Bretagne <jerome.debretagne@gmail.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
+
+#include "sc8280xp.dtsi"
+#include "sc8280xp-pmics.dtsi"
+
+/ {
+	model = "Microsoft Surface Pro 9 5G";
+	compatible = "microsoft,arcata", "qcom,sc8280xp";
+
+	aliases {
+		serial0 = &uart18;
+		serial1 = &uart2;
+	};
+
+	wcd938x: audio-codec {
+		compatible = "qcom,wcd9380-codec";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wcd_default>;
+
+		reset-gpios = <&tlmm 106 GPIO_ACTIVE_LOW>;
+
+		vdd-buck-supply = <&vreg_s10b>;
+		vdd-rxtx-supply = <&vreg_s10b>;
+		vdd-io-supply = <&vreg_s10b>;
+		vdd-mic-bias-supply = <&vreg_bob>;
+
+		qcom,micbias1-microvolt = <1800000>;
+		qcom,micbias2-microvolt = <1800000>;
+		qcom,micbias3-microvolt = <1800000>;
+		qcom,micbias4-microvolt = <1800000>;
+		qcom,mbhc-buttons-vthreshold-microvolt = <75000 150000 237000 500000 500000 500000 500000 500000>;
+		qcom,mbhc-headset-vthreshold-microvolt = <1700000>;
+		qcom,mbhc-headphone-vthreshold-microvolt = <50000>;
+		qcom,rx-device = <&wcd_rx>;
+		qcom,tx-device = <&wcd_tx>;
+
+		#sound-dai-cells = <1>;
+	};
+
+	pmic-glink {
+		compatible = "qcom,sc8280xp-pmic-glink", "qcom,pmic-glink";
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		connector@0 {
+			compatible = "usb-c-connector";
+			reg = <0>;
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					pmic_glink_con0_hs: endpoint {
+						remote-endpoint = <&usb_0_dwc3_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					pmic_glink_con0_ss: endpoint {
+						remote-endpoint = <&usb_0_qmpphy_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					pmic_glink_con0_sbu: endpoint {
+						remote-endpoint = <&usb0_sbu_mux>;
+					};
+				};
+			};
+		};
+
+		connector@1 {
+			compatible = "usb-c-connector";
+			reg = <1>;
+			power-role = "dual";
+			data-role = "dual";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				port@0 {
+					reg = <0>;
+
+					pmic_glink_con1_hs: endpoint {
+						remote-endpoint = <&usb_1_dwc3_hs>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					pmic_glink_con1_ss: endpoint {
+						remote-endpoint = <&usb_1_qmpphy_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					pmic_glink_con1_sbu: endpoint {
+						remote-endpoint = <&usb1_sbu_mux>;
+					};
+				};
+			};
+		};
+	};
+
+	vreg_nvme: regulator-nvme {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VCC3_SSD";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 135 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&nvme_reg_en>;
+
+		regulator-boot-on;
+	};
+
+	vreg_vph_pwr: regulator-vph-pwr {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VPH_VCC3R9";
+		regulator-min-microvolt = <3900000>;
+		regulator-max-microvolt = <3900000>;
+
+		regulator-always-on;
+	};
+
+	vreg_wlan: regulator-wlan {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VCC_WLAN_3R9";
+		regulator-min-microvolt = <3900000>;
+		regulator-max-microvolt = <3900000>;
+
+		gpio = <&pmr735a_gpios 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&hastings_reg_en>;
+
+		regulator-boot-on;
+	};
+
+	vreg_wwan: regulator-wwan {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VCC3B_WAN";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&pmc8280_2_gpios 1 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wwan_sw_en>;
+
+		regulator-boot-on;
+	};
+
+	reserved-memory {
+		gpu_mem: gpu-mem@8bf00000 {
+			reg = <0 0x8bf00000 0 0x2000>;
+			no-map;
+		};
+
+		linux,cma {
+			compatible = "shared-dma-pool";
+			size = <0x0 0x8000000>;
+			reusable;
+			linux,cma-default;
+		};
+	};
+
+	thermal-zones {
+		skin-temp-thermal {
+			polling-delay-passive = <250>;
+
+			thermal-sensors = <&pmk8280_adc_tm 5>;
+
+			trips {
+				skin_temp_alert0: trip-point0 {
+					temperature = <55000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				skin_temp_alert1: trip-point1 {
+					temperature = <58000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				skin-temp-crit {
+					temperature = <73000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
+			};
+
+			cooling-maps {
+				map0 {
+					trip = <&skin_temp_alert0>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+
+				map1 {
+					trip = <&skin_temp_alert1>;
+					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+	};
+
+	usb0-sbu-mux {
+		compatible = "pericom,pi3usb102", "gpio-sbu-mux";
+
+		enable-gpios = <&tlmm 101 GPIO_ACTIVE_LOW>;
+		select-gpios = <&tlmm 164 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb0_sbu_default>;
+
+		mode-switch;
+		orientation-switch;
+
+		port {
+			usb0_sbu_mux: endpoint {
+				remote-endpoint = <&pmic_glink_con0_sbu>;
+			};
+		};
+	};
+
+	usb1-sbu-mux {
+		compatible = "pericom,pi3usb102", "gpio-sbu-mux";
+
+		enable-gpios = <&tlmm 48 GPIO_ACTIVE_LOW>;
+		select-gpios = <&tlmm 47 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb1_sbu_default>;
+
+		mode-switch;
+		orientation-switch;
+
+		port {
+			usb1_sbu_mux: endpoint {
+				remote-endpoint = <&pmic_glink_con1_sbu>;
+			};
+		};
+	};
+};
+
+&apps_rsc {
+	regulators-0 {
+		compatible = "qcom,pm8350-rpmh-regulators";
+		qcom,pmic-id = "b";
+
+		vdd-l1-l4-supply = <&vreg_s12b>;
+		vdd-l2-l7-supply = <&vreg_bob>;
+		vdd-l3-l5-supply = <&vreg_s11b>;
+		vdd-l6-l9-l10-supply = <&vreg_s12b>;
+		vdd-l8-supply = <&vreg_s12b>;
+
+		vreg_s10b: smps10 {
+			regulator-name = "vreg_s10b";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
+		};
+
+		vreg_s11b: smps11 {
+			regulator-name = "vreg_s11b";
+			regulator-min-microvolt = <1272000>;
+			regulator-max-microvolt = <1272000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
+		};
+
+		vreg_s12b: smps12 {
+			regulator-name = "vreg_s12b";
+			regulator-min-microvolt = <984000>;
+			regulator-max-microvolt = <984000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
+		};
+
+		vreg_l3b: ldo3 {
+			regulator-name = "vreg_l3b";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-boot-on;
+		};
+
+		vreg_l4b: ldo4 {
+			regulator-name = "vreg_l4b";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6b: ldo6 {
+			regulator-name = "vreg_l6b";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-boot-on;
+			regulator-always-on;	// FIXME: VDD_A_EDP_0_0P9
+		};
+	};
+
+	regulators-1 {
+		compatible = "qcom,pm8350c-rpmh-regulators";
+		qcom,pmic-id = "c";
+
+		vdd-bob-supply = <&vreg_vph_pwr>;
+		vdd-l1-l12-supply = <&vreg_s1c>;
+		vdd-l2-l8-supply = <&vreg_s1c>;
+		vdd-l3-l4-l5-l7-l13-supply = <&vreg_bob>;
+		vdd-l6-l9-l11-supply = <&vreg_bob>;
+		vdd-l10-supply = <&vreg_s11b>;
+
+		vreg_s1c: smps1 {
+			regulator-name = "vreg_s1c";
+			regulator-min-microvolt = <1880000>;
+			regulator-max-microvolt = <1900000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
+		};
+
+		vreg_l1c: ldo1 {
+			regulator-name = "vreg_l1c";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l12c: ldo12 {
+			regulator-name = "vreg_l12c";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l13c: ldo13 {
+			regulator-name = "vreg_l13c";
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_bob: bob {
+			regulator-name = "vreg_bob";
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <3960000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_AUTO>;
+			regulator-always-on;
+		};
+	};
+
+	regulators-2 {
+		compatible = "qcom,pm8350-rpmh-regulators";
+		qcom,pmic-id = "d";
+
+		vdd-l1-l4-supply = <&vreg_s11b>;
+		vdd-l2-l7-supply = <&vreg_bob>;
+		vdd-l3-l5-supply = <&vreg_s11b>;
+		vdd-l6-l9-l10-supply = <&vreg_s12b>;
+		vdd-l8-supply = <&vreg_s12b>;
+
+		vreg_l3d: ldo3 {
+			regulator-name = "vreg_l3d";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4d: ldo4 {
+			regulator-name = "vreg_l4d";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l6d: ldo6 {
+			regulator-name = "vreg_l6d";
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7d: ldo7 {
+			regulator-name = "vreg_l7d";
+			regulator-min-microvolt = <3072000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l9d: ldo9 {
+			regulator-name = "vreg_l9d";
+			regulator-min-microvolt = <912000>;
+			regulator-max-microvolt = <912000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+};
+
+&dispcc0 {
+	status = "okay";
+};
+
+&dispcc1 {
+	status = "okay";
+};
+
+&gpu {
+	status = "okay";
+
+	zap-shader {
+		memory-region = <&gpu_mem>;
+		firmware-name = "qcom/sc8280xp/MICROSOFT/SurfacePro9/qcdxkmsuc8280.mbn";
+	};
+};
+
+&mdss0 {
+	status = "okay";
+};
+
+&mdss0_dp0 {
+	status = "okay";
+};
+
+&mdss0_dp0_out {
+	data-lanes = <0 1>;
+	remote-endpoint = <&usb_0_qmpphy_dp_in>;
+};
+
+&mdss0_dp1 {
+	status = "okay";
+};
+
+&mdss0_dp1_out {
+	data-lanes = <0 1>;
+	remote-endpoint = <&usb_1_qmpphy_dp_in>;
+};
+
+&pcie2a {
+	perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 145 GPIO_ACTIVE_LOW>;
+
+	vddpe-3v3-supply = <&vreg_nvme>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie2a_default>;
+
+	status = "okay";
+};
+
+&pcie2a_phy {
+	vdda-phy-supply = <&vreg_l6d>;
+	vdda-pll-supply = <&vreg_l4d>;
+
+	status = "okay";
+};
+
+&pcie3a {
+	perst-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
+
+	vddpe-3v3-supply = <&vreg_wwan>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie3a_default>;
+
+	status = "okay";
+};
+
+&pcie3a_phy {
+	vdda-phy-supply = <&vreg_l6d>;
+	vdda-pll-supply = <&vreg_l4d>;
+
+	status = "okay";
+};
+
+&pcie4 {
+	max-link-speed = <2>;
+
+	perst-gpios = <&tlmm 141 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&tlmm 139 GPIO_ACTIVE_LOW>;
+
+	vddpe-3v3-supply = <&vreg_wlan>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie4_default>;
+
+	status = "okay";
+};
+
+&pcie4_port0 {
+	wifi@0 {
+		compatible = "pci17cb,1103";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+
+		qcom,ath11k-calibration-variant = "LE_X13S";
+	};
+};
+
+&pcie4_phy {
+	vdda-phy-supply = <&vreg_l6d>;
+	vdda-pll-supply = <&vreg_l4d>;
+
+	status = "okay";
+};
+
+&pmk8280_pon_pwrkey {
+	status = "okay";
+};
+
+&pmk8280_pon_resin {
+	status = "okay";
+};
+
+&pmk8280_rtc {
+	nvmem-cells = <&rtc_offset>;
+	nvmem-cell-names = "offset";
+
+	status = "okay";
+};
+
+&pmk8280_sdam_6 {
+	status = "okay";
+
+	rtc_offset: rtc-offset@bc {
+		reg = <0xbc 0x4>;
+	};
+};
+
+&qup0 {
+	status = "okay";
+};
+
+&qup1 {
+	status = "okay";
+};
+
+&qup2 {
+	status = "okay";
+};
+
+&remoteproc_adsp {
+	firmware-name = "qcom/sc8280xp/MICROSOFT/SurfacePro9/qcadsp8280.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_nsp0 {
+	firmware-name = "qcom/sc8280xp/MICROSOFT/SurfacePro9/qccdsp8280.mbn";
+
+	status = "okay";
+};
+
+&rxmacro {
+	status = "okay";
+};
+
+&sound {
+	compatible = "qcom,sc8280xp-sndcard";
+	model = "SC8280XP-MICROSOFT-SURFACE-PRO-9-5G";
+	audio-routing =
+		"SpkrLeft IN", "WSA_SPK1 OUT",
+		"SpkrRight IN", "WSA_SPK2 OUT",
+		"IN1_HPHL", "HPHL_OUT",
+		"IN2_HPHR", "HPHR_OUT",
+		"AMIC2", "MIC BIAS2",
+		"VA DMIC0", "MIC BIAS1",
+		"VA DMIC1", "MIC BIAS1",
+		"VA DMIC2", "MIC BIAS3",
+		"VA DMIC0", "VA MIC BIAS1",
+		"VA DMIC1", "VA MIC BIAS1",
+		"VA DMIC2", "VA MIC BIAS3",
+		"TX SWR_ADC1", "ADC2_OUTPUT";
+
+	wcd-playback-dai-link {
+		link-name = "WCD Playback";
+		cpu {
+			sound-dai = <&q6apmbedai RX_CODEC_DMA_RX_0>;
+		};
+
+		codec {
+			sound-dai = <&wcd938x 0>, <&swr1 0>, <&rxmacro 0>;
+		};
+
+		platform {
+			sound-dai = <&q6apm>;
+		};
+	};
+
+	wcd-capture-dai-link {
+		link-name = "WCD Capture";
+		cpu {
+			sound-dai = <&q6apmbedai TX_CODEC_DMA_TX_3>;
+		};
+
+		codec {
+			sound-dai = <&wcd938x 1>, <&swr2 0>, <&txmacro 0>;
+		};
+
+		platform {
+			sound-dai = <&q6apm>;
+		};
+	};
+
+	wsa-dai-link {
+		link-name = "WSA Playback";
+		cpu {
+			sound-dai = <&q6apmbedai WSA_CODEC_DMA_RX_0>;
+		};
+
+		codec {
+			sound-dai = <&swr0 0>, <&wsamacro 0>;
+		};
+
+		platform {
+			sound-dai = <&q6apm>;
+		};
+	};
+
+	va-dai-link {
+		link-name = "VA Capture";
+		cpu {
+			sound-dai = <&q6apmbedai VA_CODEC_DMA_TX_0>;
+		};
+
+		platform {
+			sound-dai = <&q6apm>;
+		};
+
+		codec {
+			sound-dai = <&vamacro 0>;
+		};
+	};
+};
+
+&swr0 {
+	status = "okay";
+};
+
+&swr1 {
+	status = "okay";
+
+	wcd_rx: wcd9380-rx@0,4 {
+		compatible = "sdw20217010d00";
+		reg = <0 4>;
+		qcom,rx-port-mapping = <1 2 3 4 5>;
+	};
+};
+
+&swr2 {
+	status = "okay";
+
+	wcd_tx: wcd9380-tx@0,3 {
+		compatible = "sdw20217010d00";
+		reg = <0 3>;
+		qcom,tx-port-mapping = <1 1 2 3>;
+	};
+};
+
+&txmacro {
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-0 = <&uart2_default>;
+	pinctrl-names = "default";
+
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn6855-bt";
+
+		vddio-supply = <&vreg_s10b>;
+		vddbtcxmx-supply = <&vreg_s12b>;
+		vddrfacmn-supply = <&vreg_s12b>;
+		vddrfa0p8-supply = <&vreg_s12b>;
+		vddrfa1p2-supply = <&vreg_s11b>;
+		vddrfa1p7-supply = <&vreg_s1c>;
+
+		max-speed = <3200000>;
+
+		enable-gpios = <&tlmm 133 GPIO_ACTIVE_HIGH>;
+		swctrl-gpios = <&tlmm 132 GPIO_ACTIVE_HIGH>;
+
+		pinctrl-0 = <&bt_default>;
+		pinctrl-names = "default";
+	};
+};
+
+&uart18 {
+	status = "okay";
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart18_state>;
+
+	surface-aggregator {
+		compatible = "surface,aggregator";
+
+		current-speed = <4000000>;
+		uart-has-rtscts;
+		uart-parity = "n";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&ssam_state>;
+
+		ssam_wakeup-int-gpios = <&tlmm 85 GPIO_ACTIVE_HIGH>;
+
+		ssh-d3-closes-handle;
+		ssh-buffer-size = <0x30>;
+
+		rtc {
+			ssam-uid = "01:01:01:00:00";
+		};
+
+		battery {
+			ssam-uid = "01:02:01:01:00";
+		};
+
+		ac {
+			ssam-uid = "01:02:01:01:01";
+		};
+
+		thermal-sensors {
+			ssam-uid = "01:03:01:00:02";
+		};
+
+		kip-hub {
+			ssam-uid = "00:00:01:0e:00";
+
+			hid-keyboard {
+				ssam-uid = "01:15:02:01:00";
+			};
+
+			hid-pen-stash {
+				ssam-uid = "01:15:02:02:00";
+			};
+
+			hid-touchpad {
+				ssam-uid = "01:15:02:03:00";
+			};
+
+			hid-tcfwupd {
+				ssam-uid = "01:15:02:05:00";
+			};
+		};
+
+		kip-tablet-mode-switch {
+			ssam-uid = "01:0e:01:00:01";
+		};
+	};
+};
+
+&usb_0 {
+	status = "okay";
+};
+
+&usb_0_dwc3 {
+	dr_mode = "host";
+};
+
+&usb_0_dwc3_hs {
+	remote-endpoint = <&pmic_glink_con0_hs>;
+};
+
+&usb_0_hsphy {
+	vdda-pll-supply = <&vreg_l9d>;
+	vdda18-supply = <&vreg_l1c>;
+	vdda33-supply = <&vreg_l7d>;
+
+	status = "okay";
+};
+
+&usb_0_qmpphy {
+	vdda-phy-supply = <&vreg_l9d>;
+	vdda-pll-supply = <&vreg_l4d>;
+
+	orientation-switch;
+
+	status = "okay";
+};
+
+&usb_0_qmpphy_dp_in {
+	remote-endpoint = <&mdss0_dp0_out>;
+};
+
+&usb_0_qmpphy_out {
+	remote-endpoint = <&pmic_glink_con0_ss>;
+};
+
+&usb_1 {
+	status = "okay";
+};
+
+&usb_1_dwc3 {
+	dr_mode = "host";
+};
+
+&usb_1_dwc3_hs {
+	remote-endpoint = <&pmic_glink_con1_hs>;
+};
+
+&usb_1_hsphy {
+	vdda-pll-supply = <&vreg_l4b>;
+	vdda18-supply = <&vreg_l1c>;
+	vdda33-supply = <&vreg_l13c>;
+
+	status = "okay";
+};
+
+&usb_1_qmpphy {
+	vdda-phy-supply = <&vreg_l4b>;
+	vdda-pll-supply = <&vreg_l3b>;
+
+	orientation-switch;
+
+	status = "okay";
+};
+
+&usb_1_qmpphy_dp_in {
+	remote-endpoint = <&mdss0_dp1_out>;
+};
+
+&usb_1_qmpphy_out {
+	remote-endpoint = <&pmic_glink_con1_ss>;
+};
+
+&vamacro {
+	pinctrl-0 = <&dmic01_default>, <&dmic23_default>;
+	pinctrl-names = "default";
+
+	vdd-micb-supply = <&vreg_s10b>;
+
+	qcom,dmic-sample-rate = <4800000>;
+
+	status = "okay";
+};
+
+&wsamacro {
+	status = "okay";
+};
+
+&xo_board_clk {
+	clock-frequency = <38400000>;
+};
+
+/* PINCTRL */
+
+&lpass_tlmm {
+	status = "okay";
+};
+
+&pmc8280_2_gpios {
+	wwan_sw_en: wwan-sw-en-state {
+		pins = "gpio1";
+		function = "normal";
+	};
+};
+
+&pmr735a_gpios {
+	hastings_reg_en: hastings-reg-en-state {
+		pins = "gpio1";
+		function = "normal";
+	};
+};
+
+&tlmm {
+	gpio-reserved-ranges = <70 2>, <74 6>, <125 2>, <128 2>, <154 4>;
+
+	bt_default: bt-default-state {
+		hstp-bt-en-pins {
+			pins = "gpio133";
+			function = "gpio";
+			drive-strength = <16>;
+			bias-disable;
+		};
+
+		hstp-sw-ctrl-pins {
+			pins = "gpio132";
+			function = "gpio";
+			bias-pull-down;
+		};
+	};
+
+	nvme_reg_en: nvme-reg-en-state {
+		pins = "gpio135";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	pcie2a_default: pcie2a-default-state {
+		clkreq-n-pins {
+			pins = "gpio142";
+			function = "pcie2a_clkreq";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-n-pins {
+			pins = "gpio143";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		wake-n-pins {
+			pins = "gpio145";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+	       };
+	};
+
+	pcie3a_default: pcie3a-default-state {
+		clkreq-n-pins {
+			pins = "gpio150";
+			function = "pcie3a_clkreq";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-n-pins {
+			pins = "gpio151";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		wake-n-pins {
+			pins = "gpio148";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+	pcie4_default: pcie4-default-state {
+		clkreq-n-pins {
+			pins = "gpio140";
+			function = "pcie4_clkreq";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+
+		perst-n-pins {
+			pins = "gpio141";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		wake-n-pins {
+			pins = "gpio139";
+			function = "gpio";
+			drive-strength = <2>;
+			bias-pull-up;
+		};
+	};
+
+
+	ssam_state: ssam-state {
+		wake-int {
+			pins = "gpio85";
+			function = "gpio";
+			bias-disable;
+		};
+	};
+
+	uart2_default: uart2-default-state {
+		cts-pins {
+			pins = "gpio121";
+			function = "qup2";
+			bias-bus-hold;
+		};
+
+		rts-pins {
+			pins = "gpio122";
+			function = "qup2";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		rx-pins {
+			pins = "gpio124";
+			function = "qup2";
+			bias-pull-up;
+		};
+
+		tx-pins {
+			pins = "gpio123";
+			function = "qup2";
+			drive-strength = <2>;
+			bias-disable;
+		};
+	};
+
+	uart18_state: uart18-state {
+		cts {
+			pins = "gpio66";
+			function = "qup18";
+			bias-pull-down;
+		};
+
+		rts-tx {
+			pins = "gpio67", "gpio68";
+			function = "qup18";
+			drive-strength = <2>;
+			bias-disable;
+		};
+
+		rx {
+			pins = "gpio69";
+			function = "qup18";
+			bias-pull-up;
+		};
+	};
+
+	usb0_sbu_default: usb0-sbu-state {
+		oe-n-pins {
+			pins = "gpio101";
+			function = "gpio";
+			bias-disable;
+			drive-strength = <16>;
+			output-high;
+		};
+
+		sel-pins {
+			pins = "gpio164";
+			function = "gpio";
+			bias-disable;
+			drive-strength = <16>;
+		};
+	};
+
+	usb1_sbu_default: usb1-sbu-state {
+		oe-n-pins {
+			pins = "gpio48";
+			function = "gpio";
+			bias-disable;
+			drive-strength = <16>;
+			output-high;
+		};
+
+		sel-pins {
+			pins = "gpio47";
+			function = "gpio";
+			bias-disable;
+			drive-strength = <16>;
+		};
+	};
+
+	wcd_default: wcd-default-state {
+		reset-pins {
+			pins = "gpio106";
+			function = "gpio";
+			bias-disable;
+		};
+	};
+};
-- 
2.45.2


