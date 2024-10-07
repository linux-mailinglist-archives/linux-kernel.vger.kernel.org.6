Return-Path: <linux-kernel+bounces-353692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8245993131
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 17:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832961F2248E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 15:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9420E1D8E1A;
	Mon,  7 Oct 2024 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ayRPP2BO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1521DDC9
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314997; cv=none; b=Yinx5LP9F/MEsU+9FHpGioP4Smdj8fsgsAufHoia2eaysaM36x4tCpLMmUt+BUn8ZXZTcQpv5kWbTZ8FeAem+1fg1EzGTO8rb7vmgTIUfA/DIDO3MTjJ5ogPcu78iTwQuJTF8Fyw0JbHnsozZ3jveOmgLlNSypsZ4XHZTHdXMhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314997; c=relaxed/simple;
	bh=BdC6/Eb5tLR1aE1RjpCPnR/DrqwirHLNBzx3xXufORg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XLWNDl44jzkHbg3vd00XVzqKlCk7x6OhdlZ2UjIZYMnnp4YxQLd85P8fBcAJJjxwE0qCd/2E+W6cerD8h9rPKYP8xb6kATeiX8hKRh68rFymyo5wml1RcTAIJeMd3oeBs321vQaV+ncHd21P8Hh+GOHA46oIGy4RlkbV2/kQ2b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ayRPP2BO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728314995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MtOwAVvuEnrMZfqZ36PLpitEO3nHndslOyukUer3z5U=;
	b=ayRPP2BO0h8MOolqlsEW4q0M6SZG/YI+HlsB/FWfWIBqZd9JxVOda2SAf7gi+fgrki+sFK
	yuJkZ+FCWt6TdLN6UGCl7E03BKPO5+4Jfoa5xFpH0Wt4EOyUahouCkl3I8qazywTX1FmbD
	EkZiaa2IoxfS8uuFOk6r0OmNvNvTh8I=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-209-aaIJ1ynjMF2y3lH25jY2Ag-1; Mon,
 07 Oct 2024 11:29:53 -0400
X-MC-Unique: aaIJ1ynjMF2y3lH25jY2Ag-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 368F61955EA7;
	Mon,  7 Oct 2024 15:29:52 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.16.200])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2E503300019E;
	Mon,  7 Oct 2024 15:29:49 +0000 (UTC)
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
Subject: [PATCH v3] locking/rtmutex: Always use trylock in rt_mutex_trylock()
Date: Mon,  7 Oct 2024 11:29:10 -0400
Message-ID: <20241007152910.29457-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

One reason to use a trylock is to avoid a ABBA deadlock in case we need
to use a locking sequence that is not in the expected locking order. That
requires the use of trylock all the ways in the abnormal locking
sequence. Unfortunately, this is not the case for rt_mutex_trylock() as
it uses a raw_spin_lock_irqsave() to acquire the lock->wait_lock.

There are just a few rt_mutex_trylock() call sites in the stock kernel.
For PREEMPT_RT kernel, however, all the spin_trylock() calls become
rt_mutex_trylock(). There are a few hundreds of them. So it will be a lot
easier to trigger a circular locking lockdep splat.

One particular instance where a circular locking lockdep splat happens
is for a v6.11 debug kernel with KASAN enabled.

   sched_tick() [ acquire rq->lock ]
   -> task_work_add()
    -> __kasan_record_aux_stack()
     -> kasan_save_stack()
      -> stack_depot_save_flags()
       -> alloc_pages_mpol_noprof()
        -> __alloc_pages_noprof()
	 -> get_page_from_freelist()
	  -> rmqueue()
	   -> rmqueue_pcplist()
	    -> rt_spin_trylock()
	     -> rt_mutex_slowtrylock()
	      -> _raw_spin_lock_irqsave() [ acquire wait_lock ]

[   63.695462] ======================================================
[   63.695464] WARNING: possible circular locking dependency detected
[   63.695467] 6.11.0-0.rc5.22.el10.x86_64+rt-debug #1 Not tainted
[   63.695470] ------------------------------------------------------
[   63.695473] modprobe/610 is trying to acquire lock:
[   63.695476] ff110007e9613058 (&lock->wait_lock){-...}-{2:2}, at: rt_mutex_slowtrylock+0x3f/0xb0
[   63.695495]
[   63.695495] but task is already holding lock:
[   63.695497] ff110007e96096d8 (&rq->__lock){-...}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0xc0

The rtmutex API has the locking dependency "&lock->wait_lock -->
&p->pi_lock". The scheduler code has the locking dependency "&p->pi_lock
--> &rq->__lock". As a result, there is a circular lock dependency.

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

Fix it by using raw_spin_trylock_irqsave() in rt_mutex_slowtrylock()
instead.

Fixes: 23f78d4a03c5 ("[PATCH] pi-futex: rt mutex core")
Signed-off-by: Waiman Long <longman@redhat.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
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
2.46.2


