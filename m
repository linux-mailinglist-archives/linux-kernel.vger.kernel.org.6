Return-Path: <linux-kernel+bounces-376507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4063D9AB286
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6613DB219C2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720CD1BBBC3;
	Tue, 22 Oct 2024 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SddL0n0i"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D9B1A4F0C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 15:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612080; cv=none; b=vDXgIWxzv66ItJs6yVRYS33aGJfg793R835ydR7IkcjcgXyUawwwp51jvtgEmFNCAS1UgjYpfDQTs6oQc4DyJ3+42F0rOcG4R7TTpEuIN224l6lzfvs3bNx//yDTmOnLlWgf86+FtWe/Gj2sfNpyRoB4I4PsmPLUt5mApLyrTTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612080; c=relaxed/simple;
	bh=ALIXUFaj3TITSq6RcHZynbmUg4yb4KvnV43vbFxTm9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nHjIj2SGmxvkuWPtvNa4ESasJxPhN0C/fGeS001wc5NBZnlIkCBDOZxjIrMP1y7CVaTgmWSa0VoXdINIHBNRp2Kr640SOB3XUsYW78V0QYfmoTKFqc9E/0m+QrLIdHroOLw3RgT/hv0XdlXZ4HlN5j6CIdvg+a4/pEQbUVA2nIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SddL0n0i; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c9ff17eddbso856988a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 08:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729612075; x=1730216875; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IoCYoKUZcIYe9LQTkHcVOEJrIIeDYKxDw3PmZKvOTQw=;
        b=SddL0n0ipNJCQFNfhBqw2OuV+a1Ulp94H4cuMEaqhczYfHRHhtkjzDrkB5g+XvrdV6
         u4WH6V+qWVCuEWs93xI5zbatCBmgyBYtBJL75kP0ZigolJDwTgo077qYU+A+UTwzgWOT
         8btoDAhxgjHivshOuCUiHrBBc1s6ypn0RROY++Lm3/FC8oy10kWF20R3CAJ4pj6oqyzY
         cR3Ner5zZuXrcQGrF6fwUIVk2R5fGD48nM6MTV/qcmpwpJrJ/7sN6qCQSY37AJpl0Kov
         DkPsQtyqMh/mjLhK5UKCqkTXF3ea1V5PVtOEFiIegNydzMe2OE71bNgIlbX8I5ik7rjw
         Xriw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729612075; x=1730216875;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IoCYoKUZcIYe9LQTkHcVOEJrIIeDYKxDw3PmZKvOTQw=;
        b=ElrwXBaeVkGPl165A6uXM55g6nZHFgANS1hj1aFa0NruP48i5nFie3yTMGNkG02ZS4
         EiyQtFxqBc+ITM953jgTydrZyQXhV/eesTFuFzwGz8kdaXB3vU2HbUh+7MdBDXbPHW6P
         8I50fwrYe3CerFE0LgvueRouH+LdcflHgCUbt5CJhIihUPytWIDD20CA2D65L70rtw4C
         v4qy8NGa4nykW+TamV8lveR+vrTGxDOtAxy6M6SbhQboOV75X6fe4ik1UxJo7u5XafOT
         ZG0mtV/zfzJW2wL+AhkXwrYhHMDdjyiqZgWXU08JeRbuUU4euPLBwTAWelHBrfqWchgL
         /64w==
X-Forwarded-Encrypted: i=1; AJvYcCVa/NCVJ1FFXIqfZ0I5KTwnJA4K6fixlhIMDlP5bHhDB09I7jBOSsI3CL2CJNEHw1G9d9EM6lSB38MonYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj8oSpBvWjyaFXrUkQkr0/192mifS/qr45iRtvxStejxgdpJav
	C9GDUaEnmjd+p1yP9In/qtos2/Bo/1XlnQl4j/YHllvYZabKaP2FV3GxTu+b/sk=
X-Google-Smtp-Source: AGHT+IH66wduUn3irbYqqXv1Y9pWjyy+GexUffIoVEvG9VaQri9DPCvZtY89rb1yrbiJ3uy1uCZf7w==
X-Received: by 2002:a05:6402:2696:b0:5c8:aecf:8e87 with SMTP id 4fb4d7f45d1cf-5ca0af85c41mr5616308a12.9.1729612074822;
        Tue, 22 Oct 2024 08:47:54 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c725fesm3439959a12.87.2024.10.22.08.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 08:47:54 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 22 Oct 2024 17:47:27 +0200
Subject: [PATCH v3 02/18] arm64: dts: qcom: msm: change labels to
 lower-case
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-dts-qcom-label-v3-2-0505bc7d2c56@linaro.org>
References: <20241022-dts-qcom-label-v3-0-0505bc7d2c56@linaro.org>
In-Reply-To: <20241022-dts-qcom-label-v3-0-0505bc7d2c56@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=45120;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ALIXUFaj3TITSq6RcHZynbmUg4yb4KvnV43vbFxTm9A=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnF8kVwLmRY0393LQqlIX4QXurYJa+Stza5Jn8N
 86u/i4VpmOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZxfJFQAKCRDBN2bmhouD
 1y78EACSk3lx/KoFIGRX4fk7kFyIFs14rYawEjjtdTP2XnKbLcmaMPmgDnKiFTkBCFVlgZFCTR9
 yG/AQMytIDpi/m2F2XijkJ2Sg+hjyllXtdmsEDzam1Rv79D+MdEPNLuIB6qrAvjAVpaWRrK3/sI
 7P+OMBh9PVzg3ZEDAH6hRM+8mdy7nW4YN+mc7SgldoLu2aa0dP8Idd5cXp8fo2qqYL3VFiAtY8Q
 rhhPpP7QU/RSqPsG/mcN+3N/R/nchSHRbm2FHJvPUaxE3gvUMfrdP4IG5EcsWxbIeYfg6hvxY/n
 O/dQ5b23m7jp0h1RBvOYR0iKmElmIARD9ZA3nPUu5kj757RoQD9HDV5tK7Wt3Iw04jDVgkPBMBS
 sdcPWYJo+9KtJCbvFwAylgiisS+edGk/8rf+Q59/a5O2nnzjcMyfdH8bcCZdU3CVqLq3Av+2OJR
 N6XB88CfSYbhGJCs40W487gG6qqq9j4bTaMx6cnob87Gl+jPa3Z9/bcGyJcZ++Gcc8lyjB2WayE
 JeDYXF+teqpQNImNV6fA4WXkk1Z3u65RxWRrszSr07W4XSNZdIPFPjHhrnSeEeCLbVZnQVE+pZw
 SGg9kPImp0BxmoAL1OUNFG4X90GSAP4UVLZyF3QgGO4WUm+vYRI070v36yJ+ii8xLqdoZJX1zwn
 eJvivMfkHORpl4g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

