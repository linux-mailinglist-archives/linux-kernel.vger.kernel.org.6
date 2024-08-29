Return-Path: <linux-kernel+bounces-306869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F439644C7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 14:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BACF71C24B5E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 12:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DC71AE854;
	Thu, 29 Aug 2024 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wCSUkz9F"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D0F19E806
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 12:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724934910; cv=none; b=K5Lau4a4mVyMlHVH7J7OVzK1u2UUWX5ZKHoCEd+j0/bDxNKB6HlgANLLCqKwsAGH+rjfH3MYRQ8B/k6kH77Mv86P5wt35OuVrSGQ8ve+TrVmaNRE50hko8EZAroZt7YI0HqqdVR3kclO/i69DQAsIbc94fpCBO8Hcnsjc8ZhMjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724934910; c=relaxed/simple;
	bh=NrOndlWfXZF6lpM19zJ45AimPpnk17G4h/TVfyto7X8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sgFHEjlUu0hY920J9K68nOQNt5dMcAZTTJgAclsJrB9RqYxT1nws0A6nr4aT4Lie1RQH01wmBnDtsBu8w4MMzI8l83iCs+KariAkKZGM9bPtj8b0GL0/OSfMUFksczX4Z4iSrPZb59rLkEFXkyRdCPHb1MgDU8H2wxngxk5YyEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wCSUkz9F; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4281e715904so833725e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 05:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724934905; x=1725539705; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tdyDWmrtNSICbiqLpzVC7k2RW1ob136KpVWRbobipxQ=;
        b=wCSUkz9F3TGWLt7Tg0MdVmu1DbIbUOk721Yv6hgyG156+m0bB6k5HpYn6xPbMeK3bb
         FJ0pZ+iYBZmau6AdcbT3evC/qll/zVqa5PUjGXMEPdR4Xgg8oyUc0Sc/bZaFKPu72GxR
         fzt1Lt9hIOUS8YsotxmxDun2nrd1M+csdN8hV+Zw9zu2Y+HGOYKaBxrfwXdwBUgyPyoW
         lZ+L8c6o9g6sD1mViD8NhvXqE/rqPrrkRi1+Fq9np6gzYznHge8FSlOS+6p1T6cK2P8f
         wjtb9ixdfIQhKVgcXXVxDcdpG22Jzk6dHGyHMf+i51ANho4ReO5xePaDp1T4DNbnU3VB
         qi6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724934905; x=1725539705;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tdyDWmrtNSICbiqLpzVC7k2RW1ob136KpVWRbobipxQ=;
        b=GXJe/7syTRS9OdvKdw4TBSsyYr67DRPFOk3+NMqMdhngJG/Ojqdg273kmqA5LuiAl/
         kVHB7G4xeVoPHG2LD3P1qNhNLzBf3EI35+NZi+kX3liDnUVTnoaxfaju7c41QQJhl5Ge
         P6MNA4l7zNjbaWtpQUKib534QNYSVMP8D4hWZf5jfwPSpgq7/mDNt24i4r8TKYcUw2ua
         jaHLt0Ac79Ga2HOBnM0w8eft6jYg7xm1z6WbW92eVG1VQesUaQgx3YiYGR1J7UDEx+IC
         UEnybYf/w7pIyJvmzt66T+yGnkCqQSe5DosnCkGHIUG3mbTKNSJtZ5foi4XmT8rgHMG/
         w/4g==
X-Forwarded-Encrypted: i=1; AJvYcCV5x8p9aRZTzySFx1MBwpBmGX0H8cXQ8ew4nU5J4QnJr+b+CcxWDFWo356DdXH64+XcKtTEqiFgG9NMTik=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgAlGW57JktAxBMhdbG5oS7SXzGJ4utGXgL7z0rwq06Xkyf3ap
	C5e9gdlV1gC4Q6KfUvczds2AeveowIW23ku4V89jW2wN51VgTlj1L5ATWtsB7jg=
