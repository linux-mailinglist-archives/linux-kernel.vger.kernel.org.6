Return-Path: <linux-kernel+bounces-228993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAFDD91697D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 15:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E788B246AD
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 13:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89F916D4F6;
	Tue, 25 Jun 2024 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFuYuusr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC59516D4C5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323585; cv=none; b=gUiWqBCm+z82oLzfiLIIQs2rjlFB+1nT6QbWmubbLbAVvTz8O+6zKUv38se3dHcYiHtNwx6I7UQ34GN5r+B6134ui8RagbakiLD9IJ162R/BjxbNajClOGm61FCAHa0yxEQnHA4s0t2JmmrKYmBS5ihyGeUKKv3HUOjVF9zc+n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323585; c=relaxed/simple;
	bh=jsbe59F+45c+ldudiJuMxz+R4Pww7gQC2ECwzseICnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oXlQFrg4Qq6sceExevC2Lw0+taqQddTwBh2WUG5VBk1Lb8gK+2prfneJeua02baUmoUhgG4s+/dog0r5IR9oL/9X+v5p98hGtYe/fM5ABS7ocLoPDMhCuZX1g1295ItRfY16KW7Y/azJe17wt5iEiO3m+VmIF+gY2uSUWwmrYMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFuYuusr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D979C4AF07;
	Tue, 25 Jun 2024 13:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719323584;
	bh=jsbe59F+45c+ldudiJuMxz+R4Pww7gQC2ECwzseICnw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pFuYuusrrokX4bozFJb3gokF7224w3g7XKbz5BhHFPbjypLcXEuLjqADsAUkWNiXv
	 uzn0YCSsp7NNjfZ7IKeoLbNGkPIy1tP7GeTSKIDFNIpMvngPVX5Jl3wAxfBRKrmfsX
	 jL6pvIfVA/Ku1FWinT1LQOoPM58QVgvWonuUhe/752u1puf94Jk5qHWac7kpDtx1b3
	 EN8yqZvvy8TYHE+UdT6lRi3ELnKm3Osaxw0lzUthWo669tFROB8abV649Tc5j4BeTv
	 WmY4/ERQbBDOC649uELSHbYi0jE5SsMZdrZ9UkXIBD6OTgSESedaejAaIwZ2JRNd2B
	 NYVRoTp02E/Pw==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Michal Hocko <mhocko@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Oleg Nesterov <oleg@redhat.com>
Subject: [RFC PATCH 5/6] sched/isolation: Introduce isolated task work
Date: Tue, 25 Jun 2024 15:52:43 +0200
Message-ID: <20240625135244.20227-6-frederic@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625135244.20227-1-frederic@kernel.org>
References: <20240625135244.20227-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some asynchronous kernel work may be pending upon resume to userspace
and execute later on. On isolated workload this becomes problematic once
the process is done with preparatory work involving syscalls and wants
to run in userspace without being interrupted.

Provide an infrastructure to queue a work to be executed from the current
isolated task context right before resuming to userspace. This goes with
the assumption that isolated tasks are pinned to a single nohz_full CPU.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/sched.h           |  1 +
 include/linux/sched/isolation.h | 17 +++++++++++++++++
 kernel/sched/core.c             |  1 +
 kernel/sched/isolation.c        | 31 +++++++++++++++++++++++++++++++
 kernel/sched/sched.h            |  1 +
 5 files changed, 51 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d531b610c410..f6df21866055 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1349,6 +1349,7 @@ struct task_struct {
 #endif
 
 #ifdef CONFIG_NO_HZ_FULL
+	struct callback_head		nohz_full_work;
 	atomic_t			tick_dep_mask;
 #endif
 
diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index 2b461129d1fa..e69ec5ed1d70 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -72,4 +72,21 @@ static inline bool cpu_is_isolated(int cpu)
 	       cpuset_cpu_is_isolated(cpu);
 }
 
+#if defined(CONFIG_NO_HZ_FULL)
+extern int __isolated_task_work_queue(void);
+
+static inline int isolated_task_work_queue(void)
+{
+	if (!housekeeping_test_cpu(raw_smp_processor_id(), HK_TYPE_TICK))
+		return -ENOTSUPP;
+
+	return __isolated_task_work_queue();
+}
+
+extern void isolated_task_work_init(struct task_struct *tsk);
+#else
+static inline int isolated_task_work_queue(void) { }
+static inline void isolated_task_work_init(struct task_struct *tsk) { }
+#endif /* CONFIG_NO_HZ_FULL */
+
 #endif /* _LINUX_SCHED_ISOLATION_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f01979b600e8..01960434dbfd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4566,6 +4566,7 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->migration_pending = NULL;
 #endif
 	init_sched_mm_cid(p);
+	isolated_task_work_init(p);
 }
 
 DEFINE_STATIC_KEY_FALSE(sched_numa_balancing);
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 5891e715f00d..410df1fedc9d 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -253,3 +253,34 @@ static int __init housekeeping_isolcpus_setup(char *str)
 	return housekeeping_setup(str, flags);
 }
 __setup("isolcpus=", housekeeping_isolcpus_setup);
+
+#if defined(CONFIG_NO_HZ_FULL)
+static void isolated_task_work(struct callback_head *head)
+{
+}
+
+int __isolated_task_work_queue(void)
+{
+	unsigned long flags;
+	int ret;
+
+	if (current->flags & PF_KTHREAD)
+		return 0;
+
+	local_irq_save(flags);
+	if (task_work_queued(&current->nohz_full_work)) {
+		ret = 0;
+		goto out;
+	}
+
+	ret = task_work_add(current, &current->nohz_full_work, TWA_RESUME);
+out:
+	local_irq_restore(flags);
+	return ret;
+}
+
+void isolated_task_work_init(struct task_struct *tsk)
+{
+	init_task_work(&tsk->nohz_full_work, isolated_task_work);
+}
+#endif /* CONFIG_NO_HZ_FULL */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a831af102070..24653f5879cc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -60,6 +60,7 @@
 #include <linux/stop_machine.h>
 #include <linux/syscalls_api.h>
 #include <linux/syscalls.h>
+#include <linux/task_work.h>
 #include <linux/tick.h>
 #include <linux/topology.h>
 #include <linux/types.h>
-- 
2.45.2


