Return-Path: <linux-kernel+bounces-352304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3A8991D40
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 10:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9681C21340
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 08:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC15A170A3F;
	Sun,  6 Oct 2024 08:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jTgAtEXR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7838F1BF58
	for <linux-kernel@vger.kernel.org>; Sun,  6 Oct 2024 08:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728203413; cv=none; b=MsYbAefRBSALoiDJQwrJ4OE2zJVW+OtUzVjAXuYf1ZIlY3y50ZbFfKL1Cx7UqXUTKkXHax27ke2IQgVNBtgLxwoLH9AFZkUrQW/OipJPsAcNDkbZVxW5ShyOV1ppDysEUzv/qhN9qAlF5pcxLTi9BrYmyiyBMMQZJKxiVJn8dpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728203413; c=relaxed/simple;
	bh=O9zKFN97pePSfMsAuC5u8/6R7f9gIX/xDUrjV300V50=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OR4LKJ3KK/6G+V8wojuk3XZwk/qyVPbENjt2biPB1Xd6NECTIP51qiaeqdrWWvpx60QljnHjCIKTDPOkdvprs2F6eDf5U/zyNqneg6OvxJVr/UvcVb93klazMSMoWoBjUNZUYX8RI1rL9bjEmtwumfljeriblCGvl6WhlvOwNZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jTgAtEXR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4966ZqLR011471;
	Sun, 6 Oct 2024 08:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=PZY+DlQqwatgP5nSoW/Qeyztli5qyNU6htpXvSP/Zms=; b=jT
	gAtEXRUknmpy9Tn+HyIPpVNEN8WWOUGWl1qUbt9Y7lVEOm+ZMKJ8o4og1zV4uSE3
	/fxNh1uiGaaxNO3wc9nQOPueZwAq3ucAZkHWKliaRh7rYmpd9cvymbqk6OHz80L6
	MiR+wb5Sd6/eOzBmp18dtAoaanwFQMA/JHCo2rPwTDHhlN1dfpkjXeBvSC9chbsZ
	kbSs3Qd7v+8e0rJqyhAby2GXtPdHX4f76doMAWP4juEANn/PjFM9XPKpw5749xIG
	d14Ozr7L9zGiyEvAnW0zgu2W9Emi91XoSohG7uL4kS8pM5ZSE03ceWHGCgHqCsEP
	NHA8aMO7Ce5+/IzgSCOg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xsnhqj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 06 Oct 2024 08:29:51 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4968TolN032321
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 6 Oct 2024 08:29:50 GMT
Received: from hu-pintu-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 6 Oct 2024 01:29:45 -0700
From: Pintu Kumar <quic_pintu@quicinc.com>
To: <hannes@cmpxchg.org>, <surenb@google.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>, <christophe.jaillet@wanadoo.fr>,
        <linux-kernel@vger.kernel.org>
CC: <joe@perches.com>, <skhan@linuxfoundation.org>, <pintu.ping@gmail.com>,
        Pintu Kumar <quic_pintu@quicinc.com>
Subject: [PATCH v5] sched/psi: fix memory barrier without comment warnings
Date: Sun, 6 Oct 2024 13:59:26 +0530
Message-ID: <20241006082926.20647-1-quic_pintu@quicinc.com>
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
X-Proofpoint-GUID: KiUBnkzbTBsJ1AGcWs0_shQf8M2Jz5XI
X-Proofpoint-ORIG-GUID: KiUBnkzbTBsJ1AGcWs0_shQf8M2Jz5XI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 priorityscore=1501 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410060059

These warnings were reported by checkpatch.
Fix them with minor changes.
No functional changes.

WARNING: memory barrier without comment
+       t = smp_load_acquire(trigger_ptr);

WARNING: memory barrier without comment
+       smp_store_release(&seq->private, new);

Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>

---
Changes in V5:
Corrected api name and missing () in comments as suggested by Christophe JAILLET.
V4: https://lore.kernel.org/all/a8393bc0-6f56-4e40-b971-4a837cf28323@wanadoo.fr/
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
index 020d58967d4e..907fa3830c8e 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -1474,6 +1474,7 @@ __poll_t psi_trigger_poll(void **trigger_ptr,
 	if (static_branch_likely(&psi_disabled))
 		return DEFAULT_POLLMASK | EPOLLERR | EPOLLPRI;
 
+	/* Pairs with the smp_store_release() in psi_write() */
 	t = smp_load_acquire(trigger_ptr);
 	if (!t)
 		return DEFAULT_POLLMASK | EPOLLERR | EPOLLPRI;
@@ -1557,6 +1558,7 @@ static ssize_t psi_write(struct file *file, const char __user *user_buf,
 		return PTR_ERR(new);
 	}
 
+	/* Pairs with the smp_load_acquire() in psi_trigger_poll() */
 	smp_store_release(&seq->private, new);
 	mutex_unlock(&seq->lock);
 
-- 
2.17.1


