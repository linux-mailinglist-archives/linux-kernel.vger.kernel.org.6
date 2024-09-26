Return-Path: <linux-kernel+bounces-339813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1078B986AE3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 04:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BF1EB21297
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 02:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6619185B55;
	Thu, 26 Sep 2024 02:16:14 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDDE17C988
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 02:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727316974; cv=none; b=evQonKiG7Ut4oV7GQiCIho8FcX3xadrAM3gaCbHe+9644pOiF/amlAIALoukAV1bnFcY4ZH5xDdRdStCh5iYq3QnwjFj+SowEjT3gnq2THtZ53cK3lZRJX2tnfsZZw16dBtycLJc5JV+TNJcuGjqktBZ80u2fk3fr6FqhPpsFHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727316974; c=relaxed/simple;
	bh=Y4iSYXyazSQtKNPvXRtgCg8jOC+NlZvi40CfIg0ky2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGP/Q+pszYf6RLWJhvHYXO4osUYqJEVzwCTD1PI7FLcWe8vi3Hst2Pix84iJsi7aUr5Wxh4QBCVS1LZazstwSvilaDyf90DVK0Mwl6YfquUn2/ax9ljBnZHy1qmn+ZyB3oaBF48BcOQwalhqX8UluxkZ8fSapEp9c7QiFtTa1NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XDcf3166rz1ylxj;
	Thu, 26 Sep 2024 10:16:11 +0800 (CST)
Received: from kwepemg200007.china.huawei.com (unknown [7.202.181.34])
	by mail.maildlp.com (Postfix) with ESMTPS id 5C96F1400D5;
	Thu, 26 Sep 2024 10:16:09 +0800 (CST)
Received: from huawei.com (7.223.141.1) by kwepemg200007.china.huawei.com
 (7.202.181.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 26 Sep
 2024 10:16:08 +0800
From: Zhang Qiao <zhangqiao22@huawei.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel
 Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Tejun Heo
	<tj@kernel.org>, David Vernet <void@manifault.com>
CC: <linux-kernel@vger.kernel.org>, <zhangqiao22@huawei.com>
Subject: [PATCH 2/2] sched/ext: Use tg_cgroup() to elieminate duplicate code
Date: Thu, 26 Sep 2024 10:15:05 +0800
Message-ID: <20240926021506.340636-3-zhangqiao22@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240926021506.340636-1-zhangqiao22@huawei.com>
References: <20240926021506.340636-1-zhangqiao22@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemg200007.china.huawei.com (7.202.181.34)

Use tg_cgroup() to eliminate duplicate code patterns
in scx_bpf_task_cgroup().

Signed-off-by: Zhang Qiao <zhangqiao22@huawei.com>
---
 kernel/sched/ext.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 66aaca9efa0c..eabf8705e1e6 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -7054,15 +7054,8 @@ __bpf_kfunc struct cgroup *scx_bpf_task_cgroup(struct task_struct *p)
 	if (!scx_kf_allowed_on_arg_tasks(__SCX_KF_RQ_LOCKED, p))
 		goto out;
 
-	/*
-	 * A task_group may either be a cgroup or an autogroup. In the latter
-	 * case, @tg->css.cgroup is %NULL. A task_group can't become the other
-	 * kind once created.
-	 */
-	if (tg && tg->css.cgroup)
-		cgrp = tg->css.cgroup;
-	else
-		cgrp = &cgrp_dfl_root.cgrp;
+	cgrp = tg_cgrp(tg);
+
 out:
 	cgroup_get(cgrp);
 	return cgrp;
-- 
2.33.0


