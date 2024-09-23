Return-Path: <linux-kernel+bounces-336141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5344297EFA9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 101D4281F0D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DEA19F12D;
	Mon, 23 Sep 2024 16:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="e/IMOfoa"
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF83198830
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727110583; cv=none; b=VIY9998Vd+VxR1J3ZwOPeLBVUG8ykem779LjA02kZiuhTGv1qOp4Ty28ozUnRYSrSswZ71IFPFQcg+KmrQrmmUNU9gcX5bEmWeLLuplmPpx8Erv7bjLsETr4q9mdBV2zugESMCJkeo/KRm72Gyv3vGLsCd6MQM7krOqnnID3yT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727110583; c=relaxed/simple;
	bh=/pdY9kWwHrxXvG1S1HxtJPc12+9AHp96/q96eFyw4q4=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iAGX+LX3TCQSjMTG2Yd26nb1OO5grVCNUtw6vDn6ARMPBcnfYjTssnKv/De1lRYHQtwDIVBLfwnlWsXGk4Jcw4HHPwbeZkRGUhZecOfZkaZMwIyXrvch/WjbBdtAes5T6dwzMsFKafVo4kSpjX3tgseowG8DBE2UYrWwKb+odPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=e/IMOfoa; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=vks3cebq3vdw7a4rnzjveg7ena.protonmail; t=1727110573; x=1727369773;
	bh=VBiHTrxnlgF7CEdwzgnz6wOY4daqZeZ2aovd2mGkiw4=;
	h=Date:To:From:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=e/IMOfoa3yf8O6lEpU51TqX+m/aRg1OrWBTSEqDwXJPFAuJBr453TPOvJHVYRhPle
	 7lOD5utxbModcnhLJn916Ro2Z/xiUz+F/ZWcGp5boTXazBOLyDh7op8qhb920cMd22
	 61XHOWcqhsqm9GP4HGwP12yUm48B2FAykHSGcFPUnI0lQKpXpwS6Ii5BIEdByQGFr1
	 pIRsdbRRMPJv0LHkY9GXoP+KhZqttI3P1Sn+mDk0Xk5Hsv05BIDzOZbzCR3mEa6FyX
	 8Wi1hxWdDixEYrjjLhOPcsb573dsPVTZu46mFOIQyzL8qjPOMxQWq3SGJFIWS6z8E6
	 iAF+HynDAUKhQ==
Date: Mon, 23 Sep 2024 16:56:08 +0000
To: Greg KH <gregkh@linuxfoundation.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
From: Benno Lossin <benno.lossin@proton.me>
Subject: Re: [PATCH 1/3] rust: add untrusted data abstraction
Message-ID: <d3b44a97-83db-4bea-b89e-9d631c98ed1e@proton.me>
In-Reply-To: <ZvGScCHfprZcymFQ@phenom.ffwll.local>
References: <20240913112643.542914-1-benno.lossin@proton.me> <20240913112643.542914-2-benno.lossin@proton.me> <ZuRbSxwlz1xWT1pG@phenom.ffwll.local> <cf0d6189-e81c-4b7c-ab50-7a297c69b132@proton.me> <ZuhTdwCqz61bQEgq@phenom.ffwll.local> <3c7b27e3-eedc-44c7-a31b-d927214cc9f8@proton.me> <ZvGScCHfprZcymFQ@phenom.ffwll.local>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 15a44d1ee38d6c104d2efd575a15700ca6a40def
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.09.24 18:08, Simona Vetter wrote:
> On Sat, Sep 21, 2024 at 07:45:44AM +0000, Benno Lossin wrote:
>> On 16.09.24 17:49, Simona Vetter wrote:
>>> On Fri, Sep 13, 2024 at 04:49:29PM +0000, Benno Lossin wrote:
>>>> On 13.09.24 17:33, Simona Vetter wrote:
>>>>> On Fri, Sep 13, 2024 at 11:26:57AM +0000, Benno Lossin wrote:
>>>>>>  /// Used to transfer ownership to and from foreign (non-Rust) langu=
ages.
>>>>>> @@ -532,3 +533,248 @@ unsafe impl AsBytes for str {}
>>>>>>  // does not have any uninitialized portions either.
>>>>>>  unsafe impl<T: AsBytes> AsBytes for [T] {}
>>>>>>  unsafe impl<T: AsBytes, const N: usize> AsBytes for [T; N] {}
>>>>>> +
>>>>>> +/// Untrusted data of type `T`.
>>>>>> +///
>>>>>> +/// When reading data from userspace, hardware or other external un=
trusted sources, the data must
>>>>>> +/// be validated before it is used for logic within the kernel. To =
do so, the [`validate()`]
>>>>>> +/// function exists and uses the [`Validator`] trait. For raw bytes=
 validation there also is the
