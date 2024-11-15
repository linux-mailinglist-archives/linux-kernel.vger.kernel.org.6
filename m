Return-Path: <linux-kernel+bounces-410299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0B99CD96A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 08:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 656C3B28014
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 07:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4093218A92D;
	Fri, 15 Nov 2024 06:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v5ydfwDG"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71AA18A6D2
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 06:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653971; cv=none; b=n2Cxfp0AMFSmzA3Jz2R3vD+Fq2pOZrm3ltnvo5a5mgRwZuAHLjZD2+X5gjdAO8yV6VdHdF6ih/eySiCS6O3xIP9XZlfx9ft9JOtASQKTAnz9r+oXG1aJoIsuddO+58NUqTIFtvWw8w6b5eDJACbjqcLjFsEJfjgTHLKefvZ2uXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653971; c=relaxed/simple;
	bh=IzxIqxEM17NnU8O1wqGzQo6xuWqEOreY2WiD1EYVXIg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UcxLUel/zN8pnfV8OU07+NYx0ONsZda/kUHVfRZo01FK/cFaX62B3vgAzI3i3owCFrzWUqBL2SIvdr+sGfFJmzNzZUqqBILRvs+HyJcaM8gcB3rTa3J8G9++vUehXHrb4JKvo0/KteXwwIgTP694hvpzw1Jgj83npfFILIufskI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v5ydfwDG; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ff5d2b8f0eso8822481fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 22:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731653968; x=1732258768; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a+fKhg3HP8gMufM+S/hGnQD8Wwi4Hu8gIzMM0mqvlhU=;
        b=v5ydfwDGSaJRN8aENt8WXUk0YO36kBbXSpLa0xJPD8IlnVH8JBgH8UfOeyukzeW5SV
         JyjHSgV15+syHd7qkMZwlo9BEqd8k0QKCAYU5SJF0uoT/tIChBy6PuCmTpouRHLSMT0c
         aEjVPnmhbpBZCKb+yP1c0IVC3jmqiTGWFNWNFme95aE8KkEv/vkVEeH+OjzkR6yfDpS/
         g9nh8EuWppbXKBmXeJWZt8cQ+l5vkL/9l6zEM2gVzA41jKWEFhrzhVxmR3yI0Pjg/mXr
         eDn+eOXZah5Avxm/qNtb9mMtRDGTNrStEJ82dVMIyEStKMXZmMoNe9QO/a96O2FQv4Oy
         3vfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731653968; x=1732258768;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+fKhg3HP8gMufM+S/hGnQD8Wwi4Hu8gIzMM0mqvlhU=;
        b=wggwFDMihchdzuVhFoXaoi0qRfAP4NxfnrGXS6QMg7jLQNRAzhmk/i636RQ0vjl5ol
         3LHUdJIU4s1Upk8WrRiIH6wlaDkUqc5QkoZEZpB/M2p3q6g3EdKuY7JDFtwzWYLSI5hV
         MO1IXoCWNKhdvUbM0TDpArfedx0NBLqX9OcaAguDdkkO/hOaVEQnYiPPIEQ8P7Pps2vT
         Vg7cvNKtzgUQ4GmZyFtpd9JGwVFzJ6bFbu4qw5h/emzZlNeLEhAtCK8zmKJUXYMKad6N
         b2SRxRV6SWH+ScB0Z/1+w584+YlxK3UTOtDX7GGQIOj+wlfTSLY3krYGx7dkMVp3De54
         ZP8A==
X-Forwarded-Encrypted: i=1; AJvYcCUgGyDqQCgcX5NUf37T39cFE+gq8DWkqHvLzlaauHIT/ukRBV1FYf9C2X6X3SAzmeZjqQibErPv4OUTHzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvNa9ai6r55QBBXxZsKpCrqoQKC9v4TAKDJJxFBSRfDTZHxVjv
	uq7KAXMJgaik6skKn7xQlaKw+CeuBksDu9YqAhtlt40Mt1ugzm5MBtLimg+yDrM=
X-Google-Smtp-Source: AGHT+IFEi6Fm4iuPSnT4O4bDV4e9ph8Wdx09JdswEoyj75QsjVr25rkYDIyD86Tkx+xIDte2owhy7A==
X-Received: by 2002:a2e:a914:0:b0:2fb:5a19:5b9b with SMTP id 38308e7fff4ca-2ff606100c8mr8875691fa.8.1731653967833;
        Thu, 14 Nov 2024 22:59:27 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff5988ffdbsm4438281fa.111.2024.11.14.22.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 22:59:26 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 15 Nov 2024 08:59:21 +0200
