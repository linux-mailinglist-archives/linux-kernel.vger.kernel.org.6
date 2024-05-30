Return-Path: <linux-kernel+bounces-195661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9AEA8D4FF0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 18:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925C7282EAC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 May 2024 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C32383A5;
	Thu, 30 May 2024 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pH8RIvrM"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9B222EF0
	for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717086959; cv=none; b=DaCVu6lNnS1UDoljUn7BPlp9H1kpA89wfrchFKzjqMI//BMI/cKL6xhRyATr1XxZFDCzBi4ILUybaJjJRTiplGVjFt0L7R+I21LSPS3JGHUWOrvns41y2vVCrt/VJzRsa2ENkLykPK5VHbDv1EU036LDUcu6SkBJtNZd78AGUAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717086959; c=relaxed/simple;
	bh=6HntS71rHp1CBZeIhiK7csmrNdwGhdAijMWT15I8h6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dC6QfujGm2GWiy4p2Idp0Yo2CzPVHu/Jv+quK+3wpp+Y8w4UOMSaa0NAkR9hZe91KIwJWtYpe8r+NtRnwM0m1DChjnsrnOPdASTNwsv/vrV86jfqAoH+XPysO3wkGnYEb5PtSlvEjHOgdQ11wWShbVjeoT7mq0Ko92AjX6ewolU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pH8RIvrM; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57a034697fbso1395936a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2024 09:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717086956; x=1717691756; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVNBbeVZBvTq8FFnr5SMvxjl63WbZpKZEJu2+F+OFfM=;
        b=pH8RIvrMFZaE8iLBBEiltfEHVNSBrHJQN9Yf4Z6wVbX/jsXsstgCTERRRBEx0jCcaV
         j+WUEymy4v7ybIaKjMmsa6oOWWpWG04Eca8vEt5O9j+mva7zQgTHs0hEw0prxTJ6C+9Y
         296MU1kep5+AO9EPIDREGeflojCvOGVozMqVyhemPmYSHBvpjYxKmJEmBXSSEh1WjmH4
         ZPQkI3yVHNP/yriZw1YSP30loDS4nMpY+Knax5coFT3AXHvaJWDX5YzDSr39q1ckjsEV
         RxB+Tc8MrV0SAp7BKszNpR3TcZLwLtv41bIpHX9A0jkurR1rd45UuH0fZeGT670A9HDb
         eJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717086956; x=1717691756;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVNBbeVZBvTq8FFnr5SMvxjl63WbZpKZEJu2+F+OFfM=;
        b=j1h59W5MusIo0oRBROhhjrRy17u4PiNAPOsQl05P4D+RvHQURrEevfnUrOh2Wp69P8
         Y6HsYzmaLxkPv9+cHkS/64kKTsM/HXVUPXMP/HmlLGnmKHOGO+DA33YV8Vvn6vvBx++Q
         pq0qSMRt1WqAYmBsecbcEI9XClE9KePMGKrwTgDwdwjj2K/F/uaIMbirNmW+wKSMUKxy
         1Uy+qHAMrUnVEpGytcLyVfS0tA54epNV82svU0xsUZXkkljZPPkvwc7ocgnsnLpBy0aT
         MaBdfxeasmXFr8brxih25GdA5V9z54c1KT5FuBLK6dnxu+iPC1I3YHcN9uxFa5rBP3fS
         u1Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWHQAT+R1HQ7reNw81d7VNgp+a8d0GymYqScrcKT0pYAG5jLQHuIjecPmSYZm5xtk5lQrLjn8M4k9yj11IXpA6zmzJXWjeW6WkAFkFN
X-Gm-Message-State: AOJu0YynJrFRUj3OMkXgmOAVVs3ztNp9LKGn7WVSfRe0U/XUUywyJ9Ye
	QOT99Dy/dx0Dpi69wRgNa+TCAo11cN2DPWRtOu8z/SU7W8hAwHdu05jvVmn9zQk3tO5MDF7TCOo
	f
X-Google-Smtp-Source: AGHT+IGNvmaxJuZ56kRub6HJrnCCvwMNSDYvRB4DosUBUCyELTa77vo317nBgy8bmWqwQJ832iIXDg==
X-Received: by 2002:a50:8e4f:0:b0:574:d0ae:568b with SMTP id 4fb4d7f45d1cf-57a17941e6fmr1599753a12.38.1717086955777;
        Thu, 30 May 2024 09:35:55 -0700 (PDT)
