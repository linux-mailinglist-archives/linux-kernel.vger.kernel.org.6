Return-Path: <linux-kernel+bounces-426043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCCF9DEE2A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E4EA1622AE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842C0197A87;
	Sat, 30 Nov 2024 01:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p5S1cGz/"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B2F188717
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931102; cv=none; b=CnsQzY4Jw0bkAiyUlMIz/rAqTtwga+sf2UEOPwDWessSWpLrG+edkE2mU9bRPhhQ8Q3fq7YVvmpCT0bS1FRQMtmBFf+91zLBx75JcxGnF6GJhUniJFOMlgd+3LcI1LMAFYd4gOTY4O7b65wt5UckiDH3QuETS2GwE6IX3szEQ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931102; c=relaxed/simple;
	bh=t0rQXPrtoBaJrNoELAVHdj8ug8kB5TUw+I/NzNZW0co=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KXzWIpttaNXFggvV3JJr4TLfvuErSRbaC0/CQAj+u4D7argvhS6MumRV9NzkBUoAn/FX/OK82fRpp/d93ZVNNgBrEekM5Rjq1MlkZbxDT2zQh/ZJau4JMC6xsTusn1wFgN+F2sdaTGkLUx09TS9lFbuROPoDMRec5EjCQBojIiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p5S1cGz/; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-53dd8b7796dso2507485e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732931099; x=1733535899; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZvlf47lLnOuGGVqz501ZYTHYvZy2AJJ5Z/oU2OF890=;
        b=p5S1cGz/y8XoxtAycrGTkE262pfaEkiR9YWV08ML/xWba1le+Vbew3hrPlrjOp1sOP
         fQPly/zWBKtmNg01VOKS/GRT7RUrcCRfQzvIGjsQODspGnyJN6L3Ef4goW/6FLJ6Jee0
         ymnP3zz+U8e/UiXRB3qiKzy8ERIUWADtQuht78o62AQ0Lj78SozwNoUJpgQH4okuvAJN
         whrdLsm/BjeDk1EP7JTVTNjnhnTdsLa6f70jEVPfPfnpnQQgeMEQmKlKUquToiOQaaAK
         28Gjx93tdRn08tqsZ04hAYhxQft7rj3swlHlOphTzpbTUB4h4Bar0Yu0ZfmpFw8cDiwq
         qmPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931099; x=1733535899;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZvlf47lLnOuGGVqz501ZYTHYvZy2AJJ5Z/oU2OF890=;
        b=detzboiK07aOXFPZ00FMRtw7jH6W1Zdsi9nyAp0LWRIzlogZowchxJWEIlPOD7VDQY
         CIH3bTCLVSYIT7czjTTamlaFTCnz1J/+WRVVBvHJcc4uZyP0oVpGwu6Lac2z5YM+9b2W
         +0M+bJIFW28u8ngvU3v3iNBM9hasju/crZv9QbDEQh0NMRCNVD1HZPFheu4H9EZbJSwp
         ONFFHCCf8b1u2jbqw6tN0vLWkgXwhJ66o9R6qoI8svbW9Uq0gS5/ZLF78/HhB6iuou8z
         h2XqzhRzHlFRblZcipAjMZhMpdYmEUrXTSeqjPTBbde4j7JuwD902ynl7AKBOQkAbaVE
         uY3w==
X-Forwarded-Encrypted: i=1; AJvYcCX41vFkniVlVBYSq0zo+/9Vi1p7Dz6n+Xhz+uD7/Y3v5YmvogBEIgKFlkpVqrdMmM7y+Oo8TDdM1X2YcxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuRoziLBaG9TsqMnEDmqSiQotUYxkDNuOeOULfC5sAcThRXqX0
	STAmjIIgc0JMOIc4b5q8CGXnC9PuDBnxXtkUnFt/serCdQNmTdYEy/7LShi5yrg=
X-Gm-Gg: ASbGncsP7dEF7+92yfC3QJWKPrDSnSIFn/WO+Q+ArGSf1udAyYh0HMDOJ+zGVRmkDEH
	8ISgkfDzWtIc3w/92T3FW5UIreqpoQV0+LGB83DVE7EcLWrsSbKMEJEti9QKzMxd9VA3N4+o1fv
	nUD4nz1s03rOuNSWVKEhARY/3UGs3V+ZGk+53lv/PUWP0k+7NS7kXQ4fqlFMNmvsuOqrUcpjbY4
	sqnluLKApBCDH4OlyXLhyZECH7KcnsVdiYIUZrckYFUaMr2RxxRrHNu9Q==
