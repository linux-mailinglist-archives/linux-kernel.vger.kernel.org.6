Return-Path: <linux-kernel+bounces-424826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6BFE9DB9EF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 15:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A29E164C45
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 14:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAF01B4F10;
	Thu, 28 Nov 2024 14:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RL1yVVgq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7g8/gnqn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C607E1B3F3D
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 14:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732805510; cv=none; b=jaNFrTugIIP9p2d5ZqjRYq9BzfPv2OreK7TBmcHirmSo3UtVipNZM1AcmbExSPzV56xv04o3tIdkMkMwgOFhilfShcpQcOeiKxy5/vyIctwU+NzBY0d0jNOFXtKQ6TOZDV2KJf+kqOchl9k0ZbUd9udr7VLzTmWiIUwGC4TcYbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732805510; c=relaxed/simple;
	bh=cO94tHvqgaICl04ZRxTb810L3Ym+y8yFDgU7H0ViUyQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tAe8fpa1VANBm0L3UcCsNGQ6KOjy9m3jVbfTiFYvt/0rUjNjKWA1ncelDMQAVqHWAk+J32zHhczwEQlODpVn5QylOQJw2EbZyDS/lVTt90nY8NM+h5QdAK4BlzELzIiW9Pilb7laL299X17s8DbRFkabrUctdgj3BNlxJDgOMok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RL1yVVgq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7g8/gnqn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732805501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uYcDokw3hL3uBCkO0VJZW6TcchgM+Z6awwYJW0ch9c0=;
	b=RL1yVVgqw5AigdPZk6ogg+UEWXZi60rgzPZmYlDE4rY54PQ/Xt1ByaR5FFVPRm5ZaT/xJn
	i3rl59J5ZWCBk3pYTXX97vTCzKcvi/Ts3KbeGP5agj5KJ585tHoxmYkvOroPN1lEOpjFNC
	guJV1+YRvDn1uYtearO5WP6c6ewUT5ljnuDdAV2kUwCInjHR3fAGFBbFWrLWZI+REmyM1l
	m2L6sl3g6ozXig6CEAaCptVtJo98QrEXHoUeQJdNlaLpmBqrQ/kst/VpE5cCk1w3zaJbhF
	6Wr2yrnOrsDxdQti17IelS+s9a3+Np3HLK7NeDVVljfvw7cZ2FJoCoKmP0mU1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732805501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uYcDokw3hL3uBCkO0VJZW6TcchgM+Z6awwYJW0ch9c0=;
	b=7g8/gnqnl4R95RfwTl3MF7Bap6pnJVLc5ozhXkbRL0bIMJsSqwvl++aQRtfGjs8onDJD6D
	ZCALbIIL1rX+nPDQ==
To: Guenter Roeck <linux@roeck-us.net>, John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 2/2] timekeeping: Always check for negative motion
In-Reply-To: <65b412ef-fc57-4988-bf92-3c924a1c74a5@roeck-us.net>
References: <20241031115448.978498636@linutronix.de>
 <20241031120328.599430157@linutronix.de>
 <387b120b-d68a-45e8-b6ab-768cd95d11c2@roeck-us.net>
 <CANDhNCo1RtcfqUJsuAQ+HdS7E29+gByfek5-4KYiAk3Njk4M3Q@mail.gmail.com>
 <65b412ef-fc57-4988-bf92-3c924a1c74a5@roeck-us.net>
Date: Thu, 28 Nov 2024 15:51:40 +0100
Message-ID: <87cyifxvgj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Nov 27 2024 at 15:02, Guenter Roeck wrote:
> On 11/27/24 14:08, John Stultz wrote:
> An example log is at [1]. It says
>
> clocksource: npcm7xx-timer1: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 597268854 ns

That's a 24bit counter. So negative motion happens when the readouts are
more than (1 << 23) apart. AFAICT the counter runs with about 14MHz, but
I'd like to have that confirmed.

> clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
> ...
> clocksource: Switched to clocksource npcm7xx-timer1
>
> I don't know where exactly it stalls; sometime after handover to userspace.
> I'll be happy to do some more debugging, but you'll nee to let me know what
> to look for.

On that platform max_idle_ns should correspond to 50% of the counter
width. So if both CPUs go deep idle for max_idle_ns, then the next timer
interrupt doing the timeeeping advancement sees a delta of > (1 << 23)
and timekeeping stalls.

If my ssumption is correct, then the below should fix it.

Thanks,

        tglx
---
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2221,7 +2221,7 @@ static bool timekeeping_advance(enum tim
 	struct timekeeper *real_tk = &tk_core.timekeeper;
 	unsigned int clock_set = 0;
 	int shift = 0, maxshift;
-	u64 offset;
+	u64 offset, maxcyc;
 
 	guard(raw_spinlock_irqsave)(&tk_core.lock);
 
@@ -2229,8 +2229,13 @@ static bool timekeeping_advance(enum tim
 	if (unlikely(timekeeping_suspended))
 		return false;
 
-	offset = clocksource_delta(tk_clock_read(&tk->tkr_mono),
-				   tk->tkr_mono.cycle_last, tk->tkr_mono.mask);
+	offset = tk_clock_read(&tk->tkr_mono) - tk->tkr_mono.cycle_last;
+	offset &= tk->tkr_mono.mask;
+
+	maxcyc = tk->tkr_mono.mask >>= 1;
+	maxcyc += tk->tkr_mono.mask >>= 2;
+	if (offset > maxcyc)
+		offset = 0;
 
 	/* Check if there's really nothing to do */
 	if (offset < real_tk->cycle_interval && mode == TK_ADV_TICK)

