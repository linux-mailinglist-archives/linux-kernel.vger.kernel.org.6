Return-Path: <linux-kernel+bounces-216225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD032909CE1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 11:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D109D1C20327
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jun 2024 09:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3CB616D9B5;
	Sun, 16 Jun 2024 09:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QjDxLQaE"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C33D185080
	for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 09:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718531669; cv=none; b=BhxHxTD6JEON6nOZooP/+3lxkFGSGDaBeSknrPbpVIWb2DdVnIwF/SQGNQWtmGq5v7PLWMR95739rchiOzfw97aMYkZNAUrneseTmhO11aMAgMNZhaB66RlC2/XArmFeMsV3ox+lrIP9sISwtPpDf9yVxuD3/AnNodkW7vSLBeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718531669; c=relaxed/simple;
	bh=5QDDjLp1jzm2+zuXtQcNEAnSW+WHWSuGo7ed7D2abg0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NYwEFnucQsBMv6NBsj8N8JXq0KCVvSALf/MYuOy1NLsweKG77zQWqLX4hwTE2usZmcuX4mhl0/GRJ1dgA8KCV7JJoIDh1Bl531dw5yK1hreizFzWTF7worZSy/hgC6OGTS+19gGkr/+/Wk5+CKLVyy3WD0EBFbb6QAx7RtVFcB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QjDxLQaE; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45G9gwV7019620;
	Sun, 16 Jun 2024 09:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=Kk8cl7a+vOxJypJJzEiSAGXmvC+x47fky4QvRVdDLO0=; b=Qj
	DxLQaE8mPfopIGIiTMXeaDxDp3Xp/M2ZcJOhBhGvR0V6Vzw2EXafyzEwvDVs+l0V
	UlNtCu9LuJAbG4SVeVgNgrIHeJA2tFLYIIEOUTETFNCYdiE4jIyp7kv7Y1DXsS/O
	vc0OZf+eKwZ2sX9WHhvQPASSyM7mVaEY6EIWvnzjaepeBey6EQgiuL4T243PzVuT
	baNp86K7G4NFeTcXryYc/vYn0zWLTu2KVKKKJxhmHfsUv3IooaPaysRwxNgdxAfa
	rpUiwnX5wzpVu3m/wDrDzPiMI7NpOTgvyKL2950YJB82+tU041Pr19wzwkoA4x3A
	UPzYqAdek8D9krrbLd8A==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ys3qf1m0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Jun 2024 09:54:20 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45G9sKTa019329
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Jun 2024 09:54:20 GMT
Received: from zijuhu-gv.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 16 Jun 2024 02:54:18 -0700
From: Zijun Hu <quic_zijuhu@quicinc.com>
To: <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC: <andriy.shevchenko@linux.intel.com>, <brgl@bgdev.pl>,
        <linux-kernel@vger.kernel.org>, Zijun Hu <quic_zijuhu@quicinc.com>
Subject: [PATCH v1] devres: Fix devm_krealloc() allocating memory with wrong size
Date: Sun, 16 Jun 2024 17:54:15 +0800
Message-ID: <1718531655-29761-1-git-send-email-quic_zijuhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 52jNVyWkhWsYlibZnf5NaaypKZRGMi4z
X-Proofpoint-ORIG-GUID: 52jNVyWkhWsYlibZnf5NaaypKZRGMi4z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-16_08,2024-06-14_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 malwarescore=0 spamscore=0 mlxlogscore=755 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406160077

Kernel API devm_krealloc() calls alloc_dr() with wrong argument
@total_new_size, and it will cause more memory to be allocated
than required, fixed by using @new_size as alloc_dr()'s argument.

Fixes: f82485722e5d ("devres: provide devm_krealloc()")
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/base/devres.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/devres.c b/drivers/base/devres.c
index 3df0025d12aa..1cf87ddf1f55 100644
--- a/drivers/base/devres.c
+++ b/drivers/base/devres.c
@@ -898,7 +898,7 @@ void *devm_krealloc(struct device *dev, void *ptr, size_t new_size, gfp_t gfp)
 	 * taking the lock as most probably the caller uses GFP_KERNEL.
 	 */
 	new_dr = alloc_dr(devm_kmalloc_release,
-			  total_new_size, gfp, dev_to_node(dev));
+			  new_size, gfp, dev_to_node(dev));
 	if (!new_dr)
 		return NULL;
 
-- 
2.7.4


