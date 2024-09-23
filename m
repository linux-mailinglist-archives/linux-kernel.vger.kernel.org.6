Return-Path: <linux-kernel+bounces-334495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F43097D7F8
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 18:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 408EA287A60
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 16:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8390F181B80;
	Fri, 20 Sep 2024 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="POnTdsrY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4997617DFF1;
	Fri, 20 Sep 2024 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726847979; cv=none; b=jJ2NZGiN8F2VfDk+H7S6FlS+/ezH2j906o/JsbeUP6Rqh/OmUOpAn51Jk8/AuSYNx3wt6Ebasrqcj9fO+3WIT5bB2hXhqRyQ/s4wOuzUSxE2FQSHYQTKX7sBbWm5umdQwicquGV6yd/Vr74Znd3H0YxrxGlRugedMQ43SgbItrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726847979; c=relaxed/simple;
	bh=a5u0nrsBvJPFtQqVD782CMJ9K5DcjHsuW8ISsjQp5f0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=imICv3cWYJi6caplW2nZxQYuC0yIOFexblVwEPCNLVq2YbTan2eAaM075g8lVNDubGKjK7xImYRAuxGwmpP3D0GZD2YU4ylCpZ+d5NPxuez+cEKSiBPtoues1FmWXQ/VvY1EWaROaIlksEjXRlkVhgawCZkBT37qQFzAH5/o6nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=POnTdsrY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48K8EFYm006893;
	Fri, 20 Sep 2024 15:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pisCdr9NWnrRRgIMMBRCLbDY/8BeAAtZDiDWE+77Llw=; b=POnTdsrYWlznbIdS
	zwMKpfXJrYqkCupWJyr20kXpuqaiGwepdWnxVxRjmSqzo8qTl6oVWjWSOtLO6LvP
	zfUovE2DWE8qJsCnlQrN+n8i7FqwxmFhWLC9bb/rS19W8fT/xW6UGNWZ5q0cYjvX
	5e+MCve1f6ozY4sjqBqj+xzmXxAXSkkw1h2GogfidpNYKyloQCRmBuAc/Va9Aegn
	Ks9POvVrEkc0Y3/boCCHQX9hwyDmrxKvgQOh314+tjRP3R1DeRDnBAmfbQ6gROgl
	/O9HK/H/OU8+hUgFnpczPDWJZxb8sRDzrXiO0DAisz3GQ9jLcCyMFHpaqp14D1Ua
	YxL4Pg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4k11x0n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 15:59:11 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48KFxA5Q031641
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 15:59:10 GMT
Received: from hu-bibekkum-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 20 Sep 2024 08:59:05 -0700
From: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
To: <robdclark@gmail.com>, <will@kernel.org>, <robin.murphy@arm.com>,
        <joro@8bytes.org>, <jgg@ziepe.ca>, <jsnitsel@redhat.com>,
        <robh@kernel.org>, <krzysztof.kozlowski@linaro.org>,
        <quic_c_gdjako@quicinc.com>, <dmitry.baryshkov@linaro.org>
CC: <iommu@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <quic_bibekkum@quicinc.com>, Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v15 1/5] iommu/arm-smmu: re-enable context caching in smmu reset operation
Date: Fri, 20 Sep 2024 21:28:09 +0530
Message-ID: <20240920155813.3434021-2-quic_bibekkum@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240920155813.3434021-1-quic_bibekkum@quicinc.com>
References: <20240920155813.3434021-1-quic_bibekkum@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: tV3Jt6KqT-6NrD7MrfVFycRuO_D3JfS4
X-Proofpoint-GUID: tV3Jt6KqT-6NrD7MrfVFycRuO_D3JfS4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 mlxlogscore=999 clxscore=1011
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409200117

Default MMU-500 reset operation disables context caching in
prefetch buffer. It is however expected for context banks using
the ACTLR register to retain their prefetch value during reset
and runtime suspend.

Replace default MMU-500 reset operation with Qualcomm specific reset
operation which envelope the default reset operation and re-enables
context caching in prefetch buffer for Qualcomm SoCs.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 45 ++++++++++++++++++++--
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 087fb4f6f4d3..0cb10b354802 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -16,6 +16,16 @@

 #define QCOM_DUMMY_VAL	-1

+/*
+ * SMMU-500 TRM defines BIT(0) as CMTLB (Enable context caching in the
+ * macro TLB) and BIT(1) as CPRE (Enable context caching in the prefetch
+ * buffer). The remaining bits are implementation defined and vary across
+ * SoCs.
+ */
+
+#define CPRE			(1 << 1)
+#define CMTLB			(1 << 0)
+
 static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
 {
 	return container_of(smmu, struct qcom_smmu, smmu);
@@ -396,11 +406,40 @@ static int qcom_smmu_def_domain_type(struct device *dev)
 	return match ? IOMMU_DOMAIN_IDENTITY : 0;
 }

+static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
+{
+	int ret;
+	u32 val;
+	int i;
+
+	ret = arm_mmu500_reset(smmu);
+	if (ret)
+		return ret;
+
+	/*
+	 * arm_mmu500_reset() disables CPRE which is re-enabled here.
+	 * The errata for MMU-500 before the r2p2 revision requires CPRE to be
+	 * disabled. The arm_mmu500_reset function disables CPRE to accommodate all
+	 * RTL revisions. Since all Qualcomm SoCs are on the r2p4 revision, where
+	 * the CPRE bit can be enabled, the qcom_smmu500_reset function re-enables
+	 * the CPRE bit for the next-page prefetcher to retain the prefetch value
+	 * during reset and runtime suspend operations.
+	 */
+
+	for (i = 0; i < smmu->num_context_banks; ++i) {
+		val = arm_smmu_cb_read(smmu, i, ARM_SMMU_CB_ACTLR);
+		val |= CPRE;
+		arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_ACTLR, val);
+	}
+
+	return 0;
+}
+
 static int qcom_sdm845_smmu500_reset(struct arm_smmu_device *smmu)
 {
 	int ret;

-	arm_mmu500_reset(smmu);
+	qcom_smmu500_reset(smmu);

 	/*
 	 * To address performance degradation in non-real time clients,
@@ -427,7 +466,7 @@ static const struct arm_smmu_impl qcom_smmu_500_impl = {
 	.init_context = qcom_smmu_init_context,
 	.cfg_probe = qcom_smmu_cfg_probe,
 	.def_domain_type = qcom_smmu_def_domain_type,
-	.reset = arm_mmu500_reset,
+	.reset = qcom_smmu500_reset,
 	.write_s2cr = qcom_smmu_write_s2cr,
 	.tlb_sync = qcom_smmu_tlb_sync,
 #ifdef CONFIG_ARM_SMMU_QCOM_DEBUG
@@ -461,7 +500,7 @@ static const struct arm_smmu_impl qcom_adreno_smmu_v2_impl = {
 static const struct arm_smmu_impl qcom_adreno_smmu_500_impl = {
 	.init_context = qcom_adreno_smmu_init_context,
 	.def_domain_type = qcom_smmu_def_domain_type,
-	.reset = arm_mmu500_reset,
+	.reset = qcom_smmu500_reset,
 	.alloc_context_bank = qcom_adreno_smmu_alloc_context_bank,
 	.write_sctlr = qcom_adreno_smmu_write_sctlr,
 	.tlb_sync = qcom_smmu_tlb_sync,
--
2.34.1


