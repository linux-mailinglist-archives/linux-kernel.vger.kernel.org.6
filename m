Return-Path: <linux-kernel+bounces-426050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C1E9DEE3F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 884F4B236E5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF9A1A725E;
	Sat, 30 Nov 2024 01:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NvxzQT8h"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947D12FC52
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931118; cv=none; b=YHSW4/seaANbLCQLWkyNDoAB9a0SQ8SkvPIURJvWW1IzgXYKSNGKPX9UbsGGgNSxoCg4eGKio/njQZcX1tl59pYQRhFZ3IZ4luTahJgvLJTwp/sLlsIt6R/o57FLJpM77pz4hHeK/DudVCpb0+NXOBB3vGCxQsWGG/UF9as/Zeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931118; c=relaxed/simple;
	bh=7OHCCY/C9Gi+J8yjNBu9jXr2t5pH4lXuG676E3PqyrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QEHb9pYTQCNzoRYIi+Zh97xxOVCQRHmz2luKlU642LYlCmqVY7BFVdzQ+1vc6tF8n+9J52WkcaHtXBtSh3masKOmIpnIjPx8APWeb3f6X+ZnmYNjAKbxC0fvwbuMyFID42Ssmj+Mv6axzkJoMHcVK4yEkIIYnt6z2tajkvXLTkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NvxzQT8h; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53de579f775so3647719e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732931115; x=1733535915; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4z856H9JHoTkiVMW2wllXOsniUtBFQ269F+uLj3QMj8=;
        b=NvxzQT8hEYTXcbyOc5fkC+C0BQ7peJBwB00nAlhFcEY4NknetGm86CBsYPspH9jONW
         JmGDB2H2hWE8xAeXZX3C4zzos0KWQ+baG42j4rp+Rs90eUkxswTUKJsW+9j/BGO46J4+
         7JdImHjtLLxaiOT3LQ/CF0B43cHE+WkDbj8SoM7Bn2JzdEgkOv+/SdcSZY7wI8GFrIuh
         UADq6yFyLzhjoW3sv5JzdT3sezg31LhBZP9+QDuonyTzKYty0cWjXX11Fpvp7TRYTW2h
         idJCVbV+/W6y/BW/rkf4ylWlD18szdL8Kf0XHQJza3w6vpGcsB24NFDVTU2zVg/XJrz6
         DHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931115; x=1733535915;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4z856H9JHoTkiVMW2wllXOsniUtBFQ269F+uLj3QMj8=;
        b=MW+1wYZog9Mmlfp6nX98pkozNjzGuTQMD+nUykavQK9Do/RkNrakEPuznRh3cO7Moc
         c0AUxF4yf4vpajnm7VB6ASpZo1gIwangpXyv/nSW01EMqW/WjqvfvifvdEB7B8nP2bYp
         onwtf13ILXq/ATlcCEfgZ4XU2cFPpXx/WbI++gmfl5RGlt8p3hD0ZMIaXivKHOwMdgOJ
         FTLsl+Y4Vu1zJVxSbpPOmg1PN5Jl26hiieHrJXVdLGiADjGkp3WfVrsJAYITB1hOrVMC
         HKsgOnz72icjUXZjqBCOOaXYpmtlun6uKrliAAfKHkovlgpzzwlihEd19Vc+4qh2a6SG
         OgkA==
X-Forwarded-Encrypted: i=1; AJvYcCW6LYwIGFsMLSC0MOVdIMQLaDolq/DOECnNdltAkjHnEzQ0HpL7U9g9FHKImkxn+sOKnN2HrQxGLzYCzX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbbsRxkv00ueyrBq6RPQpiziUEBA+c31p0EO+OowKy3jRXjBC+
	vJAqHtAoD96E4Ub7rXodbCHP3xaQGt3wBgLYTU+VUXMzZyqenBNQ13Taommxw+4=
X-Gm-Gg: ASbGncvrsMGNQCiyFXpJbE1zZ2oDR8Rucl+3+CuehnTe4E4wdCtFAnnFqDF68p7uVrV
	rGjSQO3iomiLsRSlI2m3bVZLXMUyJonzBaltQUTGAXgj/v8aAIralrUtqJZv7Wqn90Tg2hUr8js
	xGFLy4JW9eE/zVCWjmSJbvywousJaJRnQTaOHym5YfIFh5LvFpAquPsd10pCAekTTydaiMkiIRW
	YgLlsNZfJcn3hWiKdJfyX5shZ8GxM+ug0M8u3Jo//6RUkz1XjK+6RfUAQ==
