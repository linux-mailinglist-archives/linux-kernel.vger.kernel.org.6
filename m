Return-Path: <linux-kernel+bounces-426033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A649DEE0B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38173281BA7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A104E13C83D;
	Sat, 30 Nov 2024 01:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N1d/hhtX"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C769130E27
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931077; cv=none; b=U3adI/NYCm7k8zROhkaBHosA3zQuXXEMIF2NZko9XB+0OnjSTcT1ub7KkEQmqyBe1PoLY8Midu79srHxOZTmH8E0pO8sFTE7TedQTrvWZiH8dJKBGpZCPmBSOyonHLI+ThxrbWS4FMx/B+KKyiICT1hSyjAzDdfWIZQ93xM+oD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931077; c=relaxed/simple;
	bh=ICsKkpn5EvTWejmupXrRW9hTH7/us+kf6N9oJ7E9bww=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I6U0jZFmNjRTTJqoGEm9QaKB2dTEbZz9ShgMQW5A6Kv3sIVZU8o7Ne5oMzbiyLErmjSLAG+Itl59oUXwKeiMmFCHEVQ3P5j92o2rqpd2kAL1phPh+132ruvVeTRRf+rhTy3CDxuamZcs91lBAs7xdyFLh0PUXmz/jXwKBphWcrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N1d/hhtX; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53dd8b7796dso2507393e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:44:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732931073; x=1733535873; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQd/2FVmAl0Cmw9f2Bljw/aTs9lMiBL9KUoFa8xK7FU=;
        b=N1d/hhtXebX+d/1dXnQ+AMkxUGkOW0Pd2RvfkYdAYlNlRJ5lyxMHCiwNVEX1gFLdW2
         igjX8Kz5J20n6awcocC61zEdpWRO0ZQuTNnjW2ev/fBmgP00Std+1Fc/C5JCH0mEwvRW
         0IrthjYDAKPBxp+qtATPKWWhMJUL6Kplz0k+pIckkb+KOdv9VGY8ij4ceOWsxeLobcG7
         eFn0Wf0LnSU/Gu6QU4cHEI25mmasxeqHt4jmMfBb2ZG8UhR3/dOtyiieEVEBIpobgGD+
         eZHPOUCBjqU8rixRitdxxnDCtvffAQHCn7UD3UIKeYmUlxBVPbF9iP5tqCsD9ik9kJZY
         YEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931073; x=1733535873;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQd/2FVmAl0Cmw9f2Bljw/aTs9lMiBL9KUoFa8xK7FU=;
        b=NgBf2NZ8zHKqjK7CSCrsRnavLGcn2XvMmwHkX06TGzhvztWx+ZsFbUSdhQ4Rk2RN4X
         +vZMvYlsRG/KCnMYQijsMmN13D/hbC0HN/2htAvtgRfW3Sj3p49zkBajILZ7KgJh368q
         oDZi0/L9rY/jYRcUjKrstgMeiZmEbTFaw02vtl+6BhjzCaT5XR0EdPOJ4CAoNVw8Vh/Q
         gtrPD+40lg3jXu7q6oL2AEVRM+bholrFRlwLunrLbbKgQ1CFX3uNyAWLcLVjYhWyc1hq
         CwZMLES+vz2755oGW+WYRzjO1OBQft7fbIEanuvyVpoeJO/6kdSdxUNSllOvB64hhnWF
         Jw8A==
X-Forwarded-Encrypted: i=1; AJvYcCXNv0rSmbHloWw+wskOKmj/53SilXNAzuZlFkZ2l+SP7HWke587jTAIRwJ//M45cflbL0Tu30zYlcZZClc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA6yx2BWcJxtMAu7zwV4rxe3hrHL1jCKJYA2Mjvzho31c0RayF
	VRaeFdAV96b4sv2AOBQRkFjiK4A/lV0++fSYJM8SZjZoldfRUG5/22ZFXZsoFck=
X-Gm-Gg: ASbGncuO4g2TjbHe491V9R7mKpQgvcdiVRJpIthbYBq7EGdszfVEmBwqI2opeQ//FF8
	SlFA8ejFZ7BRB/w/BjgOMStR8D8NsPAttrs3kr6o4TXLp4afRLm0Rv5LqNWHXKuqTvTahDsVjgj
	dlz9vgPvq0CMswarAtnADK7Qbu8DFUfAD1/nqdxGPiTWboXX0B9lmPIzc4bFz2U5/Z/CzXxo52E
	XLVUrrWisDtdZ9P8tfPsBI+RzLiwYY/90X2ke7Y+madhEgJmJp/+Ovf5g==
X-Google-Smtp-Source: AGHT+IGn4VU64Gx7Dmo3dMzNMzuHw/MRvZUdEx/fz/pqU3pk43z0lDuxrHaEfEjr4dOGL9s0lVGo2w==
X-Received: by 2002:a05:6512:ba6:b0:539:fed8:321 with SMTP id 2adb3069b0e04-53df010eacbmr9375322e87.51.1732931073574;
        Fri, 29 Nov 2024 17:44:33 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64a0742sm631946e87.261.2024.11.29.17.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:44:32 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Nov 2024 03:44:15 +0200
Subject: [PATCH v2 03/31] arm64: dts: qcom: msm8994: correct sleep clock
 frequency
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-fix-board-clocks-v2-3-b9a35858657e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=956;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=ICsKkpn5EvTWejmupXrRW9hTH7/us+kf6N9oJ7E9bww=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnSm3zk09ns0089zqinIfwldAGTE/e9tpdne0E1
 d9WLHWwoWmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0pt8wAKCRCLPIo+Aiko
 1cgnCACl6LKeTCxlSH2Uc5kV4MVd5oBaHtbUGVCUgWxopMMc++/8PS+pOarwMxypWWJiq7iqSeH
 /EeKxHRvm2hLq9gJBRX4DTZe01orTqBBnvmxchjqFBsvzwddya/kzIkey8OXiIpBlySDxMFsHyB
 /JtOLwk7Z9rENXxvuMb6Ia8PiuyFiz2pu+ttuTRKiHP5DyIXo5HdAmZJKv0bSARgUIXiqTogGM3
 ac4pkhEpWZC2oaUPGeTjvJj0iEE/OJWaQs0DQq9niPrZYcBWG2FhSfN0h1yp2QLcvNwooR4wiPr
 OI3dZXcnyN4VapP/xDedb33YomzaOc8W1AGJPx0vJKQQX4S/
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The MSM8994 platform uses PM8994/6 to provide sleep clock. According to the
documentation, that clock has 32.7645 kHz frequency. Correct the sleep
clock definition.

Fixes: feeaf56ac78d ("arm64: dts: msm8994 SoC and Huawei Angler (Nexus 6P) support")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/msm8994.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index 1acb0f159511996db07bc7543cf4f194a4ebd0fa..e6c6582ce1eab5bb6831d3458861d0d68c056316 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -34,7 +34,7 @@ xo_board: xo-board {
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-frequency = <32768>;
+			clock-frequency = <32764>;
 			clock-output-names = "sleep_clk";
 		};
 	};

-- 
2.39.5


