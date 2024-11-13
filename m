Return-Path: <linux-kernel+bounces-406887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FE19C65A4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 01:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BBCC1F24C4C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB5815A8;
	Wed, 13 Nov 2024 00:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XFBZXGmi"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921EF20ED
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 00:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731456120; cv=none; b=sJ8I/vl2smJLEbTdwy/wN+N6okgV/tmrZ8gS+Kx3TSh/YHg4EjKbejRMR57+8BAKaVl+XNYBTX9QecukyH85KdIoA1Mv0da/NVyatLbkL0j8SXbgrR5YyQnwPblxj91TLwWLSEW9pONblZXD1lL+cCSchV1/mIcV2pkzMOADXDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731456120; c=relaxed/simple;
	bh=IY4GAH++/EKRcd8NAEKfW3X6nfJ3TmoSG5uf/OmuG3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nyyuukB/EYn2SJiSXWgWKFXYJF9pOPHF3X4ysmS+VNKF9bAy8f2InrCYagAjFCoKgSCpzY5WkH65YQqJVJ+p7B4+dPoIkrtm0i3OG6hCAWjeFB2ewH8tzvcDAbrynUkdolDWPzNUTXCgrsJzRvOUIzPPk7VSIJEEgsISugHZOMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XFBZXGmi; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACN1V8U026399;
	Wed, 13 Nov 2024 00:01:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=H+sK7
	mIUePH4fiExpJB0QMD2IK4GxjsnzM1SkRbELAw=; b=XFBZXGmi/jUxBUb9jddVx
	9cu1hGvSFKYLXFZW03aOStliTPBTJwQrZHsYH7992omoC6s0A4Dkp87y29y0Ba/W
	bK1FwumYgBGsbopOXgEyBRFU171HIpfJXq4FQn++VE+PPcgzDRos3T3zaBIkGoxb
	E8CnLa8O+JEZ8UtY0ddMYe5VOyE/qA3NLGzpelCkxHpVQJXtNEiMM3zhMbeizsyk
	EYnlpemkMoYuC+SiOdB91vMaE6ESU7Wg4fGlUzDvOXHEggh2mVHaiq2OBOngF2O/
	HQEqe71yPNF/svyyze4SC2xmdq4r5voLgQddOUqowu3S9JiyDZJ/dtL9T5HtYrOa
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mbdqxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 00:01:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACMlZ3M007934;
	Wed, 13 Nov 2024 00:01:41 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx68uq9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 13 Nov 2024 00:01:41 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4AD01bKk011807;
	Wed, 13 Nov 2024 00:01:40 GMT
Received: from psang-work.osdevelopmeniad.oraclevcn.com (psang-work.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.35])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx68uq2j-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 13 Nov 2024 00:01:40 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: rostedt@goodmis.org, peterz@infradead.org, tglx@linutronix.de,
        daniel.m.jordan@oracle.com, prakash.sangappa@oracle.com
Subject: [RFC PATCH 3/4] Indicate if schedular preemption delay request is granted
Date: Wed, 13 Nov 2024 00:01:25 +0000
Message-ID: <20241113000126.967713-4-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241113000126.967713-1-prakash.sangappa@oracle.com>
References: <20241113000126.967713-1-prakash.sangappa@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-12_09,2024-11-12_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411120193
X-Proofpoint-GUID: oQEOGIfja_pm_5jzE17-6b99M6fQ-eU_
X-Proofpoint-ORIG-GUID: oQEOGIfja_pm_5jzE17-6b99M6fQ-eU_

Indicate to user space if the preemption delay request was granted
or denied.

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 include/uapi/linux/task_shared.h | 11 +++++++++++
 mm/task_shared.c                 | 14 +++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/task_shared.h b/include/uapi/linux/task_shared.h
index 6e4c664eea60..a0f7ef0c69d0 100644
--- a/include/uapi/linux/task_shared.h
+++ b/include/uapi/linux/task_shared.h
@@ -15,4 +15,15 @@
 struct task_sharedinfo {
 		volatile unsigned short sched_delay;
 };
+
+/*
+ * 'sched_delay'  values:
+ * TASK_PREEMPT_DELAY_REQ - application sets to request preemption delay.
+ * TASK_PREEMPT_DELAY_GRANTED - set by kernel if granted extended time on cpu.
+ * TASK_PREEMPT_DELAY_DENIED- set by kernel if not granted because the
+ *     application requested preemption delay again within the extended time.
+ */
+#define TASK_PREEMPT_DELAY_REQ		1
+#define TASK_PREEMPT_DELAY_GRANTED	2
+#define TASK_PREEMPT_DELAY_DENIED	3
 #endif
diff --git a/mm/task_shared.c b/mm/task_shared.c
index 575b335d6879..5b8a068a6b44 100644
--- a/mm/task_shared.c
+++ b/mm/task_shared.c
@@ -279,13 +279,21 @@ bool taskshrd_delay_resched(void)
 	if(shrdp == NULL || shrdp->kaddr == NULL)
 		return false;
 
-	if (t->taskshrd_sched_delay)
+	if (t->taskshrd_sched_delay) {
+		if (shrdp->kaddr->ts.sched_delay
+				== TASK_PREEMPT_DELAY_REQ) {
+			/* not granted */
+			shrdp->kaddr->ts.sched_delay
+				= TASK_PREEMPT_DELAY_DENIED;
+		}
 		return false;
+	}
 
-	if (!(shrdp->kaddr->ts.sched_delay))
+	if (shrdp->kaddr->ts.sched_delay != TASK_PREEMPT_DELAY_REQ)
 		return false;
 
-	shrdp->kaddr->ts.sched_delay = 0;
+	/* granted */
+	shrdp->kaddr->ts.sched_delay = TASK_PREEMPT_DELAY_GRANTED;
 	t->taskshrd_sched_delay = 1;
 
 	return true;
-- 
2.43.5


