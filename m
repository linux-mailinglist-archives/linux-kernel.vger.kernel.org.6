Return-Path: <linux-kernel+bounces-531251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F340A43E1F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:47:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9EAC17152A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B1B267B8B;
	Tue, 25 Feb 2025 11:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="F6dfTcNz"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48AE268C77
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483962; cv=none; b=ajE39bU4kWiKC5I0bOao6oL9JBR2jvpVYgKz22nho35DPvM6SRr4o9G3Wg5JDHVcgAgAapwTOD5uSRX5fcCpgkIYSbgyhSB9cf82dF3KrXq6re9HXOji+jBhvz8ecyYtQ8UWeVLQN1ZaFQwMzdkf2ouv1DLJcL9HTUVylsGbsKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483962; c=relaxed/simple;
	bh=pFcdNrDAhL7Xbm6OQtksZi4cGoUNQlf9iCCnxA9zgpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ieZx7hpyouE4VFa4dCqvqw+OOruTVoW0ToDcVCrx+ZBloJITFBCFWVuYMHT6XgKGQnUwPzzYJdF0m3dz81iJkFi7VF0DuvTI6pxSfKMJk38dqL+p7Ok+1rKS2cIhmb12v2k70sUs2iO2O4BuNjl9UChLlbDkij+D1SszAkOSSbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=F6dfTcNz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P8BqNF009763
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:46:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EJcYMRyGQkw8QY2ncGIv3icP3Wer3n1fNhPc10KzWt0=; b=F6dfTcNzyhR7IBut
	OCNnxSm+xVEQcV34HRqx8/9GqJFBSjqTznHjhQWc6vGUoasibMdntp/Jy97daygU
	XD2MXUyVDgU1mOZJ1AYWOoORoYDahyB4uD4YnEOIuTgMgvtYcg+IHZSBeoplVONr
	1noOs9alMO0yibdRCgwJakn5iQ90xRUpXWrvC6CN4ZdvZu5+k5MSsUkjIdRSnzax
	HqqPpDd/fhQI/+g7gMMJ2xFmhC/SadAcXQSsyl3x5n9EWcXn4qqUHWIpFKV0uTmg
	aljOu5roQJ7wmtKKpr5kL8b1ALD0OZdV7GK+sGvZjsw4guy9AX89zc3+1tM5meGx
	JFoB2w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y3xngydv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:45:59 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-220ee2e7746so113518685ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:45:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740483958; x=1741088758;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJcYMRyGQkw8QY2ncGIv3icP3Wer3n1fNhPc10KzWt0=;
        b=R1HhqHk691+34OYgqFOHbpbzlYylYKQk6ovzlYfA5iBBuLS1ddCuQPfKr1HR7j2aBO
         oMgIivsut6+GCAcsOCLW2uxweuPtFViTSWOVOvEsEOTtig5YZhHM7VgcYmBKj4iCjnvI
         nb2m16A8d5K9hOs2mktIYccqnIQPId9sePne9ssknacTsEEjzVq98K2VJoOraj7DEVjZ
         Cs/vNO59mXwZvje0Rqbs5tyculZotzTJ2+VyWThaxicfCe3zNZ2dST+JlCPnFkYxNqU6
         Csc2ngshp9RhOeOwt8UhxoZutxfxApRS/HDFzm1Yf/26LmhcUhzUpmYoqkBAwxQyQw3u
         ve6A==
X-Forwarded-Encrypted: i=1; AJvYcCWj1aluYg4ouVDpkZYaf5HeUAouHLf92Hz3yG7iCQRXszl8L9rAkNpmcxV0fQypnnviwcBZ4eH1uP5Nznc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh5dOePghPmeJCkg4VXGbIiBK1eR6M/tTaiXfEhx3nzmaMKvzO
	ymceiMa0+32sK6T/UrIDL5Budm+UIeELKyTKHIj0EMCqbslTImv0KIEFVKVGa9SldP0BoiQu+eF
	OTlWlFUpXfb7o7QF8k48G2ovoHbdwfKxqJS2QCkxjjTMLmj5WuUm0m7TpW4SmXFg=
