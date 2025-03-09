Return-Path: <linux-kernel+bounces-552906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3813FA580DA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 06:48:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12AF23A3349
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 05:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C066195B37;
	Sun,  9 Mar 2025 05:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JwBv9OAw"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1E0195FE8
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 05:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741499209; cv=none; b=FypJP9LgB1P9GMIhETmb1hLHd39J8IzNHdj9NZBWAwymuB0n8QbR5xi6Hu+yXPZFkcwQxc1itAqn4MKOoUNXY0Uvz7rs1S9BMJ1joiLbvxlfZA1eLDCTKXvGBcX7xcd66AhD4OHy+8yTg0XFrBwMCZBqtFXEyckhCQCWo8iC+eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741499209; c=relaxed/simple;
	bh=sEcZFHTUzdOTAZzu2vqRCbTaZ+x+54x0/4maTU/qWnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WIoRBWvkUbIv4riztA2grJ9vQP7ApXoAvvB0Bvi/A2ygO1Kx9SSxWl2N0kghEycnpFrgzXtUARAJPpTFbB3j9XaG5Rro7FlaVNKcOsNirKtEIbxrUGKq6/kWN0F0ZHO7hufP0q/xZTRctzRDhsrjakQZCw3AZf6yBpa7dfVjiGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JwBv9OAw; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5295Nm62013133
	for <linux-kernel@vger.kernel.org>; Sun, 9 Mar 2025 05:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bQX8qVQEqQwhroXZXpd1fC1SeUQiRpTsY8ImuDvpfek=; b=JwBv9OAwYBqAbAXa
	J9ik5yUQYDWMdb4cRB6P2s5sr2MvIq3R/W5pXLC6VXunW48SNK6AjMQ0mp92CJuD
	t1Rv8UFLgAfdH6NgYL/C/CZ0i2XeRa5XZapC5oC48/oR3a4GyQX57QA5CtgNmmW0
	WPOZaKL56znzmzjmCwY4JBS84N1RwP0Sfx2sbbRzyFcYekoTRvV2OQsmXF6pPUAB
	BYxgEROR6KHE2Gok7dYnVzg3Y7f9ifRCoUNeTJ6wesC7IOYGhDNn8+Pf5fW+rBlq
	eTqxVdUPbHCDe4w17tXG9T+DkaAjQwjahRnJ/wKInZxvWaR9xaOe23P37U7igyc3
	XxEzYQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458ex0sqb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 05:46:47 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2242f3fd213so27464215ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Mar 2025 21:46:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741499206; x=1742104006;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQX8qVQEqQwhroXZXpd1fC1SeUQiRpTsY8ImuDvpfek=;
        b=mNsD68FnViZtydk/+f9PQkGE8mfuldUiolUNncH0e/qe1juliazk4xyFvrh+0R4wWE
         V1oV/vK8jsbQhRK1xLGnXsP5i3sygXcPOFBidIFAuXNq9W3jEFYZfpM3vfHLV9plByte
         KGaY8aimcwuH8bS9sNhoH/DOHfgogMwZswtzAqsBh0IKvwucA/NyoC88IWSbN6Eg5fk7
         OcoQwzSjpVI9p6nCmIryqVp3KUHhDChdD2Qlvlgv60HOH5ZCorlcjFV0Qm4waP40Ovz6
         mc1O7JioNO8bV0y75/h1bFgMz0WpKUgzeg0xnWCnCh4y6DGjkTnkkUrms4hjCVs/artU
         sfOw==
X-Forwarded-Encrypted: i=1; AJvYcCVfhgH+vEMhE8vprbGQH9X2kj3+yrYYLkwDT1LtVbRYKeEV74W7vEfbqtmeWc+ZN48OvBrDYXcci7LhGDY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/5nh1T+n/RvOzwGwINK781etfMGBaPu4KHClrbD5j2E4AMPOZ
	Y8n6y+lbecRKwiMMWm+QBW0Smypesk3u3pkRrsBULWfRSM7sI72cYFg4TshictOeVsb5CT6Pkpa
	jgH55tt0HCVjq+N4ScXWheoVZA7vU9XLAXGbadF16u0rA4bP2dK260pyKEY/GNIc=
