Return-Path: <linux-kernel+bounces-551181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 462DDA5690D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 528047A4E2A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE49219E9E;
	Fri,  7 Mar 2025 13:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lO/+hGsB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD21EBE;
	Fri,  7 Mar 2025 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741354666; cv=none; b=Oafmxi3t7VRuT3NgHKSofCvYXJnD2KY12MykhAoXlDiajlq5EcjxV3xhKgC2/mfiWTSReCEpHrvyvroqCq8Fj++BC8zBb6Jba0ihYQi1EiBgRs6vvJavJqba1oA/4qYT2BvlrJWGtT2US8T253u2y+G7ylRTQTKbFX64SNsrIgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741354666; c=relaxed/simple;
	bh=6twqrik2u9WyiixhLU/idbbx3nP34hgJ5afeu7rAbPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ijyD/weYRlq2IRt9nDbjPVFMdSBbg3xsusE53eHR9ZoAjntQdj4zwhh91GGIouG6N5vJ7/Fwai2AE9V3GTxRYLj1ieEkHsEDm/tEnCRYXlKzJzbg2aTP8dWYDx+2aPydbrqwNMK4K3lwT1McZ1Qus0tVcdsqgpmSLFMQDKQX2WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lO/+hGsB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6638C4CED1;
	Fri,  7 Mar 2025 13:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741354665;
	bh=6twqrik2u9WyiixhLU/idbbx3nP34hgJ5afeu7rAbPg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=lO/+hGsBhVb5kx3ttrOjf9T0ePOXmTkU0/+R/Ff4wl8GPQoRZP+rYLVBRvhd6EwiX
	 IEGY4Feqq8I6ftL/57O27h6wCXilz6kb4aNF3bc6ovFHf2DBrqLU3U0Dn3JJd113Bv
	 55Y7Ub7qgEi00jdsZAGLjsmufNJwODeIctZ1j8/G1dPfxLg8DGsJmvhTsYrTVqYgxt
	 8uIP9Q3JoPaIgRmA937ifVu72eaeYosRrPZocaOLXJd0sNgdPRrZRrSTgzvi4Xt+vT
	 akG/fsl5al0Cz9XG07s5TAyzU5n/lZf+okt/ESeILjYOVF/ZwJsZBqBoV1O5aMaFzR
	 xXRioKlSYjgWg==
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
Subject: Re: [PATCH v10 07/13] rust: hrtimer: implement
 `UnsafeHrTimerPointer` for `Pin<&T>`
In-Reply-To: <D8A25UNDIJHK.216EX6YG4EJ6E@proton.me> (Benno Lossin's message of
	"Fri, 07 Mar 2025 13:12:01 +0000")
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org>
	<20250307-hrtimer-v3-v6-12-rc2-v10-7-0cf7e9491da4@kernel.org>
	<6-QyjoxR_6TYuJVEXwdFAZrhFz52ZDU_4-r64epTLFpOAMc3jM_REWS-v_7TzdcgYmq1j74UmTnhYW5HdT98bQ==@protonmail.internalid>
	<D8A25UNDIJHK.216EX6YG4EJ6E@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 07 Mar 2025 14:37:35 +0100
