Return-Path: <linux-kernel+bounces-340498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA8198742C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9E6CB23AF3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 13:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25C0219FC;
	Thu, 26 Sep 2024 13:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZpeKJYNh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9980B49659
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 13:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727356068; cv=none; b=h7nq00K5drYdK6A0A2uMEAcYggJ3iFzh9GX/WQOQNa174CKIqoBQlkVyJ9WLW1sXkT9rnfTAh3P0+1WbiNrApmKR9p6Kb3cMYIYChS3lUhwIkEkMpjSlOlnnPCpD6or1zsePms1Btdfizf92n7mnR25mYp20ecDI/nnKxzmGNhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727356068; c=relaxed/simple;
	bh=abluw+uDhZH9xO1wLDvHzV2Fu+WSUoUPv8tOQ3se4aM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u1TBujAJzKiO79reK5VjHwcVAS/EjdgWUs0WTWKSQo0SHyfQTx4XYoclZPZUUIFDGIyWaN4wQ7edOb1Niez8QLOQWh4xX7AJaqh7L7tzzGWjbv4tCKaV2QsxiNV4k0shMltPQh+LZYURP4U+USToRSUfNa819N7+eR8iu7sZOFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZpeKJYNh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48Q78bwJ032278;
	Thu, 26 Sep 2024 13:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=VmvN773oK2qiJqCjQ8MT+b8UEiP9dQDcSI0FSU82/O4=; b=Zp
	eKJYNhNbuZXeqPDsvFBo/je6O7SbvdYIbl1QzALg67el/c1yS9IZrf7DKBIu0FCZ
	fDCO8DQay/mpEIkoaFbXezlQu/kXxt8QdcIXmlL/eEc8idu0U9oLmc6L4ZnDIR1r
	c8KCrAmYiYmGvLuMcCBuVVrDqCKZG/9cwtHAziLxcgu+R+UN61Mm+me2GDzRT9Aw
	zcwshSxFxo9qKdmBMHEVvqBcQNpqBQddO6AwoNNdMLzsYW3RxgV77NU5/AYzVG21
	uFKJbv/umtZScR2Psn1oSxtmLlh07lsJkSXyzBkICnH68HmMlLbymz2E4RJg6Ged
	dsrk+4Ga32+wPt0cKZrw==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41sp7uqqx9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Sep 2024 13:07:25 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48QD7OWZ002041
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Sep 2024 13:07:24 GMT
Received: from hu-pbrahma-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 26 Sep 2024 06:07:20 -0700
From: Pratyush Brahma <quic_pbrahma@quicinc.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>
CC: <quic_bjorande@quicinc.com>, <geert+renesas@glider.be>,
        <dmitry.baryshkov@linaro.org>, <krzysztof.kozlowski@linaro.org>,
        <neil.armstrong@linaro.org>, <johan+linaro@kernel.org>,
        <arnd@arndb.de>, <nfraprado@collabora.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Pratyush Brahma <quic_pbrahma@quicinc.com>
Subject: [PATCH] arm64: defconfig: Enable DMABUF heaps support
Date: Thu, 26 Sep 2024 18:37:03 +0530
Message-ID: <20240926130703.7817-1-quic_pbrahma@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: C6C5jf0iqErlUv289sbbc9XjDbAf6VPW
X-Proofpoint-ORIG-GUID: C6C5jf0iqErlUv289sbbc9XjDbAf6VPW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 bulkscore=0 mlxlogscore=407 mlxscore=0 phishscore=0
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409260090

Enable the DMABUF heaps, system heap and default cma heap,
required on Qualcomm SoCs (e.g. qcm6490) for sharing buffers
across different subsystems.

Signed-off-by: Pratyush Brahma <quic_pbrahma@quicinc.com>
---
 arch/arm64/configs/defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 7d32fca64996..106b8029d989 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1233,6 +1233,9 @@ CONFIG_RENESAS_USB_DMAC=m
 CONFIG_RZ_DMAC=y
 CONFIG_TI_K3_UDMA=y
 CONFIG_TI_K3_UDMA_GLUE_LAYER=y
+CONFIG_DMABUF_HEAPS=y
+CONFIG_DMABUF_HEAPS_SYSTEM=y
+CONFIG_DMABUF_HEAPS_CMA=y
 CONFIG_VFIO=y
 CONFIG_VFIO_PCI=y
 CONFIG_VIRTIO_PCI=y
-- 
2.17.1


