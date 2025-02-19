Return-Path: <linux-kernel+bounces-521422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB7DEA3BD14
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 12:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 994E7171453
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 11:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5CF1E0090;
	Wed, 19 Feb 2025 11:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ic7iNTZl"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692051DEFE5
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965016; cv=none; b=HU+iqcjuSJwLfusbHeVB9t6gfPsfg1I1vZT1xai5fumlq2oSl62jqUFSCpzYMWzx+u+r9+NeTt4xC9IaP9jR8RCiaVmpRWfa1wkV2p2UWKrSfVM904yyeG3tr+JRWPOiGkQM2L4n6QFD3k8H6YwN0bjYR+L3W5jD0Hep+9HTaQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965016; c=relaxed/simple;
	bh=33cm5WS/G6VY/dc2qmZDX/V+SsLvyzcbRcvB37CSYbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qu4AS9ZCowG6WvMJxsPCB88tIlm5CvlNy4WXLvbCIADTglV+5xsT4fDoSEg/vG9TbSzOrRmjPnzsTJaRcOvIYBoaXJvuPyp1XPlI7d4c8lUr+xdkqTQ57giXgkAYBJkAlZM+Fkd8VPhgqNK6miAwF+qahpd8W4Dn6lR/B61c4i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ic7iNTZl; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-38f1e8efe82so7269799f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 03:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739965012; x=1740569812; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0iGD8NL6kmMwxzaeqi64LDKuVZAOMW+RBizn+/JXQY4=;
        b=ic7iNTZlRIWUQj7DT5lr/73OPfswNiw2hlScvnzEoGekUAZ9m2wM3hi2uIzeDA0krn
         lNVT+INT65JfTm5PIoyTewlkclRO6HTB+O49LchJcA5nihEOXhgG2SqCSVlmrcB2sli+
         B7bcpaup8pFbv4OFAaG7BIowYvuzxD1C6fA+mCWYYyeSEqWv5TfoFvaWXn5+N30cAug8
         WBcZaIQ0qEpoxL56HVXwcMCtZruo44HLDhomCmVCRHGu1KMAs83lyNvToutpkC7Pn6nN
         Xi/sbgVVNo0ebTY20WeN20LmlQbeqsQtmUyPqwNEZf9hw/gfyIWyef6GT9QwX+W2Z20m
         mm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739965012; x=1740569812;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0iGD8NL6kmMwxzaeqi64LDKuVZAOMW+RBizn+/JXQY4=;
        b=ftyBociw1z4RTnd/2z6Ezi780dgdJg4u3fuszjZ3RViuSD0EwMpf1K6T1yztUDdAIi
         NPfL2WXGcNR6JBYkqfDUhbt3eq/XB1mBkcBKaXym2kN2DxZjkotTtbFRxDeym0DG97qK
         es7MN9p4ByMRDCOoIzsU5gKS2A8ayt++j3JE7JGt8Wdz1f/KLLtZI9X2nGCd1YwYwZr5
         Kd9AH5Dha+V2GC/3b/3RbONznjf7501QGqqUwEl1wWYkFFf6wMyB4U0yJwivufysjloH
         TXJcL2zASXyC5P6ZecUk20Co6h2aWiTkrHR+xp0PlZKBPhYg70FtZI5iGFUza6Vq3vhU
         +7Lg==
X-Forwarded-Encrypted: i=1; AJvYcCWPuyKRsVFBTGJScXpEyUVrCrvauOOdi9TlNbhP6QsBhKfjzTC4QTMuDahjwOLSos4+dI5j4FJEMaLPScQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFN5MwBoXjEZeOgRGi/hRM/wx7OenwEPxx9IFjbt41L4Gyud8z
	vRfBRf2sX4+gLAWSYCkM9sYGRY2TGORcFEnDT7FQlSfGXMf3IvZKi7PXH0N1SEo=
X-Gm-Gg: ASbGnctOWiX8i8rPOJpgCcWNmxYF0C0Rj4nTzLOjnbLsAG9KdN1qfGRgsznMJzgTjUt
	lD9CdPad/2I4Md1+Z1vECQJcwosJKVozMekdaiUfzicYLpY4nD2XlwFiGG7kAtpj4+hhqtM4ob+
	CSdmLu3DypM3Js9vXy2Z0eavQkJecRMOX6F1y3xMd42Kk2pNTU2TV/WG3xAlZ/mss4CTAve5eUq
	GSD+bgYAg3BNw1yfuMzPdcEq7+S0QgJIr75aBqRn2POxfRAmb7m7Fzj5guS3yIROHPntk368n+Z
	azFcEA0MZw01Rd9N/3f5c9oeRipJyg==
X-Google-Smtp-Source: AGHT+IGNMSOqjWnlyZLFvK6YmONGNDZANemlT7uaXrS7eZVPt8fRzXq+1z+qd/VxYr7IARiwT5KheA==
X-Received: by 2002:a5d:5888:0:b0:38d:e33d:d0eb with SMTP id ffacd0b85a97d-38f33f125f7mr17169149f8f.9.1739965011565;
        Wed, 19 Feb 2025 03:36:51 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:8630:e1af:c2ac:8a22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4399600257asm42437905e9.4.2025.02.19.03.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 03:36:51 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 19 Feb 2025 12:36:19 +0100
