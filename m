Return-Path: <linux-kernel+bounces-416030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE659D3F5F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C7F2834CA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539D21448E0;
	Wed, 20 Nov 2024 15:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WN9X5vHA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC6612BF02;
	Wed, 20 Nov 2024 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732117919; cv=none; b=ui7iJBrmfy2pBZzwsVjOkPtgP2xJsD0TQ4Fu/loKTTXb5shsIAmW47hKY+9T8mraRu7tWfRs0RmLVPDG5fMe01AoGGsjCzkZk7Xi9gnhWO6Zvqn529waCyQmDCfHKChHDrulUqvZKG/QrTFgaUO9lYZH9cCycXgY5Zay1RJLezQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732117919; c=relaxed/simple;
	bh=8IVlxGS65y/Z3LoG7hMZVm0036HIRMtQCt9WMX5LvSs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gFBFIUcv6juaqshczTb9FQquEHgiZA2q/ttbrzGttK2b0N8DkWdLfa1YNb6PJnaHVEsPIgj3mv8e+J1kHYpNnrB01FNc4Nd+yzI9dL/LLtHeyWWpagcVjKRwLpGCzvIwsW0C2xoAcrd02p6p7yC3YftkCkDd/erzumJERBR4WUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WN9X5vHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B8EC4CECD;
	Wed, 20 Nov 2024 15:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732117919;
	bh=8IVlxGS65y/Z3LoG7hMZVm0036HIRMtQCt9WMX5LvSs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=WN9X5vHAn8EZDfk/XToTYw0qs7/N4R/AVvvRgNYbMvSfSK138ceU6Ooo6mfEEoo4Q
	 J0tkUZxSD47qNUS8o1EiIy4yNv/7Yi2ZYvTtS3cUhCKW320koNEwfbgmD55S+vWZUo
	 +lAv5dfK/mv5CNCPCMGYIUWWk6blMQ0/+YNXiu/ZaeAjjCHI4emtzi6+03ff7gc0Xi
	 kTBzH+Pv2WRi+H6SeWJeHPJprq69z0l6lFrbmQ9iWTAaoODJq6I+o0MAOFxYLPIHWD
	 +NHs2cTPRRoBKqhWNZCMcO9PIquZQYYNncBIA/+iP089JSVmCWLE9DV78JBS3ccjh5
	 JKyfL/8nmVicA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Lyude Paul" <lyude@redhat.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 11/13] rust: hrtimer: add `TimerMode`
