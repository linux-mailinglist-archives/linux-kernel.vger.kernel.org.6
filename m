Return-Path: <linux-kernel+bounces-524418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E96FA3E2C4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70028188F2C6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536A6213E72;
	Thu, 20 Feb 2025 17:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iDoliWli"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241CB213248
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073375; cv=none; b=pIkpK3ShEfNAjysENT+QExLNX/gdOxWmeA+e85lU1/e1PZdYz9elAPKx1tgbvYy/LNxVe7EciszHPx6//UGeE+rvHomaVt1ahgmlRLSEdefw0+FlF9Nh+aL3Ksos6/pCkRtb5XXiCnyFRBlesu+lv53C8KJe1+3Y4X1O2Wffmhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073375; c=relaxed/simple;
	bh=MhEWbQKeL4hp6PAsi3bp/coMyvA+vOUXxLINdXHgeAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gAMAZPjZ8ZIxAPFCw+/Vqln+tSLIREqhM0U5QAy/G1G4WowVlRfMi5QUbrrht0bBIUn705or6AhF4WRTvbGMYQ/y4f2hYM1pPyzluqM3GN/ngbjTaNevHtSm349OtT1PLGY9QA6GBEdQ/XXcwK0eSi3FTPByIfVHHoaHCNT9Yf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iDoliWli; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-abb90f68f8cso235200466b.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 09:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740073371; x=1740678171; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mtFXokZVjvbfuakmYskRnuTAG5EU61PrUinN7HB6kKA=;
        b=iDoliWliqpB1D9mTN+amgWaC+eI9vwEcpsJXGnu4TTLc24G1llR42buEJrWr9IXZ7l
         aszAQ4nScA7PgpRK2QG18fTF3moUDGP6m8gnFNbOki/Phm16DiVNPk4/MD6KQW9KNtSk
         f03/OZMJUab2DZujFNkHqfUBjrPfq+OQ1KiA6Gog4Pm1CoLpWl54dvGwpT52WRJ5booC
         SyPiX3bKU4D8l1eVM/sx5A6saSybfs/ShfSxquNW4tLEOsty5Yqf6tjUxOSdQTLe8F+w
         +Pkx6mK8Qv0hWlr0/sC1e26bWoaU+y0kXo5NI3qNP4zAO5+HY4FO1vHgmfj/dIf9TuBX
         U+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740073371; x=1740678171;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mtFXokZVjvbfuakmYskRnuTAG5EU61PrUinN7HB6kKA=;
        b=xSwSfr3wwO0yvZIpLb1v6Ht+11IOc8atx0JKJuA3nQSOX7DU/NasjA7zglhmK8NHUN
         c88DWhCIrsUB3ewzbnTjTPe3YPPakO88MSW1jCuBOXCZw8bTPHbV6eTtNWkG+/fXoH+d
         rIUCSe2qrlZpY/lVSMHAZqvjEgoPkh1nCFE82QmTnxMEWE1YbWP8Nn8q/x1jAHIW9CkI
         Pk9K18HwF9dLKl6EZQou5CIJVJmDB7aAkx8DmNn9X81nbs+yJgJQk2Zw0VijkVu11QjC
         W+Asuw0a7wHTU/c13OHNWRBPo15V73QHPYZTYEjEPOnCnU1qad1585dLo4i38aa4qCCD
         ++hA==
X-Forwarded-Encrypted: i=1; AJvYcCWzCLdAB1vO798IwPK0oflAOOwFq9t/dQ+GOyghuqEBbwWc533sQa/igyxnvtBTlNvtcPDiAZEIZA/vjuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAsPqWX0OnHZVNU2Ubyrg+2tpwc5PJU6BCcXXwzhDWPr4LisWa
	Lr0D80I/2fW4KKAXX5Qs4PoAMFJ9fdgeqjcfxV+qG+4PG04PjLnZK1vckKIc3sI=
X-Gm-Gg: ASbGncvEq7otsw57XGENKtnpaGfQ8WUqb75/4JLy50e6Idfwhbd4Le8ph2guH131nYa
	BvdOLU7tKJzEOvJap18yASVvesoVjpMjztXU0lw5z7ncAlnR77DpFLx0p41VaItUfbQPHRzCXF2
	puwKgTARL8Z2QRbKr7bgAwpS3PMSEc2F+ygNLW5wamVKaevrkGIjbaqaIHM9o6SnrFBkiFUKVC+
	nlv9FMzmK4gASBwFv5Y7m8w1R+w9U/LpKNmOIQHIi/qzOe74MQO2sza2+W25vGT7onPWUqiPEjM
	hR7A86jmGEFuHA==
