Return-Path: <linux-kernel+bounces-208582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 641289026F7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7991C1C21DD1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7C7154453;
	Mon, 10 Jun 2024 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QGjhEL8r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l6CWizxc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476C415380D
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718037750; cv=none; b=kQW5weaEWeVHE+HvsdXrqr/nFPeO2xlvLDvpv/yi2kxBvtib/hKurbaFIm9pUqLiGWNhhdiCI/Ebd1NBnnZUS7VWxWuodlLt+ho4S0H39Z33jxgcrK/Gw34/4VzD0LTCc2o3MPvLpGoGJM9Kn3dKFBQdVj1idDUogiXET3GowSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718037750; c=relaxed/simple;
	bh=M9Q7ax6L6HgZ2sYcMaynew0ayWNP6jxDDhPzY9nkD8E=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ESO8t8iJ9IHBCwTWf5126QI0UQUafluDoeuKtzOEZw4kApcQZWOI0SiHsb/pzwOoxe7CrRBuChvwZqXSOD+usdys1SXh/I9dyN2Xz5S7B/AYHr01AvVhnHeQQbjyIAhC+skoOJ8XnACP5xAviiyVtxLj/44dnhBNgJuJfNTaiBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QGjhEL8r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l6CWizxc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240610164026.552899255@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718037746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=a4kBoLxoimUoUZk3ev7GSbKQUyXJ3UwY85qwVJP4oio=;
	b=QGjhEL8rgUf4LT4XnfB9hwh3Joy0TpJofyy3Zzciwpqy16jIm74JFa2pE9d88WtHtzhcw+
	YU1uZNVe/NP5Ln74Gl6w2LvLAyxSO5s5lw4ChUDTI3TFDz+91wLG2ZBlSzzaerBojQzRQY
	fPz9Rw356u4q4P0kfeGJ+7zbwieLSFcTPKj6CAL4PzV7MRyI9tQduMUKgCdhEQYEcIVyH7
	ey1HHEPNqawr/B0rjYJVk3eZERlTsHFRUFP2XyXj6Wl7kVN6ufn0HcznsI7k6EhkdLm0gB
	yBiVpomKR/omMT8rnUJfMzqIaCvZUKEqBHeJi2VjoHbXMLsM3dWqpy1yd5TeBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718037746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=a4kBoLxoimUoUZk3ev7GSbKQUyXJ3UwY85qwVJP4oio=;
	b=l6CWizxcP/W4v72SIhiaaF1M463VhiMlQJ2B0UjZXbp0QYE48s2XaSzfSqdPAD8+heHtNZ
	PLW4LmA9Lz4jgNDw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 John Stultz <jstultz@google.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>,
 Eric Biederman <ebiederm@xmission.com>,
 Oleg Nesterov <oleg@redhat.com>
Subject: [patch V3 17/51] posix-timers: Retrieve interval in common
 timer_settime() code
References: <20240610163452.591699700@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Jun 2024 18:42:26 +0200 (CEST)

No point in doing this all over the place.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Removed the timer_gettime() part - Frederic
---
 kernel/time/posix-cpu-timers.c |   10 ++--------
 kernel/time/posix-timers.c     |    5 ++++-
 2 files changed, 6 insertions(+), 9 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -622,8 +622,8 @@ static int posix_cpu_timer_set(struct k_
 {
 	bool sigev_none = timer->it_sigev_notify == SIGEV_NONE;
 	clockid_t clkid = CPUCLOCK_WHICH(timer->it_clock);
-	u64 old_expires, new_expires, old_incr, now;
 	struct cpu_timer *ctmr = &timer->it.cpu;
+	u64 old_expires, new_expires, now;
 	struct sighand_struct *sighand;
 	struct task_struct *p;
 	unsigned long flags;
@@ -660,10 +660,7 @@ static int posix_cpu_timer_set(struct k_
 		return -ESRCH;
 	}
 
-	/*
-	 * Disarm any old timer after extracting its expiry time.
-	 */
-	old_incr = timer->it_interval;
+	/* Retrieve the current expiry time before disarming the timer */
 	old_expires = cpu_timer_getexpires(ctmr);
 
 	if (unlikely(timer->it.cpu.firing)) {
@@ -742,9 +739,6 @@ static int posix_cpu_timer_set(struct k_
 		cpu_timer_fire(timer);
 out:
 	rcu_read_unlock();
-	if (old)
-		old->it_interval = ns_to_timespec64(old_incr);
-
 	return ret;
 }
 
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -904,7 +904,7 @@ static int do_timer_settime(timer_t time
 	const struct k_clock *kc;
 	struct k_itimer *timr;
 	unsigned long flags;
-	int error = 0;
+	int error;
 
 	if (!timespec64_valid(&new_spec64->it_interval) ||
 	    !timespec64_valid(&new_spec64->it_value))
@@ -918,6 +918,9 @@ static int do_timer_settime(timer_t time
 	if (!timr)
 		return -EINVAL;
 
+	if (old_spec64)
+		old_spec64->it_interval = ktime_to_timespec64(timr->it_interval);
+
 	kc = timr->kclock;
 	if (WARN_ON_ONCE(!kc || !kc->timer_set))
 		error = -EINVAL;


