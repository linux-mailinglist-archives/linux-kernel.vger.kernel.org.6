Return-Path: <linux-kernel+bounces-194305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 680828D39D1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81C4E1C237B1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7D31836EC;
	Wed, 29 May 2024 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QqPE6Vw1"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EC917F395
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 14:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716994032; cv=none; b=VOJ4iYm8hPdtNryoE0KzBNe8vegic1YRKwD4nJDTj+YG6FTaUsmlPgDxzXwqU0Um8kKL08KN4hH+kNkAKr9UeoxYhiK1AuXggGdLCY6zt2us4/ajVht6o/HhbnAhjwP25hL0N17YahLiBuHz7BhQPD9blpg8DSuliUFe5C7aQYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716994032; c=relaxed/simple;
	bh=G5RXv53c1hLv4LM7F4zn3z3FVONduXaRM3LwSBI/B10=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CIOVLt1etSr0TruIUrUk9qh4hEHAx3QJGFP/ZIMWm+iFJkrL2cjXGiLKs4vQmsy+s/WrIHrdCpC6xXfuns7Bup9fQoxh4xfJX0z+/KUDXKQbr7qUkh55zdVnpht5IL0ogrO+CErMKPpD99yTl6H4dktN4d00gD97fKA4cWppHik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QqPE6Vw1; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2e6f33150bcso21877101fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 07:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716994029; x=1717598829; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Up7voLI6IpTr60tew+zNNPmNNe/ChsxQ/yaVPYl4Apo=;
        b=QqPE6Vw1AsjtO2j5UpeQ0pMNY1SU8DRnaSQSUKsEpDWvD9lAyaroHxy6kZKNY1cyQw
         Gl927igCigdRtl2++OnjZHbIFHBjXbqr2WPkJRm7e7zpkbQFMrQnmj34jQjZKqeVumKg
         5D7Cp7i/9T8m2j6lBg/iJTj5pZKP9fW914Dyz6cOu7I23TbnU5hGFmqYHrxN5pZaQzr1
         BUKmcvtj4B7uPTPeCY7Jy8IhYZVbvyE/lBg16gor29tAdlJEZawFACFnUHvy6BTyUtmF
         /X+zQyyKS2TS2RWL/8HB0FDZ1MHIEFytszJrODMlABz178bojgdwZbnhvJ/ZcRITkD3W
         DuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716994029; x=1717598829;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Up7voLI6IpTr60tew+zNNPmNNe/ChsxQ/yaVPYl4Apo=;
        b=lDNPn5svWM4glPj10EJZx6dL2zrp3z2uZuD/y7DtbmjJwkXIZgKX6xIAqkgfFdYyCL
         xHrNTLnZz0dpn6oAorlKqUctXsrvJaZalk0sV9Bov54siLeoTSRX5iZrRvNSChx7NveU
         OCh4lkHF30T9TSePMR/pEYE6Vk1drl5poFc8HN2un+6R9IvUuKVIN2N6KhCFaR/+8uQ/
         7Z64D2k3NC6ltV/ZryNaGtnR9DVWY+B41uoPXRaOc8of9mbPC8Kxou6c+BjcgPKvpk3L
         4t4gk4h66kjjKiya1x1dJ4C5uGUWYlHzLZmXyaWAYi05e0w/Cqdj2TBhwtftZX1BEpjw
         Tt+A==
X-Forwarded-Encrypted: i=1; AJvYcCXc21/3Nz34bIVFRMGNyC7RUrfeXYvC+1V+s3u3XVI/xshc9gaXNJ2tkOaEJjdO8Vxujox6sgM6Eai4OpoLkDeaXDu2WAzH1j+eKsuC
X-Gm-Message-State: AOJu0YzrJSyZMX5VxMteILjA8X1P5aB5WB4Rq+yi9bptFIDbmOAD6gqt
	dMB4TtVNoQGrXKzbUmQi9myDJ+uCEp+of+YyHch8rh/5Dz6144AFsIJR1ILBa2c=
X-Google-Smtp-Source: AGHT+IFdxPSqIzYY5/OBKUguzAhdWTxukIPVKeTWkfd2Z5W4PhNDxwmdr25oHVctqfP0KIBbIkg29w==
X-Received: by 2002:a05:651c:1992:b0:2df:b7cf:9607 with SMTP id 38308e7fff4ca-2e95b0c6fb1mr127182211fa.22.1716994029215;
        Wed, 29 May 2024 07:47:09 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e98c45df0csm3791951fa.68.2024.05.29.07.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 07:47:08 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 29 May 2024 17:47:06 +0300
Subject: [PATCH v2 08/14] ARM: dts: qcom: ipq8064: drop #power-domain-cells
 property of GCC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-qcom-gdscs-v2-8-69c63d0ae1e7@linaro.org>
References: <20240529-qcom-gdscs-v2-0-69c63d0ae1e7@linaro.org>
In-Reply-To: <20240529-qcom-gdscs-v2-0-69c63d0ae1e7@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Robert Marko <robimarko@gmail.com>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=792;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=G5RXv53c1hLv4LM7F4zn3z3FVONduXaRM3LwSBI/B10=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmVz/lhpTmu53rAd76n5+GKFaDXiZ6DP9X7oga6
 QEGJknzQ4+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZlc/5QAKCRCLPIo+Aiko
 1YzQB/9g0vhYfrr9DdBzFj2kNiPPOInEcPHzBBpJbcdTEghOUwzS2CxBmFQTirxRXCe5rp+/QdP
 eiciSjwSsL0rv9C+X5z6UPZtUJSz6actn2wPt0Y2s9jAAGJtDEC4PYBzqREibcZ1qSd/0w7HCwV
 hzcVeIKmdL0/FAsbl6GZj84Yg19e0NLqW8cpNfyd/6tEcSWI0yfXLLG1OAzZfnK6SjbxjrvRx6e
 TE9GYY6gv5Wmk6VsJOtYemZIlRk210HM1kdO+lA55lwQwAiPL2RKJXMATmNKXjuFwkouogcboIC
 T5mXm9Wf8bLhCwUsM5g1iFF/OxO9+sfCMG4OXm4TQb/yth3V
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On IPQ8064 the Global Clock Controller (GCC) doesn't provide power
domains. Drop the #power-domain-cells property from the controller
device node.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
index f128510d8445..12cf85441a0b 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
@@ -519,7 +519,6 @@ gcc: clock-controller@900000 {
 			reg = <0x00900000 0x4000>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
-			#power-domain-cells = <1>;
 
 			tsens: thermal-sensor {
 				compatible = "qcom,ipq8064-tsens";

-- 
2.39.2


