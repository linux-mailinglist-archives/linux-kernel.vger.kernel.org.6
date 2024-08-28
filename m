Return-Path: <linux-kernel+bounces-304479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CCE9620B0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD1F11F258B5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F21715F33A;
	Wed, 28 Aug 2024 07:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t2eIX2Vt"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C44B15B99F
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724829494; cv=none; b=CyYDHZYWan+h8lQggGejOtkRJ5MLlcYTraKLEeBdocr4cJW5xHmSCRArMtehZ5PEqVf1VS2fjiUGstbmsLbT0M/xZRKtOxn2qE7Q/ZjP94WI2lAIvVHO+XFGhymurmDFQ7PlWf6UtRsfJBHuDoSRf9Skdc/FAs+ALvwipRHrYD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724829494; c=relaxed/simple;
	bh=bsO8XavMuXDODKyHZDeiBHUHH7IV/AAT/szB17sAFW4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oUf7TNIwNoikNRMCavt9RYrs6S10g9WUnJ7cYvTFeH/pVfHDRPsNd/iUlw6Y6t/+TwHnd++Jx7f47F8kgyzHNwMUXh07tq+Q+7ncNVaBOw7xxeRlFl7G1cW509SdlFJC9tXWanZlrX/TRZsp0IIIkmeLxFOZc/ZfPdbXR4ZqOIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t2eIX2Vt; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3719419c2aaso211833f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 00:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724829490; x=1725434290; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vtPVuTBsjhkf7hMpD3lVCaptXVmYt4pSOTn46udEgyU=;
        b=t2eIX2VtBuz61gzqVsQe8J3WICF1TQbPa5RMafN1arcovg8OuBOvIjtHioN1eO+eaC
         DmUFpfq50QEUuNpmCYFtG+F0o4ZpLz+rt/hNtswp1FX5kTQHnwbMln/MpoitT8j4vAgW
         1FvPXxOEbArnmfqYrFT8KihC8m0amj9DpjbdrtUxATDqMoCUjWRQwJ/hMEqp2JsPUr23
         QET+dOZfJkHRBjd4XqWka/tAHeXeFFCQhFOF/Bfw/GbGsARuDM7etdCcK1g9fZ0ag/PQ
         26xbXEnFmwUScNc6vU2KVnxc892dXKIRbRfzRlzwBuYpBkz6GGShiUS/kHnPhFxal83h
         F6ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724829490; x=1725434290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtPVuTBsjhkf7hMpD3lVCaptXVmYt4pSOTn46udEgyU=;
        b=D8pdLvg4hEjZ2fYt5f7AVAM4AktGWqZvNxqdItGX94RxeWGIe5YEVli1g0wqxHJHgN
         0dVQdrmqFGCz/BudGoPpBd6iY0zaFdqxzrF8oPsdZKI4GIHTwLEpfoNJfEhywpgtOJC4
         pNxJClh+bxEHEqUPJqCQ2nBlcEUmKh3b8OHiT8h+PbJxxJezNZWDs/ybUpAOn1BlxCei
         Uu+K9X61dkg8ukaHl+A87AO5KWV2Dzn0TYbsgPaDP8GvFKNt0SX8HqXLZ5G9YDUENLqR
         dGUmoJQY+PlxZD7W9N82v0XL8JArq9GBg9ZcjgvW0mcBYb3hxCrgg8bhbcyEgICpxbqA
         YLww==
X-Forwarded-Encrypted: i=1; AJvYcCWBDjQ4Bp26104wqwSGEMyVgjFPdM2cLS/IghFpOuhqSC0qcURW6pBDUl3VYYM4idUL8+DLwI9PInATIWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMZOjOM9cQnAEIOEdGiLcbCz6k1OyGAKRjAdASMAb4+1Z9vw3P
	2pzz+Jw5UQrmrofUYC0PBia6iju3LMaoMtCWHDc5HEJKdkg5ZaARoUUc9/vTrKI=
X-Google-Smtp-Source: AGHT+IEKzCmuCCJ5wEJgsjTMOFB26z7d4IyPjQa7ZCHrzN62ka7pzL4eBpe2ODL3pTe5sO2WxMmerw==
X-Received: by 2002:a5d:47a5:0:b0:367:2da6:aa1b with SMTP id ffacd0b85a97d-373118e930fmr6931473f8f.7.1724829489649;
        Wed, 28 Aug 2024 00:18:09 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37308200404sm14843476f8f.81.2024.08.28.00.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 00:18:09 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 28 Aug 2024 09:17:39 +0200
