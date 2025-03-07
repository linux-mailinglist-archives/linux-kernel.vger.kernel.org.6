Return-Path: <linux-kernel+bounces-551153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F87AA568C3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764FD1888323
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577DE218592;
	Fri,  7 Mar 2025 13:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Oq7Ceyfl"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF6921766A;
	Fri,  7 Mar 2025 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353719; cv=none; b=fN/xGAYOOLw1rJPvA5dQOI9Jgb1YtJlPNgpcLXtP5hi4UbkHvyXeyqer0YN+lpWUH4SwR9hY0FUpD7B87svfgIyFmfpUB9MLJeM3Ic9UK4G8+fefuRbNyY3NGS0xYUs1il0Gsb+3tovVWi1Hu4NuO64Ye0x2G8JNP48tc82p9oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353719; c=relaxed/simple;
	bh=vA08rp+GauFFkvql3PJYYKaGeal8Vz7EnyCQmoEvSCA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6+vsno0WptumCSLpG0erwIlvzm2ySdR+G6eSqNCNKw5hZkesUrdDvlKeDKrE4fKdbFbHrEnt1qwGIz6zr4sy8EnYFlhUwARCfN30NVPn+V5cUfsAHhh171x2aDYcvqzY62VcIB2GLuwISNFpJ7rCNXW+puIRLw5+pfQO5e9Sog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Oq7Ceyfl; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=rfhu44corralbjgscz7aoex4yu.protonmail; t=1741353707; x=1741612907;
	bh=g9I17LnuLpRiNJ7CP70cjoepGRs+1G1lV39xRLjr7S8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Oq7CeyfluQmlmLDYi9fcHBBGYkB9nGFPvodj8x0q7cOieRyBN0dWq3TLhhZwkxUOB
	 23XUGcEbMhZxZ0cHDd8dxsG6+JRhiWepH4FtInzyZ0o8WowIXZtFlzHZnSl9SL05sz
	 WrZX7mgYYA8gly24iafbqMxKtbPOrG7stYxNeQK1KrsBa0C2T2A79vHU/DqDmGNMWL
	 h8p9fzb3MTOXMVcg47XC9U/GJMWDjVxZBzYvRZOvnN57fhDJaw5Ept45Q/fkEfKkHt
	 JU3CM0gIq2iuz1oehsFTloHRWwFiHe+4JIhqgboyAV3K0776khdrjSdsh/ns5ku/7Z
	 8lZ/2CN00y7jQ==
