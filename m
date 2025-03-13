Return-Path: <linux-kernel+bounces-559372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05468A5F2DE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:45:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D6E188EFAE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62E45268C7D;
	Thu, 13 Mar 2025 11:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EVEq33vx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D638266F17
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866101; cv=none; b=qgy3XerldVJr4iu/STl48pPl8GPbLlt7taNz4bXAPIsmYdOSO1FKil9aslhz8o7ae6A2K/zAd9LA/XBA3ERDCNy9dDJJ1Lysl22l5PlLtBAgfwOoNQ+B8C3dGx1zrPm8Z5aIqnka3bP+FphKi7PTjDGAE4KXkcOy/CCllQlgk1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866101; c=relaxed/simple;
	bh=8h6iYqT9QgxKQ7chsjPReDkmLMBOz+R1kQyF7lNPqNQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rAuKZn9VU6drq3g7p0jcWvsyS11mFEObngPnlniqB7mW2qRGYZqYGXX0ONn7Kdog0TbgfctvvFAYlT3FsTM6uwfSNERIQb7VW6d3GbIQmE9uDmiOqLlr3HZBPr9eD+iu+1+IZsH1eXp89IRg2zEO97qeacgobcDnt/6sNQtk4ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EVEq33vx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D92oFj018573
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6csxGEooemVwhVCZXPAno/xD7GGqltefCOv7rH6G52E=; b=EVEq33vx9yuK88OJ
	7jNNxLMvNyDzkk86pb2QlSDH9SQcw8BWIchhNFiWLi/cZbGdwPHC3U0+T11I4FeS
	D0732izuKp3qV41qcrmhIkuP2jGrxpSSdqA8C0w4pV3cdELSeJ+b3tsFuE38fHzy
	skY0zVfKNn/YjaWg9+5Hb3W0dWinwf4MfinLPONKJsC/WZw6RCxIPA5Xc5JJbX2s
	iD4n51F4INZhPgBdkeXEgVOVsiIWnnTlFrV/WPn1ag6ZTRDXyxhU/YgzlX5ZK13B
	otFrH9JgdfJBq7z4Ug7+JIMsog/Lq2w18j1OusVIDTDeQ0yIIEGllen3YUvO3hzL
	YJBbJw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45au2nwr71-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:41:39 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2fec3e38c2dso2507343a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 04:41:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866097; x=1742470897;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6csxGEooemVwhVCZXPAno/xD7GGqltefCOv7rH6G52E=;
        b=xVPq2RIsYshOdLnm3q0VtJFuUaHsdIZ5Gn74KfwU8tNHvXfQLulT+H1s9OvcBiSO4O
         qg+ImeumEaLPmyz5x0sOmTpGZpuGYebe2owQ6sF9EZqgmwch94jWEI4HWDyHhRt0479M
         a8/hykAiSOIriu+WK7MlBYX4Wt4CIIL46sraKwXyk5UbRsw+xCT7qkcHRyJ1gqshxyuy
         O1iiV0HVv8MLhz/p/a6NOPBA1tLAT4+WGw2yeWsymqYYzBaNNrp4CjEPOBrdxhOECREw
         5/CyxbjSmbcLdD1aR+nfN6nvUQzjJomJEgYtGVNnz0w0OVnL6lXm3/OQmbdmAv9hv7oZ
         +M9w==
X-Forwarded-Encrypted: i=1; AJvYcCVqVSrA+eYXzDxZ3myMHqol6fflJZkRjl8fGpMaj1M4t3jdTIDuHDy1hTbLA3+21d/VnRoyi42FLtX0YcI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA0hVNLoUNXtJSMVu3bP64NCt8au8RvcSAExJAVdVqmETRJ5wA
	iFcSxPX5ZjdFBB6UUp6Y+ERIwbPaXMdHmLb+jZe2gHwomiMzRu5ePKpkeWYsKkiixmNtc8xa+WA
	NsmSZH49aAE79QDq/Kci2LO/B0oJZYMEojGT8w9sLnu7QZfdvWx+23Pk5X+1eQUk=
