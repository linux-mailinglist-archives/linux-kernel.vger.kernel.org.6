Return-Path: <linux-kernel+bounces-176752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3028C346C
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2024 00:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34A9A1F21555
	for <lists+linux-kernel@lfdr.de>; Sat, 11 May 2024 22:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739F957CA2;
	Sat, 11 May 2024 22:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wuAbluKb"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5DF4DA13
	for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 22:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715465057; cv=none; b=Hi3an80gGneePh/Ir9alFqv7ggoGRpr4G85NH+1XINI7KMmeduL6WIVeje4ifo7ahWNVfhknVLNyqxR3UT+ulHiGLDXvPCzaTFCyLSHFvwlk+OJDQdWg9lNqx/6GBwvOVfKnliR99crQCLkW0DVyPAry81EIykBXG5cuhjA75I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715465057; c=relaxed/simple;
	bh=S9N9mh3qsGiXOgKkwEQkt0VVAuKxPDthH/EXJb68S6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LS82/+SIfO0EYzUa8iaPDbOEJ12Q7l0ecjqavWhrNh8UeV726QVpEg4dADP0g7HiB/hWUEBeaHV9cngc+i+rEjNNCMFKw6JkSzH9DiR3C59LrlQId3yJEwG8it0Yk4c2oWZsS24WF0UaNo2mhTkuO+aTnyJLPJn0DKKF2rC1P6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wuAbluKb; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51f12ccff5eso4267177e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 11 May 2024 15:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715465054; x=1716069854; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbD/JPruWfUyc0C7/fo3jIUkImhzSKlbr6u9GWuBcDs=;
        b=wuAbluKb+0E/t8y3ZFkraWx7/HlVkmqng8C+Y6/ED8ZVlOO7v+uGY8eSB4ywRSP6lr
         d/Ymh1m9RYgR7nYKHAmrGCMZhB09k7ljXG0ZwA7gcsdombzVLzYnnBEAKFe8ksETfoi8
         Tn9sjSis/VaktfO9pArnx8XhTHAXZoxYJntP151tuTd+fB0MAU9UGciv1f1kYH7R8PWj
         WGpAtc9niGDU6DxQQEBqEAdLYXFQPlC8od3skZnuH9z3R1UbvExJ808QeCZnCoDiWtcc
         tcQVCtkqhjcy+2k2FFVwmoMKtEjV5Wkoa+8/y+FdBetX6kzTxiTkcePnT+wu3cO0oJZP
         w4wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715465054; x=1716069854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UbD/JPruWfUyc0C7/fo3jIUkImhzSKlbr6u9GWuBcDs=;
        b=wtvhDZTdTP0dhMosb5nxq3Wf7i5upGkvRHMVG1kpi7wZWVJtp+m66AWjdjZ1wZROTk
         BgrKIrrXw2qT0s8sGe1X3evK3cTTTugZAgQmLiKNFn3LFx/7I+9OgPC/R9FG80+YWsnQ
         /e4QYUPxDvpByW7X7KV2mv6LdqWESUqro2I2IA/zFHD1pUJ0dEualzYjK8nsRSHMej9z
         jENhSS9lsj04cL6hc6N469c3wDFqUh26nb7/yKYL6EuljQgqtfcW0zPciinWk48Gj0io
         TwYD93CV+e/hDlvTMBLqbWraYrmn/gpEu5JnAE0DoPuKoDaxqCSuC8IEtyb3nJi2M6jS
         qy/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPHDM3lVCZVzyAaPTu6m1pddhzkWVrxl7WE7/yCHbNjTcIPfSSRC+ic1ySyD+of9bKxds+WX6Aqw/D6v4L7Fi7HwwPA/r3K/9PpcNa
X-Gm-Message-State: AOJu0YzFpp2iIDILBlbNH4YtL1tj+iU8NOos8eXepfrEZX4QudIjoopa
	/TxlALDLvchmpDM1TPjzVO9sHRsUnPQDnnc7FBrRjcMjhGdHF9yxSdjmyprGU8s=
