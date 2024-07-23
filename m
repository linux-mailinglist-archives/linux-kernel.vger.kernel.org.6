Return-Path: <linux-kernel+bounces-259703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6A2939BC2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 09:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B943E1F227A6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 07:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0751E14B08A;
	Tue, 23 Jul 2024 07:31:07 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D8914B089
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 07:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721719866; cv=none; b=SrX/XALU9uxQHNi7RIQ8odLaLn/B+teWteG3bmWCtdvdiQ/GS02s3bjdJCzZ80NBzbx+B8fmXbW3M8f8ZGNtu4rC9IGpzD164UzOYBuU4F54lVj3UUyV2jEstISg1EFQ3kYvjIzxb46BvStcXCjNfWZS1nmPaJAUW/DiYWYJp/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721719866; c=relaxed/simple;
	bh=zN3VWt5S4d5w25Cf1F///qtIGHWBxrmzrql5/QOxfKc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AvH+bU2j4ex892hIQt07+LlgbC0yiJGBBRgNi8LTALN1+7Muz4sxilNqeox4dq2E6Y6BvSuwajYoCoaWZVkYLBdChuWlLGUFeP9gkthUxWhRfN/H766KUxdDIwbxH9F4IGbF5ZuDJw1QRZlK8x0Y46BwPxMlIGlsgNB9AIyZTMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WSpf708r6z1HFSX;
	Tue, 23 Jul 2024 15:28:15 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id E855B18001B;
	Tue, 23 Jul 2024 15:30:54 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Tue, 23 Jul
 2024 15:30:54 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>
CC: <lizetao1@huawei.com>, <zhangqiao22@huawei.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH -next] sched/fair: inline cpu_util_without and cpu_util to improve performance
Date: Tue, 23 Jul 2024 15:36:07 +0800
Message-ID: <20240723073607.568819-1-lizetao1@huawei.com>
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

Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
Signed-off-by: Li Zetao <lizetao1@huawei.com>
---
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


