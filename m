Return-Path: <linux-kernel+bounces-371699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 637309A3ED0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED9C28673D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 12:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618911FCF5D;
	Fri, 18 Oct 2024 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="IjEQynAw"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDC41DFDB2
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 12:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729255789; cv=none; b=c9IwKN6P/T9ice2dz4duahKhEnGuOfhNvIYTQIucFPFFn5U7OITSvcHyxqkxV7/Bbq3X8Gy2QFLXiqYBZ6DpIwrq2UDYHSy0G8oPJHzJgBjiB6dSZkyTPCR/R2BFln9JJEtKq9yDDYy2DosA6KLi+RRePJkeO2ceosfJg+iJ5ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729255789; c=relaxed/simple;
	bh=Mn0mPpmbFY44Z0P2dT0RMB+Ql2YBHQB3ao9m3twFsKY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vDz/EaBBSmbJfrKRyj9y2F5LSTu/L4nGxt2PkHd4Lj+7vDoqyZHyJwXLfUe4g4+F3j+slZff+265FTd5KkIU/VVhgaeFBlsxTnJ0hjzpLHdrV2431N/FhdG1juF0DgVHVulmL6P2KSTudGrI30eK+4M3kQ+mT3kLKdh5/eAJqL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=IjEQynAw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315eeb2601so16570835e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 05:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729255785; x=1729860585; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=puU3xrkTTeTbfF4fDr7QGtlbG9wfai2YC1VsHMJgxP4=;
        b=IjEQynAwmH6c1YeLWQ+CUcTnMioslDeV7juZzxLu30mLd3B4gJGlpxeLsz5aTrrEV7
         9mHKl9/sK8B9aZ8Y8bpjxNu2U4LySesKmC2M8750D69f4teElDGUk0tVZe9Jahib/gzA
         JFIAt0n36RVDLHTjy12sjIMErfqWKmb3d8OZquW6C8zW+/agNE2D2iE5zftPyuBHn/XP
         4dHoXp+OeL9PXuYE7CMD1YjmGB80VnrSrkld1BDWmY/2twthkRtrROMfhOm0BvFmG3HQ
         ezCeHgSoFeop/zRGIyKCeG+XjK3OMqY5Sa4TIOGZLytbsXhTUu+eD9/2PcPJw/MHsjwI
         4eJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729255785; x=1729860585;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puU3xrkTTeTbfF4fDr7QGtlbG9wfai2YC1VsHMJgxP4=;
        b=GWMc6+zFJSm9YfjfIhqf7Ao1z2OXi0tuN3mYWMEdsUoOZHvbiPHAZqJCIyta47WlSV
         GDHKegLCqeDUl2qGZjx5fcapRZJb644xMVx4txp+LrPNTErHLy7yLFiebirvWChNf4ca
         lWrxPbG5kmStME/AGhNYynXq5tFGJXwzZnqRnt77Rm6dQ+J1Cq3bMX10My8Nf8m/X8V4
         +FC6OmcqbLZHv8+JBFCkK0iJ3CJ2GwT01UYZ+VeQgnG2oOlziOvI0X6jup3gWI60/7FQ
         7wwWh98fNLFdWw6MSC6N/P+QP3pvqvWqZXburT0pzQm8rPxbDVWgnLxp4ql/eXy0NcnP
         VgZg==
X-Forwarded-Encrypted: i=1; AJvYcCU6E4QQ+Q6sqIeFUv3tbR62NIh2OF8AZueKZzSyxXHEPJ7okZdHQF5Z94W/JBQi4v2CNe0uhmCYq1f5vwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzofuUxT0ih8mqfRZYNsGPlggggsP/nf5jDx5PQRxlm3ugDTj0b
	VuChSDslgaU1zw+wVDfhw+IppazTd7apBVwVdm7Zpx/219Q9Y8eJIoPyY+BmV8I=
X-Google-Smtp-Source: AGHT+IEGATYWTKXNH6YAve//PNdziwpNAYmjhrBS40gfiqxO+ONe+vKCaXB1kH27WO6F4kgHc1nBjQ==
X-Received: by 2002:a05:600c:1c94:b0:431:5f8c:ccb9 with SMTP id 5b1f17b1804b1-4316163c333mr23809175e9.17.1729255784130;
        Fri, 18 Oct 2024 05:49:44 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:45a3:93e:5196:d8ce])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43160695d8fsm26640835e9.27.2024.10.18.05.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 05:49:43 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 18 Oct 2024 14:49:15 +0200
