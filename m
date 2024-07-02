Return-Path: <linux-kernel+bounces-237435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (unknown [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF71923844
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 10:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D94731C2203A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 08:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2747B14E2E6;
	Tue,  2 Jul 2024 08:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="a2Cf0J/v"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C9214D714
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 08:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719909534; cv=none; b=Vm7lbyeyWA08xiVJHk4lTPXHFm39/QOjTE0KlKssRHJjdAu7dCNM6DhWNzmqZk7wgi3YgFPB7VJkoDycVaXhV9lvYLp6rdD6qHZf+xH/lU7Aywi1E1+4BZzNkMlphFY4bA03QxHU9zupQTDmnE4FNk58Upm3/7XUIFoqRD3FT3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719909534; c=relaxed/simple;
	bh=KKuKsGMpWuLke6SxyfQ5w7B4Cqh2Ga+aBGEorhoIbfg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RktAM04YeXcrDzLPaFaKmIfrp7SNkCQU/ArEi71T0mTgFW6ck9QZzNqliUmR4ydlG8zvpjCeioQ9CuXpUksqWHxJ3uw0SdNTrVt9sG2EXtbzgAXZv6X6Y5lRtPyfmjEnS7UXk7yIjSydxEGYDb+mzL44rpxDRyiqkNcGsl0A/IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=a2Cf0J/v; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4627wkma020471;
	Tue, 2 Jul 2024 08:38:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=cCgoOrSmTw0fSMos0OMc1DBsK0
	e/HIlgfvT8b+kbihc=; b=a2Cf0J/vIJBHtYHsoFYe/7fNJQofDCFt+Jx4YJynEV
	RWh3pD7ky5cGhfAPp6O/rYcdmQpfh60Yor/7Z+RGZrmDhsec7jRtGHlk7alc6v/g
	8udFg4FDMkT6doegbi4eRp7zn8mWm9JcbhmbOdVMztoRtumoSP7CV6rmFqZS118P
	LEnMXOjbEKp61ASCFmDGxnPWt56S+fs9hFHFOcBFQZOW7l2QwyeBNFHjQ6qatlcC
	wHw4k76fkUaloKp76FjDzhLuHowrSMSbMqF5RxQZsrentJyFMmHlWV1c7xFaFQoc
	vMCyPeGJ8cD4NbOkFNvcByoeBw7xrMx5qG1Nf5AMTGjA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 404dmk03b0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 08:38:46 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4626d8Q6009121;
	Tue, 2 Jul 2024 08:38:45 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 402w00m25t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 08:38:45 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4628cfuE53084534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jul 2024 08:38:43 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C83F72004E;
	Tue,  2 Jul 2024 08:38:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C127F20040;
	Tue,  2 Jul 2024 08:38:40 +0000 (GMT)
Received: from li-34d1fccc-27cd-11b2-a85c-c167793e56f7.in.ibm.com (unknown [9.204.200.131])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jul 2024 08:38:40 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: tj@kernel.org, void@manifault.com
Cc: aboorvad@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2 sched_ext/for-6.11] sched_ext: Documentation: Remove mentions of scx_bpf_switch_all
Date: Tue,  2 Jul 2024 14:08:39 +0530
Message-Id: <20240702083839.176996-1-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DN0uNhVGwLp2wysmpIzPrTsNBd2OsytQ
X-Proofpoint-ORIG-GUID: DN0uNhVGwLp2wysmpIzPrTsNBd2OsytQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_04,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=865 clxscore=1015 malwarescore=0
 spamscore=0 adultscore=0 impostorscore=0 bulkscore=0 mlxscore=0
 phishscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2406140001 definitions=main-2407020063

Updated sched_ext doc to eliminate references to scx_bpf_switch_all,
which has been removed in recent sched_ext versions.

Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 Documentation/scheduler/sched-ext.rst | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 497eeaa5ecbe..a707d2181a77 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -48,13 +48,16 @@ sched_ext is used only when the BPF scheduler is loaded and running.
 
 If a task explicitly sets its scheduling policy to ``SCHED_EXT``, it will be
 treated as ``SCHED_NORMAL`` and scheduled by CFS until the BPF scheduler is
-loaded. On load, such tasks will be switched to and scheduled by sched_ext.
+loaded.
 
-The BPF scheduler can choose to schedule all normal and lower class tasks by
-calling ``scx_bpf_switch_all()`` from its ``init()`` operation. In this
-case, all ``SCHED_NORMAL``, ``SCHED_BATCH``, ``SCHED_IDLE`` and
-``SCHED_EXT`` tasks are scheduled by sched_ext. In the example schedulers,
-this mode can be selected with the ``-a`` option.
+When the BPF scheduler is loaded and ``SCX_OPS_SWITCH_PARTIAL`` is not set
+in ``ops->flags``, all ``SCHED_NORMAL``, ``SCHED_BATCH``, ``SCHED_IDLE``, and
+``SCHED_EXT`` tasks are scheduled by sched_ext.
+
+However, when the BPF scheduler is loaded and ``SCX_OPS_SWITCH_PARTIAL`` is
+set in ``ops->flags``, only tasks with the ``SCHED_EXT`` policy are scheduled
+by sched_ext, while tasks with ``SCHED_NORMAL``, ``SCHED_BATCH`` and
+``SCHED_IDLE`` policies are scheduled by CFS.
 
 Terminating the sched_ext scheduler program, triggering :kbd:`SysRq-S`, or
 detection of any internal error including stalled runnable tasks aborts the
@@ -109,7 +112,7 @@ Userspace can implement an arbitrary BPF scheduler by loading a set of BPF
 programs that implement ``struct sched_ext_ops``. The only mandatory field
 is ``ops.name`` which must be a valid BPF object name. All operations are
 optional. The following modified excerpt is from
-``tools/sched/scx_simple.bpf.c`` showing a minimal global FIFO scheduler.
+``tools/sched_ext/scx_simple.bpf.c`` showing a minimal global FIFO scheduler.
 
 .. code-block:: c
 
@@ -156,13 +159,12 @@ optional. The following modified excerpt is from
             scx_bpf_dispatch(p, SCX_DSQ_GLOBAL, SCX_SLICE_DFL, enq_flags);
     }
 
-    s32 BPF_STRUCT_OPS(simple_init)
+    s32 BPF_STRUCT_OPS_SLEEPABLE(simple_init)
     {
             /*
-             * All SCHED_OTHER, SCHED_IDLE, and SCHED_BATCH tasks should
-             * use sched_ext.
+             * By default, all SCHED_EXT, SCHED_OTHER, SCHED_IDLE, and
+             * SCHED_BATCH tasks should use sched_ext.
              */
-            scx_bpf_switch_all();
             return 0;
     }
 
-- 
2.25.1


