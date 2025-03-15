Return-Path: <linux-kernel+bounces-562484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 097D2A62989
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 10:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 309C43BF4E2
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 09:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 982791DED5F;
	Sat, 15 Mar 2025 09:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2rrReDy6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FBsATca/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841451D63C2
	for <linux-kernel@vger.kernel.org>; Sat, 15 Mar 2025 09:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742029594; cv=none; b=Vfm3MoRmAQfaLGB3lWpLVUe/R7S0mPZHa71pPHo0T1NzyGhiBz4Yg8+zkXGVRAqv4n5ws0z5onkMRTG4quU1cAT4hQlldlsBUbIIg8fL7T41+wj3wQW007POx8tgwf+fOqDMMbnO+6yjCQ0xf5+AWOnvba1SPf3hTY4JbdrWLNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742029594; c=relaxed/simple;
	bh=d/CXp+WliNO0b6P7imGFhRmG6bqOxjNn+OydHxTYnu4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WSQiPHeBfTrA0Ol7GvEX/x1wHKrLbfl8UYQGKilxysg07vTsmllA4lfw4Ohiuf35S/tScajunPDX/LaKBHH8GtNiJp/DLxfD0YCeo+/iZozYXwRvay8S9Vq2queSnVKSDREt/QIyrdv92RWLsqtgxEgbizGbxxe4mSjhN7K/l58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2rrReDy6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FBsATca/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742029589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v3+a6j5FRQ26omtQSu+g3bAUVWDDMpEpN4tV0oeJPYA=;
	b=2rrReDy6AZDqPVG6MpAGp3D7BE+yeAvvb9rL1RAEiw+oho4UCN0LiLcZ/vOFu4fp9T0L+u
	yPgYOFiIg9kGyUORb03VP8Y7dRBb1eIBJSXvC/Iz3ml1PtKSJS9zYMFb0rkriWL7+NnRg8
	IbleEFmdMwtR3/ksG66JNC05dDjQveFKD/5F1q6Oks+gXWipLlcaTpNRggo4dnb9fQJxZd
	33K8al7JGq1TCiTdnWUBRYOXzDOUlX+iPE/znsfAiqdNuO15LZh38mVZGvXCtSYHIQODxc
	Zzx5KGHg6An93GAU359broflewr186qQRc3wBmZGDovhxHefmSfD5CeoJtcBVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742029589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v3+a6j5FRQ26omtQSu+g3bAUVWDDMpEpN4tV0oeJPYA=;
	b=FBsATca/+KxL8IwPpKJvF8N8f/1v0CejmXt2eQc8i2ceWkU2P/utslxufv9OSVGfg/yi3T
	5pvWIEgFx//o2bCQ==
To: John Stultz <jstultz@google.com>, Lei Chen <lei.chen@smartx.com>
Cc: Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix rolling back of CLOCK_MONOTONIC_COARSE
In-Reply-To: <CANDhNCpSB5HzMHne94rnGEi+=yd1Q2j+pJX8pdX5RbEojwpZcA@mail.gmail.com>
References: <20250310030004.3705801-1-lei.chen@smartx.com>
 <CANDhNCoRxxA-CxOQ6vxfjf6BDxR-gqCC_QE1wwf4L3gwrvfv6A@mail.gmail.com>
 <CAKcXpBwvjrmoPnfFgaXs81XF5du-mWzLiJ+8YvvhM_1tQMiZBQ@mail.gmail.com>
 <CANDhNCpSB5HzMHne94rnGEi+=yd1Q2j+pJX8pdX5RbEojwpZcA@mail.gmail.com>