Subject: [PATCH 09/16] arm64: dts: qcom: sm8350: change labels to
 lower-case
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-dts-qcom-label-v1-9-b27b72130247@linaro.org>
References: <20240828-dts-qcom-label-v1-0-b27b72130247@linaro.org>
In-Reply-To: <20240828-dts-qcom-label-v1-0-b27b72130247@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=23416;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=bsO8XavMuXDODKyHZDeiBHUHH7IV/AAT/szB17sAFW4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmzs8ZqxebFT6M7L0hRLHPUVlaOIHhKjnJVskq+
 xIzIjjbzySJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZs7PGQAKCRDBN2bmhouD
 16UcD/sEU66HpjqIilsTZgBAvQks5gikH3alcHRAHkW/yBqg5cRkY4iAwTkoscMEjmnaU8cWdYN
 aItL9gL/QtVSBR8YJP/WhMF7oaYjzRhAzscB20i1bBBVMTyFLjk6OwhbYbcVKT+HSRFpVimKKI0
 j73ET0P7DYqpWPPhf84VgOW2aw9Q0dO4ogqwndPWZYQHzdIN+Ymt28U6f4iznoXDI2DdAVfxn7n
 fWZlQXhicZalZ+4YPZpKPAiCiP0qwjr5fEmHPhIjR3n/uTOn4yjI4y8UBrtbJGREgWKfepIFxlT
 9lAfoKtTeLwkR4rMlYZVW7LfBSXXb4FaSX/Lz5YQKBJcigMuoUDSry+fyusoa87Eo0FQ3bEEYNK
 4cglJH3HY9CWCF+Ljg4U4wceEK0ftfFOxY7Z24SjAO62giG/7ZUIpAAq5ODB+Ir/lS47l7yv+UR
 tB2YKIX8Fwfff/fbepAXjdOTVc+IQwjhJ0pNDOclJ1jJAlpbRlD3AVZeh8nDlBIMmsqeK2Z83Yz
 e+/aD/Jqh8uZaIXxjhtrqq/FadV5FzHhRKJY0KeEKDCWzYyTR7Hv9K3IwsQQssMCRg/lOsfpx4I
 w1oGQ0PMGiqEncWevx205pT+NxP2VcsDMxt6q5ZISYis7lwgcFjHFTCfGxaPNawVndvX0wvrBlu
 4/LVBgwNs0VFC/w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

