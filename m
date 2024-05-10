Return-Path: <linux-kernel+bounces-175802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 455B38C253C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5E2F286FF7
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C2B170844;
	Fri, 10 May 2024 12:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bRh6CPD4"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1231311B9
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 12:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715345927; cv=none; b=t8PdJdUxgQ/wXwYGheR3dI8UEKpXcUpi+Tzs9I6OKN98FkzAaWiRDptEcBrDQedOO5qNiJy2RsCDwqVgvLK6msZqxIee1+kMS9i1oEzj6PSJInrBYR7hyZw2suaUUAUiaFxRwFLDcV9ssbivK6b1/8SMvQvOLDVqNWvDvKXHXmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715345927; c=relaxed/simple;
	bh=bRUdpwvsxjVEA+bEIQiwaB+/SrBiEO/590bU96RlLgI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hFdc2vjameUQ0iebK8Wv09UN+tqzWSt/t/RxzjLAp9Tp1eumWpFobWanGptisssXGI5NYupQizaUj96dKHSfFOQpyKFwROL6ml6aXkCsgDWJGXLjBCjuBoV2JqalclKaK7exjZnTzIbo8Z5MahV9+9OXZ1xyhsJn/4utkaoWdb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bRh6CPD4; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a59b097b202so467324866b.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 05:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715345924; x=1715950724; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tv5Or4RfPJ0awNc1s7KQ9nHBJpQAMX0v2SVx0hn6YRI=;
        b=bRh6CPD4nhn8Q+FjDTxNcSuUg1zKmgfSdqStowhgu0YH9MPfXu+Av8EhcaZKxlwTU9
         ZVcSs1GBIVP8fYcyv0cTGvhMORTymYbz0PDLaNsRGqIRtZFMgy/NQ+ZXfz/ab5fDeNmx
         iogriMiCGMszOJlOnA5aSdtuEl5F90nN24/82pgeiNMFZ/ayONV5L7CsnVMn5Lqg5flU
         vCxOzGfg2NagcMktkdws0r9wtQ76a4ozOt8vHtyoDraH+v0xZOoqbAL0zWfpEwBoMsZT
         kwiKtT6fTkFVxyqSaf6bSTYUlK3EErEbcqWKvcbbe4c+dX4RJ097gfZgpwNGpRfiApud
         rlYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715345924; x=1715950724;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tv5Or4RfPJ0awNc1s7KQ9nHBJpQAMX0v2SVx0hn6YRI=;
        b=UICbubH9b9FCWfaQBjofqIWPxriVQDE1qlHfykO3/V2UQhBvoTPbEba9QIV+XcWE1P
         wax9T8qI8spTurXck2PaHpnGy+M8xqT7uc939r4dGLskmcgV/wiTXldhnwqsHnysxAsT
         OlE+Nzb5yEABtUfqSFL5/1jg4NM5PrsslN5Uvo1qOBZr/RRkPdt3xdzsn/mDTAm/AOyN
         jXNXmLxL2PPQZNfNFr8oYF0Faib1w1Pelgbg2HYO7h8fCCVxXP8jv9U5qvaaQ/ItNxnl
         GcN2NVXBV+nbFJ1iAbj0kuzYuXlb5eZ7gJK0FHK+nM1W9rwPI4BULFWGdE66sgoKTY0J
         4AEA==
X-Forwarded-Encrypted: i=1; AJvYcCXevt0Tm2z2wF5TNa1mGZ56UBfVYq3Rz8zYzzFIWGkBeIZ/y0eQz0los7lncY0yoW3fouROw732gbzWkioFf2Hj4cjWSXQJFyqAZll8
X-Gm-Message-State: AOJu0YwVAPETGdrfiAb+ZqingaPsvRnW2xRWJYO7DRj1TgxObGGorPiP
	a/GMZ7mnGGvb5px+0iiXZL0VmF+9zLQ8eTCVUEy9TweD9XoQcygaOnNJn0KQjRizd+eW8ikvpJZ
	TZgQ=
X-Google-Smtp-Source: AGHT+IHD0lGCCIKmW6BWOHjW9Nj61cGVsLD6S57fVLRbgBMQdAoeu+mJwyfD2wrtNtlC6lofYf/JBQ==
X-Received: by 2002:a17:907:7f94:b0:a59:ab57:741e with SMTP id a640c23a62f3a-a5a2d675779mr221351466b.76.1715345924587;
        Fri, 10 May 2024 05:58:44 -0700 (PDT)
Received: from [127.0.1.1] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d6bfsm181857366b.31.2024.05.10.05.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 05:58:44 -0700 (PDT)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Fri, 10 May 2024 14:58:35 +0200
Subject: [PATCH 06/12] arm64: dts: qcom: sm6350: Update GPU thermal zone
 settings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-topic-gpus_are_cool_now-v1-6-ababc269a438@linaro.org>
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
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index abfaa1178a39..99813f380df0 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -3177,18 +3177,20 @@ ddr-crit {
 		};
 
 		gpuss0-thermal {
+			polling-delay-passive = <250>;
+
 			thermal-sensors = <&tsens0 13>;
 
 			trips {
 				gpuss0_alert0: trip-point0 {
-					temperature = <95000>;
+					temperature = <85000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
 				gpuss0-crit {
-					temperature = <115000>;
-					hysteresis = <0>;
+					temperature = <110000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};
@@ -3202,18 +3204,20 @@ map0 {
 		};
 
 		gpuss1-thermal {
+			polling-delay-passive = <250>;
+
 			thermal-sensors = <&tsens0 14>;
 
 			trips {
 				gpuss1_alert0: trip-point0 {
-					temperature = <95000>;
+					temperature = <85000>;
 					hysteresis = <2000>;
 					type = "passive";
 				};
 
 				gpuss1-crit {
-					temperature = <115000>;
-					hysteresis = <0>;
+					temperature = <110000>;
+					hysteresis = <1000>;
 					type = "critical";
 				};
 			};

-- 
2.40.1


