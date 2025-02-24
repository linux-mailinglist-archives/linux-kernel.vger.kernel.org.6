Return-Path: <linux-kernel+bounces-529986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF79A42D51
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 21:05:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 488D1177C20
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 20:05:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2656D2063F6;
	Mon, 24 Feb 2025 20:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UiCOsuK7"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC72EEA9;
	Mon, 24 Feb 2025 20:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740427538; cv=none; b=VQnEN7FLkHq68eZaGAhCDOy2JHH5g9zoFQdZbxoXhsAO6t3oZR4KDM114w+d8IlBWqHzeaiE0FEC5epXmtqZEuh75iyqyZo+ryPqI64JDeg80wFcUCaVtm7xrcIXQ77j4xkmTzblEDNb25CouZvb01NBl+7bWfCd4k7k5pg+KYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740427538; c=relaxed/simple;
	bh=E9iS8fTbV7Y7eCbnOYthTDo2rWH1v4fU75TdFr9A4DI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4Jkjmh72vW1svtO5dD8M6MFmnhGTEr23yOwz8pa3mCw2mUuWq3xnS7s7gp+RhTV39vMiDV2e1Rj3ZqN9TD/t5tptDEoTKcm1/i8zJBUbnExidm1VhrKfyPB1T344hz4PMrsqWvBsisCe9AzVx8Pd1F+NxrV1vpLFmeV3315aPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UiCOsuK7; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30613802a04so51738301fa.2;
        Mon, 24 Feb 2025 12:05:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740427534; x=1741032334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P/8v1s++7AHqK0ygE594Gq7TGfseOkvuMIP7Ka8QUBY=;
        b=UiCOsuK7rnSYS2/eVksVtJUCXxo+q25vc7+dHk++xJY7FpgN9L3ikR1f7L/kMajOsQ
         AB4y43GytqW57Fhn/AUxDCiXp0V6gVs2vBvhI2wZoFYR8FQLePxUiG7tUaP896qJeNT0
         zGBvIZJFN4Q6OmwD6YjOSWkZAhDs6eiRq6B79xXhocLqwqTAMJyy2RJSK4Aef6zgQ2pP
         Q0IAOHUsN/sLoQ8QsdWPnaJLJRfgZx7UiPJcZAuAnKE19wbFDAMWT8rNUDGWLA20iUfi
         LYBwDn/CEvKd9ao15/iHaqbfnpP7q3FwqmYos+DxzL4Yl5pBw+eDyy3lDHYd0nwlIH9b
         2nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740427534; x=1741032334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P/8v1s++7AHqK0ygE594Gq7TGfseOkvuMIP7Ka8QUBY=;
        b=SRGgmUuZkjiEI/kKSUzHl7tEg5rcsBRyg36pT2MGSl3/PIQW2uLs/H7fyrn8JyOAOl
         5yZCxUPmwjQjiXjtNi2JJ+U7vaJhwsguFc2RDxt30a/maZ+zXOazj6quBRfvUuDPah28
         +mU5sVXh+knEpLasDJFADwwQlzMMwGxydJkLTcE9zLVaZDjPZ1JzU5yyZuOcT5MxYxNo
         3oDjj3Lp8H81Za/wlQQKW2RXDqHl9YFQYFBeoUpiM6OzU7MEYIWV9leTecPpT+ydaoz8
         QTt4V4AsrfKaRD8Yq1Lx6eTp3IPzkheqnPoIQVHMjr99wLlQR2E12+ENLasADY5Nm8mV
         LIcg==
X-Forwarded-Encrypted: i=1; AJvYcCVY9/WjYoXV1/yktDJtbAyaR1uwfgsajt3qwudxQhr7C+DZnzHR+jt3phQEICfg5lVn6HvUCbXEcg2eQys=@vger.kernel.org, AJvYcCWXWQzL3c2yS66u8034L5GsyFY4bX/JKwRvCt3zLepC0G5SvSQZaXLalajLQwIZk6//s+yD4yG89gYGBD8F9GA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl48nFKofS9JnFm+i1rcGMHFyhrWyl5X2WuQgsCabHiVkw02It
	5hrB7nqdaaxjYqcyuZ6UzuK3Cs0i8aPq8yPOBloMCMZv8VUn1oCkeJ+okyGkm7vFaRe69jF0/1k
	99vjVlaGbAGBZmTYz90xg8xkEogI=
