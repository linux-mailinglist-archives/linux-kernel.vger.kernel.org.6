Return-Path: <linux-kernel+bounces-208173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6789021DD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 14:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B625B22AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1974B823CB;
	Mon, 10 Jun 2024 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1nEESOIn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7WWbIfT9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52967FBC3
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718023600; cv=none; b=Swo6klmopnCEeSKtBFgnWMP0Qs89KLpeg02s7ScTvBglGEmZq9LrZrH702/D+BKWMe+L/devwtPKG3IjnLj6ILzhFNqMSCEw4FLADWjv2lLALey14xiXxTwDyyLzHCjzoY8arY1G3M2iCQzUVnM7jq4mqp7ZkLkoZwZmfm1U1lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718023600; c=relaxed/simple;
	bh=T0rVGvr8LUnN2I6wnFzkd0Tr5pnWjtPzVfRQIF/iiMw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=kmu8ApIck/4YD/ga0RKCMzFs5t4FhVTUaaHsOe4xh2y0iqjcO64DmUwfV/YbBZCuEsJ0kmy1KlcLqsl9l0kxaGQZTc9cvgpEJA0lnOt8wXbSbrJspjHv0VIaYyVuYcyV4K6rMvMV7ZLSy2ab9X2wSjFg16kDKgzh2J+uboSVHwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1nEESOIn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7WWbIfT9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610124406.422897838@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718023596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=1pvZGI7LQe2pRVrv1BSniOl5jD1/WESX9RzOVXXK4i8=;
	b=1nEESOIn4k16C5y3euYo6+jNB3gqgCCamS8J7wyMdiYoKICUmXlb34xDjcvRv4SGdtwcft
	B6ICy6ADGIBf+NIJpOEibwCgMfK79tvijUl6De/PYvluQ/RwXpwK8/mDOXlZe6LA5arqXe
	QqbCmz999WKaR07A3dxKAyIZ0xmPPKq9WviUj6QES0LVeT5kVlO6g/EPT/2V/28q3u9pgA
	BVVRo0+QfoDYcKIm1lQ4DER2vG2bsol3NiKmSQBzwEMXx7+MO8PZHEmrI0n3kxsdoLDbnV
	K2ZKr6MvI9ZpTEpPfjcrPq5Qzq9Ew7Kq8Rb05w/8eeHubdqubzqGNAI19yvc8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718023596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=1pvZGI7LQe2pRVrv1BSniOl5jD1/WESX9RzOVXXK4i8=;
	b=7WWbIfT9Is15JgwTfm1VRsuaWLnyII+SrAkwQAPGeorvzLJYQzaobyrqy8XV4RM2Wim0up
	QEdrQQwukPv6PSDA==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Sam Sun <samsun1006219@gmail.com>,
 x86@kernel.org,
 syzkaller-bugs@googlegroups.com,
 xrivendell7@gmail.com
Subject: [patch 2/4] jump_label: Fix concurrency issues in
 static_key_slow_dec()
References: <87bk49xf15.ffs@tglx>
 <20240610124258.109097511@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 14:46:36 +0200 (CEST)

The commit which tried to fix the concurrency issues of concurrent
static_key_slow_inc() failed to fix the equivalent issues
vs. static_key_slow_dec():

CPU0                     CPU1

static_key_slow_dec()
  static_key_slow_try_dec()

	key->enabled == 1
	val = atomic_fetch_add_unless(&key->enabled, -1, 1);
	if (val == 1)
	     return false;

  jump_label_lock();
  if (atomic_dec_and_test(&key->enabled)) {
     --> key->enabled == 0
   __jump_label_update()

			 static_key_slow_dec()
			   static_key_slow_try_dec()

			     key->enabled == 0
			     val = atomic_fetch_add_unless(&key->enabled, -1, 1);

			      --> key->enabled == -1 <- FAIL

There is another bug in that code, when there is a concurrent
static_key_slow_inc() which enables the key as that sets key->enabled to -1
so on the other CPU

	val = atomic_fetch_add_unless(&key->enabled, -1, 1);

will succeed and decrement to -2, which is invalid.

Cure all of this by replacing the atomic_fetch_add_unless() with a
atomic_try_cmpxchg() loop similar to static_key_fast_inc_not_disabled().

Fixes: 4c5ea0a9cd02 ("locking/static_key: Fix concurrent static_key_slow_inc()")
Reported-by: Yue Sun <samsun1006219@gmail.com>
Reported-by: Xingwei Lee <xrivendell7@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/jump_label.c |   38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -131,7 +131,7 @@ bool static_key_fast_inc_not_disabled(st
 	STATIC_KEY_CHECK_USE(key);
 	/*
 	 * Negative key->enabled has a special meaning: it sends
-	 * static_key_slow_inc() down the slow path, and it is non-zero
+	 * static_key_slow_inc/dec() down the slow path, and it is non-zero
 	 * so it counts as "enabled" in jump_label_update().  Note that
 	 * atomic_inc_unless_negative() checks >= 0, so roll our own.
 	 */
@@ -150,7 +150,7 @@ bool static_key_slow_inc_cpuslocked(stru
 	lockdep_assert_cpus_held();
 
 	/*
-	 * Careful if we get concurrent static_key_slow_inc() calls;
+	 * Careful if we get concurrent static_key_slow_inc/dec() calls;
 	 * later calls must wait for the first one to _finish_ the
 	 * jump_label_update() process.  At the same time, however,
 	 * the jump_label_update() call below wants to see
@@ -247,20 +247,25 @@ EXPORT_SYMBOL_GPL(static_key_disable);
 
 static bool static_key_slow_try_dec(struct static_key *key)
 {
-	int val;
-
-	val = atomic_fetch_add_unless(&key->enabled, -1, 1);
-	if (val == 1)
-		return false;
+	int v;
 
 	/*
-	 * The negative count check is valid even when a negative
-	 * key->enabled is in use by static_key_slow_inc(); a
-	 * __static_key_slow_dec() before the first static_key_slow_inc()
-	 * returns is unbalanced, because all other static_key_slow_inc()
-	 * instances block while the update is in progress.
+	 * Go into the slow path if key::enabled is less than or equal than
+	 * one. One is valid to shut down the key, anything less than one
+	 * is an imbalance, which is handled at the call site.
+	 *
+	 * That includes the special case of '-1' which is set in
+	 * static_key_slow_inc_cpuslocked(), but that's harmless as it is
+	 * fully serialized in the slow path below. By the time this task
+	 * acquires the jump label lock the value is back to one and the
+	 * retry under the lock must succeed.
 	 */
-	WARN(val < 0, "jump label: negative count!\n");
+	v = atomic_read(&key->enabled);
+	do {
+		if (v <= 1)
+			return false;
+	} while (!likely(atomic_try_cmpxchg(&key->enabled, &v, v - 1)));
+
 	return true;
 }
 
@@ -271,10 +276,11 @@ static void __static_key_slow_dec_cpuslo
 	if (static_key_slow_try_dec(key))
 		return;
 
-	jump_label_lock();
-	if (atomic_dec_and_test(&key->enabled))
+	guard(mutex)(&jump_label_mutex);
+	if (atomic_cmpxchg(&key->enabled, 1, 0))
 		jump_label_update(key);
-	jump_label_unlock();
+	else
+		WARN_ON_ONCE(!static_key_slow_try_dec(key));
 }
 
 static void __static_key_slow_dec(struct static_key *key)


