Return-Path: <linux-kernel+bounces-429221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 041389E1A0E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 11:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 816A1B2C696
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 10:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F29C1E0E1D;
	Tue,  3 Dec 2024 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UraGzI05";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qhi4n6E0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04ED192583
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 10:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733220996; cv=none; b=dXGCW9bdURU5ERcpzs2mtdF4vP71BOaqgncAiCEHfDayq7B9MDreF43IN5GfsfjnBvLl3av95MLC6Uu0p/cTRLUIWj++NCwzBThhMtEBnOlaqmPL/kpyxlQ26cHouvA3csR6T/JgD5725xBiU7w7MnFrBk+0NcXTuBj9o+rrWuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733220996; c=relaxed/simple;
	bh=xJZFzYbKU5tfV7DH4LciImH4NAIrHAk2Y+Ca33P+C4w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O83zxkXOs4G1l8BV2aecaOZAW4ZGx2XffCIlGvmd5pbzh+bTP64sXFDDC+sOyO5bWIdCtz5MC3B/uKAhvNHuMZbbzaof96nq1F0SQVaRz4P7tXeBzMDXemNFDBf4o/ibgDDV4cYRSQUZV3UbGKQvaacSFFNZdSiT1NdiidGNtvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UraGzI05; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qhi4n6E0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733220991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wiRele5vXkMhicUTP2J6tI55wSQl0sF6iH1Pv6V77Cs=;
	b=UraGzI05WcgK3gWPNcEr3FGyvkezMfb47SN/wUy7iD2MXEerAhcm8cXL04RrUR6lwZJ1b7
	D2Dq3AqIZJhMP69sm5RK9d6kJgDOw7uuxtmqOyp6WdZHxP65CWeMKmDNDfapmjPB4agELz
	a8O4tf642b3HPMVcLZQ2o5QU+oMcTbMh7nX3VIvn/0K8TmER6yxHnSlqM21XmuFQXpwFD3
	PN8PlbrKnHH3msJJawic0GbGH3oK62CFl0IEc8BQxrPPObvL8ujuUImZwDOnLiAzfqgY4Y
	dsDvDnBs+Zb0GHXj4DM8FpDqce8nsfmS82nrCJnGNC+8rrCtserPCe7kNOl7JQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733220991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wiRele5vXkMhicUTP2J6tI55wSQl0sF6iH1Pv6V77Cs=;
	b=qhi4n6E04FjjjtqukvgeJ+2wYrrltUzF6G4mZ3k+AmM2h8O/Lfs22gWmEBeoseKBoLGsPV
	YFGvULjCyaNDw4BA==
To: Guenter Roeck <linux@roeck-us.net>, John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: [patch] clocksource: Make negative motion detection more robust
In-Reply-To: <a79b27d5-ae85-4b7c-bd08-ac7b345f3a20@roeck-us.net>
References: <20241031115448.978498636@linutronix.de>
 <20241031120328.599430157@linutronix.de>
 <387b120b-d68a-45e8-b6ab-768cd95d11c2@roeck-us.net>
 <CANDhNCo1RtcfqUJsuAQ+HdS7E29+gByfek5-4KYiAk3Njk4M3Q@mail.gmail.com>
 <65b412ef-fc57-4988-bf92-3c924a1c74a5@roeck-us.net> <87cyifxvgj.ffs@tglx>
 <2cb25f89-50b9-4e72-9b18-bee78e09c57c@roeck-us.net> <874j3qxmk7.ffs@tglx>
 <2b732d25-63e7-40f7-8d66-b1e6dc0b701d@roeck-us.net> <87r06tvuzd.ffs@tglx>
 <a79b27d5-ae85-4b7c-bd08-ac7b345f3a20@roeck-us.net>
Date: Tue, 03 Dec 2024 11:16:30 +0100
Message-ID: <8734j5ul4x.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Guenter reported boot stalls on a emulated ARM 32-bit platform, which has a
24-bit wide clocksource.

It turns out that the calculated maximal idle time, which limits idle
sleeps to prevent clocksource wrap arounds, is close to the point where the
negative motion detection triggers.

  max_idle_ns:                    597268854 ns
  negative motion tripping point: 671088640 ns

If the idle wakeup is delayed beyond that point, the clocksource
advances far enough to trigger the negative motion detection. This
prevents the clock to advance and in the worst case the system stalls
completely if the consecutive sleeps based on the stale clock are
delayed as well.

Cure this by calculating a more robust cut-off value for negative motion,
which covers 87.5% of the actual clocksource counter width. Compare the
delta against this value to catch negative motion. This is specifically for
clock sources with a small counter width as their wrap around time is close
to the half counter width. For clock sources with wide counters this is not
a problem because the maximum idle time is far from the half counter width
due to the math overflow protection constraints.

For the case at hand this results in a tripping point of 1174405120ns.

