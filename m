Return-Path: <linux-kernel+bounces-175750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C910D8C2467
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBEB71C23A1C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D47617EB8D;
	Fri, 10 May 2024 12:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cT7P0K+y"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4065517F375
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342412; cv=none; b=tXb4StgDPPMz/E1svElsEWtow4n9cxrLLXL+e2JkRSpH9UhrjyzbDbWJ+pLAIs820rOxqQKjIveIHkiMBfcYBNpSyrCihLBJoKISoQP5f/tAmAgsNjPIt5TmnVY/rrbCTcYk7QtFmfzuSly0p2o0V8Cp0SlaFBgPRYGU2XGIWCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342412; c=relaxed/simple;
	bh=dM06frtinfupKHldRRk+LQ3oyFP6ldIH+IYzotGsv0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kuT+3k1DD+mIqcxJMl6Yf9FP/6wsLLFhsp0L0A4DvoP9a6N81kzziWSXcCzMfg7MkZa8Qlq2/bYQuDkvWI7EusieWoOAxItIyCYPl810uS2O/BQLjbWtK+zU4jpkb4D/4Y9EuJgyJsgu/LKDBGAHNQku1Xu3EuvTX4k6j6R8CLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cT7P0K+y; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a59a0e4b773so459957966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 05:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715342409; x=1715947209; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mwg+NmMup1QputCYoDC/r/UpIJ5EK4OLQAees3Xkvdk=;
        b=cT7P0K+ydl7WLdlidj5WwAauuBX/UtDd/Ijb/+qR4+2OBPijTJ9IuX4raQFFIUEpBM
         vXAeR8kyChVQXHfHvQ0KvzW+CWcbzPc7BkNptFqyLvedXKaCqqSyYrNnsEtnXCCzGdez
         8oKULUwmqFEKK6B/sx99hV+XHTwQh47n7Be5vlTT7fgPIDByd2S+fAAsCa2D6ZznsoMQ
         5p2jQiGJsLlxoU2AFBGE490FkMMGZX4SvU5tFUJRzh1O2rIKnAgJtfT7KwAT1659/PjM
         peFfv+pu8qb9mY+WAFAbJfjff5+++I2hZ+DFPDR9GfcMXmCD807MYWywGbKxzwy44IWN
         GJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715342409; x=1715947209;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwg+NmMup1QputCYoDC/r/UpIJ5EK4OLQAees3Xkvdk=;
        b=DIUCKSmI9EQnPiAsV3HpGp8uywiGe+0EuBZyg9ILZanVKWfqfCYTYf/LmcDXUshgu6
         TfkxRjjiQTFcBHUKyCM20N54pRNuZuNcOnkWeQnTqtRuUea9cmmQKuDPJGodb+J4vVId
         Kbl+RJZKFjlL1jdR2FT67LcLGCKJoORhRKN0qQ/8In2ogLwIOm1g6+Bw+fid5i6FaY24
         TnHL5xSsZdp9erS2XyfmSUAkjiuXQE881TRcsY25Ll6P/LJI6S/bNL2Vpg/toCQ1VHoA
         Z4U3ICzJ9Vzdewvnc8u7FOt4bnHpjXeCehyM28xLPFqoDs551XeK4qvmz6HXpJeDyieQ
         TK3g==
X-Forwarded-Encrypted: i=1; AJvYcCV2AN1stgSAZFEEkTibtp2drUeD3J3//t3M+hfLgNZVto0uqs/yTIq0Y0iLF+DgVA99pWMYJ5W4kjBHKuF1GwqZ75Mu0ERtgyHvKRKO
X-Gm-Message-State: AOJu0YyeY51T56rmL4qiM3rI7zsWuC44N2cvUZq4UBINdk58wgN7VrOz
	R3dAsIGa6XFpGzcepbrirroexiOb8wBEWPm6JKFHx1v1kQ0QtOjdUKMWbiBoX+U=
X-Google-Smtp-Source: AGHT+IGKkfh9HlLJdNmg53mc1MK1neyYvjTTFya/q/Hd2y+bRgwxfZUIhRWWzD7DkmK8TxFLpewllA==
X-Received: by 2002:a17:907:6e8d:b0:a59:aa68:9992 with SMTP id a640c23a62f3a-a5a2d57ab93mr210340166b.18.1715342408887;
        Fri, 10 May 2024 05:00:08 -0700 (PDT)
