Return-Path: <linux-kernel+bounces-311572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEAF968A92
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 17:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83BAF1F22962
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 15:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE1E1A3029;
	Mon,  2 Sep 2024 15:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EaZZJVJc"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D0D183CBB
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 15:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725289318; cv=none; b=kDOyslDb5VY47lm7O0Us52lSV2vqtYtuSX/Nd2lGG9f25p8T03u3Qx7MHj22ll42p3wTYzxf+Kz4xlnh7MyuUudrN9WRnXBD5uVd6x699xi6pQ+QWlYw+d3vB7miXZjIpnCy5rU4koBmgdiXHG8kIMD4npTkG4mMOZdgY+0oIsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725289318; c=relaxed/simple;
	bh=h5Xq82//l1sVdEO34qNdYiFnG6IVy5Rx/913P5VPOVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vyil9rx8thdxZldOpuwKuKU5AsJTZX957KP6YNxRIhQQoZuNbOKaiBGOW+LDYepII/a4GcjIGAu56P7kfkk47+xPQ02Xeq7aV+ejDZ2RRwpWEtFd3PGvsDmJ94Lij7tY3+wBbrwQccaMursxXsdk4viRvbPOLQ/qUXBKFAyEdHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EaZZJVJc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42bbd16fca8so26124955e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 08:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725289314; x=1725894114; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DxknQ0wfQYWuyr9cw/RceM9p4Pvz+sRj5P9CPIckMAM=;
        b=EaZZJVJcDjH/LXR/J3S3FkUVWkBhLCemDIRHhXsYAEdpbtZLPwNq2K1YjQA5MIDRQB
         LtaSCk7n1++FnA21IgjEt26IAhhllQcMdjvB5kkXAvfEWo5cnaA4/UORfMRU2peSP6Py
         8CBKbpMkhSmKhgBPrvtiNLuCcvFXxAp3SH81qRVE6Zt37OyJa96icsNtkM3/VwVI6luh
         i3qh7McSegN3fC3eQt+7O6/wJjiq1eopS7R7cKG0imx5sUIy2QZREECTc5mSgOWnco0t
         3TU7EJap970OHt5OGQNAZIsd+r6z02JrohV9c5KuNv583Mmq5+b21gfOn6fMyWo3X6Yb
         LmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725289314; x=1725894114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxknQ0wfQYWuyr9cw/RceM9p4Pvz+sRj5P9CPIckMAM=;
        b=mgHKnnUC9iIMYhrasPW1CkyqbtwJ9svixTQ5R2oEX1YZdUF90P7mc8LglK0WprE78F
         /lex2FDtWNuUfgpeqmiT26sxsmvOrxtUnV2stwLG+473i4cCNW/mC7tEvYQUzxD3LbhW
         wX/im90pYBkMNkVUvuctyvdakchNQIz37VLsKLs1cqsNmqBV58yP38P6I9DbG2f6pIhX
         1xaMDjp4kl0UlezIr5UuMnYrVhO6532BR3J2bMoZtSSfs/mR+g5g6DDAr6GPuFByT6s/
         j4/k2X7/G+zagPHhZ2GFkQoF9kBUwNSdafbvi4pH54akLuEqGt4Kt9kFT65Koa/xvhFx
         N0Tg==
X-Forwarded-Encrypted: i=1; AJvYcCV+Os4O/N4vjDH5+NOVtjILvjqP2RNQDTBmQT681jlW6J6wOMi6FVdw30kCWWqiqRZMnI38EeZeZjUZhYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzZ8lNRLXZ+dH0oUdqJzcYtkw6WjZf29NM2x4ZqLZZkV6EGZ+q
	GfxuUPp23FtV+NzQ9inVJE79JSVc60eQz3RXsT91SCFyd3uP46IGpf1Hps7Bp6Y=
X-Google-Smtp-Source: AGHT+IHbOfN+sU8d6+iOdoFyqChJSi+NANboVEGhWfUjFGv6PJ5It/K5595QkKbX1B/2NspEgtXVyA==
X-Received: by 2002:a05:600c:3c82:b0:42b:b016:94a3 with SMTP id 5b1f17b1804b1-42c88108590mr3601915e9.31.1725289313825;
        Mon, 02 Sep 2024 08:01:53 -0700 (PDT)
