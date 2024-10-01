Return-Path: <linux-kernel+bounces-345508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0BD98B716
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 10:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CF471F22749
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 08:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5405619D060;
	Tue,  1 Oct 2024 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EPi4l5I1"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E50319ABC6
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 08:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771756; cv=none; b=D0xW+1cTKINZOO59MuGidUaZEu0SsjN5pevfPscUgc28ocpNSeSuiPksaXKPLtn/iEaWJBXmE3KNMXLE/g5fK6Xe0NYVD3CZvZDlZFRAb6S0K7+ADzj4q+waSf4RAh1I9CAPdHoTb3IgbO40Okm2N1lcEvemuqA702DtSefkP24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771756; c=relaxed/simple;
	bh=dLvkJEUL6VtVGQkABtezfzHLczpEx2U41WqDsA5yxdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gEDFyowWWG9GKWQd/e9xNVdH6M+2cUmCiNBgwg6CvhyfwkQ4ss5VISKqIl6DRh1W+FqusIgCnAbyCrOhM/8uhuzovGniC4J1MuoxvZeODwH22uyckmY6+ZUH7cGZcwVD62DhVockWqTMFkBp5mQf5squnsmY+tE2e06uHnt7I6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EPi4l5I1; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42ca6ba750eso31563625e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 01:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1727771752; x=1728376552; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NAe7W/LhRmgxZ94rVeyNAaOD54tr0dyFQ/AJp3q7NfE=;
        b=EPi4l5I1wQduAnMuwhpsnYMYj6qjFjb+s3x3ox5j+jJeTX+Q7ZDorGMZz+QKxyCXBl
         u3EjKuBSemB5y9/lEBl6e3/kjMqWTMaFpXgp7MRRnuS6UDDrlT+QXW19yxER5+sbURGr
         kUnX61UM9IJK5IiIkoZkhnRDHnnZmRtlNFKBNtzFzUEnTHcNM32F6cR5ZSd4/GlpWdrk
         qUOJMMZ6m+c4QlisJOpSrNNeWf/YUjvktLcCjyVyn8KDFRdaJwXnwr+a0a+2NakTnHiZ
         fUO1QbDSc+MM9KXSGlq+9RW51hWlN2J+PszR1WHeWOSs0DwGhfsji0R2Z9cIvtZGbAqp
         3IrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727771752; x=1728376552;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NAe7W/LhRmgxZ94rVeyNAaOD54tr0dyFQ/AJp3q7NfE=;
        b=lnwQbLjgq6ldvHSwuagmGRivUY7I020IfBxwSogXAmLLEDlBlemXZWO8Zm6IPZS3cz
         35W2UIoaehSXMJ3OiIUa/fPfrqHBB0pj7uiSnQFZGEysaCRYbXeKDlJssn16jZPO3Tqj
         UyKb+ucxiTltwUZ+CNxmRttI6Cdc0tuFOg604lECA6GUFF9yVUh8Y4e3qIASCy6CZBj9
         cInr+XqYbEFyTGE/FI11UOvTAAU3y318MLfU4Ddcuuv6+rJbrtQJhFuyNR0ZhW4Nhpyd
         +KIi1WxO+H24Qr1nJqe+UxP9RHqHAYnTHBB2kLaGD0db9fCoyly8dPigCXHANlLYnCuj
         Wrmw==
X-Forwarded-Encrypted: i=1; AJvYcCWEifWDNCHHSR2nuMHUB78vWrdO9clppaK1L8UyMh4jyCeqkXokZsmSmZ33I7iPQRJKpV1tisWK2dgaagc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIh79+CRATRsg7LgXgeexU+Z3dDSKQZWhQYOWgR7gjLFYaaWA9
	QQlRXpmzD1JR7Uk24u0Xxgq5pseWGQL1ynSygqf+wsuTGuYkEtHW6x/0NNXhjt8=
