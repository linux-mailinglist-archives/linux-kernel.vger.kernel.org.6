Return-Path: <linux-kernel+bounces-376505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EB69AB280
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 091E11F234A5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 15:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F70F1AD3E2;
	Tue, 22 Oct 2024 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iz5lYm5w"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0D91A0BD0
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 15:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729612077; cv=none; b=oC7v6UMw499jnQ6kgQn+RqOc1S3TDHYEgeK/9TzMk11txBBmTVv/UTEiOB2pNGNyQqzWuNFzOfUv5Ybau8iYOKh1jP9mNPBknZadOOBfv8yDJRQMomVnUHG7rDxUC/NQrqgaHvvsI5OSxN+jalGND/q52KZ2AD6PUEkDakUfLTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729612077; c=relaxed/simple;
	bh=5KnjYWNoQonMUKH4Crw2+ZOH1md/NQUEce78VXKNOZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cdqMRcL9Kkm1eNJcq1oscrA34iqivGLiiIwlWVEGWdV6dvh5L+BTmYnSnttR0s8W2HqrCBzvQjremTF5UdyIJuMrw4g8HjUNQb9Br+IVCW45x3mp6bSKjxcxv4sk8aeGvb+gBvwcJHviQVv+ilC/vqm4l5ksouscCleUPOyoaDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iz5lYm5w; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c8ae7953b2so911671a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 08:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729612073; x=1730216873; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uVeaQsj908vQhSvzq+9+a3G/s1xhhBZjUnZ6mjejRdU=;
        b=iz5lYm5wMH9y3TshqnO6kBimuCXa7SRz1TnVybu3W+eVXDmX8L7BG5Ctf6nSVm9H60
         YsVv8Gu+g74yBdiPmR8YRckVAYzNHZ/wvAp0kPBJN9TSxf2qZJLxjWDxchX+O08kr8BQ
         S16hW3k5N1Yd9EoxwNpn+wlU1z+YqEdemh/Qzeht6IpFHfz8KakPuNAm8/G8bBaFKJwR
         CWPIcpFTKMtX5nUD8MBZuw/vdklmMKLZ5YgA6c+CuESYoxQIjcxBAiRzDTIM3IzEgKw5
         BApm/+rTxP6VN6Kw7Qx4eDOL5Gore+D8Wsjl/9tPpV18arVHMDTmaDbGpnTOX8kcbLtq
         LJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729612073; x=1730216873;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uVeaQsj908vQhSvzq+9+a3G/s1xhhBZjUnZ6mjejRdU=;
        b=vMUQAdDRyUeTO0GOrZn4JGEC10CDW8uIKv0VfEXod7NG5WXj5SGdsIMEE/H+AIv3lc
         imlT4ICizRCE/ixbINlcTPJHE9SzBKS0ed8AbIXX3Yltqc/CbSBhjVv9xWsc1RnXHYt9
         30hXHoOiDLH5Z3zkH5NLWjUSWEUu4I3ScwOGij8y/WVWHg04udhDK3J6TJmhZ3fgaoiC
         tdPIW45rUsB2SefBYa7A195eze0udbvQwJbELSiiEbfpHRFsFYsCL+/BGdOF9fyMbkxd
         6wpDMj18yUonE4q1haAHbGh+ex9KhIDpkSQbF+LrmA0W1OjIKLpJQeWlRSsXHXCRscwL
         uTnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX96e/XAt/H2/t24dIPfhUEmlug/M+MRnv5jzzC45x1isG0S9extdgECFUA2gaZbLQGbPz0e9gC5PRpUHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcRvEPmZhnlx3/hxtxo6mhrIUQ9QKkN7HYz6ObO+3dVZ9zF9r6
	f88bW/qk+cba3aGr0YeBbmZSzTbimhjGUUMBJQkiMCgvCU/HHm8IKqhXPuFL7u8=
X-Google-Smtp-Source: AGHT+IFlCJJwMxnHfakJwVuMZ74qwjFm6fDjhW7FTpLrv+8gU4Q2aRJCS+FnhZ7kFluYvByQKLu6WA==
X-Received: by 2002:a05:6402:42d6:b0:5c3:eb29:53ff with SMTP id 4fb4d7f45d1cf-5ca0ae87565mr4945144a12.7.1729612073000;
        Tue, 22 Oct 2024 08:47:53 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.211.167])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66c725fesm3439959a12.87.2024.10.22.08.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 08:47:52 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Tue, 22 Oct 2024 17:47:26 +0200
