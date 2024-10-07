Return-Path: <linux-kernel+bounces-353872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 814389933E4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9F231C23752
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDF41DC1B4;
	Mon,  7 Oct 2024 16:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1vEf7qlL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D3w7uJPD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7446F1DB352
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319797; cv=none; b=D32Z6aKJkm6jgNyxH4fMcl9/JLWB9D65810HiKBCIYFPGqsTlGqLLTQQkn1S3iwG2vdvYwqOanFfJgKCjsMcNW97EnvTP35udM9WfLawc7Xkly3cotjxvbNGFyNE3sLkLefLv4rMF6FFLuTtaGNKnPYZVWwhfep/IqXI6tZMVmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319797; c=relaxed/simple;
	bh=DxyC468MIKBKRepgOYqobCuLab+7VZZ8uQul0v7O7v8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=gBhy5amRcKX7HLuh4gO4IItH1kHrspJ+62/tw5B3F0rOySzZZSbsPoVv6l870aw9D1oMqZQHeXwEpY8LK0MeN3DIs9nayrVp+hmeEIDAFHnGRe1kJ+FL5zen5SF5egn81HJwBP7RcWHQ+5D7+bb9+QvhK2ExXqu8oqFZpT1VqGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1vEf7qlL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D3w7uJPD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241007164913.073653668@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728319793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=mavBQBTQJ1+PBT60+7EBJrSCYznE7ddqxiJvXAlj+sw=;
	b=1vEf7qlLAaQO9cJSVc/+ikcdrtg+Z9VGqz//7c/tt5UWgaVCm9PKuY0nZmktp8gN7D7W6p
	Csyvo/gRgEX0D4F4EhSHK8PWzsoh6kngEN8uy94jAeq0hV+/Jz5BLfgtE9PpbMKd9n9ZOD
	A2CDjo9zUQ1R3FcG+43FzK2fSDiyz4ufwQxSwTgfY4WSqtCoFKYBO1k9l0BoNntXYaaij8
	zquqzVK+3zLVPUYYEDXxqIEFqiK8F0TCCv8IJOQ7S9GZQmMRqWjLCQdWRI598V8gUnAN1q
	hl2K/WFw726tdOYqcFSgmp4Rl4cwNSVu07n5JXHdNRW3QB9MhvCi9qMCYG1SeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728319793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=mavBQBTQJ1+PBT60+7EBJrSCYznE7ddqxiJvXAlj+sw=;
	b=D3w7uJPDosW5AcAtJP9qG70VmjfBW1tj1Sr4dyM8dFvJyP/+DZ+FygqVEIR5T+Hr6rzQKG
	9wf/a/scicx3I9Dw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
 Waiman Long <longman@redhat.com>
Subject: [patch 02/25] debugobjects: Collect newly allocated objects in a list
 to reduce lock contention
References: <20241007163507.647617031@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  7 Oct 2024 18:49:53 +0200 (CEST)

From: Zhen Lei <thunder.leizhen@huawei.com>

Collect the newly allocated debug objects in a list outside the lock, so
that the lock held time and the potential lock contention is reduced.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240911083521.2257-3-thunder.leizhen@huawei.com

---
 lib/debugobjects.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -161,23 +161,25 @@ static void fill_pool(void)
 		return;
 
 	while (READ_ONCE(obj_pool_free) < debug_objects_pool_min_level) {
-		struct debug_obj *new[ODEBUG_BATCH_SIZE];
+		struct debug_obj *new, *last = NULL;
+		HLIST_HEAD(head);
 		int cnt;
 
 		for (cnt = 0; cnt < ODEBUG_BATCH_SIZE; cnt++) {
-			new[cnt] = kmem_cache_zalloc(obj_cache, gfp);
-			if (!new[cnt])
+			new = kmem_cache_zalloc(obj_cache, gfp);
+			if (!new)
 				break;
+			hlist_add_head(&new->node, &head);
+			if (!last)
+				last = new;
 		}
 		if (!cnt)
 			return;
 
 		raw_spin_lock_irqsave(&pool_lock, flags);
-		while (cnt) {
-			hlist_add_head(&new[--cnt]->node, &obj_pool);
-			debug_objects_allocated++;
-			WRITE_ONCE(obj_pool_free, obj_pool_free + 1);
-		}
+		hlist_splice_init(&head, &last->node, &obj_pool);
+		debug_objects_allocated += cnt;
+		WRITE_ONCE(obj_pool_free, obj_pool_free + cnt);
 		raw_spin_unlock_irqrestore(&pool_lock, flags);
 	}
 }


