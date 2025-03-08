Return-Path: <linux-kernel+bounces-552631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF7BA57C1F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 17:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC11516DFAC
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Mar 2025 16:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC1520FA9B;
	Sat,  8 Mar 2025 16:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VheeN7ep";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BmJb6W/q"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA2420D4F4
	for <linux-kernel@vger.kernel.org>; Sat,  8 Mar 2025 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741452520; cv=none; b=EUiYTjmmKT78O6Fo/rBDVdp4+5zO6PzFIeFZS6BLO9ZfbxEuxCdizgnZoiY/eFXysq2pcuhWPdZa9JhL0fPfokMVsZLhNIq/zyWL96EyfS5ipSh9XGXOE6IEsMbWWoCSzzbb6vPdlyl/h7pll2VjPYDPNQoMiivf33Pf722OCd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741452520; c=relaxed/simple;
	bh=VZRiy9Nx/9QJr+labI5YPBS7f+6rHBvP8+BxprYYoIY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=nYd/LssXKs1t/4AFX+B5/PyS3v7gFbNFTXZtD9S30nl/E716NAtjnO6579QXHUI8o0koblzkKGQ2ypJgDlic8kQrALSB0OQ3ORgs4ZdrY9rsl8GT7zDjYzkOhX0s+ZduHjo2d9SK8gsb1Q9tAqAIojqtKPumSwZBmfrSGIMSS1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VheeN7ep; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BmJb6W/q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250308155624.151545978@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741452517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=wKjKiY6BXUNfp2GLLE0gAGlF2vV5x60AlACNOqAMXBY=;
	b=VheeN7epUs8M9aifJ+UNTdIDWvKhlvDj+OA1QvPCnDmYrRpyK0GaU7cX5TIt7WRGIyAUga
	NGL1Yi5xOiU59d2+0fCcrJwKlFSXi01ZylpiHA9d2x0bdQa4tjsqKkUj1tfnUX1cXdPIzN
	/Mia678S+rRhEXaGeutbK20lalvN9smmcNiWi5dWfIYZuiDavmN7ncnClPaIp2Nk2z0YAE
	Azke5/0oDJxnr2NeX+rtzi2jqot96io6r1j0PZbbIidGe4dT/GlhX9eTr3kUdOaV60ckGi
	mDXNW34JSEpCMaerihOT2O1Tp3h6FVvCdsXUDCnvSlb1aYoTrjXdChJOxhjWyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741452517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=wKjKiY6BXUNfp2GLLE0gAGlF2vV5x60AlACNOqAMXBY=;
	b=BmJb6W/q1Aox7gou+kNLcpDjFhoVAz3QN50kIYadTJAE76oeJaRsD8Qh5g5cLpmmP5MP7y
	8hxi4Uu+swuCAGBg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Benjamin Segall <bsegall@google.com>,
 Eric Dumazet <edumazet@google.com>,
 Andrey Vagin <avagin@openvz.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Cyrill Gorcunov <gorcunov@gmail.com>
Subject: [patch V3 11/18] posix-timers: Make signal_struct::
 Next_posix_timer_id an atomic_t
References: <20250308155501.391430556@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sat,  8 Mar 2025 17:48:36 +0100 (CET)

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
V2: Use atomic_fetch_inc() - PeterZ
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
@@ -119,21 +119,17 @@ static bool posix_timer_hashed(struct hl
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
+		unsigned int id = atomic_fetch_inc(&sig->next_posix_timer_id) & INT_MAX;
+		struct hlist_head *head = &posix_timers_hashtable[hash(sig, id)];
 
-		head = &posix_timers_hashtable[hash(sig, id)];
+		spin_lock(&hash_lock);
 		if (!posix_timer_hashed(head, sig, id)) {
 			/*
 			 * Set the timer ID and the signal pointer to make