X-Gm-Gg: ASbGnctA/FSRgFcoDsVf2qNbYmbd2PVq0NUKoh6ozrgerqWmqJKXZta7D0Uz/1Y00EK
	WLFBp1+aRKDp8UuuaUuwbQlbeCJFK6zTF7m336v3LDAwfMYeZRRzonPqn8zJ7Ty3pP0dRwvSW8b
	2Qyg9NpVYJwHumQhj3Feft1RX8ggpLHL0ZY+oPHBxloQOJ5Z9nyVnx9kPhgtrgHMvmlB0ukriLV
	8HLcB6uuy7QOf72AGUVr+eWU9GtCd5Ua4E5UKHHn8N82E31Qw1NJRqHuxu1Swgpm9++pkVNTY9a
	+furbVxfYmP3IIBQVZ/zGk2saST0cZeP/HfK5xQmZrCmd+bdQ34=
X-Received: by 2002:a17:902:da84:b0:224:10a2:cae7 with SMTP id d9443c01a7336-22428c057cemr176811095ad.40.1741499205696;
        Sat, 08 Mar 2025 21:46:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECJeYnA+nsUD+o/eqnm4QtvsRdhmKFL8Q+7mFkXSS4GdY8aPxKPCskNUDwUo9BRavJxDnd1g==
X-Received: by 2002:a17:902:da84:b0:224:10a2:cae7 with SMTP id d9443c01a7336-22428c057cemr176810675ad.40.1741499205331;
        Sat, 08 Mar 2025 21:46:45 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-224109ddbe7sm54887145ad.32.2025.03.08.21.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 21:46:44 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Sun, 09 Mar 2025 11:15:29 +0530
Subject: [PATCH v5 7/7] PCI: qcom: Add support for ECAM feature
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250309-ecam_v4-v5-7-8eff4b59790d@oss.qualcomm.com>
References: <20250309-ecam_v4-v5-0-8eff4b59790d@oss.qualcomm.com>
In-Reply-To: <20250309-ecam_v4-v5-0-8eff4b59790d@oss.qualcomm.com>
To: cros-qcom-dts-watchers@chromium.org,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_mrana@quicinc.com,
        quic_vpernami@quicinc.com, mmareddy@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741499159; l=5409;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=sEcZFHTUzdOTAZzu2vqRCbTaZ+x+54x0/4maTU/qWnM=;
 b=Hf6ymgF00bE2KFsDVcS36WMgOqoJSOXu97ObSuEfqieJtzHX2tNxi+qIlGhK2zOamXPPDnWfs
 aLfNgw0nCItC8hCza4NPVivk2X0//WHCGuWnjv31ObgWsMPeMbTwtjZ
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: fGxVXXjLQkFms0LJi-5A3siQdeDp0C4l
X-Authority-Analysis: v=2.4 cv=f/qyBPyM c=1 sm=1 tr=0 ts=67cd2b47 cx=c_pps a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=oQbQ34n3Jerzy_GFPTkA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: fGxVXXjLQkFms0LJi-5A3siQdeDp0C4l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-09_02,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=999 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503090043

The ELBI registers falls after the DBI space, PARF_SLV_DBI_ELBI register
gives us the offset from which ELBI starts. so use this offset and cfg
win to map these regions.

On root bus, we have only the root port. Any access other than that
should not go out of the link and should return all F's. Since the iATU
is configured for the buses which starts after root bus, block the
transactions starting from function 1 of the root bus to the end of
the root bus (i.e from dbi_base + 4kb to dbi_base + 1MB) from going
outside the link through ECAM blocker through PARF registers.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 64 ++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 258b2d615080..c34c0edd225f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -52,6 +52,7 @@
 #define PARF_AXI_MSTR_WR_ADDR_HALT_V2		0x1a8
 #define PARF_Q2A_FLUSH				0x1ac
 #define PARF_LTSSM				0x1b0
+#define PARF_SLV_DBI_ELBI			0x1b4
 #define PARF_INT_ALL_STATUS			0x224
 #define PARF_INT_ALL_CLEAR			0x228
 #define PARF_INT_ALL_MASK			0x22c
@@ -61,6 +62,17 @@
 #define PARF_DBI_BASE_ADDR_V2_HI		0x354
 #define PARF_SLV_ADDR_SPACE_SIZE_V2		0x358
 #define PARF_SLV_ADDR_SPACE_SIZE_V2_HI		0x35c
