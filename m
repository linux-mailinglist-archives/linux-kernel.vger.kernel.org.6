Return-Path: <linux-kernel+bounces-426049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 291169DEE3C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71625B218B1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A240719F121;
	Sat, 30 Nov 2024 01:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ABBHbLac"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282E21A01D4
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931116; cv=none; b=bExGqCZYFuuNW6NwuPvoYBxzbRLgxWwXIiTDA52acJEvcdmvnki2j2s1f8Zc9/xPbmhBmNvFOH5pYJv2gp5ePQUxKULo2u+RSGiFjwiTrxm+Fo93O5r7545CDL1JAdz8fWnMJgbLEMJ/gnRue1Z9x60MKLcCw0qko03Fz2Fg7W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931116; c=relaxed/simple;
	bh=LXX0tpGxrPC2kis2WoEdR7Ui3mOGhEj+zhg45SEX/Ao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TyIvo5dT0a6Gd6ZYL2RaCuDep54xhgnXEpSVSGve9Njfc7LaAUkkyvhwwdvou+oK7zzXGd/6q4d773+BPxrkKlsA4rQBR01lUdblAHbzHh4/RqslGRfau0ZjwKXEkj9TuQpmvGaHazKdMlv1mIhR3EK5CN+qzJkVbs7lte89MfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ABBHbLac; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53ddb99e9dcso2466804e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732931112; x=1733535912; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qLx30k3oLtldvsgstuJQ+s3SGXKcYe7FaeB1beknjb8=;
        b=ABBHbLac0BsfsvvwMTXxIOHarXaqT5ETtFSflVcg1Wi8AxKZbXxv6Nd2G6Cn8/83LI
         VaP5bZYLSMxlTHQPvQUk6W3nwxMDo4RxJ/i5LdFv1RnTXSCs9G5LB6PE4vAnvu7y8zpG
         QxwdIdzLbhd+B60srYd+30c6Gglg9BUhdyuVdbYpavvFwWfhcn76AY4PyH0VcH1m6iIP
         B9yVNj47BEWQqLojyg14Y8aq5fwTFKBI+CHnhGjc1oPGW1DAI+U+KRWV1VLHiWy/dAHt
         8TFvBou4djray51W9RZpK1LduMYOo5cgtX6A5P8Y2fXzy7nrS1kyUpR3XPpR89phQW3T
         ZWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931112; x=1733535912;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qLx30k3oLtldvsgstuJQ+s3SGXKcYe7FaeB1beknjb8=;
        b=f5ywwRLHYfe1vB9Ly5gq2MhW+Gkr9Lt2K4oEne0C4exXe86pd6hZafFJLpQzIGwF6n
         27fLGfSlRvOeVmgyYK7FAiBvjqjsYXMA0OAx5e1YDDIHMFWtKuPYPau9sTgjj8VrOVVl
         nOuBBBNSn/k/hszD8kBzish8hS5rzkdnRU0clBvZcbpoTf2b+wvMPOUIEaUoIEYXdNcW
         Vf2Ql44jEcwn9uutWoWPp4toRZH9VqHWtHuLB1laFfmOXZ7BSK+SnFhpmHkUcBR25HsY
         mXNVzE4tCTVlY5jKr5Xs5P2lsTfw/gy7arvGlR4G9MJYuxFX8iukuucK07CsSQNw+qlY
         Psxg==
X-Forwarded-Encrypted: i=1; AJvYcCUaUskEbIvxjpxq4oyRr1iya/imag1u9qMjGxUuwuw3tW0Q8kSxYmAsuEGWIFBR4NxPG/1lig+hM8YGW6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc7mSeEmN7CbdOWZPnhqucgi+DsKACBLhsShBYDA3dn0BFdJ9K
	iWuE0PCZt4IZ/KiRQx3BvzkQZyKuHpSR0b5jN3aPqV02dCk87GT3WGjgH9fW6Iw=
