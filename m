Return-Path: <linux-kernel+bounces-428115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC249E0B47
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14A77B27CB9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 17:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4EC1DE2B5;
	Mon,  2 Dec 2024 17:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YremjeKy"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9A41DB548
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733161582; cv=none; b=uNiGAnuif7roqGEscx3hrNh/4xG4LB4KZq5JMzsWbRQsxBREsQfYTemkr8aqbNcx+rRNFy+Pb3mW5nMuJLlRmUQcAGkc2uQQiEzxCASjWwoDxa0w4y3OqHH/p8HBwP1WIJil8DKZUe7P10k4nCJD8fVnEPmYPkr+r75OmOHIkoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733161582; c=relaxed/simple;
	bh=bPSze9Be6KKv+lxg6xKVD8vLL7rpB+u/fYOoZsaxDv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sARfDlv+AyyPywd8hoqT4I4bTVTb0JDs+ICjACysZQ40VznYa1js1wsIIfQo+WHPJHrR9zmE3o5MAXD8kqR81SYJXX0o/gVbwqODoHeBk6o0msjVVByXSG9bUYiMyP1SYhkHmmdtYhAfl6WBcA887f0BV0GrkuE0oloRBZxLlzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YremjeKy; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53de771c5ebso5235200e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 09:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733161578; x=1733766378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ek/xsElwsHkh8LnXoYO/HvGXR5tmyf5r/Nk1G/nsybw=;
        b=YremjeKyfbzzzFzfvzqUjM8Bjk/Mvo3cQfBzFu+BIw69Ib218eq3Jsj4BeXS65bnJK
         yjTD5BmAtlgNJRCIGwqQr8DfV33nYYkmf2eMSbd1UPL3CKbgkkOnaRYLt34EXz1lxh1u
         JKCW7dVZ59D6+smJo4GPmRfCMeioLtfcXq+4obL0CRZtfQoMaftgJ3EvAYLSLEz4F7u1
         azoj8DLSW43cw2nxRhgpT86BfApCoPTjaWBWXFNwsf8LvG/YZVTT24qONf4T0xH63Xfu
         N2YIy8hd76hk8hWAGTl0uLRc+179dd/kE3jcxVNBM1qHH8Pnr51MsTPa3ba2kdOj5a3t
         m8YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733161578; x=1733766378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ek/xsElwsHkh8LnXoYO/HvGXR5tmyf5r/Nk1G/nsybw=;
        b=kCBmnrmHm6NugBup+fjCk9ooSw3D+0+2vbbmDM0jZ3oqCUKrXgWzbZd2ljFyhbppG6
         X6T1Vk7K+z0SjDOyBl1opmBXe5D67NBZ4QKDUaUPs+dZFEYPLxLsYnfDP2b0F67o3NUz
         5pPZV+46jcFXzxTFdHJoWIGEC/ekc8GjvP4tygVSXMi96+FfqOSkU054/QyMhKiTFs51
         O2ypyWR7HRr0prqGehmzGtxGb2QKeHVoZFkFDNjj5aSxgF0RBH0btHFQwiCSw5mAyDd2
         1PvzJyQj3Gb5knKkN02TCn5L1ZUyiMtMZ1COdBOPnIwxso7QNORqFyJTjIu/2o592GCI
         9VxA==
X-Forwarded-Encrypted: i=1; AJvYcCVlxP9laKADTffaPeTPBVZwcoAnpjz6EXufX9jQpFG6LE+qnAmCtES6uDYcGyzPbgeGUgLnDWuktHz2iIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVQdNBD7red+jtV0JZMIIhbxuam1lB7ZKIrYwKuP3jHiMA1W4y
	CJNRgJEU5YDc3E2uvZF5qjjjx7p4Be1JnjWfSzY52x0UlcXQhIR6VAoHpqwRBOc=
