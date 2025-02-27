Return-Path: <linux-kernel+bounces-536132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A993A47BDF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:20:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175FD161490
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1021622D78E;
	Thu, 27 Feb 2025 11:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/OI7Ljr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E30322C35C;
	Thu, 27 Feb 2025 11:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740655113; cv=none; b=jbnMy8c45Z92iFnNMy1FWc3BOuv3NOkukFyMlRjeoR4jqiYYceB8KWEhC2js7alwhy58vLuYvqQl3qVu0Zyj2BciJIVU6PYIhUKVrdkXAA/M+hJnj2buM2tDDuNJJGI2aed/vQiYyP7l+Oi4f0ZblsC5/NPJ83EKBQIZCfjYJ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740655113; c=relaxed/simple;
	bh=JXgvvPrYeF0pvduPQJMNtLcDXB27r3C6+JTUA7Dp/OI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NCyQ6TH/SleDDDyHXrMlbgoBjURJcNI0Wie99xVZPt2rhPy1wTadGPSkX/DHW0GYcBv31IiJIeh9yTi4JdVHNZcfsnunPYHrLZFxnbHTrhIEy7u680gpiIb45n8cR/4xsOuhPRZftnM8Arwiv35DVBjlDkI2VcJe/bKLNJH/n6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/OI7Ljr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C3CC4CEE4;
	Thu, 27 Feb 2025 11:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740655112;
	bh=JXgvvPrYeF0pvduPQJMNtLcDXB27r3C6+JTUA7Dp/OI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=F/OI7LjrEZzNm7VvUX1asI6hfhWUistr0YMl3SHX1levzAllzAYOzb48FBSq2bgyG
	 wPqYj2AOzUK+1qhxOca8fiA+wVIHAV6VcECouBA0SeXnCXt8J8VxbsKQxXHvIjpxSL
	 qNpJMNAvNT/Hji+Td6QdtZ/D9UBENOiufz7l9MKxmotjJtFukhC5r+wrpfBYFvP4/H
	 7Oit4OorSas62rBsPMvufIZSKnhbqlUdVjDCpIJ3qfLKL8p1PQNYw/rzLJoTesd4zA
	 TUVPGYh300UGcKXBdCwDmpLAOs7T7N5+8UjXRg045u5UGRh1sADJqnb+E/ZBJr4ZDq
	 P/E+WNwegdlWg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Thomas Gleixner" <tglx@linutronix.de>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Danilo Krummrich" <dakr@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  "Lyude Paul" <lyude@redhat.com>,
  "Guangbo Cui" <2407018371@qq.com>,  "Dirk Behme" <dirk.behme@gmail.com>,
  "Daniel Almeida" <daniel.almeida@collabora.com>,  "Tamir Duberstein"
 <tamird@gmail.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 12/13] rust: hrtimer: add clocksource selection
 through `ClockSource`