X-Gm-Gg: ASbGncukcmcqCHTjHVCJAo/1phqmSPL5OiasXCqX9xNruWpCngGbRJaHxyyyEz6N1ZL
	2ObXPrNBxMsP9431VCX3L2oytzzBT7rkqt/XT4BAu5+0ncHGhwhEMzRxlIXtol8lEmTfIDo0m+e
	eXZ+PBbEdb5R2BlDJAg14eeyOVyyNMYA1ZokgPs7jXzVvWxyMXWVY2nO5hIVDtdEcSjXbqFCSHb
	rSXeoHM2rbReXydKZ6Zsdft7LXooaJUoGkQAUPUmJ5Tb6tr6nbIkiaOBd/tgdpn7SBWcSm/0mz7
	6XTp9lbD0G9BKZ0lX2psBEacjlFZYG2zsjnhkeqAZJuhHE4DuBI=
X-Received: by 2002:a05:6a00:22c5:b0:732:2170:b6a3 with SMTP id d2e1a72fcca58-73426d963b2mr30573989b3a.21.1740483958281;
        Tue, 25 Feb 2025 03:45:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvHfsK827INp2OUOpMhbFB5TykPzqPp/lSDZEx2IWzQtTO3rjE9E3N8V1y2Pm2T7ObYclovw==
X-Received: by 2002:a05:6a00:22c5:b0:732:2170:b6a3 with SMTP id d2e1a72fcca58-73426d963b2mr30573954b3a.21.1740483957820;
        Tue, 25 Feb 2025 03:45:57 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a7f9bb1sm1331790b3a.92.2025.02.25.03.45.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 03:45:57 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 25 Feb 2025 17:15:07 +0530
Subject: [PATCH v7 4/4] PCI: dwc: Add support for configuring lane
 equalization presets
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-preset_v6-v7-4-a593f3ef3951@oss.qualcomm.com>
References: <20250225-preset_v6-v7-0-a593f3ef3951@oss.qualcomm.com>
In-Reply-To: <20250225-preset_v6-v7-0-a593f3ef3951@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_mrana@quicinc.com, quic_vbadigan@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740483933; l=5105;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=pFcdNrDAhL7Xbm6OQtksZi4cGoUNQlf9iCCnxA9zgpc=;
 b=BV/ghXP6XY1A4XML0m8XYu8Z0skAAgZIgIjY6gWhoPZplTS7w7dxIEWCxpU8tGv3fzSgbEHnC
 LE7AYc9lT2vAjc6f9b+Ag39P/ZCZt/s4+asJwyGGYbx92+UFd9noapw
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: MH7X0g1sZQvkdq6HIsyEcbk36rOWZzao
X-Proofpoint-GUID: MH7X0g1sZQvkdq6HIsyEcbk36rOWZzao
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 malwarescore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502250082

PCIe equalization presets are predefined settings used to optimize
signal integrity by compensating for signal loss and distortion in
high-speed data transmission.

Based upon the number of lanes and the data rate supported, write
the preset data read from the device tree in to the lane equalization
control registers.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 66 +++++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h      |  3 ++
 include/uapi/linux/pci_regs.h                     |  3 ++
 3 files changed, 72 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index dd56cc02f4ef..ea596119de92 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -507,6 +507,10 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (pci->num_lanes < 1)
 		pci->num_lanes = dw_pcie_link_get_max_link_width(pci);
 