Received: from [127.0.1.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7df7sm176795666b.111.2024.05.10.05.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 05:00:08 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 10 May 2024 13:59:48 +0200
Subject: [PATCH v2 25/31] arm64: dts: qcom: sm6375-*: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-topic-msm-polling-cleanup-v2-25-436ca4218da2@linaro.org>
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
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 78 ------------------------------------
 1 file changed, 78 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index f40509d91bbd..ddea681b536d 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -1837,9 +1837,6 @@ cpufreq_hw: cpufreq@fd91000 {
 
 	thermal-zones {
 		mapss0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 0>;
 
 			trips {
@@ -1864,9 +1861,6 @@ mapss0_crit: mapss-crit {
 		};
 
 		cpu0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 1>;
 
 			trips {
@@ -1891,9 +1885,6 @@ cpu0_crit: cpu-crit {
 		};
 
 		cpu1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 2>;
 
 			trips {
@@ -1918,9 +1909,6 @@ cpu1_crit: cpu-crit {
 		};
 
 		cpu2-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 3>;
 
 			trips {
@@ -1945,9 +1933,6 @@ cpu2_crit: cpu-crit {
 		};
 
 		cpu3-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 4>;
 
 			trips {
@@ -1972,9 +1957,6 @@ cpu3_crit: cpu-crit {
 		};
 
 		cpu4-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 5>;
 
 			trips {
@@ -1999,9 +1981,6 @@ cpu4_crit: cpu-crit {
 		};
 
 		cpu5-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 6>;
 
 			trips {
@@ -2026,9 +2005,6 @@ cpu5_crit: cpu-crit {
 		};
 
 		cluster0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 7>;
 
 			trips {
@@ -2053,9 +2029,6 @@ cluster0_crit: cpu-crit {
 		};
 
 		cluster1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 8>;
 
 			trips {
@@ -2080,9 +2053,6 @@ cluster1_crit: cpu-crit {
 		};
 
 		cpu6-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 9>;
 
 			trips {
@@ -2107,9 +2077,6 @@ cpu6_crit: cpu-crit {
 		};
 
 		cpu7-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 10>;
 
 			trips {
@@ -2134,9 +2101,6 @@ cpu7_crit: cpu-crit {
 		};
 
 		cpu-unk0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 11>;
 
 			trips {
@@ -2161,9 +2125,6 @@ cpu_unk0_crit: cpu-crit {
 		};
 
 		cpu-unk1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 12>;
 
 			trips {
@@ -2188,9 +2149,6 @@ cpu_unk1_crit: cpu-crit {
 		};
 
 		gpuss0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 13>;
 
 			trips {
@@ -2215,9 +2173,6 @@ gpuss0_crit: gpu-crit {
 		};
 
 		gpuss1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 14>;
 
 			trips {
@@ -2242,9 +2197,6 @@ gpuss1_crit: gpu-crit {
 		};
 
 		mapss1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 0>;
 
 			trips {
@@ -2269,9 +2221,6 @@ mapss1_crit: mapss-crit {
 		};
 
 		cwlan-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 1>;
 
 			trips {
@@ -2296,9 +2245,6 @@ cwlan_crit: cwlan-crit {
 		};
 
 		audio-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 2>;
 
 			trips {
@@ -2323,9 +2269,6 @@ audio_crit: audio-crit {
 		};
 
 		ddr-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 3>;
 
 			trips {
@@ -2350,9 +2293,6 @@ ddr_crit: ddr-crit {
 		};
 
 		q6hvx-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 4>;
 
 			trips {
@@ -2377,9 +2317,6 @@ q6hvx_crit: q6hvx-crit {
 		};
 
 		camera-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 5>;
 
 			trips {
@@ -2404,9 +2341,6 @@ camera_crit: camera-crit {
 		};
 
 		mdm-core0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 6>;
 
 			trips {
@@ -2431,9 +2365,6 @@ mdm_core0_crit: mdm-core0-crit {
 		};
 
 		mdm-core1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 7>;
 
 			trips {
@@ -2458,9 +2389,6 @@ mdm_core1_crit: mdm-core1-crit {
 		};
 
 		mdm-vec-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 8>;
 
 			trips {
@@ -2485,9 +2413,6 @@ mdm_vec_crit: mdm-vec-crit {
 		};
 
 		msm-scl-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 9>;
 
 			trips {
@@ -2512,9 +2437,6 @@ msm_scl_crit: msm-scl-crit {
 		};
 
 		video-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens1 10>;
 
 			trips {

-- 
2.40.1