Note, that this cannot prevent issues when the delay exceeds the 87.5%
margin, but that's not different from the previous unchecked version which
allowed arbitrary time jumps.

Systems with small counter width are prone to invalid results, but this
problem is unlikely to be seen on real hardware. If such a system
completely stalls for more than half a second, then there are other more
urgent problems than the counter wrapping around.

Fixes: c163e40af9b2 ("timekeeping: Always check for negative motion")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/all/387b120b-d68a-45e8-b6ab-768cd95d11c2@roeck-us.net
---
 include/linux/clocksource.h        |    2 ++
 kernel/time/clocksource.c          |   11 ++++++++++-
 kernel/time/timekeeping.c          |    6 ++++--
 kernel/time/timekeeping_internal.h |    8 ++++----
 4 files changed, 20 insertions(+), 7 deletions(-)

--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -49,6 +49,7 @@ struct module;
  * @archdata:		Optional arch-specific data
  * @max_cycles:		Maximum safe cycle value which won't overflow on
  *			multiplication
+ * @max_raw_delta:	Maximum safe delta value for negative motion detection
  * @name:		Pointer to clocksource name
  * @list:		List head for registration (internal)
  * @freq_khz:		Clocksource frequency in khz.
@@ -109,6 +110,7 @@ struct clocksource {
 	struct arch_clocksource_data archdata;
 #endif
 	u64			max_cycles;
+	u64			max_raw_delta;
 	const char		*name;
 	struct list_head	list;
 	u32			freq_khz;
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -24,7 +24,7 @@ static void clocksource_enqueue(struct c
 
 static noinline u64 cycles_to_nsec_safe(struct clocksource *cs, u64 start, u64 end)
 {
-	u64 delta = clocksource_delta(end, start, cs->mask);
+	u64 delta = clocksource_delta(end, start, cs->mask, cs->max_raw_delta);
 
 	if (likely(delta < cs->max_cycles))
 		return clocksource_cyc2ns(delta, cs->mult, cs->shift);
@@ -993,6 +993,15 @@ static inline void clocksource_update_ma
 	cs->max_idle_ns = clocks_calc_max_nsecs(cs->mult, cs->shift,
 						cs->maxadj, cs->mask,
 						&cs->max_cycles);
+
+	/*
+	 * Threshold for detecting negative motion in clocksource_delta().
+	 *
+	 * Allow for 0.875 of the counter width so that overly long idle
+	 * sleeps, which go slightly over mask/2, do not trigger the
+	 * negative motion detection.
+	 */
+	cs->max_raw_delta = (cs->mask >> 1) + (cs->mask >> 2) + (cs->mask >> 3);
 }
 
 static struct clocksource *clocksource_find_best(bool oneshot, bool skipcur)
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -755,7 +755,8 @@ static void timekeeping_forward_now(stru
 	u64 cycle_now, delta;
 
 	cycle_now = tk_clock_read(&tk->tkr_mono);
-	delta = clocksource_delta(cycle_now, tk->tkr_mono.cycle_last, tk->tkr_mono.mask);
+	delta = clocksource_delta(cycle_now, tk->tkr_mono.cycle_last, tk->tkr_mono.mask,
+				  tk->tkr_mono.clock->max_raw_delta);
 	tk->tkr_mono.cycle_last = cycle_now;
 	tk->tkr_raw.cycle_last  = cycle_now;
 
@@ -2230,7 +2231,8 @@ static bool timekeeping_advance(enum tim
 		return false;
 
 	offset = clocksource_delta(tk_clock_read(&tk->tkr_mono),
-				   tk->tkr_mono.cycle_last, tk->tkr_mono.mask);
+				   tk->tkr_mono.cycle_last, tk->tkr_mono.mask,
+				   tk->tkr_mono.clock->max_raw_delta);
 
 	/* Check if there's really nothing to do */
 	if (offset < real_tk->cycle_interval && mode == TK_ADV_TICK)
--- a/kernel/time/timekeeping_internal.h
+++ b/kernel/time/timekeeping_internal.h
@@ -30,15 +30,15 @@ static inline void timekeeping_inc_mg_fl
 
 #endif
 
-static inline u64 clocksource_delta(u64 now, u64 last, u64 mask)
+static inline u64 clocksource_delta(u64 now, u64 last, u64 mask, u64 max_delta)
 {
 	u64 ret = (now - last) & mask;
 
 	/*
-	 * Prevent time going backwards by checking the MSB of mask in
-	 * the result. If set, return 0.
+	 * Prevent time going backwards by checking the result against
+	 * @max_delta. If greater, return 0.
 	 */
-	return ret & ~(mask >> 1) ? 0 : ret;
+	return ret > max_delta ? 0 : ret;
 }
 
 /* Semi public for serialization of non timekeeper VDSO updates. */

