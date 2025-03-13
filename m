Return-Path: <linux-kernel+bounces-559365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6BBA5F2B4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D83A16F6BE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B454C267B62;
	Thu, 13 Mar 2025 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dFCPNfx3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59472267B1B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866072; cv=none; b=KAE0qCwwYvFzHVuomt9bPn/7HRDwJEDQRA1M37nZiONcM4O84p6AKSH/mrwaNGMpU7+lhERuCn/RjjALRq3sll2HzdpA27rYQ+r83O8CjyEdfvZ+vDFHztLkFN0kwskNxhbzgrH/gC/pq1j89d/Lf7y7Dd23nvs2/UjIOTYByG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866072; c=relaxed/simple;
	bh=OgsUrN9q3q+inPJyVIdWwjHz4E1SChNjRFIZ0QnU4Yw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ahQqjN6m/uIXcJiV9GbJjdAUi9a1AGAYlclfcCsTXwbVWp5CjtcyijC/xEEIky67WhBqGe4I72D5U5kwvuFgIeiyKfduEy2gmKHKo15Kedm5p5isXQkpjCVDgtAzKkSJvKh+ryiH69QHiq66BzIG5QaFRzCPGpHL+/kpi/7EV/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dFCPNfx3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D7RSmR021895
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Inz7l/vu9v73fPSt9ovFbJUFU8bzhwtdsdKcnEdBMh0=; b=dFCPNfx3k971WYCS
	A+XQv//5LqX72EqMMNugFH/z0NBMaTLcHALb2sJLqjqP6qEBY85EnRKkEdR8rQxy
	YC5BEoRRyuuzSXBnzVBgYvj2hiW5N7GbvXOQ24gnI6V5jhiB2elcuLKTsWMngPv3
	NjVT7pgL7sUubGXGnfUsECtXQQOiS0MnCefA60XYky63Ws6aG9PGTBjhkne00Bu2
	zHY1WDlSLhtBuuNWWqDp13OpWF/BEQaLvQETfmDD9mUCTGEaITc/0704DlN2n0ef
	KfsAH5XsuM/z2yFn0h6Uej1gtzD2kmnbOx8LA1qdbqiY3dpr7WGy2u3zT6uBeJUD
	fq1VNg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45bu07gq5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:41:09 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2ff53a4754aso2481293a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 04:41:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866068; x=1742470868;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Inz7l/vu9v73fPSt9ovFbJUFU8bzhwtdsdKcnEdBMh0=;
        b=CircqDQUQys8Am83v8FakcrSMR0st/xmdB3qtnhsC/XUGgNI6qMNSKyST3Ko/duFs6
         6WWvlu7UkVH7zNYDQ1CNfWWWyEaiEoy6GJfXBv2yZwCTSZUXLpcN58gzo+7sypakiWJx
         fMmpet/4tfSCXlawD4ssdTEbN6NGsHV95pNBj4lCidhYv7pvd9b9xlysTW4OOajckv3A
         vcHpRuN96ViJQ/TiEpNw70b9Q922owaRxaLPbjGQcP1Jttu4Bv2Vf46sUWZWpks1N06C
         Vx08GFSo0J+38SMfxudaBBSvZ+7Mo9NnTwTANn8b1NapvUo9xxkj4vArjQJQYzU/E7L9
         OF+w==
X-Forwarded-Encrypted: i=1; AJvYcCW67HY0dJnbpp3BWazUBjGI9ZUPPBtSGSgI0ibhijAnwle669g9uUaKoOJoc0vSO9qbyAL4gwO+qJohb1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YymgWIy0c54w0lZU7WdlM0D7lEY/W/k5izHJ4ZGdUJNNFp0aJSr
	1z/NtB006xdpkmANn+iom1704F9D4KUaQGqxYHrpmZWOq/ksjGunEMzKaKmzlJST0WrC0Wj0EjZ
	H0KzxhVkFrZUYepxArKMD3f3Pp3mOk+VimM8sVOyq4h2dKHyt0vrlkfuch4PpgSg=
X-Gm-Gg: ASbGnct0sGDXofXBULaCK2TnDpTLgNoZf3umpvDSWIpyINqiBFbgc0QQtrFfx34gLS7
	J/atO/AsNrEWGDrT3Bh4yblpJREtf+cVDJ5BXgCkaJiaVlAZR3p5+7Defc0D5jTYko2S5xTbeR/
	qpX2xQzcklJjtvxMzYulec3DIHG0RgS9OVlKWU6FkpIOwKXZzpkRvVQg+nXJ+xzbuyufZNjGlhQ
	1VhXqw/bIIbxxW9l8KYox3VZYO8H94xl27WkVI2GeEj1ISPnvGweMwCAtEjWjzqkbtzBxaaxQaJ
	vg9bIcYhceDQs32higUTMVQy1JU8zUgpCLcH8bNfZW8UMHyVDPs=
X-Received: by 2002:a05:6a20:244f:b0:1f3:486c:8509 with SMTP id adf61e73a8af0-1f544b1864dmr37037082637.25.1741866068016;
        Thu, 13 Mar 2025 04:41:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYMSraKTahqSusHZQjg0Nxxu2lq1B8e00PC9WyPgDLU3mKpXvp/IOMCPvRJSDANheLJbPDkA==
