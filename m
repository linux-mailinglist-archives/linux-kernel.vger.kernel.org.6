Return-Path: <linux-kernel+bounces-524120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B19A3DF67
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EA003BFDC3
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D982020DD6E;
	Thu, 20 Feb 2025 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0ePWNLU"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C0B20C038;
	Thu, 20 Feb 2025 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066714; cv=none; b=L5lx8s/epsF0UjJdxP/Izd9ZOauRNmHXbHyIEFXkVeOnrizGY94Zh+WllWm2Mu4yfkSV6pDeGjlDHEQY41qSZYJE7E0WSPoEh6P5+ZIJg1j+MupfVbiAh6GrDs7aQ9bE/XAXKySAOYJezC+YKEBAOkgTOOx4WgB78xTsYPQcHUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066714; c=relaxed/simple;
	bh=3G32KGPWtAlTMVeEh2nFd9QMJAqTbBI6LKbnc/7mszk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hXdaPBuADETo2r+fth1jddUAcZjd+1+igVP91Iq3wEpUNzykru6w70Y0DIMrIfzn503Z8jm/axUy06/YrAQvtpVvyyzI0NCyaX7gscGwIJ0CI0RgkI7z4x9PYO/ZA0AWEUULZ3gcnhm0mEctG1EXECUClBhgir/q1U1okHpswqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0ePWNLU; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220ecbdb4c2so28795885ad.3;
        Thu, 20 Feb 2025 07:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740066712; x=1740671512; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=unB38tK/OXEn7+tTxdPa8sEeBESGQmaxRAo5u3OkTcU=;
        b=l0ePWNLU4vz0+vgOySMTi19JkYN1GA4jgvSEVCoFg7GZi/aoMqQ9M8PautlB8e9tpd
         ZdN3+0qbt8/DetaOwt2eIkVmfZIgdFMUssfjV9rZFcS9d4E1FlJmABP7oMmIqd2zlL5U
         MIMMQtZB84Bd0k1U2p5p31XkG0HNIbx8uLLlNsUwLAVjq2dMs2FRx4I5ZPKtaCpIRsjr
         X3FSipGARgnLPML5qxTm9L1bk0FjZoBt3siB7GeIWZmmfR9c8KLeuoTwzeT1el+nTudk
         0ioIAlVGA+FLHrrmT1XLwvfSYZT+n8mtRUQ7BGOKW4k21Jx/MaHAd6s5jLeKeIfDpnt/
         yj4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740066712; x=1740671512;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=unB38tK/OXEn7+tTxdPa8sEeBESGQmaxRAo5u3OkTcU=;
        b=rMKzETvq+mAP7GyLekAs6mgRXg2Jl8VNeH9Ds4Z9DXmARKVj2jtfWbYDIPYLW2yQp6
         m9UBQimXtQkJnbwLfQPTQIv11nKb8OmtjnsfF7KYofFnf1l4+ZyZdRdsdPX/sCidPvzY
         NaxHLrMltVTei1G17+eVRtjWJS2gAsC8chH4000mzwQzY45qxKVKQTazzMRmOjxYIz5K
         WFaOGVAjRVKW5R+Y3M9dOrcY7RKWTp0pKD62Xafy5z9LbvAijvIVRelQ3RP2N44taKL2
         csBKC2ti9K/pmrYUAl9CutnLhmZAVXrbdq6XlsBflUVoBGNPMySuFjuib2NZ+tLjUDzq
         hysQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMCRBGi7a+vaUSv9BnjTnKwd6BvKh8++UHxGWTs0uhqsguu3kveNVg7Y3gNCK913LF5MJxt1Xo1Pre@vger.kernel.org, AJvYcCWyDbf8AdYyXPbRuzV8bFPOTckXTDvGK/wR+R8FaVwFMYkoDwDVriVEdRlbmXFxEtL4c3KSYFvQZlMAMqGI@vger.kernel.org
X-Gm-Message-State: AOJu0Yztot6RLEKwAO7sWfRg3g+t16Cz6v/7HuilGjr/sGua15PrHC6i
	WHlX7xcEH75RLZ2FdhRaFaPXAJkOixaAyXHDK+HjoTZOFTqtLa6E
X-Gm-Gg: ASbGncui106HKmiN12V4JyI6E9aNePzuxekP2Kd8Z4mOWx+OgboHLRJkLM0g+tiCvk8
	6h49chjuOsEWBGg7GiDNNNEs0VDOtkJhfFdkBy1e3gTIZnUh2duwT2dXYhM6lIskdSuDMYKg/px
	UbXxylKg9APo40wQTaWRkCBC4viLRyDf6FKkt8TaFW60BXKPuZy28fC7LIROv6R76KH43Im5Xa4
	HqbgvxjjhBNlONYOSEjwgjMD1jNQO3nALHZn0uJFjHR/l2cMH7VDPz4tyMIshqus4J+NbuxeZpl
	RgH4hFo3QlmwWIhnnw==
