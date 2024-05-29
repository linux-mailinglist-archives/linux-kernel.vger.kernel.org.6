Return-Path: <linux-kernel+bounces-194663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 261A28D3FA5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAE5728209C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 20:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107071C8FA6;
	Wed, 29 May 2024 20:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P13N+e0n"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70501B960;
	Wed, 29 May 2024 20:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717014775; cv=none; b=RM/wZBUof1AXLtCtC/bA1DI6IsPEmq+865hoouCvHUbbcNZY4nlr1mTzb4rK/WXaXF4drY6QstdIFWxdWG/Fjm66jPOENuR9uhfTs3xsxaYEH/JLdyYZAE6Kusw6ZV8+Uf7ue3EXbOEd0p5Gr4B+lmh8axJNzmznLzJLIZbM/Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717014775; c=relaxed/simple;
	bh=EdWnHQisu1nrswQypPdNPBhY3Mgg5x+zg7G0J6Hj/q4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=FRWEGNfWFAhYdQp+b2P30Id78MbJy711b0zN6ck57gc1+bBgJ1+Vlfnng5Ze3xtCYggirWQcvrPfD7HAcUx4Z+aNBdZGAv8nSKk8sqxC/pvrLiyfW9W+EhQ7JsAZI13Jlb5eD4+nWfQmNdAo+I9BkPHlEBUBZPMD7FCTMGyHXwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=P13N+e0n; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44TJW7iL003995;
	Wed, 29 May 2024 20:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=rCqFl5f8RO2DUzlXJ5cFQD
	L60x4q3eGy6NQrAJMF/r8=; b=P13N+e0nLlzHkS/d1IvFC5Y3jVCeytJHUg8yy9
	6VCD7lOFPIXYE7NjX9K07O8/yj9MgvV23ANuPZA5kLANc0PwKsl5+awt0A0pxE8D
	JClwYS2qTpIC/2UJ5oZ3jBf6yZf2D0XsWhMAsYnPsP31bwuyNxvahieK/qwpJ52n
	MMwoVHGEu5UYoDj9qqSQtLASVg9hD2S3y2aSj8tp/m5uGtvpSBG8bPvSw+iEGR1E
	XCSllY/yubYXtCDxzfE3tjbdb7WjS5SGwXEwWb9JiIIrGaKn5PYC67tq9nOd0hQp
	XJ6wM5SJTrPc3gqYQyzNrQHkP57vVd4CIEiATUn+5Vgu5DQQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba0xaa49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 20:32:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44TKWmBZ006478
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 20:32:48 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 May
 2024 13:32:48 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Wed, 29 May 2024 13:32:46 -0700
Subject: [PATCH] scftorture: add MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240529-md-scftorture-v1-1-c9f557365953@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAO2QV2YC/x3MQQqDMBBA0avIrDug0aD1KqWLJI51oEaZiUUQ7
 27s8i3+P0BJmBT64gChHysvMaN6FBAmFz+EPGSDKU1TWvPEeUANY1okbUJIwZvOtrVtuwpyswq
 NvP9/r3e2d0roxcUw3Zcvx23H2WkigfO8ALPbvkl+AAAA
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -4ge-gzZYSwUr0S9KVX9vwmuFy3BWmqn
X-Proofpoint-ORIG-GUID: -4ge-gzZYSwUr0S9KVX9vwmuFy3BWmqn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_16,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxlogscore=917 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2405290144

Fix the 'make W=1' warning:
WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/scftorture.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 kernel/scftorture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 59032aaccd18..c20c6eb8389d 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -43,6 +43,7 @@
 
 #define SCFTORTOUT_ERRSTRING(s, x...) pr_alert(SCFTORT_FLAG "!!! " s "\n", ## x)
 
+MODULE_DESCRIPTION("Torture tests on the smp_call_function() family of primitives");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@kernel.org>");
 

---
base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
change-id: 20240529-md-scftorture-ecb285735781


