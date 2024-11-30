Return-Path: <linux-kernel+bounces-426058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E22DD9DEE57
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 960DC16406A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CA51AE843;
	Sat, 30 Nov 2024 01:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jEIic/vY"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECC81ABEA3
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931137; cv=none; b=vFZldAYjLrRRa9R2ZrAvGIznO7TNHk6KERK3SsmarozXyB2DiZWEgkfvGgTSLwxOM48gFmtBP+stmveVxBBC4J9eHnoHEUhCWO5dP3raR3OPmsxfY8Rgrc+gbpENPcD3Nq9SCkRClVQrVLzd2CnoBgO4pigFtQlB65JErDTCSp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931137; c=relaxed/simple;
	bh=Nreu1u5iw3CPT/3n6jHeCOVz+ph8i8GPQOf5hBrI5+Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J16WN7kI9EnYk4NxzDkVWguLMCBTK4Nt20LcOd1E/ECG+vHjBVE6zZvZ47DrbMalLMR2rIKCgQ65e54oonJo1WPyZt8fsQZ2Eo8YgU+U6zOPiju1iwJ2l5IzSbKH6bdDxx5R1Irgs5/+sfPpwWvuS1NZuwqY4i9XFKEAtvE9IbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jEIic/vY; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-53dd668c5easo2530515e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732931134; x=1733535934; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DEgT9I0Lh/MZkMW0zZ7UbVH9eyNcxPSCmRl8RTx+uIo=;
        b=jEIic/vYBy2z+l/KJMKu3AWjFSi8xkCmHvPMOdnXlY0YRX8Mn8InURUOnUuAwIIERk
         mPGwAI652tIvEGv+4KsWWBTVoWJltAvAcWs7VyZuzwRJhw2NTRrDDDpyrI642pE5rnjg
         HduD+SG6gt4EfxpDXZOzBRJSDfayng7/ArEzhoboFBuoOKnBBbcGFNXbFvshG8AJyzF7
         qUCcu2TaKOLulaY1swwW55RXipihrwOZbxZaEk4Z71jfWAJmBGjIDTdNdYo+Ql4xCMAE
         poOtWtaQsN4LEjAFzzMsfzKcNklZ9Nn2KhWlXfMU1M1/tg1Jbi6VN7hO50e5HUz5iSdZ
         EBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931134; x=1733535934;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEgT9I0Lh/MZkMW0zZ7UbVH9eyNcxPSCmRl8RTx+uIo=;
        b=oytCL/Ux5O6I6ko67nH0z+dYv4c22kzskUzPqNvoyLUgggQFu4irn6INJilYsFHsSX
         kvQAaIGubjReCmIQ8wcKq9sv/ny6G4MRpMSlJjRgE+JgcSc8hkUq15XnNNpV65crETur
         3JcgwU58uHlHRlTm2973FMg8omDjxDnsgGtQRH+FokFwoJ204p13MFkK8XtYeS1Nqo1W
         LDfBRRV07nOOWCwz7NE3rWmOxtNnMjNaFVWN5Qz/xyWvC4pgOCIeDZd1mHn7qwIZBuO0
         UFAkM0CNlL/QHagsDxBcEKaZCUbE92S8vHm3rYkeeaT9Tlg3Ze4HgGb28wK2LRMwULmK
         EJiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzs+rxH9XXUzDvkbNQfRtV1w/OxKAES2j9g8h9+H7SNovsJu2O7KZ3QsOf+iqSTkq7Fj+6WYDJdw3DTPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6O7LMY8d/Si/ogNrfjxMlwqtIJLKzN4qIDvshk8oSoibILqg6
	lax2fFo3D6o2eNiuFwP7qHAiELiEJMZN34WrWBEJdQlguD7E9w5XFwnyq75neso=
X-Gm-Gg: ASbGncsn6eEzdouYLjIfESx2BsGPuIz7s3GoBZZL+XxXTC/GLytkN4FNbpvRGJjpHri
	8JFu5XCtaHz1A5t+wV9hSXFXIDE9rvZ8UuNthLgIuxwmWgdkifSSO4oXrrE1Jvnp1VRRcGNZQOI
	wwPYzqFTNnMiC8OMcId1bglneiKBda4Z/tYKchfFMiRYP6UtLOj3v31F4rI3CuLZWoB8OiEp7M4
	JCThTKPn5t5Snr7X0RhdYCGApgpEd4gyS0NCxSEAGZuBDlBKEMKaDUXYg==
