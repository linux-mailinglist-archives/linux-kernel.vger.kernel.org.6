Return-Path: <linux-kernel+bounces-426910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9449DF9FD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 05:39:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E94281C8E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 04:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC75D1F8EE3;
	Mon,  2 Dec 2024 04:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIW/JS2X"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843761F8EE2
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 04:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733114351; cv=none; b=LWJoBQuWw3Xn5Qmsv2cyHvKrAXmF/NHP2kxagnxYRIjgUs6PQUb0qmHE5z+ZXcazESQIIXtNrH73lIss9tI5tk8m3dy9n7ymxCtvidb3mz+WW78fS8OR2IVuL2nZDc8wMyVgP7Kd23JS6yNMG/48cv1Y+z7jWo90HqwRY/fNLJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733114351; c=relaxed/simple;
	bh=LqVTHh10a/zWSmpfUFGG88RGCMLgEOiqgRiJBI5bTrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ST9fALcGWBkeFqwB3pwHagiaPdM66RVnqv2TMzSLVCvI42OhX5Ub6NlwAJkChWLbxuZeMi7mggxOwrsSs1yvkNT6/+GnzTyzpMKUPmCa/gg7BGTE6CTvCjwM/Q4LNWidTaVb5h5uGn4pifle1ghTDx/hpzZ8/hvotLtC8cBYD0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIW/JS2X; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e9ff7a778cso3428824a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 01 Dec 2024 20:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733114349; x=1733719149; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vgq4gZ3czszS9fpJ4ZhxgFfICr08ym8vUl7BLZh8zf0=;
        b=IIW/JS2XbOK5/OwIJTgplsqbTJMX3uRAyAzOqoIoXznjJEUbHvFFbBjqqe/BC4jU/i
         aXLHWxgpK7DyulnhGDBie4yPyiYxIaaxvI0y3VMFOIsEA21dwk11IQwDXcrgaU5jvyYJ
         J+BJEOStfCDWEB5tB3ultsFPCMzV6JX96clg4P8omIEt1BVfeduZjWuGlhYtZwpOXydx
         2oBwbE3udJEXPFYGGVUzHctFYkfEvhaVbUjefs3T9EUc4uk7oI2oG2BGdTMpCBtVbbJ8
         NxPXNykxknHHToVD9QZhxZ53El+DbMq2TR03CpMHQXp0WGt5HmyvyKetLAfpSczzo6O6
         khGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733114349; x=1733719149;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vgq4gZ3czszS9fpJ4ZhxgFfICr08ym8vUl7BLZh8zf0=;
        b=LOCSM4jkq+xPFzMKzjKu+Hfti+OPA6u8rpSd9YmNYHuYbKnnLujn7IRzcXDgKqJGOc
         o6dmp/KiruESO/5OMU13J+IU6damQIgudQkEPbXFrkDk7mRyyZdzT8JF/Q7R4qVR8aWD
         FG2v2b2mGvDbZp9tb9Iy67pqcf5NBwv67jNpBlqSbNvnlULwqgtIOHoggqDphxgry1hZ
         1OTKlc7bKl9y5rWyuf3+xS38TQnTEAQ0bFNRuyH3U6ewmQmldquZyTDd+/1eMO10tcZl
         /ncCNLS0rSNP9PhqoKkM9i9fYfXbNqnq8OG7CTVKYHlZ8i8kmCih4APGXqH46QDz06mc
         ITUA==
X-Forwarded-Encrypted: i=1; AJvYcCV2aceUUotZYSuknR96LKSRheRoGRr3BE8sPcLVU9SpTRLvM69XmH7oY+m92JtxppJ6B8X9VaPIIl31sFA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIcfGRbUneqUktvEOd2oA625nPgHAJMDm7u+9UPBWZXNzBqHLZ
	QHgN6H6/pDPkp1i6D24C36s8FpLXIZK1wpDcqA4MS3cehUAinzds
X-Gm-Gg: ASbGncuWd8kCRLs20bmQ9NeX0SgYHMwwjItQ1Ln46Tp8/GYLC24ZwwntW//caDUGXTX
	n00EkWnUwFcd2CYgRWmc5vFJwQQcgT+Z8v3XoxvbvcSkpz6S9tA+tEwl42yVw1y73LbMjJb/EIo
	qgYL3Gpkmz4LgV3telRN9Veyul1kfifxPW1uX2yVVaaMNMq5XFfs8IQ9H8z3dhm5NiG0k2WWRGc
	8u8RJm6PItHJDsIXNskQqZnOuoOAqfXKPeO7jXQNK6pjh6sMZW0PDh+2cQHSf/m0UrOAFePHdyT
	u8draA==
X-Google-Smtp-Source: AGHT+IGRQ6fVVNbSZFwSFFRJDNIY2lw6ABSXN9rG5RLxCnKGLO5WuqSwuygQarwP4BpqxcBxNe1QwQ==
X-Received: by 2002:a17:90b:3647:b0:2ee:7c22:6e7c with SMTP id 98e67ed59e1d1-2ee7c227f45mr12715840a91.13.1733114348786;
        Sun, 01 Dec 2024 20:39:08 -0800 (PST)
Received: from localhost ([58.29.143.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee2aff1f34sm7131146a91.5.2024.12.01.20.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Dec 2024 20:39:08 -0800 (PST)
From: Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To: tj@kernel.org,
	void@manifault.com,
	mingo@redhat.com,
	peterz@infradead.org
Cc: changwoo@igalia.com,
	kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] sched_ext: Manage the validity of scx_rq_clock
Date: Mon,  2 Dec 2024 13:38:46 +0900
Message-ID: <20241202043849.1465664-3-changwoo@igalia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241202043849.1465664-1-changwoo@igalia.com>
References: <20241202043849.1465664-1-changwoo@igalia.com>
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
index 09d5a64f78ce..1c1345274b02 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1766,7 +1766,7 @@ static inline void rq_unpin_lock(struct rq *rq, struct rq_flags *rf)
 	if (rq->clock_update_flags > RQCF_ACT_SKIP)
 		rf->clock_update_flags = RQCF_UPDATED;
 #endif
-
+	scx_rq_clock_stale(rq);
 	lockdep_unpin_lock(__rq_lockp(rq), rf->cookie);
 }
 
-- 
2.47.1


