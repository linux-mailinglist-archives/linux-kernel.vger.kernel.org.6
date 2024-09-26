Return-Path: <linux-kernel+bounces-340650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AABD987645
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 17:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C10381F2892D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Sep 2024 15:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E1414A4DE;
	Thu, 26 Sep 2024 15:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGNgUEQ3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C61A60DCF
	for <linux-kernel@vger.kernel.org>; Thu, 26 Sep 2024 15:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727363614; cv=none; b=lIKsJ3GIqBiZkGHnXXqlWi12WdEQbjdmq16YDTswL4nghJmTaoDCHQqH6Mwh+SdAfPYHcsD3UvzqCilreVyK8UrpdhOsZsEKH6A03KCyBCT9eNZ32zybe7J3Py9E04of+BvbBFkkwDBZN2BXVmpdKav7HDz7CXN4Ar5X/d4iI7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727363614; c=relaxed/simple;
	bh=VgVZKBR+ShthNo9tWwwPYxFabzZPSMP/C2zc3AXerfI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GSRzPv19b5EtaAJhq5imonCGar9SdFDi3JZZWLhCQUfpUN4qNzJakcviAJBDq9OpZPKUG1T5fGw10FSaWtjJ44W1PD6k7CnZ8sNfQEjX+rpo3Jw5v7vEKoRaPqS1j/HWylLIHwEhecS9usQybMyR9MwtZJbPTnEPqb7F4+47qRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hGNgUEQ3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727363610;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HNVhyp3DiUzwqhlUAv5fpptFKCMzsQUkgeQCcaP9hDI=;
	b=hGNgUEQ38QJtrz6o7QOdMJbnd7c/Rc66GBFskhdfXdt0XZJENDDg52gQJNbV+f8v+0LPoN
	L3PbqJr459y+zbi6ftCCUTXi+jUwjgNtjd18A+C0O0dFfXbO6lPovKeHoZ/EXt/Wk/z1H/
	oanyPS9ycwYzjS+8Y6uG1WK3suSo38o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-608-X9k_sB6XMGCJKNdgUcfdfg-1; Thu,
 26 Sep 2024 11:13:26 -0400
X-MC-Unique: X9k_sB6XMGCJKNdgUcfdfg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C275218F38C6;
	Thu, 26 Sep 2024 15:13:25 +0000 (UTC)
Received: from llong.com (unknown [10.2.16.69])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 971A31954B0E;
	Thu, 26 Sep 2024 15:13:23 +0000 (UTC)
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
Subject: [PATCH] locking/rtmutex: Always use trylock in rt_mutex_trylock()
Date: Thu, 26 Sep 2024 11:13:15 -0400
Message-ID: <20240926151315.507905-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

One reason to use a trylock is to avoid a ABBA deadlock in case we need
to use a locking sequence that is not in the expected locking order. That
requires the use of trylock all the ways in the abnormal locking
sequence. Unfortunately, this is not the case for rt_mutex_trylock() as
it uses a raw_spin_lock_irqsave() to acquire the lock->wait_lock. That
will cause a lockdep splat like the following in a PREEMPT_RT kernel:

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
[   63.695708]        get_page_from_freelist+0x1d0/0xa00
[   63.695712]        __alloc_pages_noprof+0x19a/0x450
[   63.695716]        alloc_pages_mpol_noprof+0xaf/0x1e0
[   63.695721]        stack_depot_save_flags+0x4db/0x520
[   63.695727]        kasan_save_stack+0x3f/0x50
[   63.695731]        __kasan_record_aux_stack+0x8e/0xa0
[   63.695736]        task_work_add+0x1ad/0x240
[   63.695741]        sched_tick+0x1c7/0x500
[   63.695744]        update_process_times+0xf1/0x130
[   63.695750]        tick_nohz_handler+0xf7/0x230
[   63.695754]        __hrtimer_run_queues+0x13b/0x7b0
[   63.695758]        hrtimer_interrupt+0x1c2/0x350
[   63.695763]        __sysvec_apic_timer_interrupt+0xdb/0x340
[   63.695770]        sysvec_apic_timer_interrupt+0x9c/0xd0
[   63.695774]        asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   63.695780]        __asan_load8+0x8/0xa0
[   63.695784]        mas_wr_end_piv+0x28/0x2c0
[   63.695789]        mas_preallocate+0x3a8/0x680
[   63.695793]        vma_shrink+0x180/0x3f0
[   63.695799]        shift_arg_pages+0x219/0x2c0
[   63.695804]        setup_arg_pages+0x343/0x5e0
[   63.695807]        load_elf_binary+0x5ac/0x15d0
[   63.695813]        search_binary_handler+0x125/0x370
[   63.695818]        exec_binprm+0xc9/0x3d0
[   63.695821]        bprm_execve+0x103/0x230
[   63.695824]        kernel_execve+0x187/0x1c0
[   63.695828]        call_usermodehelper_exec_async+0x145/0x1e0
[   63.695832]        ret_from_fork+0x31/0x60
[   63.695836]        ret_from_fork_asm+0x1a/0x30
[   63.695840]
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