X-Google-Smtp-Source: AGHT+IF0zW4Tb9smsX05u/8ucSJALcaHFjYyfqVbtDlbID1tAo7/zHKSvldSi48FISJZUqMPBLI+sQ==
X-Received: by 2002:a05:6512:3a8d:b0:53d:e83e:a23d with SMTP id 2adb3069b0e04-53df00d952dmr12619712e87.27.1732931114874;
        Fri, 29 Nov 2024 17:45:14 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64a0742sm631946e87.261.2024.11.29.17.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:45:13 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Nov 2024 03:44:32 +0200
Subject: [PATCH v2 20/31] arm64: dts: qcom: ipq5018: move board clocks to
 ipq5018.dtsi file
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-fix-board-clocks-v2-20-b9a35858657e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2648;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=7OHCCY/C9Gi+J8yjNBu9jXr2t5pH4lXuG676E3PqyrQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnSm32u9te1Qpn5Qa9ML35WLzEI1r0Xn/Ay2PZV
 nezXo95cqeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0pt9gAKCRCLPIo+Aiko
 1c41B/0TGGROPMQI5cFxBBrL+cOETVbJVXbve1qsZlcI88uOjKk4+WJJ40C4Is1ozIi9LEdtUWb
 UdvQ13lTw/wNECHJ+i3Dsy/HL8+GwfTvemGlrb9ZbTP4bBswkuxygCIj526qWpTl1yycXLty+Og
 wVh/aus15bo/QYD2K81AztGzmRhYPsoQcfbzSYiFf4IdurIxUELGW6QwkxzApLXqHV0KQt+YDw5
 yrUO/ZjEM1tTJGNahFwdp7udfKnVn+Ggc3CJ4FqNpjgM7XLBam9mHBx5mXcWaRY+ya5/pcxWheU
 UA3D2RXp5P5Nh6XbXScyKlF9okMbuQ7bjWRziSvjVuU1YcfH
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

IPQ5018 is one of the platforms where board-level clocks (XO, sleep)
definitions are split between the SoC dtsi file and the board file.
This is not optimal, as the clocks are a part of the SoC + PMICs design.
Frequencies are common for the whole set of devices using the same SoC.
Remove the split and move frequencies to the SoC DTSI file.

Suggested-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts             | 8 --------
 arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dts | 8 --------
 arch/arm64/boot/dts/qcom/ipq5018.dtsi                      | 2 ++
 3 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
index 8460b538eb6a3e2d6b971bd9637309809e0c0f0c..9bb87b7fd25777d4ba13bd2bb36024b8035d8afd 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5018-rdp432-c2.dts
@@ -38,10 +38,6 @@ &sdhc_1 {
 	status = "okay";
 };
 
-&sleep_clk {
-	clock-frequency = <32000>;
-};
-
 &tlmm {
 	sdc_default_state: sdc-default-state {
 		clk-pins {
@@ -78,7 +74,3 @@ &usb_dwc {
 &usbphy0 {
 	status = "okay";
 };
-
-&xo_board_clk {
-	clock-frequency = <24000000>;
-};
diff --git a/arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dts b/arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dts
index 5bb021cb29cd39cb95035bfac1bdbc976439838b..af281c285447f9845f542cc9d976fcdc7f1cf766 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dts
+++ b/arch/arm64/boot/dts/qcom/ipq5018-tplink-archer-ax55-v1.dts
@@ -95,10 +95,6 @@ &blsp1_uart1 {
 	status = "okay";
 };
 
-&sleep_clk {
-	clock-frequency = <32000>;
-};
-
 &tlmm {
 	button_pins: button-pins-state {
 		pins = "gpio25", "gpio31";
@@ -122,7 +118,3 @@ uart_pins: uart-pins-state {
 		bias-disable;
 	};
 };
-
-&xo_board_clk {
-	clock-frequency = <24000000>;
-};
diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 8914f2ef0bc47fda243b19174f77ce73fc10757d..fe617e9a086e6541854e03bd1f0a6519079befed 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -19,11 +19,13 @@ clocks {
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
+			clock-frequency = <32000>;
 		};
 
 		xo_board_clk: xo-board-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
+			clock-frequency = <24000000>;
 		};
 	};
 

-- 
2.39.5


