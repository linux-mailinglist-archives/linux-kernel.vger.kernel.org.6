Return-Path: <linux-kernel+bounces-232209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1DF591A512
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 13:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1132C1C22526
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 11:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D7D149C4A;
	Thu, 27 Jun 2024 11:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G8b6b1G8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r4E3ECDe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D256813C3C2
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 11:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719487609; cv=none; b=b/VyoWy4PKRcCG6yW1FmWTtlymlRXysGOG2Rf35Lw8tq85jy5I4omZSltetq/e2hwmKuYpHf3H/NJqz+GugOYGN7JaBWSSbpcpObMUUXBdk7IjkvS/DB/vDlOIwRQPMqI+5//jTErxcbKx2dj2jfplMeZKu7QQ3W/Wm5z63hOyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719487609; c=relaxed/simple;
	bh=p37ixO8Rona+hmXTW9entWpqzMPJSkoFXZUR5ZwrgVc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=TVvGwCW9oZM41HVI9lJHvXrJTreN2g52SJccWv4YR3vhvtH9XQvbp8WKwuOD5rbUE2h51ftsnVmexEO1k1ojFNkcbFzruhisFozK/FVVTE3NdS5pP7DZftrRj59BbIppvnyECRXyD67TGm9XmjpoAHGiba7Ny9wDywqWdkj3FZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G8b6b1G8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r4E3ECDe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719487600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=1OHSIImJE1dxlHsd3fYtQufYAiQO5t41s6YB+Huk/nE=;
	b=G8b6b1G8jnaJNlHPdXFW3BkmJUGb/h+Smkb4uiyPs900aceT+zB0zF+w5okFII0cAeikOj
	4Z5beOzFYIWi/OKPc+QSUyXTAGuvZ3iDorxairEPr+0zHw6O+j0mZyi7IaY/E0CPMTcppW
	4Odc9edFKIohDTyVeDERdUOMjcscmCTuVas/dBATxFzH6l5yE+n3bvpertP/RDosHY9cEm
	1f2vyYFurBuDxZmS4v80ys8b6+bGvLi0PSJuoaWzfJ/YqDNj8O8xpWuxwAKXpXbrt8HyHs
	D4D/yXVPwHlGXQZHNkU7j3S7PvDOMPjuBXMyDrwUldv96vz1qjnCYqS/12bCbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719487600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:  in-reply-to:in-reply-to;
	bh=1OHSIImJE1dxlHsd3fYtQufYAiQO5t41s6YB+Huk/nE=;
	b=r4E3ECDegEJiuzc34sdtBU2QdBrMw97BDb3CGpryB751tEBFN7jjza+ERsmlJMIdapy0IE
	Gb5p9S8MrxKV17Cw==
To: =?utf-8?B?5pyx5oG65Lm+?= <zhukaiqian@xiaomi.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?utf-8?B?546L6Z+s?=
 <lingyue@xiaomi.com>, =?utf-8?B?54aK5Lqu?= <xiongliang@xiaomi.com>,
 "isaacmanjarres@google.com" <isaacmanjarres@google.com>, Frederic
 Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>
Subject: Re: Race condition when replacing the broadcast timer
In-Reply-To: <042520850d394f0bb0004a226db63d0d@xiaomi.com>
Date: Thu, 27 Jun 2024 13:26:40 +0200
Message-ID: <87o77m1v9r.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26 2024 at 02:17, =E6=9C=B1=E6=81=BA=E4=B9=BE wrote:
> We find a possible race condition when replacing the broadcast
> timer. Here is how the race happend,

> 1. In thread 0, ___tick_broadcast_oneshot_control, timer 0 as a
> broadcast timer is updating the next_event.

> 2. In thread 1, tick_install_broadcast_device, timer 0 is going to be
> replaced by a new timer 1.

> 3. If thread 0 gets the broadcast timer first, it would have the old
> timer returned (timer 0). When thread 1 shuts the old timer down and
> marks it as detached, Thread 0 still have the chance to re-enable the
> old timer with a noop handler if it executes slower than thread 1.

> 4. As the old timer is binded to a CPU, when plug out that CPU, kernel
> fails at clockevents.c:653

Clearly tick_install_broadcast_device() lacks serialization.

The untested patch below should cure that.

Thanks,

        tglx
---
 kernel/time/clockevents.c    |   31 +++++++++++++++++++------------
 kernel/time/tick-broadcast.c |   36 ++++++++++++++++++++++--------------
 kernel/time/tick-internal.h  |    2 ++
 3 files changed, 43 insertions(+), 26 deletions(-)

--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -557,23 +557,14 @@ void clockevents_handle_noop(struct cloc
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
@@ -585,6 +576,22 @@ void clockevents_exchange_device(struct
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
+	if (old)
+		module_put(old->owner);
+	__clockevents_exchange_device(old, new);
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
+		module_put(old->owner);
=20
 	if (!(dev->features & CLOCK_EVT_FEAT_ONESHOT))
 		return;
@@ -1185,7 +1193,7 @@ int tick_broadcast_oneshot_active(void)
  */
 bool tick_broadcast_oneshot_available(void)
 {
-	struct clock_event_device *bc =3D tick_broadcast_device.evtdev;
+	struct clock_event_device *bc =3D READ_ONCE(tick_broadcast_device.evtdev);
=20
 	return bc ? bc->features & CLOCK_EVT_FEAT_ONESHOT : false;
 }
@@ -1193,7 +1201,7 @@ bool tick_broadcast_oneshot_available(vo
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