>>>>>> +/// [`validate_bytes()`] function.
>>>>>> +///
>>>>>> +///
>>>>>> +/// [`validate()`]: Self::validate
>>>>>> +/// [`validate_bytes()`]: Self::validate_bytes
>>>>>> +#[repr(transparent)]
>>>>>> +pub struct Untrusted<T: ?Sized>(T);
>>>>>
>>>>> I think we could make this a bit more strict and instead of encouragi=
ng
>>>>> people to put all their validation code into a Validator<T>, force
>>>>> them to. Which means assuming apis wrap all untrusted stuff in
>>>>> Untrusted<T> reviewers only need to look at validate implementations =
and
>>>>> nothing else.
>>>>>
>>>>> If I'm not too wrong with my rust I think this would work with slitti=
ng
>>>>> Untrusted<T> into two types:
>>>>>
>>>>> - Untrusted<T> is just a box you can't access, and the type returned =
by
>>>>>   apis for untrusted data. It doesn't have any of the functions excep=
t
>>>>>   validate and new_untrusted so that you can't get at the data at all=
.
>>>>>
>>>>> - UntrustedUnsafe<T> does have all the accessors needed for validatio=
n,
>>>>>   but you can't construct that outside of this module. Maybe simplest=
 to
>>>>>   just nest this within the Untrusted<T> box.
>>>>>
>>>>> - Untrusted::validate does the unboxing and passes a reference to
>>>>>   UntrustedUnsafe<T> to Validator::validate, to guarantee that all th=
e
>>>>>   validation code is in there and nowhere else. Similar for
>>>>>   validate_bytes.
>>>>>
>>>>> Of course people can still bypass this easily, but it gets a bit hard=
er to
>>>>> do so, and easier for reviewers to verify everything.
>>>>
>>>> This is a great idea!
>>>> I think we should also remove `validate_bytes`, then you really must
>>>> implement `Validator`. If we figure out later that people need it, we
>>>> can add it later again. I added it because I thought that implementing
>>>> `Validator` for something very small might be very annoying, but it
>>>> seems like you actually want to force people to implement it :)
>>>
>>> See further down, I think there's a real use-case for validate_bytes, o=
r
>>> something really close to it at least.
>>
>> Could you point me to it? I wasn't able to find the use-case you are
>> referring to here.
>>
>> If I remove the `untrusted()` function, then I would think that I also
>> should remove the `validate_bytes` function, since you could just do:
>>
>>     untrusted.validate_bytes(|_| true)
>>
>> Which would give you access to the untrusted data without validation.
>> (of course one could also do this in the `Validate` trait, but I feel
>> like if we have exactly one place where this can happen, it will be a
>> lot easier to catch. We could even have some tool that looks for
>> `Validate` implementations that just return `Ok(untrusted)`)
>=20
> So the use-case I've meant is the in-place validation, without copying
> stuff around. So it wouldn't be the specific validate_bytes, but a
> validate_inplace. In my original email I did directly call it that, but i=
t
> took me a w/e to realize that validate_bytes is really just a special-cas=
e
> of validate_inplace when T =3D [u8], and so really we only need
> validate_inplace for every case where we do some in-place validation.

Ahh I see, then we don't need `validate_bytes`.

> And yes validate_inplace would be a very easy minimal escape hatch to jus=
t
> unbox the unvalidated data. But fundamentally we can't prevent that, all
> we can do is make sure that the validation code is concentrated in very
> specific places reviewers can easily catch, and |_| true probably not
> being correct validation code is rather easy to spot.

I don't think that it necessarily has to be an escape hatch. I think I
can design an API where you can choose if it will be done in-place vs
copied, while still using the `Validate` trait.

> I do think we need inplace validation for the fairly common case where th=
e
> copy_from_user is split from the validation, e.g. when you copy a big
> chunk of memory which is composed itself of variable-length objects that
> reside within: You'd do one big copy_from_user and then a pile of inplace
> validations for each thing that's in there, maybe with the assistance of
> alice's Range module to make sure you don't split up the overall memory
> area badly into individual pieces.

Yes, will definitely add it.

---
Cheers,
Benno


