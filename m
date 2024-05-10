Return-Path: <linux-kernel+bounces-175742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2AC8C2450
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17CC21F27BFC
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE12C17A932;
	Fri, 10 May 2024 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OqUKQAXf"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2DAF17964F
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342400; cv=none; b=dT5bNPVUhDo8K3BkF05QlTytmJYlihr4DkUVCwJVs7/ciwoodIwYBcv4q1mFEHZi/7jhsBTznvwC52SNE0rlwela53dgg0ZSEuHXH/SfJYhSWw8eFAIcoFCOxxuLCszUlo6lszRaiSSwfOKX/j6zooxC50c71Hsw8X67lbQaEoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342400; c=relaxed/simple;
	bh=AOFLkk4IFxOn/MX4UUdfkqJWXKeIJ66YDXrmLvWsfeU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sI4q1NPi6m/IuIocm2YU3Fo3VmUedM4bQuR1wnW5DEfTwkk9/0MbzPQH6ubiQk+yq8YzjUOb86VHeIgwOvsuWNa27Eutw0X4HEgudkXFP98s/MigHo1Ia8v0BjCeEQYntmNBC/BTmCOMgGjgvRaeipExzsqZA4KfzhLd0sYclvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OqUKQAXf; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a5a1054cf61so488748866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 04:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715342397; x=1715947197; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D8ZpJqGDxvOMPwn+PPKFcoTbeNu9kckhYHX6EWIzsEU=;
        b=OqUKQAXfIIYJpt51QDu8LIW9AWIiETGHPmTKotVMOV1Rgs2BzYqxf6+PzQy6qoYiUl
         rSlbJYXaVo3VhkZk8Ppbpt8v+1b2LwcJ5xJbxbuoy3wN+T5LLZATW3TPSws9qxTIY505
         kNfPODX7oNK2pP26bzrDrH/lgm6T38fApOn+GHW4G6my3WfExCAKxE03nxejEnNiwr1I
         BkTu2BRSjadDsCq8wRc2iGx5nseM+ff2Q5Q55jL5uqqco5IPoo9O4QARCWFGritTnMaR
         +KY4wQgLB3xBH3ynKjb10Ca+28YPMQSOTM+cpQxDKfphi9tB/j5+GRdRKoBIBUIC8ya6
         mcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715342397; x=1715947197;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8ZpJqGDxvOMPwn+PPKFcoTbeNu9kckhYHX6EWIzsEU=;
        b=c4IF5cYWGSrIX5K90QpRXgZaf8TVfZbQi+CU0PLrqFVuPGTcKhyIc+pH9kFY0QQZgc
         sYBA8Wkz+Q98uOWoe0rQfsLJFYvrdvmYCoxryOsKSxCvgE151q8ohpxr1TiHa/KLvnUo
         4YX7YDVGLHqNO82qv1bu+kkphO6OsuvQ9D7slV95jW4kuNnhk9UWWkvZy9bfH+VUpcp3
         moceoSWBalHdjN8JuTY7VpP+fFi2LX02fl3J9Rzbb6G/Jwuo19D/ynG4a5IP6AGG4JvF
         GOjKjSEflbTCvM1FXAEJQUAky9CSnwHZm/L/rmrcao/0Ug6eaoit7BSBKID8bWdKUd5B
         Mo1A==
X-Forwarded-Encrypted: i=1; AJvYcCVgHg6zP7tb4DA0/qG16zjgLkQDbN350utiSAxj5aDA/gPT34gkvHoLPRGb5QqTBrbuOUQEWyuwezfBbHykIgnqPQExABJjLYMCVtbJ
X-Gm-Message-State: AOJu0YxanGiK46C8O3UwMYLyKNPQay6ZDW/LrZcP1XePB4O7lYeO/cfi
	MS6orSjxjuOfyairQLUUIvnki05dH1qJVnJlagL4DjSr68d4t+1hp2PcCXXB7ZqFleC37JdzJIf
	cZMY=
