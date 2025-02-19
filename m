Return-Path: <linux-kernel+bounces-521260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4F6A3BABF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 10:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E6A53BAB58
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 09:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4638E1B6CFA;
	Wed, 19 Feb 2025 09:38:42 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA03F1A315E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2025 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739957921; cv=none; b=u+RV7fJ3hUQcWo8kn6BuYrpwmqRCtdpJqMSFdTi6a9lrSjIceC8Gu2x0AknXjQ+HpgiSgdcAeo4f5/Wgmg08t/cg9Nyh/XOLCnlYIzWA2k8+gljclVzitncnnEsxPl2xBaPf/+iZc90NanRwCYmI9N1qcLguM7VnoNMqZicG1Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739957921; c=relaxed/simple;
	bh=pFcpTDqU0wCpY/TJ6FjQZyphAtOY5YxEvc5BhkEgNOo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jswFIhyOy5MjMfLxEgbdpsIuFJhk9ojBtg7HsCvFxcuiQh65nvXmsPSMEL3PlmREAn9MEJYlrAmHoyILyeVVdRV4ig+xQQBUf/qURolro+CL9tBb0OxsKiGVkh8GOjM0z17g4gR6MOcIUXaGRqAL+qmLNkq70JmI3iP7YPkuf8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 51J9cLiY054113;
	Wed, 19 Feb 2025 17:38:21 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4YyWRq2pWkz2SRfry;
	Wed, 19 Feb 2025 17:33:59 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 19 Feb 2025 17:38:18 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <vincent.guittot@linaro.org>, <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
        <mgorman@suse.de>, <vschneid@redhat.com>, <christian.loehle@arm.com>,
        <hongyan.xia2@arm.com>, <ke.wang@unisoc.com>, <di.shen@unisoc.com>,
        <xuewen.yan94@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] sched/uclamp: Add uclamp_is_used() check before enable it
Date: Wed, 19 Feb 2025 17:37:47 +0800
Message-ID: <20250219093747.2612-2-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250219093747.2612-1-xuewen.yan@unisoc.com>
References: <20250219093747.2612-1-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 51J9cLiY054113

Because the static_branch_enable() would get the cpus_read_lock(),
and sometimes users may frequently set the uclamp value of tasks,
and this operation would call the static_branch_enable()
frequently, so add the uclamp_is_used() check to prevent calling
the cpus_read_lock() frequently.
And to make the code more concise, add a helper function to encapsulate
this and use it everywhere we enable sched_uclamp_used.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
V2:
- change some commit message;
- Add a helper function and use it everywhere when enable uclamp (Vincent)
---
---
 kernel/sched/core.c     |  6 +++---
 kernel/sched/sched.h    | 14 ++++++++++++++
 kernel/sched/syscalls.c |  2 +-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 38a7192bfc19..0466a2f61b99 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1942,12 +1942,12 @@ static int sysctl_sched_uclamp_handler(const struct ctl_table *table, int write,
 	}
 
 	if (update_root_tg) {
-		static_branch_enable(&sched_uclamp_used);
+		sched_uclamp_enable();
 		uclamp_update_root_tg();
 	}
 
 	if (old_min_rt != sysctl_sched_uclamp_util_min_rt_default) {
-		static_branch_enable(&sched_uclamp_used);
+		sched_uclamp_enable();
 		uclamp_sync_util_min_rt_default();
 	}
 
@@ -9295,7 +9295,7 @@ static ssize_t cpu_uclamp_write(struct kernfs_open_file *of, char *buf,
 	if (req.ret)
 		return req.ret;
 
-	static_branch_enable(&sched_uclamp_used);
+	sched_uclamp_enable();
 
 	guard(mutex)(&uclamp_mutex);
 	guard(rcu)();
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3624fdce5536..bd22af347d0b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3407,6 +3407,18 @@ static inline bool uclamp_is_used(void)
 	return static_branch_likely(&sched_uclamp_used);
 }
 
+/*
+ * Enabling static branches would get the cpus_read_lock(),
+ * check whether uclamp_is_used before enable it to avoid always
+ * calling cpus_read_lock(). Because we never disable this
+ * static key once enable it.
+ */
+static inline void sched_uclamp_enable(void)
+{
+	if (!uclamp_is_used())
+		static_branch_enable(&sched_uclamp_used);
+}
+
 static inline unsigned long uclamp_rq_get(struct rq *rq,
 					  enum uclamp_id clamp_id)
 {
@@ -3486,6 +3498,8 @@ static inline bool uclamp_is_used(void)
 	return false;
 }
 
+static inline void sched_uclamp_enable(void) {}
+
 static inline unsigned long
 uclamp_rq_get(struct rq *rq, enum uclamp_id clamp_id)
 {
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 456d339be98f..9100a77e9d79 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -368,7 +368,7 @@ static int uclamp_validate(struct task_struct *p,
 	 * blocking operation which obviously cannot be done while holding
 	 * scheduler locks.
 	 */
-	static_branch_enable(&sched_uclamp_used);
+	sched_uclamp_enable();
 
 	return 0;
 }
-- 
2.25.1


