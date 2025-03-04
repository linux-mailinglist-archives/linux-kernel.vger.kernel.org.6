Return-Path: <linux-kernel+bounces-543938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D173EA4DBAB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 12:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F7CF3B0FD7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 11:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA8F202F8B;
	Tue,  4 Mar 2025 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KRh1JO1H"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC58820297F
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 10:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085895; cv=none; b=D/UWQMQMG2oSdD/PBJrxrsm9negxSYNFL8qRoxWdt0nccY77XF03GH/ahTMNnVyfGLgIN4lF0A2ZdB9Gmti8BWuC8oZQYTRLer+MzoqcVsbtHtM/hjx8SSViLlmG0LR+ldbZ8YncIpwGVmlhLM2fuP/1RWMHg4DWa0tQU0MMvkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085895; c=relaxed/simple;
	bh=2GMMBV5KCTCVUEz74lKQuY4y7IGNzVZFUJRa7iO3KyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iJIC0zaL4gOf6++ssfuK+I6Qt/l8DHMyogjes5h77Fp+nXGYuntXcKm3BZneWXfdXLThD3RSh8Y046GxMIUFaVTGSW97TYo2YJelgONPdmKNvF09J4VX0Ife7UgF7707URhdK3O6KyhUzCLmRQ1edm+xPAeS8toTu3iixEa9gfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KRh1JO1H; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso984720366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 02:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741085891; x=1741690691; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9N0aPkF/Z0JEFykm8NKBcg4YWEC1djCpni+AK9aqtpo=;
        b=KRh1JO1H5trKK/EEnXwnNOMuHrQrr7RwOKU3v4GP0z5P0MpFTaWhSXKUJfnVdoaKjz
         3Fz6G+v7LKBuyaqAfV4VfYo33kuvRH4SzdxXrT5/O4mrO4focvKPgr2hcQj8SMTcumeW
         JnXov/KUJPm7OcswtVZ8Fs5wj1kOkCSTEEfbQFSpd7os1M3LUyKB7Jr1fRcxYjn4fKnm
         1fPrqzOYeRrftrZObNJxjSF1gk+UCxo2/EdIHzmOtFMASGuRaLdQvggOv9oxidWyQjWP
         pUzX5dc3SgdSdv9XRXVAyvcUrrdk71kpdrrZAVJRJESY1W7DtGgpPI4TNy8XmVipXX94
         KUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741085891; x=1741690691;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9N0aPkF/Z0JEFykm8NKBcg4YWEC1djCpni+AK9aqtpo=;
        b=Azefm0x8Mu6ABdwZtlKqPIjmSoTMIDWRwJTkpYG7aSVU6HxVDta+WG8QhSdRhMdC8K
         bI5fDFn6Nuv+oLokDO8ZYMckMIWPkBSbHXx7xhHkX6cyE3+CeEb8/PTMDfYTC/thIDww
         d0Ofo4afJyswSAR954ezhkiZ2sIUWBg2SHkMauyroqrT0Ib7ZNA8LUgqGsbX7g0+ICcj
         7S/m43Yu8/nJ0QeCr+dzcFnke3zFLwi/bTzb27cOU6LDwsbKtvODWYFKZFSv5t/Nyd9K
         iEjsTdFJ8tboGdmx56VGmhLBbqEL5OGgy6uXh54xaS//nWBAFrrTFbWV9896ldUJEdmu
         B9Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVGeC0U315D634R5SSjBL79Yk9IounJfSMhlwz7Yaova/EdLf3Eow+C8K8E9v1MuphsgUTTsgsAl/oQ998=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjgBDn5Ke/Lp8jjPjEGT8BvubQhE332M+2OcSCS0VNLCn28dHQ
	TTgp9K4YXh6P1RpMES2elaiSOXJ9FcOX2/Dk1cyGG3hrbUEjOVqR8fANypgk3CHm5yVRQwSi1Ip
	d
X-Gm-Gg: ASbGncvurjtgnUANNszqsFZfYR0qnMekds6W73i4qkjHndQjo8VkUNRSj9GsmzYX7Nr
	PKpGsDPiLuVCMYaL6zploKAPoAipcpTnBplGR2bFe/RPT0o/cxJKc0ar0xxNIeVj/0luUTFgzdY
	Ybp1buM9DHDMCg6rZcpW+0wtbM6vqhvbxVhrHMRlwzKdWxWwc3q+yVD2rZR7i87MQs44x4cahWx
	kqum6E1ukUQVm+d9EryAz8u68PooTBF8uDejA1QT0RzN47TgASNVtG4TeIvhTqtijAK7J95saQS
	BHms8HBFVq7YEY4ZJHjQ5xBYaZvtdfpAwAsO25QmoBQ=
X-Google-Smtp-Source: AGHT+IHdsXVkbV8H0XhuNEizh3IcOoxDnDBO1bpMNgRbqISU7Ni23irJrYgBYNsFaYHYvOKxcCn22g==
X-Received: by 2002:a17:907:2d10:b0:ac0:4364:4091 with SMTP id a640c23a62f3a-ac043738670mr657341266b.9.1741085891153;
        Tue, 04 Mar 2025 02:58:11 -0800 (PST)
