Return-Path: <linux-kernel+bounces-283270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0D994EF61
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 16:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C04151F221F8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 14:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C6B17E455;
	Mon, 12 Aug 2024 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UDvcXxfZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y95j8LCk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2CA16B38D
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723472392; cv=none; b=gAEkZ7dgmt4IhM60ReK1UwAfSUa8XeAmGXzKTf5cHCQZGplubLiv5FWbwc0b1Dj2qbsLL1Tp5H9+HrxKNEtjFUaajnGvfHsFKZfD+TmRXkxzoySYVq4I4rq9kjTg0d0GnjdSn1i5lq0lCeJWsan+B9JubNMenS0WWo0VzPBmtOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723472392; c=relaxed/simple;
	bh=z7mATyb58JS5DN2gYqXThRA/83NR5+cciFk77ErE+R8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LyE3g8PlXRlvk3iePdqadj6cuQedcEgb0qNHWJXpW+6cdlywBJAFm/fRYpX7uQrOAaS9TtG7gjbhxF6U56lNSbE1fnCVrAieNlAU+5/FgMVElSEAZ9dO5FV+96uFjpt2xJgczF5Cw2gSL5xyPSPk9tgPnWhdcz/xDcoJHVuah5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UDvcXxfZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y95j8LCk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723472388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JxMPsYBXBNIUTSEIC6i3732bTRtL25D8Nj326RVTXFA=;
	b=UDvcXxfZQH1AzGzvhkt7i7t4yasmAaO7r28YRXC6NqBpphdqSQA+wGcoWaOwuJljvNh8LW
	aYrKdwGP/Xfq+cTmGfeV413fmrwRopaPwyaXVc/g8QVgZB3UJ1Dz8MkVwAk4OyvJd9RC2J
	OHWueFcjc7Le5bm4sSxpctV0ZBhGwWSWgcFG15W9ULH3J0QS1k8HsU52YooRx0j4w6zqMb
	DlU8Pemx+Ja6UQKDeAd+dBQ/QLyCLoCec/8OoVUnWeWrjLUl8jilffEwPiMtEuL7RlQ9k/
	2c1G+3JI6X4Y9SXnsPpEqZYVfHBP0nwVZElWIgiJWPm72AgYa/eTOCH1z98ucA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723472388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JxMPsYBXBNIUTSEIC6i3732bTRtL25D8Nj326RVTXFA=;
	b=y95j8LCkl7MgXp633xRFrsrnlhjetWpZnCRtDmJtEoxtNqvH7zt9OqWAyTfpf9ZAorLFdQ
	IgFGkCwi75gbS3CQ==
To: =?utf-8?B?5pyx5oG65Lm+?= <zhukaiqian@xiaomi.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>,
 =?utf-8?B?5byg5ZiJ5Lyf?= <zhangjiawei8@xiaomi.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?utf-8?B?546L6Z+s?=
 <lingyue@xiaomi.com>, =?utf-8?B?54aK5Lqu?= <xiongliang@xiaomi.com>,
 "isaacmanjarres@google.com" <isaacmanjarres@google.com>, Frederic
 Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, =?utf-8?B?5qKB5Lyf6bmP?=
 <weipengliang@xiaomi.com>, =?utf-8?B?57+B6YeR6aOe?=
 <wengjinfei@xiaomi.com>
Subject: [PATCH] tick/broadcast: Plug clockevents replacement race
In-Reply-To: <87frrs8lsg.ffs@tglx>
References: <042520850d394f0bb0004a226db63d0d@xiaomi.com>
 <87o77m1v9r.ffs@tglx> <b07f9746a58d46919b1600b22f5dff05@xiaomi.com>
 <835d5847-1aa0-4852-89c7-6a6996b3eb65@linaro.org>
 <bc1a086b932f454f9379c49221983675@xiaomi.com> <87o775uh0y.ffs@tglx>
 <87frrs8lsg.ffs@tglx>
Date: Mon, 12 Aug 2024 16:19:48 +0200
Message-ID: <87cymdsu0r.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=E6=9C=B1=E6=81=BA=E4=B9=BE reported and decoded the following race conditi=
on when a broadcast
device is replaced:

CPUA					CPUB
 __tick_broadcast_oneshot_control()
   bc =3D tick_broadcast_device.evtdev;
					tick_install_broadcast_device(dev)
        				clockevents_exchange_device(cur, dev)
					   shutdown(cur);
					   detach(cur);
					   cur->handler =3D noop;
					   tick_broadcast_device.evtdev =3D dev;

  tick_broadcast_set_event(bc, next_event); <- FAIL: arms a detached device.

If the original broadcast device has a restricted interrupt affinity mask
and the last CPU in that mask goes offline then the BUG() in
tick_cleanup_dead_cpu() triggers because the clockevent device is not in
detached state.

The reason for this is that tick_install_broadcast_device() is not
serialized vs. tick broadcast operations.

The obvious cure is to serialize tick_install_broadcast_device() with
tick_broadcast_lock against a concurrent tick broadcast operation.

That requires to split clockevents_exchange_device() into two parts, one
which does the exchange, shutdown and detach operation and the other which
drops the module reference count. This is required because the module
reference cannot be dropped while holding tick_broadcast_lock.

Let clockevents_exchange_device() do both operations as before, but let the
broadcast device code take the two step approach and do the device
exchange under tick_broadcast_lock and drop the module reference count
after releasing it.

