Return-Path: <linux-kernel+bounces-290863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C56AB9559AC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 22:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 757A4281583
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Aug 2024 20:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0842D158874;
	Sat, 17 Aug 2024 20:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="E02/qpjb"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAA915666A
	for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 20:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723927613; cv=none; b=AV0BW3NdpBPZ1/J8Y7KMuNmMFDTPKdDy641tU/eyjf3N/fjj65PbAW208NAbZhBpjCZnZ5o86tHCFgJJ7HIe6FsdfIV4u1eASq20hx7Ksb7+fW6kFC1EhuYdL9EfLZDfeUgbebFOBpGP4Ad8gkGG58XwU1PF6IlKEqsX3O3a8hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723927613; c=relaxed/simple;
	bh=SPg/XGdiwvOhL+oa1vx9Pvfril4dvc5VZdhtTr90MxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lu/gqEeLdrgHER1BsqApfCX1DROtnXayo4WuVoIxLTyKrdEhfRfgeGDYDTKNf3+1QBIzBkRcgZD3a42OkGuTyqmOPHBEaKOzhlgPVDFehYUllgX+B9kipPkS+7vjn+1dV8GzVqjiRwOMsYNwFZ8A71zATu9hakmzl6zONTUYolc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=E02/qpjb; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70e9545d8b2so302667b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Aug 2024 13:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723927609; x=1724532409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PdJU0AKBI1klaEB//Q4NVt3BG+whZBi3IWelzEvwmBo=;
        b=E02/qpjbrnlVn3jpYt6tIroIYW2nTqBmzbxp3/c8qOPOhZak84E3MBsUOg+cx8lGs6
         Me/KfFzY6GSdfhUGH1JyQ5NqiclGhK6elXXkv37oJsOBlZ+Y13W83mVNQ1SrvqZrasys
         zzjBwEqlJF9n1CEMUZcYNIcLDNCH0LruMfgdV/WWORb4w82y1rmoUfXrafMLUdjyxwAF
         mfKQueW6m5THhas+A+yjw0Far4awYN+Q2A3idAoarIU+yHQQuA8TQHozlzFvnCGlx+qG
         m6nPacBIlUpFtAYraiEGkeb/tL2Tj5zz8X+Ni3+gKjfp/gVDH5TJjW0FiBxX6Egg+8pE
         uOPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723927609; x=1724532409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PdJU0AKBI1klaEB//Q4NVt3BG+whZBi3IWelzEvwmBo=;
        b=gfkpgo9+t0Nbud+UHhWO72UKNs7T3M6qEMv40uiDCMJUUPiF3a95yhMGTx/4rPnmDA
         mKXEEPVHvpmM/nMVKbjUAcUznvnkcMF/N13el5CEDeux0v8L8tWZ5amE4MZ9A6mws+3J
         2E0MpamfTA2Vc2YnvdA642/lEnZFAiKe1ULp8w0eujKOqFZcskP2ZEN/ZyzwUFS75hQn
         O6+vNjH4J/JnC3X1VHf2/Aq+q5ZIh+eUUYCN6+SjQRVNTwYxoxir4LIs1l9BasPlFo3k
         KyTpRR66v4SUx31m2/ZpdjRELsRNIC/jRl54trUS0zSLXyjZFwRK/SCUz3i6cckC7bel
         sfKw==
X-Gm-Message-State: AOJu0Yw5b2N+9g3BXtJQoKel38iZQMdetAeTnrwQQuJxMnJxXEsfMSwP
	YR9fICTAWVD+EPHPUzSVz/P+fWs9t3OH3kWSmrQl5dc3/GL+X4oddaUV37r7zMOu1uzttzgMbrQ
	o
