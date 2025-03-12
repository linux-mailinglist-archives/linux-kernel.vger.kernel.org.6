Return-Path: <linux-kernel+bounces-557730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC17A5DCF6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0C3A17908A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 12:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6BB24500B;
	Wed, 12 Mar 2025 12:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e6UIH5RX"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AE323F37C
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 12:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783501; cv=none; b=RZ5fJ5TScTw/sSv1sTbylMQ1xVtLNPT4x8sCl5Uq5o6XG8D70Hf5ncchUQjKUOPJ33nFKygjYECQPx3eoc7F77fE2iuUD7GKCa//o2pY2cJAo6KjPc1l046MFLiYvc+p421BcaFi+1EGHrHmJ9vpL7qSt3fUkHd/jPLv2Cn9gho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783501; c=relaxed/simple;
	bh=oL6moqxBuaEz3rxsz8wppsHXom2I6GKZ4bU13rJQ1uc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KregW6UOqX5W40R4VWAxL1aJ299psBA17PQrWVh1K3Co0fobmpzzWJ2wQ8mRvrxvmuYu94AyWWdurgOJ+4OWZ1b+PFfL/nZHpEoTl8V/lt1UOkz9XgqPdq7trGVJEMm/MaPeddrX+dKmeiHtiJqs6OG985lijteeQK465YO+2oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e6UIH5RX; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ac1df33123cso90552666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 05:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741783497; x=1742388297; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Sh4g/C/Ubyh8uPMatx1TkijwdZ5uMHq/AjXcR8sIHw=;
        b=e6UIH5RXpsuAkzPgC05wNZygZHR/UuJk9E6lWTjM4W5zvYKMzs2NJ0j9GgYUOMwe3Z
         UCJ8Au8xsDhAGNR3K9AZKuty/rOBrJ1FLuEJyiLNNm0gK5mA2mU68PjNpGkxj6iGS5n2
         zZ5iWmjlMbjSU6xQp7pxsIVIQedqIdGaVhZagZGVow3CZDkxp+s1Fm3flK6D3lpmy9P9
         jWLeiI2zaxJVpkjH/VtgOdgLdQ1+v66e3olubQe613uuHuIy1O/67nJCTP+p9jPM2ccY
         qCkF6BPdr3WiQULMC0e0Kl/yKvLornDDDPK1XLQ0fi7aGp0AWJP9o/GsxmPwmWf4jxK8
         KzHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741783497; x=1742388297;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Sh4g/C/Ubyh8uPMatx1TkijwdZ5uMHq/AjXcR8sIHw=;
        b=tsMK7Z9CyykmlKKo+MZjq0kyDW+Pfji4oC1YuRep+dznKscYbwaBIF/4VDSihwmiy4
         r3aP6gAPk6lIbh/wB4jhJuPNGVFqhztBNSiZsxyqxaGrX2Up1aPYnrolrO4B0LwWoTcy
         egsyMcFlBpms7wO+xOl0NhIV5f7ipvWaU6tqdtKepF/lx4mBigRYypfJnec50x2VPyMw
         4Ryx7/+bpObJ97S5itwup4Al6VfETRHz20iiDgn1YhxdU7Hir+0pJ712EHm4jn7/5hPn
         uD6jlJM2OQKnwuV4jiKootcG01SQ4EJKQwbHb+OnEX++Z2CMK5iyX0Jl+DgUXslPhdQt
         QlCA==
X-Forwarded-Encrypted: i=1; AJvYcCVuKdEg05edBBxcXF1Q3KswxyXrVvwadbPVS6cvyQRmLGH26fhn11WLEal8tmWiP5iVePgyzpIabLUsYhI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb7SqIeSmzV6KoOXeJp3a2IoEXxerGDH/BtsZ13F53WiZChGe5
	l6oSwzKi9JxvncgdpCz/5ytmcVNc4bNYLY6YfCpTOktQtn4YPSSEV2smrNs5nhM=
