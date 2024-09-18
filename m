Return-Path: <linux-kernel+bounces-332865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B7297C004
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 20:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BFC5283358
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 18:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8781C9EC4;
	Wed, 18 Sep 2024 18:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="BeGB10Gw"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B00B1509AE
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726683198; cv=none; b=WXQO6y0/gXFI5Gjfgwn5AaU5FwiA9qbXzUmQnvaazkmJhAPVNtEjg7E0hmkt8rn+QEDukkByBphVYask2U8sIdrzAVBqpCVsjnx/JmhVAZSRlweY2TFJcu7R14ThFaFHLL+HYtcNhEbOzqGB3gC2H9RGkrvTWYhJTIPosJ4++Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726683198; c=relaxed/simple;
	bh=fgypAt171m5So09Wjj7w+t5PaO9kShJN9gLRg5dNG2o=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LUESEt4XfEzMKlGEH8a4shWWBBL4gSh43kb+YoCFWcWGnrzTUm8VXmr8LeQ+IcdLENZmi/+5CwMjhZx1SQ7TnbDSo+7AL/qCb0MAQlBUYSbv4GJ8gZvyWIU5/Kftv/RI6RCB3SvxRuWbnd1/hqQkYLxttiT8gPaj3f9xirYgAbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=BeGB10Gw; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=doooutqqifdwzm5d56xktn2yam.protonmail; t=1726683194; x=1726942394;
	bh=2tKN1tTfgLVEdmHrDZ46MrwbY6b4WkLLPf4HJl3zkj0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=BeGB10GwtkrRLhYKS/B7xXoOwd8Q2Rb3GzeoFjhbnLd/wqGErjNjiWQ3U1N6fdGBQ
	 eeN7Mtni9kvyOlmxKTLuVPJVa4aiY22U+T3FTyGRoXp5dRpTbp4cK7kvcRzCNMqGVE
	 GVLblhl+ROgFpjNyPGPq5hm3LqvON/2qP19qm9++OB8pPUBYYhedllrnSKPC91Cqnu
	 nJb6WgsjJocO1qXCNpCAt0j+CIdMfDJcseYve2KqQ/azqZ07T8ax7x5cmXlTGSN9vO
	 gKcEhR8LieKVdEST30jiKbVqfnFLlORQUshkPGPX4oxXJh+FVnmmvuIE66ssfY3mFv
	 FZlDLsYW2mzSg==
Date: Wed, 18 Sep 2024 18:13:11 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/14] rust: hrtimer: introduce hrtimer support
Message-ID: <f502f6c6-40b7-4ec4-8d0c-09adb0df1a30@proton.me>
In-Reply-To: <20240917222739.1298275-3-a.hindborg@kernel.org>
References: <20240917222739.1298275-1-a.hindborg@kernel.org> <20240917222739.1298275-3-a.hindborg@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 953dc1dc911ca6c34dab7db4b90dcbf4cf744df6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.09.24 00:27, Andreas Hindborg wrote:
> This patch adds support for intrusive use of the hrtimer system. For now,
> only one timer can be embedded in a Rust struct.
>=20
> The hrtimer Rust API is based on the intrusive style pattern introduced b=
y
> the Rust workqueue API.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/hrtimer.rs | 231 +++++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs     |   1 +
>  2 files changed, 232 insertions(+)
>  create mode 100644 rust/kernel/hrtimer.rs
>=20
> diff --git a/rust/kernel/hrtimer.rs b/rust/kernel/hrtimer.rs
> new file mode 100644
> index 000000000000..5c92afd8eb2c
> --- /dev/null
> +++ b/rust/kernel/hrtimer.rs
> @@ -0,0 +1,231 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Intrusive high resolution timers.
> +//!
> +//! Allows scheduling timer callbacks without doing allocations at the t=
ime of
> +//! scheduling. For now, only one timer per type is allowed.
> +
> +use crate::{init::PinInit, prelude::*, time::Ktime, types::Opaque};
> +use core::marker::PhantomData;
> +
> +/// A timer backed by a C `struct hrtimer`.
> +///
> +/// # Invariants
> +///
> +/// * `self.timer` is initialized by `bindings::hrtimer_init`.
> +#[repr(transparent)]
> +#[pin_data]
> +pub struct Timer<U> {
> +    #[pin]
> +    timer: Opaque<bindings::hrtimer>,
> +    _t: PhantomData<U>,
> +}
> +
> +// SAFETY: A `Timer` can be moved to other threads and used/dropped from=
 there.
