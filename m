Return-Path: <linux-kernel+bounces-304476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6DAF9620A7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:19:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17DB5B24692
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C0415B560;
	Wed, 28 Aug 2024 07:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="abc9KBG4"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EEC15B109
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724829489; cv=none; b=uIRyHou7ZcF2kOAOI6bX1H5luxgDWp4t/H5ONt6/u1b8usMGj50PF087j5ygZdDPtEKetkdSbuRx0tPsg0txWyRQqFdg2cACipMut+PR/rX3QDcDuDCIo5kvGp4fu47XXo5zdhNdDhdlNZGRQsoCLISJLFDW6tkxmcdKsdr/TLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724829489; c=relaxed/simple;
	bh=ePudiw1R5FdvfqyG7oEuNE0c8SPlzKqGh2kDCuGDt5w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fTU2JbmRXGEoGKSEUoVH/1O5aowMT21hs+T4w++2ZJ+JzW4ATWRanfKDTYHVFKtW5rdNVSf8GBPWnMqYqthQL/1fIghmGmeGogACBqLU87PeRLPs8tAI6W4dV9Ngqz4sVR5Gh8xAVoIlXKt/RQG3JSQsI+Cy8kC5ZANwa5e4S+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=abc9KBG4; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37308a2ea55so259936f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 00:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724829485; x=1725434285; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rgwPKrW8TZpk1Py1raG6XSzTb7ye4CwtM+5ECHKmrVU=;
        b=abc9KBG41RPjDYugoceYEhg33tjXPzhcZL1J2eILJdSAiif4VDc4NEtkxQSzLuh3Ea
         eBA/6NJVhHdp+0hd670wCDSYnZxJZ/mcO4E6TWiViIri8uF83OlaQUZwN/4BgRkTPHta
         LoJRpNXuD6PFT3/FKQcr7XaVgqDLKvwDPdId6chssupgyTJRFhTynYPr+/qtSfvWEmkM
         sM8ZFp18tRuM0nsQvzbkcPR6tQJBqLe2SgXRNMwnf3TPOVlfoWBCLcjIRe8dI15mxJHk
         nfsJueR4psrDL0EVhPjQunKu7oUnvLL/WHI6sKUfOWdu00yXozuUKGEH7o+h1Q7DgGb5
         R+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724829485; x=1725434285;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgwPKrW8TZpk1Py1raG6XSzTb7ye4CwtM+5ECHKmrVU=;
        b=aF4JPk7vuslnPmPAaSYOa7hPVS72HW5TdN+c9A22xQnDR6JhRHspYLjDASFJgRDZk0
         vyfwPoa2NtkTAgwT3vB8AEQVVs03NCT1PdNypM0utu6hN2SmQcY78UNik1QVdB6vFcLc
         bIb4VLSnO10iHlP668WGqXauvMLDDOER43FvCYwE6D7lNNblQz0aL/yStUD4FIM5znGT
         iui13pQmXNGHaD1BVAtyxU3qKu2IEdBUQMAH9osT99A1/tjOoyO8ipw3jSWoVyq4DkMr
         9+xQesFYr1nxNMpom1jEACWetwfyePwKOVmi+803QTMkPfPyvEA+IFtOQKq4sGQoFHKO
         gY0g==
X-Forwarded-Encrypted: i=1; AJvYcCUFjlhqnYBSVyiqnnPzqgpPBGp/YgefPLd2dXm0Keay1wAnqWX/Fmq5J02jf/NZD7vKAXJUf6MQo6wm4QQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw973MXADbRo4jvDzFKHkdYlf5vD2fuP+zKNP2qRoeCP2VaUgR9
	VObx3vVOw/U6+a0XgrvUUnV6gFaTrp5XhQb2Mls4VrhXTCcu+W93tNEUc8tAd5c=
