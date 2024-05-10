Return-Path: <linux-kernel+bounces-175734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BA3E8C2434
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2ECD28B80E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70450172BD5;
	Fri, 10 May 2024 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JiE1VML1"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3B9172763
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342389; cv=none; b=WJWgg7XlE/MmDbMNQlacROC0HDMGWWSTK+uFw/yJ7Q8eGboGB24xZs86KoTpjC6JjYynUxdGgq07tVr8EaWoewj7clbd5HJZ4q9qFz+96B/p23RSrf9Ay55ZVlwvXyiIKCnNbO6GieHYvlwITquq9LtCpAcseRsetZ6JJhlwtAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342389; c=relaxed/simple;
	bh=dPMuQ0ylNI0a5NigtOQVSMDVjzVT9ODCDReELcHdOvw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rILPFLpetQr9zBeJCYT95ZwJd5vHywLdJoamsECOQIU8T4WJL8uWzgsYD8hT0X6Pgfuruww5IJUsFdU4EjdWkqE93WUyqE7rjtsSmHnh9/DYiCGKbhoWb2nX3E0r981eO8neAKy1fy8xJ9o7lDcv8/+eqEkgxnirY8SUhs2c6Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JiE1VML1; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51fdc9af005so3106551e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 04:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715342386; x=1715947186; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YDcdiULGO3VMyvdeFdkqY9Rkq8pXSaaNzxtQ5BbPA/Q=;
        b=JiE1VML1UrDM0Ygbj5V3bOxvSEUNm9igog16pllqvgWy/S3+edL/EIqAC1u/HuM+a1
         wRkGImcHhc8jfavFYy5xUnBz3mjg30rfYeqVMrhVGHkyZdjOFK+duhdKz5WcHlexHxmB
         0R/yUtlood0f/sJgToejuEDjUtqXP0gfHhApKPa4+moQHLmsOKbsfsCT2YJpXKci/WIX
         3rOb/NjHH/5vMBKpX8qpEWEMCqXf3ssv+ICaqthAaopSSflzIntB8wl25jOwYGgOn4Ng
         eIYyFK+Fd8GxvABkFPkKpglNr5sp2dmvV2ZcbDcLzvFbAnwJPkOgpju2/EdjP3FVW7nz
         +1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715342386; x=1715947186;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YDcdiULGO3VMyvdeFdkqY9Rkq8pXSaaNzxtQ5BbPA/Q=;
        b=HKq2pt14WFUTcOnEZToTAx82RE+d5EtNNoAZFCk8hG1u9JUrOIFj2kr7AlLW27zMf0
         yHaskv8BIF1iMWTLG/C3OO6Lrq0rcJROUE1lZxywFmlUOTirJsd4evf1blld3bWS1PHR
         3k5NZ4r0vMkeqUgFvRx35jAH7CCwIyIgrAkL4QYvd9vm6LcRVkHvaJCAmYGGtK3Qz5ol
         gYcqO2/oDqNIjk1JEq6K1NgGESLiwmjphHpXKTzQoXMNgj3Odf6J7VQ2hiiC4pOd0+r9
         G8PS/tTfOcXOdUj2L4Nos5cykwxdCuf533hSlWmpd9sP+Dj+JXVjjj1WtIcIFJznDnUg
         5Z7A==
X-Forwarded-Encrypted: i=1; AJvYcCXi/9Udp+S+Lf1acLUAXJQ8L5RfkaLn1SZ6J3oWK4IpKdozMzSGqttz738hyl6LaZSH6GQOhAkd3xtSVy2NnkGyP7J2CGrn9mOH4E4w
X-Gm-Message-State: AOJu0YzVe7loDoiM18d73ElEIEFNKqvpLly1pbLmwecJgI2MDMGKuf4W
	kdzbWMjX88qFI6X+0y1wquLX6DQPcMAU9OxIOETqzhDKII+nG9zFeSrH9cZtMo8=
