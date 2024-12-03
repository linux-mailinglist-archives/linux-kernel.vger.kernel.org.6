Return-Path: <linux-kernel+bounces-429650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FC19E2803
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4538DB3B141
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 14:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E96E1F4738;
	Tue,  3 Dec 2024 14:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQuQtKD4"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541D51F4733
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 14:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236103; cv=none; b=C7NBeae/YEbwhkLDva7QNrO62xYrApIE5J6/s+MeTOu8Is15t6XqvWuvpaPwAtqCEyVKrfqnnjb8lp9OONvyxfteiOz0pJO+a7W2AM76j6JwwSH2o5GsKZmN/6UcSjupg5b3zWc/ScJs+4WZbpzGR051dzGaZVWTmD79QJneIhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236103; c=relaxed/simple;
	bh=vQrVciJTDoDS5vnYIk1yX6n6NAutqvNy1gYAuXSRH5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qZft4nvRQKLTUA2tMwCCKiPSbb53FAua09sl345O9Lvjlbi++mZm0fEKSgd+i6SXwv2KlH0naZgG/sldiS1mLzltl8wcVFtGukhaO+Niz4wIshZ5eXLppSb7JylGNQtHWQwGX6Ve5bRQs34ZelyuPddusEdz81N2oDgn+RLzrZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQuQtKD4; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2155157c31fso30057515ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 06:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733236101; x=1733840901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UN9R12v3ErwGCI7mcp2L+jL7PAoJVHL8ztjnEIA4Wlc=;
        b=eQuQtKD4eHVJEdypcSFlHk1MmhZnh6WYX/eVH6kHwomhivOFt9GpNIgUUVilWEGP33
         jfYR8BQtn/g16U6DtILxMBOfVe8WOY7FO0NUbmUuVGp5ccX2KvuIEI32HPzWSY1ah/sB
         dXVGAoAdtosMIdcIy64qyAibnJAD+mQ9ooflJWJ5U22Perf9+olqk0Hm4bid08csCId0
         GHfeaq6+hPzqtHvTSXKHg7EUeAbotzQZ5o+sAdMu2dLlCS5J5RJhHtYIMWiGOq/Y34np
         1UAHQpPxrJVxwrPGLExCv5FtRLEA2ppwMK2MG6A7tswzj8ZzJc/RdEeSbmkdYz/PMk/i
         NmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733236102; x=1733840902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UN9R12v3ErwGCI7mcp2L+jL7PAoJVHL8ztjnEIA4Wlc=;
        b=mE//+XLuQWR2MUaUhyuhGqJBeY9HAJI+v1sg4WducPxoOGKsVWJOOgewzChzUqSz7g
         aOnOE1IXSEbfgoQ3OQtuTRS6UobtfEqP7+vWTa6OuUkaZnJQkBuCooTwcYVHprar6o7W
         +OHFIfXOu32OMPEuUjOe2hgtqZaZRC8z5iEIni/s1Nx1i3ShcDiOLMjSebrBib8xGDix
         m+hKV3j7LyY2UTgg/8yHdqEZ2ELdGhEYDx3Dzo+/hFO55hQ6RpKHh0W/iIlgGvqQfTMa
         tPYAzkXOZoGEKymL2TawkgUN6bQ437X1yl6B+rUwguOeFVwtd4IoRALgaRDcZdyDuSQb
         30bg==
X-Forwarded-Encrypted: i=1; AJvYcCX8OHiRfGI7vPq5NkYdGjkOQL2TiaBxhHaRLm9+QY+WnavoGuIqMlpCNeDS7VH+ruXwuzruw980h2WcS40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6CA8kXH4TAeR/JlKUM1dkXHksd1q0g9I94yhbEkmoZKcWO+Bj
	bQ8Mil9c/uz8rN9XuX1I8Fp/Zg3HpN8UkTjSmqI6yOcPiljcY5VA
X-Gm-Gg: ASbGncvQvdLnfQgjqCcZUQKEoBCRAYsG8dx7D0wSspSxw4Dx4KHJ+e3lZvu82yZ9C9a
	Syd5fCzgGJTjJca5BMgw3CQ/YSHHSd26yrduMGmFtoVrkqPqPs610C3i1/2AY47iU57wJEcPXt8
	J2s9UVz48iMwhe1W4s3gXhAwK7iQ1dqqeKwO/J2C5OYqIVgl6rJoEQi/KLC0DbX93DQzsm0r17l
	221kbFySUoETs6YP0yfdsqbP7zGvmaS7bYzWrWZmnL22+HiyEloRzWTYZV0sgrL0a86N78pTFb5
	IsE0DQ==
