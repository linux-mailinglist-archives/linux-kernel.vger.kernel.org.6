Return-Path: <linux-kernel+bounces-283058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D766794EC69
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 949CD282380
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB52178390;
	Mon, 12 Aug 2024 12:09:52 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E79175D3E
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464591; cv=none; b=RrHmJQB3bS5BwsswSB1DFjw97n6Nuxbx/jYfi+7kUPwe7w3B4/djoTEZCRTkap3+K6IYrfXnHmRY2sQ95kJSFoTWXN8GVAttvxtNJ78/kp30yW9gzIL2jzABnHcheHqFWIIN4/wOoN2Ot3EwueAC9u/LLfrg4BwPMD4TgwXoFe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464591; c=relaxed/simple;
	bh=XlIu32Z9RpRk59EBTuaKIUlp3COR3AUvKks1HUYv2oo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mGLrNWa7VxC5aDBuZlPdVM05iLpAoOEpyqtgJSqkmA/oQ2cNLo4gXi9PSD8Hx/zCWyFm045UM2M5qUaaqYLNNbUyIFraepZHQ+mVYWiRK42SEeDlQlTLmQ3B2Mi7Cz8L+5qg6rfudgTG/9myAW6EBKWMdW+uhUSIzHCExJuiUcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4WjCr855F0z1S7fK;
	Mon, 12 Aug 2024 20:04:56 +0800 (CST)
Received: from kwepemd500019.china.huawei.com (unknown [7.221.188.86])
	by mail.maildlp.com (Postfix) with ESMTPS id 875AA1A0188;
	Mon, 12 Aug 2024 20:09:46 +0800 (CST)
Received: from huawei.com (10.67.174.116) by kwepemd500019.china.huawei.com
 (7.221.188.86) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 12 Aug
 2024 20:09:45 +0800
From: Zheng Zucheng <zhengzucheng@huawei.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <gregkh@linuxfoundation.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] sched: Remove the check on the return value of sched_update_scaling()
Date: Mon, 12 Aug 2024 12:08:19 +0000
Message-ID: <20240812120819.1083687-1-zhengzucheng@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd500019.china.huawei.com (7.221.188.86)

sched_update_scaling() always returns 0, so there's no need to check if
sched_update_scaling() was successful.

Fixes: 8a99b6833c88 ("sched: Move SCHED_DEBUG sysctl to debugfs")
Signed-off-by: Zheng Zucheng <zhengzucheng@huawei.com>
---
 kernel/sched/debug.c | 3 +--
 kernel/sched/fair.c  | 4 +---
 kernel/sched/sched.h | 2 +-
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 845b79238398..87c683c8635f 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -188,8 +188,7 @@ static ssize_t sched_scaling_write(struct file *filp, const char __user *ubuf,
 		return -EINVAL;
 
 	sysctl_sched_tunable_scaling = scaling;
-	if (sched_update_scaling())
-		return -EINVAL;
+	sched_update_scaling();
 
 	*ppos += cnt;
 	return cnt;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index efb2b3062179..b3d79b693021 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -954,7 +954,7 @@ struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
  * Scheduling class statistics methods:
  */
 #ifdef CONFIG_SMP
-int sched_update_scaling(void)
+void sched_update_scaling(void)
 {
 	unsigned int factor = get_update_sysctl_factor();
 
@@ -962,8 +962,6 @@ int sched_update_scaling(void)
 	(normalized_sysctl_##name = sysctl_##name / (factor))
 	WRT_SYSCTL(sched_base_slice);
 #undef WRT_SYSCTL
-
-	return 0;
 }
 #endif
 #endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 9373426d5aae..d8319e58a0c6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2054,7 +2054,7 @@ static inline void update_sched_domain_debugfs(void) { }
 static inline void dirty_sched_domain_sysctl(int cpu) { }
 #endif
 
-extern int sched_update_scaling(void);
+extern void sched_update_scaling(void);
 
 static inline const struct cpumask *task_user_cpus(struct task_struct *p)
 {
-- 
2.34.1


