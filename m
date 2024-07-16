Return-Path: <linux-kernel+bounces-253576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EAD932341
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 11:46:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22F301C225E0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 09:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6547F1990B3;
	Tue, 16 Jul 2024 09:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BMRIPlid"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC919198E60
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 09:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721123121; cv=none; b=XPyjqmB3r1wUlFf1SQhJdC2KE/e++rD0VF+PwQ+8BAOiVo3uDg1rpj/sqC8F+qthOAJW3P9yHuKYdAC+cXkoDZY6NSYCIcA/uQN7nmCjYNIBQze21Q3ZCQDLeudwoqBGRh8PYzxnAeETL+GFsr5xvDIc+4YnEebfY35qNPWh964=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721123121; c=relaxed/simple;
	bh=ui/IQX/ULWv/Nzby1faTOhQWMn0QQZb7F5O7dFY+BFk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BDXAuufeL2hLbAEJWJXx551MYmdCGqEbYvHBZTyDLpgIJ5roqXJ8kNFWfRm3DT44ty2bNjJcCI339ba22JBH6W4wb7qQMyVTGd8Zq0Cyo0XKB4xkHvjwleKYE6Awb5xpp7MNrhr74bQK33fCr0NXteF9/R+lu6UI2/42k+5mA+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BMRIPlid; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4266eda81c5so41476125e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 02:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721123117; x=1721727917; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iR3lNizK94hW/awP0cbNptCacPLKiFQN6/M5gJEwtEE=;
        b=BMRIPlidwds3nVOxJ5IWHoCsekHTqJERg2YgFuDBTudE01Fwp56STlX1iVfWcugq32
         ZqS4JYkTeE9UaBuxVWUNf79Ba08pp7nt6LloGjRcRy2QbnGsmSGCbhxdzz+CUaiIwQRf
         ibiIVuux2glVwQf5BELiG4VvJQ9XfsvOD+F0wZXcgrm4M1VWATyM6+cKonTau0SItSD6
         dCiFVJ6lbs91NUSteTPORnKhsPoJV4/ogkb/z8Ij0Ug9D5zxzxCSEjx9u1E4avSkmDB9
         mth4aiEjgPFrx8VuZcsvnangWy2H2fjwUGRglVHj88xJAqf1G8keg8S+RrPT9sNlTHPA
         W/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721123117; x=1721727917;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iR3lNizK94hW/awP0cbNptCacPLKiFQN6/M5gJEwtEE=;
        b=rImfFL6p1STIoMn+JvljS+3XaSYx/KD1ImCeH1fUEBdPGb0a7UPL0AGEcHTJaItuTJ
         aCIsyXCW97hfY4ko/XPj7wlqmqV57JqVzPvt1uhhgs8czyzO4QufDcc3b3oyarPM7Lak
         tEP9i3NiKeiUv5JCL6Bbtihc8KWXZJ2n3O8dtp7IswZk2TTt1cU7SrpwOwyYS2/4YBmO
         m8ZyTM2IupwZrdLn/cuUPIXlgj/9Jdo2K6wWek1T1jR3GkBo0L+ivG1jWQlvQFGET72F
         5B2sMUBkT5r3g/FHZKvuMI1NmqT2EhnPGCVLENT1p6HsdIGftLF34Y3IPDzz9YV/pIgh
         BpGA==
X-Forwarded-Encrypted: i=1; AJvYcCUyyxzd1qwvOGEfIFJtJvlqdESMF145qn3XJB2AbpqclNCoZplk/UUi5+xBoSfMZoXNKcOqKYNjqw/AMoA4w9xSJcPo5J3DaiGY5US4
X-Gm-Message-State: AOJu0YxDHgwhQ8GZI5igx41BtWZEDSpbbJjltFzWZvfbZ93LuyX3XHrO
	Qztjq+LnzyEGutktTKv9CXaqb9PAX/1GDhbsSCrM0j7gh3pLkPCD5JWH72lUce0=
X-Google-Smtp-Source: AGHT+IErY0duGCm61ue2XWh4AW0KKokPExzhzreAXpndf7GJkzX1Sf6kKOc9o2kTLbqs5CAu/P4oVw==
X-Received: by 2002:a05:600c:3ba6:b0:426:6ee7:d594 with SMTP id 5b1f17b1804b1-427ba64ccf7mr11759805e9.7.1721123116888;
        Tue, 16 Jul 2024 02:45:16 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2cc2efsm154408185e9.36.2024.07.16.02.45.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 02:45:16 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 16 Jul 2024 11:45:10 +0200
