Return-Path: <linux-kernel+bounces-551142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B49BA5689C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5736216F5B4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0897F13A86C;
	Fri,  7 Mar 2025 13:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="B4chkNii"
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C6A1E868
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353336; cv=none; b=dcpoim+VgXlls16HIdDIAJAuzzmtOhU+CSGQUIGseyx79FeF6tGBltzW+ukDMRhGOq/DVQTuT86z6hcQ7fFAOTK7ez/VONNXG6C4RcpqV6/PF9UysrFNENqQuUoVPyBltm5xgNjMOhKY7I9vImdgStr6izX+H9HmwH5FSsGig/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353336; c=relaxed/simple;
	bh=YQWL+wmIuVv10+yePp6lxnmndBqngTBnuvjom1L3UKc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ti/uJXEK+5kfNna/N+cpDSsVK6nZn51uHECoAtAghFG+SC0aPeKpWsTrpwyuHF4Uoh92NHQgYGgmZXz/PUTaDudYDfL7eUp3p8+kx1dgX1aSZgPioXsgywHYsVqIBIS35IaDEGHFpW0H12LOjmrcFzqZQnsIzsG3zJ9rAWC0PwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=B4chkNii; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741353332; x=1741612532;
	bh=50DcLxnh3wd9fr3mX7Hv6xRCBCAsY1XlFpSZNnOZqPQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=B4chkNiiIo7CDMMNsxdLpI/vaQKWjEBRhxC8Pf6cbtDJn1Cj/Znng8Lv6FzsOVmQQ
	 bzF6x95v+w+eXNc9n31bUPGynTKSx7aQlvs2UMHFPZTLjFM+Csymgkg9A+2KJoUmPV
	 s0Zz+iOqp/idzLxGPmVzjMGHCvENf2UiiDi0dkA8kfEXJDfxjNqQU16xHaQTnK4noX
	 0jVIsYAvKh4C65KG0qMBZJvrsHtAkQ4uOZSR10FKSYfxIxh0rRlTV4ZwMfoeLu+bHf
	 HeaDq4F+xrIO1SqXXJfcs/ZKzR5xBS5tbmIhYrJ+27FNJKRLPGoD4Ss7SxeN4yhUOZ
	 LOYtf28/HrJKA==
