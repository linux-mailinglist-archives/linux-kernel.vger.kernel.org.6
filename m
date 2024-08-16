Return-Path: <linux-kernel+bounces-289358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8D8954544
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:14:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5BFD1F2600B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 09:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF93013D297;
	Fri, 16 Aug 2024 09:13:47 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08FC13C8F0
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 09:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723799627; cv=none; b=Le2mq7ZpivdvlY2hQgqqOlPDWJqYri1rDOBEF7D1TSJBAV00ciMjFqpa7A+IQuvz3c1QDjv8aPVIgjXkI0mVpnqeCsVbKAvxzQAH3DAEzEfQAx32oYGEeIfOt1eMJZmc0dW5bbxy8PTs+g2sDbM0q+rslgUK/gPbp5NQqMaIhu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723799627; c=relaxed/simple;
	bh=4o2/qXMiZyWABXNQzZimNAZXHPtSPu+RvuGua4QSozs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TGccqIOe7j3J7IW1Cgy1hx2pnuWOrJiSP9LW+TBeyaXry3GO2JM9necJLLKeqa6tR3kXlqVpUT8IOzeH+GwSDi4TWk4IQw6A9Xt/kj3ZuXsJ4dVdvCSIJIXuB1z7eUIMf5THXw9cjKIxgL9la1EOSxoBY/UPIs7303h8SPAlE9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Wlbl26CT1z1S7wJ;
	Fri, 16 Aug 2024 17:08:46 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id AB39C1400FD;
	Fri, 16 Aug 2024 17:13:41 +0800 (CST)
Received: from huawei.com (10.175.124.71) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 16 Aug
 2024 17:13:40 +0800
From: Nanyong Sun <sunnanyong@huawei.com>
To: <hughd@google.com>, <akpm@linux-foundation.org>, <david@redhat.com>,
	<willy@infradead.org>, <ryan.roberts@arm.com>
CC: <baohua@kernel.org>, <baolin.wang@linux.alibaba.com>,
	<ioworker0@gmail.com>, <peterx@redhat.com>, <ziy@nvidia.com>,
	<sunnanyong@huawei.com>, <wangkefeng.wang@huawei.com>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] mm: control mthp per process/cgroup
Date: Fri, 16 Aug 2024 17:13:27 +0800
Message-ID: <20240816091327.54183-1-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)

Now the large folio control interfaces is system wide and tend to be
default on: file systems use large folio by default if supported,
mTHP is tend to default enable when boot [1].
When large folio enabled, some workloads have performance benefit,
but some may not and some side effects can happen: the memory usage
may increase, direct reclaim maybe more frequently because of more
large order allocations, result in cpu usage also increases. We observed
this on a product environment which run nginx, the pgscan_direct count
increased a lot than before, can reach to 3000 times per second, and
disable file large folio can fix this.

Now the anon/shmem/file mthp control interfaces is system wide, so the
control api per process or cgroup may be necessary, for example, in one
machine, some containers can use large folios and some can disable them.

This patch present a possible solution:
Extend the existing prctl api(PR_SET_THP_DISABLE), use the third argument
to specify which kind of mTHP to disable for this process.
For example:
  prctl(PR_SET_THP_DISABLE, 1, 0, 0, 0); //keep the original semantics
  prctl(PR_SET_THP_DISABLE, 1, PR_DISABLE_ANON_MTHP, 0, 0);
  prctl(PR_SET_THP_DISABLE, 1, PR_DISABLE_SHMEM_MTHP, 0, 0);
  prctl(PR_SET_THP_DISABLE, 1, PR_DISABLE_FILE_MTHP, 0, 0);

The child processes will inherit the setting so if a seed process had
configured, all processes in the cgroup will inherit the setting.

This patch does not implement control over file mTHP, this is planed to
do after pagecache folio sizes control done[2].

[1] https://lore.kernel.org/linux-mm/20240814085409.124466-1-21cnbao@gmail.com/T/
[2] https://lore.kernel.org/lkml/20240717071257.4141363-1-ryan.roberts@arm.com/T/

Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
---
This patch is more to discuss the possible directions.