X-Google-Smtp-Source: AGHT+IGJY117emqiWiaAw7hJR2jgJXypH9JAa5pixPdjNfoRKlDOxchalfXCK9aU3kL1dpwjft0wjQ==
X-Received: by 2002:a17:903:1744:b0:215:3998:189f with SMTP id d9443c01a7336-215bd45d400mr38752025ad.6.1733236101460;
        Tue, 03 Dec 2024 06:28:21 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21589aa5478sm41391925ad.59.2024.12.03.06.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:28:21 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	mingo@redhat.com,
	peterz@infradead.org
Cc: changwoo@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/5] sched_ext: Manage the validity of scx_rq_clock
Date: Tue,  3 Dec 2024 23:27:59 +0900
Message-ID: <20241203142802.36305-3-changwoo@igalia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203142802.36305-1-changwoo@igalia.com>
References: <20241203142802.36305-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An rq clock becomes valid when it is updated using update_rq_clock()
and invalidated when the rq is unlocked using rq_unpin_lock(). Also,
after long-running operations -- ops.running() and ops.update_idle() --
in a BPF scheduler, the sched_ext core invalidates the rq clock.

Let's suppose the following timeline in the scheduler core:

   T1. rq_lock(rq)
   T2. update_rq_clock(rq)
   T3. a sched_ext BPF operation
   T4. rq_unlock(rq)
   T5. a sched_ext BPF operation
   T6. rq_lock(rq)
   T7. update_rq_clock(rq)

For [T2, T4), we consider that rq clock is valid (SCX_RQ_CLK_VALID is
set), so scx_bpf_clock_get_ns() calls during [T2, T4) (including T3)
will return the rq clock updated at T2. For duration [T4, T7),
when a BPF scheduler can still call scx_bpf_clock_get_ns() (T5), we
consider the rq clock is invalid (SCX_RQ_CLK_VALID is unset at T4). So
when calling scx_bpf_clock_get_ns() at T5, we will return a fresh clock
value by calling sched_clock() internally.

One example of calling scx_bpf_clock_get_ns(), when the rq clock is
invalid (like T5), is in scx_central [1]. The scx_central scheduler uses
a BPF timer for preemptive scheduling. In every msec, the timer callback
checks if the currently running tasks exceed their timeslice. At the
beginning of the BPF timer callback (central_timerfn in scx_central.bpf.c),
scx_central gets the current time. When the BPF timer callback runs, the rq
clock could be invalid, the same as T5. In this case, scx_bpf_clock_get_ns()
returns a fresh clock value rather than returning the old one (T2).

[1] https://github.com/sched-ext/scx/blob/main/scheds/c/scx_central.bpf.c

Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/sched/core.c  | 6 +++++-
 kernel/sched/ext.c   | 3 +++
 kernel/sched/sched.h | 2 +-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 95e40895a519..ab8015c8cab4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -789,6 +789,7 @@ static void update_rq_clock_task(struct rq *rq, s64 delta)
 void update_rq_clock(struct rq *rq)
 {
 	s64 delta;
+	u64 clock;
 
 	lockdep_assert_rq_held(rq);
 
@@ -800,11 +801,14 @@ void update_rq_clock(struct rq *rq)
 		SCHED_WARN_ON(rq->clock_update_flags & RQCF_UPDATED);
 	rq->clock_update_flags |= RQCF_UPDATED;
 #endif
+	clock = sched_clock_cpu(cpu_of(rq));
+	scx_rq_clock_update(rq, clock);
 
-	delta = sched_clock_cpu(cpu_of(rq)) - rq->clock;
+	delta = clock - rq->clock;
 	if (delta < 0)
 		return;
 	rq->clock += delta;
+
 	update_rq_clock_task(rq, delta);
 }
 
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7fff1d045477..ac279a657d50 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2928,6 +2928,8 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	if (SCX_HAS_OP(running) && (p->scx.flags & SCX_TASK_QUEUED))
 		SCX_CALL_OP_TASK(SCX_KF_REST, running, p);
 
+	scx_rq_clock_stale(rq);
+
 	clr_task_runnable(p, true);
 
 	/*
@@ -3590,6 +3592,7 @@ void __scx_update_idle(struct rq *rq, bool idle)
 {
 	int cpu = cpu_of(rq);
 
+	scx_rq_clock_stale(rq);
 	if (SCX_HAS_OP(update_idle) && !scx_rq_bypassing(rq)) {
 		SCX_CALL_OP(SCX_KF_REST, update_idle, cpu_of(rq), idle);
 		if (!static_branch_unlikely(&scx_builtin_idle_enabled))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index da55b39c9e58..7d26731c350f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1779,7 +1779,7 @@ static inline void rq_unpin_lock(struct rq *rq, struct rq_flags *rf)
 	if (rq->clock_update_flags > RQCF_ACT_SKIP)
 		rf->clock_update_flags = RQCF_UPDATED;
 #endif
-
+	scx_rq_clock_stale(rq);
 	lockdep_unpin_lock(__rq_lockp(rq), rf->cookie);
 }
 
-- 
2.47.1


