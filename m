Return-Path: <linux-kernel+bounces-513812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C256A34EF2
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:03:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C31216D4F6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D972661B8;
	Thu, 13 Feb 2025 20:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ebsMz1H/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002622661A7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739476974; cv=none; b=mcnxzaEyRP6vUs4dlDzfyREPRe98hq0hZDBpKxh/elTgZwCtP4R2oZ1kuq/t/hicF64AUFiegbzHFF9rcdgBI6O9zQRhrbQJ9vHMUJ9awZTLFNvYVSdAnxx2LgBVDifvKpCqvW7urOlLVG0z/YSwX5OkhVObvxQnIFP5gHLblOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739476974; c=relaxed/simple;
	bh=EUVQgYDdQvDpbP5AdqIWHackolUC0UTmiQ6+5AfhcxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqsccsqaXN/EywI2/GKs/wssPkAfjNE060uUHqARM2Adx/SUhVSR0Ih6wVT2iwuhkB1FNBWpK5oDk70duBYhqL6Epm1QleHXVxHVCnNl+70nqDQAT2a/gPkiBmbc8rkyXXquP/M1ezZKqjZ1rO7GxHQ2yi++5AyiFcrgyOGa4dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ebsMz1H/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739476971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jCz7+XdNeTmg0ywryfA79K8sDfbhrWMKHNAgiZbFNpE=;
	b=ebsMz1H/aCFoVz1mpPLHDVg82TpSr0VRnPdp+ML/ZpgeD/OaWYKQtatdQbL1ibEIkSjhvs
	7LBEP7hY7+8JMt+lHjWBoek+xHjQ3C4asiUbOQjei4YIPygk9Qc5B4gbK0QU9i93QmTHyX
	uXhUa6gXd3KL/wyll9bNq08U4CUHUKo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-433-SsxhO4IwMmWfG-T4-krdSQ-1; Thu,
 13 Feb 2025 15:02:47 -0500
X-MC-Unique: SsxhO4IwMmWfG-T4-krdSQ-1
X-Mimecast-MFC-AGG-ID: SsxhO4IwMmWfG-T4-krdSQ
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AB17619560BC;
	Thu, 13 Feb 2025 20:02:45 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.174])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 70E361800872;
	Thu, 13 Feb 2025 20:02:42 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will.deacon@arm.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Marco Elver <elver@google.com>
Cc: linux-kernel@vger.kernel.org,
	kasan-dev@googlegroups.com,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v4 2/4] locking/lock_events: Add locking events for lockdep
Date: Thu, 13 Feb 2025 15:02:26 -0500
Message-ID: <20250213200228.1993588-3-longman@redhat.com>
In-Reply-To: <20250213200228.1993588-1-longman@redhat.com>
References: <20250213200228.1993588-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Add some lock events to the lockdep for profiling its behavior.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lock_events_list.h | 7 +++++++
 kernel/locking/lockdep.c          | 8 +++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index 80b11f194c9f..9ef9850aeebe 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -88,3 +88,10 @@ LOCK_EVENT(rtmutex_slow_acq3)	/* # of locks acquired in *block()	*/
 LOCK_EVENT(rtmutex_slow_sleep)	/* # of sleeps				*/
 LOCK_EVENT(rtmutex_slow_wake)	/* # of wakeup's			*/
 LOCK_EVENT(rtmutex_deadlock)	/* # of rt_mutex_handle_deadlock()'s	*/
+
+/*
+ * Locking events for lockdep
+ */
+LOCK_EVENT(lockdep_acquire)
+LOCK_EVENT(lockdep_lock)
+LOCK_EVENT(lockdep_nocheck)
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 4470680f0226..8436f017c74d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -61,6 +61,7 @@
 #include <asm/sections.h>
 
 #include "lockdep_internals.h"
+#include "lock_events.h"
 
 #include <trace/events/lock.h>
 
@@ -170,6 +171,7 @@ static struct task_struct *lockdep_selftest_task_struct;
 static int graph_lock(void)
 {
 	lockdep_lock();
+	lockevent_inc(lockdep_lock);
 	/*
 	 * Make sure that if another CPU detected a bug while
 	 * walking the graph we dont change it (while the other
@@ -5091,8 +5093,12 @@ static int __lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	if (unlikely(lock->key == &__lockdep_no_track__))
 		return 0;
 
-	if (!prove_locking || lock->key == &__lockdep_no_validate__)
+	lockevent_inc(lockdep_acquire);
+
+	if (!prove_locking || lock->key == &__lockdep_no_validate__) {
 		check = 0;
+		lockevent_inc(lockdep_nocheck);
+	}
 
 	if (subclass < NR_LOCKDEP_CACHING_CLASSES)
 		class = lock->class_cache[subclass];
-- 
2.48.1