X-Google-Smtp-Source: AGHT+IHOc6pZmP/o+UqAl/Ci/QaculaXeGegJZ+BpMU5iWILTIJklH4fKUpWEJUIlH3/h0D9qMiKeQ==
X-Received: by 2002:a17:906:308b:b0:aba:519b:f774 with SMTP id a640c23a62f3a-abc09d31cc7mr20665566b.52.1740073371356;
        Thu, 20 Feb 2025 09:42:51 -0800 (PST)
Received: from [127.0.1.1] ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8190d1b6sm1014496166b.36.2025.02.20.09.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 09:42:50 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 20 Feb 2025 19:42:30 +0200
Subject: [PATCH RESEND v5 1/4] arm64: dts: qcom: x1e80100-crd: Describe the
 Parade PS8830 retimers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-x1e80100-dts-crd-t14s-enable-typec-retimers-v5-1-380a3e0e7edc@linaro.org>
References: <20250220-x1e80100-dts-crd-t14s-enable-typec-retimers-v5-0-380a3e0e7edc@linaro.org>
In-Reply-To: <20250220-x1e80100-dts-crd-t14s-enable-typec-retimers-v5-0-380a3e0e7edc@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Trilok Soni <quic_tsoni@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=12392; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=MhEWbQKeL4hp6PAsi3bp/coMyvA+vOUXxLINdXHgeAI=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnt2mORlMnb4EDNPBmpnwYoBhwBKWouBNIFzown
 zci/uNVbfmJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ7dpjgAKCRAbX0TJAJUV
 VgNQEACXvzaDn+aT7RfxSA8sl/yA5sr4K5PQ2xFwD7zRyLPKWGbRiVA8stltI3A4QLSKqKO9N/o
 PonHs4hxsvBXYCeDWh+tv05mbxFVQabM2Lx32AI1mIIB/bHAjzkD68A41mpLUAPMZJnW3/+7WjV
 2GlomEmJfVPKa2JNpscj0YeAwX+/dknQo6EycFyYzZBuT+RiKMBT7r9H9y680MhAHw3vphHqpjv
 V95/vcoQ1QRgqvlVHziyw6A2cf81WEBGKFzLSn74dqI43ozBczxq2w6F8cbiKc1Cv3wupOp7yVc
 zbxkvn147n5rBA5d7kAAsKyDiXEifnRK8wFGNYgiKqBCdVJIWso1i4Q95uVdFwV3Igj+BV7OaWc
 5wV/9hiWRfC0C4hAiyKe18gFS+1BS6c08s+7dQ41qaaE2DkM+vBLlotUyiV85OQnJKn42Db7q5K
 sylPPC0AZHcel087e1v1Di2AEouMBU19ZwgW1/Yq4bWpPluh4aEoHMtYVjxxN/Tx0MQQiyko+9C
 n5bUbFg6vzmc1+aiiqkBSNofdRqwnaP2HXXrjlmkc0zPlzl3UgUKUa2W8Zpyyb1PWxqmfyDGRh9
 dmpx6yPdMPog+XjllNtIeILA71WyocQb0pExSEkjo9S+VpSeWJ5LjTAZAKbK+a3VnPi2OeOZ5a5
 6Sl7ehraOvqc5XA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The X Elite CRD board comes with 3 Parade PS8830 retimers, one for each
Type-C port. These handle the orientation and altmode switching and are
controlled over I2C. In the connection chain, they sit between the
USB/DisplayPort combo PHY and the Type-C connector.