Received: from [127.0.1.1] ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac1fde3f585sm38973266b.53.2025.03.04.02.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 02:58:10 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 04 Mar 2025 12:57:48 +0200
Subject: [PATCH v6 3/4] arm64: dts: qcom: x1e80100-t14s: Describe the
 Parade PS8830 retimers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-x1e80100-dts-crd-t14s-enable-typec-retimers-v6-3-e5a49fae4e94@linaro.org>
References: <20250304-x1e80100-dts-crd-t14s-enable-typec-retimers-v6-0-e5a49fae4e94@linaro.org>
In-Reply-To: <20250304-x1e80100-dts-crd-t14s-enable-typec-retimers-v6-0-e5a49fae4e94@linaro.org>
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
 Abel Vesa <abel.vesa@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Johan Hovold <johan+linaro@kernel.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=9056; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=2GMMBV5KCTCVUEz74lKQuY4y7IGNzVZFUJRa7iO3KyU=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBnxty6zeSih0EUkE5OenNTqsof+N1Z48ZXKNeJq
 pmESQqVf5yJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ8bcugAKCRAbX0TJAJUV
 Vj8XD/9geLuAcQ7shRz92ZTjUMhcuM7B1SvZ5burD1fYYBHgbtfd/a6doEMBQiGVjakrYsNShlX
 D72ZaJbvY7CwZbrwPT9Yg7ab49H1JJHWihtMfECZ5ztUE+2jRMxJVzktbPKLF8Onr0q+gpwvaHg
 vnBpQ42mGdbnZn1sLBxYrIYNPHiZLLnhPyU7n/7OTKCCqd04utdGTceTyHxukqZgsfAp2A2JwJ2
 fn5tOCM3xeCUxqcREHEu5tE6/vsUpy+syRu3sNz/VY171sv4IJZos5mqwQIKSgGnz2Tp+qKTNjJ
 +WCLcbpkfvLW4LIpmiORSgL83pw7LrszICJy/Fg2IhPhjRWMkovU1x7gYeITrNv14Asx609Ba7T
 oqMK/51Bz1oUnGBRoTQMnupRsJhtgze4vadbl/5jDmXFwH5IS2FHYq5mCt22hlbqz8dmRbn1hMh
 PLKjO1wsvj9n//Ny45jtrBahY8HrwfS6fW53gHq2WZCaYE6Sc4ulosL3l5fvWzcJRq5fMvfEWyH
 vueDqARjYXtj7ij4vvTyi/TLTaH8uQeGpDFraFG8ryJWBdtZVxuqCmw0LWBDzYUoiMmysMZl8LE
 KqllW/fYL3yz0f8ioA6wqumuZfJCGcZTG84VJ8eUk+LEbGzLmOejZrKgCJhMO5QsWbhL8L9zWvp
 OcaTXFg0WTn+x9w==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The Lenovo ThinkPad T14s Gen6 laptop comes with 3 Parade PS8830 retimers,
one for each Type-C port. These handle the orientation and altmode
switching and are controlled over I2C. In the connection chain, they sit
between the USB/DisplayPort combo PHY and the Type-C connector.

Describe the retimers and all gpio controlled voltage regulators used by
each retimer. Also, modify the pmic glink graph to include the retimers in
between the SuperSpeed/Sideband in endpoints and the QMP PHY out
endpoints.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts     | 304 ++++++++++++++++++++-
 1 file changed, 300 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
index b2c2347f54fa65f9355f0d7c008119e95bb64fb2..9c0903b8436396b2fe6e17ee3bc4d454cb5a0f8b 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dts
@@ -92,7 +92,15 @@ port@1 {
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
@@ -121,7 +129,15 @@ port@1 {
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
@@ -169,6 +185,102 @@ vreg_nvme: regulator-nvme {
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
 	vph_pwr: regulator-vph-pwr {
 		compatible = "regulator-fixed";
 
@@ -607,6 +719,63 @@ keyboard@3a {
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
 &i2c5 {
 	clock-frequency = <400000>;
 
@@ -655,6 +824,63 @@ eusb6_repeater: redriver@4f {
 	};
 };
 
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
+		};
+	};
+};
+
 &i2c8 {
 	clock-frequency = <400000>;
 
@@ -777,6 +1003,37 @@ &pcie6a_phy {
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
@@ -787,6 +1044,17 @@ edp_bl_en: edp-bl-en-state {
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
@@ -1007,6 +1275,34 @@ wake-n-pins {
 		};
 	};
 
+	rtmr1_default: rtmr1-reset-n-active-state {
+		pins = "gpio176";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
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
 	wcd_default: wcd-reset-n-active-state {
 		pins = "gpio191";
 		function = "gpio";
@@ -1045,7 +1341,7 @@ &usb_1_ss0_dwc3_hs {
 };
 
 &usb_1_ss0_qmpphy_out {
-	remote-endpoint = <&pmic_glink_ss0_ss_in>;
+	remote-endpoint = <&retimer_ss0_ss_in>;
 };
 
 &usb_1_ss1_hsphy {
@@ -1077,7 +1373,7 @@ &usb_1_ss1_dwc3_hs {
 };
 
 &usb_1_ss1_qmpphy_out {
-	remote-endpoint = <&pmic_glink_ss1_ss_in>;
+	remote-endpoint = <&retimer_ss1_ss_in>;
 };
 
 &usb_2 {

-- 
2.34.1


