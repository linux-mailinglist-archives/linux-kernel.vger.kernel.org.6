Return-Path: <linux-kernel+bounces-353876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E7C9933EC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 18:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F6E285701
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA891DD52B;
	Mon,  7 Oct 2024 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kU3uOOxT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vLf79YYx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33BC1DC745
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 16:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319802; cv=none; b=ECJlAJsY2Ve1e4V4smyzT2mESMsRsXYJ1rwEDMqFVWmRhvFFend9XV11oIGG8EoookYl6YNGwNxULkVt23Lg0b2v0+Y59nU+cvehkXDpJvX3rr06tDcO6y3yyFBjBfJeyGQVyK3Vlrq94wLhxQ3XazrN3KnZXyUtjFESSuKYRlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319802; c=relaxed/simple;
	bh=dNGVc4bYaNKNEvCSBdFCpq1aOrxV8/ArUQ6Icm0wUQ4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=Rtxc9jmgBFsDRLEGjNfSZ8e9nLEp7TC4LLO/cIuleWOBypzXx9zCcgXMw1qzHlIbkBbuY2EnKhHfk94GLz8k/SpJ0V9ihwuGv13sVIiuRtHHiSbdX8QE978j7WRai+g/E1MldUApGj530NeBGXnDp+apJSqNIGSFIsPyNslqSIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kU3uOOxT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vLf79YYx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20241007164913.326834268@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728319798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=NzOkvYQgrh58j6+yH6duWn05tqHa4WhiuqidyYO6bOY=;
	b=kU3uOOxTAQleQYG85E0qxa+Pn0hwlabW+kxAUlNWfwgsiALnmJyqFTJx/qE2tKd/7gVLzU
	my4l/idtWobv3+J/Mvyk38TIoloRrpt9MejxBrb4E1/OCohfI20A+EjK0S6E2EJGw5QklA
	gl02Va0sq3JiQL0M2GTuoqPJEXiMaMu4bLMpg7oQQXTTP+ORMqRPZYkXPN328YRXvNy8GN
	ImRFcm8GwhedA5QxcvIjX84aBb4lEWi9w77OGKTO28I4O1INFSYXNpgjjOqAX0eaUy2sKU
	05QQN8tY5UXXw42SA9cBfnU2MYNO6aFgxhNdvB166hZYfHdqA221rdtbr6rOwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728319798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=NzOkvYQgrh58j6+yH6duWn05tqHa4WhiuqidyYO6bOY=;
	b=vLf79YYxNSScHjNhamjUmH1b0IM2FjoQx6/rkCQ4gQ9ElxCoxzGrM9oFbzS2t83LbB3trx
	UZqcRlmDyV2M2HDQ==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Zhen Lei <thunder.leizhen@huawei.com>,
 Waiman Long <longman@redhat.com>
Subject: [patch 06/25] debugobjects: Reuse put_objects() on OOM
References: <20241007163507.647617031@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon,  7 Oct 2024 18:49:58 +0200 (CEST)

Reuse the helper function instead of having a open coded copy.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 lib/debugobjects.c |   26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -429,7 +429,6 @@ static void free_object(struct debug_obj
 	}
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
 static void put_objects(struct hlist_head *list)
 {
 	struct hlist_node *tmp;
@@ -445,6 +444,7 @@ static void put_objects(struct hlist_hea
 	}
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
 static int object_cpu_offline(unsigned int cpu)
 {
 	/* Remote access is safe as the CPU is dead already */
@@ -456,31 +456,19 @@ static int object_cpu_offline(unsigned i
 }
 #endif
 
-/*
- * We run out of memory. That means we probably have tons of objects
- * allocated.
- */
+/* Out of memory. Free all objects from hash */
 static void debug_objects_oom(void)
 {
 	struct debug_bucket *db = obj_hash;
-	struct hlist_node *tmp;
 	HLIST_HEAD(freelist);
-	struct debug_obj *obj;
-	unsigned long flags;
-	int i;
 
 	pr_warn("Out of memory. ODEBUG disabled\n");
 
-	for (i = 0; i < ODEBUG_HASH_SIZE; i++, db++) {
-		raw_spin_lock_irqsave(&db->lock, flags);
-		hlist_move_list(&db->list, &freelist);
-		raw_spin_unlock_irqrestore(&db->lock, flags);
-
-		/* Now free them */
-		hlist_for_each_entry_safe(obj, tmp, &freelist, node) {
-			hlist_del(&obj->node);
-			free_object(obj);
-		}
+	for (int i = 0; i < ODEBUG_HASH_SIZE; i++, db++) {
+		scoped_guard(raw_spinlock_irqsave, &db->lock)
+			hlist_move_list(&db->list, &freelist);
+
+		put_objects(&freelist);
 	}
 }
 