X-Google-Smtp-Source: AGHT+IHCMlvikufxnp0CIT030Dri3L7MhVt1qa9DhShIkxkCbTdWVjDgAAvrxENvPAGV41e+iE3f5A==
X-Received: by 2002:a05:6a00:2d17:b0:70d:1048:d4eb with SMTP id d2e1a72fcca58-713c5222e10mr5169301b3a.3.1723927609548;
        Sat, 17 Aug 2024 13:46:49 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127ae07e41sm4411039b3a.65.2024.08.17.13.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Aug 2024 13:46:48 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org,
	tglx@linutronix.de,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/4] sched/core: split iowait state into two states
Date: Sat, 17 Aug 2024 14:45:13 -0600
Message-ID: <20240817204639.132794-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240817204639.132794-1-axboe@kernel.dk>
References: <20240817204639.132794-1-axboe@kernel.dk>
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
 include/linux/sched.h              |  6 +++
 include/linux/sched/stat.h         |  5 ++-
 kernel/sched/core.c                | 62 +++++++++++++++++++++++-------
 kernel/sched/sched.h               |  1 +
 kernel/time/tick-sched.c           |  6 +--
 8 files changed, 65 insertions(+), 21 deletions(-)

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
index 7cb7ca38fdfc..94af01c6b85d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3541,30 +3541,47 @@ static inline bool rq_has_pinned_tasks(struct rq *rq)
 
 #endif /* !CONFIG_SMP */
 
+/*
+ * Store iowait and iowait_acct state in the same variable. The lower bits
+ * hold the iowait state, and the upper bits hold the iowait_acct state.
+ */
 static void task_iowait_inc(struct task_struct *p)
 {
 #ifdef CONFIG_64BIT
-	atomic_long_inc(&task_rq(p)->nr_iowait);
+	long val = 1 + ((long) p->in_iowait_acct << 32);
+	atomic_long_add(val, &task_rq(p)->nr_iowait);
 #else
-	atomic_inc(&task_rq(p)->nr_iowait);
+	int val = 1 + ((int) p->in_iowait_acct << 16);
+	atomic_add(val, &task_rq(p)->nr_iowait);
 #endif
 }
 
 static void task_iowait_dec(struct task_struct *p)
 {
 #ifdef CONFIG_64BIT
-	atomic_long_dec(&task_rq(p)->nr_iowait);
+	long val = 1 + ((long) p->in_iowait_acct << 32);
+	atomic_long_sub(val, &task_rq(p)->nr_iowait);
 #else
-	atomic_dec(&task_rq(p)->nr_iowait);
+	int val = 1 + ((int) p->in_iowait_acct << 16);
+	atomic_sub(val, &task_rq(p)->nr_iowait);
 #endif
 }
 
 int rq_iowait(struct rq *rq)
 {
 #ifdef CONFIG_64BIT
-	return atomic_long_read(&rq->nr_iowait);
+	return atomic_long_read(&rq->nr_iowait) & ((1UL << 32) - 1);
+#else
+	return atomic_read(&rq->nr_iowait) & ((1U << 16) - 1);
+#endif
+}
+
+int rq_iowait_acct(struct rq *rq)
+{
+#ifdef CONFIG_64BIT
+	return atomic_long_read(&rq->nr_iowait) >> 32;
 #else
-	return atomic_read(&rq->nr_iowait);
+	return atomic_read(&rq->nr_iowait) >> 16;
 #endif
 }
 
@@ -5307,7 +5324,12 @@ unsigned long long nr_context_switches(void)
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
@@ -5342,12 +5364,12 @@ unsigned int nr_iowait_cpu(int cpu)
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
@@ -7427,18 +7449,32 @@ static inline void preempt_dynamic_init(void) { }
 
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
+#ifdef CONFIG_64BIT
+	long token = current->in_iowait + ((long) current->in_iowait_acct << 32);
+#else
+	int token = current->in_iowait + (current->in_iowait_acct << 16);
+#endif
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
+#ifdef CONFIG_64BIT
+	current->in_iowait_acct = token >> 32;
+#else
+	current->in_iowait_acct = token >> 16;
+#endif
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6a90c2da1eb3..0f0eb2b26816 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3584,6 +3584,7 @@ extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
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


