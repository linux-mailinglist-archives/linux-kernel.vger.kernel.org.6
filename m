Return-Path: <linux-kernel+bounces-319952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE9B97042F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 23:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC9231C21070
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 21:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF3815F3E2;
	Sat,  7 Sep 2024 21:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S4IeI0Di";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9Lij9/0M"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BCB4D8CC
	for <linux-kernel@vger.kernel.org>; Sat,  7 Sep 2024 21:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725745380; cv=none; b=D2p7po6jhN9oTFiGkHRAPcSqU7OBp8HNQSB6MU5efAsNontGTM0sgyH7c1+2mQOMlBKbR5ae1g72mqjVA3o1SGC8gYzsV9Zwz/GmG7xa/majD9+3miEUZY5WYVxl+nC+r+I/RNgJRFi3wr4B5jwsDzrcU35Mw20xV4rxyzPjXEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725745380; c=relaxed/simple;
	bh=bjbPCO68YLHhkgYfrDrDyRt0yZU0ge1MbX416yNBvuI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lRz1Z2sx6hkxMQZfoQkzQmjuHU4mpI4P5LzXJLbz5mEhg8nKkwJzJSCbkQh+WoTYP1015eImFu0P1I/vwAaim4FrA/4oebNhDE8P2SkB+7e88039N50tYP3APn1rw+PBDTJB+QyPS8GaHz6i5M9Q73ePSASpxZjIEGbdILE1PYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S4IeI0Di; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9Lij9/0M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725745376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CVupB2mbltBc0lxUjnNEmFbRfMK7S2DGGlQjSHZXftw=;
	b=S4IeI0Dimi8IMv4y4HsEudazKLF0K9mwPnNq7JvDSnbSlmE4zgQ7vinZNVKRNnNlwKl13c
	y8PiKYMP5gm91WIS7eqZMHgsFOkILwO05tqFiwaTx3YDisqBPZi4S4JV2DxONBWzfU/eET
	kzaE5s4BftjtvEWlgqpA+wEeZ+7J/i/Zjc1p78rKoTGjeQC/LNh6TzHQiZzOzH29ugQWFk
	w11ojcjXOymQFXwNSe3NHN9dUi1rIdlEusuRO9Hz5fO7GnX7FwTQMU9DOSKCMWpOeShzcR
	MCaP3suot3pb2JIAPBADufL+gc94Yhf8LKZqtzYEC0m1Dvfy+o6bxZzMF9B6Fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725745376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CVupB2mbltBc0lxUjnNEmFbRfMK7S2DGGlQjSHZXftw=;
	b=9Lij9/0MwiwSEiOOrL605TaeMFfMufgTDZonpfdLznsw0SgcRgRXdOAFafIBOqOXnOITBL
	pwKfhw5gawzE3EAQ==
To: Benjamin ROBIN <dev@benjarobin.fr>, jstultz@google.com
Cc: sboyd@kernel.org, linux-kernel@vger.kernel.org, Benjamin ROBIN
 <dev@benjarobin.fr>
Subject: Re: [PATCH] ntp: Make sure RTC is synchronized when time goes
 backwards
In-Reply-To: <20240907190900.55421-1-dev@benjarobin.fr>
References: <20240907190900.55421-1-dev@benjarobin.fr>
Date: Sat, 07 Sep 2024 23:42:55 +0200
Message-ID: <87zfojcf8g.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Sep 07 2024 at 21:09, Benjamin ROBIN wrote:
> The "sync_hw_clock" is normally called every 11 minutes when time is

s/The "sync_hw_clock"/sync_hw_clock()/

See: https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#function-references-in-changelogs

> synchronized. This issue is that this periodic timer uses the REALTIME
> clock, so when time moves backwards (the NTP server jumps into the past),
> the next call to "sync_hw_clock" could be realized after a very long

s/the next .../the timer expires late./

And then please explain what the consequence is when it expires
late. See the changelog section of the above link.

> period.

Cute.

> A normal NTP server should not jump in the past like that, but it is
> possible... Another way to reproduce this issue is using phc2sys to
> synchronize the REALTIME clock with for example an IRIG timecode with
> the source always starting at the same date (not synchronized).
>
> This patch cancels the periodic timer on a time jump (ADJ_SETOFFSET).

s/This patch cancels/Cancel/

For explanation:
# git grep 'This patch' Documentation/process 

> The timer will be relaunched at the end of "do_adjtimex" if NTP is still
> considered synced. Otherwise the timer will be relaunched later when NTP
> is synced. This way, when the time is synchronized again, the RTC is
> updated after less than 2 seconds.
>
> Signed-off-by: Benjamin ROBIN <dev@benjarobin.fr>
> ---
>  kernel/time/ntp.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
> index 8d2dd214ec68..5c8dd92cf012 100644
> --- a/kernel/time/ntp.c
> +++ b/kernel/time/ntp.c
> @@ -751,6 +751,9 @@ static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
>  
>  	if (txc->modes & (ADJ_TICK|ADJ_FREQUENCY|ADJ_OFFSET))
>  		ntp_update_frequency();
> +
> +	if (txc->modes & ADJ_SETOFFSET)
> +		hrtimer_cancel(&sync_hrtimer);

Did you test this with lockdep enabled?

The caller holds timekeeping_lock and has the time keeper sequence write
held. There is an existing dependency chain which is invers. Assume the
sync_hrtimer is queued on a different CPU, CPU1 in this example:

CPU 0                                       CPU1

lock(&timekeeper_lock);                     lock_hrtimer_base(CPU1);    

write_seqcount_begin(&tk_core.seq); <- Makes tk_core.seq odd

__do_adjtimex()
  process_adjtimex_modes()                  base->get_time()
    hrtimer_cancel()                          do {
      hrtimer_try_to_cancel()                       seq = read_seqcount_begin(&tk_core.seq);
        lock_hrtimer_base(CPU1);                          ^^^
        ^^^ deadlock                                      Spin waits for tk_core.seq
                                                          to become even

You can do that cancel only outside of timekeeper_lock:

--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2426,6 +2426,7 @@ int do_adjtimex(struct __kernel_timex *t
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	struct audit_ntp_data ad;
+	bool offset_set = false;
 	bool clock_set = false;
 	struct timespec64 ts;
 	unsigned long flags;
@@ -2448,6 +2449,7 @@ int do_adjtimex(struct __kernel_timex *t
 		if (ret)
 			return ret;
 
+		offset_set = delta.tv_sec < 0;
 		audit_tk_injoffset(delta);
 	}
 
@@ -2481,7 +2483,7 @@ int do_adjtimex(struct __kernel_timex *t
 	if (clock_set)
 		clock_was_set(CLOCK_REALTIME);
 
-	ntp_notify_cmos_timer();
+	ntp_notify_cmos_timer(offset_set);
 
 	return ret;
 }

Now you can fix that up in ntp_notify_cmos_timer() which is outside of
the timekeeper_lock held region for the very same reason and it's the
proper place to do that.

Thanks,

        tglx

