Return-Path: <linux-kernel+bounces-380892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6DE9AF759
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 04:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D621F22C0C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 02:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DCC1384B3;
	Fri, 25 Oct 2024 02:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="q8JpH4o1"
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26B27405A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 02:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729822935; cv=none; b=apO+bP60GwQtxtHCkTT7C3dDQ7m7g5pK78JX6xJWXFtH6QN4XVRCv+ZyHwbgonE/OxXRy/HPCGQUxwDBQpZT1pVe16YhhJEN+Ps00ZMtKXc20IyltlT3iVMqtFK9KhD3jASgk8dzTea04wuNW6fYzKr28ay3/aCbxkcGda3luDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729822935; c=relaxed/simple;
	bh=qi8ORvOGJVv0zbaDdW2+p9BJOsYoeQLDgnolrcfwsO4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V7xBgCN3CcmQRoUlIR3Yc6L8FFWaM/Z7gzf6lODoO3ZYh4bR8kG8jFsBFEurGsk7PG73VPE0yrCVCNb6v7aCs3umdmMs/3WYq2s/aZ0A+6+JsQ7rzdJfwlk9jNxOFVuZRbjvydurLonpB50qS1m27Y+VbfISTsmg7fiCfkRUBPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=q8JpH4o1; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729822930; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=dSXBh8mdvx30sYvTAOaMIw3eRXY+OORwBiJ21iouk/U=;
	b=q8JpH4o1V4WXLd19i7RJ+56evjv4sOnbemv+sC5QDjZi3PWjbfh1Y6msO2kZHiM1HufXaPXeDt1u+1PqwDcE3M3QlsBJWbsxYVOdt+isV6ROU/7U6nkK2DPZGxF6zpSFxwD0WKxl+YZdEL2ZRwI1h8yEonYT2LkDR2ubyzui/Vc=
Received: from localhost(mailfrom:shawnwang@linux.alibaba.com fp:SMTPD_---0WHqqNUL_1729822928 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 25 Oct 2024 10:22:08 +0800
From: Shawn Wang <shawnwang@linux.alibaba.com>
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Liam.Howlett@oracle.com
Cc: akpm@linux-foundation.org,
	baolin.wang@linux.alibaba.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	shawnwang@linux.alibaba.com
Subject: [PATCH] sched/numa: Fix the potential null pointer dereference in task_numa_work()
Date: Fri, 25 Oct 2024 10:22:08 +0800
Message-Id: <20241025022208.125527-1-shawnwang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When running stress-ng-vm-segv test, we found a null pointer dereference
error in task_numa_work(). Here is the backtrace:

  [323676.066985] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000020
  ......
  [323676.067108] CPU: 35 PID: 2694524 Comm: stress-ng-vm-se
  ......
  [323676.067113] pstate: 23401009 (nzCv daif +PAN -UAO +TCO +DIT +SSBS BTYPE=--)
  [323676.067115] pc : vma_migratable+0x1c/0xd0
  [323676.067122] lr : task_numa_work+0x1ec/0x4e0
  [323676.067127] sp : ffff8000ada73d20
  [323676.067128] x29: ffff8000ada73d20 x28: 0000000000000000 x27: 000000003e89f010
  [323676.067130] x26: 0000000000080000 x25: ffff800081b5c0d8 x24: ffff800081b27000
  [323676.067133] x23: 0000000000010000 x22: 0000000104d18cc0 x21: ffff0009f7158000
  [323676.067135] x20: 0000000000000000 x19: 0000000000000000 x18: ffff8000ada73db8
  [323676.067138] x17: 0001400000000000 x16: ffff800080df40b0 x15: 0000000000000035
  [323676.067140] x14: ffff8000ada73cc8 x13: 1fffe0017cc72001 x12: ffff8000ada73cc8
  [323676.067142] x11: ffff80008001160c x10: ffff000be639000c x9 : ffff8000800f4ba4
  [323676.067145] x8 : ffff000810375000 x7 : ffff8000ada73974 x6 : 0000000000000001
  [323676.067147] x5 : 0068000b33e26707 x4 : 0000000000000001 x3 : ffff0009f7158000
  [323676.067149] x2 : 0000000000000041 x1 : 0000000000004400 x0 : 0000000000000000
  [323676.067152] Call trace:
  [323676.067153]  vma_migratable+0x1c/0xd0
  [323676.067155]  task_numa_work+0x1ec/0x4e0
  [323676.067157]  task_work_run+0x78/0xd8
  [323676.067161]  do_notify_resume+0x1ec/0x290
  [323676.067163]  el0_svc+0x150/0x160
  [323676.067167]  el0t_64_sync_handler+0xf8/0x128
  [323676.067170]  el0t_64_sync+0x17c/0x180
  [323676.067173] Code: d2888001 910003fd f9000bf3 aa0003f3 (f9401000)
  [323676.067177] SMP: stopping secondary CPUs
  [323676.070184] Starting crashdump kernel...

stress-ng-vm-segv in stress-ng is used to stress test the SIGSEGV error
handling function of the system, which tries to cause a SIGSEGV error on
return from unmapping the whole address space of the child process.

Normally this program will not cause kernel crashes. But before the
munmap system call returns to user mode, a potential task_numa_work()
for numa balancing could be added and executed. In this scenario, since the
child process has no vma after munmap, the vma_next() in task_numa_work()
will return a null pointer even if the vma iterator restarts from 0.

Recheck the vma pointer before dereferencing it in task_numa_work().

Fixes: 214dbc428137 ("sched: convert to vma iterator")
Cc: stable@vger.kernel.org # v6.2+
Signed-off-by: Shawn Wang <shawnwang@linux.alibaba.com>
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c157d4860a3b..b4c3277cd563 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3369,7 +3369,7 @@ static void task_numa_work(struct callback_head *work)
 		vma = vma_next(&vmi);
 	}
 
-	do {
+	for (; vma; vma = vma_next(&vmi)) {
 		if (!vma_migratable(vma) || !vma_policy_mof(vma) ||
 			is_vm_hugetlb_page(vma) || (vma->vm_flags & VM_MIXEDMAP)) {
 			trace_sched_skip_vma_numa(mm, vma, NUMAB_SKIP_UNSUITABLE);
@@ -3491,7 +3491,7 @@ static void task_numa_work(struct callback_head *work)
 		 */
 		if (vma_pids_forced)
 			break;
-	} for_each_vma(vmi, vma);
+	}
 
 	/*
 	 * If no VMAs are remaining and VMAs were skipped due to the PID
-- 
2.43.5


