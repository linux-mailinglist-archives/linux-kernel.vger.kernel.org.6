Return-Path: <linux-kernel+bounces-525597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD49FA3F1DD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29302188CE28
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627DD205ADD;
	Fri, 21 Feb 2025 10:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="j9K4D5Td"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0761DFDB9;
	Fri, 21 Feb 2025 10:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740133354; cv=none; b=ky3PH/fuDn91nNAq9hLPAf+JX265ZKXUUFxEdv2uS7RQ1N8IvpZeugu1ft0/Qf5EovErbHjM2ZfeHMc34U3EfQDii2kJunaWZggPsMMO1MzER35M+kFv0g8Me4mYUSWgNC/Xk6ItR6gJHCpOCJTg+fqVIJHpkiWwDa1JEDEmO8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740133354; c=relaxed/simple;
	bh=L1Hc1NyK8oBmOxUpaLFZxP68BKn50ePdzdoBKcdg/8c=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EGnhR5C8ZMjbcg4RFsHvZLtUgNLDl6Ft1WEZh/5q9m3DMJnBzhybUxgw4KUEYUw8NSc6WeTekT5xb2hPEAOjtIDWB9UqRntzAH19MHw/O2/cDShn/1CSSvkcw26uWzqmFo+R4ELoF1t08bUAidc6ptVepJc1NQ+VI09HgG58qYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=j9K4D5Td; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1740133349; x=1740392549;
	bh=6u1YPUHmQ0Q6bi5JBJ45QYNmpBvfB0XVEZTH15dlImk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=j9K4D5TdNO7Eqh9Mt6BeEpoFNTtUlVb+vcApJc3OiNV//rTpMofQ2yKVHdDH0Ywds
	 0egDonrnVhDuvQCqSUKaRsoaVG+tmzHXvHZVQ+hVoD0p57EiHNKwB4/wDMXD+9oNMu
	 GNT08trrVNNVKJT0dB/H+O+WyiGI8y7AhTh/Cmz1E6xlR7tUkneVasR0GKCKrZaZ2f
	 mvHjlrAHe0gX18kr60Q7PTojQuOkMo58LO4FcZEcXm1/29SZkmkSYcZgh2fvvrfgmn
	 r+UgwC5/k/0Wcqy0eZ4bmM5Nmh0pK0Ty27WtpYsUP00HlEd91bXl4Ka7ov9Nx9sSVZ
	 W0/bUGpzBhDXw==
Date: Fri, 21 Feb 2025 10:22:26 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 13/14] rust: hrtimer: add clocksource selection through `ClockSource`
Message-ID: <ec4977d7-7df3-44f4-80c7-3ecdfc6266d1@proton.me>
In-Reply-To: <87h64nfxxk.fsf@kernel.org>
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org> <20250218-hrtimer-v3-v6-12-rc2-v8-13-48dedb015eb3@kernel.org> <_PhcA_mgs6P2AIFlF8RGVU5_-q4wrrdHR0xxDRGJUKPGsIGK56Uae6RS-dAqE5lRQZ61SR35ysRU7Yj_gqmVGg==@protonmail.internalid> <f2066461-8a10-4d5e-bce9-989f9bbade2c@proton.me> <87h64nfxxk.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 119ec2bb485c30bef4631c99eb2b86ec1918c27c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.02.25 10:29, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>=20
>> On 18.02.25 14:27, Andreas Hindborg wrote:
>>> Allow selecting a clock source for timers by passing a `ClockSource`
>>> variant to `HrTimer::new`.
>>>
>>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>>> ---
>>>  rust/kernel/time/hrtimer.rs | 52 +++++++++++++++++++++++++++++++++++++=
++++++--
>>>  1 file changed, 50 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
>>> index db49061f830c3..2b46d66eaa313 100644
>>> --- a/rust/kernel/time/hrtimer.rs
>>> +++ b/rust/kernel/time/hrtimer.rs
>>> @@ -73,7 +73,7 @@ unsafe impl<T> Sync for HrTimer<T> {}
>>>
>>>  impl<T> HrTimer<T> {
>>>      /// Return an initializer for a new timer instance.
>>> -    pub fn new(mode: HrTimerMode) -> impl PinInit<Self>
>>> +    pub fn new(mode: HrTimerMode, clock: ClockSource) -> impl PinInit<=
Self>
>>>      where
>>>          T: HrTimerCallback,
>>>      {
>>> @@ -87,7 +87,7 @@ pub fn new(mode: HrTimerMode) -> impl PinInit<Self>
>>>                      bindings::hrtimer_setup(
>>>                          place,
>>>                          Some(T::CallbackTarget::run),
>>> -                        bindings::CLOCK_MONOTONIC as i32,
>>> +                        clock.into(),
>>>                          mode.into(),
>>>                      );
>>>                  }
>>> @@ -448,6 +448,54 @@ fn from(value: HrTimerMode) -> Self {
>>>      }
>>>  }
>>>
>>> +/// The clock source to use for a [`HrTimer`].
>>> +pub enum ClockSource {
>>> +    /// A settable system-wide clock that measures real (i.e., wall-cl=
ock) time.
>>
>> Missing newline here to separate the short one-line description and the
>> rest of the docs. (also below)
>=20
> Right. It is copy pasta from the C code, but I guess we can add some newl=
ines.
>=20
>>
>>> +    /// Setting this clock requires appropriate privileges. This clock=
 is
