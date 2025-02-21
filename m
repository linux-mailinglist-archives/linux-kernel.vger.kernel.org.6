Return-Path: <linux-kernel+bounces-526080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABC57A3F99F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 16:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F252D1703C4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 15:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C0A21170E;
	Fri, 21 Feb 2025 15:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YCn26tSX"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2038F2101AD
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153137; cv=none; b=IOOOCw3sjQ+01oSAdjcXIT3BXkoabLtLWW0UF/8AE6BDwEF6dwlCEkg8eRIJ7zFzId26uahwATHva2NTHMpXcSKzTLz9ffF23tvw2mto6s3St0x8Mpy10SsiQe/mc4UArYC8YgmEgBNpXohTuw+Yil3e+IjGyrtdihgwT/BJmeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153137; c=relaxed/simple;
	bh=b6PLMBw7yyw15o3VEzosQAWxFJYLV5zXvl5ZUGHocbU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fIOD6qHGwxWW/2sSiv5tKkCXXvnfFC3rySI1HocyB2NQrtDsZpSZvyaU1IZCxfvdZ2tBnXxQpOL+I6QRYwSXmC/NeJKsvV9904LnjGGXcl1hBgS8yLX4sMaBIXXT3NjHQ2RCrgfP7Fy6pe/AYDx6j0HGvkL60qo5SMg/0F0PMZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YCn26tSX; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5452c2805bcso2541505e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 07:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740153133; x=1740757933; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hf+01lWdYqM6cH2pf9TEQebVcTlfAkpm0nesnJVjo8c=;
        b=YCn26tSXCcwF6annzF5tNuwe1dCHTDxDmuGKB9btWOkBwM/wmqFbtJTdmDzAQsyDa2
         RSnOTW2md5sE03r0wl96TmPoGYH8iDmi9FvbAOWLKx9aL9NunCeWPMcuG0ZnDhAYrHVr
         xEubhfUWnc7jvPjbQlAkTn888vuGxsatnJSLGDNACXb4IG5zm7RU3I5xuOIDc7ge0JMm
         GUycSvv8ASAWoMDLJxSwBjghQm6uo8GkLJgkV7H+ig+l0QreQro05oFw+qMH5zOUuguz
         MtArvEeQiVFr7Wi+XJdQpFmeQ46PmT0O2xRJlQg3yxlaraivCJzEx9I3Eg7z+2qrTets
         1Z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740153133; x=1740757933;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hf+01lWdYqM6cH2pf9TEQebVcTlfAkpm0nesnJVjo8c=;
        b=E66uUveFhYswDpwsVM2QKc/W1eCUaiulz9lBomdRIhWND0NUQVlbgfNUHyIe6Gv1GG
         cMdMRJl1/8oifmbvPd/0DE6kRXqTIRd/VZr4NB9C1o20dw4qzzyeraVD1SQBjIptvbO6
         lHZTsTvO4cT8KkSvuvTS68/8HDYJPTF6c1sBstdl1HihOOxoOAsomLmACqLbnXk03Z5H
         UJAFlsi0hQTpqNjhT3D0KwF1Mwt8bG2r7mRRp7n+pB1S/J87D/IbRPmuqxxgJw/eYQnk
         kObXwiSMWsoYtr0Tj89aUKAS7loL50jY20jBDup1mmdDedE7ZcUU2S28l1d4zwOM/Qa3
         bi0w==
X-Forwarded-Encrypted: i=1; AJvYcCVnRxOKcK9llDFpVhYxdMZF3I+mYEnpsxV7cxzXdidpN0VGSsKYCU5Pf8xBXJSNFYZa4qktR89ydZYM2U0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDcglYfCVuDTT80QXStOb6QTXMf5GTjjJ1CgYG0YiyWofvcoMI
	wwE/vi9ChEhRHMmkQSZ+BAeaof8LcE2unCYR1RLEEQRMBovqYVoTSW3ffP+bPMc=
