Return-Path: <linux-kernel+bounces-527070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8115FA406FD
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 10:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B0219C6F85
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Feb 2025 09:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14DAF207658;
	Sat, 22 Feb 2025 09:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="FyPcCk+F"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CA220458A
	for <linux-kernel@vger.kernel.org>; Sat, 22 Feb 2025 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740217082; cv=none; b=Pn6+P5RlaxFvQ1dDHbNwTfL8TX42OuPti+HNAakyi+eAHHUrZfr4BcBtjrqZBHaEhh35jrQJbWjjH3rr0z+GTKCifsqJxIVmMp31zPZZKVGeRsuwJUjYGYdcDOmNkCubOoen54CkmKOOBPX4tCnocXGNGDh1Bo9kvuvnYI0Lu9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740217082; c=relaxed/simple;
	bh=vsTXzOsg3hrfJ371flK8NpGydgevELjGtHSeAJ0mSuU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mNnSVvm5WkwmNi6JJuf07xjwI8enAYioD2p0A7UxC52YiBy1InFNKhtfVDRaazbExEHeYuySsA2eQNME9Z9iWen8/+EL/sGs9f9DhKbg7iDvMs0toQi8RQZ1ueYSsIiGgXqPVYDdNlQj35zYEkS0cRuXCmtxNx47ZPLy+QqcSBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=FyPcCk+F; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1740217078; x=1740476278;
	bh=55lTNHa0JObaGbVq2nFp/5SG1J6H0QyA17uQmtPumlg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=FyPcCk+F1uJs0V3hbGTBIRCVa6KoJJSVs3xuXkVvWCHNe9pRRlaF6UT+WonTtBlVU
	 nwm+OorhFXagvGGvx9vcfARSmqwEScYfm+e8vMfKf2mwhNDbLvS7Ek7mXSHe0/7CqU
	 /Asj8vYkH8IK9Gi13lgtD1BLOaHgmxUMTROYka6rNCojNo2kSmEHg6FKXEw8earDNV
	 y6mYB1QaxGjLjNUcUbfjHLjkYfztFFJvE55gbTSIb9D8DPmBIc7sgwYuf4FtqHiPdY
	 tsH1BKVuHygQvY5PyP6OMf5PiPwGZ11eYCmDeTEt92GAAdVwuA7tLSJmL2fvCNgfm0
	 ArkXuX09Hnx1A==
Date: Sat, 22 Feb 2025 09:37:53 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Danilo Krummrich <dakr@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Lyude Paul <lyude@redhat.com>, Guangbo Cui <2407018371@qq.com>, Dirk Behme <dirk.behme@gmail.com>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@gmail.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 02/14] rust: hrtimer: introduce hrtimer support
Message-ID: <a2579353-9249-44d1-8f43-9064beaa109c@proton.me>
In-Reply-To: <87o6yveble.fsf@kernel.org>
References: <20250218-hrtimer-v3-v6-12-rc2-v8-0-48dedb015eb3@kernel.org> <20250218-hrtimer-v3-v6-12-rc2-v8-2-48dedb015eb3@kernel.org> <1id7is_U22yzuGODgkUIoB5AFM6snF9CPu7F_sY7Mfkn3EwQRPfjB5JNkRFYu6DX1N8X_OQvdEB2BT-l3rFhwg==@protonmail.internalid> <df748ac2-3551-460f-a16f-85d805671a3f@proton.me> <87a5afhdq0.fsf@kernel.org> <875xl3fvtm.fsf@kernel.org> <uoEWs3I3Cf4H5QBXCk4i1-gCs_nR7fJAX7z9JyvaEIP_yrPckvsgcC8fWctvwPY91ZLOwk041dhytXFtSwDFOA==@protonmail.internalid> <841150db-2f92-4cfe-bb1f-29b34b4662c1@proton.me> <87o6yveble.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 328bfb3974f6c934d2a59aa92a9dea9196371e29
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.02.25 13:17, Andreas Hindborg wrote:
> "Benno Lossin" <benno.lossin@proton.me> writes:
>=20
>> On 21.02.25 11:15, Andreas Hindborg wrote:
>>> Andreas Hindborg <a.hindborg@kernel.org> writes:
>>>
>>>> "Benno Lossin" <benno.lossin@proton.me> writes:
>>>>
>>>>> On 18.02.25 14:27, Andreas Hindborg wrote:
>>>>>> +pub trait HrTimerCallback {
>>>>>> +    /// The type whose [`RawHrTimerCallback::run`] method will be i=
nvoked when
>>>>>> +    /// the timer expires.
>>>>>> +    type CallbackTarget<'a>: RawHrTimerCallback;
>>>>>> +
>>>>>> +    /// This type is passed to the timer callback function. It may =
be a borrow
>>>>>> +    /// of [`Self::CallbackTarget`], or it may be `Self::CallbackTa=
rget` if the
>>>>>> +    /// implementation can guarantee exclusive access to the target=
 during timer
>>>>>
>>>>> Technically "exclusive" access is correct if the `CallbackTarget` is
>>>>> `Pin<&Self>`, since you will get exclusive access to a `Pin<&Self>`, =
but
>>>>> it might confuse people, because there can be multiple `Pin<&Self>`. =
So
>>>>> I would just drop the word "exclusive" here.
>>>>
>>>> Yes, maybe it should be "shared or exclusive access, depending on the =
type"?
>>>>
>>>>>
>>>>>> +    /// handler execution.
>>>>>> +    type CallbackTargetParameter<'a>;
>>>>>
>>>>> Also why can't this type be an associated type of `HrTimerPointer`?
>>>>> Since this seems to always be constrained in the impls of
>>>>> `RawHrTimerCallback`.
>>>>
>>>> That might be a nice improvement, I'll try that out.
>>>
>>> Looking closer at this, I don't see how to achieve this. We need access
>>> to the type here, because it is used in the signature of `run`.
>>> `HrTimerCallback` has no bounds on it, and that is nice. If we want to
>>> move these associated types, we have to introduce a bound here.
>>>
>>> We need to be generic over the type of the parameter to `run`, and by
>>> the time the user implements this trait, the type must be known and so
>>> the user has to specify somehow.
>>
>> I think if you put the associated type on the `RawHrTimerCallback`
>> trait, it should work.
>=20
> What would be the signature of `HrTimerCallback::run` in that case?

    /// Implemented by structs that can be the target of a timer callback.
    pub trait HrTimerCallback {
        /// The type whose [`RawHrTimerCallback::run`] method will be invok=
ed when
        /// the timer expires.
        type CallbackTarget: RawHrTimerCallback;
   =20
        /// Called by the timer logic when the timer fires.
        fn run(this: <Self::CallbackTarget as RawHrTimerCallback>::Callback=
TargetParameter<'_>)
        where
            Self: Sized;
        // also, why does this Sized bound exist here?
    }

That should work, but now the names seem a bit long... How about:
- CallbackTarget -> Pointer
  - and then you can also call this the "smart pointer whose `run`
    method will be invoked when..." in the docs
- CallbackTargetParameter -> CallbackParameter

---
Cheers,
Benno