DTS coding style expects labels to be lowercase.  No functional impact.
Verified with comparing decompiled DTB (dtx_diff and fdtdump+diff).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-msm8916-smp.dtsi    |   2 +-
 arch/arm64/boot/dts/qcom/msm8916.dtsi           | 100 ++++++++++-----------
 arch/arm64/boot/dts/qcom/msm8939.dtsi           | 110 ++++++++++++------------
 arch/arm64/boot/dts/qcom/msm8953.dtsi           |  68 +++++++--------
 arch/arm64/boot/dts/qcom/msm8976.dtsi           |  32 +++----
 arch/arm64/boot/dts/qcom/msm8992-lg-h815.dts    |  12 +--
 arch/arm64/boot/dts/qcom/msm8992.dtsi           |   4 +-
 arch/arm64/boot/dts/qcom/msm8994.dtsi           |  52 +++++------
 arch/arm64/boot/dts/qcom/msm8996.dtsi           |  54 ++++++------
 arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi |  32 +++----
 arch/arm64/boot/dts/qcom/msm8998.dtsi           |  92 ++++++++++----------
 arch/arm64/boot/dts/qcom/sdm632.dtsi            |  26 +++---
 12 files changed, 292 insertions(+), 292 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8916-smp.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8916-smp.dtsi
index 1ba403b83cb1d4e92b218ab6b9a44ed4f9d4308a..94b7694eeeffaffe88a6e28d625187f36a1d69f5 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8916-smp.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8916-smp.dtsi
@@ -25,7 +25,7 @@ psci {
 	};
 };
 
