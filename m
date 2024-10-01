Return-Path: <linux-kernel+bounces-345807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249F498BB61
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 13:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 486601C22493
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBCD81C0DD6;
	Tue,  1 Oct 2024 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q6+VpXET"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0821C0DCC
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 11:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727782755; cv=none; b=qa5MvmHYXS3Zfs93yZUyt9ShaW/rYsBRarPnjYQHZkPuNgCYeKD7yZVFG8Z57sjrc/WbbBTHe3NPZxk0P/0FI1svga1WZ2D78I9lV571CqD7oR8F3YW/Z8SFJL6kXpNRyvJRib/Cveo17FSaKKvSaqt7Pj6Tt4DIU4MwnRwvf+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727782755; c=relaxed/simple;
	bh=J7eSqIlI6DHlgHjNhwl5eWKu8XB+oZ9v0aZfXnyLs9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=bXLWM7JTF7lVDcKnoaFuaybFD0xjUcQMxzTDsz11viGFRmk46BxPzazYabmsZbmhpMGAOzf8kifdUHsA7T1bkJu/rcMx356EMy6l7j+fe3vBXRaMbUlGaE06yxO0bL1HfjLvlFRJ5oP5Kp96sACsG7SYFseEm4GJGYxU6GXeHZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q6+VpXET; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4919iONE011432;
	Tue, 1 Oct 2024 11:39:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:content-type:mime-version; s=pp1;
	 bh=HZAqqG7dPtXbao6YoTgp4NHcvN+qI55ul+/f7mAXrxM=; b=Q6+VpXETx7Yw
	7ogTk47DPei8tmY9gbWDuJ+1GM6emxWtk9n1p+2DRkFU8nEpiE+jd1vZJxAJkpKN
	cfoUqwvcPgWw16myJMNKLyovRkDNqfupnjSvL3PSZos5a+iluey5ggQtOXJQKnMc
	QDUoRZTs82RnqbEmDMmcOZBOmz7DBBGhw9pVqcXVwGdDALn89NC2HOp8t9sJiBuu
	Bk5HzbzPrAFPEJJ3fvIwCjlxKGBQqrBu4Yhyz0UB23LGUsGpbKiUlvqaD2XzuPPg
	YOhavIvQ9X/JFAyAZ1zU1l+3HUefyczmiMIEZImMSTWosxVbGcnB5NpTMEQyByn2
	JKGiwAWh5Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420ckj993m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 11:39:09 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 491Bd8vw018572;
	Tue, 1 Oct 2024 11:39:08 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420ckj993g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 11:39:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4918anRn007923;
	Tue, 1 Oct 2024 11:39:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 41xvgxv63g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 11:39:07 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 491Bd5j658917298
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 11:39:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10A7220043;
	Tue,  1 Oct 2024 11:39:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2B34A20040;
	Tue,  1 Oct 2024 11:39:03 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.109.245.217])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  1 Oct 2024 11:39:02 +0000 (GMT)
Date: Tue, 1 Oct 2024 17:08:58 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>, Josh Don <joshdon@google.com>,
        Hao Luo <haoluo@google.com>, Barret Rhoden <brho@google.com>,
        linux-kernel@vger.kernel.org
Subject: sched_ext: build errors when building flatcg and qmap schedulers
Message-ID: <ZvvfUqRNM4-jYQzH@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3hV6VjXmZ8UodsTMBoNwXcbG1ibFY16K
X-Proofpoint-GUID: 3o7gt6uAtT49DRBaC_lKYfGIBUKitHjc
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_07,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 phishscore=0 adultscore=0 mlxlogscore=896 suspectscore=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410010075

Hi, 

