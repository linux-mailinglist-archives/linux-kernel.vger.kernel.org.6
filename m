Return-Path: <linux-kernel+bounces-319975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5C9970498
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 03:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8901F2830BA
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 01:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414CF6FA8;
	Sun,  8 Sep 2024 01:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f31NDp+N"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3C7181;
	Sun,  8 Sep 2024 01:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725757353; cv=none; b=A12DruV3FZEeac/JrRaZLDSPw0uSSNYz3xVIpNaHe4e/p732yueJRenqEcAkudLiS4S4BNtrKzKYA7n8auM30G9w1hDKLxp+2kA/s9nNRLk3WLNBFyHLO1ilfBk3MGDUNpL+Fz1JvlszhsTT7Agsxtr6unPvXHy/PtF1f2snlwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725757353; c=relaxed/simple;
	bh=F0s7ixT9XH5I6XOBr+KkTkTMxUaSIGOaGHhl2A4jZKI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kwKH1LAXDm30TwPs84Zp7J4SuGPmlvGGDYC9ZiMzLDZ4tgFGRRgXtzLvg8k/MirrPIzJMO3nXz5sJZg7Hdj7CD2/a3TksnUutp6QAKP8oZumy6ZfeA/m6Fjk08ycXJC0LtGWalAxeieS2bCO6luFh74poiws7DAJIl0Gr6A/77g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f31NDp+N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4880fnkh014185;
	Sun, 8 Sep 2024 01:02:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=9+3mVQXFRnFOnGuVXqAeii
	ZKG/0loiyMqVxdiPFiiSo=; b=f31NDp+NW5l1v9X3SQ6DuXOFXG+1XmzBuJPJLk
	B7lccsJvJaz4vzCX2QqtXg9f+tL/QBpATirTOykUS/7BfBEBEi7HyJOljXFlpvIu
	UkESAg/08fCwSnRbP7VpTlL9RTjq+2mEZadK3lhTrUR56fm3wRWybma2+l2mvLY9
	Mw8uZ1bX/mHE+KLdBxM4it7E7YNLOiaXxCPQ1pvzQ48YBXP/yXjjUv6H2lPaFFej
	jyGuFY5EJguF4VCyNuzmWMmozTChFDyh2HUKFiyitQbRNbYjVMO7654HF3/5Vnj8
	qQCyOITspWhIuANBI4maK0Qx1t+UTX5fdelYcZVQkeAuU90w==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41gy59r4ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 08 Sep 2024 01:02:22 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48812M3O014068
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 8 Sep 2024 01:02:22 GMT
Received: from hu-nkela-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 7 Sep 2024 18:02:18 -0700
From: Nikunj Kela <quic_nkela@quicinc.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, <quic_psodagud@quicinc.com>,
        Nikunj Kela
	<quic_nkela@quicinc.com>
Subject: [PATCH v3] dt-bindings: arm: GIC: add ESPI and EPPI specifiers
Date: Sat, 7 Sep 2024 18:02:05 -0700
Message-ID: <20240908010205.863701-1-quic_nkela@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V5b_YhaldSlPk4b-Z_9qpa8eZ8lK6Fqr
X-Proofpoint-ORIG-GUID: V5b_YhaldSlPk4b-Z_9qpa8eZ8lK6Fqr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 mlxlogscore=543 phishscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409080007

Add interrupt specifier for extended SPI and extended PPI interrupts.

Qualcomm SA8255p platform uses extended SPI for SCMI 'a2p' doorbells.

Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
---

Changes in v3:
	- Removed the patch from original series[1]

Changes in v2:
	- Modified subject line and description
	- Added EPPI macro

[1]: https://lore.kernel.org/all/20240903220240.2594102-1-quic_nkela@quicinc.com/
---
 include/dt-bindings/interrupt-controller/arm-gic.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/interrupt-controller/arm-gic.h b/include/dt-bindings/interrupt-controller/arm-gic.h
index 35b6f69b7db6..887f53363e8a 100644
--- a/include/dt-bindings/interrupt-controller/arm-gic.h
+++ b/include/dt-bindings/interrupt-controller/arm-gic.h
@@ -12,6 +12,8 @@
 
 #define GIC_SPI 0
 #define GIC_PPI 1
+#define GIC_ESPI 2
+#define GIC_EPPI 3
 
 /*
  * Interrupt specifier cell 2.
-- 
2.34.1


