Return-Path: <linux-kernel+bounces-559359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A81D5A5F2A4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC8281779A0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 11:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19E42676C1;
	Thu, 13 Mar 2025 11:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HmXvMXzU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60751266F1C
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741866055; cv=none; b=kqK+VaHYAG1E4DGF1VWb+9pZJR5Uvn3KzRXH4/0ddcncgo/RoiX27/kz9U5GWBgz+7wCKiUSIp+4e/207TcOwOJzCl6YRKirEuPmlNo/l4VOTS7Z1p4OUQZL7gvtf9zlphio65vbMgypKjtpJPIVGnfzLjiZYQEkskH0C7shWUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741866055; c=relaxed/simple;
	bh=kC8jbRyoGWHcr5F6bMdpdYEPmSroHXkD/t16CewXuhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WnssjIZMWPI1gPAminl2etIkOXM4IbwWCk6nN1Sio1l6dZRicDNAvP0JJI4wkNyvzEYZHhpOcZVghHSlaS3hF1KHe1AIid2mRxQNgefx1pvTv6M/SZaanBO0WL0Hco8gBGcoi+Z8ao42+MWNdyP3RwcknDzXOjiWiANy/+88VPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HmXvMXzU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D7CKtd019923
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FDJhVDK2s1wMdCivo+PnGOHqGOzFfulqMDQxzsMg+uQ=; b=HmXvMXzUoTP8Q8hI
	I3LttVypEv90ARIUfTW+7FEwKadDufSkIiWfgbb/CQwlr1WPnWZPczd92TM1LSIJ
	NRyLQZxKmth2DPuaCpl4bCWFN/LRvbjystJkWPKpYwpC1MYL9UHnw3uXy+IOzcvh
	11myRbTGdnhRs9kzgNl58CdZC7o7DNbELWlEbQMUFiPtzXB0xFNo/nJqpkqOGVcR
	QsaXNNPXbTas55XxnNlXuWnlTqk1Ox92eMJjj6h4Xq82VE8KeL2uK2NlHRyBnLtR
	Asl+hJ3aF5S2twK2tlEk/cW3noS8QR0P+ceF8rEKVX6fb7F4VZu/GBweQhBXYw0/
	90/HzA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45bts0grc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:40:52 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3011cfa31f6so1631428a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 04:40:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741866051; x=1742470851;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDJhVDK2s1wMdCivo+PnGOHqGOzFfulqMDQxzsMg+uQ=;
        b=kKQrHVU2zLxejickGT5kHliVhbfZXmvRNL8T3KlGZhG2GTuOMJUnfahlXLWmqaj8cU
         7Eyu5CYffYd6xlR70r7nVwhWtoK3Bg6gdBkPlChvWOE5S9NaTpoD0w0vJ+2aSx7A0H0d
         REjKAnHsNIS9t655tJU6T+NNx5o9EvVbdkQSf41WG8jjSFgZT0yJ/FBf4Up/Krho7R9Z
         pxU3Ao407p7L0NPGcilD2f+szyDMLMVcPcUytCwptlGRISS+7BLn+A4pQG2g1NPNOCDm
         6jx9vbBZ5RLckoYQF3KhWpnb4muB2XisNMH+LBAx3f6eyHFnmZ67uMmwqm6mZoo0fbr9
         KFQw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ9Ra4SZ04HA/qrUD6NgNx2vwGfvcq00OKntMI39OavomTuXmWdlp/0NcqpOE4ofFRJNpNJUSXio/LkJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEK9d6/OkO4kBShZyRRekoU8qVmWCbgMJVGm8rC8GmajOrPdiv
	W5mQKATjeWSPxBoTdWmsx5SUNQPsnPyKSfwFy5mlHmEAjfSfaIR7HGZ7Gx5QF6AfH0xi4zH/1fb
	KMRqe7dzDTKvaWYUFoNqspkrT4yzXnJ6MjEcIO+CKgNhzYGJjrZbEjlh/wX9imMg=
X-Gm-Gg: ASbGncuK65eUrFxx+8b9w1UIhrYuCwR3+03jT/A6Vd4XSrbpwp9bhHUrHbankOzOFX0
	J1D9fHa+/W4uDGnUUJ/vz0EBbuJbKginGXjrLacK6Io5w6jeWRJ/fGNUHYBpEtsXF1KVAQusrZ4
	eCg2FwPbBqSW0E6Avv/BzSwOl+lJbTBWJzwE4eBSxz7Jpd6rqIiC4ZkS5/33K0jJg1G9mjlFX6u
	fVo9k33YkyrrMKzOBUvocyU7fgc2LVaP2xvh02aIZSav2ptloDnRaPoAE0pvJXOEMBZZi54BzlC
	KkJ+DmxLF4p44JgR/rPg0B1tV2ggqXZJfh1oTrjntxVZS65L/YI=
X-Received: by 2002:a05:6a21:a8a:b0:1f5:535c:82d6 with SMTP id adf61e73a8af0-1f5535c862cmr38690645637.35.1741866050743;
        Thu, 13 Mar 2025 04:40:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFX0osURi3EPGsBhGonuGqBQDJB5s6R9Ee/fm3sZrU83VNV9iwXDBptbFr6kXXFDh+i9IOGIQ==
X-Received: by 2002:a05:6a21:a8a:b0:1f5:535c:82d6 with SMTP id adf61e73a8af0-1f5535c862cmr38690595637.35.1741866050366;
        Thu, 13 Mar 2025 04:40:50 -0700 (PDT)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea964e3sm1063219a12.76.2025.03.13.04.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Mar 2025 04:40:50 -0700 (PDT)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Thu, 13 Mar 2025 17:10:08 +0530
Subject: [PATCH v2 01/10] PCI: update current bus speed as part of
 pci_bus_add_devices()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250313-mhi_bw_up-v2-1-869ca32170bf@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741866038; l=865;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=kC8jbRyoGWHcr5F6bMdpdYEPmSroHXkD/t16CewXuhA=;
 b=ahY6Y0A168tVls7xeIA9KMyOy4DdXUlaSCT4aLtCvCoOwCqtVuPLJB4oihUbL9V6lKzs0jMIr
 YbHNVpW7tlaAw2nG6V5+CebfmNfg9kEZrPSIm76H9fmD5LPSKow5ily
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-ORIG-GUID: 9qMG6Ow24J5tTN3SYd0vJ_HWUVJRkhGM
X-Authority-Analysis: v=2.4 cv=DNSP4zNb c=1 sm=1 tr=0 ts=67d2c444 cx=c_pps a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=u3yxjsl3ZikD_R2semEA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-GUID: 9qMG6Ow24J5tTN3SYd0vJ_HWUVJRkhGM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 phishscore=0 malwarescore=0 mlxlogscore=982
 priorityscore=1501 mlxscore=0 spamscore=0 bulkscore=0 impostorscore=0
 suspectscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503130092

If the link is not up till the pwrctl drivers enable power to endpoints
then cur_bus_speed will not be updated with correct speed.

As part of rescan, pci_bus_add_devices() will be called and as part of
it update the link bus speed.

Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/pci/bus.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 98910bc0fcc4..994879071d4c 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -432,6 +432,9 @@ void pci_bus_add_devices(const struct pci_bus *bus)
 	struct pci_dev *dev;
 	struct pci_bus *child;
 
+	if (bus->self)
+		pcie_update_link_speed((struct pci_bus *)bus);
+
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		/* Skip already-added devices */
 		if (pci_dev_is_added(dev))

-- 
2.34.1


