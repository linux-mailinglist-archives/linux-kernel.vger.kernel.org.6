Return-Path: <linux-kernel+bounces-530992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B68A43AC3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA7A3A1643
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB7B26982C;
	Tue, 25 Feb 2025 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lCUJpQd+"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C3F267F69
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477578; cv=none; b=k/neLb7IuyxkjJnTwTiVlsFNti300gOjxtFvnm0JJKbLQMQtAkJFsjIBdSWuOda2ux2rH/T2G+vDyeJ32tmi2VGZphdbBkr28FUdSbB1grGzr4qeZMlzi7tV8hraUeAfXoS7OItKqiA69ssvNYZm5pDMl0qf7wiIChXaU6jSjw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477578; c=relaxed/simple;
	bh=Use6RFmohFAguMjNfvsYL1WWbJ7F/XbJAq8uZ/6xVQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iZ0J0AaF1mgZRNmaUV4FI21yo8FeAw/+dP/TsFk6CmtguuDOwrAQS7JNomLXo1u2w+TnqeYHc58KbzdLEofGJSLoclKhzp1syB4U5/yqk56GBVL/06Jo4hNM/xeCu54AkyTOBQ8Qd3ivlfM/kTURopzi0Lo8yG5PAE5dDkrrP1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lCUJpQd+; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5de8e26f69fso977337a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740477575; x=1741082375; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=siFt1Rf17aQe9sXvLDxB1vAZBkxV9WrzrueF+H/8o14=;
        b=lCUJpQd+8Rc++h74e3+7/rGQbJMzkMila/ffQ+6dK03VjSxZmBBt8Pe4LOO8lhUVxo
         lJLYdjsUm5JStlqDFnTVf7tu+iMLFZlBu3nHYGMvxK/6c3h7mQYaVf9g36KBrw+rjM49
         76RuFrmcIQbIjc5Xc1myVa9aJFq9yLkV3npDjtn7FJdP0xB4LOHUa0t4ydUnsmxQRfPP
         CUwolrZi1pdTSwSOekFwQ1N7Ci+Xt5u49v35xWuJelDTUpFrsPALv6qHYOFQuLxGJgNp
         mYc7oKT5xmwGinvfRS8FBceGMW1ENfg+QA5MioVQegL8Jyny3AKyfWLVQuejLdMR5aNf
         hb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477575; x=1741082375;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=siFt1Rf17aQe9sXvLDxB1vAZBkxV9WrzrueF+H/8o14=;
        b=I9l2pFXCmkEsKukOUL4pnvuEGtCvZyCtQ4kCh3DGrKKN2ESzipL/NvBVHa6sp2R1kt
         lSGL98ZQAbD8gT/Hfy8+vT0S/21xoVv/QgB++08E40FWkpDIF7O1Xip88XFFAB/ShSt0
         iwCxqtnM6uHZfRNTM348UcnY/cnwTK+poUj9NKBtFOJ9XHBS2VsUZusni4suezMYfw8A
         BVxFtElea6ApEXO7z37efJgmdR1xfP1up1++2WjifzmLmWBYtjCXAy7j//P76UJbX9/P
         InnmM7cKi+zi9xqB+bAVCHxQNwUA3DURNro17R5Kw3ieXobGGVc4FbWfu7hPw6L9foO/
         zhEA==
X-Forwarded-Encrypted: i=1; AJvYcCVY45wpSmCvD65PR365TMkcnoGAlxNntzX+d9PiuSK02/eZIC2Bho2xOcgfk8cZakx8YVaZC4c4sYGcTjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+oyKeC3IaQVhEqIaeoDAqH5c3iJKJlvq+mM34yuGE+lV+TCZv
	1pLx0D3x7fktr1r7+ZBBcKdz7Y7o1EUZXeOoSS/lbxQCt8NMczbLXJByVVMTZtI=
X-Gm-Gg: ASbGncuYxBjk9jA1gF4wngZlljP8FtuAkL2qX6owjHBQgVRIXly8mh+auIz/dTYSUPO
	Lf92stIiutAIL+oxkUE3Yd8uFeLPOWhYBZFpWuF4wy9JuLTtlHk6O8mpqgkyaPaF7PB0UkVerdw
	odk/szTczaVyVUI5BnsJuyR3No+3a33d18jj2z2sN+nLppDAJ3tN8cRCUJiXnsV+WTsMI4I6piM
	QAzDL6iEuPp/IcIoyfekj/D2aVjPq8mmzAM4a3msV54Tm/RUMl3x87OnrgyzZgsOCQvwN0Bt+ia
	BkfT79fRG2EDCoDiCdN5Dhi6Fm+LNwVrs5KzfzA3vkIw2rKHvCvVCpS99GBtowwIUXQnyJO92Gt
	M
