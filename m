Return-Path: <linux-kernel+bounces-411935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAFB9D017E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Nov 2024 00:48:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83B77B21BC9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 23:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71B4198831;
	Sat, 16 Nov 2024 23:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UCO0vxHw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF55219FF
	for <linux-kernel@vger.kernel.org>; Sat, 16 Nov 2024 23:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731800912; cv=none; b=FpwIYwLMQXX2o9OUp7XPC6RxeuzgC1GqNLa+tF7jtbjlvgaGhfEoxWFkkqDPe6TFfASXHdi3rObfUqrj10+FInd0rF+DpVhtQIUXzppYxSWP7tnvMuOx9w+P5KXGgRtUFDtfPyB3llun14rh2XDdTxKSY7LW/N3eVRqwojMiv8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731800912; c=relaxed/simple;
	bh=/8Q9v50cb3tWqVkZVKZ9WeEWxOVgp82X7xufnSizMMA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OLb2RyXc/OewO4MiUkgq1rgRYiMbxp4qzZbugivlxzU/xAUqcFkqvc1YU9wF5jdusejkFDh1+kRFZeGSrpRXJ5PfoqaYiin3ptfROPOxUR7UAGu4FHhpcKUcpI4xjkz3AGPc+YPbeJ34Uyr4WURjIJ64v++5tV5AcS2HbtzBm24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UCO0vxHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D3FC4CEC3;
	Sat, 16 Nov 2024 23:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731800911;
	bh=/8Q9v50cb3tWqVkZVKZ9WeEWxOVgp82X7xufnSizMMA=;
	h=From:To:Cc:Subject:Date:From;
	b=UCO0vxHwDIgegNCdtgeIMC2pcnb7pOwGtgal1QXyHnY1yGzWG/PhPy8/icFHSp800
	 Fk4QfH7JOC39aN8riGdu19OixIUv/MuwXjKSwa3oSDnvdLFhJnbg7FibeGSHUSmgg9
	 OS4ZBv/PK6DkRo5zqty8BYWuB9yvIWMeKrJEf7Bm/dN6hVY2L5ui1TdU2ZWExJKZ2J
	 KTSSPJT2RvzG7Cj4DPQKWZDN75qdcWIWiFPclxxy5157Vu/H9j5hNT7mtNXpVWdKSo
	 fbG29v9ZSgQfAOatJ0iJImuxhx5hlxWI9l65++c1c9SWKQyprn0J+WfQEidpN1HyNy
	 vhdjCmB5ZKAhA==
From: Frederic Weisbecker <frederic@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	hdanton@sina.com,
	syzbot+852e935b899bde73626e@syzkaller.appspotmail.com
Subject: [PATCH] posix-timers: Fix spurious warning on double enqueue VS do_exit()
Date: Sun, 17 Nov 2024 00:48:23 +0100
Message-ID: <20241116234823.28497-1-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A timer sigqueue may find itself already pending when it is tried to
be enqueued. This situation can happen if the timer sigqueue is enqueued
but then the timer is reset afterwards and fires before the pending
signal managed to be delivered.

However when such a double enqueue occurs while the corresponding signal
is ignored, the sigqueue is expected to be found either on the dedicated
ignored list if the timer was periodic or dropped if the timer was
one-shot. In any case it is not supposed to be queued on the real signal
queue.

An assertion verifies the latter expectation on top of the return value
of prepare_signal(), assuming "false" means that the signal is being
ignored. But prepare_signal() may also fail if the target is exiting as
the last task of its group. In this case the double enqueue observes the
sigqueue queued, as in such a situation:

    TASK A (same group as B)                   TASK B (same group as A)
    ------------------------                   ------------------------

    // timer event
    // queue signal to TASK B
    posix_timer_queue_signal()
    // reset timer through syscall
    do_timer_settime()
    // exit, leaving task B alone
    do_exit()
                                               do_exit()
                                                  synchronize_group_exit()
                                                      signal->flags = SIGNAL_GROUP_EXIT
                                                  // ========> <IRQ> timer event
                                                  posix_timer_queue_signal()
                                                  // return false due to SIGNAL_GROUP_EXIT
                                                  if (!prepare_signal())
                                                     WARN_ON_ONCE(!list_empty(&q->list))

And this spuriously triggers this warning:

    WARNING: CPU: 0 PID: 5854 at kernel/signal.c:2008 posixtimer_send_sigqueue
    CPU: 0 UID: 0 PID: 5854 Comm: syz-executor139 Not tainted 6.12.0-rc6-next-20241108-syzkaller #0
    RIP: 0010:posixtimer_send_sigqueue+0x9da/0xbc0 kernel/signal.c:2008
    Call Trace:
     <IRQ>
     alarm_handle_timer
     alarmtimer_fired
     __run_hrtimer
     __hrtimer_run_queues
     hrtimer_interrupt
     local_apic_timer_interrupt
     __sysvec_apic_timer_interrupt
     instr_sysvec_apic_timer_interrupt
     sysvec_apic_timer_interrupt
     </IRQ>

Fortunately the recovery code in that case already does the right thing:
just exit from posixtimer_send_sigqueue() and wait for __exit_signal()
to flush the pending signal. Just make sure to warn only the case when
the sigqueue is queued and the signal is really ignored.

Reported-and-tested-by: syzbot+852e935b899bde73626e@syzkaller.appspotmail.com
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/signal.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index cbf70c808969..10b464b9d91f 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2003,9 +2003,15 @@ void posixtimer_send_sigqueue(struct k_itimer *tmr)
 	if (!prepare_signal(sig, t, false)) {
 		result = TRACE_SIGNAL_IGNORED;
 
-		/* Paranoia check. Try to survive. */
-		if (WARN_ON_ONCE(!list_empty(&q->list)))
+		if (!list_empty(&q->list)) {
+			/*
+			 * If task group is exiting with the signal already pending,
+			 * wait for __exit_signal() to do its job. Otherwise if
+			 * ignored, it's not supposed to be queued. Try to survive.
+			 */
+			WARN_ON_ONCE(!(t->signal->flags & SIGNAL_GROUP_EXIT));
 			goto out;
+		}
 
 		/* Periodic timers with SIG_IGN are queued on the ignored list */
 		if (tmr->it_sig_periodic) {
-- 
2.46.0