Subject: [PATCH v6 5/6] arm64: dts: qcom: sc8280xp-x13s: model the PMU of
 the on-board wcn6855
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-sc8280xp-pwrseq-v6-5-8da8310d9564@linaro.org>
References: <20241018-sc8280xp-pwrseq-v6-0-8da8310d9564@linaro.org>
In-Reply-To: <20241018-sc8280xp-pwrseq-v6-0-8da8310d9564@linaro.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Johan Hovold <johan+linaro@kernel.org>, Kalle Valo <kvalo@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Steev Klimaszewski <steev@kali.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4620;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=VorITfXsqBi0NtY1PaIp2H2H5IW9YOuVROCxugaGrMg=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBnEllgx+72Im4cPUTbWEDEvC4JqzP7pr7yc/98X
 G0xvVyL/aSJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZxJZYAAKCRARpy6gFHHX
 cuY0EACC5MCJbW16PRuawEC9C2LqGVUDMnPQFTjDLxk3TSoCgTWlfOBCoHrwF7VdKEaAOzlFgq0
 1cSaxe2Hylt8qaVME4EPC7VP9xBvu0jnyknp++1cSK2uOb6phU9FQ7XUb4qprEWgK+dqxsDekO4
 E325JkvYuzreI+qZ+v0g5NZEuo72bFyEfUY770kww1SP1xKENtzwqRVtKUxpnES09gVUV2+S6Oo
 9IdILGuJ0EaweEcDxbrgipFghSDMlAu08yKcOYerfkTgAPgHm9HpauzqnhPNYVk6Mt2yqs1Sqjb
 1WtLvbGCGrmsIZWfy8d0VwOgVzgOuxOO6rNfH3hGKCfxkNxk1+EpylhybPbdE8sBuKLi5FpFVT4
 BLOqNKNxsEdwY0xXbLvZV6MWqp08yPnNHzl4q8JfKrphPev03okjqoz/furEyQMVcVNV56tMuSa
 j1QqG865r7CLzHXyH46Nd0hdCSbJpUHT+RTCd8YHADI98Dl7osU0sn3u7T8qSX+kO3U5qQLQOn8
 aI8EDwAh1j5FRvKyoLu784sTUr/1ReZcB9EesPkS1lZhWm+RXVb/HIYzwy5MByXMkF/ZGUahPRm
 SMQzmkPoifFGThTL6kC+NfLVGYYY1n/k72JNlQcumsjStb5qZg1tcfxljC1z7cNFBU+wiTjrZ6t
 JkGyl5QqpkOYQeA==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a node for the PMU of the WCN6855 and rework the inputs of the wifi
and bluetooth nodes to consume the PMU's outputs.

With this we can drop the regulator-always-on properties from vreg_s11b
and vreg_s12b as they will now be enabled by the power sequencing
driver.

Tested-by: Steev Klimaszewski <steev@kali.org> # Thinkpad X13s
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts     | 103 ++++++++++++++++++---
 1 file changed, 89 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index 6a28cab97189..ce1898c085de 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -400,6 +400,70 @@ usb1_sbu_mux: endpoint {
 			};
 		};
 	};
+
+	wcn6855-pmu {
+		compatible = "qcom,wcn6855-pmu";
+
+		pinctrl-0 = <&bt_default>, <&wlan_en>;
+		pinctrl-names = "default";
+
+		wlan-enable-gpios = <&tlmm 134 GPIO_ACTIVE_HIGH>;
+		bt-enable-gpios = <&tlmm 133 GPIO_ACTIVE_HIGH>;
+		swctrl-gpios = <&tlmm 132 GPIO_ACTIVE_HIGH>;
+
+		vddio-supply = <&vreg_s10b>;
+		vddaon-supply = <&vreg_s12b>;
+		vddpmu-supply = <&vreg_s12b>;
+		vddpmumx-supply = <&vreg_s12b>;
+		vddpmucx-supply = <&vreg_s12b>;
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
@@ -426,7 +490,6 @@ vreg_s11b: smps11 {
 			regulator-min-microvolt = <1272000>;
 			regulator-max-microvolt = <1272000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-always-on;
 		};
 
 		vreg_s12b: smps12 {
@@ -434,7 +497,6 @@ vreg_s12b: smps12 {
 			regulator-min-microvolt = <984000>;
 			regulator-max-microvolt = <984000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
-			regulator-always-on;
 		};
 
 		vreg_l1b: ldo1 {
@@ -927,6 +989,16 @@ wifi@0 {
 		compatible = "pci17cb,1103";
 		reg = <0x10000 0x0 0x0 0x0 0x0>;
 
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
 		qcom,ath11k-calibration-variant = "LE_X13S";
 	};
 };
@@ -1258,20 +1330,16 @@ &uart2 {
 	bluetooth {
 		compatible = "qcom,wcn6855-bt";
 
-		vddio-supply = <&vreg_s10b>;
-		vddbtcxmx-supply = <&vreg_s12b>;
-		vddrfacmn-supply = <&vreg_s12b>;
-		vddrfa0p8-supply = <&vreg_s12b>;
-		vddrfa1p2-supply = <&vreg_s11b>;
-		vddrfa1p7-supply = <&vreg_s1c>;
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn_0p8>;
+		vddaon-supply = <&vreg_pmu_aon_0p8>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p8>;
+		vddbtcmx-supply = <&vreg_pmu_btcmx_0p8>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p8-supply = <&vreg_pmu_rfa_1p7>;
 
 		max-speed = <3200000>;
-
-		enable-gpios = <&tlmm 133 GPIO_ACTIVE_HIGH>;
-		swctrl-gpios = <&tlmm 132 GPIO_ACTIVE_HIGH>;
-
-		pinctrl-0 = <&bt_default>;
-		pinctrl-names = "default";
 	};
 };
 
@@ -1761,4 +1829,11 @@ reset-pins {
 			bias-disable;
 		};
 	};
+
+	wlan_en: wlan-en-state {
+		pins = "gpio134";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-down;
+	};
 };

-- 
2.43.0


