Return-Path: <linux-kernel+bounces-439145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9969EAB66
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 10:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB01B168E5A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 09:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBD63594F;
	Tue, 10 Dec 2024 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZduQ2svO"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F23C2327BB
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 09:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733821683; cv=none; b=WmfsK1x+lsudLUdJyHGnB11gq6Ejhk/FiCNU0uR1hl8+83OCW8Zwt56phuBAQlOn2WYCzCpaqanVwqFY8+KGWyfoXmSNvRNwZj6pfiNN6Jl559q6ghY3eG0sUaxlQp+dIBX5FAgaL8c/rxC7VcZRLuFzWXakE89KnDBH2cuIfxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733821683; c=relaxed/simple;
	bh=9Mg9Rrhg2LSgODdoE1tzq9KxEGyDoyShcD0j+29WE00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sCWj9gdZ/JvXg/mT2dShwsfld5ohT5DXOg25Di3sByb5MeAH7gY/Hh+Kq7PGmzFPvLcjiIN4qn9XR5JPI3Ksu1MTa+bJ5cNlx/h4+8rW4gLgYW4Cjj3+sj8d7g5LV7F97fjOzVW5iQ1wsUXRSvGIWSi/d/Qh2zMOr1bS9MH6YHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZduQ2svO; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-aa6332dde13so676676066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 01:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733821679; x=1734426479; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WGvX2QcuP5DqxIvnEOgzcaFNQkncwNJahENclIwi56o=;
        b=ZduQ2svOS3RkVXC0I+abxYSuR9T+T7Nrp/GMwUQuMIeJzE4Wi/CQs20T/IJGSMxh9l
         WY3oCYMlT4PfzTrOep/dHYsxQyZnmzeBe/sdejERn4XjoNesEW3206/mXYByGvJ3vboj
         Cu+pq7K8JDqokbIfaGbs2Lxg8EYJdDwqcvHCZyAZk+ygzBaPPJcVb2eYM+H+nxAfNg7A
         VJtaFGptIT31jBNv55xOtgDqJ0mnRzVjSKAILg7zmsF7dDiuOpGMIfaGDZjOtDOUc2ft
         hxJX/CtYsGKySh2s7AZYojrxEqHE+6QX0/4zdoetQY85CjpS9H0sY1nJRTipsGCiWHWP
         ioYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733821679; x=1734426479;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGvX2QcuP5DqxIvnEOgzcaFNQkncwNJahENclIwi56o=;
        b=K1PriKwNBWABzajcMUEkmyRfVyN38/lgCjjiEOJLXH8vcQiHg8gJrJ1rOIhXZy2/ok
         MextYaeyNRBk8iBzLEocIN/1ioOFTZmJZi02boV+Q48LQUOdUbxExIQZ6qJprtK81kCC
         dpwStIOhXTD3j8JBpIS/6Oi0+g39wNPQRtOppXs4/3tFE2q9VuJDNyHVtiNsdmRH7QFP
         x8Da33m0OB8aNsZ9XDAC58178OroythDDNgpI5zrMu3AOTk5O3HJ+ud0dpYa33mIuSiJ
         YdEXjIKl1a9jH51hJ2891O+O98/JdiTpoHRDMCsSVRB+jXDE2/tKN59AscNC07CtCu6j
         6V7g==
X-Forwarded-Encrypted: i=1; AJvYcCUJTnjxMk72O1Ju9G5O6vuY+DK1tX+mKNiXS3SgrfrELwiW+tZHwgX+OMskzaaTBn65faQTx5NFJUVpCHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy98ioh5735w6EWgPM1n5//u4M73BJQC3niYKDrxLzbjSqjDlY
	INHa1ftoDrB88SIqP0qK+sm32LRmlVUmNSb+tEpTIrerICZBLOvpe1O1/B9dJhE=
