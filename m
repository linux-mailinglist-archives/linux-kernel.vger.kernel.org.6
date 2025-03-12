Return-Path: <linux-kernel+bounces-557982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF54CA5E00F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 16:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77036164AA9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 15:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B1D258CDF;
	Wed, 12 Mar 2025 15:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vfAZNY3I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bdxg+nTr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D514254854
	for <linux-kernel@vger.kernel.org>; Wed, 12 Mar 2025 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741792608; cv=none; b=hYAorFf5FkVVbAUZaJY3wyE79hSwPp0NP4i20C9Y4CVFDW/zVgx/z+czRjb44opCqPmf6CaQh8JP4ij/s9WpKvoeP6gEOSKvFAg6v52FWg1yg7xqWTu9JinOSJg4LVxom6XcOtXXb6ijlN1V5qSpMqBe41PtFAzt7Sf9jvgL6Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741792608; c=relaxed/simple;
	bh=sJE7kkM+ee6XzUfxK02b7HGBX7JN4uRjiQhi6eJ2Gdg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKZN8KDzxTXv3nxgS4UpElKVwRPS9FUKG5lSG4mZ8VyY3hgoy1F9dRC1F27NAjyH4dcZLcpNMfZusHEJ6+aPXqG4A/juEYNx0jBpOMqsiy2McQldVNTnATwIk0/GAo6sqQauygcpEGG4F38toxwgD6rbm2xnXgQR0546yK/9wQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vfAZNY3I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bdxg+nTr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741792603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8viNeFodPA9cABm3ztkM3eISgNmBGw4dLmTsZtJtTBk=;
	b=vfAZNY3IaTfXKIq4+fEdXkA4fwM3H3nZhKSCQRBVuCvUqwKEWu1K3WstEyNhg6yY7gXZfp
	VQ6DiqBNXHbZy0p5T0zkYjLxH2kouP4HzAQnQ9ECLxqrJQTB+m8kInH6+bXebBTjGZ7WYw
	NNzB/FPxDxXCmAqFJb3oYcbs4KsC2ftlXEJ+06i7UMPZayMI5j4M3kNdptpcSVYaBdC0mH
	4LzuiNWV/HxdE8hQ1S3QvhrRPgnEjpGjNL1sjBJ9FBvxsGO0XTIbb+SNYNcBcAMpDdtRP0
	/nVLiBg3DMkA/vZTkAuWj8n2eGfxWJCn7HdznZFkJq7k+RPsn/DdvTQVDEgw/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741792603;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8viNeFodPA9cABm3ztkM3eISgNmBGw4dLmTsZtJtTBk=;
	b=bdxg+nTrQ2TNGz7nr30HtqBkQbulHFevRBLzF3SywZ6EdCqItO1pWHK8nK06vIwrEW9FAl
	SubqvBbzR+ATHVDw==
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v10 12/21] futex: Acquire a hash reference in futex_wait_multiple_setup().
Date: Wed, 12 Mar 2025 16:16:25 +0100
Message-ID: <20250312151634.2183278-13-bigeasy@linutronix.de>
In-Reply-To: <20250312151634.2183278-1-bigeasy@linutronix.de>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

futex_wait_multiple_setup() changes task_struct::__state to
!TASK_RUNNING and then enqueues on multiple futexes. Every
futex_q_lock() acquires a reference on the global hash which is dropped
later.
If a rehash is in progress then the loop will block on
mm_struct::futex_hash_bucket for the rehash to complete and this will
lose the previously set task_struct::__state.

Acquire a reference on the local hash to avoiding blocking on
mm_struct::futex_hash_bucket.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/futex/core.c     | 10 ++++++++++
 kernel/futex/futex.h    |  2 ++
 kernel/futex/waitwake.c | 21 +++++++++++++++++++--
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 4d8912daffe83..700a24d796acb 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -129,6 +129,11 @@ static struct futex_hash_bucket *futex_hash_private(un=
ion futex_key *key,
 	return &fhb[hash & hash_mask];
 }
=20
+struct futex_private_hash *futex_get_private_hash(void)
+{
+	return NULL;
+}
+
 /**
  * futex_hash - Return the hash bucket in the global hash
  * @key:	Pointer to the futex key for which the hash is calculated
@@ -152,6 +157,11 @@ struct futex_hash_bucket *__futex_hash(union futex_key=
 *key)
 	return &futex_queues[hash & futex_hashmask];
 }
=20
+bool futex_put_private_hash(struct futex_private_hash *hb_p)
+{
+	return false;
+}
+
 /**
  * futex_hash_get - Get an additional reference for the local hash.
  * @hb:		    ptr to the private local hash.
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index e6f8f2f9281aa..0a76ee6e7dc10 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -206,6 +206,8 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleeper=
 *timeout,
 extern struct futex_hash_bucket *__futex_hash(union futex_key *key);
 extern void futex_hash_get(struct futex_hash_bucket *hb);
 extern void futex_hash_put(struct futex_hash_bucket *hb);
+extern struct futex_private_hash *futex_get_private_hash(void);
+extern bool futex_put_private_hash(struct futex_private_hash *hb_p);
=20
 DEFINE_CLASS(hb, struct futex_hash_bucket *,
 	     if (_T) futex_hash_put(_T),
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 44034dee7a48c..67eebb5b4b212 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -385,7 +385,7 @@ int futex_unqueue_multiple(struct futex_vector *v, int =
count)
 }
=20
 /**
- * futex_wait_multiple_setup - Prepare to wait and enqueue multiple futexes
+ * __futex_wait_multiple_setup - Prepare to wait and enqueue multiple fute=
xes
  * @vs:		The futex list to wait on
  * @count:	The size of the list
  * @woken:	Index of the last woken futex, if any. Used to notify the
@@ -400,7 +400,7 @@ int futex_unqueue_multiple(struct futex_vector *v, int =
count)
  *  -  0 - Success
  *  - <0 - -EFAULT, -EWOULDBLOCK or -EINVAL
  */
-int futex_wait_multiple_setup(struct futex_vector *vs, int count, int *wok=
en)
+static int __futex_wait_multiple_setup(struct futex_vector *vs, int count,=
 int *woken)
 {
 	bool retry =3D false;
 	int ret, i;
@@ -491,6 +491,23 @@ int futex_wait_multiple_setup(struct futex_vector *vs,=
 int count, int *woken)
 	return 0;
 }
=20
+int futex_wait_multiple_setup(struct futex_vector *vs, int count, int *wok=
en)
+{
+	struct futex_private_hash *hb_p;
+	int ret;
+
+	/*
+	 * Assume to have a private futex and acquire a reference on the private
+	 * hash to avoid blocking on mm_struct::futex_hash_bucket during rehash
+	 * after changing the task state.
+	 */
+	hb_p =3D futex_get_private_hash();
+	ret =3D __futex_wait_multiple_setup(vs, count, woken);
+	if (hb_p)
+		futex_put_private_hash(hb_p);
+	return ret;
+}
+
 /**
  * futex_sleep_multiple - Check sleeping conditions and sleep
  * @vs:    List of futexes to wait for
--=20
2.47.2


