Return-Path: <linux-kernel+bounces-262788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ADF93CCC3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 04:34:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C570E281920
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 02:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA122032D;
	Fri, 26 Jul 2024 02:34:13 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA731E89A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 02:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721961252; cv=none; b=uRKJQuxMq9X/+gO7lMoPmqV87VkAMokBn+BcxK5PN8/l+FJpJzydqctWXTRyyo6OJYrSP4bOAnn06E/4h8xrOk7zmWe1yx4RG/wMcTWjjVI5Z3Zmxq8lUATlnqbAXhScOmyJ/d6A5BiNYZeUX/7UWpwk/JzRD1de70CF73tRy+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721961252; c=relaxed/simple;
	bh=fAzvoxsGLriR7T64A1MDkqFjYfgdfs00pNVgsSdTq6U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ipGUb5JiwdVi+nGhBvytREN9yKgJXhDvmZezSpMTCKHzyTQyCfAi3R6XJlRcgQzKQQs1mfalTyCo8TaH65iGBKAIlVo9HcfeI9vwl6TGq9lqHsIDg0dnTsXhhaFJwuC5wel0NYmKcL5cxq+wlyJZvQQ55JTtfM9dmTzX69xoofs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WVWzG03hGzxVKR;
	Fri, 26 Jul 2024 10:34:02 +0800 (CST)
Received: from kwepemd500019.china.huawei.com (unknown [7.221.188.86])
	by mail.maildlp.com (Postfix) with ESMTPS id 86BDE140FC1;
	Fri, 26 Jul 2024 10:34:06 +0800 (CST)
Received: from huawei.com (10.67.174.116) by kwepemd500019.china.huawei.com
 (7.221.188.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 26 Jul
 2024 10:34:05 +0800
From: Zheng Zucheng <zhengzucheng@huawei.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <oleg@redhat.com>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 -next] sched/cputime: Fix mul_u64_u64_div_u64() precision for cputime
Date: Fri, 26 Jul 2024 02:32:35 +0000
Message-ID: <20240726023235.217771-1-zhengzucheng@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240725120315.212428-1-zhengzucheng@huawei.com>
References: <20240725120315.212428-1-zhengzucheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

Trigger condition:
1). User task run in kernel mode most of time
2). ARM64 architecture
3). TICK_CPU_ACCOUNTING=y
    CONFIG_VIRT_CPU_ACCOUNTING_NATIVE is not set

Fix mul_u64_u64_div_u64() conversion precision by reset stime to rtime

v2:
 - Add comment
 - Update trigger condition

Fixes: 3dc167ba5729 ("sched/cputime: Improve cputime_adjust()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Zheng Zucheng <zhengzucheng@huawei.com>
---
 kernel/sched/cputime.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index aa48b2ec879d..4feef0d4e449 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -582,6 +582,12 @@ void cputime_adjust(struct task_cputime *curr, struct prev_cputime *prev,
 	}
 
 	stime = mul_u64_u64_div_u64(stime, rtime, stime + utime);
+	/*
+	 * Because mul_u64_u64_div_u64() can approximate on some
+	 * achitectures; enforce the constraint that: a*b/(b+c) <= a.
+	 */
+	if (unlikely(stime > rtime))
+		stime = rtime;
 
 update:
 	/*
-- 
2.34.1


