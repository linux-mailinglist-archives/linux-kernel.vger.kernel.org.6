Return-Path: <linux-kernel+bounces-352004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFC19918FD
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 19:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A3371C20FCB
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 17:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AF2156C6F;
	Sat,  5 Oct 2024 17:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k+hvgnwE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2A8288B1
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728150384; cv=none; b=TNwwutURtXxjUH58WRKLQQSzS4bjbGmxp8PVsWfjSlDBNe+KzldKioXxignwFXn8IeyyCNJZsJkG3a812NJg7EZXCwKsqiUQEhcpRi6+Tv8Fi0PvxTkESCIacYmAj3LeYUUWeTRiEHJpv2sKQ28sbO24NSTlMha3kmVL3WyjaCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728150384; c=relaxed/simple;
	bh=hBUjgvVyKrb9mQU/LgiPWMwb9E5Zif91ceR1irwt+nI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NqLRYsj8bpt6gtu8Q6xA4Q7fpeYbDgMvbnKS8zUCzBGthlBYSz3noc9SIkZlnZkLinjxV7X4bXOSa+OQSzP75hzPm/3E2foD//aPuHC2c4xqs1WIJesDE08cq7B2PZd/43nyH86fQXCv9hejNVg8snrJ1kX+BFeRGX+0kr4V72Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k+hvgnwE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 495FcNW0032295;
	Sat, 5 Oct 2024 17:46:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=95YU4wxcQIoMSg5FakoXPVGRDGPoRu8SyHcMhirja3o=; b=k+
	hvgnwEc+6Mi94EaX8aIiCAg+SEw3yyljI9Y8p6ImfIOaRsUTLb+Hfmrj7p1R17+O
	0e5HBuT/fdfJkRG72DSLSUCvfQ/5zpWIqVEa7chSvUSQcFoAMsXHScuuP/fWC5Vh
	fetn1kzJ47EUNPwIRfdhVtY+JVYV9oJvISOXvgS221OgEkK8G3xkP1N4Rfzw2CGW
	m31Mg7VZWr83pKLvx/XedBSNnoSI1zl8t12k0q+E/pW0NjMTZWjcUxbS3cgM0uJy
	/6S+mu27PWALYwwGKTZCh07kd4e9PkWEfQVi0aDQjFZrhYZcFlMNas+p5saksc+G
	lhEl+6q0cfVKYsa0fJZw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 422xtb0w5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 05 Oct 2024 17:46:02 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 495Hk1gE015474
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 5 Oct 2024 17:46:01 GMT
Received: from hu-pintu-blr.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 5 Oct 2024 10:45:56 -0700
From: Pintu Kumar <quic_pintu@quicinc.com>
To: <hannes@cmpxchg.org>, <surenb@google.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
        <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <joe@perches.com>, <skhan@linuxfoundation.org>, <pintu.ping@gmail.com>,
        Pintu Kumar <quic_pintu@quicinc.com>
Subject: [PATCH v3] sched/psi: fix memory barrier without comment warnings
Date: Sat, 5 Oct 2024 23:15:35 +0530
Message-ID: <20241005174535.2152-1-quic_pintu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 4BPjfeo3y42Iem9Q_93XalAqy5goWgJv
X-Proofpoint-GUID: 4BPjfeo3y42Iem9Q_93XalAqy5goWgJv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410050130

These warnings were reported by checkpatch.
Fix them with minor changes.
No functional changes.

WARNING: memory barrier without comment
+       t = smp_load_acquire(trigger_ptr);

WARNING: memory barrier without comment
+       smp_store_release(&seq->private, new);

Signed-off-by: Pintu Kumar <quic_pintu@quicinc.com>

---
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


