Return-Path: <linux-kernel+bounces-426056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A5E9DEE51
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30063B23DE4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92511AB6C2;
	Sat, 30 Nov 2024 01:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Laew7HcZ"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1646B143871
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931132; cv=none; b=dY+Ksx1h7RU48z1RnnkngsxtrXrQQI99maAPm4nDQdnJhFCm6t11KRDJdHT9F/TUYpca9WArX+upeJvJTtSkBJmVMj4H/6NotF5kDdiqvs1T4wAFCeBUgtcYbFCQ+cG4tKH+H8Y/HPTiFOic2igxJo5KC6sgg1ilK6c8DxhgivY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931132; c=relaxed/simple;
	bh=Uy0U0ERr39hDg3O49x0h3zoYcwr/oL9Yd1/e2vOTYSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aP43skqZ9KGiGwkVI4B0ddUmuFsfnfmzfOZu9jXLz4iA8hy8OyMS+s3DX2H8CZDiYeThpTGFfBWgUPuMfeKShkjp4ivyWlH3FszDV9nWDxntXgkQ2Qr1PeRqmtvx0SkY+Hir34R+mvIednl/heHHarb6XzNfCE8gF62lSpb2xhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Laew7HcZ; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53dde4f0f23so2517867e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732931129; x=1733535929; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+c+RSzytJFjx7MIg7eaSWg+rDoxb8wPpF5exbHH8xTQ=;
        b=Laew7HcZpjdbEBEVqR25FXOxYoGuOecpOFT2mupokanPRnN5XknJBWLHGPnVEC5a2B
         pQLiab47EFwezf2ucR8bNz8qYPm7A6oNm/qk5htbNlgPP+7q4ekCINbZijAWz3NwJl7s
         mthPYTAp8pVgkoJEzVgKM9Xn3+j04RIZRidycSD6CGdySwf61K3BJu/m+jEUIOVekU+t
         sfdVKzmrwHgXQrDTvZ1Y2pi3klOjDQKpf6HmMDB5RDTO1atT8DBZ9AqR5KBOaVLuLolP
         2ZMo7yEf21xqiMlFVzji683muN3OW6IdRmQgSU5nRj3ytJ3/piMCAY5PfI0uQE8xAX24
         kU0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931129; x=1733535929;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+c+RSzytJFjx7MIg7eaSWg+rDoxb8wPpF5exbHH8xTQ=;
        b=BWjY2YhnF4HHpk0dc6dxMWPuUl47nSVHPy+WSUm7SJfcLLXb3kRjaeGEvKwho9Tfoh
         ZjaeIl/A3xmN00LG8cIjE21gMzU+v1uUgqXgHPXw9AdqqM7MZMnnYB0C+FUKL1h0xQMT
         ICDmkekkOm6kSNUdi2+JCmc1HNx0j/oxwmekCt7jBn6gUxgGQHCq1S2//lC7mYtZpyIv
         5yRAjcPGVPMpDm6F2qMKPe3D4j+f8IYTerl2xBwxoP5KZ/im44hkXFIC3BPlbA3Y6kLl
         NpHySEbhN8gVR+kl5HWRXMcyvzmuKlcq8uBv0eILG/4wqMnlpBTA5LXFNl3gluSBwQDf
         ugSg==
X-Forwarded-Encrypted: i=1; AJvYcCVWA3uCT2/P10tyRfOY4C/eZwflQZSVFSy1xgeQNgmKcefR1SVxYnXTAk4YtUBGaSxzB3qEIkqLSJSV+2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvvRfbTKIuluyKUNhFRhqTVW1v1/ooR/Nv4kBgk3pmaZvlQyHb
	tTWmlTYK4cKMmCy4W1M5zRR4lPwy51I75lVwyctcduE68gkYKGoltdyPPfjeFfI=
X-Gm-Gg: ASbGncvZMfRvTevCQ00Q6t6g+6P5K11kLE9w2K+uL4c1dKYQaO0jllnlxt+Hp8PLWgv
	cjeN5WqQZ89rJT4HnMccqF2BoRJJdX/s4RAx3d03LllRZtFpiKuyPiOGqAAVPrKlz/RIUeOJkMM
	weYFFVGC1IdCFUA51G/yOZ4s5X+Z/SBLUXx2oj2WqKR/O31wYsDmJIDjsIl4XhuNVylN1BSew8f
	wK6o8kcyyD1iKVOVITQ/dHn4xRFKPAl7kwPOh5L+fSjZ9O8khrLv+bipg==
X-Google-Smtp-Source: AGHT+IE8uRm6rHrMw7TRWbEpQREzwmtNJXmz1+qCsTtCPbR+h6nvAVNL03Sp2DPMtIyUiP1Re8AeyA==
X-Received: by 2002:a05:6512:3ba5:b0:535:82eb:21d1 with SMTP id 2adb3069b0e04-53df01178e6mr9262667e87.57.1732931129250;
        Fri, 29 Nov 2024 17:45:29 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64a0742sm631946e87.261.2024.11.29.17.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:45:28 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Nov 2024 03:44:38 +0200