Date: Fri, 07 Mar 2025 13:21:44 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, Markus Elfring <Markus.Elfring@web.de>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 10/13] rust: hrtimer: implement `HrTimerPointer` for `Pin<Box<T>>`
Message-ID: <D8A2DAP4JOOK.PC50NH7JGIM2@proton.me>
In-Reply-To: <20250307-hrtimer-v3-v6-12-rc2-v10-10-0cf7e9491da4@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org> <20250307-hrtimer-v3-v6-12-rc2-v10-10-0cf7e9491da4@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: e162dc079f29301a8b2e4dce2f2cdc32b96986b4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 7, 2025 at 11:11 AM CET, Andreas Hindborg wrote:
> Allow `Pin<Box<T>>` to be the target of a timer callback.
>
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> Reviewed-by: Lyude Paul <lyude@redhat.com>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> ---
>  rust/kernel/time/hrtimer.rs      |   3 ++
>  rust/kernel/time/hrtimer/tbox.rs | 109 +++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 112 insertions(+)
>
> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
> index d2791fd624b7..991d37b0524a 100644
> --- a/rust/kernel/time/hrtimer.rs
> +++ b/rust/kernel/time/hrtimer.rs
> @@ -443,3 +443,6 @@ unsafe fn timer_container_of(ptr: *mut $crate::time::=
hrtimer::HrTimer<$timer_typ
>  pub use pin::PinHrTimerHandle;
>  mod pin_mut;
>  pub use pin_mut::PinMutHrTimerHandle;
> +// `box` is a reserved keyword, so prefix with `t` for timer
> +mod tbox;
> +pub use tbox::BoxHrTimerHandle;
> diff --git a/rust/kernel/time/hrtimer/tbox.rs b/rust/kernel/time/hrtimer/=
tbox.rs
> new file mode 100644
> index 000000000000..a3b2ed849050
> --- /dev/null
> +++ b/rust/kernel/time/hrtimer/tbox.rs
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +use super::HasHrTimer;
> +use super::HrTimer;
> +use super::HrTimerCallback;
> +use super::HrTimerHandle;
> +use super::HrTimerPointer;
> +use super::RawHrTimerCallback;
> +use crate::prelude::*;
> +use crate::time::Ktime;
> +use core::mem::ManuallyDrop;
> +use core::ptr::NonNull;
> +
> +/// A handle for a [`Box<HasHrTimer<T>>`] returned by a call to
> +/// [`HrTimerPointer::start`].
> +pub struct BoxHrTimerHandle<T, A>

Should this type implement `Send` and `Sync` depending on `T`?

> +where
> +    T: HasHrTimer<T>,
> +    A: crate::alloc::Allocator,
> +{
> +    pub(crate) inner: NonNull<T>,
> +    _p: core::marker::PhantomData<A>,
> +}
> +
> +// SAFETY: We implement drop below, and we cancel the timer in the drop
> +// implementation.
> +unsafe impl<T, A> HrTimerHandle for BoxHrTimerHandle<T, A>
> +where
> +    T: HasHrTimer<T>,
> +    A: crate::alloc::Allocator,
> +{
> +    fn cancel(&mut self) -> bool {
> +        // SAFETY: As we obtained `self.inner` from a valid reference wh=
en we
> +        // created `self`, it must point to a valid `T`.
> +        let timer_ptr =3D unsafe { <T as HasHrTimer<T>>::raw_get_timer(s=
elf.inner.as_ptr()) };
> +
> +        // SAFETY: As `timer_ptr` points into `T` and `T` is valid, `tim=
er_ptr`
> +        // must point to a valid `HrTimer` instance.
> +        unsafe { HrTimer::<T>::raw_cancel(timer_ptr) }
> +    }
> +}
> +
> +impl<T, A> Drop for BoxHrTimerHandle<T, A>
> +where
> +    T: HasHrTimer<T>,
> +    A: crate::alloc::Allocator,
> +{
> +    fn drop(&mut self) {
> +        self.cancel();
> +        // SAFETY: `self.inner` came from a `Box::into_raw` call

Please add this as an invariant to `Self`.

> +        drop(unsafe { Box::<T, A>::from_raw(self.inner.as_ptr()) })
> +    }
> +}
> +
> +impl<T, A> HrTimerPointer for Pin<Box<T, A>>
> +where
> +    T: 'static,
> +    T: Send + Sync,
> +    T: HasHrTimer<T>,
> +    T: for<'a> HrTimerCallback<Pointer<'a> =3D Pin<Box<T, A>>>,
> +    Pin<Box<T, A>>: for<'a> RawHrTimerCallback<CallbackTarget<'a> =3D Pi=
n<&'a T>>,

I don't think this is necessary.

> +    A: crate::alloc::Allocator,
> +{
> +    type TimerHandle =3D BoxHrTimerHandle<T, A>;
> +
> +    fn start(self, expires: Ktime) -> Self::TimerHandle {
> +        // SAFETY:
> +        //  - We will not move out of this box during timer callback (we=
 pass an
> +        //    immutable reference to the callback).
> +        //  - `Box::into_raw` is guaranteed to return a valid pointer.
> +        let inner =3D
> +            unsafe { NonNull::new_unchecked(Box::into_raw(Pin::into_inne=
r_unchecked(self))) };
> +
> +        // SAFETY:
> +        //  - We keep `self` alive by wrapping it in a handle below.
> +        //  - Since we generate the pointer passed to `start` from a val=
id
> +        //    reference, it is a valid pointer.
> +        unsafe { T::start(inner.as_ptr(), expires) };
> +
> +        BoxHrTimerHandle {
> +            inner,
> +            _p: core::marker::PhantomData,
> +        }
> +    }
> +}
> +
> +impl<T, A> RawHrTimerCallback for Pin<Box<T, A>>
> +where
> +    T: 'static,
> +    T: HasHrTimer<T>,
> +    T: for<'a> HrTimerCallback<Pointer<'a> =3D Pin<Box<T, A>>>,
> +    A: crate::alloc::Allocator,
> +{
> +    type CallbackTarget<'a> =3D Pin<&'a T>;

Why isn't this `Pin<&'a mut T>`?

> +
> +    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::h=
rtimer_restart {
> +        // `HrTimer` is `repr(C)`
> +        let timer_ptr =3D ptr.cast::<super::HrTimer<T>>();
> +
> +        // SAFETY: By C API contract `ptr` is the pointer we passed when
> +        // queuing the timer, so it is a `HrTimer<T>` embedded in a `T`.
> +        let data_ptr =3D unsafe { T::timer_container_of(timer_ptr) };
> +
> +        // SAFETY: We called `Box::into_raw` when we queued the timer.
> +        let tbox =3D ManuallyDrop::new(Box::into_pin(unsafe { Box::<T, A=
>::from_raw(data_ptr) }));

Since you turn this into a reference below and never run the drop, why
not turn the pointer directly into a reference?

---
Cheers,
Benno

> +
> +        T::run(tbox.as_ref()).into_c()
> +    }
> +}
>
> --
> 2.47.0