X-Gm-Gg: ASbGncuowKA9x1CHgKhmBg7ClOKhGBSq12PR+85oGOFajuRpRkmRwo0T1SxMhlTFoSS
	a96gBK677nKI11hBEeviCCDWlV1GU0DZolOuzm0V1BXIRgLsmzk+l8NS2H/awTa/ebSvbPQLDnA
	G7XoxOJr1eyEt3wDyLJBF8Bt4+4QZ23p8TdFICIWJHK3cKaL+3BJQJOg2QigVWWEiKUixEZSXVJ
	ZRIcQjYGru7HMgPkRKDubUTJx2H9TY5G7upxMFR8j+FX0LRjEdTc0qM0NbjBXPetqKCLrjmlJnx
	On6++YGNlmm8UdGjd3NetQutdmQTqt7HD5ydvxcp35vauh6rxyHHnSvlTIk=
X-Google-Smtp-Source: AGHT+IEtHfgOtLRq+J/v0HvP6SCheIAhhH26H1i8jn+DiifDHWy09QP2Kkh3P+/RCGUHMMYp7uWVJw==
X-Received: by 2002:a17:907:7d8d:b0:ac1:d84d:72cd with SMTP id a640c23a62f3a-ac2b9c7d592mr345287166b.3.1741783497351;
        Wed, 12 Mar 2025 05:44:57 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac287653d1esm628955866b.125.2025.03.12.05.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:44:56 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Mar 2025 13:44:45 +0100
Subject: [PATCH v3 1/4] arm64: dts: qcom: sm8750: Add IPCC, SMP2P, AOSS and
 ADSP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-sm8750-audio-v3-1-40fbb3e53f95@linaro.org>
References: <20250312-sm8750-audio-v3-0-40fbb3e53f95@linaro.org>
In-Reply-To: <20250312-sm8750-audio-v3-0-40fbb3e53f95@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5612;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=oL6moqxBuaEz3rxsz8wppsHXom2I6GKZ4bU13rJQ1uc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBn0YHCgI3HGwz9xwS9SVIea1YQ/z3nlbeqH8hqh
 ZFJv5utNwOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ9GBwgAKCRDBN2bmhouD
 1xjKD/wI0+FMrJjSNCclHK2p8kgnYGIh3BPC0z++hU+tuy9S/bni8VTSkB12bYU5MDrmH1KkPFB
 BqpUCrPwx1h7iNFjf+gW38CYgCYY9idy81jHT+yam115NsLQcxiVB8kF01XDfHflnGldl7+uac6
 nCQ4OPGwc2UBTMKfoF0EqUlGNIv0Jrx+Rz8/C9jGJVqEMKDso7v1Ums2V/AKkHsKM8EPa99di8x
 g8kjHe8CGZGM9wCbXPIVW77K22K9XoAnXoCgTnx6PK3tQzzkGrmT3l88DHBQnK6CHpMIlOE7TPC
 4JuhVrEim/IQchUiQ7uyzhvHLRQrmBpd3a7RCV9PAkh9sWMviJgDrGCU+TSJSLZivZcQQoS4YuO
 mhiI3f//4Vo7O7dpCpAtt6+0mEm6VgxmRCTVoelFlPBmKQwy8Xo/um2goJ1DoI0f6xx5tdu1h1g
 0T9sTApgpEw/uO87LQm3rW/w+F00jBifAIQRoq2jugmm8Hc0XVrSxuXSuqDoG/EHFe6kKN9l6mR
 6LJiWRUzvge6OVwteltsphzOb34PpQjiyxeXwpPwRsl/bwHD5D8TFL/WPm9yAdJ6jZzP7G+5mAb
 8iSYaZ1il4bEkYIXeOxI3j7cRauntmkTrEL9saQh5RTj1sOUt2Zro0/xFgp3P5cIe4uU4Yd3uo4
 CLY9xYyjzUBUoPA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add nodes for IPCC mailbox, SMP2P for ADSP, AOSS and the ADSP remoteproc
PAS loader (compatible with SM8550).

Reviewed-by: Melody Olvera <quic_molvera@quicinc.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 140 +++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index 529e4e4e1d0ea9e99e89c12d072e27c45091f29e..76efb46edbb149b83179a5f4cbcb9072a5b5b107 100644
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
 		sram@c3f0000 {
 			compatible = "qcom,rpmh-stats";
 			reg = <0x0 0x0c3f0000 0x0 0x400>;

-- 
2.43.0