Describe the retimers and all gpio controlled voltage regulators used by
each retimer. Also, modify the pmic glink graph to include the retimers in
between the SuperSpeed/Sideband in endpoints and the QMP PHY out endpoints.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 450 +++++++++++++++++++++++++++++-
 1 file changed, 444 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index ff5b3472fafd35a2a3754c11ab0b9b9e8ea5a4b4..1b29082788a366c63474b74e7dc916176a57546d 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -100,7 +100,15 @@ port@1 {
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
@@ -129,7 +137,15 @@ port@1 {
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
@@ -158,7 +174,15 @@ port@1 {
 					reg = <1>;
 
 					pmic_glink_ss2_ss_in: endpoint {
-						remote-endpoint = <&usb_1_ss2_qmpphy_out>;
+						remote-endpoint = <&retimer_ss2_ss_out>;
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					pmic_glink_ss2_con_sbu_in: endpoint {
+						remote-endpoint = <&retimer_ss2_con_sbu_out>;
 					};
 				};
 			};
@@ -311,6 +335,150 @@ vreg_nvme: regulator-nvme {
 		regulator-boot-on;
 	};
 
+	vreg_rtmr0_1p15: regulator-rtmr0-1p15 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_RTMR0_1P15";
+		regulator-min-microvolt = <1150000>;
+		regulator-max-microvolt = <1150000>;
+
+		gpio = <&pmc8380_5_gpios 8 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&usb0_pwr_1p15_reg_en>;
+		pinctrl-names = "default";
+
+		regulator-boot-on;
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
+		pinctrl-0 = <&usb0_1p8_reg_en>;
+		pinctrl-names = "default";
+
+		regulator-boot-on;
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
+		pinctrl-0 = <&usb0_3p3_reg_en>;
+		pinctrl-names = "default";
+
+		regulator-boot-on;
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
+		pinctrl-0 = <&usb1_pwr_1p15_reg_en>;
+		pinctrl-names = "default";
+
+		regulator-boot-on;
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
+		pinctrl-0 = <&usb1_pwr_1p8_reg_en>;
+		pinctrl-names = "default";
+
+		regulator-boot-on;
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
+		pinctrl-0 = <&usb1_pwr_3p3_reg_en>;
+		pinctrl-names = "default";
+
+		regulator-boot-on;
+	};
+
+	vreg_rtmr2_1p15: regulator-rtmr2-1p15 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_RTMR2_1P15";
+		regulator-min-microvolt = <1150000>;
+		regulator-max-microvolt = <1150000>;
+
+		gpio = <&tlmm 189 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&usb2_pwr_1p15_reg_en>;
+		pinctrl-names = "default";
+
+		regulator-boot-on;
+	};
+
+	vreg_rtmr2_1p8: regulator-rtmr2-1p8 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_RTMR2_1P8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		gpio = <&tlmm 126 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&usb2_pwr_1p8_reg_en>;
+		pinctrl-names = "default";
+
+		regulator-boot-on;
+	};
+
+	vreg_rtmr2_3p3: regulator-rtmr2-3p3 {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_RTMR2_3P3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 187 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-0 = <&usb2_pwr_3p3_reg_en>;
+		pinctrl-names = "default";
+
+		regulator-boot-on;
+	};
+
 	vph_pwr: regulator-vph-pwr {
 		compatible = "regulator-fixed";
 
@@ -735,6 +903,178 @@ keyboard@3a {
 	};
 };
 
+&i2c1 {
+	clock-frequency = <400000>;
+
+	status = "okay";
+
+	typec-mux@8 {
+		compatible = "parade,ps8830";
+		reg = <0x08>;
+
+		clocks = <&rpmhcc RPMH_RF_CLK5>;
+
+		vdd-supply = <&vreg_rtmr2_1p15>;
+		vdd33-supply = <&vreg_rtmr2_3p3>;
+		vdd33-cap-supply = <&vreg_rtmr2_3p3>;
+		vddar-supply = <&vreg_rtmr2_1p15>;
+		vddat-supply = <&vreg_rtmr2_1p15>;
+		vddio-supply = <&vreg_rtmr2_1p8>;
+
+		reset-gpios = <&tlmm 185 GPIO_ACTIVE_LOW>;
+
+		pinctrl-0 = <&rtmr2_default>;
+		pinctrl-names = "default";
+
+		orientation-switch;
+		retimer-switch;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				retimer_ss2_ss_out: endpoint {
+					remote-endpoint = <&pmic_glink_ss2_ss_in>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				retimer_ss2_ss_in: endpoint {
+					remote-endpoint = <&usb_1_ss2_qmpphy_out>;
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+
+				retimer_ss2_con_sbu_out: endpoint {
+					remote-endpoint = <&pmic_glink_ss2_con_sbu_in>;
+				};
+			};
+		};
+	};
+};
+
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
+
+		vdd-supply = <&vreg_rtmr0_1p15>;
+		vdd33-supply = <&vreg_rtmr0_3p3>;
+		vdd33-cap-supply = <&vreg_rtmr0_3p3>;
+		vddar-supply = <&vreg_rtmr0_1p15>;
+		vddat-supply = <&vreg_rtmr0_1p15>;
+		vddio-supply = <&vreg_rtmr0_1p8>;
+
+		reset-gpios = <&pm8550_gpios 10 GPIO_ACTIVE_LOW>;
+
+		pinctrl-0 = <&rtmr0_default>;
+		pinctrl-names = "default";
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
+
+		vdd-supply = <&vreg_rtmr1_1p15>;
+		vdd33-supply = <&vreg_rtmr1_3p3>;
+		vdd33-cap-supply = <&vreg_rtmr1_3p3>;
+		vddar-supply = <&vreg_rtmr1_1p15>;
+		vddat-supply = <&vreg_rtmr1_1p15>;
+		vddio-supply = <&vreg_rtmr1_1p8>;
+
+		reset-gpios = <&tlmm 176 GPIO_ACTIVE_LOW>;
+
+		pinctrl-0 = <&rtmr1_default>;
+		pinctrl-names = "default";
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
 