X-Gm-Gg: ASbGncvC1TMUjNieW/Fm0dA7TvkdbR6ulScTnXs9jRxHz9DMzbjUcv3GeidXuTQ90/e
	TfevIURPDIrF0CkJMTGMHLuMlvdCnxV99/gZCDYnWiYXqVKSM5Q5SvW0r4x5EqlzfifQf2VYbPp
	+zsOK2yIB/p2tL8XdQw9qpzl0=
X-Google-Smtp-Source: AGHT+IG+sxZpFch33qDuekT/glCJYAkQ/0BGMSnr8wNGCq50QQWxMbzFq36YKXOpflOZiN2c6bZwA9J0a8j3u5841cw=
X-Received: by 2002:a2e:9c06:0:b0:2ff:8e69:77d7 with SMTP id
 38308e7fff4ca-30a5b1a09d0mr46577671fa.20.1740427534067; Mon, 24 Feb 2025
 12:05:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224-hrtimer-v3-v6-12-rc2-v9-0-5bd3bf0ce6cc@kernel.org> <20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org>
In-Reply-To: <20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 24 Feb 2025 15:04:57 -0500
X-Gm-Features: AWEUYZk9mzEuBXxUMksm3ER3keADFk4mQiZFGKjtUJbIsMQ9MHkvNFpqkOqm0Q4
Message-ID: <CAJ-ks9nj8+fXM_oo0LJo4O6Q=skFRcHwz8TLxw-yB3QTcDF9GA@mail.gmail.com>
Subject: Re: [PATCH v9 01/13] rust: hrtimer: introduce hrtimer support
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, 
	Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andreas, mostly grammar and prose clarity comments below.

I still think HasHrTimer::OFFSET is less clear and more fragile than
just generating compiler-checked implementations in the macro (you're
already generating OFFSET and one method implementation rather than
generating 2 method implementations).

On Mon, Feb 24, 2025 at 7:06=E2=80=AFAM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> This patch adds support for intrusive use of the hrtimer system. For now,
> only one timer can be embedded in a Rust struct.
>
> The hrtimer Rust API is based on the intrusive style pattern introduced b=
y
> the Rust workqueue API.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  kernel/time/Kconfig         |  13 ++
>  rust/kernel/time.rs         |   3 +
>  rust/kernel/time/hrtimer.rs | 347 ++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 363 insertions(+)
>
> diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
> index b0b97a60aaa6..7726e14ca3e2 100644
> --- a/kernel/time/Kconfig
> +++ b/kernel/time/Kconfig
> @@ -211,3 +211,16 @@ config CLOCKSOURCE_WATCHDOG_MAX_SKEW_US
>
>  endmenu
>  endif
> +
> +config RUST_HRTIMER
> +       bool "Enable Rust hrtimer API"
> +       depends on RUST
> +       default y
> +       help
> +         This option allows exclusion of the Rust hrtimer API from the b=
uild.
> +         This allows testing out changes to the C API without having to =
update
> +         the Rust abstractions during initial development.
> +
> +         Say Y if you wish to build the Rust hrtimer API.
> +
> +         Say N if you wish to exclude the Rust hrtimer API from the buil=
d.
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 379c0f5772e5..e928b1340ee3 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -8,6 +8,9 @@
>  //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.=
h).
>  //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
>
> +#[cfg(CONFIG_RUST_HRTIMER)]
> +pub mod hrtimer;
> +
>  /// The number of nanoseconds per millisecond.
>  pub const NSEC_PER_MSEC: i64 =3D bindings::NSEC_PER_MSEC as i64;
>
> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
> new file mode 100644
> index 000000000000..fe20405d8bfe
> --- /dev/null
> +++ b/rust/kernel/time/hrtimer.rs
> @@ -0,0 +1,347 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Intrusive high resolution timers.
> +//!
> +//! Allows running timer callbacks without doing allocations at the time=
 of
