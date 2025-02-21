Return-Path: <linux-kernel+bounces-525369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09311A3EF1B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2AB16E39E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 08:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2B4202C3B;
	Fri, 21 Feb 2025 08:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgnVH3kJ"
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74444202C23
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 08:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740127880; cv=none; b=SMReAt/G3DqaYMGhAddWytwFetfBAhbu69D3p0JKgyZsatBQjeYTmtItaUvBRi9nStk8SDy7BLT4++dA0/3nfefaeLsbTS8dzrGP4u+9CxgyKduHbChJWjPwqs7P6O4Tex8BTmteGwQWCd104SuHkY6bUCKhiYjSZWuVwcNxtAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740127880; c=relaxed/simple;
	bh=IOGJQL6s27+8z3AuOXUqyPojF4z/7mrWClNgfqxYZJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d42phdqejSlTm0rR9Cy4ec5O1I0w9VhNxQrqpzK/dEiXiCMoaAaY0jNfMDR8E3fXxOXqWnNehhAK/e9wZ7pIk8DnFq5R0FU+XKFgUS9nnqx4979duKqt4SLBP58cTey+p9DEtY38Ey+8+r3gnD4wR/qxBi9+gsVU46JHJ5/Ht5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgnVH3kJ; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-22128b7d587so34888325ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 00:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740127877; x=1740732677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25FyP5V2MCscP+w4+HnonziJqe8/Aa1u78lqnAr5ogs=;
        b=VgnVH3kJKQlhaQWjI0012/+jTUHjEP9vOoK2owk9XbowRD3BEONeE/Ii7hyl1b3yrZ
         tif/1k9z8aqVIi/tIoVmDWd//BezzEGo/NkIgTpwE/bLntLR6dFV9lK6u3QXrQGVyxdE
         58tDRK6PU9dLWFWZSnD0E8Yeg/RFdFo40pX+UqavGUFO4y142T1eFRkQLGwfCIjLLrRT
         +AHWgNC/hEKiyNXXZlm0bRG1LP5lD3n88U6yuVdiu9uWRwNDiBmnLIK9ax1b5dkkL/yJ
         Es/OXs2wMWivrkf2u/JuhkQhfPwHFAV45cO8JPg6bHzHTMYSkC1Dxy8PK7+qzlfC7ztC
         ggPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740127877; x=1740732677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=25FyP5V2MCscP+w4+HnonziJqe8/Aa1u78lqnAr5ogs=;
        b=bQngOwCtmOYNdA1KuqQtIOit+wY3Zet4KD8EPHSkN/MIFRt6nfmGlUvIrRHim5zBXK
         cFpaJCyTiQ9FmPQ+Nz7GdKkIfDSPjF5+qCkv6vnxgK4lnX6zxiShycuZT0g60VgnlXXW
         Fylh7DYLnRMzGnRSEaEBwvCeMZRbob7tucWLGIUhB+6TSoXCfQKcRnRSNIkdiB4ociQO
         QWj8MzEobsm1k4Fj9/SBLz0qqWB5VxWuN+em+yWTjNAVRW9UK/0wlmOaMOUA+f1fHDrV
         kVVOQqYBcV2UD37Q1YkB2Ha63xXrFs2fAcE8pY9XZMff8txGDkLNCiTNuciyU4Mcuvdl
         lgCA==
X-Forwarded-Encrypted: i=1; AJvYcCVA3qa2XuTzO9YaDukd013I8M8hDkXfKMhJqm2/52JSURCTg/AaaonmJpCgOorcEZACXyZees/4mBu8R0U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMCdivmNcm6nEufSywpXM/9wZ+N56XxAnNswIOw8IDytBcEsul
	nr/fPBM2+u9muZ3QuITsIQyPFuyZzNzQpypIwajK4hEdBuMrmz1e
X-Gm-Gg: ASbGncvpbupCPTigphgBON0cnHhP4RvyIrQB82boxFDgcLHGnOjW2e6AptyKL1k284y
	BNcCFq2pG4I26E3c5AP+pFFaVJ09OW5hapuF1PNaUbFKpBrimXVM1oYecqF+4lDUzWcTUwOBY0D
	5NsD0HypKdlDlU1qgLFz/DssS/YwGpQ9l0v/UXTiYxgdJDoAL41xdbvktygbEw2okIBjZYPTsD3
	UrBMx2Foo4STgL/WoIKQSuaX2PdMe+t9TknPTRjmmLh4Ktdj+IvCbNT+Rm87pN90RJRVCAuneO2
	6xWF+EcQKqWc1KwDajVgi1peXZlXPEwawg==
