Return-Path: <linux-kernel+bounces-188896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A328CE848
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 17:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACDD71F21F1B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 May 2024 15:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F79712E1D0;
	Fri, 24 May 2024 15:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SzuzNJ0o"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7225012C49F
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 15:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716565982; cv=none; b=Lqd2MwXEHgb6jToS2FRE9em78PN9Ut6TKSM5pZkJ/xhx9/5ek1WpbdDVNutTDcuir4UJAN23zk2LOBwMQVjfgNSqsx66oIST4R7fckCgMWO2btVhb8XmPtO/IoV4DUdnQL2W3yv4MvRmzxPoq8rfdB749AQnZ7Hhs4QMzshozCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716565982; c=relaxed/simple;
	bh=890vdz8AVj8lpFtCQhkJD04ptDdcp2OP1uV1uoubhVI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PaIskC/StKxp8yMjVVgK4fjiNpkk9lpT+qT+Cou58pojZQdhWsK2UMzbgxbjcsOIwNLWGYh2gxWXrCPZJwRwS3Y7Mcrrgaau2ySuxt6/PAv8dOC70kj3xhzvdLXqZuexDaH0aL3BlsubGweLIjJuxFX4vRBMan1m+E7uBs0SqZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=SzuzNJ0o; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44O9f9Zv007133
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 15:52:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	qcppdkim1; bh=w27UNgW80NbJvyNK7BSKnoLACrj/aidJmbnMxgB8pE4=; b=Sz
	uzNJ0oSjl6nN0ws+MHJSBLIMTPmoLbJ9MFQq9bf6ePy82bZWJx6ZG7wE4ttbdyLd
	25V41PhCMKoYOwFBAR3Sl/joOQLe4AJlLxSxibe/GG1J6jJsnhm4D4KqIdxDjAMT
	zmn07vSDCzmGXBmfkdsln3/nEkqH2IYzIr0J2c+qrWYpF5zOdd2ow2cxmh5GIP2q
	Twm7XaRDdGe8txogaMY9VBjl9QPmYAGu44n9iOkL8Ixv5NlltHyiEozXWD/Hr1wT
	Aor6dveAWEJWr8O1L80+wlx1GI3qJEa7vwJLTk/9/pcz3/tJa3e7Llrcxw95YnpT
	8dC6ZoGquOn7QVAYB/zA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yaa8k2v76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 15:52:59 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44OFqwZb022414
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 May 2024 15:52:58 GMT
Received: from hu-mojha-hyd.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 24 May 2024 08:52:57 -0700
From: Mukesh Ojha <quic_mojha@quicinc.com>
To: <linux-kernel@vger.kernel.org>
CC: Mukesh Ojha <quic_mojha@quicinc.com>
Subject: [PATCH v2] stop_machine: Fix rcu_momentary_dyntick_idle() call in multi_cpu_stop()
Date: Fri, 24 May 2024 21:22:41 +0530
Message-ID: <1716565961-18715-1-git-send-email-quic_mojha@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fnkhmd0ngQmwkrKbIxDDT-o1o7nJg6gu
X-Proofpoint-GUID: fnkhmd0ngQmwkrKbIxDDT-o1o7nJg6gu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_04,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=699 impostorscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405240110

rcu_momentary_dyntick_idle() is getting called from all the irq disable
path (mention doc section in rcu_momentary_dyntick_idle()) however, in
multi_cpu_stop() it is not called from irq disable path.

"
 * Let the RCU core know that this CPU has gone through the scheduler,
 * which is a quiescent state.  This is called when the need for a
 * quiescent state is urgent, so we burn an atomic operation and full
 * memory barriers to let the RCU core know about it, regardless of what
 * this CPU might (or might not) do in the near future.
 *
 * We inform the RCU core by emulating a zero-duration dyntick-idle period.
 *
 * The caller must have disabled interrupts and must not be idle.
"

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
---
Change in v2: https://lore.kernel.org/lkml/1712649736-27058-1-git-send-email-quic_mojha@quicinc.com/
 - Removed the unnecessary stack trace posted.

 kernel/stop_machine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index cedb17ba158a..f93e6deb8150 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -250,8 +250,8 @@ static int multi_cpu_stop(void *data)
 			 * be detected and reported on their side.
 			 */
 			touch_nmi_watchdog();
+			rcu_momentary_dyntick_idle();
 		}
-		rcu_momentary_dyntick_idle();
 	} while (curstate != MULTI_STOP_EXIT);
 
 	local_irq_restore(flags);
-- 
2.7.4


