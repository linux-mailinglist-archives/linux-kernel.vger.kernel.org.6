Return-Path: <linux-kernel+bounces-426044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B54289DEE2D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D4A280637
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4829219CD12;
	Sat, 30 Nov 2024 01:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f4adiKSI"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D574B19AD7D
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931105; cv=none; b=LryhpRwqSip5nHJs4SRAwiP590JQkuB5ltb/dCkBmvE+RabKEv3mOIvWCsB1tnZGklKckLhgbWzp1uMSS0SfGmRoWBKFDt6ExZw9atdWaAIls0RphEqZUnuDfzt9P+vwpl6bYZ/KRh0xlyoT34Ygz6gMb70P4/ZQjkQ87cUIuKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931105; c=relaxed/simple;
	bh=zFjg3X4sj0bxnLQr9HZSDlL6zt2ff3hQG2YCOF9/IoY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QFCAM+vZICkEqeMYUW7R3O0Rd6GQe6CehLCCJ7TABfxZU/fX+aIWCWftLEK7aK7sEJxayZ2WosBXg+OIoXO2Di9QX1XoGLN+7DCVwMPvqg2SQSd4bbMydxLOVREFIptcUov+syZ4I6OB1Xw3iNKsnwf0bpjIJAP5kQZ/mpE5ePc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f4adiKSI; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-53dd57589c8so3636150e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732931102; x=1733535902; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K/a5BAp3qzVqtYl9QHTxi0LWKFQabKWYE2YUriBQCrQ=;
        b=f4adiKSIvIreB8lB6evk4hjUK/EqAHM0EfXIKT3nvGSdm/rN2u5R6bZKJYh4q/7yKs
         yUvohsXPAIm27HDF5L7oq7P4nN7T/jWn5XRYH0DkphO/8SJFHtvk8JC1oaRV2XyHsA78
         nx0FdmPXx9l4WPi7JPB7yQBjSgLSdClgRbsmZtn1+/QrQe52UBJDIZlhFJl7T+RMIYMk
         Iz+ZnpgsVfkotbKaQIJP1O6bcE6Z8lJGW1cJUFUQ+k9W5+rQML97niIacLgZg476pR2B
         coLGXY4uAIZUURGdWQ/sKY84MkLO2eQmbKLVvpqHaP9U610HFgm9u4FZY3paJYnJQoiZ
         OasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931102; x=1733535902;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K/a5BAp3qzVqtYl9QHTxi0LWKFQabKWYE2YUriBQCrQ=;
        b=Vg5UkQ2cEqf25lkK9420aytCrdDH41VTN2CdLRc5x8AdaelnA5EnCSlELrPMvPhkiv
         PKBMDfRb6apGZnW2EzgwLOTZ33kJ6w36nNAhgdreVf2/S6jeSOfyuKPfp2iH3dGQt+me
         lsjc80zr6ToMdw4SAhzaOOCeJby3OiHEJWsba5LY460IIkJq8Ag2l0KdO3jh+4I3+fN0
         o6EV8ux1gnC1spc7x92udp49wyO6u91o+6ZsaRcnHH45K5o8pkKkPy6cn+BtgxPuyywt
         /kx6z1Jfou/dwbIRr6jduXmNid3bn3oLsXBfeLkl3BtMFGiXYifNefMmSZsRgcWQ0LCs
         Ogcw==
X-Forwarded-Encrypted: i=1; AJvYcCUyOZj7ufyXzVjhvWnCbfd7j5zGZ09BJNqVZmvHWN8FYZnmoNLC6neeo36oQjuiyLy3XLpxV4aLZnsW6dE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr8BtiTD/Qjs3IFP7qjnfH7TUK6mBs0SGODqgGgFfMV5q+kncI
	3Wv5FMqcPoOs1JfGdRc1PF0HksBl+Au4jjgg6OY66HxqRg47qHftxGoXCN4+3z8=
X-Gm-Gg: ASbGnctSWCtjd9Djb+xxJh/e5a6GGLeGD+rWj2MWwHO5seTus/4u4oIOyYauEU0hVLn
	kuXXJwkLDubMX1Mco8jZSnK6LWuEq2oC1aufRxx6sVuljCv4OAMIg88pVr5WL79RpBBJfexg0gR
	T4tOohZbbkXuk3omZ4Hf2Wm/b6Z3h5LI+mF8VyLFEO4jS9JEwfGB0toYXpX6RvMfxddFEqC+MO5
	BoyhitUvPU5vXKqyUHDgjbZ+AiMycfvQs+EOljJjthEcTLmSpBKIGElOA==
X-Google-Smtp-Source: AGHT+IEV+tG0cn8ecYo52eg8XBWYc80ZHk81V4q1eI8bArb8p7A8/lL8i0oSwTsogfw/c+A/sZVHEQ==
X-Received: by 2002:a05:6512:68c:b0:53d:f716:1e4d with SMTP id 2adb3069b0e04-53df7161e8cmr3042194e87.7.1732931102039;
        Fri, 29 Nov 2024 17:45:02 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64a0742sm631946e87.261.2024.11.29.17.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:45:00 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Nov 2024 03:44:26 +0200
Subject: [PATCH v2 14/31] arm64: dts: qcom: sm8350: correct sleep clock
 frequency
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-fix-board-clocks-v2-14-b9a35858657e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=914;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=zFjg3X4sj0bxnLQr9HZSDlL6zt2ff3hQG2YCOF9/IoY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnSm31D065hWsgzOcAAmlcI0LsQtZAm0QA5DLlG
 9kK3CVaezeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0pt9QAKCRCLPIo+Aiko
 1WcNB/9mSl7V9h8dAOyUvsJHNGqbZPHmf+Tlhs8xI5XQvXhCmEsYpQV8/rKDUYsR1oxKLRn1gbs
 h1qO1jeg7TRRUSd5thWZi0PDeKP40ZaPfnA4wylK0YNHQ6d604/lRDHITg9AmJhmWJkN4ZgzRYw
 7/K2nCYSGQjpLELwmUAxtyFR/xBU/Xiv3vUJDyEwOq0UTOrV2fUEay8kb5d9orA0vE486CoRaDB
 PM8q9HJAsK64w+SI1eO54bUxZ5U8dk6k8L/g/MWznNWbo2J4g/5UPwSPxuB0z98Bi/Ae9ogzMt6
 io/0OpgsJ9MIQJiwTe07nMzIAtbOHkgzMjJJqxuxi0yc9xlB
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The SM8350 platform uses PMK8350 to provide sleep clock. According to the
documentation, that clock has 32.7645 kHz frequency. Correct the sleep
clock definition.

Fixes: b7e8f433a673 ("arm64: dts: qcom: Add basic devicetree support for SM8350 SoC")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 877905dfd861edbcd083e6691a7cfa1279164ffc..15b7f15b3836dc544cb1209ab36df85263d612a1 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -42,7 +42,7 @@ xo_board: xo-board {
 
 		sleep_clk: sleep-clk {
 			compatible = "fixed-clock";
-			clock-frequency = <32000>;
+			clock-frequency = <32764>;
 			#clock-cells = <0>;
 		};
 	};

-- 
2.39.5