> +unsafe impl<U> Send for Timer<U> {}
> +
> +// SAFETY: Timer operations are locked on C side, so it is safe to opera=
te on a
> +// timer from multiple threads
> +unsafe impl<U> Sync for Timer<U> {}
> +
> +impl<T> Timer<T> {
> +    /// Return an initializer for a new timer instance.
> +    pub fn new() -> impl PinInit<Self>
> +    where
> +        T: TimerCallback,
> +    {
> +        pin_init!( Self {

I would remove the space after the `(`.
Would be great if we had rustfmt support for custom macros.

> +            // INVARIANTS: We initialize `timer` with `hrtimer_init` bel=
ow.
> +            timer <- Opaque::ffi_init(move |place: *mut bindings::hrtime=
r| {
> +                // SAFETY: By design of `pin_init!`, `place` is a pointe=
r live
> +                // allocation. hrtimer_init will initialize `place` and =
does not
> +                // require `place` to be initialized prior to the call.
> +                unsafe {
> +                    bindings::hrtimer_init(
> +                        place,
> +                        bindings::CLOCK_MONOTONIC as i32,
> +                        bindings::hrtimer_mode_HRTIMER_MODE_REL,
> +                    );
> +                }
> +
> +                // SAFETY: `place` is pointing to a live allocation, so =
the deref
> +                // is safe.
> +                let function: *mut Option<_> =3D

Do you really need this type hint?

> +                    unsafe { core::ptr::addr_of_mut!((*place).function) =
};
> +
> +                // SAFETY: `function` points to a valid allocation and w=
e have
> +                // exclusive access.
> +                unsafe { core::ptr::write(function, Some(T::CallbackTarg=
et::run)) };
> +            }),
> +            _t: PhantomData,
> +        })
> +    }
> +
> +    /// Get a pointer to the contained `bindings::hrtimer`.
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
> +}
> +
> +/// Implemented by pointer types that point to structs that embed a [`Ti=
mer`].
> +///
> +/// Typical implementers would be [`Box<T>`], [`Arc<T>`], [`ARef<T>`] wh=
ere `T`
> +/// has a field of type `Timer`.
> +///
> +/// Target must be [`Sync`] because timer callbacks happen in another th=
read of
> +/// execution (hard or soft interrupt context).
> +///
> +/// Scheduling a timer returns a [`TimerHandle`] that can be used to man=
ipulate
> +/// the timer. Note that it is OK to call the schedule function repeated=
ly, and
> +/// that more than one [`TimerHandle`] associated with a `TimerPointer` =
may
> +/// exist. A timer can be manipulated through any of the handles, and a =
handle
> +/// may represent a cancelled timer.
> +///
> +/// [`Box<T>`]: Box
> +/// [`Arc<T>`]: crate::sync::Arc
> +/// [`ARef<T>`]: crate::types::ARef
> +pub trait TimerPointer: Sync + Sized {
> +    /// A handle representing a scheduled timer.
> +    ///
> +    /// If the timer is armed or if the timer callback is running when t=
he
> +    /// handle is dropped, the drop method of `TimerHandle` should not r=
eturn
> +    /// until the timer is unarmed and the callback has completed.
> +    ///
> +    /// Note: It must be safe to leak the handle.
> +    type TimerHandle: TimerHandle;

Why does this need to be an associated type? Couldn't we have a
`TimerHandle<T>` struct? The schedule function below could then return
`TimerHandle<Self>`.

> +
> +    /// Schedule the timer after `expires` time units. If the timer was =
already
> +    /// scheduled, it is rescheduled at the new expiry time.
> +    fn schedule(self, expires: Ktime) -> Self::TimerHandle;
> +}



> +/// Use to implement the [`HasTimer<T>`] trait.
> +///
> +/// See [`module`] documentation for an example.
> +///
> +/// [`module`]: crate::hrtimer
> +#[macro_export]
> +macro_rules! impl_has_timer {
> +    (
> +        impl$({$($generics:tt)*})?
> +            HasTimer<$timer_type:ty>
> +            for $self:ty
> +        { self.$field:ident }
> +        $($rest:tt)*
> +    ) =3D> {
> +        // SAFETY: This implementation of `raw_get_timer` only compiles =
if the
> +        // field has the right type.
> +        unsafe impl$(<$($generics)*>)? $crate::hrtimer::HasTimer<$timer_=
type>  for $self {

There is a double space in front of `for`.

> +            const OFFSET: usize =3D ::core::mem::offset_of!(Self, $field=
) as usize;
> +
> +            #[inline]
> +            unsafe fn raw_get_timer(ptr: *const Self) ->
> +                *const $crate::hrtimer::Timer<$timer_type>
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
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 274bdc1b0a82..55f846c5a849 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -34,6 +34,7 @@
>  pub mod error;
>  #[cfg(CONFIG_RUST_FW_LOADER_ABSTRACTIONS)]
>  pub mod firmware;
> +pub mod hrtimer;
>  pub mod init;
>  pub mod ioctl;
>  #[cfg(CONFIG_KUNIT)]
> --
> 2.46.0
>=20
>=20


