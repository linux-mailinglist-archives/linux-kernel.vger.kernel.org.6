Return-Path: <linux-kernel+bounces-531250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F91DA43E1A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 12:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3804518851F5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 11:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650F7268C67;
	Tue, 25 Feb 2025 11:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pNxv1FZD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116A3267B93
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740483958; cv=none; b=W8yzK+Isho0gxUU31Q9aN1aEr5WBDqbgUBtq55Pbnj3zvyqJDxjpwWj6aRHCFuShVle42pTwMF3MPAF/5Rw7qPmNJGmW3ZkxQiSHg/E9/GX/KXt3iSB4B8K0vFhbsmj73gHjUAA2WUnQMtW0A/x30E6DW+2gLDlU3yOgqZk+Sl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740483958; c=relaxed/simple;
	bh=u4stSlHqt6SDmbNCOygNp94BXAp7R4cdNbXp5bogHOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KQdi3K2OvTdpuCJqDXRsa9uWRsjmr/cu+0H26713jkPqbaBMJ3/QmibvoFevpXAMKdQjrm7O70yvIUWDtI8CbwSHIlYOGzIo+ZD7212auVKjxxEcXZpgsirK4QcTjeqeogpgUM7j1kVi3MnHCyG9DJizEQoOuudomk5CHioAly0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pNxv1FZD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P8opiY017279
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CL0lc3FSdVBtQAJZpLV5Pqt/+P+vvC1pRH/Z+SNoYHk=; b=pNxv1FZDgM6TnQ1b
	mK81TmbDhW/rQI2Y2M6MKYBwLuCKDpN47fU3jfck+PLlFGtfxiAU49ONE4Vi05yL
	VV+aT9zdyUX9G0YTViTPQWCnwBDvoTSDkK6IW4jKb2cjjWbgja8k77cWVTGwBIQv
	BLWbS8ZeVJwsiZp0aDG9AxJMNG6VANqQROBqVQVZEaJfX8TH88WiCWekj8ldEm25
	2JU39X09Z/EV5mc801XiHJx5AfYDSd2GVm++8l8ZCtaWIF54al24YLkH1fSvtzPl
	hbm61So8XeA7LMZ01S5yA6XGxGRI489ENAgT3FZfuZpTgsuKkG6sSMzREM0rC+Ur
	VUsb4g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y5k68udd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 11:45:55 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-221063a808dso108258245ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:45:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740483954; x=1741088754;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CL0lc3FSdVBtQAJZpLV5Pqt/+P+vvC1pRH/Z+SNoYHk=;
        b=hcph7zTz2Jx/T9wdRDclvHdFuf8Cczu+pl+O43rWTkjdF60yAFNNdJcIgyn5l05ko4
         fhoS4yV3eyirEP0hEV/kXMwb58hkdrnLHtW0puR2O7xlBLIfoRsm0fOT2UI17v19zpW6
         w2GalTc2Z1T+cH+vu3PEMFh4yiJHh+LVf24E5JgL6MKMEHqFjXDBfYcyxVoVSg7Gz/TX
         kalS1rYh+/HapHXtgSxFUxycfGjSxlI/C+v468ytoDj3rblvzPeg3ZO7OJ9aLCE8FJtF
         7rF51AQ1/K4ABIxNqGlBjP7oH2Voga9wdp5LP80m+BFdv+83M8k6HIFIernRYNThEU5J
         nIVA==
X-Forwarded-Encrypted: i=1; AJvYcCWPIWokVX9aocgEArQ9ruBZnF0je5iP4sESvCJgBbohvMYfGzRRTzjdmEaUPlCy+JsOG5+xk4iMnOs0NVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxASGGsmfkcTzWtdHif+9pSEgfXSIrgWRpoRdNsCLK5pm8iTf9
	N9dSn5WRi8zLpiIYWdrAi5EqGndn15tgJkYAHIwpMExkTbMnhCwQ4enoD/FMnhMCqBxEqn4o5wP
	oJAoIqATyjdBgBQ46dHHvrLqAhxdN+UGeQaB3gXvMey4X39aCJsdSEQNl9rpM05c=
