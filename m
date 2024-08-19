Return-Path: <linux-kernel+bounces-292412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FE76956F19
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 17:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36A552856CE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9237171E73;
	Mon, 19 Aug 2024 15:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OgzqL1b+"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0C113B287
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082192; cv=none; b=uH2ig0FruRzcKMpsRpClZ6r+Y8f9G0WdiG6QiP1d5krKjq5M5lz9AJG9gshLEsPUpr5u9cX56sZdFxa9QXt5yyXcjU70GaXn6lBLIAzfUdStvgB6eZlBmNj7BNI8prWxn8KND4zhmKg3p1nUjW0Xc1YTcEeunU40R2kkhPlho1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082192; c=relaxed/simple;
	bh=TR7xaH6L9jgxRR/GiRLfQKqo83/pPQC7QNSPfZayCzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ocn6bfAbl5fu11KiMWvJRjtp/1Qek6ulEEeoN0KDb33qFtRjHJUDlGZUp9d1zKP1J+crA/JNysdoJrBzKVXCEyFDkwFC+zjETUHTjDADaVa5OGC5MNwpNSZVRKdG/h5aVgbgKw3Evv3HIpWcnfxxzFvyM5rFgWiEglEim9um0fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OgzqL1b+; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d3cc6170eeso802282a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 08:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724082189; x=1724686989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrNxaKdN0nj20MhEnsw6+1Kaiw7B64qE6Xvz9cx2Ues=;
        b=OgzqL1b+qrBAdYd9KV7j3OvQFvN7s7cTEqwdy9io/yiACumhoLlZZNsRb+5rWZLS7A
         4uuTBJoDojTfw20QYwL7SZq9BOL3dBvSRxhRd7juc0lF4zL2Xiv7Rq86LmRmyh9j2C3U
         qr0DXEgz69sb3n7sj4KR2sIaPjAMrFy5FRwoOM2tYLATOGSP7ikGRsqd2GceRxpWQXKO
         Xtr7f169hK7ABOPJdaG7M3y+IOCsN2OjPX3XgCzj6W+kKCtSJGUigCLz+usi+qtDl76f
         10Vn57WrP0mYGVrksHacIGJHsrRRJsGyvX04P2aKVTCZBe4WeV4VMtImZwcIox014ob7
         6VzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724082189; x=1724686989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SrNxaKdN0nj20MhEnsw6+1Kaiw7B64qE6Xvz9cx2Ues=;
        b=fj0CD6Jqmr82Ejso7edyt7t5VX6TI4GpRzfl5ezlYwUpYj4QIebFJ+IkSO7OxvlEUx
         Gt/2TUMYdV4EU0QSzPmD0AKgeIV634hk80VhDe7M3pxaJr+7adFLzcOVShv2bl5QkTh7
         hnssTSNKLBAiGKow8fJGEY9HTLL3xT9RYTmA+WwFOXQFsYye8iAauvnGZBGMdoEpQm4S
         fLeeJHHRUXXXzpr+Tyw47rl8jjRrejU9oMkm8YHlAxh/VAEnYEI9uaaJH8rPl+lz8vvc
         d/WHLTyZQnLCQdmWJOcbi/adFt/141MijM0uTwgt3eAZF2ATRGIWRzW9RQugCXI2bwUR
         Wqlw==
X-Gm-Message-State: AOJu0YxftbLkfgfguF0dz/V+vjBUG+4fyQg7D6jFltAaWTuXMvHJHVDA
	rj9tZw+henDzDpxhpCaw0Eb4lDx8YWCQpTrApQ0APF22qhCNXRlf2pX68uLhThB0CFzk3BtwD5J
	E
X-Google-Smtp-Source: AGHT+IF4gcFLJSSpe+tu9+lz3xS5xKspsgXRZSsGGQ7GI6UPMwVEfS71qppmaH8I0RuzWx2ZKRb8jA==
X-Received: by 2002:a17:90a:c390:b0:2d3:d662:61ec with SMTP id 98e67ed59e1d1-2d3e04140f2mr7114441a91.4.1724082189427;
        Mon, 19 Aug 2024 08:43:09 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e3c751f1sm7356041a91.38.2024.08.19.08.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 08:43:08 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	tglx@linutronix.de,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/4] sched/core: split iowait state into two states
Date: Mon, 19 Aug 2024 09:39:49 -0600
Message-ID: <20240819154259.215504-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240819154259.215504-1-axboe@kernel.dk>
References: <20240819154259.215504-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iowait is a bogus metric, but it's helpful in the sense that it allows
short waits to not enter sleep states that have a higher exit latency
than would've otherwise have been picked for iowait'ing tasks. However,
it's harmless in that lots of applications and monitoring assumes that
iowait is busy time, or otherwise use it as a health metric.
Particularly for async IO it's entirely nonsensical.

