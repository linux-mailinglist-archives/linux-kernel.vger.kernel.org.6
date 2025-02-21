Return-Path: <linux-kernel+bounces-525465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B393A3F049
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443E617F4C1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 09:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72591204F86;
	Fri, 21 Feb 2025 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOeIJN+N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B790E1FF1C7;
	Fri, 21 Feb 2025 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130215; cv=none; b=i6zpSJ1zukCTd/rwGCiAuA0TkWER6pOdURtq2CTCJJy/jb0LfmzrATw84C/VZ1Ioym7WSM7cDG5LTc4sQCVSkh1drLUe9to0oSBYNa61uaQwfVROEK+iZogrJ1po2P5507UihbW/fN9qzmZ+CMdXe69daSCKZiZsfWnLDANzuTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130215; c=relaxed/simple;
	bh=pSvgDKoaU6/u1vGhOc63MGdIbawEWfcUKFdGMd1M+lc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WsYaHsTRxbDNEScjiW6DqybOVV36ZpHv1/pooJsrNbOy6384ajCcV7KFcXFLamofisXCro75j8uCn6HccsvBmuAHFMYxxAyezy3lULWDO2ErKzTeZzgCPlgnawQao6AacsPdfgZqwqnK1SfXpAkONKOY8yTsTu64twMOjOUMTzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOeIJN+N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82E49C4CED6;
	Fri, 21 Feb 2025 09:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740130215;
	bh=pSvgDKoaU6/u1vGhOc63MGdIbawEWfcUKFdGMd1M+lc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HOeIJN+NE59heXwxb8wPco45CmGEC+ixMafU8YoTcpR+3DEOk+bp0c3C5EtHuYtaq
	 GTtKmLr72Y7Gq2AK4bvhcDG5gyFQtY/nOpCrnwTFT24CHb68s7Tyq48pHO4yrixc2e
	 3xvKvZ9d4S4qfenIukkKUZzETd4nTmePYqmH7phYhrG+/I5Fp/38DaM8AxYn9Eq9hg
	 NtoG4UAcVxEzTk0xtI+m+V0FT1Pof/fB5fvCMP79xq5GUnRpTcKcv76lTAUG0llQK2
	 mc5wS/0rlFMQJc9uzlR85OlDepQ5VPupKcwMKeWAgJ217JLf99VRCdAfofFNjfySv5
	 UGm71pkcjgrqw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "Lyude Paul" <lyude@redhat.com>,  "Guangbo
 Cui" <2407018371@qq.com>,  "Dirk Behme" <dirk.behme@gmail.com>,  "Daniel
 Almeida" <daniel.almeida@collabora.com>,  "Tamir Duberstein"
 <tamird@gmail.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 13/14] rust: hrtimer: add clocksource selection
 through `ClockSource`
In-Reply-To: <f2066461-8a10-4d5e-bce9-989f9bbade2c@proton.me> (Benno Lossin's
	message of "Thu, 20 Feb 2025 23:27:34 +0000")
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
	<20250218-hrtimer-v3-v6-12-rc2-v8-13-48dedb015eb3@kernel.org>
	<_PhcA_mgs6P2AIFlF8RGVU5_-q4wrrdHR0xxDRGJUKPGsIGK56Uae6RS-dAqE5lRQZ61SR35ysRU7Yj_gqmVGg==@protonmail.internalid>
	<f2066461-8a10-4d5e-bce9-989f9bbade2c@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 21 Feb 2025 10:29:27 +0100
Message-ID: <87h64nfxxk.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Benno Lossin" <benno.lossin@proton.me> writes:

> On 18.02.25 14:27, Andreas Hindborg wrote:
>> Allow selecting a clock source for timers by passing a `ClockSource`
>> variant to `HrTimer::new`.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  rust/kernel/time/hrtimer.rs | 52 ++++++++++++++++++++++++++++++++++++++=
+++++--
>>  1 file changed, 50 insertions(+), 2 deletions(-)
>>
>> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
>> index db49061f830c3..2b46d66eaa313 100644
>> --- a/rust/kernel/time/hrtimer.rs
>> +++ b/rust/kernel/time/hrtimer.rs
>> @@ -73,7 +73,7 @@ unsafe impl<T> Sync for HrTimer<T> {}
>>
>>  impl<T> HrTimer<T> {
>>      /// Return an initializer for a new timer instance.
>> -    pub fn new(mode: HrTimerMode) -> impl PinInit<Self>
>> +    pub fn new(mode: HrTimerMode, clock: ClockSource) -> impl PinInit<S=
elf>
>>      where
>>          T: HrTimerCallback,
>>      {
>> @@ -87,7 +87,7 @@ pub fn new(mode: HrTimerMode) -> impl PinInit<Self>
>>                      bindings::hrtimer_setup(
>>                          place,
>>                          Some(T::CallbackTarget::run),
>> -                        bindings::CLOCK_MONOTONIC as i32,
>> +                        clock.into(),
>>                          mode.into(),
>>                      );
>>                  }
>> @@ -448,6 +448,54 @@ fn from(value: HrTimerMode) -> Self {
>>      }
>>  }
>>
>> +/// The clock source to use for a [`HrTimer`].
>> +pub enum ClockSource {
>> +    /// A settable system-wide clock that measures real (i.e., wall-clo=
ck) time.
>
> Missing newline here to separate the short one-line description and the
> rest of the docs. (also below)

Right. It is copy pasta from the C code, but I guess we can add some newlin=
es.

>
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
> Thanks for the extensive descriptions of the various clock sources!

Just FYI, I pulled these from other documentation sources, I didn't
author all of this.

>
>> +    RealTime,
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
>> +    /// clock), but is affected by frequency adjustments. This clock do=
es not
>> +    /// count time that the system is suspended.
>> +    Monotonic,
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
>> +    /// A nonsettable system-wide clock derived from wall-clock time but
>> +    /// counting leap seconds. This clock does not experience discontin=
uities or
>> +    /// frequency adjustments caused by inserting leap seconds as CLOCK=
_REALTIME
>> +    /// does.
>> +    ///
>> +    /// The acronym TAI refers to International Atomic Time.
>
> In that case, I would expect the acronym to be `IAT`.

Yea, this one is funny. The abbreviation apparently is French [1] and
TAI is the correct and agreed upon (beyond Linux) abbreviation to use.

[1] https://en.wikipedia.org/wiki/International_Atomic_Time

>
>> +    TAI,
>> +}
>> +
>> +impl From<ClockSource> for bindings::clockid_t {
>> +    fn from(value: ClockSource) -> Self {
>> +        match value {
>> +            ClockSource::RealTime =3D> bindings::CLOCK_REALTIME as i32,
>> +            ClockSource::Monotonic =3D> bindings::CLOCK_MONOTONIC as i3=
2,
>> +            ClockSource::BootTime =3D> bindings::CLOCK_BOOTTIME as i32,
>> +            ClockSource::TAI =3D> bindings::CLOCK_TAI as i32,
>> +        }
>> +    }
>> +}
>
> Same question here as for the `HrTimerMode`, do drivers need this impl?
> If not, then I think a private conversion function is a better fit.

I will hide it.


Best regards,
Andreas Hindborg



