Return-Path: <linux-kernel+bounces-282970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E64794EB64
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36411F227E4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDC61741CB;
	Mon, 12 Aug 2024 10:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pnGqhcfg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yy/FdoPn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3D7170822
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723459331; cv=none; b=WVF81cLfEdU8WeMehgVUN4lJq33kLE8mueUhFp/iw5CJGDp1xo3YYjJFzpqDx63m6t5DDAgUBoeRZRJbe4zHlh1CweP3iSCZUJpzzYOkmarqAbNfuz/REPtYFZOGYXuAlJV9UZyAVdO3pMM173mJIWrMHVqRyr/Sj+AYhJtAPuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723459331; c=relaxed/simple;
	bh=VZsmijDKid7tM6bWHfJ2i17Rl/uZiaKRSPrRusNR354=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UtWjT4mseHmCHC93SoGY5NJZAIvwK6Km4S2b2weD2xgaNaZ3ZgXgotObAopa2dinO7iH3E/6Wxf2TwJ1Y9UbKM7c6yI2NpLDhW27Iho7t6i/RHDv0yiCPLQLtesg72c+SYZvnZOSH2gRbMXsXArM5Vtum5J/ggUzrpqlZ8P4yIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pnGqhcfg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yy/FdoPn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723459327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IK5+JoyiPBwiFxOBi7sh5IY29l1DPeZVngamdBZqWlE=;
	b=pnGqhcfgIiZBxBgSO1floZLDQxwb/ZGh8kLQS3z0MzvxvWVMpWLGCcIIuuy6FG3JppnV7Y
	/G6qKxNFHExJEIgEDh9sq2bSut+E7e9914p95ytudCKj4pSB13K/a1N0T507vmXU1eS9VR
	7iEEOD9YiW+YkHjWmmIlb1GHosrAkhE75A0Kco2szoz2Nvy1ZHCUT/rDKrQyBd2iseLhiY
	VWLIZFO64eXjkaDQLwC/RzdRM3GGMwJPKyLWqJbzuGt6tSsKDlCqCMcgqr8Pb/FdwtoGFJ
	L2drPrD0uOiq6zHLW3ZRZxQPqd3sE3GDc+L75i7yCXpSXoh8g0nd2VL5UVsVew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723459327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IK5+JoyiPBwiFxOBi7sh5IY29l1DPeZVngamdBZqWlE=;
	b=yy/FdoPn21b7isxdYGFY/7drcx4Ao49x4L07DelLdi2nIXZUSDEa8vyWCvbl9lwdHQc8nT
	SuR9a5xy6GopaWBQ==
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/4] locking/rt: Remove one __cond_lock() in RT's spin_trylock_irqsave()
Date: Mon, 12 Aug 2024 12:39:03 +0200
Message-ID: <20240812104200.2239232-3-bigeasy@linutronix.de>
In-Reply-To: <20240812104200.2239232-1-bigeasy@linutronix.de>
References: <20240812104200.2239232-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

spin_trylock_irqsave() has a __cond_lock() wrapper which points to
__spin_trylock_irqsave(). The function then invokes spin_trylock() which
has another __cond_lock() finally pointing to rt_spin_trylock().

The compiler has no problem to parse this but sparse does not recognise
that users of spin_trylock_irqsave() acquire a conditional lock and
complains.

Remove one layer of __cond_lock() so that sparse recognises conditional
locking.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/spinlock_rt.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index babc3e0287791..f9f14e135be7b 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -132,7 +132,7 @@ static __always_inline void spin_unlock_irqrestore(spin=
lock_t *lock,
 #define spin_trylock_irq(lock)				\
 	__cond_lock(lock, rt_spin_trylock(lock))
=20
-#define __spin_trylock_irqsave(lock, flags)		\
+#define spin_trylock_irqsave(lock, flags)		\
 ({							\
 	int __locked;					\
 							\
@@ -142,9 +142,6 @@ static __always_inline void spin_unlock_irqrestore(spin=
lock_t *lock,
 	__locked;					\
 })
=20
-#define spin_trylock_irqsave(lock, flags)		\
-	__cond_lock(lock, __spin_trylock_irqsave(lock, flags))
-
 #define spin_is_contended(lock)		(((void)(lock), 0))
=20
 static inline int spin_is_locked(spinlock_t *lock)
--=20
2.45.2


