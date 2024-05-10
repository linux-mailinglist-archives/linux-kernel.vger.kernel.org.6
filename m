Return-Path: <linux-kernel+bounces-175752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C9C8C2470
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCCEE1F28641
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6018181300;
	Fri, 10 May 2024 12:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MCQgewoI"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D21B1802AD
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 12:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342415; cv=none; b=bQ8vQ4jjxiTZWvSqjY30oSx083oyWniEceU4j2n6wfIbKWW0PJZFNsL/O/QJovLZeBNs9Z98XedzG8mi4aXuMVpPQMgk9AECgRn4PZJUEf2QhTY8vkDw/ZEs0G+haSl2cIkZKcbMKgH+WpgJskQaLlR8J2OWtEMCt0N5b3XXq4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342415; c=relaxed/simple;
	bh=ehRFjqLWRiLNvZRnyufAqB/NWP0ieFSlY50s9E/H5JM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gJQ+REpe3eSRPb5jbUkMXS3DoU4MA4jjjebKf2OPQjUf0n7tIJ2LqL4qDbGo9Td/aOS7aYhQDnPLg+6WNU5TJEeUV4joCMOvNHmyaOx2FJoWUeAXb5K75WtZTQ82RXDOJRUEb5r3HPOXAJ5wIsGD5X/uBp7B7gnOsniTYd7ygp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MCQgewoI; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51fdc9af005so3107300e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 05:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715342410; x=1715947210; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jqWldNBkhC606D1/sb2WlbU/W4xvALOq8LBhMOZzI3U=;
        b=MCQgewoIXeCGOciHxoLlHWix8UWsSLf6ejwJD3W6aBE38rU02MDtoMxjuSdATH1avQ
         5/afT+cv/nALLrCD+rzE8NfaF69umdhL6v2t+ThMxAcS7TH6IHlcVxc1BbuvpdqLacvP
         916gfRcqlmb1ECnDifaNwZLa8D85/Q7xZG7aZlRgEeUoOs7oSZmX+NP/9UsrJC1GZ4gJ
         QSP66LktN22Py3PCZyYF/yGNeTH/iDRERqRJgSSqM9zbGfj0lHMe9lIPycsF+cYku+kM
         Z94kSkLTqPYzRQXZja8vHk1Iw/6BaVTteSZ0l7SB9LXOqVxMHtN5vN486Z0YLdOkRTwG
         i0TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715342410; x=1715947210;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqWldNBkhC606D1/sb2WlbU/W4xvALOq8LBhMOZzI3U=;
        b=tbe9Lski0PUbgLzXXaWWiXmNBeIXkD9AyTNzdRyuXAsGtVS255gKKIZQrSepNSBB4P
         0qjvM0HGLnjAgBHqcSj0bxuQKsXVLrPSmnZLUvEswO5eoX0R+llYonFsy7CKuSjouqwq
         q4gM1XK6uHWa9XCqkArmvEwftSi3TSuB8PlSWKLflJHqz6IYsEwi/yzWA4cUalJK0hAJ
         tRKfdpRVd64tUIeMrrE99gJLjSD8Ah9hpKj2KAzVySpoS0PTfF+q3I1EWzfW40+UGlYc
         dAMao1DzpObjpFJUdqk304QyhgZYygJfIROaWpdm8S6Gjx4kKza/4Z8zdQXyjI5mHnqy
         ZLTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVFzdHsDIURxrawp+opR4lVoRCwIGJmNJyEfCqN6Nf+coXNY2q8xRmErJaIGzXVkLrsfEt6KibThg3mZ+v9dhKsSeyN8JGCdL25TDVZ
X-Gm-Message-State: AOJu0YyOdiiMNhrRor4TTQf4zTFWSOb+yaJzB4Li7PEhOpSwm2z5V025
	6fci8eEroM4VVI9v67Dp+ZaVCb0bGddVZ2SrATHysdOIsYYpDxmbH2qtIefLDuw=
X-Google-Smtp-Source: AGHT+IF7rVWyxa7NuKmc9EzGfMcaE8FyPTnY8Ql+Ygkx3xCCPe6LVFTpwkyV2bSBZrKmQf9GRjvs8g==
X-Received: by 2002:a19:2d04:0:b0:51c:778f:b569 with SMTP id 2adb3069b0e04-5220fe7931fmr1627201e87.29.1715342410335;
        Fri, 10 May 2024 05:00:10 -0700 (PDT)
