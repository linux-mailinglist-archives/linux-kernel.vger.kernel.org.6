Return-Path: <linux-kernel+bounces-539840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B58A4A99F
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 09:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBDA0175547
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Mar 2025 08:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567021CB332;
	Sat,  1 Mar 2025 08:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=pm.me header.i=@pm.me header.b="ChE7ejeC"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C168179A7
	for <linux-kernel@vger.kernel.org>; Sat,  1 Mar 2025 08:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740816416; cv=none; b=BdDYXxWdMq/+sErde0mzv2khA49WcCJEupX5YdNpsyKZ+ixMh7ach4ONkEY/M98eWkd3rvtMdZ+/2rNJ/EFffKr0dC8e6Cka1bwWzrnpxffFwMo2bq+uWLZmpzzQI2tzgpHK8kdIvHJW5RjHJS32SzzNMXY4pEwdaMV4kJM9FqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740816416; c=relaxed/simple;
	bh=3r254mxjuKQj84109sWWnrjAD/M8nC9Nz12m4EeuFIc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4Vf2VvZDUUVMWK7pJ6QJnu51awIQnxnjqiaVgOP3RioUGBQ5XEMzTze8XYKslqkDbIwb1jfQk7feaMYtZhB08zfSRQyXrhdomUaHWcBN1Y0L3f0Ix0etuOq9Ts6tRyvefOmEz74ojUmgUD4+oXBqUcCylz2cColkFY9vBT8Xxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=ChE7ejeC; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1740816412; x=1741075612;
	bh=wiklNvGzAIUWW4/D8G5yXVuV0ECy8wK/4hpkmA5YanY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=ChE7ejeCDP+32OOMQb7Gl2vXE2fo4leTzv50M5BuGpI0xKsP+O+I4zaH+cbau0/hy
	 gu+bLY7ZXmzVFSJr9OTNdMxMe4mmp+om7HJbxkzlNiN3ZQdt0jERSEJF3IpYa3Qm/d
	 XQ+qRk4Pi1cBiwoNgKGfZ08/Han7z51zklgXlJAgZsRxOCV158i7R5IRQEQf+LH95D
	 hnPKo8Jf8OPiBn+F3gfVUrwmpQ8NJvbfoVzm7SmdVoR6SVfMwfBVLFCBi600nVwgLy
	 +xwXKqAc8E+Ii5T4wASXlSfevOZobvhOJGZtmc7vQXkph3sSf1Jk5t4/9sgFvJ8JPy
	 JGZ98dvDP8rYw==
Date: Sat, 01 Mar 2025 08:06:49 +0000
To: =?utf-8?Q?Beno=C3=AEt_du_Garreau?= <benoit@dugarreau.fr>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: =?utf-8?Q?Beno=C3=AEt_du_Garreau?= <bdgdlm@outlook.com>, Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] rust: adding UniqueRefCounted and UniqueRef types
Message-ID: <Z8LAFz_Q07qhio-O@laptop>
In-Reply-To: <20250228234148.7270-1-benoit@dugarreau.fr>
References: <20250228234148.7270-1-benoit@dugarreau.fr>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 5078987e009625416c9502e4650362f3511c930c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 250301 0041, Beno=C3=AEt du Garreau wrote:
> From: Beno=C3=AEt du Garreau <bdgdlm@outlook.com>
>=20
> It would be great for this trait to only have a `is_unique` method, and t=
hat functions here
> do the actual work. It would make it easier to implement and would avoid =
duplicating this
> work.
Hi,

I see where you are coming from, but there are good reasons for it to be li=
ke this.

mq::Request (for which this work was initially done) has the surprising pro=
perty,
that it is possible to create a reference to it 'out of band'
(i.e. without deriving it from an existing one) through mq::TagSet::tag_to_=
rq().

As this means try_shared_to_unique() to an UniqueRef can race
with tag_to_rq(), a non-standard reference counting scheme needs to be used
which can distinguish between 'a single ARef exists' and 'an UniqueRef exis=
ts',
and requires the is_unique() check and the necessary modification of the
reference count in try_shared_to_unique() have to be done
in one combined atomic operation.

Of course the whole thing could be refactored that both ways work, this one
and one like you suggest with just a to_unique(). I will think about it
for a bit, but I'm not sure it is worth the effort.

What probably makes sense is to at least have a default implementation
for unique_to_shared() which just does a
ARef::from_raw(UniqueRef::into_raw()) leaving only try_shared_to_unique()
as mandatory to implemented.

Thoughts?
> Maybe this could even be a new method on `AlwaysRefCounted`?
>
I didn't do that intentionally, because I think for many AlwaysRefCounted
implementors it would be a pain, as they simply use some get() and put()
methods to inc/dec the refcount which are provided by the C API,
while the actual refcount stays hidden from them.
>=20
> I think you meant "no other refcount" or "only references borrowed from t=
his".
>
Yes, you are right. Thanks. I will fix that.
>=20
> `UniqueRef` is essentially a `Box`, so it should have the same `Send`/`Sy=
nc` implementations. Here
> I don't see how sending a `UniqueRef<T>` is sharing a `&T`.
>=20
> Same here: you can only get a `&T` from a `UniqueRef<T>`, definitely not =
clone it.
>
I just copy/pasted that from ARef. You might be right, I have to think abou=
t that when
my minds is less foggy than right now :)
> > +
> > +
> > +impl<T: UniqueRefCounted> From<&T> for UniqueRef<T> {
> > +    /// Converts the [`UniqueRef`] into an [`ARef`]
> > +    /// by calling [`UniqueRefCounted::unique_to_shared`] on it.
> > +    fn from(b: &T) -> Self {
> > +        b.inc_ref();
> > +        // SAFETY: We just incremented the refcount above.
> > +        unsafe { Self::from_raw(NonNull::from(b)) }
> > +    }
> > +}
>=20
> This is wrong: the reference borrows from a refcount (as per `AlwaysRefCo=
unted`), and this
> method increments it once more. It cannot be unique when the function ret=
urns.
> Actually the only way such conversion could be written is by cloning `T`,=
 which is probably
> not what we want.
>=20
Good catch. That was also an relict of copy-paste which I missed. The metho=
d should
just be deleted. I will do that.

Best,

Oliver