Date: Fri, 07 Mar 2025 13:15:26 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, Markus Elfring <Markus.Elfring@web.de>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 08/13] rust: hrtimer: implement `UnsafeHrTimerPointer` for `Pin<&mut T>`
Message-ID: <D8A28FTNL1BC.3AYZMT4OYF79R@proton.me>
In-Reply-To: <20250307-hrtimer-v3-v6-12-rc2-v10-8-0cf7e9491da4@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org> <20250307-hrtimer-v3-v6-12-rc2-v10-8-0cf7e9491da4@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 97f84d8619d16470f551c5195984fab40fd3b786
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 7, 2025 at 11:11 AM CET, Andreas Hindborg wrote:
> Allow pinned mutable references to structs that contain a `HrTimer` node =
to
> be scheduled with the `hrtimer` subsystem.
>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/time/hrtimer.rs         |   2 +
>  rust/kernel/time/hrtimer/pin_mut.rs | 101 ++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 103 insertions(+)
>
> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
> index 2ca56397eade..d2791fd624b7 100644
> --- a/rust/kernel/time/hrtimer.rs
> +++ b/rust/kernel/time/hrtimer.rs
> @@ -441,3 +441,5 @@ unsafe fn timer_container_of(ptr: *mut $crate::time::=
hrtimer::HrTimer<$timer_typ
>  pub use arc::ArcHrTimerHandle;
>  mod pin;
>  pub use pin::PinHrTimerHandle;
> +mod pin_mut;
> +pub use pin_mut::PinMutHrTimerHandle;
> diff --git a/rust/kernel/time/hrtimer/pin_mut.rs b/rust/kernel/time/hrtim=
er/pin_mut.rs
> new file mode 100644
> index 000000000000..4f4a9e9602d8
> --- /dev/null
> +++ b/rust/kernel/time/hrtimer/pin_mut.rs
> @@ -0,0 +1,101 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use super::HasHrTimer;
> +use super::HrTimer;
> +use super::HrTimerCallback;
> +use super::HrTimerHandle;
> +use super::RawHrTimerCallback;
> +use super::UnsafeHrTimerPointer;
> +use crate::time::Ktime;
> +use core::pin::Pin;
> +
> +/// A handle for a `Pin<&mut HasHrTimer>`. When the handle exists, the t=
imer might
> +/// be running.
> +pub struct PinMutHrTimerHandle<'a, T>
> +where
> +    T: HasHrTimer<T>,
> +{
> +    pub(crate) inner: Pin<&'a mut T>,
> +}
> +
> +// SAFETY: We cancel the timer when the handle is dropped. The implement=
ation of
> +// the `cancel` method will block if the timer handler is running.
> +unsafe impl<'a, T> HrTimerHandle for PinMutHrTimerHandle<'a, T>
> +where
> +    T: HasHrTimer<T>,
> +{
> +    fn cancel(&mut self) -> bool {
> +        // SAFETY: We are not moving out of `self` or handing out mutabl=
e
> +        // references to `self`.
> +        let self_ptr =3D unsafe { self.inner.as_mut().get_unchecked_mut(=
) as *mut T };
> +
> +        // SAFETY: As we got `self_ptr` from a reference above, it must =
point to
> +        // a valid `T`.
> +        let timer_ptr =3D unsafe { <T as HasHrTimer<T>>::raw_get_timer(s=
elf_ptr) };
> +
> +        // SAFETY: As `timer_ptr` is derived from a reference, it must p=
oint to
> +        // a valid and initialized `HrTimer`.
> +        unsafe { HrTimer::<T>::raw_cancel(timer_ptr) }
> +    }
> +}
> +
> +impl<'a, T> Drop for PinMutHrTimerHandle<'a, T>
> +where
> +    T: HasHrTimer<T>,
> +{
> +    fn drop(&mut self) {
> +        self.cancel();
> +    }
> +}
> +
> +// SAFETY: We capture the lifetime of `Self` when we create a
> +// `PinMutHrTimerHandle`, so `Self` will outlive the handle.
> +unsafe impl<'a, T> UnsafeHrTimerPointer for Pin<&'a mut T>
> +where
> +    T: Send + Sync,
> +    T: HasHrTimer<T>,
> +    T: HrTimerCallback<Pointer<'a> =3D Self>,
> +    Pin<&'a mut T>: RawHrTimerCallback<CallbackTarget<'a> =3D Self>,
> +{
> +    type TimerHandle =3D PinMutHrTimerHandle<'a, T>;
> +
> +    unsafe fn start(self, expires: Ktime) -> Self::TimerHandle {
> +        // Cast to pointer
> +        let self_ptr: *const T =3D <Self as core::ops::Deref>::deref(&se=
lf);

You cannot go through a shared reference here, since you convert the
pointer obtained here in the `run` function later back into a mutable
reference. You will have to use `get_unchecked_mut` or
`into_inner_unchecked`.

> +
> +        // SAFETY:
> +        //  - As we derive `self_ptr` from a reference above, it must po=
int to a
> +        //    valid `T`.
> +        //  - We keep `self` alive by wrapping it in a handle below.
> +        unsafe { T::start(self_ptr, expires) };
> +
> +        PinMutHrTimerHandle { inner: self }
> +    }
> +}
> +
> +impl<'a, T> RawHrTimerCallback for Pin<&'a mut T>
> +where
> +    T: HasHrTimer<T>,
> +    T: HrTimerCallback<Pointer<'a> =3D Self>,
> +{
> +    type CallbackTarget<'b> =3D Self;
> +
> +    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::h=
rtimer_restart {
> +        // `HrTimer` is `repr(C)`
> +        let timer_ptr =3D ptr as *mut HrTimer<T>;
> +
> +        // SAFETY: By the safety requirement of this function, `timer_pt=
r`
> +        // points to a `HrTimer<T>` contained in an `T`.
> +        let receiver_ptr =3D unsafe { T::timer_container_of(timer_ptr) }=
;
> +
> +        // SAFETY: By the safety requirement of this function, `timer_pt=
r`
> +        // points to a `HrTimer<T>` contained in an `T`.

Same question here as for the `Pin<&T>` patch.

---
Cheers,
Benno

> +        let receiver_ref =3D unsafe { &mut *receiver_ptr };
> +
> +        // SAFETY: `receiver_ref` only exists as pinned, so it is safe t=
o pin it
> +        // here.
> +        let receiver_pin =3D unsafe { Pin::new_unchecked(receiver_ref) }=
;
> +
> +        T::run(receiver_pin).into_c()
> +    }
> +}
>
> --
> 2.47.0



