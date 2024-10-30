Return-Path: <linux-kernel+bounces-388349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD379B5E3E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 09:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF3311C21D04
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Oct 2024 08:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73891E1A36;
	Wed, 30 Oct 2024 08:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZYk0JYGu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KHJTL7ah"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CC11E1A32
	for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2024 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730278232; cv=none; b=KvQaTRH6tOuPTcLvww84cLNQKgHDSYKgf3XH8cZw6sOdX1xKl+UKRoP3u7quZO4DgP7c3gEXKMr90CfW2B6MicFwqmG/RqD2ZN13eu8G9SxRLzLWu73nBnSJFnnMexrpjdRYknxe28sW+twnYHV9WfpUuqe5V3sw4l3eW4NTMyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730278232; c=relaxed/simple;
	bh=MW1cvSIgXQQweni8xpqI9UlPmU7TfkyFIvvx/VCnM08=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mULokjY2oIPhsifY9U4e6eTdz2df2soj7QTuhsPG0IkgIR2oYLkjAosvFUcpgT1XqorkNSW0f09LnSr+XI7+D6AoeqrTKJjRrRtQPtceKSlZmjEPRudzX6gQpjSF+g2cUknzwLxr73AAzfz8GyGnuiZypiZjzqqTMdxhGYKspYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZYk0JYGu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KHJTL7ah; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730278227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DEEncBPPE/chMonzXun3zXcQ8sc4lIaBCOXSozYEIWw=;
	b=ZYk0JYGuWJiqKIaUCGZTh8K6mk629SRTNVazpmw3Co3G74moz9YmwY0iaaCGZF3i9E+ERQ
	EFqaqHheIf3b4dvApHy1htCSCqJTbdITrfdJwZIiSFX3Nsu4i+CEZ5aNPleU3Hq3NZ8Bq2
	4fnGWBNjPL76X72RW6wOhTd6QcXPIJYOxYKG/udhJvwZMMpPc3mvHrEVfbGpqoauG96wiS
	JBsIJSV4F+WdLKBzDOqmVw6b+3tymeEtgvG9FwH1waqmB4h89TfLL3Aex9CXhMxyuk8b4V
	CwfmuBs/O+10D2+aT4wGmCHRweTkiRq6BD4NYBhA6uKoN5hZgwI3MEpoaYCh2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730278227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DEEncBPPE/chMonzXun3zXcQ8sc4lIaBCOXSozYEIWw=;
	b=KHJTL7ahXzC8iGJoCRkuxTz9vukexBjgdeR+m1QR2p2SyJsSM3ert8iL6SZ2UucooEDDE5
	5D0ofHu5PEoGGcAA==
To: kernel test robot <oliver.sang@intel.com>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
 x86@kernel.org, John Stultz <jstultz@google.com>, oliver.sang@intel.com,
 Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 Frederic Weisbecker <frederic@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Stephen Boyd <sboyd@kernel.org>
Subject: Re: [tip:timers/core] [timekeeping]  5aa6c43eca:
 BUG:KCSAN:data-race_in_timekeeping_debug_get_ns/timekeeping_update_from_shadow
In-Reply-To: <202410301316.e51421de-lkp@intel.com>
References: <202410301316.e51421de-lkp@intel.com>
Date: Wed, 30 Oct 2024 09:50:27 +0100
Message-ID: <877c9qynxo.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 30 2024 at 13:47, kernel test robot wrote:
> this is another report about BUG:KCSAN, the change does not introduce new KCSAN
> issue, but causes stats changes as below.
>
> [   70.265411][    C1] BUG: KCSAN: data-race in timekeeping_debug_get_ns / timekeeping_update_from_shadow
> [   70.265430][    C1]
> [   70.265433][    C1] write to 0xffffffff8483fef8 of 296 bytes by interrupt on cpu 0:
> [ 70.265440][ C1] timekeeping_update_from_shadow+0x8e/0x140 
> [ 70.265452][ C1] timekeeping_advance (kernel/time/timekeeping.c:2394) 
> [ 70.265462][ C1] update_wall_time (kernel/time/timekeeping.c:2403)

timekeeping_update_from_shadow() holds the sequence count write.