Received: from [127.0.1.1] ([82.79.186.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6deb1ebsm140726115e9.3.2024.09.02.08.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 08:01:53 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 02 Sep 2024 18:01:36 +0300
Subject: [PATCH 2/2] arm64: dts: qcom: x1e80100-t14s: Add external DP
 support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240902-x1e80100-crd-dts-add-external-dp-support-v1-2-899c264c0eb7@linaro.org>
References: <20240902-x1e80100-crd-dts-add-external-dp-support-v1-0-899c264c0eb7@linaro.org>
In-Reply-To: <20240902-x1e80100-crd-dts-add-external-dp-support-v1-0-899c264c0eb7@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Trilok Soni <quic_tsoni@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7841; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=h5Xq82//l1sVdEO34qNdYiFnG6IVy5Rx/913P5VPOVA=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBm1dNcwav1nL0dHrjX2wU5BHgIBJw3vsWxnT0Q4
 oZ+raNyOCiJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZtXTXAAKCRAbX0TJAJUV
 VuEQD/4hl6By0Yi5gyeWU7JhZt/0ux1Gt/n8VtwoQh6AHuEDjE5F6z22zvjYF2puf4ggH5LuajH
 r2ycRLwwMcdsvW7OqbQAIKfAVx1GSlXq9aoisw6xdsK67s9XtxIHAH5J1BrBC/LaI9RL5Dr5xfV
 /tn9JwBu4tLK8nHVFyKedsruu/UrabCyG2fumfC4WJclZwNm9lXCSpN2U2q77PDZM/c7jJeM7qY
 i9XitBb3uIeWDNN2cSRvu+gmG5U6uAZhz0RBbxTMfq9ArP7elYtGIohkvLXlyvPoc/xdXH3Tex3
 whnOlZrkixpMfhDXeXxrTs9bvpL05LwKsvRXfY0JYpSvAm+xbcUDBXKv7wFa/qtCRk0t51wygKq
 9KIuHNwH5FUqctxattrepG1XzkajSvopo0H9p0Qf94A52qjtPoaXzmam0M0s8YAqvx3iBGOWqKu
 4Ov50Pxish8ApCiKwOH9kelXRYooNG+HGnVCxRgaCk7eOMKPm9JuB165PyhzcC3ADyimOvVXwCE
 avgswJMsS0NY1Sr/PRWxRR9h99Pq6ut2B6bVsYnMo6V9WrMJVnrU0fqmeuVpERYjUPd0TJzgvJ5
 qZ69PHRwSpJlRv5gT+61SS+40kxz61Utg+H53TpOyDOfm/FclkTjaYrBzWevY6T/zSAb3orNHb7
 oxTKXVls804YUmw==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The Lenovo Thinkpad T14s has only 2 USB Type-C ports, both of them
supporting external DP altmode. Between each QMP combo PHY and the
corresponding Type-C port, sits one Parade PS8830 retimer which handles
both orientation and SBU muxing. Add nodes for each retimer, fix the
graphs between connectors and the PHYs accordingly add the voltage
regulators needed by each retimer and then enable DP 0 and 1.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts     | 278 ++++++++++++++++++++-
 1 file changed, 274 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
index 941dfddd6713..08ec2419f95f 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
@@ -66,7 +66,15 @@ port@1 {
 					reg = <1>;
 
 					pmic_glink_ss0_ss_in: endpoint {
-						remote-endpoint = <&usb_1_ss0_qmpphy_out>;
+						remote-endpoint = <&retimer_ss0_ss_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					pmic_glink_ss0_con_sbu_in: endpoint {
+						remote-endpoint = <&retimer_ss0_con_sbu_out>;
 					};
 				};
 			};
@@ -95,7 +103,15 @@ port@1 {
 					reg = <1>;
 
 					pmic_glink_ss1_ss_in: endpoint {
-						remote-endpoint = <&usb_1_ss1_qmpphy_out>;
+						remote-endpoint = <&retimer_ss1_ss_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					pmic_glink_ss1_con_sbu_in: endpoint {
+						remote-endpoint = <&retimer_ss1_con_sbu_out>;
 					};
 				};
 			};
@@ -127,6 +143,90 @@ vreg_edp_3p3: regulator-edp-3p3 {
 		regulator-boot-on;
 	};
 
+	vreg_rtmr0_1p15: regulator-rtmr0-1p15 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_RTMR0_1P15";
+		regulator-min-microvolt = <1150000>;
+		regulator-max-microvolt = <1150000>;
+
+		gpio = <&pm8550ve_8_gpios 8 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&rtmr0_1p15_reg_en>;
+		pinctrl-names = "default";
+	};
+
+	vreg_rtmr0_1p8: regulator-rtmr0-1p8 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_RTMR0_1P8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		gpio = <&pm8550ve_9_gpios 8 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&rtmr0_1p8_reg_en>;
+		pinctrl-names = "default";
+	};
+
+	vreg_rtmr0_3p3: regulator-rtmr0-3p3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_RTMR0_3P3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&pm8550_gpios 11 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&rtmr0_3p3_reg_en>;
+		pinctrl-names = "default";
+	};
+
+	vreg_rtmr1_1p15: regulator-rtmr1-1p15 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_RTMR1_1P15";
+		regulator-min-microvolt = <1150000>;
+		regulator-max-microvolt = <1150000>;
+
+		gpio = <&tlmm 188 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&rtmr1_1p15_reg_en>;
+	};
+
+	vreg_rtmr1_1p8: regulator-rtmr1-1p8 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_RTMR1_1P8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		gpio = <&tlmm 175 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&rtmr1_1p8_reg_en>;
+	};
+
+	vreg_rtmr1_3p3: regulator-rtmr1-3p3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_RTMR1_3P3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 186 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&rtmr1_3p3_reg_en>;
+	};
+
 	vreg_nvme: regulator-nvme {
 		compatible = "regulator-fixed";
 
@@ -484,6 +584,111 @@ keyboard@3a {
 	};
 };
 
