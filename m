Return-Path: <linux-kernel+bounces-268851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18684942A37
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 11:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E126B22DF5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 09:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF061AC441;
	Wed, 31 Jul 2024 09:18:22 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A151AB51F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417502; cv=none; b=VCRiQsH9QqGzzC9b8TZ2EAcvV9HHjA08ivhv8n/CawPY6RIbaxszcq2dcSz/9LBxODbSxb8qjyBoMtyp1exmJr/3+AhgYhvNreNL7eFfBbhvCKbCy/wbzDhPxgnuraBm230VlIQtEse2cKlQywBhPMPD0O63FS+uebRbkCZPdLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417502; c=relaxed/simple;
	bh=MJOGH6mPPaYQoGPxLPqid+q05kL/PekU0ZeJhOCgquQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BZUy/VhrVBEPegtE4YSJiUWXMCzLGdkcM3Ve2NrB73Bwge8y39nl+sjS/MNaCghjYvjxcZSFMHYByWlhltrCKPrhgpwvJ8JVJECgnnXUQz3mKr057CPE1u0RL7LnXPBartpD/kaL+gZq+3l/srcwQW0Gh7WlekooZYHjKIJLc5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WYmgG1WVsz17MyT;
	Wed, 31 Jul 2024 17:16:26 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 52681180042;
	Wed, 31 Jul 2024 17:18:11 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Wed, 31 Jul
 2024 17:18:10 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>
CC: <lizetao1@huawei.com>, <zhangqiao22@huawei.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next v2] sched/fair: inline cpu_util_without and cpu_util to improve performance
Date: Wed, 31 Jul 2024 17:24:00 +0800
Message-ID: <20240731092400.675459-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd500012.china.huawei.com (7.221.188.25)

The commit 3eb6d6ececca ("sched/fair: Refactor CPU utilization functions")
refactored cpu_util_without and cpu_util functions. Since the size of
cpu_util function has increased, the inline cpu_util is dropped. This had
a negative impact on performance, in the scenario of updating
sched_group's statistics, cpu_util_without and cpu_util functions are on
the hotspot path.

Inlining cpu_util_without and cpu_util functions have been shown to
significantly improve performance in lmbench as follow:

  Machine: Intel(R) Xeon(R) Gold 6248 CPU @ 2.50GHz
                     before          after          diff
  fork+exit          317.0625        303.6667       -4.22%
  fork+execve        1482.5000       1407.0000      -5.09%
  fork+/bin/sh       2096.0000       2020.3333      -3.61%

This patch introduces inlining to cpu_util_without and cpu_util functions.
While this increases the size of kernel/sched/fair.o, the performance
gains in critical workloads make this an acceptable trade-off.

Size comparison before and after patch:
     text	   data	    bss	    dec	    hex	filename
   0x1264a	 0x1506	   0xb0	  80896	  13c00	kernel/sched/fair.o.before
   0x12672	 0x14fe	   0xb0	  80928	  13c20	kernel/sched/fair.o.after

Co-developed-by: Zhang Qiao <zhangqiao22@huawei.com>
Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
v1 -> v2: Fix incorrect SoB chain
v1: https://lore.kernel.org/all/20240723073607.568819-1-lizetao1@huawei.com/

 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5904405ffc59..677b78fa65b6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7706,7 +7706,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
  *
  * Return: (Boosted) (estimated) utilization for the specified CPU.
  */
-static unsigned long
+static __always_inline unsigned long
 cpu_util(int cpu, struct task_struct *p, int dst_cpu, int boost)
 {
 	struct cfs_rq *cfs_rq = &cpu_rq(cpu)->cfs;
@@ -7794,7 +7794,7 @@ unsigned long cpu_util_cfs_boost(int cpu)
  * utilization of the specified task, whenever the task is currently
  * contributing to the CPU utilization.
  */
-static unsigned long cpu_util_without(int cpu, struct task_struct *p)
+static __always_inline unsigned long cpu_util_without(int cpu, struct task_struct *p)
 {
 	/* Task has no contribution or is new */
 	if (cpu != task_cpu(p) || !READ_ONCE(p->se.avg.last_update_time))
-- 
2.34.1


