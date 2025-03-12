Return-Path: <linux-kernel+bounces-558522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 767F3A5E70A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B0D189D77E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C781EFF81;
	Wed, 12 Mar 2025 22:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GD5psmxo"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D111E2823
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 22:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741817528; cv=none; b=B9ERq+GqzoB2EisERqNSlrJJYoTv5mqXAHHdb0/T3dcFIyEjOcAo44bgzIF1IV0JDRBBvXzd7Mfdn0UGEzh8aNmd3EWGIzz51zEI9N/GgbmjQXEMozcq27mXTvgnQoSnh5UcfzZmMvMlMoyqZqOwjj31fiQ8JEgjfBSQ+wz73+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741817528; c=relaxed/simple;
	bh=ScRvgL5J66/FNMNQgyhMFOslQSnvwTPOErcqUsKWrxc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rZ8ewWE7TerxZJM8B3ChqN4pSKrXZ3hcavON7c2olnBg4egWmnL2XSbUbPJieklWopBbv14JNRA+JktMCUSKx61FcKMrU5Ql48q53JXQg/ScVQZSD0gZQ9hSHENQanCQ9lrkrcEpYS6vrhwekAPkpx6/YjN6qEl/Y9vFnM4LsZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GD5psmxo; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-225ab4b8fe9so4611045ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741817525; x=1742422325; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=td7oW6pOWYq7YvXPP724rbAu1/wbGK62pp3VH3i7leI=;
        b=GD5psmxo1gk179tOiAsO4NQqpHMMqKNNqJjU1BXia/9ZA4qLvzNXE22VY6N/E4Py8K
         dLVnXktT87r+GZh+mfeL/vtVQ4njiMZ+Th0VhI4WtWHAPPwZi7fxzh2wWw/nc6jwfQkX
         oFXu6EXMAk5ZHw1XWxAKyrI6tsC1JYJ9HYcfDhNKDnBqUNWbtGov3VwOGHwcW/dxVj/m
         ql77n6KWLqmtvvn07jL3WpfHZIIsbRhoj66Ptpmt16T+GojnKrDXK2DM8O/KrSYxNX7z
         w3FGfcUjZK9EOTZuy4mFIA+61UdPVJsivaVV5WeEzizGaAT2Vc9GBBZ39vf1pKcGC8gN
         ToMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741817525; x=1742422325;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=td7oW6pOWYq7YvXPP724rbAu1/wbGK62pp3VH3i7leI=;
        b=ayCPwS6/BmyEYnCJwZNYmKXAbZo4iHbKFYKQgJvjcq4g42I/EDkTfJOOBjaFWRoD99
         8ZgKx/8BC2PJ8a51VGGO+SVs+aXYdQ0qZ5RlQtAmJICax8iAV2wMibO8SVyOwMwkQqBE
         9GtnXV2ZHlTMM377lYls5vVGhZFIOX/K977bTS+sRP9rVZpmG6MmHJpZaqeBavrRNF4F
         CKavq/b58bdT/ht9E0Xf398JU6aXMEyYJt6nZmVKw29mqRrcENSLlRi2ISyPglMawrEs
         ea7/t5v9TktkWRgjTy3fFO0/4uX6Df1Wc8KCcVKBJMmPaSZjYnCu52p4814Jw6V1X3Cd
         7HFQ==
X-Gm-Message-State: AOJu0Yy05JX49ru8QB3ZsV4BoIK8XfKsKwj3HwnH8yWPH/oE7IAMeQqL
	qyZafGLGEo2aEkniPBTBEu+DTd1YY4gKVP0v4fJhQutQYJilQkAvpm2C/4bXW5C7SgTxRmMt/BR
	ZdPedczRj4XX4r8HD1H7WJmalQ/AC+XeuhjKIpEfLXICzUhZcrYTAY+Bu7R+WoHAfS6CDXK3Rd1
	Fw19bhgedHGSO+CWTkSjZ4XGzFiWLZ8EDrU5qxSmbhyN6S
X-Google-Smtp-Source: AGHT+IGuSkFcXrZEdH54rhkETrN7461UlsipLwjDZ0vn5KVHhJclQ2ZPE5pFd99+xZMGVOT8WBwbI+o8nQVY
X-Received: from pfuv20.prod.google.com ([2002:a05:6a00:1494:b0:730:4672:64ac])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3e28:b0:736:4e67:d631
 with SMTP id d2e1a72fcca58-736eb8a17c0mr11578939b3a.23.1741817525257; Wed, 12
 Mar 2025 15:12:05 -0700 (PDT)
Date: Wed, 12 Mar 2025 15:11:31 -0700
In-Reply-To: <20250312221147.1865364-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250312221147.1865364-1-jstultz@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250312221147.1865364-2-jstultz@google.com>
Subject: [RFC PATCH v15 1/7] sched: Add CONFIG_SCHED_PROXY_EXEC & boot
 argument to enable/disable
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Suleiman Souhlal <suleiman@google.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Add a CONFIG_SCHED_PROXY_EXEC option, along with a boot argument
sched_proxy_exec= that can be used to disable the feature at boot
time if CONFIG_SCHED_PROXY_EXEC was enabled.

