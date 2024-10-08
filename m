Return-Path: <linux-kernel+bounces-355224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 488D3994C96
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 14:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C5101C24FA8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Oct 2024 12:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372FF1DF981;
	Tue,  8 Oct 2024 12:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kUKEqIuz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BB61DEFC8;
	Tue,  8 Oct 2024 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392111; cv=none; b=eQIr/VqJaqXcq1Zb4Jm1qLslyeNKdU8WRc09DjoWAK+DPFv3FZUgKhKmlwGKu6mqYPKgQ4tT96X3SQPVl/Q4hUBLSMlCktvbFBQJ2p0/hyPqCdlQuXRzVCQepRVSkEI+R9tj81Q7RN5soZz+nmZwWyA8nvbeSUJR68Ik80kS6tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392111; c=relaxed/simple;
	bh=zIKMNymzh3calR2YcOJ4dzupVmC+bIcnl6WLAC79MkY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O1d3okyxLvQrYV8oDyCIgfHnZUUbM4EeboAkOhK1jgWbXUim5YHwDkX6N5QFsoj4Z2oe3249By/046o+iFyr3kMeFohwva/sIfgphif6fz47I9vgw1xIaw9M4lPRxsb4jGfpmnsZ2Sh4SUKFHvCv47wnM3OOzOfRam4XsIRcUaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kUKEqIuz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4984SZUj008683;
	Tue, 8 Oct 2024 12:54:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5Y3aDgfRVLGgN3HidyyMfEpSeROSQeQY3w2wK0D8Bno=; b=kUKEqIuzgveRlMxZ
	h3oUIAcJ5m/MU7eVvfS+AY+ztwe/dj9kCTDjEgdwGnObt3KKJK6RFjder0B/bFgm
	X6hnOG8OHnNoAdXcUuH1WsBnzT1XGLA9gFUaBIJqHYX4K6+AaDV4x12GPHfVVw3d
	AE7IEtU5U+tZIGjU3noSYWO5KpLCB7BjVj9zOowMgzrXMEBPRLopfAgfIYL/OPQT
	KqfiyEXbKg5GjYoJXLrZrYV0p5bsF3R+TzhERSkID7txhLjafuJUXtqB8RDLCimt
	SM2RdzdLdC7UHtP7AzdSYUr4ruFmoyOon2dTRjSwOAKebGtB9RXRWdzwuxqizX7f
	HOjZ+A==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 424wrc1a87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 12:54:55 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 498CstDD018302
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 8 Oct 2024 12:54:55 GMT
Received: from hu-bibekkum-hyd.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 8 Oct 2024 05:54:50 -0700
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
To: <robdclark@gmail.com>, <will@kernel.org>, <robin.murphy@arm.com>,
        <joro@8bytes.org>, <jgg@ziepe.ca>, <jsnitsel@redhat.com>,
        <robh@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <quic_c_gdjako@quicinc.com>, <dmitry.baryshkov@linaro.org>
CC: <iommu@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <quic_bibekkum@quicinc.com>
Subject: [PATCH v16 4/5] iommu/arm-smmu: introduction of ACTLR for custom prefetcher settings
Date: Tue, 8 Oct 2024 18:24:09 +0530
Message-ID: <20241008125410.3422512-5-quic_bibekkum@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241008125410.3422512-1-quic_bibekkum@quicinc.com>
References: <20241008125410.3422512-1-quic_bibekkum@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: G2XJY01WNtfEcPUb8q1pQCvDGAxK6gmS
X-Proofpoint-ORIG-GUID: G2XJY01WNtfEcPUb8q1pQCvDGAxK6gmS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 clxscore=1015 spamscore=0
 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410080081

Currently in Qualcomm  SoCs the default prefetch is set to 1 which allows
the TLB to fetch just the next page table. MMU-500 features ACTLR
register which is implementation defined and is used for Qualcomm SoCs
to have a custom prefetch setting enabling TLB to prefetch the next set
of page tables accordingly allowing for faster translations.

ACTLR value is unique for each SMR (Stream matching register) and stored
in a pre-populated table. This value is set to the register during
context bank initialisation.

Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 26 ++++++++++++++++++++++
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 38ac9cab763b..2d2c1e75632c 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -252,6 +252,20 @@ static bool qcom_adreno_can_do_ttbr1(struct arm_smmu_device *smmu)
 	return true;
 }

+static void qcom_smmu_set_actlr_dev(struct device *dev, struct arm_smmu_device *smmu, int cbndx,
+		const struct of_device_id *client_match)
+{
+	const struct of_device_id *match =
+			of_match_device(client_match, dev);
+
+	if (!match) {
+		dev_dbg(dev, "no ACTLR settings present\n");
+		return;
+	}
+
+	arm_smmu_cb_write(smmu, cbndx, ARM_SMMU_CB_ACTLR, (unsigned long)match->data);
+}
+
 static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 		struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
 {
@@ -316,8 +330,20 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
 		struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
 {
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
+	const struct of_device_id *client_match;
+	int cbndx = smmu_domain->cfg.cbndx;
+
 	smmu_domain->cfg.flush_walk_prefer_tlbiasid = true;

+	client_match = qsmmu->data->client_match;
+
+	if (!client_match)
+		return 0;
+
+	qcom_smmu_set_actlr_dev(dev, smmu, cbndx, client_match);
+
 	return 0;
 }

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
index b55cd3e3ae48..8addd453f5f1 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h
@@ -28,6 +28,7 @@ struct qcom_smmu_match_data {
 	const struct qcom_smmu_config *cfg;
 	const struct arm_smmu_impl *impl;
 	const struct arm_smmu_impl *adreno_impl;
+	const struct of_device_id * const client_match;
 };

 irqreturn_t qcom_smmu_context_fault(int irq, void *dev);
--
2.34.1


