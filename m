Return-Path: <linux-kernel+bounces-185712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A52A8CB998
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 05:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B4991F2502B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 03:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602D974C14;
	Wed, 22 May 2024 03:16:06 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06A214295
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 03:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716347766; cv=none; b=dfqLdXoCTDXjR9hKOoO168mmkE2JRB37MRilUhryU1qsA2dYCNb5YqWvH/lQI6GTxwXedu7BAZmrIjEqmFeHA31d/Vi3RUPURx69UebPLiPpiSKlNk+rTw5ZxpuqAu1hwCHsoqj+JTJp6COXI1ew65UO1ERvpmvrXWwE3sJVnv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716347766; c=relaxed/simple;
	bh=nXZtuUsWNOhDKw25i9SHciZzMx/bGrHST16YDSwVn5w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YtnLTl04ZffMtbkvqvoEyWmrnYpyCmmyqJrnG9JZko7sYwgrTRH8Z4ciYfsCVqBMO8MWhASpKZRTMLHGXsEsAVrhQigbuqh2lap3l2CZpVENUZOVOXsASF/6jNNEGUHc4CnonRzMvsJal6RceicqlSgZ4KZw0+9LIY2u1AYTw8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Vkbtm57JmzXnpl;
	Wed, 22 May 2024 11:11:44 +0800 (CST)
Received: from kwepemf500005.china.huawei.com (unknown [7.202.181.243])
	by mail.maildlp.com (Postfix) with ESMTPS id 34F741401E9;
	Wed, 22 May 2024 11:15:56 +0800 (CST)
Received: from huawei.com (10.67.174.161) by kwepemf500005.china.huawei.com
 (7.202.181.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 22 May
 2024 11:15:55 +0800
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
Subject: [PATCH 2/2] sched/fair: set burst to zero when set max to cpu.max
Date: Wed, 22 May 2024 11:10:07 +0800
Message-ID: <20240522031007.643498-3-serein.chengyu@huawei.com>
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

In the cgroup v2 cpu subsystem, assuming we have a cgroup named 'test',
and we set cpu.max and cpu.max.burst:
    # echo 1000000 > /sys/fs/cgroup/test/cpu.max
    # echo 1000000 > /sys/fs/cgroup/test/cpu.max.burst

Next we remove the restriction on cfs bandwidth:
    # echo max > /sys/fs/cgroup/test/cpu.max
    # cat /sys/fs/cgroup/test/cpu.max
    max 100000
    # cat /sys/fs/cgroup/test/cpu.max.burst
    1000000

Now we expect that the value of burst should be 0. When the burst is 0,
it means that the restriction on burst is cancelled.

Fixes: f4183717b370 ("sched/fair: Introduce the burstable CFS controller")
Reported-by: Qixin Liao <liaoqixin@huawei.com>
Signed-off-by: Cheng Yu <serein.chengyu@huawei.com>
---
 kernel/sched/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e9198e30bb74..982d357b3983 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -11414,8 +11414,11 @@ static ssize_t cpu_max_write(struct kernfs_open_file *of,
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