> [ 70.265642][ C1] timekeeping_debug_get_ns (kernel/time/timekeeping.c:415 kernel/time/timekeeping.c:399 kernel/time/timekeeping.c:307) 
> [ 70.265653][ C1] ktime_get (kernel/time/timekeeping.c:431 (discriminator 4) kernel/time/timekeeping.c:897 (discriminator 4)) 
> [ 70.265660][ C1] tick_nohz_lowres_handler (kernel/time/tick-sched.c:220 kernel/time/tick-sched.c:290 kernel/time/tick-sched.c:1486) 

ktime_get()

        do {
           seq = read_seqcount_begin(&tk_core.seq);
           timekeeping_debug_get_ns();
        } while (read_seqcount_retry(&tk_core.seq, seq));

So this should be safe against concurreny. I assume the issue here is
that timekeeping_debug_get_ns() has a nested

        do {
           seq = read_seqcount_begin(&tk_core.seq);
           ....
        } while (read_seqcount_retry(&tk_core.seq, seq));

inside. Which is still correct, but confuses KCSAN. Marco?

But that aside, since 135225a363ae timekeeping_cycles_to_ns() is fully
overflow protected and unconditionally handles negative motion (before
it was x86 only), the value of timekeeping_debug_get_ns() becomes
questionable.

I'm leaning towards removing it completely.

John?

Thanks,

        tglx
---
 include/linux/timekeeper_internal.h |   16 ------
 kernel/time/timekeeping.c           |   87 ++----------------------------------
 2 files changed, 5 insertions(+), 98 deletions(-)

--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -76,9 +76,6 @@ struct tk_read_base {
  *				ntp shifted nano seconds.
  * @ntp_err_mult:		Multiplication factor for scaled math conversion
  * @skip_second_overflow:	Flag used to avoid updating NTP twice with same second
- * @last_warning:		Warning ratelimiter (DEBUG_TIMEKEEPING)
- * @underflow_seen:		Underflow warning flag (DEBUG_TIMEKEEPING)
- * @overflow_seen:		Overflow warning flag (DEBUG_TIMEKEEPING)
  *
  * Note: For timespec(64) based interfaces wall_to_monotonic is what
  * we need to add to xtime (or xtime corrected for sub jiffy times)
@@ -147,19 +144,6 @@ struct timekeeper {
 	u32			ntp_error_shift;
 	u32			ntp_err_mult;
 	u32			skip_second_overflow;
-
-#ifdef CONFIG_DEBUG_TIMEKEEPING
-	long			last_warning;
-	/*
-	 * These simple flag variables are managed
-	 * without locks, which is racy, but they are
-	 * ok since we don't really care about being
-	 * super precise about how many events were
-	 * seen, just that a problem was observed.
-	 */
-	int			underflow_seen;
-	int			overflow_seen;
-#endif
 };
 
 #ifdef CONFIG_GENERIC_TIME_VSYSCALL
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -227,8 +227,6 @@ static inline u64 tk_clock_read(const st
 }
 
 #ifdef CONFIG_DEBUG_TIMEKEEPING
-#define WARNING_FREQ (HZ*300) /* 5 minute rate-limiting */
-
 static void timekeeping_check_update(struct timekeeper *tk, u64 offset)
 {
 
@@ -239,82 +237,15 @@ static void timekeeping_check_update(str
 		printk_deferred("WARNING: timekeeping: Cycle offset (%lld) is larger than allowed by the '%s' clock's max_cycles value (%lld): time overflow danger\n",
 				offset, name, max_cycles);
 		printk_deferred("         timekeeping: Your kernel is sick, but tries to cope by capping time updates\n");
-	} else {
-		if (offset > (max_cycles >> 1)) {
+	} else if (offset > (max_cycles >> 1)) {
 			printk_deferred("INFO: timekeeping: Cycle offset (%lld) is larger than the '%s' clock's 50%% safety margin (%lld)\n",
 					offset, name, max_cycles >> 1);
 			printk_deferred("      timekeeping: Your kernel is still fine, but is feeling a bit nervous\n");
-		}
-	}
-
-	if (tk->underflow_seen) {
-		if (jiffies - tk->last_warning > WARNING_FREQ) {
-			printk_deferred("WARNING: Underflow in clocksource '%s' observed, time update ignored.\n", name);
-			printk_deferred("         Please report this, consider using a different clocksource, if possible.\n");
-			printk_deferred("         Your kernel is probably still fine.\n");
-			tk->last_warning = jiffies;
-		}
-		tk->underflow_seen = 0;
-	}
-
-	if (tk->overflow_seen) {
-		if (jiffies - tk->last_warning > WARNING_FREQ) {
-			printk_deferred("WARNING: Overflow in clocksource '%s' observed, time update capped.\n", name);
-			printk_deferred("         Please report this, consider using a different clocksource, if possible.\n");
-			printk_deferred("         Your kernel is probably still fine.\n");
-			tk->last_warning = jiffies;
-		}
-		tk->overflow_seen = 0;
 	}
 }
 
-static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u64 cycles);
-
-static inline u64 timekeeping_debug_get_ns(const struct tk_read_base *tkr)
-{
-	struct timekeeper *tk = &tk_core.timekeeper;
-	u64 now, last, mask, max, delta;
-	unsigned int seq;
-
-	/*
-	 * Since we're called holding a seqcount, the data may shift
-	 * under us while we're doing the calculation. This can cause
-	 * false positives, since we'd note a problem but throw the
-	 * results away. So nest another seqcount here to atomically
-	 * grab the points we are checking with.
-	 */
-	do {
-		seq = read_seqcount_begin(&tk_core.seq);
-		now = tk_clock_read(tkr);
-		last = tkr->cycle_last;
-		mask = tkr->mask;
-		max = tkr->clock->max_cycles;
-	} while (read_seqcount_retry(&tk_core.seq, seq));
-
-	delta = clocksource_delta(now, last, mask);
-
-	/*
-	 * Try to catch underflows by checking if we are seeing small
-	 * mask-relative negative values.
-	 */
-	if (unlikely((~delta & mask) < (mask >> 3)))
-		tk->underflow_seen = 1;
-
-	/* Check for multiplication overflows */
-	if (unlikely(delta > max))
-		tk->overflow_seen = 1;
-
-	/* timekeeping_cycles_to_ns() handles both under and overflow */
-	return timekeeping_cycles_to_ns(tkr, now);
-}
 #else