X-Google-Smtp-Source: AGHT+IF3PXI2N3sC1yAnYeW+Cj3DS/1pE18sqIIS7OlKt8TjwaAlMKae5KJss4xK1PHo+3l7G+GaqQ==
X-Received: by 2002:a05:600c:4f86:b0:426:6cd1:d116 with SMTP id 5b1f17b1804b1-42acca0dc64mr68036435e9.3.1724829485016;
        Wed, 28 Aug 2024 00:18:05 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37308200404sm14843476f8f.81.2024.08.28.00.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 00:18:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 28 Aug 2024 09:17:36 +0200
Subject: [PATCH 06/16] arm64: dts: qcom: sm6115: change labels to
 lower-case
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240828-dts-qcom-label-v1-6-b27b72130247@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12301;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ePudiw1R5FdvfqyG7oEuNE0c8SPlzKqGh2kDCuGDt5w=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBmzs8W7vk06ACgbJlTlgOn3hgCNsvqJoO0vLM0C
 wm6+4cFwESJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZs7PFgAKCRDBN2bmhouD
 14qHD/9TQP7+udD1lGFDN/3hPb3g2lVcxzWbW2QhD73ao2PY/HtP2imBRcD60K3hd1hTt1ogzYG
 n7ZOxvZa58UFMfzDCXD9vYWKDX1cN+GOmpFp04Q3tGId1bWXKUdhDag67GJUlNx8R/tXVv5o32l
 sj2QhDb8K5RmYKCjuOeLt47To7JX1xZE97ieOKJdf5nhQUugwJEzqaRQiAqcqzHbWpwLw1UEQv4
 BGwp+VmoWcycjtjSkX6JrwIl2VYsqdti9wPDklvim6aFsdrCd+rvdEDYdU572N6sfpX9lHlQAkK
 RjaZpKGrp7rVZ+xK9zKa4GidV5eRmXg1FhVglk8AFNG25z96LgRoi+BUG6iyPiNcHz6YIj8NB7E
 lAyLmKMX+M9+KrQDEfUIBlTQm5J7ueD6Cy2AXBSZ3vrXOT0sVEn3Aads8utcGQFspITxruGmlMu
 tfsHzuvAV5GL4MX3jf+0xDOCPuKyW50ojpL/5ZEvRDUvi98UQPlvqyNlp39MOcVuxCiwiTMgme0
 pP39+MCoVUagxAv2YMUnkgPx5uBujEoIz+TbLz7L2BhJd1J5kzbwyznUl5UI9yriCaHQm6T+VbR
 iP2VbbiyL2xVFAMUBc7qe9bvWnIJuTXaWEN/40+Ie6XIwRWpXvkonPrHAEgc1CfZz0QgAWoetJF
 IWzbZGZV2J3wd5A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

DTS coding style expects labels to be lowercase.  No functional impact.
Verified with comparing decompiled DTB (dtx_diff and fdtdump+diff).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm4250.dtsi |  16 ++--
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 152 +++++++++++++++++------------------
 2 files changed, 84 insertions(+), 84 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm4250.dtsi b/arch/arm64/boot/dts/qcom/sm4250.dtsi
index c5add8f44fc0..a0ed61925e12 100644
--- a/arch/arm64/boot/dts/qcom/sm4250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm4250.dtsi
@@ -5,34 +5,34 @@
 
 #include "sm6115.dtsi"
 
