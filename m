Return-Path: <linux-kernel+bounces-226112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDAE8913A5D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 14:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 466B71F21ABC
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 12:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C0F181305;
	Sun, 23 Jun 2024 12:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nWiJVsR+"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9127B180A7D
	for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 12:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719144434; cv=none; b=aUp4jLizo946VFuAUa2hOxyNDzej0NmNNiI0uLPgIRbPgucf88xOQSg0K67ipnyZ5dnAqEhCHKJhAW0pxfaAtvEItu7o0UU6Qwhs2SMxtMIxWKZxRQQG/usXmfqH5rOPQHjIkPxM9Aee1ntaPkSlkcimBDnax/YzxFyHoTt7cC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719144434; c=relaxed/simple;
	bh=uHYvDYR/0OCKZLGvvzWmpbwWIBr305LjSa6MiZXxS8M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KOzBw8on/oEWSIC4w5+eRWrGXTGDAprH9OdrfYB8XzyajqQBRbWW4UbdsHrXRh/+QiNoJbA9lg0YYow7EMwitUhVHVDnUwCrqsurXeUL9M22Hww+I9/zQjclpqwfK8M4rXh2V175vl25DwuZE0s62+XKt0OQgAz/lWieID3J3+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nWiJVsR+; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a689ad8d1f6so428167866b.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 05:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1719144431; x=1719749231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Im9pps3F9eSCq1woRzWsXbS8wxrxaZe4+MW3D6HBN4=;
        b=nWiJVsR+G0sv2Cqfk5kghvfAhkVc7YEKiGtte+mIKBX7nmDvNWJE8ELrtddf4Bvj27
         lnuwwWhVLBJcDiRuUnPcISQvapoDiYan0e6evYuaC+2iWgWmxGlTLh9EZeWQbOzn78er
         q/Hu8xswUDUoWY0WLY5B7MvBNkr48Sga6eamRjCepS2yXMuL4ajuJV8Gbf4MYqhOD9CJ
         hyhyH6ZUB6djPptBiJXzIZsnjpIDLC2z5zxKkoCFuz2sDUYCvXnMYrDkZ1gmk67mDCdz
         CwKG/ndgl6iN9p87lnHZG7X//5wCE4sjJO5CIcuLyGnh75TgjBcyRQhj/oDMeIVwyXzc
         PhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719144431; x=1719749231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Im9pps3F9eSCq1woRzWsXbS8wxrxaZe4+MW3D6HBN4=;
        b=idhQqVzSUC0FwcFwQqqnVVsFOruNLWl6j9cRnvUyScIKI6rCASySkfzIfVVqDzbYMV
         Mf4VZqf5VQtijJrrhggKPK51Xp2G9KgxOzKpUcwDOYe4I3wrIsMjQPWH4ESWHEufxvPU
         /y8hUnQtAloSTIO6x2xs4PjcuQnR2yv+eEN4IdTLwhGQFdKGjnojbyyFbdSHMLGNqDrt
         debss5vRYXSAfTM4Ty4zRc7Qhcj/7cXN/tItwn/CBmyt99sSrk9U3/EJtMJcxt85Sr1P
         lMMIs/Yr09ojjR7O/MiO1bp0JEIT9j2UAz2bj2ERE+bSF/14fOxjwQmge5xwlj9GdrtB
         bh2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgEsxEe3pcvbly0FtQYGeodFyMweTEIv8fn2OZd5BdQsslAoZpdErJuh+Eg+THX/sz+ouomOIbxxK3nEfK+LghsvrWNRd3C0Cb+YeF
X-Gm-Message-State: AOJu0YxA9NuPckCiHf4eIa4a02oc7VcyUx23+TZf4zLyV4NDjveQmOZ1
	y5whKU665ak6/DYhhD2jlghPdjMymTONaEcbnsUOv6w7U1a1HlWWf8BcijO/ftY=
X-Google-Smtp-Source: AGHT+IFFOnAlnUD5SZlHKO+8g/23aF3khBJGARG75g3tsfD2hW3IYT329v2VSFQKwncszwU9X7alAA==
X-Received: by 2002:a17:906:9c93:b0:a6f:b7a0:3e68 with SMTP id a640c23a62f3a-a7245ccda3dmr140352366b.20.1719144430919;
        Sun, 23 Jun 2024 05:07:10 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6ff4f68248sm162501566b.127.2024.06.23.05.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 05:07:10 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: qcom: use generic node names for Adreno and QFPROM
