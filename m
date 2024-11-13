Return-Path: <linux-kernel+bounces-406891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E47809C65A8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 01:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 771A91F2303C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 00:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19E241C6C;
	Wed, 13 Nov 2024 00:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JLzVw6F8"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18759A50
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 00:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731456122; cv=none; b=N3fTE41cleGVzeE14b9iUFbxIUVXR1GK7Vj+2/smecGADMt+QdwDm4/QOegoFHXsqJYr5W3KAxc2bMSm4Lf7zqhIFgCirWlrzg+NTtWPhPnXmIzpiE/A80dlCIA+4gQhOPuraOsul6GIk3o9uYB8DwyvV/KPzj6innO44JF7cPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731456122; c=relaxed/simple;
	bh=Q1b/AY9t9aUu6Mu4IsCtaLqvkjDwt2IwIwt6+gJsR9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXntWEBCmP9RbAT2P01dj4XQjimo3pGxTOKVtuskOGf9ueuCcc34AQO8I6R3DbOlpSBZ8ZIIrTrsdqPvQcU2u4B3lrq5bADulY4Dzv4Jg/tXAp9kZnZzFsdhMdsvaPGZDU5LBbWcpiSWYRF3HAOWcAlcfOABpd2wCo6WojIgDt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JLzVw6F8; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACN1Ohx006074;
	Wed, 13 Nov 2024 00:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2023-11-20; bh=Mrkrj
	KzT1wSbz77CbxZEjRtVE8fmoSTduLYtgoBjwWo=; b=JLzVw6F8lYVEua9qAsvrL
	T6y6sONNCz4Uj7r+HSI+voRKcPHCo64QLPbfcevbeJoSJ/CuE4j58qVS4+tdoCsC
	e/eQzZdnfdBI99sYfn/hSztOJsm8jUIfBxbO8Wx3gIwUF8/PQDEiSYVW9NZ8SFN3
	ZgB13A9ge6o2FKdqcHZ03R+n47d/IdabVVWmC+zaeFh6LcnP/rLLCxQydv/DtCyy
	7JPDPmN2CjMUqHljprlAZSHnId3vFQBUg2weH8nuw94qqKQ998gbKLLeba+CRK65
	xyV3kaILpZlna0fFS5l5vVtKL0vxZFbY9Sg7RFkSs+RUFFAf7HzX4tDhoPHAnXwv
	w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k25pch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 00:01:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACNGZsb008025;
	Wed, 13 Nov 2024 00:01:39 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx68uq7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 13 Nov 2024 00:01:39 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4AD01bKg011807;
	Wed, 13 Nov 2024 00:01:38 GMT
Received: from psang-work.osdevelopmeniad.oraclevcn.com (psang-work.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.35])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx68uq2j-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 13 Nov 2024 00:01:38 +0000
From: Prakash Sangappa <prakash.sangappa@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: rostedt@goodmis.org, peterz@infradead.org, tglx@linutronix.de,
        daniel.m.jordan@oracle.com, prakash.sangappa@oracle.com
Subject: [RFC PATCH 1/4] Introduce per thread user-kernel shared structure
Date: Wed, 13 Nov 2024 00:01:23 +0000
Message-ID: <20241113000126.967713-2-prakash.sangappa@oracle.com>
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
X-Proofpoint-ORIG-GUID: diJilSc6g_0HYTdl2FgZE8-JgNiPYE4k
X-Proofpoint-GUID: diJilSc6g_0HYTdl2FgZE8-JgNiPYE4k

A structure per thread is allocated from a page that is shared mapped
between user space and kernel, to be used as a means for faster
communication. This will facilitate sharing thread specific information
between user space and kernel, which can be accessed by the application
without requiring system calls in latency sensitive code path.

This change adds a new system call, which will allocate the shared
structure and return its mapped user address. Multiple such structures
will be allocated on a page to accommodate requests from different
threads of a multithreaded process. Available space on a page is managed
using a bitmap. When a thread exits, the shared structure is freed and
can get reused for another thread that requests it. More pages will be
allocated and used as needed based on the number of threads requesting
use of shared structures. These pages are all freed when the process
exits.

