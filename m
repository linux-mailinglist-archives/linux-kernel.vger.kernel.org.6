Return-Path: <linux-kernel+bounces-344198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B7598A640
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F5C1F23786
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 13:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9E0198E83;
	Mon, 30 Sep 2024 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="liVVVine"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56D4198831
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704385; cv=none; b=kmNYlCVFf8X5wM9PD9l8Qq3Mpz/GL3JmUCzWGI15idXIxE3qZD+1mTfQ5beG4uViUhzlUed/ysED7SWkKsQztmEZltU7E6qMa2SOB1ddCih5uetbJLFiVEHutWvrUtqVtD1FHxV6tVQ61tDIzvI62ceF8Sx3a3HYRdtPliFLpUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704385; c=relaxed/simple;
	bh=0Yu/tkKhLgDKlmxGBhP4fnuSJXMi0tuTMjZVuxir/ik=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jfsy1GUFvbKtjuCjUvs8NSHlOp67bNGwCujUAtC2RtRKJHi/klkoqhuKWoZlhvYByBAdpXc1Tq2izJHg4gGs0kWRr5ZdV4FHK7C5oxLgnERO8EuhEpOxebQ/BqlUTzrWaUBgfNN2krmZ3E2Bidan/nVHZndGM6ZnvJ6q3Tr39DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=liVVVine; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48UBkZ2v028034;
	Mon, 30 Sep 2024 13:52:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=EtoCRyyW8lj/r++NHnlo/O5/Z90VmWRDmbWCubcgn7Q=; b=li
	VVVineeLuissihI8hZho9xlCDRmDuIYd54VTTC0dIMoxLXaFUvlUA4CBV7AoGB1e
	4udJ2Hlu0zrHR1Z3LEhF3XAucZDFfxNIuBjqIp1JmduTQN44Cqo9UClFy7TtX8w8
	K+40r7VyfrBeqzfUDx4085zryTw7PaRKWYVzmeRb1cdz6SItd8snEi/l03GlfRzv
	Tb/b3OJ7qNc+YmAvDz8PHSnKRRdglUrFFZZBMqiPd/8dKvxDdNPdZEIzWzSqVc5s
	zWq2ueaNktIgoEQw20g+KwB+piCQa1J3OZiNea3CdJg7j+rzObzF9rYvHBwcRKNs
	DcbNi0lTRmeLLAm9a/EQ==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41xajfctdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 13:52:15 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48UDqEvX013098
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Sep 2024 13:52:14 GMT
Received: from hu-pintu-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 30 Sep 2024 06:52:09 -0700
From: Pintu Kumar <quic_pintu@quicinc.com>
To: <hannes@cmpxchg.org>, <surenb@google.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <joe@perches.com>, <skhan@linuxfoundation.org>, <pintu.ping@gmail.com>,
        Pintu Kumar <quic_pintu@quicinc.com>
Subject: [PATCH] sched/psi: fix unnecessary KERN_ERR and memory barrier comment
Date: Mon, 30 Sep 2024 19:21:19 +0530
Message-ID: <20240930135119.21164-1-quic_pintu@quicinc.com>
X-Mailer: git-send-email 2.17.1
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
X-Proofpoint-GUID: mnzPitKeIDJlqA1tsb854Nyyb9iZ_7m9
X-Proofpoint-ORIG-GUID: mnzPitKeIDJlqA1tsb854Nyyb9iZ_7m9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 clxscore=1011 priorityscore=1501 adultscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409300101

These warnings were reported by checkpatch.
Fix them with minor changes.

WARNING: Possible unnecessary KERN_ERR
+                       printk_deferred(KERN_ERR "psi: task underflow! cpu=%d t=%d tasks=[%u %u %u %u] clear=%x set=%x\n",

WARNING: Possible unnecessary KERN_ERR
+               printk_deferred(KERN_ERR "psi: inconsistent task state! task=%d:%s cpu=%d psi_flags=%x clear=%x set=%x\n",

WARNING: memory barrier without comment
+       t = smp_load_acquire(trigger_ptr);

WARNING: memory barrier without comment
+       smp_store_release(&seq->private, new);

Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>
---
 kernel/sched/psi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 020d58967d4e..ca4c5c2c7478 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -816,7 +816,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
 		if (groupc->tasks[t]) {
 			groupc->tasks[t]--;
 		} else if (!psi_bug) {
-			printk_deferred(KERN_ERR "psi: task underflow! cpu=%d t=%d tasks=[%u %u %u %u] clear=%x set=%x\n",
+			printk_deferred("psi: task underflow! cpu=%d t=%d tasks=[%u %u %u %u] clear=%x set=%x\n",
 					cpu, t, groupc->tasks[0],
 					groupc->tasks[1], groupc->tasks[2],
 					groupc->tasks[3], clear, set);
@@ -885,7 +885,7 @@ static void psi_flags_change(struct task_struct *task, int clear, int set)
 	if (((task->psi_flags & set) ||
 	     (task->psi_flags & clear) != clear) &&
 	    !psi_bug) {
-		printk_deferred(KERN_ERR "psi: inconsistent task state! task=%d:%s cpu=%d psi_flags=%x clear=%x set=%x\n",
+		printk_deferred("psi: inconsistent task state! task=%d:%s cpu=%d psi_flags=%x clear=%x set=%x\n",
 				task->pid, task->comm, task_cpu(task),
 				task->psi_flags, clear, set);
 		psi_bug = 1;
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


