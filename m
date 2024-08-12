Return-Path: <linux-kernel+bounces-282971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D339894EB65
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:42:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870421F22C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC720175D2A;
	Mon, 12 Aug 2024 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q89qmv+V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PAqY91R4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD85C170828
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723459331; cv=none; b=Odjh5e8+xG+jwJGEKgoH8e+8kAF6P7OJQTEKI35nZr40oVjSRyWeLzaUAhte7Kcbt23SUBcMrZ5NmDBnww9yG7KSEjcdNX8bYoMxgybdD+m0FveuOUL3+ib+FPu1Y+SfhI/BcDJ4UqoYGlM9ivvkVEck/tyLuBiKyFnysFpGJHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723459331; c=relaxed/simple;
	bh=3YlCf+NMedo/zckHv+HKZtFLRIW9P7oYH0jrPJuPsjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O93Yq3xW86leS30nAW+fIXpVevvWsRwIdjskKoNdDghHFqFsmuDcxNfb21+AMOGCXBX08WWrctK5VAit2bNGT3w5VqVDs2YOC5PT0ep0tLkauE9FSLHhGsbtBxIKrz80Y+sDBN8ZcoI35IwFDBJl9wBR+FJModa/huVvREOysx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q89qmv+V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PAqY91R4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723459328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HjM0SVz4kOhTwFkccQW4pdtbDEZ+SXQVrvLOG1uKGio=;
	b=Q89qmv+VXxTqLVtX4/T44UE4ZxLlLXKVLBQ6u+mODYLH8vgTuOxlsp1BeUp1e1iY4o6DHb
	27B7TgLqHxwCQxNhg+qTyapAi6MTLjk4smOBeMbkomxbMZXylms0AdS2ta7FXMh6c1Gi0j
	WH2qM/Dwzg3w/xnkHmNPZlMGxfr28u/WEHD6n1Hyj105OON6odMuJ8QlRMuIjSR6qB9OP6
	0uJ3ARboAwOkdWqtzfj55XQw7MWaLtw4CN/Pp4GXZIOFly8TeMIsaPgXHj8VvPHE6tfINc
	D9VMajfaikJhnEd2+7k1113duI+6Cwm8bVf/fxw7eoq5/Pb5u71UeFX5HpkVYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723459328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HjM0SVz4kOhTwFkccQW4pdtbDEZ+SXQVrvLOG1uKGio=;
	b=PAqY91R49R2Se8/OJwSIjBb0SWEsbsgoWN3dDwRS6IVI/yYVo8BDWbAMx6uRSpLUXYB2Vr
	utC6xpqumLTguBCA==
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/4] locking/rt: Add sparse annotation for RCU.
Date: Mon, 12 Aug 2024 12:39:04 +0200
Message-ID: <20240812104200.2239232-4-bigeasy@linutronix.de>
In-Reply-To: <20240812104200.2239232-1-bigeasy@linutronix.de>
References: <20240812104200.2239232-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Every lock, that becomes a sleeping on PREEMPT_RT, starts a RCU read
section. There is no sparse annotation for this and sparse complains
about unbalanced locking.

Add __acquires/ __releases for the RCU lock. This covers all but the
trylock functions. I tried the __cond_acquires() annotation but it
didn't work.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/locking/spinlock_rt.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index 38e292454fccb..d1cf8b2b6dcac 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -51,7 +51,7 @@ static __always_inline void __rt_spin_lock(spinlock_t *lo=
ck)
 	migrate_disable();
 }
=20
-void __sched rt_spin_lock(spinlock_t *lock)
+void __sched rt_spin_lock(spinlock_t *lock) __acquires(RCU)
 {
 	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
 	__rt_spin_lock(lock);
@@ -75,7 +75,7 @@ void __sched rt_spin_lock_nest_lock(spinlock_t *lock,
 EXPORT_SYMBOL(rt_spin_lock_nest_lock);
 #endif
=20
-void __sched rt_spin_unlock(spinlock_t *lock)
+void __sched rt_spin_unlock(spinlock_t *lock) __releases(RCU)
 {
 	spin_release(&lock->dep_map, _RET_IP_);
 	migrate_enable();
@@ -225,7 +225,7 @@ int __sched rt_write_trylock(rwlock_t *rwlock)
 }
 EXPORT_SYMBOL(rt_write_trylock);
=20
-void __sched rt_read_lock(rwlock_t *rwlock)
+void __sched rt_read_lock(rwlock_t *rwlock) __acquires(RCU)
 {
 	rtlock_might_resched();
 	rwlock_acquire_read(&rwlock->dep_map, 0, 0, _RET_IP_);
@@ -235,7 +235,7 @@ void __sched rt_read_lock(rwlock_t *rwlock)
 }
 EXPORT_SYMBOL(rt_read_lock);
=20
-void __sched rt_write_lock(rwlock_t *rwlock)
+void __sched rt_write_lock(rwlock_t *rwlock) __acquires(RCU)
 {
 	rtlock_might_resched();
 	rwlock_acquire(&rwlock->dep_map, 0, 0, _RET_IP_);
@@ -246,7 +246,7 @@ void __sched rt_write_lock(rwlock_t *rwlock)
 EXPORT_SYMBOL(rt_write_lock);
=20
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-void __sched rt_write_lock_nested(rwlock_t *rwlock, int subclass)
+void __sched rt_write_lock_nested(rwlock_t *rwlock, int subclass) __acquir=
es(RCU)
 {
 	rtlock_might_resched();
 	rwlock_acquire(&rwlock->dep_map, subclass, 0, _RET_IP_);
@@ -257,7 +257,7 @@ void __sched rt_write_lock_nested(rwlock_t *rwlock, int=
 subclass)
 EXPORT_SYMBOL(rt_write_lock_nested);
 #endif
=20
-void __sched rt_read_unlock(rwlock_t *rwlock)
+void __sched rt_read_unlock(rwlock_t *rwlock) __releases(RCU)
 {
 	rwlock_release(&rwlock->dep_map, _RET_IP_);
 	migrate_enable();
@@ -266,7 +266,7 @@ void __sched rt_read_unlock(rwlock_t *rwlock)
 }
 EXPORT_SYMBOL(rt_read_unlock);
=20
-void __sched rt_write_unlock(rwlock_t *rwlock)
+void __sched rt_write_unlock(rwlock_t *rwlock) __releases(RCU)
 {
 	rwlock_release(&rwlock->dep_map, _RET_IP_);
 	rcu_read_unlock();
--=20
2.45.2


