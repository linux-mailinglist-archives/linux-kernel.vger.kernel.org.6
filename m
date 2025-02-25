Return-Path: <linux-kernel+bounces-530879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08EFBA439A1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 10:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBCD37A4D68
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 09:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D844262801;
	Tue, 25 Feb 2025 09:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MYsKrDz4"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108BF263F2F
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740476096; cv=none; b=YJ7e246SZZof+l2RjqArI+lDh8595A0ZJ2l9us1Joop2qGYMALzN1XZReoAGNsZc3SPabH2/QPlEWMt2oR3ZxI0s9zdeYWvFJPkJhBDLuiECXbkqggW4N382OiEfVo4Ibnq90Jg9AxJ9l+TgG8jN1+SnaV3LGwcEVpyTHWEirRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740476096; c=relaxed/simple;
	bh=w3BQV4GEVn3y93ZdP3UnB+XSKP+XiwrUWY/Bml6uy9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VjMi8CusP/SzfxougFRHsFElkbqph7O0UGATLAGAPvFAWuh/1X4uhnc/mMfRzcP1z2t2THP5maLki9rYIveC+T5MeWFAfgss2Hkyt3L8uagipfwApeRmd6Z6G4o2+O7Z6PtOPZ1uiYkJhgFC0SJ4VuQRsOTiTIIlqxG8cblyFHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MYsKrDz4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P0RjjN028975
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PfVBAnMbd2bkW2PD02FjVQrfyFMHr5hxwFL2Mh9QfHQ=; b=MYsKrDz4OVpmk2U5
	5tpxkw4/ypzQVD1NZfHTdvcovmqjxNPo49Z+z3XBPVj9tV/eFMUuawnXNSDC4Rwe
	qsGVx3xP22vetpyhA3ClGAtLOJVmPyGE2A8mu+FW5zyy4HlqMirIvg8XCm+SFdNc
	9GtRlUd+dCPVaLMz+jLQpBhTbjkH2o6c2uv36XU4voLgw7UK2b9liGqZzwCUqmfz
	lEEOmFeUUa6fYA8iNnws8QETI0VfP0bFjouxwPvd1PsCJ1M5vjt95hCviaaknriN
	DqGIQkcYoDRCG/kF0yhBdlaSjuibhoQM+8Y65SjnXSmI8FHeC1jcZPPfhw8w6Xww
	vIYyLQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44y7rk05ys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 09:34:54 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2fc4fc93262so11819309a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 01:34:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740476093; x=1741080893;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PfVBAnMbd2bkW2PD02FjVQrfyFMHr5hxwFL2Mh9QfHQ=;
        b=qCXfEHmDQs+EILR8DpWLOw45uZzIJEUCYI826WJ3ms7zP/QjZy95jnCS+UdehHQrF5
         Ns8QRV1Taj+C+6tFgivn0GR5WtflWkNYebTlFt1E5XI6QZDyiyjX6GWaHp8ygQ5tEtxR
         te5se4RBls62sWraAFbndBQnUQchEfVajGsazbD3pdVgf4o+Y/r8gYxFNcKG4kcynSs5
         Q+yyAq8xs4/nJimzBl6ghvQxZOb987d6nuREC0eDASd8KWt1k15HBvarzxa0k5hMlY2q
         4SKtTALtDaKglwDXh2SAiceyuvKVAKx55PSp9kMcxyuyyDddelCt3w1H3wkAk8KBROj2
         6ttA==
X-Forwarded-Encrypted: i=1; AJvYcCVS5KbUr+7hydB+KYoJEzfY7VUJTynj6bzFqdhScqFtRb4Mc0EOxiYoaj4Wyc6pkGZ2Uxz3im+Cm+s1mXk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLOIp8vPwZI+w460ZALJkhsEgyExMwC/mXiiJKv3E4kzHYqBw6
	XbfXTMNVtqmCU536SqZH+4/ADktfPos9eL1OSXfDF+AzBJN4+z/wNfBxhjH/yCdUGURKSpElzMc
	bqbnLc7Bkh1vmOZUIIPCX0av2NCKzcLzn0Q6KibOiWhW/TLfezK6SXWg3Otu6mME=
