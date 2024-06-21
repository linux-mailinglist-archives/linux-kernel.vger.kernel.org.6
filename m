Return-Path: <linux-kernel+bounces-224221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 427A5911F08
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 10:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED0972861BE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 08:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4368A16E871;
	Fri, 21 Jun 2024 08:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="F90CYt4c"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F1A16D9DB
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 08:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718959369; cv=none; b=jjQZwP0u8qkfpEJGAy38ZOUOhYQBRQoRR33nIRgiP4wvyqXcZwhZA2p4Q5pLniuetrZ8bBCF2Z4MhnvCZA3un+/pcUiWtKIs21kOdunp2cODqfWt/tMqNEeCs7UO4LE+WVTbU7OiOoJUGwx1gEUcnfUMwFXZl1mDBoSMCWp2fMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718959369; c=relaxed/simple;
	bh=mQBtqXRL4nG/wQ2Gonn03d7mFlmmcCbFLHwKhqXTVg0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kfp2UXhjLDUOPDXl965Ly0iNrlt58OVUqmyiv5LupzvvWHxfo2LCpuFMSxSUqttizzEKWlvapYxzlftC0JnF44+bikpLJgX0kF6racB9PPgea3SQO0iXkbHhEFOKCu/TVujyD6MF1tArWRTvEy/GKU/qBGAMIsiqrL+2/qY6Neg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=F90CYt4c; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a6f9fe791f8so289907966b.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 01:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1718959366; x=1719564166; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6/FWrAKVXVKCvlxPWf7/91N7cA8SSxdEOKYrF7gJy+8=;
        b=F90CYt4cXSqNif8UVr/dZzvqR7Ji5KsRmBimEi549o9HcRcMB8hw91zWYvxYaRlfVB
         fPw2zSjlXq8SZ/m+SOqcSjnijdrBXmh7jpbqQPatvA+cbG7/P2aT9pDWiP/As381Ogrk
         NiGPM/HNDmLizs0zbXEFq7z6uAmoD5tLKaaGkiGY7VU6C9ZCmb6Hot8MvpvPsEWxQeQ0
         7I23EZFwkV+fIahmn8AVIiKt03DX6hlFi2tOUNsz1Q6hBTsNKtMGaCVHFoGWl+E+DyuL
         DVOevBHKiOR7TNfc+re2XK2vxoSQy7cgsTYRj1BNcDni1q1DkPgO8guiBqoRqNomiwyj
         IROw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718959366; x=1719564166;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6/FWrAKVXVKCvlxPWf7/91N7cA8SSxdEOKYrF7gJy+8=;
        b=DQM2I5E/6qC14w1NeNr7/U4lmw7LMsUpy7al0r55ywpeoHUzLNtPrj0WlPa8ibVJb5
         FlCjDTJ11fXgUbDJJn/d66QDZ/hzuot1VpADTHMbT1ujCb+zN85TiEoOTE/V30MLIuFo
         b4AO6TwFPnyaLyUyIW38a/wx7GGv1Cx3tTA+IXAmKJ6wZFrC3HkmT/2g/4L1Bs8Wtsob
         8WvNdr4MXj50SkFLcLat0Q03QL3Nz1Q/EPK7RvsUCCTHXZrnEVEfn4yZiJmt/T8gbjbG
         /nO2/6p4Tbt+xxJFAOuBfQjdqp6evXs+KO2MQfXCmKSateLCm9Ikfa403UanllySS2aH
         RQwA==
X-Forwarded-Encrypted: i=1; AJvYcCX+DSWHuR4nIb5P+1vKcqpCd3s9hYjGsneeCA+Jrt3qouMi+Mcp1o/eoeG2XqS+Fp1up+bGvWn+B3uWqNiVDOR6vNtC9YX5c8ejcZjd
X-Gm-Message-State: AOJu0YxAktMvHQ6WmYprdm1QJljN8gxiMsAoA87BtN2vdxBeyDFybYYt
	0tABHKMln5TTdIoEn0BVuA5HfAkLMaqvnPy+oHt79+VLLsUsiecoWwER4U2EW9s=
X-Google-Smtp-Source: AGHT+IEfFBROnrph7emIhlAXuHZZDsdW4wzja/NgbYTMXQ3bFBbVpVwojfAzaTpmcLRte0EkRYDQ5w==
X-Received: by 2002:a17:906:3e8a:b0:a6f:8e53:e981 with SMTP id a640c23a62f3a-a6fa449a9efmr481862666b.34.1718959366099;
        Fri, 21 Jun 2024 01:42:46 -0700 (PDT)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf428c18sm58993166b.24.2024.06.21.01.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 01:42:44 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 21 Jun 2024 10:42:31 +0200