Date: Sat, 15 Mar 2025 10:06:28 +0100
Message-ID: <87a59m64tn.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14 2025 at 12:21, John Stultz wrote:
> On Thu, Mar 13, 2025 at 11:32=E2=80=AFPM Lei Chen <lei.chen@smartx.com> w=
rote:
> My suspicion is that if we are coming into timekeeping_advance() more
> frequently then cycle_interval cycles, than its possible we didn't
> actually accumulate anything, but had some left over ntp error that
> triggered a mult adjustment, causing a xtime_nsec to be decremented
> without the normal accumulation before that. Opening up a window for
> the inconsistency.
>
> The "if (offset < real_tk->cycle_interval && mode =3D=3D TK_ADV_TICK)"
> check there is supposed to catch that, but with
> timekeeping_advance(TK_ADV_FREQ) it looks like during an ntp
> adjustment we can try to do the mult adjustment without accumulation.

Even if the delta is > cycle_interval in the normal TK_ADV_TICK case,
then the accumulation will always have a leftover offset.

After accumulation timekeeping_advance() invokes timekeeping_adjust(offset).

timekeeping_adjust() does multiplier adjustment based on [NTP] tick
length and ntp error. That's completely independent of TV_ADV_FREQ.

So _ANY_ adjustment of the multiplier has to adjust xtime_nsec so that

     T1nsec[OLD] =3D xtime_sec[OLD] * NSEC_PER_SEC +
		   (xtime_nsec[OLD] + offset * mult[OLD]) >> shift;

     T1nsec[NEW] =3D xtime_sec[NEW] * NSEC_PER_SEC +
		   (xtime_nsec[NEW] + offset * mult[NEW]) >> shift;

results in:

     T1nsec[OLD] =3D=3D T1nsec[NEW]

So while Lei's change fulfils that requirement by advancing xtime_nsec
so that this becomes:

     T1nsec[NEW] =3D xtime_sec[NEW] * NSEC_PER_SEC +
                   xtime_nsec[NEW] >> shift;

it changes a fundamental property of the timekeeping code:

  cycles_last has to be incremented by multiples of cycles_interval to
  ensure that the accumulation, on which the NTP correction relies, has
  a periodic base. That allows to steer the clock in a coordinated way
  against ntp_tick_length and guarantees smooth error accumulation.

With Lei's changes this property is lost because every multiplicator
adjustment moves cycles_last around by the random offset which happened
to be left over in the accumulation. So the period of cycles_last
advancement gets lost and becomes a self modifying random number
generator depening on the size of the reminder (offset).

Now coming back to your suspicion that this is related to TK_ADV_FREQ.
That's one way to trigger it, but even the regular steering algorithm,
which smoothes the multplicator adjustment with

           mult [+-] =3D 1

exposes this because there is no guarantee that the remaining offset is
small enough to be not visible. All it takes is:

      (offset >> shift) >=3D 1

which means it's greater than or equal one nanosecond. Assume a clock
frequency of 1GHz. Then

      mult ~=3D shift

So all it takes is to hit timekeeping_advance() at a point in time where
the reminder is becomes greater than shift, which is pretty much
guaranteed to happen with NOHZ on a fully idle system.

In the 1GHz clock frequency case and HZ=3D100 and the in use

   shift =3D 1 << 23 =3D 8388608

this opens a window of ~1.62 milliseconds, which is easy enough to
hit. It does not even require NOHZ because in the NTP steering case the
period of the tick is not longer the same as the cycle_interval. Which
means that the reminder slightly increases per tick and hits the window
where the reminder becomes large enough roughly once per second.

I've instrumented timekeeping_advance() accordingly and the
trace_printk() nicely fills the trace buffer over time with xtime_nsec
going backwards. Except for the TK_ADV_FREQ case, this is always just
one nanosecond, but it's one nanosecond too much.

As I said in the previous mail, the fundamental flaw of the coarse time
getters is the assumption that xtime_sec + xtime_nsec does not go
backwards (except when the clock was set).

That's not the case and we can't change that without rewriting the
accumulation algorithm. I looked at the math required and it becomes a
total nightmare to compensate for that. I really don't have any
interrest in chasing the resulting NTP regressions for the next year
just for that.

Providing a seperate and accurate coarse_nsec value is easy enough and
does not touch any of the well established and correct accumulation and
steering code at all.

Thanks,

        tglx