Subject: [PATCH v3 01/18] arm64: dts: qcom: ipq: change labels to
 lower-case
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241022-dts-qcom-label-v3-1-0505bc7d2c56@linaro.org>
References: <20241022-dts-qcom-label-v3-0-0505bc7d2c56@linaro.org>
In-Reply-To: <20241022-dts-qcom-label-v3-0-0505bc7d2c56@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=11894;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=5KnjYWNoQonMUKH4Crw2+ZOH1md/NQUEce78VXKNOZY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnF8kUhKasX3yA7UIFSLy2ucDPLGsYAU0S0U1TE
 FPdhBDLTOCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZxfJFAAKCRDBN2bmhouD
 17I0EACXJ420vCKaof13mmlrKJy/B+nd6Z/sPyfS/lDzUIyqiMTCH2Jcb+LMwiqNDDQEltsQ+9c
 r3MFjbrkcVYUmtUoPC65lUqFfimSFmgVgZyRIl6wT3tLwEWmVyTdsdKmq2oicMS8FR5TpAvwyvW
 G1ZXUPt+Uy5ESxwnGcON9nmYj04Zk+qDKmKacLxK1/En91sXxUv9wcDKDBJgS8v0ej7F5rZYlJK
 XjM6quxdSIADCoeokhv3f2FiCisp4Cyge5H0j8yzwRHaK3aKhz3mvANmPkWFHEBXafgRlRg0PXb
 KPJrj7OAARvdMMG+IAPjTRh0moXNBn4nuVO39omoUp4Laqt+vCqP4m7cZZIyaDr4+wWMmY1c04T
 2ECKEFDFIYxY/nBYVoYfA1tXDJ9sUksxbWxOwV9tf+x5wpggrApJHrYsLtsqDvOPlGaouEbO3tK
 WgH55W+Jw8h65/dWlbb0XuElyCU6lZIOLPD2rSFRZNOXuJWyZrvVgEw7jvOQMbyanzpG5lNe7Ea
 0JNuEUdWyQqsRYkdFOMLlP+JbPec/FgD7SBwN+79t0/7Fdgj6pHFfxbO3cfd5jdIKPLNLKieDFE
 PSUUrL+ylINLXKhKOSudyS0/UZl9pmk0d4qOxbaDkcYUwKBaZQS8VqCymzWahtt0lDyOWuRH6Et
 yog65bHjhyNCrRQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

DTS coding style expects labels to be lowercase.  No functional impact.
Verified with comparing decompiled DTB (dtx_diff and fdtdump+diff).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 10 +++----
 arch/arm64/boot/dts/qcom/ipq5332.dtsi | 18 ++++++-------
 arch/arm64/boot/dts/qcom/ipq6018.dtsi | 26 +++++++++---------
 arch/arm64/boot/dts/qcom/ipq8074.dtsi | 18 ++++++-------
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 50 +++++++++++++++++------------------
 5 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 7e6e2c1219793145fdbc6d97cac5c1a646dd77b3..8914f2ef0bc47fda243b19174f77ce73fc10757d 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -31,27 +31,27 @@ cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		CPU0: cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0>;
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			operating-points-v2 = <&cpu_opp_table>;
 		};
 
-		CPU1: cpu@1 {
+		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x1>;
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			operating-points-v2 = <&cpu_opp_table>;
 		};
 
-		L2_0: l2-cache {
+		l2_0: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
 			cache-size = <0x80000>;
diff --git a/arch/arm64/boot/dts/qcom/ipq5332.dtsi b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
index 71328b22353114f21404450fcf54e2767fa50cd9..d3c3e215a15cfc3998f8e30656828a46b6991898 100644
--- a/arch/arm64/boot/dts/qcom/ipq5332.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5332.dtsi
@@ -31,47 +31,47 @@ cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		CPU0: cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0>;
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			operating-points-v2 = <&cpu_opp_table>;
 		};
 
-		CPU1: cpu@1 {
+		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x1>;
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			operating-points-v2 = <&cpu_opp_table>;
 		};
 
-		CPU2: cpu@2 {
+		cpu2: cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x2>;
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			operating-points-v2 = <&cpu_opp_table>;
 		};
 
-		CPU3: cpu@3 {
+		cpu3: cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x3>;
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			operating-points-v2 = <&cpu_opp_table>;
 		};
 
