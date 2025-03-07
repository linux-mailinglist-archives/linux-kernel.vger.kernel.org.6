Return-Path: <linux-kernel+bounces-551131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8BBA5688B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455021898F63
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B469A219A97;
	Fri,  7 Mar 2025 13:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="VwHwIzyu"
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA570219A91;
	Fri,  7 Mar 2025 13:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353132; cv=none; b=mTjDOIewPL8rVQQxpXZz5/EigOqahmTDNAtrba7UICM3thqyiLeQ3c0vvUd0xKCWZnVNEw9KNsdTuPxCZ4Va+nuxGea0neOjZDri+TR8F74mYBugO2HoVvJi1qsyobQDq6slTv8o06m4HPDtkgikA8jvOM1L+qzMrvdxXDzc5S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353132; c=relaxed/simple;
	bh=JU8htKFP4OTNtmFYmIpr/tleZo1HgElVetqRW0R1f68=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o3/X+mt/Ayrspz6tWRSngJuKqfzjTWcqGZYH5Jx5NqsILKHtFFKs2Sou2lQOPrguRFAT8RCGm66Nw1acurLymFGL+iz/YqtIFY9hhKKVFYZMjJb/y1bSuq2pwD73IAsVSVgP86HDPUj3Y4wJiIdDLNYMZvTUPVenYMlqkBIkqqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=VwHwIzyu; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=d6eet5shpfgetkni5iz6gdgrwy.protonmail; t=1741353125; x=1741612325;
	bh=/+q9lE6UJf74WcjYXHOyPYDemOtS/IPH0c3XT1oZCQc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=VwHwIzyukVPXTfYdBb5XH8uGqo4jJAsxi78WWBsZlcmgEFXiy0LN8TCMqCXqTmZs8
	 1E7Vdbu+tm6Ld8qj0lvZmt0zBkuA2W1/wo+en3R2BFZ4CbxNr+STmQFTZuYByEP82F
	 gJiwMs7zMnJGorWBbcn8ufNTNrc6h6n+TsB2SqI+LQGriNSM9tjHrh4o7F08gaQGUX
	 czKIIBtt9atkdr/OIDR97CV5Tl4E5q5R+t7jg9/jBFgA+hYiAdPX3yJUQ03BAhUEKr
	 hlNN7cP0FNjseeLTLzSMWBzV78iGblrqFHeia/uKEKFl/AFO/PCMpXz6vMQcB6rezI
	 OiLBK7i9m6ECg==
Date: Fri, 07 Mar 2025 13:12:01 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, Markus Elfring <Markus.Elfring@web.de>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 07/13] rust: hrtimer: implement `UnsafeHrTimerPointer` for `Pin<&T>`
Message-ID: <D8A25UNDIJHK.216EX6YG4EJ6E@proton.me>
In-Reply-To: <20250307-hrtimer-v3-v6-12-rc2-v10-7-0cf7e9491da4@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org> <20250307-hrtimer-v3-v6-12-rc2-v10-7-0cf7e9491da4@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f68f5ec89961c2cc36164558a8db5bdee9fb5b01
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 7, 2025 at 11:11 AM CET, Andreas Hindborg wrote:
> Allow pinned references to structs that contain a `HrTimer` node to be
> scheduled with the `hrtimer` subsystem.
>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/time/hrtimer.rs     |  2 +
>  rust/kernel/time/hrtimer/pin.rs | 99 +++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 101 insertions(+)
>
> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
> index d90a25785f87..2ca56397eade 100644
> --- a/rust/kernel/time/hrtimer.rs
> +++ b/rust/kernel/time/hrtimer.rs
> @@ -439,3 +439,5 @@ unsafe fn timer_container_of(ptr: *mut $crate::time::=
hrtimer::HrTimer<$timer_typ
>
>  mod arc;
>  pub use arc::ArcHrTimerHandle;
> +mod pin;
> +pub use pin::PinHrTimerHandle;
> diff --git a/rust/kernel/time/hrtimer/pin.rs b/rust/kernel/time/hrtimer/p=
in.rs
> new file mode 100644
> index 000000000000..6c9f2190f8e1
> --- /dev/null
> +++ b/rust/kernel/time/hrtimer/pin.rs
> @@ -0,0 +1,99 @@
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
> +/// A handle for a `Pin<&HasHrTimer>`. When the handle exists, the timer=
 might be
> +/// running.
> +pub struct PinHrTimerHandle<'a, T>
> +where
> +    T: HasHrTimer<T>,
> +{
> +    pub(crate) inner: Pin<&'a T>,
> +}
> +
> +// SAFETY: We cancel the timer when the handle is dropped. The implement=
ation of
> +// the `cancel` method will block if the timer handler is running.
> +unsafe impl<'a, T> HrTimerHandle for PinHrTimerHandle<'a, T>
> +where
> +    T: HasHrTimer<T>,
> +{
> +    fn cancel(&mut self) -> bool {
> +        let self_ptr: *const T =3D self.inner.get_ref();
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
> +impl<'a, T> Drop for PinHrTimerHandle<'a, T>
> +where
> +    T: HasHrTimer<T>,
> +{
> +    fn drop(&mut self) {
> +        self.cancel();
> +    }
> +}
> +
> +// SAFETY: We capture the lifetime of `Self` when we create a `PinHrTime=
rHandle`,
> +// so `Self` will outlive the handle.
> +unsafe impl<'a, T> UnsafeHrTimerPointer for Pin<&'a T>
> +where
> +    T: Send + Sync,
> +    T: HasHrTimer<T>,
> +    T: HrTimerCallback<Pointer<'a> =3D Self>,
> +    Pin<&'a T>: RawHrTimerCallback<CallbackTarget<'a> =3D Self>,
> +{
> +    type TimerHandle =3D PinHrTimerHandle<'a, T>;
> +
> +    unsafe fn start(self, expires: Ktime) -> Self::TimerHandle {
> +        // Cast to pointer
> +        let self_ptr: *const T =3D <Self as core::ops::Deref>::deref(&se=
lf);

Why use deref? `get_ref` seems much cleaner.

> +
> +        // SAFETY:
> +        //  - As we derive `self_ptr` from a reference above, it must po=
int to a
> +        //    valid `T`.
> +        //  - We keep `self` alive by wrapping it in a handle below.
> +        unsafe { T::start(self_ptr, expires) };
> +
> +        PinHrTimerHandle { inner: self }
> +    }
> +}
> +
> +impl<'a, T> RawHrTimerCallback for Pin<&'a T>
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

This justification seems wrong it talks about `HrTimer<T>`, but here we
have a `*const T`... Also see [1] (I am mainly interested in your
justification for the lifetime).

[1]: https://doc.rust-lang.org/std/ptr/index.html#pointer-to-reference-conv=
ersion

---
Cheers,
Benno

> +        let receiver_ref =3D unsafe { &*receiver_ptr };
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



