Return-Path: <linux-kernel+bounces-236796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567A491E736
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D154BB232E0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F14216EC11;
	Mon,  1 Jul 2024 18:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sug4zvn4"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA2516EB6D
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 18:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719857483; cv=none; b=HM1+eBbJ+2PwuVetZqOXYy1qDP7CK7DGT4qfhnV86/QhFTIIoG6smboIS+vuqpk/v/7nymHQ1OdqPHfP2kTB8Mf58GHmTzwFSjR8dtPNOvpcbwux8F11p0kPDbc95ozCFDKHBNlqWDH3HsI5NaUSYjqRDdJp+knY7l+nu4un6Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719857483; c=relaxed/simple;
	bh=w7U7p//qg9/BOYI9iU60ZIGf+BbEbqV3HX/8OXO7k20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=clP60gbQ82bzo194qstHRDL9PNDVLp2B1AQlTm0n4H/Q36j7/OXhyNnJy4PmfzBebt5fGNaUYXYEJS+et2uznrq/1rat4sEpW1GDZ9N0rvi++HtWGp89YbaPQVAaJQ0n/dZG3LzAJKPUj8sHEvHYTHRh3nmBvyLzO98qKuklrko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sug4zvn4; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52e764bb3fbso4271834e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 11:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719857479; x=1720462279; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UXIjfifqoY2+USdxqsmMR1PZNjbJyEi4O/Dl39q5iAg=;
        b=sug4zvn4JF2dCA43ZCLn+iwezXRDZucJI23Tq1wbktBunfHFAM5R1u+Cu/Xdx+EKhB
         EDaa3a1KMUmXAcV2Yom46JWgx2cjneNwNdTP4LsG4RJxf979W6m59333EPhWwbT8BtVX
         X+Q1XClsPe+uttN5/8khXNo5bTsjmvFFaS+ewftnDrzjNACqD1f95cazRBCCW20BbvoW
         kEBbKuVayKwm+sc0s6nZTQ75ZE5DWo+2aOV5BQLU5hn2s2AoP5hyWX8QqgVFrf85ndAo
         /ueUtK1uRq2fEPSK9eHbA1NQjRS+UYpEWZQdkWkhWToCPQs4hILCphLK5LBte0SvuojB
         n6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719857479; x=1720462279;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UXIjfifqoY2+USdxqsmMR1PZNjbJyEi4O/Dl39q5iAg=;
        b=A2+dTJmDKtAnG3i4aXw/P8h1jLoir0hcxZ0gKmcgCI2SqsxYGC2wGM4mLMB7dx9Thi
         RQGyHibSYdanpTVWliEU+BS44GCMqpYCK2Y+IB+WPZum40JjuXcxacH1t+0coOy4jbyg
         06MqG88FzpyUcQ9004qf5AS78HKWpRK3JJJmZOf3bx72JFPEIVUqhjs5Xi1LbxWfzhwr
         /2TMmw+RXQAGHB00jiCTzNAo3gdLReviE/Lkz6X/8SVemdp58+GYNXBpQdajI/OlraJc
         OspoNrhK2PyYLiEG0xbz16kc5EO5lD+GEXb+Dhn0qsJgSi+A0HlhjtZlUrfDILzhzMDm
         Qmow==
X-Forwarded-Encrypted: i=1; AJvYcCX/cz/o3apFfSo0OBFDoTG0OVGBq25f0/+9NKdqjETypvCDuq/dF9Uk+WwUXB2IZ3rNYGNktBAVmgF3c5bDavrHX4QfkzB+Ksqdi6Vl
X-Gm-Message-State: AOJu0YzxeNYl2ujmR3mterLIkMl5aG/FxmEqwZyS1MsGyzTFzkU9AIrN
	OJDMMdkOf5P0mI6O5wEB9idStB8oZ/XGP5p8hwDIwmhEs0b4xXz9Pp8WfjHgwvc=
X-Google-Smtp-Source: AGHT+IF3y0VQLedqFBWkM6U87xQcON7ggU7XAKTs5isP66PO2FZSXJSQqq/IyH9zOvUQm0t8b7EkCg==
X-Received: by 2002:a05:6512:528:b0:52b:c1ad:1b56 with SMTP id 2adb3069b0e04-52e8266639bmr3495909e87.19.1719857479041;
        Mon, 01 Jul 2024 11:11:19 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52e7e3bd707sm1274292e87.53.2024.07.01.11.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 11:11:18 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 01 Jul 2024 21:11:16 +0300
Subject: [PATCH] arm64: dts: qcom: pm8916: correct thermal zone name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-fix-pm8916-tz-v1-1-02f8a713f577@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEPxgmYC/x2MSQqAMAwAvyI5G0hKcfuKeHCJmoNVWhGx+HeLx
 4GZiRDEqwRosgheLg26uwScZzCuvVsEdUoMhoylkhhnvfHYqpoLPB9kIzyQkJ1kgNQcXpLw/9r
 ufT84GrIDXwAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=998;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=w7U7p//qg9/BOYI9iU60ZIGf+BbEbqV3HX/8OXO7k20=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmgvFG5D7g4V+ZT1LWDVCXsEADQXnHuLk/v9cMz
 m2ca8/RU+SJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZoLxRgAKCRCLPIo+Aiko
 1WVoB/9270bZd7hm1wP1rDCf0QLlVeu+merMMJdG4zLjiIvUAoGOnSQRjyIgCBwfwbjz0Pe79rd
 +K3Jn3w7jsJb420UkDb+OTsssL5yzZOjPt2e1gJkxraOgPm19/3qe0iCMJ+7T/tJGY4B01IXyjv
 v4vfGYnepgsTIE/dnNqCwmhzx0x05yE2gGbxBc3aIhwYI30gyArq3tUBsFokxsBYyX7xFOdrYJH
 v+/hcGftN+GHiHTECu1gXTWz5oQVTLuB5fwNDa8zovsrsAYNuKGS/ANaomcUfjOPO8oxJ8NnHSp
 Nne1ca5ZjTBBXrwRnMynrA3XHyfbS2fabhc7dx1ot1XNvfWe
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Correct the name for the thermal zone on PM8916 PMIC. I ended up with
c&p mistake, which wasn't noticed until the patch got merged.

Reported-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Fixes: b7a28d8a7b80 ("arm64: dts: qcom: pm8916: add temp-alarm thermal zone")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8916.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
index 2def48f2d101..f8e4829ff7f7 100644
--- a/arch/arm64/boot/dts/qcom/pm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
@@ -6,7 +6,7 @@
 
 / {
 	thermal-zones {
-		pm8150-thermal {
+		pm8916-thermal {
 			polling-delay-passive = <100>;
 
 			thermal-sensors = <&pm8916_temp>;

---
base-commit: 43f9f53b46c63cbfc02af073a84c72c64b10767b
change-id: 20240701-fix-pm8916-tz-12e1b0e04deb

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