X-Google-Smtp-Source: AGHT+IF/mDLCTqZ8GW7wW9y8ifgPMcvlCVtyNeEeSxzkgweekvvLAr9TVAwLFYmDJvwSyNbG1hFK3g==
X-Received: by 2002:a05:600c:474c:b0:426:5dd5:f245 with SMTP id 5b1f17b1804b1-42bb01b5027mr13162225e9.2.1724934905231;
        Thu, 29 Aug 2024 05:35:05 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee4a55fsm1322270f8f.10.2024.08.29.05.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 05:35:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 29 Aug 2024 14:34:36 +0200
Subject: [PATCH v2 01/17] arm64: dts: qcom: ipq: change labels to
 lower-case
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240829-dts-qcom-label-v2-1-5deaada3e6b2@linaro.org>
References: <20240829-dts-qcom-label-v2-0-5deaada3e6b2@linaro.org>
In-Reply-To: <20240829-dts-qcom-label-v2-0-5deaada3e6b2@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=11614;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=NrOndlWfXZF6lpM19zJ45AimPpnk17G4h/TVfyto7X8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBm0Grm82Fe20tYuQMgnpOJgyUoIO4J4z2vJNeee
 3JSQaLR1xuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZtBq5gAKCRDBN2bmhouD
 1xmKD/0XApqVvRuwZNRRC8nFH+aAGy9vFiZnvR37aUTLKC0seWWFk7BSHYcpoa5SGPWiAst4o2A
 qgJTUlEJH2Rpm2p258qj6piSW9zMMimRiXdbpaU8hBp2ldhn40iLxwg3vfvxY/5H5UWKfMtREOd
 SpMQbACPAsX1tBk4yCoxxVDWbjmrJFsJdSmzCc3oGr+1o+VvZ1SjaNOD+LKfsIGUXluRpB2MBr+
 Hxw+H8k4uSGVT94U7bgx3aEX9DrDr73PJfpZbEi5q97Pr/fAgOzs+NuEjSKmtI8grn2XIEzHF1Y
 6q2Wzj3XTPimXA2uFm6FEo2rfbiOLLn5NclBeFhJmA66R0zXL++oumQedh0as+AWspvmqcfvEdJ
 c+VGGac7NMTgBiAnoOEGQUqsJUo1SZsETYM6B+bKe1GQQEjJgh/LRJIR5ZFIYxZpijMCJQMsmQn
 rHbPPrBqqj/wodnTYdDc5sR15iaKztgnuYjNl0eFIXyv9DtAzarq10wz0iPMeGaTtruhXBOiHgV
 M3g0LMCzcruf0K5MN+NVy+v7kk3BWfTO/IPF7n//kfFMkaXW1mzCOBHYlLZLHoC7NF/KydFo2VB
 iq3WW00DOkB97DkTIyYBm3aOZKT9eVhw+SVaBn4FgHz5qvWMy5/dtY5p31KK4DpT7IxEOloZaNk
 cvg92w9ov9r7fcQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

DTS coding style expects labels to be lowercase.  No functional impact.
Verified with comparing decompiled DTB (dtx_diff and fdtdump+diff).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 10 +++----
 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 18 ++++++-------
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 26 +++++++++---------
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 18 ++++++-------
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 50 +++++++++++++++++------------------
 5 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 7e6e2c121979..8914f2ef0bc4 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -31,27 +31,27 @@ cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		CPU0: cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0>;
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			operating-points-v2 = <&cpu_opp_table>;
 		};
 
-		CPU1: cpu@1 {
+		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x1>;
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			operating-points-v2 = <&cpu_opp_table>;
 		};
 
-		L2_0: l2-cache {
+		l2_0: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
 			cache-size = <0x80000>;
diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index 71328b223531..d3c3e215a15c 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -31,47 +31,47 @@ cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		CPU0: cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0>;
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			operating-points-v2 = <&cpu_opp_table>;
 		};
 
-		CPU1: cpu@1 {
+		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x1>;
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			operating-points-v2 = <&cpu_opp_table>;
 		};
 
-		CPU2: cpu@2 {
+		cpu2: cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x2>;
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			operating-points-v2 = <&cpu_opp_table>;
 		};
 
