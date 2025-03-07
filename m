Return-Path: <linux-kernel+bounces-551277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1576A56A63
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 15:30:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31D93189A3EC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BFD621B1BC;
	Fri,  7 Mar 2025 14:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="gjyO6s3L"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E12121B918
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741357811; cv=none; b=fL+2e85Q2rINl1NXc9Q1c+1TVeDx+UlSMW/4xFoa6uI/qPZldV6fiD3Ix9V2PTC0kAtAr/FKh4zBs7kXsSsfTeI8ICE8uBrGUwB0hJUQ3TxfpZwQVPbZtewX5CxjMHJixnUDBj85+wSfA9vsW8GLI211rpNin5SEiDQjWWVN2XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741357811; c=relaxed/simple;
	bh=fleqeP/FCDmwdLw5F27AS7KWR4YOCNwwEmIYnsgNX5I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbksIN4aczgGrFGhS3rMbhO+HCeLU45e/+hYAeg5uvt4tfkuDItxZrCL1364v4ZFTNL/DqMTTgIpyiq7soTGMsHY93v3pgjE/CHNHiCps6yqsBCsQJQAmNq9o7e40E0DVO2csGlbNDql9oQrxsy8XlJANlG34bG4UUCZd3zotzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=gjyO6s3L; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ropyt3ciq5djhfusp5t3zvr6ym.protonmail; t=1741357807; x=1741617007;
	bh=BzotiybtxOMnzczcpfh7Ghvit0KX8yvXjEj11c8kWdo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=gjyO6s3LumOMFUMfZ0XjK0YNnrzenw1MA6Y3M6Tzh13R7qjSt2OrhsPKsGEUcBHcp
	 um6ePatPVyAbw+yRF3ef6otirtceNn/hSB15/1su7L/Wtrg7+dT1fxi8ZvrHAS5R8w
	 9ajuviPo8bPug+Gt6Rc068SphJsIDUvyPGUYCi+jBczNCYt4yStMnyD3C051IvOBIa
	 bCswLxH6y47UDwttD5LJq7J8ew7+36m0uzQy0oYh5TCzL6Jsbad0rISEpHOktGX7aR
	 TKV0Z1hoKFH/wLj6pXKLfZREoD0uw4sgoir7E6Q6C/alYcFx3HBmB8RJ/keOqzQBkh
	 fsMUHV3vyBm7A==
