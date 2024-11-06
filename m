Return-Path: <linux-kernel+bounces-397553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C1F9BDD57
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE04E284236
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A81190072;
	Wed,  6 Nov 2024 02:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NovCl0/k"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E46318FDCE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 02:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730861826; cv=none; b=NTTpUssbb4iZtpCx1NchEDitoLAB7eiNyFexUQlb+bDAjAHJdwLe1QlUvB3QWy/gP5YPlSxTk1V2E8TY1ot60GP4X9xcLnzVkQIPd4HkLsIQcDxQXlGf+CgjI6pvDu6aWptFVKwSyoUia85JYNxZbEQSBFqdEDwddqAeS8Fjvek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730861826; c=relaxed/simple;
	bh=h6TFkk3UWQbVFEnbht6yNjdbKrdQbKC/+TdjrBRVTyU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bIS5AigEqyTyxq0bPzqRycC9RgVwrzIplrN5mVyliYTpAEWvsc2IDULafz89nWnTnUif6Q79mTdo+uym7MnQbQ1Pcl4nSITsvfCaDFnpaHan8D6Q+66/iNsg83Y0dCM5HtqGweYdYbv/Fy1hpAIEDbxmrq6nepYfqkJRDmoL5Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NovCl0/k; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ea863ecfe9so73139467b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 18:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730861823; x=1731466623; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FAcghQf6R6kdCkj8rTfS8LDuV3Z5MU4VGrydA8s7ieg=;
        b=NovCl0/k0OKEjUkIuGpuv7qCCz5NZHz9ajR5bExOPxLn3dUf8KVVWfF4/ZsFMEi4X5
         ongeIzjq0UOFTIlXqJVi+oM1zr3+tOKs9s7xrQAl2+KUnXi20L2p3lm0seF1fD2ZCMyu
         BGGNZ4j7DnBsuPYPnkFMsfngUrnRDbwIJpQBT1s8WMRKs/P4P5sfDiVkf/smhnZeDhbY
         WMbbLDYzCxZfXU/j31zK07VlGEAUXD64o/g9jk6XGamucIIftVB76iUYUJX2XQbfjsjk
         9Y9CNzAG+mAXJ822za3z2El2P9WEN93VqZe1A0C/28Z0cWCFWWtylnQEV0WngBuEI/gR
         cEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730861823; x=1731466623;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FAcghQf6R6kdCkj8rTfS8LDuV3Z5MU4VGrydA8s7ieg=;
        b=HNau6TC17SM6XU9ucOxdh0W5TCRV07sxbOFSQBj4SUU3x82J9odL1KevUrqtuSzGrL
         ndCskPHltEToC4f47A0HM3gbcxU9Bv8DzuHevxQGWYj3oDOJsrHzNBxIx84MVd+a5062
         FmlvfOZ5EpZv+4/k1wEe6pfdNsbkhD05HZqIbGD23uIo13kBU3gOsd6/Qs/tZBaanJNv
         RmrSpFNDZbGsebnpxwYbAf2lESz5EAHxEXS3uJcOStQVwAk5FwalscimhaxbmA5zr/uY
         bZi5xp7pHDtMdidCwiCLvG5xw7iWAjFbOgozVHoM0cYUAjAWWAf7zBim/CEe/l78W8N6
         ac0Q==
X-Gm-Message-State: AOJu0YwD4LFfuCsDCQEyVjiGVGCx+hosZpQjfpCtRt6Gos2/BfxRXdWZ
	E0hSPpqGXnoLHy/9+8mlA50Wdt/IBgsjcFqeXlaguAbfk5Md0LHKndclkXi2MO0cV6V5ZcP6zye
	FRk9PSJKtuctU0MtoTkDZ6P6CFOf2FfJgkCGtLhEyGgYHUX0M5+AdIGipCT0tjhr3TUDcmLsl8G
	cJIWws52wEHeBKFaDp9Z62N9JRwlH8n8++ruUsTv2o20b1
X-Google-Smtp-Source: AGHT+IGUWP+GWTBSONfEMXEftSPgQpmB2+QGLi3H5/olrnBR57+co6NioocX80C16bXkHPB1fkvygZCa2qvS
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a5b:91:0:b0:e28:f2a5:f1d with SMTP id
 3f1490d57ef6-e3087a4ed65mr70312276.4.1730861822133; Tue, 05 Nov 2024 18:57:02
 -0800 (PST)
Date: Tue,  5 Nov 2024 18:56:41 -0800
In-Reply-To: <20241106025656.2326794-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241106025656.2326794-1-jstultz@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241106025656.2326794-2-jstultz@google.com>
Subject: [RFC][PATCH v13 1/7] sched: Add CONFIG_SCHED_PROXY_EXEC & boot
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
---
 .../admin-guide/kernel-parameters.txt         |  5 ++++
 include/linux/sched.h                         | 13 +++++++++
 init/Kconfig                                  |  7 +++++
 kernel/sched/core.c                           | 29 +++++++++++++++++++
 kernel/sched/sched.h                          | 12 ++++++++
 5 files changed, 66 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 1518343bbe22..5152935b54b6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5944,6 +5944,11 @@
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
index a76e3d074a2a..2a47228a4808 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1609,6 +1609,19 @@ struct task_struct {
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
index c521e1421ad4..a91c51850731 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -863,6 +863,13 @@ config UCLAMP_BUCKETS_COUNT
 
 	  If in doubt, use the default value.
 
+config SCHED_PROXY_EXEC
+	bool "Proxy Execution"
+	default n
+	help
+	  This option enables proxy execution, a mechanism for mutex-owning
+	  tasks to inherit the scheduling context of higher priority waiters.
+
 endmenu
 
 #
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c57a79e34911..731ebd8614a9 100644
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
index e51bf5a344d3..258db6ef8c70 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1147,10 +1147,15 @@ struct rq {
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
@@ -1347,10 +1352,17 @@ DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
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
2.47.0.199.ga7371fff76-goog


