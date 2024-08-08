Return-Path: <linux-kernel+bounces-280080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3967994C56C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 21:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B1951C21F0B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 19:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106BD15665D;
	Thu,  8 Aug 2024 19:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Rx1gMVYp"
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609D384A2F;
	Thu,  8 Aug 2024 19:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723146264; cv=none; b=SziZ7tFx0ScUBXBCxc1f9Kbd30KvA9NpOY1XNW9iex5FXhH22iYfF5UW9N4VRPmSA0y6BwnBNaUHHbGsIWqBM9UYypuFJNyBSKZ8mNkeOZTWVZd2b6qTbYcUgyDuWbwcVKQ3O4X1Vs4fGmehxa8DXWjCYfzGS46HobxyZlg3vKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723146264; c=relaxed/simple;
	bh=teaW2G1YGha8rVB9C/v3HcRwfsyObZF1CeXtVkwhcuI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/rM148h+7iWUjJir+9bBg4hBOnQrnGpYXDp2tjXShigb0FdGBSMYehqvlrqgfSGyuB+YAQIrLkPSm2xDcTr63y3iqrDNa4ylaXItzjhK7XZZcLXgJd2Zybo+ze6LvaQ0ql3ZHeqB3N/IDKmCGJPlnI0cHEYZd9DpFHpQynbnSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Rx1gMVYp; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1723146259; x=1723405459;
	bh=lAr0Z9Q64iaHBte2FBu5E58VU9jdd81HnbL+G/DFjqg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Rx1gMVYpTi3jPobET6jCnd0OY9sTVE+7He2/PWK2L64dBqzDsxBLJsHhi3Lv06UEQ
	 eBn7VpVidhNljGS8N0tX6hma5b++7+l3z37oOIWJ1O1wyNoi5RWYpytGA889pjZier
	 ffV6FShQQjhMB6aZMoOP3BeYApKsUBicuMMC6iy3YjrZPe4qUT2bVgkVInob8jbPrQ
	 fR4tmHWy9UVB/pntgWJWMiZNzDGUfX2LudW0DrtTBJSZnVjvKa6Bi63hnZneebFM4G
	 RU6MmG6xhqmTB2xCroYL13EwxS4bWfv3hZDH48+rVUHjILDYE9s3OxbB9kK1ubjIyT
	 ewMWw4Qa7DUOQ==
Date: Thu, 08 Aug 2024 19:44:12 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@samsung.com, aliceryhl@google.com, akpm@linux-foundation.org, daniel.almeida@collabora.com, faith.ekstrand@collabora.com, boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 09/28] rust: alloc: implement kernel `Box`
Message-ID: <42e37b4d-000d-4077-ad28-bc8660890b72@proton.me>
In-Reply-To: <ZrUD6ZyfK9Kg1mrn@pollux>
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-10-dakr@kernel.org> <a1c1e273-2d40-4114-b3b9-f27c73e3d122@proton.me> <ZrKrMrg5E85y7jkj@pollux> <012f5a12-2408-4658-8318-55fa8d4285e1@proton.me> <ZrUD6ZyfK9Kg1mrn@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: fc2754af04323626804628546a03721ca89db691
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.08.24 19:44, Danilo Krummrich wrote:
> On Wed, Aug 07, 2024 at 07:49:31AM +0000, Benno Lossin wrote:
>>>>> +impl<T, A> Drop for Box<T, A>
>>>>> +where
>>>>> +    T: ?Sized,
>>>>> +    A: Allocator,
>>>>> +{
>>>>> +    fn drop(&mut self) {
>>>>> +        let ptr =3D self.0.as_ptr();
>>>>> +
>>>>> +        // SAFETY: `ptr` is always properly aligned, dereferenceable=
 and points to an initialized
>>>>> +        // instance of `T`.
>>>>> +        let size =3D unsafe { core::mem::size_of_val(&*ptr) };
>>>>
>>>> 1. `size_of_val` is not `unsafe`.
>>>
>>> Right, but dereferencing the `ptr` is unsafe.
>>>
>>>> 2. why not use `&*self` instead of using the raw pointer? (then move t=
he
>>>>    let binding below this line)
>>>
>>> If we ever support non-ZST `Allocator`s using `self` would not always e=
valuate
>>> to the correct size. I think evaluating the size of `T` rather than `Bo=
x<T>` is
>>> the correct thing to do.
>>
>> I mean use `Box::deref` (that's what `&*self` should do), you don't need
>=20
> Actually, this must either be `size_of_val(&**self)` or `size_of_val::<T>=
(self).
>=20
> `size_of_val(&*self)` should indeed resolve to `&Box<T, A>`, right?

Oh yeah that is true, good catch! Here is a playground example [1].

[1]: https://play.rust-lang.org/?version=3Dstable&mode=3Ddebug&edition=3D20=
21&gist=3Dc439494a0582bb287232c7a05e21bd23

---
Cheers,
Benno

>=20
>> to repeat the same SAFETY comment when it already is wrapped by a safe
>> function.
>>
>> ---
>> Cheers,
>> Benno
>>


