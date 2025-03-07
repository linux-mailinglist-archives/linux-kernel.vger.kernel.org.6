Return-Path: <linux-kernel+bounces-551908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9A6A572D4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 21:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA12189BB60
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F912561C6;
	Fri,  7 Mar 2025 20:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxD2zVRS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C0E1A5B8C;
	Fri,  7 Mar 2025 20:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741378406; cv=none; b=L5S9Rs+LFqJgupSYWkTNM8N2/qMacmhjYTcRgT1urOQVf/ksNPDbgMdCZEmaflU1mhSXhY1jnpGMHiLGYnBML3SJnaxvzx4+MadpS69tA1Bsfn9+m6Ck2HgCKPLOn6xBZLiUYiMEZhkeD4+Xy5zHgUgzevjpW2bBlrTy8UDyk94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741378406; c=relaxed/simple;
	bh=M2FARmcsZStMQDjL0QcDCzPZDc8Ui0yVPkCpiS0euQ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fI/g1zveYzjgL3ClpxwCO3vVq2C8eUGCBFlbbFkFz/qoZNHfRZHCP51vmGp4KoPtSlLWIjfnCvu0LaootG11yTmWCQCyAaCTcWw60+SQ1qcSgCU7NeEJ8eHTpTLtYkzT1GQQvLrQMfglN61RBTitmZJEN3qzvTu/zobNhcPiM8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxD2zVRS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 877CCC4CED1;
	Fri,  7 Mar 2025 20:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741378406;
	bh=M2FARmcsZStMQDjL0QcDCzPZDc8Ui0yVPkCpiS0euQ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DxD2zVRSjSbe0i7xtUtODsrv9P39bYOyWwnpEsWUCGVujfmi9Dd1X0NvNMnM4hsrw
	 qLMIhBlX82HEoyhm0Z5fvgRHaRaYxzUfXop7xs4EtPwUuaop/yIP4FhJYZ7nl2ilE8
	 wkqV+2q36WppiE6AFkp/EoIUNcZi4ENIlMyLT0tmPs0QWEcSNLtyawHauVUvCihzGg
	 PHHZPK1rayH8eMn97CgmYqnQn4UP2M/lSALZ5cvG2OTPO8HZ/pHSdPGtb0QXKeQgch
	 +cgrEKyzqQ2QGGf1ySA9Dynov+PsIfM+/ld7B+n49x4hiA2RqBuyiB/YxK99RVJIQE
	 0iXywE+dDHSCA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Danilo Krummrich"
 <dakr@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "Lyude Paul" <lyude@redhat.com>,  "Guangbo
 Cui" <2407018371@qq.com>,  "Dirk Behme" <dirk.behme@gmail.com>,  "Daniel
 Almeida" <daniel.almeida@collabora.com>,  "Tamir Duberstein"
 <tamird@gmail.com>,  "Markus Elfring" <Markus.Elfring@web.de>,
  <rust-for-linux@vger.kernel.org>,  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 10/13] rust: hrtimer: implement `HrTimerPointer` for
 `Pin<Box<T>>`
In-Reply-To: <D8A3THTBK4SK.3LI57W1VI580J@proton.me> (Benno Lossin's message of
	"Fri, 07 Mar 2025 14:29:58 +0000")
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org>
	<20250307-hrtimer-v3-v6-12-rc2-v10-10-0cf7e9491da4@kernel.org>
	<xfHjwuMWnL16ZsoPZa788aqaVAj2E57dGCkenefxU1HFxGOtCTWHdPNc2nPOF_osnruq4qsvkAFoQZFwzxMyZA==@protonmail.internalid>
	<D8A2DAP4JOOK.PC50NH7JGIM2@proton.me> <87bjud3po0.fsf@kernel.org>
	<iEFqFgdHr-qWv7gFkDccjbUrujKQzXbIzmC8grlTfXmOx7FwjNLXaDf4l6AbRR6uIIUJz6Hf7PupXYL0vBwNPQ==@protonmail.internalid>
	<D8A3THTBK4SK.3LI57W1VI580J@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 07 Mar 2025 16:33:56 +0100
