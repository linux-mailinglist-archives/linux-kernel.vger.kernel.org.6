Return-Path: <linux-kernel+bounces-445002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A049F0FBE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 15:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2C9918821A2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 14:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDC91E32C5;
	Fri, 13 Dec 2024 14:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O/HytsKT"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE8C1E2309
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 14:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101669; cv=none; b=bM9zpkkYSKWkCy6RREfa/2ZR5J5uVjqwerkfWTcJoRpv4cONmZfLohz/bg1VJfplNtyGxdYoARMFVFw/PCZoF9ybiW6rGRES4BmDtK7INk9WliIERJZF9t1MX0kniNa2tjSkSxANiYKIuIgjWNg5KjuP8OJs9OK8Dv3euYEpHxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101669; c=relaxed/simple;
	bh=0EVceoWUYvaAhk9hFZoxilWmthbEqHGZlB/Aec2a0ls=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sDsqgyVh4zeKBdaBNhjOb9btPZaELCLSXPNDcVim554F2CPlRaCSd67YP1Scrgj/cXvdDyBfntGsDRKPJsZ+c5zKVRWHm6v+ooLJW8VVWkft6Hu0EsNYT2qdb+oNndMLcAIHWait7iB0YzCbjXtSIZ+nGy0z2bRAWQblKQ0N9EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O/HytsKT; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-434f1e5e77dso1474015e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 06:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734101665; x=1734706465; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d3eubFWCtOkA9zmoG7iTSW5qF+LPCoruvLjJDIK8GFw=;
        b=O/HytsKTNxhjarCmonvPDHSLP8yDCbCUjRpSUk8g9b/KVOpa1J6HY0PJGl4bKJjUmm
         m4pYv/goDY41dYzD6BTLffvT9XJzH2ekBQDtem0yA0lZ+y34nDsdVYhXW8O1MbhnOgPU
         r6J2sSeg4XJqZ4WmacYHqbD3//nlY4Lp1uH+LPbe9v5Rl3SsTU1CyVmX7KZwx2CZvrx6
         rNR5sHXQmIWFJQloZLuDWXNL2nDNN+i2g3wFtOhu52yjQHGjHvZLKK5aR5dR8q0gbhjj
         3FqEhqJpWND9ck3/z+iZmMf5cR8HErpULh3US3tAPeoL067WM4YnMxy4xOV5OA1vZQQ+
         7KIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734101665; x=1734706465;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3eubFWCtOkA9zmoG7iTSW5qF+LPCoruvLjJDIK8GFw=;
        b=gCi41A+bchQvKkjJclB7Q615m+iLRt+TNFafgdNXCbLPDkDNmKsq02WxTsPCA0VBTf
         6jxDBkzmLtQ2ugWsSxkmP91WiaK9gjvszJ31AVSidvfjVC+Mi6nW2lUIi+5nJrMkZLuE
         lCM4yrJSiFEXPoKeYVf5euhc/izLWd4a5tWI2I7lNt05tPGDmqBsLpHOTU8DvhrMqdp/
         Lt9UKvhZY9ZHhaSN7RjCsl7cBuj8n4z5H1dCnf06BSpwm3yARKyJOs7ZZk78hT1GpP2y
         PiprNBTzRVJsG1inKhuA+y5GDsflML1wsgsJ6An/wVt2/FLC3pRifBrAHjBuh54wD2s5
         mfZw==
X-Forwarded-Encrypted: i=1; AJvYcCW85CQA4VnUinlPIQxDWNLMKchKMYrD0cgNjgpGSoNasfN1UABecEJSWNRO923xvrkzj/RgSW5JgmdJmPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyInZI64+L8ptg2KxUK0rsmrNXPSfsafAx9Yw44KHHwQ+JEEpPO
	aaQMBbZSLkPhySLHQV85e3i5MdxYylGQ92F/a1YnneCIEGqKe/XQLi3I4BjUA9I=
