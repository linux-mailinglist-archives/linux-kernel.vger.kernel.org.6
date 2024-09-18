Return-Path: <linux-kernel+bounces-332947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CA997C13C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 23:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912B91C20D64
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 21:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5781CB300;
	Wed, 18 Sep 2024 21:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="OBSX8VPy"
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9700A1C57AA;
	Wed, 18 Sep 2024 21:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726693800; cv=none; b=fANZiyWcMot/Ig4dHp+Bgp5RUze/nd606pmrm8TeNiI3mL89+YmdLccBgIEkOGsp9Cw3gvXtRUJn26eBsOxjb5zVdHhXDw1gkykiERsSD1BjZMksCvJG1VHPE2RbP7HjT+iawjwwGbUmLCTJHAViOC0C7SqB0A8tvCxhEs6zOPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726693800; c=relaxed/simple;
	bh=JlWnVRVnYhEjEr1/Q3v36vCLOAAbDFwTxUzDCXv5+2M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZxlzXr+7dpzwXl0apSkWhKXVPgfok1ka7fvD4cDKuNlDeDWHRGe48d2mMXIhZtfJHpBLlNP/gFxDS6mJurqgTtcwQCdQfKWMTY8lN5krjE/N09pzkM0ANTNtlcCU0lv7Gg5YePGROSf7VwYI/tXp8MIdCD6gNtRIv308DcW5Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=OBSX8VPy; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1726693789; x=1726952989;
	bh=/u8PBwGXBscULsjZ8iKPqoof2eVxe32nkxnp/WD9Nlw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=OBSX8VPyQq5HkL6mRO+OFoIFvlRRrpZyy/4cGZEk9R03oqDXE5f+Nnry09RZjfMCc
	 S9vR/EU+1vCt5sCnK2vHNjx3gwlOjOctJhGVDA3AFjjB+aaV2U6RKY5axbYUf4zISR
	 XdcfUixeOAEZbZFhSnOu7rK9pBmJDKghFTujDt24DAJy+00siwD0cGUxFoT9hAikCg
	 wt7TOKJnRlsoTr8DTq4qTJjavhm1bL14e4HNX5MvpJrRHgUrHLIs5KYvtBI/NuYw3p
	 kYtV79zRT9TjWnm9wV1GYVJQ5oAUJPya4VkaB+3aztirvbmrcUq6Uo1n5AiEG9QcKp
	 ksKff4Ns/R+xw==
Date: Wed, 18 Sep 2024 21:09:44 +0000
To: Gary Guo <gary@garyguo.net>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/14] rust: sync: add `Arc::clone_from_raw`
Message-ID: <db9d0400-dd63-4e8c-9879-7452ff322673@proton.me>
In-Reply-To: <20240918211211.73b1324e.gary@garyguo.net>
References: <20240917222739.1298275-1-a.hindborg@kernel.org> <20240917222739.1298275-5-a.hindborg@kernel.org> <43b9bc9b-f64c-4421-8cf2-795f1f0ec94a@proton.me> <20240918211211.73b1324e.gary@garyguo.net>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: f8b5e1671cc4b65bc92d926083071ecacf6923c0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 18.09.24 22:12, Gary Guo wrote:
> On Wed, 18 Sep 2024 18:19:20 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>=20
>> On 18.09.24 00:27, Andreas Hindborg wrote:
>>> Add a method to clone an arc from a pointer to the data managed by the
>>> `Arc`.
>>>
>>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>>> ---
>>>  rust/kernel/sync/arc.rs | 20 ++++++++++++++++++++
>>>  1 file changed, 20 insertions(+)
>>>
>>> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
>>> index a57ea3e2b44c..2c95712d12a2 100644
>>> --- a/rust/kernel/sync/arc.rs
>>> +++ b/rust/kernel/sync/arc.rs
>>> @@ -282,6 +282,26 @@ pub unsafe fn from_raw(ptr: *const T) -> Self {
>>>          unsafe { Self::from_inner(ptr) }
>>>      }
>>>
>>> +    /// Clones an [`Arc`] instance from a pointer to the contained dat=
a.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// `ptr` must point to an allocation that is contained within a l=
ive [`Arc<T>`].
>>> +    pub unsafe fn clone_from_raw(ptr: *const T) -> Self {
>>> +        // SAFETY: The caller promises that this pointer points to dat=
a
>>> +        // contained in an `Arc` that is still valid.
>>> +        let inner =3D unsafe { ArcInner::container_of(ptr).as_ref() };
>>> +
>>> +        // INVARIANT: C `refcount_inc` saturates the refcount, so it c=
annot
>>> +        // overflow to zero. SAFETY: By the function safety requiremen=
t, there
>>> +        // is necessarily a reference to the object, so it is safe to =
increment
>>> +        // the refcount.
>>> +        unsafe { bindings::refcount_inc(inner.refcount.get()) };
>>> +
>>> +        // SAFETY: We just incremented the refcount. This increment is=
 now owned by the new `Arc`.
>>> +        unsafe { Self::from_inner(inner.into()) }
>>
>> The implementation of this function looks a bit strange to me, how about
>> this?:
>>
>>     // SAFETY: this function has the same safety requirements as `from_r=
aw`.
>>     let arc =3D unsafe { Self::from_raw(ptr) };
>>     let clone =3D arc.clone();
>>     // Prevent decrementing the refcount.
>>     mem::forget(arc);
>>     clone
>>
>> (of course you would need to change the safety requirements of
>> `clone_from_raw` to point to `from_raw`)
>=20
> Wouldn't this function simply be
>=20
> =09// SAFETY: ...
> =09let borrow =3D unsafe { ArcBorrow::from_raw(ptr) }
>   =09borrow.into()
>=20
> ?

Oh yeah we do have ArcBorrow...

> Maybe this function doesn't even need to exist...

Depends on how often the above has to be written, but I think yeah, it
might not be necessary.

---
Cheers,
Benno


