Return-Path: <linux-kernel+bounces-351859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8259916F7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 15:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 934081F22985
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 13:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338F514F9FD;
	Sat,  5 Oct 2024 13:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aIhTopr0"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D817F6
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 13:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728134254; cv=none; b=FM++eHkE7MxxOaGa+sUgZrOvcLOeEtQktCAsLr7Dgg0uR+KIf7YUpTrF1chKv+uIz71UBYSSEvHtxvunYx1JSd6hENJOOC2CwZoh6p3bjZos+Wzk3xe1eiijDkmCBjYg/0FpZsoDctfVGcU6EqLE9Ap5bBDPYXcrhENkMGMB2uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728134254; c=relaxed/simple;
	bh=xJb8Yx87MzW/8eUrGjNeU3WL88o7HsMKZzmSciJGEh8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZXcc/Q/qMMN1yz557iWzrb/3Cts2WMr/DccfdF8AZpoFppWzcDLK2iwY80wSioz9Tj3QPN9qubIOKGImKszsyMABzhU+wDQw8OzzlZHm7uKYmazjHTE2F8sJZ6M5zeCGJf0YhQqQNmWcFXes+2/IOJ2mAMCficQVsh2upKqOhEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aIhTopr0; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 495AgP5O004926;
	Sat, 5 Oct 2024 13:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=NKxSmhMVcUv/pOhvIsOxXx0/MK98fh7XPdGu/a/9/Qk=; b=aI
	hTopr0CYRG0JpsSHPu5yOgCGuieJPFt1acV3xakyz4HlQOfU3PkjeYzjlwMPS14R
	7u6aWhI79xFnWfs/j/LeBpdFUNHOx4haO8fp73XbDuZgpttWzCSmcTzAecUItrB5
	8XL1byKA8N93ADW56wv/36So0TcUzhUsbVj1HcoF4tILryNJyUlhdMx5GOZcqnD7
	YNr3kwPF+fIlknpHDQMBf6Ixa1m+UtZFgPRt/fpJLhJjGqxTDWtWACjLe9CWPDzk
	PDPya0LghETyc+yYXR9jRkqX+5YlwpbDqDt6PqVaZuMmhxm38RZWwYcbpuC6eYBN
	PgwvR0ct22idRGJggfEw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xqnrkfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 05 Oct 2024 13:17:09 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 495DH8Cc003060
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 5 Oct 2024 13:17:08 GMT
Received: from hu-pintu-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 5 Oct 2024 06:17:03 -0700
From: Pintu Kumar <quic_pintu@quicinc.com>
To: <hannes@cmpxchg.org>, <surenb@google.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <joe@perches.com>, <skhan@linuxfoundation.org>, <pintu.ping@gmail.com>,
        Pintu Kumar <quic_pintu@quicinc.com>
Subject: [PATCH v2] sched/psi: fix memory barrier without comment warnings
Date: Sat, 5 Oct 2024 18:46:43 +0530
Message-ID: <20241005131643.7692-1-quic_pintu@quicinc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: TJbbBw0h6YgRbk0K5o-3cvge3GQQa1Go
X-Proofpoint-GUID: TJbbBw0h6YgRbk0K5o-3cvge3GQQa1Go
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410050097

These warnings were reported by checkpatch.
Fix them with minor changes.
No functional changes.

WARNING: memory barrier without comment
+       t = smp_load_acquire(trigger_ptr);

WARNING: memory barrier without comment
+       smp_store_release(&seq->private, new);

Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
Reviewed-by: Joe Perches <joe@perches.com>

---
Changes in V2:
Retain printk_deferred warnings as suggested by Joe Perches.
V1: https://lore.kernel.org/all/a848671f803ba2b4ab14b0f7b09f0f53a8dd1c4b.camel@perches.com/
---
 kernel/sched/psi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 020d58967d4e..4e4ff12fdeae 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1474,6 +1474,7 @@ __poll_t psi_trigger_poll(void **trigger_ptr,
 	if (static_branch_likely(&psi_disabled))
 		return DEFAULT_POLLMASK | EPOLLERR | EPOLLPRI;
 
+	/* Pairs with the smp_store_release in psi_write */
 	t = smp_load_acquire(trigger_ptr);
 	if (!t)
 		return DEFAULT_POLLMASK | EPOLLERR | EPOLLPRI;
@@ -1557,6 +1558,7 @@ static ssize_t psi_write(struct file *file, const char __user *user_buf,
 		return PTR_ERR(new);
 	}
 
+	/* Pairs with the smp_store_acquire in psi_trigger_poll */
 	smp_store_release(&seq->private, new);
 	mutex_unlock(&seq->lock);
 
-- 
2.17.1