X-Google-Smtp-Source: AGHT+IE8dFjT2Oon5YwErpoMrJGlxB95W6CjlQaMdMYIGfz791B9Eo46Mhq7uycbNpThPO6azcAR2Q==
X-Received: by 2002:a17:902:dac5:b0:21f:507b:9ada with SMTP id d9443c01a7336-2210405cc66mr363009275ad.31.1740066711834;
        Thu, 20 Feb 2025 07:51:51 -0800 (PST)
Received: from [127.0.1.1] ([59.188.211.160])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-220d5349019sm123694345ad.36.2025.02.20.07.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:51:51 -0800 (PST)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 20 Feb 2025 23:51:05 +0800
Subject: [PATCH 3/5] arm64: dts: apple: s800-0-3: Add backlight nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-dwi-dt-v1-3-d742431c7373@gmail.com>
References: <20250220-dwi-dt-v1-0-d742431c7373@gmail.com>
In-Reply-To: <20250220-dwi-dt-v1-0-d742431c7373@gmail.com>
To: Janne Grunau <j@jannau.net>, Sven Peter <sven@svenpeter.dev>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1515; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=3G32KGPWtAlTMVeEh2nFd9QMJAqTbBI6LKbnc/7mszk=;
 b=owEBbQKS/ZANAwAIAQHKCLemxQgkAcsmYgBnt0+MWpFjd2LtOQnV2+6ipFIwn+Yq7wK3q4mHQ
 R1LMKFNUimJAjMEAAEIAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCZ7dPjAAKCRABygi3psUI
 JOwlD/4+8SZyMCcMdoRA2KEvrrknMp5BdQaSl2xwUDTU+HVS+8Hns8oLhlQOjUvl4gyBvOSdfWB
 qVTyQNueZqUv/HzqwrGwIPBX3ZoZnLrfThWw+10dvcpOMo/IY6WUKJ6hHBk3s/I9PUw3ocwtk1a
 HPNNY15H3Ehbyo6MkofcTpZoF91EBuKlAamaf3xWvjbF1R78FlEoKtUk2PCrCQg9l2dcqRK7tkM
 9o+jPSajtTBnz8qTVkLRcVL4yokZiUo7+gE7ND8VISWjTm2J6BtJt4zmXpYmuks2LvF00HK7suB
 J+V4UVLQ2ahH45c6PJIRNyigGZ2FOZYlHXr7zyUBaSCGzxjTM/d/bHmfR9qj5UucOtH/6JnwkiQ
 9vxh1CSlhmZo8Rq8wuBamag1y79d2pQzEYVTouVVHFKNIg9hBccqariCHNw4l1PD070KqUpTe7V
 UWh6WU2MxLD7/iykt0jAMDVp3lXqwt9MymDzaIQaGDadO3E8HRfuhtBgSd0H5OU6yPHz8w9bxG/
 dWERsWXLVlkag1wMW4rC+gawidOeMd5j7HKbj9x4XeRZQWNjozaWF46IrS2Ui2yx3bhS2hTMrBb
 tO5jlnzHlBsiyZjCMUxX/3roFuN21IpFHLQasbkySU1mPoWv0BdtcWpflPl0i4zt9HqJRJI343j
 A6kuPPm7s12/DRQ==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add DWI backlight controller nodes for Apple A9 SoC, and enable it for:

- iPhone 6
- iPhone 6s
- iPhone SE
- iPad 5

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/s800-0-3-common.dtsi | 4 ++++
 arch/arm64/boot/dts/apple/s800-0-3.dtsi        | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/s800-0-3-common.dtsi b/arch/arm64/boot/dts/apple/s800-0-3-common.dtsi
index 4276bd890e81b16f19b04e1716a55f32f9a371d9..cb42c5f2c1b6caed4ae04ca0b6173e23bbda47f0 100644
--- a/arch/arm64/boot/dts/apple/s800-0-3-common.dtsi
+++ b/arch/arm64/boot/dts/apple/s800-0-3-common.dtsi
@@ -43,6 +43,10 @@ reserved-memory {
 	};
 };
 
+&dwi_bl {
+	status = "okay";
+};
+
 &serial0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/apple/s800-0-3.dtsi b/arch/arm64/boot/dts/apple/s800-0-3.dtsi
index 2aec49f0da6467519aeb2561d00b14f46fe216fb..c0e9ae45627c8150bc0ddcdc1e6ab65d52fa7219 100644
--- a/arch/arm64/boot/dts/apple/s800-0-3.dtsi
+++ b/arch/arm64/boot/dts/apple/s800-0-3.dtsi
@@ -91,6 +91,13 @@ aic: interrupt-controller@20e100000 {
 			power-domains = <&ps_aic>;
 		};
 
+		dwi_bl: backlight@20e200080 {
+			compatible = "apple,s8000-dwi-bl", "apple,dwi-bl";
+			reg = <0x2 0x0e200080 0x0 0x8>;
+			power-domains = <&ps_dwi>;
+			status = "disabled";
+		};
+
 		pinctrl_ap: pinctrl@20f100000 {
 			compatible = "apple,s8000-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x0f100000 0x0 0x100000>;

-- 
2.48.1