> +//! starting the timer. For now, only one timer per type is allowed.
> +//!
> +//! # Vocabulary
> +//!
> +//! States:
> +//!
> +//! - Stopped: initialized but not started, or cancelled, or not restart=
ed.
> +//! - Started: initialized and started or restarted.
> +//! - Running: executing the callback.
> +//!
> +//! Operations:
> +//!
> +//! * Start
> +//! * Cancel
> +//! * Restart
> +//!
> +//! Events:
> +//!
> +//! * Expire
> +//!
> +//! ## State Diagram
> +//!
> +//! ```text
> +//!                                                   Return NoRestart
> +//!                       +---------------------------------------------=
------------------------+
> +//!                       |                                             =
                        |
> +//!                       |                                             =
                        |
> +//!                       |                                             =
                        |
> +//!                       |                                         Retu=
rn Restart              |
> +//!                       |                                      +------=
------------------+     |
> +//!                       |                                      |      =
                  |     |
> +//!                       |                                      |      =
                  |     |
> +//!                       v                                      v      =
                  |     |
> +//!           +-----------------+      Start      +------------------+  =
         +--------+-----+--+
> +//!           |                 +---------------->|                  |  =
         |                 |
> +//! Init      |                 |                 |                  |  =
Expire   |                 |
> +//! --------->|    Stopped      |                 |      Started     +--=
-------->|     Running     |
> +//!           |                 |     Cancel      |                  |  =
         |                 |
> +//!           |                 |<----------------+                  |  =
         |                 |
> +//!           +-----------------+                 +---------------+--+  =
         +-----------------+
> +//!                                                     ^         |
> +//!                                                     |         |
> +//!                                                     +---------+
> +//!                                                      Restart
> +//! ```
> +//!
> +//!
> +//! A timer is initialized in the **stopped** state. A stopped timer can=
 be
> +//! **started** by the `start` operation, with an **expiry** time. After=
 the
> +//! `start` operation, the timer is in the **started** state. When the t=
imer
> +//! **expires**, the timer enters the **running** state and the handler =
is
> +//! executed. After the handler has finished executing, the timer may en=
ter the
> +//! **started* or **stopped** state, depending on the return value of th=
e
> +//! handler. A running timer can be **canceled** by the `cancel` operati=
on. A
> +//! timer that is cancelled enters the **stopped** state.

This is a bit confusing because it sounds like you're describing a
*started* timer. After reading the next paragraph I think this wording
applies to both *started* and *running*, but it isn't unambiguous.

> +//!
> +//! A `cancel` or `restart` operation on a timer in the **running** stat=
e takes
> +//! effect after the handler has finished executing and the timer has tr=
ansitioned
> +//! out of the **running** state.

There's no external restart, right? I think this wording is confused
by the unification of cancel and restart under operations, though they
are not isomorphic. Restart (as I understand it) can only happen from
the handler, and cancel can only happen via a call to hrtimer_cancel.
It's also a bit strange that start isn't mentioned whenever cancel and
restart are mentioned.

> +//!
> +//! A `restart` operation on a timer in the **stopped** state is equival=
ent to a
> +//! `start` operation.
> +
> +use crate::{init::PinInit, prelude::*, time::Ktime, types::Opaque};
> +use core::marker::PhantomData;
> +
> +/// A timer backed by a C `struct hrtimer`.
> +///
> +/// # Invariants
> +///
> +/// * `self.timer` is initialized by `bindings::hrtimer_setup`.
> +#[pin_data]
> +#[repr(C)]
> +pub struct HrTimer<T> {
> +    #[pin]
> +    timer: Opaque<bindings::hrtimer>,
> +    _t: PhantomData<T>,
> +}
> +
> +// SAFETY: Ownership of an `HrTimer` can be moved to other threads and
> +// used/dropped from there.
> +unsafe impl<T> Send for HrTimer<T> {}
> +
> +// SAFETY: Timer operations are locked on C side, so it is safe to opera=
te on a
> +// timer from multiple threads