+&i2c3 {
+	clock-frequency = <400000>;
+
+	status = "okay";
+
+	typec-mux@8 {
+		compatible = "parade,ps8830";
+		reg = <0x08>;
+
+		clocks = <&rpmhcc RPMH_RF_CLK3>;
+		clock-names = "xo";
+
+		vdd15-supply = <&vreg_rtmr0_1p15>;
+		vdd18-supply = <&vreg_rtmr0_1p8>;
+		vdd33-supply = <&vreg_rtmr0_3p3>;
+
+		reset-gpios = <&pm8550_gpios 10 GPIO_ACTIVE_HIGH>;
+
+		retimer-switch;
+		orientation-switch;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				retimer_ss0_ss_out: endpoint {
+					remote-endpoint = <&pmic_glink_ss0_ss_in>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				retimer_ss0_ss_in: endpoint {
+					remote-endpoint = <&usb_1_ss0_qmpphy_out>;
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+
+				retimer_ss0_con_sbu_out: endpoint {
+					remote-endpoint = <&pmic_glink_ss0_con_sbu_in>;
+				};
+			};
+		};
+	};
+};
+
+&i2c7 {
+	clock-frequency = <400000>;
+
+	status = "okay";
+
+	typec-mux@8 {
+		compatible = "parade,ps8830";
+		reg = <0x8>;
+
+		clocks = <&rpmhcc RPMH_RF_CLK4>;
+		clock-names = "xo";
+
+		vdd15-supply = <&vreg_rtmr1_1p15>;
+		vdd18-supply = <&vreg_rtmr1_1p8>;
+		vdd33-supply = <&vreg_rtmr1_3p3>;
+
+		reset-gpios = <&tlmm 176 GPIO_ACTIVE_HIGH>;
+
+		retimer-switch;
+		orientation-switch;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				retimer_ss1_ss_out: endpoint {
+					remote-endpoint = <&pmic_glink_ss1_ss_in>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				retimer_ss1_ss_in: endpoint {
+					remote-endpoint = <&usb_1_ss1_qmpphy_out>;
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+
+				retimer_ss1_con_sbu_out: endpoint {
+					remote-endpoint = <&pmic_glink_ss1_con_sbu_in>;
+				};
+			};
+
+		};
+	};
+};
+
 &i2c8 {
 	clock-frequency = <400000>;
 
@@ -508,6 +713,22 @@ &mdss {
 	status = "okay";
 };
 
+&mdss_dp0 {
+	status = "okay";
+};
+
+&mdss_dp0_out {
+	data-lanes = <0 1 2 3>;
+};
+
+&mdss_dp1 {
+	status = "okay";
+};
+
+&mdss_dp1_out {
+	data-lanes = <0 1 2 3>;
+};
+
 &mdss_dp3 {
 	compatible = "qcom,x1e80100-dp";
 	/delete-property/ #sound-dai-cells;
@@ -588,6 +809,33 @@ &pcie6a_phy {
 	status = "okay";
 };
 
+&pm8550_gpios {
+	rtmr0_3p3_reg_en: rtmr0-3p3-reg-en-state {
+		pins = "gpio11";
+		function = "func1";
+		input-disable;
+		output-enable;
+	};
+};
+
+&pm8550ve_8_gpios {
+	rtmr0_1p15_reg_en: rtmr0-1p15-reg-en-state {
+		pins = "gpio8";
+		function = "func1";
+		input-disable;
+		output-enable;
+	};
+};
+
+&pm8550ve_9_gpios {
+	rtmr0_1p8_reg_en: rtmr0-1p8-reg-en-state {
+		pins = "gpio8";
+		function = "func1";
+		input-disable;
+		output-enable;
+	};
+};
+
 &pmc8380_3_gpios {
 	edp_bl_en: edp-bl-en-state {
 		pins = "gpio4";
@@ -733,6 +981,28 @@ wake-n-pins {
 		};
 	};
 
+	rtmr1_1p15_reg_en: rtmr1-1p15-reg-en-state {
+		pins = "gpio188";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	rtmr1_1p8_reg_en: rtmr1-1p8-reg-en-state {
+		pins = "gpio175";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	rtmr1_3p3_reg_en: rtmr1-3p3-reg-en-state {
+		pins = "gpio186";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+
 	wcd_default: wcd-reset-n-active-state {
 		pins = "gpio191";
 		function = "gpio";
@@ -771,7 +1041,7 @@ &usb_1_ss0_dwc3_hs {
 };
 
 &usb_1_ss0_qmpphy_out {
-	remote-endpoint = <&pmic_glink_ss0_ss_in>;
+	remote-endpoint = <&retimer_ss0_ss_in>;
 };
 
 &usb_1_ss1_hsphy {
@@ -803,5 +1073,5 @@ &usb_1_ss1_dwc3_hs {
 };
 
 &usb_1_ss1_qmpphy_out {
-	remote-endpoint = <&pmic_glink_ss1_ss_in>;
+	remote-endpoint = <&retimer_ss1_ss_in>;
 };

-- 
2.34.1