-		CPU3: cpu@3 {
+		cpu3: cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x3>;
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			operating-points-v2 = <&cpu_opp_table>;
 		};
 
-		L2_0: l2-cache {
+		l2_0: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
 			cache-unified;
diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 8edd535a188f..dbf6716bcb59 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -34,12 +34,12 @@ cpus: cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		CPU0: cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0>;
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu_opp_table>;
@@ -47,12 +47,12 @@ CPU0: cpu@0 {
 			#cooling-cells = <2>;
 		};
 
-		CPU1: cpu@1 {
+		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			enable-method = "psci";
 			reg = <0x1>;
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu_opp_table>;
@@ -60,12 +60,12 @@ CPU1: cpu@1 {
 			#cooling-cells = <2>;
 		};
 
-		CPU2: cpu@2 {
+		cpu2: cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			enable-method = "psci";
 			reg = <0x2>;
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu_opp_table>;
@@ -73,12 +73,12 @@ CPU2: cpu@2 {
 			#cooling-cells = <2>;
 		};
 
-		CPU3: cpu@3 {
+		cpu3: cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			enable-method = "psci";
 			reg = <0x3>;
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu_opp_table>;
@@ -86,7 +86,7 @@ CPU3: cpu@3 {
 			#cooling-cells = <2>;
 		};
 
-		L2_0: l2-cache {
+		l2_0: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
 			cache-unified;
@@ -1015,10 +1015,10 @@ cpu_alert: cpu-passive {
 			cooling-maps {
 				map0 {
 					trip = <&cpu_alert>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 284a4553070f..78e1992b7495 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -32,39 +32,39 @@ cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		CPU0: cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0>;
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			enable-method = "psci";
 		};
 
-		CPU1: cpu@1 {
+		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			enable-method = "psci";
 			reg = <0x1>;
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 		};
 
-		CPU2: cpu@2 {
+		cpu2: cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			enable-method = "psci";
 			reg = <0x2>;
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 		};
 
-		CPU3: cpu@3 {
+		cpu3: cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			enable-method = "psci";
 			reg = <0x3>;
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 		};
 
-		L2_0: l2-cache {
+		l2_0: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
 			cache-unified;
diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 08a82a5cf667..130fb65a21a0 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -34,12 +34,12 @@ cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		CPU0: cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a73";
 			reg = <0x0>;
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu_opp_table>;
@@ -47,12 +47,12 @@ CPU0: cpu@0 {
 			#cooling-cells = <2>;
 		};
 
-		CPU1: cpu@1 {
+		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a73";
 			reg = <0x1>;
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu_opp_table>;
@@ -60,12 +60,12 @@ CPU1: cpu@1 {
 			#cooling-cells = <2>;
 		};
 
-		CPU2: cpu@2 {
+		cpu2: cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a73";
 			reg = <0x2>;
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu_opp_table>;
@@ -73,12 +73,12 @@ CPU2: cpu@2 {
 			#cooling-cells = <2>;
 		};
 
-		CPU3: cpu@3 {
+		cpu3: cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a73";
 			reg = <0x3>;
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu_opp_table>;
@@ -86,7 +86,7 @@ CPU3: cpu@3 {
 			#cooling-cells = <2>;
 		};
 
-		L2_0: l2-cache {
+		l2_0: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
 			cache-unified;
@@ -863,10 +863,10 @@ cpu0_alert: cpu-passive {
 			cooling-maps {
 				map0 {
 					trip = <&cpu0_alert>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
@@ -891,10 +891,10 @@ cpu1_alert: cpu-passive {
 			cooling-maps {
 				map0 {
 					trip = <&cpu1_alert>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
@@ -919,10 +919,10 @@ cpu2_alert: cpu-passive {
 			cooling-maps {
 				map0 {
 					trip = <&cpu2_alert>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
@@ -947,10 +947,10 @@ cpu3_alert: cpu-passive {
 			cooling-maps {
 				map0 {
 					trip = <&cpu3_alert>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};

-- 
2.43.0


