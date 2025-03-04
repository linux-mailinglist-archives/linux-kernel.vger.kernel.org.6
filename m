Return-Path: <linux-kernel+bounces-544212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CA5A4DEDE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 14:11:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8024B7AB143
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 13:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E69205AD7;
	Tue,  4 Mar 2025 13:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cgSO9gDL"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E257204F7D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 13:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741093642; cv=none; b=YTk8Hd9OC2FFVHdLdbi61gKQ4VWEA8/qJWvGZM02juv99PELm9yv8h8l+QWokuyfFEmrSO0mTo9XxVswl1CKhExizZA2JeJAcdL2CxrU+YtNUHaahxFxTzxhA39PZ8/6BFJgdW0TdSjdo0WZzyUazVZW03pcfzdELsQvur2TakQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741093642; c=relaxed/simple;
	bh=TO/kj9+lLvHOlw6v676cGN2X1xrQoQT6nqKUEG+rBfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l54M6qJbrOBuT/8PpNe9UPNE4MeiG7bmSuuCaCiWAdo97opf76XBkpbOYrLja8SDO3JdhN/qubhXXOzv9oGTC/0bkeKhk8xOAwsJuXIO7L66e6R9tUpSO00HI/GHupOvyCODIzWDEGMI3EZ3mnd06ZhLqmrsiKb6d6yrq2awXfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cgSO9gDL; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-390ddf037ffso2995779f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 05:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741093638; x=1741698438; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nln3oiv+wCOohYzCVrwCh2whMM1hc+Xd6ZxmtYAIQvg=;
        b=cgSO9gDL58k48jBjDE95W+iYW0KzS5IzZeNEu8aL+9n2oco07ik71yP7/qggFASjl5
         ANJAsKmzBFeMLuqPFu2NBBB3Xsi9v3h3VV99/miXN2AFR4Vkyo+A+8CcI1rTEzIBgZO7
         ApqNmSwu/JQ3pmLT+Df2IYxuy64L9NfUveC7Eij+qK2zP5Zyvo3AYd/CEPc4Q0zkefjW
         mQaoQYuGMJqzLEytMjdD/Tpc9gM/kAqx8bJRpHrKrgTwtI3293DNyh7M7YWVLNi1sjkJ
         C1hrU9QhF48EK8BP2cch5mE53Fmrx3IrcQxguMx7O8h7RZjNNVjTtkBX8CfARRRuxS66
         cKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741093638; x=1741698438;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nln3oiv+wCOohYzCVrwCh2whMM1hc+Xd6ZxmtYAIQvg=;
        b=eRMpaaBYTO8uQE7ZtzND4eRy1Nx9gQ1rI4ng+x6u87xM9Ghu6nlziB6fV3waslmVfU
         X8atgHoYANKT2f6DK0bejt7eYw5nrZOosB+84n46eczEI0IBzOVlofxUUg8tjKxH3JFY
         X6+1N5xTztnFPOxS3UgDJL+cPz92EGLiYZI4UR1ahKEQPPTcMVH00FhIghJLIE9mVVQ3
         9SBkKBs1So2/7onsJ0Zs5z8gdXw2rVenntl2twXic5kUNohA0DOJ9wS4C/cW6yuC3aZU
         v60Na0yE3Q41+VoWvwEurPiqMLlmXtGQK6hsCu+lPpWvMF2BPBfasfsvj/wVMGHK3WEA
         I7Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWya4EbqTzpmxLKjMWJ3mZajOYVYKw9eNQ98bTKyFwQusmhBtvf2Te3HCFkplCPII6UL1IWRl3ocrq17As=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi5NM2xg4WGKtY9eIZj8ha4kjQ5lsAAziQYvj0pAuADwrcIYor
	YIJa6vtqbrYm+mxOTiffdnjsf0pY1hZIeaHGCzfR/Q3cLeqrWN8crJ7UYbWe7ClRkS4L4lCRy1n
	e
X-Gm-Gg: ASbGnct+J7psC82zzvF8j3c3kLj7yG/zhX9DucEroxdKB3TQ49Aa73BhvCj8KsyDYA/
	JkFlB1FZFzBv+8H3haZHoFrYrFJ4oQ4OyKOi/IYAN+s9JsCXsoiTZ2RgVvqLl/LZZw78Ss/GW2q
	nxHeALhcfadJsZbvA62Q4pesNH85QHGwbxAHF39bxaxMoaWoZu081ngk56dXQ9/PMIY2y1qSB3P
	ujG6dLbPW7h2KnzBRtmrgCOf2EfOQw8cLM6DwtCuPmEZMYLqyz+3pnucObBGhYcKqk16izJYhni
	eI33N3ohFpJOBxSTnhnej8V2bnisrvHMY2mwOZfGg2khF+IOvBmEWSmRMGQ/NUM1qYZGbmZAyfz
	nxZY/IQ==