In-Reply-To: <87jz9beor7.ffs@tglx> (Thomas Gleixner's message of "Thu, 27 Feb
	2025 10:11:08 +0100")
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
	<20250224-hrtimer-v3-v6-12-rc2-v9-12-5bd3bf0ce6cc@kernel.org>
	<6sz8JD2Jq54KZZ3nCKbMpvae2yHUmF2hHEP3qrQlbGY6RrWzS8BN5YxinlIQnIFkGfjAPauTxI8i3sZUhzoPiw==@protonmail.internalid>
	<87jz9beor7.ffs@tglx>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Thu, 27 Feb 2025 12:18:09 +0100
Message-ID: <87zfi7prf2.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Thomas Gleixner" <tglx@linutronix.de> writes:

> On Mon, Feb 24 2025 at 13:03, Andreas Hindborg wrote:
>>
>> +/// The clock source to use for a [`HrTimer`].
>> +pub enum ClockSource {
>
> ClockSource is a confusing name as 'clocksource' is used in the kernel
> already for devices providing counters, which can be used for
> timekeeping.
>
> Also these clocks are not really hrtimer specific. These CLOCK ids are
> system wide valid and are used for other purposes obviously internally
> in timekeeping. hrtimers are built on top of timekeeping, which provides
> the underlying time.

I see. How about renaming to `ClockId` and moving the type one level up
to `kernel::time`?

>
>> +    /// A settable system-wide clock that measures real (i.e., wall-clo=
ck) time.
>> +    ///
>> +    /// Setting this clock requires appropriate privileges. This clock =
is
>> +    /// affected by discontinuous jumps in the system time (e.g., if th=
e system
>> +    /// administrator manually changes the clock), and by frequency adj=
ustments
>> +    /// performed by NTP and similar applications via adjtime(3), adjti=
mex(2),
>> +    /// clock_adjtime(2), and ntp_adjtime(3). This clock normally count=
s the
>> +    /// number of seconds since 1970-01-01 00:00:00 Coordinated Univers=
al Time
>> +    /// (UTC) except that it ignores leap seconds; near a leap second i=
t is
>> +    /// typically adjusted by NTP to stay roughly in sync with UTC.
>
> That's not correct. It depends on the implementation/configuration of
> NTP. The default is that the leap second is actually applied at the
> requested time, by setting the clock one second forth or back.
>
> Though there are NTP configurations/implementations out there which use
> leap second "smearing" to avoid the jump. They adjust the conversion
> factors around the leap second event by slowing down or speeding up for
> a while. That avoids a few common issues, e.g. in data bases.
>
> But it brings all clocks out of sync with the actual progress of time, wh=
ich
> is patently bad for systems which require strict synchronization.
>
> The problem is that the kernel uses the NTP/PTP frequency adjustment to
> steer the conversion of all clocks, except CLOCK_MONOTONIC_RAW. The
> kernel internal base clock is CLOCK_MONOTONIC. The other clocks are
> derived from that:
>
>         CLOCK_[X] =3D CLOCK_MONOTONIC + offset[X]

I see. I lifted the text from `clock_getres(2)` in linux-man [1]. We
might consider updating that source with the info we collect here.

How about changing the text like so:

.. by frequency adjustments performed by NTP ...

to

.. by frequency adjustments performed by some implementations of NTP ...

?

>
>> +    RealTime,
>> +    /// A monotonically increasing clock.
>> +    ///
>> +    /// A nonsettable system-wide clock that represents monotonic time =
since=E2=80=94as
>> +    /// described by POSIX=E2=80=94"some unspecified point in the past"=
 On Linux, that
>> +    /// point corresponds to the number of seconds that the system has =
been
>> +    /// running since it was booted.
>> +    ///
>> +    /// The CLOCK_MONOTONIC clock is not affected by discontinuous jump=
s in the
>> +    /// system time (e.g., if the system administrator manually changes=
 the
>
> s/system time/CLOCK_REALTIME/

OK.

>
>> +    /// clock), but is affected by frequency adjustments. This clock do=
es not
>> +    /// count time that the system is suspended.
>> +    Monotonic,
>> +    /// A monotonic that ticks while system is suspended.
>> +    ///
>> +    /// A nonsettable system-wide clock that is identical to CLOCK_MONO=
TONIC,
>> +    /// except that it also includes any time that the system is suspen=
ded. This
>> +    /// allows applications to get a suspend-aware monotonic clock with=
out
>> +    /// having to deal with the complications of CLOCK_REALTIME, which =
may have
>> +    /// discontinuities if the time is changed using settimeofday(2) or=
 similar.
>> +    BootTime,
>> +    /// International Atomic Time.
>> +    ///
>> +    /// A nonsettable system-wide clock derived from wall-clock time but
>> +    /// counting leap seconds. This clock does not experience discontin=
uities or
>> +    /// frequency adjustments caused by inserting leap seconds as CLOCK=
_REALTIME
>> +    /// does.
>
> Only partially correct.
>
> CLOCK_TAI can be set as CLOCK_TAI is obviously coupled to CLOCK_REALTIME
> and vice versa.

So it cannot be set directly, but if CLOCK_REALTIME is set, CLOCK_TAI
will update?

In that case I would add the following paragraph:

  This clock is coupled to CLOCK_REALTIME and will be set when
  CLOCK_REALTIME is set.

> Also if the NTP implementation does leap seconds smearing then the
> adjustment affects CLOCK_TAI as well. See above. That's compensated for
> by adjusting the TAI offset to be in sync with reality, but during the
> smear phase the readout is not precise.

I would add the following paragraph then:

  However, if NTP adjusts CLOCK_REALTIME by leap second smearing, this
  clock will not be precise during leap second smearing.



Best regards,
Andreas Hindborg


[1] https://web.git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/ma=
n/man2/clock_getres.2?h=3Dman-pages-6.12


