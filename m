Return-Path: <linux-kernel+bounces-175803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C338C2540
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 558C01C21BE3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEFFC17089E;
	Fri, 10 May 2024 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d9eMkWgt"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A8816F8E9
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715345928; cv=none; b=dYEiTLh2mGrYehbq9/dV9HVy8dHzATWtZNxYUl1ZLjlZv0FisLEGX5sj3CSxqUii/oWYGCRYzVK5XZ8nKukhzRtl8DVpMYUidkk3TTQce0GyzjBc+xnOOKKbqZ2QIrcFHHBMBPXzXY/PdvKKQ/gqthqtngPfxvF8diJBQ8lwa4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715345928; c=relaxed/simple;
	bh=N7Z1UTqSXat0Px8O9Bf8HVTVlZ48y7r+JK1PVbiHrJU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lfrzKHkPsT7W0v1Q9xU0R/bU3jSzwZ/ue4V2j8c3gqzwksIpe3RgZWvKyAv80k2rTWpKN93ZBb1oT3NZ3doBPjsfeSSFk1+dnJ090QTZDsADOxOmZKbiJUkmvGI80bsaOEkrBlfvD2EZjzV43XUnmZM1C+HCSDOC2NXj0zxSh1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d9eMkWgt; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a5a1054cf61so506313966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 05:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715345926; x=1715950726; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+kvJ0NjI9lgZVfze2m0LNfaiMKZki2itDXIFFMMddwA=;
        b=d9eMkWgtaoLPS6D8rTcxMY2AykfIJ2xWB6ndeQ/srWHyVgzmO3oNdQljJOfdL7uPZy
         RkylE7JqD4Z/gFS3AixhvLxpRSE6gs26gPdFyKb6djl+Oz2V7T1eWlUxMCpGYluRcNgQ
         Q8IFtiYXsM8kLwlmKbKwnW4ihyXr9vbwL8DDXcSgvGxhx5iqLLmxRAi3yzEY8uv4m7D9
         bvZo1LfD9VyRg4QLJXuvmX1Pt7Q4anR0LkpY4F2HZHg9b2Qa+mLrjva1Q+qoWS0BuSm4
         fvDcP+FRErRyUXvet91/dGDcjymLrcNloclZc16vJxigbCkANHKwUP9GBwMwG4Ifz0Em
         iluQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715345926; x=1715950726;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+kvJ0NjI9lgZVfze2m0LNfaiMKZki2itDXIFFMMddwA=;
        b=cG9NPHIArzxVtYn9L5NmIH88rSCQ48bhhOumcMGnhjj8mup5OpoHIj9uMUZUoKl/Sm
         g2IKAspwRZ8PeePQpXhgFZzUHewUfn0hbFDPFsRRzURWzdGZr+GsEH3ua53NFnJImkpx
         snhtCrhQGBZxoW6T3nVkIFLXgxc7UKxa9Hm3ZMTJMtY2JhbrLwqp1BQY4CQ6OhokUC42
         zVrc39HcSQcAdB0KO/MCFJBf+Ny6h8uZWDd1UXkLG6zJyf3s2qiPUXn0Bdh3I4V/cBYy
         G2NmuoFHWGeL9+0lMJ3DpUiV4FtbC5LPsrFp7K1gucZzuscN22CCmxA+H8bjEG5SsWaH
         ix8w==
X-Forwarded-Encrypted: i=1; AJvYcCVwSmVvFCYE5OZFwr2+oDpoZZVsaRqu080g0yK3QJRxhvzguPirVUgv8gL0Tw4uoapFmxViWifg6ZE9Ev9sdJq3Y4XXda1lBCVbJFVw
X-Gm-Message-State: AOJu0YwaPeaPbluspVCoCVpmJrb4zDx7FIDrP2x6sQ133k5VL9+l4VHI
	R7bUHgSnDQcxRV7r18k4XmdmjoCHYNczSH+E2ZzJ9P2DxrNlj6Mi0R7xHAOY7VA=
X-Google-Smtp-Source: AGHT+IGalolyTJ0z7eOceIS7ntIwx3MY/OTBAactA6M5X3a/KbMMqJ+6bB9q1BJKjSHRmADdQNoQBA==
X-Received: by 2002:a17:906:1992:b0:a5a:15f6:157e with SMTP id a640c23a62f3a-a5a2d53adcamr235167766b.11.1715345925757;
        Fri, 10 May 2024 05:58:45 -0700 (PDT)
Received: from [127.0.1.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d6bfsm181857366b.31.2024.05.10.05.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 05:58:45 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 10 May 2024 14:58:36 +0200
Subject: [PATCH 07/12] arm64: dts: qcom: sm8150: Throttle the GPU when
 overheating
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-topic-gpus_are_cool_now-v1-7-ababc269a438@linaro.org>
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

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index 1f597f03107b..8e9194051283 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -5157,10 +5157,22 @@ map0 {
 
 			trips {
 				gpu_top_alert0: trip-point0 {
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
+
+				trip-point2 {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
 			};
 		};
 
@@ -5332,10 +5344,22 @@ map0 {
 
 			trips {
 				gpu_bottom_alert0: trip-point0 {
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
+
+				trip-point2 {
+					temperature = <110000>;
+					hysteresis = <1000>;
+					type = "critical";
+				};
 			};
 		};
 	};

-- 
2.40.1