+	ret = of_pci_get_equalization_presets(dev, &pp->presets, pci->num_lanes);
+	if (ret)
+		goto err_free_msi;
+
 	/*
 	 * Allocate the resource for MSG TLP before programming the iATU
 	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
@@ -808,6 +812,67 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 	return 0;
 }
 
+static void dw_pcie_program_presets(struct dw_pcie_rp *pp, enum pci_bus_speed speed)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	u8 lane_eq_offset, lane_reg_size, cap_id;
+	u8 *presets;
+	u32 cap;
+	int i;
+
+	if (speed == PCIE_SPEED_8_0GT) {
+		presets = (u8 *)pp->presets.eq_presets_8gts;
+		lane_eq_offset =  PCI_SECPCI_LE_CTRL;
+		cap_id = PCI_EXT_CAP_ID_SECPCI;
+		/* For data rate of 8 GT/S each lane equalization control is 16bits wide*/
+		lane_reg_size = 0x2;
+	} else if (speed == PCIE_SPEED_16_0GT) {
+		presets = pp->presets.eq_presets_Ngts[EQ_PRESET_TYPE_16GTS];
+		lane_eq_offset = PCI_PL_16GT_LE_CTRL;
+		cap_id = PCI_EXT_CAP_ID_PL_16GT;
+		lane_reg_size = 0x1;
+	} else {
+		dev_WARN_ONCE(pci->dev, 1, "Not supported data rate %s\n",
+			      pci_speed_string(speed));
+		return;
+	}
+
+	if (presets[0] == PCI_EQ_RESV) {
+		dev_WARN_ONCE(pci->dev, 1,
+			      "Lane equalization preset properties are missing for %s\n",
+			      pci_speed_string(speed));
+		return;
+	}
+
+	cap = dw_pcie_find_ext_capability(pci, cap_id);
+	if (!cap)
+		return;
+
+	/*
+	 * Write preset values to the registers byte-by-byte for the given
+	 * number of lanes and register size.
+	 */
+	for (i = 0; i < pci->num_lanes * lane_reg_size; i++)
+		dw_pcie_writeb_dbi(pci, cap + lane_eq_offset + i, presets[i]);
+}
+
+static void dw_pcie_config_presets(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	enum pci_bus_speed speed = pcie_link_speed[pci->max_link_speed];
+
+	/*
+	 * Lane equalization needs to be perfomed for all data rates
+	 * the controller supports and for all supported lanes.
+	 */
+
+	if (speed >= PCIE_SPEED_8_0GT)
+		dw_pcie_program_presets(pp, PCIE_SPEED_8_0GT);
+
+	if (speed >= PCIE_SPEED_16_0GT)
+		dw_pcie_program_presets(pp, PCIE_SPEED_16_0GT);
+}
+
 int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -861,6 +926,7 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
 	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
 
+	dw_pcie_config_presets(pp);
 	/*
 	 * If the platform provides its own child bus config accesses, it means
 	 * the platform uses its own address translation component rather than
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 61d1fb6b437b..30ae8d3f4282 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -25,6 +25,8 @@
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
 
+#include "../../pci.h"
+
 /* DWC PCIe IP-core versions (native support since v4.70a) */
 #define DW_PCIE_VER_365A		0x3336352a
 #define DW_PCIE_VER_460A		0x3436302a
@@ -381,6 +383,7 @@ struct dw_pcie_rp {
 	int			msg_atu_index;
 	struct resource		*msg_res;
 	bool			use_linkup_irq;
+	struct pci_eq_presets	presets;
 };
 
 struct dw_pcie_ep_ops {
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 3445c4970e4d..2cd20170adb4 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -1140,6 +1140,9 @@
 #define PCI_DLF_CAP		0x04	/* Capabilities Register */
 #define  PCI_DLF_EXCHANGE_ENABLE	0x80000000  /* Data Link Feature Exchange Enable */
 
+/* Secondary PCIe Capability 8.0 GT/s */
+#define PCI_SECPCI_LE_CTRL	0x0c /* Lane Equalization Control Register */
+
 /* Physical Layer 16.0 GT/s */
 #define PCI_PL_16GT_LE_CTRL	0x20	/* Lane Equalization Control Register */
 #define  PCI_PL_16GT_LE_CTRL_DSP_TX_PRESET_MASK		0x0000000F

-- 
2.34.1