X-Google-Smtp-Source: AGHT+IEOAOTRyLvRdUaXnyjs8VsQp5GfeiQD5oaImMWatWhTh0cR7XYwwPtBmyUhGGa16PLUtQ0TZA==
X-Received: by 2002:ac2:4d06:0:b0:51d:1239:21e8 with SMTP id 2adb3069b0e04-5221017e0a8mr3794707e87.37.1715465053897;
        Sat, 11 May 2024 15:04:13 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d878fsm1123875e87.206.2024.05.11.15.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 May 2024 15:04:13 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 12 May 2024 01:04:12 +0300
Subject: [PATCH v4 6/9] arm64: dts: qcom: sc8180x: describe USB signals
 properly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240512-typec-fix-sm8250-v4-6-ad153c747a97@linaro.org>
References: <20240512-typec-fix-sm8250-v4-0-ad153c747a97@linaro.org>
In-Reply-To: <20240512-typec-fix-sm8250-v4-0-ad153c747a97@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5234;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=S9N9mh3qsGiXOgKkwEQkt0VVAuKxPDthH/EXJb68S6I=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmP+tYH+Bj46Zpzic2moUVpeMPRBQeGf2/cn1fJ
 c3QOIzrTWCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZj/rWAAKCRCLPIo+Aiko
 1ejtB/9peY6QCFOlRJJSXC/YuLjsVa1M90VEvcwV5EDLTC36UMRB++PEKw7cdYfdGuFfR9VNhy3
 K/hl3W+Y64qyhzY2rsQPtbUf7NVZaKVkt/pCe/Ao/PPlVm4EfMYxnW07BFkj33co+RSZ2UXrul5
 fYvwTpBSwUSKOhfAeyrDCWhzbqFxLUZ6IQfSq2BAJwmmhwFaQkZYhAokoqdSli4pAzsJRmG+078
 5yTeJ+zXESPxUX84PDr2ZWaU8qwu3J3mZGp4oZ/km3d0s0xQLPilA66d4JdZW6kO5UAfEX2vtfr
 jnIV8lhkxqIBq9bz1bc503wRv/6xWbCqB3miRsipG77qTjH9
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Follow example of other platforms. Rename HS graph nodes to contain
'dwc3_hs' and link SS lanes from DWC3 controllers to QMP PHYs.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts | 16 ++++----
 arch/arm64/boot/dts/qcom/sc8180x-primus.dts        | 20 +++++-----
 arch/arm64/boot/dts/qcom/sc8180x.dtsi              | 46 +++++++++++++++++++---
 3 files changed, 58 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
index 6af99116c715..5b226577f9d8 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
+++ b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
@@ -68,7 +68,7 @@ port@0 {
 					reg = <0>;
 
 					pmic_glink_con0_hs: endpoint {
-						remote-endpoint = <&usb_prim_role_switch>;
+						remote-endpoint = <&usb_prim_dwc3_hs>;
 					};
 				};
 
@@ -103,7 +103,7 @@ port@0 {
 					reg = <0>;
 
 					pmic_glink_con1_hs: endpoint {
-						remote-endpoint = <&usb_sec_role_switch>;
+						remote-endpoint = <&usb_sec_dwc3_hs>;
 					};
 				};
 
@@ -582,6 +582,10 @@ &usb_prim_dwc3 {
 	dr_mode = "host";
 };
 
+&usb_prim_dwc3_hs {
+	remote-endpoint = <&pmic_glink_con0_hs>;
+};
+
 &usb_prim_qmpphy_dp_in {
 	remote-endpoint = <&mdss_dp0_out>;
 };
@@ -590,8 +594,8 @@ &usb_prim_qmpphy_out {
 	remote-endpoint = <&pmic_glink_con0_ss>;
 };
 
