Return-Path: <linux-kernel+bounces-175808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 671C88C254F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D224028720F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424CE172BCB;
	Fri, 10 May 2024 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aCXSgKdJ"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2D5172764
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715345936; cv=none; b=Q3qq3LvheDd8C/PBeax5ejsu1UDIRfDNz86PClNy7i6mzhZSJJnexiFFbig6QE7riWzHMQBWYOatrL8byztNf6GlA/MSGtMD6XymTGRSOoke03RJ7wIlpbqqGPWEFahoL71aUuscZycbg219yVBPubLws8YxlCje2vUEprjkx9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715345936; c=relaxed/simple;
	bh=Cl7BuIrFlAl4aD4Z00HnjW4zAP6QqudUQ1OzmOr+xi0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nipGedVlVWcQqczZEHY8oKxxQJwLiHXuVgEpJ5RK0Tcprsqq3XVsWcOh93MzcLGdikTTtfVgm0ifXEUyNROC2u6d6Bj/6evn7NgKZOxt1av2dXksev59vBH+z+aXCpsytqHgLQIqD6Guw/e6gZciFlBH/E9xHrDlKnVGZzwIg0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aCXSgKdJ; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59a0168c75so524252966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 05:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715345933; x=1715950733; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GzNgccEjJJ10l5IzhJDmyxwX1t0d4Nd8C8K0mQGyahA=;
        b=aCXSgKdJRS4C4o80IYRwlowg/iIz138wZ7jcqt/AM0R8vw26yutPcjoVzyDnUsn7AX
         ETlNJEiSLSRLdYHWxqWOzQfbysg5JrZcACZ0CSsxApmRIIry2JjM7c7RsBlwX0rgQSpW
         Fql2Y7QAl1tHRQ9IYYUJqT6YujSns/sS2Kh/Mt7ROKQDckKKY1c/EgALXkP8DdMmDNz4
         BDWbcluzE8PHAs4hdlHu7KVJLxiufLY8nrOcalbKbW8eAfO4R8IYXUQ1zDv40SDXLV1R
         3nbTasOXCBvaDhri4pgs2/916LXAZmsnxj0ZipEkIfE6IhafsYGbC0Fm7Y+Bpuy52+tr
         FjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715345933; x=1715950733;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GzNgccEjJJ10l5IzhJDmyxwX1t0d4Nd8C8K0mQGyahA=;
        b=iog2Qb0Yft2MLe/ue/4yXrUEEJ2zqLmQJAN1S/46tjLkebUPdcFq0CMa4SBMilyxxu
         wzWXvfBRPHJfX3PfSpgU2Yk6UUh6k2RQ+LTYqRcAD0N9ihT8VcPz1eNdZAIHk6no/GZX
         JJZOi2R9Qac+UZ4JChsmxLg3Lunnsto9XN9wLEjo2Jfa78sWjUi2gId+xPkd0p8fFBrM
         OcrL96JCWrzVY4sRhK2C7cTz3XAFx2bgZhJSMQzkDHmN+qVCRz/fmRlDGpBlHG/rCk0h
         0vaxGUVL87rHm7pALosy0UN/oWln7ddXBW6h7bvAOkTYAi/PCxu3U6xQGmr0IWRwMDD0
         QccQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5AYjc/4qsS9AXgo9v5OE7eCEV8WmGcUEcjJkSGjzhc6duAo6Fig+1fcYBR9G3fwiC8r2RYUAdBxEYAxWTmq4RckpjF8oOFZfrd9OJ
X-Gm-Message-State: AOJu0Ywq5/pzXF7u09ktriy9bzNqLB2rfn414cmQufSX36kogTpilx60
	VMVisBDIRpW94H2CbjcsF37+vVYQtDPYarOPdIEeFr3ZInbfkfXwnMWiNXfp4GM=
X-Google-Smtp-Source: AGHT+IGz49EaXDJIZQ+dIlV387Idl3kbEJONmp6R+FnxXMvoNEpPp9bR6PYBM3a5UI0kgiLKhPl3Mg==
X-Received: by 2002:a17:906:194a:b0:a58:e8c7:c0b8 with SMTP id a640c23a62f3a-a5a2d53ad9amr179754066b.7.1715345933040;
        Fri, 10 May 2024 05:58:53 -0700 (PDT)