Received: from [127.0.1.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7df7sm176795666b.111.2024.05.10.05.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 05:00:10 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 10 May 2024 13:59:49 +0200
Subject: [PATCH v2 26/31] arm64: dts: qcom: sm8150-*: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-topic-msm-polling-cleanup-v2-26-436ca4218da2@linaro.org>
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
 arch/arm64/boot/dts/qcom/pm8150.dtsi      |  1 -
 arch/arm64/boot/dts/qcom/pm8150b.dtsi     |  1 -
 arch/arm64/boot/dts/qcom/pm8150l.dtsi     |  1 -
 arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi |  1 -
 arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi |  1 -
 arch/arm64/boot/dts/qcom/sm8150.dtsi      | 28 ----------------------------
 6 files changed, 33 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8150.dtsi b/arch/arm64/boot/dts/qcom/pm8150.dtsi
index 3ba3ba5d8fce..a74a7ff660d2 100644
--- a/arch/arm64/boot/dts/qcom/pm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150.dtsi
@@ -13,7 +13,6 @@ / {
 	thermal-zones {
 		pm8150-thermal {
 			polling-delay-passive = <100>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&pm8150_temp>;
 
diff --git a/arch/arm64/boot/dts/qcom/pm8150b.dtsi b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
index 1aee3270ce7b..3f7b0b6a1d10 100644
--- a/arch/arm64/boot/dts/qcom/pm8150b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150b.dtsi
@@ -12,7 +12,6 @@ / {
 	thermal-zones {
 		pm8150b-thermal {
 			polling-delay-passive = <100>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&pm8150b_temp>;
 
diff --git a/arch/arm64/boot/dts/qcom/pm8150l.dtsi b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
index ac08a09c64c2..3911d6d0d2e2 100644
--- a/arch/arm64/boot/dts/qcom/pm8150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
@@ -12,7 +12,6 @@ / {
 	thermal-zones {
 		pm8150l-thermal {
 			polling-delay-passive = <100>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&pm8150l_temp>;
 
diff --git a/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi b/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
index dbd4b91dfe06..5084de66fc46 100644
--- a/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi
@@ -12,7 +12,6 @@ / {
 	thermal-zones {
 		pmm8155au-1-thermal {
 			polling-delay-passive = <100>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&pmm8155au_1_temp>;
 
diff --git a/arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi b/arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi
index 1cee20ac2c9c..555e4a456ef1 100644
--- a/arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmm8155au_2.dtsi
@@ -11,7 +11,6 @@ / {
 	thermal-zones {
 		pmm8155au-2-thermal {
 			polling-delay-passive = <100>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&pmm8155au_2_temp>;
 
diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index ff22e4346660..1f597f03107b 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -4577,7 +4577,6 @@ timer {
 	thermal-zones {
 		cpu0-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 1>;
 
@@ -4621,7 +4620,6 @@ map1 {
 
 		cpu1-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 2>;
 
@@ -4665,7 +4663,6 @@ map1 {
 
 		cpu2-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 3>;
 
@@ -4709,7 +4706,6 @@ map1 {
 
 		cpu3-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 4>;
 
@@ -4753,7 +4749,6 @@ map1 {
 
 		cpu4-top-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 7>;
 
@@ -4797,7 +4792,6 @@ map1 {
 
 		cpu5-top-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 8>;
 
@@ -4841,7 +4835,6 @@ map1 {
 
 		cpu6-top-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 9>;
 
@@ -4885,7 +4878,6 @@ map1 {
 
 		cpu7-top-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 10>;
 
@@ -4929,7 +4921,6 @@ map1 {
 
 		cpu4-bottom-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 11>;
 
@@ -4973,7 +4964,6 @@ map1 {
 
 		cpu5-bottom-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 12>;
 
@@ -5017,7 +5007,6 @@ map1 {
 
 		cpu6-bottom-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 13>;
 
@@ -5061,7 +5050,6 @@ map1 {
 
 		cpu7-bottom-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 14>;
 
@@ -5105,7 +5093,6 @@ map1 {
 
 		aoss0-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 0>;
 
@@ -5120,7 +5107,6 @@ aoss0_alert0: trip-point0 {
 
 		cluster0-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 5>;
 
@@ -5140,7 +5126,6 @@ cluster0_crit: cluster0-crit {
 
 		cluster1-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 6>;
 
@@ -5160,7 +5145,6 @@ cluster1_crit: cluster1-crit {
 
 		gpu-top-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens0 15>;
 
@@ -5182,7 +5166,6 @@ gpu_top_alert0: trip-point0 {
 
 		aoss1-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 0>;
 
@@ -5197,7 +5180,6 @@ aoss1_alert0: trip-point0 {
 
 		wlan-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 1>;
 
@@ -5212,7 +5194,6 @@ wlan_alert0: trip-point0 {
 
 		video-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 2>;
 
@@ -5227,7 +5208,6 @@ video_alert0: trip-point0 {
 
 		mem-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 3>;
 
@@ -5242,7 +5222,6 @@ mem_alert0: trip-point0 {
 
 		q6-hvx-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 4>;
 
@@ -5257,7 +5236,6 @@ q6_hvx_alert0: trip-point0 {
 
 		camera-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 5>;
 
@@ -5272,7 +5250,6 @@ camera_alert0: trip-point0 {
 
 		compute-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 6>;
 
@@ -5287,7 +5264,6 @@ compute_alert0: trip-point0 {
 
 		modem-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 7>;
 
@@ -5302,7 +5278,6 @@ modem_alert0: trip-point0 {
 
 		npu-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 8>;
 
@@ -5317,7 +5292,6 @@ npu_alert0: trip-point0 {
 
 		modem-vec-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 9>;
 
@@ -5332,7 +5306,6 @@ modem_vec_alert0: trip-point0 {
 
 		modem-scl-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 10>;
 
@@ -5347,7 +5320,6 @@ modem_scl_alert0: trip-point0 {
 
 		gpu-bottom-thermal {
 			polling-delay-passive = <250>;
-			polling-delay = <1000>;
 
 			thermal-sensors = <&tsens1 11>;
 

-- 
2.40.1