Message-ID: <87msdx3qsg.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> On Fri Mar 7, 2025 at 11:11 AM CET, Andreas Hindborg wrote:
>> Allow pinned references to structs that contain a `HrTimer` node to be
>> scheduled with the `hrtimer` subsystem.
>>
>> Acked-by: Frederic Weisbecker <frederic@kernel.org>
>> Reviewed-by: Lyude Paul <lyude@redhat.com>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  rust/kernel/time/hrtimer.rs     |  2 +
>>  rust/kernel/time/hrtimer/pin.rs | 99 +++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 101 insertions(+)
>>
>> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
>> index d90a25785f87..2ca56397eade 100644
>> --- a/rust/kernel/time/hrtimer.rs
>> +++ b/rust/kernel/time/hrtimer.rs
>> @@ -439,3 +439,5 @@ unsafe fn timer_container_of(ptr: *mut $crate::time::hrtimer::HrTimer<$timer_typ
>>
>>  mod arc;
>>  pub use arc::ArcHrTimerHandle;
>> +mod pin;
>> +pub use pin::PinHrTimerHandle;
>> diff --git a/rust/kernel/time/hrtimer/pin.rs b/rust/kernel/time/hrtimer/pin.rs
>> new file mode 100644
>> index 000000000000..6c9f2190f8e1
>> --- /dev/null
>> +++ b/rust/kernel/time/hrtimer/pin.rs
>> @@ -0,0 +1,99 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +use super::HasHrTimer;
>> +use super::HrTimer;
>> +use super::HrTimerCallback;
>> +use super::HrTimerHandle;
>> +use super::RawHrTimerCallback;
>> +use super::UnsafeHrTimerPointer;
>> +use crate::time::Ktime;
>> +use core::pin::Pin;
>> +
>> +/// A handle for a `Pin<&HasHrTimer>`. When the handle exists, the timer might be
>> +/// running.
>> +pub struct PinHrTimerHandle<'a, T>
>> +where
>> +    T: HasHrTimer<T>,
>> +{
>> +    pub(crate) inner: Pin<&'a T>,
>> +}
>> +
>> +// SAFETY: We cancel the timer when the handle is dropped. The implementation of
>> +// the `cancel` method will block if the timer handler is running.
>> +unsafe impl<'a, T> HrTimerHandle for PinHrTimerHandle<'a, T>
>> +where
>> +    T: HasHrTimer<T>,
>> +{
>> +    fn cancel(&mut self) -> bool {
>> +        let self_ptr: *const T = self.inner.get_ref();
>> +
>> +        // SAFETY: As we got `self_ptr` from a reference above, it must point to
>> +        // a valid `T`.
>> +        let timer_ptr = unsafe { <T as HasHrTimer<T>>::raw_get_timer(self_ptr) };
>> +
>> +        // SAFETY: As `timer_ptr` is derived from a reference, it must point to
>> +        // a valid and initialized `HrTimer`.
>> +        unsafe { HrTimer::<T>::raw_cancel(timer_ptr) }
>> +    }
>> +}
>> +
>> +impl<'a, T> Drop for PinHrTimerHandle<'a, T>
>> +where
>> +    T: HasHrTimer<T>,
>> +{
>> +    fn drop(&mut self) {
>> +        self.cancel();
>> +    }
>> +}
>> +
>> +// SAFETY: We capture the lifetime of `Self` when we create a `PinHrTimerHandle`,
>> +// so `Self` will outlive the handle.
>> +unsafe impl<'a, T> UnsafeHrTimerPointer for Pin<&'a T>
>> +where
>> +    T: Send + Sync,
>> +    T: HasHrTimer<T>,
>> +    T: HrTimerCallback<Pointer<'a> = Self>,
>> +    Pin<&'a T>: RawHrTimerCallback<CallbackTarget<'a> = Self>,
>> +{
>> +    type TimerHandle = PinHrTimerHandle<'a, T>;
>> +
>> +    unsafe fn start(self, expires: Ktime) -> Self::TimerHandle {
>> +        // Cast to pointer
>> +        let self_ptr: *const T = <Self as core::ops::Deref>::deref(&self);
>
> Why use deref? `get_ref` seems much cleaner.

Sure.

>
>> +
>> +        // SAFETY:
>> +        //  - As we derive `self_ptr` from a reference above, it must point to a
>> +        //    valid `T`.
>> +        //  - We keep `self` alive by wrapping it in a handle below.
>> +        unsafe { T::start(self_ptr, expires) };
>> +
>> +        PinHrTimerHandle { inner: self }
>> +    }
>> +}
>> +
>> +impl<'a, T> RawHrTimerCallback for Pin<&'a T>
>> +where
>> +    T: HasHrTimer<T>,
>> +    T: HrTimerCallback<Pointer<'a> = Self>,
>> +{
>> +    type CallbackTarget<'b> = Self;
>> +
>> +    unsafe extern "C" fn run(ptr: *mut bindings::hrtimer) -> bindings::hrtimer_restart {
>> +        // `HrTimer` is `repr(C)`
>> +        let timer_ptr = ptr as *mut HrTimer<T>;
>> +
>> +        // SAFETY: By the safety requirement of this function, `timer_ptr`
>> +        // points to a `HrTimer<T>` contained in an `T`.
>> +        let receiver_ptr = unsafe { T::timer_container_of(timer_ptr) };
>> +
>> +        // SAFETY: By the safety requirement of this function, `timer_ptr`
>> +        // points to a `HrTimer<T>` contained in an `T`.
>
> This justification seems wrong it talks about `HrTimer<T>`, but here we
> have a `*const T`... Also see [1] (I am mainly interested in your
> justification for the lifetime).
>
> [1]: https://doc.rust-lang.org/std/ptr/index.html#pointer-to-reference-conversion

How is this:

        // SAFETY:
        //  - By the safety requirement of this function, `timer_ptr`
        //    points to a `HrTimer<T>` contained in an `T`.
        //  - The `PinHrTimerHandle` associated with this timer is guaranteed to
        //    be alive until this method returns. As the handle borrows from
        //    `T`, `T` is also guaranteed to be alive for the duration of this
        //    function.


Best regards,
Andreas Hindborg



