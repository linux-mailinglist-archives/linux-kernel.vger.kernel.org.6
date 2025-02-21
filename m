Return-Path: <linux-kernel+bounces-525578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A6FA3F199
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 11:15:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB57370225B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 10:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3F5205AC5;
	Fri, 21 Feb 2025 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhnm/i47"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5C720102C;
	Fri, 21 Feb 2025 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740132913; cv=none; b=Oh/UAPJ+4JTYXWt5eroSrH2QqUqNxXCsedolw5crBLkVBZEx+5zEFZfm60fxOcHJ26HHUI9Rla1KPCKC8yVpcj01iOaUYOLWJP5gJADTMCp7+hico8VQt92ill7lc4E1CZkdwyXofXM05u8CEQF9qnePQwLJWEmZ8uMCbK1L6fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740132913; c=relaxed/simple;
	bh=wSC1GjhCo5yf/kHGrfCrHB0JMy0/s+ydsKQOikv6YFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u0ooObf0AXSzQVrzMd/vxjoc/8oXVXONCZydPj3nEigTORmgc3BBUA7B3m6xg68CYQ+63ZZ0oivWZFCto+r+fymN9uXGHCrVV170LVFMpGjiG1Of+GW3GR6xLUeyn1U+kIP7ZdECDzcrTqLAneAj16SKDCK0XYG7uE/i7eUsIf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhnm/i47; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DCCC4CEDD;
	Fri, 21 Feb 2025 10:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740132913;
	bh=wSC1GjhCo5yf/kHGrfCrHB0JMy0/s+ydsKQOikv6YFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=uhnm/i47xWKDTDC+WORmaeS/i9A6T5FDykwbHKd776VLG5f1RrUNO2K5yVdfErkTt
	 fNPDsa865hKmr2WZeXju5lqF1czCiGW2HuA0WspjtfGUAl9LF1wzWCS7I0UfvHXlA+
	 4caO8sDfcm0n1N3Z73kWO13xFARf9TIVGc7PgwFfG4VQt44rAH9SxXWbzHjfgvkxxl
	 pE5s1IAsh3+w/ricieEwmZN6J/JYnEHBTEtGARiqO78roRzUAIBFyYo6Z59M9Q6Xiy
	 14p4+AuCUktMZ0nqB8w8mvlWq28SNGeulZdTRpx6JZoGHozISBfWag114ptIuHDsHu
	 SeaMI6kWHjJLg==
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
In-Reply-To: <87a5afhdq0.fsf@kernel.org> (Andreas Hindborg's message of "Fri,
	21 Feb 2025 10:03:03 +0100")
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org>
	<20250218-hrtimer-v3-v6-12-rc2-v8-2-48dedb015eb3@kernel.org>
	<1id7is_U22yzuGODgkUIoB5AFM6snF9CPu7F_sY7Mfkn3EwQRPfjB5JNkRFYu6DX1N8X_OQvdEB2BT-l3rFhwg==@protonmail.internalid>
	<df748ac2-3551-460f-a16f-85d805671a3f@proton.me>
 <87a5afhdq0.fsf@kernel.org>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Fri, 21 Feb 2025 11:15:01 +0100
Message-ID: <875xl3fvtm.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andreas Hindborg <a.hindborg@kernel.org> writes:

> "Benno Lossin" <benno.lossin@proton.me> writes:
>
>> On 18.02.25 14:27, Andreas Hindborg wrote:
>>> +pub trait HrTimerCallback {
>>> +    /// The type whose [`RawHrTimerCallback::run`] method will be invoked when
>>> +    /// the timer expires.
>>> +    type CallbackTarget<'a>: RawHrTimerCallback;
>>> +
>>> +    /// This type is passed to the timer callback function. It may be a borrow
>>> +    /// of [`Self::CallbackTarget`], or it may be `Self::CallbackTarget` if the
>>> +    /// implementation can guarantee exclusive access to the target during timer
>>
>> Technically "exclusive" access is correct if the `CallbackTarget` is
>> `Pin<&Self>`, since you will get exclusive access to a `Pin<&Self>`, but
>> it might confuse people, because there can be multiple `Pin<&Self>`. So
>> I would just drop the word "exclusive" here.
>
> Yes, maybe it should be "shared or exclusive access, depending on the type"?
>
>>
>>> +    /// handler execution.
>>> +    type CallbackTargetParameter<'a>;
>>
>> Also why can't this type be an associated type of `HrTimerPointer`?
>> Since this seems to always be constrained in the impls of
>> `RawHrTimerCallback`.
>
> That might be a nice improvement, I'll try that out.

Looking closer at this, I don't see how to achieve this. We need access
to the type here, because it is used in the signature of `run`.
`HrTimerCallback` has no bounds on it, and that is nice. If we want to
move these associated types, we have to introduce a bound here.

We need to be generic over the type of the parameter to `run`, and by
the time the user implements this trait, the type must be known and so
the user has to specify somehow.


Best regards,
Andreas Hindborg