X-Google-Smtp-Source: AGHT+IHxWFQSmkedkS3a+dZhZd3yX6MVWzJAf9ItZ0cxeDP2rzWp3AYqAsgOUslritLsYmOhL8j14Q==
X-Received: by 2002:a17:906:2309:b0:a59:bbf0:88f0 with SMTP id a640c23a62f3a-a5a2d55eec2mr224773966b.18.1715342397412;
        Fri, 10 May 2024 04:59:57 -0700 (PDT)
Received: from [127.0.1.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7df7sm176795666b.111.2024.05.10.04.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 04:59:57 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 10 May 2024 13:59:40 +0200
Subject: [PATCH v2 17/31] arm64: dts: qcom: sc7280-*: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-topic-msm-polling-cleanup-v2-17-436ca4218da2@linaro.org>
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
 arch/arm64/boot/dts/qcom/pm7250b.dtsi              |  1 -
 arch/arm64/boot/dts/qcom/pm7325.dtsi               |  2 +-
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 14 +++----
 arch/arm64/boot/dts/qcom/sc7280.dtsi               | 45 ----------------------
 4 files changed, 8 insertions(+), 54 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
index 3bf7cf5d1700..b5989fb4ccc0 100644
--- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
@@ -11,7 +11,6 @@ / {
 	thermal-zones {
 		pm7250b-thermal {
 			polling-delay-passive = <100>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&pm7250b_temp>;
 
diff --git a/arch/arm64/boot/dts/qcom/pm7325.dtsi b/arch/arm64/boot/dts/qcom/pm7325.dtsi
index d1c5476af5ee..6e29468505b2 100644
--- a/arch/arm64/boot/dts/qcom/pm7325.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm7325.dtsi
@@ -35,7 +35,7 @@ pm7325_gpios: gpio@8800 {
 &thermal_zones {
 	pm7325_thermal: pm7325-thermal {
 		polling-delay-passive = <100>;
-		polling-delay = <0>;
+
 		thermal-sensors = <&pm7325_temp_alarm>;
 
 		trips {
diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index f3432701945f..30b8a49528f8 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -167,7 +167,7 @@ afvdd_2p8: regulator-afvdd-2p8 {
 	thermal-zones {
 		camera-thermal {
 			polling-delay-passive = <0>;
-			polling-delay = <0>;
+
 			thermal-sensors = <&pmk8350_adc_tm 2>;
 
 			trips {
@@ -181,7 +181,7 @@ active-config0 {
 
 		chg-skin-thermal {
 			polling-delay-passive = <0>;
-			polling-delay = <0>;
+
 			thermal-sensors = <&pm7250b_adc_tm 0>;
 
 			trips {
@@ -195,7 +195,7 @@ active-config0 {
 
 		conn-thermal {
 			polling-delay-passive = <0>;
-			polling-delay = <0>;
+
 			thermal-sensors = <&pm7250b_adc_tm 1>;
 
 			trips {
@@ -209,7 +209,7 @@ active-config0 {
 
 		quiet-thermal {
 			polling-delay-passive = <0>;
-			polling-delay = <0>;
+
 			thermal-sensors = <&pmk8350_adc_tm 1>;
 
 			trips {
@@ -223,7 +223,7 @@ active-config0 {
 
 		rear-cam-thermal {
 			polling-delay-passive = <0>;
-			polling-delay = <0>;
+
 			thermal-sensors = <&pmk8350_adc_tm 4>;
 
 			trips {
@@ -237,7 +237,7 @@ active-config0 {
 
 		sdm-skin-thermal {
 			polling-delay-passive = <0>;
-			polling-delay = <0>;
+
 			thermal-sensors = <&pmk8350_adc_tm 3>;
 
 			trips {
@@ -251,7 +251,7 @@ active-config0 {
 
 		xo-thermal {
 			polling-delay-passive = <0>;
-			polling-delay = <0>;
+
 			thermal-sensors = <&pmk8350_adc_tm 0>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index fc9ec367e3a5..6fc5f9cd3591 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -5994,7 +5994,6 @@ cpufreq_hw: cpufreq@18591000 {
 	thermal_zones: thermal-zones {
 		cpu0-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 1>;
 
@@ -6038,7 +6037,6 @@ map1 {
 
 		cpu1-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 2>;
 
@@ -6082,7 +6080,6 @@ map1 {
 
 		cpu2-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 3>;
 
@@ -6126,7 +6123,6 @@ map1 {
 
 		cpu3-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 4>;
 
@@ -6170,7 +6166,6 @@ map1 {
 
 		cpu4-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 7>;
 
@@ -6214,7 +6209,6 @@ map1 {
 
 		cpu5-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 8>;
 
@@ -6258,7 +6252,6 @@ map1 {
 
 		cpu6-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 9>;
 
@@ -6302,7 +6295,6 @@ map1 {
 
 		cpu7-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 10>;
 
@@ -6346,7 +6338,6 @@ map1 {
 
 		cpu8-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 11>;
 
@@ -6390,7 +6381,6 @@ map1 {
 
 		cpu9-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 12>;
 
@@ -6434,7 +6424,6 @@ map1 {
 
 		cpu10-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 13>;
 
@@ -6478,7 +6467,6 @@ map1 {
 
 		cpu11-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 14>;
 
@@ -6522,7 +6510,6 @@ map1 {
 
 		aoss0-thermal {
 			polling-delay-passive = <0>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 0>;
 
@@ -6543,7 +6530,6 @@ aoss0_crit: aoss0-crit {
 
 		aoss1-thermal {
 			polling-delay-passive = <0>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 0>;
 
@@ -6564,7 +6550,6 @@ aoss1_crit: aoss1-crit {
 
 		cpuss0-thermal {
 			polling-delay-passive = <0>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 5>;
 
@@ -6584,7 +6569,6 @@ cpuss0_crit: cluster0-crit {
 
 		cpuss1-thermal {
 			polling-delay-passive = <0>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 6>;
 
@@ -6604,7 +6588,6 @@ cpuss1_crit: cluster0-crit {
 
 		gpuss0-thermal {
 			polling-delay-passive = <100>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 1>;
 
@@ -6632,7 +6615,6 @@ map0 {
 
 		gpuss1-thermal {
 			polling-delay-passive = <100>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 2>;
 
@@ -6659,9 +6641,6 @@ map0 {
 		};
 
 		nspss0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 3>;
 
 			trips {
@@ -6680,9 +6659,6 @@ nspss0_crit: nspss0-crit {
 		};
 
 		nspss1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 4>;
 
 			trips {
@@ -6701,9 +6677,6 @@ nspss1_crit: nspss1-crit {
 		};
 
 		video-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 5>;
 
 			trips {
@@ -6722,9 +6695,6 @@ video_crit: video-crit {
 		};
 
 		ddr-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 6>;
 
 			trips {
@@ -6743,9 +6713,6 @@ ddr_crit: ddr-crit {
 		};
 
 		mdmss0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 7>;
 
 			trips {
@@ -6764,9 +6731,6 @@ mdmss0_crit: mdmss0-crit {
 		};
 
 		mdmss1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 8>;
 
 			trips {
@@ -6785,9 +6749,6 @@ mdmss1_crit: mdmss1-crit {
 		};
 
 		mdmss2-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 9>;
 
 			trips {
@@ -6806,9 +6767,6 @@ mdmss2_crit: mdmss2-crit {
 		};
 
 		mdmss3-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 10>;
 
 			trips {
@@ -6827,9 +6785,6 @@ mdmss3_crit: mdmss3-crit {
 		};
 
 		camera0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 11>;
 
 			trips {

-- 
2.40.1


