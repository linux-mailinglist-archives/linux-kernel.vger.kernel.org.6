Return-Path: <linux-kernel+bounces-562035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C97A61ADF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 20:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE0A3BA719
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 19:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDE81FDA9C;
	Fri, 14 Mar 2025 19:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cFhy9qQZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KAb/hd3x"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1CC17D2
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 19:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741981311; cv=none; b=sWiLGXBDB1Rfe6CPzKJRXoerkihkS5rFLjUQIYfNVqLA+Rw77Izj4uKMazSAZmvxmRmD8PS3pyAw+EFQrC33NxiBl1jbkNqCxCPqTrFTV5Rxvgrc4/qHN9r+H6OFLc47YCh/PVa2G681IxXdjOAt7CsfyRFsD0f7xynTyRjGg3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741981311; c=relaxed/simple;
	bh=I5zRzBukRd+sPNRxLV1pBxskGkOy5QpLReQ1XY2mw+4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=jryCkpSCyKzEA+Y4p0d+EcaplgUsO3WsyvWlpF52oqyNDhH5TzVlDS2gmdoyP+DPStDUcuGwwSUCrfQN5O6ogKZCnTekEgc1JFzkYWboMxcvIEoYcyMnhbwk8ZwI4v9KXd+4qaTHTLfHBK9smR0p75iZxSOIWW6GzWSbd67nMIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cFhy9qQZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KAb/hd3x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741981307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=U/NEj9UEXf7erMJdW3z69NTMfU74LOgpxZ6Yda3gDLU=;
	b=cFhy9qQZgxi+aSw9KEv+knjK57ALfhpkyJe3atfwUU4EdHyV/OR6+eu4qcYL2+hTu4sPst
	CSevpQVnPv1Ic6V5KqPF4F64KnkcmZKRpMiQx3cl67veCEBkp47K35HFZgEuMNRBHlk27a
	oTen0PnL7wXPKkKwr7a+ohqxgHhd//p8/JofxMv0Czf2avuv62NidpXTIaCD5tFOGKy8OQ
	XaInK0UEwyU6CySOm89ePtFlTxEhHVjxuMy88VYG+Otv4T3SnvsHAhuaVCcTVXk9BduNDc
	iMxWEml44E9y4hhCXlpUxz1QCg5jXVOBPYmH0QYe3dPisYPZeIfH85Ptl4r+Hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741981307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=U/NEj9UEXf7erMJdW3z69NTMfU74LOgpxZ6Yda3gDLU=;
	b=KAb/hd3xoxRh7cU82L9CRhMcyB4Xn1mB58Yzf4BdMDTohjHUTw2N585vDe3goPw7mRN5Mm
	Kly74dOaSnV/oLDw==
To: Lei Chen <lei.chen@smartx.com>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix rolling back of CLOCK_MONOTONIC_COARSE
In-Reply-To: <20250310030004.3705801-1-lei.chen@smartx.com>
Date: Fri, 14 Mar 2025 20:41:46 +0100
Message-ID: <87cyej5rid.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Mar 10 2025 at 11:00, Lei Chen wrote:
> To fix this issue, the patch accumulates offset into tk, and export
> N(P2) to real tk and vdso.
>
> tk.tkr_mono := N(P2) = N(P1) + offset * M1
>
> Then at P3, we calculate N(P3) based on N(P2) instead of N(P1):
> N(P3) := N(P2) + clock_delta * M2

Your analysis is mostly correct, but it is only correct versus the
coarse timekeeper.

Moving everything forward to P2 breaks the periodic accumulation and
therefore NTP. Monitoring NTP/chrony immediately shows that they are
behaving differently and do not really converge.

The real problem is that the introduction of the coarse time accessors
completely missed the fact, that xtime_nsec is adjusted by multiplier
changes. This went unnoticed for about 15 years :)

So the obvious cure is to leave the accumulation logic alone and to
provide a seperate coarse_nsec instance, which compensates for the
offset.

The offset contains the reminder of the periodic accumulation from the
point where timekeeping_advance() read the clocksource at T1.

At the point of readout T1 nanoseconds have been:

     T1nsec[OLD] = xtime_sec[OLD] * NSEC_PER_SEC +
                   (xtime_nsec[OLD] + offset * mult[OLD]) >> shift;

After the accumulation and eventual multiplier update that becomes:

     T1nsec[NEW] = xtime_sec[NEW] * NSEC_PER_SEC +
                   (xtime_nsec[NEW] + offset * mult[NEW]) >> shift;

If the unmodified accumulation math is correct then:

     T1nsec[OLD] == T1nsec[NEW]

