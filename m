Return-Path: <linux-kernel+bounces-416032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4419D3F62
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 16:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1E341F2357E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Nov 2024 15:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEC114F10E;
	Wed, 20 Nov 2024 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4hf7XU7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F0914C5AE;
	Wed, 20 Nov 2024 15:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732117928; cv=none; b=YLE+4O5E3et9cvIvyuHciukIlP8Te7RCWDz4wF++wniLd17UMiMlcaZ06DXeIelAK89EZh3n1ZP4KJdg3KPb3f2TcJwVlpw4/syKdiXRjEQpGaZcgmahwIKDGCaL6sjyVvgApztpk3DpjdxAe266S7hqvRQzLcssIaHq5bJ190g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732117928; c=relaxed/simple;
	bh=6sl/hLhDAqd6o+eAytT6pnSBd2n8Gpaj7e9r8RvqjBk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yy6xiZWS5jhVTt7ETATq9wbRrX9qSOh+5e/7AmA9/NoaqaDU+zoZm+QBoHimyK8fs3rjDswizrhQaUQndusCFquYN7qvIu6sdODezrQPaIp1yo3ZJBSWlkop/51IgwVL+RhByQJE2slxhzSc/e48facM7HY91XVg10T1SZk+tvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4hf7XU7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C544C4CECD;
	Wed, 20 Nov 2024 15:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732117926;
	bh=6sl/hLhDAqd6o+eAytT6pnSBd2n8Gpaj7e9r8RvqjBk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=J4hf7XU7fVyNLaI5lOBa2AVW8PZ4aLSVmiJGeZS2FUyA4HpJKeMI0TZN4sHOD1605
	 dPD4rwZb7ut1Bv7L41EsnrUU1kels9bgCyOdD9Cqp2WTJUmzUwcVHy+gznObfxiQ+e
	 cEwUck+ppV4h4ZA/j6/7HLKOC+RnzLDyVese5ENYT5oiOtXWfx0uqvioZ9A1nm5e64
	 hgUL6yuCOL3OmfTKW97u7g7TmBJCjG0Z1vG4K2dVUXtYdZX/45H4SexSfWa4Dw5yx9
	 3N0Gb4AHCaXjg9v/zM9rMhd1xR2yvJQ60aOA+rVAyEoMhopJqT8nyeXwKDioMU8aGQ
	 /Z+Rc2QCC3Ylw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Lyude Paul" <lyude@redhat.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,
  "Trevor Gross" <tmgross@umich.edu>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 07/13] rust: hrtimer: implement `UnsafeTimerPointer`
 for `Pin<&T>`
