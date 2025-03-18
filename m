Return-Path: <linux-kernel+bounces-566464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE1EA67856
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 16:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8F5D421B1E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 15:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B27E2101A0;
	Tue, 18 Mar 2025 15:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LL20/uxJ"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED8B20F070
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742313053; cv=none; b=Lbjl3h60PVPXYCl5EMoGn1JR/7kVBhO7Cwv0fyKl0wC2XZRlnbM/bygca/0IjNpEdb5Hqapw627pxq5P/abE4ZKAHG/z84mEiHUwdmoQjK4NLhB01u1jtRwF8iPq+aw3Uv32ReAIv7+c6a499JG2SCV436roe39qjADxHrJ7C6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742313053; c=relaxed/simple;
	bh=rCVeganpgKkSmMUxzbkZl/t2tM+TN3Tix8wM6E4Lfms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mrc0Hd3V4aoDjAbjp2VrksqdCde5BCUsAHGR9krZDINVqvH3jChoqMv/N6ReTbVCOlPhW+2zPwkYSIJxLmDB+3rQ4nVu9mN9fULOtlKFa/YxgNV+vKkiDAzte8Bf7zgr3yQ3SIbcJL/aJXEYqONFUcJFRiD/w25X1LMSVwNucjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LL20/uxJ; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso191464866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742313050; x=1742917850; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/SxRdYZ96n2ayDL/V6fz5vJX00R/j7bp+EUMURrHrM4=;
        b=LL20/uxJfnyu3Tp571roFQEX24Km+CtoTVtW5a1g8qgDkjlLgXGjI2cIUCgcwSSTLZ
         dRgj0o7/4J8ZDn9NSjsrREVYfzZ4gXszPGyef5p5efwNX+RBALhazjt3iehOfDbGBi6v
         k7Jzck7V6FzT79qgj+ZbPWjkqBPuCc147GMQN5mEsgrqC0lEBySP/DeD6MBdbqYwPuOD
         6QRRuCBPIgv3Lhq7nQobzlLVPWaTworo/Z7gfNkc4vcBH9yCDBhaf+VKQ5y+y1fQsL9b
         ysDgaH+rrE+zrOwTWaUUo29IUjoYf9h60Ng1LxX36hVtAY4QY3vGh/1GnKbiaM4qWyJo
         NEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742313050; x=1742917850;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SxRdYZ96n2ayDL/V6fz5vJX00R/j7bp+EUMURrHrM4=;
        b=FEy3GExxqgi8gdl4AZRaJltV7jNBc4mnQp4IJuVBOwloy/Qt+fb+dw/RaX1OfYwYo3
         xHOq65MWPobhO7QJxk/lS6RLFb3uh6BMMdgMqqLvzlnMZMhQI2wH2zknjNQOwDah94E8
         f4hNzVYHI1nH6O5nXG+HvXtT0JTZatZYjCis7pTgzT6rDXkPZcWo2etYlzrqRKE7WVIS
         6/m3YBDhcrgHTxeEiFZ6X6MqUSHF6RDha35D2jIqrvZASTH6lou8ldKD4d3qn8zoQL/j
         d0DEljFgTrEd+hkBJcJqRzDvSuRhG7J1smskVQhEdo+cDiN3/UbCXsAa98NZxDkPPmQD
         PEwQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5y6SfnvL/gvTD8wuYNLXG9BzIcvIbHG8TFk8GsHKgGH4pa3pvcVmvCltptpTO/tdlftAoxDJqUZWd+tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeFbSoUYA6+o84hb52QSkyxXwPIVveF6Bbgf3GgmxAUF50wrRN
	tCxuN1PClK4YasQZ9ZgHieRR4q7GP7jkhPlpEj0fyHCQwt5GcahP9+c9xNmLvas=
X-Gm-Gg: ASbGncs3qFibkkqO+buR9ps1kJvhPjVagJIAEIM7DJAioiJu6sLVOp++HBAyq8Tmmns
	A5NfZJmT4Qtv6VaFoxEMpP2gdwqCy+vqiFzdkl22Up+0OE/3CRj7L4glc098z3jOdIs77HQ+0Cs
	w8Mq9UstWt6T7N9PxpOQLygbDtgoC1zp7bflObBePBAf1zBkIw34Yxz9PpZncrPqHbHOk/EHrnG
	XdLNFh1p+c2eH+ygAIfd71uB85W7u80/4CLkOYp6H2P5P1G1UfTAjsttlI0nsw++MgEfzoBUGA0
	PYeLM/xoUoCWiAXyMN+wGAFVNonqexoKEy7C6nILI5U=
