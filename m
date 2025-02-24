Return-Path: <linux-kernel+bounces-528677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA496A41A98
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 227D51613B9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 10:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438C4254AE0;
	Mon, 24 Feb 2025 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0oFNtqPi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l9qoHdHP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCEA253B57
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392135; cv=none; b=kz8qFEf1N4FOJ6peBgt6OgMlbsrAdxtUNevcAXLgdxchEqe4OHU0wBOoHQTubaG+72wP7VvHC94Q0EBAc5PCjFW3Wwp74N5dre+niEp7ggflHIVuu9MVHprayk955k+iJRReW6UHuCDKtC0Czle4/U4sK+35Rn8HDtbCy7s7p8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392135; c=relaxed/simple;
	bh=2XGHKppiI14EJmvbu8OZVXUe2XVlMI1v2uj+6/Gxu3w=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=iqnyzBxuoEzYfnJprNXs0wAvrsufW+Kk/Nk1okPQHWE8Xo5tkfRRZGfQba8HZCflgXdfBvfQwA+C2R7/JeVT6RyjcGZQq/8FImoJhfe3zAyTE0zUFVK5CgYijtGuC7uuRjctA3xr71X/Q9OrAWLSQHCZd/K5zuJ9joLRWMlwy5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0oFNtqPi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l9qoHdHP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250224101343.344168498@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740392132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=5b26gUKwIOtDz/nxYP1M5mOx9KSbpQ2cUpKA7MwXFdw=;
	b=0oFNtqPiWrJfXkzLzFer+vNpG7QHObJPkbCnu22EwHJDX+tQ04huuoynuPkKIVRHh7mHjH
	ZRCFC9DU6YJO7NsjtPggE8sVRSyjOBPWhfIYMsDE3kUz2nF3l6F5bDUAF4oQhrCgJXjOgH
	8M6vwbWGYmVH+lYCSz+UC19Hv8ULon/L3GUY79os8MUx8kF2PRjD/J7/hce4eaSLIvlNE8
	zKUXVvSSUfYq9LlcF8+LkHmvQXQJgu3IpIapCyiAtEnFn5N413P4NOYt04R0jFUtro7NdN
	ZgV0HSjLiG09ig5hR5Q3dPw1skkzvbiPgHx0dOltsdsO4yQUjwEu+9yusSv91A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740392132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=5b26gUKwIOtDz/nxYP1M5mOx9KSbpQ2cUpKA7MwXFdw=;
	b=l9qoHdHPiAd5PoyR2eGIEnUnYgekwbfNYFUpwyL8HBhonzbXcsRpIP5OjzgRMU78/71i3d
	8aZTnI51o1h+7JBw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: [patch 06/11] posix-timers: Make signal_struct::next_posix_timer_id
 an atomic_t
References: <20250224095736.145530367@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Feb 2025 11:15:32 +0100 (CET)

From: Eric Dumazet <edumazet@google.com>

The global hash_lock protecting the posix timer hash table can be heavily
contended especially when there is an extensive linear search for a timer
ID.

Timer IDs are handed out by monotonically increasing next_posix_timer_id
and then validating that there is no timer with the same ID in the hash
table. Both operations happen with the global hash lock held.

To reduce the hash lock contention the hash will be reworked to a scaled
hash with per bucket locks, which requires to handle the ID counter
lockless.

Prepare for this by making next_posix_timer_id an atomic_t, which can be
used lockless with atomic_inc_return().

[ tglx: Adopted from Eric's series, massaged change log and simplified it ]

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250219125522.2535263-2-edumazet@google.com
---
 include/linux/sched/signal.h |    2 +-
 kernel/time/posix-timers.c   |   14 +++++---------
 2 files changed, 6 insertions(+), 10 deletions(-)

--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -136,7 +136,7 @@ struct signal_struct {
 #ifdef CONFIG_POSIX_TIMERS
 
 	/* POSIX.1b Interval Timers */
-	unsigned int		next_posix_timer_id;
+	atomic_t		next_posix_timer_id;
 	struct hlist_head	posix_timers;
 	struct hlist_head	ignored_posix_timers;
 
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -105,21 +105,17 @@ static bool posix_timer_hashed(struct hl
 static int posix_timer_add(struct k_itimer *timer)
 {
 	struct signal_struct *sig = current->signal;
-	struct hlist_head *head;
-	unsigned int cnt, id;
 
 	/*
 	 * FIXME: Replace this by a per signal struct xarray once there is
 	 * a plan to handle the resulting CRIU regression gracefully.
 	 */
-	for (cnt = 0; cnt <= INT_MAX; cnt++) {
-		spin_lock(&hash_lock);
-		id = sig->next_posix_timer_id;
-
-		/* Write the next ID back. Clamp it to the positive space */
-		sig->next_posix_timer_id = (id + 1) & INT_MAX;
+	for (unsigned int cnt = 0; cnt <= INT_MAX; cnt++) {
+		/* Get the next timer ID and clamp it to positive space */
+		unsigned int id = (atomic_inc_return(&sig->next_posix_timer_id) - 1) & INT_MAX;
+		struct hlist_head *head = &posix_timers_hashtable[hash(sig, id)];
 
-		head = &posix_timers_hashtable[hash(sig, id)];
+		spin_lock(&hash_lock);
 		if (!posix_timer_hashed(head, sig, id)) {
 			/*
 			 * Set the timer ID and the signal pointer to make


