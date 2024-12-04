Return-Path: <linux-kernel+bounces-431082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 664E29E396A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 13:02:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5BEEB32CD8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED3021B3935;
	Wed,  4 Dec 2024 11:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NDwOxvNB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9602D1AF0BC
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 11:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733311437; cv=none; b=XbgbXuA8P5ftc/3EnFq0Z8NsThBGQgua1dbHPP31mNp+tHJYKt3aNRCFC193fvSiIcwaRqjqwun4HE/WTn103vsfMDD0eSqCqfIEzpjHNKWHH+HLrplFOEZDQHMTy8qpaYdgBSEZMytqzVVEia2IXB2Vemy4nQxx+l8jdWky+24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733311437; c=relaxed/simple;
	bh=cbiL5kZZuVyah+xYztbldPil5JXSMwG4j/rgVVR8czc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sQUd0RSVjPKc4LS33Z7XS9QbS1O5bjGDRQAJW+z2WwoX0Y4rYluMO1SSnRCB5hLfVg01nqtzIcPuN8ZLp1X1uP+qSTtyNTpXRB8emwfZgGK3IFEnbGH3nKYQH2SMqBlTm5lAxp4+wllzQW4YZ+8oHhPL9DjLIViYQBSl6Gs1gq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NDwOxvNB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B433V8p001110;
	Wed, 4 Dec 2024 11:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5idbvNyrHZyan+emBRP5C7
	lgPCobP/XRbc6txHnTLEA=; b=NDwOxvNBAUfsk3bEfVHrxExq2Id/7SZtn2eO3c
	4N6yPUpnB5VUyaUwGJ18Lw0rXbYfTp9F2plACvSnQfu45q/eJi47BkAacOaaj3DW
	ICyusTLTA9lm9IMD4Uw7ROy+JqPJnMMB9gndRciKEbxiV45LyM7H4lrOsy1FaXQ1
	VI28IPrVt/o6P2PJ1GL1LqT9RAuX9vf6HOI5ZmfnDWibXSlhwsTYKuRfPswMWOYI
	kU824B3pdLtgpeAL4BC21FpA4FdaIyq7mLcRYRDpxKOywOzpyh9mI/m5nY/L25Ww
	Aanuj2z7Q+0GHOvivRYZa6ODMR3NgADxP7+mjYVgrIp1XcWQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 439trbmfat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 11:23:46 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B4BNj3N029049
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 4 Dec 2024 11:23:45 GMT
Received: from yuanfang4-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 4 Dec 2024 03:23:43 -0800
From: yuanfang zhang <quic_yuanfang@quicinc.com>
To: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <james.clark@linaro.org>, <alexander.shishkin@linux.intel.com>
CC: <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] coresight-etm4x: add isb() before reading the TRCSTATR
Date: Wed, 4 Dec 2024 19:23:32 +0800
Message-ID: <20241204112332.3706137-1-quic_yuanfang@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tAWKaZHF7z1ZzZk6bCvBZS-GuwZIBb4N
X-Proofpoint-ORIG-GUID: tAWKaZHF7z1ZzZk6bCvBZS-GuwZIBb4N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=943 mlxscore=0
 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 clxscore=1015 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412040089

From: Yuanfang Zhang <quic_yuanfang@quicinc.com>

As recommended by section 4.3.7 ("Synchronization when using system
instructions to progrom the trace unit") of ARM IHI 0064H.b, the
self-hosted trace analyzer must perform a Context synchronization
event between writing to the TRCPRGCTLR and reading the TRCSTATR.

Fixes: ebddaad09e10 ("coresight: etm4x: Add missing single-shot control API to sysfs")
Signed-off-by: Yuanfang Zhang <quic_yuanfang@quicinc.com>
---
Change in V2:
Added comments in the code.
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 66d44a404ad0..decb3a87e27e 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -906,6 +906,13 @@ static void etm4_disable_hw(void *info)
 	tsb_csync();
 	etm4x_relaxed_write32(csa, control, TRCPRGCTLR);
 
+	/*
+	 * As recommended by section 4.3.7 ("Synchronization when using system
+	 * instructions to progrom the trace unit") of ARM IHI 0064H.b, the
+	 * self-hosted trace analyzer must perform a Context synchronization
+	 * event between writing to the TRCPRGCTLR and reading the TRCSTATR.
+	 */
+	isb();
 	/* wait for TRCSTATR.PMSTABLE to go to '1' */
 	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_PMSTABLE_BIT, 1))
 		dev_err(etm_dev,
-- 
2.34.1


