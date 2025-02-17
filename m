Return-Path: <linux-kernel+bounces-517064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F22A37B8F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 07:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48BE51888281
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 06:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D451A8F93;
	Mon, 17 Feb 2025 06:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Sl0iAd/M"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704B61A8405
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739774089; cv=none; b=qQi7x+bpU+0o04zjNbyQtFHGUwV55Zhnh2GZUCQFdj8qj0FogAY+QLIP94FU54EHWIpSJt2gHzGkLgCStHj8odP6hG5lgsFiXOYI+wraLFsoLx2aXG1gP/D8tXePWnUKhl88zpiufUYmk6aAXDO03RSK61RavlEldyVN35DMhPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739774089; c=relaxed/simple;
	bh=YqqLhB2sDmeRf0yvSJdYtwvNNWc93ZsNkQgc1bLXWOA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X9FGr+w0M4ii+8MjPvlb8d6tzGCNMaw21jBK4xEJYskHnF9gwD0G/SGYRSYXV0lhj+TTB7ZBMUnyheexx1Q3J8+gER5iNvUJUa2vGAEQr4pCZIkMTUm/tx86vd7EOWZrYpS7csp68wew+7SNYmFpfwuJA1sobQblkYkYLpil+4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Sl0iAd/M; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51H036YG016850
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:34:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b66c7trNFzZoQyrgHszRHq0+mVYbdCkWT7Z8WHwPyWo=; b=Sl0iAd/MnSjsbO6p
	RaioFwWYm6cYTh9hVO6NZl4cDpzwKVbYGPcXz5j19NjL7sqRha4E8hlm1QIa+HWJ
	WWpRoqNnY+kQ+la4rP57zDUmBIHXB8vRrCxLhaT1BUXAw+lXaOY5OEFieaPZMUjc
	3qQByfSPIONTSoYGZSZ3RYb1f7vUlvXSoTW5QtZnvU/HXvaYCpD9NjTn249AsZeC
	77YIsVY/ixRcluhKjgpn+CxTbzMw77aMrJj3WCEcznNrCOXKPo5Xk4qm4LZGzgdK
	1m/kpI3vFPvrkd7bWJEwd2HSgvXlMf4RQxkZ0bgqcibSlSkj1VMgp3iMrKyOrZKq
	FVKQGA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44ut7urpw2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 06:34:46 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fc43be27f8so5347639a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2025 22:34:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739774085; x=1740378885;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b66c7trNFzZoQyrgHszRHq0+mVYbdCkWT7Z8WHwPyWo=;
        b=nMjuNu/0L9cOJ8zGKGXjrMBxEeHDUU3QAX3Z9oZcGBNUdAjOWSpjOShKmJcAMDWjBE
         bTFCPOdrYChR0rRY17KVc86sY5yLhrCTlvKbZklHewcZWzebyknkf6zAfKljKpQ7L1Hx
         F++2acvizmPRyGrLeLYI6mEftdRBvYxaCtQUve3uBZyZfzHdIEJ7jJBgd09y9WZG7Rxm
         x+yqJFqRSpalKq3VE5RcOjRKZlcTVtM/QGIveG4s3/odsyGT6ARw0WoYG7X0yZvuwB4Q
         EBhfl4pQ2Z/8kZhf0t6ka1zgFJZjJmPUX85nQDAs4zn9GwSQlik1u+4HJPcwXySwyCYI
         0uSw==
X-Forwarded-Encrypted: i=1; AJvYcCW+bEJ1Y/Kuutn0vfTTXxEtFcj097BXD5L3V4vJOio2Uqr6dBpXx3YHzW5B+x8XrmLc5BkLt103Oq5t+Ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxOGvmL0YnrwDcAyMybSgACuXJQDqedTIR5dB+5NbiqnAFJjrC
	iUTPsRnTLv6bnA+w9dTI3f6BkfDEVQztVTtvKp3jjMCisH4K79jIAPClPuePxaFTdWfeNkWMnOH
	p70HzoiFDehEvf3hW5rXl+nbG9EHVix+blKDXFXB3R2npKJ5pp3w8qtwC1vZhLac=
X-Gm-Gg: ASbGncszNUseEv+j5zEzHPeVKBO4/GrkNhLO+ANJKJCvGJTXW2TQbHPRu2XdYDsbwfL
	96u+rkOTTsVcxtcgAK49psTLEJ9LpQD9ulqiZynRH+1qR1FC3EHgGb3gWw//XsDP2+Q2EwPvURq
	2upc0XILsDUrQFtVJnvE4ogjNtvN30M+RTgX9ZzeXyKQ4mWz8WoyiI/6cq73NNLdiQqk5XCms9w
	fEul6JOViR/q1iqTFgT3RsLL4GEwME1LfEMO4PibF6r/wOMHPH2LADbdhEQAfagHC7nka/Usgx9
	zDXLzZrYJPXWdY/g1TIwSJdWRpfoslrGWKRoemuJ