X-Google-Smtp-Source: AGHT+IGn2IPjva2esrxqes1fneYalYkM593na73RdEni1hrsArpjaZzg1rAnuAXiH9NCfxKR33otsA==
X-Received: by 2002:a17:903:230f:b0:216:4883:fb43 with SMTP id d9443c01a7336-2219ffd2718mr43910005ad.32.1740127877428;
        Fri, 21 Feb 2025 00:51:17 -0800 (PST)
Received: from localhost.localdomain ([129.227.63.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545df28sm132392645ad.153.2025.02.21.00.51.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 21 Feb 2025 00:51:16 -0800 (PST)
From: zihan zhou <15645113830zzh@gmail.com>
To: 15645113830zzh@gmail.com
Cc: bsegall@google.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com
Subject: [PATCH V1 2/4] sched: Do predict load
Date: Fri, 21 Feb 2025 16:50:52 +0800
Message-Id: <20250221085051.32468-1-15645113830zzh@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20250221084437.31284-1-15645113830zzh@gmail.com>
References: <20250221084437.31284-1-15645113830zzh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Patch 2/4 is the core content of this submission.

The main struct is predict_load_data, which every se has one except
init_task. Both group se and task se has it.

Predict load is mainly realized by functions record_predict_load_data
and se_do_predict_load, they run when dequeue and enqueue.

when enqueue, se_do_predict_load record load_normalized_when_enqueue,
and try get predict_load_normalized. when dequeue, record_predict_load_data
use record_load_array to record correspondence between enqueue load and
dequeue load.

Here we use Boyer–Moore majority vote algorithm, I think prediction is
considered reliable only when the confidence is greater than
CONFIDENCE_THRESHOLD(4), this is an experimental value.

It has also been explained in patch 0/4 that the load will be normalized to
0~1024. From the perspective of machine learning, normalization is better,
and it also helps to deal with some special cases.

All operation time complexity is O(1), and predict load will not affect
performance, at least when I test.

TODO:
There are still many shortcomings here. I hope to have the opportunity
to establish a mapping of exec_filename to predict_load_data and add
exec statistics, which helps the kernel distinguish whether the executable
file is sysbench or cyclictest.

Signed-off-by: zihan zhou <15645113830zzh@gmail.com>
---
 include/linux/sched.h      |  46 ++++++++++++
 include/linux/sched/task.h |   2 +-
 init/init_task.c           |   3 +
 kernel/fork.c              |   6 +-
 kernel/sched/core.c        |  15 +++-
 kernel/sched/fair.c        | 148 ++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h       |   2 +
 7 files changed, 217 insertions(+), 5 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9632e3318e0d..b8576bca5a5d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -491,6 +491,42 @@ struct sched_avg {
 	unsigned int			util_est;
 } ____cacheline_aligned;
 
+#ifdef CONFIG_SCHED_PREDICT_LOAD
+
+#define NO_PREDICT_LOAD ULONG_MAX
+#define CONFIDENCE_THRESHOLD 4
+
+#define PREDICT_LOAD_MAX 1024
+#define LOAD_GRAN_SHIFT 4
+#define LOAD_GRAN (1 << LOAD_GRAN_SHIFT)
+
+struct record_load {
+	u8 load_after_offset;
+	u8 confidence;
+};
+
+extern struct kmem_cache *predict_load_data_cachep;
+
+#endif
+
+#ifdef CONFIG_SCHED_PREDICT_LOAD
+
+	struct predict_load_data {
+		//1024 Special processing, index does not need +1.
+		struct record_load record_load_array[PREDICT_LOAD_MAX >> LOAD_GRAN_SHIFT];
+		unsigned long		load_normalized_when_enqueue;
+		unsigned long		predict_load_normalized;
+
+#ifdef CONFIG_SCHED_PREDICT_LOAD_DEBUG
+		unsigned long predict_count;
+		unsigned long predict_correct_count;
+		unsigned long no_predict_count;
+#endif
+		bool in_predict_no_preempt;
+	};
+
+#endif
+
 /*
  * The UTIL_AVG_UNCHANGED flag is used to synchronize util_est with util_avg
  * updates. When a task is dequeued, its util_est should not be updated if its
@@ -587,9 +623,19 @@ struct sched_entity {
 	 * collide with read-mostly values above.
 	 */
 	struct sched_avg		avg;
+
+#ifdef CONFIG_SCHED_PREDICT_LOAD
+	struct predict_load_data *pldp;
+#endif
 #endif
 };
 
+#ifdef CONFIG_SCHED_PREDICT_LOAD
+unsigned long get_predict_load(struct sched_entity *se);
+void set_in_predict_no_preempt(struct sched_entity *se, bool in_predict_no_preempt);
+bool predict_error_should_resched(struct sched_entity *se);
+#endif
+
 struct sched_rt_entity {
 	struct list_head		run_list;
 	unsigned long			timeout;
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 0f2aeb37bbb0..c5d435b9fce9 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -62,7 +62,7 @@ extern int lockdep_tasklist_lock_is_held(void);
 extern asmlinkage void schedule_tail(struct task_struct *prev);
 extern void init_idle(struct task_struct *idle, int cpu);
 
-extern int sched_fork(unsigned long clone_flags, struct task_struct *p);
+extern int sched_fork(unsigned long clone_flags, struct task_struct *p, int node);
 extern int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs);
 extern void sched_cancel_fork(struct task_struct *p);
 extern void sched_post_fork(struct task_struct *p);
diff --git a/init/init_task.c b/init/init_task.c
index e557f622bd90..c0ea11adfdab 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -89,6 +89,9 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 	},
 	.se		= {
 		.group_node 	= LIST_HEAD_INIT(init_task.se.group_node),
+#ifdef CONFIG_SCHED_PREDICT_LOAD
+		.pldp			= NULL,
+#endif
 	},
 	.rt		= {
 		.run_list	= LIST_HEAD_INIT(init_task.rt.run_list),
diff --git a/kernel/fork.c b/kernel/fork.c
index 735405a9c5f3..b8ba621d2a87 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -182,6 +182,10 @@ static inline struct task_struct *alloc_task_struct_node(int node)
 
 static inline void free_task_struct(struct task_struct *tsk)
 {
+#ifdef CONFIG_SCHED_PREDICT_LOAD
+	if (tsk->se.pldp != NULL && predict_load_data_cachep != NULL)
+		kmem_cache_free(predict_load_data_cachep, tsk->se.pldp);
+#endif
 	kmem_cache_free(task_struct_cachep, tsk);
 }
 
@@ -2370,7 +2374,7 @@ __latent_entropy struct task_struct *copy_process(
 #endif
 
 	/* Perform scheduler related setup. Assign this task to a CPU. */
-	retval = sched_fork(clone_flags, p);
+	retval = sched_fork(clone_flags, p, node);
 	if (retval)
 		goto bad_fork_cleanup_policy;
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 165c90ba64ea..905d53503a35 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4712,7 +4712,7 @@ late_initcall(sched_core_sysctl_init);
 /*
  * fork()/clone()-time setup:
  */
-int sched_fork(unsigned long clone_flags, struct task_struct *p)
+int sched_fork(unsigned long clone_flags, struct task_struct *p, int node)
 {
 	__sched_fork(clone_flags, p);
 	/*
@@ -4768,7 +4768,9 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	}
 
 	init_entity_runnable_average(&p->se);
-
+#ifdef CONFIG_SCHED_PREDICT_LOAD
+	init_entity_predict_load_data(&p->se, node);
+#endif
 
 #ifdef CONFIG_SCHED_INFO
 	if (likely(sched_info_on()))
@@ -8472,11 +8474,20 @@ LIST_HEAD(task_groups);
 static struct kmem_cache *task_group_cache __ro_after_init;
 #endif
 
+#ifdef CONFIG_SCHED_PREDICT_LOAD
+struct kmem_cache *predict_load_data_cachep;
+#endif
+
 void __init sched_init(void)
 {
 	unsigned long ptr = 0;
 	int i;
 
+#ifdef CONFIG_SCHED_PREDICT_LOAD
+	predict_load_data_cachep = kmem_cache_create("predict_load_data",
+		sizeof(struct predict_load_data), 0, SLAB_PANIC|SLAB_ACCOUNT, NULL);
+#endif
+
 	/* Make sure the linker didn't screw up */
 #ifdef CONFIG_SMP
 	BUG_ON(!sched_class_above(&stop_sched_class, &dl_sched_class));
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 857808da23d8..d22d47419f79 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1068,6 +1068,23 @@ void init_entity_runnable_average(struct sched_entity *se)
 	/* when this task is enqueued, it will contribute to its cfs_rq's load_avg */
 }
 
+#ifdef CONFIG_SCHED_PREDICT_LOAD
+void init_entity_predict_load_data(struct sched_entity *se, int node)
+{
+	if (predict_load_data_cachep == NULL) {
+		se->pldp = NULL;
+		return;
+	}
+
+	struct predict_load_data *pldp = kmem_cache_alloc_node(predict_load_data_cachep,
+										 GFP_KERNEL, node);
+
+	memset(pldp, 0, sizeof(*(pldp)));
+	pldp->predict_load_normalized = NO_PREDICT_LOAD;
+	se->pldp = pldp;
+}
+#endif
+
 /*
  * With new tasks being created, their initial util_avgs are extrapolated
  * based on the cfs_rq's current util_avg:
@@ -4701,6 +4718,114 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 	trace_pelt_cfs_tp(cfs_rq);
 }
 
+#ifdef CONFIG_SCHED_PREDICT_LOAD
+
+static unsigned long get_load_after_offset(unsigned long load)
+{
+	if (load >= PREDICT_LOAD_MAX)
+		load = PREDICT_LOAD_MAX - 1;
+	return load >> LOAD_GRAN_SHIFT;
+}
+
+/*
+ * Here I don't want the weight of se to affect the load, because
+ * the predict_load_data is designed to record load form 0 to 1024,
+ * so normalized it, we can restore it as needed by restore_normalized_load.
+ */
+static unsigned long get_normalized_load(struct sched_entity *se)
+{
+	unsigned long normalized_load, load = se->avg.load_avg;
+
+	//Prevent arithmetic overflow
+	WARN_ON_ONCE(load > 4000000);
+	if (se_weight(se) == PREDICT_LOAD_MAX)
+		return load;
+	normalized_load = div_u64(load * PREDICT_LOAD_MAX, se_weight(se));
+	return min(normalized_load, PREDICT_LOAD_MAX);
+}
+
+static unsigned long restore_normalized_load(unsigned long normalized_load, unsigned long weight)
+{
+	unsigned long load;
+
+	//Prevent arithmetic overflow
+	WARN_ON_ONCE(normalized_load > 4000000);
+	if (weight == PREDICT_LOAD_MAX)
+		return normalized_load;
+	load = div_u64(load * weight, PREDICT_LOAD_MAX);
+	return load;
+}
+
+//This is a useful API.
+unsigned long get_predict_load(struct sched_entity *se)
+{
+	if (se->pldp == NULL)
+		return NO_PREDICT_LOAD;
+	struct predict_load_data *pldp = se->pldp;
+	unsigned long predict_load_normalized = pldp->predict_load_normalized;
+	unsigned long predict_load;
+
+	if (predict_load_normalized == NO_PREDICT_LOAD)
+		return NO_PREDICT_LOAD;
+
+	predict_load = restore_normalized_load(predict_load_normalized + LOAD_GRAN, se_weight(se));
+	return predict_load;
+}
+
+
+static void record_predict_load_data(struct sched_entity *se)
+{
+	if (se->pldp == NULL)
+		return;
+	struct predict_load_data *pldp = se->pldp;
+	struct record_load *rla = pldp->record_load_array;
+	unsigned long load_normalized_when_dequeue = get_normalized_load(se);
+	unsigned long load_normalized_when_enqueue = se->pldp->load_normalized_when_enqueue;
+	unsigned long index = get_load_after_offset(load_normalized_when_enqueue);
+	unsigned long val = get_load_after_offset(load_normalized_when_dequeue);
+
+#ifdef CONFIG_SCHED_PREDICT_LOAD_DEBUG
+	if (pldp->predict_load_normalized != NO_PREDICT_LOAD) {
+		pldp->predict_count++;
+		if (load_normalized_when_dequeue >= pldp->predict_load_normalized
+		&& load_normalized_when_dequeue <= pldp->predict_load_normalized + LOAD_GRAN)
+			pldp->predict_correct_count++;
+	} else {
+		pldp->no_predict_count++;
+	}
+#endif
+
+	if (rla[index].load_after_offset == val) {
+		if (rla[index].confidence < 255)
+			rla[index].confidence++;
+	} else {
+		if (rla[index].confidence <= 1) {
+			rla[index].load_after_offset = val;
+			rla[index].confidence = 1;
+		} else {
+			rla[index].confidence--;
+		}
+	}
+}
+
+static void se_do_predict_load(struct sched_entity *se)
+{
+	if (se->pldp == NULL)
+		return;
+	unsigned long index, predict_load_normalized = NO_PREDICT_LOAD;
+	struct predict_load_data *pldp = se->pldp;
+	struct record_load *rla = pldp->record_load_array;
+
+	pldp->load_normalized_when_enqueue = get_normalized_load(se);
+	index = get_load_after_offset(pldp->load_normalized_when_enqueue);
+
+	if (rla[index].confidence >= CONFIDENCE_THRESHOLD)
+		predict_load_normalized = rla[index].load_after_offset << LOAD_GRAN_SHIFT;
+	pldp->predict_load_normalized = predict_load_normalized;
+}
+
+#endif
+
 /**
  * detach_entity_load_avg - detach this entity from its cfs_rq load avg
  * @cfs_rq: cfs_rq to detach from
@@ -5336,6 +5461,11 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 */
 	update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH);
 	se_update_runnable(se);
+
+#ifdef CONFIG_SCHED_PREDICT_LOAD
+	se_do_predict_load(se);
+#endif
+
 	/*
 	 * XXX update_load_avg() above will have attached us to the pelt sum;
 	 * but update_cfs_group() here will re-adjust the weight and have to
@@ -5493,6 +5623,11 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	update_load_avg(cfs_rq, se, action);
 	se_update_runnable(se);
 
+#ifdef CONFIG_SCHED_PREDICT_LOAD
+	record_predict_load_data(se);
+	set_in_predict_no_preempt(se, false);
+#endif
+
 	update_stats_dequeue_fair(cfs_rq, se, flags);
 
 	update_entity_lag(cfs_rq, se);
@@ -5628,6 +5763,9 @@ static void put_prev_entity(struct cfs_rq *cfs_rq, struct sched_entity *prev)
 	}
 	SCHED_WARN_ON(cfs_rq->curr != prev);
 	cfs_rq->curr = NULL;
+#ifdef CONFIG_SCHED_PREDICT_LOAD
+	set_in_predict_no_preempt(prev, false);
+#endif
 }
 
 static void
@@ -13345,8 +13483,13 @@ void free_fair_sched_group(struct task_group *tg)
 	for_each_possible_cpu(i) {
 		if (tg->cfs_rq)
 			kfree(tg->cfs_rq[i]);
-		if (tg->se)
+		if (tg->se) {
 			kfree(tg->se[i]);
+#ifdef CONFIG_SCHED_PREDICT_LOAD
+			if (tg->se[i]->pldp != NULL && predict_load_data_cachep != NULL)
+				kmem_cache_free(predict_load_data_cachep, tg->se[i]->pldp);
+#endif
+		}
 	}
 
 	kfree(tg->cfs_rq);
@@ -13384,6 +13527,9 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
 		init_cfs_rq(cfs_rq);
 		init_tg_cfs_entry(tg, cfs_rq, se, i, parent->se[i]);
 		init_entity_runnable_average(se);
+#ifdef CONFIG_SCHED_PREDICT_LOAD
+		init_entity_predict_load_data(se, cpu_to_node(i));
+#endif
 	}
 
 	return 1;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ab16d3d0e51c..cf1e98bf83d3 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2733,6 +2733,8 @@ extern void init_dl_entity(struct sched_dl_entity *dl_se);
 extern unsigned long to_ratio(u64 period, u64 runtime);
 
 extern void init_entity_runnable_average(struct sched_entity *se);
+extern void init_entity_predict_load_data(struct sched_entity *se, int node);
+
 extern void post_init_entity_util_avg(struct task_struct *p);
 
 #ifdef CONFIG_NO_HZ_FULL
-- 
2.33.0


