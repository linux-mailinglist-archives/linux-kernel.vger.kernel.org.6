Return-Path: <linux-kernel+bounces-552047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA3AA574B5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 23:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A71189C146
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 22:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B22B241CA5;
	Fri,  7 Mar 2025 22:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IX5kYgPt"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B780C1A5B88;
	Fri,  7 Mar 2025 22:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741385263; cv=none; b=Bo/n0VtISF9AuVI6X8jOIxbYr8NOAYPOud2bFo+b0xjJ1RaacT6VBQFEJYSDctChjioL1aPOCvwjdH+D8lBql8ffUGaH3YurJvHb4jNUZdnbcOhOpYwhMdDFz/wXUqBm40O5zNJZURERU2N1uOOVq4WDvFQ47sagr7ITmhE5XQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741385263; c=relaxed/simple;
	bh=F5v+bUQNPfp3I/kpIkF//Q7WJhPT8yl6OKfoM5aHo+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KajEsEMpG4pcnNSgpbh47G59BiZPSfFgvjvc2CzgQ46cQUnw7fc2wA+oKamC13l6yuWhqK4+7j65LgMY048Ee9+hNWt2GNJAm3GY8VWP5+8huZ9r73gSSVqVBS05kDwd+BuAuu7/c/LcoCVGt1VGg8mc/NAmV0xH4V8GlrHQ2no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IX5kYgPt; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30613802a6bso24622361fa.1;
        Fri, 07 Mar 2025 14:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741385259; x=1741990059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrV+HTzsLyE0q0FjJT3FiUcFk5z6NXv+u+UCT3WofwU=;
        b=IX5kYgPtwIda9rkUzc9XzYmCwsn+hu4L2yFwnOSRLjFRx4hewU4SP7yy7Lh0lpe2ql
         UWRS59TjBY2oNP/hSrgrWHLLekLq2agUt96Ztdf6S3ovtHDQQmplMp1gt5jVEefGSdSx
         9EgYeRQThIax9OwZV100y3PGzm7V9FSwdA+4USXLQVxXcdy+JyAVQ62/9s4Hgzh4I9QX
         iJRTcD9UA2d+iBmFkJuqJbzCRCGEkBE2myu8t2Gdg0kPfrk2iF3ygMDvD5udsZkoXvwC
         /InWRbIh2WuiyHDCg8x0bQsy/Srcl1zANXGletKGJqmGPaDVk4dygAw0oZTzFEt5CT6B
         2c4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741385259; x=1741990059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PrV+HTzsLyE0q0FjJT3FiUcFk5z6NXv+u+UCT3WofwU=;
        b=cpMuk82FhOn3v+l/AbYejojnY7RNpbb6bzdKsnIGF1g/d6L94pF7ifFtJAZa659tbR
         SStBkyWOwy4/BvvDJgSmYJJg9pEqnu9QWx4fDeIvncL/oRaonXKQHyex/KiKGkCL4xWu
         /fij/ROsr0vG9wq9VQFZEJScgV6ZgTbfbSVCCRnWgf0K/eO4srZ3DeSeljYOhZjcfFyF
         gKWqlCM3nxiz+zyrh+IbNVoCRVIzyOdZg+d1ZTIgBCoacPuranZW1r2+QUuxRdq8G1O0
         +jIF1NTavahm/e6wlOcMYOU8LviP64cilCs49Cy8yAqjj94UeC9g5CVt2FRk8b0QM3ti
         WXwA==
X-Forwarded-Encrypted: i=1; AJvYcCXBxQAaXlJatzUUJcfbExz8KjyYS2/6+ViWiM7VLfBkNovUYLe73hD4EcBodE9Dap0nRLZtK99jv9BQMljdmSg=@vger.kernel.org, AJvYcCXi2/q9Stv9hHpwObIawIp28cMIHR+YJ5dMf0ckMlM2xKyywvzYeTpZutz6UZlNRPZviyoolOLsckjrgjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqQL/T9O6wdIGOQ+Qier8O1l+BhN1DgIPmwXb+kAZG7m6Wzghd
	YdaQAYlYsQa6oxZ81CT+LJ1TXW8pU8aVLdM8N5tWqmjM6adqeWEX/xW0kfIzJ33fQm/sPlfwjOs
	adwTNDAAoU2KhBG/swJd42Jd2bNEkVLPvcZI=
X-Gm-Gg: ASbGncvKqs2G7MyIstVwF6C0Vu9XOTraKosD7eMU+psI0+DC8Q8XUST+e2Dh8we89oX
	DiT8/bPqtvq60lhSHZ4UzX+oO6S3t9b5MnrWJ0nSSHts00HRm1kSkNotev0Tp4zTL39nHzda1wu
	G355H0gnroHYLjQRsQlbkjZ3TCbAAzj0lLpPBZSGqvjmhzeYDU8Aev3uR+ISt1
