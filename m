Return-Path: <linux-kernel+bounces-348144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776FE98E345
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FC1F1C2240F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 19:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827DD1C6F51;
	Wed,  2 Oct 2024 19:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fg7TAoVK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549701FDA
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 19:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727895720; cv=none; b=Oat0eHTn0tOrp6Tz7JjnfWfYL1AmROIOTuvx+FjBOrDDc37nZG5hGjow36+pcVjijYb/ucIHjuBjslcd9JUglojBG24UH1MOf1ExV/3OJLM1tJbZCHPnxlRJjx8RnoWSNm8M5xjsIwSWTDsWe4+CzTsB3VSqy9PvvfS40YWzLN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727895720; c=relaxed/simple;
	bh=0YpuzuNm/5gwqIww2lfObMwVdU/kQO9rVtoD5N2i/sY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RO5mFevbXtrZRlpJEy/pYn8kEHH1E5PejStrWoJjNIX2vQwm+b2kcUwkQlGJ+UOxd06UQyn+QQBHoHRJ4QsQ2TSr3+XGQDUC/YI5zi76Dqk2k/G3hUzpCaiR/mP5l5aMYDH4IxO3YqIMIYwFG/PwmRpYSVO8Uzl5ncMW4/q6be0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fg7TAoVK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727895718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hMYYQCKxP7S6WbOudBXIYw1Gz4a/IrKcHynA9x79jao=;
	b=fg7TAoVKvtSwM7MySYElgsH6DX4BcOlmKzbX4vriWu4URMMuxPG9XPBaFKGfy1fT//jTul
	Q67AmkAjNUz1ttYioNqQ2rgfk2JMciR/InMrv3K73m61URkIxkbuvt4FLL5tDvGwtkoAbE
	aGrFp6WAM3d9Go3ZOFphL9tbHDjIvIg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-7jiKwEeBMIe35Rxw1HaeLw-1; Wed,
 02 Oct 2024 15:01:55 -0400
X-MC-Unique: 7jiKwEeBMIe35Rxw1HaeLw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A675219560A7;
	Wed,  2 Oct 2024 19:01:53 +0000 (UTC)
Received: from llong.com (unknown [10.2.16.89])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AACD419560AD;
	Wed,  2 Oct 2024 19:01:51 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Luis Goncalves <lgoncalv@redhat.com>,
	Chunyu Hu <chuhu@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2] locking/rtmutex: Always use trylock in rt_mutex_trylock()
Date: Wed,  2 Oct 2024 15:01:08 -0400
Message-ID: <20241002190108.1115386-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

One reason to use a trylock is to avoid a ABBA deadlock in case we need
to use a locking sequence that is not in the expected locking order. That
requires the use of trylock all the ways in the abnormal locking
sequence. Unfortunately, this is not the case for rt_mutex_trylock() as
it uses a raw_spin_lock_irqsave() to acquire the lock->wait_lock.

There are just a few rt_mutex_trylock() call sites in the stock kernel.
For PREEMPT_RT kernel, however, all the spin_trylock() calls become
rt_mutex_trylock(). There are a few hundreds of them. So it will be a lot
easier to trigger a circular locking lockdep splat like the following.

[   63.695668] -> #0 (&lock->wait_lock){-...}-{2:2}:
[   63.695674]        check_prev_add+0x1bd/0x1310
[   63.695678]        validate_chain+0x6cf/0x7c0
[   63.695682]        __lock_acquire+0x879/0xf40
[   63.695686]        lock_acquire.part.0+0xfa/0x2d0
[   63.695690]        _raw_spin_lock_irqsave+0x46/0x90
[   63.695695]        rt_mutex_slowtrylock+0x3f/0xb0
[   63.695699]        rt_spin_trylock+0x13/0xc0
[   63.695702]        rmqueue_pcplist+0x5b/0x180
[   63.695705]        rmqueue+0xb01/0x1040
     :
[   63.695840] other info that might help us debug this:
[   63.695840]
[   63.695842] Chain exists of:
[   63.695842]   &lock->wait_lock --> &p->pi_lock --> &rq->__lock
[   63.695842]
[   63.695850]  Possible unsafe locking scenario:
[   63.695850]
[   63.695851]        CPU0                    CPU1
[   63.695852]        ----                    ----
[   63.695854]   lock(&rq->__lock);
[   63.695857]                                lock(&p->pi_lock);
[   63.695861]                                lock(&rq->__lock);
[   63.695864]   lock(&lock->wait_lock);
[   63.695868]
[   63.695868]  *** DEADLOCK ***

Fix it by using raw_spin_trylock_irqsave() instead.

Fixes: 23f78d4a03c5 ("[PATCH] pi-futex: rt mutex core")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/rtmutex.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index ebebd0eec7f6..a32bc2bb5d5e 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1381,10 +1381,13 @@ static int __sched rt_mutex_slowtrylock(struct rt_mutex_base *lock)
 		return 0;
 
 	/*
-	 * The mutex has currently no owner. Lock the wait lock and try to
-	 * acquire the lock. We use irqsave here to support early boot calls.
+	 * The mutex has currently no owner. Try to lock the wait lock first.
+	 * If successful, try to acquire the lock. We use irqsave here to
+	 * support early boot calls. Trylock is used all the way to avoid
+	 * circular lock dependency.
 	 */
-	raw_spin_lock_irqsave(&lock->wait_lock, flags);
+	if (!raw_spin_trylock_irqsave(&lock->wait_lock, flags))
+		return 0;
 
 	ret = __rt_mutex_slowtrylock(lock);
 
-- 
2.43.5


