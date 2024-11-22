Return-Path: <linux-kernel+bounces-418861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6CF9D6670
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Nov 2024 00:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 436E216111D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 23:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E3C18C920;
	Fri, 22 Nov 2024 23:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vzii+MXZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B71208A9
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 23:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732319302; cv=none; b=l3hjfO/Gy6oU3005gU9q5lm79Qi5/c3SQ3exs642C6hKBR1Mci/lTzXKLu4QrGygHoVKjQLBgloadVMxLyeBjU8TZ6zvbRXskEickgBNBv82lJnlSCD1cfLJskiE2XcrZbdO1JfqxsbaNOybC3RPUCe7cjHJoFToGwc4WIZMiIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732319302; c=relaxed/simple;
	bh=IRBJs9tzj/+j3tOOYYucW6hkcUxHD7siYOm5ePvU748=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h0A1At/tmwTTXkRiX5TbVKskyCe/f1S2lrj/8rjSOccDEO6Wh6h5bCCUKt/gczKFAHY5xnvWO/o9UieeNo7pWqwylr4P/9U44qKU3d2XH7XWvHSSXmz06hTRtg07PRfvDrWbjItYbxnTjcFI5OU7Nd39aygjLrt/1drdK9u49hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vzii+MXZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49298C4CECE;
	Fri, 22 Nov 2024 23:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732319302;
	bh=IRBJs9tzj/+j3tOOYYucW6hkcUxHD7siYOm5ePvU748=;
	h=From:To:Cc:Subject:Date:From;
	b=Vzii+MXZFTrx4N88lBp/DO9KCzr4+GLgG7lOsTuiWeB/8+k284VNvDwXbLBIpLmeo
	 zm98sHSy9ggbQXhfuXsq79HVhsVdMZaGrg42TfaR/sjLKZmy+pN0I7Xn4Jjw9QNpa5
	 Sf348/VVRr8OSf1dE3vmyV415Ww5uD9+9T4FUCoX0n2sB7I6oTgYz+PxDNSRTJ7dWW
	 O8LWULEVW1dAZAKWoucYYS48x5x5ACgvPQYyAT9p/ZmuC4rX0D2invaBxZeNYKTqVi
	 nvT+OQ6uu19RePN7WJwdPftvlu+dEXsnxBa3jm68bCWtCrL+hMrk2t3y5pYgKbqtvC
	 UTsPMl1OJpjYQ==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Anthony Mallet <anthony.mallet@laas.fr>
Subject: [PATCH] posix-timers: Target group sigqueue to current task only if not exiting
Date: Sat, 23 Nov 2024 00:48:11 +0100
Message-ID: <20241122234811.60455-1-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A sigqueue belonging to a posix timer, which target is not a specific
thread but a whole thread group, is preferrably targeted to the current
task if it is part of that thread group.

However nothing prevents a posix timer event from queueing such a
sigqueue from a reaped yet running task. The interruptible code space
between exit_notify() and the final call to schedule() is enough for
posix_timer_fn() hrtimer to fire.

If that happens while the current task is part of the thread group
target, it is proposed to handle it but since its sighand pointer may
have been cleared already, the sigqueue is dropped even if there are
other tasks running within the group that could handle it.

As a result posix timers with thread group wide target may miss signals
when some of their threads are exiting.

Fix this with verifying that the current task hasn't been through
exit_notify() before proposing it as a preferred target so as to ensure
that its sighand is still here and stable.

complete_signal() might still reconsider the choice and find a better
target within the group if current has passed retarget_shared_pending()
already.

Reported-by: Anthony Mallet <anthony.mallet@laas.fr>
Fixes: bcb7ee79029d ("posix-timers: Prefer delivery of signals to the current thread")
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/signal.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index 10b464b9d91f..7cdfb25d5078 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1958,14 +1958,15 @@ static void posixtimer_queue_sigqueue(struct sigqueue *q, struct task_struct *t,
  *
  * Where type is not PIDTYPE_PID, signals must be delivered to the
  * process. In this case, prefer to deliver to current if it is in
- * the same thread group as the target process, which avoids
- * unnecessarily waking up a potentially idle task.
+ * the same thread group as the target process and its sighand is
+ * stable, which avoids unnecessarily waking up a potentially idle task.
  */
 static inline struct task_struct *posixtimer_get_target(struct k_itimer *tmr)
 {
 	struct task_struct *t = pid_task(tmr->it_pid, tmr->it_pid_type);
 
-	if (t && tmr->it_pid_type != PIDTYPE_PID && same_thread_group(t, current))
+	if (t && tmr->it_pid_type != PIDTYPE_PID &&
+	    same_thread_group(t, current) && !current->exit_state)
 		t = current;
 	return t;
 }
-- 
2.46.0


