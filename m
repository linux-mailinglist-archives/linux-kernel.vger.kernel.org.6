Return-Path: <linux-kernel+bounces-335924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2719397EC9D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEB24282BC5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FC919CC1C;
	Mon, 23 Sep 2024 13:58:55 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5882A6BFC7
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727099935; cv=none; b=Grdh4/i7fIuyN8MP3KOzxFHRnRyBkvlS3T7KHJJebKhmT5Zxjp+4UrWHI3Mj0HsQuvWXndo8Y15kphrX3+L+UcXy6usvCK8MvmnBqL2yQL4ePRGqOZCpIqAGUxLow8rcfoJHmC0TyDMHF1SzS37j41DKQlQeHEFLL1tN1zvEy8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727099935; c=relaxed/simple;
	bh=UxcPhZ/sZJK4RpiHqBEgmsR27OL99HtSS6uQBOaa8q8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=glCwYzzAoMXly736KXZARwCI0irjHbIOkfTTYt12vGszBtdUcQV8AhG0WgxHEP1/efJ2w0uqOyCsr9QeId1+vuLlJBkybHGpE9diSogIa0Y0AVD0HCJHZGKkSj+O737rwVFg3T5p/xh/q8U5MDfBnt9i8HtbHeQQDaE3t6C+uBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XC4Kq4S89zpW04;
	Mon, 23 Sep 2024 21:56:47 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (unknown [7.185.36.200])
	by mail.maildlp.com (Postfix) with ESMTPS id 9EC71180113;
	Mon, 23 Sep 2024 21:58:50 +0800 (CST)
Received: from huawei.com (10.44.142.84) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 23 Sep
 2024 21:58:50 +0800
From: Yu Liao <liaoyu15@huawei.com>
To: <tj@kernel.org>
CC: <liaoyu15@huawei.com>, <xiexiuqi@huawei.com>, <peterz@infradead.org>,
	<mingo@redhat.com>, <linux-kernel@vger.kernel.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>
Subject: [RFC PATCH 1/2] sched: Add dummy version of sched_group_set_idle()
Date: Mon, 23 Sep 2024 21:54:30 +0800
Message-ID: <20240923135431.2440320-2-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240923135431.2440320-1-liaoyu15@huawei.com>
References: <20240923135431.2440320-1-liaoyu15@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500003.china.huawei.com (7.185.36.200)

Fix the following error when build with CONFIG_GROUP_SCHED_WEIGHT &&
!CONFIG_FAIR_GROUP_SCHED:

kernel/sched/core.c:9634:15: error: implicit declaration of function
'sched_group_set_idle'; did you mean 'scx_group_set_idle'? [-Wimplicit-function-declaration]
  9634 |         ret = sched_group_set_idle(css_tg(css), idle);
       |               ^~~~~~~~~~~~~~~~~~~~
       |               scx_group_set_idle

Fixes: e179e80c5d4f ("sched: Introduce CONFIG_GROUP_SCHED_WEIGHT")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409220859.UiCAoFOW-lkp@intel.com/
Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 kernel/sched/sched.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8063db62b027..91d14061fdca 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -582,6 +582,7 @@ static inline void set_task_rq_fair(struct sched_entity *se,
 #endif /* CONFIG_SMP */
 #else /* !CONFIG_FAIR_GROUP_SCHED */
 static inline int sched_group_set_shares(struct task_group *tg, unsigned long shares) { return 0; }
+static inline int sched_group_set_idle(struct task_group *tg, long idle) { return 0; }
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 
 #else /* CONFIG_CGROUP_SCHED */
-- 
2.33.0


