Return-Path: <linux-kernel+bounces-557782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCDDA5DDB3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 14:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F7E11637F5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 13:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C62245017;
	Wed, 12 Mar 2025 13:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GqWm8zyo"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AB824889A
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 13:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741785272; cv=none; b=jwQldriC8wJL/4ZkL5D9eOp2EVTC2XoJGK6IOKJB1RFE25SzPyBaL4kKGlOoXHyCBPwNzO5Cl8SeLbtN//6Az6bLRtIwXJvY32SNVo75CHeMEDCS2FGJ55BVU91eTYgnmuC+6JmH9PKDKhVhYxj4Cs32ivY0XeKmuzX1yyGK6yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741785272; c=relaxed/simple;
	bh=WwJ1D/xQhYnnE70APK5HUuAgSfdcB5C+d9hVsHP/PwU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fZawwk5tGxZeeIIr1apbZYs5aOSiV6m+/h8gWSf5vu9ZTIWzXGijExKB0RXLMGLE4RzkGRLDfnAwwnST4kV/goVXkwc17LuBM94wd08vVL/7TmdU8Ax30TGr/tfyW+FYXPSH1ATcyM7frKnGG6W01gzRfHT2E1Zu5otIwHfJX8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GqWm8zyo; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43ce5cd91e5so4693125e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 06:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741785267; x=1742390067; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iqtIX+KRQ/gRjdq8FBtPRASYggrMYH2b/Et+HrtT7KA=;
        b=GqWm8zyoz1q4a0X/ZxOXjfL9LZMWHm/Z9impPE8NKzc8e9LKtWdmOLiXucA/5OX9wI
         qpqLEID4VoE3reez3d+Qc8a1XzToW9npyL+Pr7yRXWNdZMyEBh28vnyLLLHKHiNkTaab
         3FL9O8KL3ZayriGQDVgkBYuZYQcB07v/iyxiY604HRp6+WaD+OA2Tnel3gsF9PU2XZkk
         3gIlb2lhrixrNiIEX0gqHU8FXjnMRHSEyYXTGhHvTIvhXFLPGQkjj+miVc8D9ejaLMMu
         wVH1ldxaH7Z00RakkCm/FIusDQpt02muQsHyczHB28/FggF8Jka4iVjSeqh9DJA5XauH
         8FOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741785267; x=1742390067;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iqtIX+KRQ/gRjdq8FBtPRASYggrMYH2b/Et+HrtT7KA=;
        b=CQH0zG6OYCsL/d2iexl9aAZ6bjKmsJmNXDdc/amixb/wSuqCjTIQYqig7T4xN2CFHd
         ki3zwiYPXA4/aZOeDcYmEcbWm6zbDCaqVXedNxgB/3+JbcQkEGV0t5Xjr8yy6O/A9eQH
         dY2f2MXOIrU4JvtGETSUwUMjJJrT/MgpgQXVVn7Q+WwmaRGzXq3Tp0H9FUVHI+N0UZTb
         zH0Ypbrbb2uee/d2Ls/nLTu/+hQRmaKROshua8HCSE/+tylqlnixs/tQYCfh1tspe6ri
         IpJgUVLpcVJkzpeyqOL1LNWQd4tYQxMYYBS0rH3s/KuXSWYf5tDNitmpa8OIn0lXgi9n
         xhyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTgckBrzKadMQOzzXuQIXm1v28pqHG1BYzsjNyT4gV+cVzSvztUXiRx+Twn+WhRbe3CwMA5Hs9aEQ/gmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR3+rjfmRwxkwFip4nHIQef86u/Qgc81onFYVDe50D9UWn2TqL
	OGpN1rzRB6D3dNQcozoSH0rDnEf2YYPJwvR08sOxLe1lJeCI8CTbq393n3nSd8Q=
X-Gm-Gg: ASbGncu+RohH8iVvDzby4k/wutkPGsJ1bib/TWn2MNaLHhg2Inyqxvqbbj46Gxrhdm4
	qajWqTTAQWO/ndx7Vbao/LBymhjHcXqAWyvo1Oydta+PTHQRzo5n5st/OOrbyuGxaMMoK3jJjZn
	z2xcXOoZN+7vUM1TPT91cfNMZr1b0ib8+DayxqwJLDJCuySSBAzMsak3HxCRvo5NKSqXH/gqlRA
	+wTTADn2w/3SoGatDHdBAJhrer9FDsLgHQIosxhcJQKS7biMvGAe2Pf1zVBWNSmYG5txgSjOQ0A
	49WBrkNQ+/hrVPHFopbcBTBXm1uj4iq3CmJXD58rvu7GUh9mTgo5d/phR34=