-		L2_0: l2-cache {
+		l2_0: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
 			cache-unified;
diff --git a/arch/arm64/boot/dts/qcom/ipq6018.dtsi b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
index 8edd535a188f2ddc8af2f564f514c8be4a8d7a43..dbf6716bcb59a04939c2b994d85cf58c12365962 100644
--- a/arch/arm64/boot/dts/qcom/ipq6018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq6018.dtsi
@@ -34,12 +34,12 @@ cpus: cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		CPU0: cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0>;
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu_opp_table>;
@@ -47,12 +47,12 @@ CPU0: cpu@0 {
 			#cooling-cells = <2>;
 		};
 
-		CPU1: cpu@1 {
+		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			enable-method = "psci";
 			reg = <0x1>;
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu_opp_table>;
@@ -60,12 +60,12 @@ CPU1: cpu@1 {
 			#cooling-cells = <2>;
 		};
 
-		CPU2: cpu@2 {
+		cpu2: cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			enable-method = "psci";
 			reg = <0x2>;
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu_opp_table>;
@@ -73,12 +73,12 @@ CPU2: cpu@2 {
 			#cooling-cells = <2>;
 		};
 
-		CPU3: cpu@3 {
+		cpu3: cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			enable-method = "psci";
 			reg = <0x3>;
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu_opp_table>;
@@ -86,7 +86,7 @@ CPU3: cpu@3 {
 			#cooling-cells = <2>;
 		};
 
-		L2_0: l2-cache {
+		l2_0: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
 			cache-unified;
@@ -1015,10 +1015,10 @@ cpu_alert: cpu-passive {
 			cooling-maps {
 				map0 {
 					trip = <&cpu_alert>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
index 284a4553070faa94960d12e6b08fadf8cd2c6b06..78e1992b749573ea899e4d639eedf437cab19d59 100644
--- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
@@ -32,39 +32,39 @@ cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		CPU0: cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			reg = <0x0>;
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			enable-method = "psci";
 		};
 
-		CPU1: cpu@1 {
+		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			enable-method = "psci";
 			reg = <0x1>;
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 		};
 
-		CPU2: cpu@2 {
+		cpu2: cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			enable-method = "psci";
 			reg = <0x2>;
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 		};
 
-		CPU3: cpu@3 {
+		cpu3: cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
 			enable-method = "psci";
 			reg = <0x3>;
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 		};
 
-		L2_0: l2-cache {
+		l2_0: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
 			cache-unified;
diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 14c7b3a78442c85c3b5dab24498aa1740facc22b..d1fd35ebc4a28bafee77e7be441709f99f482558 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -34,12 +34,12 @@ cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		CPU0: cpu@0 {
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a73";
 			reg = <0x0>;
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu_opp_table>;
@@ -47,12 +47,12 @@ CPU0: cpu@0 {
 			#cooling-cells = <2>;
 		};
 
-		CPU1: cpu@1 {
+		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a73";
 			reg = <0x1>;
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu_opp_table>;
@@ -60,12 +60,12 @@ CPU1: cpu@1 {
 			#cooling-cells = <2>;
 		};
 
-		CPU2: cpu@2 {
+		cpu2: cpu@2 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a73";
 			reg = <0x2>;
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu_opp_table>;
@@ -73,12 +73,12 @@ CPU2: cpu@2 {
 			#cooling-cells = <2>;
 		};
 
-		CPU3: cpu@3 {
+		cpu3: cpu@3 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a73";
 			reg = <0x3>;
 			enable-method = "psci";
-			next-level-cache = <&L2_0>;
+			next-level-cache = <&l2_0>;
 			clocks = <&apcs_glb APCS_ALIAS0_CORE_CLK>;
 			clock-names = "cpu";
 			operating-points-v2 = <&cpu_opp_table>;
@@ -86,7 +86,7 @@ CPU3: cpu@3 {
 			#cooling-cells = <2>;
 		};
 
-		L2_0: l2-cache {
+		l2_0: l2-cache {
 			compatible = "cache";
 			cache-level = <2>;
 			cache-unified;
@@ -863,10 +863,10 @@ cpu0_alert: cpu-passive {
 			cooling-maps {
 				map0 {
 					trip = <&cpu0_alert>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
@@ -891,10 +891,10 @@ cpu1_alert: cpu-passive {
 			cooling-maps {
 				map0 {
 					trip = <&cpu1_alert>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
@@ -919,10 +919,10 @@ cpu2_alert: cpu-passive {
 			cooling-maps {
 				map0 {
 					trip = <&cpu2_alert>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};
@@ -947,10 +947,10 @@ cpu3_alert: cpu-passive {
 			cooling-maps {
 				map0 {
 					trip = <&cpu3_alert>;
-					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
-							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
 				};
 			};
 		};

-- 
2.43.0


