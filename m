Return-Path: <linux-kernel+bounces-523217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E68A3D3A8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 09:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23B63BCB58
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86A11EDA11;
	Thu, 20 Feb 2025 08:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sjdaiwWt"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384CF1EB1A9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 08:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041390; cv=none; b=AYmpuJgHqXFSSmv9L4VZKJCte03zUqjc8NMEQFE/RreMUgWTUao+3nrubskHrbIEiLIsqZwinrnZovdWLIEWnpFTd5/FXKAxOlX/3n3e4gyp+Y5OGjTGtVMtr8ZwgUlaWaBQ4twExrcXTpLljyZQELU4dbcwpNUVU02ikfGC6gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041390; c=relaxed/simple;
	bh=iNChfhRaxZaWc7+AMNO4hQDgaKmdd0RV5kN/272VBfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aLX2y/8qy+19IPFtYuyLvNKJoe1Ubsdj95xWLBK2INCEvqU122sonhMjmpMdvbcfBqRrMNRQaEmk79IrdBC3mPcvFU+3JhDVi3u9TqOOJyPL6KRRo/wqVfx8+RAMCXlOV0UVwrqhTg6h2WhoNHNQy1lJsJmixpJaVbAi5vQXT0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sjdaiwWt; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43980f4d969so1027635e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 00:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740041386; x=1740646186; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZbFvjOeNMnP+x2TmZRkvgSPoJV570mVDl8EHHnjD7pA=;
        b=sjdaiwWtAmFdARWz8wJfsYe5FOyiDQX01KNNHUTM1L1kVHz5Fxf2VtsG5OmOJcMtut
         NP1/50DYxxPLkmbO3SkS7UtppU+Yi90bgJ+kfxdrEVNAVtxyFOwZpSC0kj3eaAYrtnS5
         NHc1S+f7yR0T3F5wOdoZtOIEn2dGi7teuhc0tafLsjD/OsnSrcgBY64dzepq9GQ9iyRv
         0E5PsxmiE5HbBUJA3VNEjkfKsIC8MS9KAwbUBligJ4B5LQm4xhbFGoZZryfY3GgjItt+
         GQKDJ6OBOc+ouJQqjK/+7NDka0fxQ3vC3U6lSSRR0y7lg0xd8wRvRzodGvDE2ql5ziu7
         DI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740041386; x=1740646186;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZbFvjOeNMnP+x2TmZRkvgSPoJV570mVDl8EHHnjD7pA=;
        b=HEQeTqHBlzROMArs4/kg6MBhGtDRh+pdrPOM8MnC3QCWaUs6zI5PjgX+kV5MlsQK2A
         SA3r01aBzw6FosuEsUfApqxGdyLRBWpBUjyB5w5UZvYBmy+NaHDgIaLrLuTMobUT+JXM
         qdFgFPEEh0VQX/eSOcIq/JATc/sWKzhJdc9xgfqxAFg7N9zPWFrMfHMeKJCQ284I7R1U
         FkevDprIWA1du1e+VjZ1HNkGEh8BR84nY2o6j2wXjZFPs+5sMfHw/YkWXSmriex4r/f+
         M/sWJsffV4K0+WVExkartZn3J8++mRPcqNeJPSPMn6CWWnqNIiyhPS7KvmZ0NIuN3d7s
         6w4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdpl5Jl5yCjwqhrl0x2fiaq3FN74s+yX4mCBpi+JWPfINKf2OG/U0UrwdNrNiXgWUR4RTaQozf7jRkOZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcWhZTK6kYYJHM7cm/scSkZgpM8FLm7YjumpzTjFcCJocD1Akm
	Uw7Xn9AP4aNGG3ttBfh7X/VynJOqdtpK+CfmygN+fhaFzgs2JLVFy6+sdujkKwY=
X-Gm-Gg: ASbGnct1aLcs86u4vogGJhcyoiljwoOxCz+gqdaP9lROMvIBTZHDutoI25DHTjJMv3z
	qGJajswxxhZTZpaW+WczzetOsvxuAp3xwrzhVN1a2sijndaTLE0LDc5eaX2PDhNX8B2WvsH+kSu
	jTaOpdr+H2cJbUPEQIs8Hi00yAR4m18Yed+FkRMrNIWgEgDe7XK60mOjbe6yUeJpJwoFOnPTDVs
	F5r+jHOdDlOeDbbX0J3wlYTvt/16oWdA+BneLAp1VcWO/5JEun2Nm7jQj6P8T8Fl+LtpSusqwFC
	9MpYaYjTztAPzLnQ9jecGW2z1PykNhv84/NidjYCFZnm6Usfjn2Sa2fTzIuHc1HP
X-Google-Smtp-Source: AGHT+IHVgDByDtcNf4ZxxlL+uWtgEI8tQkrwG9tddkLsr9UnJjtJS8aQ6uUZsxm44qR9z1dbdsbGxg==
X-Received: by 2002:a05:600c:4ece:b0:439:a1ce:5669 with SMTP id 5b1f17b1804b1-439a1dd9be3mr9998945e9.5.1740041386360;
        Thu, 20 Feb 2025 00:49:46 -0800 (PST)