Each of these per thread shared structures are rounded to 128 bytes.
Available space in this structure can be used to add structure members
to implement new features.

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 include/linux/mm_types.h               |   4 +
 include/linux/sched.h                  |   5 +
 include/linux/syscalls.h               |   2 +
 include/linux/task_shared.h            |  63 +++++
 include/uapi/asm-generic/unistd.h      |   4 +-
 include/uapi/linux/task_shared.h       |  18 ++
 init/Kconfig                           |  10 +
 kernel/fork.c                          |  12 +
 kernel/sys_ni.c                        |   2 +
 mm/Makefile                            |   1 +
 mm/mmap.c                              |  13 ++
 mm/task_shared.c                       | 306 +++++++++++++++++++++++++
 14 files changed, 441 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/task_shared.h
 create mode 100644 include/uapi/linux/task_shared.h
 create mode 100644 mm/task_shared.c

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 534c74b14fab..3838fdc3d292 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -468,3 +468,4 @@
 460	i386	lsm_set_self_attr	sys_lsm_set_self_attr
 461	i386	lsm_list_modules	sys_lsm_list_modules
 462	i386	mseal 			sys_mseal
+463	i386	task_getshared		sys_task_getshared
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 7093ee21c0d1..5bc4ecd74117 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -386,6 +386,7 @@
 460	common	lsm_set_self_attr	sys_lsm_set_self_attr
 461	common	lsm_list_modules	sys_lsm_list_modules
 462 	common  mseal			sys_mseal
+463	common	task_getshared		sys_task_getshared
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 6e3bdf8e38bc..d32d92a47c34 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1030,6 +1030,10 @@ struct mm_struct {
 #endif
 		} lru_gen;
 #endif /* CONFIG_LRU_GEN_WALKS_MMU */
+#ifdef CONFIG_TASKSHARED
+		/* user shared pages */
+		void *usharedpg;
+#endif
 	} __randomize_layout;
 
 	/*
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ee9d8aecc5b5..1ca7d4efa932 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1593,6 +1593,11 @@ struct task_struct {
 	struct user_event_mm		*user_event_mm;
 #endif
 
+#ifdef	CONFIG_TASKSHARED
+	/* user shared struct */
+	void *task_ushrd;
+#endif
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 5758104921e6..3ca79244aa0b 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -997,6 +997,8 @@ asmlinkage long sys_spu_create(const char __user *name,
 		unsigned int flags, umode_t mode, int fd);
 
 
+asmlinkage long sys_task_getshared(long opt, long flags, void __user *uaddr);
+
 /*
  * Deprecated system calls which are still defined in
  * include/uapi/asm-generic/unistd.h and wanted by >= 1 arch
diff --git a/include/linux/task_shared.h b/include/linux/task_shared.h
new file mode 100644
index 000000000000..983fdae47308
--- /dev/null
+++ b/include/linux/task_shared.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef	__TASK_SHARED_H__
+#define	__TASK_SHARED_H__
+
+#include <linux/mm_types.h>
+#include <uapi/linux/task_shared.h>
+
+#ifdef CONFIG_TASKSHARED
+/*
+ * Track user-kernel shared pages referred by mm_struct
+ */
+struct ushared_pages {
+	struct list_head plist;
+	struct list_head frlist;
+	unsigned long pcount;
+};
+
+
+/*
+ * Following is used for cacheline aligned allocations of shared structures
+ * within a page.
+ */
+union task_shared {
+	struct task_sharedinfo ts;
+	char    s[128];
+};
+
+/*
+ * Struct to track per page slots
+ */
+struct ushared_pg {
+	struct list_head list;
+	struct list_head fr_list;
+	struct page *pages[2];
+	u64 bitmap; /* free slots */
+	int slot_count;
+	unsigned long kaddr;
+	unsigned long vaddr; /* user address */
+	struct vm_special_mapping ushrd_mapping;
+};
+
+/*
+ * Following struct is referred by struct task_struct, contains mapped address
+ * of per thread shared structure allocated.
+ */
+struct task_ushrd_struct {
+	union task_shared *kaddr; /* kernel address */
+	union task_shared *uaddr; /* user address */
+	struct ushared_pg *upg;
+};
+
+extern void task_ushared_free(struct task_struct *t);
+extern void mm_ushared_clear(struct mm_struct *mm);
+#else	/* !CONFIG_TASKSHARED */
+static inline void task_ushared_free(struct task_struct *t)
+{
+}
+
+static inline void mm_ushared_clear(struct mm_struct *mm)
+{
+}
+#endif /* !CONFIG_TASKSHARED */
+#endif /* __TASK_SHARED_H__ */
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 5bf6148cac2b..7f6367616fb5 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -840,9 +840,11 @@ __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
 
 #define __NR_mseal 462
 __SYSCALL(__NR_mseal, sys_mseal)
