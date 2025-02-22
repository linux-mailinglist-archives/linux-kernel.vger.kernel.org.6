Return-Path: <linux-kernel+bounces-526848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5B8A40458
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 01:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76F5117802B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 00:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B101984D13;
	Sat, 22 Feb 2025 00:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uZz+wENo"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C4F7081A
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 00:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740184996; cv=none; b=O/5oGLqsh/krw9IJV3QTe0Kumqyfq88A6uULtV2FPeaZ8793W/3QmnJ8MYjWrKCyVp5C2kYFVwjJbsStrNiUPU/6Fjo4W69M48y13sCRft5HPnMh22LrxyqKAMbCC1kDZ8AEk0ObMCLgCLGKQVzcLSqh+g2TRizgtxoxfjakr0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740184996; c=relaxed/simple;
	bh=RPWOCmL23bGGwiUHvdooGKW20ZSBhHUbBWVdVubFaOI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pnMpwJ4kE7tUYEwT8cqr4r3ptYnkO3HXQ53KPUxsamrMopj6Bi+lbTPpp95lUcLkk6Gii3JvvMZh/FwBREoJMmfbg0PYvjU6ZPs9fV5hPA434ipO3yhxCxBoAaoTZ6HyLf33OqQ8Y2nf1+cHzQJj6UsITlhph3klDUaEmb76qfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uZz+wENo; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-54529e15643so3348236e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 16:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740184992; x=1740789792; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DnejlGa6g9a4DQfGIg7S1SaLgJ/zYRveKCuAvDE4/uE=;
        b=uZz+wENovzegzCKi023DOOKNWXdDujEpEJ3i5uU8JF4gVXb7SUrRWwApayIVayDUcx
         pVMNJq+odxHjxbdPwLOL03j5KRl8kF5QOZcAW7bEocFjB4w4Dnfzhssx2De7/iR0E0vQ
         dpID2L0X/AzuPBOgC55mJrP7upMG48Qmi6Gp/5t9aiEGTrUADc/SBA9WzsnWWSSEkyHd
         cm2keNdNf6cdV1BhppnLorDq1UveK5/uOnYWZtKEkYypeSSRuV9my0PdMosD+BxxVsMD
         +8gGA9hdtsf/UB64WMW+JYTjqam9fu0sekyOo2b5t/waPpS2xRBjzvllRHojtzSCPIlh
         JF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740184992; x=1740789792;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DnejlGa6g9a4DQfGIg7S1SaLgJ/zYRveKCuAvDE4/uE=;
        b=eoLEb6qHrvq9u96Wrp4pJX7HuK1/aYS2rBSOrYgwwj6Obmic1PIZS1BJXk6P7Kffvc
         8ad0oN9pTjEfvATuBpeTFoECKxpjrI0s5wY9NbXcvftdN4SrjLS8uv3wzaWfusz6PU7+
         ibnmBePUMi2qXlr53e8CJehRKpk99uvc8e6kgjv/S9eHj2griby8bX7RZptzDgh9w4gy
         EIUGbT9duFR8+ritG17MCYBZbulmRdBp9m9O0wTzvFzvalr6GDHnjMUPkwYlnd/SHe7Y
         CkbefR4rJuD9tPSXwFkbZuvyvDNDpCV5IccHHIGJT5ygRFhCV5R/3D1TET1KEtPwseqJ
         t30g==
X-Forwarded-Encrypted: i=1; AJvYcCVUOaoyUSPOTsvlIl6mskDrwAD4RTuUmNAskZ5zHNSGfjVBZN/Mtv0itL2XQxNqpfiqRDZyGO4EA5QDjuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR4Dj85VdnLtq+1x4+znbCOrNCsGx7eCme7fylP/iu7CoaHf91
	FPfo2S3esI+Nol3yiz2wjsZ/i63UobmHhiIfbI/lq1SzJh2xqEyzvzqCY9f5PZCwPaep3lLFBIW
	s