X-Gm-Gg: ASbGncs5h+Gh/xdMAVGjRIvRlb7wbRQOesvdhMO1vPnPVynnWEWRFm7A74kJvICKb5J
	luOQ8x0XMT2jOQHoeCFUzDlNRwSRdXjHqIXmOZxlM/FsG49BOyGJrS44DV2i9HVTbHEIv8356Iq
	URz+GafZevtSwnrOqKx+dPUVjfvtcoB4PHLevQPvo8i638sOP8w9Kf/Ca6k2n6/jJ1C2E4voAjs
	BaWK1aAsoygpu+hR05UQ5JvyYvsOt5ZhAgUXw9yrxOAZ/Y2Io73eP6/BaA=
X-Google-Smtp-Source: AGHT+IGT2Akx/4NKE0Li/lmEpkH1uyU3ezVGw48+hLzJjhoFjk3qlR8IGq+3L600SlxZqFiXULRvCA==
X-Received: by 2002:a05:6512:1115:b0:539:918c:5124 with SMTP id 2adb3069b0e04-53df00dce95mr13626576e87.31.1733161577712;
        Mon, 02 Dec 2024 09:46:17 -0800 (PST)
Received: from vingu-cube.. ([2a01:e0a:f:6020:f271:ff3b:369e:33b6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa7d29fbsm193275855e9.29.2024.12.02.09.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 09:46:16 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org
Cc: kprateek.nayak@amd.com,
	pauld@redhat.com,
	efault@gmx.de,
	luis.machado@arm.com,
	tj@kernel.org,
	void@manifault.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 04/11 v3] sched/fair: Add new cfs_rq.h_nr_runnable
Date: Mon,  2 Dec 2024 18:45:59 +0100
Message-ID: <20241202174606.4074512-5-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241202174606.4074512-1-vincent.guittot@linaro.org>
References: <20241202174606.4074512-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With delayed dequeued feature, a sleeping sched_entity remains queued in
the rq until its lag has elapsed. As a result, it stays also visible
in the statistics that are used to balance the system and in particular
the field cfs.h_nr_queued when the sched_entity is associated to a task.

Create a new h_nr_runnable that tracks only queued and runnable tasks.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/debug.c |  1 +
 kernel/sched/fair.c  | 20 ++++++++++++++++++--
 kernel/sched/sched.h |  1 +
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 08d6c2b7caa3..fd711cc4d44c 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -844,6 +844,7 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	spread = right_vruntime - left_vruntime;
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "spread", SPLIT_NS(spread));
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
+	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_runnable", cfs_rq->h_nr_runnable);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_queued", cfs_rq->h_nr_queued);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_delayed", cfs_rq->h_nr_delayed);
 	SEQ_printf(m, "  .%-30s: %d\n", "idle_nr_running",
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0f6dc4d9b15f..46cf1c72598c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5469,6 +5469,7 @@ static void set_delayed(struct sched_entity *se)
 	for_each_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
+		cfs_rq->h_nr_runnable--;
 		cfs_rq->h_nr_delayed++;
 		if (cfs_rq_throttled(cfs_rq))
 			break;
@@ -5481,6 +5482,7 @@ static void clear_delayed(struct sched_entity *se)
 	for_each_sched_entity(se) {
 		struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
+		cfs_rq->h_nr_runnable++;
 		cfs_rq->h_nr_delayed--;
 		if (cfs_rq_throttled(cfs_rq))
 			break;
@@ -5933,7 +5935,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long queued_delta, idle_task_delta, delayed_delta, dequeue = 1;
+	long queued_delta, runnable_delta, idle_task_delta, delayed_delta, dequeue = 1;
 	long rq_h_nr_queued = rq->cfs.h_nr_queued;
 
 	raw_spin_lock(&cfs_b->lock);
@@ -5965,6 +5967,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	rcu_read_unlock();
 
 	queued_delta = cfs_rq->h_nr_queued;
+	runnable_delta = cfs_rq->h_nr_runnable;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
 	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
@@ -5989,6 +5992,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 			idle_task_delta = cfs_rq->h_nr_queued;
 
 		qcfs_rq->h_nr_queued -= queued_delta;
+		qcfs_rq->h_nr_runnable -= runnable_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
 		qcfs_rq->h_nr_delayed -= delayed_delta;
 
@@ -6012,6 +6016,7 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 			idle_task_delta = cfs_rq->h_nr_queued;
 
 		qcfs_rq->h_nr_queued -= queued_delta;
+		qcfs_rq->h_nr_runnable -= runnable_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
 		qcfs_rq->h_nr_delayed -= delayed_delta;
 	}
@@ -6039,7 +6044,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	struct rq *rq = rq_of(cfs_rq);
 	struct cfs_bandwidth *cfs_b = tg_cfs_bandwidth(cfs_rq->tg);
 	struct sched_entity *se;
-	long queued_delta, idle_task_delta, delayed_delta;
+	long queued_delta, runnable_delta, idle_task_delta, delayed_delta;
 	long rq_h_nr_queued = rq->cfs.h_nr_queued;
 
 	se = cfs_rq->tg->se[cpu_of(rq)];
@@ -6074,6 +6079,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	}
 
 	queued_delta = cfs_rq->h_nr_queued;
