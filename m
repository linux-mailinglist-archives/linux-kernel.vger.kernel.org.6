Return-Path: <linux-kernel+bounces-397555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2496E9BDD59
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 03:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A70071F236DF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 02:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802BA19066D;
	Wed,  6 Nov 2024 02:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cZjjSYC+"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3294A190052
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 02:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730861829; cv=none; b=W3TaZl2D5F2J0AivM/lwkfAYgyaWC0tmAR32SMyQnLbU82c3k7Lgu1OpPoHrloqPwHFaqTun+XDRVVkNjNMTOITeHCaF3FBT4vYBq+b1AXw4tdQFN1SHNAZGrf9wrz07RcroRwLyME9H6YIIat5427jvYB1NXZF6euRAWKQpn4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730861829; c=relaxed/simple;
	bh=epXx3nKHnvZo7ttPmlz+gQBJAvkWxrkiXzHmixCGH4E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aW4a01DoFad3oszDmO6UaWcl/SHv6hjAv/fGx+qIgfOAm3RxxDUrBPl39YdMa3j0DyBq4vRxIMUQIN2HTVZKI4JVmJmJKyQFKFqwiV6VV6GLphWl0Y7Q33YeZAFtY/4YUaJCZi+hhOzt+3Fm4GzCvZVdmBcSM3ihCyu4XMUrti8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cZjjSYC+; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ea8d6fb2ffso57541967b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 18:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730861827; x=1731466627; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JIjrE5PEMg1ur9keW/GF/fKrt7H/YNFX6Ddge323Jlc=;
        b=cZjjSYC+nOROS8tslrvrpRn5o+49J9zZsoZ9kyX8aaZHvjHlKICuECJGqGKf027Qpu
         XKVEbERcA7PMH9TBvdEzidCPDt+Y2lau+mVYoAD+cZRrCy6/G3UBFBpIsFxgTb9MnH1A
         oS7Hl/cHxYTHOmu2fDKIZHxmPx1OMoHBlloeCiYNJWi+BEbTIqxiJ/ec/FQsZ2hyZZ6L
         WEQpktjkjzOElWQkyWbRWtj8LNR4TVCRJ5ioLCq4v12O+QTLDHwxPbeUIlFyKPKKdn/U
         QcJrxB1kSEkCZ5HG4XJ8XjNVKjxjUomLf4ZJfp/1k6S66Uo7SjDCh3LQMpD57Or/j8NU
         dKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730861827; x=1731466627;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JIjrE5PEMg1ur9keW/GF/fKrt7H/YNFX6Ddge323Jlc=;
        b=eDxJUvbQbdBMuRLdt4X9QzgYh0EpCeUP/RUBu0AAxAb6etVzKxEiz8IdjBFGk+iCj6
         kHvLKFg9UoEsxkkio1jDZbwIATa/c5ZRwe77GIiZDgQylrQ3As+rvWHzT1ypA+PozYLm
         32LpMFnSV5hjjwTj2pMLUF6k/8HZBz+4iLKavUaxZAimdNKzqGAwq+ezYrVKrZUV2WYQ
         qtcZhBkmj/lXFpFuHkbKkXPC56WB3u10WrfT3KRxTNSJkLmDzX5o8S1JZz7DDCHEzLun
         lcn95GXzqW1DRe7o6C9YFFeHNKF34Ce/02AIY0wmDyMTaDwGbr9lMKQ7Eb9h6FDevTUL
         TibQ==
X-Gm-Message-State: AOJu0Yy5UCIz+NcqVgu4f3Rtx1ftSBwSflJcKMfFMExa64lclxMjov1J
	HgqgVaUglW+8ciaPgPwzcV6DyGJws6XPyzATfYA0PD19X15l7vKy0uScA54zpmNU8F+qwPu2rOr
	icQartdd6T8eC0PEKKQY94nMBJAlBWWs6cuMUj7m83PfmXPZLFLEpQUM6J9MPVYNTMcadXYm4n3
	aXF10rQDDxyubISaBc32Vrl+ttPsh8Pd5ypTsNVXc2ZwvC
X-Google-Smtp-Source: AGHT+IH57CaO7dkz9YeYIDEWbd5iZq3+IpRtvec2q0BntJ6KhDSB2nrieHTmma7LEhVdAsPW5ELtduDVRF3S
X-Received: from jstultz-noogler2.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:690c:308a:b0:6e9:f188:8638 with SMTP
 id 00721157ae682-6e9f1888858mr14057437b3.7.1730861827130; Tue, 05 Nov 2024
 18:57:07 -0800 (PST)
Date: Tue,  5 Nov 2024 18:56:43 -0800
In-Reply-To: <20241106025656.2326794-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241106025656.2326794-1-jstultz@google.com>
X-Mailer: git-send-email 2.47.0.199.ga7371fff76-goog
Message-ID: <20241106025656.2326794-4-jstultz@google.com>
Subject: [RFC][PATCH v13 3/7] sched: Fix runtime accounting w/ split exec &
 sched contexts
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

The idea here is we want to charge the scheduler-context task's
vruntime but charge the execution-context task's sum_exec_runtime.

This way cputime accounting goes against the task actually running
but vruntime accounting goes against the rq->donor task so we get
proper fairness.

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
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/sched/fair.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6512258dc71f..42043310adfe 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1131,22 +1131,33 @@ static void update_tg_load_avg(struct cfs_rq *cfs_rq)
 }
 #endif /* CONFIG_SMP */
 
-static s64 update_curr_se(struct rq *rq, struct sched_entity *curr)
+static s64 update_curr_se(struct rq *rq, struct sched_entity *se)
 {
 	u64 now = rq_clock_task(rq);
 	s64 delta_exec;
 
-	delta_exec = now - curr->exec_start;
+	delta_exec = now - se->exec_start;
 	if (unlikely(delta_exec <= 0))
 		return delta_exec;
 
-	curr->exec_start = now;
-	curr->sum_exec_runtime += delta_exec;
+	se->exec_start = now;
+	if (entity_is_task(se)) {
+		struct task_struct *running = rq->curr;
+		/*
+		 * If se is a task, we account the time against the running
+		 * task, as w/ proxy-exec they may not be the same.
+		 */
+		running->se.exec_start = now;
+		running->se.sum_exec_runtime += delta_exec;
+	} else {
+		/* If not task, account the time against se */
+		se->sum_exec_runtime += delta_exec;
+	}
 
 	if (schedstat_enabled()) {
 		struct sched_statistics *stats;
 
-		stats = __schedstats_from_se(curr);
+		stats = __schedstats_from_se(se);
 		__schedstat_set(stats->exec_max,
 				max(delta_exec, stats->exec_max));
 	}
-- 
2.47.0.199.ga7371fff76-goog


