Return-Path: <linux-kernel+bounces-406890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFDB9C660A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 01:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0C61B3389E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D501F95E;
	Wed, 13 Nov 2024 00:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gHfH85C9"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187921388
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 00:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731456122; cv=none; b=bxbkAXQakZ7FHdSnixdMp3Ut/TLc2OjdkyaqvCRrj/KE4HGzFrH+eh5GvbHkoPNgklzM6DaBFFOAJpevaMBAk/kEYbx3LqXRwQaWnu9JzCm4WllXozwm6dnd9nC2Ct07XI7Y4j5+yBE1+oBY1dtgY+V4iputfNojOEk/Dc9m7fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731456122; c=relaxed/simple;
	bh=5xUQcst6pDD1YFAoXBP8sYznrv2hf4TEBf6QqVs9rFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f6sWQz56QR3PvlYf7bRANF7Z47aIWBuxcZI646308fRYWYrrTmznAu7lrTQ8x9/FUJ3YwekhbCvfDwBT9gOdQoRRypsrZKe0BatG2wns8d+V/uwq6W3q3893e3VLql44gJxgLwpfqL28Fs6djbElFkUOnDkqKMt27TF1/cwvB0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gHfH85C9; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACN1R3o028982;
	Wed, 13 Nov 2024 00:01:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=09JlznhO8b1F8A6So7yAhDx4YE160
	wfVZrVne/DxKjw=; b=gHfH85C95CbtAkCDakmHVwOZz0NWvDgqitM4v3YTbFFE0
	SoaS+Kiz2f24ACldWrTzHdJMNKTYvlOzFglSvjzkyGGdCRmG0QMPTTGsZWXxtI/2
	tylmd1RpWxFTn0FwBRJP5MGe4Mb+lOHQRP1hZGhmxy0L5XtSwemOLIYvf4HH3U9Z
	tVSkcwQ7PkJhHAaHuUesfeZvii1ZMtYHlSX21+hquHWVpVD5G+NTxx00jMD78X5u
	lQbjf8O6qObOExuADzw+b9lFRa4wMjNULfN6jPGOGGK1F6Z/q2oooGLciFlNZA2L
	7rVnfLO1maIUmo6htk2BWM+PLa+8zUdbAR5k1gsVg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k5dmn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 00:01:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACMSRJM008004;
	Wed, 13 Nov 2024 00:01:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx68uq7d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 13 Nov 2024 00:01:38 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4AD01bKe011807;
	Wed, 13 Nov 2024 00:01:37 GMT
Received: from psang-work.osdevelopmeniad.oraclevcn.com (psang-work.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.35])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx68uq2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 13 Nov 2024 00:01:37 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: rostedt@goodmis.org, peterz@infradead.org, tglx@linutronix.de,
        daniel.m.jordan@oracle.com, prakash.sangappa@oracle.com
Subject: [RFC PATCH 0/4] Scheduler time slice extension
Date: Wed, 13 Nov 2024 00:01:22 +0000
Message-ID: <20241113000126.967713-1-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.43.5
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
X-Proofpoint-ORIG-GUID: QAmwMy1lnBr1z14cVBg1dN0GmIejVz9d
X-Proofpoint-GUID: QAmwMy1lnBr1z14cVBg1dN0GmIejVz9d

A user thread can get preempted in the middle of executing a critical
section in user space while holding locks, can have undesirable affect on
performance. Having a way for the thread to request additional execution
time on cpu so that it can complete the critical section will be useful in
such scenario.  The request can be made by setting a bit in mapped memory,
such that the kernel can also access to check and grant extra execution time
on the cpu. 

There have been couple of proposals[1][2] for such a feature, which attempt
to address the above scenario by granting one extra tick of execution time.
In patch thread [1] posted by Steven Rostedt, there is ample discussion about
need for this feature. 

However, the concern has been that this can lead to abuse. One extra tick can
be a long time(about a millisec or more). Peter Zijlstra in response posted a 
prototype solution[3], which grants 50us execution time extension only.
This is achieved with the help of a timer started on that cpu at the time of
granting extra execution time. When the timer fires the thread will be
preempted, if still running. 

This patch set implements the above mentioned 50us extension time as posted
by Peter. But instead of using restartable sequences as API to set the flag
to request the extension, this patch proposes a new API with use of a per
thread shared structure implementation described below. This shared structure
is accessible in both users pace and kernel. The user thread will set the
flag in this shared structure to request execution time extension.

We tried this change with a database workload. Here are the results, comparing
runs with and without use of the 50us scheduler time slice extension. This
clearly shows there is benefit.

