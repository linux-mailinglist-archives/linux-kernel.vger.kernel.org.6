Return-Path: <linux-kernel+bounces-426055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 171739DEE4E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAD75281552
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A9D1AAE31;
	Sat, 30 Nov 2024 01:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eA7mt30U"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DF51AA1F8
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931130; cv=none; b=OyKhlE5ouNnNVrjVO4x/N+MI7mylnxBfjgMv+e5Ctc+P48M8Lh75hTJE4mPq+n8DhFNCa3hXFpbdxZfkwlqxaneQt2g8bgZYw44wfV0WqtndNgU+LxCr2BdWI/X3ajA4JjXzqoF8oPSjGD0m75PijjT5qjKrdMLsiVsv9qe4LlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931130; c=relaxed/simple;
	bh=JjPpXCp+YkT/eXiY1YYIwN7gXkPlXjyGgVYw6L4BL40=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K55N+ydijhXFZo5gIKTMACCdsc5BhhsztjbHhubK9ZyQ0atO1/BfciSNEOU5/gN3iGgYGrfBRYAI6t3ntl0upu45Jla9Xa4hi1DBKzjazZoFG2NIOLSyIZf8IzRh47cdoSJefJQrztCN+KC9tOqoK+4U/f/A3QpFq3rwqk7JxPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eA7mt30U; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53dd59a2bc1so2805568e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732931127; x=1733535927; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g4DhC3X/gaoKikUDQE86mzH2vJHzM9VbOVLew/6Upq8=;
        b=eA7mt30UVzReZzkkBctVJQF/iSNXOWN9OIRWp7d6b8R6lJLkQkFgKMuhPvHRjyPrtN
         yDJcMLUQs0Ofz+cRdpdPNgvP/n10aQLNfZsPuVoB3A76KeDIECc/lZpQ/38E+ks20bkf
         mVfGWcR69HV8tmWBdXqX9avQyztPbq2j2NlhxabqdNcjyPibVyVK+3ydos7DbYtcmuib
         MxLXDdp2oVWteuRxNTgIPA9xdlstgOd7wyGAXPAGe0tEZl9hnKmj60Brn6e5pBWTywXX
         cWZfWzfHeW+UEVdc2jWoCsNeHmw2z0BtYiNyQVRK4csVNj88lzj3P0g30SfBeCh7FT9t
         f0Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931127; x=1733535927;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4DhC3X/gaoKikUDQE86mzH2vJHzM9VbOVLew/6Upq8=;
        b=I+nq7wYXs33PRSz+vMbvMhGo8dl1FJeRhq46JFap3N2clzR3KOZD7lHHIa48+h3lha
         UKMuEfAe5E1esJUTzNpyDL4E0HOiIQIqta3HWkymx5O5n2VlB8cbWkE27a7FYXj9SrAr
         qN/hkry5Ro5Ohjg+srOVgFmXosb1mj2VYFG4QkaBgrcUkYGirVFYP53X3XTGji9cGiCw
         KKazDpvtIZJNddrD3gzQWzlmlFDb9Xrkq1yqX73+QTudD71oniTnolweEZMbz37YvQFx
         YQ5xGCaYacDUP4DEHp1cwoW0YOZD9+0c3+1NkKcZNhLZgJKHx42RM0b5CvaPKx06Br4v
         Pgrg==
X-Forwarded-Encrypted: i=1; AJvYcCW5cwxJnC+1119FdLCzS9Arqemg2BBllE67wY05e6OGXRJpddghk12vOdn3bSc9k/CAYlXDAEOu09+tgqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm2dU5bsXVlAa6W3JEP0feIoqZnr2oGmH6tLY4rDUgDaS9VcnW
	rWFHoUrqHTKDs3JHGJdcMNHLcCNKW20jsRdYXPTqUaqRe2QIoaNYyzY+SPjia8E=
X-Gm-Gg: ASbGncslH6Mzq+zW8Ar7vPVZGsizFVvXrpbjkf+bw7EmGQlDKs04lV9eN+9POesprrE
	8aJz2BBGN5yGJ1e1yaKCbMgw1MGMJOhYZlQo4VloSJgus1afXNPNYb7rs2d4fvgQXIMGKHAGY8B
	KFkTFJEh7b2aNJ7a44imDUlmxl2ruFXxkh24nVFMJsv1VKf+Cyuow1+OCsZBMp6290TGD/fDw9V
	gma+sXLBDFR2wTH14ja15qur/uD7Qz4QAquD+25Pf2/rBx6NvVGPiytFA==
X-Google-Smtp-Source: AGHT+IGB+9h29MUOUDhTnmaew4NYiuYWPs0bipcZTTDtdtgzkoVEWLqWDkZP+Ni6xLj44x3hr4T/Cg==
X-Received: by 2002:a05:6512:b1c:b0:53d:d19f:1c7e with SMTP id 2adb3069b0e04-53df010ea53mr9076858e87.51.1732931126658;
        Fri, 29 Nov 2024 17:45:26 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64a0742sm631946e87.261.2024.11.29.17.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:45:25 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Nov 2024 03:44:37 +0200
