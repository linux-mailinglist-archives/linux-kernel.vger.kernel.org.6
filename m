Return-Path: <linux-kernel+bounces-285385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0609950CD7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D39471C2326F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CDE1A7050;
	Tue, 13 Aug 2024 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="kbIp/Q4C"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4861C19EEA2
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 19:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723576010; cv=none; b=Y+FSgyh+rM7oRV/K7UogCNUxKV5cTSJ1CTnBu+klpkDzPjeWr+D7yiIaFO8brjuQ7n/c/V66WfNloCJdQ2rT4Fq+LjxuDS31RFUG9x9WG7mpPQLX5rUFs+6+l4s1XByPwtZ2ubctcXSfrUH4Vi249ix066Dyxy10SjzadnoDOXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723576010; c=relaxed/simple;
	bh=mewBQ5RDEqagsjt2lG11t5eBkvDcRWf9y6E9yAMbPVU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBwnU0i24aC068dcAZKa6pUye4Y3zTsWCXCJsCo++sH56tuHjl4Zrz85FGip9/t2f1M9wrvYHR1UgkR1oNiS7qb8taLbHcnoph9FOjsri04+uiKaQQpQLhlRsQjFmKLAZmEZGmL3J4xIAakR5/3RlGfvZBuf6OmErmyrbr/xl4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=kbIp/Q4C; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3684407b2deso3166893f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 12:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1723576006; x=1724180806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n6dRMYYGkFEzUx72BoTFKhbidKTOX5RlSihSxNf84YA=;
        b=kbIp/Q4CkdlRxCDAVbDYaYuGgzQyM0ZAfQICLvGoFVVB2h21jiZaIYmFNvci8+FGrt
         xT/mJ0FHtcCxazEGxVjoiNib63r4paG6pxny6rXyeal7BrXQGDu4pUSeGiSQYifPrinp
         QftJu2Qh4mkUqzpn6SKpPxgCTuc9ecgEgk9xLlLJrXGHHPWPQkYfr6LyL+E35bT35+Qt
         RYU1oNB4nyxn5IbpmK1CvyKUESlSDGFSXaAwuiyUoQr69lgGKB1mgHOqv3KNzZlGHpfy
         ZPlDm6v9R0WQwEoFpmVlIAAtwN1Wka7mBorsgQH3k8ChEWe73jzROEYNeuLo9FFS+6vw
         T8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723576006; x=1724180806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n6dRMYYGkFEzUx72BoTFKhbidKTOX5RlSihSxNf84YA=;
        b=YmbmzugREBxttLIPdA9iFBeS/TBrkW+QuGwPKg71BVEcMhuRaccCW3GcPkm7huf4oA
         XE6o2fS1OVC4HFO6KSs7Px/OZN2JB5PZKsVv3hmXGpzZsRtrLD9XLJqnetebaCmKpari
         fMKSjNNwvoS6E/Xd/qhM1myAHTHlNY0Hqf8yYp+7jO7tHTPIF73xT5yWb0sahVEdFeKP
         muh7+UYJKjTdOAH2GP7vS8RsOfqz7ZgrZTkugPpcRIpWe1JAlsmU6F6fzCJQpjUMzZcp
         wsDuNwTKdbrKgGd7qJMnSE6iuUqjdhY31/YUvgEJWI0ZjNsvf+0sm9LXVh1/fqVPUvXs
         fEWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgMCbBc28CD64xlBbfsGImrqH7mO/JrGfOk2y+8taOz06ehVPTVELgn2u/sa/sVHhGDKmW6a4hm6FQdQu+aQ9JhXPgrJDsAyc0ICTZ
X-Gm-Message-State: AOJu0YzJnEE+mjIoegSCXyUvEZG04lY/0dkxdU0KeplilYD7QXZ5KHZc
	vE6dgYtDJ5pcBPRUGWJpPnYj5qBBlbDCn39bwMgykl6z1ma1xQc6+4x9w/zK68E=
X-Google-Smtp-Source: AGHT+IFejtSRG7RRYnL4z08S2L4gmVa7Wl15o0oikoQMwLR03rR1aGa7hSVmm9y3rCvkWjbUNssYwA==
X-Received: by 2002:a5d:5228:0:b0:368:460b:4f8e with SMTP id ffacd0b85a97d-3717775cd8dmr453393f8f.13.1723576005407;
        Tue, 13 Aug 2024 12:06:45 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:3979:ff54:1b42:968a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c93708asm11119358f8f.29.2024.08.13.12.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 12:06:45 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/3] arm64: dts: qcom: sc8280xp-crd: enable wifi
Date: Tue, 13 Aug 2024 21:06:36 +0200
Message-ID: <20240813190639.154983-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240813190639.154983-1-brgl@bgdev.pl>
References: <20240813190639.154983-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konrad Dybcio <konradybcio@kernel.org>

Add nodes for the WCN6855 PMU, the WLAN module and relevant regulators
and pin functions to enable wifi support on sc8280xp-crd.

Signed-off-by: Konrad Dybcio <konradybcio@kernel.org>
[Bartosz:
  - write the commit message,
  - rebase Konrad's commit,
  - fix one of the supplies' name]
Co-developed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts | 112 ++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index 6020582b0a59..57efeefbc89e 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -177,6 +177,17 @@ vreg_misc_3p3: regulator-misc-3p3 {
 		regulator-always-on;
 	};
 
+	vreg_s10b: regulator-s10b {
+		compatible = "regulator-fixed";
+
+		regulator-name = "VREG_S10B";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
 	vreg_wlan: regulator-wlan {
 		compatible = "regulator-fixed";
 
@@ -260,6 +271,67 @@ usb1_sbu_mux: endpoint {
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
+		bt-enable-gpios = <&tlmm 133 GPIO_ACTIVE_HIGH>;
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
@@ -276,6 +348,13 @@ vreg_s11b: smps11 {
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
@@ -304,6 +383,13 @@ regulators-1 {
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
@@ -583,6 +669,25 @@ &pcie4_phy {
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
+		qcom,ath11k-calibration-variant = "LE_X13S";
+	};
+};
+
 &pmc8280c_lpg {
 	status = "okay";
 };
@@ -829,6 +934,13 @@ reset-pins {
 		};
 	};
 
+	wlan_en: wlan-en-state {
+		pins = "gpio134";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-down;
+	};
+
 	nvme_reg_en: nvme-reg-en-state {
 		pins = "gpio135";
 		function = "gpio";
-- 
2.43.0


