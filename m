Return-Path: <linux-kernel+bounces-175751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E71B78C246E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158F31C2418F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA00180A9A;
	Fri, 10 May 2024 12:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gq9RYZ9l"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5771802D6
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342415; cv=none; b=XT16V4vlB+RMjILQr7mIZiO4RcZYQx1J0/CkqEHA+4pwvjEynkzVt1gQvw6WrPrDLlTs7ww9H0mUx4rWJzO6zNopT3jtNXL8rTq9vyo+2Jgx6aFtAsUVgBTAR8TvCXi8x+/93474hz7wiG+D+VATknZ0KCOxn29o+km86y3eNy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342415; c=relaxed/simple;
	bh=Kbj3u/5ZImrDMVsR3HqJAVHmw82ATJgCVmX1NNlGqZo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vz6jZgWWFIBIRi0epVa5h7Y//Edoigl4e6kRKxdt05v3idRycK+fC1KYxpPxkLz+MEYWhoqbduoya2d8boBua5j96wm1oje2UTceHxYZ0W0Q0M7hjEHBRudI1ybcP8bRoB52ux/HKo6Sg7NoyZ7FC7/1Vr78i1akvun6tn6h3/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gq9RYZ9l; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59a17fcc6bso467134566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 05:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715342412; x=1715947212; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NcerLa4pMFHxPICxM5Wv2t1Zix02REiwHEd3ZZQE29M=;
        b=gq9RYZ9l8gR+DWrV+U/HGaBAki5F31q90bJ45QQbmDrmEoANZ8VrewaNis5jgOSt6p
         UsbxtKbHgeUQzZOQ2eSXrPfNpiqvLNLCex2PKqN+HKy5KVeH7mPp25G3JWHFAIZqz3Ye
         ftHOZzI+tKJYk26am1ACn8N+/0aX8IUXRyY1rV67dfMJbI8yTJeTWInbFfIpJlmFcPdq
         jHy6faKeeQyVJCA7eq4zil3Gua4YB4k0xol+LA2FSdpp+gIjilkRTkI00mHWMZM+Hxhr
         Di+J3uKq000z9dUWRTu/xIO0GEVaL6FKGhXMtsp46j1MT6D6wnhgx/cuLr7qPNUOuSK+
         vLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715342412; x=1715947212;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NcerLa4pMFHxPICxM5Wv2t1Zix02REiwHEd3ZZQE29M=;
        b=nhHmF+M5n0+YRma5eejDGe/Jqt9jrJHGDaduIkICSvx6TiPDl7p9XJ51NDIpQNWTZl
         aHok802ChQaPzKZBjhmrQzvqjMIQ1YJWku5UP/ZXPj4kIIa/2xen57EUnSAzo9PtVSp0
         BnnVS03f0PAR14LuwcKFEdBPOzchuSA4wXYvr1uCngD3o2/is91Jr2oLzKMBZ+7wvGvz
         Pq0lmY+BZBOPnrAGuh27VHLNqTWvTldkYx04jRAq5Cp3UkzvqQ00dKBViyagwXoo5M0p
         4m8fa0Eon4pfeyNmGSQptJGdp7rW8wcUdAK7jnuUt6+c2CbKdamC179Yt42XHZrhK4m6
         NyYg==
X-Forwarded-Encrypted: i=1; AJvYcCWxUS3Ide7Xy22jr6h52yURND9Zmnq5zCGexaGTocD/ss5spm2REnLgz1YSsSuU7WJ7H1T+kc71QxapsPyndpxSHni85m1H0cvp7U3L
X-Gm-Message-State: AOJu0YxoSynP//X26nWy3D+Q09tO7Urwrk1c9+/i4rRTUbMlldiz1V28
	X4kTf92y1l0jyiNU91KErM8YqH6sWhX/6EKUskdsKmiMciqwCfb2begDz2fcStk=
X-Google-Smtp-Source: AGHT+IFgIEGWnP+p+jo9UA0VCJltJFQpHO4F7X4gOVulJrMVO3ZKxInq7wveqsU4JQefavMXDbvNjg==
X-Received: by 2002:a17:906:a845:b0:a59:9f7b:68d4 with SMTP id a640c23a62f3a-a5a2d5734eemr155334366b.28.1715342412151;
        Fri, 10 May 2024 05:00:12 -0700 (PDT)
