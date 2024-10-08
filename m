Return-Path: <linux-kernel+bounces-354966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A71C799454C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 12:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29FCA1F246FD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 10:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F4E1C0DF3;
	Tue,  8 Oct 2024 10:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nvBA05Ad"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B472198A20
	for <linux-kernel@vger.kernel.org>; Tue,  8 Oct 2024 10:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728383160; cv=none; b=FeVcDLn/sLbWgbh/zni/kFE6+H9NkSRFQ85N6zTUmPhbMBPRkbPjkbUasGpO54RHo+C7TTURiWYFPIcGBAfkpZpNJoDahtVEAY9O3r6eWJyR5gS6zh85sQl4MoXRZzz6qatbzxKHhPBel8vnz2OzsxycMkJV0jZvbAmfVb/0lBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728383160; c=relaxed/simple;
	bh=wOwXZupALiNW3+X5wqO5OmvJO9K0b8t/CukyNIJZQBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMgc9fHK6oyrm/Po+8Swnin4L6bsub2LBdCKBWX9hHjDH5Vs/n123ChstVrAlEtRt9GD5Z+FoI8rJtXXJTOAxnlUl/SMm9e1opETUxIcwXUPJ2kl9BZX9okHY5DJr8mfdY9LLlMEzPlUzHTZbZw8TlE6f01D5tCqp3Y5hEm3oCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nvBA05Ad; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cbc22e1c4so43611405e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2024 03:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1728383157; x=1728987957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhMmED9J3JD3SYPvvVD0/+8QTIt2z+wu1FQxCfU13xU=;
        b=nvBA05Ad9JiKj7ESndrqTC9ck+kzqbMGyJdnOaeXxP2ygcfHUJATYsKRAY75Qy/bd+
         +Xjb5BoVUbjAloXhOG1GmtiIN0v/Xi7Fj054oqJ/KVWIzPX92i3SU2DOF7nHF5yksYr6
         zBV/7UHM53/kpaSX4qRT2tppY6KJ25tCf6bRkmdODbpnkQXXGNBUjFwWl//QcgAIbAsg
         eFXkB5CSbIIQOaUxNQBRpcQU1q0p0bxk/ot6QTelcnqhPND3E2lnQns9IuNCuGT4+RV8
         /nGtxbY4ZqEyESLz6N3Li3ly4+NmD0nJk5otCx0blW4y761G0qWxCHnpjPiYfHvo615W
         7Zgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728383157; x=1728987957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhMmED9J3JD3SYPvvVD0/+8QTIt2z+wu1FQxCfU13xU=;
        b=BOzISXez4Bg3jfYTStsRf0QXrohEmOW2rWQsvPCW0QXbzbbowgMiEdTF1Rrb/2Y6xT
         ZQDesSq0rWSlBRne0diBZNj0OMlp3Ro6GqY9YWjXgjf1SBbmEgS2SV5f57CfvvuiBRLu
         yWC455N6PYm8u/tzCgOr50yZWxCdjWCId1RM51SUOxBBcr+tEPPJxbh+HSDQnkl0ipcS
         LLjEK12YwxBMnximIVKOFxYKcIQwQ4WZ3XIdYV+1UVcYIwhuw6A/5vNWUQ18qj3QCult
         E7pFoxapoR/zpD+Xc+NtMUbu/DPTRXWYXBb9sqeOYJvOd/u5iCtRefzR44bZZ8kp+exz
         0CZg==
X-Forwarded-Encrypted: i=1; AJvYcCUtc0n/BA8EwpTltb4iODtW1NdznDMAmwKDiCNnpJXceMGwR0tyvCMkAkbmAMK73UYs3fnirYxfkCCEbrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz75uOoBwwz+c6wsbG0mne83gwafaNVfrRi8S6WHwnNmC0qqcgr
	uLUVDAXi4ZkhOnEmP27x/3z7eV6sgiolzX1aEozdqve/g+vZjMXdgYXZXBSKcSE=
X-Google-Smtp-Source: AGHT+IEgyeOhRR8j3BHmdHxOzVo1NxLbPZzdaLDDLvVg2K30fQjTncDYH3oA7MhEjuiRHPdmYjGIIQ==
X-Received: by 2002:a05:600c:350c:b0:42e:8d0d:bca5 with SMTP id 5b1f17b1804b1-42f85aa1a76mr98025805e9.2.1728383156747;
        Tue, 08 Oct 2024 03:25:56 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:738a:20da:f541:94ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d1691b505sm7766800f8f.43.2024.10.08.03.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 03:25:56 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v5 1/3] arm64: dts: qcom: sc8280xp-crd: model the PMU of the on-board wcn6855