Date: Sun, 23 Jun 2024 14:07:07 +0200
Message-ID: <20240623120707.45764-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use recommended generic node names for the Adreno GPU and QFPROM fused
values device nodes.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 4 ++--
 arch/arm/boot/dts/qcom/qcom-apq8084.dtsi | 2 +-
 arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi | 2 +-
 arch/arm/boot/dts/qcom/qcom-msm8226.dtsi | 4 ++--
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi | 4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index 178a3b424670..d73ea1434b36 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -666,7 +666,7 @@ ssbi: ssbi@500000 {
 			qcom,controller-type = "pmic-arbiter";
 		};
 
-		qfprom: qfprom@700000 {
+		qfprom: efuse@700000 {
 			compatible = "qcom,apq8064-qfprom", "qcom,qfprom";
 			reg = <0x00700000 0x1000>;
 			#address-cells = <1>;
@@ -992,7 +992,7 @@ tcsr: syscon@1a400000 {
 			reg = <0x1a400000 0x100>;
 		};
 
-		gpu: adreno-3xx@4300000 {
+		gpu: gpu@4300000 {
 			compatible = "qcom,adreno-320.2", "qcom,adreno";
 			reg = <0x04300000 0x20000>;
 			reg-names = "kgsl_3d0_reg_memory";
diff --git a/arch/arm/boot/dts/qcom/qcom-apq8084.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8084.dtsi
index ca53dff820ef..2b52e5d5eb51 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8084.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8084.dtsi
@@ -245,7 +245,7 @@ sram@fc190000 {
 			reg = <0xfc190000 0x10000>;
 		};
 
-		qfprom: qfprom@fc4bc000 {
+		qfprom: efuse@fc4bc000 {
 			compatible = "qcom,apq8084-qfprom", "qcom,qfprom";
 			reg = <0xfc4bc000 0x1000>;
 			#address-cells = <1>;
diff --git a/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
index 4e36fe4bf2a1..0b04ea856f7c 100644
--- a/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-ipq8064.dtsi
@@ -372,7 +372,7 @@ ssbi@500000 {
 			qcom,controller-type = "pmic-arbiter";
 		};
 
-		qfprom: qfprom@700000 {
+		qfprom: efuse@700000 {
 			compatible = "qcom,ipq8064-qfprom", "qcom,qfprom";
 			reg = <0x00700000 0x1000>;
 			#address-cells = <1>;
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
index 270973e85625..b2f92ad6499a 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8226.dtsi
@@ -635,7 +635,7 @@ restart@fc4ab000 {
 			reg = <0xfc4ab000 0x4>;
 		};
 
-		qfprom: qfprom@fc4bc000 {
+		qfprom: efuse@fc4bc000 {
 			compatible = "qcom,msm8226-qfprom", "qcom,qfprom";
 			reg = <0xfc4bc000 0x1000>;
 			#address-cells = <1>;
@@ -1046,7 +1046,7 @@ cci_i2c0: i2c-bus@0 {
 			};
 		};
 
-		gpu: adreno@fdb00000 {
+		gpu: gpu@fdb00000 {
 			compatible = "qcom,adreno-305.18", "qcom,adreno";
 			reg = <0xfdb00000 0x10000>;
 			reg-names = "kgsl_3d0_reg_memory";
diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
index 1bea3cef4ba7..f9820d996910 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
@@ -1235,7 +1235,7 @@ restart@fc4ab000 {
 			reg = <0xfc4ab000 0x4>;
 		};
 
-		qfprom: qfprom@fc4bc000 {
+		qfprom: efuse@fc4bc000 {
 			compatible = "qcom,msm8974-qfprom", "qcom,qfprom";
 			reg = <0xfc4bc000 0x2100>;
 			#address-cells = <1>;
@@ -2131,7 +2131,7 @@ cci_i2c1: i2c-bus@1 {
 			};
 		};
 
-		gpu: adreno@fdb00000 {
+		gpu: gpu@fdb00000 {
 			compatible = "qcom,adreno-330.1", "qcom,adreno";
 			reg = <0xfdb00000 0x10000>;
 			reg-names = "kgsl_3d0_reg_memory";
-- 
2.43.0


