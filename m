Return-Path: <linux-kernel+bounces-380980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E869AF87C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 05:52:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DABF2829B2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 03:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C93C18BC27;
	Fri, 25 Oct 2024 03:51:56 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751D7433BE
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 03:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729828315; cv=none; b=R9qdNWY9JSBpy1La+qNzd+O5Vt6nOmLtVsoLEx/R2AeoCn/omWrIkJ3Ta58DyJNjSbgX51IxWUXllDEiizw6iqaWTfVslbtCWHMdPeBRXeh34pmTbjm8Dx0pR9lYerqo9nc6l726Zeh1ommUWdJ+ldeRllYXhOYBXoHbCiq5dAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729828315; c=relaxed/simple;
	bh=3mnhQWWdaiTkFNIziLadeypEUiMsicgx0vgIdeX2Pw0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FE4W9GueZo2u6ldY7rLWobag7NJCLT9YKbAhOmLJx9e7HpUlk1lWlhBnaIc1BlOInBMpuYIswfHylhoorEI4urQdTji79a/++4UxaxSQ9nVkFpEWd2aYebHhhfMDoOavC2PoXIG8iW/Q4MrQCPY8oAGakF+BBIegyRdk8SDcuKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XZTMD1nN4zyQQt;
	Fri, 25 Oct 2024 11:50:16 +0800 (CST)
Received: from kwepemm600002.china.huawei.com (unknown [7.193.23.29])
	by mail.maildlp.com (Postfix) with ESMTPS id 986EB14022E;
	Fri, 25 Oct 2024 11:51:49 +0800 (CST)
Received: from huawei.com (10.44.142.84) by kwepemm600002.china.huawei.com
 (7.193.23.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 25 Oct
 2024 11:51:48 +0800
From: Qi Xi <xiqi2@huawei.com>
To: <kernel@openeuler.org>, <bobo.shaobowang@huawei.com>, <xiqi2@huawei.com>,
	<mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<vschneid@redhat.com>, <patrick.bellasi@arm.com>, <mkoutny@suse.com>,
	<tj@kernel.org>
CC: <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched: Fix compile warning about variable 'uclamp_mutex'
Date: Fri, 25 Oct 2024 11:47:40 +0800
Message-ID: <20241025034740.546570-1-xiqi2@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600002.china.huawei.com (7.193.23.29)

When build with CONFIG_UCLAMP_TASK && !CONFIG_UCLAMP_TASK_GROUP,
the variable 'uclamp_mutex' is defined but not used:

kernel/sched/core.c:1361:21: warning: 'uclamp_mutex' defined but not used [-Wunused-variable]
    1361 | static DEFINE_MUTEX(uclamp_mutex);

Fix this by only defining the variable uclamp_mutex when the
CONFIG_UCLAMP_TASK_GROUP is enabled.

Fixes: 2480c093130f ("sched/uclamp: Extend CPU's cgroup controller")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/lkml/202410250459.EJe6PJI5-lkp@intel.com/
Signed-off-by: Qi Xi <xiqi2@huawei.com>
---
 kernel/sched/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f3951e4a55e5..9109fed6f022 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1348,6 +1348,7 @@ void set_load_weight(struct task_struct *p, bool update_load)
 }
 
 #ifdef CONFIG_UCLAMP_TASK
+#ifdef CONFIG_UCLAMP_TASK_GROUP
 /*
  * Serializes updates of utilization clamp values
  *
@@ -1359,6 +1360,7 @@ void set_load_weight(struct task_struct *p, bool update_load)
  * updates or API abuses.
  */
 static DEFINE_MUTEX(uclamp_mutex);
+#endif /* CONFIG_UCLAMP_TASK_GROUP */
 
 /* Max allowed minimum utilization */
 static unsigned int __maybe_unused sysctl_sched_uclamp_util_min = SCHED_CAPACITY_SCALE;
-- 
2.33.0