X-Google-Smtp-Source: AGHT+IGpTFcm31h9EpuPbAm3YUIJaoJyD95IH89so3fYUNBg2B1J+FhEDae5gGh7l1PFPh0SPC0Ycg==
X-Received: by 2002:a5d:6da3:0:b0:390:e85b:a8ee with SMTP id ffacd0b85a97d-390ec7c6a2fmr13832592f8f.1.1741093638590;
        Tue, 04 Mar 2025 05:07:18 -0800 (PST)
Received: from [127.0.1.1] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b6cd8sm17401715f8f.44.2025.03.04.05.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 05:07:18 -0800 (PST)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Tue, 04 Mar 2025 13:07:13 +0000
Subject: [PATCH 7/8] arm64: dts: qcom: sc8280xp: Add Venus
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250304-b4-linux-media-comitters-sc8280xp-venus-v1-7-279c7ea55493@linaro.org>
References: <20250304-b4-linux-media-comitters-sc8280xp-venus-v1-0-279c7ea55493@linaro.org>
In-Reply-To: <20250304-b4-linux-media-comitters-sc8280xp-venus-v1-0-279c7ea55493@linaro.org>
To: Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
 Vikash Garodia <quic_vgarodia@quicinc.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Johan Hovold <johan+linaro@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
X-Mailer: b4 0.15-dev-33ea6

From: Konrad Dybcio <konradybcio@kernel.org>

Add the required nodes to enable Venus on sc8280xp.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
[ johan: use sm8350 videocc defines ]
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
[ bod: dropped video encoder/decoder declarations ]
[ bod: added interconnect tags ]
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 82 ++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
index 01501acb1790a..fe8aa24d5d51e 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
@@ -10,6 +10,8 @@
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,sc8280xp-camcc.h>
 #include <dt-bindings/clock/qcom,sc8280xp-lpasscc.h>
+#include <dt-bindings/clock/qcom,sm8350-videocc.h>
+#include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sc8280xp.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
@@ -690,6 +692,11 @@ reserved-region@85b00000 {
 			no-map;
 		};
 
+		pil_video_mem: pil_video_region@86700000 {
+			reg = <0 0x86700000 0 0x500000>;
+			no-map;
+		};
+
 		pil_adsp_mem: adsp-region@86c00000 {
 			reg = <0 0x86c00000 0 0x2000000>;
 			no-map;
@@ -3699,6 +3706,81 @@ usb_1_dwc3_ss: endpoint {
 			};
 		};
 
+		venus: video-codec@aa00000 {
+			compatible = "qcom,sm8350-venus";
+			reg = <0 0x0aa00000 0 0x100000>;
+			interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
+
+			clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
+				 <&videocc VIDEO_CC_MVS0C_CLK>,
+				 <&videocc VIDEO_CC_MVS0_CLK>;
+			clock-names = "iface",
+				      "core",
+				      "vcodec0_core";
+			power-domains = <&videocc MVS0C_GDSC>,
+					<&videocc MVS0_GDSC>,
+					<&rpmhpd SC8280XP_MX>;
+			power-domain-names = "venus",
+					     "vcodec0",
+					     "mx";
+
+			resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>;
+			reset-names = "core";
+
+			interconnects = <&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
+					<&mmss_noc MASTER_VIDEO_P0 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&mmss_noc MASTER_VIDEO_P0 QCOM_ICC_TAG_ALWAYS
+					 &gem_noc SLAVE_LLCC QCOM_ICC_TAG_ALWAYS>;
+			interconnect-names = "cpu-cfg",
+					     "video-mem",
+					     "video-llcc";
+
+			operating-points-v2 = <&venus_opp_table>;
+			iommus = <&apps_smmu 0x2e00 0x400>;
+			memory-region = <&pil_video_mem>;
+
+			status = "disabled";
+
+			venus_opp_table: opp-table {
+				compatible = "operating-points-v2";
+
+				opp-720000000 {
+					opp-hz = /bits/ 64 <720000000>;
+					required-opps = <&rpmhpd_opp_low_svs>;
+				};
+
+				opp-1014000000 {
+					opp-hz = /bits/ 64 <1014000000>;
+					required-opps = <&rpmhpd_opp_svs>;
+				};
+
+				opp-1098000000 {
+					opp-hz = /bits/ 64 <1098000000>;
+					required-opps = <&rpmhpd_opp_svs_l1>;
+				};
+
+				opp-1332000000 {
+					opp-hz = /bits/ 64 <1332000000>;
+					required-opps = <&rpmhpd_opp_nom>;
+				};
+			};
+		};
+
+		videocc: clock-controller@abf0000 {
+			compatible = "qcom,sc8280xp-videocc";
+			reg = <0 0x0abf0000 0 0x10000>;
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK_A>,
+				 <&sleep_clk>;
+			power-domains = <&rpmhpd SC8280XP_MMCX>;
+			required-opps = <&rpmhpd_opp_low_svs>;
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		cci0: cci@ac4a000 {
 			compatible = "qcom,sc8280xp-cci", "qcom,msm8996-cci";
 			reg = <0 0x0ac4a000 0 0x1000>;

-- 
2.47.2


