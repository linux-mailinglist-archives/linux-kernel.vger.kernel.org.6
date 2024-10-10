Return-Path: <linux-kernel+bounces-358967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A489985DA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 14:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 486271C21C9E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 12:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C301C4623;
	Thu, 10 Oct 2024 12:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/3OhUGf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E331BDA8D;
	Thu, 10 Oct 2024 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728563105; cv=none; b=M33AxKKW7E5RHCZDMurMQQyIzlaa54hpR59lCRdlwotakrvHZtZVcOvIvzQ7G7zG1tj4t4OEKIH/euEMLjYBSn4YdpB10v6XtZG1rrSp1CjFc/ZoAQCy/JcQ6AfI7pJ6D9wOSAVq5u5SoUfsuUiQAXmul2F8zSmhR3uX5DfFd/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728563105; c=relaxed/simple;
	bh=HizpD/yKlQdyBbr2TvLEEcfUYqeKG1QhLvslstH1G+w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LlRqCvAwD5yFcc31Rzte3qdITL1fg1qVj0LPRxof6TUucYKqYD5BNOYqrfyw6fSgCFGtTj52oW0tk5hmIDMPY8FyAMNzm/VkyJ3Jvhr+0DSTNri4w7vf5vT1TZ/gbjrXFE24N4qfwxx2WS3PqVeLXcJnkQqi3MbII23krWh37zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/3OhUGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4301BC4CECE;
	Thu, 10 Oct 2024 12:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728563105;
	bh=HizpD/yKlQdyBbr2TvLEEcfUYqeKG1QhLvslstH1G+w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=n/3OhUGfZxCzHMMJ3r6UpqfL8CB69fkt1cYVONODixvCisO5jo5tUbjXiAB2SjyNI
	 /toprhUD1oBAdkX1JJaCClmlpXRpIEko+aCB6SiAPO0f15Bq9S8eWnGD528g498OwJ
	 ixEFtVA4oCvKv0mxVkG8w5JMNyfmrK9oQpWzMrpGOcs+rPCBUJ7vpzPCWtr+OWQNJQ
	 uFNlgUv4Z+xHIqUn66pI8wdFggYzs+y4Jum387mp5i4VE907wAwPo9piJMZfgEm39G
	 yqem3gme9VtELLpGrmUNhIzjdX/3hQM5fAG9qybYQ/ZJ6ulnoD8gj1QwUdcfUATSFs
	 uFFjcstbVAvUw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Anna-Maria Behnsen <anna-maria@linutronix.de>,  Frederic Weisbecker
 <frederic@kernel.org>,  Thomas Gleixner <tglx@linutronix.de>,  Boqun Feng
 <boqun.feng@gmail.com>,  Gary Guo <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6?=
 =?utf-8?Q?rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  Alice Ryhl <aliceryhl@google.com>,
  rust-for-linux@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/14] rust: hrtimer: introduce hrtimer support
In-Reply-To: <51f18817-1ebd-451a-bc6e-e298a9148001@proton.me> (Benno Lossin's
	message of "Mon, 23 Sep 2024 16:59:47 +0000")
References: <20240917222739.1298275-1-a.hindborg@kernel.org>
	<20240917222739.1298275-3-a.hindborg@kernel.org>
	<Wohby8PLjQeZ47sXKGeWKOxdA2ShTjjvqOM6xWzhJY1aZ-SYk9TCDAnZN2EqiWuJUKwPKoFCsCofDHjtfeG--w==@protonmail.internalid>
	<f502f6c6-40b7-4ec4-8d0c-09adb0df1a30@proton.me>
 <878qvojj0o.fsf@kernel.org>
	<pvhILkKRTj8T2Ks3off5HLMqewNM_X192WV4J5-nnC4Uu0o9G8-Qk5Tl9bQxsqVCw4QHmeJii7mCK2VorN-xcw==@protonmail.internalid>
	<33c65715-3af5-44f9-93c5-149d07a4c503@proton.me>
 <87ldziqqeo.fsf@kernel.org>
	<51f18817-1ebd-451a-bc6e-e298a9148001@proton.me>
Date: Thu, 10 Oct 2024 14:24:53 +0200
Message-ID: <87zfnckuwa.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benno Lossin <benno.lossin@proton.me> writes:

> On 23.09.24 18:35, Andreas Hindborg wrote:
>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>> On 19.09.24 07:43, Andreas Hindborg wrote:
>>>>>> +    /// until the timer is unarmed and the callback has completed.
>>>>>> +    ///
>>>>>> +    /// Note: It must be safe to leak the handle.
>>>>>> +    type TimerHandle: TimerHandle;
>>>>>
>>>>> Why does this need to be an associated type? Couldn't we have a
>>>>> `TimerHandle<T>` struct? The schedule function below could then return
>>>>> `TimerHandle<Self>`.
>>>>
>>>> At one point, I had some cycles in trait resolution. Moving generics to
>>>> associated types solved that issue. Maybe this can be changed to a
>>>> generic. But are generics preferred over associated types for some
>>>> reason?
>>>
>>> The associated type is more complicated IMO, because then every
>>> implementer of the trait needs to create one. If we can avoid that, I
>>> would prefer a generic type.
>> 
>> When you say create, you mean specify?
>
> Yes.
>
>> Users would not invent their own type to put here, they would use the
>> types defined by the `hrtimer` module in later patches.
>
> I mean the implementers of this trait, not the users of the trait. You
> define an `ArcTimerHandle`, `PinTimerHandle` and a `PinMutTimerHandle`
> in this series. I think we can avoid that using a single generic struct.

It is not immediately clear for me how to do this. For `Box` we have:

pub struct BoxTimerHandle<U>
where
    U: HasTimer<U>,
{
    pub(crate) inner: *mut U,
}

but for `Pin<&U>` we have

pub struct PinTimerHandle<'a, U>
where
    U: HasTimer<U>,
{
    pub(crate) inner: Pin<&'a U>,
}

How can these be combined to a single generic struct?


Best regards,
Andreas


