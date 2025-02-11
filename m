Return-Path: <linux-kernel+bounces-509916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5AAA315FC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 20:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CBEA162675
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2025 19:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C472265CD2;
	Tue, 11 Feb 2025 19:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hnfFNmeZ"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCED262175
	for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2025 19:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739303431; cv=none; b=DMIXkdcUmu7FRedstU5KZQ9gKt6qGgEnep4FTW4FfvumzJCMlGzGJSfxs1Z2SMgcUFqlfFhaeOI7hw2L5/ttNq6QUNGmmBQFTL+NII3PLjGKiJ6vQNDdF+soukPrkKKVOa0Nh1qxOhrtJ787GV9I9+aIvbLr32Pu7recAkYsggc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739303431; c=relaxed/simple;
	bh=wfLZW5gqtvVmGHnil9DDZFmpzOx8V/Vjk+jgnWcGFhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a+fDsV0I3XLZS7S5/2sulrwLsyMiUc5jYBq3RcBPreP6sWUhJeUbsVCLa8TszpQQgJQjA4g5kAn3Enjxq1xtdvVONDez8x6HuFVUt1FoKdhfLMECrjRTPTes3spu7kX6sSHHFVNlrZ9sjlEHXZqfQCiVkS1x/b/Dubszt317iMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hnfFNmeZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51BGYoxX015636;
	Tue, 11 Feb 2025 19:49:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=79Q7RCoFbvD/ApWNVNwamV+gO+i8NxSznRW253IJX
	10=; b=hnfFNmeZ7y0FcqoIWMZNhSAo6hLXsQKBMrzb8VlswRdbWMIk+t/ZwK0/9
	vv49TNKxg8aAJ/uxqlXiz3Qh1lWfhqGJrUFH/VjZJZBzCn8JwnSuluHzB5TUG3yW
	fVudqu0tC8H/8GhNIwgdubPT8eSgckoxKNPQXqwZv8uWj9hfaUTZCRD51p3cESPQ
	1rzKYCse5GuxCeF2DjH2AfM4BeJYJMu0w2LSwLBIcoRPUkhXXUNJu8p7KZLB+RuE
	VCn6UszP8x5vZj/4LXHmJS4xMCjAq4T08e+mHTjy8Eum4IU95rsBbk88ihugPX6m
	DilesS+ETt2WARsqRzfGUZMAhpkjA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44r28puh3k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 19:49:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51BGMIf4021672;
	Tue, 11 Feb 2025 19:49:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44phksn50e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Feb 2025 19:49:55 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51BJnqqi33816882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Feb 2025 19:49:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 56B7D20043;
	Tue, 11 Feb 2025 19:49:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B25120040;
	Tue, 11 Feb 2025 19:49:50 +0000 (GMT)
Received: from li-7bb28a4c-2dab-11b2-a85c-887b5c60d769.ibm.com.com (unknown [9.39.23.89])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Feb 2025 19:49:50 +0000 (GMT)
From: Shrikanth Hegde <sshegde@linux.ibm.com>
To: frederic@kernel.org, linux-kernel@vger.kernel.org
Cc: sshegde@linux.ibm.com, mingo@kernel.org, peterz@infradead.org,
        vincent.guittot@linaro.org, maddy@linux.ibm.com,
        dietmar.eggemann@arm.com, riel@surriel.com
Subject: [RFC] sched/cputime: issue with time accounting using default configs
Date: Wed, 12 Feb 2025 01:15:58 +0530
Message-ID: <20250211194558.803373-1-sshegde@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Jt0HC7HrCRGQZTemKUjreg5WSib7_S2g
X-Proofpoint-GUID: Jt0HC7HrCRGQZTemKUjreg5WSib7_S2g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_08,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 suspectscore=0 impostorscore=0 mlxlogscore=753 lowpriorityscore=0
 clxscore=1011 phishscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502110126

While experimenting with irq time accounting stumbled upon this issue
with cputime accounting while running simple benchmarks.  

This is very likely a common issue across different archs unless one turns
on IRQ_TIME_ACCOUNTING. Took a look at src rpms of rhel and suse. Only
rhel on x86 seems to enable it. 

(default configs)
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
# CONFIG_IRQ_TIME_ACCOUNTING is not set
CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
all    3.41    0.00   73.81    0.00   22.00    0.00    0.10    0.00    0.00    0.67
all    3.39    0.00   73.30    0.00   22.71    0.01    0.01    0.00    0.00    0.58

(With CONFIG_IRQ_TIME_ACCOUNTING=y)
CONFIG_VIRT_CPU_ACCOUNTING=y
CONFIG_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_IRQ_TIME_ACCOUNTING=y
CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
all    3.64    0.00   94.26    0.00    1.77    0.06    0.05    0.00    0.00    0.21
all    3.42    0.00   93.89    0.00    1.94    0.07    0.00    0.00    0.00    0.68


Forced NATIVE to be enabled by removing conditional check in NO_HZ_FULL.
CONFIG_VIRT_CPU_ACCOUNTING=y
# CONFIG_TICK_CPU_ACCOUNTING is not set
CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y
CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
all    5.78    0.00   92.55    0.00    1.56    0.00    0.00    0.00    0.00    0.11
all    6.14    0.00   91.86    0.00    1.68    0.02    0.00    0.00    0.00    0.29

Given the code, NATIVE accounting seems most accurate, 
since it tracks enter/exit of user, hardirq, softirqs. 
Though it comes with its own overhead.


Such a drastic difference w.r.t to *irq time*. That made me wonder why?
This happens because of when NO_HZ_FULL is chosen, NATIVE accounting
cannot be enabled and GENeric is the option. 
GEN -> account_process_tick ->
	-> if context tracking is enabled, do accounting based on it. 
	-> if irq_time accounting is enabled, do that. 
	-> If not, fall back to simple tick based accounting. With this
	   whole tick duration can be attributed to IRQ. Which is not true.

NATIVE -> account_process_tick ->
	vtime_flush - native based accounting. 


The main concern is, context tracking is enabled only if NO_HZ_FULL=y and 
(nohz_full= or isolcpus=) is set. Most of the kernels are built with
NO_HZ_FULL, but many may not pass the nohz_full=. (correct me if i am
wrong). This leads to context tracking isn't being enabled. Since irq
time isn't enabled either, it falls into simple tick based accounting. 

A few ways to fix. Some may not be sane. These are the hacks that i have
tried. 

1. Looking at irq_time vs native accounting, seems like irq_time is
lightweight and close enough to native. maybe that can be a middle
ground. So enable it for the arch default configs. That way distros can
enable it. below patch is with this method. 
NOTE: this needs more work still w.r.t to measuring the overhead.

2. Select IRQ_TIME_ACCOUNTING in case of NO_HZ_FULL. This would fix this
accounting issue for all archs. But given a slight overhead, some archs
may not want it. 

3. If context tracking is not enabled, then do native way if archs
supports it. since native and irq_time are exclusive only one of them
can be enabled. This needs a lot of change given how the current code is
with macros. Also this meant decoupling native from NO_HZ_FULL. 
 
Is this a problem worth fixing? are there any better way to fix it? 

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
---
 arch/powerpc/configs/ppc64_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 465eb96c755e..9bc678d92384 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -3,6 +3,7 @@ CONFIG_POSIX_MQUEUE=y
 CONFIG_AUDIT=y
 CONFIG_NO_HZ_FULL=y
 CONFIG_NO_HZ=y
+CONFIG_IRQ_TIME_ACCOUNTING=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_BPF_SYSCALL=y
 CONFIG_BPF_JIT=y
-- 
2.39.3


