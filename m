Return-Path: <linux-kernel+bounces-557980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B68BA5E00B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C954E174295
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26D925745F;
	Wed, 12 Mar 2025 15:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fqPgtx/S";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RabAcvFY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4438E253F32
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792608; cv=none; b=bo7IvVwL4z4VezNj4zruyCrYugHL4XaCAjHx1zNz7BliweEca0cZi39wwWB/ohkwRjYdTKcQ5G+mX/g0ICepySTUIuAz+p4kNt0s1HyvjV58sKI2Bobb65HpSI2GlneK6dSu5g7iT5mWzljBYSjP+rpUN0lQmSBictssXVqC3zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792608; c=relaxed/simple;
	bh=6Saf8+6zOJvJXTerUyM6/ulxWs8fDqg+gHh8MDFo338=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmPrDTJ6ESfKEVr7j3VX+7CRvc7Vt7SnZ9au+Dg2sb3RbX8a17XYcFhQYynoRFP9KDap/xjDDN8p7xSIBccbvNS0PlaDFhjxG1KAwrltIiNrYv+deujXj2AhWvb9VtLOgiNz6QfGUNRy/+Cl9nISwu37nzI3y7wKnCvrkI/dklg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fqPgtx/S; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RabAcvFY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741792603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wlPRd71QgRWcOngjZIbTVAwCSWBwEnHmUW8a2a4k+sI=;
	b=fqPgtx/S/NwCd93TX+o2UBYMhVNBzEbDYwWBtcQIy5bLfmsYY75h4kjoesGo1GgFCPZSZ7
	W/WFriEx7wk2rj1IIawjEbkOPa+gTohoDFntMdSVZnxJlPw2YQn5JUOl9rFLaVP+UMAEGk
	dMDLJNqDW5vBUHI5DIDFxoQzQBuyyr5WbstuU8sxPYvigy2QHw/1tmkiQIAxFskX2tYp8e
	dxuzMf2wb1M77tKYvAEL/U4TR14gmkEzFePniJ/nemYbfRnCJmR9sE7S2HUdaBF22jjTdt
	/QDEfYAqN44nN8q9DKARcay+mIpVTDqRlft4A89kC+jL7lWMHtcDSqWy2/vcHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741792603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wlPRd71QgRWcOngjZIbTVAwCSWBwEnHmUW8a2a4k+sI=;
	b=RabAcvFYiYSPFaeTOG15AoJvXw13G4q2+FFMR8r0RNnINEflyuHIIJhLH7gpmrYe+0cO/j
	zXr2p+fUfbVVXbCg==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v10 10/21] futex: Decrease the waiter count before the unlock operation.
Date: Wed, 12 Mar 2025 16:16:23 +0100
Message-ID: <20250312151634.2183278-11-bigeasy@linutronix.de>
In-Reply-To: <20250312151634.2183278-1-bigeasy@linutronix.de>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

To support runtime resizing of the process private hash, it's required
to not use the obtained hash bucket once the reference count has been
dropped. The reference will be dropped after the unlock of the hash
bucket.
The amount of waiters is decremented after the unlock operation. There
is no requirement that this needs to happen after the unlock. The
increment happens before acquiring the lock to signal early that there
will be a waiter. The waiter can avoid blocking on the lock if it is
known that there will be no waiter.
There is no difference in terms of ordering if the decrement happens
before or after the unlock.

Decrease the waiter count before the unlock operation.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex/core.c    | 2 +-
 kernel/futex/requeue.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 8561c41df7dc5..063d733181783 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -554,8 +554,8 @@ void futex_q_lock(struct futex_q *q, struct futex_hash_=
bucket *hb)
 void futex_q_unlock(struct futex_hash_bucket *hb)
 	__releases(&hb->lock)
 {
-	spin_unlock(&hb->lock);
 	futex_hb_waiters_dec(hb);
+	spin_unlock(&hb->lock);
 }
=20
 void __futex_queue(struct futex_q *q, struct futex_hash_bucket *hb,
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index 992e3ce005c6f..023c028d2fce3 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -456,8 +456,8 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flag=
s1,
 			ret =3D futex_get_value_locked(&curval, uaddr1);
=20
 			if (unlikely(ret)) {
-				double_unlock_hb(hb1, hb2);
 				futex_hb_waiters_dec(hb2);
+				double_unlock_hb(hb1, hb2);
=20
 				ret =3D get_user(curval, uaddr1);
 				if (ret)
@@ -542,8 +542,8 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flag=
s1,
 				 * waiter::requeue_state is correct.
 				 */
 			case -EFAULT:
-				double_unlock_hb(hb1, hb2);
 				futex_hb_waiters_dec(hb2);
+				double_unlock_hb(hb1, hb2);
 				ret =3D fault_in_user_writeable(uaddr2);
 				if (!ret)
 					goto retry;
@@ -556,8 +556,8 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flag=
s1,
 				 *   exit to complete.
 				 * - EAGAIN: The user space value changed.
 				 */
-				double_unlock_hb(hb1, hb2);
 				futex_hb_waiters_dec(hb2);
+				double_unlock_hb(hb1, hb2);
 				/*
 				 * Handle the case where the owner is in the middle of
 				 * exiting. Wait for the exit to complete otherwise
@@ -674,8 +674,8 @@ int futex_requeue(u32 __user *uaddr1, unsigned int flag=
s1,
 		put_pi_state(pi_state);
=20
 out_unlock:
-		double_unlock_hb(hb1, hb2);
 		futex_hb_waiters_dec(hb2);
+		double_unlock_hb(hb1, hb2);
 	}
 	wake_up_q(&wake_q);
 	return ret ? ret : task_count;
--=20
2.47.2