-&CPU0 {
+&cpu0 {
 	compatible = "qcom,kryo240";
 };
 
-&CPU1 {
+&cpu1 {
 	compatible = "qcom,kryo240";
 };
 
-&CPU2 {
+&cpu2 {
 	compatible = "qcom,kryo240";
 };
 
-&CPU3 {
+&cpu3 {
 	compatible = "qcom,kryo240";
 };
 
-&CPU4 {
+&cpu4 {
 	compatible = "qcom,kryo240";
 };
 
-&CPU5 {
+&cpu5 {
 	compatible = "qcom,kryo240";
 };
 
-&CPU6 {
+&cpu6 {
 	compatible = "qcom,kryo240";
 };
 
-&CPU7 {
+&cpu7 {
 	compatible = "qcom,kryo240";
 };
diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 41216cc319d6..590a1d2ead83 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -40,7 +40,7 @@ cpus {
 		#address-cells = <2>;
 		#size-cells = <0>;
 
-		CPU0: cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "qcom,kryo260";
 			reg = <0x0 0x0>;
@@ -48,18 +48,18 @@ CPU0: cpu@0 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
-			power-domains = <&CPU_PD0>;
+			power-domains = <&cpu_pd0>;
 			power-domain-names = "psci";
-			L2_0: l2-cache {
+			l2_0: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
 			};
 		};
 
-		CPU1: cpu@1 {
+		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "qcom,kryo260";
 			reg = <0x0 0x1>;
@@ -67,13 +67,13 @@ CPU1: cpu@1 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
-			power-domains = <&CPU_PD1>;
+			power-domains = <&cpu_pd1>;
 			power-domain-names = "psci";
 		};
 
-		CPU2: cpu@2 {
+		cpu2: cpu@2 {
 			device_type = "cpu";
 			compatible = "qcom,kryo260";
 			reg = <0x0 0x2>;
@@ -81,13 +81,13 @@ CPU2: cpu@2 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
-			power-domains = <&CPU_PD2>;
+			power-domains = <&cpu_pd2>;
 			power-domain-names = "psci";
 		};
 
-		CPU3: cpu@3 {
+		cpu3: cpu@3 {
 			device_type = "cpu";
 			compatible = "qcom,kryo260";
 			reg = <0x0 0x3>;
@@ -95,13 +95,13 @@ CPU3: cpu@3 {
 			capacity-dmips-mhz = <1024>;
 			dynamic-power-coefficient = <100>;
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			qcom,freq-domain = <&cpufreq_hw 0>;
-			power-domains = <&CPU_PD3>;
+			power-domains = <&cpu_pd3>;
 			power-domain-names = "psci";
 		};
 
-		CPU4: cpu@100 {
+		cpu4: cpu@100 {
 			device_type = "cpu";
 			compatible = "qcom,kryo260";
 			reg = <0x0 0x100>;
@@ -109,18 +109,18 @@ CPU4: cpu@100 {
 			enable-method = "psci";
 			capacity-dmips-mhz = <1638>;
 			dynamic-power-coefficient = <282>;
-			next-level-cache = <&L2_1>;
+			next-level-cache = <&l2_1>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
-			power-domains = <&CPU_PD4>;
+			power-domains = <&cpu_pd4>;
 			power-domain-names = "psci";
-			L2_1: l2-cache {
+			l2_1: l2-cache {
 				compatible = "cache";
 				cache-level = <2>;
 				cache-unified;
 			};
 		};
 
-		CPU5: cpu@101 {
+		cpu5: cpu@101 {
 			device_type = "cpu";
 			compatible = "qcom,kryo260";
 			reg = <0x0 0x101>;
@@ -128,13 +128,13 @@ CPU5: cpu@101 {
 			capacity-dmips-mhz = <1638>;
 			dynamic-power-coefficient = <282>;
 			enable-method = "psci";
-			next-level-cache = <&L2_1>;
+			next-level-cache = <&l2_1>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
-			power-domains = <&CPU_PD5>;
+			power-domains = <&cpu_pd5>;
 			power-domain-names = "psci";
 		};
 
-		CPU6: cpu@102 {
+		cpu6: cpu@102 {
 			device_type = "cpu";
 			compatible = "qcom,kryo260";
 			reg = <0x0 0x102>;
@@ -142,13 +142,13 @@ CPU6: cpu@102 {
 			capacity-dmips-mhz = <1638>;
 			dynamic-power-coefficient = <282>;
 			enable-method = "psci";
-			next-level-cache = <&L2_1>;
+			next-level-cache = <&l2_1>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
-			power-domains = <&CPU_PD6>;
+			power-domains = <&cpu_pd6>;
 			power-domain-names = "psci";
 		};
 
-		CPU7: cpu@103 {
+		cpu7: cpu@103 {
 			device_type = "cpu";
 			compatible = "qcom,kryo260";
 			reg = <0x0 0x103>;
@@ -156,46 +156,46 @@ CPU7: cpu@103 {
 			capacity-dmips-mhz = <1638>;
 			dynamic-power-coefficient = <282>;
 			enable-method = "psci";
-			next-level-cache = <&L2_1>;
+			next-level-cache = <&l2_1>;
 			qcom,freq-domain = <&cpufreq_hw 1>;
-			power-domains = <&CPU_PD7>;
+			power-domains = <&cpu_pd7>;
 			power-domain-names = "psci";
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
@@ -203,7 +203,7 @@ core3 {
 		idle-states {
 			entry-method = "psci";
 
-			LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
+			LITTLE_cpu_sleep_0: cpu-sleep-0-0 {
 				compatible = "arm,idle-state";
 				idle-state-name = "silver-rail-power-collapse";
 				arm,psci-suspend-param = <0x40000003>;
@@ -213,7 +213,7 @@ LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
 				local-timer-stop;
 			};
 
-			BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
+			BIG_cpu_sleep_0: cpu-sleep-1-0 {
 				compatible = "arm,idle-state";
 				idle-state-name = "gold-rail-power-collapse";
 				arm,psci-suspend-param = <0x40000003>;
@@ -225,7 +225,7 @@ BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
 		};
 
 		domain-idle-states {
-			CLUSTER_0_SLEEP_0: cluster-sleep-0-0 {
+			cluster_0_sleep_0: cluster-sleep-0-0 {
 				/* GDHS */
 				compatible = "domain-idle-state";
 				arm,psci-suspend-param = <0x40000022>;
@@ -234,7 +234,7 @@ CLUSTER_0_SLEEP_0: cluster-sleep-0-0 {
 				min-residency-us = <782>;
 			};
 
-			CLUSTER_0_SLEEP_1: cluster-sleep-0-1 {
+			cluster_0_sleep_1: cluster-sleep-0-1 {
 				/* Power Collapse */
 				compatible = "domain-idle-state";
 				arm,psci-suspend-param = <0x41000044>;
@@ -243,7 +243,7 @@ CLUSTER_0_SLEEP_1: cluster-sleep-0-1 {
 				min-residency-us = <7376>;
 			};
 
-			CLUSTER_1_SLEEP_0: cluster-sleep-1-0 {
+			cluster_1_sleep_0: cluster-sleep-1-0 {
 				/* GDHS */
 				compatible = "domain-idle-state";
 				arm,psci-suspend-param = <0x40000042>;
@@ -252,7 +252,7 @@ CLUSTER_1_SLEEP_0: cluster-sleep-1-0 {
 				min-residency-us = <660>;
 			};
 
-			CLUSTER_1_SLEEP_1: cluster-sleep-1-1 {
+			cluster_1_sleep_1: cluster-sleep-1-1 {
 				/* Power Collapse */
 				compatible = "domain-idle-state";
 				arm,psci-suspend-param = <0x41000044>;
@@ -306,62 +306,62 @@ psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
 
-		CPU_PD0: power-domain-cpu0 {
+		cpu_pd0: power-domain-cpu0 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_0_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+			power-domains = <&cluster_0_pd>;
+			domain-idle-states = <&LITTLE_cpu_sleep_0>;
 		};
 
-		CPU_PD1: power-domain-cpu1 {
+		cpu_pd1: power-domain-cpu1 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_0_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+			power-domains = <&cluster_0_pd>;
+			domain-idle-states = <&LITTLE_cpu_sleep_0>;
 		};
 
-		CPU_PD2: power-domain-cpu2 {
+		cpu_pd2: power-domain-cpu2 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_0_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+			power-domains = <&cluster_0_pd>;
+			domain-idle-states = <&LITTLE_cpu_sleep_0>;
 		};
 
-		CPU_PD3: power-domain-cpu3 {
+		cpu_pd3: power-domain-cpu3 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_0_PD>;
-			domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
+			power-domains = <&cluster_0_pd>;
+			domain-idle-states = <&LITTLE_cpu_sleep_0>;
 		};
 
-		CPU_PD4: power-domain-cpu4 {
+		cpu_pd4: power-domain-cpu4 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_1_PD>;
-			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+			power-domains = <&cluster_1_pd>;
+			domain-idle-states = <&BIG_cpu_sleep_0>;
 		};
 
-		CPU_PD5: power-domain-cpu5 {
+		cpu_pd5: power-domain-cpu5 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_1_PD>;
-			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+			power-domains = <&cluster_1_pd>;
+			domain-idle-states = <&BIG_cpu_sleep_0>;
 		};
 
-		CPU_PD6: power-domain-cpu6 {
+		cpu_pd6: power-domain-cpu6 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_1_PD>;
-			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+			power-domains = <&cluster_1_pd>;
+			domain-idle-states = <&BIG_cpu_sleep_0>;
 		};
 
-		CPU_PD7: power-domain-cpu7 {
+		cpu_pd7: power-domain-cpu7 {
 			#power-domain-cells = <0>;
-			power-domains = <&CLUSTER_1_PD>;
-			domain-idle-states = <&BIG_CPU_SLEEP_0>;
+			power-domains = <&cluster_1_pd>;
+			domain-idle-states = <&BIG_cpu_sleep_0>;
 		};
 
-		CLUSTER_0_PD: power-domain-cpu-cluster0 {
+		cluster_0_pd: power-domain-cpu-cluster0 {
 			#power-domain-cells = <0>;
-			domain-idle-states = <&CLUSTER_0_SLEEP_0>, <&CLUSTER_0_SLEEP_1>;
+			domain-idle-states = <&cluster_0_sleep_0>, <&cluster_0_sleep_1>;
 		};
 
-		CLUSTER_1_PD: power-domain-cpu-cluster1 {
+		cluster_1_pd: power-domain-cpu-cluster1 {
 			#power-domain-cells = <0>;
-			domain-idle-states = <&CLUSTER_1_SLEEP_0>, <&CLUSTER_1_SLEEP_1>;
+			domain-idle-states = <&cluster_1_sleep_0>, <&cluster_1_sleep_1>;
 		};
 	};
 
@@ -2405,7 +2405,7 @@ etm@9040000 {
 			clock-names = "apb_pclk";
 			arm,coresight-loses-context-with-cpu;
 
-			cpu = <&CPU0>;
+			cpu = <&cpu0>;
 
 			status = "disabled";
 
@@ -2426,7 +2426,7 @@ etm@9140000 {
 			clock-names = "apb_pclk";
 			arm,coresight-loses-context-with-cpu;
 
-			cpu = <&CPU1>;
+			cpu = <&cpu1>;
 
 			status = "disabled";
 
@@ -2447,7 +2447,7 @@ etm@9240000 {
 			clock-names = "apb_pclk";
 			arm,coresight-loses-context-with-cpu;
 
-			cpu = <&CPU2>;
+			cpu = <&cpu2>;
 
 			status = "disabled";
 
@@ -2468,7 +2468,7 @@ etm@9340000 {
 			clock-names = "apb_pclk";
 			arm,coresight-loses-context-with-cpu;
 
-			cpu = <&CPU3>;
+			cpu = <&cpu3>;
 
 			status = "disabled";
 
@@ -2489,7 +2489,7 @@ etm@9440000 {
 			clock-names = "apb_pclk";
 			arm,coresight-loses-context-with-cpu;
 
-			cpu = <&CPU4>;
+			cpu = <&cpu4>;
 
 			status = "disabled";
 
@@ -2510,7 +2510,7 @@ etm@9540000 {
 			clock-names = "apb_pclk";
 			arm,coresight-loses-context-with-cpu;
 
-			cpu = <&CPU5>;
+			cpu = <&cpu5>;
 
 			status = "disabled";
 
@@ -2531,7 +2531,7 @@ etm@9640000 {
 			clock-names = "apb_pclk";
 			arm,coresight-loses-context-with-cpu;
 
-			cpu = <&CPU6>;
+			cpu = <&cpu6>;
 
 			status = "disabled";
 
@@ -2552,7 +2552,7 @@ etm@9740000 {
 			clock-names = "apb_pclk";
 			arm,coresight-loses-context-with-cpu;
 
-			cpu = <&CPU7>;
+			cpu = <&cpu7>;
 
 			status = "disabled";
 

-- 
2.43.0