Message-ID: <87cyes3lej.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> On Fri Mar 7, 2025 at 3:01 PM CET, Andreas Hindborg wrote:
>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>
>>> On Fri Mar 7, 2025 at 11:11 AM CET, Andreas Hindborg wrote:
>>>> Allow `Pin<Box<T>>` to be the target of a timer callback.
>>>>
>>>> Acked-by: Frederic Weisbecker <frederic@kernel.org>
>>>> Reviewed-by: Lyude Paul <lyude@redhat.com>
>>>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>>>> ---
>>>>  rust/kernel/time/hrtimer.rs      |   3 ++
>>>>  rust/kernel/time/hrtimer/tbox.rs | 109 +++++++++++++++++++++++++++++++++++++++
>>>>  2 files changed, 112 insertions(+)
>>>>
>>>> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
>>>> index d2791fd624b7..991d37b0524a 100644
>>>> --- a/rust/kernel/time/hrtimer.rs
>>>> +++ b/rust/kernel/time/hrtimer.rs
>>>> @@ -443,3 +443,6 @@ unsafe fn timer_container_of(ptr: *mut $crate::time::hrtimer::HrTimer<$timer_typ
>>>>  pub use pin::PinHrTimerHandle;
>>>>  mod pin_mut;
>>>>  pub use pin_mut::PinMutHrTimerHandle;
>>>> +// `box` is a reserved keyword, so prefix with `t` for timer
>>>> +mod tbox;
>>>> +pub use tbox::BoxHrTimerHandle;
>>>> diff --git a/rust/kernel/time/hrtimer/tbox.rs b/rust/kernel/time/hrtimer/tbox.rs
>>>> new file mode 100644
>>>> index 000000000000..a3b2ed849050
>>>> --- /dev/null
>>>> +++ b/rust/kernel/time/hrtimer/tbox.rs
>>>> @@ -0,0 +1,109 @@
>>>> +// SPDX-License-Identifier: GPL-2.0
>>>> +
>>>> +use super::HasHrTimer;
>>>> +use super::HrTimer;
>>>> +use super::HrTimerCallback;
>>>> +use super::HrTimerHandle;
>>>> +use super::HrTimerPointer;
>>>> +use super::RawHrTimerCallback;
>>>> +use crate::prelude::*;
>>>> +use crate::time::Ktime;
>>>> +use core::mem::ManuallyDrop;
>>>> +use core::ptr::NonNull;
>>>> +
>>>> +/// A handle for a [`Box<HasHrTimer<T>>`] returned by a call to
>>>> +/// [`HrTimerPointer::start`].
>>>> +pub struct BoxHrTimerHandle<T, A>
>>>
>>> Should this type implement `Send` and `Sync` depending on `T`?
>>
>> Yes. In practice `T` will always be `Send` and `Sync` because of bounds
>> on other traits.
>>
>> I don't think we have to require `T: Sync`, because the handle does not ever
>> create shared references to the underlying `T`?
>
> Oh I meant to do:
>
>     unsafe impl<T: Send + Sync, A> Send for BoxHrTimerHandle<T, A> {}
>
> But since you don't have it, it might be unnecessary.
>
>>>> +where
>>>> +    T: HasHrTimer<T>,
>>>> +    A: crate::alloc::Allocator,
>>>> +{
>>>> +    pub(crate) inner: NonNull<T>,
>>>> +    _p: core::marker::PhantomData<A>,
>>>> +}
>>>> +
>>>> +// SAFETY: We implement drop below, and we cancel the timer in the drop
>>>> +// implementation.
>>>> +unsafe impl<T, A> HrTimerHandle for BoxHrTimerHandle<T, A>
>>>> +where
>>>> +    T: HasHrTimer<T>,
>>>> +    A: crate::alloc::Allocator,
>>>> +{
>>>> +    fn cancel(&mut self) -> bool {
>>>> +        // SAFETY: As we obtained `self.inner` from a valid reference when we
>>>> +        // created `self`, it must point to a valid `T`.
>>>> +        let timer_ptr = unsafe { <T as HasHrTimer<T>>::raw_get_timer(self.inner.as_ptr()) };
>>>> +
>>>> +        // SAFETY: As `timer_ptr` points into `T` and `T` is valid, `timer_ptr`
>>>> +        // must point to a valid `HrTimer` instance.
>>>> +        unsafe { HrTimer::<T>::raw_cancel(timer_ptr) }
>>>> +    }
>>>> +}
>>>> +
>>>> +impl<T, A> Drop for BoxHrTimerHandle<T, A>
>>>> +where
>>>> +    T: HasHrTimer<T>,
>>>> +    A: crate::alloc::Allocator,
>>>> +{
>>>> +    fn drop(&mut self) {
>>>> +        self.cancel();
>>>> +        // SAFETY: `self.inner` came from a `Box::into_raw` call
>>>
>>> Please add this as an invariant to `Self`.
>>
>> OK.
>>
>>>
>>>> +        drop(unsafe { Box::<T, A>::from_raw(self.inner.as_ptr()) })
>>>> +    }
>>>> +}
>>>> +
>>>> +impl<T, A> HrTimerPointer for Pin<Box<T, A>>
>>>> +where
>>>> +    T: 'static,
>>>> +    T: Send + Sync,
>>>> +    T: HasHrTimer<T>,
>>>> +    T: for<'a> HrTimerCallback<Pointer<'a> = Pin<Box<T, A>>>,
>>>> +    Pin<Box<T, A>>: for<'a> RawHrTimerCallback<CallbackTarget<'a> = Pin<&'a T>>,
>>>
>>> I don't think this is necessary.
>>
>> Should I remove it? I feel like it communicates intent.
>
> What intent?
>
>>>> +    A: crate::alloc::Allocator,
>>>> +{
>>>> +    type TimerHandle = BoxHrTimerHandle<T, A>;
>>>> +
>>>> +    fn start(self, expires: Ktime) -> Self::TimerHandle {
>>>> +        // SAFETY:
>>>> +        //  - We will not move out of this box during timer callback (we pass an
>>>> +        //    immutable reference to the callback).
>>>> +        //  - `Box::into_raw` is guaranteed to return a valid pointer.
>>>> +        let inner =
>>>> +            unsafe { NonNull::new_unchecked(Box::into_raw(Pin::into_inner_unchecked(self))) };
>>>> +
>>>> +        // SAFETY:
>>>> +        //  - We keep `self` alive by wrapping it in a handle below.
>>>> +        //  - Since we generate the pointer passed to `start` from a valid
>>>> +        //    reference, it is a valid pointer.
>>>> +        unsafe { T::start(inner.as_ptr(), expires) };
>>>> +
>>>> +        BoxHrTimerHandle {
>>>> +            inner,
>>>> +            _p: core::marker::PhantomData,
>>>> +        }
>>>> +    }
>>>> +}
>>>> +
>>>> +impl<T, A> RawHrTimerCallback for Pin<Box<T, A>>
>>>> +where
>>>> +    T: 'static,
>>>> +    T: HasHrTimer<T>,
>>>> +    T: for<'a> HrTimerCallback<Pointer<'a> = Pin<Box<T, A>>>,
>>>> +    A: crate::alloc::Allocator,
>>>> +{
>>>> +    type CallbackTarget<'a> = Pin<&'a T>;
>>>
>>> Why isn't this `Pin<&'a mut T>`?
>>
>> I don't think it matters much? There can be no other mutable references
>> while the callback is running, so why not a shared ref?
>
> IIUC there can be no references to the value, since the user used a
> `Pin<Box<T>>` to schedule the timer.
>
> I thought it might make sense to give a pinned mutable reference, since
> you explicitly implement the `RawHrTimerCallback` for `Pin<&mut T>`.
> Which made me believe one sometimes needs to modify the `T` from the
> callback.
>
> Since we're able to do that when the user used a `Box`, I think we
> should just do it.

I see your point, I will change it.

>
>>>> +
>>>> +    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
>>>> +        // `HrTimer` is `repr(C)`
>>>> +        let timer_ptr = ptr.cast::<super::HrTimer<T>>();
>>>> +
>>>> +        // SAFETY: By C API contract `ptr` is the pointer we passed when
>>>> +        // queuing the timer, so it is a `HrTimer<T>` embedded in a `T`.
>>>> +        let data_ptr = unsafe { T::timer_container_of(timer_ptr) };
>>>> +
>>>> +        // SAFETY: We called `Box::into_raw` when we queued the timer.
>>>> +        let tbox = ManuallyDrop::new(Box::into_pin(unsafe { Box::<T, A>::from_raw(data_ptr) }));
>>>
>>> Since you turn this into a reference below and never run the drop, why
>>> not turn the pointer directly into a reference?
>>
>> You mean replace with `unsafe {&*data_ptr};`? I guess that could work,
>> but it hinges on `Box` being transparent which is more subtle than going
>> through the API.
>
> I think that's cleaner. Also why does that rely on `Box` being
> transparent?

I did not think of `Box::into_raw` as returning a pointer to the
underlying `T`, but looking at the signature, it does. I thought it was
returning a pointer to a `Box`.

I will change it as you suggest.


Best regards,
Andreas Hindborg