X-Google-Smtp-Source: AGHT+IE1uULeizDHWyO0d7hF5rr2RWuIEgFE8H9Z8wKTke0iSgnfdD9mBqDYPtEPfwFxW1t3Zfd1fGATmt1vSw88ZlU=
X-Received: by 2002:a05:651c:1a0b:b0:309:2ed:7331 with SMTP id
 38308e7fff4ca-30bf453cdb5mr20832191fa.18.1741385258369; Fri, 07 Mar 2025
 14:07:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-hrtimer-v3-v6-12-rc2-v11-0-7934aefd6993@kernel.org> <20250307-hrtimer-v3-v6-12-rc2-v11-1-7934aefd6993@kernel.org>
In-Reply-To: <20250307-hrtimer-v3-v6-12-rc2-v11-1-7934aefd6993@kernel.org>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 7 Mar 2025 17:07:02 -0500
X-Gm-Features: AQ5f1JrL8-U1G29EF9POEZO4CXU0RPQVWfGCVTsZiAy0s0_hbJ1ndE-fe_GHggc
Message-ID: <CAJ-ks9mteU3qAApVxo0eGYshR3_CME54qaqVD2z4ZAyD1=Kd5A@mail.gmail.com>
Subject: Re: [PATCH v11 01/13] rust: hrtimer: introduce hrtimer support
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, 
	Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, 
	Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Markus Elfring <Markus.Elfring@web.de>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 4:40=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel.=