X-Received: by 2002:a05:6a00:3c84:b0:730:9a85:c940 with SMTP id d2e1a72fcca58-732618fa927mr13972161b3a.20.1739774084845;
        Sun, 16 Feb 2025 22:34:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IET9NqXu9YhEF4OUJJNSE1yb6BAX22gJvAdfV1pFSU2HIsvMZxp0MWtpRcG1/tuk9BYS1lpew==
X-Received: by 2002:a05:6a00:3c84:b0:730:9a85:c940 with SMTP id d2e1a72fcca58-732618fa927mr13972118b3a.20.1739774084409;
        Sun, 16 Feb 2025 22:34:44 -0800 (PST)
Received: from hu-krichai-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73263b79287sm3771800b3a.29.2025.02.16.22.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 22:34:44 -0800 (PST)
From: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Date: Mon, 17 Feb 2025 12:04:12 +0530
Subject: [PATCH 5/8] bus: mhi: host: Add support to read MHI capabilities
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250217-mhi_bw_up-v1-5-9bad1e42bdb1@oss.qualcomm.com>
References: <20250217-mhi_bw_up-v1-0-9bad1e42bdb1@oss.qualcomm.com>
In-Reply-To: <20250217-mhi_bw_up-v1-0-9bad1e42bdb1@oss.qualcomm.com>
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
        quic_jjohnson@quicinc.com, quic_pyarlaga@quicinc.com,
        quic_vbadigan@quicinc.com, quic_vpernami@quicinc.com,
        quic_mrana@quicinc.com,
        Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739774050; l=2486;
 i=krishna.chundru@oss.qualcomm.com; s=20230907; h=from:subject:message-id;
 bh=nMXDxyNhjI58pEdLUQqctmcAdSRLINO8la+ypV3eSj8=;
 b=MQ6N/YxmXdZYM/h4EXUzjf7ED6A+e2TCUQqHV1U9ZjjlxWMDTUC6Zyc4oEzb++zTAGffYYHXK
 JcJtOZl/Yj6BrrVo1R/a0YARbkQE2A6ijYMZGz/E1wb3DcClbyjOwF9
X-Developer-Key: i=krishna.chundru@oss.qualcomm.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-Proofpoint-GUID: UUZCB3jsTqL2qK4ZnDlS0h9UUKT9K8kd
X-Proofpoint-ORIG-GUID: UUZCB3jsTqL2qK4ZnDlS0h9UUKT9K8kd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-17_03,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 malwarescore=0 bulkscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502170056

From: Vivek Pernamitta <quic_vpernami@quicinc.com>

As per MHI spec sec 6.6, MHI has capability registers which are located
after the ERDB array. The location of this group of registers is
indicated by the MISCOFF register. Each capability has a capability ID to
determine which functionality is supported and each capability will point
to the next capability supported.

Add a basic function to read those capabilities offsets.

Signed-off-by: Vivek Pernamitta <quic_vpernami@quicinc.com>
Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
---
 drivers/bus/mhi/common.h    |  4 ++++
 drivers/bus/mhi/host/init.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/drivers/bus/mhi/common.h b/drivers/bus/mhi/common.h
index dda340aaed95..eedac801b800 100644
--- a/drivers/bus/mhi/common.h
+++ b/drivers/bus/mhi/common.h
@@ -16,6 +16,7 @@
 #define MHICFG				0x10
 #define CHDBOFF				0x18
 #define ERDBOFF				0x20
+#define MISCOFF				0x24
 #define BHIOFF				0x28
 #define BHIEOFF				0x2c
 #define DEBUGOFF			0x30
@@ -113,6 +114,9 @@
 #define MHISTATUS_MHISTATE_MASK		GENMASK(15, 8)
 #define MHISTATUS_SYSERR_MASK		BIT(2)
 #define MHISTATUS_READY_MASK		BIT(0)
+#define MISC_CAP_MASK			GENMASK(31, 0)
+#define CAP_CAPID_MASK			GENMASK(31, 24)
+#define CAP_NEXT_CAP_MASK		GENMASK(23, 12)
 
 /* Command Ring Element macros */
 /* No operation command */
diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index a9b1f8beee7b..0b14b665ed15 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -467,6 +467,35 @@ int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl)
 	return ret;
 }
 
+static int mhi_get_capability_offset(struct mhi_controller *mhi_cntrl, u32 capability, u32 *offset)
+{
+	u32 val, cur_cap, next_offset;
+	int ret;
+
+	/* get the 1st supported capability offset */
+	ret = mhi_read_reg_field(mhi_cntrl, mhi_cntrl->regs, MISCOFF,
+				 MISC_CAP_MASK, offset);
+	if (ret)
+		return ret;
+	do {
+		if (*offset >= mhi_cntrl->reg_len)
+			return -ENXIO;
+
+		ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, *offset, &val);
+		if (ret)
+			return ret;
+
+		cur_cap = FIELD_PREP(CAP_CAPID_MASK, val);
+		next_offset = FIELD_PREP(CAP_NEXT_CAP_MASK, val);
+		if (cur_cap == capability)
+			return 0;
+
+		*offset = next_offset;
+	} while (next_offset);
+
+	return -ENXIO;
+}
+
 int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
 {
 	u32 val;

-- 
2.34.1


