Return-Path: <linux-kernel+bounces-282972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D621094EB66
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 12:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 150FC1C216CF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 10:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F0A175D2D;
	Mon, 12 Aug 2024 10:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nvxVVDey";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AkMPmLRu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13E1170849
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 10:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723459331; cv=none; b=YxbZ7o1Jj5OcyccnR5wm8PTrjJrowz5kjotJwK6+6TnFz+ZhssUVUyuvsTCs5RKCGSFp15r5Ql6khQxl4NiDHQEapn57COWTzECKxkD2k5nHPhvHPtI+kuNQJ1LBv+eN33gy90PoNUj5sfic+ALDuwOXLivLXHCcOhJAMpDaSoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723459331; c=relaxed/simple;
	bh=o4+8ORhhb5Y21RAzXkUl06n1R34xyy+UUpRzOGGKZ+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DGCYn8SB9AXG9RwSrxb2oUPBqR4V4YrZCJ6MinAs/0CdBkti+lg2dCopfSzTFP/PIiC4wDedPr07vQLFii/0IO+doTvviX6ytCxIs0v5DBJia+Se0x9EtvZ/jk0zURQdfFinCPuCh24OL8WnuEngXZ46FlFvUJZuaXSBjmNmhRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nvxVVDey; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AkMPmLRu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723459328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aqu+zvdYqrYNOg+n+RIMOdzPm3Y/ZxUaNwQty9rNRHw=;
	b=nvxVVDeyXDsl7iCaqZk6uQoosl9dSoINQ/qdd6jiLKUPyolagycvVdrC/K9uWHHEWm4ok2
	rOVJkYzMoSFg1PDmjNSvMrgqg+pNKuGfMkutuHdfM/AAPF6pOj2govCYRkAGN8adX5hdHf
	qmHnvSJHpdjzFNCHjpWUei5D8KEOxWf8nNeJUM5F/YfvuMf50PEA+h+o3SI7oKCKh9ds47
	rBzG+1/u3bXEkCTqDTWbn1rFf4JZBcEY5E6rfiTwJNo3k2zorV/rlcVs9e0nb+5z97OIAN
	oz+4Bs4Cwn1NShx26OHX6Gi9sX/8UrE/RP3J7JGKwncjN9e6J3Gwt5hrAT178w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723459328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aqu+zvdYqrYNOg+n+RIMOdzPm3Y/ZxUaNwQty9rNRHw=;
	b=AkMPmLRuIubd0nMzhD0v11HsvaZtd+kJ6uPVy4dA9d0aS592u77/OMHRFug7DPrS3Ns8AH
	9Psh/CLw9zlnl1AA==
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/4] locking/rt: Annotate unlock followed by lock for sparse.
Date: Mon, 12 Aug 2024 12:39:05 +0200
Message-ID: <20240812104200.2239232-5-bigeasy@linutronix.de>
In-Reply-To: <20240812104200.2239232-1-bigeasy@linutronix.de>
References: <20240812104200.2239232-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

rt_mutex_slowlock_block() and rtlock_slowlock_locked() both unlock
lock::wait_lock and then lock it later. This is unusual and sparse
complains about it.

Add __releases() + __acquires() annotation to mark that it is expected.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/locking/rtmutex.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 88d08eeb8bc03..e389078bddecb 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1601,6 +1601,7 @@ static int __sched rt_mutex_slowlock_block(struct rt_=
mutex_base *lock,
 					   unsigned int state,
 					   struct hrtimer_sleeper *timeout,
 					   struct rt_mutex_waiter *waiter)
+	__releases(&lock->wait_lock) __acquires(&lock->wait_lock)
 {
 	struct rt_mutex *rtm =3D container_of(lock, struct rt_mutex, rtmutex);
 	struct task_struct *owner;
@@ -1804,6 +1805,7 @@ static __always_inline int __rt_mutex_lock(struct rt_=
mutex_base *lock,
  * @lock:	The underlying RT mutex
  */
 static void __sched rtlock_slowlock_locked(struct rt_mutex_base *lock)
+	__releases(&lock->wait_lock) __acquires(&lock->wait_lock)
 {
 	struct rt_mutex_waiter waiter;
 	struct task_struct *owner;
--=20
2.45.2