@@ -883,6 +1223,26 @@ &pcie6a_phy {
 	status = "okay";
 };
 
+&pm8550_gpios {
+	rtmr0_default: rtmr0-reset-n-active-state {
+		pins = "gpio10";
+		function = "normal";
+		power-source = <1>; /* 1.8V */
+		bias-disable;
+		input-disable;
+		output-enable;
+	};
+
+	usb0_3p3_reg_en: usb0-3p3-reg-en-state {
+		pins = "gpio11";
+		function = "normal";
+		power-source = <1>; /* 1.8V */
+		bias-disable;
+		input-disable;
+		output-enable;
+	};
+};
+
 &pm8550ve_8_gpios {
 	misc_3p3_reg_en: misc-3p3-reg-en-state {
 		pins = "gpio6";
@@ -896,6 +1256,17 @@ misc_3p3_reg_en: misc-3p3-reg-en-state {
 	};
 };
 
+&pm8550ve_9_gpios {
+	usb0_1p8_reg_en: usb0-1p8-reg-en-state {
+		pins = "gpio8";
+		function = "normal";
+		power-source = <1>; /* 1.8V */
+		bias-disable;
+		input-disable;
+		output-enable;
+	};
+};
+
 &pmc8380_3_gpios {
 	edp_bl_en: edp-bl-en-state {
 		pins = "gpio4";
@@ -906,6 +1277,17 @@ edp_bl_en: edp-bl-en-state {
 	};
 };
 
+&pmc8380_5_gpios {
+	usb0_pwr_1p15_reg_en: usb0-pwr-1p15-reg-en-state {
+		pins = "gpio8";
+		function = "normal";
+		power-source = <1>; /* 1.8V */
+		bias-disable;
+		input-disable;
+		output-enable;
+	};
+};
+
 &qupv3_0 {
 	status = "okay";
 };
@@ -1143,6 +1525,20 @@ wake-n-pins {
 		};
 	};
 
+	rtmr1_default: rtmr1-reset-n-active-state {
+		pins = "gpio176";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	rtmr2_default: rtmr2-reset-n-active-state {
+		pins = "gpio185";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	tpad_default: tpad-default-state {
 		pins = "gpio3";
 		function = "gpio";
@@ -1164,6 +1560,48 @@ reset-n-pins {
 		};
 	};
 
+	usb1_pwr_1p15_reg_en: usb1-pwr-1p15-reg-en-state {
+		pins = "gpio188";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	usb1_pwr_1p8_reg_en: usb1-pwr-1p8-reg-en-state {
+		pins = "gpio175";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	usb1_pwr_3p3_reg_en: usb1-pwr-3p3-reg-en-state {
+		pins = "gpio186";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	usb2_pwr_1p15_reg_en: usb2-pwr-1p15-reg-en-state {
+		pins = "gpio189";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	usb2_pwr_1p8_reg_en: usb2-pwr-1p8-reg-en-state {
+		pins = "gpio126";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	usb2_pwr_3p3_reg_en: usb2-pwr-3p3-reg-en-state {
+		pins = "gpio187";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	wcd_default: wcd-reset-n-active-state {
 		pins = "gpio191";
 		function = "gpio";
@@ -1214,7 +1652,7 @@ &usb_1_ss0_dwc3_hs {
 };
 
 &usb_1_ss0_qmpphy_out {
-	remote-endpoint = <&pmic_glink_ss0_ss_in>;
+	remote-endpoint = <&retimer_ss0_ss_in>;
 };
 
 &usb_1_ss1_hsphy {
@@ -1246,7 +1684,7 @@ &usb_1_ss1_dwc3_hs {
 };
 
 &usb_1_ss1_qmpphy_out {
-	remote-endpoint = <&pmic_glink_ss1_ss_in>;
+	remote-endpoint = <&retimer_ss1_ss_in>;
 };
 
 &usb_1_ss2_hsphy {
@@ -1278,5 +1716,5 @@ &usb_1_ss2_dwc3_hs {
 };
 
 &usb_1_ss2_qmpphy_out {
-	remote-endpoint = <&pmic_glink_ss2_ss_in>;
+	remote-endpoint = <&retimer_ss2_ss_in>;
 };

-- 
2.34.1


