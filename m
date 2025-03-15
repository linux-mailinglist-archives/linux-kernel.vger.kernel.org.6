Return-Path: <linux-kernel+bounces-562332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F143A6233A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 01:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A123BFA26
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 00:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB87C9450;
	Sat, 15 Mar 2025 00:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JFyvJJqo"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C439139D
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 00:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741999094; cv=none; b=fR+9oXqHGUl4+ewvcnCeScUAQeARpKwDqJjRv7Y5SGatQ8f7tdQc3nCB6sFwnG7WGZKgUYnkMuFsDyxoCbPFN7zoJYrbsuOL2WACWQH5BhurMjSSpbmHGdk6PAEHbjTfRyXUktS7E2R7atsWigJxSTrgXKqN7uA2XOd9ms4ZJVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741999094; c=relaxed/simple;
	bh=yMmQ0fFi3IbgqATEYGssWRnBGKGBiiA+nNhLjqFPIRA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=s6xJYqfUZCCj4w6+BRYdoe7VXs9gs1tv9WpeoSLn+/vdw8sSlQT6rbiTXxN3FErYJQtwlFChPRUxuGf6AuLSfIlnFawI1kx4TJ41BaBkU6QXcoC76Wp/2hv+w4u2h6THotPZFTzygnxp/4EyIe7UcdZTL1fVmWm8oK4R69xT+jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JFyvJJqo; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jstultz.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff69646218so614489a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 17:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741999092; x=1742603892; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JBBbvvIvDC/mHmEen0xNd6Oduzl1KFskcxJhYdjd5B8=;
        b=JFyvJJqodnI1Ig/eRK8dhPHmDsQ5W2cbOHFDhClRMhiCepsEX/M3nPqP1i5dkOfGA2
         7lsTuZDCAEo4fX47fb98b/uvziIE7mrntAXuDyWkU9piFBCxbFPXyWg3bdvT7/Ltlvln
         rDUpVxRCMPrmgyjG+PEsV+YWqUXIQMHTJ1Pz+Zqm+TvDypEl0LRSm6aGOO7lH1smV+Uw
         woZtm4x8nmv1zlZb2ncWJffFMO7rxe5BsukWid/+Y4RUWYKkK3WVpkhlyrRDpYIMh9fR
         JtkCl/LZk5/AKsVKQyoKPaQMNuW7kRD70iNUQEYbw1YO7rj6MSUHe8tImybK2k9+PljQ
         YqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741999092; x=1742603892;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JBBbvvIvDC/mHmEen0xNd6Oduzl1KFskcxJhYdjd5B8=;
        b=HkRSCA4Q/Fd6ISSE/pTXgyUfYS15ohecBpEjTbDbFjv9wsp1uJzqtJXz/1xRPFy+hG
         7lzu9QP6TueAPj14Eyxxu4XYs2xBai79JqHTR5hb/la5RKj94VBFpFojw1e6V+zOiklM
         k07xiey7q3JqsYfFG6wYn+VWwZhUyOHW0Mnmzuh4Th7DzoTFj2EYk1BWEEbekM3kQQ0E
         BsEuVSmpQu+WguYeFs/AV57NsJUWcbAFN7reC368h9kB/3QT7DUF2xroS19VW+ujcUe9
         cO0lkGXOfnmqIax0noOtyOEK+zhmazDtiHDDZMWg9AszvWC7VfE2lO9Dk1vWm5aTRnCW
         0Lxw==
X-Gm-Message-State: AOJu0Ywn1tv2sAKjg9pUFjkDWXonZPOuLiO6p+ncnbdYNiLzb2nlKjNg
	uREQXgUnkngXyObyFzBwhAysGNkYOIjcnZTkKh0MCZVka4fHG2K0P/YNX8uy2PGKH1Gx1aL3EYi
	hDIleGOslBno7iJCRBaHflrZUEPQlAV/LIyOvwJI3GbQsIVyA9b8q6c3thZVzmTHko62+rkow0v
	fvd/yoIBSIUR0x7M+qvhMsiio1xoDj4onZpesNuu7TPqgO
