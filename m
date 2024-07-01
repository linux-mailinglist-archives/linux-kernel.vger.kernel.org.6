Return-Path: <linux-kernel+bounces-236242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D044C91DF4A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 14:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4583BB22B35
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 12:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A44914A0B2;
	Mon,  1 Jul 2024 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VBGk9eNU"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F78F1E488
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719837036; cv=none; b=sEV8CHHnwWS2EcT5eC74x9ttnSQodEmnWzvDkWhaib3RBwXPPRRy2xNjmokfjIvyCAu8bHMPtauYR4JyygQFYT9Hq3g3iJOBepqkl4u1TwrHsQDSPB3FjNWKp6Ujq8SuqI1N0XmUEDgF5FxhpTZ8eeqg4I+s0En1OllNf+qGAYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719837036; c=relaxed/simple;
	bh=LLmcgabvctEkbE6riHSSC4c3qFFz1sFOpyMoPGQvv7o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JGquQXXXY1+YBRv4ZC0KVlnX1QIIuUsW7Neq+C7UJ2orQz+Qn5GgvXwTRgdqgEszBstX+wfgVDd2bL4l1VMaHbhb3XjcxHJz1dX/GO0o9SyLKyptoMq/MrReOGeNzM6VEKKCel/nTWB2eEb5ekKaKkwoiZXgXwo2C1sY/0lVKHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VBGk9eNU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 461BvBOY020166;
	Mon, 1 Jul 2024 12:30:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=7GWEMxivoUcncsnn/R8QMMDiaH
	Hb/pV3UWTM6QzvYLY=; b=VBGk9eNUqu0+5HqPzyNxZPYAla859eTGsyx9LB0m+Q
	TsriisyxThBGkKF84Mdh2sn1833ij1XnufZPDrwUiguezHzfM8cz6jcqIqHAUIKi
	QjTx4O5xHHxUJ6edFWwZJaC73gnOaLpPu2SCEiH01Ix5Wb+dvoe3FhFAo06HHG/y
	5VzX0jEoXc0GmRuQLqpGihqLSZgu2hcCs1ZdE9JlWASbE5zXcnOTwcyABw9m8Nlc
	kx2jCnldP1+CzK6gauGMA15WzcTgBpEE5XwUi8n8cFoQNV5Vs586O/PJsVUUDMPE
	oxpPP8cUjmdNNh09O5ijknilkkpgMFP9Nt8kuFTmsoMw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 403ukyr4r5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 12:30:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4619vqK7024071;
	Mon, 1 Jul 2024 12:30:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 402ya36thn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 01 Jul 2024 12:30:28 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 461CUOhR45220172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 1 Jul 2024 12:30:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65F7F2004B;
	Mon,  1 Jul 2024 12:30:24 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BCBC20040;
	Mon,  1 Jul 2024 12:30:23 +0000 (GMT)
Received: from li-34d1fccc-27cd-11b2-a85c-c167793e56f7.in.ibm.com (unknown [9.204.200.131])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  1 Jul 2024 12:30:23 +0000 (GMT)
From: Aboorva Devarajan <aboorvad@linux.ibm.com>
To: tj@kernel.org, void@manifault.com
Cc: aboorvad@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.11] sched_ext: Documentation: Remove mentions of scx_bpf_switch_all
Date: Mon,  1 Jul 2024 18:00:22 +0530
Message-Id: <20240701123022.68700-1-aboorvad@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hKbCSgkuic0HnYXBMrGm04tYsAmHK6jc
X-Proofpoint-ORIG-GUID: hKbCSgkuic0HnYXBMrGm04tYsAmHK6jc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-01_10,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 mlxscore=0 clxscore=1011
 priorityscore=1501 bulkscore=0 spamscore=0 mlxlogscore=961 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407010095

Updated sched_ext doc to eliminate references to scx_bpf_switch_all,
which has been removed in recent sched_ext versions.

Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
---
 Documentation/scheduler/sched-ext.rst | 32 ++++++++++++++++-----------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/Documentation/scheduler/sched-ext.rst b/Documentation/scheduler/sched-ext.rst
index 497eeaa5ecbe..d887e9e11256 100644
--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -44,17 +44,24 @@ options should be enabled to use sched_ext:
     CONFIG_PAHOLE_HAS_SPLIT_BTF=y
     CONFIG_PAHOLE_HAS_BTF_TAG=y
 
-sched_ext is used only when the BPF scheduler is loaded and running.
 
-If a task explicitly sets its scheduling policy to ``SCHED_EXT``, it will be
-treated as ``SCHED_NORMAL`` and scheduled by CFS until the BPF scheduler is
-loaded. On load, such tasks will be switched to and scheduled by sched_ext.
+sched_ext is used only when the BPF scheduler is loaded and running. To use
+sched_ext, a task can invoke ``sched_setscheduler`` with the ``SCHED_EXT``
+policy constant.
 
-The BPF scheduler can choose to schedule all normal and lower class tasks by
-calling ``scx_bpf_switch_all()`` from its ``init()`` operation. In this
-case, all ``SCHED_NORMAL``, ``SCHED_BATCH``, ``SCHED_IDLE`` and
-``SCHED_EXT`` tasks are scheduled by sched_ext. In the example schedulers,
-this mode can be selected with the ``-a`` option.
+When the BPF scheduler is not loaded, tasks with the ``SCHED_EXT`` policy are
+treated as ``SCHED_NORMAL`` and scheduled by CFS. ``SCHED_NORMAL`` tasks
+continue to be scheduled by CFS.
+
+When the BPF scheduler is loaded, all tasks with the ``SCHED_EXT`` policy are
+switched to sched_ext. By default, if the ``struct ops->flag`` is not set to
+``SCX_OPS_SWITCH_PARTIAL``, ``SCHED_EXT``, ``SCHED_NORMAL``, and lower class
+tasks are scheduled by sched_ext. In this case, all ``SCHED_NORMAL``,
+``SCHED_BATCH``, ``SCHED_IDLE``, and ``SCHED_EXT`` tasks are scheduled by
+sched_ext.
+
+However, if the ``struct ops->flag`` is set to``SCX_OPS_SWITCH_PARTIAL``,
+only tasks with the policy set to ``SCHED_EXT`` are scheduled by sched_ext.
 
 Terminating the sched_ext scheduler program, triggering :kbd:`SysRq-S`, or
 detection of any internal error including stalled runnable tasks aborts the
@@ -156,13 +163,12 @@ optional. The following modified excerpt is from
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


