Return-Path: <linux-kernel+bounces-513814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B55A0A34EF4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3835F7A4E0A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB82266B5F;
	Thu, 13 Feb 2025 20:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RltJGkhT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDEE2661A7
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739476979; cv=none; b=RWFzLZ1sRI0dXv3sMPzb+3fJ+rZ61NXRSC8rrGO/KAim8ogDStDV/Dot2T5eEfH3EaD66Zn/Jzjxv+1OIp0VAENM0GVLy7Ho/c+/vHNJm6Ty5iy+dmuVkcdDbQnWbwIBkFmRLYKtwuNxuoFj7gVED67u4D8iaocaZCzjxOxrYD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739476979; c=relaxed/simple;
	bh=nXCD/LXulwuMSZFXcozil2n1aFaawh8DejNvW9hLXYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ku8Jk/7VoBV5JcaJqmEWZvVWrmJKWwL7BNVOy4OFyGpiEqnpAPqFuyO/3M67MiJMBbtjbUvoke1Q3d5RXBGJvwxqv8tVc4ofzk6p3HaXkTpLvzi83UgBs2b7z0BlQkl66sl4ZzpFmZ04eAhW4CcUvmZh0uq5+vhQc1x8WRKo9Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RltJGkhT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739476976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oSXvIJINQIfUxBjAhkboBcPP4OyeZ0/nogoPQVNBBqQ=;
	b=RltJGkhTpd6vOP9JUIdzT90QbVHB8/HxRpBI8ib6aiSKUQ5SM6FXba3w1H15z0tOXti1mk
	z2vniJ5w1+8JqNGx+fUsa12ZT/BAVrLBpWy+BNZy9VisCUDJJl3kYb6jH62P1w/Yk7HS7Q
	S8YOho00juYK0qXOo7UbuGjoKAKGQaw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-FV_rQcKIPGaILACE79EL4g-1; Thu,
 13 Feb 2025 15:02:53 -0500
X-MC-Unique: FV_rQcKIPGaILACE79EL4g-1
X-Mimecast-MFC-AGG-ID: FV_rQcKIPGaILACE79EL4g
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 14C1B180087F;
	Thu, 13 Feb 2025 20:02:51 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.88.174])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B57FC1800358;
	Thu, 13 Feb 2025 20:02:48 +0000 (UTC)
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
Subject: [PATCH v4 4/4] locking/lockdep: Add kasan_check_byte() check in lock_acquire()
Date: Thu, 13 Feb 2025 15:02:28 -0500
Message-ID: <20250213200228.1993588-5-longman@redhat.com>
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

KASAN instrumentation of lockdep has been disabled as we don't need
KASAN to check the validity of lockdep internal data structures and
incur unnecessary performance overhead. However, the lockdep_map pointer
passed in externally may not be valid (e.g. use-after-free) and we run
the risk of using garbage data resulting in false lockdep reports. Add
kasan_check_byte() call in lock_acquire() for non kernel core data
object to catch invalid lockdep_map and abort lockdep processing if
input data isn't valid.

Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lock_events_list.h |  1 +
 kernel/locking/lockdep.c          | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/kernel/locking/lock_events_list.h b/kernel/locking/lock_events_list.h
index 9ef9850aeebe..bed59b2195c7 100644
--- a/kernel/locking/lock_events_list.h
+++ b/kernel/locking/lock_events_list.h
@@ -95,3 +95,4 @@ LOCK_EVENT(rtmutex_deadlock)	/* # of rt_mutex_handle_deadlock()'s	*/
 LOCK_EVENT(lockdep_acquire)
 LOCK_EVENT(lockdep_lock)
 LOCK_EVENT(lockdep_nocheck)
+LOCK_EVENT(lockdep_kasan_fail)
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 8436f017c74d..98dd0455d4be 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -57,6 +57,7 @@
 #include <linux/lockdep.h>
 #include <linux/context_tracking.h>
 #include <linux/console.h>
+#include <linux/kasan.h>
 
 #include <asm/sections.h>
 
@@ -5830,6 +5831,19 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	if (!debug_locks)
 		return;
 
+	/*
+	 * As KASAN instrumentation is disabled and lock_acquire() is usually
+	 * the first lockdep call when a task tries to acquire a lock, add
+	 * kasan_check_byte() here to check for use-after-free of non kernel
+	 * core lockdep_map data to avoid referencing garbage data.
+	 */
+	if (unlikely(IS_ENABLED(CONFIG_KASAN) &&
+		     !is_kernel_core_data((unsigned long)lock) &&
+		     !kasan_check_byte(lock))) {
+		lockevent_inc(lockdep_kasan_fail);
+		return;
+	}
+
 	if (unlikely(!lockdep_enabled())) {
 		/* XXX allow trylock from NMI ?!? */
 		if (lockdep_nmi() && !trylock) {
-- 
2.48.1