Date: Tue,  8 Oct 2024 12:25:42 +0200
Message-ID: <20241008102545.40003-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008102545.40003-1-brgl@bgdev.pl>
References: <20241008102545.40003-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add nodes for the WCN6855 PMU, the WLAN module and relevant regulators
and pin functions to fully describe how the wifi is actually wired on
this platform.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Co-developed-by: Konrad Dybcio <konradybcio@kernel.org>
Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 110 ++++++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index 6020582b0a59..69326e4f5534 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -260,6 +260,67 @@ usb1_sbu_mux: endpoint {
 			};
 		};
 	};
+
+	wcn6855-pmu {
+		compatible = "qcom,wcn6855-pmu";
+
+		pinctrl-0 = <&wlan_en>;
+		pinctrl-names = "default";
+
+		wlan-enable-gpios = <&tlmm 134 GPIO_ACTIVE_HIGH>;
+		swctrl-gpios = <&tlmm 132 GPIO_ACTIVE_HIGH>;
+
+		vddio-supply = <&vreg_s10b>;
+		vddaon-supply = <&vreg_s12b>;
+		vddpmu-supply = <&vreg_s12b>;
+		vddrfa0p95-supply = <&vreg_s12b>;
+		vddrfa1p3-supply = <&vreg_s11b>;
+		vddrfa1p9-supply = <&vreg_s1c>;
+		vddpcie1p3-supply = <&vreg_s11b>;
+		vddpcie1p9-supply = <&vreg_s1c>;
+
+		regulators {
+			vreg_pmu_rfa_cmn_0p8: ldo0 {
+				regulator-name = "vreg_pmu_rfa_cmn_0p8";
+			};
+
+			vreg_pmu_aon_0p8: ldo1 {
+				regulator-name = "vreg_pmu_aon_0p8";
+			};
+
+			vreg_pmu_wlcx_0p8: ldo2 {
+				regulator-name = "vreg_pmu_wlcx_0p8";
+			};
+
+			vreg_pmu_wlmx_0p8: ldo3 {
+				regulator-name = "vreg_pmu_wlmx_0p8";
+			};
+
+			vreg_pmu_btcmx_0p8: ldo4 {
+				regulator-name = "vreg_pmu_btcmx_0p8";
+			};
+
+			vreg_pmu_pcie_1p8: ldo5 {
+				regulator-name = "vreg_pmu_pcie_1p8";
+			};
+
+			vreg_pmu_pcie_0p9: ldo6 {
+				regulator-name = "vreg_pmu_pcie_0p9";
+			};
+
+			vreg_pmu_rfa_0p8: ldo7 {
+				regulator-name = "vreg_pmu_rfa_0p8";
+			};
+
+			vreg_pmu_rfa_1p2: ldo8 {
+				regulator-name = "vreg_pmu_rfa_1p2";
+			};
+
+			vreg_pmu_rfa_1p7: ldo9 {
+				regulator-name = "vreg_pmu_rfa_1p7";
+			};
+		};
+	};
 };
 
 &apps_rsc {
@@ -269,6 +330,15 @@ regulators-0 {
 
 		vdd-l3-l5-supply = <&vreg_s11b>;
 
+		vreg_s10b: smps10 {
+			regulator-name = "vreg_s10b";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
 		vreg_s11b: smps11 {
 			regulator-name = "vreg_s11b";
 			regulator-min-microvolt = <1272000>;
@@ -276,6 +346,13 @@ vreg_s11b: smps11 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
+		vreg_s12b: smps12 {
+			regulator-name = "vreg_s12b";
+			regulator-min-microvolt = <984000>;
+			regulator-max-microvolt = <984000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
 		vreg_l3b: ldo3 {
 			regulator-name = "vreg_l3b";
 			regulator-min-microvolt = <1200000>;
@@ -304,6 +381,13 @@ regulators-1 {
 		compatible = "qcom,pm8350c-rpmh-regulators";
 		qcom,pmic-id = "c";
 
+		vreg_s1c: smps1 {
+			regulator-name = "vreg_s1c";
+			regulator-min-microvolt = <1888000>;
+			regulator-max-microvolt = <1888000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
 		vreg_l1c: ldo1 {
 			regulator-name = "vreg_l1c";
 			regulator-min-microvolt = <1800000>;
@@ -583,6 +667,25 @@ &pcie4_phy {
 	status = "okay";
 };
 
+&pcie4_port0 {
+	wifi@0 {
+		compatible = "pci17cb,1103";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn_0p8>;
+		vddaon-supply = <&vreg_pmu_aon_0p8>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p8>;
+		vddpcie1p8-supply = <&vreg_pmu_pcie_1p8>;
+		vddpcie0p9-supply = <&vreg_pmu_pcie_0p9>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
+
+		qcom,ath11k-calibration-variant = "QC_8280XP_CRD";
+	};
+};
+
 &pmc8280c_lpg {
 	status = "okay";
 };
@@ -1030,4 +1133,11 @@ mode-pins {
 			output-high;
 		};
 	};
+
+	wlan_en: wlan-en-state {
+		pins = "gpio134";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-disable;
+	};
 };
-- 
2.30.2


