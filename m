Return-Path: <linux-kernel+bounces-573833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9CDA6DCF4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A271161D40
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486CC25FA0D;
	Mon, 24 Mar 2025 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cVDSjf9V"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9C526137B
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742826254; cv=none; b=RLINFz0vU2bba5fSf/JCXsOfkRb9I78X6NcZcySI1+hRHi5XCieEbhfz+IF2BsOCm2DAIhiKu7N5oloPWYx/9lfWBLS52Gq8duS26ijbEGsH6bE76edBJ4RxvBsS4yLLNzDotMODSIu2IL6e11YC1PRFg6rzI6NNM8BNE70hUB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742826254; c=relaxed/simple;
	bh=O14EyF9A15Ru315HFl4HSzQuAQcmW2SYomPhPWdbxQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UT3jE+WKXoFGBIY+MvoWuohpj9rPGGsTw65Z+FY6Hf9XZ7yusWKw9c6TuLYP8FFSp0NHWCwlnkZ7uLwjBVyEIp7/1FizMujBkfZXux8B8oJwA/ylN2w1DJ0KPVX+SFatyMtSk9lySPNadan1UqzGmrGq3s00jhXOWoWPzAWgGKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cVDSjf9V; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ac3fcf5ab0dso429277966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 07:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742826249; x=1743431049; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N5W5g6PwOvS4pLaf93NgeHPK0lEFRnE/rz638Ra6x+s=;
        b=cVDSjf9VPxGzjL308ZAfWjhsXRpm62MSWa8DyI39iJYCYX8usktM1w07xANhZrHLtu
         U4N3AduM5obAwOrzk3L+12MSR4xqSCc+mdYXvWCOCZSu2AzArQiHrqWRX7unW7XEXfbu
         NWmlSW+MJ+xHCyCUIzeOj5Sq9niQbWgDRCVhZUI/PBGaVviNwH5qm/JmLz+HVL+9kbSA
         KJkXX84DwHPbKw3bIlWRL5xbr3rwJeodAD9ZS3sDFiBenuKDEA8ymyVnMPa4IiMdrryw
         lVilEwyiaODIA94AAwnQ4Bf4F2Q+Qo/rsLNHd36VtGD2rVjS6KZ+uc0aDDg88LhhXFQu
         e8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742826249; x=1743431049;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N5W5g6PwOvS4pLaf93NgeHPK0lEFRnE/rz638Ra6x+s=;
        b=imGYkeP8Ff0jr9ILtMnduLBTTqYlzoEmsDnuvM+09fqM7URqW4IVB2KZVQNl1BIKtO
         joUZ4neaLzaUVUxP0XwTR4E+nwtoNiUS21sOAZ28oeO1KYHLuS3F7z1FD4jUGaaWhUMf
         PetAwRWuOqWuttojMTPL6uXGcb6g73ZquVssy+Bb2DWAvc5CV24+LoK47BY5SXEFl1FX
         ZrkhhbySFh35GSxXwJbGT5NVSUPg6k60oO0A0DxqyssYvPhGEu17LWnecF8ZTsDq7rCF
         B1p9V3T+XE9o14RemutwCDOhKS1sbT8DuSxrh4kS+cRSQCqUX3a2ueMy8lAj2DXOR9j5
         ypMA==
X-Forwarded-Encrypted: i=1; AJvYcCVjHQFCJlz9pRxxvj9XIy5pWOArr5Ak6/5zLVat52OC45A6YBqYnZ3LuU8ZwBW22th/Gn1xlTwAGBm1nio=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOXKL93m/cv7GD83CU+aJz18XyJdsQdXHHTUJFa+kT0ULE0UGP
	i9pVXm+siiPRVmiFE2LAkKjknH7YU/FpQtxXda3NIt0cKrLdzJ9R7gNnoCGkpOA=
X-Gm-Gg: ASbGncu+s+EuZtW5Bpn+0scFFU5U8KNnPPsBz79YIUIfX4o+nh8m8LrV1Z78PPSuHB3
	IL8ESN4VwkycYrX9uSayyIqN4gHeP8BGq9cBt2rsb0MPKoLsvvPUsMx3unlwvBrYh11ls2EujzT
	/xoL3CvWJLzw9jTSBrYDndKiw7judiQn2j8xyO3yoRntr1047GbgiyvGx5m5YVqGj5lRvJsELtu
	L8d1iifRLL+ejOvx0eH1qtF75r9iqY9Z642Usw+sYCYyrlXI+rRNn9UxPN1OW29bx/3pF2jV5ln
	g/QiVEfm9sP2yGPhMMJapKd/npIRTH5mnN2oEEymGzY=
X-Google-Smtp-Source: AGHT+IHYJjQcnvC0ryFrppXbwzy2MaIiK3p54ZynX0xZ5IkhjX/bqQbS4oI+0KQ1kd+n1FhIDqGwjQ==
X-Received: by 2002:a17:907:971d:b0:ac3:eb24:ab26 with SMTP id a640c23a62f3a-ac3f2559a6bmr1240855366b.51.1742826249519;
        Mon, 24 Mar 2025 07:24:09 -0700 (PDT)