Split the iowait part into two parts - one that tracks whether the task
needs boosting for short waits, and one that marks whether the task
needs to be accounted as such. ->in_iowait_acct nests inside of
->in_iowait, both for efficiency reasons, but also so that the
relationship between the two is clear. A waiter may set ->in_wait alone
and not care about the accounting.

Existing users of nr_iowait() for accounting purposes are switched to
use nr_iowait_acct(), which leaves the governor using nr_iowait() as it
only cares about iowaiters, not the accounting side.

Utilize that there's enough space in rq->nr_iowait to store both values
in there, shifting the accounting side by half the size of the type.
Thank you to Thomas Gleixner for that [1] suggestion.

[1] https://lore.kernel.org/lkml/87sf1b6o9w.ffs@tglx/

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 arch/s390/appldata/appldata_base.c |  2 +-
 arch/s390/appldata/appldata_os.c   |  2 +-
 fs/proc/stat.c                     |  2 +-
 include/linux/sched.h              |  6 ++++
 include/linux/sched/stat.h         |  5 ++--
 kernel/sched/core.c                | 45 +++++++++++++++++++++++-------
 kernel/sched/sched.h               |  1 +
 kernel/time/tick-sched.c           |  6 ++--
 8 files changed, 51 insertions(+), 18 deletions(-)

diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index 91a30e017d65..5b21225405fd 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -423,4 +423,4 @@ EXPORT_SYMBOL_GPL(si_swapinfo);
 #endif
 EXPORT_SYMBOL_GPL(nr_threads);
 EXPORT_SYMBOL_GPL(nr_running);
-EXPORT_SYMBOL_GPL(nr_iowait);
+EXPORT_SYMBOL_GPL(nr_iowait_acct);
diff --git a/arch/s390/appldata/appldata_os.c b/arch/s390/appldata/appldata_os.c
index a363d30ce739..fa4b278aca6c 100644
--- a/arch/s390/appldata/appldata_os.c
+++ b/arch/s390/appldata/appldata_os.c
@@ -100,7 +100,7 @@ static void appldata_get_os_data(void *data)
 
 	os_data->nr_threads = nr_threads;
 	os_data->nr_running = nr_running();
-	os_data->nr_iowait  = nr_iowait();
+	os_data->nr_iowait  = nr_iowait_acct();
 	os_data->avenrun[0] = avenrun[0] + (FIXED_1/200);
 	os_data->avenrun[1] = avenrun[1] + (FIXED_1/200);
 	os_data->avenrun[2] = avenrun[2] + (FIXED_1/200);
diff --git a/fs/proc/stat.c b/fs/proc/stat.c
index da60956b2915..149be7a884fb 100644
--- a/fs/proc/stat.c
+++ b/fs/proc/stat.c
@@ -180,7 +180,7 @@ static int show_stat(struct seq_file *p, void *v)
 		(unsigned long long)boottime.tv_sec,
 		total_forks,
 		nr_running(),
-		nr_iowait());
+		nr_iowait_acct());
 
 	seq_put_decimal_ull(p, "softirq ", (unsigned long long)sum_softirq);
 