-static inline void timekeeping_check_update(struct timekeeper *tk, u64 offset)
-{
-}
-static inline u64 timekeeping_debug_get_ns(const struct tk_read_base *tkr)
-{
-	BUG();
-}
+static inline void timekeeping_check_update(struct timekeeper *tk, u64 offset) { }
 #endif
 
 /**
@@ -421,19 +352,11 @@ static inline u64 timekeeping_cycles_to_
 	return ((delta * tkr->mult) + tkr->xtime_nsec) >> tkr->shift;
 }
 
-static __always_inline u64 __timekeeping_get_ns(const struct tk_read_base *tkr)
+static __always_inline u64 timekeeping_get_ns(const struct tk_read_base *tkr)
 {
 	return timekeeping_cycles_to_ns(tkr, tk_clock_read(tkr));
 }
 
-static inline u64 timekeeping_get_ns(const struct tk_read_base *tkr)
-{
-	if (IS_ENABLED(CONFIG_DEBUG_TIMEKEEPING))
-		return timekeeping_debug_get_ns(tkr);
-
-	return __timekeeping_get_ns(tkr);
-}
-
 /**
  * update_fast_timekeeper - Update the fast and NMI safe monotonic timekeeper.
  * @tkr: Timekeeping readout base from which we take the update
@@ -477,7 +400,7 @@ static __always_inline u64 __ktime_get_f
 		seq = raw_read_seqcount_latch(&tkf->seq);
 		tkr = tkf->base + (seq & 0x01);
 		now = ktime_to_ns(tkr->base);
-		now += __timekeeping_get_ns(tkr);
+		now += timekeeping_get_ns(tkr);
 	} while (raw_read_seqcount_latch_retry(&tkf->seq, seq));
 
 	return now;
@@ -593,7 +516,7 @@ static __always_inline u64 __ktime_get_r
 		tkr = tkf->base + (seq & 0x01);
 		basem = ktime_to_ns(tkr->base);
 		baser = ktime_to_ns(tkr->base_real);
-		delta = __timekeeping_get_ns(tkr);
+		delta = timekeeping_get_ns(tkr);
 	} while (raw_read_seqcount_latch_retry(&tkf->seq, seq));
 
 	if (mono)


