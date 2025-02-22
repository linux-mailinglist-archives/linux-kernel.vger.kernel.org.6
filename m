Return-Path: <linux-kernel+bounces-527143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 806D0A407DD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 12:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3E817ED83
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 11:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB74D20A5E1;
	Sat, 22 Feb 2025 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJKGy3qn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE34207A03;
	Sat, 22 Feb 2025 11:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740223657; cv=none; b=BfFivVdhKBFl5C4r73Uze/pcipxpKvL7klwI27eMeqtlNp2RmghZLm9Ck1Y0hEwD85c1L1rZwgBgIuTKQk42OJh43blARQuxVYCY6KPvMXzjL6+TWkfAYv66RglMkZKu8aLVZkSH0TopEjYln9vi93c/MFSYlQKZ0LZPrGxi/Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740223657; c=relaxed/simple;
	bh=WxrDsmMBLtsWhAj3vyvEabkkXnfwKlhdJ9w+mMMtKY8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G7Qh+6TPi08Pn6P+YNVlu7NhkRv038i1MgElYM5LI+s60EEY4XVnd4Z9I7mD82i1ZdFnxI1XsVySgGd//QEQB7Izrcx/HoDG4yWdMDP6raGWllhT2HzpK3i1FBaTGe8Ss0PLpkF3vd6nsoUNTJeNpNrAJayw813HzTbWrkpmC3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJKGy3qn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 211DFC4CED1;
	Sat, 22 Feb 2025 11:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740223656;
	bh=WxrDsmMBLtsWhAj3vyvEabkkXnfwKlhdJ9w+mMMtKY8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iJKGy3qnJfjsy4/+L1Zetu6p7YcZ+eNuPCwAW/aGB1O1I/VIUgytZvcRlrQweRN6y
	 kUoIxeovt1Jyi8fqYp4Nk29affseuzW/lmRv42jaIIIQIRLxumB7hZKRHA1RuNGfZk
	 cYxN2PhhkEhGH9qYIeR2gXnrPBwOuLtUllVpPIwn6Zx2nGm28Ve1d6iuUbJFVp3o95
	 zlxl8zD4Yu/GmvBcTVM4m+vbBjRSgxA+jEEC0oxghBSLfqiA7W0Ydhhz0kw+9XnaVn
	 FN3H/AxVxt1msDU3Jp96LxhWAf/2qitm19t1mCraBjWQKgjsqaWM4A6jJmxu4OA9gq
	 rJsulp2aEL9cQ==
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
 <tamird@gmail.com>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 02/14] rust: hrtimer: introduce hrtimer support
In-Reply-To: <a2579353-9249-44d1-8f43-9064beaa109c@proton.me> (Benno Lossin's
	message of "Sat, 22 Feb 2025 09:37:53 +0000")
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
	<20250218-hrtimer-v3-v6-12-rc2-v8-2-48dedb015eb3@kernel.org>
	<1id7is_U22yzuGODgkUIoB5AFM6snF9CPu7F_sY7Mfkn3EwQRPfjB5JNkRFYu6DX1N8X_OQvdEB2BT-l3rFhwg==@protonmail.internalid>
	<df748ac2-3551-460f-a16f-85d805671a3f@proton.me>
 <87a5afhdq0.fsf@kernel.org>
	<875xl3fvtm.fsf@kernel.org>
	<uoEWs3I3Cf4H5QBXCk4i1-gCs_nR7fJAX7z9JyvaEIP_yrPckvsgcC8fWctvwPY91ZLOwk041dhytXFtSwDFOA==@protonmail.internalid>
	<841150db-2f92-4cfe-bb1f-29b34b4662c1@proton.me>
 <87o6yveble.fsf@kernel.org>
	<F4gUtoGlotAjPGDTRJvfEZqfyEhkp35fCC1sKMtlXKMm8PQV_hNIsNz6ZOE1OcRmNTQU36vvHXTynOZ5LxSJbw==@protonmail.internalid>
	<a2579353-9249-44d1-8f43-9064beaa109c@proton.me>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Sat, 22 Feb 2025 12:27:22 +0100
Message-ID: <87mseecj8l.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <benno.lossin@proton.me> writes:

> On 21.02.25 13:17, Andreas Hindborg wrote:
>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>
>>> On 21.02.25 11:15, Andreas Hindborg wrote:
>>>> Andreas Hindborg <a.hindborg@kernel.org> writes:
>>>>
>>>>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>>>>
>>>>>> On 18.02.25 14:27, Andreas Hindborg wrote:
>>>>>>> +pub trait HrTimerCallback {
>>>>>>> +    /// The type whose [`RawHrTimerCallback::run`] method will be invoked when
>>>>>>> +    /// the timer expires.
>>>>>>> +    type CallbackTarget<'a>: RawHrTimerCallback;
>>>>>>> +
>>>>>>> +    /// This type is passed to the timer callback function. It may be a borrow
>>>>>>> +    /// of [`Self::CallbackTarget`], or it may be `Self::CallbackTarget` if the
>>>>>>> +    /// implementation can guarantee exclusive access to the target during timer
>>>>>>
>>>>>> Technically "exclusive" access is correct if the `CallbackTarget` is
>>>>>> `Pin<&Self>`, since you will get exclusive access to a `Pin<&Self>`, but
>>>>>> it might confuse people, because there can be multiple `Pin<&Self>`. So
>>>>>> I would just drop the word "exclusive" here.
>>>>>
>>>>> Yes, maybe it should be "shared or exclusive access, depending on the type"?
>>>>>
>>>>>>
>>>>>>> +    /// handler execution.
>>>>>>> +    type CallbackTargetParameter<'a>;
>>>>>>
>>>>>> Also why can't this type be an associated type of `HrTimerPointer`?
>>>>>> Since this seems to always be constrained in the impls of
>>>>>> `RawHrTimerCallback`.
>>>>>
>>>>> That might be a nice improvement, I'll try that out.
>>>>
>>>> Looking closer at this, I don't see how to achieve this. We need access
>>>> to the type here, because it is used in the signature of `run`.
>>>> `HrTimerCallback` has no bounds on it, and that is nice. If we want to
>>>> move these associated types, we have to introduce a bound here.
>>>>
>>>> We need to be generic over the type of the parameter to `run`, and by
>>>> the time the user implements this trait, the type must be known and so
>>>> the user has to specify somehow.
>>>
>>> I think if you put the associated type on the `RawHrTimerCallback`
>>> trait, it should work.
>>
>> What would be the signature of `HrTimerCallback::run` in that case?
>
>     /// Implemented by structs that can be the target of a timer callback.
>     pub trait HrTimerCallback {
>         /// The type whose [`RawHrTimerCallback::run`] method will be invoked when
>         /// the timer expires.
>         type CallbackTarget: RawHrTimerCallback;
>
>         /// Called by the timer logic when the timer fires.
>         fn run(this: <Self::CallbackTarget as RawHrTimerCallback>::CallbackTargetParameter<'_>)
>         where
>             Self: Sized;
>         // also, why does this Sized bound exist here?
>     }
>
> That should work, but now the names seem a bit long... How about:
> - CallbackTarget -> Pointer
>   - and then you can also call this the "smart pointer whose `run`
>     method will be invoked when..." in the docs
> - CallbackTargetParameter -> CallbackParameter

Right, that works. I thought you wanted to move both the associated
types.


Best regards,
Andreas Hindborg