diff --git a/include/linux/sched.h b/include/linux/sched.h
index c1a65e19a3ac..1b40847b0a80 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -953,7 +953,13 @@ struct task_struct {
 
 	/* Bit to tell TOMOYO we're in execve(): */
 	unsigned			in_execve:1;
+	/* task is in iowait */
 	unsigned			in_iowait:1;
+	/*
+	 * task is in iowait and should be accounted as such. can only be set
+	 * if ->in_iowait is also set.
+	 */
+	unsigned			in_iowait_acct:1;
 #ifndef TIF_RESTORE_SIGMASK
 	unsigned			restore_sigmask:1;
 #endif
diff --git a/include/linux/sched/stat.h b/include/linux/sched/stat.h
index 0108a38bb64d..31e8a44b3d71 100644
--- a/include/linux/sched/stat.h
+++ b/include/linux/sched/stat.h
@@ -19,8 +19,9 @@ DECLARE_PER_CPU(unsigned long, process_counts);
 extern int nr_processes(void);
 extern unsigned int nr_running(void);
 extern bool single_task_running(void);
-extern unsigned int nr_iowait(void);
-extern unsigned int nr_iowait_cpu(int cpu);
+unsigned int nr_iowait_acct(void);
+unsigned int nr_iowait_acct_cpu(int cpu);
+unsigned int nr_iowait_cpu(int cpu);
 
 static inline int sched_info_on(void)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d6c494e33206..a082919caaf8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3541,19 +3541,33 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
 
 #endif /* !CONFIG_SMP */
 
+/* Shift half the size of the type, atomic_long_t */
+#define IOWAIT_SHIFT	(4 * sizeof(atomic_long_t))
+
+/*
+ * Store iowait and iowait_acct state in the same variable. The lower bits
+ * hold the iowait state, and the upper bits hold the iowait_acct state.
+ */
 static void task_iowait_inc(struct task_struct *p)
 {
-	atomic_long_inc(&task_rq(p)->nr_iowait);
+	long val = 1 + ((long) p->in_iowait_acct << IOWAIT_SHIFT);
+	atomic_long_add(val, &task_rq(p)->nr_iowait);
 }
 
 static void task_iowait_dec(struct task_struct *p)
 {
-	atomic_long_dec(&task_rq(p)->nr_iowait);
+	long val = 1 + ((long) p->in_iowait_acct << IOWAIT_SHIFT);
+	atomic_long_sub(val, &task_rq(p)->nr_iowait);
 }
 
 int rq_iowait(struct rq *rq)
 {
-	return atomic_long_read(&rq->nr_iowait);
+	return atomic_long_read(&rq->nr_iowait) & ((1UL << IOWAIT_SHIFT) - 1);
+}
+
+int rq_iowait_acct(struct rq *rq)
+{
+	return atomic_long_read(&rq->nr_iowait) >> IOWAIT_SHIFT;
 }
 
 static void
@@ -5295,7 +5309,12 @@ unsigned long long nr_context_switches(void)
  * it does become runnable.
  */
 
-unsigned int nr_iowait_cpu(int cpu)
+unsigned int nr_iowait_acct_cpu(int cpu)
+{
+	return rq_iowait_acct(cpu_rq(cpu));
+}
+
+unsigned nr_iowait_cpu(int cpu)
 {
 	return rq_iowait(cpu_rq(cpu));
 }
@@ -5330,12 +5349,12 @@ unsigned int nr_iowait_cpu(int cpu)
  * Task CPU affinities can make all that even more 'interesting'.
  */
 
-unsigned int nr_iowait(void)
+unsigned int nr_iowait_acct(void)
 {
 	unsigned int i, sum = 0;
 
 	for_each_possible_cpu(i)
-		sum += nr_iowait_cpu(i);
+		sum += nr_iowait_acct_cpu(i);
 
 	return sum;
 }
@@ -7415,18 +7434,24 @@ static inline void preempt_dynamic_init(void) { }
 
 #endif /* CONFIG_PREEMPT_DYNAMIC */
 
+/*
+ * Returns a token which is comprised of the two bits of iowait wait state -
+ * one is whether we're making ourselves as in iowait for cpufreq reasons,
+ * and the other is if the task should be accounted as such.
+ */
 long io_schedule_prepare(void)
 {
-	long old_iowait = current->in_iowait;
-
+	long token = current->in_iowait + ((long) current->in_iowait_acct << IOWAIT_SHIFT);
 	current->in_iowait = 1;
+	current->in_iowait_acct = 1;
 	blk_flush_plug(current->plug, true);
-	return old_iowait;
+	return token;
 }
 
 void io_schedule_finish(long token)
 {
-	current->in_iowait = token;
+	current->in_iowait = token & 0x01;
+	current->in_iowait_acct = token >> IOWAIT_SHIFT;
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index da2e67621f39..be377ecd1301 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3580,6 +3580,7 @@ extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
 extern int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se);
 
 int rq_iowait(struct rq *rq);
+int rq_iowait_acct(struct rq *rq);
 
 #ifdef CONFIG_RT_MUTEXES
 
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 753a184c7090..17a82771c3df 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -732,7 +732,7 @@ static void tick_nohz_stop_idle(struct tick_sched *ts, ktime_t now)
 	delta = ktime_sub(now, ts->idle_entrytime);
 
 	write_seqcount_begin(&ts->idle_sleeptime_seq);
-	if (nr_iowait_cpu(smp_processor_id()) > 0)
+	if (nr_iowait_acct_cpu(smp_processor_id()) > 0)
 		ts->iowait_sleeptime = ktime_add(ts->iowait_sleeptime, delta);
 	else
 		ts->idle_sleeptime = ktime_add(ts->idle_sleeptime, delta);
@@ -805,7 +805,7 @@ u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
 
 	return get_cpu_sleep_time_us(ts, &ts->idle_sleeptime,
-				     !nr_iowait_cpu(cpu), last_update_time);
+				     !nr_iowait_acct_cpu(cpu), last_update_time);
 }
 EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
 
@@ -831,7 +831,7 @@ u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
 
 	return get_cpu_sleep_time_us(ts, &ts->iowait_sleeptime,
-				     nr_iowait_cpu(cpu), last_update_time);
+				     nr_iowait_acct_cpu(cpu), last_update_time);
 }
 EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
 
-- 
2.43.0


