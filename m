Return-Path: <linux-kernel+bounces-525119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D86A3EB0F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 04:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C98E3BE497
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 03:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBDD1F03C1;
	Fri, 21 Feb 2025 03:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fJIXdnMh"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB521EBFE6
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 03:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740107181; cv=none; b=uIu0Igu7JWqipTLzoyJVJSD9D9GjjVj5i3GhxtYowDQ9T+7SXo/3Dr5Bn8WdL0z/Sw/i3fe+bKanRPu2MGMa/j/EUiWpzJ8gnwCymWY8JpTkZMEtwe+T6eMoy+G3JxDRHnAOhSJsF8IZi1hQb4rgY9b/N9w5Z+A0M+SJjN46d+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740107181; c=relaxed/simple;
	bh=b6PLMBw7yyw15o3VEzosQAWxFJYLV5zXvl5ZUGHocbU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dSuHdrQA76ZXjBKJYOmCVY7nfcPsLXT1dP9mByJ87ynpWYOC0GX6+nAFiwgCQZBRwdtKbYX95AHHq8MXOCgWvF+yJD56pom0qTZbSr7C3uT6U/qFgFKvS8KFed2xZPofNZQz161eRFgGQUQLDBgSeD/BE0ZLUt9FtsWXXOjbNCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fJIXdnMh; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30a3092a9ebso18291761fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 19:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740107178; x=1740711978; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hf+01lWdYqM6cH2pf9TEQebVcTlfAkpm0nesnJVjo8c=;
        b=fJIXdnMhnFFRD7MiHalQg29wbAstLuu+0VUc2u1aA4KK0VsZnW/SLBt8863ph6InV2
         NNHIAucXAgzm2mjTCAzpLlN/RY7s8XrYO9EoRhjYAzSoCGsG8T4QNj+o6a/1IGrh4wYT
         m8WlfKRJfTMl4KRnBziHHLYynqtQH1yducUjdHdimnHCks/lnfDW1NuHOarolN+7Rzj0
         x7Vartn/NCd0MRKfwgUuof1vtkYtV/IMbONd8F0Elrb2ai4x331mMD3UsovnmQrDvCqw
         nRUDRUkEA7PoZf02CKEN9MZ0y4KqgjGkCVH5Rm/q0nethq21sqD+ztflzSLJgcTpl7aP
         Zy5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740107178; x=1740711978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hf+01lWdYqM6cH2pf9TEQebVcTlfAkpm0nesnJVjo8c=;
        b=Nq1tQkxoxpIlauoi/zDQDETDQ8lLnF+EoS/bcBnimYv/hfXPMXwa7tcvzBEIZNghWl
         sBbTxy3tZvec10qY5dHVjJ+jprT9JB1E//zbGHE5oVpO8jNqX4gLwMlKO0PM5kXk60Su
         yTnh9j5gEQ+zDoi4I9dozIJ9OivqitRBWPk+4rybTvqzp5JvTjam8Z2QpCHQRfAie00N
         EziYEIZ2p5GCMJYTVW2FzBH7tMFh1AJICvSGpoOHwaxWOO6zoWadAHcKXjXiZIqMN1ae
         ekAwbOcI1YWqUsIGjgEbjOIXCWi/3bGf+on1ZGPQFoeqh+m5NQgLuDRvICQqIlgjbUgA
         J4XA==
X-Forwarded-Encrypted: i=1; AJvYcCWfgZWI5ZmXMOveWKbDUDFmJKStE/QY8a82O32u7CrkTf89YFq/9ROQ69drNw7mGhpmQMed8JS20UFj4oQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxviWjQrhq46+fVQ9Ep0oTxP/Dpxz0C4SeReWYkeuMUjugyb1qm
	JMU8evmw3uMS69tKLZM9zQnXhouwbB9kB9Wt3Uaa/MrnFC2XjqlNl30v7MNqF/o=
X-Gm-Gg: ASbGncsDL8WcZMAZ2M0j1ZZHa/7v+WCivqbxcqQxH3sejZrqPVL+onUFy5pmnJqAFpS
	dQWrENojUE3huCKX+raWmIiCICe//AtBRBgsZaM8wztzJrkhUPmhUUX9wKMFLJOpEgy6hHcWNn3
	eShRTJqHxf9niY/jQozgQSXZfVvlWX9i/zZJIbhU5QGVGEoDE/bRMFRWCHdFltYiermNtJY+SPT
	uFMSjRTs7hTjlglMApJTylhQkNt+VIB+NQh0E2UmAjRWEChaS41gf5B/6L+wNf96tVg1AwsW3QV
	aJeumEMyouqJ4/2xyJdP5ZzqylQiYZkc7Pr3xGh6JwJD8ehn8zXRkX79VZ9IOQbAZDPB8A==
X-Google-Smtp-Source: AGHT+IFIkUTVECcUanvIgEQylzLf9cAeuyCvSYP0ViEN5AYii2FSHeNuyGSW+Wo3XvGPACfY4hAK+Q==
X-Received: by 2002:a2e:9dd1:0:b0:302:22e6:5f8 with SMTP id 38308e7fff4ca-30a5b1a0abbmr2867681fa.22.1740107177715;
        Thu, 20 Feb 2025 19:06:17 -0800 (PST)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00--782.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::782])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-30a2be45876sm16021071fa.68.2025.02.20.19.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 19:06:16 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 21 Feb 2025 05:06:04 +0200
Subject: [PATCH v2 5/6] arm64: dts: qcom: sar2130p: add PCIe EP device
 nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-sar2130p-pci-v2-5-cc87590ffbeb@linaro.org>