X-Gm-Gg: ASbGncuYNc42Z0IdgqwbA9kxh+DDNnfYvv3y0c5EHD/IQpMP7FxfitbXP406LUVIQcE
	j0Hf2apGOQ7tS3lDOe7kG2G2vY0SDAjX5EYoOmbRGMmF/fBs0fitTV2OQE+U4c6ySUHOc21OD2/
	lBzhouqWc9Ov3L9rtgASeXgCGm5FJFgg7bUsKRogpAp9tx4KwF1fBoDPwQFcvkU2xvW1HBFW6ix
	8cnmfTfiqGy3+7zi47BLNxp08hnxHTJv0ECT7MJSijs4cB9OEpCxYKxP0CdtI9672ddspusVJoG
	qmAFrfjPfxGPCRTD/1KQUc1qtTDu9pN60XFYJ609NaCWaozIv3g=
X-Received: by 2002:a17:90b:2b8f:b0:2ee:ab04:1037 with SMTP id 98e67ed59e1d1-2fce78abacemr31839445a91.17.1740476093308;
        Tue, 25 Feb 2025 01:34:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfkUK8utPlxTxnPZ9mggiWDUCDDRGxOZv53sroMbh4/7yD0hJFXv+8HK7v+WABBzkzfhkZJQ==
X-Received: by 2002:a17:90b:2b8f:b0:2ee:ab04:1037 with SMTP id 98e67ed59e1d1-2fce78abacemr31839414a91.17.1740476092989;
        Tue, 25 Feb 2025 01:34:52 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fe6a3dec52sm1080770a91.20.2025.02.25.01.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 01:34:52 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Tue, 25 Feb 2025 15:04:01 +0530
Subject: [PATCH v4 04/10] PCI: dwc: Add host_start_link() &
 host_start_link() hooks for dwc glue drivers
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-qps615_v4_1-v4-4-e08633a7bdf8@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740476062; l=1526;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=w3BQV4GEVn3y93ZdP3UnB+XSKP+XiwrUWY/Bml6uy9g=;
 b=Ecnyx+01R7Ol61lB0SnLfgUmwTIIXPUGq+dcGYlCeRzL3eRvLpFInkEy3FC8hwma9M91qp/zo
 Ki3CTxY7zvgBrv57Lq970TQORFWxzP/T98htd0+Z+SOm8rMp5igpFGq
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: zE6aOIOvj-60LnkF-M7z73iufnPqjKSO
X-Proofpoint-ORIG-GUID: zE6aOIOvj-60LnkF-M7z73iufnPqjKSO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 priorityscore=1501 mlxlogscore=724 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502250066

Add host_start_link() and host_stop_link() functions to dwc glue drivers to
register with start_link() and stop_link() of pci ops, allowing for better
control over the link initialization and shutdown process.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-designware.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 501d9ddfea16..47f34dd12c39 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -435,6 +435,8 @@ struct dw_pcie_ops {
 	enum dw_pcie_ltssm (*get_ltssm)(struct dw_pcie *pcie);
 	int	(*start_link)(struct dw_pcie *pcie);
 	void	(*stop_link)(struct dw_pcie *pcie);
+	int	(*host_start_link)(struct dw_pcie *pcie);
+	void	(*host_stop_link)(struct dw_pcie *pcie);
 };
 
 struct dw_pcie {
@@ -664,6 +666,20 @@ static inline void dw_pcie_stop_link(struct dw_pcie *pci)
 		pci->ops->stop_link(pci);
 }
 
+static inline int dw_pcie_host_start_link(struct dw_pcie *pci)
+{
+	if (pci->ops && pci->ops->host_start_link)
+		return pci->ops->host_start_link(pci);
+
+	return 0;
+}
+
+static inline void dw_pcie_host_stop_link(struct dw_pcie *pci)
+{
+	if (pci->ops && pci->ops->host_stop_link)
+		pci->ops->host_stop_link(pci);
+}
+
 static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
 {
 	u32 val;

-- 
2.34.1


