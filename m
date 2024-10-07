Return-Path: <linux-kernel+bounces-353889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4A6993403
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985841C2074C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0AF41DE3A5;
	Mon,  7 Oct 2024 16:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ALqW3Ajs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hAZEPf+d"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A881DDC21
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319817; cv=none; b=So00KbARvAIGh7fGJDH3U5vLbr2M2W16co88lnENSrDstUg/jXg8lvqXdZ/Fcy8zVGxEjxHOcC1TEjVGiKFyuckTRFR6hX8x/SvKli1ERysEnWtdkIIr1hZFqn6SXE8LFd7znOFtKVkNIl4vmLB/aNTpeVVlV5eLdPcvQ/HG71g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319817; c=relaxed/simple;
	bh=yXUwgX8jkz1jw+eUIpPrYKnGu4sx71nK1S57F3E70jc=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=J+QiUd9ci3whOdbVgVz1DEQKBBQK+Sp75jiqa3ahty4Ra3HhM5PU/72LIaGoVEPslkAm3d/c4v5HcHCmGYEGkZp5QNPPb2wOf0R4HiNu+5gA/Lh2rp702MjCGyDyFBDPZ01PbiEReSTFTkmiZ/U9lsoVgaVMuAgxMrb3vgC25Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ALqW3Ajs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hAZEPf+d; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241007164914.015906394@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728319812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=msOIqIj5y9aBSnK6QnRcLQeyJq+tPIAMJdXBn04Aajc=;
	b=ALqW3AjsumRSbCUtVML5FnoN8weMnnRKu06CFVdt69A/nxsuoopFAiNCi4zNgH8+2fs1gA
	7dwoSy2SUyHbaKBBb6hZI7beFOXY4It9v9UJBo16hkblDBtSu/a6Zu2TlpOSYxSDz50Q9H
	kI4T+Yr3UgtFxjTYhAECYiT3aHyjC7B+XGPDgT3ukA4LUHDkaCdArndzI9EHBpI0MqRktW
	i5e/HxCOgLxuqiizJjw7h00qDjd3W5wKRm+KWG/3Prr+v4q+6BhwcEPJ5lQgCDE3cP3S74
	+97qd0Bv/JxIMSb4H+iJVAhlprDkl2c62S0hTDLkLZ8owjpF7RmbsiHfLOogCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728319812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=msOIqIj5y9aBSnK6QnRcLQeyJq+tPIAMJdXBn04Aajc=;
	b=hAZEPf+dONWHP4mM7ERTBuBcw6pdD1veaZU+eIGoranmLCs7YJVbk7Re6uNmVBU7+xRqRw
	6xhRA5cDvNhAayCw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
 Waiman Long <longman@redhat.com>
Subject: [patch 17/25] debugobjects: Rework free_object_work()
References: <20241007163507.647617031@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  7 Oct 2024 18:50:12 +0200 (CEST)

Convert it to batch processing with intermediate helper functions. This
reduces the final changes for batch processing.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 lib/debugobjects.c |   80 +++++++++++++++++++++++++----------------------------
 1 file changed, 38 insertions(+), 42 deletions(-)

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -35,7 +35,7 @@
  * frequency of 10Hz and about 1024 objects for each freeing operation.
  * So it is freeing at most 10k debug objects per second.
  */
-#define ODEBUG_FREE_WORK_MAX	1024
+#define ODEBUG_FREE_WORK_MAX	(1024 / ODEBUG_BATCH_SIZE)
 #define ODEBUG_FREE_WORK_DELAY	DIV_ROUND_UP(HZ, 10)
 
 struct debug_bucket {
@@ -158,6 +158,21 @@ static bool pool_move_batch(struct obj_p
 	return true;
 }
 
+static bool pool_pop_batch(struct hlist_head *head, struct obj_pool *src)
+{
+	if (!src->cnt)
+		return false;
+
+	for (int i = 0; src->cnt && i < ODEBUG_BATCH_SIZE; i++) {
+		struct hlist_node *node = src->objects.first;
+
+		WRITE_ONCE(src->cnt, src->cnt - 1);
+		hlist_del(node);
+		hlist_add_head(node, head);
+	}
+	return true;
+}
+
 static struct debug_obj *__alloc_object(struct hlist_head *list)
 {
 	struct debug_obj *obj;
@@ -343,55 +358,36 @@ static struct debug_obj *alloc_object(vo
 	return obj;
 }
 
-/*
- * workqueue function to free objects.
- *
- * To reduce contention on the global pool_lock, the actual freeing of
- * debug objects will be delayed if the pool_lock is busy.
- */
+/* workqueue function to free objects. */
 static void free_obj_work(struct work_struct *work)
 {
-	struct debug_obj *obj;
-	unsigned long flags;
-	HLIST_HEAD(tofree);
+	bool free = true;
 
 	WRITE_ONCE(obj_freeing, false);
-	if (!raw_spin_trylock_irqsave(&pool_lock, flags))
+
+	if (!pool_count(&pool_to_free))
 		return;
 
-	if (pool_global.cnt >= pool_global.max_cnt)
-		goto free_objs;
+	for (unsigned int cnt = 0; cnt < ODEBUG_FREE_WORK_MAX; cnt++) {
+		HLIST_HEAD(tofree);
 
-	/*
-	 * The objs on the pool list might be allocated before the work is
-	 * run, so recheck if pool list it full or not, if not fill pool
-	 * list from the global free list. As it is likely that a workload
-	 * may be gearing up to use more and more objects, don't free any
-	 * of them until the next round.
-	 */
-	while (pool_to_free.cnt && pool_global.cnt < pool_global.max_cnt) {
-		obj = hlist_entry(pool_to_free.objects.first, typeof(*obj), node);
-		hlist_del(&obj->node);
-		hlist_add_head(&obj->node, &pool_global.objects);
-		WRITE_ONCE(pool_to_free.cnt, pool_to_free.cnt - 1);
-		WRITE_ONCE(pool_global.cnt, pool_global.cnt + 1);
-	}
-	raw_spin_unlock_irqrestore(&pool_lock, flags);
-	return;
-
-free_objs:
-	/*
-	 * Pool list is already full and there are still objs on the free
-	 * list. Move remaining free objs to a temporary list to free the
-	 * memory outside the pool_lock held region.
-	 */
-	if (pool_to_free.cnt) {
-		hlist_move_list(&pool_to_free.objects, &tofree);
-		WRITE_ONCE(pool_to_free.cnt, 0);
+		/* Acquire and drop the lock for each batch */
+		scoped_guard(raw_spinlock_irqsave, &pool_lock) {
+			if (!pool_to_free.cnt)
+				return;
+
+			/* Refill the global pool if possible */
+			if (pool_move_batch(&pool_global, &pool_to_free)) {
+				/* Don't free as there seems to be demand */
+				free = false;
+			} else if (free) {
+				pool_pop_batch(&tofree, &pool_to_free);
+			} else {
+				return;
+			}
+		}
+		free_object_list(&tofree);
 	}
-	raw_spin_unlock_irqrestore(&pool_lock, flags);
-
-	free_object_list(&tofree);
 }
 
 static void __free_object(struct debug_obj *obj)


