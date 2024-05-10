Return-Path: <linux-kernel+bounces-175806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AB78C254A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B04E42869E5
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63995172760;
	Fri, 10 May 2024 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+NSkcVY"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F7E17108A
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 12:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715345933; cv=none; b=DrFsRLnfnBBojS1ibA3w+1NMGkNZsSh0j6Q3iVAf9iFlJSbjTXfyff2peeTpNtzdmBLXd96xYL7TfUVYJVK/CjOIvEfnowuCgScwbZKlcJC+OhymH5OejDflj/ivrOD1rHpH8IpTo2ZEqk+kYev5F9dWR6IEJ0TpvwQyq3f20YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715345933; c=relaxed/simple;
	bh=ahnPT653i4P3yBKIsubPh2pxiiWDa4+WxBcxEAxXX1M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OBr0lHkn67r02Vv2mLqnuoO8tfHqO0AP+TVy50OBo6O02y1uVbBaxDt268E/xNTo1rlrcpyzV6+F/Vzy50doaBG24AtgSHPfBU2UxZcMNxJihbFHhvvRchWso4OTbpxfC8gxgAddSbe0ZBhMiWopfCUqmLaGRIAKF7FZYj6sSrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C+NSkcVY; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59b178b75bso410861266b.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 05:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715345929; x=1715950729; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lK/7BWX9Y0nvD7QdHzfYOrPNJBMxWT+Wj9Jc9yOJ7ow=;
        b=C+NSkcVYRw1yU6u8Qrmp9jkbWC//3TcCiCyvGIemh9q9plKZqJZjYeMDIQJur2/IME
         QTkBADHuy/l1VN2+ybubn+JDJOgBHD0esUPSwswgRaMZkregdsSb2+eruQ2CTAwp8CFc
         oVjhY0mpAnGiAhR3w7Egk6wQ8YEUkfWD+t4sO5817kpzTbc8ya/pC/H2Cg8ElyFN76Qj
         ab2v0ZznSsVuPDYXXUxT0fEMA4UQUlrSntfNC2Gh78VKdfs6Dpy4b5cy2joNrucsHJYS
         VTX2KkpG87m3RSw2/UwBK4QCFnkCJ3gttjmyzkw4pZlgqbYHVMcg8uhfyVNRAqwHK7HB
         yAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715345929; x=1715950729;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lK/7BWX9Y0nvD7QdHzfYOrPNJBMxWT+Wj9Jc9yOJ7ow=;
        b=FYaGLaE7keboj8EdAH0qNnVDmnZwfNJdyzlDRbdxRE/o1giyrqJInNNSn75TecvVIZ
         FSEjDNwHkOOqSJaQatSh3EeXJoHbhsCQhIAZo8oNZc9O4WQmZ/xH4yzX8fSvzHdMsQNM
         fH1JX9fBGh5eBzC6swYjCngqZe/CvKKoQgfj6y0tEUPR0ibRP9U5CcTRGl5YJrJtr03c
         E8ixY/tVLEJarmAEBB/jh5c+dYMBKhNPBmRz9cHhl5Uw4R1AZOkUaXs2mJS/LM0kiu26
         KNiXtNRAT4jvT6YEqSW4jybrxlrnhwt0ediUY/YCfUmkpvycOOf9rYBlVV4wxasTBxnp
         eigA==
X-Forwarded-Encrypted: i=1; AJvYcCWWqXrI65wz8JFlZlNbywLabRM0ZXu8Ocy3ZOSFmEmbs9iPdLsICbh5QMws79ptZGHmeX2Pc2H3l454oxIfWzakCMh0OBqKJBuIKloC
X-Gm-Message-State: AOJu0Yyv2Wly3Cn8btNSYB5Gs3jkegi8lHqqnzgEDaTJXaIUSfGaBowd
	s//ubrqbRYTXKXolLSpvHKaCi/LAt7yJy0In3p2dguZTPb7kkZsiExomk+NNfIk=
X-Google-Smtp-Source: AGHT+IHKOpovGI5VphV3uLsVQmzdZyHyTEMnWFhb29n1MWn9SfqDm/GS+pvSKWIWCe5hMFJVhvUzgA==
X-Received: by 2002:a17:906:4ed0:b0:a59:c8bf:1269 with SMTP id a640c23a62f3a-a5a2d5eebf4mr178676766b.37.1715345929554;
        Fri, 10 May 2024 05:58:49 -0700 (PDT)
Received: from [127.0.1.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d6bfsm181857366b.31.2024.05.10.05.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 05:58:49 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 10 May 2024 14:58:39 +0200
Subject: [PATCH 10/12] arm64: dts: qcom: sm8450: Throttle the GPU when
 overheating
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-topic-gpus_are_cool_now-v1-10-ababc269a438@linaro.org>
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

Remove the copypasta-from-downstream userspace governor entries while
at it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 48 ++++++++++++++----------------------
 1 file changed, 18 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index ee60fd257efe..38e8d3e9dd43 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -4928,28 +4928,22 @@ map0 {
 			};
 
 			trips {
-				thermal-engine-config {
-					temperature = <125000>;
+				gpu_top_alert0: trip-point0 {
+					temperature = <85000>;
 					hysteresis = <1000>;
 					type = "passive";
 				};
 
-				thermal-hal-config {
-					temperature = <125000>;
+				trip-point1 {
+					temperature = <90000>;
 					hysteresis = <1000>;
-					type = "passive";
-				};
-
-				reset-mon-cfg {
-					temperature = <115000>;
-					hysteresis = <5000>;
-					type = "passive";
+					type = "hot";
 				};
 
-				gpu_top_alert0: trip-point0 {
-					temperature = <95000>;
-					hysteresis = <5000>;
-					type = "passive";
+				trip-point2 {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
 				};
 			};
 		};
@@ -4967,28 +4961,22 @@ map0 {
 			};
 
 			trips {
-				thermal-engine-config {
-					temperature = <125000>;
+				gpu_bottom_alert0: trip-point0 {
+					temperature = <85000>;
 					hysteresis = <1000>;
 					type = "passive";
 				};
 
-				thermal-hal-config {
-					temperature = <125000>;
+				trip-point1 {
+					temperature = <90000>;
 					hysteresis = <1000>;
-					type = "passive";
-				};
-
-				reset-mon-cfg {
-					temperature = <115000>;
-					hysteresis = <5000>;
-					type = "passive";
+					type = "hot";
 				};
 
-				gpu_bottom_alert0: trip-point0 {
-					temperature = <95000>;
-					hysteresis = <5000>;
-					type = "passive";
+				trip-point2 {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
 				};
 			};
 		};

-- 
2.40.1