X-Gm-Gg: ASbGncsf5qA5ca24ZFxNuO/gtsmD2vS3LVuzD68ho8HRZwABJBoC5S+Bzm/bebSDhjW
	/4RFs+BLCA9NOLHjv+Ba9dJmzFju9TFc1SF/PfacFiteMcF2URVrs2wXBXOkz7RQ1h5UqfwEYtL
	1s72bdY6m/AQ+j6z2V+ZuYKaEOTgc30JwTHV9/sj9ZdcFeFAkpvkYB9PLMctc7eybvNUBy2/6b5
	sFPLeFCO0vJRJ9bC8SLWDJ2sDLHctP5kVmMhRvM5DdAaBNjL6LrMnf9W04HxSVUTbW+QrQbARms
	dO4OifI+ORkowj2Lh4Nv3XY8JuQDNgJgu4ew27NayaiUk/5xXlo=
X-Received: by 2002:a05:6a00:1810:b0:727:3fd5:b530 with SMTP id d2e1a72fcca58-73426d77f98mr23598036b3a.15.1740483954378;
        Tue, 25 Feb 2025 03:45:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF98KPJ3NHHETIUHz7cVz0wu8yWb6paMuhFIuUIGnid4MPw8cUtFG1Nqb9e6yv3CwbN4XxWTQ==
X-Received: by 2002:a05:6a00:1810:b0:727:3fd5:b530 with SMTP id d2e1a72fcca58-73426d77f98mr23597949b3a.15.1740483952968;
        Tue, 25 Feb 2025 03:45:52 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a7f9bb1sm1331790b3a.92.2025.02.25.03.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 03:45:52 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 25 Feb 2025 17:15:06 +0530
Subject: [PATCH v7 3/4] PCI: dwc: Improve handling of PCIe lane
 configuration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-preset_v6-v7-3-a593f3ef3951@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740483933; l=3059;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=u4stSlHqt6SDmbNCOygNp94BXAp7R4cdNbXp5bogHOM=;
 b=oTMbuIEWa0kinDliVDvtm/fVhAbjJe+MxEG67fD9o1BGTgITJ7v/ldktwJIJaDX0WLUYw1xM3
 yon9TibsZreBK0B2dZula3WaVgUj5R73uYw9ax9vYU/yFGK4l111H8P
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: eGxyNefL28kRv9wdjS4Kqm6NjnpiXO7J
X-Proofpoint-GUID: eGxyNefL28kRv9wdjS4Kqm6NjnpiXO7J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250082

Currently even if the number of lanes hardware supports is equal to
the number lanes provided in the devicetree, the driver is trying to
configure again the maximum number of lanes which is not needed.

Update number of lanes only when it is not equal to hardware capability.

And also if the num-lanes property is not present in the devicetree
update the num_lanes with the maximum hardware supports.

Introduce dw_pcie_link_get_max_link_width() to get the maximum lane
width the hardware supports.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c |  3 +++
 drivers/pci/controller/dwc/pcie-designware.c      | 11 ++++++++++-
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index ffaded8f2df7..dd56cc02f4ef 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -504,6 +504,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 
 	dw_pcie_iatu_detect(pci);
 
+	if (pci->num_lanes < 1)
+		pci->num_lanes = dw_pcie_link_get_max_link_width(pci);
+
 	/*
 	 * Allocate the resource for MSG TLP before programming the iATU
 	 * outbound window in dw_pcie_setup_rc(). Since the allocation depends
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 145e7f579072..9fc5916867b6 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -737,12 +737,21 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci)
 
 }
 
+int dw_pcie_link_get_max_link_width(struct dw_pcie *pci)
+{
+	u8 cap = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	u32 lnkcap = dw_pcie_readl_dbi(pci, cap + PCI_EXP_LNKCAP);
+
+	return FIELD_GET(PCI_EXP_LNKCAP_MLW, lnkcap);
+}
+
 static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
 {
+	int max_lanes = dw_pcie_link_get_max_link_width(pci);
 	u32 lnkcap, lwsc, plc;
 	u8 cap;
 
-	if (!num_lanes)
+	if (max_lanes == num_lanes)
 		return;
 
 	/* Set the number of lanes */
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 501d9ddfea16..61d1fb6b437b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -488,6 +488,7 @@ void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
 int dw_pcie_link_up(struct dw_pcie *pci);
 void dw_pcie_upconfig_setup(struct dw_pcie *pci);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
+int dw_pcie_link_get_max_link_width(struct dw_pcie *pci);
 int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 			      const struct dw_pcie_ob_atu_cfg *atu);
 int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, int index, int type,

-- 
2.34.1


