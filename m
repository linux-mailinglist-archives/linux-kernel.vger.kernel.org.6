Return-Path: <linux-kernel+bounces-421575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2279D8D09
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F8CA163BDB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52BF1C07F1;
	Mon, 25 Nov 2024 19:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lwAlyHF4"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2A917E00F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 19:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732564330; cv=none; b=Uzn5FUgqR9ht7snfVxvh+raERiqBXusd8OocZfphTnXaelsK1Zd56r2hraiEi3bIVuGcBVyyC01pwr+q/yq22bKdIXifnmpDiHs9+PHqtX7xLip2VpqYkzP6g8kxpUQ1OQ9LvrkngVFyfhjuQ6PfR9XGHz/P2GQ16KtaKqiIXic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732564330; c=relaxed/simple;
	bh=ldvGcJ1p5BFMj5Gb5T1BYJE899OrjpqU47w++MQHuO8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T+4NKM51BmWTK/3CfQtiDEs7TPjkHX4EcyrOnTXo1TbugNZrkZr0Ai6LsKIb32Y1ZEsA5upoq43zGCd0epKAtd1CCyxwuhJOsjK+cVmH71yLvyE+HJZI2RmGfuJOPsKrotam7LsDHnpOC88UicWxfv0agJCPKHfge4/R5S5+juU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lwAlyHF4; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-7fbbb61a67cso3222028a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732564328; x=1733169128; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ajms8VnNMkE1TQffsMnBvZtTPD6SPlAUmat2ZJ1/s7g=;
        b=lwAlyHF4ThPqLryoC6TccNW3ICNct0LQTa+m1NQTmWdm5thNa82mtGBeDrNWq33K7u
         /1jS3xkVW4zmfB5IbVKgo28ItHOCmsXhMU7MYllTE9MfzmRNSU7ggCBK3MZa1P6z4sIl
         IkwfWtbmM27nUccKdFTPJM67/DM0Bdki5cdjjhLOA5+4ykUXklBPsxqQblgou01B9eYs
         Bj2s2vxHbzzZrKr7OtJdR8Xvi/pLLKHpSFmUxkO5eG5lRJmmiBmHLqipqWV9H3D7jiys
         +Cfb1mVgG74KUirqV2d50kBcKP1vuiKHfQ/Zmz9P/TR8I4USJ0sgdrCCW+0bNs1afpnR
         dDtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732564328; x=1733169128;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ajms8VnNMkE1TQffsMnBvZtTPD6SPlAUmat2ZJ1/s7g=;
        b=P+JlFdW6EoFXFwvIANcgUUezWa65WfA1soWz3IpC4T4JKAr+R8bwnX+gIWRzJwbMhW
         2c9UhC2zDcFntT1Ke4aH3Vw+e9pU26I0mt57GbqnFJb5ModsdYEaUcMeixwNWTR4hqnN
         eP4wj/2H8EKUCOK4BcY1T1uhKq2FQ4W5JJ7iQKWZWeDc5UBJkeXha+bsLX9r8engG22T
         X/USqpsz5yI3L7ziqoN9ewr3YQU8OF+hyZkzQwT3VV1/Sq3z7OL3DVfzpDZIVbJ3yyHo
         dn3jIizty6l0HXPBkEJdVP3PePMD4qAGWpo6fEevGwAOMTDQeje2fl04I9rpLjrc2zPb
         pInQ==
X-Gm-Message-State: AOJu0YzjWcae6TMxUspddtd5ehCq3QY3IjybTTGu4mOwzHyDlFnhom7U
	QYd+NUNeYeh4wNVlIqEufifooka2wIHxlDKaAN0ru2ebHkKRPMz/WLwClqbW7MMQcRc1mvM4Kxs
	s8BBUftBHZmLDauY6gZB98NWecymFpde/IE9Vk+j1LgvCLxODQQcLzxIZ1SlLCS2ozaxU+EBv9i
	bA4ReYM7xDPd4+JePD9ObChsAH5rNg5jX4nJBMe9X+Y3kH
X-Google-Smtp-Source: AGHT+IFRW2wpYU0GwI7l0UB+J3wwg1ogfMsLSpZ+RMNEClBjAmofPmgplJSoSqIM/qfIAJxIjEQWZMqYOpYr
X-Received: from pgbee13.prod.google.com ([2002:a05:6a02:458d:b0:7fc:3112:b331])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:164a:b0:1e0:c5f9:75a0
 with SMTP id adf61e73a8af0-1e0c5f977dbmr8796928637.17.1732564328450; Mon, 25
 Nov 2024 11:52:08 -0800 (PST)
Date: Mon, 25 Nov 2024 11:51:55 -0800
In-Reply-To: <20241125195204.2374458-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241125195204.2374458-1-jstultz@google.com>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241125195204.2374458-2-jstultz@google.com>
Subject: [RFC][PATCH v14 1/7] sched: Add CONFIG_SCHED_PROXY_EXEC & boot
 argument to enable/disable
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Joel Fernandes <joelaf@google.com>, 
	Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Valentin Schneider <vschneid@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>, Mel Gorman <mgorman@suse.de>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Metin Kaya <Metin.Kaya@arm.com>, 
	Xuewen Yan <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"

Add a CONFIG_SCHED_PROXY_EXEC option, along with a boot argument
sched_proxy_exec= that can be used to disable the feature at boot
time if CONFIG_SCHED_PROXY_EXEC was enabled.

Cc: Joel Fernandes <joelaf@google.com>
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
---
 .../admin-guide/kernel-parameters.txt         |  5 ++++
 include/linux/sched.h                         | 13 +++++++++
 init/Kconfig                                  |  9 ++++++
 kernel/sched/core.c                           | 29 +++++++++++++++++++
 kernel/sched/sched.h                          | 12 ++++++++
 5 files changed, 68 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a4736ee87b1aa..761e858c62b92 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5955,6 +5955,11 @@
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
index f0e9e00d3cf52..24e338ac34d7b 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1610,6 +1610,19 @@ struct task_struct {
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
index b07f238f3badb..364bd2065b1f1 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -863,6 +863,15 @@ config UCLAMP_BUCKETS_COUNT
 
 	  If in doubt, use the default value.
 
+config SCHED_PROXY_EXEC
+	bool "Proxy Execution"
+	default n
+	# Avoid some build failures w/ PREEMPT_RT until it can be fixed
+	depends on !PREEMPT_RT
+	help
+	  This option enables proxy execution, a mechanism for mutex-owning
+	  tasks to inherit the scheduling context of higher priority waiters.
+
 endmenu
 
 #
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 95e40895a5190..d712e177d3b75 100644
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
index 76f5f53a645fc..24eae02ddc7f6 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1148,10 +1148,15 @@ struct rq {
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
@@ -1348,10 +1353,17 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
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
2.47.0.371.ga323438b13-goog