X-Google-Smtp-Source: AGHT+IG0APvZyb2F77PT2c/bLlGOMV+AySLZafrEoG5BY10GJjPWxGCDmuiKnBb39piS9qNWpRt4Q5zhiRaN
X-Received: from pjbsg17.prod.google.com ([2002:a17:90b:5211:b0:2ef:973a:3caf])
 (user=jstultz job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:fc4f:b0:2f2:a664:df20
 with SMTP id 98e67ed59e1d1-30151c5f303mr5922074a91.7.1741999091663; Fri, 14
 Mar 2025 17:38:11 -0700 (PDT)
Date: Fri, 14 Mar 2025 17:37:41 -0700
In-Reply-To: <CANDhNCoueki=keYNcNr4eXqgLFPh3VupDJC0hFqxm4FNKfGzYg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CANDhNCoueki=keYNcNr4eXqgLFPh3VupDJC0hFqxm4FNKfGzYg@mail.gmail.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Message-ID: <20250315003800.3054684-1-jstultz@google.com>
Subject: [RFC PATCH 1/2] time/timekeeping: Fix possible inconsistencies in
 _COARSE clockids
From: John Stultz <jstultz@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Stephen Boyd <sboyd@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Miroslav Lichvar <mlichvar@redhat.com>, linux-kselftest@vger.kernel.org, 
	kernel-team@android.com, Lei Chen <lei.chen@smartx.com>
Content-Type: text/plain; charset="UTF-8"

Lei Chen raised an issue with CLOCK_MONOTONIC_COARSE seeing
time inconsistencies.

Lei tracked down that this was being caused by the adjustment
  tk->tkr_mono.xtime_nsec -= offset;

which is made to compensate for the unaccumulated cycles in
offset when the mult value is adjusted forward, so that
the non-_COARSE clockids don't see inconsistencies.

However, the _COARSE clockids don't use the mult*offset value
in their calculations, so this subtraction can cause the
_COARSE clock ids to jump back a bit.

Now, by design, this negative adjustment should be fine, because
the logic run from timekeeping_adjust() is done after we
accumulate approx mult*interval_cycles into xtime_nsec.
The accumulated (mult*interval_cycles) will be larger then the
(mult_adj*offset) value subtracted from xtime_nsec, and both
operations are done together under the tk_core.lock, so the net
change to xtime_nsec should always be positive.

However, do_adjtimex() calls into timekeeping_advance() as well,
since we want to apply the ntp freq adjustment immediately.
In this case, we don't return early when the offset is smaller
then interval_cycles, so we don't end up accumulating any time
into xtime_nsec. But we do go on to call timekeeping_adjust(),
which modifies the mult value, and subtracts from xtime_nsec
to correct for the new mult value.

Here because we did not accumulate anything, we have a window
where the _COARSE clockids that don't utilize the mult*offset
value, can see an inconsistency.

So to fix this, rework the timekeeping_advance() logic a bit
so that when we are called from do_adjtimex() and the offset
is smaller then cycle_interval, that we call
timekeeping_forward(), to first accumulate the sub-interval
time into xtime_nsec. Then with no unaccumulated cycles in
offset, we can do the mult adjustment without worry of the
subtraction having an impact.

NOTE: This was implemented as a potential alternative to
Thomas' approach here:
   https://lore.kernel.org/lkml/87cyej5rid.ffs@tglx/

And similarly, it needs some additional review and testing,
as it was developed while packing for conference travel.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Miroslav Lichvar <mlichvar@redhat.com>
Cc: linux-kselftest@vger.kernel.org
Cc: kernel-team@android.com
Cc: Lei Chen <lei.chen@smartx.com>
Fixes: da15cfdae033 ("time: Introduce CLOCK_REALTIME_COARSE")
Reported-by: Lei Chen <lei.chen@smartx.com>
Closes: https://lore.kernel.org/lkml/20250310030004.3705801-1-lei.chen@smartx.com/
Diagnosed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: John Stultz <jstultz@google.com>
---
 kernel/time/timekeeping.c | 87 ++++++++++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 25 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 1e67d076f1955..6f3a145e7b113 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -682,18 +682,18 @@ static void timekeeping_update_from_shadow(struct tk_data *tkd, unsigned int act
 }
 
 /**
- * timekeeping_forward_now - update clock to the current time
+ * timekeeping_forward - update clock to given cycle now value
  * @tk:		Pointer to the timekeeper to update
+ * @cycle_now:  Current clocksource read value
  *
  * Forward the current clock to update its state since the last call to
  * update_wall_time(). This is useful before significant clock changes,
  * as it avoids having to deal with this time offset explicitly.
  */
-static void timekeeping_forward_now(struct timekeeper *tk)
+static void timekeeping_forward(struct timekeeper *tk, u64 cycle_now)
 {
-	u64 cycle_now, delta;
+	u64 delta;
 
-	cycle_now = tk_clock_read(&tk->tkr_mono);
 	delta = clocksource_delta(cycle_now, tk->tkr_mono.cycle_last, tk->tkr_mono.mask,
 				  tk->tkr_mono.clock->max_raw_delta);
 	tk->tkr_mono.cycle_last = cycle_now;
@@ -710,6 +710,21 @@ static void timekeeping_forward_now(struct timekeeper *tk)
 	}
 }
 
