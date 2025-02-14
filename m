Return-Path: <linux-kernel+bounces-515590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 651F1A36683
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 20:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F25A1897F3A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 19:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1326A1C8627;
	Fri, 14 Feb 2025 19:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UbMi2ujT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56281C8616
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 19:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562793; cv=none; b=AdwfqVLQT9KH+tC7vcHklLcvCqhwa16v1MZhsAdIAsL3NRYrAWA2Rf3BC/T79D77AYiIgRfwU9NqNGPDLsvGNvpWe7GhtufED3/NPuGpPO64kdxiuvjfqvh5TEuMELOKaTy6OM44hlhToUHMRNwQHRE5rUGqURECOV3q2YHWM7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562793; c=relaxed/simple;
	bh=bpqpbEg8UyVMcher6IVTMqGb7iTCJrB20DmRE7Iw29o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvJOZGUtLHlneh4i3oGa2axHr0NzNuKgsMVBidmiWNktSTev2pnBfrz1NqU0fdjzvgbIkZzsszMk1bqdJ4PsMAXlcr7/o4sDn4U/sI2Z297trxtASys2Myyc6DQkPyBwlwoqwV+STMFO3QXZrqsxJTEdWNi5lK/e/ojIJQUP87g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UbMi2ujT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739562790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v0A/F0sxY6CPbFBG1cOgr1XQMfWgjq/GMhonm5xEbAY=;
	b=UbMi2ujTzzumnUJ0qeRsxuCbcQbGLsWxsMpQvxxFW3e7zwSAZppxZjZn/Xj8rKGwI77cof
	gggIS0O/A4wumcKoDpP8HgI+pMo4NNvACTHRd5h9BmrBw1j2ApDwlCyY89mJRzjcywOv5T
	+Rf4hRcY19/WgWJMeF6wSp0kwgn97K8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-138-hiKAVQYcPD6OURKxGKIcvA-1; Fri,
 14 Feb 2025 14:53:09 -0500
X-MC-Unique: hiKAVQYcPD6OURKxGKIcvA-1
X-Mimecast-MFC-AGG-ID: hiKAVQYcPD6OURKxGKIcvA_1739562787
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 072CE18D95DC;
	Fri, 14 Feb 2025 19:53:07 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.89.30])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4749C1800874;
	Fri, 14 Feb 2025 19:53:03 +0000 (UTC)
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
Subject: [PATCH v4.1 4/4] locking/lockdep: Add kasan_check_byte() check in lock_acquire()
Date: Fri, 14 Feb 2025 14:52:42 -0500
Message-ID: <20250214195242.2480920-1-longman@redhat.com>
In-Reply-To: <20250213200228.1993588-1-longman@redhat.com>
References: <20250213200228.1993588-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

KASAN instrumentation of lockdep has been disabled as we don't need
KASAN to check the validity of lockdep internal data structures and
incur unnecessary performance overhead. However, the lockdep_map pointer
passed in externally may not be valid (e.g. use-after-free) and we run
the risk of using garbage data resulting in false lockdep reports.

Add kasan_check_byte() call in lock_acquire() for non kernel core data
object to catch invalid lockdep_map and print out a KASAN report before
any lockdep splat, if any.

Suggested-by: Marco Elver <elver@google.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/locking/lockdep.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 8436f017c74d..b15757e63626 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -57,6 +57,7 @@
 #include <linux/lockdep.h>
 #include <linux/context_tracking.h>
 #include <linux/console.h>
+#include <linux/kasan.h>
 
 #include <asm/sections.h>
 
@@ -5830,6 +5831,14 @@ void lock_acquire(struct lockdep_map *lock, unsigned int subclass,
 	if (!debug_locks)
 		return;
 
+	/*
+	 * As KASAN instrumentation is disabled and lock_acquire() is usually
+	 * the first lockdep call when a task tries to acquire a lock, add
+	 * kasan_check_byte() here to check for use-after-free and other
+	 * memory errors.
+	 */
+	kasan_check_byte(lock);
+
 	if (unlikely(!lockdep_enabled())) {
 		/* XXX allow trylock from NMI ?!? */
 		if (lockdep_nmi() && !trylock) {
-- 
2.48.1