Fixes: f8381cba04ba ("[PATCH] tick-management: broadcast functionality")
Reported-by: =E6=9C=B1=E6=81=BA=E4=B9=BE <zhukaiqian@xiaomi.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/clockevents.c    |   33 ++++++++++++++++++++-------------
 kernel/time/tick-broadcast.c |   36 ++++++++++++++++++++++--------------
 kernel/time/tick-internal.h  |    2 ++
 3 files changed, 44 insertions(+), 27 deletions(-)

--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -557,34 +557,41 @@ void clockevents_handle_noop(struct cloc
 {
 }
=20
-/**
- * clockevents_exchange_device - release and request clock devices
- * @old:	device to release (can be NULL)
- * @new:	device to request (can be NULL)
- *
- * Called from various tick functions with clockevents_lock held and
- * interrupts disabled.
- */
-void clockevents_exchange_device(struct clock_event_device *old,
-				 struct clock_event_device *new)
+void __clockevents_exchange_device(struct clock_event_device *old,
+				   struct clock_event_device *new)
 {
 	/*
 	 * Caller releases a clock event device. We queue it into the
 	 * released list and do a notify add later.
 	 */
 	if (old) {
-		module_put(old->owner);
 		clockevents_switch_state(old, CLOCK_EVT_STATE_DETACHED);
 		list_move(&old->list, &clockevents_released);
 	}
=20
 	if (new) {
-		BUG_ON(!clockevent_state_detached(new));
+		WARN_ON(!clockevent_state_detached(new));
 		clockevents_shutdown(new);
 	}
 }
=20
 /**
+ * clockevents_exchange_device - release and request clock devices
+ * @old:	device to release (can be NULL)
+ * @new:	device to request (can be NULL)
+ *
+ * Called from various tick functions with clockevents_lock held and
+ * interrupts disabled.
+ */
+void clockevents_exchange_device(struct clock_event_device *old,
+				 struct clock_event_device *new)
+{
+	__clockevents_exchange_device(old, new);
+	if (old)
+		module_put(old->owner);
+}
+
+/**
  * clockevents_suspend - suspend clock devices
  */
 void clockevents_suspend(void)
@@ -650,7 +657,7 @@ void tick_cleanup_dead_cpu(int cpu)
 		if (cpumask_test_cpu(cpu, dev->cpumask) &&
 		    cpumask_weight(dev->cpumask) =3D=3D 1 &&
 		    !tick_is_broadcast_device(dev)) {
-			BUG_ON(!clockevent_state_detached(dev));
+			WARN_ON(!clockevent_state_detached(dev));
 			list_del(&dev->list);
 		}
 	}
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -162,23 +162,31 @@ static bool tick_set_oneshot_wakeup_devi
  */
 void tick_install_broadcast_device(struct clock_event_device *dev, int cpu)
 {
-	struct clock_event_device *cur =3D tick_broadcast_device.evtdev;
+	struct clock_event_device *cur;
=20
-	if (tick_set_oneshot_wakeup_device(dev, cpu))
-		return;
+	scoped_guard(raw_spinlock_irqsave, &tick_broadcast_lock) {
=20
-	if (!tick_check_broadcast_device(cur, dev))
-		return;
+		if (tick_set_oneshot_wakeup_device(dev, cpu))
+			return;
=20
-	if (!try_module_get(dev->owner))
-		return;
+		cur =3D tick_broadcast_device.evtdev;
+		if (!tick_check_broadcast_device(cur, dev))
+			return;
=20
-	clockevents_exchange_device(cur, dev);
+		if (!try_module_get(dev->owner))
+			return;
+
+		__clockevents_exchange_device(cur, dev);
+		if (cur)
+			cur->event_handler =3D clockevents_handle_noop;
+		WRITE_ONCE(tick_broadcast_device.evtdev, dev);
+		if (!cpumask_empty(tick_broadcast_mask))
+			tick_broadcast_start_periodic(dev);
+	}
+
+	/* Module release must be outside of the lock */
 	if (cur)
-		cur->event_handler =3D clockevents_handle_noop;
-	tick_broadcast_device.evtdev =3D dev;
-	if (!cpumask_empty(tick_broadcast_mask))
-		tick_broadcast_start_periodic(dev);
+		module_put(cur->owner);
=20
 	if (!(dev->features & CLOCK_EVT_FEAT_ONESHOT))
 		return;
@@ -1209,7 +1217,7 @@ int tick_broadcast_oneshot_active(void)
  */
 bool tick_broadcast_oneshot_available(void)
 {
-	struct clock_event_device *bc =3D tick_broadcast_device.evtdev;
+	struct clock_event_device *bc =3D READ_ONCE(tick_broadcast_device.evtdev);
=20
 	return bc ? bc->features & CLOCK_EVT_FEAT_ONESHOT : false;
 }
@@ -1217,7 +1225,7 @@ bool tick_broadcast_oneshot_available(vo
 #else
 int __tick_broadcast_oneshot_control(enum tick_broadcast_state state)
 {
-	struct clock_event_device *bc =3D tick_broadcast_device.evtdev;
+	struct clock_event_device *bc =3D READ_ONCE(tick_broadcast_device.evtdev);
=20
 	if (!bc || (bc->features & CLOCK_EVT_FEAT_HRTIMER))
 		return -EBUSY;
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -53,6 +53,8 @@ static inline void clockevent_set_state(
 }
=20
 extern void clockevents_shutdown(struct clock_event_device *dev);
+extern void __clockevents_exchange_device(struct clock_event_device *old,
+					  struct clock_event_device *new);
 extern void clockevents_exchange_device(struct clock_event_device *old,
 					struct clock_event_device *new);
 extern void clockevents_switch_state(struct clock_event_device *dev,