Date: Fri, 07 Mar 2025 14:29:58 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, Markus Elfring <Markus.Elfring@web.de>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 10/13] rust: hrtimer: implement `HrTimerPointer` for `Pin<Box<T>>`
Message-ID: <D8A3THTBK4SK.3LI57W1VI580J@proton.me>
In-Reply-To: <87bjud3po0.fsf@kernel.org>
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org> <20250307-hrtimer-v3-v6-12-rc2-v10-10-0cf7e9491da4@kernel.org> <xfHjwuMWnL16ZsoPZa788aqaVAj2E57dGCkenefxU1HFxGOtCTWHdPNc2nPOF_osnruq4qsvkAFoQZFwzxMyZA==@protonmail.internalid> <D8A2DAP4JOOK.PC50NH7JGIM2@proton.me> <87bjud3po0.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 61db47778e6dfdfa1623c35b5aab7d7c3edffb7a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 7, 2025 at 3:01 PM CET, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>
>> On Fri Mar 7, 2025 at 11:11 AM CET, Andreas Hindborg wrote:
>>> Allow `Pin<Box<T>>` to be the target of a timer callback.
>>>
>>> Acked-by: Frederic Weisbecker <frederic@kernel.org>
>>> Reviewed-by: Lyude Paul <lyude@redhat.com>
>>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>>> ---
>>>  rust/kernel/time/hrtimer.rs      |   3 ++
>>>  rust/kernel/time/hrtimer/tbox.rs | 109 +++++++++++++++++++++++++++++++=
++++++++
>>>  2 files changed, 112 insertions(+)
>>>
>>> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
>>> index d2791fd624b7..991d37b0524a 100644
>>> --- a/rust/kernel/time/hrtimer.rs
>>> +++ b/rust/kernel/time/hrtimer.rs
>>> @@ -443,3 +443,6 @@ unsafe fn timer_container_of(ptr: *mut $crate::time=
::hrtimer::HrTimer<$timer_typ
>>>  pub use pin::PinHrTimerHandle;
>>>  mod pin_mut;
>>>  pub use pin_mut::PinMutHrTimerHandle;
>>> +// `box` is a reserved keyword, so prefix with `t` for timer
>>> +mod tbox;
>>> +pub use tbox::BoxHrTimerHandle;
>>> diff --git a/rust/kernel/time/hrtimer/tbox.rs b/rust/kernel/time/hrtime=
r/tbox.rs
>>> new file mode 100644
>>> index 000000000000..a3b2ed849050
>>> --- /dev/null
>>> +++ b/rust/kernel/time/hrtimer/tbox.rs
>>> @@ -0,0 +1,109 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +use super::HasHrTimer;
>>> +use super::HrTimer;
>>> +use super::HrTimerCallback;
>>> +use super::HrTimerHandle;
>>> +use super::HrTimerPointer;
>>> +use super::RawHrTimerCallback;
>>> +use crate::prelude::*;
>>> +use crate::time::Ktime;
>>> +use core::mem::ManuallyDrop;
>>> +use core::ptr::NonNull;
>>> +
>>> +/// A handle for a [`Box<HasHrTimer<T>>`] returned by a call to
>>> +/// [`HrTimerPointer::start`].
>>> +pub struct BoxHrTimerHandle<T, A>
>>
>> Should this type implement `Send` and `Sync` depending on `T`?
>
> Yes. In practice `T` will always be `Send` and `Sync` because of bounds
> on other traits.
>
> I don't think we have to require `T: Sync`, because the handle does not e=
ver
> create shared references to the underlying `T`?

Oh I meant to do:

    unsafe impl<T: Send + Sync, A> Send for BoxHrTimerHandle<T, A> {}

But since you don't have it, it might be unnecessary.

>>> +where
>>> +    T: HasHrTimer<T>,
>>> +    A: crate::alloc::Allocator,
>>> +{
>>> +    pub(crate) inner: NonNull<T>,
>>> +    _p: core::marker::PhantomData<A>,
>>> +}
>>> +
>>> +// SAFETY: We implement drop below, and we cancel the timer in the dro=
p
>>> +// implementation.
>>> +unsafe impl<T, A> HrTimerHandle for BoxHrTimerHandle<T, A>
>>> +where
>>> +    T: HasHrTimer<T>,
>>> +    A: crate::alloc::Allocator,
>>> +{
>>> +    fn cancel(&mut self) -> bool {
>>> +        // SAFETY: As we obtained `self.inner` from a valid reference =
when we
>>> +        // created `self`, it must point to a valid `T`.
>>> +        let timer_ptr =3D unsafe { <T as HasHrTimer<T>>::raw_get_timer=
(self.inner.as_ptr()) };
>>> +
>>> +        // SAFETY: As `timer_ptr` points into `T` and `T` is valid, `t=
imer_ptr`
>>> +        // must point to a valid `HrTimer` instance.
>>> +        unsafe { HrTimer::<T>::raw_cancel(timer_ptr) }
>>> +    }
>>> +}
>>> +
>>> +impl<T, A> Drop for BoxHrTimerHandle<T, A>
>>> +where
>>> +    T: HasHrTimer<T>,
>>> +    A: crate::alloc::Allocator,
>>> +{
>>> +    fn drop(&mut self) {
>>> +        self.cancel();
>>> +        // SAFETY: `self.inner` came from a `Box::into_raw` call
>>
>> Please add this as an invariant to `Self`.
>
> OK.
>
>>
>>> +        drop(unsafe { Box::<T, A>::from_raw(self.inner.as_ptr()) })
>>> +    }
>>> +}
>>> +
>>> +impl<T, A> HrTimerPointer for Pin<Box<T, A>>
>>> +where
>>> +    T: 'static,
>>> +    T: Send + Sync,
>>> +    T: HasHrTimer<T>,
>>> +    T: for<'a> HrTimerCallback<Pointer<'a> =3D Pin<Box<T, A>>>,
>>> +    Pin<Box<T, A>>: for<'a> RawHrTimerCallback<CallbackTarget<'a> =3D =
Pin<&'a T>>,
>>
>> I don't think this is necessary.
>
> Should I remove it? I feel like it communicates intent.

What intent?

>>> +    A: crate::alloc::Allocator,
>>> +{
>>> +    type TimerHandle =3D BoxHrTimerHandle<T, A>;
>>> +
>>> +    fn start(self, expires: Ktime) -> Self::TimerHandle {
>>> +        // SAFETY:
>>> +        //  - We will not move out of this box during timer callback (=
we pass an
>>> +        //    immutable reference to the callback).
>>> +        //  - `Box::into_raw` is guaranteed to return a valid pointer.
>>> +        let inner =3D
>>> +            unsafe { NonNull::new_unchecked(Box::into_raw(Pin::into_in=
ner_unchecked(self))) };
>>> +
>>> +        // SAFETY:
>>> +        //  - We keep `self` alive by wrapping it in a handle below.
>>> +        //  - Since we generate the pointer passed to `start` from a v=
alid
>>> +        //    reference, it is a valid pointer.
>>> +        unsafe { T::start(inner.as_ptr(), expires) };
>>> +
>>> +        BoxHrTimerHandle {
>>> +            inner,
>>> +            _p: core::marker::PhantomData,
>>> +        }
>>> +    }
>>> +}
>>> +
>>> +impl<T, A> RawHrTimerCallback for Pin<Box<T, A>>
>>> +where
>>> +    T: 'static,
>>> +    T: HasHrTimer<T>,
>>> +    T: for<'a> HrTimerCallback<Pointer<'a> =3D Pin<Box<T, A>>>,
>>> +    A: crate::alloc::Allocator,
>>> +{
>>> +    type CallbackTarget<'a> =3D Pin<&'a T>;
>>
>> Why isn't this `Pin<&'a mut T>`?
>
> I don't think it matters much? There can be no other mutable references
> while the callback is running, so why not a shared ref?

IIUC there can be no references to the value, since the user used a
`Pin<Box<T>>` to schedule the timer.

I thought it might make sense to give a pinned mutable reference, since
you explicitly implement the `RawHrTimerCallback` for `Pin<&mut T>`.
Which made me believe one sometimes needs to modify the `T` from the
callback.

Since we're able to do that when the user used a `Box`, I think we
should just do it.

>>> +
>>> +    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings:=
:hrtimer_restart {
>>> +        // `HrTimer` is `repr(C)`
>>> +        let timer_ptr =3D ptr.cast::<super::HrTimer<T>>();
>>> +
>>> +        // SAFETY: By C API contract `ptr` is the pointer we passed wh=
en
>>> +        // queuing the timer, so it is a `HrTimer<T>` embedded in a `T=
`.
>>> +        let data_ptr =3D unsafe { T::timer_container_of(timer_ptr) };
>>> +
>>> +        // SAFETY: We called `Box::into_raw` when we queued the timer.
>>> +        let tbox =3D ManuallyDrop::new(Box::into_pin(unsafe { Box::<T,=
 A>::from_raw(data_ptr) }));
>>
>> Since you turn this into a reference below and never run the drop, why
>> not turn the pointer directly into a reference?
>
> You mean replace with `unsafe {&*data_ptr};`? I guess that could work,
> but it hinges on `Box` being transparent which is more subtle than going
> through the API.

I think that's cleaner. Also why does that rely on `Box` being
transparent?

---
Cheers,
Benno