X-Google-Smtp-Source: AGHT+IEK4JnJ+KBUaz6i/k2ILNCmsJvtUTE3Xk5NlCGOFLAcetO/yIL+RK+7Yr4PN/LOWtpKx+UgYw==
X-Received: by 2002:a05:6512:3e1d:b0:53d:d139:6c21 with SMTP id 2adb3069b0e04-53df00d10e6mr7821513e87.18.1732931099480;
        Fri, 29 Nov 2024 17:44:59 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64a0742sm631946e87.261.2024.11.29.17.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:44:58 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Nov 2024 03:44:25 +0200
Subject: [PATCH v2 13/31] arm64: dts: qcom: sm8250: correct sleep clock
 frequency
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-fix-board-clocks-v2-13-b9a35858657e@linaro.org>
References: <20241130-fix-board-clocks-v2-0-b9a35858657e@linaro.org>
In-Reply-To: <20241130-fix-board-clocks-v2-0-b9a35858657e@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Leo Yan <leo.yan@linux.dev>, Joseph Gates <jgates@squareup.com>, 
 Georgi Djakov <djakov@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, 
 Stephan Gerhold <stephan@gerhold.net>, Zac Crosby <zac@squareup.com>, 
 =?utf-8?q?Bastian_K=C3=B6cher?= <git@kchr.de>, 
 Andy Gross <andy.gross@linaro.org>, Jeremy McNicoll <jeremymc@redhat.com>, 
 Rohit Agarwal <quic_rohiagar@quicinc.com>, 
 Melody Olvera <quic_molvera@quicinc.com>, 
 Bhupesh Sharma <bhupesh.sharma@linaro.org>, 
 cros-qcom-dts-watchers@chromium.org, Stephen Boyd <swboyd@chromium.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Martin Botka <martin.botka@somainline.org>, 
 Jonathan Marek <jonathan@marek.ca>, Vinod Koul <vkoul@kernel.org>, 
 Tengfei Fan <quic_tengfan@quicinc.com>, 
 Fenglin Wu <quic_fenglinw@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, 
 Alexandru Marc Serdeliuc <serdeliuk@yahoo.com>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Jun Nie <jun.nie@linaro.org>, 
 James Willcox <jwillcox@squareup.com>, Max Chen <mchen@squareup.com>, 
 Vincent Knecht <vincent.knecht@mailoo.org>, Benjamin Li <benl@squareup.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=920;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=t0rQXPrtoBaJrNoELAVHdj8ug8kB5TUw+I/NzNZW0co=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnSm30/qqutm8AVBRdVsmflA7t8c5bUdq73r6kN
 R+8xAYCD4aJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0pt9AAKCRCLPIo+Aiko
 1eW5B/46A3mdgHPzPqYR3PvfQwBQ9sznJYapBsJiiLdEFmxjr0JD084s3D54kXfBT7PPLOZSV2C
 Pju8Zov83BNTZgPTrSA+Zx6HUYOoxAvP8Lc3Hn/Pmh0uHXxeG0Soltp6cPi1x5S6FAR1dXiEDNj
 FKvBpVAs4gBWuKBqsCxmHNSQ/2iaL6vOCTtU41y96avgkTHbCouvIP3pz+f+yLEL3X364tAdNsf
 +gAzeGEvHFR/fm5ppnbRssqBvdeD4SXp1D13W7B/G19qnxLkU//sq8Ta4YVh7H8kSSgeia7+0/G
 ZUm4Wya0m5oBe2th1Kn3UNIPobBmXsvXnm5JAzTssurUruIO
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The SM8250 platform uses PM8150 to provide sleep clock. According to the
documentation, that clock has 32.7645 kHz frequency. Correct the sleep
clock definition.

Fixes: 9ff8b0591fcf ("arm64: dts: qcom: sm8250: use the right clock-freqency for sleep-clk")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 48318ed1ce98ab40de75129cb9bdfe32eda4c004..f39318304da8d02ded9bc4ff833bc88139ded744 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -84,7 +84,7 @@ xo_board: xo-board {
 
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
-			clock-frequency = <32768>;
+			clock-frequency = <32764>;
 			#clock-cells = <0>;
 		};
 	};

-- 
2.39.5