X-Gm-Gg: ASbGncv6N4pDC5Wk/qxRIenusYcrF5XI3Q2l+IuPqJVrhPLeIGTurX5rqxCVqsZjvwC
	jbk41U8EuUdQ0o6ckGTkTQq7bzVJdli5hwZuBFotkpZXMKEqB6Nqhk+/PusRJoGYPVygpI6hI+X
	pBVgiUDUfeGcMqKkYm76CjdjBUkhhnpGmSL++2Xw7xufG0fK7so56lHGCbSnEf56xpc5J54tPdy
	CduaRzgzsx3eMi1V6bXTZABMLTQFYrxTklTFMfYKKS3Vn7ZrnHXZFYAtA==
X-Google-Smtp-Source: AGHT+IHFQ0NyCu0orpLKv3xjrWL8Avs0kPgEYdYOIiv//cGCHygZQf4V6eq44clsK8n7/xBG9nCR9g==
X-Received: by 2002:a05:6512:3a95:b0:53d:ee75:1443 with SMTP id 2adb3069b0e04-53df00d794fmr7797805e87.18.1732931112305;
        Fri, 29 Nov 2024 17:45:12 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64a0742sm631946e87.261.2024.11.29.17.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:45:11 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Nov 2024 03:44:31 +0200
Subject: [PATCH v2 19/31] arm64: dts: qcom: sc8180x: drop extra XO clock
 frequencies
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-fix-board-clocks-v2-19-b9a35858657e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1337;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=LXX0tpGxrPC2kis2WoEdR7Ui3mOGhEj+zhg45SEX/Ao=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnSm31MhGEqb50neg5rH/N010ZmC9Og/YXRoANL
 NStRUSHKLuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0pt9QAKCRCLPIo+Aiko
 1QiUB/94zmzwNbHEHJ+AOpd1HZhwyCNY6wo9c+FWQhpUBhmHCfqol1BAx7EHeYIRqEaZp3Sxx+A
 U1BuxzFRKYW/Q0iXr7i9jXT526qgec1/Cgj7qI0EBUNjMB4tTIZBo/EXJDr5JWQr99FDfAvWwkB
 4WHZkosBo+N56FSMczBDEh6zAtKexiwYNRHzKotN4C1JsAE2e7IUZI0le71ZEImVIdXvoAi90SY
 SWuxpdcwkqG1tjEqzdkUpk+1yY48w7xPZ2z0VFKfX1TJVBGycgDEALLjwj4wrC+VK2b2YW9GoGF
 Ma4xs+2KimVlQhElhmSZHr0DE2DhkRTLhdCSzL3z3gf1nRS9
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

sc8180x.dtsi already defines 38.4 MHz clock frequency for the XO clock.
Drop duplicate overrides from Primus and Lenovo Flex 5G DT files.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts | 4 ----
 arch/arm64/boot/dts/qcom/sc8180x-primus.dts         | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
index 62de4774c556d3954a797287ba2ecb36d979dc9f..21c2d25a294506de41f6e8b7197be85c02d03568 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
+++ b/arch/arm64/boot/dts/qcom/sc8180x-lenovo-flex-5g.dts
@@ -681,10 +681,6 @@ &wifi {
 	status = "okay";
 };
 
-&xo_board_clk {
-	clock-frequency = <38400000>;
-};
-
 /* PINCTRL */
 
 &pmc8180c_gpios {
diff --git a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
index 79b4d293ea1e70d68346e7c5458c94f7c2b6f1eb..7a4bd6955470338dd9c7a628c9f9a01de8b480ac 100644
--- a/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
+++ b/arch/arm64/boot/dts/qcom/sc8180x-primus.dts
@@ -773,10 +773,6 @@ &wifi {
 	status = "okay";
 };
 
-&xo_board_clk {
-	clock-frequency = <38400000>;
-};
-
 /* PINCTRL */
 
 &pmc8180c_gpios {

-- 
2.39.5