nit: missing article ("the" C side) and missing period.

> +unsafe impl<T> Sync for HrTimer<T> {}
> +
> +impl<T> HrTimer<T> {
> +    /// Return an initializer for a new timer instance.
> +    pub fn new() -> impl PinInit<Self>
> +    where
> +        T: HrTimerCallback,
> +    {
> +        pin_init!(Self {
> +            // INVARIANTS: We initialize `timer` with `hrtimer_setup` be=
low.

Why plural INVARIANTS?

> +            timer <- Opaque::ffi_init(move |place: *mut bindings::hrtime=
r| {
> +                // SAFETY: By design of `pin_init!`, `place` is a pointe=
r to a
> +                // live allocation. hrtimer_setup will initialize `place=
` and
> +                // does not require `place` to be initialized prior to t=
he call.
> +                unsafe {
> +                    bindings::hrtimer_setup(
> +                        place,
> +                        Some(T::Pointer::run),
> +                        bindings::CLOCK_MONOTONIC as i32,
> +                        bindings::hrtimer_mode_HRTIMER_MODE_REL,
> +                    );
> +                }
> +            }),
> +            _t: PhantomData,
> +        })
> +    }
> +
> +    /// Get a pointer to the contained `bindings::hrtimer`.
> +    ///
> +    /// This function do not create any references.

s/do/does/

But maybe this should use the same wording from Opaque::raw_get?

    /// This function is useful to get access to the value without
creating intermediate
    /// references.

If so, consider also naming the argument "this" for consistency. Same
for other methods below.

> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must point to a live allocation of at least the size of `S=
elf`.
> +    unsafe fn raw_get(ptr: *const Self) -> *mut bindings::hrtimer {
> +        // SAFETY: The field projection to `timer` does not go out of bo=
unds,
> +        // because the caller of this function promises that `ptr` point=
s to an
> +        // allocation of at least the size of `Self`.
> +        unsafe { Opaque::raw_get(core::ptr::addr_of!((*ptr).timer)) }
> +    }
> +
> +    /// Cancel an initialized and potentially running timer.
> +    ///
> +    /// If the timer handler is running, this will block until the handl=
er is
> +    /// finished.

nit: s/is finished/returns/ and maybe clarify the ordering, namely
that the timer is definitely in a stopped state after this returns.

> +    ///
> +    /// Users of the `HrTimer` API would not usually call this method di=
rectly.
> +    /// Instead they would use the safe [`HrTimerHandle::cancel`] on the=
 handle
> +    /// returned when the timer was started.
> +    ///
> +    /// This function does not create any references.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `self_ptr` must point to a valid `Self`.

Why use different phrasing here than on raw_get? The parameter name is
also different. Would be nice to be consistent.

> +    #[allow(dead_code)]
> +    pub(crate) unsafe fn raw_cancel(self_ptr: *const Self) -> bool {
> +        // SAFETY: timer_ptr points to an allocation of at least `HrTime=
r` size.
> +        let c_timer_ptr =3D unsafe { HrTimer::raw_get(self_ptr) };
> +
> +        // If the handler is running, this will wait for the handler to =
finish
> +        // before returning.
> +        // SAFETY: `c_timer_ptr` is initialized and valid. Synchronizati=
on is
> +        // handled on C side.

missing article here.

> +        unsafe { bindings::hrtimer_cancel(c_timer_ptr) !=3D 0 }
> +    }
> +}
> +
> +/// Implemented by pointer types that point to structs that embed a [`Hr=
Timer`].
> +///
> +/// Target (pointee) must be [`Sync`] because timer callbacks happen in =
another
> +/// thread of execution (hard or soft interrupt context).

Is this explaining the bound on the trait, or something that exists
outside the type system? If it's the former, isn't the Sync bound on
the trait going to apply to the pointer rather than the pointee?

> +///
> +/// Starting a timer returns a [`HrTimerHandle`] that can be used to man=
ipulate
> +/// the timer. Note that it is OK to call the start function repeatedly,=
 and
> +/// that more than one [`HrTimerHandle`] associated with a [`HrTimerPoin=
ter`] may
> +/// exist. A timer can be manipulated through any of the handles, and a =
handle
> +/// may represent a cancelled timer.
> +pub trait HrTimerPointer: Sync + Sized {
> +    /// A handle representing a started or restarted timer.
> +    ///
> +    /// If the timer is running or if the timer callback is executing wh=
en the
> +    /// handle is dropped, the drop method of [`HrTimerHandle`] should n=
ot return
> +    /// until the timer is stopped and the callback has completed.
> +    ///
> +    /// Note: When implementing this trait, consider that it is not unsa=
fe to
> +    /// leak the handle.

What does leak mean in this context?

> +    type TimerHandle: HrTimerHandle;
> +
> +    /// Start the timer with expiry after `expires` time units. If the t=
imer was
> +    /// already running, it is restarted with the new expiry time.
> +    fn start(self, expires: Ktime) -> Self::TimerHandle;
> +}
> +
> +/// Implemented by [`HrTimerPointer`] implementers to give the C timer c=
allback a
> +/// function to call.
> +// This is split from `HrTimerPointer` to make it easier to specify trai=
t bounds.
> +pub trait RawHrTimerCallback {
> +    /// This type is passed to [`HrTimerCallback::run`]. It may be a bor=
row of
> +    /// [`Self::CallbackTarget`], or it may be `Self::CallbackTarget` if=
 the
> +    /// implementation can guarantee correct access (exclusive or shared
> +    /// depending on the type) to the target during timer handler execut=
ion.
> +    type CallbackTarget<'a>;
> +
> +    /// Callback to be called from C when timer fires.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Only to be called by C code in `hrtimer` subsystem. `ptr` must p=
oint to

missing article, should be "...in the `hrtimer`..."

> +    /// the `bindings::hrtimer` structure that was used to start the tim=
er.
> +    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::h=
rtimer_restart;
> +}
> +
> +/// Implemented by structs that can be the target of a timer callback.
> +pub trait HrTimerCallback {
> +    /// The type whose [`RawHrTimerCallback::run`] method will be invoke=
d when
> +    /// the timer expires.
> +    type Pointer<'a>: RawHrTimerCallback;
> +
> +    /// Called by the timer logic when the timer fires.
> +    fn run(this: <Self::Pointer<'_> as RawHrTimerCallback>::CallbackTarg=
et<'_>)
> +    where
> +        Self: Sized;
> +}
> +
> +/// A handle representing a potentially running timer.
> +///
> +/// More than one handle representing the same timer might exist.
> +///
> +/// # Safety
> +///
> +/// When dropped, the timer represented by this handle must be cancelled=
, if it
> +/// is running. If the timer handler is running when the handle is dropp=
ed, the
> +/// drop method must wait for the handler to finish before returning.
> +///
> +/// Note: One way to satisfy the safety requirement is to call `Self::ca=
ncel` in
> +/// the drop implementation for `Self.`
> +pub unsafe trait HrTimerHandle {
> +    /// Cancel the timer, if it is running. If the timer handler is runn=
ing, block
> +    /// till the handler has finished.

Here's another case where "running" is confusingly used to refer to
the timer being in the state before the handler has begun to execute,
and also to the state after the handler has begun to execute.

> +    fn cancel(&mut self) -> bool;
> +}
> +
> +/// Implemented by structs that contain timer nodes.
> +///
> +/// Clients of the timer API would usually safely implement this trait b=
y using
> +/// the [`crate::impl_has_hr_timer`] macro.
> +///
> +/// # Safety
> +///
> +/// Implementers of this trait must ensure that the implementer has a [`=
HrTimer`]
> +/// field at the offset specified by `OFFSET` and that all trait methods=
 are
> +/// implemented according to their documentation.
> +///
> +/// [`impl_has_timer`]: crate::impl_has_timer
> +pub unsafe trait HasHrTimer<T> {
> +    /// Offset of the [`HrTimer`] field within `Self`
> +    const OFFSET: usize;
> +
> +    /// Return a pointer to the [`HrTimer`] within `Self`.
> +    ///
> +    /// This function does not create any references.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must point to a valid struct of type `Self`.
> +    unsafe fn raw_get_timer(ptr: *const Self) -> *const HrTimer<T> {
> +        // SAFETY: By the safety requirement of this trait, the trait
> +        // implementor will have a `HrTimer` field at the specified offs=
et.
> +        unsafe { ptr.cast::<u8>().add(Self::OFFSET).cast::<HrTimer<T>>()=
 }
> +    }
> +
> +    /// Return a pointer to the struct that is embedding the [`HrTimer`]=
 pointed
> +    /// to by `ptr`.
> +    ///
> +    /// This function does not create any references.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must point to a [`HrTimer<T>`] field in a struct of type `=
Self`.
> +    unsafe fn timer_container_of(ptr: *mut HrTimer<T>) -> *mut Self
> +    where
> +        Self: Sized,
> +    {
> +        // SAFETY: By the safety requirement of this function and the `H=
asHrTimer`
> +        // trait, the following expression will yield a pointer to the `=
Self`
> +        // containing the timer addressed by `ptr`.
> +        unsafe { ptr.cast::<u8>().sub(Self::OFFSET).cast::<Self>() }
> +    }
> +
> +    /// Get pointer to embedded `bindings::hrtimer` struct.
> +    ///
> +    /// This function does not create any references.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `self_ptr` must point to a valid `Self`.
> +    unsafe fn c_timer_ptr(self_ptr: *const Self) -> *const bindings::hrt=
imer {
> +        // SAFETY: `self_ptr` is a valid pointer to a `Self`.
> +        let timer_ptr =3D unsafe { Self::raw_get_timer(self_ptr) };
> +
> +        // SAFETY: timer_ptr points to an allocation of at least `HrTime=
r` size.
> +        unsafe { HrTimer::raw_get(timer_ptr) }
> +    }
> +
> +    /// Start the timer contained in the `Self` pointed to by `self_ptr`=
. If
> +    /// it is already running it is removed and inserted.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `self_ptr` must point to a valid `Self`.
> +    /// - Caller must ensure that `self` lives until the timer fires or =
is
> +    ///   canceled.
> +    unsafe fn start(self_ptr: *const Self, expires: Ktime) {
> +        // SAFETY: By function safety requirement, `self_ptr`is a valid =
`Self`.
> +        unsafe {
> +            bindings::hrtimer_start_range_ns(
> +                Self::c_timer_ptr(self_ptr).cast_mut(),
> +                expires.to_ns(),
> +                0,
> +                bindings::hrtimer_mode_HRTIMER_MODE_REL,
> +            );
> +        }
> +    }
> +}
> +
> +/// Use to implement the [`HasHrTimer<T>`] trait.
> +///
> +/// See [`module`] documentation for an example.
> +///
> +/// [`module`]: crate::time::hrtimer
> +#[macro_export]
> +macro_rules! impl_has_hr_timer {
> +    (
> +        impl$({$($generics:tt)*})?
> +            HasHrTimer<$timer_type:ty>
> +            for $self:ty
> +        { self.$field:ident }
> +        $($rest:tt)*
> +    ) =3D> {
> +        // SAFETY: This implementation of `raw_get_timer` only compiles =
if the
> +        // field has the right type.
> +        unsafe impl$(<$($generics)*>)? $crate::time::hrtimer::HasHrTimer=
<$timer_type> for $self {
> +            const OFFSET: usize =3D ::core::mem::offset_of!(Self, $field=
) as usize;
> +
> +            #[inline]
> +            unsafe fn raw_get_timer(ptr: *const Self) ->
> +                *const $crate::time::hrtimer::HrTimer<$timer_type>
> +            {
> +                // SAFETY: The caller promises that the pointer is not d=
angling.
> +                unsafe {
> +                    ::core::ptr::addr_of!((*ptr).$field)
> +                }
> +            }
> +        }
> +    }
> +}
>
> --
> 2.47.0
>
>

Cheers.
Tamir