X-Google-Smtp-Source: AGHT+IGhwe0OMSbFHHOUehMPPfWn2jTA4ABvp6/xPDYHrwK3gTIOw2weHxHElR054XOM3L9z9PdcFw==
X-Received: by 2002:a05:6512:5d2:b0:53d:f57e:eb38 with SMTP id 2adb3069b0e04-53df57eeca5mr2940556e87.25.1732931134246;
        Fri, 29 Nov 2024 17:45:34 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64a0742sm631946e87.261.2024.11.29.17.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:45:33 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Nov 2024 03:44:40 +0200
Subject: [PATCH v2 28/31] arm64: dts: qcom: sm8550: move board clocks to
 sm8550.dtsi file
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-fix-board-clocks-v2-28-b9a35858657e@linaro.org>
References: <20241130-fix-board-clocks-v2-0-b9a35858657e@linaro.org>
In-Reply-To: <20241130-fix-board-clocks-v2-0-b9a35858657e@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Leo Yan <leo.yan@linux.dev>, Joseph Gates <jgates@squareup.com>, 
 Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, 
 Stephan Gerhold <stephan@gerhold.net>, Zac Crosby <zac@squareup.com>, 
 =?utf-8?q?Bastian_K=C3=B6cher?= <git@kchr.de>, 
 Andy Gross <andy.gross@linaro.org>, Jeremy McNicoll <jeremymc@redhat.com>, 
 Rohit Agarwal <quic_rohiagar@quicinc.com>, 
 Melody Olvera <quic_molvera@quicinc.com>, 
 Bhupesh Sharma <bhupesh.sharma@linaro.org>, 
 cros-qcom-dts-watchers@chromium.org, Stephen Boyd <swboyd@chromium.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Martin Botka <martin.botka@somainline.org>, 
 Jonathan Marek <jonathan@marek.ca>, Vinod Koul <vkoul@kernel.org>, 
 Tengfei Fan <quic_tengfan@quicinc.com>, 
 Fenglin Wu <quic_fenglinw@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, 
 Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Jun Nie <jun.nie@linaro.org>, 
 James Willcox <jwillcox@squareup.com>, Max Chen <mchen@squareup.com>, 
 Vincent Knecht <vincent.knecht@mailoo.org>, Benjamin Li <benl@squareup.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5523;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Nreu1u5iw3CPT/3n6jHeCOVz+ph8i8GPQOf5hBrI5+Y=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnSm33pfZrPKRbfNTzfbxoE3XkoZqqTSBvkHhTz
 m6B89ThZYiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0pt9wAKCRCLPIo+Aiko
 1RTuB/9/fvVB6jLGXy1ipcXvp1c/GzBhPxTJ2aExfiZCJYgjPAZmpAdl1sID4fRTorI97hLJnJB
 CsNoY4JH0XP0HiRub9vGha0FfcPoBhVSpRVnH9eFv3fUqYMFU9NcFEDH4tYy5hxMnlAlm1T600C
 5GfBD/Z39PySdcNHSdBX5rFFvnOhmleY5UHYrFHaKhC2OKj7d6kNaUmDVn0WPyApSMeR2G8VzGo
 8qhqUE2ev8QW8XJJ3OVvoogIELj4rFbflnqEJieTK4JYqnhncsh4g2vXxKaGM8MRxctIogmidKu
 eZwtx1vd5S/AtCDDnXx0Rp+M8+DO37rPkxCFK5O5clWU3MsK
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

SM8550 is one of the platforms where board-level clocks (XO, sleep)
definitions are split between the SoC dtsi file and the board file.
This is not optimal, as the clocks are a part of the SoC + PMICs design.
Frequencies are common for the whole set of devices using the same SoC.
Remove the split and move frequencies to the SoC DTSI file.

Suggested-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi                | 8 --------
 arch/arm64/boot/dts/qcom/sm8550-hdk.dts                     | 8 --------
 arch/arm64/boot/dts/qcom/sm8550-mtp.dts                     | 8 --------
 arch/arm64/boot/dts/qcom/sm8550-qrd.dts                     | 8 --------
 arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts             | 8 --------
 arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts | 8 --------
 arch/arm64/boot/dts/qcom/sm8550.dtsi                        | 2 ++
 7 files changed, 2 insertions(+), 48 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi b/arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi
index e6ac529e6b7216ac4b9e10900c5ddc9a06c9011c..9f1f99f892f5f92ba0e44bd9cc3daeb2916387b2 100644
--- a/arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi
@@ -366,10 +366,6 @@ &pm8550b_eusb2_repeater {
 	vdd3-supply = <&vreg_l5b_3p1>;
 };
 
