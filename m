Return-Path: <linux-kernel+bounces-370226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A392C9A2A52
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 19:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6EE0B2EEB1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 16:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA391DFDBB;
	Thu, 17 Oct 2024 16:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bVSJpQLT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C981DFDA1
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 16:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729183851; cv=none; b=agd+7VlIch0LpNel0IoIcBDgOiE0LjJdMnvzv78RoCaNNgsgP6pgVhoBpvNvplVeswiQargymA5QdwYeFzsAoqI+EJUpqb/RG8/wGVm02a43/ssJJ8RGZr+RA1e/zsvJULi/aNvBRgX6T6c5wPXz/rZ8WoqaJCvDO6DyXdQUjSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729183851; c=relaxed/simple;
	bh=ReHV9EcaEtqbsXSnw8gIYFjB+jlPXGkfJVT0049j+Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xfw7KvW3w4SXXhd0imCl5VnUknBdZQQdlUTT1FPDU/o2m60Xa2ORzbNuJ7JsTr3YmDKHtB0tBpW0IUdaxxvAsuF9PIAiuo8mJqpZ1xvZUJNAnE2PBhg/uHKVWquATxgFeM82c6FWROm8YOeUbf2XkROmhEcmCvPNbcTzHOzQiAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bVSJpQLT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71D5FC4CEC3;
	Thu, 17 Oct 2024 16:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729183850;
	bh=ReHV9EcaEtqbsXSnw8gIYFjB+jlPXGkfJVT0049j+Mk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bVSJpQLTFqZD4iOOy36hwPoW0SHeuNtI47ouUGvTzyX7No5t0ibxLNguYWtH7ion1
	 SJ/mt8ATWNsxkhBAKHVTgtD0mJOTGU8xfOsb0RM+c7DBdlBjqnYPRcMs+6ULJXDk1T
	 qIh24/8FQWJe0NpacMKc/DLsGC2tYoIe4bvDmW3+iAa6BnLemsg7NbSGvrWXYLaBoY
	 MsBOeF2Ch2wKrGw7Evg55QOa+z4Eo2WY9vGGse9kw+qD/g+h+4j/qbHJ5vJ+Wl3WTA
	 hXRsHPma2o4f/1rUklsAdLOUJHRtaaA0cXyx3GJeV06Tw4FY5Wofl10DO+Pw8+TrDp
	 wJiWUee2G83gA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: [PATCH 02/10] clockevents: Shutdown and unregister current clockevents at CPUHP_AP_TICK_DYING
Date: Thu, 17 Oct 2024 18:50:33 +0200
Message-ID: <20241017165041.6954-3-frederic@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241017165041.6954-1-frederic@kernel.org>
References: <20241017165041.6954-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The way the clockevent devices are finally stopped while a CPU is
offlining is currently chaotic. The layout being by order:

1) tick_sched_timer_dying() stops the tick and the underlying clockevent
  but only for oneshot case. The periodic tick and its related
  clockevent still runs.

2) tick_broadcast_offline() detaches and stops the per-cpu oneshot
  broadcast and append it to the released list.

3) Some individual clockevent drivers stop the clockevents (a second time if
  the tick is oneshot)

4) Once the CPU is dead, a control CPU remotely detaches and stops
  (a 3rd time if oneshot mode) the CPU clockevent and adds it to the
  released list.

5) The released list containing the broadcast device released on step 2)
   and the remotely detached clockevent from step 4) are unregistered.

These random events can be factorized if the current clockevent is
detached and stopped by the dying CPU at the generic layer, that is
from the dying CPU:

a) Stop the tick
b) Stop/detach the underlying per-cpu oneshot broadcast clockevent
c) Stop/detach the underlying clockevent
d) Release / unregister the clockevents from b) and c)
e) Release / unregister the remaining clockevents from the dying CPU.
   This part could be performed by the dying CPU

This way the drivers and the tick layer don't need to care about
clockevent operations during cpuhotplug down. This also unifies the tick
behaviour on offline CPUs between oneshot and periodic modes, avoiding
offline ticks altogether for sanity.