Test results:
=============
	Test system 2 socket AMD Genoa

	Lock table test:- a simple database test to grab table lock(spin lock).
	   Simulates sql query executions.
	   300 clients + 400 cpu hog tasks to generate load.

		Without extension : 182K SQL exec/sec
		With extension    : 262K SQL exec/sec
	   44% improvement.

	Swingbench - standard database benchmark 
	   Cached(database files on tmpfs) run, with 1000 clients.

		Without extension : 99K SQL exec/sec
		with extension    : 153K SQL exec/sec
	   55% improvement in throughput.


Shared structure mechanism:
==========================

A per thread structure is allocated from a page shared mapped between user
space and kernel. This will be useful in sharing thread specific information
between user space and kernel without the need for making system calls in
latency sensitive code path.

Implementation:

A new system call is added to request use of a shared structure by a user
thread. Kernel will allocate page(s), shared mapped with user space in
which per-thread shared structures will be allocated. These structures
are padded to 128 bytes. Multiple such shared structures will be allocated
from that page(upto 32 per 4k page) to accommodate requests from multiple
threads in a process, thus avoiding the need to allocate one page per thread. 
Additional pages are allocated as needed to accommodate more thread's
requesting the shared structure. The number of pages required will depend
on the number of threads of the process requesting/using shared structure.

These pages are pinned and so the kernel can access/update the shared
structure thru the kernel address, without the need for
copy_from_user/copy_to_user() calls. 

The system call will return a pointer(user address) to the per thread shared
structure. Application threads could save this per thread pointer in a TLS
variable and reference it.

Request for scheduler time extension described above, will be a use case 
of this shared structure API. The user thread will request execution time 
extension by setting a flag in the shared structure.

Additional members can be appended to the shared structure to implement 
new features that address other use cases. For example sharing thread's
time spent off cpu and on run queue(described in [4]). These would help
the user thread measure cpu time consumption accross some operation,
without having to call getrusage() system call or read /proc/pid/schedstat
frequently.

Another use case is to share user thread's state 'on' or 'off' cpu thru the
shared structure - which can be useful in implementing adaptive waits in
user space(as discussed in [1]). The waiter thread checks if the owner 
of the resource(lock) is 'on' cpu to continue spinning.

API:
===
	The system call 
	int task_getshared(int option, int flags, void __user *uaddr)

	Only supports TASK_SHAREDINFO option for now, 'flags' are not used.

	/* option */
	#define TASK_SHAREDINFO 1

	struct task_sharedinfo {
		volatile unsigned short sched_delay;    
	};

	#define TASK_PREEMPT_DELAY_REQ     1
	#define TASK_PREEMPT_DELAY_GRANTED 2
	#define TASK_PREEMPT_DELAY_DENIED  3


	Following call:
	__thread struct task_sharedinfo *ts;
	task_getshared(TASK_SHAREDINFO, 0, &ts);

	User task sets 'sched_delay' member to TASK_PREEMPT_DELAY_REQ to
	request scheduler time extension. Kernel sets 'sched_delay' to 
	TASK_PREEMPT_DELAY_GRANTED to indicate if the request for execution 
	time extension was granted or TASK_PREEMPT_DELAY_DENIED if denied.

[1] https://lore.kernel.org/lkml/20231025054219.1acaa3dd@gandalf.local.home/
[2] https://lore.kernel.org/lkml/1395767870-28053-1-git-send-email-khalid.aziz@oracle.com/
[3] https://lore.kernel.org/lkml/20231030132949.GA38123@noisy.programming.kicks-ass.net/
[4] https://lore.kernel.org/all/1631147036-13597-1-git-send-email-prakash.sangappa@oracle.com/

Prakash Sangappa (4):
  Introduce per thread user-kernel shared structure
  Scheduler time extention
  Indicate if schedular preemption delay request is granted
  Add scheduler preemption delay granted stats

 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 include/linux/entry-common.h           |  10 +-
 include/linux/mm_types.h               |   4 +
 include/linux/sched.h                  |  30 ++
 include/linux/syscalls.h               |   2 +
 include/linux/task_shared.h            |  63 +++++
 include/uapi/asm-generic/unistd.h      |   4 +-
 include/uapi/linux/task_shared.h       |  29 ++
 init/Kconfig                           |  10 +
 kernel/entry/common.c                  |  15 +-
 kernel/fork.c                          |  12 +
 kernel/sched/core.c                    |  28 ++
 kernel/sched/debug.c                   |   4 +
 kernel/sched/syscalls.c                |   7 +
 kernel/sys_ni.c                        |   2 +
 mm/Makefile                            |   1 +
 mm/mmap.c                              |  13 +
 mm/task_shared.c                       | 366 +++++++++++++++++++++++++
 19 files changed, 593 insertions(+), 9 deletions(-)
 create mode 100644 include/linux/task_shared.h
 create mode 100644 include/uapi/linux/task_shared.h
 create mode 100644 mm/task_shared.c

-- 
2.43.5


