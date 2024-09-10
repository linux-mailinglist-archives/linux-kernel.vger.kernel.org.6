Return-Path: <linux-kernel+bounces-323429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5A7973D31
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EBECB21A32
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493791A01C6;
	Tue, 10 Sep 2024 16:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kh1s/v/D"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199DE1A2561;
	Tue, 10 Sep 2024 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985614; cv=none; b=k/o4UmUvuZU4Dy1RHHtTsCCYiX8am4LGjTKJfo/+jnKoyPwIHTLTob3fXQH7oCg4+Qjs/NfCfs7AwceIXu5/C8lkl7Xtzyiit7vzdPutnOOKgi7jykwG/BPTh9EchLBCJy4AgdcnK0d3c/riDbegmGkAtbpKvjhaH1cPHx9NcwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985614; c=relaxed/simple;
	bh=v2JgJC9HpnMsZ3+whc62AvZy1esUupU9st6hfrNoB5A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RXYWjKoNU4OHya6HP38q6srp2FWB37PBqKf/6C9JdFzj/Y5bfCWumgpdHoTEScIYhO4SMldL08YE235F0VawgUtUWzeUdbsHDi8ZQAaTWOpk46S+J7ZF3z7j0eUe+7+f2rMkGnXVsm+h+60GC+ZqUSVaIhacjiIuObeg7PlPbKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kh1s/v/D; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48AEnSaI020627;
	Tue, 10 Sep 2024 16:26:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=u2cqv/IwxjsiYNs6yIXCt8
	VkAWkTZmSA17ZK9KaYlZc=; b=kh1s/v/D/b9WDk8E36WYnTnEBnyEwWpm0tcPTb
	x7m1PmT7PL7PcgRd8VEGb5ZsEdZ33MBGI1FRy+5HQuoKUVm7CP3Z9WS3SKYQfeSO
	EKhMMxuAnLOG1FsIlgsD60CkPSfxngmoiwCO+eRBSN6Bequ9TgZb6WzyhBcaG1VA
	FITs6rdEeajjsrsOKyIVl3dYCDfumaCMjDV+Jbx784eHKnH1jEjW3pd9tYps9sCV
	dhEhHHg6DMOlXYBHafds4IOe9VCBX9iD50Z7v5ABIEAGdyQQJvn1Lhpv6e3C2ruR
	0gNhpJJHwVvmAuodx0+kNFUNtgj/Pg/YkjbbiF0HX72WuFKg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41he5dwva1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 16:26:50 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48AGQn1C014566
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Sep 2024 16:26:49 GMT
Received: from hu-nkela-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 10 Sep 2024 09:26:46 -0700
From: Nikunj Kela <quic_nkela@quicinc.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, <quic_psodagud@quicinc.com>,
        Nikunj Kela
	<quic_nkela@quicinc.com>
Subject: [PATCH v4] dt-bindings: arm: GIC: add ESPI and EPPI specifiers
Date: Tue, 10 Sep 2024 09:26:37 -0700
Message-ID: <20240910162637.2382656-1-quic_nkela@quicinc.com>
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
X-Proofpoint-ORIG-GUID: ddmV8iaQRJ2MSYTwBr3dNtB4MYpkBAi1
X-Proofpoint-GUID: ddmV8iaQRJ2MSYTwBr3dNtB4MYpkBAi1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 mlxlogscore=541 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409100122

Extended SPI and extended PPI interrupts are in the range [0-1023] and
[0-127] respectively, supported by GICv3.1.

Qualcomm SA8255p platform uses extended SPI for SCMI 'a2p' doorbells.

Signed-off-by: Nikunj Kela <quic_nkela@quicinc.com>
---

Changes in v4:
        - Included interrupts ranges in description

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


