Return-Path: <linux-kernel+bounces-426060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA5B9DEE5D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 02:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D328281D21
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 01:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6AD1B5ED2;
	Sat, 30 Nov 2024 01:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ra5QmT0+"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D021AB52B
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 01:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732931143; cv=none; b=RDDXAnwYbuFUj0wAXLj+eyPxdJiTfm3jQ2dH285GQrg4KrBRTJ+y6YIpfqR5vzwKscHqrSkRLj9QobgAG+nTJOkpTrgnyPPYvJPHan9aIFfhvA+30YAyuJ1uyEGiyNgjPWtDtLkeTEwzaM5oyrtKYkhfINcS0PhwMH5cEWTx8Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732931143; c=relaxed/simple;
	bh=LwSpKOq1GqZouqzSTW+vvDI2/fjTuTTRV2CIEe3lHrs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yq1m2PZ6R4HhykHICw+gBcWYRpFeCGoZv5LvjtP1noOww5Vq3p+zrkC14SyNFLtWOp/Q66hLfgcZBZH88rcpIHnbjfzX18WxiWE/CJ0HihH8XkABA4ZWInuhl5fBhzqI+Rn46GE2qn8lg5VccdZSfThUd6EuSVvjR1isDWOiAtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ra5QmT0+; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53dd2fdcebcso2884018e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 17:45:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732931139; x=1733535939; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iVuVXOPYsKpuOKWxVV75YfQI6Bwi53UfnzrCPKYgu4o=;
        b=ra5QmT0+hD4HVa3hoxck4OSIQOMymD3MwPaM+RZCmAZ9dnO5fmJWnMN/22kZFEntfj
         A0NqjmGI4TQ+qsnU4TMMv0Wcwvy9m/yFTD8Xsrnrg/q+M1jUEFgIMPVnUooLIQ8/xbIY
         O/OVEzlmVApdB5g+8o0aWuZUY6xjig+yuso43WO/QFvqOH7j9w1n2xzC9Fse5vpt6R1C
         FactUnXqWlV1/fNcA3rChoTq8CY94dFVCJlJCCeOf+FHtiUwZuhKqBSQh4vptg7Nfn6i
         +XZCoUqp4e6MKdjw+N5qa76VaVNTpQKrf6Y/vc/caF/1ZsRmq/Bfwh9RHB1lLmQjnjQQ
         wbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732931139; x=1733535939;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iVuVXOPYsKpuOKWxVV75YfQI6Bwi53UfnzrCPKYgu4o=;
        b=F8EoWEZ93aLvswQGrWQcexY4L3Zk99bzc98FssDxqDnh94JAO6jCOuBRpnjCYgntNu
         0jnpLfUAxL8U5CAkiGwZSMyznR09Ei815/OlOMbR8zaMEAgmOpmNwgmpM1bm265Mjf06
         iq6373o/YpLYw9CPpOWiq7pqgPLIPxf4oc6qUHqqB1LUyMgXWJIMt6lbENl3bjOShu+f
         yGw25kqtve5/ROsJXln/Q7aczSjjh/B5KmQMZWfYNKPH/FQRoym32V/qmtnF4fkCczUv
         upq159oFstCP/pApY1Pb4nubeQHVqldOPqcETjs1QT9GNw97QJMo7izc3ywcO6Q+zbZ8
         TNsA==
X-Forwarded-Encrypted: i=1; AJvYcCWcXbDaZFoJ5xF0SbtBHz3cnZ1ZQl0mCxbK+4j9ZrlC9Ji//K1h4fTx7B1UFEGuu2ArY5rWd0YTETSU0AY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJvgPgKaooDv63PQv0kB3T/PeUAaahwO6lH/3zXoptZVRVLIt7
	kb/nAisajxZbbF9DHbcCOE1ccjFQImGHGS2a2WbOsvKqQ6vVFvLRv9v0k5LdkWU=