Received: from [127.0.1.1] ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efbde4bfsm680626166b.143.2025.03.24.07.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 07:24:08 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Mon, 24 Mar 2025 16:24:01 +0200
Subject: [PATCH] arm64: dts: qcom: x1e001de-devkit: Add Wi-Fi and Bluetooth
 pwrseq
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-x1e001de-devkit-dts-pwrseq-v1-1-530f69b39a16@linaro.org>
X-B4-Tracking: v=1; b=H4sIAABr4WcC/x3MwQqCQBAG4FeROTcws1obvUp4kPbfGgKzHTFBf
 HeXjt/l28hRDE63ZqOCxdw+Y4WeGnq8hvEJtlRNQcJZ2tDxqhDRBE5Y3jZzmp2nX3F8OYq2+ZK
 vGuNANZgKsq3//N7v+wG9DlY1bAAAAA==
X-Change-ID: 20250324-x1e001de-devkit-dts-pwrseq-7013f6f8177a
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5152; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=O14EyF9A15Ru315HFl4HSzQuAQcmW2SYomPhPWdbxQE=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBn4WsGG0VF7w1+dgKH6eEdutb6UZHbVya4No+Ri
 S6c61U7cRuJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ+FrBgAKCRAbX0TJAJUV
 Vqc4D/0U1dIQourgy19gD5wTGYlPrHZRa3ex10RSv45I1t/e+qVJpqfvBp30A3jg1mX2gEmD3+7
 z4kjTIAb3R51r3113LTo6dQv4Iv786jchKcwsWL7OMWJGF/5KJ4gqf/YGOBPXS0PMtxtq5x6DQj
 kAItRhDrWGjcbO6LUSmQDjK9gJhMvW98vKhpylPIAHRJOeYXbSMQOrBsXkq3HkRYkAPg43KJrhM
 /ecG1G1JsMCcwmbpanX4HrCwkUNOvWWrZ6rn00DkVXps6/jdsxw0W6J1fNFVsfBRSjUhpepyJLo
 X2eyy/TxWtU+BC56BAnztrQwdKLLJ4W5QmneOiyjdmF/3Eqh2NKrdsg8pacAorAclvzmcBSbGD+
 c0pEFW6JkYTieYKr0xFsQqNuERYvuIUjzw10AKIWXkp+UbCGyU+gFb9DkNnyKD19+vUfzjhOUFD
 gNRbb6OwFBrLsrtVPdnlcNIZW9flZLZL2F7zBH0uLQsAW4b4kWC0cwCg0keIzQ1dKo1QjRaiSc8
 lVMHM+1E3azfToXRHmyn0/dAvQ4wsVKsXI7EmVK813sXpo+EKzF017ST/cTidmEqLasBiFH/w1e
 ASip1C16+YWIfD6GTGrIWk0+uoWOGXA3TZfPrWRP/ZbDrtNQtLhLIXriP3tDY4MGgwzTNmNyEy9
 aYCSB7V7Nx2quSQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The Qualcomm X Elite Devkit comes with a WCN7850 combo chip which provides
Wi-fi and Bluetooth, similar to the CRD and QCP.

Describe the nodes for the Wi-Fi, Bluetooth, the related regulators and
the PMU.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts | 144 +++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
index 74911861a3bf2606add8cf4aaa3816542e837513..8f288a138c4cb6e21725fdf726eb2a2489bfbc38 100644
--- a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
+++ b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
@@ -17,6 +17,7 @@ / {
 
 	aliases {
 		serial0 = &uart21;
+		serial1 = &uart14;
 	};
 
 	wcd938x: audio-codec {
@@ -392,6 +393,42 @@ vph_pwr: regulator-vph-pwr {
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
 	vreg_wwan: regulator-wwan {
 		compatible = "regulator-fixed";
 
@@ -407,6 +444,65 @@ vreg_wwan: regulator-wwan {
 
 		regulator-boot-on;
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
@@ -979,6 +1075,23 @@ &pcie4_phy {
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
 &pcie5 {
 	perst-gpios = <&tlmm 149 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 151 GPIO_ACTIVE_LOW>;
@@ -1262,6 +1375,20 @@ wcd_default: wcd-reset-n-active-state {
 		output-low;
 	};
 
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
+
 	wwan_sw_en: wwan-sw-en-state {
 		pins = "gpio221";
 		function = "gpio";
@@ -1270,6 +1397,23 @@ wwan_sw_en: wwan-sw-en-state {
 	};
 };
 
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
+};
+
 &uart21 {
 	compatible = "qcom,geni-debug-uart";
 	status = "okay";

---
base-commit: 9388ec571cb1adba59d1cded2300eeb11827679c
change-id: 20250324-x1e001de-devkit-dts-pwrseq-7013f6f8177a

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