Cc: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Qais Yousef <qyousef@layalina.io>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Zimuzo Ezeozue <zezeozue@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Will Deacon <will@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Metin Kaya <Metin.Kaya@arm.com>
Cc: Xuewen Yan <xuewen.yan94@gmail.com>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Suleiman Souhlal <suleiman@google.com>
Cc: kernel-team@android.com
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
v7:
* Switch to CONFIG_SCHED_PROXY_EXEC/sched_proxy_exec= as
  suggested by Metin Kaya.
* Switch boot arg from =disable/enable to use kstrtobool(),
  which supports =yes|no|1|0|true|false|on|off, as also
  suggested by Metin Kaya, and print a message when a boot
  argument is used.
v8:
* Move CONFIG_SCHED_PROXY_EXEC under Scheduler Features as
  Suggested by Metin
* Minor rework reordering with split sched contexts patch
v12:
* Rework for selected -> donor renaming
v14:
* Depend on !PREEMPT_RT to avoid build issues for now
v15:
* Depend on EXPERT while patch series upstreaming is
  in progress.
---
 .../admin-guide/kernel-parameters.txt         |  5 ++++
 include/linux/sched.h                         | 13 +++++++++
 init/Kconfig                                  | 10 +++++++
 kernel/sched/core.c                           | 29 +++++++++++++++++++
 kernel/sched/sched.h                          | 12 ++++++++
 5 files changed, 69 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb8752b42ec85..dcc2443078d00 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6262,6 +6262,11 @@
 	sa1100ir	[NET]
 			See drivers/net/irda/sa1100_ir.c.
 
+	sched_proxy_exec= [KNL]
+			Enables or disables "proxy execution" style
+			solution to mutex-based priority inversion.
+			Format: <bool>
+
 	sched_verbose	[KNL,EARLY] Enables verbose scheduler debug messages.
 
 	schedstats=	[KNL,X86] Enable or disable scheduled statistics.
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9c15365a30c08..1462f2c70aefc 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1636,6 +1636,19 @@ struct task_struct {
 	 */
 };
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+DECLARE_STATIC_KEY_TRUE(__sched_proxy_exec);
+static inline bool sched_proxy_exec(void)
+{
+	return static_branch_likely(&__sched_proxy_exec);
+}
+#else
+static inline bool sched_proxy_exec(void)
+{
+	return false;
+}
+#endif
+
 #define TASK_REPORT_IDLE	(TASK_REPORT + 1)
 #define TASK_REPORT_MAX		(TASK_REPORT_IDLE << 1)
 
diff --git a/init/Kconfig b/init/Kconfig
index d0d021b3fa3b3..b989ddc27444e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -875,6 +875,16 @@ config UCLAMP_BUCKETS_COUNT
 
 	  If in doubt, use the default value.
 
+config SCHED_PROXY_EXEC
+	bool "Proxy Execution"
+	default n
+	# Avoid some build failures w/ PREEMPT_RT until it can be fixed
+	depends on !PREEMPT_RT
+	depends on EXPERT
+	help
+	  This option enables proxy execution, a mechanism for mutex-owning
+	  tasks to inherit the scheduling context of higher priority waiters.
+
 endmenu
 
 #
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 67189907214d3..3968c3967ec38 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -119,6 +119,35 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+DEFINE_STATIC_KEY_TRUE(__sched_proxy_exec);
+static int __init setup_proxy_exec(char *str)
+{
+	bool proxy_enable;
+
+	if (kstrtobool(str, &proxy_enable)) {
+		pr_warn("Unable to parse sched_proxy_exec=\n");
+		return 0;
+	}
+
+	if (proxy_enable) {
+		pr_info("sched_proxy_exec enabled via boot arg\n");
+		static_branch_enable(&__sched_proxy_exec);
+	} else {
+		pr_info("sched_proxy_exec disabled via boot arg\n");
+		static_branch_disable(&__sched_proxy_exec);
+	}
+	return 1;
+}
+#else
+static int __init setup_proxy_exec(char *str)
+{
+	pr_warn("CONFIG_SCHED_PROXY_EXEC=n, so it cannot be enabled or disabled at boot time\n");
+	return 0;
+}
+#endif
+__setup("sched_proxy_exec=", setup_proxy_exec);
+
 #ifdef CONFIG_SCHED_DEBUG
 /*
  * Debugging: various feature bits
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c8512a9fb0229..05d2122533619 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1155,10 +1155,15 @@ struct rq {
 	 */
 	unsigned int		nr_uninterruptible;
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+	struct task_struct __rcu	*donor;  /* Scheduling context */
+	struct task_struct __rcu	*curr;   /* Execution context */
+#else
 	union {
 		struct task_struct __rcu *donor; /* Scheduler context */
 		struct task_struct __rcu *curr;  /* Execution context */
 	};
+#endif
 	struct sched_dl_entity	*dl_server;
 	struct task_struct	*idle;
 	struct task_struct	*stop;
@@ -1355,10 +1360,17 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define raw_rq()		raw_cpu_ptr(&runqueues)
 
+#ifdef CONFIG_SCHED_PROXY_EXEC
+static inline void rq_set_donor(struct rq *rq, struct task_struct *t)
+{
+	rcu_assign_pointer(rq->donor, t);
+}
+#else
 static inline void rq_set_donor(struct rq *rq, struct task_struct *t)
 {
 	/* Do nothing */
 }
+#endif
 
 #ifdef CONFIG_SCHED_CORE
 static inline struct cpumask *sched_group_span(struct sched_group *sg);
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


