Return-Path: <linux-kernel+bounces-521196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1E6A3B7C1
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D4C2176D6B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA801E1A23;
	Wed, 19 Feb 2025 09:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bsj6W421"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98451C4A06
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739956081; cv=none; b=XObUyMiTrXrhycOWACMPnB+BEMTLpBXHQYDti1/dp7vDInXlvC67UU0QLRejJxWHplNLxr/NZnOLEgY4zlio3P4e7c4cKBY+BZkns16MvQBlWesDUvE8lkeCU8VfGjqDc2RV96Jk+jVV74guoT+l1vmewwYiTwkR7VWdInLcmG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739956081; c=relaxed/simple;
	bh=eVMT887Zl9nmg8Aj/EZhckpL2rRL2zR2XvxzGjBNVrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bifAyvENEup5FL454oZbXkL3pEM0XSqqnExsLwIrbjoLeyIvHSZnc9cBP0gmVEvdWLCFAvAExyzRTdZbpl+W8og7fP5z/bHxuN5ZBqTO43QNlq6l+zflVzdnVR7pcrYh3N9i743m/vPJkA+wdUmN1oSVCkMJXEge+A9n8xQfR10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bsj6W421; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab7ee6f5535so85602466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 01:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739956077; x=1740560877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7e/kyLMpdbaW4hoGX8KhqKMu7hDSW4KWzFrVgpwh0Io=;
        b=bsj6W421XreFzYk8gxKY9WyZKDypaz3X3O0KErl2iIG/MnfvdxDl/gwjsKff5hN8U0
         KuhcJwSs7KrbRVEOSQLIzul2wbVhstDV9n0bYT4lgEKa1T8BMj40/t44X/KPmXUsd78f
         /Cclj2lW79OZJleK5Jzkk1D72rCEbodl1MsowQPB8NvAQZ3NNCjEAYDEoXzR3YX/HnR4
         T5/d9zEf8BWVoX5ym3SDdKPsFcIDktowNb5dS6V2OMJYEN2nWVkRVNbIf5FwNMz69nte
         PSVGHDqW6IlZwtQch0y7WrGUygUlZ0PfsTxkvYfV91PwuTsut+9SBk09DqyaPExlL/Z5
         dMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739956077; x=1740560877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7e/kyLMpdbaW4hoGX8KhqKMu7hDSW4KWzFrVgpwh0Io=;
        b=gnJEtLRo+JMTEEFjcUSWOZt/70QElIhXNXMBRYA/qs6Vrt7yD7hKGT7ex7q+zK7nCe
         Gt0VMlqFcjgQb9qMyM0SuDH7bmnKkpGfr+Vg6/25vHDRuY24QOwVwAxFMKNvSqsqKFiF
         +q5GrqGQhVLQW5hbpZrxM7A/3FV+lfPouPP7lMw861VhHWC9acNFqOKFh4m2hcARzGHs
         XZUjKpUlSRmjDkhgYGjiMyD7P+38ugX92Vwrmek2jDewqF7bRnSkpMyrXqfNrEfiq3gf
         V6EvS/HgmOmqvdvaPckDh/PavPCuLUNfu3TOg8t4wnzi7pyhOtgfUO/uHC3MwKG+7u5E
         vFkg==
X-Forwarded-Encrypted: i=1; AJvYcCWx2RBs5Gp7Lc9cDffGgpd1laaKFkCCkV9T8JTZPQMHplv2mqlGobTqNUjs7CX9NxCxx5pQxosPgxTzbqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTUluvw3wGaIYI7frBPHIZSDQBGWAb4I2ZKBMZ7Z0R/D4b0MJ+
	Sy3yv9oF1WgGtJsb2gPH12RJ1NPKPIGYpraRZaO1Ss5J9p5kvCzVzRwEoYVl57U=
X-Gm-Gg: ASbGncswdTj0SjXTup8YkpXF4oGfWrjxne3AZjDY4/3uTC8WdIlYeHtAtD2s0MyBNEW
	C0z9qHyj1SrGJKLDmMQblshSV2t9QFQR+qtHC9VzK5/TICmwczdEu7a9B6YiJw16/DKJjbKY1KV
	h+vYuOPkHcMCBh5A9VAIBhzGjn05BqEYEpXlA+wF2O2W0QwzYk1iKiGLgxeXj2VHbBDUgc91Op9
	qUQ8B4iC9nUWp4HQ9YHmWPB0jtkFg/tjMDoNgbJpI9jvTZ2p1Gtb7xKV7YBIgGt+FBfV5AA4l58
	J0kUMxLCrUPg0N8neSBgnDpUntPK9A==
