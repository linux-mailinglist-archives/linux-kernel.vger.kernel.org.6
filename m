Return-Path: <linux-kernel+bounces-528777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CE4A41C39
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 12:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B653B6565
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 11:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E493925A2B6;
	Mon, 24 Feb 2025 11:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvlTaxKA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481C91853;
	Mon, 24 Feb 2025 11:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395735; cv=none; b=duBT3LtD9mwn4zmE8tf8ag8zHkShaX6rowJ6zegMQheS4JMnM6LEEDDDXwtiFMwfSgU/aLi82POlYCs3OcGGz9wHatZPx1lwuObdBi77RTuo5QNVdHRooFXdrYxCrtoh0AEWq6CgDwZ+89FfUbfTmrP+KjqU8/bMqcbRsKTWF6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395735; c=relaxed/simple;
	bh=WmHoHIDzRoE4YEADCig2y1QWlSoJdSm+eIGybIJt26k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Os6Sn+r5M2ZFW4OOp4VFy20UHWPrC5ZsJoKih31wJ2iC9nxOajrASYzv3A3gKyUueT/VgQcPbWgaVjTP4C+6TiouNb8YwzjoI8phVwP4IEYOh4GclWKkWL/k1vt/uQkl4z86ojy5jurXQXrcOIe+j3CbM01Zjt1vYZC2+irfUFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvlTaxKA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B13AFC4CED6;
	Mon, 24 Feb 2025 11:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395733;
	bh=WmHoHIDzRoE4YEADCig2y1QWlSoJdSm+eIGybIJt26k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CvlTaxKAcOGRpLRF3L/NiwDx7cBxWbrtcO112/NiNe4V5wi6sXfTpZ79dUqghuFnJ
	 aiK0X20dkEwTgw9ABq+ibZ4QH8ZBCoTSb9DmwQa+ORE2JOvT5Rtio6J3/5Dr7YwPNt
	 AmpWPokx6sV3fSEJRuLn3gnMFdkJPDEYaAcZWNfEvjX+WjPyZWNWe7uPFDuRXk3UaO
	 RlRxDoR0F8/MFuqhg6ExsAfWCXl3J+9NcVK8l42dpqbaoTEDWzUF/NrmzG/YtqGk2X
	 I61b2YmiktKl8pp+OsNTlGG5344kTx11dT6GZgtWqO3h3NU0UcBFOGwCteDC1Kv/uD
	 zjDEyGIXKUe7A==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Boqun Feng" <boqun.feng@gmail.com>,  <linux-kernel@vger.kernel.org>,
  <rust-for-linux@vger.kernel.org>,  "Peter Zijlstra"
 <peterz@infradead.org>,  "Ingo Molnar" <mingo@redhat.com>,  "Will Deacon"
 <will@kernel.org>,  "Waiman Long" <longman@redhat.com>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice
 Ryhl" <aliceryhl@google.com>,  "Trevor Gross" <tmgross@umich.edu>
Subject: Re: [PATCH] rust: sync: lock: Add an example for Guard::lock_ref()
In-Reply-To: <304505cb-9f68-4d34-b4f1-7d703baba012@proton.me> (Benno Lossin's
	message of "Mon, 24 Feb 2025 10:06:35 +0000")
References: <20250223072114.3715-1-boqun.feng@gmail.com>
	<87wmdf22ae.fsf@kernel.org>
	<abHXLME4gEkYx7XkPVjZGIFs7Uuur8t0PkXDscTQPCvJCRsEfxM7gUS3K4MqegDt_nBDQJQDjLf5utZREFhDzA==@protonmail.internalid>
	<304505cb-9f68-4d34-b4f1-7d703baba012@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 24 Feb 2025 12:15:22 +0100
Message-ID: <87r03n1tmd.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> On 24.02.25 09:08, Andreas Hindborg wrote:
>> Boqun Feng <boqun.feng@gmail.com> writes:
>>
>>> To provide examples on usage of `Guard::lock_ref()` along with the unit
>>> test, an "assert a lock is held by a guard" example is added.
>>>
>>> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>>> ---
>>> This depends on Alice's patch:
>>>
>>> 	https://lore.kernel.org/all/20250130-guard-get-lock-v1-1-8ed87899920a@google.com/
>>>
>>> I'm also OK to fold this in if Alice thinks it's fine.
>>>
>>>  rust/kernel/sync/lock.rs | 24 ++++++++++++++++++++++++
>>>  1 file changed, 24 insertions(+)
>>>
>>> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
>>> index 3701fac6ebf6..6d868e35b0a3 100644
>>> --- a/rust/kernel/sync/lock.rs
>>> +++ b/rust/kernel/sync/lock.rs
>>> @@ -201,6 +201,30 @@ unsafe impl<T: Sync + ?Sized, B: Backend> Sync for Guard<'_, T, B> {}
>>>
>>>  impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
>>>      /// Returns the lock that this guard originates from.
>>> +    ///
>>> +    /// # Examples
>>> +    ///
>>> +    /// The following example shows how to use [`Guard::lock_ref()`] to assert the corresponding
>>> +    /// lock is held.
>>> +    ///
>>> +    /// ```
>>> +    /// # use kernel::{new_spinlock, stack_pin_init, sync::lock::{Backend, Guard, Lock}};
>>> +    ///
>>> +    /// fn assert_held<T, B: Backend>(guard: &Guard<'_, T, B>, lock: &Lock<T, B>) {
>>> +    ///     // Address-equal means the same lock.
>>> +    ///     assert!(core::ptr::eq(guard.lock_ref(), lock));
>>> +    /// }
>>
>> This seems super useful. Perhaps add this method as part of the lock api
>> instead of just having it in the example?
>
> I don't think it should be an assert. Instead make it return a
> `Result<(), ()>`. (or create better named unit error types)

No, this should not be part of usual control flow, and developers should
not make control flow decisions based on this. It would always be an
assertion. But you are right that `assert!` is probably not what we
want. `debug_assert!` might be fine though.


Best regards,
Andreas Hindborg