Adopt the simplification and verify no further clockevent can be
registered for the dying CPU after the final release.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/tick.h      |  2 --
 kernel/cpu.c              |  2 --
 kernel/time/clockevents.c | 33 ++++++++++++++-------------------
 3 files changed, 14 insertions(+), 23 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 72744638c5b0..b0c74bfe0600 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -20,12 +20,10 @@ extern void __init tick_init(void);
 extern void tick_suspend_local(void);
 /* Should be core only, but XEN resume magic and ARM BL switcher require it */
 extern void tick_resume_local(void);
-extern void tick_cleanup_dead_cpu(int cpu);
 #else /* CONFIG_GENERIC_CLOCKEVENTS */
 static inline void tick_init(void) { }
 static inline void tick_suspend_local(void) { }
 static inline void tick_resume_local(void) { }
-static inline void tick_cleanup_dead_cpu(int cpu) { }
 #endif /* !CONFIG_GENERIC_CLOCKEVENTS */
 
 #if defined(CONFIG_GENERIC_CLOCKEVENTS) && defined(CONFIG_HOTPLUG_CPU)
diff --git a/kernel/cpu.c b/kernel/cpu.c
index d293d52a3e00..895f3287e3f3 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1338,8 +1338,6 @@ static int takedown_cpu(unsigned int cpu)
 
 	cpuhp_bp_sync_dead(cpu);
 
-	tick_cleanup_dead_cpu(cpu);
-
 	/*
 	 * Callbacks must be re-integrated right away to the RCU state machine.
 	 * Otherwise an RCU callback could block a further teardown function
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 4af27994db93..4ac562ef7f40 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -452,6 +452,9 @@ void clockevents_register_device(struct clock_event_device *dev)
 {
 	unsigned long flags;
 
+	if (WARN_ON_ONCE(cpu_is_offline(raw_smp_processor_id())))
+		return;
+
 	/* Initialize state to DETACHED */
 	clockevent_set_state(dev, CLOCK_EVT_STATE_DETACHED);
 
@@ -618,39 +621,30 @@ void clockevents_resume(void)
 
 #ifdef CONFIG_HOTPLUG_CPU
 
-# ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 /**
- * tick_offline_cpu - Take CPU out of the broadcast mechanism
+ * tick_offline_cpu - Shutdown all clock events related
+ *                    to this CPU and take it out of the
+ *                    broadcast mechanism.
  * @cpu:	The outgoing CPU
  *
- * Called on the outgoing CPU after it took itself offline.
+ * Called by the dying CPU during teardown.
  */
 void tick_offline_cpu(unsigned int cpu)
-{
-	raw_spin_lock(&clockevents_lock);
-	tick_broadcast_offline(cpu);
-	raw_spin_unlock(&clockevents_lock);
-}
-# endif
-
-/**
- * tick_cleanup_dead_cpu - Cleanup the tick and clockevents of a dead cpu
- * @cpu:	The dead CPU
- */
-void tick_cleanup_dead_cpu(int cpu)
 {
 	struct clock_event_device *dev, *tmp;
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&clockevents_lock, flags);
+	raw_spin_lock(&clockevents_lock);
 
+	tick_broadcast_offline(cpu);
 	tick_shutdown(cpu);
+
 	/*
 	 * Unregister the clock event devices which were
-	 * released from the users in the notify chain.
+	 * released above.
 	 */
 	list_for_each_entry_safe(dev, tmp, &clockevents_released, list)
 		list_del(&dev->list);
+
 	/*
 	 * Now check whether the CPU has left unused per cpu devices
 	 */
@@ -662,7 +656,8 @@ void tick_cleanup_dead_cpu(int cpu)
 			list_del(&dev->list);
 		}
 	}
-	raw_spin_unlock_irqrestore(&clockevents_lock, flags);
+
+	raw_spin_unlock(&clockevents_lock);
 }
 #endif
 
-- 
2.46.0


