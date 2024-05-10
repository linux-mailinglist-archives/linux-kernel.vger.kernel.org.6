Return-Path: <linux-kernel+bounces-175741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C1258C244E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1FC0B22F87
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013C4179943;
	Fri, 10 May 2024 12:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="idagLTot"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313F1178CC8
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342398; cv=none; b=bzEBy0D6jxN4fVGp9x/L0aaNffAnqxSpE88horKUPhexDNY+rkCPlg+IufdNCqWnuEr60glWSoCp59ydyVJ7zl8KsWRstI1dy43STHp/xLSDrWOJc70aq5nr/TlVMgfVezfS2x0ZiV64XGPJIOijHLV9Ppeo8J85xXLkSGxAHzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342398; c=relaxed/simple;
	bh=u+BlxNpy844knWBsQeHvKNxIXOqPeVH7Uh1dVKanY8Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LvQQ55/WcF3ZicExVmghdwadNGigVtLi2jAViy3/4a4Qodu51HDPndJBaPadMEPcaRaK2uktqoLe5YoMyMQrtb6mHRlaZQJbj+9Lh2bsglfLegW3pVMA+qaUgXqE3f+ZbYXSByVZUcP9MvFT0uibeERrY5JUm/O43uRsIu6fClA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=idagLTot; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59c5c9c6aeso476100966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 04:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715342396; x=1715947196; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZqPwBkB48y/IGaU4ZewJb8k/C/8/AgksToU6nDwfI8=;
        b=idagLTotIkFUCfueaBiNG7TvrGUBOT9wMZgVVHTcuuTNKK8FfEho7mjjaPU53QcWM8
         T4Mvv13xKMqBSC1DtdRejEOMK3hX8s+qXzk4MXgoz6D7Lhq0IZS/kHj+Dam0Oktk+VfQ
         kNq3uHQyQlmSAgVCQbdWqJL52WOmCt5aiCPbGoyWCGL9ilzv5Ys3k0rrPfVttpovoJxI
         m7R7gDbcgp5/VFtcQamBJrUW/en4RDvTzUMBryyK1wthRJMSBl31YOWP0l8tAb5Nc26O
         SxG2/4Aa8j6tgMjtbxrCO7oZnHtIX67YJGrdhFp7TnFJ0d4zsMnLtpbOuKrU5om35Gnb
         tBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715342396; x=1715947196;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zZqPwBkB48y/IGaU4ZewJb8k/C/8/AgksToU6nDwfI8=;
        b=hJ46Q5sMGqT3uQToQP9YYpi6xcYDA6HiB+hoTsko+mWF96LWgkVYf9r+qOh/hGEaA/
         xg/flbxQnyALQP0R/+Ik/5ZZRmiHR2gMEEj0VBORRLp5YoH0bki3DJSkDYVwZlZ3xEcz
         h6Jqc4hZFbr6PLcB/Z6C2gRoauSmpQwDLwcCwFbmN8iFI5wnC1zStBewSZKs2IcXTjLR
         VzvXi0aeinOi97TURbHZOWX1UZ/JoRrJaWVdm124BUr1+Nz2Myox0E/gaVyPpFeGmk8w
         jCNfsKGlUfLIszSbnvezR170nNSct8lyhs1FczOMVLyMnjDC6mLxcumuOUq+bDBfy2FV
         YrVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUA7jegjLFHe0OWUvnXljbMMpk+/6gbvdxOlUN+STi+tPb5Rj9PzWklw9z3pnRB81upYWvmhFH1ZAY8TVi8vJooe/ULZdDgiqzDw3zD
X-Gm-Message-State: AOJu0YwYr3/hhZELlK5ciTqPOShqYCnywHw6HFEfbEyiJW+URmRRA54d
	Q1I0jcGU8QD03zOt4yoYGaH2vce2NQJs8Yu/i01uGbhPn9Q5zNLNIuP6oHKYNAs=
X-Google-Smtp-Source: AGHT+IH+lLQuP2CIn1XUpZTKAivZO8YMzIPaMtKyiSLctQahOmlK6XbGFaSk5LHZzMOqlWWZcsuujw==
X-Received: by 2002:a17:906:30c7:b0:a59:a431:a8ce with SMTP id a640c23a62f3a-a5a2d55a7c3mr178378266b.2.1715342395579;
        Fri, 10 May 2024 04:59:55 -0700 (PDT)
