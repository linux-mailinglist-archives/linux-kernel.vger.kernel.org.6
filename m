Return-Path: <linux-kernel+bounces-261879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A2193BD4E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 09:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94307283B5A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 07:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0363F16FF4B;
	Thu, 25 Jul 2024 07:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="dGSchshJ"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276F93224
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 07:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721893648; cv=none; b=K418ZrEeLrVnNEV49tfc3bl1YIVaHQdC0kBdCdkeGhUDzUUXw2DonjHGoFU5/vGCtRLqnaWIZOr13GXzbdHRHBHQUCQXtqzg2EfNjWanurVfoLzCDXna92Of4b2ygiqvAahTGsVWtdr+vdO+yZ+sWywnomFsnYYmCXhuG2CC2lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721893648; c=relaxed/simple;
	bh=90friIihxzKBTsqDhvI/fTTRt+OmJpdawPIgELGbaME=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G+5ox1/c7N3rM0rP+iD4GpKzH0DQ7bJ1OMFUbAgAdJriioPAIPNbUq+Cd/MDsRxFJ1xNG1Zd0R4VduAHThJ5a1r4mzhevb0Pu/mr85BOXeAPZucAf6s6m+MkKqOPE7lbgluQfmuSXlsEFJPqcimlK79YdgahdaubCNNp2WRsFJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=dGSchshJ; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1721893643; x=1722152843;
	bh=miXt3IUXrmvbifOm8Nduijv7QdZ3CVgFQEo0EfymG6k=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dGSchshJcFstBX2rDHy97as7r5bAMsyTwON7GxqFLBC9StlIWCYx5pn0B4enu40mb
	 mKrb8tA/kuyS42vZjJvjMkUIMR4Cc3eTvpOmdJEer45Sx02wV9MefzXUZNmROwGB7U
	 OnE/lo8xuLpoXt6Z4Q1ZLqa9ja84NJvIW+CpMPFS9TDDeE3SmReVqugIf8NQxW6yHp
	 XSFd4xYOHlZcnWBaQ2+TitySvvMgFBQCahtTEwZk5XfQ74GF4tgIURrW4rqwyCStV6
	 femjnLIOmnRFNUMeSZIepysP4dKJaqIJsBsiKFM1/8JD83ht+UpoZw/29Sk0mIh8iK
	 NirgaJ3W9/A/g==
Date: Thu, 25 Jul 2024 07:47:17 +0000
To: Daniel Almeida <daniel.almeida@collabora.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Jonathan Corbet <corbet@lwn.net>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [RFC PATCH 2/5] doc: rust: safety standard: add examples
Message-ID: <37d7b08d-f37a-45ff-9993-08fa7ed87443@proton.me>
In-Reply-To: <B0E3D539-2D29-4BB4-9CB7-98672F590A57@collabora.com>
References: <20240717221133.459589-1-benno.lossin@proton.me> <20240717221133.459589-3-benno.lossin@proton.me> <B0E3D539-2D29-4BB4-9CB7-98672F590A57@collabora.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 3da799b47d578a798619681f8a39d94fbb8240bb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.07.24 18:36, Daniel Almeida wrote:
>> On 17 Jul 2024, at 19:12, Benno Lossin <benno.lossin@proton.me> wrote:
>> +Sound ``unsafe`` Code
>> +---------------------
>> +
>> +The Importance of the API Boundary
>> +**********************************
>> +
>> +Is the following API sound?::
>> +
>> +    fn foo(r: &mut u32) {
>> +        let ptr: *mut u32 =3D r;
>> +        let val;
>> +        unsafe {
>> +            val =3D *ptr;
>> +            *ptr =3D 0;
>> +        }
>> +    }
>> +
>> +It better be sound, but one could argue that it is unsound, since one c=
ould replace the ptr
>> +initialization by ``ptr =3D core::ptr::null_mut()``::
>> +
>> +    fn foo(r: &mut u32) {
>> +        let ptr: *mut u32 =3D core::ptr::null_mut();
>> +        let val;
>> +        unsafe {
>> +            val =3D *ptr;
>> +            *ptr =3D 0;
>> +        }
>> +    }
>> +
>> +But this modification is not allowed, since it goes beyond the API boun=
dary of ``foo``. This way
>> +any ``unsafe`` code that relies on surrounding safe code could be shown=
 to be unsound. Instead one
>> +should only consider safe code using the API, in this case, there is no=
 way to make the code
>> +incorrect, since a reference is always valid to dereference during its =
lifetime.
>=20
> I find this paragraph a bit confusing. Maybe this can be clarified a bit =
further?

I will try to rephrase this, tell me if it helps. When checking if an
API is sound, you are not allowed to change the code behind the API.
That is because `unsafe` code often relies on the surrounding safe code
to work properly. In the example above, safe code ensures that the raw
pointer `ptr` is valid. This is OK (and also very necessary), since we
expect people to be *aware* of the `unsafe` block and thus more
carefully review the changes in surrounding safe code. If you have safe
code that only interfaces with other safe code you don't need to be this
careful.

Note that this heavily depends on where you put the API boundary. In our
case, we generally have this boundary: driver code <-> `kernel` crate.
But if your driver requires very specific helper code that does not fit
into the `kernel` crate, then you might also have an API boundary there.

If it doesn't help, then it would great to get some more detailed
questions which part(s) you need help with.

---
Cheers,
Benno


