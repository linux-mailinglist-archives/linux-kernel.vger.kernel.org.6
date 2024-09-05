Return-Path: <linux-kernel+bounces-317447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6FEB96DE6B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96A59288B6D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357B21990DB;
	Thu,  5 Sep 2024 15:32:36 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEE4D529
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 15:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725550355; cv=none; b=Yyr8bmM4sDDt/Cb+GZaYzlTLpvMA2fvzcxZmndj3lqHOultk4rYLm1ieFGIyd8zdLUj3rgyMvZFhsjGFKv8HbjKqyiaIjneb1ElphHHGBX+qT8NNyt+nnGLSCzaqwSv1gtiAb7UzTZRSIKjfMNZo6RI2qsI32g0SPP11W3wyLz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725550355; c=relaxed/simple;
	bh=femPHuMRkwJ+p1eFTxatR71zsKFG/1fKE9Blx/FBemE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lMl9FRxRWaT+lJGIY10uN9c3LU79MzCCK0cQoCn17WxI+plGdQN5HF283Ue+r4xe5zCY6BStZKma4rf32Qw2zyiDqbgrJbUi/UTJTfbtb6MoNBudcrTftUD1tqeciAv2vGC0NxLgw6W/JIhU6b4xwJMB0oiZeM6nrxFIi1zyBGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X03Bq4Pcpz20nWD;
	Thu,  5 Sep 2024 23:27:31 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (unknown [7.193.23.202])
	by mail.maildlp.com (Postfix) with ESMTPS id 00BAC1400FD;
	Thu,  5 Sep 2024 23:32:30 +0800 (CST)
Received: from huawei.com (10.175.124.71) by kwepemm600003.china.huawei.com
 (7.193.23.202) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 5 Sep
 2024 23:32:29 +0800
From: Nanyong Sun <sunnanyong@huawei.com>
To: <akpm@linux-foundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: [PATCH] mm: migrate: simplify find_mm_struct()
Date: Thu, 5 Sep 2024 23:31:18 +0800
Message-ID: <20240905153118.1205173-1-sunnanyong@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600003.china.huawei.com (7.193.23.202)

Use find_get_task_by_vpid() to replace the task_struct find logic in
find_mm_struct(), note that this patch move the ptrace_may_access()
call out from rcu_read_lock() scope, this is ok because it actually
does not need it, find_get_task_by_vpid() already get the pid and task
safely, ptrace_may_access() can use the task safely, like what
sched_core_share_pid() similarly do.

Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
---
 mm/migrate.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 923ea80ba744..e9477c64c267 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -2432,25 +2432,19 @@ static struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
 		return current->mm;
 	}
 
-	/* Find the mm_struct */
-	rcu_read_lock();
-	task = find_task_by_vpid(pid);
+	task = find_get_task_by_vpid(pid);
 	if (!task) {
-		rcu_read_unlock();
 		return ERR_PTR(-ESRCH);
 	}
-	get_task_struct(task);
 
 	/*
 	 * Check if this process has the right to modify the specified
 	 * process. Use the regular "ptrace_may_access()" checks.
 	 */
 	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
-		rcu_read_unlock();
 		mm = ERR_PTR(-EPERM);
 		goto out;
 	}
-	rcu_read_unlock();
 
 	mm = ERR_PTR(security_task_movememory(task));
 	if (IS_ERR(mm))
-- 
2.33.0