Subject: [PATCH 1/2] arm64: dts: qcom: sm8650-hdk: use the PMU to power up
 bluetooth
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240716-topic-sm8x50-upstream-use-pmu-to-power-up-bt-v1-1-67b3755edf6a@linaro.org>
References: <20240716-topic-sm8x50-upstream-use-pmu-to-power-up-bt-v1-0-67b3755edf6a@linaro.org>
In-Reply-To: <20240716-topic-sm8x50-upstream-use-pmu-to-power-up-bt-v1-0-67b3755edf6a@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1921;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ui/IQX/ULWv/Nzby1faTOhQWMn0QQZb7F5O7dFY+BFk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmlkEqy9IWAZMc87BkuXNhnj8hq5aUxIiVs8h9Krhf
 HyF2uYOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZpZBKgAKCRB33NvayMhJ0X51EA
 C2tmnEH1m46oQDnemHKarakhYVq7sd1qWctXqstx/HdvrvLkjlUr/y3d9FXzrbPiFl8v7ATGT1dKw9
 cmvtyWtqLP+IOA4nvykqOE9AC2ZHa9StIQ28htsH94TfGOIZcauCvHovE6Pdt+jX5Z436t+YzGTQ6x
 z8NM5XIqjoDm9JX8NkYDqw3xgC39ULZerUdv0YbVk9Ati9uHCUPVFtrTNXsJIE9hoKQ9ccUb5ZXrA/
 rAolmgg8xS7peJWtZyQFG/rt4/R9IxKLCx8PQLl4VLYg6rSXUHCDzFmz7h/7K9q31DFhqfhJGumc13
 PZZYMzol8hl69yXxWVv29ZNXaGdJ/BaYcsC1SeZTeriikW16ZTVsHcnRjndXVFubU+g51vl1qyig8s
 dc4yb66+ajt9fMx2/hevm486YzGvPFjh/qErK0NGuqksCOiBXjz6hRJbCd5ON0Y/yo0qe5L5Q+GgWB
 fZFkb/xzHzmgrEnJRjUJwvpm5a9jUFEA74eGaTUcEtAxK2gNLy4oskkS3zWwlwH344x11j4RwjFVzr
 8K/MB+NEzVdCOcyTiZKcwZoQ95Xt3yN6HqDjPtxG8dKexSmocryFGE4CAuVEn6FLn6YN0fCUv1N1GB
 oV8thsHyyZe60CqGLWJLZXWHhQZehagcmX7rmX6Fz/93rlyXArg196yWg+FQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Change the HW model in sm8650-hdk.dts to a one closer to reality - where
the WLAN and Bluetooth modules of the WCN7850 are powered by the PMU
inside the package.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650-hdk.dts | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
index 591e6ab9bf5b..127c7aacd4fc 100644
--- a/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
+++ b/arch/arm64/boot/dts/qcom/sm8650-hdk.dts
@@ -271,13 +271,10 @@ wcn7850-pmu {
 		compatible = "qcom,wcn7850-pmu";
 
 		pinctrl-names = "default";
-		pinctrl-0 = <&wlan_en>;
+		pinctrl-0 = <&wlan_en>, <&bt_default>;
 
 		wlan-enable-gpios = <&tlmm 16 GPIO_ACTIVE_HIGH>;
-		/*
-		 * TODO Add bt-enable-gpios once the Bluetooth driver is
-		 * converted to using the power sequencer.
-		 */
+		bt-enable-gpios = <&tlmm 17 GPIO_ACTIVE_HIGH>;
 
 		vdd-supply = <&vreg_s4i_0p85>;
 		vddio-supply = <&vreg_l15b_1p8>;
@@ -1272,20 +1269,15 @@ &uart14 {
 	bluetooth {
 		compatible = "qcom,wcn7850-bt";
 
-		vddio-supply = <&vreg_l3c_1p2>;
-		vddaon-supply = <&vreg_l15b_1p8>;
-		vdddig-supply = <&vreg_s3c_0p9>;
-		vddrfa0p8-supply = <&vreg_s3c_0p9>;
-		vddrfa1p2-supply = <&vreg_s1c_1p2>;
-		vddrfa1p9-supply = <&vreg_s6c_1p8>;
+		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
+		vddaon-supply = <&vreg_pmu_aon_0p59>;
+		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
+		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
+		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
+		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
+		vddrfa1p8-supply = <&vreg_pmu_rfa_1p8>;
 
 		max-speed = <3200000>;
-
-		enable-gpios = <&tlmm 17 GPIO_ACTIVE_HIGH>;
-		swctrl-gpios = <&tlmm 18 GPIO_ACTIVE_HIGH>;
-
-		pinctrl-0 = <&bt_default>;
-		pinctrl-names = "default";
 	};
 };
 

-- 
2.34.1


