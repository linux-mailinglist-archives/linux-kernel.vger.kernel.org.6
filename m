Return-Path: <linux-kernel+bounces-335926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9539797EC9F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:59:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C61461C214B3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC19419CC2A;
	Mon, 23 Sep 2024 13:58:55 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621B919CC0D
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 13:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727099935; cv=none; b=ncEZxCg9KmCNq+NnrPKEdovaGKmf+Ui1zcq0yQcOHtUGwgFnrUCP6HBdfABonbnRyD7k3+8jcS8d6mJxNj2f2PseaDTR/4o6HEocJ/QvpIqF6GxXKVgwOUjS+Lde21HCVZ/N0E4OA29angh+yj0oVeOvhMfL31vDsJuaSkdK2NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727099935; c=relaxed/simple;
	bh=VVagp1WX76fAq+9V5Vo7EJKS+OM20nfVvs0nUzAZmDw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fmi6hmrnavk5pES+DslSHQ5a8XLFyhwPS1xbMiMLD9+KA0dXE/j0sVsw5xvXFIg1hq8t0+QQIkXUbRqzW1x2cvk3lUjPsRCNZ1xWST4emK0VoSqMOLe7Nx4mOTbzfKm2VlUSrbD4wTpDe5gFhtq2QBgxwllV8nPxbP0NO4GvQKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XC4Hp2P0Jz1HK3S;
	Mon, 23 Sep 2024 21:55:02 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (unknown [7.185.36.200])
	by mail.maildlp.com (Postfix) with ESMTPS id C2C8E180041;
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
Subject: [RFC PATCH 2/2] sched: Put task_group::idle under CONFIG_GROUP_SCHED_WEIGHT
Date: Mon, 23 Sep 2024 21:54:31 +0800
Message-ID: <20240923135431.2440320-3-liaoyu15@huawei.com>
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

When build with CONFIG_GROUP_SCHED_WEIGHT && !CONFIG_FAIR_GROUP_SCHED,
the idle member is not defined:

kernel/sched/ext.c:3701:16: error: 'struct task_group' has no member named 'idle'
  3701 |         if (!tg->idle)
       |                ^~

Fix this by putting 'idle' under new CONFIG_GROUP_SCHED_WEIGHT, this
doesn't modify the layout of struct task_group.

Fixes: e179e80c5d4f ("sched: Introduce CONFIG_GROUP_SCHED_WEIGHT")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202409220859.UiCAoFOW-lkp@intel.com/
Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 kernel/sched/sched.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 91d14061fdca..fb871677ba22 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -438,11 +438,14 @@ struct task_group {
 	/* runqueue "owned" by this group on each CPU */
 	struct cfs_rq		**cfs_rq;
 	unsigned long		shares;
+#endif
 
+#ifdef CONFIG_GROUP_SCHED_WEIGHT
 	/* A positive value indicates that this is a SCHED_IDLE group. */
 	int			idle;
+#endif
 
-#ifdef	CONFIG_SMP
+#if defined(CONFIG_FAIR_GROUP_SCHED) && defined(CONFIG_SMP)
 	/*
 	 * load_avg can be heavily contended at clock tick time, so put
 	 * it in its own cache-line separated from the fields above which
@@ -450,7 +453,6 @@ struct task_group {
 	 */
 	atomic_long_t		load_avg ____cacheline_aligned;
 #endif
-#endif
 
 #ifdef CONFIG_RT_GROUP_SCHED
 	struct sched_rt_entity	**rt_se;
-- 
2.33.0