Received: from [127.0.1.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7df7sm176795666b.111.2024.05.10.04.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 04:59:55 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 10 May 2024 13:59:39 +0200
Subject: [PATCH v2 16/31] arm64: dts: qcom: sc7180-*: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-topic-msm-polling-cleanup-v2-16-436ca4218da2@linaro.org>
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
 arch/arm64/boot/dts/qcom/pm6150.dtsi               |  2 +-
 arch/arm64/boot/dts/qcom/pm6150l.dtsi              |  3 ---
 .../arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi |  1 -
 .../boot/dts/qcom/sc7180-trogdor-homestar.dtsi     |  1 -
 .../arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi |  3 ---
 .../boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi  |  1 -
 arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi       |  3 ---
 arch/arm64/boot/dts/qcom/sc7180.dtsi               | 25 ----------------------
 8 files changed, 1 insertion(+), 38 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm6150.dtsi b/arch/arm64/boot/dts/qcom/pm6150.dtsi
index 6de6ed562d97..b4f4d700800d 100644
--- a/arch/arm64/boot/dts/qcom/pm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150.dtsi
@@ -13,7 +13,7 @@ / {
 	thermal-zones {
 		pm6150_thermal: pm6150-thermal {
 			polling-delay-passive = <100>;
-			polling-delay = <0>;
+
 			thermal-sensors = <&pm6150_temp>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/pm6150l.dtsi b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
index 0fce45276e5c..334f976f1154 100644
--- a/arch/arm64/boot/dts/qcom/pm6150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6150l.dtsi
@@ -10,9 +10,6 @@
 / {
 	thermal-zones {
 		pm6150l-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&pm6150l_temp>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
index 7765c8f64905..0c8a4517083a 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-coachz.dtsi
@@ -25,7 +25,6 @@ adau7002: audio-codec-1 {
 	thermal-zones {
 		skin_temp_thermal: skin-temp-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&pm6150_adc_tm 1>;
 			sustainable-power = <965>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
index 2ba3bbf3b9ad..68bc17a81d24 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-homestar.dtsi
@@ -45,7 +45,6 @@ pp3300_touch: pp3300-touch-regulator {
 	thermal-zones {
 		skin_temp_thermal: skin-temp-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&pm6150_adc_tm 1>;
 			sustainable-power = <965>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
index 067813f5f437..026d0845d78b 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-pompom.dtsi
@@ -14,9 +14,6 @@
 / {
 	thermal-zones {
 		5v-choke-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <250>;
-
 			thermal-sensors = <&pm6150_adc_tm 1>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
index 305ad127246e..3c6e958996a1 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor-wormdingler.dtsi
@@ -50,7 +50,6 @@ v1p8_mipi: v1p8-mipi-regulator {
 	thermal-zones {
 		skin_temp_thermal: skin-temp-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&pm6150_adc_tm 1>;
 			sustainable-power = <574>;
diff --git a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
index 8513be297120..4d33c3fbedff 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180-trogdor.dtsi
@@ -21,9 +21,6 @@
 / {
 	thermal-zones {
 		charger_thermal: charger-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&pm6150_adc_tm 0>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/sc7180.dtsi b/arch/arm64/boot/dts/qcom/sc7180.dtsi
index 4774a859bd7e..8bbe5c92fbed 100644
--- a/arch/arm64/boot/dts/qcom/sc7180.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7180.dtsi
@@ -4036,7 +4036,6 @@ lpass_hm: clock-controller@63000000 {
 	thermal-zones {
 		cpu0_thermal: cpu0-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 1>;
 			sustainable-power = <1052>;
@@ -4085,7 +4084,6 @@ map1 {
 
 		cpu1_thermal: cpu1-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 2>;
 			sustainable-power = <1052>;
@@ -4134,7 +4132,6 @@ map1 {
 
 		cpu2_thermal: cpu2-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 3>;
 			sustainable-power = <1052>;
@@ -4183,7 +4180,6 @@ map1 {
 
 		cpu3_thermal: cpu3-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 4>;
 			sustainable-power = <1052>;
@@ -4232,7 +4228,6 @@ map1 {
 
 		cpu4_thermal: cpu4-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 5>;
 			sustainable-power = <1052>;
@@ -4281,7 +4276,6 @@ map1 {
 
 		cpu5_thermal: cpu5-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 6>;
 			sustainable-power = <1052>;
@@ -4330,7 +4324,6 @@ map1 {
 
 		cpu6_thermal: cpu6-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 9>;
 			sustainable-power = <1425>;
@@ -4371,7 +4364,6 @@ map1 {
 
 		cpu7_thermal: cpu7-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 10>;
 			sustainable-power = <1425>;
@@ -4412,7 +4404,6 @@ map1 {
 
 		cpu8_thermal: cpu8-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 11>;
 			sustainable-power = <1425>;
@@ -4453,7 +4444,6 @@ map1 {
 
 		cpu9_thermal: cpu9-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 12>;
 			sustainable-power = <1425>;
@@ -4494,7 +4484,6 @@ map1 {
 
 		aoss0-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 0>;
 
@@ -4515,7 +4504,6 @@ aoss0_crit: aoss0-crit {
 
 		cpuss0-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 7>;
 
@@ -4535,7 +4523,6 @@ cpuss0_crit: cluster0-crit {
 
 		cpuss1-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 8>;
 
@@ -4555,7 +4542,6 @@ cpuss1_crit: cluster0-crit {
 
 		gpuss0-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 13>;
 
@@ -4583,7 +4569,6 @@ map0 {
 
 		gpuss1-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens0 14>;
 
@@ -4611,7 +4596,6 @@ map0 {
 
 		aoss1-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 0>;
 
@@ -4632,7 +4616,6 @@ aoss1_crit: aoss1-crit {
 
 		cwlan-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 1>;
 
@@ -4653,7 +4636,6 @@ cwlan_crit: cwlan-crit {
 
 		audio-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 2>;
 
@@ -4674,7 +4656,6 @@ audio_crit: audio-crit {
 
 		ddr-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 3>;
 
@@ -4695,7 +4676,6 @@ ddr_crit: ddr-crit {
 
 		q6-hvx-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 4>;
 
@@ -4716,7 +4696,6 @@ q6_hvx_crit: q6-hvx-crit {
 
 		camera-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 5>;
 
@@ -4737,7 +4716,6 @@ camera_crit: camera-crit {
 
 		mdm-core-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 6>;
 
@@ -4758,7 +4736,6 @@ mdm_crit: mdm-crit {
 
 		mdm-dsp-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 7>;
 
@@ -4779,7 +4756,6 @@ mdm_dsp_crit: mdm-dsp-crit {
 
 		npu-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 8>;
 
@@ -4800,7 +4776,6 @@ npu_crit: npu-crit {
 
 		video-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&tsens1 9>;
 

-- 
2.40.1


