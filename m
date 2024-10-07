Return-Path: <linux-kernel+bounces-353882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E7B9933F5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C39C1F245F8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D879A1DD9CD;
	Mon,  7 Oct 2024 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="46G04xuk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OYrjoKh3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F9D1DD9A3
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319809; cv=none; b=GY1mPbDctM+H7VdCJpgZ8pI5HIWN10NlshAe2CwZVPFTIierUY/FWVnNUrZNLToLbYXjJq+Vy287Lep2E4nISz2c9InTAlDR53nXwr9M46HqRAhH3kwOTeJ94Z6RD99nwuvJcpb/IO8Jd99LQrq8hx90ZztXUPmWloG5H9sgaA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319809; c=relaxed/simple;
	bh=PjgQRkzOq7ZOYamgeX2qnTV4RUfzvLmT7KF6nmn07+0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=rbjwDOksATPfDHfXooaTI2XoW2838WkSrNdh/cInCsqbFgvlyHOak1rAnLIhRETs2JLuJ9wdz0gVrMPOwBJtbpwAfILSasqWvEN9Xbv/+tjdk/7HgJ4lgkYoEgH5vcJk2AbGbIhxEZL3xTwbmyD9Lij5jteerOBHtImFdyiJk3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=46G04xuk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OYrjoKh3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241007164913.708939081@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728319806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=03yKkOdmGQrxY+R+fCwNxN1bQA9mKL+hWQ/PugmBeKQ=;
	b=46G04xuk+StWd4yiNgwOLPlonc8M+rcnKyZ1zp/WTAYJ9Y1XhytJgeSvTXrPLSGfZicY0b
	QkSEfhwofhhp3ypLP2T809fk1yzmj15/rbcAhmApnffPblWSUwEJXi9rCqv+4VCnO4ILTN
	fEpabdj/E6Y0OrCLwn6DGLahaliDVhijf0LAMkq4Fuit9XZXQk8HxYC4enJTxh3E5PV0Uv
	df/f9odu8QQgYEQbO7UrcFfYVrqSozwKRFTeoEeKtb/PGV8aaL47SBddI7CiLmanc8by02
	wN44Rj/Bf5+UXkL/cTgFpsSYPXDkugtBt4PA4UHDBR45TQx0bz780X3rSVmcaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728319806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=03yKkOdmGQrxY+R+fCwNxN1bQA9mKL+hWQ/PugmBeKQ=;
	b=OYrjoKh3Em/nXn/oyBg9hNa53Bcv4IU4oDY8+X50eIVfUKOzNZGGEbWNwQ7j13U/fZTzfC
	wyrYXGgGSpjk3yBQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
 Waiman Long <longman@redhat.com>
Subject: [patch 12/25] debugobjects: Use separate list head for boot pool
References: <20241007163507.647617031@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  7 Oct 2024 18:50:05 +0200 (CEST)

There is no point to handle the statically allocated objects during early
boot in the actual pool list. This phase does not require accounting, so
all of the related complexity can be avoided.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 lib/debugobjects.c |   28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -68,6 +68,8 @@ static DEFINE_RAW_SPINLOCK(pool_lock);
 static struct obj_pool		pool_global;
 static struct obj_pool		pool_to_free;
 
+static HLIST_HEAD(pool_boot);
+
 /*
  * Because of the presence of percpu free pools, obj_pool_free will
  * under-count those in the percpu free pools. Similarly, obj_pool_used
@@ -278,6 +280,9 @@ alloc_object(void *addr, struct debug_bu
 			percpu_pool->obj_free--;
 			goto init_obj;
 		}
+	} else {
+		obj = __alloc_object(&pool_boot);
+		goto init_obj;
 	}
 
 	raw_spin_lock(&pool_lock);
@@ -381,12 +386,14 @@ static void __free_object(struct debug_o
 	struct debug_obj *objs[ODEBUG_BATCH_SIZE];
 	struct debug_percpu_free *percpu_pool;
 	int lookahead_count = 0;
-	unsigned long flags;
 	bool work;
 
-	local_irq_save(flags);
-	if (!obj_cache)
-		goto free_to_obj_pool;
+	guard(irqsave)();
+
+	if (unlikely(!obj_cache)) {
+		hlist_add_head(&obj->node, &pool_boot);
+		return;
+	}
 
 	/*
 	 * Try to free it into the percpu pool first.
@@ -395,7 +402,6 @@ static void __free_object(struct debug_o
 	if (percpu_pool->obj_free < ODEBUG_POOL_PERCPU_SIZE) {
 		hlist_add_head(&obj->node, &percpu_pool->free_objs);
 		percpu_pool->obj_free++;
-		local_irq_restore(flags);
 		return;
 	}
 
@@ -410,7 +416,6 @@ static void __free_object(struct debug_o
 		percpu_pool->obj_free--;
 	}
 
-free_to_obj_pool:
 	raw_spin_lock(&pool_lock);
 	work = (pool_global.cnt > debug_objects_pool_size) && obj_cache &&
 	       (pool_to_free.cnt < ODEBUG_FREE_WORK_MAX);
@@ -455,7 +460,6 @@ static void __free_object(struct debug_o
 		}
 	}
 	raw_spin_unlock(&pool_lock);
-	local_irq_restore(flags);
 }
 
 /*
@@ -1341,10 +1345,9 @@ void __init debug_objects_early_init(voi
 	for (i = 0; i < ODEBUG_HASH_SIZE; i++)
 		raw_spin_lock_init(&obj_hash[i].lock);
 
+	/* Keep early boot simple and add everything to the boot list */
 	for (i = 0; i < ODEBUG_POOL_SIZE; i++)
-		hlist_add_head(&obj_static_pool[i].node, &pool_global.objects);
-
-	pool_global.cnt = ODEBUG_POOL_SIZE;
+		hlist_add_head(&obj_static_pool[i].node, &pool_boot);
 }
 
 /*
@@ -1372,10 +1375,11 @@ static bool __init debug_objects_replace
 	pool_global.cnt = ODEBUG_POOL_SIZE;
 
 	/*
-	 * Replace the statically allocated objects list with the allocated
-	 * objects list.
+	 * Move the allocated objects to the global pool and disconnect the
+	 * boot pool.
 	 */
 	hlist_move_list(&objects, &pool_global.objects);
+	pool_boot.first = NULL;
 
 	/* Replace the active object references */
 	for (i = 0; i < ODEBUG_HASH_SIZE; i++, db++) {