Received: from [127.0.1.1] (46-253-189-43.dynamic.monzoon.net. [46.253.189.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1b8397sm234417565e9.36.2025.02.20.00.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 00:49:44 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 20 Feb 2025 09:49:40 +0100
Subject: [PATCH v2 1/4] arm64: dts: qcom: sm8750: Add IPCC, SMP2P, AOSS and
 ADSP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250220-sm8750-audio-v2-1-fbe243c4afc3@linaro.org>
References: <20250220-sm8750-audio-v2-0-fbe243c4afc3@linaro.org>
In-Reply-To: <20250220-sm8750-audio-v2-0-fbe243c4afc3@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Melody Olvera <quic_molvera@quicinc.com>, 
 Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2

Add nodes for IPCC mailbox, SMP2P for ADSP, AOSS and the ADSP remoteproc
PAS loader (compatible with SM8550).

Reviewed-by: Melody Olvera <quic_molvera@quicinc.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 140 +++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index 3bbd7d18598ee0a3a0d5130c03a3166e1fc14d82..683dd5529f02c8b446e704106294bd68d55d65dc 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -10,8 +10,10 @@
 #include <dt-bindings/interconnect/qcom,icc.h>
 #include <dt-bindings/interconnect/qcom,sm8750-rpmh.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/power/qcom,rpmhpd.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
+#include <dt-bindings/soc/qcom,gpr.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
 / {
@@ -516,6 +518,32 @@ llcc_lpi_mem: llcc-lpi@ff800000 {
 		};
 	};
 
+	smp2p-adsp {
+		compatible = "qcom,smp2p";
+
+		interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
+					     IPCC_MPROC_SIGNAL_SMP2P
+					     IRQ_TYPE_EDGE_RISING>;
+
+		mboxes = <&ipcc IPCC_CLIENT_LPASS
+				IPCC_MPROC_SIGNAL_SMP2P>;
+
+		qcom,smem = <443>, <429>;
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <2>;
+
+		smp2p_adsp_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		smp2p_adsp_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	soc: soc@0 {
 		compatible = "simple-bus";
 
@@ -542,6 +570,17 @@ gcc: clock-controller@100000 {
 			#power-domain-cells = <1>;
 		};
 
+		ipcc: mailbox@406000 {
+			compatible = "qcom,sm8750-ipcc", "qcom,ipcc";
+			reg = <0x0 0x00406000 0x0 0x1000>;
+
+			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+
+			#mbox-cells = <2>;
+		};
+
 		gpi_dma2: dma-controller@800000 {
 			compatible = "qcom,sm8750-gpi-dma", "qcom,sm6350-gpi-dma";
 			reg = <0x0 0x00800000 0x0 0x60000>;
@@ -1945,6 +1984,94 @@ tcsr_mutex: hwlock@1f40000 {
 			#hwlock-cells = <1>;
 		};
 
+		remoteproc_adsp: remoteproc@6800000 {
+			compatible = "qcom,sm8750-adsp-pas", "qcom,sm8550-adsp-pas";
+			reg = <0x0 0x06800000 0x0 0x10000>;
+
+			interrupts-extended = <&pdc 6 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog",
+					  "fatal",
+					  "ready",
+					  "handover",
+					  "stop-ack",
+					  "shutdown-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			interconnects = <&lpass_lpicx_noc MASTER_LPASS_PROC QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+
+			power-domains = <&rpmhpd RPMHPD_LCX>,
+					<&rpmhpd RPMHPD_LMX>;
+			power-domain-names = "lcx",
+					     "lmx";
+
+			memory-region = <&adspslpi_mem>, <&q6_adsp_dtb_mem>;
+
+			qcom,qmp = <&aoss_qmp>;
+
+			qcom,smem-states = <&smp2p_adsp_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			remoteproc_adsp_glink: glink-edge {
+				interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+				mboxes = <&ipcc IPCC_CLIENT_LPASS
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+				qcom,remote-pid = <2>;
+				label = "lpass";
+
+				gpr {
+					compatible = "qcom,gpr";
+					qcom,glink-channels = "adsp_apps";
+					qcom,domain = <GPR_DOMAIN_ID_ADSP>;
+					qcom,intents = <512 20>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					q6apm: service@1 {
+						compatible = "qcom,q6apm";
+						reg = <GPR_APM_MODULE_IID>;
+						#sound-dai-cells = <0>;
+						qcom,protection-domain = "avs/audio",
+									 "msm/adsp/audio_pd";
+
+						q6apmbedai: bedais {
+							compatible = "qcom,q6apm-lpass-dais";
+							#sound-dai-cells = <1>;
+						};
+
+						q6apmdai: dais {
+							compatible = "qcom,q6apm-dais";
+							iommus = <&apps_smmu 0x1001 0x80>,
+								 <&apps_smmu 0x1041 0x20>;
+						};
+					};
+
+					q6prm: service@2 {
+						compatible = "qcom,q6prm";
+						reg = <GPR_PRM_MODULE_IID>;
+						qcom,protection-domain = "avs/audio",
+									 "msm/adsp/audio_pd";
+
+						q6prmcc: clock-controller {
+							compatible = "qcom,q6prm-lpass-clocks";
+							#clock-cells = <2>;
+						};
+					};
+				};
+			};
+		};
+
 		lpass_ag_noc: interconnect@7e40000 {
 			compatible = "qcom,sm8750-lpass-ag-noc";
 			reg = <0x0 0x07e40000 0x0 0xe080>;
@@ -1978,6 +2105,19 @@ pdc: interrupt-controller@b220000 {
 			interrupt-controller;
 		};
 
+		aoss_qmp: power-management@c300000 {
+			compatible = "qcom,sm8750-aoss-qmp", "qcom,aoss-qmp";
+			reg = <0x0 0x0c300000 0x0 0x400>;
+
+			interrupt-parent = <&ipcc>;
+			interrupts-extended = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP
+						     IRQ_TYPE_EDGE_RISING>;
+
+			mboxes = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+			#clock-cells = <0>;
+		};
+
 		spmi_bus: spmi@c400000 {
 			compatible = "qcom,spmi-pmic-arb";
 			reg = <0x0 0x0c400000 0x0 0x3000>,

-- 
2.43.0


