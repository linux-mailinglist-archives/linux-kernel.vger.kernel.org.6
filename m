Return-Path: <linux-kernel+bounces-421578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93DB09D8D0C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 20:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54C9228CD33
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 19:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8E41CCEEC;
	Mon, 25 Nov 2024 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PyTYKlh9"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFA31C8FD6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 19:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732564336; cv=none; b=TbnJCmH0lM1pEq3Ii3+YSsk9LcpYgdHwr3b0y1KesJbl4kNKFvyHsCmum268vGKD61DEgyJ4NRziQC6Vwqqxnbu6fOI8QEolpAsUeWaNuM9UTf09PRd7DkIJqIxRnoWYB4+88zgAAi2U1zUGbuNCUMzN2Slp4IbFHD3BFm5toNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732564336; c=relaxed/simple;
	bh=M2SDcIOQuVxMIY2F55xh8D0sosZvE/g4I0hYYLIH2oM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SeKKOeqXmfAHA9J6i5Q0zhi0N6At5lhCnt1oLXK6KERIROchk+ajnGk0HBnETjCTt+QM99k1M/dHfFuIU4V7o2cPhqa2gMbqL682wnWEYfJ53TgcFpg2R5NPB01PUIC7EKTgJfNg4vSXzqdHiO3rRhNMzpnm6QQJ0IAZR6tmO8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PyTYKlh9; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-21147fea103so66660095ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 11:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732564333; x=1733169133; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DuS7non9bLiEZBdtAM6QuHjrqXfHHnVYgqWyiDCcd1A=;
        b=PyTYKlh9cZG85divNzLYEvJp+ksQqoQCVphkC62MbHGd3vFCLYCBrLS7rwYNzpGwBS
         0ctgYgDsZSwAPumbhBl0V8B6PAx1AHfsqcdscgBH/UgFs1LUxa5/vsXl0aNphpbawlIK
         eXyCWv4x1LNrI1FFEgL6UyJMDkuRMApml9lubWGAS/QkL6ua+I1MG8UT5L9Qz5q7CRqR
         alY6nxI/UDMi4pYHKaHVqtaiExNadl2c+7wqST28gZSm2fk/3erR3JHdkcjM4Vj2pneO
         tPdrKMVN5+7BC4UEqa2bDzHqspR7lQmp0Qvrnf9dLK/ijD1Z0WvDOUMbboLNZFZrLSLL
         jFeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732564333; x=1733169133;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DuS7non9bLiEZBdtAM6QuHjrqXfHHnVYgqWyiDCcd1A=;
        b=pjI+3JalNKgFkLIM2Euy61Lh9MXk1jqraw6w9K7NMHF/j1gJE6nT1LZWxSRVU1YHvO
         gy2Z2sIej6cq9RsDjBnhTfteCa/qR3agB5GuTf2UgbF5AcjyDv5MJK8rRYAfPM31G8WV
         Qfl27qt5gYV/YPAW2Q1lXPdW//kaeLggrDODgmXCVZwqgXNrcGvAGryVkJDSyQsPwzoW
         KZrCx4bZ2XmDEQiB+MZAkTtfh3gRbPX4UrkRI7wbdw7cP9argLMVwLu1A1H5WwebJnEl
         gG4JJskN6covnjtuQqBUW0Zb1IgRuLGOvS14eIA++CJQ0isCfZwQ6RbWirClRf3evu9c
         7vLg==
X-Gm-Message-State: AOJu0YwRfOjUwoc6RMUhGeVjqZU9ksTDkE29aJ7WJC7PoFufS7RZW6KS
	ZfR+P+nS6erv9EDNZLPXyCEquT5tSHJhZM/x8t5Qggy5wQjLoALLI8WQ530xzR6GfZaovtQObVs
	Hiv6gnTt7d1hV+X78s7VjUo/7zjdp3cqjvhQ5BRz/cqQciPQg2IkpxvMdW5mKgeVbyzcYaE51eN
	Snp7Ytc5s63RlIqkwx7359LBJ2PjZLJu3CwZVM06bhEqLG
X-Google-Smtp-Source: AGHT+IE3ZsuhtPJ/efOBhGni1a8MxByd57KWn1zoKuXK4FmRZF1mXB5+snAwLut9I7Ml3vhqR3vRy8yl4y0o
X-Received: from plgk8.prod.google.com ([2002:a17:902:ce08:b0:20f:ae59:441e])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f681:b0:20c:c631:d81f
 with SMTP id d9443c01a7336-2129f69245cmr159206635ad.21.1732564333217; Mon, 25
 Nov 2024 11:52:13 -0800 (PST)
Date: Mon, 25 Nov 2024 11:51:58 -0800
In-Reply-To: <20241125195204.2374458-1-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241125195204.2374458-1-jstultz@google.com>
X-Mailer: git-send-email 2.47.0.371.ga323438b13-goog
Message-ID: <20241125195204.2374458-5-jstultz@google.com>
Subject: [RFC][PATCH v14 4/7] sched: Fix psi_dequeue for Proxy Execution
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

Currently, if the sleep flag is set, psi_dequeue() doesn't
change any of the psi_flags.

This is because psi_switch_task() will clear TSK_ONCPU as well
as other potential flags (TSK_RUNNING), and the assumption is
that a voluntary sleep always consists of a task being dequeued
followed shortly there after with a psi_sched_switch() call.

Proxy Execution changes this expectation, as mutex-blocked tasks
that would normally sleep stay on the runqueue. In the case where
the mutex owning task goes to sleep, we will then deactivate the
blocked task as well.

However, in that case, the mutex-blocked task will have had
its TSK_ONCPU cleared when it was switched off the cpu, but it
will stay TSK_RUNNING. Then when we later dequeue it becaues of
a sleeping-owner, as it is sleeping psi_dequeue() won't change
any state (leaving it TSK_RUNNING), as it incorrectly expects a
psi_task_switch() call to immediately follow.

Later on when it get re enqueued, and psi_flags are set for
TSK_RUNNING, we hit an error as the task is already TSK_RUNNING:
  psi: inconsistent task state!

To resolve this, extend the logic in psi_dequeue() so that
if the sleep flag is set, we also check if psi_flags have
TSK_ONCPU set (meaning the psi_task_switch is imminient) before
we do the shortcut return.

If TSK_ONCPU is not set, that means we've already swtiched away,
and this psi_dequeue call needs to clear the flags.

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
v13:
* Reworked for collision
---
 kernel/sched/stats.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 8ee0add5a48a8..c313fe76a7723 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -176,8 +176,12 @@ static inline void psi_dequeue(struct task_struct *p, int flags)
 	 * avoid walking all ancestors twice, psi_task_switch() handles
 	 * TSK_RUNNING and TSK_IOWAIT for us when it moves TSK_ONCPU.
 	 * Do nothing here.
+	 * In the SCHED_PROXY_EXECUTION case we may do sleeping
+	 * dequeues that are not followed by a task switch, so check
+	 * TSK_ONCPU is set to ensure the task switch is imminent.
+	 * Otherwise clear the flags as usual.
 	 */
-	if (flags & DEQUEUE_SLEEP)
+	if ((flags & DEQUEUE_SLEEP) && (p->psi_flags & TSK_ONCPU))
 		return;
 
 	/*
-- 
2.47.0.371.ga323438b13-goog