X-Google-Smtp-Source: AGHT+IGdddJo4VWIt10W+E1/Iko/ufJtGmlgoul8czpa/Vlv8haaYwr1ZNjdAQ2cqyGnrM6ezz1kfg==
X-Received: by 2002:a17:907:9713:b0:ab7:f92c:8ff9 with SMTP id a640c23a62f3a-abc099c6f28mr692893866b.1.1740477575144;
        Tue, 25 Feb 2025 01:59:35 -0800 (PST)
Received: from [127.0.1.1] (78-11-220-99.static.ip.netia.com.pl. [78.11.220.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed1d59391sm115164266b.56.2025.02.25.01.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:59:34 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 25 Feb 2025 10:59:10 +0100
Subject: [PATCH RFC 13/13] arm64: dts: qcom: sm8250-elish: Switch to
 undeprecated qcom,calibration-variant
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-dts-qcom-wifi-calibration-v1-13-347e9c72dcfc@linaro.org>
References: <20250225-dts-qcom-wifi-calibration-v1-0-347e9c72dcfc@linaro.org>
In-Reply-To: <20250225-dts-qcom-wifi-calibration-v1-0-347e9c72dcfc@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1058;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Use6RFmohFAguMjNfvsYL1WWbJ7F/XbJAq8uZ/6xVQo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnvZRyuy+D3bj6OZpYHkSLie0ePoetBPTy6Ux9l
 GqWNF8L40+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ72UcgAKCRDBN2bmhouD
 1/+tD/9BcMELPcgX2zPVkDQdO/0GN6aEnExlZ6WasD8JLbcInJ7foopkeZ0P/94kSDtuhOIdApm
 ZqJIv7atb4jLdn+oaJoZDUGLqf7CWrH/k1HMlRY2wxd+08Q5DzrHeQoYfvrw5yU1ga2wChrokxm
 Q6jajeSgFIpYsD8/5ZEA8i/95i35kgWeioiXTYvhnEkQlgirCYLvRSEV6PyiFqzAgCHZFsVFOg9
 JyVGCcNwbPtl0mqbJ8ChrVEG+C2LXc10THI3tlI2sb4CBdG2GNuP99Ysa+4Ug15UhHSHCFe9mkB
 sxnQOkpGSwVL+inYJu3evQRr0ooWP1IWoHE59W+N6FzUSUA/Xe6eHuBfQR2b2XY6mZnjUcRwxBX
 G6qeQK4g4VDOiVvjBgj/bYyZt8EOfhw1fg7Gm3zhDKfALujNGhdcYPS1abT9ur708w4s8uIab+2
 ST5Syo05bvq5tUYMgK+AsLDhr07oCDWPCSkB96WejBlkdbDaQOcHpHWKM7LoIPhGcYgvPYiiZo8
 PJaZMfpFrkfJZKTuIfw8F1pW7AdlYYkomtVvBjVLBNRdE6r2UsAUP/Rt5C4o/yjJ3gOdOSfXu50
 /O+qlEaSNKL9XqLr4l06vvgWoazc4aVEc5SV160V5XadoScHQ9oP7X6ObeEzto5/e48/Ulzk764
 bHng3NjrAKB1jqA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The property qcom,ath11k-calibration-variant was deprecated in favor of
recently introduced generic qcom,calibration-variant, common to all
Qualcomm Atheros WiFi bindings.

Change will affect out of tree users, like other projects, of this DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
index 813b009b7bd6818b92b243f0982d2c7ef903d421..01a321d801af3389258abd54e60c39272c59fb7e 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-xiaomi-elish-common.dtsi
@@ -699,7 +699,7 @@ wifi@0 {
 		vddpcie0p9-supply = <&vreg_pmu_pcie_0p9>;
 		vddpcie1p8-supply = <&vreg_pmu_pcie_1p8>;
 
-		qcom,ath11k-calibration-variant = "Xiaomi_Pad_5Pro";
+		qcom,calibration-variant = "Xiaomi_Pad_5Pro";
 	};
 };
 

-- 
2.43.0


