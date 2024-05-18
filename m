Return-Path: <linux-kernel+bounces-182998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0138C9308
	for <lists+linux-kernel@lfdr.de>; Sun, 19 May 2024 01:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B2D11C20A61
	for <lists+linux-kernel@lfdr.de>; Sat, 18 May 2024 23:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530856D1B4;
	Sat, 18 May 2024 23:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KIzdWqU2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED4D1A28C;
	Sat, 18 May 2024 23:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716074340; cv=none; b=rv9vHj/bNBK2IIbp8CrXFysU1kSlkoQO0JBvTw/LnJj70EbIjeDGeTTXq7Jw/3VnjVIo1kslph1KLrMM5SYfk2C/WaQCEvj32A++CaN+sVnqtD1NhRxeDji39fNbNb3xUp/wd8CVKChmoGuPIaMa4AW7qeRhrlEVMZLGK47+Kjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716074340; c=relaxed/simple;
	bh=TH/yo8G5DWhAzjG42jYMIuqw31qhzP6QKwEBZxtrsXw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=E4BQH6Z3sXZHtk0nXr28Kg0vaYUWwRhGLmDj2TdQkqQfG2G/azRuWP1vahZsbAiX8+OPq2v4ezVIdgMgkRpaDbfR8+jmPIxCndsaJYFkGuc3rAdA7AmjkCmZfxpxQoD227Qc6MJNcv2fEWidH5kqojRc8D+CBI+PdVfpoqFG7Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KIzdWqU2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44IMqMFl015368;
	Sat, 18 May 2024 23:18:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=rNe
	h6oapn4i0biCv2vB3sPE8P2fWJClpeveqLP08ScA=; b=KIzdWqU2iOEp6XAWlDv
	4qQ93IpWjNXbf+vCOlFcwr4v4GkYP0fKIcu66OdAThVt/S4hrsyGH1kHge2vo0dX
	wdsFA5XWpFLH7Z0H/TqJUQTj2vBaExyx71s76pkty4HFyQMKuuDSgA1dp7tig66S
	xinCSZuPddV6VECMx6Y+VP3S94ksd0D/NgLSODIdhIWOeJL8DkijurNUfqb5lTDT
	lRv050HcBzqf5JN7c20zveno5yBD3yGV63s6RfOBN61hVSxUwH3b/OkzmeqsUHtA
	1ZSS6yUqXZ/8rB0m/0gWrtRw8h4M4hOM82jaYwBq95woOWhuuh9XvORALTqK2aNr
	YqA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6psarxbu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 May 2024 23:18:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44INIeD8016871
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 18 May 2024 23:18:40 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 18 May
 2024 16:18:39 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Sat, 18 May 2024 16:18:39 -0700
Subject: [PATCH] torture: add MODULE_DESCRIPTION()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240518-md-torture-v1-1-f4d7ff51d17a@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAE43SWYC/x3MQQqDQAyF4atI1g04VtH2KqWLcSatgTpKMhaLe
 Hdjlx+892+gJEwK92IDoS8rT8ngLgWEwac3IUczVGVVl43rcIyYJ8mLELoYWnetu6a9RbDDLPT
 i9R97PM29V8JefArDmfhwWlYcvWYSnH82hX0/AIaqXS2BAAAA
To: Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney"
	<paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zOBpM0Wa0SqdFg3Ohf7Zsxo9TIIc8sky
X-Proofpoint-ORIG-GUID: zOBpM0Wa0SqdFg3Ohf7Zsxo9TIIc8sky
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-18_14,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=898
 priorityscore=1501 phishscore=0 impostorscore=0 spamscore=0 clxscore=1011
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405180191

Fix the 'make W=1' warning:

WARNING: modpost: missing MODULE_DESCRIPTION() in kernel/torture.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 kernel/torture.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/torture.c b/kernel/torture.c
index c72ab2d251f4..dede150aef01 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -40,6 +40,7 @@
 #include <linux/sched/rt.h>
 #include "rcu/rcu.h"
 
+MODULE_DESCRIPTION("Common functions for in-kernel torture tests");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Paul E. McKenney <paulmck@linux.ibm.com>");
 

---
base-commit: 674143feb6a8c02d899e64e2ba0f992896afd532
change-id: 20240518-md-torture-1dc71348579d