X-Google-Smtp-Source: AGHT+IFGjkpX3+TLejfc88gfo31XjrHN5z9eYLiDkjiUP6WJ9W8wR2ONeZILHGObL6JLboIUqAXhYg==
X-Received: by 2002:a17:907:d8b:b0:ab7:b545:b2eb with SMTP id a640c23a62f3a-abb70932f6cmr690990666b.2.1739956077105;
        Wed, 19 Feb 2025 01:07:57 -0800 (PST)
Received: from krzk-bin.. ([178.197.206.225])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbac3242dcsm407695666b.107.2025.02.19.01.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 01:07:56 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: qcom: Corret white-space style
Date: Wed, 19 Feb 2025 10:07:51 +0100
Message-ID: <20250219090751.124267-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250219090751.124267-1-krzysztof.kozlowski@linaro.org>
References: <20250219090751.124267-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There should be exactly one space before and after '=', and one space
before '{'.  No functional impact.  Verified with comparing decompiled
DTB (dtx_diff and fdtdump+diff).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi         | 40 +++++++++----------
 .../boot/dts/qcom/msm8917-xiaomi-riva.dts     |  2 +-
 arch/arm64/boot/dts/qcom/msm8917.dtsi         |  2 +-
 arch/arm64/boot/dts/qcom/qcs615.dtsi          | 16 ++++----
 arch/arm64/boot/dts/qcom/sm8750.dtsi          |  2 +-
 5 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 942290028972..cac58352182e 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -876,11 +876,11 @@ frame@b128000 {
 
 		pcie1: pcie@10000000 {
 			compatible = "qcom,pcie-ipq9574";
-			reg =  <0x10000000 0xf1d>,
-			       <0x10000f20 0xa8>,
-			       <0x10001000 0x1000>,
-			       <0x000f8000 0x4000>,
-			       <0x10100000 0x1000>;
+			reg = <0x10000000 0xf1d>,
+			      <0x10000f20 0xa8>,
+			      <0x10001000 0x1000>,
+			      <0x000f8000 0x4000>,
+			      <0x10100000 0x1000>;
 			reg-names = "dbi", "elbi", "atu", "parf", "config";
 			device_type = "pci";
 			linux,pci-domain = <1>;
@@ -956,11 +956,11 @@ pcie1: pcie@10000000 {
 
 		pcie3: pcie@18000000 {
 			compatible = "qcom,pcie-ipq9574";
-			reg =  <0x18000000 0xf1d>,
-			       <0x18000f20 0xa8>,
-			       <0x18001000 0x1000>,
-			       <0x000f0000 0x4000>,
-			       <0x18100000 0x1000>;
+			reg = <0x18000000 0xf1d>,
+			      <0x18000f20 0xa8>,
+			      <0x18001000 0x1000>,
+			      <0x000f0000 0x4000>,
+			      <0x18100000 0x1000>;
 			reg-names = "dbi", "elbi", "atu", "parf", "config";
 			device_type = "pci";
 			linux,pci-domain = <3>;
@@ -1036,11 +1036,11 @@ pcie3: pcie@18000000 {
 
 		pcie2: pcie@20000000 {
 			compatible = "qcom,pcie-ipq9574";
-			reg =  <0x20000000 0xf1d>,
-			       <0x20000f20 0xa8>,
-			       <0x20001000 0x1000>,
-			       <0x00088000 0x4000>,
-			       <0x20100000 0x1000>;
+			reg = <0x20000000 0xf1d>,
+			      <0x20000f20 0xa8>,
+			      <0x20001000 0x1000>,
+			      <0x00088000 0x4000>,
+			      <0x20100000 0x1000>;
 			reg-names = "dbi", "elbi", "atu", "parf", "config";
 			device_type = "pci";
 			linux,pci-domain = <2>;
@@ -1116,11 +1116,11 @@ pcie2: pcie@20000000 {
 
 		pcie0: pci@28000000 {
 			compatible = "qcom,pcie-ipq9574";
-			reg =  <0x28000000 0xf1d>,
-			       <0x28000f20 0xa8>,
-			       <0x28001000 0x1000>,
-			       <0x00080000 0x4000>,
-			       <0x28100000 0x1000>;
+			reg = <0x28000000 0xf1d>,
+			      <0x28000f20 0xa8>,
+			      <0x28001000 0x1000>,
+			      <0x00080000 0x4000>,
+			      <0x28100000 0x1000>;
 			reg-names = "dbi", "elbi", "atu", "parf", "config";
 			device_type = "pci";
 			linux,pci-domain = <0>;
diff --git a/arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts b/arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts
index f1d22535fedd..df135f9891a8 100644
--- a/arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts
+++ b/arch/arm64/boot/dts/qcom/msm8917-xiaomi-riva.dts
@@ -119,7 +119,7 @@ bq27426@55 {
 		monitored-battery = <&battery>;
 	};
 
-	bq25601@6b{
+	bq25601@6b {
 		compatible = "ti,bq25601";
 		reg = <0x6b>;
 		interrupts-extended = <&tlmm 61 IRQ_TYPE_EDGE_FALLING>;
diff --git a/arch/arm64/boot/dts/qcom/msm8917.dtsi b/arch/arm64/boot/dts/qcom/msm8917.dtsi
index 7bf58dd0146e..9d8358745c91 100644
--- a/arch/arm64/boot/dts/qcom/msm8917.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8917.dtsi
@@ -587,7 +587,7 @@ tsens_s4_p2: s4-p2@217 {
 				bits = <1 6>;
 			};
 
-			tsens_s9_p1: s9-p1@230{
+			tsens_s9_p1: s9-p1@230 {
 				reg = <0x230 1>;
 				bits = <0 6>;
 			};
diff --git a/arch/arm64/boot/dts/qcom/qcs615.dtsi b/arch/arm64/boot/dts/qcom/qcs615.dtsi
index f4abfad474ea..6c17860dd6c8 100644
--- a/arch/arm64/boot/dts/qcom/qcs615.dtsi
+++ b/arch/arm64/boot/dts/qcom/qcs615.dtsi
@@ -1819,7 +1819,7 @@ replicator@6046000 {
 			in-ports {
 				port {
 					replicator0_in: endpoint {
-						remote-endpoint= <&tmc_etf_out>;
+						remote-endpoint = <&tmc_etf_out>;
 					};
 				};
 			};
@@ -1832,7 +1832,7 @@ port@1 {
 					reg = <1>;
 
 					replicator0_out1: endpoint {
-						remote-endpoint= <&replicator1_in>;
+						remote-endpoint = <&replicator1_in>;
 					};
 				};
 			};
@@ -1872,7 +1872,7 @@ replicator@604a000 {
 			in-ports {
 				port {
 					replicator1_in: endpoint {
-						remote-endpoint= <&replicator0_out1>;
+						remote-endpoint = <&replicator0_out1>;
 					};
 				};
 			};
@@ -1880,7 +1880,7 @@ replicator1_in: endpoint {
 			out-ports {
 				port {
 					replicator1_out: endpoint {
-						remote-endpoint= <&funnel_swao_in6>;
+						remote-endpoint = <&funnel_swao_in6>;
 					};
 				};
 			};
@@ -2311,7 +2311,7 @@ port@6 {
 					reg = <6>;
 
 					funnel_swao_in6: endpoint {
-						remote-endpoint= <&replicator1_out>;
+						remote-endpoint = <&replicator1_out>;
 					};
 				};
 
@@ -2319,7 +2319,7 @@ port@7 {
 					reg = <7>;
 
 					funnel_swao_in7: endpoint {
-						remote-endpoint= <&tpda_swao_out>;
+						remote-endpoint = <&tpda_swao_out>;
 					};
 				};
 			};
@@ -2343,7 +2343,7 @@ tmc@6b09000 {
 			in-ports {
 				port {
 					tmc_etf_swao_in: endpoint {
-						remote-endpoint= <&funnel_swao_out>;
+						remote-endpoint = <&funnel_swao_out>;
 					};
 				};
 			};
@@ -2351,7 +2351,7 @@ tmc_etf_swao_in: endpoint {
 			out-ports {
 				port {
 					tmc_etf_swao_out: endpoint {
-						remote-endpoint= <&replicator_swao_in>;
+						remote-endpoint = <&replicator_swao_in>;
 					};
 				};
 			};
diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index abb92c81c76b..f81a3c3ae334 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -990,7 +990,7 @@ uart14: serial@898000 {
 				clocks = <&gcc GCC_QUPV3_WRAP2_S5_CLK>;
 				clock-names = "se";
 
-				interconnects =	<&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
+				interconnects = <&clk_virt MASTER_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS
 						 &clk_virt SLAVE_QUP_CORE_2 QCOM_ICC_TAG_ALWAYS>,
 						<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ALWAYS
 						 &config_noc SLAVE_QUP_2 QCOM_ICC_TAG_ALWAYS>;
-- 
2.43.0


