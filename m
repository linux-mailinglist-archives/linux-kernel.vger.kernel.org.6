Return-Path: <linux-kernel+bounces-558525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B01AA5E70D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 23:12:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8640189E387
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 22:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783EF1F0E5D;
	Wed, 12 Mar 2025 22:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BHQKhEty"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB0A1F099D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 22:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741817532; cv=none; b=js5AYZV0+pxAJ5H+pkGOKaqIPdJyin7JFNfwBFw7ZpV8vfbOJy1rMYq0DqGcUFU8VnCMDPE0FcKlKcKrDEW3thBqV2NDymKvCBKk+v6HWO81pswvZlm4PQS/1kMFp9bYXdrWGQEcN+JbyiOkMay6gnC3mRtk09Jm7EwVRyVjSAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741817532; c=relaxed/simple;
	bh=r8Xmdb7/oMNjDbX7ftHrQP69ytcX2LgW27zNpKAmLxA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=anYhtI2Ae20RAqQj1YgsARg0bl9TMrWxgs8IDmVJrE2ES4MZL7FA3laEds6N+29iXXbdpWzdSq9u0GLu7I0tOM5vepkqANTh5MV0qdrzOjqGyCId8WIkur1FA/LfCVmi94twrt/CxnqpnUgk8cbIWMgSXBpyLVNsWZAA5Sxle7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BHQKhEty; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff6167e9ccso819590a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741817530; x=1742422330; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p85IZWyNhDKAJWT9u/TQ4C6aOXZqtmGlenKHzziJi5g=;
        b=BHQKhEtyKl2hdU60vAoJmRR9HBBUaLIzCkb5lc9xFjb4+0oTS2EVCj2roZAFGL9LaH
         jkUdVAqz+ewLjOZP4Kb7kODqoZnCNotgMFMq6rnkI5P+eEchblUopJUS0QWUy5/hwbuN
         uiOPJyBPY9uU3B5glFSDlTUSxtGsZyITruoh6QKpU/49U4ZJ9Nui1PUQ+8PA7sxZLwlq
         M1EZC4zp256cngBdCLHkxMQ0YueOb8HjaE+BazVVn5EQPCvkEBrYAiifLwejWN1N7cxx
         FBCRUOA9ssOJZEAEQhfr7GusK/E+ZRrzZH/rnxitUujVirI3B88z1tc/Hr9/ySmAT8sC
         mqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741817530; x=1742422330;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p85IZWyNhDKAJWT9u/TQ4C6aOXZqtmGlenKHzziJi5g=;
        b=B8R2UgSbW7iO694iCOCf2Z/QnHDTOPfw3df1AZnMBjzmsLDbcM4aQOM8ObDYZFZqGY
         JPkFg4VxWIR6qRw6aGM34gg1NR6lqNSHJg9sGgEQe+1/j3AedNGc2zJGFRBhuDyPlIN4
         ZonDQLxHyfTTcRSkfyMb7JEz6TiyOTo5i1nB3h2PonvrHF0GFGdrvj76eQTBumuV5A8x
         CxduIbvH0b3llII5Locch2uQ7xok4XgqiZ9FjPKLJSPjzAsAugw+98y0340qI0dMxtTs
         E2ykw2/mJT+ITuML+bRA3EceRQDO7UoC5YAq5qFC/GAXaVIS6V7aFOSYdTxGiXCzVxxf
         j99A==
X-Gm-Message-State: AOJu0Yxkuz262iAInGzKCwMQdOwohrsI4QwAFFV7xxg9AKmdpM3ypBr0
	QsUyiP0Cn605Q/zGo0sWtReU7f9Y2+00JOXZ32ZFQxtR+UNLAq/pCS9G+/r5arbVHpr927eFfn4
	qeDzqo+yuU9jK7fAusY/mCEwqMwDPGcd7T0UioAln4SmxyccL3+KtxO6tSrC2V4dZ+379Ar2DgN
	KuAuyEtW8d0wWIQvyLE2DuyIf1Bj4z+5wFEKise0YYKGrI
X-Google-Smtp-Source: AGHT+IFmw/822eTzUBkUVDRlJuN992GCCAXwPjeKnTfFQRKUKF9R3vwJT7t1Frwq0C8CYIOpFWNNAva4zdPN
X-Received: from pjbsd4.prod.google.com ([2002:a17:90b:5144:b0:2ff:6e58:89f7])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2fc5:b0:2ee:fa0c:cebc
 with SMTP id 98e67ed59e1d1-2ff7ce949d2mr34249512a91.20.1741817530434; Wed, 12
 Mar 2025 15:12:10 -0700 (PDT)
Date: Wed, 12 Mar 2025 15:11:34 -0700
In-Reply-To: <20250312221147.1865364-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250312221147.1865364-1-jstultz@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250312221147.1865364-5-jstultz@google.com>
Subject: [RFC PATCH v15 4/7] sched: Fix runtime accounting w/ split exec &
 sched contexts
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

The idea here is we want to charge the scheduler-context task's
vruntime but charge the execution-context task's sum_exec_runtime.

This way cputime accounting goes against the task actually running
but vruntime accounting goes against the rq->donor task so we get
proper fairness.

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
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/sched/fair.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c798d27952431..f8ad3a44b3771 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1129,22 +1129,33 @@ static void update_tg_load_avg(struct cfs_rq *cfs_rq)
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
2.49.0.rc0.332.g42c0ae87b1-goog


