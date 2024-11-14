Return-Path: <linux-kernel+bounces-409949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE4F9C93E1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 22:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B68287366
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 21:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0721F1AF0BE;
	Thu, 14 Nov 2024 21:14:57 +0000 (UTC)
Received: from zulu.geekplace.eu (zulu.geekplace.eu [5.45.100.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1316218A6C5
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.45.100.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731618896; cv=none; b=k0sggCaXzOILp1JyhzqPK8e3Y+cikKQ+QIE249nN4H1eArcoheUudc0MwFfU5q2zoJrBbBJs9yrD7+gVPe9UDOv25nH48RslmHz0aRZ/kR3TN507u/eXm55elVngtzVw0ODWGA5+hTE9sQae03YWfhjZ1fk4ZAI10xb7UAa4yO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731618896; c=relaxed/simple;
	bh=gbgAuwsznoi2Ocb2QQFB0XRAAb8REgfIyFsAfc3Isl4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L10o18GRB6GAowVnO/pbCwI93R3iZtxFKwqSPB91mGa26m+OaVe8S9ls5+RjSu4AJ1/FBmUu7GKz7oXrGr6UEeOZYBqza2JdMTMIMgeCn7TKnCih7BOD5GnP/Kcglp3v13oHdvpPmPm1mPZdAbQDvcg4tSStH2VD8huL6/ACGzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=geekplace.eu; spf=pass smtp.mailfrom=geekplace.eu; arc=none smtp.client-ip=5.45.100.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=geekplace.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geekplace.eu
Received: from neo-pc.sch (unknown [IPv6:2001:4090:a240:80f6:34fb:50ff:feac:591b])
	by zulu.geekplace.eu (Postfix) with ESMTPA id A99654A01C7;
	Thu, 14 Nov 2024 22:07:32 +0100 (CET)
From: Florian Schmaus <flo@geekplace.eu>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>
Cc: Florian Schmaus <flo@geekplace.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sched: Provide sched_set_batch()
Date: Thu, 14 Nov 2024 22:06:47 +0100
Message-ID: <20241114210649.71377-1-flo@geekplace.eu>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function allows kernel threads created by modules to run under
SCHED_BATCH. Its usage may be a good option if the kernel thread is
not sensitive to scheduling latency; for example bcachefs' rebalancing
thread.

Signed-off-by: Florian Schmaus <flo@geekplace.eu>
---
 include/linux/sched.h   |  1 +
 kernel/sched/syscalls.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index bb343136ddd0..100e6923fe39 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1862,6 +1862,7 @@ extern int sched_setscheduler_nocheck(struct task_struct *, int, const struct sc
 extern void sched_set_fifo(struct task_struct *p);
 extern void sched_set_fifo_low(struct task_struct *p);
 extern void sched_set_normal(struct task_struct *p, int nice);
+extern void sched_set_batch(struct task_struct *p, int nice);
 extern int sched_setattr(struct task_struct *, const struct sched_attr *);
 extern int sched_setattr_nocheck(struct task_struct *, const struct sched_attr *);
 extern struct task_struct *idle_task(int cpu);
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 24f9f90b6574..d272c0e0c508 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -880,6 +880,16 @@ void sched_set_normal(struct task_struct *p, int nice)
 }
 EXPORT_SYMBOL_GPL(sched_set_normal);
 
+void sched_set_batch(struct task_struct *p, int nice)
+{
+	struct sched_attr attr = {
+		.sched_policy = SCHED_BATCH,
+		.sched_nice = nice,
+	};
+	WARN_ON_ONCE(sched_setattr_nocheck(p, &attr) != 0);
+}
+EXPORT_SYMBOL_GPL(sched_set_batch);
+
 static int
 do_sched_setscheduler(pid_t pid, int policy, struct sched_param __user *param)
 {
-- 
2.45.2


