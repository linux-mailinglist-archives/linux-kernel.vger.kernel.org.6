Return-Path: <linux-kernel+bounces-282969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D231594EB62
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F06F1F2281F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52857171E68;
	Mon, 12 Aug 2024 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qnnSw8ve";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JZycTMb1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D2616FF5F
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723459330; cv=none; b=oMShiJG1SxdlPeyimwly9gbt4PcZpKbsQtiRobCvNAtiE51K5Zz54n4AekEPh4II5+tRes3MJ+Dku8PHvxP1lojBcysnO18j8VSMj6PVa1LRf52JiKHQc0/sy3l8N/X2EAeJuE6PCx6CeA7q0ciaDyke8oCYHvFXKSMYwS+cBmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723459330; c=relaxed/simple;
	bh=4/Af0Ld7a8M7egpq5joT7M4CMURrpFr9NCOgulnJn4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CE5b8ZoE8d+7p81BszyUYgVLc9x7CsM1oNqZXhRZnBwmrPVt+TcFJkE7xYjoRjpcmd32j07u6mKUxqJ5F36pU4Yd+TDOSs+LxfP1Zsc4NAawhvvSD9NDEzDGh5XV26tWtgxLnC8DNK4WygXhC0g+hTYN59YEvsT7nQdB+Ny7T4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qnnSw8ve; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JZycTMb1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723459327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tXxiZ1HSlsfMpK9KfoV+2vAEQ7Qxc0sfPHhUxDuEOsA=;
	b=qnnSw8veRe6xMBV9unvIQE40hEEeeViF9Z9BMvBMlkl8WJBEkA5O4OpjC2DUs4DOqqXH2g
	XA1RkdIwFW3Xhhq2YRC27alnoeoVVJXP0iBincgt43sneKsOMvzDfebmzZVEQEvD0kpgaa
	X+WVAxfhwgB3SLPfaYBXOe9lf5TwGHTflAUOx791stq6530tzgykWgEPbv7B7L4uocNeqf
	I9prCZNmS4kaEHe3R9poBCAEYtZOWmHaiSfIb6vbNwbk2eR0gFpCUdo6G4ySOtINc5hl2T
	8K9wFNY8TSrhAYDJK8LthZkdCoNIXhKWS1VVoKVsQBG/R2buMOvYaJnB8howfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723459327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tXxiZ1HSlsfMpK9KfoV+2vAEQ7Qxc0sfPHhUxDuEOsA=;
	b=JZycTMb1Vr3zGEEDcnpVUQNJHS7vhyeMfGkDSzBEXgnWrdAdcCCqG4dwGRgOqWLiuKdKqi
	XE7IdARetDOm1FDg==
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/4] locking/rt: Add sparse annotation PREEMPT_RT's sleeping locks.
Date: Mon, 12 Aug 2024 12:39:02 +0200
Message-ID: <20240812104200.2239232-2-bigeasy@linutronix.de>
In-Reply-To: <20240812104200.2239232-1-bigeasy@linutronix.de>
References: <20240812104200.2239232-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The sleeping locks on PREEMPT_RT (rt_spin_lock() and friends) lack
sparse annotation. Therefore a missing spin_unlock() won't be spotted by
sparse in a PREEMPT_RT build while it is noticed on a !PREEMPT_RT build.

Add the __acquires/__releases macros to the lock/ unlock functions. The
trylock functions already use the __cond_lock() wrapper.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/rwlock_rt.h   | 10 +++++-----
 include/linux/spinlock_rt.h |  8 ++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/rwlock_rt.h b/include/linux/rwlock_rt.h
index 8544ff05e594d..7d81fc6918ee8 100644
--- a/include/linux/rwlock_rt.h
+++ b/include/linux/rwlock_rt.h
@@ -24,13 +24,13 @@ do {							\
 	__rt_rwlock_init(rwl, #rwl, &__key);		\
 } while (0)
=20
-extern void rt_read_lock(rwlock_t *rwlock);
+extern void rt_read_lock(rwlock_t *rwlock)	__acquires(rwlock);
 extern int rt_read_trylock(rwlock_t *rwlock);
-extern void rt_read_unlock(rwlock_t *rwlock);
-extern void rt_write_lock(rwlock_t *rwlock);
-extern void rt_write_lock_nested(rwlock_t *rwlock, int subclass);
+extern void rt_read_unlock(rwlock_t *rwlock)	__releases(rwlock);
+extern void rt_write_lock(rwlock_t *rwlock)	__acquires(rwlock);
+extern void rt_write_lock_nested(rwlock_t *rwlock, int subclass)	__acquire=
s(rwlock);
 extern int rt_write_trylock(rwlock_t *rwlock);
-extern void rt_write_unlock(rwlock_t *rwlock);
+extern void rt_write_unlock(rwlock_t *rwlock)	__releases(rwlock);
=20
 static __always_inline void read_lock(rwlock_t *rwlock)
 {
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index 61c49b16f69ab..babc3e0287791 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -32,10 +32,10 @@ do {								\
 	__rt_spin_lock_init(slock, #slock, &__key, true);	\
 } while (0)
=20
-extern void rt_spin_lock(spinlock_t *lock);
-extern void rt_spin_lock_nested(spinlock_t *lock, int subclass);
-extern void rt_spin_lock_nest_lock(spinlock_t *lock, struct lockdep_map *n=
est_lock);
-extern void rt_spin_unlock(spinlock_t *lock);
+extern void rt_spin_lock(spinlock_t *lock) __acquires(lock);
+extern void rt_spin_lock_nested(spinlock_t *lock, int subclass)	__acquires=
(lock);
+extern void rt_spin_lock_nest_lock(spinlock_t *lock, struct lockdep_map *n=
est_lock) __acquires(lock);
+extern void rt_spin_unlock(spinlock_t *lock)	__releases(lock);
 extern void rt_spin_lock_unlock(spinlock_t *lock);
 extern int rt_spin_trylock_bh(spinlock_t *lock);
 extern int rt_spin_trylock(spinlock_t *lock);
--=20
2.45.2


