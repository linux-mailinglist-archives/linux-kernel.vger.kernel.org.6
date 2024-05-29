Return-Path: <linux-kernel+bounces-194673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C8C8D3FC7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 22:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5946E1C20DC8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 20:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585301C8FB4;
	Wed, 29 May 2024 20:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M5otaLcI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18ABBA48;
	Wed, 29 May 2024 20:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717015545; cv=none; b=QWOfmkWJLMYv5KaVoQ+iEsigo1bMzmJ8EEOpj3XRmtt9QZ/ft2OUewq4MJ8zAeaD3hwVsRwBKogdBe8V286JrMXumjIOqnM2ddbhWeoT5j6seCFEx+LxkTNCmohjwsvRiJSblwK7xRUlCameeScOqGxhR1sa+kMyJSeDGKcE/4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717015545; c=relaxed/simple;
	bh=4ki7blp5JrFHd6o75yirTaNoR9qlBmHkYg2liLM/CLc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=lSF0fHgdof2nSR2fZnwRlKij05EjqLnCQCDDqjJw/iMUOFOFb2AVYsKYyiwOzm31wFGyywWBK5m965UCV3olCKDpHsvJoB0PgbC0OK7tF4wE7HLA4efNnXzsjLThJLyrUOrqB8Yc3W+QU8uhb0FuKITU3Dx2vwUaxOJ4N6CQgnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M5otaLcI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44TBhx6C027634;
	Wed, 29 May 2024 20:45:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=muVXLkYL4mVe1bD7GPQLZG
	r3MdPXXZvWAWwGRgBXRdk=; b=M5otaLcIIqnRxe7aWej6yNO9DSIiKQ0cXlqsu9
	ccktFB0XlArLhgO/xcglOTHcePIJoF8OHoiy1drfBFdWsiuV2Uotqgx9QWGwcXBq
	1Rm9oTexaOJQkzOYMObgdDkcOk609OxpCWKQoLbstz8h0BTd11ZEN9BywaNOpvM5
	s6Hant2Da5J2LuecHmd7UhiL2evWFq8oU1xcnVTXOC/gB6z9lnZU2PF9ALyXfLk7
	E8mToX/n0gMYKz4377e/579ThL2bLzwgb8uAUPedyamwF8WBKr8JP9rSKsAPmBeo
	LodJ9tvzVr1120JZFsi64m9Joj63Vx7+ZXbLLCLN6f8javsw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yba2njbry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 20:45:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44TKje5a006165
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 20:45:40 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 29 May
 2024 13:45:40 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Wed, 29 May 2024 13:45:40 -0700
Subject: [PATCH] scftorture: make torture_type static
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240529-static-scftorture-v1-1-b0ceaeefebaa@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAPOTV2YC/x3MywrCQAxG4VcpWRsYxwvWVxEX0/SvDehUkqkUS
 t/d0eW3OGclhymcrs1Kho+6Trliv2tIxpQfYO2rKYZ4DKfYspdUVNhlKJOV2cByOUOkb3EIoNq
 9DYMu/+ftXt0lB3eWsoy/01PzvPAreYHRtn0Bp2QJw4IAAAA=
To: "Paul E. McKenney" <paulmck@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JaL1MCWP4AgtZsZfvPNQgNJzJNhkDN5l
X-Proofpoint-GUID: JaL1MCWP4AgtZsZfvPNQgNJzJNhkDN5l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_16,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 phishscore=0 suspectscore=0 mlxlogscore=766 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2405290146

Fix the 'make C=1' warning:
kernel/scftorture.c:71:6: warning: symbol 'torture_type' was not declared. Should it be static?

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 kernel/scftorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 59032aaccd18..13ad348143ca 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -67,7 +67,7 @@ torture_param(int, weight_many_wait, -1, "Testing weight for multi-CPU operation
 torture_param(int, weight_all, -1, "Testing weight for all-CPU no-wait operations.");
 torture_param(int, weight_all_wait, -1, "Testing weight for all-CPU operations.");
 
-char *torture_type = "";
+static char *torture_type = "";
 
 #ifdef MODULE
 # define SCFTORT_SHUTDOWN 0

---
base-commit: 4a4be1ad3a6efea16c56615f31117590fd881358
change-id: 20240529-static-scftorture-c86eccd9e30e