Subject: [PATCH v2 25/31] arm64: dts: qcom: sc8280xp: move board clocks to
 sc8280xp.dtsi file
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-fix-board-clocks-v2-25-b9a35858657e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3869;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=JjPpXCp+YkT/eXiY1YYIwN7gXkPlXjyGgVYw6L4BL40=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnSm32JloeBcaHMD8trR1qmOsBaxUwdHmP74ZvY
 kJFzPnM5DqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0pt9gAKCRCLPIo+Aiko
 1WTOB/45i3FcA/MSkn4F8pspIU946puZFdxeMttvqaZOPviCYKTQz9KgKvXTNEz83GvSGH4p2WL
 EDaq7YnwoMZeXJsKw/5cVeklyKHSsIDSY9JkdaS8PeVtJxx6hRqJHpdOwxmC3s9JWr/CxwWRgMH
 /sUiA1iB3khayI1tBOoaP30W8O/d5HmLHrBsH7ah/dUlxttxaPvSszeQhtRwCIB3BF1l1setmYN
 EhBfHvhmsXjXJRLQ3rHmXlvVZ5nqPeOVfcimDXyz+2HaY9sdD2X2+EnsSwRDzfZppHrSOq2Tur3
 +C/hlPl/mBrvqLDMx8X0fF6fntbYtD+lXKUU5KYs3KbPNMQA
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

SC8280XP, SA8540P and SA8295P have main XO clock definition split
between the SoC dtsi file and the board file.
This is not optimal, as the clocks are a part of the SoC + PMICs design.
Frequencies are common for the whole set of devices using the same SoC.
Remove the split and move frequencies to the SoC DTSI file.

Suggested-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8295p-adp.dts                   | 4 ----
 arch/arm64/boot/dts/qcom/sa8540p-ride.dts                  | 4 ----
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts                  | 4 ----
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts | 4 ----
 arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts     | 4 ----
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi                     | 1 +
 6 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
index 2fd1dafe63ce7a4f409d19946b9f10ffe324fba3..c536df2acc66276a0bf4e3b2640ee204109867f7 100644
--- a/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
+++ b/arch/arm64/boot/dts/qcom/sa8295p-adp.dts
@@ -728,10 +728,6 @@ &usb_2_qmpphy1 {
 	status = "okay";
 };
 
-&xo_board_clk {
-	clock-frequency = <38400000>;
-};
-
 /* PINCTRL */
 
 &pmm8540a_gpios {
diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
index 177b9dad6ff703467ea4d10e0f5a651d11569275..64c35a72a828c128f9dbe9e3537a3f777d21713b 100644
--- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
@@ -503,10 +503,6 @@ &usb_2_qmpphy0 {
 	status = "okay";
 };
 
-&xo_board_clk {
-	clock-frequency = <38400000>;
-};
-
 /* PINCTRL */
 
 &tlmm {
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
index 75adaa19d1c3e0c8fcad40c7d0b0afb504331d75..61ae4d0a9e7d10387a8331fbc22d5f88edaa9c23 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-crd.dts
@@ -868,10 +868,6 @@ &usb_1_qmpphy_out {
 	remote-endpoint = <&pmic_glink_con1_ss>;
 };
 
-&xo_board_clk {
-	clock-frequency = <38400000>;
-};
-
 /* PINCTRL - additions to nodes defined in sc8280xp.dtsi */
 
 &pmc8280_1_gpios {
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index f3190f408f4b2c7ca9fe368d652d5d66bb3949af..bee1e143178be5971a5916c368a5e8c864927b47 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -1481,10 +1481,6 @@ &wsamacro {
 	status = "okay";
 };
 
-&xo_board_clk {
-	clock-frequency = <38400000>;
-};
-
 /* PINCTRL */
 
 &lpass_tlmm {
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts
index ae5daeac8fe284bbec86622c10e6831d60a25297..c4a19ecbd894cbdd0521bbf784efd23f46eb07f0 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-microsoft-arcata.dts
@@ -837,10 +837,6 @@ &wsamacro {
 	status = "okay";
 };
 
-&xo_board_clk {
-	clock-frequency = <38400000>;
-};
-
 /* PINCTRL */
 
 &lpass_tlmm {
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index ef06d1ac084d3205a149feff880f457822dca2b4..e6517ad9408d9a49da9c00bcb661f32539fa32e6 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -31,6 +31,7 @@ clocks {
 		xo_board_clk: xo-board-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
+			clock-frequency = <38400000>;
 		};
 
 		sleep_clk: sleep-clk {

-- 
2.39.5