X-Gm-Gg: ASbGnctdNutKmCWF6CkuduSOccCDwOWyO3z01y7b5RDsry7jARCr6MRa/hAmrh6sJbk
	BicXT8ivVtCBxyTocF+uoJuELYMedEk7UjL0Iiopd6fSHMMLb15BkNOqdgYR1ODUGSZIEB7uXyZ
	fOErxGwQt/rjTlFb58FoX5t9GLe7DmHEEarxJvNPxzg4bIe+N5KSGwDWpl28kqAFcFpLkAoJX69
	A5m2zFHG9JBC9vyCccoizLFui1Rb3Q3sDME3YNK0RNZ5cIVCxg3hs1FKA==
X-Google-Smtp-Source: AGHT+IG/gB1YYyYfYqJDFqNDhyS12TcU92dIbuCRkbjDZGJlyIHkEqRlPOjim71bxlaSf0UoPw1jWA==
X-Received: by 2002:a05:6512:3ba3:b0:53d:ed16:7a32 with SMTP id 2adb3069b0e04-53df00ff7bamr7967044e87.36.1732931139385;
        Fri, 29 Nov 2024 17:45:39 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53df64a0742sm631946e87.261.2024.11.29.17.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Nov 2024 17:45:38 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Nov 2024 03:44:42 +0200
Subject: [PATCH v2 30/31] arm64: dts: qcom: sdm670: move board clocks to
 sdm670.dtsi file
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241130-fix-board-clocks-v2-30-b9a35858657e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1867;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=LwSpKOq1GqZouqzSTW+vvDI2/fjTuTTRV2CIEe3lHrs=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnSm33NmIQwFBxIPvKGEcX3mja1XLN8tpDXTi3Z
 hYENw+jxtWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ0pt9wAKCRCLPIo+Aiko
 1cOBCACpjdhJHKSJDtiOo+gFZ+54Dvs+BgIb46W8od5CZ8yPgwOpGjtQhSljfkfFG1rvRo47o0d
 aTUmkReCJ/jfuTUkXArISpuA03yjh7UlAuk6SjAXd601nXgq2Z+cjv0kJ1iUncaGmGmAzxvG/5h
 9+BXzkIeO+XjKLIvzPZdgBoSI++Ovkq8UOVdf8I9OwadN2h7lcrS20h2HD6Jq/03Wp4qENulECB
 BKbqrjiEsxKWqRgw0kUhUedUwvYsbwuLEsyiOzXcToQc9/Ru3rwWoa5tiBRZP8qliC2f82U4Uom
 7HDiv+NfOhr1U7evafpfct/L67h+0cMfUlI0YMapoiTCnaEE
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

The SDM670 devices define XO and clocks completely in the
board files, despite sdm670.dtsi file referencing them directly. Follow
the example of other platforms and move clock definitions to the
sdm670.dtsi file.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts | 14 --------------
 arch/arm64/boot/dts/qcom/sdm670.dtsi             | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts b/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
index 176b0119fe6d45d7d3fa584f1825f4e4e681c2e7..44b708c8a4e4ef5ee1d9110bba372d230fdd5b4b 100644
--- a/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
+++ b/arch/arm64/boot/dts/qcom/sdm670-google-sargo.dts
@@ -49,20 +49,6 @@ framebuffer@9c000000 {
 		};
 	};
 
-	clocks {
-		sleep_clk: sleep-clk {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <32764>;
-		};
-
-		xo_board: xo-board {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <38400000>;
-		};
-	};
-
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
index c93dd06c0b7d6444aefd0e24201cea999dcb23a4..c4fd7598d1ca8d8baf4c3da0e20cb191f7883f0a 100644
--- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
@@ -28,6 +28,20 @@ / {
 
 	chosen { };
 
+	clocks {
+		sleep_clk: sleep-clk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <32764>;
+		};
+
+		xo_board: xo-board {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <38400000>;
+		};
+	};
+
 	cpus {
 		#address-cells = <2>;
 		#size-cells = <0>;

-- 
2.39.5