The patch below implements exactly that and survives lightweight testing
where neither in kernel nor in userspace these time jumps are
observable anymore.

It needs quite some eyeballs, testing and validation.

Thanks,

        tglx
---
Subject: timekeeping: Decouple coarse time readout from xtime
From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 14 Mar 2025 14:15:59 +0100

< Insert change log>

Fixes: da15cfdae033 ("time: Introduce CLOCK_REALTIME_COARSE")
Reported-by: Lei Chen <lei.chen@smartx.com>
Not-Yet-Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/timekeeper_internal.h |    8 +++--
 kernel/time/timekeeping.c           |   54 ++++++++++++++++++++++++++++++++----
 kernel/time/vsyscall.c              |    4 +-
 3 files changed, 55 insertions(+), 11 deletions(-)

--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -51,7 +51,7 @@ struct tk_read_base {
  * @offs_real:			Offset clock monotonic -> clock realtime
  * @offs_boot:			Offset clock monotonic -> clock boottime
  * @offs_tai:			Offset clock monotonic -> clock tai
- * @tai_offset:			The current UTC to TAI offset in seconds
+ * @coarse_nsec:		The nanoseconds part for coarse time getters
  * @tkr_raw:			The readout base structure for CLOCK_MONOTONIC_RAW
  * @raw_sec:			CLOCK_MONOTONIC_RAW  time in seconds
  * @clock_was_set_seq:		The sequence number of clock was set events
@@ -76,6 +76,7 @@ struct tk_read_base {
  *				ntp shifted nano seconds.
  * @ntp_err_mult:		Multiplication factor for scaled math conversion
  * @skip_second_overflow:	Flag used to avoid updating NTP twice with same second
+ * @tai_offset:			The current UTC to TAI offset in seconds
  *
  * Note: For timespec(64) based interfaces wall_to_monotonic is what
  * we need to add to xtime (or xtime corrected for sub jiffy times)
@@ -100,7 +101,7 @@ struct tk_read_base {
  * which results in the following cacheline layout:
  *
  * 0:	seqcount, tkr_mono
- * 1:	xtime_sec ... tai_offset
+ * 1:	xtime_sec ... coarse_nsec
  * 2:	tkr_raw, raw_sec
  * 3,4: Internal variables
  *
@@ -121,7 +122,7 @@ struct timekeeper {
 	ktime_t			offs_real;
 	ktime_t			offs_boot;
 	ktime_t			offs_tai;
-	s32			tai_offset;
+	u32			coarse_nsec;
 
 	/* Cacheline 2: */
 	struct tk_read_base	tkr_raw;
@@ -144,6 +145,7 @@ struct timekeeper {
 	u32			ntp_error_shift;
 	u32			ntp_err_mult;
 	u32			skip_second_overflow;
+	s32			tai_offset;
 };
 
 #ifdef CONFIG_GENERIC_TIME_VSYSCALL
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -164,10 +164,20 @@ static inline struct timespec64 tk_xtime
 	return ts;
 }
 
+static inline struct timespec64 tk_xtime_coarse(const struct timekeeper *tk)
+{
+	struct timespec64 ts;
+
+	ts.tv_sec = tk->xtime_sec;
+	ts.tv_nsec = tk->coarse_nsec;
+	return ts;
+}
+
 static void tk_set_xtime(struct timekeeper *tk, const struct timespec64 *ts)
 {
 	tk->xtime_sec = ts->tv_sec;
 	tk->tkr_mono.xtime_nsec = (u64)ts->tv_nsec << tk->tkr_mono.shift;
+	tk->coarse_nsec = tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
 }
 
 static void tk_xtime_add(struct timekeeper *tk, const struct timespec64 *ts)
@@ -175,6 +185,7 @@ static void tk_xtime_add(struct timekeep
 	tk->xtime_sec += ts->tv_sec;
 	tk->tkr_mono.xtime_nsec += (u64)ts->tv_nsec << tk->tkr_mono.shift;
 	tk_normalize_xtime(tk);
+	tk->coarse_nsec = tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
 }
 
 static void tk_set_wall_to_mono(struct timekeeper *tk, struct timespec64 wtm)
@@ -708,6 +719,8 @@ static void timekeeping_forward_now(stru
 		tk_normalize_xtime(tk);
 		delta -= incr;
 	}
+
+	tk->coarse_nsec = tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
 }
 
 /**
@@ -804,8 +817,8 @@ EXPORT_SYMBOL_GPL(ktime_get_with_offset)
 ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
-	unsigned int seq;
 	ktime_t base, *offset = offsets[offs];
+	unsigned int seq;
 	u64 nsecs;
 
 	WARN_ON(timekeeping_suspended);
@@ -813,7 +826,7 @@ ktime_t ktime_get_coarse_with_offset(enu
 	do {
 		seq = read_seqcount_begin(&tk_core.seq);
 		base = ktime_add(tk->tkr_mono.base, *offset);
-		nsecs = tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
+		nsecs = tk->coarse_nsec;
 
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
@@ -1926,6 +1939,33 @@ static int __init timekeeping_init_ops(v
 device_initcall(timekeeping_init_ops);
 
 /*
+ * Update the nanoseconds part for the coarse time keepers. They can't rely
+ * on xtime_nsec because xtime_nsec is adjusted when the multiplication
+ * factor of the clock is adjusted. See timekeeping_apply_adjustment().
+ *
+ * This is required because tk_read::cycle_last must be advanced by
+ * timekeeper::cycle_interval so that the accumulation happens with a
+ * periodic reference.
+ *
+ * But that adjustment of xtime_nsec can make it go backward to compensate
+ * for a larger multiplicator.
+ *
+ * @offset contains the leftover cycles which were not accumulated.
+ * Therefore the nanoseconds portion of the time when the clocksource was
+ * read in timekeeping_advance() is:
+ *
+ *	nsec = (xtime_nsec + offset * mult) >> shift;
+ *
+ * Calculate that value and store it in timekeeper::coarse_nsec, from where
+ * the coarse time getters consume it.
+ */
+static inline void timekeeping_update_coarse_nsecs(struct timekeeper *tk, u64 offset)
+{
+	offset *= tk->tkr_mono.mult;
+	tk->coarse_nsec = (tk->tkr_mono.xtime_nsec + offset) >> tk->tkr_mono.shift;
+}
+
+/*
  * Apply a multiplier adjustment to the timekeeper
  */
 static __always_inline void timekeeping_apply_adjustment(struct timekeeper *tk,
@@ -2205,6 +2245,8 @@ static bool timekeeping_advance(enum tim
 	 */
 	clock_set |= accumulate_nsecs_to_secs(tk);
 
+	timekeeping_update_coarse_nsecs(tk, offset);
+
 	timekeeping_update_from_shadow(&tk_core, clock_set);
 
 	return !!clock_set;
@@ -2248,7 +2290,7 @@ void ktime_get_coarse_real_ts64(struct t
 	do {
 		seq = read_seqcount_begin(&tk_core.seq);
 
-		*ts = tk_xtime(tk);
+		*ts = tk_xtime_coarse(tk);
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 }
 EXPORT_SYMBOL(ktime_get_coarse_real_ts64);
@@ -2271,7 +2313,7 @@ void ktime_get_coarse_real_ts64_mg(struc
 
 	do {
 		seq = read_seqcount_begin(&tk_core.seq);
-		*ts = tk_xtime(tk);
+		*ts = tk_xtime_coarse(tk);
 		offset = tk_core.timekeeper.offs_real;
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
@@ -2350,12 +2392,12 @@ void ktime_get_coarse_ts64(struct timesp
 	do {
 		seq = read_seqcount_begin(&tk_core.seq);
 
-		now = tk_xtime(tk);
+		now = tk_xtime_coarse(tk);
 		mono = tk->wall_to_monotonic;
 	} while (read_seqcount_retry(&tk_core.seq, seq));
 
 	set_normalized_timespec64(ts, now.tv_sec + mono.tv_sec,
-				now.tv_nsec + mono.tv_nsec);
+				  now.tv_nsec + mono.tv_nsec);
 }
 EXPORT_SYMBOL(ktime_get_coarse_ts64);
 
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -97,12 +97,12 @@ void update_vsyscall(struct timekeeper *
 	/* CLOCK_REALTIME_COARSE */
 	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_REALTIME_COARSE];
 	vdso_ts->sec	= tk->xtime_sec;
-	vdso_ts->nsec	= tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
+	vdso_ts->nsec	= tk->coarse_nsec;
 
 	/* CLOCK_MONOTONIC_COARSE */
 	vdso_ts		= &vdata[CS_HRES_COARSE].basetime[CLOCK_MONOTONIC_COARSE];
 	vdso_ts->sec	= tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
-	nsec		= tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
+	nsec		= tk->coarse_nsec;
 	nsec		= nsec + tk->wall_to_monotonic.tv_nsec;
 	vdso_ts->sec	+= __iter_div_u64_rem(nsec, NSEC_PER_SEC, &vdso_ts->nsec);
 



     


