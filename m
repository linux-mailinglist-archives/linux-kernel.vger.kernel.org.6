Return-Path: <linux-kernel+bounces-439643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E71D09EB221
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 14:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 823D21882A48
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2024 13:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E17219D897;
	Tue, 10 Dec 2024 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PvLdmeJD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E63C26AF6
	for <linux-kernel@vger.kernel.org>; Tue, 10 Dec 2024 13:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838361; cv=none; b=Buo75hZYPL1ofZ+8SpHaQ0pQYueSwZWkkFtP3MyqzlC8E6QxBinYjQsQNxewZVigD5vIQvyp9vXHQhQybX4UcclDdqzgsurTV8U2IlWc6A1O4uwFuc7KMKrRBuO3L7g9I4p0V61IsYlGUl5DlDD5sw9N5y7D5Ba/PuM6IfJf/rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838361; c=relaxed/simple;
	bh=QjJ2oOV+s0eIvWHc0jZo49maOC7W0Yq4I6oOQU5ELOQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XGYqeCKaQ8HpwmdmlnbX42IZJt2Ax448tUhCc0RTzy2W4+5ywcjT0mkl948vytyV71Zi5aqVgVPAZU20sWv53Ht9qnZGzR20uA3r9V5Gbzg+Go4BXhRogUVuJ85w837XKJfjI8P+Pma/aMUgAHdzNmxGVLj1iYLlMBUeq6q8uOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PvLdmeJD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BABaIWH007025;
	Tue, 10 Dec 2024 13:45:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=eY5oeWVS9dgAaaCFJDNLaO
	N3x4FGCSlRmZcncbrN5ow=; b=PvLdmeJD4pfAsl9/IUZjgUHoxwO+kNymNm7Chf
	M4bklfsS/97ABjbdZjsj/KLlBxIiFJDeb3aFGKaqNvElJI9MM7E2extYh9qUXfpN
	51J7u3hdACJ2IVfUImO9JOK1Jr7I7adu4VBjY5gN1jaxOlDF63TdmOGhznaMNcfT
	XMCAhHoF0MIQzCEnZ5v0JoSfxMp7mNv9i6zkmAgrrbTCwHJ4n+l6CKn7tAbKG+oP
	cIbziVVqqqS6wdw/rvLByWLaEVSGtwp/Y+e/qahTqvisgL4Hgc+LE28TkQabJgy7
	Gm/K8VRvmVTZVQzxSub2G6nEH63XpMo7UKOu5V86uwamV8uA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43e21bkjcx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 13:45:43 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4BADjhOW021295
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 13:45:43 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 10 Dec 2024 05:45:40 -0800
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>
CC: <linux-kernel@vger.kernel.org>, <quic_zhonhan@quicinc.com>
Subject: [RFC PATCH] sched/core: Enhanced debug logs in do_task_dead()
Date: Tue, 10 Dec 2024 21:45:13 +0800
Message-ID: <20241210134513.2179786-1-quic_zhonhan@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BrtZ-CuHpny4xO7izvPcAZDMVn2_zLx6
X-Proofpoint-ORIG-GUID: BrtZ-CuHpny4xO7izvPcAZDMVn2_zLx6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 clxscore=1011
 malwarescore=0 lowpriorityscore=0 mlxlogscore=691 priorityscore=1501
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412100102

If BUG() is a NOP, dump the problematic stack for debugging purposes.

Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
---
If BUG() is a NOP, it should make sense for debugging purposes. However,
just arising the patch with RFC, because at least for now, I haven't found
a definition of BUG() as NOP in various architectures. Thanks~

 kernel/sched/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f59f2c0f6e32..fc36a9c5c136 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6774,7 +6774,11 @@ void __noreturn do_task_dead(void)
 	__schedule(SM_NONE);
 	BUG();
 
-	/* Avoid "noreturn function does return" - but don't continue if BUG() is a NOP: */
+	/*
+	 * Don't continue if BUG() is a NOP to avoid "noreturn function
+	 * does return" and dump stack for this case.
+	 */
+	dump_stack();
 	for (;;)
 		cpu_relax();
 }
-- 
2.25.1