-&sleep_clk {
-	clock-frequency = <32764>;
-};
-
 &ufs_mem_hc {
 	reset-gpios = <&tlmm 210 GPIO_ACTIVE_LOW>;
 	vcc-supply = <&vreg_l17b_2p5>;
@@ -399,7 +395,3 @@ &usb_dp_qmpphy {
 	vdda-phy-supply = <&vreg_l3e_1p2>;
 	vdda-pll-supply = <&vreg_l3f_0p88>;
 };
-
-&xo_board {
-	clock-frequency = <76800000>;
-};
diff --git a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
index 29bc1ddfc7b25f203c9f3b530610e45c44ae4fb2..656c2b1facd656736495d103b7aa57708d6ad38b 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-hdk.dts
@@ -1171,10 +1171,6 @@ &sdhc_2 {
 	status = "okay";
 };
 
-&sleep_clk {
-	clock-frequency = <32764>;
-};
-
 &swr0 {
 	status = "okay";
 
@@ -1367,7 +1363,3 @@ &usb_dp_qmpphy {
 &usb_dp_qmpphy_out {
 	remote-endpoint = <&pmic_glink_ss_in>;
 };
-
-&xo_board {
-	clock-frequency = <76800000>;
-};
diff --git a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
index 5648ab60ba4c4bfaf5baa289969898277ee57cef..0e04ca10d04cefe197bc3278675809f73d61b65a 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-mtp.dts
@@ -824,10 +824,6 @@ &sdhc_2 {
 	status = "okay";
 };
 
-&sleep_clk {
-	clock-frequency = <32764>;
-};
-
 &swr0 {
 	status = "okay";
 
@@ -971,7 +967,3 @@ &usb_dp_qmpphy {
 &usb_dp_qmpphy_out {
 	remote-endpoint = <&pmic_glink_ss_in>;
 };
-
-&xo_board {
-	clock-frequency = <76800000>;
-};
diff --git a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
index 3a6cb279130489168f8d20a6e27808647debdb41..63b5f4be6fe91af799104d1384624b0a4dc592fe 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-qrd.dts
@@ -1004,10 +1004,6 @@ &remoteproc_mpss {
 	status = "okay";
 };
 
-&sleep_clk {
-	clock-frequency = <32764>;
-};
-
 &swr0 {
 	status = "okay";
 
@@ -1229,7 +1225,3 @@ &usb_dp_qmpphy {
 &usb_dp_qmpphy_out {
 	remote-endpoint = <&redriver_ss_in>;
 };
-
-&xo_board {
-	clock-frequency = <76800000>;
-};
diff --git a/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts b/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts
index e8383faac576a2f401fff74231a764712c832291..9d319a0c89be4b67ff4f2934b5526ce2ab5734cc 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-samsung-q5q.dts
@@ -564,10 +564,6 @@ &remoteproc_mpss {
 	status = "okay";
 };
 
-&sleep_clk {
-	clock-frequency = <32764>;
-};
-
 &tlmm {
 	gpio-reserved-ranges = <36 4>, <50 2>;
 };
@@ -587,7 +583,3 @@ &ufs_mem_phy {
 	vdda-pll-supply = <&vreg_l3e_1p2>;
 	status = "okay";
 };
-
-&xo_board {
-	clock-frequency = <76800000>;
-};
diff --git a/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts b/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts
index d90dc7b37c4a74cbfb03c929646fda3381413084..0e03ab2ac2eed716712833195ae56f5689a577cb 100644
--- a/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts
+++ b/arch/arm64/boot/dts/qcom/sm8550-sony-xperia-yodo-pdx234.dts
@@ -721,10 +721,6 @@ &sdhc_2 {
 	status = "okay";
 };
 
-&sleep_clk {
-	clock-frequency = <32764>;
-};
-
 &tlmm {
 	gpio-reserved-ranges = <32 8>;
 };
@@ -759,7 +755,3 @@ &usb_dp_qmpphy {
 &usb_dp_qmpphy_out {
 	remote-endpoint = <&pmic_glink_ss_in>;
 };
-
-&xo_board {
-	clock-frequency = <76800000>;
-};
diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index e7774d32fb6d2288748ecec00bf525b2b3c40fbb..e6dccb199d7fb4c4a15294c3f22eb842e4c32ce6 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -36,11 +36,13 @@ clocks {
 		xo_board: xo-board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
+			clock-frequency = <76800000>;
 		};
 
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
+			clock-frequency = <32764>;
 		};
 
 		bi_tcxo_div2: bi-tcxo-div2-clk {

-- 
2.39.5