X-Gm-Gg: ASbGncuObL95eCqXkDF/HzxY0vrmFjnLNBnJQDEUdsHaR9HmuXsHHvCXKPnL3Fuc0WY
	P+Z1bdAwATaPOIR6l35ZnGA0tpnN0vDKvbq9FShc+6xspys5qiMrqKk742nYz5zdQs08j5bAo4W
	HE/CX+rCeoChtj76+aVNZIgaSqd4d04mKcWMXTlwifdfSXHDNWmRYW/ewb1kAUR5jRHglqfcn50
	/FkgaLuW6BnyeYbsu6706TsPQEl+Y0gJb6Y3cCFD/o8U63gWHnw77knHtLx8h6sYP8=
X-Google-Smtp-Source: AGHT+IFFxJvsB6263TiO8MdGloxcpkH37mJHnB20Jq9KyPdczeyIZAI5e+UYVadqqdV+CIYbcO58gg==
X-Received: by 2002:a17:907:75fb:b0:aa6:98c9:aadc with SMTP id a640c23a62f3a-aa698c9ac13mr485527966b.31.1733821679421;
        Tue, 10 Dec 2024 01:07:59 -0800 (PST)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef40:6709:8d26:5167:3c1d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa699618041sm173148066b.81.2024.12.10.01.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 01:07:59 -0800 (PST)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Tue, 10 Dec 2024 10:07:37 +0100
Subject: [PATCH 6/8] arm64: dts: qcom: x1e80100-lenovo-yoga-slim7x: Fix USB
 QMP PHY supplies
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-x1e80100-usb-qmp-supply-fix-v1-6-0adda5d30bbd@linaro.org>
References: <20241210-x1e80100-usb-qmp-supply-fix-v1-0-0adda5d30bbd@linaro.org>
In-Reply-To: <20241210-x1e80100-usb-qmp-supply-fix-v1-0-0adda5d30bbd@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Marc Zyngier <maz@kernel.org>, Xilin Wu <wuxilin123@gmail.com>, 
 Abel Vesa <abel.vesa@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Aleksandrs Vinarskis <alex.vinarskis@gmail.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
X-Mailer: b4 0.14.2

On the X1E80100 CRD, &vreg_l3e_1p2 only powers &usb_mp_qmpphy0/1
(i.e. USBSS_3 and USBSS_4). The QMP PHYs for USB_0, USB_1 and USB_2
are actually powered by &vreg_l2j_1p2.

Since x1e80100-lenovo-yoga-slim7x mostly just mirrors the power supplies
from the x1e80100-crd device tree, assume that the fix also applies here.

Cc: stable@vger.kernel.org
Fixes: 45247fe17db2 ("arm64: dts: qcom: x1e80100: add Lenovo Thinkpad Yoga slim 7x devicetree")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
index ca5a808f2c7df66a861a933df407fd4bdaea3fe1..77908462aef6607439b8e950439a4c4ef9833b57 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-lenovo-yoga-slim7x.dts
@@ -908,7 +908,7 @@ &usb_1_ss0_hsphy {
 };
 
 &usb_1_ss0_qmpphy {
-	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-phy-supply = <&vreg_l2j_1p2>;
 	vdda-pll-supply = <&vreg_l1j_0p8>;
 
 	status = "okay";
@@ -940,7 +940,7 @@ &usb_1_ss1_hsphy {
 };
 
 &usb_1_ss1_qmpphy {
-	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-phy-supply = <&vreg_l2j_1p2>;
 	vdda-pll-supply = <&vreg_l2d_0p9>;
 
 	status = "okay";
@@ -972,7 +972,7 @@ &usb_1_ss2_hsphy {
 };
 
 &usb_1_ss2_qmpphy {
-	vdda-phy-supply = <&vreg_l3e_1p2>;
+	vdda-phy-supply = <&vreg_l2j_1p2>;
 	vdda-pll-supply = <&vreg_l2d_0p9>;
 
 	status = "okay";

-- 
2.47.0