Received: from [127.0.1.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7df7sm176795666b.111.2024.05.10.05.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 05:00:11 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 10 May 2024 13:59:50 +0200
Subject: [PATCH v2 27/31] arm64: dts: qcom: sm8250-*: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-topic-msm-polling-cleanup-v2-27-436ca4218da2@linaro.org>
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
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 10 ----------
 arch/arm64/boot/dts/qcom/sm8250-mtp.dts  | 14 --------------
 arch/arm64/boot/dts/qcom/sm8250.dtsi     | 25 -------------------------
 3 files changed, 49 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index cd0db4f31d4a..ce13fdfb0797 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -110,8 +110,6 @@ lt9611_3v3: lt9611-3v3 {
 
 	thermal-zones {
 		conn-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pm8150b_adc_tm 0>;
 
 			trips {
@@ -124,8 +122,6 @@ active-config0 {
 		};
 
 		pm8150l-pcb-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pm8150l_adc_tm 1>;
 
 			trips {
@@ -138,8 +134,6 @@ active-config0 {
 		};
 
 		skin-msm-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pm8150l_adc_tm 0>;
 
 			trips {
@@ -152,8 +146,6 @@ active-config0 {
 		};
 
 		wifi-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pm8150_adc_tm 1>;
 
 			trips {
@@ -166,8 +158,6 @@ active-config0 {
 		};
 
 		xo-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pm8150_adc_tm 0>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
index 7ef99038cb37..21b2ca1def83 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-mtp.dts
@@ -53,8 +53,6 @@ chosen {
 
 	thermal-zones {
 		camera-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pm8150l_adc_tm 0>;
 
 			trips {
@@ -67,8 +65,6 @@ active-config0 {
 		};
 
 		conn-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pm8150b_adc_tm 0>;
 
 			trips {
@@ -81,8 +77,6 @@ active-config0 {
 		};
 
 		mmw-pa1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pm8150_adc_tm 2>;
 
 			trips {
@@ -95,8 +89,6 @@ active-config0 {
 		};
 
 		mmw-pa2-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pm8150l_adc_tm 2>;
 
 			trips {
@@ -109,8 +101,6 @@ active-config0 {
 		};
 
 		skin-msm-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pm8150l_adc_tm 1>;
 
 			trips {
@@ -123,8 +113,6 @@ active-config0 {
 		};
 
 		skin-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pm8150_adc_tm 1>;
 
 			trips {
@@ -137,8 +125,6 @@ active-config0 {
 		};
 
 		xo-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pm8150_adc_tm 0>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 8ccade628f1f..1a1202bdd915 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -6275,7 +6275,6 @@ timer {
 	thermal-zones {
 		cpu0-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 1>;
 
@@ -6319,7 +6318,6 @@ map1 {
 
 		cpu1-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 2>;
 
@@ -6363,7 +6361,6 @@ map1 {
 
 		cpu2-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 3>;
 
@@ -6407,7 +6404,6 @@ map1 {
 
 		cpu3-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 4>;
 
@@ -6451,7 +6447,6 @@ map1 {
 
 		cpu4-top-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 7>;
 
@@ -6495,7 +6490,6 @@ map1 {
 
 		cpu5-top-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 8>;
 
@@ -6539,7 +6533,6 @@ map1 {
 
 		cpu6-top-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 9>;
 
@@ -6583,7 +6576,6 @@ map1 {
 
 		cpu7-top-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 10>;
 
@@ -6627,7 +6619,6 @@ map1 {
 
 		cpu4-bottom-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 11>;
 
@@ -6671,7 +6662,6 @@ map1 {
 
 		cpu5-bottom-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 12>;
 
@@ -6715,7 +6705,6 @@ map1 {
 
 		cpu6-bottom-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 13>;
 
@@ -6759,7 +6748,6 @@ map1 {
 
 		cpu7-bottom-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 14>;
 
@@ -6803,7 +6791,6 @@ map1 {
 
 		aoss0-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 0>;
 
@@ -6818,7 +6805,6 @@ aoss0_alert0: trip-point0 {
 
 		cluster0-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 5>;
 
@@ -6838,7 +6824,6 @@ cluster0_crit: cluster0-crit {
 
 		cluster1-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 6>;
 
@@ -6858,7 +6843,6 @@ cluster1_crit: cluster1-crit {
 
 		gpu-top-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 15>;
 
@@ -6880,7 +6864,6 @@ gpu_top_alert0: trip-point0 {
 
 		aoss1-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 0>;
 
@@ -6895,7 +6878,6 @@ aoss1_alert0: trip-point0 {
 
 		wlan-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 1>;
 
@@ -6910,7 +6892,6 @@ wlan_alert0: trip-point0 {
 
 		video-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 2>;
 
@@ -6925,7 +6906,6 @@ video_alert0: trip-point0 {
 
 		mem-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 3>;
 
@@ -6940,7 +6920,6 @@ mem_alert0: trip-point0 {
 
 		q6-hvx-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 4>;
 
@@ -6955,7 +6934,6 @@ q6_hvx_alert0: trip-point0 {
 
 		camera-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 5>;
 
@@ -6970,7 +6948,6 @@ camera_alert0: trip-point0 {
 
 		compute-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 6>;
 
@@ -6985,7 +6962,6 @@ compute_alert0: trip-point0 {
 
 		npu-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 7>;
 
@@ -7000,7 +6976,6 @@ npu_alert0: trip-point0 {
 
 		gpu-bottom-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 8>;
 

-- 
2.40.1