In-Reply-To: <4a1ee5fff788d6624234f7e6df992406952ddb1d.camel@redhat.com>
	(Lyude Paul's message of "Wed, 13 Nov 2024 18:30:42 -0500")
References: <20241017-hrtimer-v3-v6-12-rc2-v3-0-59a75cbb44da@kernel.org>
	<20241017-hrtimer-v3-v6-12-rc2-v3-7-59a75cbb44da@kernel.org>
	<jHA_jGNaF2hHo2a_74AwFcLGTGjFLasx1dKROtdfw1QjgncwXCymfXB0F8JC2z3jSg-kaWSa7a_ATsVXaPDzBQ==@protonmail.internalid>
	<4a1ee5fff788d6624234f7e6df992406952ddb1d.camel@redhat.com>
Date: Wed, 20 Nov 2024 16:48:07 +0100
Message-ID: <87v7wh3o08.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lyude Paul" <lyude@redhat.com> writes:

> On Thu, 2024-10-17 at 15:04 +0200, Andreas Hindborg wrote:
>> Allow pinned references to structs that contain a `Timer` node to be
>> scheduled with the `hrtimer` subsystem.
>>
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>> ---
>>  rust/kernel/hrtimer.rs     |  1 +
>>  rust/kernel/hrtimer/pin.rs | 97 ++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 98 insertions(+)
>>
>> diff --git a/rust/kernel/hrtimer.rs b/rust/kernel/hrtimer.rs
>> index e97d7b8ec63ce6c9ac3fe9522192a28fba78b8ba..ceedf330a803ec2db7ff6c25713ae48e2fd1f4ca 100644
>> --- a/rust/kernel/hrtimer.rs
>> +++ b/rust/kernel/hrtimer.rs
>> @@ -362,3 +362,4 @@ unsafe fn raw_get_timer(ptr: *const Self) ->
>>  }
>>
>>  mod arc;
>> +mod pin;
>> diff --git a/rust/kernel/hrtimer/pin.rs b/rust/kernel/hrtimer/pin.rs
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..a2c1dbd5e48b668cc3dc540c5fd5514f5331d968
>> --- /dev/null
>> +++ b/rust/kernel/hrtimer/pin.rs
>> @@ -0,0 +1,97 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +use super::HasTimer;
>> +use super::RawTimerCallback;
>> +use super::Timer;
>> +use super::TimerCallback;
>> +use super::TimerHandle;
>> +use super::UnsafeTimerPointer;
>> +use crate::time::Ktime;
>> +use core::pin::Pin;
>> +
>> +/// A handle for a `Pin<&HasTimer>`. When the handle exists, the timer might be
>> +/// running.
>> +pub struct PinTimerHandle<'a, U>
>> +where
>> +    U: HasTimer<U>,
>> +{
>> +    pub(crate) inner: Pin<&'a U>,
>> +}
>> +
>> +// SAFETY: We cancel the timer when the handle is dropped. The implementation of
>> +// the `cancel` method will block if the timer handler is running.
>> +unsafe impl<'a, U> TimerHandle for PinTimerHandle<'a, U>
>> +where
>> +    U: HasTimer<U>,
>> +{
>> +    fn cancel(&mut self) -> bool {
>> +        let self_ptr = self.inner.get_ref() as *const U;
>> +
>> +        // SAFETY: As we got `self_ptr` from a reference above, it must point to
>> +        // a valid `U`.
>> +        let timer_ptr = unsafe { <U as HasTimer<U>>::raw_get_timer(self_ptr) };
>> +
>> +        // SAFETY: As `timer_ptr` is derived from a reference, it must point to
>> +        // a valid and initialized `Timer`.
>> +        unsafe { Timer::<U>::raw_cancel(timer_ptr) }
>> +    }
>> +}
>> +
>> +impl<'a, U> Drop for PinTimerHandle<'a, U>
>> +where
>> +    U: HasTimer<U>,
>> +{
>> +    fn drop(&mut self) {
>> +        self.cancel();
>> +    }
>> +}
>> +
>> +// SAFETY: We capture the lifetime of `Self` when we create a `PinTimerHandle`,
>> +// so `Self` will outlive the handle.
>> +unsafe impl<'a, U> UnsafeTimerPointer for Pin<&'a U>
>> +where
>> +    U: Send + Sync,
>> +    U: HasTimer<U>,
>> +    U: TimerCallback<CallbackTarget<'a> = Self>,
>> +{
>> +    type TimerHandle = PinTimerHandle<'a, U>;
>> +
>> +    unsafe fn start(self, expires: Ktime) -> Self::TimerHandle {
>> +        use core::ops::Deref;
>
> I'm sure this is valid but this seems like a strange place to put a module use
> (also - do we ever actually need to import Deref explicitly? It should always
> be imported)

`core::ops::Deref` is not in scope. So if we want to use
`Deref::deref()`, we must import the trait first.

My first intuition for writing this expression was:

 `(*self) as *const U;`

because `*self` should invoke `Deref::deref()`, right?

But the compiler does not do what I thought it would do. I am not sure
why it does not work. It thinks the result of `(*self)` is not a
reference, but a value expression:

> error[E0605]: non-primitive cast: `U` as `*const U`
>   --> /home/aeh/src/linux-rust/hrtimer-v4-wip/rust/kernel/hrtimer/pin.rs:62:24
>    |
> 62 |         let self_ptr = (*self) as *const U;
>    |                        ^^^^^^^^^^^^^^^^^^^ invalid cast
>    |
> help: consider borrowing the value
>    |
> 62 |         let self_ptr = &(*self) as *const U;
>    |                        +


Another option to consider is:

 `<Self as core::ops::Deref>::deref(&self) as *const U;`

That is also fine for me. Which one do you like better?


Best regards,
Andreas Hindborg



