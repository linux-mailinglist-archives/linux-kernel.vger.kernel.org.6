Return-Path: <linux-kernel+bounces-433824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5FE9E5D8E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 18:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6916128548A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 17:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F50224B04;
	Thu,  5 Dec 2024 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="UoKgMQCK"
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D112EB1F
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733420627; cv=none; b=ZuFGqIAwqZnRnrKrqtDKlvnf04r78gFcidRQU+pWSCnHjHB+84mXYp+HqRJz5KvAlmgLZL/Fn80irkSjWhZVQJ5MIQZ4hZ6FAZoPt35nlyJFr+AOtNbB8FTSERCLe5g+aDWn0kdM9w6frNaF/vdVCjq1qxcoJ3kWM+yJlfdzz2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733420627; c=relaxed/simple;
	bh=77dDWmhz9+vNNVwfh+cDg6E6bZYQGGhWOkzcSD89/no=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZmCaZClPeiZBpEKlMG2BLEbZVy5DvwzJCnONoOIgU2G5YdqAxAyNlLIT4dLweuomg445xml/K/fiXCvsnLETFO0gcZn4QrvpBOfDKcyKXmc/p5k0otcwoTwObsyHLO9WHDgNC3r7k0RHoAsxVpyZhAHISyZli2JZ6halM9s+akY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b=UoKgMQCK; arc=none smtp.client-ip=185.136.64.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20241205170322a7db41e085103b262e
        for <linux-kernel@vger.kernel.org>;
        Thu, 05 Dec 2024 18:03:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ziJSG6ctVi3hXuBtO97gjLaanzOcTvctskZW8qKtFqg=;
 b=UoKgMQCK3OZnoNoxk1GJ3f5UMqi0wKd5Hgy8yFKdTqcvOeGom2RqUa9OhYb9YHhH/JYK8J
 Ylhg5cCoSgtYoEnn/xC0Ucs+AEliU14rPmumoJizbabCyteDhx0FzLQSYs+e6c7gjNsEkhwi
 KqiGfTN21mGjeUOVzBT6RzWxDCjjfbld3kIZ60KCZX1HGfqwb6Ymou+DamEhygZHCPk+gv+b
 QpkNSXuTBD2ijFCTQZbgPLh8s5h9q/7vmrHAKm70ggGDrZz3Ie3NMklk/bL0sXIe3WqbqkR3
 g1LQdlHHlrfBNtYT4yi5sRggJT5SsfAYJjG3rhWgOenG1K+U26ggMYwg==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Adrian Freihofer <adrian.freihofer@siemens.com>
Subject: [PATCH] locking/spinlock/debug: Fix data-race in do_raw_write_lock
Date: Thu,  5 Dec 2024 18:01:29 +0100
Message-ID: <20241205170143.4105094-1-alexander.sverdlin@siemens.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

KCSAN reports:

BUG: KCSAN: data-race in do_raw_write_lock / do_raw_write_lock

write (marked) to 0xffff800009cf504c of 4 bytes by task 1102 on cpu 1:
 do_raw_write_lock+0x120/0x204
 _raw_write_lock_irq
 do_exit
 call_usermodehelper_exec_async
 ret_from_fork

read to 0xffff800009cf504c of 4 bytes by task 1103 on cpu 0:
 do_raw_write_lock+0x88/0x204
 _raw_write_lock_irq
 do_exit
 call_usermodehelper_exec_async
 ret_from_fork

value changed: 0xffffffff -> 0x00000001

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 1103 Comm: kworker/u4:1 6.1.111

Commit 1a365e822372 ("locking/spinlock/debug: Fix various data races") has
adressed most of these races, but seems to be not consistent/not complete.

From do_raw_write_lock() only debug_write_lock_after() part has been
converted to WRITE_ONCE(), but not debug_write_lock_before() part.
Do it now.

Fixes: 1a365e822372 ("locking/spinlock/debug: Fix various data races")
Reported-by: Adrian Freihofer <adrian.freihofer@siemens.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
There are still some inconsistencies remaining IMO:
- lock->magic is sometimes accessed with READ_ONCE() even though it's only
being plain-written;
- debug_spin_unlock() and debug_write_unlock() both do WRITE_ONCE() on
lock->owner and lock->owner_cpu, but examine them with plain read accesses.

 kernel/locking/spinlock_debug.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/locking/spinlock_debug.c b/kernel/locking/spinlock_debug.c
index 87b03d2e41dbb..2338b3adfb55f 100644
--- a/kernel/locking/spinlock_debug.c
+++ b/kernel/locking/spinlock_debug.c
@@ -184,8 +184,8 @@ void do_raw_read_unlock(rwlock_t *lock)
 static inline void debug_write_lock_before(rwlock_t *lock)
 {
 	RWLOCK_BUG_ON(lock->magic != RWLOCK_MAGIC, lock, "bad magic");
-	RWLOCK_BUG_ON(lock->owner == current, lock, "recursion");
-	RWLOCK_BUG_ON(lock->owner_cpu == raw_smp_processor_id(),
+	RWLOCK_BUG_ON(READ_ONCE(lock->owner) == current, lock, "recursion");
+	RWLOCK_BUG_ON(READ_ONCE(lock->owner_cpu) == raw_smp_processor_id(),
 							lock, "cpu recursion");
 }
 
-- 
2.47.1