X-Gm-Gg: ASbGnctVkms1H248qmKnrZ1YOfAGUa+F50QDMTeV83PObWmtVsKaWboNzOBZY4ot2An
	jVcop0+bgM0gr37Zh3AYHy6QwdwevaCRQJ+IH1/CH/FQCvvI1XCzoEkevIgYOyTkYf8mZh7xl6G
	nJ7WQ/GXH0oZ25HAaDfpLxfYJduZ3iHs7LWkHCrevXVi1wUocBI7MiCK+UADNH51X2iXGGjgYRF
	Bin8hehLYJ3Z1RAxFbIaBnJx0dO7/56gIIfjjOkTZPwPTfYajfXRB6UNXASQDYJriY06C8fBrOz
	ujgsLGYNksAI5+yFIAeA1Sd0KwhK44uPmt8L9L1jd0+LmiBKeTFb567OIE8h1j537g729g==
X-Google-Smtp-Source: AGHT+IFK/BW6WRfk5AFZvJoLcO2PKHdti1399J++2O52dSFTn5Nhq5RV0d2Y2l04B0b9I6MXTb11ag==
X-Received: by 2002:a05:6512:2354:b0:544:ca1:da41 with SMTP id 2adb3069b0e04-54838f78dbemr1431389e87.44.1740153133477;
        Fri, 21 Feb 2025 07:52:13 -0800 (PST)
Received: from [127.0.1.1] (2001-14ba-a0c3-3a00--782.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::782])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54816a55851sm287643e87.27.2025.02.21.07.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 07:52:13 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 21 Feb 2025 17:52:05 +0200
Subject: [PATCH v3 7/8] arm64: dts: qcom: sar2130p: add PCIe EP device
 nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-sar2130p-pci-v3-7-61a0fdfb75b4@linaro.org>
References: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org>
In-Reply-To: <20250221-sar2130p-pci-v3-0-61a0fdfb75b4@linaro.org>
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
 b=owEBbQKS/ZANAwAKARTbcu2+gGW4AcsmYgBnuKEiLu4pfIYUZYk2R0MP9UobeotuKgNJ4Vvhf
 444qj3IgI6JAjMEAAEKAB0WIQRdB85SOKWMgfgVe+4U23LtvoBluAUCZ7ihIgAKCRAU23LtvoBl
 uOVzD/4wumWgTSyYzm8guT77vJxWxEvDxLtib6B0StQvn1OelUa5kd2rD9mt7iDV+uuxqVEcu5J
 QhjoQl99UqfezKsMhYiHN15aeVKVzP4c+ZDss+vog1iokW87cyNooH1Uk3uWoEA0mKeY0pXh8EJ
 1Ouf5D16bMD/KaanyXnQzLLy9uvx4hA7cIQIgrvyG6calt+vBYuZhzZ40Z6wzcsVMYQ1rthHEk5
 j5mNBXQb5eDQBdNSHJKB2pGMGxGQ5GsKlEodn2d092CeJop68Uni6wkmeycN5z8xLKZQjddi8Fa
 POLMzqLshMH5iHi477NCBWq4xmi/2xCxRUSmvCHTrQs/dgmQcb/jUTOSHicGmANOPXF9Oz4Mtjs
 QQwjryHC+bm8MkZOeR0JuP2TDL98czDcyqbsKs6GM7wZVEMOXgl3d1NjwpxuRGi0H3ZNcADhAtL
 SxpzxUrQ8rm/G0DZEOM+jKDaYecYlTbtrB8auPz1PweNuwpnfCkSoa7yuDltN3nyjU8zvoUm3O+
 iprtfdKlHMgK50sk7Tj1WxRvS2pyjn5bZfDNsB3ued59hZV6LKRIMwcFwP0I4s2KKoiDpPN5sHs
 0CKDHCzGjo7AeniTpfUqYKbMYvEFbmdmF2Uv5fDTi2slzoSbq4pxOMnR5i7oa4xwfAjD7b6UhZo
 Af2oEnk+Vto7skg==
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


