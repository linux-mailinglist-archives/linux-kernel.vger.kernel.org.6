Return-Path: <linux-kernel+bounces-535901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1D9A478BE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 10:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33A5316F3D4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 09:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357E6227B95;
	Thu, 27 Feb 2025 09:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3TufFS1F";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DbW7Shrx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD034226551;
	Thu, 27 Feb 2025 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740647472; cv=none; b=HY3sHvARxGDcE364a5cna1faqmJx8Hg6rNpDK6d6QNm9/t1qcebJgMyMxu/UMh4r+hQ9ZLsnLcKr6yPfKpbbF1r4XvwUG8tAY+A0RKKMnJh62sVsc0LybSVPQLCjCoRALOybrAirGn8InJttPLOkD4iTYt3S2fPbR7N6tZHlt04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740647472; c=relaxed/simple;
	bh=JOqY+CoNqMYtrEO1gJswp59niLfGfYa+1G5OdpGaJ64=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FRRE/ZvUytUM0QQxfBpzDg4Ex4uFk1r5LTcpcDQmUvZzgRKaqdojcMVhE0stOVl2dVqjFSkb6A41fWLNIf5U2/JS5QF88rpEJG/CZXZnKcff37LiKmXXnc8CvkOYgGUbPtqygV0umOeLrvqQI7QGVMfPB/cdJ648+s5aSsP9oik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3TufFS1F; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DbW7Shrx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740647469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VjempoGvlVjLQ6oq69ccc+cgz6csDzLpGNNetDWHHeo=;
	b=3TufFS1FpX0siM3OwozmM3yrAlVRb+AMcpGj4jpQ+mw9xu+9l3dTfGwahghmzLY6xsWF1L
	SfEItRn+t4ldrI6bjKesQUKTrLq/fUXbIIY8o/NChJbc3ojOd8Qz8WmtVPBd1jRKNT0s0Q
	kBVOuCmBHVR3m7GUZFtVSTNXhjNcld+zMprzlKMaWREh1sFrMITt1Q23BBeNENfLVserE1
	Owd9LWEmiLYboE84cpp/Cr5yU9LnmUlK5FIF5lFZGP6ZLG/kb+nCArt7yajgmhQ8PzCw2F
	tLAMcEhklbIU1efDTFAC4vr3vlvvNxtbnliwRIkw444GA0mqRetJjSK8V2eItQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740647469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VjempoGvlVjLQ6oq69ccc+cgz6csDzLpGNNetDWHHeo=;
	b=DbW7Shrxvu4mXb5ArN/VR53PJip78EUQordzqJvdYAwHJUuXNsPAT1zJLiwcpcRfPIz02W
	bf//dXOFI3+TR0Aw==
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda
 <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo
 Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida
 <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Andreas
 Hindborg <a.hindborg@kernel.org>
Subject: Re: [PATCH v9 12/13] rust: hrtimer: add clocksource selection
 through `ClockSource`
In-Reply-To: <20250224-hrtimer-v3-v6-12-rc2-v9-12-5bd3bf0ce6cc@kernel.org>
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org>
 <20250224-hrtimer-v3-v6-12-rc2-v9-12-5bd3bf0ce6cc@kernel.org>
Date: Thu, 27 Feb 2025 10:11:08 +0100
Message-ID: <87jz9beor7.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24 2025 at 13:03, Andreas Hindborg wrote:
>=20=20
> +/// The clock source to use for a [`HrTimer`].
> +pub enum ClockSource {

ClockSource is a confusing name as 'clocksource' is used in the kernel
already for devices providing counters, which can be used for
timekeeping.

Also these clocks are not really hrtimer specific. These CLOCK ids are
system wide valid and are used for other purposes obviously internally
in timekeeping. hrtimers are built on top of timekeeping, which provides
the underlying time.

> +    /// A settable system-wide clock that measures real (i.e., wall-cloc=
k) time.
> +    ///
> +    /// Setting this clock requires appropriate privileges. This clock is
> +    /// affected by discontinuous jumps in the system time (e.g., if the=
 system
> +    /// administrator manually changes the clock), and by frequency adju=
stments
> +    /// performed by NTP and similar applications via adjtime(3), adjtim=
ex(2),
> +    /// clock_adjtime(2), and ntp_adjtime(3). This clock normally counts=
 the
> +    /// number of seconds since 1970-01-01 00:00:00 Coordinated Universa=
l Time
> +    /// (UTC) except that it ignores leap seconds; near a leap second it=
 is
> +    /// typically adjusted by NTP to stay roughly in sync with UTC.

That's not correct. It depends on the implementation/configuration of
NTP. The default is that the leap second is actually applied at the
requested time, by setting the clock one second forth or back.

Though there are NTP configurations/implementations out there which use
leap second "smearing" to avoid the jump. They adjust the conversion
factors around the leap second event by slowing down or speeding up for
a while. That avoids a few common issues, e.g. in data bases.

But it brings all clocks out of sync with the actual progress of time, which
is patently bad for systems which require strict synchronization.

The problem is that the kernel uses the NTP/PTP frequency adjustment to
steer the conversion of all clocks, except CLOCK_MONOTONIC_RAW. The
kernel internal base clock is CLOCK_MONOTONIC. The other clocks are
derived from that:

        CLOCK_[X] =3D CLOCK_MONOTONIC + offset[X]

> +    RealTime,
> +    /// A monotonically increasing clock.
> +    ///
> +    /// A nonsettable system-wide clock that represents monotonic time s=
ince=E2=80=94as
> +    /// described by POSIX=E2=80=94"some unspecified point in the past".=
 On Linux, that
> +    /// point corresponds to the number of seconds that the system has b=
een
> +    /// running since it was booted.
> +    ///
> +    /// The CLOCK_MONOTONIC clock is not affected by discontinuous jumps=
 in the
> +    /// system time (e.g., if the system administrator manually changes =
the

s/system time/CLOCK_REALTIME/

> +    /// clock), but is affected by frequency adjustments. This clock doe=
s not
> +    /// count time that the system is suspended.
> +    Monotonic,
> +    /// A monotonic that ticks while system is suspended.
> +    ///
> +    /// A nonsettable system-wide clock that is identical to CLOCK_MONOT=
ONIC,
> +    /// except that it also includes any time that the system is suspend=
ed. This
> +    /// allows applications to get a suspend-aware monotonic clock witho=
ut
> +    /// having to deal with the complications of CLOCK_REALTIME, which m=
ay have
> +    /// discontinuities if the time is changed using settimeofday(2) or =
similar.
> +    BootTime,
> +    /// International Atomic Time.
> +    ///
> +    /// A nonsettable system-wide clock derived from wall-clock time but
> +    /// counting leap seconds. This clock does not experience discontinu=
ities or
> +    /// frequency adjustments caused by inserting leap seconds as CLOCK_=
REALTIME
> +    /// does.

Only partially correct.

CLOCK_TAI can be set as CLOCK_TAI is obviously coupled to CLOCK_REALTIME
and vice versa.

Also if the NTP implementation does leap seconds smearing then the
adjustment affects CLOCK_TAI as well. See above. That's compensated for
by adjusting the TAI offset to be in sync with reality, but during the
smear phase the readout is not precise.

Thanks,

        tglx