-&CPU_SLEEP_0 {
+&cpu_sleep_0 {
 	compatible = "qcom,idle-state-spc", "arm,idle-state";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 0ee44706b70ba3844a5bdd63298f318fb9e1d7c5..5e558bcc9d87893486352e5e211f131d4a1f67e5 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -133,67 +133,67 @@ cpus {
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
 			clocks = <&apcs>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
-			power-domains = <&CPU_PD0>;
+			power-domains = <&cpu_pd0>;
 			power-domain-names = "psci";
 			qcom,acc = <&cpu0_acc>;
 			qcom,saw = <&cpu0_saw>;
 		};
 
-		CPU1: cpu@1 {
+		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x1>;
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			enable-method = "psci";
 			clocks = <&apcs>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
-			power-domains = <&CPU_PD1>;
+			power-domains = <&cpu_pd1>;
 			power-domain-names = "psci";
 			qcom,acc = <&cpu1_acc>;
 			qcom,saw = <&cpu1_saw>;
 		};
 
-		CPU2: cpu@2 {
+		cpu2: cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x2>;
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			enable-method = "psci";
 			clocks = <&apcs>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
-			power-domains = <&CPU_PD2>;
+			power-domains = <&cpu_pd2>;
 			power-domain-names = "psci";
 			qcom,acc = <&cpu2_acc>;
 			qcom,saw = <&cpu2_saw>;
 		};
 
-		CPU3: cpu@3 {
+		cpu3: cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x3>;
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			enable-method = "psci";
 			clocks = <&apcs>;
 			operating-points-v2 = <&cpu_opp_table>;
 			#cooling-cells = <2>;
-			power-domains = <&CPU_PD3>;
+			power-domains = <&cpu_pd3>;
 			power-domain-names = "psci";
 			qcom,acc = <&cpu3_acc>;
 			qcom,saw = <&cpu3_saw>;
 		};
 
-		L2_0: l2-cache {
+		l2_0: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
 			cache-unified;
@@ -202,7 +202,7 @@ L2_0: l2-cache {
 		idle-states {
 			entry-method = "psci";
 
-			CPU_SLEEP_0: cpu-sleep-0 {
+			cpu_sleep_0: cpu-sleep-0 {
 				compatible = "arm,idle-state";
 				idle-state-name = "standalone-power-collapse";
 				arm,psci-suspend-param = <0x40000002>;
@@ -215,7 +215,7 @@ CPU_SLEEP_0: cpu-sleep-0 {
 
 		domain-idle-states {
 
-			CLUSTER_RET: cluster-retention {
+			cluster_ret: cluster-retention {
 				compatible = "domain-idle-state";
 				arm,psci-suspend-param = <0x41000012>;
 				entry-latency-us = <500>;
@@ -223,7 +223,7 @@ CLUSTER_RET: cluster-retention {
 				min-residency-us = <2000>;
 			};
 
-			CLUSTER_PWRDN: cluster-gdhs {
+			cluster_pwrdn: cluster-gdhs {
 				compatible = "domain-idle-state";
 				arm,psci-suspend-param = <0x41000032>;
 				entry-latency-us = <2000>;
@@ -273,33 +273,33 @@ psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 
-		CPU_PD0: power-domain-cpu0 {
+		cpu_pd0: power-domain-cpu0 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&CPU_SLEEP_0>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&cpu_sleep_0>;
 		};
 
-		CPU_PD1: power-domain-cpu1 {
+		cpu_pd1: power-domain-cpu1 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&CPU_SLEEP_0>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&cpu_sleep_0>;
 		};
 
-		CPU_PD2: power-domain-cpu2 {
+		cpu_pd2: power-domain-cpu2 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&CPU_SLEEP_0>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&cpu_sleep_0>;
 		};
 
-		CPU_PD3: power-domain-cpu3 {
+		cpu_pd3: power-domain-cpu3 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&CPU_SLEEP_0>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&cpu_sleep_0>;
 		};
 
-		CLUSTER_PD: power-domain-cluster {
+		cluster_pd: power-domain-cluster {
 			#power-domain-cells = <0>;
-			domain-idle-states = <&CLUSTER_RET>, <&CLUSTER_PWRDN>;
+			domain-idle-states = <&cluster_ret>, <&cluster_pwrdn>;
 		};
 	};
 
@@ -823,7 +823,7 @@ debug0: debug@850000 {
 			reg = <0x00850000 0x1000>;
 			clocks = <&rpmcc RPM_QDSS_CLK>;
 			clock-names = "apb_pclk";
-			cpu = <&CPU0>;
+			cpu = <&cpu0>;
 			status = "disabled";
 		};
 
@@ -832,7 +832,7 @@ debug1: debug@852000 {
 			reg = <0x00852000 0x1000>;
 			clocks = <&rpmcc RPM_QDSS_CLK>;
 			clock-names = "apb_pclk";
-			cpu = <&CPU1>;
+			cpu = <&cpu1>;
 			status = "disabled";
 		};
 
@@ -841,7 +841,7 @@ debug2: debug@854000 {
 			reg = <0x00854000 0x1000>;
 			clocks = <&rpmcc RPM_QDSS_CLK>;
 			clock-names = "apb_pclk";
-			cpu = <&CPU2>;
+			cpu = <&cpu2>;
 			status = "disabled";
 		};
 
@@ -850,7 +850,7 @@ debug3: debug@856000 {
 			reg = <0x00856000 0x1000>;
 			clocks = <&rpmcc RPM_QDSS_CLK>;
 			clock-names = "apb_pclk";
-			cpu = <&CPU3>;
+			cpu = <&cpu3>;
 			status = "disabled";
 		};
 
@@ -864,7 +864,7 @@ cti12: cti@858000 {
 			clocks = <&rpmcc RPM_QDSS_CLK>;
 			clock-names = "apb_pclk";
 
-			cpu = <&CPU0>;
+			cpu = <&cpu0>;
 			arm,cs-dev-assoc = <&etm0>;
 
 			status = "disabled";
@@ -879,7 +879,7 @@ cti13: cti@859000 {
 			clocks = <&rpmcc RPM_QDSS_CLK>;
 			clock-names = "apb_pclk";
 
-			cpu = <&CPU1>;
+			cpu = <&cpu1>;
 			arm,cs-dev-assoc = <&etm1>;
 
 			status = "disabled";
@@ -894,7 +894,7 @@ cti14: cti@85a000 {
 			clocks = <&rpmcc RPM_QDSS_CLK>;
 			clock-names = "apb_pclk";
 
-			cpu = <&CPU2>;
+			cpu = <&cpu2>;
 			arm,cs-dev-assoc = <&etm2>;
 
 			status = "disabled";
@@ -909,7 +909,7 @@ cti15: cti@85b000 {
 			clocks = <&rpmcc RPM_QDSS_CLK>;
 			clock-names = "apb_pclk";
 
-			cpu = <&CPU3>;
+			cpu = <&cpu3>;
 			arm,cs-dev-assoc = <&etm3>;
 
 			status = "disabled";
@@ -923,7 +923,7 @@ etm0: etm@85c000 {
 			clock-names = "apb_pclk", "atclk";
 			arm,coresight-loses-context-with-cpu;
 
-			cpu = <&CPU0>;
+			cpu = <&cpu0>;
 
 			status = "disabled";
 
@@ -944,7 +944,7 @@ etm1: etm@85d000 {
 			clock-names = "apb_pclk", "atclk";
 			arm,coresight-loses-context-with-cpu;
 
-			cpu = <&CPU1>;
+			cpu = <&cpu1>;
 
 			status = "disabled";
 
@@ -965,7 +965,7 @@ etm2: etm@85e000 {
 			clock-names = "apb_pclk", "atclk";
 			arm,coresight-loses-context-with-cpu;
 
-			cpu = <&CPU2>;
+			cpu = <&cpu2>;
 
 			status = "disabled";
 
@@ -986,7 +986,7 @@ etm3: etm@85f000 {
 			clock-names = "apb_pclk", "atclk";
 			arm,coresight-loses-context-with-cpu;
 
-			cpu = <&CPU3>;
+			cpu = <&cpu3>;
 
 			status = "disabled";
 
@@ -2644,10 +2644,10 @@ cpu0_1_crit: cpu-crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu0_1_alert0>;
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
@@ -2673,10 +2673,10 @@ cpu2_3_crit: cpu-crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu2_3_alert0>;
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
diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index 28634789a8a9704be6f0841d2189dd93c413c9ab..bbd116a6d492e9129b7ba363b666bdc5667a069c 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -42,122 +42,122 @@ cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		CPU0: cpu@100 {
+		cpu0: cpu@100 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "spin-table";
 			reg = <0x100>;
-			next-level-cache = <&L2_1>;
+			next-level-cache = <&l2_1>;
 			qcom,acc = <&acc0>;
 			qcom,saw = <&saw0>;
-			cpu-idle-states = <&CPU_SLEEP_0>;
+			cpu-idle-states = <&cpu_sleep_0>;
 			clocks = <&apcs1_mbox>;
 			#cooling-cells = <2>;
-			L2_1: l2-cache {
+			l2_1: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
 			};
 		};
 
-		CPU1: cpu@101 {
+		cpu1: cpu@101 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "spin-table";
 			reg = <0x101>;
-			next-level-cache = <&L2_1>;
+			next-level-cache = <&l2_1>;
 			qcom,acc = <&acc1>;
 			qcom,saw = <&saw1>;
-			cpu-idle-states = <&CPU_SLEEP_0>;
+			cpu-idle-states = <&cpu_sleep_0>;
 			clocks = <&apcs1_mbox>;
 			#cooling-cells = <2>;
 		};
 
-		CPU2: cpu@102 {
+		cpu2: cpu@102 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "spin-table";
 			reg = <0x102>;
-			next-level-cache = <&L2_1>;
+			next-level-cache = <&l2_1>;
 			qcom,acc = <&acc2>;
 			qcom,saw = <&saw2>;
-			cpu-idle-states = <&CPU_SLEEP_0>;
+			cpu-idle-states = <&cpu_sleep_0>;
 			clocks = <&apcs1_mbox>;
 			#cooling-cells = <2>;
 		};
 
-		CPU3: cpu@103 {
+		cpu3: cpu@103 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "spin-table";
 			reg = <0x103>;
-			next-level-cache = <&L2_1>;
+			next-level-cache = <&l2_1>;
 			qcom,acc = <&acc3>;
 			qcom,saw = <&saw3>;
-			cpu-idle-states = <&CPU_SLEEP_0>;
+			cpu-idle-states = <&cpu_sleep_0>;
 			clocks = <&apcs1_mbox>;
 			#cooling-cells = <2>;
 		};
 
-		CPU4: cpu@0 {
+		cpu4: cpu@0 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "spin-table";
 			reg = <0x0>;
 			qcom,acc = <&acc4>;
 			qcom,saw = <&saw4>;
-			cpu-idle-states = <&CPU_SLEEP_0>;
+			cpu-idle-states = <&cpu_sleep_0>;
 			clocks = <&apcs0_mbox>;
 			#cooling-cells = <2>;
-			next-level-cache = <&L2_0>;
-			L2_0: l2-cache {
+			next-level-cache = <&l2_0>;
+			l2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
 			};
 		};
 
-		CPU5: cpu@1 {
+		cpu5: cpu@1 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "spin-table";
 			reg = <0x1>;
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			qcom,acc = <&acc5>;
 			qcom,saw = <&saw5>;
-			cpu-idle-states = <&CPU_SLEEP_0>;
+			cpu-idle-states = <&cpu_sleep_0>;
 			clocks = <&apcs0_mbox>;
 			#cooling-cells = <2>;
 		};
 
-		CPU6: cpu@2 {
+		cpu6: cpu@2 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "spin-table";
 			reg = <0x2>;
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			qcom,acc = <&acc6>;
 			qcom,saw = <&saw6>;
-			cpu-idle-states = <&CPU_SLEEP_0>;
+			cpu-idle-states = <&cpu_sleep_0>;
 			clocks = <&apcs0_mbox>;
 			#cooling-cells = <2>;
 		};
 
-		CPU7: cpu@3 {
+		cpu7: cpu@3 {
 			compatible = "arm,cortex-a53";
 			device_type = "cpu";
 			enable-method = "spin-table";
 			reg = <0x3>;
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			qcom,acc = <&acc7>;
 			qcom,saw = <&saw7>;
-			cpu-idle-states = <&CPU_SLEEP_0>;
+			cpu-idle-states = <&cpu_sleep_0>;
 			clocks = <&apcs0_mbox>;
 			#cooling-cells = <2>;
 		};
 
 		idle-states {
-			CPU_SLEEP_0: cpu-sleep-0 {
+			cpu_sleep_0: cpu-sleep-0 {
 				compatible = "arm,idle-state";
 				entry-latency-us = <130>;
 				exit-latency-us = <150>;
@@ -182,19 +182,19 @@ cpu-map {
 		/* LITTLE (efficiency) cluster */
 		cluster0 {
 			core0 {
-				cpu = <&CPU4>;
+				cpu = <&cpu4>;
 			};
 
 			core1 {
-				cpu = <&CPU5>;
+				cpu = <&cpu5>;
 			};
 
 			core2 {
-				cpu = <&CPU6>;
+				cpu = <&cpu6>;
 			};
 
 			core3 {
-				cpu = <&CPU7>;
+				cpu = <&cpu7>;
 			};
 		};
 
@@ -202,19 +202,19 @@ core3 {
 		/* Boot CPU is cluster 1 core 0 */
 		cluster1 {
 			core0 {
-				cpu = <&CPU0>;
+				cpu = <&cpu0>;
 			};
 
 			core1 {
-				cpu = <&CPU1>;
+				cpu = <&cpu1>;
 			};
 
 			core2 {
-				cpu = <&CPU2>;
+				cpu = <&cpu2>;
 			};
 
 			core3 {
-				cpu = <&CPU3>;
+				cpu = <&cpu3>;
 			};
 		};
 	};
@@ -2318,10 +2318,10 @@ cpu0_crit: trip1 {
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
@@ -2348,10 +2348,10 @@ cpu1_crit: trip1 {
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
@@ -2378,10 +2378,10 @@ cpu2_crit: trip1 {
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
@@ -2408,10 +2408,10 @@ cpu3_crit: trip1 {
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
@@ -2438,10 +2438,10 @@ cpu4567_crit: trip1 {
 			cooling-maps {
 				map0 {
 					trip = <&cpu4567_alert>;
-					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/msm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953.dtsi
index d20fd3d7c46e4f93a4436c39d5286f69ed7a99c7..af4c341e2533ef2cca593e0dc97003334d3fd6b7 100644
--- a/arch/arm64/boot/dts/qcom/msm8953.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8953.dtsi
@@ -38,125 +38,125 @@ cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		CPU0: cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
 		};
 
-		CPU1: cpu@1 {
+		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x1>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
 		};
 
-		CPU2: cpu@2 {
+		cpu2: cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x2>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
 		};
 
-		CPU3: cpu@3 {
+		cpu3: cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x3>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			#cooling-cells = <2>;
 		};
 
-		CPU4: cpu@100 {
+		cpu4: cpu@100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x100>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			next-level-cache = <&L2_1>;
+			next-level-cache = <&l2_1>;
 			#cooling-cells = <2>;
 		};
 
-		CPU5: cpu@101 {
+		cpu5: cpu@101 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x101>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			next-level-cache = <&L2_1>;
+			next-level-cache = <&l2_1>;
 			#cooling-cells = <2>;
 		};
 
-		CPU6: cpu@102 {
+		cpu6: cpu@102 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x102>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			next-level-cache = <&L2_1>;
+			next-level-cache = <&l2_1>;
 			#cooling-cells = <2>;
 		};
 
-		CPU7: cpu@103 {
+		cpu7: cpu@103 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x103>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			next-level-cache = <&L2_1>;
+			next-level-cache = <&l2_1>;
 			#cooling-cells = <2>;
 		};
 
 		cpu-map {
 			cluster0 {
 				core0 {
-					cpu = <&CPU0>;
+					cpu = <&cpu0>;
 				};
 				core1 {
-					cpu = <&CPU1>;
+					cpu = <&cpu1>;
 				};
 				core2 {
-					cpu = <&CPU2>;
+					cpu = <&cpu2>;
 				};
 				core3 {
-					cpu = <&CPU3>;
+					cpu = <&cpu3>;
 				};
 			};
 
 			cluster1 {
 				core0 {
-					cpu = <&CPU4>;
+					cpu = <&cpu4>;
 				};
 				core1 {
-					cpu = <&CPU5>;
+					cpu = <&cpu5>;
 				};
 				core2 {
-					cpu = <&CPU6>;
+					cpu = <&cpu6>;
 				};
 				core3 {
-					cpu = <&CPU7>;
+					cpu = <&cpu7>;
 				};
 			};
 		};
 
-		L2_0: l2-cache-0 {
+		l2_0: l2-cache-0 {
 			compatible = "cache";
 			cache-level = <2>;
 			cache-unified;
 		};
 
-		L2_1: l2-cache-1 {
+		l2_1: l2-cache-1 {
 			compatible = "cache";
 			cache-level = <2>;
 			cache-unified;
@@ -1985,7 +1985,7 @@ cpu0_crit: crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu0_alert>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
@@ -2009,7 +2009,7 @@ cpu1_crit: crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu1_alert>;
-					cooling-device = <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
@@ -2033,7 +2033,7 @@ cpu2_crit: crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu2_alert>;
-					cooling-device = <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
@@ -2057,7 +2057,7 @@ cpu3_crit: crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu3_alert>;
-					cooling-device = <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
@@ -2079,7 +2079,7 @@ cpu4_crit: crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu4_alert>;
-					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
@@ -2101,7 +2101,7 @@ cpu5_crit: crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu5_alert>;
-					cooling-device = <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
@@ -2123,7 +2123,7 @@ cpu6_crit: crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu6_alert>;
-					cooling-device = <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
@@ -2145,7 +2145,7 @@ cpu7_crit: crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu7_alert>;
-					cooling-device = <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/msm8976.dtsi b/arch/arm64/boot/dts/qcom/msm8976.dtsi
index ed6ba4730cadc782fb1e0ee62e0478f7e9626b12..d036f31dfdca162debe18ed6ed9a7767a34aced6 100644
--- a/arch/arm64/boot/dts/qcom/msm8976.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8976.dtsi
@@ -31,7 +31,7 @@ cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		CPU0: cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0>;
@@ -42,7 +42,7 @@ CPU0: cpu@0 {
 			#cooling-cells = <2>;
 		};
 
-		CPU1: cpu@1 {
+		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x1>;
@@ -53,7 +53,7 @@ CPU1: cpu@1 {
 			#cooling-cells = <2>;
 		};
 
-		CPU2: cpu@2 {
+		cpu2: cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x2>;
@@ -64,7 +64,7 @@ CPU2: cpu@2 {
 			#cooling-cells = <2>;
 		};
 
-		CPU3: cpu@3 {
+		cpu3: cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x3>;
@@ -75,7 +75,7 @@ CPU3: cpu@3 {
 			#cooling-cells = <2>;
 		};
 
-		CPU4: cpu@100 {
+		cpu4: cpu@100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72";
 			reg = <0x100>;
@@ -86,7 +86,7 @@ CPU4: cpu@100 {
 			#cooling-cells = <2>;
 		};
 
-		CPU5: cpu@101 {
+		cpu5: cpu@101 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72";
 			reg = <0x101>;
@@ -97,7 +97,7 @@ CPU5: cpu@101 {
 			#cooling-cells = <2>;
 		};
 
-		CPU6: cpu@102 {
+		cpu6: cpu@102 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72";
 			reg = <0x102>;
@@ -108,7 +108,7 @@ CPU6: cpu@102 {
 			#cooling-cells = <2>;
 		};
 
-		CPU7: cpu@103 {
+		cpu7: cpu@103 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a72";
 			reg = <0x103>;
@@ -122,37 +122,37 @@ CPU7: cpu@103 {
 		cpu-map {
 			cluster0 {
 				core0 {
-					cpu = <&CPU0>;
+					cpu = <&cpu0>;
 				};
 
 				core1 {
-					cpu = <&CPU1>;
+					cpu = <&cpu1>;
 				};
 
 				core2 {
-					cpu = <&CPU2>;
+					cpu = <&cpu2>;
 				};
 
 				core3 {
-					cpu = <&CPU3>;
+					cpu = <&cpu3>;
 				};
 			};
 
 			cluster1 {
 				core0 {
-					cpu = <&CPU4>;
+					cpu = <&cpu4>;
 				};
 
 				core1 {
-					cpu = <&CPU5>;
+					cpu = <&cpu5>;
 				};
 
 				core2 {
-					cpu = <&CPU6>;
+					cpu = <&cpu6>;
 				};
 
 				core3 {
-					cpu = <&CPU7>;
+					cpu = <&cpu7>;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/msm8992-lg-h815.dts b/arch/arm64/boot/dts/qcom/msm8992-lg-h815.dts
index 38b305816d2f762c98aca13951fa35c32f035d8b..4520d5d51a2998580d9bf8ed27cc662939ad82c2 100644
--- a/arch/arm64/boot/dts/qcom/msm8992-lg-h815.dts
+++ b/arch/arm64/boot/dts/qcom/msm8992-lg-h815.dts
@@ -91,27 +91,27 @@ key-vol-up {
 	};
 };
 
-&CPU0 {
+&cpu0 {
 	enable-method = "spin-table";
 };
 
-&CPU1 {
+&cpu1 {
 	enable-method = "spin-table";
 };
 
-&CPU2 {
+&cpu2 {
 	enable-method = "spin-table";
 };
 
-&CPU3 {
+&cpu3 {
 	enable-method = "spin-table";
 };
 
-&CPU4 {
+&cpu4 {
 	enable-method = "spin-table";
 };
 
-&CPU5 {
+&cpu5 {
 	enable-method = "spin-table";
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8992.dtsi b/arch/arm64/boot/dts/qcom/msm8992.dtsi
index 02fc3795dbfd73a5c2905f630a88e42b520e7a2e..b2dc46c25fa24321f91b13b1950968418d927d6c 100644
--- a/arch/arm64/boot/dts/qcom/msm8992.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8992.dtsi
@@ -6,8 +6,8 @@
 #include "msm8994.dtsi"
 
 /* 8992 only features 2 A57 cores. */
-/delete-node/ &CPU6;
-/delete-node/ &CPU7;
+/delete-node/ &cpu6;
+/delete-node/ &cpu7;
 /delete-node/ &cpu6_map;
 /delete-node/ &cpu7_map;
 
diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index fc2a7f13f690ee1c640c78b13bfe419321a61a3a..1acb0f159511996db07bc7543cf4f194a4ebd0fa 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -43,114 +43,114 @@ cpus {
 		#address-cells = <2>;
 		#size-cells = <0>;
 
-		CPU0: cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
-			L2_0: l2-cache {
+			next-level-cache = <&l2_0>;
+			l2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
 			};
 		};
 
-		CPU1: cpu@1 {
+		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 		};
 
-		CPU2: cpu@2 {
+		cpu2: cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x2>;
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 		};
 
-		CPU3: cpu@3 {
+		cpu3: cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x3>;
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 		};
 
-		CPU4: cpu@100 {
+		cpu4: cpu@100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a57";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
-			next-level-cache = <&L2_1>;
-			L2_1: l2-cache {
+			next-level-cache = <&l2_1>;
+			l2_1: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
 			};
 		};
 
-		CPU5: cpu@101 {
+		cpu5: cpu@101 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a57";
 			reg = <0x0 0x101>;
 			enable-method = "psci";
-			next-level-cache = <&L2_1>;
+			next-level-cache = <&l2_1>;
 		};
 
-		CPU6: cpu@102 {
+		cpu6: cpu@102 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a57";
 			reg = <0x0 0x102>;
 			enable-method = "psci";
-			next-level-cache = <&L2_1>;
+			next-level-cache = <&l2_1>;
 		};
 
-		CPU7: cpu@103 {
+		cpu7: cpu@103 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a57";
 			reg = <0x0 0x103>;
 			enable-method = "psci";
-			next-level-cache = <&L2_1>;
+			next-level-cache = <&l2_1>;
 		};
 
 		cpu-map {
 			cluster0 {
 				core0 {
-					cpu = <&CPU0>;
+					cpu = <&cpu0>;
 				};
 
 				core1 {
-					cpu = <&CPU1>;
+					cpu = <&cpu1>;
 				};
 
 				core2 {
-					cpu = <&CPU2>;
+					cpu = <&cpu2>;
 				};
 
 				core3 {
-					cpu = <&CPU3>;
+					cpu = <&cpu3>;
 				};
 			};
 
 			cluster1 {
 				core0 {
-					cpu = <&CPU4>;
+					cpu = <&cpu4>;
 				};
 
 				core1 {
-					cpu = <&CPU5>;
+					cpu = <&cpu5>;
 				};
 
 				cpu6_map: core2 {
-					cpu = <&CPU6>;
+					cpu = <&cpu6>;
 				};
 
 				cpu7_map: core3 {
-					cpu = <&CPU7>;
+					cpu = <&cpu7>;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index e5966724f37c691ce871df9313e41c56ca84c419..b379623c1b8a0844c9de5255c4647fe3490bd2aa 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -43,90 +43,90 @@ cpus {
 		#address-cells = <2>;
 		#size-cells = <0>;
 
-		CPU0: cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "qcom,kryo";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SLEEP_0>;
+			cpu-idle-states = <&cpu_sleep_0>;
 			capacity-dmips-mhz = <1024>;
 			clocks = <&kryocc 0>;
 			interconnects = <&cbf MASTER_CBF_M4M &cbf SLAVE_CBF_M4M>;
 			operating-points-v2 = <&cluster0_opp>;
 			#cooling-cells = <2>;
-			next-level-cache = <&L2_0>;
-			L2_0: l2-cache {
+			next-level-cache = <&l2_0>;
+			l2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
 			};
 		};
 
-		CPU1: cpu@1 {
+		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "qcom,kryo";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SLEEP_0>;
+			cpu-idle-states = <&cpu_sleep_0>;
 			capacity-dmips-mhz = <1024>;
 			clocks = <&kryocc 0>;
 			interconnects = <&cbf MASTER_CBF_M4M &cbf SLAVE_CBF_M4M>;
 			operating-points-v2 = <&cluster0_opp>;
 			#cooling-cells = <2>;
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 		};
 
-		CPU2: cpu@100 {
+		cpu2: cpu@100 {
 			device_type = "cpu";
 			compatible = "qcom,kryo";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SLEEP_0>;
+			cpu-idle-states = <&cpu_sleep_0>;
 			capacity-dmips-mhz = <1024>;
 			clocks = <&kryocc 1>;
 			interconnects = <&cbf MASTER_CBF_M4M &cbf SLAVE_CBF_M4M>;
 			operating-points-v2 = <&cluster1_opp>;
 			#cooling-cells = <2>;
-			next-level-cache = <&L2_1>;
-			L2_1: l2-cache {
+			next-level-cache = <&l2_1>;
+			l2_1: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
 			};
 		};
 
-		CPU3: cpu@101 {
+		cpu3: cpu@101 {
 			device_type = "cpu";
 			compatible = "qcom,kryo";
 			reg = <0x0 0x101>;
 			enable-method = "psci";
-			cpu-idle-states = <&CPU_SLEEP_0>;
+			cpu-idle-states = <&cpu_sleep_0>;
 			capacity-dmips-mhz = <1024>;
 			clocks = <&kryocc 1>;
 			interconnects = <&cbf MASTER_CBF_M4M &cbf SLAVE_CBF_M4M>;
 			operating-points-v2 = <&cluster1_opp>;
 			#cooling-cells = <2>;
-			next-level-cache = <&L2_1>;
+			next-level-cache = <&l2_1>;
 		};
 
 		cpu-map {
 			cluster0 {
 				core0 {
-					cpu = <&CPU0>;
+					cpu = <&cpu0>;
 				};
 
 				core1 {
-					cpu = <&CPU1>;
+					cpu = <&cpu1>;
 				};
 			};
 
 			cluster1 {
 				core0 {
-					cpu = <&CPU2>;
+					cpu = <&cpu2>;
 				};
 
 				core1 {
-					cpu = <&CPU3>;
+					cpu = <&cpu3>;
 				};
 			};
 		};
@@ -134,7 +134,7 @@ core1 {
 		idle-states {
 			entry-method = "psci";
 
-			CPU_SLEEP_0: cpu-sleep-0 {
+			cpu_sleep_0: cpu-sleep-0 {
 				compatible = "arm,idle-state";
 				idle-state-name = "standalone-power-collapse";
 				arm,psci-suspend-param = <0x00000004>;
@@ -2829,7 +2829,7 @@ debug@3810000 {
 			clocks = <&rpmcc RPM_QDSS_CLK>;
 			clock-names = "apb_pclk";
 
-			cpu = <&CPU0>;
+			cpu = <&cpu0>;
 		};
 
 		etm@3840000 {
@@ -2839,7 +2839,7 @@ etm@3840000 {
 			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			cpu = <&CPU0>;
+			cpu = <&cpu0>;
 
 			out-ports {
 				port {
@@ -2858,7 +2858,7 @@ debug@3910000 {
 			clocks = <&rpmcc RPM_QDSS_CLK>;
 			clock-names = "apb_pclk";
 
-			cpu = <&CPU1>;
+			cpu = <&cpu1>;
 		};
 
 		etm@3940000 {
@@ -2868,7 +2868,7 @@ etm@3940000 {
 			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			cpu = <&CPU1>;
+			cpu = <&cpu1>;
 
 			out-ports {
 				port {
@@ -2923,7 +2923,7 @@ debug@3a10000 {
 			clocks = <&rpmcc RPM_QDSS_CLK>;
 			clock-names = "apb_pclk";
 
-			cpu = <&CPU2>;
+			cpu = <&cpu2>;
 		};
 
 		etm@3a40000 {
@@ -2933,7 +2933,7 @@ etm@3a40000 {
 			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			cpu = <&CPU2>;
+			cpu = <&cpu2>;
 
 			out-ports {
 				port {
@@ -2952,7 +2952,7 @@ debug@3b10000 {
 			clocks = <&rpmcc RPM_QDSS_CLK>;
 			clock-names = "apb_pclk";
 
-			cpu = <&CPU3>;
+			cpu = <&cpu3>;
 		};
 
 		etm@3b40000 {
@@ -2962,7 +2962,7 @@ etm@3b40000 {
 			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			cpu = <&CPU3>;
+			cpu = <&cpu3>;
 
 			out-ports {
 				port {
diff --git a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
index 3b7172aa40374cb953fc27cc36546a897b748258..4748a093af2fc520e5e5273dcc49d7721ffe5b3a 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-clamshell.dtsi
@@ -61,36 +61,36 @@ cts-pins {
  * not advertised as enabled in ACPI, and enabling it in DT can cause boot
  * hangs.
  */
-&CPU0 {
-	cpu-idle-states = <&LITTLE_CPU_SLEEP_1>;
+&cpu0 {
+	cpu-idle-states = <&little_cpu_sleep_1>;
 };
 
-&CPU1 {
-	cpu-idle-states = <&LITTLE_CPU_SLEEP_1>;
+&cpu1 {
+	cpu-idle-states = <&little_cpu_sleep_1>;
 };
 
-&CPU2 {
-	cpu-idle-states = <&LITTLE_CPU_SLEEP_1>;
+&cpu2 {
+	cpu-idle-states = <&little_cpu_sleep_1>;
 };
 
-&CPU3 {
-	cpu-idle-states = <&LITTLE_CPU_SLEEP_1>;
+&cpu3 {
+	cpu-idle-states = <&little_cpu_sleep_1>;
 };
 
-&CPU4 {
-	cpu-idle-states = <&BIG_CPU_SLEEP_1>;
+&cpu4 {
+	cpu-idle-states = <&big_cpu_sleep_1>;
 };
 
-&CPU5 {
-	cpu-idle-states = <&BIG_CPU_SLEEP_1>;
+&cpu5 {
+	cpu-idle-states = <&big_cpu_sleep_1>;
 };
 
-&CPU6 {
-	cpu-idle-states = <&BIG_CPU_SLEEP_1>;
+&cpu6 {
+	cpu-idle-states = <&big_cpu_sleep_1>;
 };
 
-&CPU7 {
-	cpu-idle-states = <&BIG_CPU_SLEEP_1>;
+&cpu7 {
+	cpu-idle-states = <&big_cpu_sleep_1>;
 };
 
 /*
diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index 4952da36ba5935b1ed135cf2bbab1dc9b669868e..c2caad85c668df2ebe900bc560e39480ae03e353 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -136,130 +136,130 @@ cpus {
 		#address-cells = <2>;
 		#size-cells = <0>;
 
-		CPU0: cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "qcom,kryo280";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
-			next-level-cache = <&L2_0>;
-			L2_0: l2-cache {
+			cpu-idle-states = <&little_cpu_sleep_0 &little_cpu_sleep_1>;
+			next-level-cache = <&l2_0>;
+			l2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
 			};
 		};
 
-		CPU1: cpu@1 {
+		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "qcom,kryo280";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
-			next-level-cache = <&L2_0>;
+			cpu-idle-states = <&little_cpu_sleep_0 &little_cpu_sleep_1>;
+			next-level-cache = <&l2_0>;
 		};
 
-		CPU2: cpu@2 {
+		cpu2: cpu@2 {
 			device_type = "cpu";
 			compatible = "qcom,kryo280";
 			reg = <0x0 0x2>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
-			next-level-cache = <&L2_0>;
+			cpu-idle-states = <&little_cpu_sleep_0 &little_cpu_sleep_1>;
+			next-level-cache = <&l2_0>;
 		};
 
-		CPU3: cpu@3 {
+		cpu3: cpu@3 {
 			device_type = "cpu";
 			compatible = "qcom,kryo280";
 			reg = <0x0 0x3>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
-			cpu-idle-states = <&LITTLE_CPU_SLEEP_0 &LITTLE_CPU_SLEEP_1>;
-			next-level-cache = <&L2_0>;
+			cpu-idle-states = <&little_cpu_sleep_0 &little_cpu_sleep_1>;
+			next-level-cache = <&l2_0>;
 		};
 
-		CPU4: cpu@100 {
+		cpu4: cpu@100 {
 			device_type = "cpu";
 			compatible = "qcom,kryo280";
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1536>;
-			cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
-			next-level-cache = <&L2_1>;
-			L2_1: l2-cache {
+			cpu-idle-states = <&big_cpu_sleep_0 &big_cpu_sleep_1>;
+			next-level-cache = <&l2_1>;
+			l2_1: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
 			};
 		};
 
-		CPU5: cpu@101 {
+		cpu5: cpu@101 {
 			device_type = "cpu";
 			compatible = "qcom,kryo280";
 			reg = <0x0 0x101>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1536>;
-			cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
-			next-level-cache = <&L2_1>;
+			cpu-idle-states = <&big_cpu_sleep_0 &big_cpu_sleep_1>;
+			next-level-cache = <&l2_1>;
 		};
 
-		CPU6: cpu@102 {
+		cpu6: cpu@102 {
 			device_type = "cpu";
 			compatible = "qcom,kryo280";
 			reg = <0x0 0x102>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1536>;
-			cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
-			next-level-cache = <&L2_1>;
+			cpu-idle-states = <&big_cpu_sleep_0 &big_cpu_sleep_1>;
+			next-level-cache = <&l2_1>;
 		};
 
-		CPU7: cpu@103 {
+		cpu7: cpu@103 {
 			device_type = "cpu";
 			compatible = "qcom,kryo280";
 			reg = <0x0 0x103>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1536>;
-			cpu-idle-states = <&BIG_CPU_SLEEP_0 &BIG_CPU_SLEEP_1>;
-			next-level-cache = <&L2_1>;
+			cpu-idle-states = <&big_cpu_sleep_0 &big_cpu_sleep_1>;
+			next-level-cache = <&l2_1>;
 		};
 
 		cpu-map {
 			cluster0 {
 				core0 {
-					cpu = <&CPU0>;
+					cpu = <&cpu0>;
 				};
 
 				core1 {
-					cpu = <&CPU1>;
+					cpu = <&cpu1>;
 				};
 
 				core2 {
-					cpu = <&CPU2>;
+					cpu = <&cpu2>;
 				};
 
 				core3 {
-					cpu = <&CPU3>;
+					cpu = <&cpu3>;
 				};
 			};
 
 			cluster1 {
 				core0 {
-					cpu = <&CPU4>;
+					cpu = <&cpu4>;
 				};
 
 				core1 {
-					cpu = <&CPU5>;
+					cpu = <&cpu5>;
 				};
 
 				core2 {
-					cpu = <&CPU6>;
+					cpu = <&cpu6>;
 				};
 
 				core3 {
-					cpu = <&CPU7>;
+					cpu = <&cpu7>;
 				};
 			};
 		};
@@ -267,7 +267,7 @@ core3 {
 		idle-states {
 			entry-method = "psci";
 
-			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
+			little_cpu_sleep_0: cpu-sleep-0-0 {
 				compatible = "arm,idle-state";
 				idle-state-name = "little-retention";
 				/* CPU Retention (C2D), L2 Active */
@@ -277,7 +277,7 @@ LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
 				min-residency-us = <504>;
 			};
 
-			LITTLE_CPU_SLEEP_1: cpu-sleep-0-1 {
+			little_cpu_sleep_1: cpu-sleep-0-1 {
 				compatible = "arm,idle-state";
 				idle-state-name = "little-power-collapse";
 				/* CPU + L2 Power Collapse (C3, D4) */
@@ -288,7 +288,7 @@ LITTLE_CPU_SLEEP_1: cpu-sleep-0-1 {
 				local-timer-stop;
 			};
 
-			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
+			big_cpu_sleep_0: cpu-sleep-1-0 {
 				compatible = "arm,idle-state";
 				idle-state-name = "big-retention";
 				/* CPU Retention (C2D), L2 Active */
@@ -298,7 +298,7 @@ BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
 				min-residency-us = <1302>;
 			};
 
-			BIG_CPU_SLEEP_1: cpu-sleep-1-1 {
+			big_cpu_sleep_1: cpu-sleep-1-1 {
 				compatible = "arm,idle-state";
 				idle-state-name = "big-power-collapse";
 				/* CPU + L2 Power Collapse (C3, D4) */
@@ -1874,7 +1874,7 @@ etm1: etm@7840000 {
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			cpu = <&CPU0>;
+			cpu = <&cpu0>;
 
 			out-ports {
 				port {
@@ -1894,7 +1894,7 @@ etm2: etm@7940000 {
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			cpu = <&CPU1>;
+			cpu = <&cpu1>;
 
 			out-ports {
 				port {
@@ -1914,7 +1914,7 @@ etm3: etm@7a40000 {
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			cpu = <&CPU2>;
+			cpu = <&cpu2>;
 
 			out-ports {
 				port {
@@ -1934,7 +1934,7 @@ etm4: etm@7b40000 {
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			cpu = <&CPU3>;
+			cpu = <&cpu3>;
 
 			out-ports {
 				port {
@@ -2068,7 +2068,7 @@ etm5: etm@7c40000 {
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			cpu = <&CPU4>;
+			cpu = <&cpu4>;
 
 			out-ports {
 				port {
@@ -2087,7 +2087,7 @@ etm6: etm@7d40000 {
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			cpu = <&CPU5>;
+			cpu = <&cpu5>;
 
 			out-ports {
 				port {
@@ -2106,7 +2106,7 @@ etm7: etm@7e40000 {
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			cpu = <&CPU6>;
+			cpu = <&cpu6>;
 
 			out-ports {
 				port {
@@ -2125,7 +2125,7 @@ etm8: etm@7f40000 {
 			clocks = <&rpmcc RPM_SMD_QDSS_CLK>, <&rpmcc RPM_SMD_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			cpu = <&CPU7>;
+			cpu = <&cpu7>;
 
 			out-ports {
 				port {
diff --git a/arch/arm64/boot/dts/qcom/sdm632.dtsi b/arch/arm64/boot/dts/qcom/sdm632.dtsi
index 95b025ea260bdbc48e15496dda34cdd5a7f0a448..40d86d91b67fa02d100c108baf606222c1c6c4df 100644
--- a/arch/arm64/boot/dts/qcom/sdm632.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm632.dtsi
@@ -14,10 +14,10 @@ cpu0-thermal {
 
 			cooling-maps {
 				map0 {
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
@@ -42,40 +42,40 @@ cpu7-thermal {
 
 /*
  * SDM632 uses Kryo 250 instead of Cortex A53
- * CPU0-3 are efficiency cores, CPU4-7 are performance cores
+ * cpu0-3 are efficiency cores, cpu4-7 are performance cores
  */
-&CPU0 {
+&cpu0 {
 	compatible = "qcom,kryo250";
 };
 
-&CPU1 {
+&cpu1 {
 	compatible = "qcom,kryo250";
 };
 
-&CPU2 {
+&cpu2 {
 	compatible = "qcom,kryo250";
 };
 
-&CPU3 {
+&cpu3 {
 	compatible = "qcom,kryo250";
 };
 
-&CPU4 {
+&cpu4 {
 	compatible = "qcom,kryo250";
 	capacity-dmips-mhz = <1980>;
 };
 
-&CPU5 {
+&cpu5 {
 	compatible = "qcom,kryo250";
 	capacity-dmips-mhz = <1980>;
 };
 
-&CPU6 {
+&cpu6 {
 	compatible = "qcom,kryo250";
 	capacity-dmips-mhz = <1980>;
 };
 
-&CPU7 {
+&cpu7 {
 	compatible = "qcom,kryo250";
 	capacity-dmips-mhz = <1980>;
 };

-- 
2.43.0