>>> +    /// affected by discontinuous jumps in the system time (e.g., if t=
he system
>>> +    /// administrator manually changes the clock), and by frequency ad=
justments
>>> +    /// performed by NTP and similar applications via adjtime(3), adjt=
imex(2),
>>> +    /// clock_adjtime(2), and ntp_adjtime(3). This clock normally coun=
ts the
>>> +    /// number of seconds since 1970-01-01 00:00:00 Coordinated Univer=
sal Time
>>> +    /// (UTC) except that it ignores leap seconds; near a leap second =
it is
>>> +    /// typically adjusted by NTP to stay roughly in sync with UTC.
>>
>> Thanks for the extensive descriptions of the various clock sources!
>=20
> Just FYI, I pulled these from other documentation sources, I didn't
> author all of this.

I still find it useful for you to copy these, I've seen a patch in the
past where the C documentation gave more information than the Rust
abstraction.

>>> +    RealTime,
>>> +    /// A nonsettable system-wide clock that represents monotonic time=
 since=E2=80=94as
>>> +    /// described by POSIX=E2=80=94"some unspecified point in the past=
" On Linux, that
>>> +    /// point corresponds to the number of seconds that the system has=
 been
>>> +    /// running since it was booted.
>>> +    ///
>>> +    /// The CLOCK_MONOTONIC clock is not affected by discontinuous jum=
ps in the
>>> +    /// system time (e.g., if the system administrator manually change=
s the
>>> +    /// clock), but is affected by frequency adjustments. This clock d=
oes not
>>> +    /// count time that the system is suspended.
>>> +    Monotonic,
>>> +    /// A nonsettable system-wide clock that is identical to CLOCK_MON=
OTONIC,
>>> +    /// except that it also includes any time that the system is suspe=
nded. This
>>> +    /// allows applications to get a suspend-aware monotonic clock wit=
hout
>>> +    /// having to deal with the complications of CLOCK_REALTIME, which=
 may have
>>> +    /// discontinuities if the time is changed using settimeofday(2) o=
r similar.
>>> +    BootTime,
>>> +    /// A nonsettable system-wide clock derived from wall-clock time b=
ut
>>> +    /// counting leap seconds. This clock does not experience disconti=
nuities or
>>> +    /// frequency adjustments caused by inserting leap seconds as CLOC=
K_REALTIME
>>> +    /// does.
>>> +    ///
>>> +    /// The acronym TAI refers to International Atomic Time.
>>
>> In that case, I would expect the acronym to be `IAT`.
>=20
> Yea, this one is funny. The abbreviation apparently is French [1] and
> TAI is the correct and agreed upon (beyond Linux) abbreviation to use.

What a world we have... :)

---
Cheers,
Benno

> [1] https://en.wikipedia.org/wiki/International_Atomic_Time
>=20
>>
>>> +    TAI,
>>> +}
>>> +
>>> +impl From<ClockSource> for bindings::clockid_t {
>>> +    fn from(value: ClockSource) -> Self {
>>> +        match value {
>>> +            ClockSource::RealTime =3D> bindings::CLOCK_REALTIME as i32=
,
>>> +            ClockSource::Monotonic =3D> bindings::CLOCK_MONOTONIC as i=
32,
>>> +            ClockSource::BootTime =3D> bindings::CLOCK_BOOTTIME as i32=
,
>>> +            ClockSource::TAI =3D> bindings::CLOCK_TAI as i32,
>>> +        }
>>> +    }
>>> +}
>>
>> Same question here as for the `HrTimerMode`, do drivers need this impl?
>> If not, then I think a private conversion function is a better fit.
>=20
> I will hide it.
>=20
>=20
> Best regards,
> Andreas Hindborg
>=20
>=20