Subject: [PATCH v2 26/31] arm64: dts: qcom: sm6115: move board clocks to
 sm6115.dtsi file
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-fix-board-clocks-v2-26-b9a35858657e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3935;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Uy0U0ERr39hDg3O49x0h3zoYcwr/oL9Yd1/e2vOTYSE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnSm33+KjqyOEr/xJY9QiDeHeTCec5MxeXer3v3
 /563gSdcqWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0pt9wAKCRCLPIo+Aiko
 1SHpB/9HXYBNkPzn7RniXXS5K8Hjs0qzQAZvGwSnyAEaIVO595wk5rkt8gtsNyzffh3xH/XX2vC
 fmaEx/jrdtVetRV5IGsvfcCVIG7r/5sdf/kr2vyvKC6ahlTdK9e5wVElry+xK1nWvWtNtDiksz6
 74/1NdXFLvAVzaUiNH0FkBPSMsXAbDx/m0P9FjxedLtdEb7UrY+x2lUUN+GkJNoqxAWGvC+kjL8
 5GFGQB3iEsBRhR4PmKGMEeJMerHCk2Gj4lPk8VG59Rg9rHUAiFiDhnW9AyVDeSN2ffhx2QwsuM3
 jSdV1z8WhzA4GmoPbz9DQpLR8N5iSku9fvE9Ea5NidYBLOKP
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

SM6115, SM4250 and QRB4210 have board-level clocks (XO, sleep)
definitions split between the SoC dtsi file and the board file.
This is not optimal, as the clocks are a part of the SoC + PMICs design.
Frequencies are common for the whole set of devices using the same SoC.
Remove the split and move frequencies to the SoC DTSI file.

Suggested-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts            | 8 --------
 arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts | 8 --------
 arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts     | 8 --------
 arch/arm64/boot/dts/qcom/sm6115.dtsi                | 2 ++
 arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts   | 8 --------
 5 files changed, 2 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index d8d4cff7d5abed405d1b4cdf9ab8264aab076830..675f9057ed442fb4afd22064b4022df5ed8cb882 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -544,10 +544,6 @@ can@0 {
 	};
 };
 
-&sleep_clk {
-	clock-frequency = <32764>;
-};
-
 &tlmm {
 	gpio-reserved-ranges = <43 2>, <49 1>, <54 1>,
 			       <56 3>, <61 2>, <64 1>,
@@ -695,7 +691,3 @@ &wifi {
 
 	status = "okay";
 };
-
-&xo_board {
-	clock-frequency = <19200000>;
-};
diff --git a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
index 9153a5a55ed9fe82ea6771ef87dae5620a4fbf2f..ae65dc2abe510d35f1aeeeac5ccf5c576d688734 100644
--- a/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
+++ b/arch/arm64/boot/dts/qcom/sm4250-oneplus-billie2.dts
@@ -193,10 +193,6 @@ vreg_l24a: l24 {
 	};
 };
 
-&sleep_clk {
-	clock-frequency = <32764>;
-};
-
 &sdhc_2 {
 	vmmc-supply = <&vreg_l22a>;
 	vqmmc-supply = <&vreg_l5a>;
@@ -254,7 +250,3 @@ &usb_hsphy {
 	vdda-phy-dpdm-supply = <&vreg_l15a>;
 	status = "okay";
 };
-
-&xo_board {
-	clock-frequency = <19200000>;
-};
diff --git a/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts b/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
index f60d36c03b9b51d1ba5fb2db7d619916fe42f084..5cf0d2383019abec53f875c727e86656f3ac4478 100644
--- a/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
+++ b/arch/arm64/boot/dts/qcom/sm6115-fxtec-pro1x.dts
@@ -471,10 +471,6 @@ &sdhc_2 {
 	status = "okay";
 };
 
-&sleep_clk {
-	clock-frequency = <32764>;
-};
-
 &tlmm {
 	gpio-reserved-ranges = <0 4>, <14 4>;
 
@@ -570,7 +566,3 @@ &wifi {
 
 	status = "okay";
 };
-
-&xo_board {
-	clock-frequency = <19200000>;
-};
diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 9b23534c456bde8c400cc331e847f0f84ae0b74a..29eb179ac519dd0965977902ca0edf6a06fa147b 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -28,11 +28,13 @@ clocks {
 		xo_board: xo-board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
+			clock-frequency = <19200000>;
 		};
 
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
+			clock-frequency = <32764>;
 		};
 	};
 
diff --git a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
index 9d78bb3f71901705fd22d88b472f6fc1d0c0fffb..27936023175bcb73e73a85b463c4b9f5c00541cb 100644
--- a/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
+++ b/arch/arm64/boot/dts/qcom/sm6115p-lenovo-j606f.dts
@@ -305,10 +305,6 @@ &sdhc_2 {
 	status = "okay";
 };
 
-&sleep_clk {
-	clock-frequency = <32764>;
-};
-
 &tlmm {
 	gpio-reserved-ranges = <14 4>;
 
@@ -382,7 +378,3 @@ &wifi {
 	qcom,ath10k-calibration-variant = "Lenovo_P11";
 	status = "okay";
 };
-
-&xo_board {
-	clock-frequency = <19200000>;
-};

-- 
2.39.5


