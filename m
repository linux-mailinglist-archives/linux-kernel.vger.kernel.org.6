Return-Path: <linux-kernel+bounces-333567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A3297CAD2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 16:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251501C2297F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 14:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743D81A0704;
	Thu, 19 Sep 2024 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="hM1CCv04"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436DB19F475;
	Thu, 19 Sep 2024 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726755311; cv=none; b=vChx43avfsGRevqYEQBEyMLwNuB827IhYq9stl0Vz1yZw24hn59iWnJsnr2XvOfytWWaPo+/6XYmfry8UaYQCX+tpoutZPq4h+oZr7YfdKmBRJFIktVeTyFMbIu/46jwT1zaj+lwoEEdq8ggqoePnOsl+3/O+YIltgBI2H1VWz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726755311; c=relaxed/simple;
	bh=KOga4SC1i23o//+1L9L8R3rgFxzKEjiozXYwhCJtYqM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SUSzzcQ8ywdE8L5cl9bK43EGzb3s96MH/KxSi/TYwC90mw99nFhJrwFFoG5Rn5U6vpvcY2DkiRuHNEfTVMxOu3hM8aiSPSyvxWZltA4ED9p+ENp3qHXjACmNDy475CdFO3S6NaiDVZ7NMUMGJ7dfGpokGUGajdIOL03FlafdHQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=hM1CCv04; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1726755307; x=1727014507;
	bh=8N+kn0X34iYoaUsWVNZUgCP4SUSsHwlQ0rPgNJGb1U8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hM1CCv04YiSFu3AOp8LkaJ02KEZxUxxb+8airbLE6//wjnSqMfkN7le4CvL5BD/8l
	 H7FEezl6Gz6Zmy+toreMu9jXYmpKkmPXRUiQsRK3bFrFQfQZlOUAxLv3/U8+7BWkJp
	 +L5M/8U+NjnKEe07t6EH4uzs3rXQN07/6swwoeTiZDuqK8MUE9vy47XbeyGsCw9NC/
	 jP/7Hh+ofYk9Bghxv8CR5rvxlupyhpigK4jSuTOkXBYlxDZdl9JgdHDcldC8aBMUvk
	 dwuRdb3EQVzuT96ESSeQxfucveUCr2wAmFIqyGuNZTSWnyVDSD9OggcjeqStmZXvZF
	 LXUf7UQLx8PHw==
Date: Thu, 19 Sep 2024 14:15:02 +0000
To: Andreas Hindborg <a.hindborg@kernel.org>, Gary Guo <gary@garyguo.net>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 04/14] rust: sync: add `Arc::clone_from_raw`
Message-ID: <19760254-bc0b-49e2-88a0-7088ab55d9b1@proton.me>
In-Reply-To: <87zfo4i3nc.fsf@kernel.org>
References: <20240917222739.1298275-1-a.hindborg@kernel.org> <20240917222739.1298275-5-a.hindborg@kernel.org> <43b9bc9b-f64c-4421-8cf2-795f1f0ec94a@proton.me> <6J_M8_wAnE5epFRUo8RBkYFL5p36woueX8MHQleKVFw_WOitLFZNQ6808RjS7RmizhQ07qDQpze2G3UDLZgHDA==@protonmail.internalid> <20240918211211.73b1324e.gary@garyguo.net> <87zfo4i3nc.fsf@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: a4840b0f3aaae0674dba73bc5a819c869b64e028
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.09.24 08:00, Andreas Hindborg wrote:
> "Gary Guo" <gary@garyguo.net> writes:
>=20
>> On Wed, 18 Sep 2024 18:19:20 +0000
>> Benno Lossin <benno.lossin@proton.me> wrote:
>>
>>> On 18.09.24 00:27, Andreas Hindborg wrote:
> [...]
>>>> +    pub unsafe fn clone_from_raw(ptr: *const T) -> Self {
>>>> +        // SAFETY: The caller promises that this pointer points to da=
ta
>>>> +        // contained in an `Arc` that is still valid.
>>>> +        let inner =3D unsafe { ArcInner::container_of(ptr).as_ref() }=
;
>>>> +
>>>> +        // INVARIANT: C `refcount_inc` saturates the refcount, so it =
cannot
>>>> +        // overflow to zero. SAFETY: By the function safety requireme=
nt, there
>>>> +        // is necessarily a reference to the object, so it is safe to=
 increment
>>>> +        // the refcount.
>>>> +        unsafe { bindings::refcount_inc(inner.refcount.get()) };
>>>> +
>>>> +        // SAFETY: We just incremented the refcount. This increment i=
s now owned by the new `Arc`.
>>>> +        unsafe { Self::from_inner(inner.into()) }
>>>
>>> The implementation of this function looks a bit strange to me, how abou=
t
>>> this?:
>>>
>>>     // SAFETY: this function has the same safety requirements as `from_=
raw`.
>>>     let arc =3D unsafe { Self::from_raw(ptr) };
>>>     let clone =3D arc.clone();
>>>     // Prevent decrementing the refcount.
>>>     mem::forget(arc);
>>>     clone
>>>
>>> (of course you would need to change the safety requirements of
>>> `clone_from_raw` to point to `from_raw`)
>>
>> Wouldn't this function simply be
>>
>> =09// SAFETY: ...
>> =09let borrow =3D unsafe { ArcBorrow::from_raw(ptr) }
>>   =09borrow.into()
>>
>> ?
>>
>> Maybe this function doesn't even need to exist...
>=20
> Maybe that could work. But my use case does not satisfy the safety
> requirements on `ArcBorrow::from_raw`. The`Arc::into_raw` was not
> called. Perhaps we can update the requirements for that function?

If I understood the code correctly, you are essentially doing this:

    let arc =3D Arc::<T>::new(..);
    let ptr =3D Arc::as_ptr(&arc);
    let ptr =3D T::raw_get_timer(ptr);
    let ptr =3D Timer::raw_get(ptr);

    // ptr is now used by the timer subsystem to fire the timer

    let ptr =3D ptr.cast::<Timer>();
    let ptr =3D T::timer_container_of(ptr);
    let borrow =3D ArcBorrow::from_raw(ptr);
    let arc =3D borrow.into();

The only thing that we would have to change would be adding
`Arc::as_ptr` as a source in the `ArcBorrow::from_raw` safety
requirements.

---
Cheers,
Benno