X-Google-Smtp-Source: AGHT+IED+vl3AXpREuDJ5mIKT8LKqXcPzMJ8VEOqUZGlUTk+UpRr6QXtx6UiWUWl7mS6aJzcw5mw5Q==
X-Received: by 2002:a5d:6da2:0:b0:38d:e472:e6a0 with SMTP id ffacd0b85a97d-3926beebdfemr3133256f8f.9.1741785267533;
        Wed, 12 Mar 2025 06:14:27 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d0a8c5cb4sm20966745e9.25.2025.03.12.06.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 06:14:18 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Mar 2025 14:13:57 +0100
Subject: [PATCH v4 1/3] arm64: dts: qcom: sm8750: Add CDSP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250312-b4-sm8750-cdsp-v4-1-4925d607cea6@linaro.org>
References: <20250312-b4-sm8750-cdsp-v4-0-4925d607cea6@linaro.org>
In-Reply-To: <20250312-b4-sm8750-cdsp-v4-0-4925d607cea6@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6280;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=WwJ1D/xQhYnnE70APK5HUuAgSfdcB5C+d9hVsHP/PwU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBn0Yik6TVPAZg3B+bAOY5c4izBiOCMOj3GJb9Jv
 uScly2QmO6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ9GIpAAKCRDBN2bmhouD
 1+yED/45FulectWPX5QKmjW5wJDBp4wegC0UefUYnIpLyhaYTnE9GrUrqA71F2Pc5WjFmBs8xCk
 1n5DtNr1tHdYhOVFh4DQ838nYhPZrcgDHFc0u6Kt+hUm5VvHIZMglVPqDw+cU6Zi/H+BLJZfOjf
 Xljk6fTQ/9Wn71AeNx+HJT0V8ZBa9cHmdxqTvfV1Pr/XrzsTGbNHKSad+fxl/Y0X3gzP2rc3Sd1
 vHLXFyh9VF4nqU+LRjSoOdlis8BfDGOWbdVttg7NpgXW9i1FF7Pf5Id+yXOqJqevP6k+0pG2LrG
 i9mnhNpla0GIt8/iSLDKfBWnubwy92cgipc7QmLS8XBWkZuN7gHIWiOgBvMG+9bmSp/t+CJfMOf
 P2K/Xb7vTkhkglGu/ESZBgdV1qeFA6hGS4quiWNH3aDFBcNPQigjtIfBStMXYWSEQc6udhn/BDa
 D4Ns5sXqgL7MSqAy5GNbLsmNAfBVMaeiqViXbBrYJl+hmS+tqDD8iikRfqDOFt/GUDSjtS7olzs
 38wh6G6Qrz1Ip7Twg0E/9l9+vHit/bm4xxhcBhZ5jyaHPSeBPud9hJrN7lgMNRcli+Py/c8DDVY
 ysEYQSOQoaSugYHH4nUimV3oqsKCJ3XrkPZ7lJIoL3MKXjEH56FbwY4vso2uGPL9GelZlWVHXVz
 r4RBxvl4+BUfCIg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add nodes for the CDSP and its SMP2P.  These are compatible with earlier
SM8650 with difference in one more interrupt.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8750.dtsi | 194 +++++++++++++++++++++++++++++++++++
 1 file changed, 194 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index 20ddc16c49462cc316e22272cb630cf2478f52fe..e7a3177d6098352166c0a609e364e9f0094e5a7f 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -545,6 +545,32 @@ smp2p_adsp_in: slave-kernel {
 		};
 	};
 
