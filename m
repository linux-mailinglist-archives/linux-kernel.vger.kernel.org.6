Return-Path: <linux-kernel+bounces-530881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E96B2A439A8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C093AB494
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91D4266B4E;
	Tue, 25 Feb 2025 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eEpfqewR"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D651220101A
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476108; cv=none; b=VP2uBjz+W6AZoiqckuW6zaeQONALMOHgAJ0bJH/T3iZuC23qp6be/GKWT+reDbGAhXXHqFK+8OcQkijo6kO01yLDSz1SV3wkzbZRo2qfoH17JRWMzVLVjrhEvu/ksZKO4jpx9hnc95/6VFWlkHxZT7HTRHd3wTGhhruEAaFEJPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476108; c=relaxed/simple;
	bh=cqpieFQ4yffdW6JHTht9pnvXXQf74NR7jAV+Si840rI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ct8Z3c1TU6L3p/kwGz4t965aCIPU0DF/Z26Uq/Wg2w8qv7AJbpoGNqaXRZBA3VARUSxJkfnWqixwsgoACtyY3oZ6IqG43voowcSXNCqTsAyfO2miBxnqBgeRzpzwZ1MzNdu7P5xfESBrvJFETCs4RWo6mWMrYHtarHsJ2Bg7O9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eEpfqewR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P8IhYV003773
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:35:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Q6YFxMqM846mSc+Tr4fu5o2Zex5KCBKuxSN2OETBscc=; b=eEpfqewRcfRH6YD+
	DBSxYoqYgtZz0y2m3w50VuW0uulaGMz6dmXNh5Ajcf5MIu8W6A8Yd2XHCY9c3Uhm
	d0/kRR5MQdRqWgP5BITIFdzvo0PF11oQtfxeXls0UiEdEyj/0p6ZPN5reSTWek5H
	i5BTuf0ebHHTUkJlbfAuM92+zMLoTxSbfedrDvr10cc8d1PHsynwk8IWBYubYDqb
	LxeYXK3UXXYm25Wqxx0cJYFQnZHI8V6o+uMJorFFuk9cGp65HI+1m3pDZYlLbcn3
	N6WTGECJooTWBx4SNAbziLHeNYKtfu8XkTTy5icxOMlwPBkzFQDVD/uEnTxhfS4Z
	zZjUfw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 450m3dcc8t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:35:06 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fc46431885so18105311a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:35:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740476105; x=1741080905;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6YFxMqM846mSc+Tr4fu5o2Zex5KCBKuxSN2OETBscc=;
        b=EuT9NQoCOWtKeKIyy0oQ1M4tEed91sxdrEKJS9Q4uKYack5qVLG3rl7AJ/dLJtrJju
         NAhefdqohGM9m7UODOKSjiuMHZU4kq7QiAfgnWBFAJ7XtI4OLk1QB/WOYe8HXsoPyUaA
         /PVccl11Q1jbJs18zwd61NfLV6CEzeQoj21s47I4Lj/ef3bNUMzY99lpTY6f3VyhxzwG
         h2neEgOAHo5TFxnQ7JOyaU/epNXPtO+qHHlv2fkiq4odPWJeVFJLtV8B9KGCJhu4AkPn
         LfiwPligDFtsDu35qlgUx7w7iKMtuWuMn0rM7+fCna/37dn+yuNXF/fAkLQYA7gYB4cp
         GJ3w==
X-Forwarded-Encrypted: i=1; AJvYcCWbIgDh9KyJ19BN93O1zmql9KQP5LBPUUVNAJ6s0wMFR88yrXxIBwdrjqsN/VVG40tZeYTdNC5zfdxu7Bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YygZev4jxJz/bHhzuXTpijAV5POCm/XGM8c5+z8he9ANeGWu0Kl
	X4CF19O5dzCahlQFQ6QrBp7eG3w39gP5GSMWQFagrP1gqYPMowYzGdtZiHXktijObjBKShVdkH7
	gjsmr6o8nvONxOLU8IU2ZV/Z/TXmbP+vx6Kk2Guwz7TWTnm3S/Ym4Vd/jKCn0IsY=
X-Gm-Gg: ASbGncuXOBj4fe4Sa2sdr3Dt7LieEZhdn0/dg2nl33IhdfwmolUz8vKA6I9rQoa6Fts
	4NIeYk+680ibo4I51Kzf63JBihxDzHzPGZErJd0Z6A++CnYnz+vKSHmQ6Z4ouLCNFBkpNx2v37h
	X+oJE7mN2BElM9rbell5RPxxAuPhi4wT0F0bnrpjZOu6GegJPg39W+CHN1CDHXaQjAxmM3ahCEN
	nEdqqBITIOA7zmQaB2XNjMdOl/5pr9nAYgv9RpKdQnHlQcGMftDmDIiibB9iFt3vCiGj7whvUBe
	FllfA4Dt0xrMknsGtC/CsQEyMbDH8uVu7sTZpDSGDFoYn5TXcL8=
