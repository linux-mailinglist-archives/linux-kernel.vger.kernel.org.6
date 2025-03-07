Return-Path: <linux-kernel+bounces-551187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8AFA56921
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 478BC7A98E9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6FE21ABC3;
	Fri,  7 Mar 2025 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V42A9jRa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BA0EBE;
	Fri,  7 Mar 2025 13:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741354886; cv=none; b=blCvKniWXGsCxngxDQzxvHtSuYyTpLwPvfBGD4oynERYEpNmQQWwaShyZdujnDlJB8zZGtpzoWUEiiBMqP2fy9KqlBx7OSDY7gAbePn7rDvbL3QwYM8s8Iz/uY7hvMjbaM0UcrhTQYu38PcvOlSLW/FlAS16555hvQGykQ8HY3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741354886; c=relaxed/simple;
	bh=3EzXdILJsICpLU/Y0kJ7QJgaNvnAuFSYFmWDvaMIGzY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uFKyl4wlTu6QqqhmGirprj+IufuYBZsLCUVTT7kL/1bMDHMY47fgy9nu0RO5JM7K4aJRdvKLe7GjgATohT7XUdocEAwJ+cFg2SBD13hUtLHv0He9Octfr8184MUfP5ZGtOORSNTQbGLVNz0/u4vtZ+/yaKKJEYgsBpj+Hzv5WfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V42A9jRa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46142C4CED1;
	Fri,  7 Mar 2025 13:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741354885;
	bh=3EzXdILJsICpLU/Y0kJ7QJgaNvnAuFSYFmWDvaMIGzY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=V42A9jRaCOCFU45fyv8wdIRw3IVYxtmnAd2XnPVzGfelB21HblQs/U5wXFI2FR2Fy
	 OjbnagTU1J+rtO+Rh9Hfbc7WzMj4iU0Zyv/RuhyDY0PecD6lJKMSVmpjYl+IKSPspS
	 BHtjQMSgVoT7VSmMlCAQYAwwcAd4akGD7t+wRuAvRsnaSMFY6SyNj0QsIEROvuSl+T
	 qLpZpQo1dNCC/0F3VOBtEFl4lvmK84KCDuLCQJPhFyzHBenu5ZwnqgePoy25yr60mU
	 Mf7eCJL1fqo2WvXfBUhoXgZHKnQalw22gVRdJKTSBtMt6by/Apuk5kU3D0FW0pzQJG
	 o6H7IvHRyFCvA==
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
Subject: Re: [PATCH v10 08/13] rust: hrtimer: implement
 `UnsafeHrTimerPointer` for `Pin<&mut T>`
In-Reply-To: <D8A28FTNL1BC.3AYZMT4OYF79R@proton.me> (Benno Lossin's message of
	"Fri, 07 Mar 2025 13:15:26 +0000")
References: <20250307-hrtimer-v3-v6-12-rc2-v10-0-0cf7e9491da4@kernel.org>
	<20250307-hrtimer-v3-v6-12-rc2-v10-8-0cf7e9491da4@kernel.org>
	<8DuLea9f4Ue0LzzIRrjOfpa8OtL_cLObGjZhfPZnw8crCU8ISWZmIC5SVYntldK27JAR_SUGpYXFspN-OigYRQ==@protonmail.internalid>
	<D8A28FTNL1BC.3AYZMT4OYF79R@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 07 Mar 2025 14:41:15 +0100
Message-ID: <87h6453qmc.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> On Fri Mar 7, 2025 at 11:11 AM CET, Andreas Hindborg wrote:
>> Allow pinned mutable references to structs that contain a `HrTimer` node to
>> be scheduled with the `hrtimer` subsystem.
>>
>> Acked-by: Frederic Weisbecker <frederic@kernel.org>
>> Reviewed-by: Lyude Paul <lyude@redhat.com>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  rust/kernel/time/hrtimer.rs         |   2 +
>>  rust/kernel/time/hrtimer/pin_mut.rs | 101 ++++++++++++++++++++++++++++++++++++
>>  2 files changed, 103 insertions(+)
>>
>> diff --git a/rust/kernel/time/hrtimer.rs b/rust/kernel/time/hrtimer.rs
>> index 2ca56397eade..d2791fd624b7 100644
>> --- a/rust/kernel/time/hrtimer.rs
>> +++ b/rust/kernel/time/hrtimer.rs
>> @@ -441,3 +441,5 @@ unsafe fn timer_container_of(ptr: *mut $crate::time::hrtimer::HrTimer<$timer_typ
>>  pub use arc::ArcHrTimerHandle;
>>  mod pin;
>>  pub use pin::PinHrTimerHandle;
>> +mod pin_mut;
>> +pub use pin_mut::PinMutHrTimerHandle;
>> diff --git a/rust/kernel/time/hrtimer/pin_mut.rs b/rust/kernel/time/hrtimer/pin_mut.rs
>> new file mode 100644
>> index 000000000000..4f4a9e9602d8
>> --- /dev/null
>> +++ b/rust/kernel/time/hrtimer/pin_mut.rs
>> @@ -0,0 +1,101 @@
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
>> +/// A handle for a `Pin<&mut HasHrTimer>`. When the handle exists, the timer might
>> +/// be running.
>> +pub struct PinMutHrTimerHandle<'a, T>
>> +where
>> +    T: HasHrTimer<T>,
>> +{
>> +    pub(crate) inner: Pin<&'a mut T>,
>> +}
>> +
>> +// SAFETY: We cancel the timer when the handle is dropped. The implementation of
>> +// the `cancel` method will block if the timer handler is running.
>> +unsafe impl<'a, T> HrTimerHandle for PinMutHrTimerHandle<'a, T>
>> +where
>> +    T: HasHrTimer<T>,
>> +{
>> +    fn cancel(&mut self) -> bool {
>> +        // SAFETY: We are not moving out of `self` or handing out mutable
>> +        // references to `self`.
>> +        let self_ptr = unsafe { self.inner.as_mut().get_unchecked_mut() as *mut T };
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
>> +impl<'a, T> Drop for PinMutHrTimerHandle<'a, T>
>> +where
>> +    T: HasHrTimer<T>,
>> +{
>> +    fn drop(&mut self) {
>> +        self.cancel();
>> +    }
>> +}
>> +
>> +// SAFETY: We capture the lifetime of `Self` when we create a
>> +// `PinMutHrTimerHandle`, so `Self` will outlive the handle.
>> +unsafe impl<'a, T> UnsafeHrTimerPointer for Pin<&'a mut T>
>> +where
>> +    T: Send + Sync,
>> +    T: HasHrTimer<T>,
>> +    T: HrTimerCallback<Pointer<'a> = Self>,
>> +    Pin<&'a mut T>: RawHrTimerCallback<CallbackTarget<'a> = Self>,
>> +{
>> +    type TimerHandle = PinMutHrTimerHandle<'a, T>;
>> +
>> +    unsafe fn start(self, expires: Ktime) -> Self::TimerHandle {
>> +        // Cast to pointer
>> +        let self_ptr: *const T = <Self as core::ops::Deref>::deref(&self);
>
> You cannot go through a shared reference here, since you convert the
> pointer obtained here in the `run` function later back into a mutable
> reference. You will have to use `get_unchecked_mut` or
> `into_inner_unchecked`.

Thanks, will fix.


Best regards,
Andreas Hindborg



