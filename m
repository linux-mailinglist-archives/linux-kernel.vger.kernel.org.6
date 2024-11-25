Return-Path: <linux-kernel+bounces-421577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F7A9D8D0B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFD9C16AA35
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D871C7B8D;
	Mon, 25 Nov 2024 19:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wKe2+NPY"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627591C1F13
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 19:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732564334; cv=none; b=I3U/qC+4L0PC+BTjScP2L5jDdYjkDsedewxO8f5ihb4gDq0TUn1CQ1kRQlYI5NdM5a24YJo1qR8S6vy5ldC1RWQ/pGYQUCkoax5RSDpafy0x5SRoOlZr6jlT3C9uM5RPwQaFQZxVz6z5DKBSWC/5DNbUbC/HHEDeneQAr2G3L3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732564334; c=relaxed/simple;
	bh=JXRMYnd0ucUfDV5Qzz/TxTcy1aNUDBMF3uGjnrjG3tE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Az2+07y5baCkuFhmRs5FK8G2ywUaQmTx9YBuxwVQG8GH30md5e+jPcinYJDxRPfcxAsF9Bv8T4xsA6DR0bUTd+U6fX1eMMoI92mWdep1KrcHdaDxAyDC42W4qxM4awvdGnTBCaKLMI3MpaVkGUXiNlCcXH4kqTO0RFY8DtzCefY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wKe2+NPY; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-724e565cd84so3018865b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732564331; x=1733169131; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lWiy5IaznfIpEZ7WIDYWdQnPT0DdeHKfKM1+RyqUBX4=;
        b=wKe2+NPYC5z6UtHAJYhc6BtMB8HXXBrjAEBQImA+jG1Iq+763IMt/GTrZ7z4W7YUcR
         Q7p5CBRP7pV8ahiNHKv8iJAxYXq0tyCbf60anNKzjIsKD26YQtlDfVdYfoDzZ9FEKCtV
         WvZdf5p92PYRZYhb9b5DuiP3KV6csPZTir72/EfZSDG0P1T2nWgSSJ6MCr+2up/pv3iH
         pXnwDaICLIj7X6kY2+Rk5SF17fyxRn8VXwspRPfzKCYw+3wxBU8obOEyUfF92fIsUhxH
         fQyXaMy2egd1GQPbyXJjSkDB1teA6sxAHfSlSVk58OlEXIK5eSCoGtSlD+ElaAwKE7Vo
         VDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732564331; x=1733169131;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWiy5IaznfIpEZ7WIDYWdQnPT0DdeHKfKM1+RyqUBX4=;
        b=oEqvupBozmf2d5UvmgLIZazOGToW7oXZ2VzN7TY/7UioENZQITaUplM2rxgFro7pdD
         oDDqoP6k5ynV6vGEoiLfdRNrp2QBR0c3mHUyXO/f92mTyZBOjJfvHUWgMSya91xdXhQt
         siXfqKY8vEVcpTiuV0bhJ1M6TRMGiw2YjNrpy4Kmd9UNSlnzuutZ0td48bQFrrVp1oJk
         RTXrHUUboGyIL7qNmAu+VieN1I5EnhE2UstuqIEep8+Q0dT43qgFqJTRaOqJ6hlSzOMF
         CmrDdvy3aCcPzBZeVCa09jE5GHc9zt7Vg7cvhOybUIDvpAn7JF7Vbs3F8i/Z9m2kqILi
         UZzg==
X-Gm-Message-State: AOJu0YzUcQ/frOFDWA2Sljw/N9CeoRLPSwR6dYijhFuRfA6GH+N3wagW
	wX4xFlJSam0NhkcOGfkLAmyVKbhiZz9vf98vMbnPTTrJJfMmnaskL7oXigj7WM7BGh4ue9OPnwV
	EBWqE1Wt+nJ5z7xJp/PL/infw7i74lGNQmyR2Rp2E0ZlME5ugClrO3u5PhhfIXOhO8h3z/w8JQK
	SvPu0Xy0jm7+TaUnH2xIUwDr6yC2kht9ssa3TAYEzcKSWK
X-Google-Smtp-Source: AGHT+IFHXNDeOJVe69oi2JM6BqGCpzCO91LAcGe7Rb0UVct3JkWQPPkAKq+XzFe/oHCnanpggxnzCwqTROQ6
X-Received: from pfbf2.prod.google.com ([2002:a05:6a00:ad82:b0:724:fa30:554f])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:aa0e:b0:725:14fd:f62c
 with SMTP id d2e1a72fcca58-72514fdf9cfmr3665231b3a.15.1732564331587; Mon, 25
 Nov 2024 11:52:11 -0800 (PST)
Date: Mon, 25 Nov 2024 11:51:57 -0800
In-Reply-To: <20241125195204.2374458-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241125195204.2374458-1-jstultz@google.com>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241125195204.2374458-4-jstultz@google.com>
Subject: [RFC][PATCH v14 3/7] sched: Fix runtime accounting w/ split exec &
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
index fbdca89c677f4..ebde314e151f1 100644
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
2.47.0.371.ga323438b13-goog


