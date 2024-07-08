Return-Path: <linux-kernel+bounces-244293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B204792A242
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 14:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B7311F22CA0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 12:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED38823A9;
	Mon,  8 Jul 2024 12:07:41 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811F380BEC
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 12:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440461; cv=none; b=CyVIdxZlznmyWsZPQtm4UMNANWMCiZJYKjqA96AlRSKVUdBT0wGra5OSsu7T1rw19E0MGY9xfO//N66RegsbBzREBHWaZP/Nl+WWBbQosBKrrQL+B9RE7YVQEbf7p//1NJjw9T5RHADLGbVVTa7nB7MajiuRxf1P0o30LO30IeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440461; c=relaxed/simple;
	bh=io01hl0mtesneL2LZ5G5Ith3zDY7NttBBQHX2oUhV+8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N/RpIZS6O22BOkgbWUqIseuBuf1xEw+LkfmyKs5srDlAMssLMKz+on9ORKlIykVkJ8QfFs6Lz4itl5ZTOxg1kIkdxsGCysxApVBD5fWGL9Io6K9kxABUtzAE3QJZPV5owdIev1mK5gje4LyPaE1Nd3/SE0rvue5JEEo3uPb03LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WHjXt4M1hznYfQ;
	Mon,  8 Jul 2024 20:07:10 +0800 (CST)
Received: from kwepemf500005.china.huawei.com (unknown [7.202.181.243])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B176180AA6;
	Mon,  8 Jul 2024 20:07:35 +0800 (CST)
Received: from huawei.com (10.67.174.161) by kwepemf500005.china.huawei.com
 (7.202.181.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 8 Jul
 2024 20:07:34 +0800
From: Cheng Yu <serein.chengyu@huawei.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>,
	<changhuaixin@linux.alibaba.com>, <shanpeic@linux.alibaba.com>,
	<dtcccc@linux.alibaba.com>, <vishalc@linux.ibm.com>, <tj@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <zhangqiao22@huawei.com>, <judy.chenhui@huawei.com>,
	<yusongping@huawei.com>, <zhaowenhui8@huawei.com>,
	<serein.chengyu@huawei.com>
Subject: [PATCH v2] sched/fair: set burst to 0 when remove the restriction on cfs bandwidth
Date: Mon, 8 Jul 2024 20:00:53 +0800
Message-ID: <20240708120053.861037-1-serein.chengyu@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf500005.china.huawei.com (7.202.181.243)

From: Zhao Wenhui <zhaowenhui8@huawei.com>

In the cpu subsystem of cgroup v1 and v2, we set the restriction on cfs
bandwidth by setting the quota and burst value. Later, when we remove
the restriction by setting the quota to the default value, the burst
value should also be forced to the its default value of zero.

In the cgroup v1 cpu subsystem, assuming we have a cgroup named 'test',
and we set cpu.cfs_quota_us and cpu.cfs_burst_us:
    # echo 100000 > cpu.cfs_quota_us
    # echo 100000 > cpu.cfs_burst_us

Next we remove the restriction on cfs bandwidth:
    # echo -1 > cpu.cfs_quota_us
    # cat cpu.cfs_quota_us
    -1
    # cat cpu.cfs_burst_us
    100000

Now we expect that the value of burst should be zero. When the burst is
zero, it means that the restriction on burst is removed.

The same situation exists for cgroup v2. The difference is that the
interface definition of the cpu subsystem and the default value of
quota. In v2, we remove the restriction on cfs bandwidth by setting max
to cpu.max.

Fixes: f4183717b370 ("sched/fair: Introduce the burstable CFS controller")
Reported-by: Zhao Gongyi <zhaogongyi@huawei.com>
Reported-by: Qixin Liao <liaoqixin@huawei.com>
Signed-off-by: Zhao Wenhui <zhaowenhui8@huawei.com>
Signed-off-by: Cheng Yu <serein.chengyu@huawei.com>
Tested-by: Vishal Chourasia <vishalc@linux.ibm.com>
Reviewed-by: Tianchen Ding <dtcccc@linux.alibaba.com>
Reviewed-by: Ben Segall <bsegall@google.com>
---
Change log:
----------
v2:
 - Put the modifications to cgroup v1 and v2 in one patch
v1:
 - patch for cgroup v1:
   https://lore.kernel.org/all/20220809120320.19496-1-zhaowenhui8@huawei.com/
 - patchset for cgroup v1 and v2:
   https://lore.kernel.org/all/20240522031007.643498-1-serein.chengyu@huawei.com/
---
 kernel/sched/core.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bcf2c4cc0522..982d357b3983 100644
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
@@ -11406,8 +11414,11 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
 	int ret;
 
 	ret = cpu_period_quota_parse(buf, &period, &quota);
-	if (!ret)
+	if (!ret) {
+		if (quota == RUNTIME_INF)
+			burst = 0;
 		ret = tg_set_cfs_bandwidth(tg, period, quota, burst);
+	}
 	return ret ?: nbytes;
 }
 #endif
-- 
2.25.1


