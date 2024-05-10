Return-Path: <linux-kernel+bounces-175801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CFC8C2539
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1BA81F25DF8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B4E12CD99;
	Fri, 10 May 2024 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DUV9Yfud"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BD912CD98
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715345926; cv=none; b=j11qTVqRi5f7bJ6tzM3FqFiDfFRJU1IQef/Mxf6VyMy2U+YJzcdVDSLVwFX2s455fJiVy8UmcgICgwQgZIMMTT/PvNFRMnGztCuBqIZQTg5Is3lnSU6vV3gFr4E9QjnOGVcxGt5iLLROYDv0WTorSKctPj87/DJkSB0Tawk5AAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715345926; c=relaxed/simple;
	bh=xr4WOE90b0yFT70mlWTOrZUkB4FzmYThMvJB/hOW8og=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ItN2FT4d/+aD6yoAxULod2oVpPP1DqDWyAppHZrkgSboySZCIJsxerPoJ8f84ytKtU0HedtLz9+6vmQ6qR3MwTpJXaYxXdn1J0L2RdCy6/bo/XkBhC6ivzfzy8m16eSXxs2704+tXOKCotq8h+t97Hg39/otiTLuvz1rs/Ct190=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DUV9Yfud; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51fea3031c3so2749502e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 05:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715345923; x=1715950723; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OCBtongGKMs+efoOjSpIIFMYyV9OANLuyMGYx1s4Pl8=;
        b=DUV9Yfud8E0o1IPy9ww7n1kge1KStCDFJEXjML469Yu5FTDxm0i/x7uGd+39GGQ9QZ
         T6sAX2rnzLM4Sl/tnyBgGRlSaGJXpdpKqr57G+IvDb0ZprNLj5OYhlOmTYGN2OtoA50i
         trdBpux0MNVi9ubugp2gHQyWUxIC8kts0CxBfbH0YRB72cXDErW69kUWGKxlHR1fNcES
         DHSI8lcpPwacyv7JAl7adkfhcZobWc/GCaBwme5qiZ6XYVcy3nNF/3USdrZyk6s62dIC
         2YE6D1GhYho3a6yEVJ857DuFrxP3okPGrYaVZO9UxGhb9IhG0Xs0ESGamdyOhyv/DWdL
         Y8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715345923; x=1715950723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCBtongGKMs+efoOjSpIIFMYyV9OANLuyMGYx1s4Pl8=;
        b=DACZwTBu/2TPX1ksnN0WwV71vrFp+3x5q9LXxpj4FKRBs6rdjZ8DHB3UQRUcnuPptI
         oaKKEkH2jbL71ckdBitLFJr9umRVGl/CuCSA5T3PQ5QD0WpaX8YdiaTSdJ0ZCJywEKTj
         lezgtqk46ObC1/ZOzl62xq5pSaHr6HStwSTCS9o4o5MsGqMKBvjeY6F16aeOgeRlWKlE
         hPIkudkwrC2dxqbwFzdhQC76NOSaYOAdyUmcF8dfaOoObLbOlK90d2f6AbXom7UNTFRV
         5uPCFtpZ9eia7SU95lkelSDap8+v+AL8CJSQEXNB+ZOKlLdfV7pUfhxbAN9U11+Mbk9E
         AhVg==
X-Forwarded-Encrypted: i=1; AJvYcCXz52eUbACtHhEDpMhp6Yno9etLlMM8Ytw8/+nPCCCqS6Pt81zEifDgh82tW8X03t6gftdzsVjeikMg8VZSiI/7j03RpVuA+5TSFNLq
X-Gm-Message-State: AOJu0YxQrpnz5FV4mtoI4bttnMiz57i7iWcaB41RcavRR35okS9hZfGG
	dYPtg3mowGAZyq2pqa8axwkspX1NPeLq8bRnzqLSLcpTOL6vYbEJ3o3fwDpQ6B8=
X-Google-Smtp-Source: AGHT+IH+YN13W0D8aUVsryu7SpYiRt5r1DezyR4hziV4BMefqRfWNCNwspAQXdw4tb+xT2vetrmyhA==
X-Received: by 2002:ac2:4c50:0:b0:51c:d1ac:c450 with SMTP id 2adb3069b0e04-5220fc7c5camr2948565e87.10.1715345922740;
        Fri, 10 May 2024 05:58:42 -0700 (PDT)
Received: from [127.0.1.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d6bfsm181857366b.31.2024.05.10.05.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 05:58:42 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 10 May 2024 14:58:34 +0200
Subject: [PATCH 05/12] arm64: dts: qcom: sm6115: Update GPU thermal zone
 settings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-topic-gpus_are_cool_now-v1-5-ababc269a438@linaro.org>
References: <20240510-topic-gpus_are_cool_now-v1-0-ababc269a438@linaro.org>
In-Reply-To: <20240510-topic-gpus_are_cool_now-v1-0-ababc269a438@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Johan Hovold <johan+linaro@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Bjorn Andersson <quic_bjorande@quicinc.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.14-dev

Lower the thresholds to something more reasonable and introduce a
passive polling delay to make sure more than one "passive" thermal point
is taken into account when throttling.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 0a0bb5310849..afa08dd0dd69 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -3323,6 +3323,8 @@ trip-point1 {
 		};
 
 		gpu-thermal {
+			polling-delay-passive = <250>;
+
 			thermal-sensors = <&tsens0 15>;
 
 			cooling-maps {
@@ -3334,13 +3336,13 @@ map0 {
 
 			trips {
 				gpu_alert0: trip-point0 {
-					temperature = <115000>;
-					hysteresis = <5000>;
+					temperature = <85000>;
+					hysteresis = <1000>;
 					type = "passive";
 				};
 
 				trip-point1 {
-					temperature = <125000>;
+					temperature = <110000>;
 					hysteresis = <1000>;
 					type = "critical";
 				};

-- 
2.40.1


