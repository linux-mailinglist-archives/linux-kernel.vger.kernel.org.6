Return-Path: <linux-kernel+bounces-269018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FAD942C58
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:48:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E1151F25846
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 10:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43511AC434;
	Wed, 31 Jul 2024 10:48:31 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7B6190473
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2024 10:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422911; cv=none; b=ZGZ1V5mV7Zgj9/r+P7rOq4YeS8E0uqeyq6Esqdjnm71uoCQ+Gd9lVMqEKTat7t7vCJP/miM6Y3EEieUgu4CkW0EquE/KWZTHAu/mfdsRq+BUVXwB4/+U+K7CtohOIPOqYlRzYOc2jCS0bzI0g3k7iwgl8SWy21EvaGgrpNNK+0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422911; c=relaxed/simple;
	bh=VXhHatSeGioHS9fS387ak0H1IJW0tjK8WdII5K/5cwU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eVTIq+ISy9akfMiMVWk47wN4pM40vIpR2cdPEX8CWeYoHu8B4PgNZnLETcOPuA3y2SnteFYqmlns+XXqLS8m9tmWeYhNwxFS8FNJhyZdjViwFgA+YEHA1yCYPKgw96VsvHCJZa+JVwkUflbe7qIW7j7J9BxsGwGLd8J3WONZUpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WYpjB3QqKz1L9Fh;
	Wed, 31 Jul 2024 18:48:14 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id C5D3C1400DD;
	Wed, 31 Jul 2024 18:48:25 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 31 Jul
 2024 18:48:25 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <juri.lelli@redhat.com>,
	<dhaval.giani@gmail.com>
CC: <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH v2 -next] sched: Remove unused extern declarations
Date: Wed, 31 Jul 2024 18:46:29 +0800
Message-ID: <20240731104629.2303096-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf500002.china.huawei.com (7.185.36.57)

From: YueHaibing <yuehaibing@huawei.com>

commit f64f61145a38 ("sched: remove sched_exit()") removed sched_exit(), then
commit ad46c2c4ebce ("sched: clean up fastcall uses of sched_fork()/sched_exit()")
mistakenly change sched_exit() to sched_dead() extern declarations.

And since commit 7c9414385ebf ("sched: Remove USER_SCHED")
uids_sysfs_init() is not used anymore.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: fix commit log typo
---
 include/linux/sched/task.h | 1 -
 include/linux/sched/user.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 4df2f9055587..de8a7454d479 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -66,7 +66,6 @@ extern int sched_fork(unsigned long clone_flags, struct task_struct *p);
 extern int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs);
 extern void sched_cancel_fork(struct task_struct *p);
 extern void sched_post_fork(struct task_struct *p);
-extern void sched_dead(struct task_struct *p);
 
 void __noreturn do_task_dead(void);
 void __noreturn make_task_dead(int signr);
diff --git a/include/linux/sched/user.h b/include/linux/sched/user.h
index 4cc52698e214..ffa639dd3821 100644
--- a/include/linux/sched/user.h
+++ b/include/linux/sched/user.h
@@ -36,8 +36,6 @@ struct user_struct {
 	struct ratelimit_state ratelimit;
 };
 
-extern int uids_sysfs_init(void);
-
 extern struct user_struct *find_user(kuid_t);
 
 extern struct user_struct root_user;
-- 
2.34.1