X-Google-Smtp-Source: AGHT+IGTc5PdLgxOcB4mgMUK+uyG0gMxgfSEKwlPwrDMROsOXPTseEgNxu923yzUO5AkovZ84qGJWw==
X-Received: by 2002:a05:600c:3c91:b0:42c:b7ae:4c97 with SMTP id 5b1f17b1804b1-42f7137bd74mr12815675e9.11.1727771751811;
        Tue, 01 Oct 2024 01:35:51 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:cb1d:dc:7e00:b926:7e5e:6e5b:896])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd565e881sm11231406f8f.44.2024.10.01.01.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 01:35:51 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 01 Oct 2024 10:35:30 +0200
Subject: [PATCH v7 1/2] arm64: dts: qcom: sm8650: extend the register range
 for UFS ICE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-wrapped-keys-dts-v7-1-a668519b7ffe@linaro.org>
References: <20241001-wrapped-keys-dts-v7-0-a668519b7ffe@linaro.org>
In-Reply-To: <20241001-wrapped-keys-dts-v7-0-a668519b7ffe@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Om Prakash Singh <quic_omprsing@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Gaurav Kashyap <quic_gaurkash@quicinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1273;
 i=bartosz.golaszewski@linaro.org; h=from:subject:message-id;
 bh=G/MbeLTD1yijbokrC0s2c0EyRGDKayzx4cP1dLSlqkU=;
 b=owEBbQKS/ZANAwAKARGnLqAUcddyAcsmYgBm+7RlISNdxOU5w3B+q5g3zeZQr1mZX75d2d2Op
 bBQBCW2pLaJAjMEAAEKAB0WIQQWnetsC8PEYBPSx58Rpy6gFHHXcgUCZvu0ZQAKCRARpy6gFHHX
 csEJEACUwVzRK8WCaNE9HY4J2E0pCltqZsaCUTrts+1+CZhrJgLX5wMBNeV0Mb9Xce67tca2rzI
 CDpl2Aw2Y9CxhFGeBWwisMEqtZ9Kpgw9bEEcN0eGnOeoBSQR+3V9VlDwrZPJtOVjBG6KJWid1Eg
 zH9CQ4fgImpWgssYm733WZIuCMaMaMeGg9BV0P3miBPBhI9DQTh4sYWP6wvxMFODGQLAM18pLmJ
 HV9kb5vTBoTnbfrteI0ZblL0zU0IvkNpyLsvTX4Rc03lqhddxA1mm/Uu5SSJ+4QddrJD4Zbr7cs
 JpEVHLR2XtwsZ830GooQXt9kdJ4ZxrA3L09epj3Dtg+XQEgh38d/eKkuwlaCMlw4+X5k8XYWYP/
 HXTh5lJXANSm+2UcWAVQLHkRvkBcLIgffMJ6DHVi4MMqgWeOPga/zUo8OvPiep4Zq/ufiTlsG2Z
 evuSqnvZlD361vZUwt4i0PyiA79DkQThQe3NtPWh1ji8PA53+I3bfAtFK0MhA+nh/xSZVOJBELn
 aqRykXCj1JLgRNUIhLK49GBYhw0DLbLIGE3UDBoEi3X2HdQBXxhHhFOFAn4lajaLOsuJGggDsxY
 rKzmGFt6G35RHHlgLrQ9uDX8mAN7YTXtfZBL2GB7+o0wEY44BtKM/sqp8yb2cEfMDSX4TWEE3L6
 KsW4xgmanaMZTrg==
X-Developer-Key: i=bartosz.golaszewski@linaro.org; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The Inline Crypto Engine (ICE) for UFS/EMMC supports the Hardware Key
Manager (HWKM) to securely manage storage keys. Enable using this
hardware on sm8650.

This requires us to increase the register range: HWKM is an additional
piece of hardware sitting alongside ICE, and extends the old ICE's
register space.

Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
Tested-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Co-developed-by: Gaurav Kashyap <quic_gaurkash@quicinc.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index 01ac3769ffa6..5986a33ddd8b 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -2595,7 +2595,7 @@ &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
 		ice: crypto@1d88000 {
 			compatible = "qcom,sm8650-inline-crypto-engine",
 				     "qcom,inline-crypto-engine";
-			reg = <0 0x01d88000 0 0x8000>;
+			reg = <0 0x01d88000 0 0x18000>;
 
 			clocks = <&gcc GCC_UFS_PHY_ICE_CORE_CLK>;
 		};

-- 
2.43.0


