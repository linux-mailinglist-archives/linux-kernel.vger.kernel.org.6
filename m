Return-Path: <linux-kernel+bounces-175748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF968C2462
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:05:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 749FAB26E88
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9FC517F367;
	Fri, 10 May 2024 12:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZEqCSvl/"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9CA17EB8D
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 12:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342409; cv=none; b=nLRvKl3rVenm7+IhJ/JPsC4I4wxUQFTFuBcjRTE51ACbAMYFQEpsftbbcfNz+4w/7YS9/KtyJVC2CiujB/eLhbJwriay9iSqdH4SmToog3BBiPkKXJM8oNRQzwjEdC+BUIgRHeAR2hP3tWAdGpV/oQsY67D9T8/MTckOXoWKbNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342409; c=relaxed/simple;
	bh=n+li2cwWHgRrKcECYbFORheOLf9HHut1ebd58z5RuxM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZB5+6V89dABiuZOZXzJBx0vp5QSaJIhfEgzWRXgP0bBIREiFTBcKPdePc4Vg1Twh7VyfGBK2EGl6TME8S8hdLdB7HY6GlunUOjCXcx3YafZwvs4S92r5UP+Yw80+9efeaR7BIMHbKcbhlG4vMDipVhbmaaVv+qjnBrrXbL/VXRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZEqCSvl/; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a59a64db066so497566066b.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 05:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715342406; x=1715947206; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MdLq6ANhotzD8Wq7SzTk1LdXv/mLsg3mxNzxsft68D8=;
        b=ZEqCSvl//8WdeL6iJmWVIgH/P6MV3/SoQ05zGIKkraqaf0xf3GGD1dVawXui4ywkaU
         vlkaE4xaifaGJI70PKixYr5qIMV97hCIRpZ3D/eMFsEme506msvSekQF7b31cpoXMODI
         Y97h7wkwO5ZGR87OHzJCd5o6lSsy3Lr3mxjeCw61cgVC1gclEptkkUcviHhBhORmg1KB
         hcbxxVJAp99JI+so9Q1Mbe71KyLX7FqCFoHlpnh9l/MCLEOe+tiMvOT8qda9CLOSXu/0
         MA9JXQQXIuXO3GZ6vFku/Ug3YTJBegc3BdM79GV7MM+fOt1ULIvY38UB8lumTMBSxKk4
         2KnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715342406; x=1715947206;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdLq6ANhotzD8Wq7SzTk1LdXv/mLsg3mxNzxsft68D8=;
        b=ZyUw+QuOlYyVU4YmAsHfG2H0ToM7CYMRJB3owJPyCrh1bxBroaoB2z7LN+ls6yVXaa
         Fe52OLVH84DcrVVCFR+4qbR9G8yezZ8s5xdnzzHH71OGHGKDg+scOc7+MYwjerQjeLq5
         w3TvP0owo8dRSBjlGOi87Kb+mCoJs+ufaUoLoH1X9MaJxZg0p4b/a6Ak9cabrVgpu+tr
         vp76N+wUR+ZmvZ+4hRkJXwhgzg/CyEK6Ofx8sv4lmuSjefB5MXCe5+koK9y7nIFDHxOP
         n4d7BUSPfU8TzKycX9vSVKz/Y+OmRkSIEwVZnbDcEt43VP5EHOyGeR50FaHGZeLboiDe
         Zc8w==
X-Forwarded-Encrypted: i=1; AJvYcCWLfNa6VEfxSvtIiVXvZjRidyAgtMLHO4s6BD0/OEyRxzoXbBkTOx54OSRvLFterKZBgj2dQBuGLf5Ajuo+GqL3UyQ40fk54utIJLvW
X-Gm-Message-State: AOJu0YyydQRThswTjQzMkIrdKlR2NP69oWgkWrx0sY3bu+A5Sy5gvEvr
	E8sZ0KG2fftmH30m2rmlqmH3cmW7SeVP5WrLqKqOijKRQS5UWjMwCC05qnoXgSo=
X-Google-Smtp-Source: AGHT+IEsEqN3TRFOD/nnvZ40YR3rbIDItI4fD/WsLeqnkGOepf3Ywd3tBX/71W3SRx32hKlC2elU1Q==
X-Received: by 2002:a17:906:6415:b0:a59:adf8:a6d5 with SMTP id a640c23a62f3a-a5a2d6786fbmr158452666b.72.1715342406021;
        Fri, 10 May 2024 05:00:06 -0700 (PDT)
Received: from [127.0.1.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7df7sm176795666b.111.2024.05.10.05.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 05:00:05 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 10 May 2024 13:59:46 +0200
Subject: [PATCH v2 23/31] arm64: dts: qcom: sm6125-*: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-topic-msm-polling-cleanup-v2-23-436ca4218da2@linaro.org>
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
 arch/arm64/boot/dts/qcom/pm6125.dtsi                         | 1 -
 arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts | 8 --------
 arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts     | 6 ------
 3 files changed, 15 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm6125.dtsi b/arch/arm64/boot/dts/qcom/pm6125.dtsi
index 99369a0cdb61..d0db28336fa9 100644
--- a/arch/arm64/boot/dts/qcom/pm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm6125.dtsi
@@ -10,7 +10,6 @@ / {
 	thermal-zones {
 		pm6125-thermal {
 			polling-delay-passive = <100>;
-			polling-delay = <0>;
 
 			thermal-sensors = <&pm6125_temp>;
 
diff --git a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
index 08046f866f60..dcd05f303b78 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-sony-xperia-seine-pdx201.dts
@@ -90,8 +90,6 @@ cmdline_mem: memory@ffd00000 {
 
 	thermal-zones {
 		rf-pa0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pm6125_adc_tm 0>;
 
 			trips {
@@ -104,8 +102,6 @@ active-config0 {
 		};
 
 		quiet-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <5000>;
 			thermal-sensors = <&pm6125_adc_tm 1>;
 
 			trips {
@@ -118,8 +114,6 @@ active-config0 {
 		};
 
 		xo-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pm6125_adc_tm 2>;
 
 			trips {
@@ -132,8 +126,6 @@ active-config0 {
 		};
 
 		rf-pa1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pm6125_adc_tm 3>;
 
 			trips {
diff --git a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
index a49d3ebb1931..994fb0412fcb 100644
--- a/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
+++ b/arch/arm64/boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts
@@ -84,8 +84,6 @@ key-volume-up {
 
 	thermal-zones {
 		rf-pa0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pm6125_adc_tm 0>;
 
 			trips {
@@ -98,8 +96,6 @@ active-config0 {
 		};
 
 		quiet-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <5000>;
 			thermal-sensors = <&pm6125_adc_tm 1>;
 
 			trips {
@@ -112,8 +108,6 @@ active-config0 {
 		};
 
 		xo-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
 			thermal-sensors = <&pm6125_adc_tm 2>;
 
 			trips {

-- 
2.40.1