References: <20250221-sar2130p-pci-v2-0-cc87590ffbeb@linaro.org>
In-Reply-To: <20250221-sar2130p-pci-v2-0-cc87590ffbeb@linaro.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mrinmay Sarkar <quic_msarkar@quicinc.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2669;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=b6PLMBw7yyw15o3VEzosQAWxFJYLV5zXvl5ZUGHocbU=;
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnt+2b+vvnC24YRd+vl6st9IhT/q4OakLKzn3F1
 t8d/ehBxPaJAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZ7ftmwAKCRAU23LtvoBl
 uAF/EACctPzzgaDqLQSaaREFQA19W77YUO8fSLwo3g+BSjaRWIwdGGBwAYYblO6NDQbrbFBLBeR
 8eF7IJ8kUlXvnyu4KSXXIgnDBBz/WLUuMTMRnpceYGLb6tyTDwD0Xud9/6KLl4MUSMPB1wEAZuq
 46ejpKeBjz+WebjjgGHhJBTJENBluVHXQxAmY775Xz4kzri80ApF2jPAp+r01yDYx3/pT9x+ssa
 WjwgRG5QcB9Bk6RL4HtvK67DeDuIOmlcNr/LiByWzyHdCjKGciVB4wU+rmOeQqX1OVrHR8nN17E
 RGpX+V/T/aTMo5brQIb7qpppdLjQYIbqavISKKvkffR9xNsNJoMC+qfXrfsGWeSTW+WJB6gYagz
 83JFjAlhFRv020J13Xo37JZih7UakHZqu+OPRTLv037h5WCuMsGpI9S4RwzMrmqr3eQmVvCqi31
 mi7tozjx5CIq01SxleumvS+dGtxZEgmMg8i50tUkYZZkoB6piCFSpGjhESpdIMoMqBzJPB/Zdqr
 lWJwJvnj7ZuvqyNWkmNgwglr5yzaL+JxPo7VVpjmPaiDRzKSzMd85Rr2JV+55MC18H3REqLbJlW
 uIgAW70fhj9sjmdql0B0oJ49fFyXkTnkckt4NRoNfGMJSpRpui/adCnNj5hMuLxlsJ/Jnv8p+MY
 zcyXB9UJ+LWiNjg==
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

On the Qualcomm AR2 Gen1 platform the second PCIe host can be used
either as an RC or as an EP device. Add device node for the PCIe EP.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/sar2130p.dtsi | 61 ++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sar2130p.dtsi b/arch/arm64/boot/dts/qcom/sar2130p.dtsi
index dd832e6816be85817fd1ecc853f8d4c800826bc4..b45e9e2ae0357bd0c7d719eaf4fc1faa1cf913f2 100644
--- a/arch/arm64/boot/dts/qcom/sar2130p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sar2130p.dtsi
@@ -1474,6 +1474,67 @@ pcie@0 {
 			};
 		};
 
+		pcie1_ep: pcie-ep@1c08000 {
+			compatible = "qcom,sar2130p-pcie-ep";
+			reg = <0x0 0x01c08000 0x0 0x3000>,
+			      <0x0 0x40000000 0x0 0xf1d>,
+			      <0x0 0x40000f20 0x0 0xa8>,
+			      <0x0 0x40001000 0x0 0x1000>,
+			      <0x0 0x40200000 0x0 0x1000000>,
+			      <0x0 0x01c0b000 0x0 0x1000>,
+			      <0x0 0x40002000 0x0 0x2000>;
+			reg-names = "parf",
+				    "dbi",
+				    "elbi",
+				    "atu",
+				    "addr_space",
+				    "mmio",
+				    "dma";
+
+			clocks = <&gcc GCC_PCIE_1_AUX_CLK>,
+				 <&gcc GCC_PCIE_1_CFG_AHB_CLK>,
+				 <&gcc GCC_PCIE_1_MSTR_AXI_CLK>,
+				 <&gcc GCC_PCIE_1_SLV_AXI_CLK>,
+				 <&gcc GCC_PCIE_1_SLV_Q2A_AXI_CLK>,
+				 <&gcc GCC_DDRSS_PCIE_SF_CLK>,
+				 <&gcc GCC_AGGRE_NOC_PCIE_1_AXI_CLK>,
+				 <&gcc GCC_CFG_NOC_PCIE_ANOC_AHB_CLK>,
+				 <&gcc GCC_QMIP_PCIE_AHB_CLK>;
+			clock-names = "aux",
+				      "cfg",
+				      "bus_master",
+				      "bus_slave",
+				      "slave_q2a",
+				      "ddrss_sf_tbu",
+				      "aggre_noc_axi",
+				      "cnoc_sf_axi",
+				      "qmip_pcie_ahb";
+
+			interrupts = <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 440 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "global",
+					  "doorbell",
+					  "dma";
+
+			interconnects = <&pcie_noc MASTER_PCIE_1 QCOM_ICC_TAG_ALWAYS
+					 &mc_virt SLAVE_EBI1 QCOM_ICC_TAG_ALWAYS>,
+					<&gem_noc MASTER_APPSS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
+					 &config_noc SLAVE_PCIE_1 QCOM_ICC_TAG_ACTIVE_ONLY>;
+			interconnect-names = "pcie-mem",
+					     "cpu-pcie";
+			iommus = <&apps_smmu 0x1e00 0x1>;
+			resets = <&gcc GCC_PCIE_1_BCR>;
+			reset-names = "core";
+			power-domains = <&gcc PCIE_1_GDSC>;
+			phys = <&pcie1_phy>;
+			phy-names = "pciephy";
+
+			num-lanes = <2>;
+
+			status = "disabled";
+		};
+
 		pcie1_phy: phy@1c0e000 {
 			compatible = "qcom,sar2130p-qmp-gen3x2-pcie-phy";
 			reg = <0x0 0x01c0e000 0x0 0x2000>;

-- 
2.39.5