I am not sure occupy 3 bits in the mm flag hole is a good way, do we need
add a new flag in mm_struct to do this?

I think another possible solution(not in this patch) is to go in the
opposite direction of this patch, i.e. only allow the processes/cgroups
who really need large folio to use the mTHP. We can add a new prctl api
to mark the process who can use some specific sizes of mTHP.

TODO:
Need modify reference manual for the change of prctl PR_SET_THP_DISABLE.

 include/linux/huge_mm.h        |  3 +++
 include/linux/sched/coredump.h |  9 +++++++--
 include/uapi/linux/prctl.h     |  5 +++++
 kernel/sys.c                   | 36 ++++++++++++++++++++++++++++------
 mm/shmem.c                     |  7 +++++--
 5 files changed, 50 insertions(+), 10 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index e25d9ebfdf89..8c0b62b732b7 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -247,6 +247,9 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 	if ((tva_flags & TVA_ENFORCE_SYSFS) && vma_is_anonymous(vma)) {
 		unsigned long mask = READ_ONCE(huge_anon_orders_always);
 
+		if (test_bit(MMF_DISABLE_ANON_MTHP, &vma->vm_mm->flags))
+			return 0;
+
 		if (vm_flags & VM_HUGEPAGE)
 			mask |= READ_ONCE(huge_anon_orders_madvise);
 		if (hugepage_global_always() ||
diff --git a/include/linux/sched/coredump.h b/include/linux/sched/coredump.h
index e62ff805cfc9..0935b4790e6f 100644
--- a/include/linux/sched/coredump.h
+++ b/include/linux/sched/coredump.h
@@ -56,6 +56,10 @@ static inline int get_dumpable(struct mm_struct *mm)
 # define MMF_DUMP_MASK_DEFAULT_ELF	0
 #endif
 					/* leave room for more dump flags */
+#define MMF_DISABLE_ANON_MTHP	13
+#define MMF_DISABLE_SHMEM_MTHP	14
+#define MMF_DISABLE_FILE_MTHP	15
+#define MMF_DISABLE_MTHP_MASK	(7 << MMF_DISABLE_ANON_MTHP)
 #define MMF_VM_MERGEABLE	16	/* KSM may merge identical pages */
 #define MMF_VM_HUGEPAGE		17	/* set when mm is available for
 					   khugepaged */
@@ -96,8 +100,9 @@ static inline int get_dumpable(struct mm_struct *mm)
 #define MMF_TOPDOWN_MASK	(1 << MMF_TOPDOWN)
 
 #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
-				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
-				 MMF_VM_MERGE_ANY_MASK | MMF_TOPDOWN_MASK)
+				 MMF_DISABLE_THP_MASK | MMF_DISABLE_MTHP_MASK |\
+				 MMF_HAS_MDWE_MASK | MMF_VM_MERGE_ANY_MASK |\
+				 MMF_TOPDOWN_MASK)
 
 static inline unsigned long mmf_init_flags(unsigned long flags)
 {
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 35791791a879..584ac45f4ec8 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -178,6 +178,11 @@ struct prctl_mm_map {
 #define PR_GET_TID_ADDRESS	40
 
 #define PR_SET_THP_DISABLE	41
+# define PR_DISABLE_ANON_MTHP	(1UL << 1)
+# define PR_DISABLE_SHMEM_MTHP	(1UL << 2)
+# define PR_DISABLE_FILE_MTHP	(1UL << 3)
+# define DISABLE_MTHP_ALL_MASK	(PR_DISABLE_ANON_MTHP | PR_DISABLE_SHMEM_MTHP |\
+				 PR_DISABLE_FILE_MTHP)
 #define PR_GET_THP_DISABLE	42
 
 /*
diff --git a/kernel/sys.c b/kernel/sys.c
index 3a2df1bd9f64..06f2b1de46a7 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -2627,17 +2627,41 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 	case PR_GET_THP_DISABLE:
 		if (arg2 || arg3 || arg4 || arg5)
 			return -EINVAL;
-		error = !!test_bit(MMF_DISABLE_THP, &me->mm->flags);
+		if (test_bit(MMF_DISABLE_THP, &me->mm->flags))
+			error = 1;
+		if (test_bit(MMF_DISABLE_ANON_MTHP, &me->mm->flags))
+			error |= PR_DISABLE_ANON_MTHP;
+		if (test_bit(MMF_DISABLE_SHMEM_MTHP, &me->mm->flags))
+			error |= PR_DISABLE_SHMEM_MTHP;
+		if (test_bit(MMF_DISABLE_FILE_MTHP, &me->mm->flags))
+			error |= PR_DISABLE_FILE_MTHP;
 		break;
 	case PR_SET_THP_DISABLE:
-		if (arg3 || arg4 || arg5)
+		if (arg4 || arg5)
+			return -EINVAL;
+		if (arg3 && (arg3 & ~DISABLE_MTHP_ALL_MASK))
 			return -EINVAL;
 		if (mmap_write_lock_killable(me->mm))
 			return -EINTR;
-		if (arg2)
-			set_bit(MMF_DISABLE_THP, &me->mm->flags);
-		else
-			clear_bit(MMF_DISABLE_THP, &me->mm->flags);
+		if (arg2) {
+			if (!arg3)
+				set_bit(MMF_DISABLE_THP, &me->mm->flags);
+			if (arg3 & PR_DISABLE_ANON_MTHP)
+				set_bit(MMF_DISABLE_ANON_MTHP, &me->mm->flags);
+			if (arg3 & PR_DISABLE_SHMEM_MTHP)
+				set_bit(MMF_DISABLE_SHMEM_MTHP, &me->mm->flags);
+			if (arg3 & PR_DISABLE_FILE_MTHP)
+				set_bit(MMF_DISABLE_FILE_MTHP, &me->mm->flags);
+		} else {
+			if (!arg3)
+				clear_bit(MMF_DISABLE_THP, &me->mm->flags);
+			if (arg3 & PR_DISABLE_ANON_MTHP)
+				clear_bit(MMF_DISABLE_ANON_MTHP, &me->mm->flags);
+			if (arg3 & PR_DISABLE_SHMEM_MTHP)
+				clear_bit(MMF_DISABLE_SHMEM_MTHP, &me->mm->flags);
+			if (arg3 & PR_DISABLE_FILE_MTHP)
+				clear_bit(MMF_DISABLE_FILE_MTHP, &me->mm->flags);
+		}
 		mmap_write_unlock(me->mm);
 		break;
 	case PR_MPX_ENABLE_MANAGEMENT:
diff --git a/mm/shmem.c b/mm/shmem.c
index 5a77acf6ac6a..f4272883df77 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -556,7 +556,9 @@ static bool __shmem_is_huge(struct inode *inode, pgoff_t index,
 
 	if (!S_ISREG(inode->i_mode))
 		return false;
-	if (mm && ((vm_flags & VM_NOHUGEPAGE) || test_bit(MMF_DISABLE_THP, &mm->flags)))
+	if (mm && ((vm_flags & VM_NOHUGEPAGE) ||
+				test_bit(MMF_DISABLE_THP, &mm->flags) ||
+				test_bit(MMF_DISABLE_SHMEM_MTHP, &mm->flags)))
 		return false;
 	if (shmem_huge == SHMEM_HUGE_DENY)
 		return false;
@@ -1633,7 +1635,8 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
 	int order;
 
 	if ((vm_flags & VM_NOHUGEPAGE) ||
-	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags))
+	    test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags) ||
+	    test_bit(MMF_DISABLE_SHMEM_MTHP, &vma->vm_mm->flags))
 		return 0;
 
 	/* If the hardware/firmware marked hugepage support disabled. */
-- 
2.33.0