X-Gm-Gg: ASbGncs+gfOfjXswBUmV0k+Af1zjUGEpk7ed672QtWKaAWSSdFhX+QFJ8W2wLueMHMs
	bcw96uNfjvLvt9jBhr7PG6sj6PAI29/6KSMmUpQTIjU/kkOBU0WaiP80O7Zt1HbkYLvXdLEVrY8
	lEAchXTE7z5p/PLJmPirJa5sPCSUwquxBH4cBo7s8P8+LVuV1PQ0f/q3fZY4SoXLtFEJXfx5a4W
	pYcO+eIFVn2zpuIfMShS9dVK3R66n79OtXKsgtaWJMZvCt9jqLQHziATA8E0JRuHt/aFVlB
X-Google-Smtp-Source: AGHT+IHPWkwZk2QAAo1Hl8jQVni1N4x4pTjQAwtOCiBASpZ49UDKmPpiwKr9PaFOIxFuODZKowg47w==
X-Received: by 2002:a05:600c:5128:b0:434:a0fd:95d0 with SMTP id 5b1f17b1804b1-4362aa8f4f5mr9247935e9.4.1734101665359;
        Fri, 13 Dec 2024 06:54:25 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436256b42c8sm51547305e9.29.2024.12.13.06.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 06:54:24 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 13 Dec 2024 15:53:51 +0100
Subject: [PATCH v3 02/23] arm64: dts: qcom: sm8350: Fix CDSP memory base
 and length
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241213-dts-qcom-cdsp-mpss-base-address-v3-2-2e0036fccd8d@linaro.org>
References: <20241213-dts-qcom-cdsp-mpss-base-address-v3-0-2e0036fccd8d@linaro.org>
In-Reply-To: <20241213-dts-qcom-cdsp-mpss-base-address-v3-0-2e0036fccd8d@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, Sibi Sankar <quic_sibis@quicinc.com>, 
 Luca Weiss <luca.weiss@fairphone.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7941;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=0EVceoWUYvaAhk9hFZoxilWmthbEqHGZlB/Aec2a0ls=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBnXEqJwyx07W2nOHBzr98uxwjXsLi7/Wged65ef
 BTXJOLdhVWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ1xKiQAKCRDBN2bmhouD
 15E4D/9ILm9kQ1abXH4spfkN0AZkeLos2XcpoYWt5M7FzONqrFrZIfgN9IAkfq4ZaXHRwZwAavg
 F3iIn3htmtni8f8pHKaAK9D31injOOx8bgZZXqbUDQqD3kj1fibXC01TBmtF66Y1zyfBeGmUVjv
 NcMW+yNgs2hx1ogDUPIBxn5JszR2meLzcnPvwrxcneG3dHesyEHC6rUQIMGAdLNnYA1kGADb6+S
 2E1vMt/nORJNw1U8aiXfhWRYiXSmGpPK2THX0WNnG1MQrcVKTMdvOItYEaKLxA7N9lp6Gd8DjoF
 qhPsisEEIEUG8MD37kAIzwiYaDbolyvNz8B6ymdxcgz1eh9ELyA6uoFcm9IZXCwCJy28w+fHiwc
 AW6TFchOCoRg15fFiQiS73qpj9nB2gej/r8Fd9ZgSa2k/4EHNdD8dV8kdv9hlgGy9lOz37nodUv
 WU0xf+xWnYg7pme3XAyb1r1wTvcNgkZAtkXkJyPJykJTj534v927LrwolaAq5VIhBze+a687rrP
 Nl1QcTn8RbX9pWCV3rkf37LC0fWbI0nWwtiGVjCiQ/s4XHjaIYiaLi5TvkKZfBe+j1fuiVLmH8l
 4vg7fJ/5ehUBocOHwGl9BKFw2wsBF0AGQqOM0QKBnoU4BfMLNAezRDHbrQy8TIGwLEUX0FqztZu
 hqT9677KfzUFK5Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The address space in CDSP PAS (Peripheral Authentication Service)