Getting build error when trying to compile example schedulers in
tools/sched_ext/* (logs shared in the end)


tools/sched_ext # make -s -k


git repo state
$ git log --oneline
e32cde8d2bd7d (HEAD -> master, origin/master, origin/HEAD) Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext
190ecde722dd0 Merge tag 'probes-fixes-v6.12-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace
a5f24c795513f Merge tag 'vfs-6.12-rc2.fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs
f801850bc263d netfs: Fix the netfs_folio tracepoint to handle NULL mapping
28e8c5c095ec2 netfs: Add folio_queue API documentation
2007d28ec0095 bcachefs: rename version -> bversion for big endian builds
34820304cc2cd uprobes: fix kernel info leak via "[uprobes]" vma
9852d85ec9d49 (tag: v6.12-rc1) Linux 6.12-rc1


Adding __weak attribute seems to have fixed it and compilation completed
with no errors.

diff --git a/tools/sched_ext/include/scx/common.bpf.h b/tools/sched_ext/include/scx/common.bpf.h
index 225f61f9bfca..27749c51c3ec 100644
--- a/tools/sched_ext/include/scx/common.bpf.h
+++ b/tools/sched_ext/include/scx/common.bpf.h
@@ -41,8 +41,8 @@ void scx_bpf_dispatch_vtime(struct task_struct *p, u64 dsq_id, u64 slice, u64 vt
 u32 scx_bpf_dispatch_nr_slots(void) __ksym;
 void scx_bpf_dispatch_cancel(void) __ksym;
 bool scx_bpf_consume(u64 dsq_id) __ksym;
-void scx_bpf_dispatch_from_dsq_set_slice(struct bpf_iter_scx_dsq *it__iter, u64 slice) __ksym;
-void scx_bpf_dispatch_from_dsq_set_vtime(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __ksym;
+void scx_bpf_dispatch_from_dsq_set_slice(struct bpf_iter_scx_dsq *it__iter, u64 slice) __ksym __weak;
+void scx_bpf_dispatch_from_dsq_set_vtime(struct bpf_iter_scx_dsq *it__iter, u64 vtime) __ksym __weak;
 bool scx_bpf_dispatch_from_dsq(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
 bool scx_bpf_dispatch_vtime_from_dsq(struct bpf_iter_scx_dsq *it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __ksym __weak;
 u32 scx_bpf_reenqueue_local(void) __ksym;
@@ -71,7 +71,7 @@ s32 scx_bpf_pick_any_cpu(const cpumask_t *cpus_allowed, u64 flags) __ksym;
 bool scx_bpf_task_running(const struct task_struct *p) __ksym;
 s32 scx_bpf_task_cpu(const struct task_struct *p) __ksym;
 struct rq *scx_bpf_cpu_rq(s32 cpu) __ksym;
-struct cgroup *scx_bpf_task_cgroup(struct task_struct *p) __ksym;
+struct cgroup *scx_bpf_task_cgroup(struct task_struct *p) __ksym __weak;

 /*
  * Use the following as @it__iter when calling



---- Start of error log 

$ make -s -k
Warning: Kernel ABI header at 'tools/include/uapi/linux/bpf.h' differs from latest version at 'include/uapi/linux/bpf.h'
Warning: Kernel ABI header at 'tools/include/uapi/linux/if_xdp.h' differs from latest version at 'include/uapi/linux/if_xdp.h'

Auto-detecting system features:
...                         clang-bpf-co-re: [ on  ]
...                                    llvm: [ on  ]
...                                  libcap: [ OFF ]
...                                  libbfd: [ OFF ]

scx_qmap.bpf.c:321:4: error: static assertion failed due to requirement '!__builtin_constant_p(!!scx_bpf_dispatch_from_dsq_set_slice)': scx_bpf_dispatch_from_dsq_set_slice should be marked as __weak
  321 |                         __COMPAT_scx_bpf_dispatch_from_dsq_set_slice(
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  322 |                                 BPF_FOR_EACH_ITER, slice_ns * 2);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$HOME/linux-x86/tools/sched_ext/include/scx/compat.bpf.h:25:3: note: expanded from macro '__COMPAT_scx_bpf_dispatch_from_dsq_set_slice'
   25 |         (bpf_ksym_exists(scx_bpf_dispatch_from_dsq_set_slice) ?                 \
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$HOME/linux-x86/tools/sched_ext/build/include/bpf/bpf_helpers.h:191:17: note: expanded from macro 'bpf_ksym_exists'
  191 |         _Static_assert(!__builtin_constant_p(!!sym),                    \
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
scx_qmap.bpf.c:323:4: error: static assertion failed due to requirement '!__builtin_constant_p(!!scx_bpf_dispatch_from_dsq_set_vtime)': scx_bpf_dispatch_from_dsq_set_vtime should be marked as __weak
  323 |                         __COMPAT_scx_bpf_dispatch_from_dsq_set_vtime(
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  324 |                                 BPF_FOR_EACH_ITER, highpri_seq++);
      |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$HOME/linux-x86/tools/sched_ext/include/scx/compat.bpf.h:28:3: note: expanded from macro '__COMPAT_scx_bpf_dispatch_from_dsq_set_vtime'
   28 |         (bpf_ksym_exists(scx_bpf_dispatch_from_dsq_set_vtime) ?                 \
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$HOME/linux-x86/tools/sched_ext/build/include/bpf/bpf_helpers.h:191:17: note: expanded from macro 'bpf_ksym_exists'
  191 |         _Static_assert(!__builtin_constant_p(!!sym),                    \
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
2 errors generated.
make: *** [Makefile:165: $HOME/linux-x86/tools/sched_ext/build/obj/sched_ext/scx_qmap.bpf.o] Error 1
scx_flatcg.bpf.c:388:9: error: static assertion failed due to requirement '!__builtin_constant_p(!!scx_bpf_task_cgroup)': scx_bpf_task_cgroup should be marked as __weak
  388 |         cgrp = __COMPAT_scx_bpf_task_cgroup(p);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$HOME/linux-x86/tools/sched_ext/include/scx/compat.bpf.h:20:3: note: expanded from macro '__COMPAT_scx_bpf_task_cgroup'
   20 |         (bpf_ksym_exists(scx_bpf_task_cgroup) ?                                 \
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$HOME/linux-x86/tools/sched_ext/build/include/bpf/bpf_helpers.h:191:17: note: expanded from macro 'bpf_ksym_exists'
  191 |         _Static_assert(!__builtin_constant_p(!!sym),                    \
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
scx_flatcg.bpf.c:514:9: error: static assertion failed due to requirement '!__builtin_constant_p(!!scx_bpf_task_cgroup)': scx_bpf_task_cgroup should be marked as __weak
  514 |         cgrp = __COMPAT_scx_bpf_task_cgroup(p);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$HOME/linux-x86/tools/sched_ext/include/scx/compat.bpf.h:20:3: note: expanded from macro '__COMPAT_scx_bpf_task_cgroup'
   20 |         (bpf_ksym_exists(scx_bpf_task_cgroup) ?                                 \
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$HOME/linux-x86/tools/sched_ext/build/include/bpf/bpf_helpers.h:191:17: note: expanded from macro 'bpf_ksym_exists'
  191 |         _Static_assert(!__builtin_constant_p(!!sym),                    \
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
scx_flatcg.bpf.c:527:9: error: static assertion failed due to requirement '!__builtin_constant_p(!!scx_bpf_task_cgroup)': scx_bpf_task_cgroup should be marked as __weak
  527 |         cgrp = __COMPAT_scx_bpf_task_cgroup(p);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$HOME/linux-x86/tools/sched_ext/include/scx/compat.bpf.h:20:3: note: expanded from macro '__COMPAT_scx_bpf_task_cgroup'
   20 |         (bpf_ksym_exists(scx_bpf_task_cgroup) ?                                 \
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$HOME/linux-x86/tools/sched_ext/build/include/bpf/bpf_helpers.h:191:17: note: expanded from macro 'bpf_ksym_exists'
  191 |         _Static_assert(!__builtin_constant_p(!!sym),                    \
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
scx_flatcg.bpf.c:570:9: error: static assertion failed due to requirement '!__builtin_constant_p(!!scx_bpf_task_cgroup)': scx_bpf_task_cgroup should be marked as __weak
  570 |         cgrp = __COMPAT_scx_bpf_task_cgroup(p);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$HOME/linux-x86/tools/sched_ext/include/scx/compat.bpf.h:20:3: note: expanded from macro '__COMPAT_scx_bpf_task_cgroup'
   20 |         (bpf_ksym_exists(scx_bpf_task_cgroup) ?                                 \
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$HOME/linux-x86/tools/sched_ext/build/include/bpf/bpf_helpers.h:191:17: note: expanded from macro 'bpf_ksym_exists'
  191 |         _Static_assert(!__builtin_constant_p(!!sym),                    \
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
scx_flatcg.bpf.c:584:9: error: static assertion failed due to requirement '!__builtin_constant_p(!!scx_bpf_task_cgroup)': scx_bpf_task_cgroup should be marked as __weak
  584 |         cgrp = __COMPAT_scx_bpf_task_cgroup(p);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$HOME/linux-x86/tools/sched_ext/include/scx/compat.bpf.h:20:3: note: expanded from macro '__COMPAT_scx_bpf_task_cgroup'
   20 |         (bpf_ksym_exists(scx_bpf_task_cgroup) ?                                 \
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$HOME/linux-x86/tools/sched_ext/build/include/bpf/bpf_helpers.h:191:17: note: expanded from macro 'bpf_ksym_exists'
  191 |         _Static_assert(!__builtin_constant_p(!!sym),                    \
      |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
5 errors generated.
make: *** [Makefile:165: $HOME/linux-x86/tools/sched_ext/build/obj/sched_ext/scx_flatcg.bpf.o] Error 1
make: Target 'all' not remade because of errors.

---- End of error log 



