Return-Path: <linux-kernel+bounces-237494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3329239A6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B3E3286644
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 09:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C595815958A;
	Tue,  2 Jul 2024 09:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lwDYBVZU"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831D4158DCA
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 09:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719911823; cv=none; b=hT3HzMKls0COVCFZKbcCaeKwGKfynE8/oQu64HnKvh9QMyS57nPFe3eNRtponhqO7mbljYv+D5PX/RrJlPvCiLkgsXf67jeMRsp5lx89S2aIvzKY7nx9uusoy8Xa03XihkGMBYZWXqyfchv/i5/Glc81ILXBEUXl2qHXFfbNroA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719911823; c=relaxed/simple;
	bh=MmCHrblA17iBOZcaUxF0rlX2dqqdSVwFaRXmp9j7aFc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Hrg69XkItI3uO/YHHbNlJGYD9gWGQ3N33oC/6q/gIG6W4Cxn9kHw5P/v2/lx8sdBDbZwEbLZ2lOFjRuOk409IRvw0u5dX8J6+FtzlNOYkSnhhV84NdwjjcX5DGP5NDxn61H4Lx5zwlI8x/enUyAARof0wGCh3Y52g5GH+/kSVGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lwDYBVZU; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1f9ffd24262so22340105ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 02:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719911821; x=1720516621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=im7X66Ftq9hh3pjMAHs9Kh1cZ/MUVXZiYxPN2eGhMlI=;
        b=lwDYBVZUMwSPx6x/zZ1ajUouibWswnFRVoTUxZHN4U8dHE4CNeAClg244vwmJL2FBH
         nMzB41RlNAzfTy4+zFEEYfK7iQ2Bwnk0904sJ3BZTfPrPTAelne1lRR3PfNh6YBHm9SZ
         h5+TrhqsGdLyFlmvoai1eifV657FT+JYxyI9j0pS0pTs5eY99G527Sa+8DshV9+LREuR
         81x4JUQrM/yisvI5k0PGqyuwzESVuWKf5Sp0m8F5dVb8drCeOMFqprqTWa/mxPFwwRi2
         ilN1uxtwDyCdc3PBUixkd5Y4iXYi0JKJMmvPUzqHFsd5XzhLDkKo1JRkc9joC2CxVgdE
         BcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719911821; x=1720516621;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=im7X66Ftq9hh3pjMAHs9Kh1cZ/MUVXZiYxPN2eGhMlI=;
        b=m8fWijUmDOLehewXIqOTx+yGnaQsYcdKQvDmEz+EvB2PCYG6BsNUARzg98xbRK6GsK
         7SjwovOd4CDmjUtXpbe4/uzjClfxChNhdBy9ZE42HNlI60TX9uS37FkuBTjTBH6JvcKK
         936Y8cXD0uLyrCjljev82hzH2T7dnh0f/6GoTQ/7zF/4dD3lEdTX46oTyJpc8jpixIx/
         W5yxnN8cr4OpHrOqWmC1WzOwbStT6Q+zSD1plqH2PFrQ/9cuxTi6pHMziLGkWTE6n5z2
         EBMLSCX85zvgCRM2lT5Aw0PsncP+QlApe5rRVjzQLiFSbzp+LGlaNc/xiT9maJ63q00k
         or+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9MZc3wIlox1Up+kHlYya89R2qNRkFvjJ20Rh93Cq/owPOL1FhWZWcGcXWYjCtH8chOEiRUkjyzKUvGXpvfp4Sm2162CERXM6pKf3T
X-Gm-Message-State: AOJu0YzoN111f5h/n1kpsKRAvoCjRB7rvL2VMfM+9S1LC6kiIOPHrJTx
	aAMmwdnhqFEP56gv0moL7XyNb/+hYprMBYQ48UI3wgMFGDr0V6kpBR40aXRVHiI=
X-Google-Smtp-Source: AGHT+IFoLL5kK93Tt9eDt6tcLEBD5AjNAtjEjyQFNm7zDU8m2s47MtCFW3t9xsc30wpZf1p8ytb1hA==
X-Received: by 2002:a17:902:e841:b0:1f7:42ba:5b1e with SMTP id d9443c01a7336-1fadbc7504amr36177085ad.17.1719911820696;
        Tue, 02 Jul 2024 02:17:00 -0700 (PDT)
Received: from x-wing.lan ([106.51.163.238])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac15bd0edsm79120375ad.306.2024.07.02.02.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 02:17:00 -0700 (PDT)
From: Amit Pundir <amit.pundir@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>,
	dt <devicetree@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] arm64: dts: qcom: sm8550-hdk: add the Wifi node
Date: Tue,  2 Jul 2024 14:46:55 +0530
Message-Id: <20240702091655.278974-1-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the ath12k WLAN on-board the WCN7850 module present on the
board.

Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
Kanged verbatim from 490812872449 ("arm64: dts: qcom: sm8550-qrd: add the Wifi node").

 arch/arm64/boot/dts/qcom/sm8550-hdk.dts | 97 +++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
index 12d60a0ee095..c453d081a2df 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
@@ -279,6 +279,68 @@ platform {
 			};
 		};
 	};
+
+	wcn7850-pmu {
+		compatible = "qcom,wcn7850-pmu";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&wlan_en>, <&pmk8550_sleep_clk>;
+
+		wlan-enable-gpios = <&tlmm 80 GPIO_ACTIVE_HIGH>;
+		/*
+		 * TODO Add bt-enable-gpios once the Bluetooth driver is
+		 * converted to using the power sequencer.
+		 */
+
+		vdd-supply = <&vreg_s5g_0p85>;
+		vddio-supply = <&vreg_l15b_1p8>;
+		vddaon-supply = <&vreg_s2g_0p85>;
+		vdddig-supply = <&vreg_s4e_0p95>;
+		vddrfa1p2-supply = <&vreg_s4g_1p25>;
+		vddrfa1p8-supply = <&vreg_s6g_1p86>;
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
@@ -954,6 +1016,23 @@ &pcie0 {
 	status = "okay";
 };
 
+&pcieport0 {
+	wifi@0 {
+		compatible = "pci17cb,1107";
+		reg = <0x10000 0x0 0x0 0x0 0x0>;
+
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+		vddaon-supply = <&vreg_pmu_aon_0p59>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p8-supply = <&vreg_pmu_rfa_1p8>;
+		vddpcie0p9-supply = <&vreg_pmu_pcie_0p9>;
+		vddpcie1p8-supply = <&vreg_pmu_pcie_1p8>;
+	};
+};
+
 &pcie0_phy {
 	vdda-phy-supply = <&vreg_l1e_0p88>;
 	vdda-pll-supply = <&vreg_l3e_1p2>;
@@ -1046,6 +1125,17 @@ &pon_resin {
 	status = "okay";
 };
 
+&pmk8550_gpios {
+	pmk8550_sleep_clk: sleep-clk-state {
+		pins = "gpio3";
+		function = "func1";
+		input-disable;
+		output-enable;
+		bias-disable;
+		power-source = <0>;
+	};
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };
@@ -1206,6 +1296,13 @@ wcd_default: wcd-reset-n-active-state {
 		bias-disable;
 		output-low;
 	};
+
+	wlan_en: wlan-en-state {
+		pins = "gpio80";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-down;
+	};
 };
 
 &uart7 {
-- 
2.25.1


