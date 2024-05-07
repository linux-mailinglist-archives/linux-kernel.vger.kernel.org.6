Return-Path: <linux-kernel+bounces-170811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 573B58BDC5A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CCC21F22073
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 07:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0BEA13BAE9;
	Tue,  7 May 2024 07:23:30 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C94C3D0BD
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715066610; cv=none; b=DsBWifekNuhbrL80kxramdZ+5xG1pIpvL+o3lngFj6r3gARnUCRSuKdvRA6QacUrbUXmvHasfzw5x7FuJItuIJ2x0HXQWhyjAFutTnlOHVtTS08ou/dLELyYDKZEnE5x6t7mA67mY4VM/QeVTN29js6Vg3GUXQ4I6Gg6x3BMB+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715066610; c=relaxed/simple;
	bh=ar1FpdDgqeQQb1JwIhAccz/THq72DBOdMDqQLqZOQcY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E6qmqDGF2wTjYi2kPK7XQPL3tnGWz27OJDxMw4TugbMmaE8SdKYVTEz+Rp0pg/rWAiKsC0PsmZXsecL1157HW73xcYqVOxla3QLqTMzoqRfIWaaaanikITg3Ow69aOOf062BQkl83XchuS7jakSy0tiP2XXT68D0lTppUrqMFnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 4477N64F089743;
	Tue, 7 May 2024 15:23:06 +0800 (+08)
	(envelope-from Xuewen.Yan@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx01.spreadtrum.com [10.0.64.7])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4VYV6B6hwgz2K6x8R;
	Tue,  7 May 2024 15:20:02 +0800 (CST)
Received: from BJ10918NBW01.spreadtrum.com (10.0.73.73) by
 BJMBX01.spreadtrum.com (10.0.64.7) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 7 May 2024 15:23:03 +0800
From: Xuewen Yan <xuewen.yan@unisoc.com>
To: <mingo@redhat.com>, <peterz@infradead.org>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <longman@redhat.com>
CC: <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
        <mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
        <ke.wang@unisoc.com>, <xuewen.yan94@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] sched: Clear user_cpus_ptr only when no intersection with the new mask
Date: Tue, 7 May 2024 15:22:42 +0800
Message-ID: <20240507072242.585-1-xuewen.yan@unisoc.com>
X-Mailer: git-send-email 2.25.1
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
X-MAIL:SHSQR01.spreadtrum.com 4477N64F089743

The commit 851a723e45d1c("sched: Always clear user_cpus_ptr in do_set_cpus_allowed()")
would cause that online/offline cpu will produce different results
for the !top-cpuset task.
For example:

If the task was running, then offline task's cpus, would lead to clear
its user-mask.

unisoc:/ # while true; do sleep 600; done&
[1] 6786
unisoc:/ # echo 6786 > /dev/cpuset/top-app/tasks
unisoc:/ # cat /dev/cpuset/top-app/cpus
0-7
unisoc:/ # cat /proc/6786/status | grep Cpus
Cpus_allowed:   ff
Cpus_allowed_list:      0-7

unisoc:/ # taskset -p c0 6786
pid 6786's current affinity mask: ff
pid 6786's new affinity mask: c0
unisoc:/ # cat /proc/6786/status | grep Cpus
Cpus_allowed:   c0
Cpus_allowed_list:      6-7

After offline the cpu6 and cpu7, the user-mask would be cleared:

unisoc:/ # echo 0 > /sys/devices/system/cpu/cpu7/online
unisoc:/ # cat /proc/6786/status | grep Cpus
Cpus_allowed:   40
Cpus_allowed_list:      6
ums9621_1h10:/ # echo 0 > /sys/devices/system/cpu/cpu6/online
ums9621_1h10:/ # cat /proc/6786/status | grep Cpus
Cpus_allowed:   3f
Cpus_allowed_list:      0-5

When online the cpu6/7, the user-mask can not bring back:

unisoc:/ # echo 1 > /sys/devices/system/cpu/cpu6/online
unisoc:/ # echo 1 > /sys/devices/system/cpu/cpu7/online
unisoc:/ # cat /proc/6786/status | grep Cpus
Cpus_allowed:   ff
Cpus_allowed_list:      0-6

However, if we offline the cpu when the task is sleeping, at this
time, because would not call the fallback_cpu(), its user-mask will
not be cleared.

unisoc:/ # while true; do sleep 600; done&
[1] 5990
unisoc:/ # echo 5990 > /dev/cpuset/top-app/tasks
unisoc:/ # cat /proc/5990/status | grep Cpus
Cpus_allowed:   ff
Cpus_allowed_list:      0-7

unisoc:/ # taskset -p c0 5990
pid 5990's current affinity mask: ff
pid 5990's new affinity mask: c0
unisoc:/ # cat /proc/5990/status | grep Cpus
Cpus_allowed:   c0
Cpus_allowed_list:      6-7

unisoc:/ # echo 0 > /sys/devices/system/cpu/cpu6/online
unisoc:/ # cat /proc/5990/status | grep Cpus
Cpus_allowed:   80
Cpus_allowed_list:      7
unisoc:/ # echo 0 > /sys/devices/system/cpu/cpu7/online
unisoc:/ # cat /proc/5990/status | grep Cpus
Cpus_allowed:   3f
Cpus_allowed_list:      0-5

After 10 minutes, it was waked up, it can also keep its user-mask:
ums9621_1h10:/ # cat /proc/5990/status | grep Cpus
Cpus_allowed:   3f
Cpus_allowed_list:      0-5

And when online the cpu6/7,the user-mask could bring back.
unisoc:/ # echo 1 > /sys/devices/system/cpu/cpu6/online
unisoc:/ # echo 1 > /sys/devices/system/cpu/cpu7/online
unisoc:/ # cat /proc/6786/status | grep Cpus
Cpus_allowed:   c0
Cpus_allowed_list:      6-7

Indeed, there is no need to clear the user_cpus_ptr if there is an
intersection between user_cpus_ptr and new_mask.
So add the judgement of whether there is an intersection between them.
Clear user_cpus_ptr only when no intersection with the new mask.
In this way, the above problems can also be solved.

Suggested-by: Waiman Long <longman@redhat.com>
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
---
previous discussion:
 https://lore.kernel.org/all/e402d623-1875-47a2-9db3-8299a54502ef@redhat.com/
---
 kernel/sched/core.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7019a40457a6..bbb8e88949f4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2796,21 +2796,24 @@ __do_set_cpus_allowed(struct task_struct *p, struct affinity_context *ctx)
 }
 
 /*
- * Used for kthread_bind() and select_fallback_rq(), in both cases the user
- * affinity (if any) should be destroyed too.
+ * Used for kthread_bind() and select_fallback_rq().
+ * Destroy user affinity if no intersection with the new_mask.
  */
 void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 {
 	struct affinity_context ac = {
 		.new_mask  = new_mask,
 		.user_mask = NULL,
-		.flags     = SCA_USER,	/* clear the user requested mask */
+		.flags     = 0,
 	};
 	union cpumask_rcuhead {
 		cpumask_t cpumask;
 		struct rcu_head rcu;
 	};
 
+	if (p->user_cpus_ptr && !cpumask_intersects(p->user_cpus_ptr, new_mask))
+		ac.flags = SCA_USER;	/* clear the user requested mask */
+
 	__do_set_cpus_allowed(p, &ac);
 
 	/*
-- 
2.25.1


