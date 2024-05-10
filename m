Return-Path: <linux-kernel+bounces-175738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CA88C2444
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 14:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25631C2454C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 12:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0001817798F;
	Fri, 10 May 2024 11:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R2U5veYu"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFFA174EFB
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715342395; cv=none; b=IMJQCg+nX0VGsGdLBUexYk+n5pH/+WuNpspw+vt4XTAwmAjY1EZPhM7IPIcXkMYrTUtNtmuoCEXmqySKlgScH4fsakV9vveqlVTrkjrvjLz45pGpierJ3129IenM4fbIMERRX/aTjnhb6DEx6VMOfyTKHkiotfDRuoQgE4eQiNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715342395; c=relaxed/simple;
	bh=5CSw9DLoFQwug4L1mYX3ngIFb/t4mhjPkYRZKMe1FUA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MyyYBiwlCliiy6Em9MtA77X5oXshUaoQz41K3G4o/ovNeyGOyr7wwt4sxdjTwFeXhXelXL9p6WRArPQrFZnBayWnlIPplBKtRqVXTXJU3rZWvAXqwfGCvT4Z7CmK0oGB7qSkqRUNrtQ2Fs240KtL2bfdWgZo8LLPWqPISXrulZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R2U5veYu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59cc765c29so433238566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 04:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715342391; x=1715947191; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FuVEvcZ73sR11OO61dwu9pTyz0Xsj1eoAqJzsVpMEhw=;
        b=R2U5veYuWqy0GrdSjgKW5JB9015oeGjXuJFBbWoLg/sKIrJLgVt0eoZaMqoKRk+ZG1
         IUpIIgO2XzK0WDCBXZChqjjFxBitibk+Fb6bF+9dxE6CUCqGVDd8BUJBQeK6eLLPKcTR
         tb9mnd3xfk2gVpo0aMKRlAa7KQhQ5XCstN9TU7nY4nEElJsXZgybNe9sF0RkBQCTYU81
         +XDZFYoDCj33LDkDmEtKGVV3objyCaCLyH2MnRBZlsPD9wMOJKHLx3mE9u5j+WFLJqzx
         hwB65BbhfWbgUmOI9gkkZFCs1Jxu9QxQOVgh64pmjnjT2iDvzlcnVIIZeyo8SSZrnIho
         wYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715342391; x=1715947191;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuVEvcZ73sR11OO61dwu9pTyz0Xsj1eoAqJzsVpMEhw=;
        b=V0rXCswWP+YzFjbvQeJ8pRbr/EBDNf7NJ4FLZpokNImAhymoIM8Kxamq87RnKh6eib
         BNmflSzZIn9Ooc8ZFixetDbV5tADS280tVd57hpSvlwQH0ahwoB1ri6/GwnMiFh1sbYe
         OkkzOc0ik5Pn8otIn0J/hA0adUM2tVyTLThgAuM5WqTwZJ/ikS03A6IfliPXR+r4Dfbt
         qDWls2rm9867FFMUMmFaKseOsRLWboDnmIXZ6VBrFDhc1GQ5bnB4AW9jy4iOC4w2xYmG
         cUrUiHOGG1A7hypvxKSrmE+JQXTGdG8vIYJM8R8yM0b4OlEngohXBbkuBkJtNN+lAce6
         Fkqw==
X-Forwarded-Encrypted: i=1; AJvYcCVb/8M1CThkAyQWspScXIUNwPC/vqU30Sl4OVUPWgX5iweXnZ1s3cJ40VaB3O3QEtkq3DxXTaGXKHbJt1ZUK60IX5zwDOuatQX6tN/p
X-Gm-Message-State: AOJu0YxNnBxnutCWaH/GIDL0jlMgH1q0tv4wP8Xo787Eben0ShxzMEJ6
	mC0an0zSPHLLQfw5GGMtZGlHC5SkaFmbZbQRqCL5pWJomrQWiSMoVwhc4hsVGEU=
X-Google-Smtp-Source: AGHT+IGNjE5VODPCkm0AnGnT7XxC6dXH0eF6PF4HcpdsXTM1X8hp1li7g8QxZBCjjrjLHoiWq0Htiw==
X-Received: by 2002:a17:907:76d3:b0:a59:c7d7:8b0f with SMTP id a640c23a62f3a-a5a2d57a717mr160952266b.29.1715342391690;
        Fri, 10 May 2024 04:59:51 -0700 (PDT)
Received: from [127.0.1.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a179c7df7sm176795666b.111.2024.05.10.04.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 04:59:51 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 10 May 2024 13:59:36 +0200
Subject: [PATCH v2 13/31] arm64: dts: qcom: qcm2290-*: Remove thermal zone
 polling delays
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-topic-msm-polling-cleanup-v2-13-436ca4218da2@linaro.org>
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
 arch/arm64/boot/dts/qcom/qcm2290.dtsi | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm2290.dtsi b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
index 106110a9f551..e1d176b277ce 100644
--- a/arch/arm64/boot/dts/qcom/qcm2290.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcm2290.dtsi
@@ -1924,9 +1924,6 @@ lmh_cluster: lmh@f550800 {
 
 	thermal-zones {
 		mapss-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 0>;
 
 			trips {
@@ -1951,9 +1948,6 @@ mapss_crit: mapss-crit {
 		};
 
 		video-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 1>;
 
 			trips {
@@ -1978,9 +1972,6 @@ video_crit: video-crit {
 		};
 
 		wlan-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 2>;
 
 			trips {
@@ -2005,9 +1996,6 @@ wlan_crit: wlan-crit {
 		};
 
 		cpuss0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 3>;
 
 			trips {
@@ -2032,9 +2020,6 @@ cpuss0_crit: cpuss0-crit {
 		};
 
 		cpuss1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 4>;
 
 			trips {
@@ -2059,9 +2044,6 @@ cpuss1_crit: cpuss1-crit {
 		};
 
 		mdm0-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 5>;
 
 			trips {
@@ -2086,9 +2068,6 @@ mdm0_crit: mdm0-crit {
 		};
 
 		mdm1-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 6>;
 
 			trips {
@@ -2113,9 +2092,6 @@ mdm1_crit: mdm1-crit {
 		};
 
 		gpu-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 7>;
 
 			trips {
@@ -2140,9 +2116,6 @@ gpu_crit: gpu-crit {
 		};
 
 		hm-center-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 8>;
 
 			trips {
@@ -2167,9 +2140,6 @@ hm_center_crit: hm-center-crit {
 		};
 
 		camera-thermal {
-			polling-delay-passive = <0>;
-			polling-delay = <0>;
-
 			thermal-sensors = <&tsens0 9>;
 
 			trips {

-- 
2.40.1