Subject: [PATCH RFC 2/2] arm64: dts: qcom: sm8650: move board clocks to DTS
 files
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-fix-board-clocks-v1-2-8cb00a4f57c2@linaro.org>
References: <20241115-fix-board-clocks-v1-0-8cb00a4f57c2@linaro.org>
In-Reply-To: <20241115-fix-board-clocks-v1-0-8cb00a4f57c2@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4407;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=IzxIqxEM17NnU8O1wqGzQo6xuWqEOreY2WiD1EYVXIg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnNvFI4buOT0DOMP9DWbc2CxbO/1KwFbi3tJ2mO
 U4P0rHjRB+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZzbxSAAKCRCLPIo+Aiko
 1fNMB/47gnBCIM9kpQE7G8XUnT/GiAsdg2sLFhTYsTxpWboQlyKE/LlS8fF/PwK6bEZjHQzLrj5
 TocHNLigiqcJPdfKw99RKm2btOx6pn7xaYKSa0y0wYPKJdRMHhnFlEUL2lMy39tqDVNPYC/xxhA
 CbhnQy4AAWC5UiLofu8MPWgPD7CBkmGwYJqLUdF8s72OiXiznJUpHyPgZ+acq2QZgbvZkq2aLQ7
 0mGa+7hzfvrfiotrDIKBcsEQ99mbjC8kuMDRByv42sAqLvGYD1fTKdwgiC1H3LXeB4if8wft/lH
 PJcFU93S/uimp4oScKHUt9bdLfzBbrT6ImYbdyLn85zAtwZ6
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

SM8650 is one of the platforms where board-level clocks (XO, sleep)
definitions are split between the SoC dtsi file and the board file.
This is not correct, as these two clocks are not a part of the SoC. Also
such definitions don't fully follow the DT guidelines. Move these two
clocks to the board files completely.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650-hdk.dts | 22 ++++++++++++++--------
 arch/arm64/boot/dts/qcom/sm8650-mtp.dts | 22 ++++++++++++++--------
 arch/arm64/boot/dts/qcom/sm8650-qrd.dts | 22 ++++++++++++++--------
 arch/arm64/boot/dts/qcom/sm8650.dtsi    | 10 ----------
 4 files changed, 42 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
index f00bdff4280af22f6f8b23e33238f53c602bc169..641bd817d75439bc6a050189565437e1c5ead3b5 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
@@ -30,6 +30,20 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	clocks {
+		xo_board: xo-board {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <76800000>;
+		};
+
+		sleep_clk: sleep-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32000>;
+		};
+	};
+
 	hdmi-out {
 		compatible = "hdmi-connector";
 		type = "a";
@@ -1112,10 +1126,6 @@ &sdhc_2 {
 	status = "okay";
 };
 
-&sleep_clk {
-	clock-frequency = <32000>;
-};
-
 &swr0 {
 	status = "okay";
 
@@ -1337,7 +1347,3 @@ &usb_dp_qmpphy {
 &usb_dp_qmpphy_out {
 	remote-endpoint = <&pmic_glink_ss_in>;
 };
-
-&xo_board {
-	clock-frequency = <76800000>;
-};
diff --git a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
index 0db2cb03f252d19a1f8b171a562a8e06290c8a21..26ab08715473683082023ba53bef7ff37e1fbb83 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-mtp.dts
@@ -28,6 +28,20 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	clocks {
+		xo_board: xo-board {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <76800000>;
+		};
+
+		sleep_clk: sleep-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32000>;
+		};
+	};
+
 	pmic-glink {
 		compatible = "qcom,sm8650-pmic-glink",
 			     "qcom,sm8550-pmic-glink",
@@ -729,10 +743,6 @@ &sdhc_2 {
 	status = "okay";
 };
 
-&sleep_clk {
-	clock-frequency = <32000>;
-};
-
 &swr0 {
 	status = "okay";
 
@@ -884,7 +894,3 @@ &usb_dp_qmpphy {
 &usb_dp_qmpphy_out {
 	remote-endpoint = <&pmic_glink_ss_in>;
 };
-
-&xo_board {
-	clock-frequency = <76800000>;
-};
diff --git a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
index c5e8c3c2df91a49476f49832c0bd6418f4dfae3d..2a512d75d15d01b14a1eabda875f6d8fbe70a409 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-qrd.dts
@@ -30,6 +30,20 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	clocks {
+		xo_board: xo-board {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <76800000>;
+		};
+
+		sleep_clk: sleep-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32000>;
+		};
+	};
+
 	gpio-keys {
 		compatible = "gpio-keys";
 
@@ -1040,10 +1054,6 @@ &remoteproc_mpss {
 	status = "okay";
 };
 
-&sleep_clk {
-	clock-frequency = <32000>;
-};
-
 &spi4 {
 	status = "okay";
 
@@ -1320,7 +1330,3 @@ &usb_dp_qmpphy {
 &usb_dp_qmpphy_out {
 	remote-endpoint = <&redriver_ss_in>;
 };
-
-&xo_board {
-	clock-frequency = <76800000>;
-};
diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 25e47505adcb790d09f1d2726386438487255824..b960d58210f8199e1f4e080ce50cd574314fa3e8 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -35,16 +35,6 @@ / {
 	chosen { };
 
 	clocks {
-		xo_board: xo-board {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-		};
-
-		sleep_clk: sleep-clk {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-		};
-
 		bi_tcxo_div2: bi-tcxo-div2-clk {
 			compatible = "fixed-factor-clock";
 			#clock-cells = <0>;

-- 
2.39.5


