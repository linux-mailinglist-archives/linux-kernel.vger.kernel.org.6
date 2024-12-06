Return-Path: <linux-kernel+bounces-434568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFA09E6866
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 09:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C7AA18848FB
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 08:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74961DC19D;
	Fri,  6 Dec 2024 08:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="e4inyVav"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930EF328B6
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 08:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733472202; cv=none; b=WyNJW53Ugj+WjAS8VH3uO+7gST+D6WJRMr7DMIH7z6+gmm44fgXzTILeO3Wryks8HGtbOCIMI9GBB+FMXWyY1+aqraSbgD4btj7e0D4s7PPpGutl0a/LX/9ISfY2sPyjuZgVOg/AClh720zGIzpWF/Bp7DDDAllfaAUZOvfoVZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733472202; c=relaxed/simple;
	bh=7Qg0ld3KNS8SSnkAKA1OYBh/JcQmMYGGZLyVNc3lkoY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kg8Xq3TK+TdrQi3cklAyYb/fLzJ1D3G4ZFs/lrcMCAQIj8rBKWawIUtrGBVuwTkcoMXIbGqLOghMB3805XdeiabkskjRvG+G9+aln+Mi7y/De2hwon4UpG/gK63s5SYWBmDabh+578jya7Ri71aV3smaQ5eBJdBlIgOSvUqr0gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=e4inyVav; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B67K6dR017344;
	Fri, 6 Dec 2024 08:03:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ucGUMusYobOB8Yj3mJm+2v
	HXtWbXKoebvtXTj9fn+XI=; b=e4inyVavW67KDdvlEswSCGT+6KfdCBDLpi3HBL
	17a10luqJuQ7Al2/2pnajxSVIda0cWhxClP0YNAk0wlHCo9h6zghAKAVD3CmxhtZ
	yICgoOUMwRowoMnymHJw4gAqRo317y1r6RcQ8oj4Hk3HtAZ1Q2078ZFwrsar5crw
	J4pgBKGpPetXsFwN1Aqjv/yRIE/iLEP6n7LrYQFmHDI4da1UPXBnjMG04l+m4ZeE
	XlCXqXBC8Pqa6durp9nrywYsBNf5jDrEvGpaTnZyq31VsCAYUqJhnnzX/1ZA2PVT
	qhhm4qTcbTgTq+3h3vHS36dSAho0ZWa8f1F5ozCh+V+lFy1w==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43bbnj2ut7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 08:03:09 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4B68389u029826
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 6 Dec 2024 08:03:08 GMT
Received: from yuanfang4-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 6 Dec 2024 00:03:05 -0800
From: yuanfang zhang <quic_yuanfang@quicinc.com>
To: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <james.clark@linaro.org>, <alexander.shishkin@linux.intel.com>
CC: <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] coresight-etm4x: add isb() before reading the TRCSTATR
Date: Fri, 6 Dec 2024 16:02:40 +0800
Message-ID: <20241206080240.59313-1-quic_yuanfang@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: M1qrAjJUvPAp_-U5nSwFYclPBDnClUmt
X-Proofpoint-ORIG-GUID: M1qrAjJUvPAp_-U5nSwFYclPBDnClUmt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 phishscore=0 impostorscore=0
 malwarescore=0 mlxlogscore=858 lowpriorityscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412060057

From: Yuanfang Zhang <quic_yuanfang@quicinc.com>

As recommended by section 4.3.7 ("Synchronization when using system
instructions to progrom the trace unit") of ARM IHI 0064H.b, the
self-hosted trace analyzer must perform a Context synchronization
event between writing to the TRCPRGCTLR and reading the TRCSTATR.

Fixes: ebddaad09e10 ("coresight: etm4x: Add missing single-shot control API to sysfs")
Signed-off-by: Yuanfang Zhang <quic_yuanfang@quicinc.com>
---
Changes in V3:
1. Remove dsb(sy) after polling TRCSTATR.
2. Add isb() after polling TRCSTATR.
---
 .../hwtracing/coresight/coresight-etm4x-core.c   | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 66d44a404ad0..c6ea00bba0cc 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -531,7 +531,6 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	 * As recommended by section 4.3.7 ("Synchronization when using the
 	 * memory-mapped interface") of ARM IHI 0064D
 	 */
-	dsb(sy);
 	isb();
 
 done:
@@ -906,10 +905,25 @@ static void etm4_disable_hw(void *info)
 	tsb_csync();
 	etm4x_relaxed_write32(csa, control, TRCPRGCTLR);
 
+	/*
+	 * As recommended by section 4.3.7 ("Synchronization when using system
+	 * instructions to progrom the trace unit") of ARM IHI 0064H.b, the
+	 * self-hosted trace analyzer must perform a Context synchronization
+	 * event between writing to the TRCPRGCTLR and reading the TRCSTATR.
+	 */
+	if (!csa->io_mem)
+		isb();
+
 	/* wait for TRCSTATR.PMSTABLE to go to '1' */
 	if (coresight_timeout(csa, TRCSTATR, TRCSTATR_PMSTABLE_BIT, 1))
 		dev_err(etm_dev,
 			"timeout while waiting for PM stable Trace Status\n");
+	/*
+	 * As recommended by section 4.3.7 (Synchronization of register updates)
+	 * of ARM IHI 0064H.b.
+	 */
+	isb();
+
 	/* read the status of the single shot comparators */
 	for (i = 0; i < drvdata->nr_ss_cmp; i++) {
 		config->ss_status[i] =
-- 
2.34.1