X-Gm-Gg: ASbGncuM4Gh/VzXqMzZvgOaXHt/C4QUQohmOdnE1xVi2Z3Z19Hmk/yeIUYOjAXBzIAd
	+dgYb0CdaaprdeFR5F5XGQbINU/fwvM6SPkTvZZ8hXJCiMv7RRFOHbQzHKiRo4swpsucOmDp9eU
	KcYMxhcCIft9Rfix9NYeNgyZuQFV3DD08wAmPu0cqFW5QzkM3Q3giG5sEZESh9FWHBgkvQvVvIp
	PyfsTqqk8pFXM2e73neC0Cp5EsTnx/+fLCCOwj6JmbmuUUSuLbq64HEpszY+krmMroXS+NvNa+Z
	Rym7gjqUuIBd/td+Y0XAGXpRTw35YSZEiA==
X-Google-Smtp-Source: AGHT+IFTbKAI02b+n1LYT7wgygeZ4EBpiAgpy3UaJWVjaKzRgtai4q2fSYnC8SZ6lyL+pS18GbNcvw==
X-Received: by 2002:a05:6512:1324:b0:545:2b69:41a2 with SMTP id 2adb3069b0e04-54838c56e8cmr2186175e87.4.1740184992194;
        Fri, 21 Feb 2025 16:43:12 -0800 (PST)
Received: from umbar.lan ([192.130.178.90])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452c301175sm2412090e87.139.2025.02.21.16.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 16:43:10 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 22 Feb 2025 02:43:04 +0200
Subject: [PATCH 1/2] arm64: dts: qcom: sdm845-db845c: enable sensors DSP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250222-rb3-rb5-slpi-v1-1-6739be1684b6@linaro.org>
References: <20250222-rb3-rb5-slpi-v1-0-6739be1684b6@linaro.org>
In-Reply-To: <20250222-rb3-rb5-slpi-v1-0-6739be1684b6@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=905;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=RPWOCmL23bGGwiUHvdooGKW20ZSBhHUbBWVdVubFaOI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBnuR2a3DJav02uZQua5Scrp076y1z+T5zQKbX5g
 yFD2EPfG5uJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZ7kdmgAKCRCLPIo+Aiko
 1eDRB/sFyoMDGgIGkiQD3rStRcpGNEDaw4ReXCxQfM/vXqAv5preXM0yoH9nkyHxFDjfvo1gaZh
 XwFJ4pNFSa3N32H2j0uEua6ZbCrN4VbwO88Xw/QoeUxal9ihAIIjMEA1iDtT2P2Ej7l2l7ZnMiX
 0oCrtXUfCPpJu79iFUvZsr5cbE7DacNv3LYOAh/CkSs8ZnSHY+zCwNFvvVqgKxLmqkViVJMXhDT
 5uDrcvKQYCUOUswKxFKS9IcnnpMH8mI/udetOBraRkXuy0UyJLbOnS4ZArvjDF0QO33Lwxoh/Bc
 wmCzzGSu/B8gLSbAMNGjwC8K0VoElYHlTfSbhJxmSjx0kqCR
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Enable SLPI, sensors DSP, on the Qualcomm Robotics RB3 platform. The
firmware for the DSP is a part of linux-firmware repository.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 1cc0f571e1f7f3023efa08adf2791ffce5f2fecf..cd6af2fbc5ef424d57c36a3ed66a6455d09bc30f 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -756,6 +756,12 @@ &sdhc_2 {
 	cd-gpios = <&tlmm 126 GPIO_ACTIVE_LOW>;
 };
 
+&slpi_pas {
+	firmware-name = "qcom/sdm845/Thundercomm/db845c/slpi.mbn";
+
+	status = "okay";
+};
+
 &sound {
 	compatible = "qcom,db845c-sndcard", "qcom,sdm845-sndcard";
 	pinctrl-0 = <&quat_mi2s_active

-- 
2.39.5