In-Reply-To: <f27dfef8aa3d184382a6573ddde8d89a2d688f24.camel@redhat.com>
	(Lyude Paul's message of "Wed, 13 Nov 2024 18:37:31 -0500")
References: <20241017-hrtimer-v3-v6-12-rc2-v3-0-59a75cbb44da@kernel.org>
	<20241017-hrtimer-v3-v6-12-rc2-v3-11-59a75cbb44da@kernel.org>
	<qy9A8zxsg2_oQ_c3z6liELLAIfDg2Pn0DxdC67WySelkCoF9NQptKeQTNNZxA-_Su-H3sYhBHYpWQ7iiCHAN6A==@protonmail.internalid>
	<f27dfef8aa3d184382a6573ddde8d89a2d688f24.camel@redhat.com>
Date: Wed, 20 Nov 2024 16:51:44 +0100
Message-ID: <87r0753nu7.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Lyude Paul" <lyude@redhat.com> writes:

> On Thu, 2024-10-17 at 15:04 +0200, Andreas Hindborg wrote:
>> Allow selection of timer mode by passing a `TimerMode` variant to
>> `Timer::new`.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  rust/kernel/hrtimer.rs | 88 +++++++++++++++++++++++++++++++++++++++++++=
++++---
>>  1 file changed, 84 insertions(+), 4 deletions(-)
>>
>> diff --git a/rust/kernel/hrtimer.rs b/rust/kernel/hrtimer.rs
>> index 2c1573e19576de93afc959d71e94173e2c1ed715..1674d1dcba39cc7ab82e1f18=
9002afa365ee9341 100644
>> --- a/rust/kernel/hrtimer.rs
>> +++ b/rust/kernel/hrtimer.rs
>> @@ -38,12 +38,13 @@
>>  /// # Invariants
>>  ///
>>  /// * `self.timer` is initialized by `bindings::hrtimer_init`.
>> -#[repr(transparent)]
>>  #[pin_data]
>>  #[repr(C)]
>>  pub struct Timer<U> {
>>      #[pin]
>>      timer: Opaque<bindings::hrtimer>,
>> +    // This field goes away when `bindings::hrtimer_setup` is added.
>> +    mode: TimerMode,
>>      _t: PhantomData<U>,
>>  }
>>
>> @@ -56,7 +57,7 @@ unsafe impl<U> Sync for Timer<U> {}
>>
>>  impl<T> Timer<T> {
>>      /// Return an initializer for a new timer instance.
>> -    pub fn new() -> impl PinInit<Self>
>> +    pub fn new(mode: TimerMode) -> impl PinInit<Self>
>>      where
>>          T: TimerCallback,
>>      {
>> @@ -70,7 +71,7 @@ pub fn new() -> impl PinInit<Self>
>>                      bindings::hrtimer_init(
>>                          place,
>>                          bindings::CLOCK_MONOTONIC as i32,
>> -                        bindings::hrtimer_mode_HRTIMER_MODE_REL,
>> +                        mode.into(),
>>                      );
>>                  }
>>
>> @@ -83,6 +84,7 @@ pub fn new() -> impl PinInit<Self>
>>                  // exclusive access.
>>                  unsafe { core::ptr::write(function, Some(T::CallbackTar=
get::run)) };
>>              }),
>> +            mode: mode,
>>              _t: PhantomData,
>>          })
>>      }
>> @@ -330,7 +332,7 @@ unsafe fn start(self_ptr: *const Self, expires: Ktim=
e) {
>>                  Self::c_timer_ptr(self_ptr).cast_mut(),
>>                  expires.to_ns(),
>>                  0,
>> -                bindings::hrtimer_mode_HRTIMER_MODE_REL,
>> +                (*Self::raw_get_timer(self_ptr)).mode.into(),
>>              );
>>          }
>>      }
>> @@ -362,6 +364,84 @@ fn from(value: TimerRestart) -> Self {
>>      }
>>  }
>>
>> +/// Operational mode of [`Timer`].
>> +#[derive(Clone, Copy)]
>> +pub enum TimerMode {
>> +    /// Timer expires at the given expiration time.
>> +    Absolute,
>> +    /// Timer expires after the given expiration time interpreted as a =
duration from now.
>> +    Relative,
>> +    /// Timer does not move between CPU cores.
>> +    Pinned,
>> +    /// Timer handler is executed in soft irq context.
>> +    Soft,
>> +    /// Timer handler is executed in hard irq context.
>> +    Hard,
>> +    /// Timer expires at the given expiration time.
>> +    /// Timer does not move between CPU cores.
>> +    AbsolutePinned,
>> +    /// Timer expires after the given expiration time interpreted as a =
duration from now.
>> +    /// Timer does not move between CPU cores.
>> +    RelativePinned,
>> +    /// Timer expires at the given expiration time.
>> +    /// Timer handler is executed in soft irq context.
>> +    AbsoluteSoft,
>> +    /// Timer expires after the given expiration time interpreted as a =
duration from now.
>> +    /// Timer handler is executed in soft irq context.
>> +    RelativeSoft,
>> +    /// Timer expires at the given expiration time.
>> +    /// Timer does not move between CPU cores.
>> +    /// Timer handler is executed in soft irq context.
>> +    AbsolutePinnedSoft,
>> +    /// Timer expires after the given expiration time interpreted as a =
duration from now.
>> +    /// Timer does not move between CPU cores.
>> +    /// Timer handler is executed in soft irq context.
>> +    RelativePinnedSoft,
>> +    /// Timer expires at the given expiration time.
>> +    /// Timer handler is executed in hard irq context.
>> +    AbsoluteHard,
>> +    /// Timer expires after the given expiration time interpreted as a =
duration from now.
>> +    /// Timer handler is executed in hard irq context.
>> +    RelativeHard,
>> +    /// Timer expires at the given expiration time.
>> +    /// Timer does not move between CPU cores.
>> +    /// Timer handler is executed in hard irq context.
>> +    AbsolutePinnedHard,
>> +    /// Timer expires after the given expiration time interpreted as a =
duration from now.
>> +    /// Timer does not move between CPU cores.
>> +    /// Timer handler is executed in hard irq context.
>> +    RelativePinnedHard,
>> +}
>> +
>> +impl From<TimerMode> for bindings::hrtimer_mode {
>> +    fn from(value: TimerMode) -> Self {
>> +        use bindings::*;
>> +        match value {
>> +            TimerMode::Absolute =3D> hrtimer_mode_HRTIMER_MODE_ABS,
>> +            TimerMode::Relative =3D> hrtimer_mode_HRTIMER_MODE_REL,
>> +            TimerMode::Pinned =3D> hrtimer_mode_HRTIMER_MODE_PINNED,
>> +            TimerMode::Soft =3D> hrtimer_mode_HRTIMER_MODE_SOFT,
>> +            TimerMode::Hard =3D> hrtimer_mode_HRTIMER_MODE_HARD,
>> +            TimerMode::AbsolutePinned =3D> hrtimer_mode_HRTIMER_MODE_AB=
S_PINNED,
>> +            TimerMode::RelativePinned =3D> hrtimer_mode_HRTIMER_MODE_RE=
L_PINNED,
>> +            TimerMode::AbsoluteSoft =3D> hrtimer_mode_HRTIMER_MODE_ABS_=
SOFT,
>> +            TimerMode::RelativeSoft =3D> hrtimer_mode_HRTIMER_MODE_REL_=
SOFT,
>> +            TimerMode::AbsolutePinnedSoft =3D> hrtimer_mode_HRTIMER_MOD=
E_ABS_PINNED_SOFT,
>> +            TimerMode::RelativePinnedSoft =3D> hrtimer_mode_HRTIMER_MOD=
E_REL_PINNED_SOFT,
>> +            TimerMode::AbsoluteHard =3D> hrtimer_mode_HRTIMER_MODE_ABS_=
HARD,
>> +            TimerMode::RelativeHard =3D> hrtimer_mode_HRTIMER_MODE_REL_=
HARD,
>> +            TimerMode::AbsolutePinnedHard =3D> hrtimer_mode_HRTIMER_MOD=
E_ABS_PINNED_HARD,
>> +            TimerMode::RelativePinnedHard =3D> hrtimer_mode_HRTIMER_MOD=
E_REL_PINNED_HARD,
>> +        }
>> +    }
>> +}
>
> Are we sure we actually need to explicitly convert it like this? You shou=
ld be
> able to use #[repr(=E2=80=A6)] to indicate that the enum is the same type=
 as the
> actual C constant, and then we can just assign the value of each C consta=
nt as
> the discriminant for each enum value in TimerMode.
>

Some combinations of modes are illegal. With this approach, it is not
possible to name the illegal combinations.

Interesting discussion is happening on Zulip regarding a possible
solution for enums like this [1].


Best regards,
Andreas Hindborg




[1] https://rust-for-linux.zulipchat.com/#narrow/channel/291565-Help/topic/=
Best.20way.20to.20handle.20enum.2Fflags.20situation


