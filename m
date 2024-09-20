Return-Path: <linux-kernel+bounces-334109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D727497D2B1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 10:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 166AD1C23B4B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Sep 2024 08:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8611613C3D3;
	Fri, 20 Sep 2024 08:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eh021mjM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24DE13AA4E;
	Fri, 20 Sep 2024 08:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820714; cv=none; b=X5aCuA7p2E83R4IjI+ySu0HXVCyW9x09vMOvpziFkeDmP/Vu64o2xMkVXUgRYXF3q8Xj6GJd5u2Ag1o5X+LFvwd6DeMJ96KIBLEJq4JWqwyLb10le+6ujZ/ea9tpJzRvLQ2nSCdce1wk0Ldq/ccKb4fYhD29nYG1mGJciQkPxJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820714; c=relaxed/simple;
	bh=H1asYJpbEc/Ve9AdnB6jOwTfoQo/irpzHgdMxUR7AOI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BGMoKo8wTBScIe/R/JRsy+wuRtxmC7GaXkqTpKeWnVqpErCkncm7hROJ0JwggkotjX3wLGFZfPQf/3o/TLwbLDyhsJk/1D99XiKDB0KR1lXIT/Dz6AlTVje82mTtBZn6GQvdWVzxyTiJMInzI8m91s/Mqm2AVKe42vqeBUI5H4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eh021mjM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A6EC4CEC3;
	Fri, 20 Sep 2024 08:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726820713;
	bh=H1asYJpbEc/Ve9AdnB6jOwTfoQo/irpzHgdMxUR7AOI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Eh021mjM3bxxOgxCmpYxOqatsBwUY22jMa8C9n1mgCJczPmZGUr43Fhs32dHrM4O1
	 oFNPRJcfciplroGrHup741eqTKv38d8Fx4CpRx1YC6pvludQ6zqc+3Rs+yVDZYB2VI
	 wu7pj64BPXL/R7+YzCioUEpQ1v/ysQ5Cpj5JThbiMR8nfhh2OD4Hl9Sb6d8m+5tmbb
	 zmfcxIgmQfb/4Fbt6P0hGz4n5wG/o4r/LpqaBM+40GaqQngHUjO7H4S83BUuefEo7O
	 sJZQt39cnqKIMbboa2yLCD3z3EYniRYSbtK5brTTFh75JzpWswOgERUzB6762Nw6o9
	 9lrEyPLPO0TRg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <benno.lossin@proton.me>
Cc: "Gary Guo" <gary@garyguo.net>,  "Miguel Ojeda" <ojeda@kernel.org>,
  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Anna-Maria Behnsen"
 <anna-maria@linutronix.de>,  "Frederic Weisbecker" <frederic@kernel.org>,
  "Thomas Gleixner" <tglx@linutronix.de>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  "Alice Ryhl" <aliceryhl@google.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 04/14] rust: sync: add `Arc::clone_from_raw`
In-Reply-To: <19760254-bc0b-49e2-88a0-7088ab55d9b1@proton.me> (Benno Lossin's
	message of "Thu, 19 Sep 2024 14:15:02 +0000")
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
	<20240917222739.1298275-5-a.hindborg@kernel.org>
	<43b9bc9b-f64c-4421-8cf2-795f1f0ec94a@proton.me>
	<6J_M8_wAnE5epFRUo8RBkYFL5p36woueX8MHQleKVFw_WOitLFZNQ6808RjS7RmizhQ07qDQpze2G3UDLZgHDA==@protonmail.internalid>
	<20240918211211.73b1324e.gary@garyguo.net> <87zfo4i3nc.fsf@kernel.org>
	<1dkKZAT3rq13ubPiaoqilP1uZsSCOiAXnJ8HTUQ4qpWmHpl45XpiJpkaZiT87VYE_I0YpsZZKa7Tz6Fs-kbOlA==@protonmail.internalid>
	<19760254-bc0b-49e2-88a0-7088ab55d9b1@proton.me>
Date: Fri, 20 Sep 2024 10:25:13 +0200
Message-ID: <87bk0iivfa.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> On 19.09.24 08:00, Andreas Hindborg wrote:
>> "Gary Guo" <gary@garyguo.net> writes:
>>
>>> On Wed, 18 Sep 2024 18:19:20 +0000
>>> Benno Lossin <benno.lossin@proton.me> wrote:
>>>
>>>> On 18.09.24 00:27, Andreas Hindborg wrote:
>> [...]
>>>>> +    pub unsafe fn clone_from_raw(ptr: *const T) -> Self {
>>>>> +        // SAFETY: The caller promises that this pointer points to data
>>>>> +        // contained in an `Arc` that is still valid.
>>>>> +        let inner = unsafe { ArcInner::container_of(ptr).as_ref() };
>>>>> +
>>>>> +        // INVARIANT: C `refcount_inc` saturates the refcount, so it cannot
>>>>> +        // overflow to zero. SAFETY: By the function safety requirement, there
>>>>> +        // is necessarily a reference to the object, so it is safe to increment
>>>>> +        // the refcount.
>>>>> +        unsafe { bindings::refcount_inc(inner.refcount.get()) };
>>>>> +
>>>>> +        // SAFETY: We just incremented the refcount. This increment is now owned by the new `Arc`.
>>>>> +        unsafe { Self::from_inner(inner.into()) }
>>>>
>>>> The implementation of this function looks a bit strange to me, how about
>>>> this?:
>>>>
>>>>     // SAFETY: this function has the same safety requirements as `from_raw`.
>>>>     let arc = unsafe { Self::from_raw(ptr) };
>>>>     let clone = arc.clone();
>>>>     // Prevent decrementing the refcount.
>>>>     mem::forget(arc);
>>>>     clone
>>>>
>>>> (of course you would need to change the safety requirements of
>>>> `clone_from_raw` to point to `from_raw`)
>>>
>>> Wouldn't this function simply be
>>>
>>> 	// SAFETY: ...
>>> 	let borrow = unsafe { ArcBorrow::from_raw(ptr) }
>>>   	borrow.into()
>>>
>>> ?
>>>
>>> Maybe this function doesn't even need to exist...
>>
>> Maybe that could work. But my use case does not satisfy the safety
>> requirements on `ArcBorrow::from_raw`. The`Arc::into_raw` was not
>> called. Perhaps we can update the requirements for that function?
>
> If I understood the code correctly, you are essentially doing this:
>
>     let arc = Arc::<T>::new(..);
>     let ptr = Arc::as_ptr(&arc);
>     let ptr = T::raw_get_timer(ptr);
>     let ptr = Timer::raw_get(ptr);
>
>     // ptr is now used by the timer subsystem to fire the timer
>
>     let ptr = ptr.cast::<Timer>();
>     let ptr = T::timer_container_of(ptr);
>     let borrow = ArcBorrow::from_raw(ptr);
>     let arc = borrow.into();
>
> The only thing that we would have to change would be adding
> `Arc::as_ptr` as a source in the `ArcBorrow::from_raw` safety
> requirements.

Yes, I think so. I agree that `ArcBorrow` is the right way forward here.
Patch 11 of this series extends `TimerCallback` to be able to have a
different type for the implementer of `RawCallback` and the type passed
to `run`. This is to be able to specify `Pin<Box<_>` as the pointer but
`& _` as the parameter. Those names should probably be changed to
`CallbackTarget` and `CallbackTargetBorrow`, but they could cover this
use of `ArcBorrow` as well.

This use is very similar to `ForeignOwnable`, but a slightly different
use case, since I want to implement for pinned references too. Is there
a way of aligning this and sharing some trait here?

Best regards,
Andreas