+	smp2p-cdsp {
+		compatible = "qcom,smp2p";
+
+		interrupts-extended = <&ipcc IPCC_CLIENT_CDSP
+					     IPCC_MPROC_SIGNAL_SMP2P
+					     IRQ_TYPE_EDGE_RISING>;
+
+		mboxes = <&ipcc IPCC_CLIENT_CDSP
+				IPCC_MPROC_SIGNAL_SMP2P>;
+
+		qcom,smem = <94>, <432>;
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <5>;
+
+		smp2p_cdsp_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		smp2p_cdsp_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	soc: soc@0 {
 		compatible = "simple-bus";
 
@@ -3241,6 +3267,174 @@ nsp_noc: interconnect@320c0000 {
 			qcom,bcm-voters = <&apps_bcm_voter>;
 			#interconnect-cells = <2>;
 		};
+
+		remoteproc_cdsp: remoteproc@32300000 {
+			compatible = "qcom,sm8750-cdsp-pas", "qcom,sm8650-cdsp-pas";
+			reg = <0x0 0x32300000 0x0 0x10000>;
+
+			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 3 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 7 IRQ_TYPE_EDGE_RISING>;
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
+			interconnects = <&nsp_noc MASTER_CDSP_PROC QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>;
+
+			power-domains = <&rpmhpd RPMHPD_CX>,
+					<&rpmhpd RPMHPD_MXC>,
+					<&rpmhpd RPMHPD_NSP>;
+			power-domain-names = "cx",
+					     "mxc",
+					     "nsp";
+
+			memory-region = <&cdsp_mem>, <&q6_cdsp_dtb_mem>, <&global_sync_mem>;
+			qcom,qmp = <&aoss_qmp>;
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
+				qcom,remote-pid = <5>;
+				label = "cdsp";
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
+						iommus = <&apps_smmu 0x19c1 0x0>,
+							 <&apps_smmu 0x0c21 0x0>,
+							 <&apps_smmu 0x0c01 0x40>;
+						dma-coherent;
+					};
+
+					compute-cb@2 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <2>;
+						iommus = <&apps_smmu 0x1962 0x0>,
+							 <&apps_smmu 0x0c02 0x20>,
+							 <&apps_smmu 0x0c42 0x0>,
+							 <&apps_smmu 0x19c2 0x0>;
+						dma-coherent;
+					};
+
+					compute-cb@3 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <3>;
+						iommus = <&apps_smmu 0x1963 0x0>,
+							 <&apps_smmu 0x0c23 0x0>,
+							 <&apps_smmu 0x0c03 0x40>,
+							 <&apps_smmu 0x19c3 0x0>;
+						dma-coherent;
+					};
+
+					compute-cb@4 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <4>;
+						iommus = <&apps_smmu 0x1964 0x0>,
+							 <&apps_smmu 0x0c24 0x0>,
+							 <&apps_smmu 0x0c04 0x40>,
+							 <&apps_smmu 0x19c4 0x0>;
+						dma-coherent;
+					};
+
+					compute-cb@5 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <5>;
+						iommus = <&apps_smmu 0x1965 0x0>,
+							 <&apps_smmu 0x0c25 0x0>,
+							 <&apps_smmu 0x0c05 0x40>,
+							 <&apps_smmu 0x19c5 0x0>;
+						dma-coherent;
+					};
+
+					compute-cb@6 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <6>;
+						iommus = <&apps_smmu 0x1966 0x0>,
+							 <&apps_smmu 0x0c06 0x20>,
+							 <&apps_smmu 0x0c46 0x0>,
+							 <&apps_smmu 0x19c6 0x0>;
+						dma-coherent;
+					};
+
+					compute-cb@7 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <7>;
+						iommus = <&apps_smmu 0x1967 0x0>,
+							 <&apps_smmu 0x0c27 0x0>,
+							 <&apps_smmu 0x0c07 0x40>,
+							 <&apps_smmu 0x19c7 0x0>;
+						dma-coherent;
+					};
+
+					compute-cb@8 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <8>;
+						iommus = <&apps_smmu 0x1968 0x0>,
+							 <&apps_smmu 0x0c08 0x20>,
+							 <&apps_smmu 0x0c48 0x0>,
+							 <&apps_smmu 0x19c8 0x0>;
+						dma-coherent;
+					};
+
+					/* note: secure cb9 in downstream */
+
+					compute-cb@12 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <12>;
+						iommus = <&apps_smmu 0x196c 0x0>,
+							 <&apps_smmu 0x0c2c 0x20>,
+							 <&apps_smmu 0x0c0c 0x40>,
+							 <&apps_smmu 0x19cc 0x0>;
+						dma-coherent;
+					};
+
+					compute-cb@13 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <13>;
+						iommus = <&apps_smmu 0x196d 0x0>,
+							 <&apps_smmu 0x0c0d 0x20>,
+							 <&apps_smmu 0x0c2e 0x0>,
+							 <&apps_smmu 0x0c4d 0x0>,
+							 <&apps_smmu 0x19cd 0x0>;
+						dma-coherent;
+					};
+
+					compute-cb@14 {
+						compatible = "qcom,fastrpc-compute-cb";
+						reg = <14>;
+						iommus = <&apps_smmu 0x196e 0x0>,
+							 <&apps_smmu 0x0c0e 0x20>,
+							 <&apps_smmu 0x19ce 0x0>;
+						dma-coherent;
+					};
+				};
+			};
+		};
 	};
 
 	timer {

-- 
2.43.0