Subject: [PATCH 2/4] arm64: dts: qcom: x1e80100: Apply consistent critical
 thermal shutdown
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250219-x1e80100-thermal-fixes-v1-2-d110e44ac3f9@linaro.org>
References: <20250219-x1e80100-thermal-fixes-v1-0-d110e44ac3f9@linaro.org>
In-Reply-To: <20250219-x1e80100-thermal-fixes-v1-0-d110e44ac3f9@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Akhil P Oommen <quic_akhilpo@quicinc.com>, Johan Hovold <johan@kernel.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2

The firmware configures the TSENS controller with a maximum temperature of
120°C. When reaching that temperature, the hardware automatically triggers
a reset of the entire platform. Some of the thermal zones in x1e80100.dtsi
use a critical trip point of 125°C. It's impossible to reach those.

It's preferable to shut down the system cleanly before reaching the
hardware trip point. Make the critical temperature trip points consistent
by setting all of them to 115°C and apply a consistent hysteresis.
The ACPI tables also specify 115°C as critical shutdown temperature.

Cc: stable@vger.kernel.org
Fixes: 4e915987ff5b ("arm64: dts: qcom: x1e80100: Enable tsens and thermal zone nodes")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 128 ++++++++++++++++-----------------
 1 file changed, 64 insertions(+), 64 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index e349cbf6a2665695b5cc961cf9d53e7182e68e7f..9893fa8353f144e0ee723ab5312cd95aadab041d 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -8457,8 +8457,8 @@ trip-point0 {
 				};
 
 				aoss0-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -8483,7 +8483,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8509,7 +8509,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8535,7 +8535,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8561,7 +8561,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8587,7 +8587,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8613,7 +8613,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8639,7 +8639,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8665,7 +8665,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8683,8 +8683,8 @@ trip-point0 {
 				};
 
 				cpuss2-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -8701,8 +8701,8 @@ trip-point0 {
 				};
 
 				cpuss2-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -8719,7 +8719,7 @@ trip-point0 {
 				};
 
 				mem-critical {
-					temperature = <125000>;
+					temperature = <115000>;
 					hysteresis = <0>;
 					type = "critical";
 				};
@@ -8737,7 +8737,7 @@ trip-point0 {
 				};
 
 				video-critical {
-					temperature = <125000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8755,8 +8755,8 @@ trip-point0 {
 				};
 
 				aoss0-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -8781,7 +8781,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8807,7 +8807,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8833,7 +8833,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8859,7 +8859,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8885,7 +8885,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8911,7 +8911,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8937,7 +8937,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8963,7 +8963,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -8981,8 +8981,8 @@ trip-point0 {
 				};
 
 				cpuss2-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -8999,8 +8999,8 @@ trip-point0 {
 				};
 
 				cpuss2-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -9017,8 +9017,8 @@ trip-point0 {
 				};
 
 				aoss0-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -9043,7 +9043,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9069,7 +9069,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9095,7 +9095,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9121,7 +9121,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9147,7 +9147,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9173,7 +9173,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9199,7 +9199,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9225,7 +9225,7 @@ trip-point1 {
 				};
 
 				cpu-critical {
-					temperature = <110000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9243,8 +9243,8 @@ trip-point0 {
 				};
 
 				cpuss2-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -9261,8 +9261,8 @@ trip-point0 {
 				};
 
 				cpuss2-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -9279,8 +9279,8 @@ trip-point0 {
 				};
 
 				aoss0-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -9297,8 +9297,8 @@ trip-point0 {
 				};
 
 				nsp0-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -9315,8 +9315,8 @@ trip-point0 {
 				};
 
 				nsp1-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -9333,8 +9333,8 @@ trip-point0 {
 				};
 
 				nsp2-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -9351,8 +9351,8 @@ trip-point0 {
 				};
 
 				nsp3-critical {
-					temperature = <125000>;
-					hysteresis = <0>;
+					temperature = <115000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -9377,7 +9377,7 @@ trip-point1 {
 				};
 
 				trip-point2 {
-					temperature = <125000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9403,7 +9403,7 @@ trip-point1 {
 				};
 
 				trip-point2 {
-					temperature = <125000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9429,7 +9429,7 @@ trip-point1 {
 				};
 
 				trip-point2 {
-					temperature = <125000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9455,7 +9455,7 @@ trip-point1 {
 				};
 
 				trip-point2 {
-					temperature = <125000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9481,7 +9481,7 @@ trip-point1 {
 				};
 
 				trip-point2 {
-					temperature = <125000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9507,7 +9507,7 @@ trip-point1 {
 				};
 
 				trip-point2 {
-					temperature = <125000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9533,7 +9533,7 @@ trip-point1 {
 				};
 
 				trip-point2 {
-					temperature = <125000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9559,7 +9559,7 @@ trip-point1 {
 				};
 
 				trip-point2 {
-					temperature = <125000>;
+					temperature = <115000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};
@@ -9578,7 +9578,7 @@ trip-point0 {
 
 				camera0-critical {
 					temperature = <115000>;
-					hysteresis = <0>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -9596,7 +9596,7 @@ trip-point0 {
 
 				camera0-critical {
 					temperature = <115000>;
-					hysteresis = <0>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};

-- 
2.47.2