org> wrote:
>
> Add support for intrusive use of the hrtimer system. For now,
> only add support for embedding one timer per Rust struct.
>
> The hrtimer Rust API is based on the intrusive style pattern introduced b=
y
> the Rust workqueue API.
>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/time.rs         |   2 +
>  rust/kernel/time/hrtimer.rs | 351 ++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 353 insertions(+)
>
> diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
> index 379c0f5772e5..fab1dadfa589 100644
> --- a/rust/kernel/time.rs
> +++ b/rust/kernel/time.rs
> @@ -8,6 +8,8 @@
>  //! C header: [`include/linux/jiffies.h`](srctree/include/linux/jiffies.=
h).
>  //! C header: [`include/linux/ktime.h`](srctree/include/linux/ktime.h).
>
> +pub mod hrtimer;
> +
>  /// The number of nanoseconds per millisecond.
>  pub const NSEC_PER_MSEC: i64 =3D bindings::NSEC_PER_MSEC as i64;
>
> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
> new file mode 100644
> index 000000000000..dc64cef96dd4
> --- /dev/null
> +++ b/rust/kernel/time/hrtimer.rs
> @@ -0,0 +1,351 @@
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
> +//! executed. After the handler has returned, the timer may enter the
> +//! **started* or **stopped** state, depending on the return value of th=
e
> +//! handler. A timer in the **started** or **running** state may be **ca=
nceled**
> +//! by the `cancel` operation. A timer that is cancelled enters the **st=
opped**
> +//! state.
> +//!
> +//! A `cancel` or `restart` operation on a timer in the **running** stat=
e takes
> +//! effect after the handler has returned and the timer has transitioned
> +//! out of the **running** state.
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
> +// SAFETY: Timer operations are locked on the C side, so it is safe to o=
perate
> +// on a timer from multiple threads.
> +unsafe impl<T> Sync for HrTimer<T> {}
> +
> +impl<T> HrTimer<T> {
> +    /// Return an initializer for a new timer instance.
> +    pub fn new() -> impl PinInit<Self>
> +    where
> +        T: HrTimerCallback,
> +    {
> +        pin_init!(Self {
> +            // INVARIANT: We initialize `timer` with `hrtimer_setup` bel=
ow.
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
> +    /// This function is useful to get access to the value without creat=
ing
> +    /// intermediate references.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `this` must point to a live allocation of at least the size of `=
Self`.
> +    unsafe fn raw_get(this: *const Self) -> *mut bindings::hrtimer {
> +        // SAFETY: The field projection to `timer` does not go out of bo=
unds,
> +        // because the caller of this function promises that `this` poin=
ts to an
> +        // allocation of at least the size of `Self`.
> +        unsafe { Opaque::raw_get(core::ptr::addr_of!((*this).timer)) }
> +    }
> +
> +    /// Cancel an initialized and potentially running timer.
> +    ///
> +    /// If the timer handler is running, this function will block until =
the
> +    /// handler returns.
> +    ///
> +    /// Note that the timer might be started by a concurrent start opera=
tion. If
> +    /// so, the timer might not be in the **stopped** state when this fu=
nction
> +    /// returns.
> +    ///
> +    /// Users of the `HrTimer` API would not usually call this method di=
rectly.
> +    /// Instead they would use the safe [`HrTimerHandle::cancel`] on the=
 handle
> +    /// returned when the timer was started.
> +    ///
> +    /// This function is useful to get access to the value without creat=
ing
> +    /// intermediate references.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `this` must point to a valid `Self`.
> +    #[allow(dead_code)]
> +    pub(crate) unsafe fn raw_cancel(this: *const Self) -> bool {
> +        // SAFETY: `this` points to an allocation of at least `HrTimer` =
size.
> +        let c_timer_ptr =3D unsafe { HrTimer::raw_get(this) };
> +
> +        // If the handler is running, this will wait for the handler to =
return
> +        // before returning.
> +        // SAFETY: `c_timer_ptr` is initialized and valid. Synchronizati=
on is
> +        // handled on the C side.
> +        unsafe { bindings::hrtimer_cancel(c_timer_ptr) !=3D 0 }
> +    }
> +}
> +
> +/// Implemented by pointer types that point to structs that contain a [`=
HrTimer`].
> +///
> +/// `Self` must be [`Sync`] because it is passed to timer callbacks in a=
nother
> +/// thread of execution (hard or soft interrupt context).
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
> +    /// Type of the parameter passed to [`HrTimerCallback::run`]. It may=
 be
> +    /// [`Self`], or a pointer type derived from [`Self`].
> +    type CallbackTarget<'a>;
> +
> +    /// Callback to be called from C when timer fires.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Only to be called by C code in the `hrtimer` subsystem. `this` m=
ust point
> +    /// to the `bindings::hrtimer` structure that was used to start the =
timer.
> +    unsafe extern "C" fn run(this: *mut bindings::hrtimer) -> bindings::=
hrtimer_restart;
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
> +/// drop method must wait for the handler to return before returning.
> +///
> +/// Note: One way to satisfy the safety requirement is to call `Self::ca=
ncel` in
> +/// the drop implementation for `Self.`
> +pub unsafe trait HrTimerHandle {
> +    /// Cancel the timer. If the timer is in the running state, block ti=
ll the
> +    /// handler has returned.
> +    ///
> +    /// Note that the timer might be started by a concurrent start opera=
tion. If
> +    /// so, the timer might not be in the **stopped** state when this fu=
nction
> +    /// returns.
> +    ///
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

OFFSET no longer exists.

> +pub unsafe trait HasHrTimer<T> {
> +    /// Return a pointer to the [`HrTimer`] within `Self`.
> +    ///
> +    /// This function is useful to get access to the value without creat=
ing
> +    /// intermediate references.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `this` must be a valid pointer.
> +    unsafe fn raw_get_timer(this: *const Self) -> *const HrTimer<T>;
> +
> +    /// Return a pointer to the struct that is containing the [`HrTimer`=
] pointed
> +    /// to by `ptr`.
> +    ///
> +    /// This function is useful to get access to the value without creat=
ing
> +    /// intermediate references.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must point to a [`HrTimer<T>`] field in a struct of type `=
Self`.
> +    unsafe fn timer_container_of(ptr: *mut HrTimer<T>) -> *mut Self
> +    where
> +        Self: Sized;
> +
> +    /// Get pointer to the contained `bindings::hrtimer` struct.
> +    ///
> +    /// This function is useful to get access to the value without creat=
ing
> +    /// intermediate references.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `this` must be a valid pointer.
> +    unsafe fn c_timer_ptr(this: *const Self) -> *const bindings::hrtimer=
 {
> +        // SAFETY: `this` is a valid pointer to a `Self`.
> +        let timer_ptr =3D unsafe { Self::raw_get_timer(this) };
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
> +    /// - `this` must point to a valid `Self`.
> +    /// - Caller must ensure that the pointee of `this` lives until the =
timer
> +    ///   fires or is canceled.
> +    unsafe fn start(this: *const Self, expires: Ktime) {
> +        // SAFETY: By function safety requirement, `this`is a valid `Sel=
f`.
> +        unsafe {
> +            bindings::hrtimer_start_range_ns(
> +                Self::c_timer_ptr(this).cast_mut(),
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
> +
> +            #[inline]
> +            unsafe fn raw_get_timer(
> +                this: *const Self,
> +            ) -> *const $crate::time::hrtimer::HrTimer<$timer_type> {
> +                // SAFETY: The caller promises that the pointer is not d=
angling.
> +                unsafe { ::core::ptr::addr_of!((*this).$field) }
> +            }
> +
> +            #[inline]
> +            unsafe fn timer_container_of(
> +                ptr: *mut $crate::time::hrtimer::HrTimer<$timer_type>,
> +            ) -> *mut Self {
> +                // SAFETY: As per the safety requirement of this functio=
n, `ptr`
> +                // is pointing inside a `$timer_type`.
> +                unsafe { ::kernel::container_of!(ptr, $timer_type, $fiel=
d).cast_mut() }
> +            }
> +        }
> +    }
> +}
>
> --
> 2.47.0
>
>

Reviewed-by: Tamir Duberstein <tamird@gmail.com>

