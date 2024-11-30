Return-Path: <linux-kernel+bounces-426188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D309DF009
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 12:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAA2A163165
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 11:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBCC15697A;
	Sat, 30 Nov 2024 11:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R2EkLtge";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yZhDDu+O"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A36313C3F2
	for <linux-kernel@vger.kernel.org>; Sat, 30 Nov 2024 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732964971; cv=none; b=Q+mFxvmdbLalY4RVEyutl7gxA06lotTSowHm3pey7M4PLWh1XAHuspGAzeQ9JH7+EZaqeIPWA7r0Acx/KlmhkmcEg4+jdbAjs7qMMZ8f7DzCvDTuKg9USkR2GDfM5CWaZ2b8knFuFZ6XIirYiCeGJ33fpTskZH2tseINfFFh4wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732964971; c=relaxed/simple;
	bh=v4w8vyhsXyVoxX3ovqAl05cCmbdCW+Rmn6zOFLeePj4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SBefLmBTYJKvo0O+Iob8WvWOK/xw+5yUyENlNhubGjTnXlL3JikSqneMgYzKTVVGHhOf5S0cEXCCQC8CzBNjSIoSkKrhRmEE8G7+ghyp4yeRi2RKmijVDOGTr8qBSio0skQ5fMI+Utu6yRC88tb1SdR5HFR6UK4/6ARlLyMZ21w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R2EkLtge; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yZhDDu+O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732964966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O7hP4TcnSHrpXTa8PPHEqfKDeA5XRzAAdThS5PJerWw=;
	b=R2EkLtgeKPi08mI+Nj28EiSvmNLuIONj1K4EcYE4xCgJ/sLrGgOjc+NhxfNaFOi1X8IRvq
	JsnWIhvTOmv0YGhrEqsPI+7kHuYn04bp9JQvL+KnCYwot5ogT5+NCQ5hELTU74XBHDj9wz
	aLV2FdG7IjEb+bKSKgcaop/ar/n3FIwFlYolM3TirDCshLxrRf2tGag+8Bq2gskyAqT9cd
	BaA6SOPfRtLE32gX8oQp+O8zltTdE1vD4iebooDBRfxh9Buo8Cw0M0sVe0KSUTmRNm0NwA
	v7igI9MpZIPlHnMYhLWlaVirTOz6fm2uwyV2y5x6GK538Ij8WtTP3LDxLTUn7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732964966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O7hP4TcnSHrpXTa8PPHEqfKDeA5XRzAAdThS5PJerWw=;
	b=yZhDDu+O8wTaUCp9AIumD1aDYwjBdI0bZ3ctg6KXFF2LAPiGJjQbrYIUZ1nEg3owJvgQ8O
	umpq7Ho+sL34GdDQ==
To: Guenter Roeck <linux@roeck-us.net>, John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 2/2] timekeeping: Always check for negative motion
In-Reply-To: <2b732d25-63e7-40f7-8d66-b1e6dc0b701d@roeck-us.net>
References: <20241031115448.978498636@linutronix.de>
 <20241031120328.599430157@linutronix.de>
 <387b120b-d68a-45e8-b6ab-768cd95d11c2@roeck-us.net>
 <CANDhNCo1RtcfqUJsuAQ+HdS7E29+gByfek5-4KYiAk3Njk4M3Q@mail.gmail.com>
 <65b412ef-fc57-4988-bf92-3c924a1c74a5@roeck-us.net> <87cyifxvgj.ffs@tglx>
 <2cb25f89-50b9-4e72-9b18-bee78e09c57c@roeck-us.net> <874j3qxmk7.ffs@tglx>
 <2b732d25-63e7-40f7-8d66-b1e6dc0b701d@roeck-us.net>
Date: Sat, 30 Nov 2024 12:09:26 +0100
Message-ID: <87r06tvuzd.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Nov 29 2024 at 08:09, Guenter Roeck wrote:
> On 11/29/24 04:16, Thomas Gleixner wrote:
> [   13.860000] WARNING: CPU: 0 PID: 0 at kernel/time/timekeeping_internal.h:44 timekeeping_advance+0x844/0x9d0
> [   13.860000] clocksource_delta() time going backward: now=0xd60127 last=0x85170f4 mask=0xffffff ret=0x849033

So this is a idle sleep which took longer than max_idle_ns. The rest is
the consequence of this as timekeeping does not advance and the timers
are rearmed on the stale time.

Can you try the patch below?

Thanks,

        tglx
---
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
+	 * Allow for 0.875 of the mask value so that overly long idle
+	 * sleeps which go slightly over mask/2 do not trigger the negative
+	 * motion detection.
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
+	 * Prevent time going backwards by checking against the result
+	 * against @max_delta. If greater, return 0.
 	 */
-	return ret & ~(mask >> 1) ? 0 : ret;
+	return ret > max_delta ? 0 : ret;
 }
 
 /* Semi public for serialization of non timekeeper VDSO updates. */



