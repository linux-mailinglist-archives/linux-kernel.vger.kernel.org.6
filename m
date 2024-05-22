Return-Path: <linux-kernel+bounces-185711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F928CB997
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 05:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1218F1F24547
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDC66F067;
	Wed, 22 May 2024 03:16:05 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04C933F9
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 03:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716347765; cv=none; b=R/HsRkL3ef4jpaLXIDOb0AMi3sJf5iYyAWrOxGTOVNg2nfB4Aikrgg64ZGNlIiuIl0VSx67h8T10qyysCcoFlwsgwpP9TeAd92r8G054IiFtL0MgzPpZF9FQy7M/HlloaAD9BlJTqEMkm706SmAFRpXzUymHH6gde/7p6kJlpB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716347765; c=relaxed/simple;
	bh=KJZO8vPd3/MO4hkZPoB6gZ6pM5tiQInRLsIuQX5Hvl0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WAYynHnM1qvwOU/imKX7lxDNkOFE/Z18FnqHnryyCSNAnylXpivA2/s42a1gMP9/o9upxGa09zYEZQGP0Mq92Kab4DIV4iYhqo6L9rW8halSkmboiUsstBBf0G5bg9DKJQg7Dmd0mQHx8NeJezlUlwodrfa5DwzBfM/NVUbfBQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VkbvL3RGGzxPMg;
	Wed, 22 May 2024 11:12:14 +0800 (CST)
Received: from kwepemf500005.china.huawei.com (unknown [7.202.181.243])
	by mail.maildlp.com (Postfix) with ESMTPS id 89DF61401E9;
	Wed, 22 May 2024 11:15:55 +0800 (CST)
Received: from huawei.com (10.67.174.161) by kwepemf500005.china.huawei.com
 (7.202.181.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 May
 2024 11:15:54 +0800
From: Cheng Yu <serein.chengyu@huawei.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>,
	<changhuaixin@linux.alibaba.com>, <shanpeic@linux.alibaba.com>,
	<dtcccc@linux.alibaba.com>, <tj@kernel.org>, <linux-kernel@vger.kernel.org>
CC: <zhangqiao22@huawei.com>, <judy.chenhui@huawei.com>,
	<yusongping@huawei.com>, <zhaowenhui8@huawei.com>, <liaoqixin@huawei.com>,
	<serein.chengyu@huawei.com>
Subject: [PATCH 1/2] sched/fair: limit burst to zero when cfs bandwidth is turned off
Date: Wed, 22 May 2024 11:10:06 +0800
Message-ID: <20240522031007.643498-2-serein.chengyu@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240522031007.643498-1-serein.chengyu@huawei.com>
References: <20240522031007.643498-1-serein.chengyu@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf500005.china.huawei.com (7.202.181.243)

From: Zhao Wenhui <zhaowenhui8@huawei.com>

When the quota value in CFS bandwidth is set to -1, that imples the
cfs bandwidth is turned off. So the burst feature is supposed to
be disable as well.

Currently, when quota is -1, burst will not be checked, so that it can be
set to any value. Examples:
        mkdir /sys/fs/cgroup/cpu/test
        echo -1 > /sys/fs/cgroup/cpu/test/cpu.cfs_quota_us
        echo 10000000000000000 > /sys/fs/cgroup/cpu/test/cpu.cfs_burst_us

Moreover, after the burst modified by this way, quota can't be set
to any value:
        echo 100000 > cpu.cfs_quota_us
        -bash: echo: write error: Invalid argument

This patch can ensure the burst value being zero and unchangeable,
when quota is set to -1.

Fixes: f4183717b370 ("sched/fair: Introduce the burstable CFS controller")
Reported-by: Zhao Gongyi <zhaogongyi@huawei.com>
Signed-off-by: Zhao Wenhui <zhaowenhui8@huawei.com>
Reviewed-by: Tianchen Ding <dtcccc@linux.alibaba.com>
Reviewed-by: Ben Segall <bsegall@google.com>
---
v1: https://lore.kernel.org/all/20220809120320.19496-1-zhaowenhui8@huawei.com/
---
 kernel/sched/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bcf2c4cc0522..e9198e30bb74 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10840,6 +10840,12 @@ static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
 				     burst + quota > max_cfs_runtime))
 		return -EINVAL;
 
+	/*
+	 * Ensure burst equals to zero when quota is -1.
+	 */
+	if (quota == RUNTIME_INF && burst)
+		return -EINVAL;
+
 	/*
 	 * Prevent race between setting of cfs_rq->runtime_enabled and
 	 * unthrottle_offline_cfs_rqs().
@@ -10899,8 +10905,10 @@ static int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
 
 	period = ktime_to_ns(tg->cfs_bandwidth.period);
 	burst = tg->cfs_bandwidth.burst;
-	if (cfs_quota_us < 0)
+	if (cfs_quota_us < 0) {
 		quota = RUNTIME_INF;
+		burst = 0;
+	}
 	else if ((u64)cfs_quota_us <= U64_MAX / NSEC_PER_USEC)
 		quota = (u64)cfs_quota_us * NSEC_PER_USEC;
 	else
-- 
2.25.1