Received: from [127.0.1.1] ([188.27.161.69])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a10670df6sm1888885a12.69.2024.05.30.09.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 May 2024 09:35:55 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Thu, 30 May 2024 19:35:45 +0300
Subject: [PATCH 1/2] arm64: dts: qcom: x1e80100-crd: Fix USB PHYs
 regulators
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240530-x1e80100-dts-fix-usb-phy-supplies-v1-1-6eb72a546227@linaro.org>
References: <20240530-x1e80100-dts-fix-usb-phy-supplies-v1-0-6eb72a546227@linaro.org>
In-Reply-To: <20240530-x1e80100-dts-fix-usb-phy-supplies-v1-0-6eb72a546227@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Sibi Sankar <quic_sibis@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1782; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=6HntS71rHp1CBZeIhiK7csmrNdwGhdAijMWT15I8h6Y=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBmWKrmhqbqD8t9tvszAv1baRL8ihnUNlnUH09gD
 wLt4NxcnSyJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZliq5gAKCRAbX0TJAJUV
 Vua7D/4ohzvO8XSXtv+ggscSb5rvZPbh61AgPXyeNxptSYQ/HSGNv72mhcWyUVh410SHUexN7rq
 yItrMpNbLNtdo4a8opKDzvDn3WXN6QxsztT43MYwM1bAVcg3Uer46p7Ev5ycLBbfl3kcKcV399B
 iySMFMseD+qVRCChz/UV3yjTa4AVgeopgm9b5iG59L26X7VL5Oh0dPQAvMolbx36n3msrUGyWAK
 dM98ua4aHvb2cFJ5R5OUqn273PNLk314ew2R36mQdybeOFnNomtXRQyUTM85+ulrd2jVpfqWFF5
 fiUG1ZMK2PZqmMK93NnrjxsyMq0YcO/ISAraOdavp6RPrY0Rd/CQjh6G2u+YDfpx0dg63MVjmys
 5UqVPHL9UFJn0o46vv3n2FdnEQTy7z4k4rz9z9f/EJQxoKHOwGdPy0dTaYFHkJJxn5jFzEsR9mu
 K6LLJpat7/4qqaQYIjReHcAg4NyayqgoQXQmCnUpqqIB7Ejhc9tdUIo1R3tadD6f+4e3FKyqp+b
 q8p2BaStjuf/kSivArUdCfRQijlC3nGeSEPNo7r9gDPnlTYgrJHKOWJKZz6Fj9AMz0fBUcmjryI
 WxG+ushhU9YG6wIx3TYRRHwlSSsCdNjOoK4m0zfvoOXEPPS8mzL4fMDC1AnS8y6W9wpR48biGst
 0izbJWAdco23S1Q==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The 1.2v HS PHY shared regulator is actually LDO2 from PM8550ve id J.
Also add the missing supplies to QMP PHYs.

Fixes: d7e03cce0400 ("arm64: dts: qcom: x1e80100-crd: Enable more support")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-crd.dts | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
index ed8b80627534..173a88b6b8b8 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-crd.dts
@@ -841,7 +841,7 @@ &uart21 {
 
 &usb_1_ss0_hsphy {
 	vdd-supply = <&vreg_l2e_0p8>;
-	vdda12-supply = <&vreg_l3e_1p2>;
+	vdda12-supply = <&vreg_l2j_1p2>;
 
 	phys = <&smb2360_0_eusb2_repeater>;
 
@@ -849,6 +849,9 @@ &usb_1_ss0_hsphy {
 };
 
 &usb_1_ss0_qmpphy {
+	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-pll-supply = <&vreg_l1j_0p8>;
+
 	status = "okay";
 };
 
@@ -862,7 +865,7 @@ &usb_1_ss0_dwc3 {
 
 &usb_1_ss1_hsphy {
 	vdd-supply = <&vreg_l2e_0p8>;
-	vdda12-supply = <&vreg_l3e_1p2>;
+	vdda12-supply = <&vreg_l2j_1p2>;
 
 	phys = <&smb2360_1_eusb2_repeater>;
 
@@ -870,6 +873,9 @@ &usb_1_ss1_hsphy {
 };
 
 &usb_1_ss1_qmpphy {
+	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-pll-supply = <&vreg_l2d_0p9>;
+
 	status = "okay";
 };
 
@@ -883,7 +889,7 @@ &usb_1_ss1_dwc3 {
 
 &usb_1_ss2_hsphy {
 	vdd-supply = <&vreg_l2e_0p8>;
-	vdda12-supply = <&vreg_l3e_1p2>;
+	vdda12-supply = <&vreg_l2j_1p2>;
 
 	phys = <&smb2360_2_eusb2_repeater>;
 
@@ -891,6 +897,9 @@ &usb_1_ss2_hsphy {
 };
 
 &usb_1_ss2_qmpphy {
+	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-pll-supply = <&vreg_l2d_0p9>;
+
 	status = "okay";
 };
 

-- 
2.34.1