X-Received: by 2002:a17:90b:2b8b:b0:2f9:9ddd:689c with SMTP id 98e67ed59e1d1-2fce87247d0mr27790235a91.25.1740476105377;
        Tue, 25 Feb 2025 01:35:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHboVQx19IAka22tTopEyPevYSp2q5hMkX4eBoo9O54pF2jebrtXh/oJ5rVUGppNyCKsX3M1Q==
X-Received: by 2002:a17:90b:2b8b:b0:2f9:9ddd:689c with SMTP id 98e67ed59e1d1-2fce87247d0mr27790209a91.25.1740476105011;
        Tue, 25 Feb 2025 01:35:05 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe6a3dec52sm1080770a91.20.2025.02.25.01.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:35:04 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 25 Feb 2025 15:04:03 +0530
Subject: [PATCH v4 06/10] PCI: qcom: Add support for host_stop_link() &
 host_start_link()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-qps615_v4_1-v4-6-e08633a7bdf8@oss.qualcomm.com>
References: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
In-Reply-To: <20250225-qps615_v4_1-v4-0-e08633a7bdf8@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        chaitanya chundru <quic_krichai@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jingoo Han <jingoohan1@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: quic_vbadigan@quicnic.com, amitk@kernel.org, dmitry.baryshkov@linaro.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        jorge.ramirez@oss.qualcomm.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740476062; l=2776;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=cqpieFQ4yffdW6JHTht9pnvXXQf74NR7jAV+Si840rI=;
 b=OwTMhSAouVxaRKBcVHXa8wc0KbtbtdhzaEINWGVy2gtJDOSqmekSlFwT9uTan0CDSLZLOzBJM
 r94UKKFN0PlBpeTayxKvpRzS4wTFncZfLUtc44YTr/74U4yw8AglTnu
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: JPcrJ7Kgh8hVsqwB6zdXW0K-gHEkbjO_
X-Proofpoint-ORIG-GUID: JPcrJ7Kgh8hVsqwB6zdXW0K-gHEkbjO_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 phishscore=0 mlxscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250066

Add support for host_stop_link() and host_start_link() for switches like
TC956x, which require configuration before the PCIe link is established.

Assert PERST# and disable LTSSM bit to prevent the PCIe controller from
participating in link training during host_stop_link(). De-assert PERST#
and enable LTSSM bit during host_start_link().

Introduce ltssm_disable function op to stop link training.
For the switches like TC956x, which needs to configure it before
the PCIe link is established.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index e4d3366ead1f..8c9c89417440 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -247,6 +247,7 @@ struct qcom_pcie_ops {
 	void (*host_post_init)(struct qcom_pcie *pcie);
 	void (*deinit)(struct qcom_pcie *pcie);
 	void (*ltssm_enable)(struct qcom_pcie *pcie);
+	void (*ltssm_disable)(struct qcom_pcie *pcie);
 	int (*config_sid)(struct qcom_pcie *pcie);
 };
 
@@ -618,6 +619,37 @@ static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
 	return 0;
 }
 
+static int qcom_pcie_host_start_link(struct dw_pcie *pci)
+{
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+
+	qcom_ep_reset_deassert(pcie);
+
+	if (pcie->cfg->ops->ltssm_enable)
+		pcie->cfg->ops->ltssm_enable(pcie);
+
+	return 0;
+}
+
+static void qcom_pcie_host_stop_link(struct dw_pcie *pci)
+{
+	struct qcom_pcie *pcie = to_qcom_pcie(pci);
+
+	qcom_ep_reset_assert(pcie);
+
+	if (pcie->cfg->ops->ltssm_disable)
+		pcie->cfg->ops->ltssm_disable(pcie);
+}
+
+static void qcom_pcie_2_3_2_ltssm_disable(struct qcom_pcie *pcie)
+{
+	u32 val;
+
+	val = readl(pcie->parf + PARF_LTSSM);
+	val &= ~LTSSM_EN;
+	writel(val, pcie->parf + PARF_LTSSM);
+}
+
 static void qcom_pcie_2_3_2_ltssm_enable(struct qcom_pcie *pcie)
 {
 	u32 val;
@@ -1362,6 +1394,7 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
 	.host_post_init = qcom_pcie_host_post_init_2_7_0,
 	.deinit = qcom_pcie_deinit_2_7_0,
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
+	.ltssm_disable = qcom_pcie_2_3_2_ltssm_disable,
 	.config_sid = qcom_pcie_config_sid_1_9_0,
 };
 
@@ -1429,6 +1462,8 @@ static const struct qcom_pcie_cfg cfg_sc8280xp = {
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.link_up = qcom_pcie_link_up,
 	.start_link = qcom_pcie_start_link,
+	.host_start_link = qcom_pcie_host_start_link,
+	.host_stop_link = qcom_pcie_host_stop_link,
 };
 
 static int qcom_pcie_icc_init(struct qcom_pcie *pcie)

-- 
2.34.1