Received: from [127.0.1.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d6bfsm181857366b.31.2024.05.10.05.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 05:58:52 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 10 May 2024 14:58:41 +0200
Subject: [PATCH 12/12] arm64: dts: qcom: sm8650: Throttle the GPU when
 overheating
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-topic-gpus_are_cool_now-v1-12-ababc269a438@linaro.org>
References: <20240510-topic-gpus_are_cool_now-v1-0-ababc269a438@linaro.org>
In-Reply-To: <20240510-topic-gpus_are_cool_now-v1-0-ababc269a438@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan+linaro@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bjorn Andersson <quic_bjorande@quicinc.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14-dev

Add an 85C passive trip point to ensure the thermal framework takes
sufficient action to prevent reaching junction temperature and a
110C critical point to help avoid hw damage.

Also, register the GPU as a cooling device and hook it up to the
right thermal zones.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 169 ++++++++++++++++++++++++++++-------
 1 file changed, 137 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 39e789b21acc..1b20d0fcd3ef 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -2626,6 +2626,7 @@ gpu: gpu@3d00000 {
 			operating-points-v2 = <&gpu_opp_table>;
 
 			qcom,gmu = <&gmu>;
+			#cooling-cells = <2>;
 
 			status = "disabled";
 
@@ -6014,16 +6015,29 @@ gpuss0-thermal {
 
 			thermal-sensors = <&tsens2 1>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpu0_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
+				gpu0_alert0: trip-point0 {
+					temperature = <85000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				trip-point1 {
 					temperature = <90000>;
-					hysteresis = <2000>;
+					hysteresis = <1000>;
 					type = "hot";
 				};
 
-				gpuss0-critical {
+				trip-point2 {
 					temperature = <110000>;
-					hysteresis = <0>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -6034,16 +6048,29 @@ gpuss1-thermal {
 
 			thermal-sensors = <&tsens2 2>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpu1_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
+				gpu1_alert0: trip-point0 {
+					temperature = <85000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				trip-point1 {
 					temperature = <90000>;
-					hysteresis = <2000>;
+					hysteresis = <1000>;
 					type = "hot";
 				};
 
-				gpuss1-critical {
+				trip-point2 {
 					temperature = <110000>;
-					hysteresis = <0>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -6054,16 +6081,29 @@ gpuss2-thermal {
 
 			thermal-sensors = <&tsens2 3>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpu2_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
+				gpu2_alert0: trip-point0 {
+					temperature = <85000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				trip-point1 {
 					temperature = <90000>;
-					hysteresis = <2000>;
+					hysteresis = <1000>;
 					type = "hot";
 				};
 
-				gpuss2-critical {
+				trip-point2 {
 					temperature = <110000>;
-					hysteresis = <0>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -6074,16 +6114,29 @@ gpuss3-thermal {
 
 			thermal-sensors = <&tsens2 4>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpu3_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
+				gpu3_alert0: trip-point0 {
+					temperature = <85000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				trip-point1 {
 					temperature = <90000>;
-					hysteresis = <2000>;
+					hysteresis = <1000>;
 					type = "hot";
 				};
 
-				gpuss3-critical {
+				trip-point2 {
 					temperature = <110000>;
-					hysteresis = <0>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -6094,16 +6147,29 @@ gpuss4-thermal {
 
 			thermal-sensors = <&tsens2 5>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpu4_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
+				gpu4_alert0: trip-point0 {
+					temperature = <85000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				trip-point1 {
 					temperature = <90000>;
-					hysteresis = <2000>;
+					hysteresis = <1000>;
 					type = "hot";
 				};
 
-				gpuss4-critical {
+				trip-point2 {
 					temperature = <110000>;
-					hysteresis = <0>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -6114,16 +6180,29 @@ gpuss5-thermal {
 
 			thermal-sensors = <&tsens2 6>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpu5_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
+				gpu5_alert0: trip-point0 {
+					temperature = <85000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				trip-point1 {
 					temperature = <90000>;
-					hysteresis = <2000>;
+					hysteresis = <1000>;
 					type = "hot";
 				};
 
-				gpuss5-critical {
+				trip-point2 {
 					temperature = <110000>;
-					hysteresis = <0>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -6134,16 +6213,29 @@ gpuss6-thermal {
 
 			thermal-sensors = <&tsens2 7>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpu6_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
+				gpu6_alert0: trip-point0 {
+					temperature = <85000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				trip-point1 {
 					temperature = <90000>;
-					hysteresis = <2000>;
+					hysteresis = <1000>;
 					type = "hot";
 				};
 
-				gpuss6-critical {
+				trip-point2 {
 					temperature = <110000>;
-					hysteresis = <0>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -6154,16 +6246,29 @@ gpuss7-thermal {
 
 			thermal-sensors = <&tsens2 8>;
 
+			cooling-maps {
+				map0 {
+					trip = <&gpu7_alert0>;
+					cooling-device = <&gpu THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+
 			trips {
-				trip-point0 {
+				gpu7_alert0: trip-point0 {
+					temperature = <85000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				trip-point1 {
 					temperature = <90000>;
-					hysteresis = <2000>;
+					hysteresis = <1000>;
 					type = "hot";
 				};
 
-				gpuss7-critical {
+				trip-point2 {
 					temperature = <110000>;
-					hysteresis = <0>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};

-- 
2.40.1


