Return-Path: <linux-kernel+bounces-524892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D01A3E86F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 00:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D759F19C1779
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 23:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759F32676F1;
	Thu, 20 Feb 2025 23:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="NJEnqJ3C"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A0F26561A;
	Thu, 20 Feb 2025 23:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740094063; cv=none; b=WKzSaUU7NVcv5HvNgB2b9a4SPVjq7OVgTPWr/swhkf6asRuyi5nsNQNnx3l+qn7BK7tjyz1UpeU66m5ReXQhu0fazFDkFr6FJqTMm5rkVsGOIQshErWJ9MSq0dVBvWmu1EiCevRbnqH4FuI+YY+bc5utf6Acf8AFH/9BhcUpBGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740094063; c=relaxed/simple;
	bh=IDL/W8pOfs1xYSMe5XgJ5ubEC/gtEpro6a8n9++yLY8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjUFOdIItVZmxZDq+s+fJlciUMiPcwLs+sLwyRZc3bOS9i2n9h9S28Sbs/pnwMM49UXOEKbuaPXPMs4RilxlNOL4ae5FzhzAusj7GbI95Gv9NOlCuzqD9xD/9OBxPSuwYbF8g+gIMisxywZ8EgtaXnSIv9TmVPrw/I7ZuczqX3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=NJEnqJ3C; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1740094058; x=1740353258;
	bh=Dxo1SNAGaRSwPdhf0PEYylFzTQk2lGj8jYFGi3keDjM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=NJEnqJ3CMGMUH/ZjENhy4QUXYVBDdKW1Oi/hYjBbJ9Ns6Nj2WpMhuD2BC8SMDYSke
	 3f0zS+Y72gqkZLeX28PbN6hkJEJq/Y2bg3IfwMEUECAXllHOrUJwR9hd6FKAlUpsb5
	 TTrdZqbq3SOs9tkkhVNjI8PHwt/UyKC4M+h7rmHam5n9+1O6Wx1z1GUGCE4prObPrs
	 82TSgXBoTMGk9LNFEq38kGeXCAP7yioM88nypqdpVGlcixBYOG5KFGDRQSTe5d8cb/
	 M26P666YtZH6ExXiS11IcP74zhV2g11AplIx/kPa4L4q+u7qEkfFJMIoqxGZMlR6Ep
	 N0au4f+sNp+oQ==
Date: Thu, 20 Feb 2025 23:27:34 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 13/14] rust: hrtimer: add clocksource selection through `ClockSource`
Message-ID: <f2066461-8a10-4d5e-bce9-989f9bbade2c@proton.me>
In-Reply-To: <20250218-hrtimer-v3-v6-12-rc2-v8-13-48dedb015eb3@kernel.org>
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org> <20250218-hrtimer-v3-v6-12-rc2-v8-13-48dedb015eb3@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 038ad877f331f246724e40ce89b20b41c42a57ae
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.02.25 14:27, Andreas Hindborg wrote:
> Allow selecting a clock source for timers by passing a `ClockSource`
> variant to `HrTimer::new`.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/time/hrtimer.rs | 52 +++++++++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 50 insertions(+), 2 deletions(-)
>=20
> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
> index db49061f830c3..2b46d66eaa313 100644
> --- a/rust/kernel/time/hrtimer.rs
> +++ b/rust/kernel/time/hrtimer.rs
> @@ -73,7 +73,7 @@ unsafe impl<T> Sync for HrTimer<T> {}
>=20
>  impl<T> HrTimer<T> {
>      /// Return an initializer for a new timer instance.
> -    pub fn new(mode: HrTimerMode) -> impl PinInit<Self>
> +    pub fn new(mode: HrTimerMode, clock: ClockSource) -> impl PinInit<Se=
lf>
>      where
>          T: HrTimerCallback,
>      {
> @@ -87,7 +87,7 @@ pub fn new(mode: HrTimerMode) -> impl PinInit<Self>
>                      bindings::hrtimer_setup(
>                          place,
>                          Some(T::CallbackTarget::run),
> -                        bindings::CLOCK_MONOTONIC as i32,
> +                        clock.into(),
>                          mode.into(),
>                      );
>                  }
> @@ -448,6 +448,54 @@ fn from(value: HrTimerMode) -> Self {
>      }
>  }
>=20
> +/// The clock source to use for a [`HrTimer`].
> +pub enum ClockSource {
> +    /// A settable system-wide clock that measures real (i.e., wall-cloc=
k) time.

Missing newline here to separate the short one-line description and the
rest of the docs. (also below)

> +    /// Setting this clock requires appropriate privileges. This clock i=
s
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

Thanks for the extensive descriptions of the various clock sources!

> +    RealTime,
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
> +    /// clock), but is affected by frequency adjustments. This clock doe=
s not
> +    /// count time that the system is suspended.
> +    Monotonic,
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
> +    /// A nonsettable system-wide clock derived from wall-clock time but
> +    /// counting leap seconds. This clock does not experience discontinu=
ities or
> +    /// frequency adjustments caused by inserting leap seconds as CLOCK_=
REALTIME
> +    /// does.
> +    ///
> +    /// The acronym TAI refers to International Atomic Time.

In that case, I would expect the acronym to be `IAT`.

> +    TAI,
> +}
> +
> +impl From<ClockSource> for bindings::clockid_t {
> +    fn from(value: ClockSource) -> Self {
> +        match value {
> +            ClockSource::RealTime =3D> bindings::CLOCK_REALTIME as i32,
> +            ClockSource::Monotonic =3D> bindings::CLOCK_MONOTONIC as i32=
,
> +            ClockSource::BootTime =3D> bindings::CLOCK_BOOTTIME as i32,
> +            ClockSource::TAI =3D> bindings::CLOCK_TAI as i32,
> +        }
> +    }
> +}

Same question here as for the `HrTimerMode`, do drivers need this impl?
If not, then I think a private conversion function is a better fit.

---
Cheers,
Benno

> +
>  /// Use to implement the [`HasHrTimer<T>`] trait.
>  ///
>  /// See [`module`] documentation for an example.
>=20
> --
> 2.47.0
>=20
>=20