+	runnable_delta = cfs_rq->h_nr_runnable;
 	idle_task_delta = cfs_rq->idle_h_nr_running;
 	delayed_delta = cfs_rq->h_nr_delayed;
 	for_each_sched_entity(se) {
@@ -6092,6 +6098,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 			idle_task_delta = cfs_rq->h_nr_queued;
 
 		qcfs_rq->h_nr_queued += queued_delta;
+		qcfs_rq->h_nr_runnable += runnable_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
 		qcfs_rq->h_nr_delayed += delayed_delta;
 
@@ -6110,6 +6117,7 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 			idle_task_delta = cfs_rq->h_nr_queued;
 
 		qcfs_rq->h_nr_queued += queued_delta;
+		qcfs_rq->h_nr_runnable += runnable_delta;
 		qcfs_rq->idle_h_nr_running += idle_task_delta;
 		qcfs_rq->h_nr_delayed += delayed_delta;
 
@@ -7024,6 +7032,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		enqueue_entity(cfs_rq, se, flags);
 		slice = cfs_rq_min_slice(cfs_rq);
 
+		if (!h_nr_delayed)
+			cfs_rq->h_nr_runnable++;
 		cfs_rq->h_nr_queued++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 		cfs_rq->h_nr_delayed += h_nr_delayed;
@@ -7048,6 +7058,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		se->slice = slice;
 		slice = cfs_rq_min_slice(cfs_rq);
 
+		if (!h_nr_delayed)
+			cfs_rq->h_nr_runnable++;
 		cfs_rq->h_nr_queued++;
 		cfs_rq->idle_h_nr_running += idle_h_nr_running;
 		cfs_rq->h_nr_delayed += h_nr_delayed;
@@ -7138,6 +7150,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 			break;
 		}
 
+		if (!h_nr_delayed)
+			cfs_rq->h_nr_runnable -= h_nr_queued;
 		cfs_rq->h_nr_queued -= h_nr_queued;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 		cfs_rq->h_nr_delayed -= h_nr_delayed;
@@ -7177,6 +7191,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		se->slice = slice;
 		slice = cfs_rq_min_slice(cfs_rq);
 
+		if (!h_nr_delayed)
+			cfs_rq->h_nr_runnable -= h_nr_queued;
 		cfs_rq->h_nr_queued -= h_nr_queued;
 		cfs_rq->idle_h_nr_running -= idle_h_nr_running;
 		cfs_rq->h_nr_delayed -= h_nr_delayed;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index b011081aff97..869d5d3521f2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -647,6 +647,7 @@ struct cfs_rq {
 	struct load_weight	load;
 	unsigned int		nr_running;
 	unsigned int		h_nr_queued;       /* SCHED_{NORMAL,BATCH,IDLE} */
+	unsigned int		h_nr_runnable;     /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		idle_nr_running;   /* SCHED_IDLE */
 	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
 	unsigned int		h_nr_delayed;
-- 
2.43.0


