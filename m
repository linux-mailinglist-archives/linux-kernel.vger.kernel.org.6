Return-Path: <linux-kernel+bounces-530528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED010A434D5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 06:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 661C27A8306
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 05:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C512566DF;
	Tue, 25 Feb 2025 05:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TkelMVso"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4207536124;
	Tue, 25 Feb 2025 05:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740462777; cv=none; b=fBVcXxCHDsxAGKaQvxvq0AJFOi+FL+piIOqQW77ER6wRhSrKSIepH4OmqZhCtQYCFQRyVZ07K40tBA1gdpKi/0SwXKa6Wo9B6Rhp9ZUI6AUPGL8Q9fBT3XITC0FEnAJMW4Fxy4mKA9BvUsOgpc44eXdbw2Qu+Wk0uIxkMerNC4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740462777; c=relaxed/simple;
	bh=plyhqDSil5qjh5CX+n9oacA+uh+ZXsBXhBfRTVKjaEQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GWq7Mi6v0mSuzAE8KPRb9ra66gbhMkPs/3FCrqDNx/VkpVEb+q5x2aU8EYEk8ksdEigY256RTN8dBIq4D8NrexHmPeM+VobK/2iR7hrKsJzGPJokNGtiUmCLN4pkZfsjzm3L7UkaTFMwqWFggd8SMWvZ1ydY/ZTb/boy3cl1Gcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TkelMVso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F63FC4CEDD;
	Tue, 25 Feb 2025 05:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740462776;
	bh=plyhqDSil5qjh5CX+n9oacA+uh+ZXsBXhBfRTVKjaEQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TkelMVsoIY0+tXB+zTRI3UN/7W1jPXRkGE+4IerFSvbjCIt59s8yeukyG/zzk8Ujx
	 NBp3pY2pVWrAuDQ8UGWYGryZIneA2WUXHRQTDSzEWuoBUDElL4ob7NnD0QwiXEiM1I
	 nqFX67wxqfC9a53WjzQAJtwtmDN/qrLZ082/IOD6+4/kFs2XdGs74XewARjxcrL9pJ
	 SMhCxjWfRMOFmlG8GBxR/itwoKTwJDyZP2bJ4Cjij7BHYveb5378L47ehs3qbElqx5
	 PJiqvhfMzoWeWAF0FRGjesmRsElAAIaMTFLa/EFPkt47STN+JJ9l49uXqNJqcGTzbD
	 HTAtSlQkrEMEw==
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
In-Reply-To: <e3fc00dd-144a-4885-b8c7-76cd9322211a@proton.me> (Benno Lossin's
	message of "Mon, 24 Feb 2025 22:50:44 +0000")
References: <20250223072114.3715-1-boqun.feng@gmail.com>
	<87wmdf22ae.fsf@kernel.org>
	<abHXLME4gEkYx7XkPVjZGIFs7Uuur8t0PkXDscTQPCvJCRsEfxM7gUS3K4MqegDt_nBDQJQDjLf5utZREFhDzA==@protonmail.internalid>
	<304505cb-9f68-4d34-b4f1-7d703baba012@proton.me>
 <87r03n1tmd.fsf@kernel.org>
	<t26Ffiqds7WyT_9w9BXDV0sjsIMXiMURZrOWuMFTloZBD0S5WvJgkpZXbjxzYjFp-rPmBdi0yMPyFUO4hqZL4w==@protonmail.internalid>
	<e3fc00dd-144a-4885-b8c7-76cd9322211a@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 25 Feb 2025 06:52:48 +0100
Message-ID: <87zfiay3in.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> On 24.02.25 12:15, Andreas Hindborg wrote:
>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>
>>> On 24.02.25 09:08, Andreas Hindborg wrote:
>>>> Boqun Feng <boqun.feng@gmail.com> writes:
>>>>
>>>>> To provide examples on usage of `Guard::lock_ref()` along with the unit
>>>>> test, an "assert a lock is held by a guard" example is added.
>>>>>
>>>>> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
>>>>> ---
>>>>> This depends on Alice's patch:
>>>>>
>>>>> 	https://lore.kernel.org/all/20250130-guard-get-lock-v1-1-8ed87899920a@google.com/
>>>>>
>>>>> I'm also OK to fold this in if Alice thinks it's fine.
>>>>>
>>>>>  rust/kernel/sync/lock.rs | 24 ++++++++++++++++++++++++
>>>>>  1 file changed, 24 insertions(+)
>>>>>
>>>>> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
>>>>> index 3701fac6ebf6..6d868e35b0a3 100644
>>>>> --- a/rust/kernel/sync/lock.rs
>>>>> +++ b/rust/kernel/sync/lock.rs
>>>>> @@ -201,6 +201,30 @@ unsafe impl<T: Sync + ?Sized, B: Backend> Sync for Guard<'_, T, B> {}
>>>>>
>>>>>  impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
>>>>>      /// Returns the lock that this guard originates from.
>>>>> +    ///
>>>>> +    /// # Examples
>>>>> +    ///
>>>>> +    /// The following example shows how to use [`Guard::lock_ref()`] to assert the corresponding
>>>>> +    /// lock is held.
>>>>> +    ///
>>>>> +    /// ```
>>>>> +    /// # use kernel::{new_spinlock, stack_pin_init, sync::lock::{Backend, Guard, Lock}};
>>>>> +    ///
>>>>> +    /// fn assert_held<T, B: Backend>(guard: &Guard<'_, T, B>, lock: &Lock<T, B>) {
>>>>> +    ///     // Address-equal means the same lock.
>>>>> +    ///     assert!(core::ptr::eq(guard.lock_ref(), lock));
>>>>> +    /// }
>>>>
>>>> This seems super useful. Perhaps add this method as part of the lock api
>>>> instead of just having it in the example?
>>>
>>> I don't think it should be an assert. Instead make it return a
>>> `Result<(), ()>`. (or create better named unit error types)
>>
>> No, this should not be part of usual control flow, and developers should
>> not make control flow decisions based on this. It would always be an
>> assertion. But you are right that `assert!` is probably not what we
>> want. `debug_assert!` might be fine though.
>
> I agree, that it shouldn't be used for driver logic, but you still might
> want to warn/warn_once instead of panic (or debug_assert).

It might be useful to have an `assert!` that just does `pr_once!` on
failed assertion. I sort of said I would pick up the `pr_once!` patches,
so perhaps I should add that?


Best regards,
Andreas Hindborg