remoteproc node should point to the QDSP PUB address space
(QDSP6...SS_PUB): 0x0a30_0000 with length of 0x10000.  0x9890_0000,
value used so far, was copied from downstream DTS, is in the middle of
RAM/DDR space and downstream DTS describes the PIL loader, which is a
bit different interface.  Datasheet says that one of the main CDSP
address spaces is 0x0980_0000, which is oddly similar to 0x9890_0000,
but quite different.

Assume existing value (thus downstream DTS) is not really describing the
intended CDSP PAS region.

Correct the base address and length, which also moves the node to
different place to keep things sorted by unit address.  The diff looks
big, but only the unit address and "reg" property were changed.  This
should have no functional impact on Linux users, because PAS loader does
not use this address space at all.

Fixes: 177fcf0aeda2 ("arm64: dts: qcom: sm8350: Add remoteprocs")
Cc: stable@vger.kernel.org
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8350.dtsi | 218 +++++++++++++++++------------------
 1 file changed, 109 insertions(+), 109 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
index 5fae676af3a3da21066d01092b6b24fbc4ae4a40..2a62405c0c9eff959abc4cee57753a8b1545c9bf 100644
--- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
@@ -2496,6 +2496,115 @@ compute_noc: interconnect@a0c0000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 		};
 
+		cdsp: remoteproc@a300000 {
+			compatible = "qcom,sm8350-cdsp-pas";
+			reg = <0x0 0x0a300000 0x0 0x10000>;
+
+			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MXC>;
+			power-domain-names = "cx", "mxc";
+
+			interconnects = <&compute_noc MASTER_CDSP_PROC 0 &mc_virt SLAVE_EBI1 0>;
+
+			memory-region = <&pil_cdsp_mem>;
+
+			qcom,qmp = <&aoss_qmp>;
+
+			qcom,smem-states = <&smp2p_cdsp_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts-extended = <&ipcc IPCC_CLIENT_CDSP
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+				mboxes = <&ipcc IPCC_CLIENT_CDSP
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+				label = "cdsp";
+				qcom,remote-pid = <5>;
+
+				fastrpc {
+					compatible = "qcom,fastrpc";
+					qcom,glink-channels = "fastrpcglink-apps-dsp";
+					label = "cdsp";
+					qcom,non-secure-domain;
+					#address-cells = <1>;
+					#size-cells = <0>;
+
+					compute-cb@1 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <1>;
+						iommus = <&apps_smmu 0x2161 0x0400>,
+							 <&apps_smmu 0x1181 0x0420>;
+					};
+
+					compute-cb@2 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <2>;
+						iommus = <&apps_smmu 0x2162 0x0400>,
+							 <&apps_smmu 0x1182 0x0420>;
+					};
+
+					compute-cb@3 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <3>;
+						iommus = <&apps_smmu 0x2163 0x0400>,
+							 <&apps_smmu 0x1183 0x0420>;
+					};
+
+					compute-cb@4 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <4>;
+						iommus = <&apps_smmu 0x2164 0x0400>,
+							 <&apps_smmu 0x1184 0x0420>;
+					};
+
+					compute-cb@5 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <5>;
+						iommus = <&apps_smmu 0x2165 0x0400>,
+							 <&apps_smmu 0x1185 0x0420>;
+					};
+
+					compute-cb@6 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <6>;
+						iommus = <&apps_smmu 0x2166 0x0400>,
+							 <&apps_smmu 0x1186 0x0420>;
+					};
+
+					compute-cb@7 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <7>;
+						iommus = <&apps_smmu 0x2167 0x0400>,
+							 <&apps_smmu 0x1187 0x0420>;
+					};
+
+					compute-cb@8 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <8>;
+						iommus = <&apps_smmu 0x2168 0x0400>,
+							 <&apps_smmu 0x1188 0x0420>;
+					};
+
+					/* note: secure cb9 in downstream */
+				};
+			};
+		};
+
 		usb_1: usb@a6f8800 {
 			compatible = "qcom,sm8350-dwc3", "qcom,dwc3";
 			reg = <0 0x0a6f8800 0 0x400>;
@@ -3589,115 +3698,6 @@ cpufreq_hw: cpufreq@18591000 {
 			#freq-domain-cells = <1>;
 			#clock-cells = <1>;
 		};
-
-		cdsp: remoteproc@98900000 {
-			compatible = "qcom,sm8350-cdsp-pas";
-			reg = <0 0x98900000 0 0x1400000>;
-
-			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
-					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,
-					      <&smp2p_cdsp_in 1 IRQ_TYPE_EDGE_RISING>,
-					      <&smp2p_cdsp_in 2 IRQ_TYPE_EDGE_RISING>,
-					      <&smp2p_cdsp_in 3 IRQ_TYPE_EDGE_RISING>;
-			interrupt-names = "wdog", "fatal", "ready",
-					  "handover", "stop-ack";
-
-			clocks = <&rpmhcc RPMH_CXO_CLK>;
-			clock-names = "xo";
-
-			power-domains = <&rpmhpd RPMHPD_CX>,
-					<&rpmhpd RPMHPD_MXC>;
-			power-domain-names = "cx", "mxc";
-
-			interconnects = <&compute_noc MASTER_CDSP_PROC 0 &mc_virt SLAVE_EBI1 0>;
-
-			memory-region = <&pil_cdsp_mem>;
-
-			qcom,qmp = <&aoss_qmp>;
-
-			qcom,smem-states = <&smp2p_cdsp_out 0>;
-			qcom,smem-state-names = "stop";
-
-			status = "disabled";
-
-			glink-edge {
-				interrupts-extended = <&ipcc IPCC_CLIENT_CDSP
-							     IPCC_MPROC_SIGNAL_GLINK_QMP
-							     IRQ_TYPE_EDGE_RISING>;
-				mboxes = <&ipcc IPCC_CLIENT_CDSP
-						IPCC_MPROC_SIGNAL_GLINK_QMP>;
-
-				label = "cdsp";
-				qcom,remote-pid = <5>;
-
-				fastrpc {
-					compatible = "qcom,fastrpc";
-					qcom,glink-channels = "fastrpcglink-apps-dsp";
-					label = "cdsp";
-					qcom,non-secure-domain;
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					compute-cb@1 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <1>;
-						iommus = <&apps_smmu 0x2161 0x0400>,
-							 <&apps_smmu 0x1181 0x0420>;
-					};
-
-					compute-cb@2 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <2>;
-						iommus = <&apps_smmu 0x2162 0x0400>,
-							 <&apps_smmu 0x1182 0x0420>;
-					};
-
-					compute-cb@3 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <3>;
-						iommus = <&apps_smmu 0x2163 0x0400>,
-							 <&apps_smmu 0x1183 0x0420>;
-					};
-
-					compute-cb@4 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <4>;
-						iommus = <&apps_smmu 0x2164 0x0400>,
-							 <&apps_smmu 0x1184 0x0420>;
-					};
-
-					compute-cb@5 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <5>;
-						iommus = <&apps_smmu 0x2165 0x0400>,
-							 <&apps_smmu 0x1185 0x0420>;
-					};
-
-					compute-cb@6 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <6>;
-						iommus = <&apps_smmu 0x2166 0x0400>,
-							 <&apps_smmu 0x1186 0x0420>;
-					};
-
-					compute-cb@7 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <7>;
-						iommus = <&apps_smmu 0x2167 0x0400>,
-							 <&apps_smmu 0x1187 0x0420>;
-					};
-
-					compute-cb@8 {
-						compatible = "qcom,fastrpc-compute-cb";
-						reg = <8>;
-						iommus = <&apps_smmu 0x2168 0x0400>,
-							 <&apps_smmu 0x1188 0x0420>;
-					};
-
-					/* note: secure cb9 in downstream */
-				};
-			};
-		};
 	};
 
 	thermal_zones: thermal-zones {

-- 
2.43.0