+#define __NR_task_getshared 463
+__SYSCALL(__NR_task_getshared, sys_task_getshared)
 
 #undef __NR_syscalls
-#define __NR_syscalls 463
+#define __NR_syscalls 464
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/task_shared.h b/include/uapi/linux/task_shared.h
new file mode 100644
index 000000000000..a07902c57380
--- /dev/null
+++ b/include/uapi/linux/task_shared.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+#ifndef LINUX_TASK_SHARED_H
+#define LINUX_TASK_SHARED_H
+
+/*
+ * Per task user-kernel mapped structure
+ */
+
+/*
+ * Option to request allocation of struct task_sharedinfo shared structure,
+ * used for sharing per thread information between userspace and kernel.
+ */
+#define TASK_SHAREDINFO 1
+
+struct task_sharedinfo {
+		int version;
+};
+#endif
diff --git a/init/Kconfig b/init/Kconfig
index a7666e186064..1f84851d1b7e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1803,6 +1803,16 @@ config DEBUG_RSEQ
 	  Enable extra debugging checks for the rseq system call.
 
 	  If unsure, say N.
+config TASKSHARED
+	bool "Enable task getshared syscall" if EXPERT
+	default y
+	help
+	  Enable mechanism to provide per thread shared structure mapped
+	  between userspace<->kernel for faster communication. Used
+	  for sharing per thread information.
+
+	  If unsure, say Y.
+
 
 config CACHESTAT_SYSCALL
 	bool "Enable cachestat() system call" if EXPERT
diff --git a/kernel/fork.c b/kernel/fork.c
index 22f43721d031..b40792c84718 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -112,6 +112,7 @@
 #include <asm/mmu_context.h>
 #include <asm/cacheflush.h>
 #include <asm/tlbflush.h>
+#include <linux/task_shared.h>
 
 #include <trace/events/sched.h>
 
@@ -1126,6 +1127,11 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	if (err)
 		goto free_stack;
 
+#ifdef CONFIG_TASKSHARED
+	/* task's shared structures are not inherited across fork */
+	tsk->task_ushrd =  NULL;
+#endif
+
 #ifdef CONFIG_SECCOMP
 	/*
 	 * We must handle setting up seccomp filters once we're under
@@ -1282,6 +1288,10 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !defined(CONFIG_SPLIT_PMD_PTLOCKS)
 	mm->pmd_huge_pte = NULL;
 #endif
+
+#ifdef CONFIG_TASKSHARED
+	mm->usharedpg = NULL;
+#endif
 	mm_init_uprobes_state(mm);
 	hugetlb_count_init(mm);
 
@@ -1346,6 +1356,7 @@ static inline void __mmput(struct mm_struct *mm)
 	ksm_exit(mm);
 	khugepaged_exit(mm); /* must run before exit_mmap */
 	exit_mmap(mm);