X-Google-Smtp-Source: AGHT+IE8reF2rvnSOauEKYFYAqbIPPgXCfSVmvV82zhQtU3WrwVDsXK2yejQb6pBFxqDbkVqws2GmA==
X-Received: by 2002:a05:6512:3c9a:b0:521:7846:69d3 with SMTP id 2adb3069b0e04-5221027858amr2420292e87.55.1715342386380;
        Fri, 10 May 2024 04:59:46 -0700 (PDT)
Received: from [127.0.1.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7df7sm176795666b.111.2024.05.10.04.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 04:59:46 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 10 May 2024 13:59:32 +0200
Subject: [PATCH v2 09/31] arm64: dts: qcom: msm8998-*: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-topic-msm-polling-cleanup-v2-9-436ca4218da2@linaro.org>
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
 arch/arm64/boot/dts/qcom/msm8998.dtsi | 19 -------------------
 arch/arm64/boot/dts/qcom/pm8998.dtsi  |  1 -
 2 files changed, 20 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998.dtsi b/arch/arm64/boot/dts/qcom/msm8998.dtsi
index d795b2bbe133..13f3c3ee2511 100644
--- a/arch/arm64/boot/dts/qcom/msm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998.dtsi
@@ -488,7 +488,6 @@ slpi_smp2p_in: slave-kernel {
 	thermal-zones {
 		cpu0-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 1>;
 
@@ -509,7 +508,6 @@ cpu0_crit: cpu-crit {
 
 		cpu1-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 2>;
 
@@ -530,7 +528,6 @@ cpu1_crit: cpu-crit {
 
 		cpu2-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 3>;
 
@@ -551,7 +548,6 @@ cpu2_crit: cpu-crit {
 
 		cpu3-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 4>;
 
@@ -572,7 +568,6 @@ cpu3_crit: cpu-crit {
 
 		cpu4-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 7>;
 
@@ -593,7 +588,6 @@ cpu4_crit: cpu-crit {
 
 		cpu5-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 8>;
 
@@ -614,7 +608,6 @@ cpu5_crit: cpu-crit {
 
 		cpu6-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 9>;
 
@@ -635,7 +628,6 @@ cpu6_crit: cpu-crit {
 
 		cpu7-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 10>;
 
@@ -656,7 +648,6 @@ cpu7_crit: cpu-crit {
 
 		gpu-bottom-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 12>;
 
@@ -671,7 +662,6 @@ gpu1_alert0: trip-point0 {
 
 		gpu-top-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 13>;
 
@@ -686,7 +676,6 @@ gpu2_alert0: trip-point0 {
 
 		clust0-mhm-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 5>;
 
@@ -701,7 +690,6 @@ cluster0_mhm_alert0: trip-point0 {
 
 		clust1-mhm-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 6>;
 
@@ -716,7 +704,6 @@ cluster1_mhm_alert0: trip-point0 {
 
 		cluster1-l2-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 11>;
 
@@ -731,7 +718,6 @@ cluster1_l2_alert0: trip-point0 {
 
 		modem-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 1>;
 
@@ -746,7 +732,6 @@ modem_alert0: trip-point0 {
 
 		mem-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 2>;
 
@@ -761,7 +746,6 @@ mem_alert0: trip-point0 {
 
 		wlan-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 3>;
 
@@ -776,7 +760,6 @@ wlan_alert0: trip-point0 {
 
 		q6-dsp-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 4>;
 
@@ -791,7 +774,6 @@ q6_dsp_alert0: trip-point0 {
 
 		camera-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 5>;
 
@@ -806,7 +788,6 @@ camera_alert0: trip-point0 {
 
 		multimedia-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 6>;
 
diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index 3f82715392c6..3ecb330590e5 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -11,7 +11,6 @@ / {
 	thermal-zones {
 		pm8998-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&pm8998_temp>;
 

-- 
2.40.1