X-Gm-Gg: ASbGncu/IH02J2vIjQTa/GEzgTi8j1Gn8zTeq9YYf26nMv60ouxeF9ZEc2Bw8ORzBYe
	HhT/d9pSD9KXhgfqdhxFQlwA7DdWHm8RPOd3kjvFfsinXypabVp9giwE0yzRkL1R4Z713Z0DCZ0
	OeeJ3fGza5PgrJmpIhTp/LqLhn6ZQ6vGuqE22mIvKijfDxgnTpdVYBZSLMfPDpD2d/Ez88gg1er
	PKFo+6+cYaurWbj22v7MlnixgKQIM46x062FGalWDcaxCaEm/YTxDv79dU1ZgyFAmMeJJAZWdJJ
	ubZVt1gKeoGG3yVkgqpKnFRS5JIvOsCubz6TPp+anVescxjKXKk=
X-Received: by 2002:a05:6a21:516:b0:1f5:709d:e0c6 with SMTP id adf61e73a8af0-1f5709de3e1mr24106469637.42.1741866097045;
        Thu, 13 Mar 2025 04:41:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO+VZsMHm3zLtB84wJpH9RObZO6+qVAnGGVqwEYlnPvnXu3mMtC1TTdcKCjIwnGlhmgp426g==
X-Received: by 2002:a05:6a21:516:b0:1f5:709d:e0c6 with SMTP id adf61e73a8af0-1f5709de3e1mr24106444637.42.1741866096735;
        Thu, 13 Mar 2025 04:41:36 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea964e3sm1063219a12.76.2025.03.13.04.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:41:36 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 13 Mar 2025 17:10:16 +0530
Subject: [PATCH v2 09/10] PCI: Add function to convert lnkctl2speed to
 pci_bus_speed
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-mhi_bw_up-v2-9-869ca32170bf@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741866038; l=1512;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=8h6iYqT9QgxKQ7chsjPReDkmLMBOz+R1kQyF7lNPqNQ=;
 b=gNFMqlJS4PqDCxPL2OtSQ6eC/PtryQoUwiUm6/NuGn6xNnLkYCte4RpeEygA+SWaLg737Q1XU
 MERgI9pKC7DArMKbUXJJttHUPva7o7L2vUckaXu6sD9dwPouLJ3V5cj
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: _6VZYd-0W0Z64bvvEKvrR9SEMC4gksYm
X-Authority-Analysis: v=2.4 cv=Q4XS452a c=1 sm=1 tr=0 ts=67d2c473 cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=rcts_Xg4tTJKaDXoMsUA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: _6VZYd-0W0Z64bvvEKvrR9SEMC4gksYm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 mlxscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130092

Add a exported function to convert lnkctl2speed to enum pci_bus_speed,
so that other kernel drivers can use it.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/pci.c   | 12 ++++++++++++
 include/linux/pci.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 869d204a70a3..75505437a9c9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6011,6 +6011,18 @@ int pcie_link_speed_mbps(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(pcie_link_speed_mbps);
 
+/**
+ * pci_lnkctl2_bus_speed - converts lnkctl2 speed to pci_bus_speed
+ * @speed: LNKCAP2 SLS value
+ *
+ * Returns pci_bus_speed
+ */
+enum pci_bus_speed pci_lnkctl2_bus_speed(int speed)
+{
+	return pcie_link_speed[speed];
+}
+EXPORT_SYMBOL(pci_lnkctl2_bus_speed);
+
 /**
  * pcie_bandwidth_available - determine minimum link settings of a PCIe
  *			      device and its bandwidth limitation
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 9ae199c1e698..b84473f228c8 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1653,6 +1653,7 @@ unsigned char pci_bus_max_busnr(struct pci_bus *bus);
 void pci_setup_bridge(struct pci_bus *bus);
 resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 					 unsigned long type);
+enum pci_bus_speed pci_lnkctl2_bus_speed(int speed);
 
 #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
 #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)

-- 
2.34.1