+	mm_ushared_clear(mm);
 	mm_put_huge_zero_folio(mm);
 	set_mm_exe_file(mm, NULL);
 	if (!list_empty(&mm->mmlist)) {
@@ -1605,6 +1616,7 @@ static int wait_for_vfork_done(struct task_struct *child,
 static void mm_release(struct task_struct *tsk, struct mm_struct *mm)
 {
 	uprobe_free_utask(tsk);
+	task_ushared_free(tsk);
 
 	/* Get rid of any cached register state */
 	deactivate_mm(tsk, mm);
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index c00a86931f8c..9039a69e95ac 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -390,5 +390,7 @@ COND_SYSCALL(setuid16);
 
 /* restartable sequence */
 COND_SYSCALL(rseq);
+/* task shared */
+COND_SYSCALL(task_getshared);
 
 COND_SYSCALL(uretprobe);
diff --git a/mm/Makefile b/mm/Makefile
index d5639b036166..007743b40f87 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -145,3 +145,4 @@ obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
 obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
 obj-$(CONFIG_EXECMEM) += execmem.o
 obj-$(CONFIG_TMPFS_QUOTA) += shmem_quota.o
+obj-$(CONFIG_TASKSHARED) += task_shared.o
diff --git a/mm/mmap.c b/mm/mmap.c
index 79d541f1502b..05b947fac55b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2086,6 +2086,18 @@ static int special_mapping_split(struct vm_area_struct *vma, unsigned long addr)
 	return -EINVAL;
 }
 
+/*
+ * XXX: Having a mkwrite hook prevents attempt to update file time on
+ * page write fault, these mappings do not have a file structure associated.
+ */
+static vm_fault_t special_mapping_page_mkwrite(struct vm_fault *vmf)
+{
+	struct page *page = vmf->page;
+	lock_page(page);
+
+	return VM_FAULT_LOCKED;
+}
+
 static const struct vm_operations_struct special_mapping_vmops = {
 	.close = special_mapping_close,
 	.fault = special_mapping_fault,
@@ -2094,6 +2106,7 @@ static const struct vm_operations_struct special_mapping_vmops = {
 	/* vDSO code relies that VVAR can't be accessed remotely */
 	.access = NULL,
 	.may_split = special_mapping_split,
+	.page_mkwrite = special_mapping_page_mkwrite,
 };
 
 static vm_fault_t special_mapping_fault(struct vm_fault *vmf)
diff --git a/mm/task_shared.c b/mm/task_shared.c
new file mode 100644
index 000000000000..cea45d913b91
--- /dev/null
+++ b/mm/task_shared.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/mm.h>
+#include <linux/uio.h>
+#include <linux/sched.h>
+#include <linux/sched/mm.h>
+#include <linux/highmem.h>
+#include <linux/ptrace.h>
+#include <linux/slab.h>
+#include <linux/syscalls.h>
+#include <linux/task_shared.h>
+
+/*
+ * Per thread shared structure mechanism
+ */
+
+#define TASK_USHARED_SLOTS (PAGE_SIZE/sizeof(union task_shared))
+
+/*
+ * Called once to init struct ushared_pages pointer.
+ */
+static int init_mm_ushared(struct mm_struct *mm)
+{
+	struct ushared_pages *usharedpg;
+
+	usharedpg = kmalloc(sizeof(struct ushared_pages), GFP_KERNEL);
+	if (usharedpg == NULL)
+		return 1;
+
+	INIT_LIST_HEAD(&usharedpg->plist);
+	INIT_LIST_HEAD(&usharedpg->frlist);
+	usharedpg->pcount = 0;
+	mmap_write_lock(mm);
+	if (mm->usharedpg == NULL) {
+		mm->usharedpg = usharedpg;
+		usharedpg = NULL;
+	}
+	mmap_write_unlock(mm);
+	if (usharedpg != NULL)
+		kfree(usharedpg);
+	return 0;
+}
+
+static int init_task_ushrd(struct task_struct *t)
+{
+	struct task_ushrd_struct *ushrd;
+
+	ushrd = kzalloc(sizeof(struct task_ushrd_struct), GFP_KERNEL);
+	if (ushrd == NULL)
+		return 1;
+
+	mmap_write_lock(t->mm);
+	if (t->task_ushrd == NULL) {
+		t->task_ushrd = ushrd;
+		ushrd = NULL;
+	}
+	mmap_write_unlock(t->mm);
+	if (ushrd != NULL)
+		kfree(ushrd);
+	return 0;
+}
+
+/*
+ * Called from __mmput(), mm is going away
+ */
+void mm_ushared_clear(struct mm_struct *mm)
+{
+	struct ushared_pg *upg;
+	struct ushared_pg *tmp;
+	struct ushared_pages *usharedpg;
+
+	if (mm == NULL || mm->usharedpg == NULL)
+		return;
+
+	usharedpg = mm->usharedpg;
+	if (list_empty(&usharedpg->frlist))
+		goto out;
+
+	list_for_each_entry_safe(upg, tmp, &usharedpg->frlist, fr_list) {
+		list_del(&upg->fr_list);
+		put_page(upg->pages[0]);
+		kfree(upg);
+	}
+out:
+	kfree(mm->usharedpg);
+	mm->usharedpg = NULL;
+
+}
+
+void task_ushared_free(struct task_struct *t)
+{
+	struct task_ushrd_struct *ushrd = t->task_ushrd;
+	struct mm_struct *mm = t->mm;
+	struct ushared_pages *usharedpg;
+	int slot;
+
+	if (mm == NULL || mm->usharedpg == NULL || ushrd == NULL)
+		return;
+
+	usharedpg = mm->usharedpg;
+	mmap_write_lock(mm);
+
+	if (ushrd->upg == NULL)
+		goto out;
+
+	slot = (unsigned long)((unsigned long)ushrd->uaddr
+		 - ushrd->upg->vaddr) / sizeof(union task_shared);
+	clear_bit(slot, (unsigned long *)(&ushrd->upg->bitmap));
+
+	/* move to head */
+	if (ushrd->upg->slot_count == 0) {
+		list_del(&ushrd->upg->fr_list);
+		list_add(&ushrd->upg->fr_list, &usharedpg->frlist);
+	}
+
+	ushrd->upg->slot_count++;
+
+	ushrd->uaddr = ushrd->kaddr = NULL;
+	ushrd->upg = NULL;
+
+out:
+	t->task_ushrd = NULL;
+	mmap_write_unlock(mm);
+	kfree(ushrd);
+}
+
+/* map shared page */
+static int task_shared_add_vma(struct ushared_pg *pg)
+{
+	struct vm_area_struct *vma;
+	struct mm_struct *mm =  current->mm;
+	unsigned long ret = 1;
+
+
+	if (!pg->vaddr) {
+		/* Try to map as high as possible, this is only a hint. */
+		pg->vaddr = get_unmapped_area(NULL, TASK_SIZE - PAGE_SIZE,
+					PAGE_SIZE, 0, 0);
+		if (pg->vaddr & ~PAGE_MASK) {
+			ret = 0;
+			goto fail;
+		}
+	}
+
+	vma = _install_special_mapping(mm, pg->vaddr, PAGE_SIZE,
+			VM_SHARED|VM_READ|VM_MAYREAD|
+			VM_WRITE|VM_MAYWRITE|VM_DONTCOPY|VM_IO,
+			&pg->ushrd_mapping);
+	if (IS_ERR(vma)) {
+		ret = 0;
+		pg->vaddr = 0;
+		goto fail;
+	}
+
+	pg->kaddr = (unsigned long)page_address(pg->pages[0]);
+fail:
+	return ret;
+}
+
+/*
+ * Allocate a page, map user address and add to freelist
+ */
+static struct ushared_pg *ushared_allocpg(void)
+{
+
+	struct ushared_pg *pg;
+	struct mm_struct *mm = current->mm;
+	struct ushared_pages *usharedpg = mm->usharedpg;
+
+	if (usharedpg == NULL)
+		return NULL;
+	pg = kzalloc(sizeof(*pg), GFP_KERNEL);
+
+	if (unlikely(!pg))
+		return NULL;
+	pg->ushrd_mapping.name = "[task_shared]";
+	pg->ushrd_mapping.fault = NULL;
+	pg->ushrd_mapping.pages = pg->pages;
+	pg->pages[0] = alloc_page(GFP_KERNEL);
+	if (!pg->pages[0])
+		goto out;
+	pg->pages[1] = NULL;
+	pg->bitmap = 0;
+
+	/*
+	 * page size should be 4096 or 8192
+	 */
+	pg->slot_count = TASK_USHARED_SLOTS;
+
+	mmap_write_lock(mm);
+	if (task_shared_add_vma(pg)) {
+		list_add(&pg->fr_list, &usharedpg->frlist);
+		usharedpg->pcount++;
+		mmap_write_unlock(mm);
+		return pg;
+	}
+	mmap_write_unlock(mm);
+
+	__free_page(pg->pages[0]);
+out:
+	kfree(pg);
+	return NULL;
+}
+
+
+/*
+ * Allocate task_shared struct for calling thread.
+ */
+static int task_ushared_alloc(void)
+{
+	struct mm_struct *mm = current->mm;
+	struct ushared_pg *ent = NULL;
+	struct task_ushrd_struct *ushrd;
+	struct ushared_pages *usharedpg;
+	int tryalloc = 0;
+	int slot = -1;
+	int ret = -ENOMEM;
+
+	if (mm->usharedpg == NULL && init_mm_ushared(mm))
+		return ret;
+
+	if (current->task_ushrd == NULL && init_task_ushrd(current))
+		return ret;
+
+	usharedpg = mm->usharedpg;
+	ushrd = current->task_ushrd;
+repeat:
+	if (mmap_write_lock_killable(mm))
+		return -EINTR;
+
+	ent = list_empty(&usharedpg->frlist) ? NULL :
+		list_entry(usharedpg->frlist.next,
+		struct ushared_pg, fr_list);
+
+	if (ent == NULL || ent->slot_count == 0) {
+		if (tryalloc == 0) {
+			mmap_write_unlock(mm);
+			(void)ushared_allocpg();
+			tryalloc = 1;
+			goto repeat;
+		} else {
+			ent = NULL;
+		}
+	}
+
+	if (ent) {
+		slot = find_first_zero_bit((unsigned long *)(&ent->bitmap),
+		  TASK_USHARED_SLOTS);
+		BUG_ON(slot >=  TASK_USHARED_SLOTS);
+
+		set_bit(slot, (unsigned long *)(&ent->bitmap));
+
+		ushrd->uaddr = (union task_shared *)(ent->vaddr +
+		  (slot * sizeof(union task_shared)));
+		ushrd->kaddr = (union task_shared *)(ent->kaddr +
+		  (slot * sizeof(union task_shared)));
+		ushrd->upg = ent;
+		ent->slot_count--;
+		/* move it to tail */
+		if (ent->slot_count == 0) {
+			list_del(&ent->fr_list);
+			list_add_tail(&ent->fr_list, &usharedpg->frlist);
+		}
+
+	       ret = 0;
+	}
+
+	mmap_write_unlock(mm);
+	return ret;
+}
+
+
+/*
+ * Get Task Shared structure, allocate if needed and return mapped user address.
+ */
+static long task_getshared(u64 opt, u64 flags, void __user *uaddr)
+{
+	struct task_ushrd_struct *ushrd = current->task_ushrd;
+
+	/* currently only TASK_SHAREDINFO supported */
+	if (opt != TASK_SHAREDINFO)
+		return (-EINVAL);
+
+	/* if a shared structure is already allocated, return address */
+	if (ushrd != NULL && ushrd->upg != NULL) {
+		if (copy_to_user(uaddr, &ushrd->uaddr,
+			sizeof(struct  task_sharedinfo *)))
+			return (-EFAULT);
+		return 0;
+	}
+
+	task_ushared_alloc();
+	ushrd = current->task_ushrd;
+	if (ushrd != NULL && ushrd->upg != NULL) {
+		if (copy_to_user(uaddr, &ushrd->uaddr,
+			sizeof(struct task_sharedinfo *)))
+			return (-EFAULT);
+		return 0;
+	}
+	return (-ENOMEM);
+}
+
+
+SYSCALL_DEFINE3(task_getshared, u64, opt, u64, flags, void __user *, uaddr)
+{
+	return task_getshared(opt, flags, uaddr);
+}
-- 
2.43.5