-&usb_prim_role_switch {
-	remote-endpoint = <&pmic_glink_con0_hs>;
+&usb_sec_dwc3_hs {
+	remote-endpoint = <&pmic_glink_con1_hs>;
 };
 
 &usb_sec_hsphy {
@@ -619,10 +623,6 @@ &usb_sec_qmpphy_out {
 	remote-endpoint = <&pmic_glink_con1_ss>;
 };
 
-&usb_sec_role_switch {
-	remote-endpoint = <&pmic_glink_con1_hs>;
-};
-
 &usb_sec {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
index bfee60c93ccc..65d923497a05 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
+++ b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
@@ -71,7 +71,7 @@ port@0 {
 					reg = <0>;
 
 					pmic_glink_con0_hs: endpoint {
-						remote-endpoint = <&usb_prim_role_switch>;
+						remote-endpoint = <&usb_prim_dwc3_hs>;
 					};
 				};
 
@@ -106,7 +106,7 @@ port@0 {
 					reg = <0>;
 
 					pmic_glink_con1_hs: endpoint {
-						remote-endpoint = <&usb_sec_role_switch>;
+						remote-endpoint = <&usb_sec_dwc3_hs>;
 					};
 				};
 
@@ -648,6 +648,10 @@ &usb_prim_dwc3 {
 	dr_mode = "host";
 };
 
+&usb_prim_dwc3_hs {
+	remote-endpoint = <&pmic_glink_con0_hs>;
+};
+
 &usb_prim_qmpphy_dp_in {
 	remote-endpoint = <&mdss_dp0_out>;
 };
@@ -656,10 +660,6 @@ &usb_prim_qmpphy_out {
 	remote-endpoint = <&pmic_glink_con0_ss>;
 };
 
-&usb_prim_role_switch {
-	remote-endpoint = <&pmic_glink_con0_hs>;
-};
-
 &usb_sec_hsphy {
 	vdda-pll-supply = <&vreg_l5e_0p88>;
 	vdda18-supply = <&vreg_l12a_1p8>;
@@ -685,10 +685,6 @@ &usb_sec_qmpphy_out {
 	remote-endpoint = <&pmic_glink_con1_ss>;
 };
 
-&usb_sec_role_switch {
-	remote-endpoint = <&pmic_glink_con1_hs>;
-};
-
 &usb_sec {
 	status = "okay";
 };
@@ -697,6 +693,10 @@ &usb_sec_dwc3 {
 	dr_mode = "host";
 };
 
+&usb_sec_dwc3_hs {
+	remote-endpoint = <&pmic_glink_con1_hs>;
+};
+
 &wifi {
 	memory-region = <&wlan_mem>;
 
diff --git a/arch/arm64/boot/dts/qcom/sc8180x.dtsi b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
index 897c0f51a612..2d2cbbff4e13 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8180x.dtsi
@@ -2547,7 +2547,9 @@ port@0 {
 				port@1 {
 					reg = <1>;
 
-					usb_prim_qmpphy_usb_ss_in: endpoint {};
+					usb_prim_qmpphy_usb_ss_in: endpoint {
+						remote-endpoint = <&usb_prim_dwc3_ss>;
+					};
 				};
 
 				port@2 {
@@ -2592,7 +2594,9 @@ port@0 {
 				port@1 {
 					reg = <1>;
 
-					usb_sec_qmpphy_usb_ss_in: endpoint {};
+					usb_sec_qmpphy_usb_ss_in: endpoint {
+						remote-endpoint = <&usb_sec_dwc3_ss>;
+					};
 				};
 
 				port@2 {
@@ -2672,8 +2676,23 @@ usb_prim_dwc3: usb@a600000 {
 				phys = <&usb_prim_hsphy>, <&usb_prim_qmpphy QMP_USB43DP_USB3_PHY>;
 				phy-names = "usb2-phy", "usb3-phy";
 
-				port {
-					usb_prim_role_switch: endpoint {
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						usb_prim_dwc3_hs: endpoint {
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						usb_prim_dwc3_ss: endpoint {
+							remote-endpoint = <&usb_prim_qmpphy_usb_ss_in>;
+						};
 					};
 				};
 			};
@@ -2729,8 +2748,23 @@ usb_sec_dwc3: usb@a800000 {
 				phys = <&usb_sec_hsphy>, <&usb_sec_qmpphy QMP_USB43DP_USB3_PHY>;
 				phy-names = "usb2-phy", "usb3-phy";
 
-				port {
-					usb_sec_role_switch: endpoint {
+				ports {
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					port@0 {
+						reg = <0>;
+
+						usb_sec_dwc3_hs: endpoint {
+						};
+					};
+
+					port@1 {
+						reg = <1>;
+
+						usb_sec_dwc3_ss: endpoint {
+							remote-endpoint = <&usb_sec_qmpphy_usb_ss_in>;
+						};
 					};
 				};
 			};

-- 
2.39.2


