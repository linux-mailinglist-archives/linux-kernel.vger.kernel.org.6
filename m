Return-Path: <linux-kernel+bounces-523024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A87A3D112
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C78123BA6FF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 06:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918861C3306;
	Thu, 20 Feb 2025 06:00:36 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414B0286291
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 06:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740031236; cv=none; b=oc8M5CvL4lAg7zmuzo4RsHSxFLnI//WsBHUP5Z+ciZpPy/4zI5ak6xUeA48EUIqoRDrxtXUcSqUpt+0Z6oiTzoFjL4gIDRlsNrDXEobM+0PqyKF7gmUKpmyySVuOt9uzCYMxmfsLU0sS3c/Fhd+Jyit2MylNWsoeh8EZ8i0um/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740031236; c=relaxed/simple;
	bh=G/8eT3mxvv//DjpxGoAITapEuGZc6ECNvsIC2x4oLAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6Bu1wRm+OrnpUxZ2S6hHccm4jQb5FuB2Bz6CITyfmVULqSiKWFOI9WWfUNUE9xLdZYnAya132QN6kwIK6aAhmzPsQiBsytGz8AMgK12NyBaHP+gsP+J+nMtaNpdUflvYV9gZZ1xxw48OsYgW4abOcEDJJQHt6INs3vw87+9qeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 51K60BX1040474;
	Thu, 20 Feb 2025 14:00:11 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Yz2Yc0VqLz2PR6Lg;
	Thu, 20 Feb 2025 13:55:48 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Thu, 20 Feb 2025 14:00:08 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <vincent.guittot@linaro.org>, <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <christian.loehle@arm.com>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
        <mgorman@suse.de>, <vschneid@redhat.com>, <hongyan.xia2@arm.com>,
        <ke.wang@unisoc.com>, <di.shen@unisoc.com>, <xuewen.yan94@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] sched/uclamp: Add uclamp_is_used() check before enable it
Date: Thu, 20 Feb 2025 13:59:50 +0800
Message-ID: <20250220055950.4405-2-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250220055950.4405-1-xuewen.yan@unisoc.com>
References: <20250220055950.4405-1-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX01.spreadtrum.com (10.0.64.7)
X-MAIL:SHSQR01.spreadtrum.com 51K60BX1040474

Because the static_branch_enable() would get the cpus_read_lock(),
and sometimes users may frequently set the uclamp value of tasks,
and this operation would call the static_branch_enable()
frequently, so add the uclamp_is_used() check to prevent calling
the cpus_read_lock() frequently.
And to make the code more concise, add a helper function to encapsulate
this and use it everywhere we enable sched_uclamp_used.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Christian Loehle <christian.loehle@arm.com>
---
V3:
- update comment for helper function (Vincent)
- add Reviewed-by
---
V2:
- change some commit message;
- Add a helper function and use it everywhere when enable uclamp (Vincent)
---
---
 kernel/sched/core.c     |  6 +++---
 kernel/sched/sched.h    | 13 +++++++++++++
 kernel/sched/syscalls.c |  2 +-
 3 files changed, 17 insertions(+), 4 deletions(-)

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
index 3624fdce5536..98fe2c8f6961 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3407,6 +3407,17 @@ static inline bool uclamp_is_used(void)
 	return static_branch_likely(&sched_uclamp_used);
 }
 
+/*
+ * Enabling static branches would get the cpus_read_lock(),
+ * check uclamp_is_used before enabling it. There is no race
+ * issue because we never disable this static key once enabled.
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
@@ -3486,6 +3497,8 @@ static inline bool uclamp_is_used(void)
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


