Return-Path: <linux-kernel+bounces-380922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB1F9AF7EA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 05:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 865BC283453
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 03:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8A3D18BC14;
	Fri, 25 Oct 2024 03:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Wqm/aA8D"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4F618A6AB;
	Fri, 25 Oct 2024 03:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729825705; cv=none; b=XDsK3dvV0t8dJDrra0F9RMoXo4f5ALs9dqkdM80hB2nhpjPhZQqEUIVbEYWbrE2M+hdtFRvVWaJaQQlvcfT+RC81LGGHnZbscrPy3lHGaaYIFP/dzTGj3SC2vuQR90ijJ3wp/FxJi/goS8VvbCtlua71Oh+0g+TvglEdAT/+INw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729825705; c=relaxed/simple;
	bh=PiCeQjw19I7twhe/HrEaA5kwu1gqzx/zpNYDwIx/6PM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NWgdov9X9eOBIMxpyt3gQWID+hG70IZhKjIKxr6YK7m7mLIiGiZOoLFaVvkGvSB7ET1dYj9HELvwqYJRBgNIRxdHHOLxit5fxLSFQedPA73LY7WhAD6lj3rYZzcQtG9aMus4QOJLlqwOty4JrOnLjX0W20fzrKABvvBc3F3Y1No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Wqm/aA8D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ONeoSX032158;
	Fri, 25 Oct 2024 03:08:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=MVUAuuvrnKAmF45OK7oL/BUmQXyD5eMpa3MUREdxnUI=; b=Wq
	m/aA8Dh4xHFiKF8t5hicGQ6HPRQtZ7/73Vw1q7tb4O/0EKxRd2yRH/6lwdCCrO/+
	jdvnsnTuh4VF4Aoc/0zYq5yUYTN9bvLsW6YUZM+b6B6WywopQ57RbeNA+Qty/ZCi
	3Q2gQWrGeHiVovrB56iNgphnXPsGUmLQfa+68RXagVzmGVqgtRPGm5QSg4PgdnPE
	u4RnMaLlou20JQGfmJBostiWyZ7EbXIQWkORoGkv2f/ioeHK0cPrDWWOP+/U2EdY
	ECBjKscJa/BFFqS4Lm3fF6oQP/EiNdoPCunOs4X8SMYn6Y5NVK6Yiy+cQF37ats/
	fjcnd9KNk0vLKcgSnLvA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3vyky4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 03:08:09 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49P388G0032614
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 03:08:08 GMT
Received: from hu-qqzhou-sha.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 24 Oct 2024 20:08:05 -0700
From: Qingqing Zhou <quic_qqzhou@quicinc.com>
To: <andersson@kernel.org>, <konradybcio@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <robimarko@gmail.com>,
        <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
        Qingqing Zhou
	<quic_qqzhou@quicinc.com>
Subject: [PATCH v3 0/4] Add support for APPS SMMU on QCS615
Date: Fri, 25 Oct 2024 08:37:28 +0530
Message-ID: <20241025030732.29743-1-quic_qqzhou@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AwAFxU2NAkGIpegGB_9Y9uYOpaGXEPLe
X-Proofpoint-ORIG-GUID: AwAFxU2NAkGIpegGB_9Y9uYOpaGXEPLe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250021

Enable APPS SMMU function on QCS615 platform. APPS SMMU is required
for address translation in devices including Ethernet/UFS/USB and
so on.

Add the SCM node for SMMU probing normally. SMMU driver probe will
check qcom_scm ready or not, without SCM node, SMMU driver probe will
defer.
The dmesg log without SCM node:
platform 15000000.iommu: deferred probe pending: arm-smmu: qcom_scm not ready

With the SCM node, SMMU can probe normally, but SCM driver still fails
to probe because of one SCM bug:
qcom_scm firmware:scm: error (____ptrval____): Failed to enable the TrustZone memory allocator
qcom_scm firmware:scm: probe with driver qcom_scm failed with error 4
The above SCM bug has been fixed and applied:
https://lore.kernel.org/all/172965696408.224417.2033308332604008573.b4-ty@kernel.org/#t
But above patch doesn't impact building of current patch series which
can build successfully without above patch.

This patch series depends on below patch series:
https://lore.kernel.org/linux-arm-msm/20241022-add_initial_support_for_qcs615-v4-0-0a551c6dd342@quicinc.com/

Changes in v3:
- Align the interrupts of the APPS SMMU node suggested by Konrad.
- Add the Acked-by tag in the commit message of SCM bindings patch.
- Update the dependency link, SCM bug fix link and base-commit in
  cover letter.
- Link to v2: https://lore.kernel.org/linux-arm-msm/20241015081603.30643-1-quic_qqzhou@quicinc.com/

Changes in v2:
- Add the compatible "qcom,qcs615-smmu-500" into no-clocks list for
  arm,smmu.yaml suggested by Krzysztof.
- Improve the commit messages and cover letter.
- Link to v1: https://lore.kernel.org/all/20241011063112.19087-1-quic_qqzhou@quicinc.com/

Qingqing Zhou (4):
  dt-bindings: firmware: qcom,scm: document QCS615 SCM
  dt-bindings: arm-smmu: document QCS615 APPS SMMU
  arm64: dts: qcom: qcs615: add the SCM node
  arm64: dts: qcom: qcs615: add the APPS SMMU node

 .../bindings/firmware/qcom,scm.yaml           |  1 +
 .../devicetree/bindings/iommu/arm,smmu.yaml   |  2 +
 arch/arm64/boot/dts/qcom/qcs615.dtsi          | 81 +++++++++++++++++++
 3 files changed, 84 insertions(+)


base-commit: 7436324ebd147598f940dde1335b7979dbccc339
prerequisite-patch-id: 3a76212d3a3e930d771312ff9349f87aee5c55d5
prerequisite-patch-id: 8a2454d5e07e56a6dd03f762f498051065635d85
prerequisite-patch-id: 46cdc5640598b60d2f5449af444d6d4e479c00b8
prerequisite-patch-id: 050d1dd8cc9397618e570e6de2d81d0c32c10d7a
prerequisite-patch-id: cd9fc0a399ab430e293764d0911a38109664ca91
prerequisite-patch-id: 07f2c7378c7bbd560f26b61785b6814270647f1b
prerequisite-patch-id: f9680e3c90d8f05babbcadd7b7f5174f484a8275
prerequisite-patch-id: f78398623b7f08ae1183a4e637045a081bc93ec8
prerequisite-patch-id: 54b4dd987711302b083f714c6f230726c7781042
prerequisite-patch-id: 624720e543d7857e46d3ee49b8cea413772deb4c
prerequisite-patch-id: 04ca722967256efddc402b7bab94136a5174b0b9
prerequisite-patch-id: ab88a42ec69ad90e8509c9c5b7c6bdd595a7f783
prerequisite-patch-id: 918724fafe43acaa4c4b980bfabe36e9c3212cd1
prerequisite-patch-id: 203a45a2f2a8c636ad88b6c0d4868721dc34633d
prerequisite-patch-id: fc1cfec4ecd56e669c161c4d2c3797fc0abff0ae
-- 
2.17.1