X-Received: by 2002:a05:6a20:244f:b0:1f3:486c:8509 with SMTP id adf61e73a8af0-1f544b1864dmr37037047637.25.1741866067656;
        Thu, 13 Mar 2025 04:41:07 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea964e3sm1063219a12.76.2025.03.13.04.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:41:07 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 13 Mar 2025 17:10:11 +0530
Subject: [PATCH v2 04/10] PCI: qcom: Extract core logic from
 qcom_pcie_icc_opp_update()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-mhi_bw_up-v2-4-869ca32170bf@oss.qualcomm.com>
References: <20250313-mhi_bw_up-v2-0-869ca32170bf@oss.qualcomm.com>
In-Reply-To: <20250313-mhi_bw_up-v2-0-869ca32170bf@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jeff Johnson <jjohnson@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev,
        linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        quic_pyarlaga@quicinc.com, quic_vbadigan@quicinc.com,
        quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741866038; l=3187;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=OgsUrN9q3q+inPJyVIdWwjHz4E1SChNjRFIZ0QnU4Yw=;
 b=3HhOo9gMyOoRqSlN5KPpWGl2RGQzhP2VzW9Q+Y6coOM0y6QJgcxYZUSMSGKiD5fh7+bDTJjSI
 yW6u4HCY2AICcDFCzZ/byJDMF/LJ4Sea74xLy6suNHgVkhk0/OFQgKV
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: 3ZlI2tL9wGLZajSFingRjrfKjzj2nrut
X-Authority-Analysis: v=2.4 cv=V+F90fni c=1 sm=1 tr=0 ts=67d2c455 cx=c_pps a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=h4B-02p0z56_JbXvspoA:9 a=QEXdDO2ut3YA:10
 a=h065WJ_eg54NNNGU8Mde:22 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 3ZlI2tL9wGLZajSFingRjrfKjzj2nrut
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130092

Extract core logic from qcom_pcie_icc_opp_update() into
qcom_pcie_set_icc_opp() to use in other parts of the code to avoid
duplications.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 61 +++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index e4d3366ead1f..b66c413f1e2b 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1294,6 +1294,40 @@ static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
 		pcie->cfg->ops->host_post_init(pcie);
 }
 
+static int qcom_pcie_set_icc_opp(struct qcom_pcie *pcie, int speed, int width)
+{
+	struct dw_pcie *pci = pcie->pci;
+	unsigned long freq_kbps;
+	struct dev_pm_opp *opp;
+	int ret = 0, freq_mbps;
+
+	if (pcie->icc_mem) {
+		ret = icc_set_bw(pcie->icc_mem, 0,
+				 width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
+		if (ret) {
+			dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
+				ret);
+		}
+	} else if (pcie->use_pm_opp) {
+		freq_mbps = pcie_dev_speed_mbps(pcie_link_speed[speed]);
+		if (freq_mbps < 0)
+			return -EINVAL;
+
+		freq_kbps = freq_mbps * KILO;
+		opp = dev_pm_opp_find_freq_exact(pci->dev, freq_kbps * width,
+						 true);
+		if (!IS_ERR(opp)) {
+			ret = dev_pm_opp_set_opp(pci->dev, opp);
+			if (ret)
+				dev_err(pci->dev, "Failed to set OPP for freq (%lu): %d\n",
+					freq_kbps * width, ret);
+			dev_pm_opp_put(opp);
+		}
+	}
+
+	return ret;
+}
+
 static const struct dw_pcie_host_ops qcom_pcie_dw_ops = {
 	.init		= qcom_pcie_host_init,
 	.deinit		= qcom_pcie_host_deinit,
@@ -1478,9 +1512,6 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 {
 	u32 offset, status, width, speed;
 	struct dw_pcie *pci = pcie->pci;
-	unsigned long freq_kbps;
-	struct dev_pm_opp *opp;
-	int ret, freq_mbps;
 
 	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
@@ -1492,29 +1523,7 @@ static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
 	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
 
-	if (pcie->icc_mem) {
-		ret = icc_set_bw(pcie->icc_mem, 0,
-				 width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
-		if (ret) {
-			dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
-				ret);
-		}
-	} else if (pcie->use_pm_opp) {
-		freq_mbps = pcie_dev_speed_mbps(pcie_link_speed[speed]);
-		if (freq_mbps < 0)
-			return;
-
-		freq_kbps = freq_mbps * KILO;
-		opp = dev_pm_opp_find_freq_exact(pci->dev, freq_kbps * width,
-						 true);
-		if (!IS_ERR(opp)) {
-			ret = dev_pm_opp_set_opp(pci->dev, opp);
-			if (ret)
-				dev_err(pci->dev, "Failed to set OPP for freq (%lu): %d\n",
-					freq_kbps * width, ret);
-			dev_pm_opp_put(opp);
-		}
-	}
+	qcom_pcie_set_icc_opp(pcie, speed, width);
 }
 
 static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)

-- 
2.34.1