X-Google-Smtp-Source: AGHT+IEKCPuQQev+o0+YEdDKl7tdgUxc3l0FvMatFpeLvpp4wnyLNN8JknDhVHmNYu1IQdq9pe6y9A==
X-Received: by 2002:a17:907:7241:b0:abf:78ff:e271 with SMTP id a640c23a62f3a-ac3304dffa0mr1984316566b.49.1742313050085;
        Tue, 18 Mar 2025 08:50:50 -0700 (PDT)
Received: from [127.0.1.1] ([62.231.96.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3149d0077sm875615566b.93.2025.03.18.08.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:50:49 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 18 Mar 2025 17:50:35 +0200
Subject: [PATCH 2/2] arm64: dts: qcom: x1e001de-devkit: Fix pin config for
 USB0 retimer vregs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-x1e001de-devkit-dts-fix-retimer-gpios-v1-2-1c092f630b0c@linaro.org>
References: <20250318-x1e001de-devkit-dts-fix-retimer-gpios-v1-0-1c092f630b0c@linaro.org>
In-Reply-To: <20250318-x1e001de-devkit-dts-fix-retimer-gpios-v1-0-1c092f630b0c@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>
Cc: Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1454; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=rCVeganpgKkSmMUxzbkZl/t2tM+TN3Tix8wM6E4Lfms=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBn2ZZUjDHi0vqhIg3drSU+F3dHvkYwMoFaYrTN+
 cD4T6qtT/6JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZ9mWVAAKCRAbX0TJAJUV
 VmyVEACkYoRW8iPBffxz1TxKfC9gNMTU669MB4BwTaURu+VzQfqXIzPBnQcMQiP076Qyc8o21Rw
 tLkoG9jYZd2hIoha8GdMYDynMLH9PeOclE0xrCvBvpWPMr16mzLcVq9BgdxKTRcGVZ5DMTSW5q/
 iSjnsL6Tek39HQ0ua/D8I6CKRsVdSKhIJgM1fkA/AMUbxnhnT7RgYGbauD8Ir+5zP6AoX1jGbq8
 Jm/DyCh3NUhgqvbImeQCAp2wjRHPWs5EDykAgDYKD1ksTYaQhQLCTTd0X/QaLcsmcDAZM/xTVjp
 eaOM51cX7d9wman5r5xPjFk6YnV/AIME36OOlTXYvh2Xw/YzFF9Xrn/MzAiTh4ySoOGSK3dPM2N
 FjFi3CtSHvLjoqjeUdlkd89d+5+l1q3ssr4YOSx2IsOfxn7emSDBmk9jdNKOtGDBJ4OYYbExnt7
 Qn+jwsEVgURKPnO6N+RvYVXE/nkhSw8QvCop4qNvUcxp+aLv8pRZPNTo+ZCGlm2rW6knetVHFez
 VRhnA/LJPjkInpxrSciAxJDJXZQ1lEM9skfEz0fSs4UBcf2obnqR80KQaQLei70sL0/oJ8CE22i
 kiCjeRjlojyFWNYc3vX0/M4EuBZ3DK8Gf1YqoD0rAuDunhDzYbif+QXuuxNmndP4R48UPii79ye
 0svPkl+sWVykX5g==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Describe the missing power source, bias and direction for each of the USB0
retimer gpio-controlled voltage regulators related pin configuration.

Fixes: 019e1ee32fec ("arm64: dts: qcom: x1e001de-devkit: Enable external DP support")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e001de-devkit.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
index 902335396c586a991c4a2de19906b039d887780f..8e88e00c335a05d0d36b4b08b85df82f38ef4355 100644
--- a/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
+++ b/arch/arm64/boot/dts/qcom/x1e001de-devkit.dts
@@ -1039,6 +1039,10 @@ rtmr0_default: rtmr0-reset-n-active-state {
 	usb0_3p3_reg_en: usb0-3p3-reg-en-state {
 		pins = "gpio11";
 		function = "normal";
+		power-source = <1>; /* 1.8V */
+		bias-disable;
+		input-disable;
+		output-enable;
 	};
 };
 
@@ -1046,6 +1050,10 @@ &pmc8380_5_gpios {
 	usb0_pwr_1p15_en: usb0-pwr-1p15-en-state {
 		pins = "gpio8";
 		function = "normal";
+		power-source = <1>; /* 1.8V */
+		bias-disable;
+		input-disable;
+		output-enable;
 	};
 };
 
@@ -1053,6 +1061,10 @@ &pm8550ve_9_gpios {
 	usb0_1p8_reg_en: usb0-1p8-reg-en-state {
 		pins = "gpio8";
 		function = "normal";
+		power-source = <1>; /* 1.8V */
+		bias-disable;
+		input-disable;
+		output-enable;
 	};
 };
 

-- 
2.34.1


