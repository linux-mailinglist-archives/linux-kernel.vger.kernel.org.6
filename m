Return-Path: <linux-kernel+bounces-532012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76427A4478C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 18:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E25C4188C6E4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7B11DFD96;
	Tue, 25 Feb 2025 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XIcfGlfL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L1Mx7pSF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D219D1A23AD
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503374; cv=none; b=o5ljidqg65e4iQ12Itm/VeeCirUO2LjFG5mW1q6fcCtGzWpyjbYqFcFxCpKeWRjOcO+azxNdER791Ta+I/xxiR1I0QwDXFGfLpZmX9Us8FSQbO2G2xYTMdQ4GnzDCicRuDhFD9JlSghnwKwKgHhncKECIxk+8bfIeGCW0zKGMoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503374; c=relaxed/simple;
	bh=wti/elsG0RUA51ZuaoWFp0gCHmZQuf9hhQuWRGremoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WmKhHrwBHjeVQR8ZL90nE8/LC9Dzr6kLsLKYD9gKrgCAd3GGJQv7ZVK6yaxHdjpIiSzw55Y5cnZcJabAgwA7DvnDPtIpOWnXtF8qkRHanlWdTeywAfaTvqNlJtYppjL4m0Ahsj3FgocpZ098i6weAzpJCBp+plNi2PEUSaB3WuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XIcfGlfL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L1Mx7pSF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740503363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NGxmewyhId8hTpegAx9z2qlG4UsFCP4k2p/HLIL5dR8=;
	b=XIcfGlfLP7/y6ekYjUcCidr3F6yKoYKKg6oLG0KB99XmSF44mzzlTERbKvvtO1Y269QakZ
	p9Oljcu8U6QvbnVPwglnOFLk3UGzPbBwZXDJmpma/m+70ddOP9ELwNOBFp/OQiVn4o04Dj
	zfIk6pFcIvs5zJfj205HL2nyID8QXX6jXudwdz7LLsrM+sPSSKyt9F6bDwf0ZY9Y3UXeMO
	7JTC6N7jYJbCD6BpWo3V7KO/z68stCTkR26g6RrET38sFC4hWDoX2GM3/iqa3TBNIIy864
	Ixup3CRBWw4AkaSo6DHwQfyzQ85BIImO2VH9xRiCzbhR3h3CpY+BA5nJdXSRTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740503363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NGxmewyhId8hTpegAx9z2qlG4UsFCP4k2p/HLIL5dR8=;
	b=L1Mx7pSFLkKChNb7XCKOoCf4zEov1BRmg8bYonPVAXdx+Nm6y84AgDLLnb1Ilx57wsfvR3
	TSRENU0m2+LtjXCw==
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
Subject: [PATCH v9 08/11] futex: Acquire a hash reference in futex_wait_multiple_setup().
Date: Tue, 25 Feb 2025 18:09:11 +0100
Message-ID: <20250225170914.289358-9-bigeasy@linutronix.de>
In-Reply-To: <20250225170914.289358-1-bigeasy@linutronix.de>
References: <20250225170914.289358-1-bigeasy@linutronix.de>
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
---
 kernel/futex/core.c     | 10 ++++++++++
 kernel/futex/futex.h    |  2 ++
 kernel/futex/waitwake.c | 21 +++++++++++++++++++--
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 239179e9ed9d5..b08bca2ed0342 100644
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
  * futex_hash - Return the hash bucket in the global or local hash
  * @key:	Pointer to the futex key for which the hash is calculated
@@ -152,6 +157,11 @@ struct futex_hash_bucket *__futex_hash(union futex_key=
 *key)
 	return &futex_queues[hash & (futex_hashsize - 1)];
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


