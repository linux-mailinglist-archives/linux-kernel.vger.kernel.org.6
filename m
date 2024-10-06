Return-Path: <linux-kernel+bounces-352263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE22991CB6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 08:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFF491F21FB0
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 06:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE8C915B115;
	Sun,  6 Oct 2024 06:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UVVLNd0o"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECA62C18C
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 06:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728194517; cv=none; b=Ivepyj4bsAyExRYlQMkWypLMysqxjafF+EAkpxbAZsz1hjw2Ugj0bKK7EHja+kqjHbUFbd6HyNhgNttaDEONJomhZwCVgTA5P2AC+2EyvAbPWyZd1m4oDCV982f7BDeUuufKPNvP1usWuw4ZP53SxhpgmiI0KpQk+NlLGpnlKZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728194517; c=relaxed/simple;
	bh=5DKOTNxx1eO/gWqiA8EJ3eIg5sG+gx9iq1aacsDREbE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L69ZYigJcDjSx6SQPbsZTMuZkUpHMzHLTAR+zouFP/CwHJHXEtXCq1J5r1NLv4q6rtqiQ7QYxLqzfcd4yEkSmNVzk98iGn8pn9i5VufDoeo4s8BB6i9FncXx3klVZpw7/0T35R1YShfSuUVYaeYlKDxeS99GTLJCQkNt5r41gIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UVVLNd0o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4965mApx017081;
	Sun, 6 Oct 2024 06:01:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=CfC+d0WgYAA781ermU98d98AqgXJFcxOl7q8JcUahv8=; b=UV
	VLNd0oYMT/JCWEL6XZlqHl6V+lhpQ2xq03xlYo90y1sKCxgYCRLLF34iGrJl1GbM
	rNP34DZB4XN5WNjpBm9huVqd/xaWM0wf9eQ7f3yXRdiAS5Xwxgd6GH/ijjlhrEOq
	pDHrPID1vhWHR/Frz3JnRGilUmASLp/oRIW0HjXG8spUilu2Mbx1l9Vq1sILxBsN
	TeIxK+R47JHxxtgAOuxvUgjwgAfudx/kqzVvDY6tOgqoDb8sLxzWPN9GNNOR2VWL
	pn6Vgsz2xYUNeW+EeJlfyWsmrjaDonyyI+3m8cI0CV9KujmBhGwmkKBZJP7n4j+c
	RKx1NDZCZEAXYZPI0TCg==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xv89j5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 06 Oct 2024 06:01:27 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49661RnO029808
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 6 Oct 2024 06:01:27 GMT
Received: from hu-pintu-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 5 Oct 2024 23:01:21 -0700
From: Pintu Kumar <quic_pintu@quicinc.com>
To: <hannes@cmpxchg.org>, <surenb@google.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>, <christophe.jaillet@wanadoo.fr>,
        <linux-kernel@vger.kernel.org>
CC: <joe@perches.com>, <skhan@linuxfoundation.org>, <pintu.ping@gmail.com>,
        Pintu Kumar <quic_pintu@quicinc.com>
Subject: [PATCH v4] sched/psi: fix memory barrier without comment warnings
Date: Sun, 6 Oct 2024 11:30:42 +0530
Message-ID: <20241006060042.17613-1-quic_pintu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 1hRtkXkcvPZBskzxQXt8WUWPlcQAYeGl
X-Proofpoint-GUID: 1hRtkXkcvPZBskzxQXt8WUWPlcQAYeGl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 clxscore=1011 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410060042

These warnings were reported by checkpatch.
Fix them with minor changes.
No functional changes.

WARNING: memory barrier without comment
+       t = smp_load_acquire(trigger_ptr);

WARNING: memory barrier without comment
+       smp_store_release(&seq->private, new);

Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>

---
Changes in V4:
Added () in comment as well suggested by Christophe JAILLET.
V3: https://lore.kernel.org/all/00aeb243-3d47-42be-b52c-08b39c5fef07@wanadoo.fr/
Changes in V3:
Removed signature of Joe as requested. No other change.
V2: https://lore.kernel.org/all/CAOuPNLi1mUKW_vv0E6Ynzvdw_rHvCye+nAf2bWv6Qj9A8ofX1g@mail.gmail.com/
Changes in V2:
Retain printk_deferred warnings as suggested by Joe Perches.
V1: https://lore.kernel.org/all/a848671f803ba2b4ab14b0f7b09f0f53a8dd1c4b.camel@perches.com/
---
 kernel/sched/psi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 020d58967d4e..175423716e4c 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1474,6 +1474,7 @@ __poll_t psi_trigger_poll(void **trigger_ptr,
 	if (static_branch_likely(&psi_disabled))
 		return DEFAULT_POLLMASK | EPOLLERR | EPOLLPRI;
 
+	/* Pairs with the smp_store_release() in psi_write */
 	t = smp_load_acquire(trigger_ptr);
 	if (!t)
 		return DEFAULT_POLLMASK | EPOLLERR | EPOLLPRI;
@@ -1557,6 +1558,7 @@ static ssize_t psi_write(struct file *file, const char __user *user_buf,
 		return PTR_ERR(new);
 	}
 
+	/* Pairs with the smp_store_acquire() in psi_trigger_poll */
 	smp_store_release(&seq->private, new);
 	mutex_unlock(&seq->lock);
 
-- 
2.17.1