DTS coding style expects labels to be lowercase.  No functional impact.
Verified with comparing decompiled DTB (dtx_diff and fdtdump+diff).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 334 +++++++++++++++++------------------
 1 file changed, 167 insertions(+), 167 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 37a2aba0d4ca..c7255dfd2bd9 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -51,18 +51,18 @@ cpus {
 		#address-cells = <2>;
 		#size-cells = <0>;
 
-		CPU0: cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x0>;
 			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
-			power-domains = <&CPU_PD0>;
+			power-domains = <&cpu_pd0>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
-			L2_0: l2-cache {
+			l2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
@@ -75,18 +75,18 @@ L3_0: l3-cache {
 			};
 		};
 
-		CPU1: cpu@100 {
+		cpu1: cpu@100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x100>;
 			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
-			next-level-cache = <&L2_100>;
+			next-level-cache = <&l2_100>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
-			power-domains = <&CPU_PD1>;
+			power-domains = <&cpu_pd1>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
-			L2_100: l2-cache {
+			l2_100: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
@@ -94,18 +94,18 @@ L2_100: l2-cache {
 			};
 		};
 
-		CPU2: cpu@200 {
+		cpu2: cpu@200 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x200>;
 			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
-			next-level-cache = <&L2_200>;
+			next-level-cache = <&l2_200>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
-			power-domains = <&CPU_PD2>;
+			power-domains = <&cpu_pd2>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
-			L2_200: l2-cache {
+			l2_200: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
@@ -113,18 +113,18 @@ L2_200: l2-cache {
 			};
 		};
 
-		CPU3: cpu@300 {
+		cpu3: cpu@300 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x300>;
 			clocks = <&cpufreq_hw 0>;
 			enable-method = "psci";
-			next-level-cache = <&L2_300>;
+			next-level-cache = <&l2_300>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
-			power-domains = <&CPU_PD3>;
+			power-domains = <&cpu_pd3>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
-			L2_300: l2-cache {
+			l2_300: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
@@ -132,18 +132,18 @@ L2_300: l2-cache {
 			};
 		};
 
-		CPU4: cpu@400 {
+		cpu4: cpu@400 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a78";
 			reg = <0x0 0x400>;
 			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
-			next-level-cache = <&L2_400>;
+			next-level-cache = <&l2_400>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
-			power-domains = <&CPU_PD4>;
+			power-domains = <&cpu_pd4>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
-			L2_400: l2-cache {
+			l2_400: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
@@ -151,18 +151,18 @@ L2_400: l2-cache {
 			};
 		};
 
-		CPU5: cpu@500 {
+		cpu5: cpu@500 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a78";
 			reg = <0x0 0x500>;
 			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
-			next-level-cache = <&L2_500>;
+			next-level-cache = <&l2_500>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
-			power-domains = <&CPU_PD5>;
+			power-domains = <&cpu_pd5>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
-			L2_500: l2-cache {
+			l2_500: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
@@ -170,18 +170,18 @@ L2_500: l2-cache {
 			};
 		};
 
-		CPU6: cpu@600 {
+		cpu6: cpu@600 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a78";
 			reg = <0x0 0x600>;
 			clocks = <&cpufreq_hw 1>;
 			enable-method = "psci";
-			next-level-cache = <&L2_600>;
+			next-level-cache = <&l2_600>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
-			power-domains = <&CPU_PD6>;
+			power-domains = <&cpu_pd6>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
-			L2_600: l2-cache {
+			l2_600: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
@@ -189,18 +189,18 @@ L2_600: l2-cache {
 			};
 		};
 
-		CPU7: cpu@700 {
+		cpu7: cpu@700 {
 			device_type = "cpu";
 			compatible = "arm,cortex-x1";
 			reg = <0x0 0x700>;
 			clocks = <&cpufreq_hw 2>;
 			enable-method = "psci";
-			next-level-cache = <&L2_700>;
+			next-level-cache = <&l2_700>;
 			qcom,freq-domain = <&cpufreq_hw 2>;
-			power-domains = <&CPU_PD7>;
+			power-domains = <&cpu_pd7>;
 			power-domain-names = "psci";
 			#cooling-cells = <2>;
-			L2_700: l2-cache {
+			l2_700: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
@@ -211,35 +211,35 @@ L2_700: l2-cache {
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
 
 				core4 {
-					cpu = <&CPU4>;
+					cpu = <&cpu4>;
 				};
 
 				core5 {
-					cpu = <&CPU5>;
+					cpu = <&cpu5>;
 				};
 
 				core6 {
-					cpu = <&CPU6>;
+					cpu = <&cpu6>;
 				};
 
 				core7 {
-					cpu = <&CPU7>;
+					cpu = <&cpu7>;
 				};
 			};
 		};
@@ -247,7 +247,7 @@ core7 {
 		idle-states {
 			entry-method = "psci";
 
-			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
+			LITTLE_cpu_sleep_0: cpu-sleep-0-0 {
 				compatible = "arm,idle-state";
 				idle-state-name = "silver-rail-power-collapse";
 				arm,psci-suspend-param = <0x40000004>;
@@ -257,7 +257,7 @@ LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
 				local-timer-stop;
 			};
 
-			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
+			BIG_cpu_sleep_0: cpu-sleep-1-0 {
 				compatible = "arm,idle-state";
 				idle-state-name = "gold-rail-power-collapse";
 				arm,psci-suspend-param = <0x40000004>;
@@ -269,7 +269,7 @@ BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
 		};
 
 		domain-idle-states {
-			CLUSTER_SLEEP_APSS_OFF: cluster-sleep-0 {
+			cluster_sleep_APSS_OFF: cluster-sleep-0 {
 				compatible = "domain-idle-state";
 				arm,psci-suspend-param = <0x41000044>;
 				entry-latency-us = <2752>;
@@ -277,7 +277,7 @@ CLUSTER_SLEEP_APSS_OFF: cluster-sleep-0 {
 				min-residency-us = <6118>;
 			};
 
-			CLUSTER_SLEEP_AOSS_SLEEP: cluster-sleep-1 {
+			cluster_sleep_AOSS_SLEEP: cluster-sleep-1 {
 				compatible = "domain-idle-state";
 				arm,psci-suspend-param = <0x4100c344>;
 				entry-latency-us = <3263>;
@@ -320,57 +320,57 @@ psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 
-		CPU_PD0: power-domain-cpu0 {
+		cpu_pd0: power-domain-cpu0 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&LITTLE_cpu_sleep_0>;
 		};
 
-		CPU_PD1: power-domain-cpu1 {
+		cpu_pd1: power-domain-cpu1 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&LITTLE_cpu_sleep_0>;
 		};
 
-		CPU_PD2: power-domain-cpu2 {
+		cpu_pd2: power-domain-cpu2 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&LITTLE_cpu_sleep_0>;
 		};
 
-		CPU_PD3: power-domain-cpu3 {
+		cpu_pd3: power-domain-cpu3 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&LITTLE_cpu_sleep_0>;
 		};
 
-		CPU_PD4: power-domain-cpu4 {
+		cpu_pd4: power-domain-cpu4 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&BIG_cpu_sleep_0>;
 		};
 
-		CPU_PD5: power-domain-cpu5 {
+		cpu_pd5: power-domain-cpu5 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&BIG_cpu_sleep_0>;
 		};
 
-		CPU_PD6: power-domain-cpu6 {
+		cpu_pd6: power-domain-cpu6 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&BIG_cpu_sleep_0>;
 		};
 
-		CPU_PD7: power-domain-cpu7 {
+		cpu_pd7: power-domain-cpu7 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_PD>;
-			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+			power-domains = <&cluster_pd>;
+			domain-idle-states = <&BIG_cpu_sleep_0>;
 		};
 
-		CLUSTER_PD: power-domain-cpu-cluster0 {
+		cluster_pd: power-domain-cpu-cluster0 {
 			#power-domain-cells = <0>;
-			domain-idle-states = <&CLUSTER_SLEEP_APSS_OFF &CLUSTER_SLEEP_AOSS_SLEEP>;
+			domain-idle-states = <&cluster_sleep_APSS_OFF &cluster_sleep_AOSS_SLEEP>;
 		};
 	};
 
@@ -3504,7 +3504,7 @@ apps_rsc: rsc@18200000 {
 			qcom,drv-id = <2>;
 			qcom,tcs-config = <ACTIVE_TCS  2>, <SLEEP_TCS   3>,
 					  <WAKE_TCS    3>, <CONTROL_TCS 0>;
-			power-domains = <&CLUSTER_PD>;
+			power-domains = <&cluster_pd>;
 
 			rpmhcc: clock-controller {
 				compatible = "qcom,sm8350-rpmh-clk";
@@ -3728,17 +3728,17 @@ cpu0_crit: cpu-crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu0_alert0>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 				map1 {
 					trip = <&cpu0_alert1>;
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
@@ -3771,17 +3771,17 @@ cpu1_crit: cpu-crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu1_alert0>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 				map1 {
 					trip = <&cpu1_alert1>;
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
@@ -3814,17 +3814,17 @@ cpu2_crit: cpu-crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu2_alert0>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 				map1 {
 					trip = <&cpu2_alert1>;
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
@@ -3857,17 +3857,17 @@ cpu3_crit: cpu-crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu3_alert0>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 				map1 {
 					trip = <&cpu3_alert1>;
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
@@ -3900,17 +3900,17 @@ cpu4_top_crit: cpu-crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu4_top_alert0>;
-					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 				map1 {
 					trip = <&cpu4_top_alert1>;
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
@@ -3943,17 +3943,17 @@ cpu5_top_crit: cpu-crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu5_top_alert0>;
-					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 				map1 {
 					trip = <&cpu5_top_alert1>;
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
@@ -3986,17 +3986,17 @@ cpu6_top_crit: cpu-crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu6_top_alert0>;
-					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 				map1 {
 					trip = <&cpu6_top_alert1>;
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
@@ -4029,17 +4029,17 @@ cpu7_top_crit: cpu-crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu7_top_alert0>;
-					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 				map1 {
 					trip = <&cpu7_top_alert1>;
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
@@ -4072,17 +4072,17 @@ cpu4_bottom_crit: cpu-crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu4_bottom_alert0>;
-					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 				map1 {
 					trip = <&cpu4_bottom_alert1>;
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
@@ -4115,17 +4115,17 @@ cpu5_bottom_crit: cpu-crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu5_bottom_alert0>;
-					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 				map1 {
 					trip = <&cpu5_bottom_alert1>;
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
@@ -4158,17 +4158,17 @@ cpu6_bottom_crit: cpu-crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu6_bottom_alert0>;
-					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 				map1 {
 					trip = <&cpu6_bottom_alert1>;
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
@@ -4201,17 +4201,17 @@ cpu7_bottom_crit: cpu-crit {
 			cooling-maps {
 				map0 {
 					trip = <&cpu7_bottom_alert0>;
-					cooling-device = <&CPU4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu4 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu5 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu6 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu7 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 				map1 {
 					trip = <&cpu7_bottom_alert1>;
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

-- 
2.43.0


