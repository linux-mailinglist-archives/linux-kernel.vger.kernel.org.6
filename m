Return-Path: <linux-kernel+bounces-175805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 536138C2547
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:00:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09DB91F25D05
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE62171667;
	Fri, 10 May 2024 12:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wLqRh2Zw"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BD0170899
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715345931; cv=none; b=R5uhZWApJjNms8cVC6GYKBjOjtaAT6x7Ote51o+oAwB+QFkx7eWJ2oC1iYvPl04FjxsTBhP/DfQzDaqy8jncBYsFLiTxVh8npF/BPOkE60nW4RxpSTcCDg17IjRM+kGAokIJGXl4URythiYcpMpzMt13jBfpBgtiTXdB3s8Hw9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715345931; c=relaxed/simple;
	bh=M8G2mN4TaffnfNOqtxWoho4eYoLY7YRmtFMMoVV0Cck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ttg7BNHVTNAo1oUo5LOLYP2gNPJRJWgzdFqjF3Ps6V/+ZQPhIOAYEZj0b/p3vQ66LtNgudaeidxWNCcIxbfazb+fS9vqaApmrpDnctDAL6Mi2vCy2ERiIzwqM4igmYV20xVp+g0oy5+OlR8YpJ5kLad4nnCbR38oLmRlAivoy5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wLqRh2Zw; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a59ab4f60a6so443829766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 05:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715345928; x=1715950728; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=REOe2/rSmMpWIuGPFH1QLzss9p7iDlF03Wz1gvDMeLQ=;
        b=wLqRh2Zwo5rAoi6K76+WiC37pSaDINzFaw2m6kbOMtsu5MHXlVqrJcLuo90hzPunNs
         +Rk9dpmda4lGaM2EkLJNQXBgS5GjZ+abmp3l85FPJy1D3mLl+P7W3saMUj/zOiWOR2MB
         5lvgVz5ROxMGhAhF+lILDbjRNTexWSEc2lHkGWrNmKFZx71wqdj6MqXAW3zS8VVrVkA2
         H19z78kgG6cKnm9bUEGmfI2HgxWX5IlFcCEfVUlN6mv48m/7yB9SwMqMKdYEm4tsprOk
         DHOJ6HMEr4lQt3x4HKcf85OxUJRBZ97EDwEnu3tUOrXuFCMsIHvgaBgeK1ARuLA4Kk2w
         Zfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715345928; x=1715950728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REOe2/rSmMpWIuGPFH1QLzss9p7iDlF03Wz1gvDMeLQ=;
        b=X8DlFtYxUgENE0ALsIGWDwHeOVrqL34UPQy7S8sEUmC549i3XzSCrUIqlsZ9yGQ2yi
         0PejNZTdbNrf0JHfR6cUeT4dzNaP55daiLwtOWKULsARaxd1HUbcxRmZJNg+fiJ0J35o
         o7GHUeebDynerfVFjn7Qvi4FYLDmK9JfNBvWmcPTEE3MBC/ne+yPEbstr6I0uVfLgZAk
         EBa237FKxXQlqxiEdVnSyX4z8wR99YlMdQC3B9ObKhYM96h+VkoF+2qoqQ4sdZzrJYAN
         sjI8x387dZr0QiRiVO7eGymlFGYnTd9xaUxDOy/wduMsZWQHFnPjirj/ICx3aVrImB3T
         7SCw==
X-Forwarded-Encrypted: i=1; AJvYcCWSOsfkUDDK9C2nMdpFs126upAzSyZiTrwf5h8Qeyb89rjAjvnU4FVeF3CQu99CNx+FNbjO0JJP7q8pkZYl5+eJw8RuLoTKp97AHMWG
X-Gm-Message-State: AOJu0YzXLwXlqpiEyrUvDa38s34rkLan5iL3Zq2gNY2YzmuDitD/wQI9
	FqZaYIL0Es6QzHKg86lOPB6x9LO09pYIpifT7uU8ksFdsuprMWzqXV1eBYUrWRo=
X-Google-Smtp-Source: AGHT+IGmtosNKiZsmXipclDdUMX5B1eUzYiRvXVU4iJIo/8nky814hTE0SkCNKwjjcTbgLPK0VkdqQ==
X-Received: by 2002:a17:906:1992:b0:a5a:15f6:157e with SMTP id a640c23a62f3a-a5a2d53adcamr235180366b.11.1715345928254;
        Fri, 10 May 2024 05:58:48 -0700 (PDT)
Received: from [127.0.1.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d6bfsm181857366b.31.2024.05.10.05.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 05:58:47 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 10 May 2024 14:58:38 +0200
Subject: [PATCH 09/12] arm64: dts: qcom: sm8350: Throttle the GPU when
 overheating
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-topic-gpus_are_cool_now-v1-9-ababc269a438@linaro.org>
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
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 526d3c92eae8..94782180bce7 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -4259,10 +4259,22 @@ map0 {
 
 			trips {
 				gpu_top_alert0: trip-point0 {
+					temperature = <85000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				trip-point1 {
 					temperature = <90000>;
 					hysteresis = <1000>;
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
 
@@ -4280,10 +4292,22 @@ map0 {
 
 			trips {
 				gpu_bottom_alert0: trip-point0 {
+					temperature = <85000>;
+					hysteresis = <1000>;
+					type = "passive";
+				};
+
+				trip-point1 {
 					temperature = <90000>;
 					hysteresis = <1000>;
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
 

-- 
2.40.1