+#define PARF_BLOCK_SLV_AXI_WR_BASE		0x360
+#define PARF_BLOCK_SLV_AXI_WR_BASE_HI		0x364
+#define PARF_BLOCK_SLV_AXI_WR_LIMIT		0x368
+#define PARF_BLOCK_SLV_AXI_WR_LIMIT_HI		0x36c
+#define PARF_BLOCK_SLV_AXI_RD_BASE		0x370
+#define PARF_BLOCK_SLV_AXI_RD_BASE_HI		0x374
+#define PARF_BLOCK_SLV_AXI_RD_LIMIT		0x378
+#define PARF_BLOCK_SLV_AXI_RD_LIMIT_HI		0x37c
+#define PARF_ECAM_BASE				0x380
+#define PARF_ECAM_BASE_HI			0x384
+
 #define PARF_NO_SNOOP_OVERIDE			0x3d4
 #define PARF_ATU_BASE_ADDR			0x634
 #define PARF_ATU_BASE_ADDR_HI			0x638
@@ -84,6 +96,7 @@
 
 /* PARF_SYS_CTRL register fields */
 #define MAC_PHY_POWERDOWN_IN_P2_D_MUX_EN	BIT(29)
+#define PCIE_ECAM_BLOCKER_EN			BIT(26)
 #define MST_WAKEUP_EN				BIT(13)
 #define SLV_WAKEUP_EN				BIT(12)
 #define MSTR_ACLK_CGC_DIS			BIT(10)
@@ -293,6 +306,48 @@ static void qcom_ep_reset_deassert(struct qcom_pcie *pcie)
 	usleep_range(PERST_DELAY_US, PERST_DELAY_US + 500);
 }
 
+static void qcom_pci_config_ecam(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	u64 addr, addr_end;
+	u32 val;
+
+	/* Set the ECAM base */
+	writel_relaxed(lower_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE);
+	writel_relaxed(upper_32_bits(pci->dbi_phys_addr), pcie->parf + PARF_ECAM_BASE_HI);
+
+	/*
+	 * The only device on root bus is the Root Port. Any access to the PCIe
+	 * region will go outside the PCIe link. As part of enumeration the PCI
+	 * sw can try to read to vendor ID & device ID with different device
+	 * number and function number under root bus. As any access other than
+	 * root bus, device 0, function 0, should not go out of the link and
+	 * should return all F's. Since the iATU is configured for the buses
+	 * which starts after root bus, block the transactions starting from
+	 * function 1 of the root bus to the end of the root bus (i.e from
+	 * dbi_base + 4kb to dbi_base + 1MB) from going outside the link.
+	 */
+	addr = pci->dbi_phys_addr + SZ_4K;
+	writel_relaxed(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE);
+	writel_relaxed(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_WR_BASE_HI);
+
+	writel_relaxed(lower_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE);
+	writel_relaxed(upper_32_bits(addr), pcie->parf + PARF_BLOCK_SLV_AXI_RD_BASE_HI);
+
+	addr_end = pci->dbi_phys_addr + SZ_1M - 1;
+
+	writel_relaxed(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT);
+	writel_relaxed(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_WR_LIMIT_HI);
+
+	writel_relaxed(lower_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT);
+	writel_relaxed(upper_32_bits(addr_end), pcie->parf + PARF_BLOCK_SLV_AXI_RD_LIMIT_HI);
+
+	val = readl_relaxed(pcie->parf + PARF_SYS_CTRL);
+	val |= PCIE_ECAM_BLOCKER_EN;
+	writel_relaxed(val, pcie->parf + PARF_SYS_CTRL);
+}
+
 static int qcom_pcie_start_link(struct dw_pcie *pci)
 {
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
@@ -302,6 +357,9 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
 		qcom_pcie_common_set_16gt_lane_margining(pci);
 	}
 
+	if (pci->pp.ecam_mode)
+		qcom_pci_config_ecam(&pci->pp);
+
 	/* Enable Link Training state machine */
 	if (pcie->cfg->ops->ltssm_enable)
 		pcie->cfg->ops->ltssm_enable(pcie);
@@ -1233,6 +1291,7 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+	u16 offset;
 	int ret;
 
 	qcom_ep_reset_assert(pcie);
@@ -1241,6 +1300,11 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
 	if (ret)
 		return ret;
 
+	if (pp->ecam_mode) {
+		offset = readl(pcie->parf + PARF_SLV_DBI_ELBI);
+		pci->elbi_base = pci->dbi_base + offset;
+	}
+
 	ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
 	if (ret)
 		goto err_deinit;

-- 
2.34.1