Subject: [PATCH 2/2] arm64: dts: qcom: qcm6490-fairphone-fp5: Configure
 PM8008 regulators
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240621-fp4-fp5-pm8008-v1-2-dbedcd6f00f1@fairphone.com>
References: <20240621-fp4-fp5-pm8008-v1-0-dbedcd6f00f1@fairphone.com>
In-Reply-To: <20240621-fp4-fp5-pm8008-v1-0-dbedcd6f00f1@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.0

PM8008 regulators are used for the cameras found on FP5. Configure the
chip and its voltages.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 105 ++++++++++++++++++++-
 1 file changed, 104 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index 25ed74d4ebd2..765585b0d09e 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -207,6 +207,25 @@ active-config0 {
 			};
 		};
 
+		pm8008-thermal {
+			polling-delay-passive = <100>;
+			thermal-sensors = <&pm8008>;
+
+			trips {
+				trip0 {
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
 		quiet-thermal {
 			polling-delay-passive = <0>;
 
@@ -522,7 +541,76 @@ &gpi_dma1 {
 &i2c1 {
 	status = "okay";
 
-	/* PM8008 PMIC @ 8 and 9 */
+	pm8008: pmic@8 {
+		compatible = "qcom,pm8008";
+		reg = <0x8>;
+
+		interrupts-extended = <&tlmm 25 IRQ_TYPE_EDGE_RISING>;
+		reset-gpios = <&pm8350c_gpios 3 GPIO_ACTIVE_LOW>;
+
+		vdd-l1-l2-supply = <&vreg_s8b>;
+		vdd-l3-l4-supply = <&vreg_bob>;
+		vdd-l5-supply = <&vreg_bob>;
+		vdd-l6-supply = <&vreg_s1b>;
+		vdd-l7-supply = <&vreg_bob>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&pm8008_int_default>, <&pm8008_reset_n_default>;
+
+		gpio-controller;
+		#gpio-cells = <2>;
+		gpio-ranges = <&pm8008 0 0 2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+
+		#thermal-sensor-cells = <0>;
+
+		regulators {
+			vreg_l1p: ldo1 {
+				regulator-name = "vreg_l1p";
+				regulator-min-microvolt = <1000000>;
+				regulator-max-microvolt = <1200000>;
+			};
+
+			vreg_l2p: ldo2 {
+				regulator-name = "vreg_l2p";
+				regulator-min-microvolt = <950000>;
+				regulator-max-microvolt = <1152000>;
+			};
+
+			vreg_l3p: ldo3 {
+				regulator-name = "vreg_l3p";
+				regulator-min-microvolt = <2700000>;
+				regulator-max-microvolt = <3000000>;
+			};
+
+			vreg_l4p: ldo4 {
+				regulator-name = "vreg_l4p";
+				regulator-min-microvolt = <2700000>;
+				regulator-max-microvolt = <2900000>;
+			};
+
+			vreg_l5p: ldo5 {
+				regulator-name = "vreg_l5p";
+				regulator-min-microvolt = <2704000>;
+				regulator-max-microvolt = <2900000>;
+			};
+
+			vreg_l6p: ldo6 {
+				regulator-name = "vreg_l6p";
+				regulator-min-microvolt = <1700000>;
+				regulator-max-microvolt = <1904000>;
+			};
+
+			vreg_l7p: ldo7 {
+				regulator-name = "vreg_l7p";
+				regulator-min-microvolt = <2700000>;
+				regulator-max-microvolt = <3000000>;
+			};
+		};
+	};
+
 	/* Pixelworks @ 26 */
 	/* FSA4480 USB audio switch @ 42 */
 	/* AW86927FCR haptics @ 5a */
@@ -653,6 +741,14 @@ wide-rfc-therm@4 {
 	};
 };
 
+&pm8350c_gpios {
+	pm8008_reset_n_default: pm8008-reset-n-default-state {
+		pins = "gpio3";
+		function = PMIC_GPIO_FUNC_NORMAL;
+		bias-pull-down;
+	};
+};
+
 &pmk8350_rtc {
 	status = "okay";
 };
@@ -810,6 +906,13 @@ hall_sensor_default: hall-sensor-default-state {
 		bias-pull-up;
 	};
 
+	pm8008_int_default: pm8008-int-default-state {
+		pins = "gpio25";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
 	qup_uart7_sleep_cts: qup-uart7-sleep-cts-state {
 		pins = "gpio28";
 		function = "gpio";

-- 
2.45.2


