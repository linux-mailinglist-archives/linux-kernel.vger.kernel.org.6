Return-Path: <linux-kernel+bounces-175744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7698C2456
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86AC628D81D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EB117BB00;
	Fri, 10 May 2024 12:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m3qUybAG"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCE417A938
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342403; cv=none; b=XrMCbGLRznVYg6Ha1ZkLRr5k++Sb9pUyRJe2k/INK7H9St9njVG1AdBBjwvkbi376a+Ps+Cr+CQf9OeCn4REucza9467mAm0dWCdkLn6/AlEurtCc/dV700ghNSsJLhzsrtYBcr0nflfJ4shMAMsBw9hV1XArAo0KGijuaAUWPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342403; c=relaxed/simple;
	bh=FA5Hk38Z1i9X8Tdc/qRx+Uallr3SO1fTu5ohTrdaiNU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I1ubai7iaDWCWYj54DldHuQ8ikJVASMhzzL2WnbhLgR8vH8+I1TpG1GHxrSTi5vhoI6Eukiq25n7wlr/ylv2bo5AzRpKFSfISJanGop3Xo/GwqHZiEj0cRCjEbhhyvbAGTeqB9P7YAt7RxLZ7BmFAttMySD7+TLhyGxZfym5L28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=m3qUybAG; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a59a387fbc9so508119266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 05:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715342400; x=1715947200; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQ1BLO+2DAmsqLEDBjJr5Y6ZfxRHQjRe1qQH/kJ9jT0=;
        b=m3qUybAGo8T6+cSO3gQpjo83zP4TBmesegpNcAaATMucNNW8kIlEuHNf2G7LlGCz4Q
         UNtoE18QwTwS3x/B01hdtxHcr4g+X+0huW05Nsjnhhf/kKwpmXOwymuTOzAD1seM6H5t
         PtBkOQ/9CqAApFwt0uKASiUQgPTaN7lDl1oq9dIAH876YwTe1WaK7mCPDug3vKQWvL/T
         IlG4uE+s11zEB8RIPl9neuzlWPFoJF9tVh9lM3uGr6u/udSHTzR8N+BtHY/ZIxMcl7Co
         xpkhSwGv9b9hJNjLyj/xclPkvYu123LeocPq8HwlJmNjr1NAMrysbDPLlZI2GHgiAhZi
         6n8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715342400; x=1715947200;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iQ1BLO+2DAmsqLEDBjJr5Y6ZfxRHQjRe1qQH/kJ9jT0=;
        b=rq7OjZkeFzg3Ks6hmTTUqbPCk46MRN5ZIypohPWQYVC7Ge4nb+KdBwvW+wAPDr41n+
         5yn5vz5LQm1gFK1Tlw2Pe+WN+uLQpdzXuvikM4zPm4EZZcFjfONSzxdOXAOMzg4zp7By
         sebO88sFN8/+iEeCyA4xmejYczM9U3dwTBCCFd0JeQDTpQ3+tBEYGT+RJehElMcloER4
         tS+Z2Q+DIRL5Wdg813WQMdjMAXXy6v2cpta9Ggph2xN5mPZHRErAhKqwQk07KyBs+F+e
         QbT3lKFtzyrgndHZpov8hBUkfFIBpa23rlVSm0SUtaRi9Ns3pmnPb7cQI/WRpR8llPvW
         tjzw==
X-Forwarded-Encrypted: i=1; AJvYcCUF3mI/H4sJ2zbwML3HXRXBf+6v5eMdpHkVrpDZYRT9JsqUx1GPZXWXDp9EqdieYFboyOiPAIztP5pC81P1nQ3/qnAxnnXswhd2v6pl
X-Gm-Message-State: AOJu0YzkhxmbB1uK3qhZ3LHNXiqrc64/Q1rKCNXRV2S/EemKyMF7BeEV
	AeV0YPGwwuC1OLXW3kMJaIjU26WjDPaeGayl5vVnvfBf8ky/kN47JweBvW3gubI=
X-Google-Smtp-Source: AGHT+IHJ+3hzCpvnZyCU0NAveIwNAiQTpS/ryykrIKxMS4WFefGFx6KYlVhSCrX+/3+fc0fO4MKcGg==
X-Received: by 2002:a17:906:7095:b0:a59:bacc:b07e with SMTP id a640c23a62f3a-a5a2d66a801mr150614266b.59.1715342400439;
        Fri, 10 May 2024 05:00:00 -0700 (PDT)
Received: from [127.0.1.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7df7sm176795666b.111.2024.05.10.04.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 05:00:00 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 10 May 2024 13:59:42 +0200
Subject: [PATCH v2 19/31] arm64: dts: qcom: sc8280xp-*: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-topic-msm-polling-cleanup-v2-19-436ca4218da2@linaro.org>
References: <20240510-topic-msm-polling-cleanup-v2-0-436ca4218da2@linaro.org>
In-Reply-To: <20240510-topic-msm-polling-cleanup-v2-0-436ca4218da2@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14-dev

All of the thermal zone suppliers are interrupt-driven, remove the
bogus and unnecessary polling that only wastes CPU time.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts |  2 +-
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi               |  4 ++--
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi                     | 13 -------------
 3 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
index e937732abede..8c4f342b4f31 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-lenovo-thinkpad-x13s.dts
@@ -299,7 +299,7 @@ linux,cma {
 	thermal-zones {
 		skin-temp-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
+
 			thermal-sensors = <&pmk8280_adc_tm 5>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
index 945de77911de..1e3babf2e40d 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
@@ -14,7 +14,7 @@ / {
 	thermal-zones {
 		pm8280_1_thermal: pm8280-1-thermal {
 			polling-delay-passive = <100>;
-			polling-delay = <0>;
+
 			thermal-sensors = <&pm8280_1_temp_alarm>;
 
 			trips {
@@ -34,7 +34,7 @@ trip1 {
 
 		pm8280_2_thermal: pm8280-2-thermal {
 			polling-delay-passive = <100>;
-			polling-delay = <0>;
+
 			thermal-sensors = <&pm8280_2_temp_alarm>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 0549ba1fbeea..f63951186a5b 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -5831,7 +5831,6 @@ sound: sound {
 	thermal-zones {
 		cpu0-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 1>;
 
@@ -5846,7 +5845,6 @@ cpu-crit {
 
 		cpu1-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 2>;
 
@@ -5861,7 +5859,6 @@ cpu-crit {
 
 		cpu2-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 3>;
 
@@ -5876,7 +5873,6 @@ cpu-crit {
 
 		cpu3-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 4>;
 
@@ -5891,7 +5887,6 @@ cpu-crit {
 
 		cpu4-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 5>;
 
@@ -5906,7 +5901,6 @@ cpu-crit {
 
 		cpu5-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 6>;
 
@@ -5921,7 +5915,6 @@ cpu-crit {
 
 		cpu6-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 7>;
 
@@ -5936,7 +5929,6 @@ cpu-crit {
 
 		cpu7-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 8>;
 
@@ -5951,7 +5943,6 @@ cpu-crit {
 
 		cluster0-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 9>;
 
@@ -5965,9 +5956,6 @@ cpu-crit {
 		};
 
 		gpu-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens2 2>;
 
 			trips {
@@ -5981,7 +5969,6 @@ gpu-crit {
 
 		mem-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 15>;
 

-- 
2.40.1