+/**
+ * timekeeping_forward_now - update clock to the current time
+ * @tk:		Pointer to the timekeeper to update
+ *
+ * Forward the current clock to update its state since the last call to
+ * update_wall_time(). This is useful before significant clock changes,
+ * as it avoids having to deal with this time offset explicitly.
+ */
+static void timekeeping_forward_now(struct timekeeper *tk)
+{
+	u64 cycle_now = tk_clock_read(&tk->tkr_mono);
+
+	timekeeping_forward(tk, cycle_now);
+}
+
 /**
  * ktime_get_real_ts64 - Returns the time of day in a timespec64.
  * @ts:		pointer to the timespec to be set
@@ -2151,6 +2166,45 @@ static u64 logarithmic_accumulation(struct timekeeper *tk, u64 offset,
 	return offset;
 }
 
+static u64 timekeeping_accumulate(struct timekeeper *tk, u64 now, u64 offset,
+				  unsigned int *clock_set)
+{
+	struct timekeeper *real_tk = &tk_core.timekeeper;
+	int shift = 0, maxshift;
+
+	/*
+	 * If we have a sub-cycle_interval offset, we
+	 * are likely doing a TK_FREQ_ADJ, so accumulate
+	 * everything so we don't have a remainder offset
+	 * when later adjusting the multiplier
+	 */
+	if (offset < real_tk->cycle_interval) {
+		timekeeping_forward(tk, now);
+		*clock_set = 1;
+		return 0;
+	}
+
+	/*
+	 * With NO_HZ we may have to accumulate many cycle_intervals
+	 * (think "ticks") worth of time at once. To do this efficiently,
+	 * we calculate the largest doubling multiple of cycle_intervals
+	 * that is smaller than the offset.  We then accumulate that
+	 * chunk in one go, and then try to consume the next smaller
+	 * doubled multiple.
+	 */
+	shift = ilog2(offset) - ilog2(tk->cycle_interval);
+	shift = max(0, shift);
+	/* Bound shift to one less than what overflows tick_length */
+	maxshift = (64 - (ilog2(ntp_tick_length()) + 1)) - 1;
+	shift = min(shift, maxshift);
+	while (offset >= tk->cycle_interval) {
+		offset = logarithmic_accumulation(tk, offset, shift, clock_set);
+		if (offset < tk->cycle_interval << shift)
+			shift--;
+	}
+	return offset;
+}
+
 /*
  * timekeeping_advance - Updates the timekeeper to the current time and
  * current NTP tick length
@@ -2160,8 +2214,7 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 	struct timekeeper *tk = &tk_core.shadow_timekeeper;
 	struct timekeeper *real_tk = &tk_core.timekeeper;
 	unsigned int clock_set = 0;
-	int shift = 0, maxshift;
-	u64 offset;
+	u64 cycle_now, offset;
 
 	guard(raw_spinlock_irqsave)(&tk_core.lock);
 
@@ -2169,7 +2222,8 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 	if (unlikely(timekeeping_suspended))
 		return false;
 
-	offset = clocksource_delta(tk_clock_read(&tk->tkr_mono),
+	cycle_now = tk_clock_read(&tk->tkr_mono);
+	offset = clocksource_delta(cycle_now,
 				   tk->tkr_mono.cycle_last, tk->tkr_mono.mask,
 				   tk->tkr_mono.clock->max_raw_delta);
 
@@ -2177,24 +2231,7 @@ static bool timekeeping_advance(enum timekeeping_adv_mode mode)
 	if (offset < real_tk->cycle_interval && mode == TK_ADV_TICK)
 		return false;
 
-	/*
-	 * With NO_HZ we may have to accumulate many cycle_intervals
-	 * (think "ticks") worth of time at once. To do this efficiently,
-	 * we calculate the largest doubling multiple of cycle_intervals
-	 * that is smaller than the offset.  We then accumulate that
-	 * chunk in one go, and then try to consume the next smaller
-	 * doubled multiple.
-	 */
-	shift = ilog2(offset) - ilog2(tk->cycle_interval);
-	shift = max(0, shift);
-	/* Bound shift to one less than what overflows tick_length */
-	maxshift = (64 - (ilog2(ntp_tick_length())+1)) - 1;
-	shift = min(shift, maxshift);
-	while (offset >= tk->cycle_interval) {
-		offset = logarithmic_accumulation(tk, offset, shift, &clock_set);
-		if (offset < tk->cycle_interval<<shift)
-			shift--;
-	}
+	offset = timekeeping_accumulate(tk, cycle_now, offset, &clock_set);
 
 	/* Adjust the multiplier to correct NTP error */
 	timekeeping_adjust(tk, offset);
-- 
2.49.0.rc1.451.g8f38331e32-goog


