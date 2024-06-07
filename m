Return-Path: <linux-kernel+bounces-205857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE1A90015F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 12:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B35E1C2144C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 10:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EAC1862A7;
	Fri,  7 Jun 2024 10:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FRhbUvIH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5321E78C96
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717757982; cv=none; b=ChJor2ZZ85sif5NxQF8iazYtvikWsLZNm1m/uStKolT3dUtDVLVizkIUdVeVXdTSa+xT0Q4LxiiQoN5N5m7VuOK068voUV78CD8FyDWNiimPvJ1heeC4h0fpAK/INHEj8B1Qyd/agHBkrmDL5U99FAnJESxCXj/W3EMCpMwHzoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717757982; c=relaxed/simple;
	bh=13CC63O6WzMUiQHKNHxpWvs9vLgl5yeaMrCQ+TDxxWo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pVzEKLQTfkvDsS9k2qqyW3X2nmgxfbDKGPDvKojzu1xp9kBPPQpvcq8Wvv/pyRt/kLxoQOlkhoJTtq5CerS2uzhXTRBv/LGST51VbClbJ23pDkY+UBj5RkUL8poLtCRxjgv7vDBKw/+GZXeKYAHLhTgRutf5oQlvEFeFTWXm1zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FRhbUvIH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 457At7l7004248;
	Fri, 7 Jun 2024 10:59:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=QB4oYmXLiJGYMvG/R01y9F
	7Lq08+rcE5hcMOxo0hir8=; b=FRhbUvIH6XuIWd01jNBMjidb36dWJeha3P8znj
	28FAf/r+LBOQCc8ZqFx+ymV79MS7SsA60X9h8YkAM/jlawMepqlRIPGz37rvthxU
	hfS/cf7ZOP7fCG+qtXzrMVkno1PqRnA4nrnVHxCi/lsPysDjp2sOVA73Zvd3r7a2
	pV9i41hA+QkbtfP5T8R2x5rtUB4LrAVyq+JVb+cgnNMC1zqzV/DBKw1Trdwnk9ba
	iPz9zjdzxbBYd8bI7GPAbZFWPxkmLDV0gY7YNymTUqadXbukVmsf4DlU7ufJuffp
	ZUNvt28xKv9Tf+HE2GPrsoNiNSmxVJZ5oa60OJftkW0TkS0Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yjxxav7a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 10:59:25 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 457AxOxj030932
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 10:59:24 GMT
Received: from hu-faiyazm-hyd.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 7 Jun 2024 03:59:21 -0700
From: Faiyaz Mohammed <quic_faiyazm@quicinc.com>
To: <benjamin.bara@skidata.com>, <dmitry.osipenko@collabora.com>,
        <lee@kernel.org>, <daniel.lezcano@linaro.org>, <ldmldm05@gmail.com>,
        <j.granados@samsung.com>, <quic_faiyazm@quicinc.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] kernel/reboot: enhance dmesg logging for system restart
Date: Fri, 7 Jun 2024 16:29:06 +0530
Message-ID: <20240607105906.4192924-1-quic_faiyazm@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: QhTUjKT7tjTxqwjZZlo6vX-mwhMIPqVl
X-Proofpoint-GUID: QhTUjKT7tjTxqwjZZlo6vX-mwhMIPqVl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-07_05,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=866 adultscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406070079

It is useful to add the PID and Comm information along with command info.

Currently, when system reboot kernel logs don not print PID and Comm:

reboot: Restarting system with command 'reboot,scheduled_reboot'
reboot: Restarting system with command 'RescueParty'
reboot: Restarting system with command 'bootloader'
reboot: Restarting system with command 'recovery'
reboot: Restarting system with command 'userrequested,recovery’

For Example after adding PID and Comm:

reboot: PID: 1 Comm: init Restarting system with command 'shell'
reboot: PID: 1 Comm: init Restarting system with command 'bootloader'

Signed-off-by: Faiyaz Mohammed <quic_faiyazm@quicinc.com>
---
 kernel/reboot.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index f05dbde2c93f..91a4a1428eb9 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -274,14 +274,17 @@ static void do_kernel_restart_prepare(void)
  */
 void kernel_restart(char *cmd)
 {
+	char comm[sizeof(current->comm)];
+
+	get_task_comm(comm, current);
 	kernel_restart_prepare(cmd);
 	do_kernel_restart_prepare();
 	migrate_to_reboot_cpu();
 	syscore_shutdown();
 	if (!cmd)
-		pr_emerg("Restarting system\n");
+		pr_emerg("PID: %d Comm: %s Restarting system\n", current->pid, comm);
 	else
-		pr_emerg("Restarting system with command '%s'\n", cmd);
+		pr_emerg("PID: %d Comm: %s Restarting system with command '%s'\n", current->pid, comm, cmd);
 	kmsg_dump(KMSG_DUMP_SHUTDOWN);
 	machine_restart(cmd);
 }
-- 
2.25.1


