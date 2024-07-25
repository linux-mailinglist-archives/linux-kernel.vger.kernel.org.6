Return-Path: <linux-kernel+bounces-262135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 463EB93C16A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 14:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765211C219FF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 12:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9280519922A;
	Thu, 25 Jul 2024 12:04:53 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A8822089
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 12:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909093; cv=none; b=UjGzuxff7uXF4lrjFqSIapGfu0UE16W+3AziXXpZKySwWyVpJhwFITMIJdfX6+4JemCM42dTYvVD0EK2pXU6kTNK0RCulvScqODiCTHQLwE8cnlkgrSpCSfOasD+XemxGuZTq+QvjLYluOAQXrAJ0ppFS4xy9wl6UOhR3boSKyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909093; c=relaxed/simple;
	bh=YxUCC3ezvRUxsTuLC6GTvmBIm636kyw0z/gY6kCtJWM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d57J90JsnjX2enp7WlELCNZtXXtVOBfJWttF0Ra4nFld7HhR2/+Yu6W2InWOKMLu4fXQcNhXyi/Bt7Pp1YheSYjwbN2hbJdWFiLFkwuTs/SE66XPKiCXQCwS8lQRmBCLhBkbGT1LlBtkHzFQlJiQY/FpE3jvCIgJ1e+kacyx+dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WV8Zf6RR6zyNRg;
	Thu, 25 Jul 2024 19:59:54 +0800 (CST)
Received: from kwepemd500019.china.huawei.com (unknown [7.221.188.86])
	by mail.maildlp.com (Postfix) with ESMTPS id 9D907180101;
	Thu, 25 Jul 2024 20:04:46 +0800 (CST)
Received: from huawei.com (10.67.174.116) by kwepemd500019.china.huawei.com
 (7.221.188.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 25 Jul
 2024 20:04:45 +0800
From: Zheng Zucheng <zhengzucheng@huawei.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <oleg@redhat.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] sched/cputime: Fix mul_u64_u64_div_u64() precision for cputime
Date: Thu, 25 Jul 2024 12:03:15 +0000
Message-ID: <20240725120315.212428-1-zhengzucheng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd500019.china.huawei.com (7.221.188.86)

In extreme test scenarios:
the 14th field utime in /proc/xx/stat is greater than sum_exec_runtime,
utime = 18446744073709518790 ns, rtime = 135989749728000 ns

In cputime_adjust() process, stime is greater than rtime due to
mul_u64_u64_div_u64() precision problem.
before call mul_u64_u64_div_u64(),
stime = 175136586720000, rtime = 135989749728000, utime = 1416780000.
after call mul_u64_u64_div_u64(),
stime = 135989949653530

unsigned reversion occurs because rtime is less than stime.
utime = rtime - stime = 135989749728000 - 135989949653530
		      = -199925530
		      = (u64)18446744073709518790

Trigger scenario:
1. User task run in kernel mode most of time.
2. The ARM64 architecture && CONFIG_VIRT_CPU_ACCOUNTING_NATIVE=y &&
   TICK_CPU_ACCOUNTING=y

Fix mul_u64_u64_div_u64() conversion precision by reset stime to rtime

Fixes: 3dc167ba5729 ("sched/cputime: Improve cputime_adjust()")
Signed-off-by: Zheng Zucheng <zhengzucheng@huawei.com>
---
 kernel/sched/cputime.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index aa48b2ec879d..365c74e95537 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -582,6 +582,8 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
 	}
 
 	stime = mul_u64_u64_div_u64(stime, rtime, stime + utime);
+	if (unlikely(stime > rtime))
+		stime = rtime;
 
 update:
 	/*
-- 
2.34.1


